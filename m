Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BFA6610F6C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Oct 2022 13:11:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbiJ1LLf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Oct 2022 07:11:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiJ1LLe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Oct 2022 07:11:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EC851CA591
        for <linux-fsdevel@vger.kernel.org>; Fri, 28 Oct 2022 04:11:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A9A4BB82971
        for <linux-fsdevel@vger.kernel.org>; Fri, 28 Oct 2022 11:11:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 111F9C433D6;
        Fri, 28 Oct 2022 11:11:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666955490;
        bh=58LA8gRBnjFJXpLxXUiBrsiWtkueW5y9c3u5Ifpf2Xg=;
        h=From:To:Cc:Subject:Date:From;
        b=BDhq1I8Iczgzl5sbEHx5cGcMr4iiKYphVQacFPvRmzPw646f3f7fq5Zf4Gds+q3VY
         Ij62MjyZatHhkSNnqsCWk0u/MSLmZcWuFaCgs01UntCZV/3VBGKdUNadi+18G6TTc6
         d9rsqQ24iVljroTMhYaLcBz5f2mPJeeAPA/otdSlEo8uEOILz36MDiAOm61ro1xv0m
         pe0gVnkNSdJtrh4edANX7Hp6gBylVn+Zn7vYGMj40V+wiekwI6Ds5lfER6VOttzi4w
         3j0zCyLZ3WAcFO2briblE2PKWmbqmIraM3SoyHByncR6JP4YULqKrA9GL2e2MSPlnm
         rGYHY2CDw9qkQ==
From:   Christian Brauner <brauner@kernel.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     Christian Brauner <brauner@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>,
        Seth Forshee <sforshee@kernel.org>
Subject: [PATCH 1/2] fs: introduce dedicated idmap type for mounts
Date:   Fri, 28 Oct 2022 13:10:41 +0200
Message-Id: <20221028111041.448001-1-brauner@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=13467; i=brauner@kernel.org; h=from:subject; bh=58LA8gRBnjFJXpLxXUiBrsiWtkueW5y9c3u5Ifpf2Xg=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSRH71gygbst2EAuPqjy59bLXrbCt9LnCc8SqepXXyfCMbdt /5+qjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgImYPWH477GO99fnPw2ylxxPn2e6WL l37ZT1P2P0TR4t8ZXuuGrwKprhr+CcO+uT0qOKtTIX+jxVWb1ZrtZsTZsVk9Eh9/WB2uyzWQE=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Last cycle we've already made the interaction with idmapped mounts more
robust and type safe by introducing the vfs{g,u}id_t type. This cycle we
concluded the conversion and removed the legacy helpers.

Currently we still pass around the plain namespace that was attached to
a mount. This is in general pretty convenient but it makes it easy to
conflate filesystem and mount namespaces and what different roles they
have to play. Especially for filesystem developers without much
experience in this area this is an easy source for bugs.

Instead of passing the plain namespace we introduce a dedicated type
struct mnt_idmap and replace the pointer with a pointer to a struct
mnt_idmap. There are no semantic or size changes for the mount struct
caused by this.

We then start converting all places aware of idmapped mounts to rely on
struct mnt_idmap. Once the conversion is done all helpers down to the
really low-level make_vfs{g,u}id() and from_vfs{g,u}id() will take a
struct mnt_idmap argument instead of two namespace arguments. This way
it becomes impossible to conflate the two removing and thus eliminating
the possibility of any bugs. Fwiw, I fixed some issues in that area a
while ago in ntfs3 and ksmbd in the past. Afterwards only low-level code
can ultimately use the associated namespace for any permission checks.
Even most of the vfs can be completely obivious about this ultimately
and filesystems will never interact with it in any form in the future.

A struct mnt_idmap currently encompasses a simple refcount a pointer to
the relevant namespace the mount is idmapped to. If a mount isn't
idmapped then it will point to a static nop_mnt_idmap and if it doesn't
that it is idmapped. As usual there are no allocations or anything
happening for non-idmapped mounts. Everthing is carefully written to be
a nop for non-idmapped mounts as has always been the case.

If an idmapped mount is created a struct mnt_idmap is allocated and a
reference taken on the relevant namespace. Each mount that gets idmapped
or inherits the idmap simply bumps the reference count on struct
mnt_idmap. Just a reminder that we only allow a mount to change it's
idmapping a single time and only if it hasn't already been attached to
the filesystems and has no active writers.

The actual changes are fairly straightforward but this will have huge
benefits for maintenance and security in the long run even if it causes
some churn. I'm aware that there's some cost for all of you. And I'll
commit to doing this work and make this as painless as I can.

Note that this also makes it possible to extend struct mount_idmap in
the future. For example, it would be possible to place the namespace
pointer in an anonymous union together with an idmapping struct. This
would allow us to expose an api to userspace that would let it specify
idmappings directly instead of having to go through the detour of
setting up namespaces at all.

This adds the infrastructure.

Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
---
 fs/namespace.c                | 136 ++++++++++++++++++++++++++--------
 include/linux/fs.h            |  10 ++-
 include/linux/mnt_idmapping.h |   7 ++
 include/linux/mount.h         |  10 ++-
 4 files changed, 127 insertions(+), 36 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index df137ba19d37..788479fc784b 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -75,6 +75,11 @@ static DECLARE_RWSEM(namespace_sem);
 static HLIST_HEAD(unmounted);	/* protected by namespace_sem */
 static LIST_HEAD(ex_mountpoints); /* protected by namespace_sem */
 
+struct mnt_idmap nop_mnt_idmap = {
+	.owner = &init_user_ns,
+	.count	 = REFCOUNT_INIT(1),
+};
+
 struct mount_kattr {
 	unsigned int attr_set;
 	unsigned int attr_clr;
@@ -82,6 +87,7 @@ struct mount_kattr {
 	unsigned int lookup_flags;
 	bool recurse;
 	struct user_namespace *mnt_userns;
+	struct mnt_idmap *mnt_idmap;
 };
 
 /* /sys/fs */
@@ -193,6 +199,83 @@ int mnt_get_count(struct mount *mnt)
 #endif
 }
 
+/**
+ * mnt_user_ns - retrieve owner of the mount's idmapping
+ * @mnt: the relevant vfsmount
+ *
+ * This helper will go away once the conversion to use struct mnt_idmap
+ * everywhere has finished at which point the helper will be unexported and
+ * move to fs/internal.h. Only code that needs to perform permission checks
+ * based on the owner of the idmapping will get access to it. All other code
+ * will solely rely on idmappings. This will get us type safety so it's
+ * impossible to conflate filesystems idmappings with mount idmappings.
+ *
+ * Return: The owner of the idmapping.
+ */
+struct user_namespace *mnt_user_ns(const struct vfsmount *mnt)
+{
+	struct mnt_idmap *idmap = mnt_idmapping(mnt);
+
+	/* Return the actual owner of the filesystem instead of the nop. */
+	if (idmap == &nop_mnt_idmap &&
+	    !initial_idmapping(mnt->mnt_sb->s_user_ns))
+		return mnt->mnt_sb->s_user_ns;
+	return mnt_idmapping(mnt)->owner;
+}
+EXPORT_SYMBOL_GPL(mnt_user_ns);
+
+/**
+ * alloc_mnt_idmap - allocate a new idmapping for the mount
+ * @mnt_userns: owning userns of the idmapping
+ *
+ * Allocate a new struct mnt_idmap which carries the idmapping of the mount.
+ *
+ * Return: On success a new idmap, on error an error pointer is returned.
+ */
+static struct mnt_idmap *alloc_mnt_idmap(struct user_namespace *mnt_userns)
+{
+	struct mnt_idmap *idmap;
+
+	idmap = kzalloc(sizeof(struct mnt_idmap), GFP_KERNEL_ACCOUNT);
+	if (!idmap)
+		return ERR_PTR(-ENOMEM);
+
+	idmap->owner = get_user_ns(mnt_userns);
+	refcount_set(&idmap->count, 1);
+	return idmap;
+}
+
+/**
+ * mnt_idmap_get - get a reference to an idmapping
+ * @idmap: the idmap to bump the reference on
+ *
+ * If @idmap is not the @nop_mnt_idmap bump the reference count.
+ *
+ * Return: @idmap with reference count bumped if @not_mnt_idmap isn't passed.
+ */
+static inline struct mnt_idmap *mnt_idmap_get(struct mnt_idmap *idmap)
+{
+	if (idmap != &nop_mnt_idmap)
+		refcount_inc(&idmap->count);
+
+	return idmap;
+}
+
+/**
+ * mnt_idmap_put - put a reference to an idmapping
+ * @idmap: the idmap to put the reference on
+ *
+ * If this is a non-initial idmapping, put the reference count when a mount is
+ * released and free it if we're the last user.
+ */
+static inline void mnt_idmap_put(struct mnt_idmap *idmap)
+{
+	if (idmap != &nop_mnt_idmap && refcount_dec_and_test(&idmap->count)) {
+		put_user_ns(idmap->owner);
+		kfree(idmap);
+	}
+}
+
 static struct mount *alloc_vfsmnt(const char *name)
 {
 	struct mount *mnt = kmem_cache_zalloc(mnt_cache, GFP_KERNEL);
@@ -232,7 +315,7 @@ static struct mount *alloc_vfsmnt(const char *name)
 		INIT_HLIST_NODE(&mnt->mnt_mp_list);
 		INIT_LIST_HEAD(&mnt->mnt_umounting);
 		INIT_HLIST_HEAD(&mnt->mnt_stuck_children);
-		mnt->mnt.mnt_userns = &init_user_ns;
+		mnt->mnt.mnt_idmap = &nop_mnt_idmap;
 	}
 	return mnt;
 
@@ -602,11 +685,10 @@ int sb_prepare_remount_readonly(struct super_block *sb)
 
 static void free_vfsmnt(struct mount *mnt)
 {
-	struct user_namespace *mnt_userns;
+	struct mnt_idmap *idmap;
 
-	mnt_userns = mnt_user_ns(&mnt->mnt);
-	if (!initial_idmapping(mnt_userns))
-		put_user_ns(mnt_userns);
+	idmap = mnt_idmapping(&mnt->mnt);
+	mnt_idmap_put(idmap);
 	kfree_const(mnt->mnt_devname);
 #ifdef CONFIG_SMP
 	free_percpu(mnt->mnt_pcp);
@@ -1009,7 +1091,6 @@ static struct mount *skip_mnt_tree(struct mount *p)
 struct vfsmount *vfs_create_mount(struct fs_context *fc)
 {
 	struct mount *mnt;
-	struct user_namespace *fs_userns;
 
 	if (!fc->root)
 		return ERR_PTR(-EINVAL);
@@ -1027,10 +1108,6 @@ struct vfsmount *vfs_create_mount(struct fs_context *fc)
 	mnt->mnt_mountpoint	= mnt->mnt.mnt_root;
 	mnt->mnt_parent		= mnt;
 
-	fs_userns = mnt->mnt.mnt_sb->s_user_ns;
-	if (!initial_idmapping(fs_userns))
-		mnt->mnt.mnt_userns = get_user_ns(fs_userns);
-
 	lock_mount_hash();
 	list_add_tail(&mnt->mnt_instance, &mnt->mnt.mnt_sb->s_mounts);
 	unlock_mount_hash();
@@ -1120,9 +1197,8 @@ static struct mount *clone_mnt(struct mount *old, struct dentry *root,
 	mnt->mnt.mnt_flags &= ~(MNT_WRITE_HOLD|MNT_MARKED|MNT_INTERNAL);
 
 	atomic_inc(&sb->s_active);
-	mnt->mnt.mnt_userns = mnt_user_ns(&old->mnt);
-	if (!initial_idmapping(mnt->mnt.mnt_userns))
-		mnt->mnt.mnt_userns = get_user_ns(mnt->mnt.mnt_userns);
+	mnt->mnt.mnt_idmap = mnt_idmap_get(mnt_idmapping(&old->mnt));
+
 	mnt->mnt.mnt_sb = sb;
 	mnt->mnt.mnt_root = dget(root);
 	mnt->mnt_mountpoint = mnt->mnt.mnt_root;
@@ -4082,27 +4158,18 @@ static int mount_setattr_prepare(struct mount_kattr *kattr, struct mount *mnt)
 
 static void do_idmap_mount(const struct mount_kattr *kattr, struct mount *mnt)
 {
-	struct user_namespace *mnt_userns, *old_mnt_userns;
-
 	if (!kattr->mnt_userns)
 		return;
 
 	/*
-	 * We're the only ones able to change the mount's idmapping. So
-	 * mnt->mnt.mnt_userns is stable and we can retrieve it directly.
-	 */
-	old_mnt_userns = mnt->mnt.mnt_userns;
-
-	mnt_userns = get_user_ns(kattr->mnt_userns);
-	/* Pairs with smp_load_acquire() in mnt_user_ns(). */
-	smp_store_release(&mnt->mnt.mnt_userns, mnt_userns);
-
-	/*
-	 * If this is an idmapped filesystem drop the reference we've taken
-	 * in vfs_create_mount() before.
+	 * Pairs with smp_load_acquire() in mnt_idmapping().
+	 *
+	 * Since we only allow a mount to change the idmapping once and
+	 * verified this in can_idmap_mount() we know that the mount has
+	 * @nop_mnt_idmap attached to it. So there's no need to drop any
+	 * references.
 	 */
-	if (!initial_idmapping(old_mnt_userns))
-		put_user_ns(old_mnt_userns);
+	smp_store_release(&mnt->mnt.mnt_idmap, mnt_idmap_get(kattr->mnt_idmap));
 }
 
 static void mount_setattr_commit(struct mount_kattr *kattr, struct mount *mnt)
@@ -4131,11 +4198,19 @@ static void mount_setattr_commit(struct mount_kattr *kattr, struct mount *mnt)
 static int do_mount_setattr(struct path *path, struct mount_kattr *kattr)
 {
 	struct mount *mnt = real_mount(path->mnt);
+	struct mnt_idmap *mnt_idmap;
 	int err = 0;
 
 	if (path->dentry != mnt->mnt.mnt_root)
 		return -EINVAL;
 
+	if (kattr->mnt_userns) {
+		mnt_idmap = alloc_mnt_idmap(kattr->mnt_userns);
+		if (IS_ERR(mnt_idmap))
+			return PTR_ERR(mnt_idmap);
+		kattr->mnt_idmap = mnt_idmap;
+	}
+
 	if (kattr->propagation) {
 		/*
 		 * Only take namespace_lock() if we're actually changing
@@ -4323,6 +4398,9 @@ static void finish_mount_kattr(struct mount_kattr *kattr)
 {
 	put_user_ns(kattr->mnt_userns);
 	kattr->mnt_userns = NULL;
+
+	if (kattr->mnt_idmap)
+		mnt_idmap_put(kattr->mnt_idmap);
 }
 
 SYSCALL_DEFINE5(mount_setattr, int, dfd, const char __user *, path,
diff --git a/include/linux/fs.h b/include/linux/fs.h
index cffc402c2451..fc03099bb895 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2700,18 +2700,22 @@ static inline struct user_namespace *file_mnt_user_ns(struct file *file)
 	return mnt_user_ns(file->f_path.mnt);
 }
 
+static inline struct mnt_idmap *file_mnt_idmap(struct file *file)
+{
+	return mnt_idmapping(file->f_path.mnt);
+}
+
 /**
  * is_idmapped_mnt - check whether a mount is mapped
  * @mnt: the mount to check
  *
- * If @mnt has an idmapping attached different from the
- * filesystem's idmapping then @mnt is mapped.
+ * If @mnt has an non @nop_mnt_idmap attached to it then @mnt is mapped.
  *
  * Return: true if mount is mapped, false if not.
  */
 static inline bool is_idmapped_mnt(const struct vfsmount *mnt)
 {
-	return mnt_user_ns(mnt) != mnt->mnt_sb->s_user_ns;
+	return mnt_idmapping(mnt) != &nop_mnt_idmap;
 }
 
 extern long vfs_truncate(const struct path *, loff_t);
diff --git a/include/linux/mnt_idmapping.h b/include/linux/mnt_idmapping.h
index c8002294a72d..a918facee0cf 100644
--- a/include/linux/mnt_idmapping.h
+++ b/include/linux/mnt_idmapping.h
@@ -13,6 +13,13 @@ struct user_namespace;
  */
 extern struct user_namespace init_user_ns;
 
+struct mnt_idmap {
+	struct user_namespace *owner;
+	refcount_t count;
+};
+
+extern struct mnt_idmap nop_mnt_idmap;
+
 typedef struct {
 	uid_t val;
 } vfsuid_t;
diff --git a/include/linux/mount.h b/include/linux/mount.h
index 55a4abaf6715..0df15a02d460 100644
--- a/include/linux/mount.h
+++ b/include/linux/mount.h
@@ -16,6 +16,7 @@
 struct super_block;
 struct dentry;
 struct user_namespace;
+struct mnt_idmap;
 struct file_system_type;
 struct fs_context;
 struct file;
@@ -70,13 +71,14 @@ struct vfsmount {
 	struct dentry *mnt_root;	/* root of the mounted tree */
 	struct super_block *mnt_sb;	/* pointer to superblock */
 	int mnt_flags;
-	struct user_namespace *mnt_userns;
+	struct mnt_idmap *mnt_idmap;
 } __randomize_layout;
 
-static inline struct user_namespace *mnt_user_ns(const struct vfsmount *mnt)
+struct user_namespace *mnt_user_ns(const struct vfsmount *mnt);
+static inline struct mnt_idmap *mnt_idmapping(const struct vfsmount *mnt)
 {
-	/* Pairs with smp_store_release() in do_idmap_mount(). */
-	return smp_load_acquire(&mnt->mnt_userns);
+	/* Pairs with smp_rmb() in do_idmap_mount(). */
+	return smp_load_acquire(&mnt->mnt_idmap);
 }
 
 extern int mnt_want_write(struct vfsmount *mnt);

base-commit: f7adeea9ebdbf73454f083c21de57579e982f2a1
-- 
2.34.1

