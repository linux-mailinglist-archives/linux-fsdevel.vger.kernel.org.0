Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EE79669634
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jan 2023 12:54:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241379AbjAMLyM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Jan 2023 06:54:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241227AbjAMLwa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Jan 2023 06:52:30 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 140EF3FA35
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Jan 2023 03:50:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9A189616D1
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Jan 2023 11:50:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1625C433F2;
        Fri, 13 Jan 2023 11:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673610622;
        bh=abQQW0UjswzHamSS0L0Ds+KwwF5XxmDCTOKydCohW4k=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=BXf3xo1pDzK9xh/b3kJjpzHvxP7XLAwx7xExZj0gck0S5WOUmwQFTtgSDchzPpAU/
         wqcaU+WUHQfD77/PWgIWnCeA7X9FhhX/bCkMPZVeEnGnf61IjLTiM+p3VnKlJvO1Zk
         yZ+juAnGq/W7uR74VMoeNCeqvLpIRqYJNa7Zgj8mElt+jgXgrwT3x/hwyKWZL4t03W
         Dd9Ldz1egFzkHOesldUt02bqi4s2HTgQeunbTPu9XfxMmYTvFuW2SILBBgvY7ensRa
         5ayxf8hshpYITmfHCwsZFE3PJEo0sRsng8k1XAsuWiRB1wxkqgpQNQROaRa/INXJ60
         N3YL6eUnZChfA==
From:   Christian Brauner <brauner@kernel.org>
Date:   Fri, 13 Jan 2023 12:49:33 +0100
Subject: [PATCH 25/25] fs: move mnt_idmap
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230113-fs-idmapped-mnt_idmap-conversion-v1-25-fc84fa7eba67@kernel.org>
References: <20230113-fs-idmapped-mnt_idmap-conversion-v1-0-fc84fa7eba67@kernel.org>
In-Reply-To: <20230113-fs-idmapped-mnt_idmap-conversion-v1-0-fc84fa7eba67@kernel.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     Christian Brauner <brauner@kernel.org>,
        "Seth Forshee (Digital Ocean)" <sforshee@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>
X-Mailer: b4 0.12-dev-5b205
X-Developer-Signature: v=1; a=openpgp-sha256; l=23393; i=brauner@kernel.org;
 h=from:subject:message-id; bh=abQQW0UjswzHamSS0L0Ds+KwwF5XxmDCTOKydCohW4k=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSQfdA3pyPwpPM/3waa3N94XyR2L8+LRUqyYoHq97OrmoFav
 ekv+jlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIkYOjP8DzvzWZeJq+9fhdn//hlyN/
 ZO0Ht9Mqfe95X3Is6sI+sO6zMyrPi9Zs07r59zNohydK+v+zD3VMsNofojf88pMiyfWb0wlxEA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Now that we converted everything to just rely on struct mnt_idmap move it all
into a separate file. This ensure that no code can poke around in struct
mnt_idmap without any dedicated helpers and makes it easier to extend it in the
future. Filesystems will now not be able to conflate mount and filesystem
idmappings as they are two distinct types and require distinct helpers that
cannot be used interchangeably. We are now also able to extend struct mnt_idmap
as we see fit.

Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
---
 MAINTAINERS                   |   2 +-
 fs/Makefile                   |   2 +-
 fs/internal.h                 |   5 +-
 fs/mnt_idmapping.c            | 273 ++++++++++++++++++++++++++++++++++++++++++
 fs/namespace.c                |  92 +-------------
 include/linux/mnt_idmapping.h | 196 ++----------------------------
 include/linux/mount.h         |   1 -
 7 files changed, 293 insertions(+), 278 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index f61eb221415b..8c8cb625ac7c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9989,7 +9989,7 @@ S:	Maintained
 T:	git://git.kernel.org/pub/scm/linux/kernel/git/vfs/idmapping.git
 F:	Documentation/filesystems/idmappings.rst
 F:	tools/testing/selftests/mount_setattr/
-F:	include/linux/mnt_idmapping.h
+F:	include/linux/mnt_idmapping.*
 
 IDT VersaClock 5 CLOCK DRIVER
 M:	Luca Ceresoli <luca@lucaceresoli.net>
diff --git a/fs/Makefile b/fs/Makefile
index 4dea17840761..76abc9e055bd 100644
--- a/fs/Makefile
+++ b/fs/Makefile
@@ -16,7 +16,7 @@ obj-y :=	open.o read_write.o file_table.o super.o \
 		pnode.o splice.o sync.o utimes.o d_path.o \
 		stack.o fs_struct.o statfs.o fs_pin.o nsfs.o \
 		fs_types.o fs_context.o fs_parser.o fsopen.o init.o \
-		kernel_read_file.o remap_range.o
+		kernel_read_file.o mnt_idmapping.o remap_range.o
 
 ifeq ($(CONFIG_BLOCK),y)
 obj-y +=	buffer.o direct-io.o mpage.o
diff --git a/fs/internal.h b/fs/internal.h
index 9ac38b411679..766e8a554b2c 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -14,9 +14,9 @@ struct path;
 struct mount;
 struct shrink_control;
 struct fs_context;
-struct user_namespace;
 struct pipe_inode_info;
 struct iov_iter;
+struct mnt_idmap;
 
 /*
  * block/bdev.c
@@ -263,3 +263,6 @@ ssize_t __kernel_write_iter(struct file *file, struct iov_iter *from, loff_t *po
  */
 int setattr_should_drop_sgid(struct mnt_idmap *idmap,
 			     const struct inode *inode);
+struct mnt_idmap *alloc_mnt_idmap(struct user_namespace *mnt_userns);
+struct mnt_idmap *mnt_idmap_get(struct mnt_idmap *idmap);
+void mnt_idmap_put(struct mnt_idmap *idmap);
diff --git a/fs/mnt_idmapping.c b/fs/mnt_idmapping.c
new file mode 100644
index 000000000000..060aaf3d3b35
--- /dev/null
+++ b/fs/mnt_idmapping.c
@@ -0,0 +1,273 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2022 Christian Brauner (Microsoft) <brauner@kernel.org> */
+
+#include <linux/cred.h>
+#include <linux/fs.h>
+#include <linux/mnt_idmapping.h>
+#include <linux/slab.h>
+#include <linux/user_namespace.h>
+
+#include "internal.h"
+
+struct mnt_idmap {
+	struct user_namespace *owner;
+	refcount_t count;
+};
+
+/*
+ * Carries the initial idmapping of 0:0:4294967295 which is an identity
+ * mapping. This means that {g,u}id 0 is mapped to {g,u}id 0, {g,u}id 1 is
+ * mapped to {g,u}id 1, [...], {g,u}id 1000 to {g,u}id 1000, [...].
+ */
+struct mnt_idmap nop_mnt_idmap = {
+	.owner	= &init_user_ns,
+	.count	= REFCOUNT_INIT(1),
+};
+EXPORT_SYMBOL_GPL(nop_mnt_idmap);
+
+/**
+ * check_fsmapping - check whether an mount idmapping is allowed
+ * @idmap: idmap of the relevent mount
+ * @sb:    super block of the filesystem
+ *
+ * Return: true if @idmap is allowed, false if not.
+ */
+bool check_fsmapping(const struct mnt_idmap *idmap,
+		     const struct super_block *sb)
+{
+	return idmap->owner != sb->s_user_ns;
+}
+
+/**
+ * initial_idmapping - check whether this is the initial mapping
+ * @ns: idmapping to check
+ *
+ * Check whether this is the initial mapping, mapping 0 to 0, 1 to 1,
+ * [...], 1000 to 1000 [...].
+ *
+ * Return: true if this is the initial mapping, false if not.
+ */
+static inline bool initial_idmapping(const struct user_namespace *ns)
+{
+	return ns == &init_user_ns;
+}
+
+/**
+ * no_idmapping - check whether we can skip remapping a kuid/gid
+ * @mnt_userns: the mount's idmapping
+ * @fs_userns: the filesystem's idmapping
+ *
+ * This function can be used to check whether a remapping between two
+ * idmappings is required.
+ * An idmapped mount is a mount that has an idmapping attached to it that
+ * is different from the filsystem's idmapping and the initial idmapping.
+ * If the initial mapping is used or the idmapping of the mount and the
+ * filesystem are identical no remapping is required.
+ *
+ * Return: true if remapping can be skipped, false if not.
+ */
+static inline bool no_idmapping(const struct user_namespace *mnt_userns,
+				const struct user_namespace *fs_userns)
+{
+	return initial_idmapping(mnt_userns) || mnt_userns == fs_userns;
+}
+
+/**
+ * make_vfsuid - map a filesystem kuid according to an idmapping
+ * @idmap: the mount's idmapping
+ * @fs_userns: the filesystem's idmapping
+ * @kuid : kuid to be mapped
+ *
+ * Take a @kuid and remap it from @fs_userns into @idmap. Use this
+ * function when preparing a @kuid to be reported to userspace.
+ *
+ * If no_idmapping() determines that this is not an idmapped mount we can
+ * simply return @kuid unchanged.
+ * If initial_idmapping() tells us that the filesystem is not mounted with an
+ * idmapping we know the value of @kuid won't change when calling
+ * from_kuid() so we can simply retrieve the value via __kuid_val()
+ * directly.
+ *
+ * Return: @kuid mapped according to @idmap.
+ * If @kuid has no mapping in either @idmap or @fs_userns INVALID_UID is
+ * returned.
+ */
+
+vfsuid_t make_vfsuid(struct mnt_idmap *idmap,
+				   struct user_namespace *fs_userns,
+				   kuid_t kuid)
+{
+	uid_t uid;
+	struct user_namespace *mnt_userns = idmap->owner;
+
+	if (no_idmapping(mnt_userns, fs_userns))
+		return VFSUIDT_INIT(kuid);
+	if (initial_idmapping(fs_userns))
+		uid = __kuid_val(kuid);
+	else
+		uid = from_kuid(fs_userns, kuid);
+	if (uid == (uid_t)-1)
+		return INVALID_VFSUID;
+	return VFSUIDT_INIT(make_kuid(mnt_userns, uid));
+}
+EXPORT_SYMBOL_GPL(make_vfsuid);
+
+/**
+ * make_vfsgid - map a filesystem kgid according to an idmapping
+ * @idmap: the mount's idmapping
+ * @fs_userns: the filesystem's idmapping
+ * @kgid : kgid to be mapped
+ *
+ * Take a @kgid and remap it from @fs_userns into @idmap. Use this
+ * function when preparing a @kgid to be reported to userspace.
+ *
+ * If no_idmapping() determines that this is not an idmapped mount we can
+ * simply return @kgid unchanged.
+ * If initial_idmapping() tells us that the filesystem is not mounted with an
+ * idmapping we know the value of @kgid won't change when calling
+ * from_kgid() so we can simply retrieve the value via __kgid_val()
+ * directly.
+ *
+ * Return: @kgid mapped according to @idmap.
+ * If @kgid has no mapping in either @idmap or @fs_userns INVALID_GID is
+ * returned.
+ */
+vfsgid_t make_vfsgid(struct mnt_idmap *idmap,
+		     struct user_namespace *fs_userns, kgid_t kgid)
+{
+	gid_t gid;
+	struct user_namespace *mnt_userns = idmap->owner;
+
+	if (no_idmapping(mnt_userns, fs_userns))
+		return VFSGIDT_INIT(kgid);
+	if (initial_idmapping(fs_userns))
+		gid = __kgid_val(kgid);
+	else
+		gid = from_kgid(fs_userns, kgid);
+	if (gid == (gid_t)-1)
+		return INVALID_VFSGID;
+	return VFSGIDT_INIT(make_kgid(mnt_userns, gid));
+}
+EXPORT_SYMBOL_GPL(make_vfsgid);
+
+/**
+ * from_vfsuid - map a vfsuid into the filesystem idmapping
+ * @idmap: the mount's idmapping
+ * @fs_userns: the filesystem's idmapping
+ * @vfsuid : vfsuid to be mapped
+ *
+ * Map @vfsuid into the filesystem idmapping. This function has to be used in
+ * order to e.g. write @vfsuid to inode->i_uid.
+ *
+ * Return: @vfsuid mapped into the filesystem idmapping
+ */
+kuid_t from_vfsuid(struct mnt_idmap *idmap,
+		   struct user_namespace *fs_userns, vfsuid_t vfsuid)
+{
+	uid_t uid;
+	struct user_namespace *mnt_userns = idmap->owner;
+
+	if (no_idmapping(mnt_userns, fs_userns))
+		return AS_KUIDT(vfsuid);
+	uid = from_kuid(mnt_userns, AS_KUIDT(vfsuid));
+	if (uid == (uid_t)-1)
+		return INVALID_UID;
+	if (initial_idmapping(fs_userns))
+		return KUIDT_INIT(uid);
+	return make_kuid(fs_userns, uid);
+}
+EXPORT_SYMBOL_GPL(from_vfsuid);
+
+/**
+ * from_vfsgid - map a vfsgid into the filesystem idmapping
+ * @idmap: the mount's idmapping
+ * @fs_userns: the filesystem's idmapping
+ * @vfsgid : vfsgid to be mapped
+ *
+ * Map @vfsgid into the filesystem idmapping. This function has to be used in
+ * order to e.g. write @vfsgid to inode->i_gid.
+ *
+ * Return: @vfsgid mapped into the filesystem idmapping
+ */
+kgid_t from_vfsgid(struct mnt_idmap *idmap,
+		   struct user_namespace *fs_userns, vfsgid_t vfsgid)
+{
+	gid_t gid;
+	struct user_namespace *mnt_userns = idmap->owner;
+
+	if (no_idmapping(mnt_userns, fs_userns))
+		return AS_KGIDT(vfsgid);
+	gid = from_kgid(mnt_userns, AS_KGIDT(vfsgid));
+	if (gid == (gid_t)-1)
+		return INVALID_GID;
+	if (initial_idmapping(fs_userns))
+		return KGIDT_INIT(gid);
+	return make_kgid(fs_userns, gid);
+}
+EXPORT_SYMBOL_GPL(from_vfsgid);
+
+#ifdef CONFIG_MULTIUSER
+/**
+ * vfsgid_in_group_p() - check whether a vfsuid matches the caller's groups
+ * @vfsgid: the mnt gid to match
+ *
+ * This function can be used to determine whether @vfsuid matches any of the
+ * caller's groups.
+ *
+ * Return: 1 if vfsuid matches caller's groups, 0 if not.
+ */
+int vfsgid_in_group_p(vfsgid_t vfsgid)
+{
+	return in_group_p(AS_KGIDT(vfsgid));
+}
+#else
+int vfsgid_in_group_p(vfsgid_t vfsgid)
+{
+	return 1;
+}
+#endif
+EXPORT_SYMBOL_GPL(vfsgid_in_group_p);
+
+struct mnt_idmap *alloc_mnt_idmap(struct user_namespace *mnt_userns)
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
+struct mnt_idmap *mnt_idmap_get(struct mnt_idmap *idmap)
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
+void mnt_idmap_put(struct mnt_idmap *idmap)
+{
+	if (idmap != &nop_mnt_idmap && refcount_dec_and_test(&idmap->count)) {
+		put_user_ns(idmap->owner);
+		kfree(idmap);
+	}
+}
diff --git a/fs/namespace.c b/fs/namespace.c
index b7a2af5c896e..5927d90e24a0 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -75,22 +75,6 @@ static DECLARE_RWSEM(namespace_sem);
 static HLIST_HEAD(unmounted);	/* protected by namespace_sem */
 static LIST_HEAD(ex_mountpoints); /* protected by namespace_sem */
 
-struct mnt_idmap {
-	struct user_namespace *owner;
-	refcount_t count;
-};
-
-/*
- * Carries the initial idmapping of 0:0:4294967295 which is an identity
- * mapping. This means that {g,u}id 0 is mapped to {g,u}id 0, {g,u}id 1 is
- * mapped to {g,u}id 1, [...], {g,u}id 1000 to {g,u}id 1000, [...].
- */
-struct mnt_idmap nop_mnt_idmap = {
-	.owner	= &init_user_ns,
-	.count	= REFCOUNT_INIT(1),
-};
-EXPORT_SYMBOL_GPL(nop_mnt_idmap);
-
 struct mount_kattr {
 	unsigned int attr_set;
 	unsigned int attr_clr;
@@ -210,78 +194,6 @@ int mnt_get_count(struct mount *mnt)
 #endif
 }
 
-/**
- * mnt_idmap_owner - retrieve owner of the mount's idmapping
- * @idmap: mount idmapping
- *
- * This helper will go away once the conversion to use struct mnt_idmap
- * everywhere has finished at which point the helper will be unexported.
- *
- * Only code that needs to perform permission checks based on the owner of the
- * idmapping will get access to it. All other code will solely rely on
- * idmappings. This will get us type safety so it's impossible to conflate
- * filesystems idmappings with mount idmappings.
- *
- * Return: The owner of the idmapping.
- */
-struct user_namespace *mnt_idmap_owner(const struct mnt_idmap *idmap)
-{
-	return idmap->owner;
-}
-EXPORT_SYMBOL_GPL(mnt_idmap_owner);
-
-/**
- * alloc_mnt_idmap - allocate a new idmapping for the mount
- * @mnt_userns: owning userns of the idmapping
- *
- * Allocate a new struct mnt_idmap which carries the idmapping of the mount.
- *
- * Return: On success a new idmap, on error an error pointer is returned.
- */
-static struct mnt_idmap *alloc_mnt_idmap(struct user_namespace *mnt_userns)
-{
-	struct mnt_idmap *idmap;
-
-	idmap = kzalloc(sizeof(struct mnt_idmap), GFP_KERNEL_ACCOUNT);
-	if (!idmap)
-		return ERR_PTR(-ENOMEM);
-
-	idmap->owner = get_user_ns(mnt_userns);
-	refcount_set(&idmap->count, 1);
-	return idmap;
-}
-
-/**
- * mnt_idmap_get - get a reference to an idmapping
- * @idmap: the idmap to bump the reference on
- *
- * If @idmap is not the @nop_mnt_idmap bump the reference count.
- *
- * Return: @idmap with reference count bumped if @not_mnt_idmap isn't passed.
- */
-static inline struct mnt_idmap *mnt_idmap_get(struct mnt_idmap *idmap)
-{
-	if (idmap != &nop_mnt_idmap)
-		refcount_inc(&idmap->count);
-
-	return idmap;
-}
-
-/**
- * mnt_idmap_put - put a reference to an idmapping
- * @idmap: the idmap to put the reference on
- *
- * If this is a non-initial idmapping, put the reference count when a mount is
- * released and free it if we're the last user.
- */
-static inline void mnt_idmap_put(struct mnt_idmap *idmap)
-{
-	if (idmap != &nop_mnt_idmap && refcount_dec_and_test(&idmap->count)) {
-		put_user_ns(idmap->owner);
-		kfree(idmap);
-	}
-}
-
 static struct mount *alloc_vfsmnt(const char *name)
 {
 	struct mount *mnt = kmem_cache_zalloc(mnt_cache, GFP_KERNEL);
@@ -4068,7 +3980,7 @@ static int can_idmap_mount(const struct mount_kattr *kattr, struct mount *mnt)
 	 * Creating an idmapped mount with the filesystem wide idmapping
 	 * doesn't make sense so block that. We don't allow mushy semantics.
 	 */
-	if (mnt_idmap_owner(kattr->mnt_idmap) == fs_userns)
+	if (!check_fsmapping(kattr->mnt_idmap, m->mnt_sb))
 		return -EINVAL;
 
 	/*
@@ -4314,7 +4226,7 @@ static int build_mount_idmapped(const struct mount_attr *attr, size_t usize,
 	 * result.
 	 */
 	mnt_userns = container_of(ns, struct user_namespace, ns);
-	if (initial_idmapping(mnt_userns)) {
+	if (mnt_userns == &init_user_ns) {
 		err = -EPERM;
 		goto out_fput;
 	}
diff --git a/include/linux/mnt_idmapping.h b/include/linux/mnt_idmapping.h
index 53d42b0b6f17..057c89867aa2 100644
--- a/include/linux/mnt_idmapping.h
+++ b/include/linux/mnt_idmapping.h
@@ -113,166 +113,19 @@ static inline bool vfsgid_eq_kgid(vfsgid_t vfsgid, kgid_t kgid)
 #define AS_KUIDT(val) (kuid_t){ __vfsuid_val(val) }
 #define AS_KGIDT(val) (kgid_t){ __vfsgid_val(val) }
 
-#ifdef CONFIG_MULTIUSER
-/**
- * vfsgid_in_group_p() - check whether a vfsuid matches the caller's groups
- * @vfsgid: the mnt gid to match
- *
- * This function can be used to determine whether @vfsuid matches any of the
- * caller's groups.
- *
- * Return: 1 if vfsuid matches caller's groups, 0 if not.
- */
-static inline int vfsgid_in_group_p(vfsgid_t vfsgid)
-{
-	return in_group_p(AS_KGIDT(vfsgid));
-}
-#else
-static inline int vfsgid_in_group_p(vfsgid_t vfsgid)
-{
-	return 1;
-}
-#endif
+int vfsgid_in_group_p(vfsgid_t vfsgid);
 
-/**
- * initial_idmapping - check whether this is the initial mapping
- * @ns: idmapping to check
- *
- * Check whether this is the initial mapping, mapping 0 to 0, 1 to 1,
- * [...], 1000 to 1000 [...].
- *
- * Return: true if this is the initial mapping, false if not.
- */
-static inline bool initial_idmapping(const struct user_namespace *ns)
-{
-	return ns == &init_user_ns;
-}
+vfsuid_t make_vfsuid(struct mnt_idmap *idmap,
+		     struct user_namespace *fs_userns, kuid_t kuid);
 
-/**
- * no_idmapping - check whether we can skip remapping a kuid/gid
- * @mnt_userns: the mount's idmapping
- * @fs_userns: the filesystem's idmapping
- *
- * This function can be used to check whether a remapping between two
- * idmappings is required.
- * An idmapped mount is a mount that has an idmapping attached to it that
- * is different from the filsystem's idmapping and the initial idmapping.
- * If the initial mapping is used or the idmapping of the mount and the
- * filesystem are identical no remapping is required.
- *
- * Return: true if remapping can be skipped, false if not.
- */
-static inline bool no_idmapping(const struct user_namespace *mnt_userns,
-				const struct user_namespace *fs_userns)
-{
-	return initial_idmapping(mnt_userns) || mnt_userns == fs_userns;
-}
+vfsgid_t make_vfsgid(struct mnt_idmap *idmap,
+		     struct user_namespace *fs_userns, kgid_t kgid);
 
-/**
- * make_vfsuid - map a filesystem kuid into a mnt_userns
- * @idmap: the mount's idmapping
- * @fs_userns: the filesystem's idmapping
- * @kuid : kuid to be mapped
- *
- * Take a @kuid and remap it from @fs_userns into @mnt_userns. Use this
- * function when preparing a @kuid to be reported to userspace.
- *
- * If no_idmapping() determines that this is not an idmapped mount we can
- * simply return @kuid unchanged.
- * If initial_idmapping() tells us that the filesystem is not mounted with an
- * idmapping we know the value of @kuid won't change when calling
- * from_kuid() so we can simply retrieve the value via __kuid_val()
- * directly.
- *
- * Return: @kuid mapped according to @mnt_userns.
- * If @kuid has no mapping in either @mnt_userns or @fs_userns INVALID_UID is
- * returned.
- */
+kuid_t from_vfsuid(struct mnt_idmap *idmap,
+		   struct user_namespace *fs_userns, vfsuid_t vfsuid);
 
-static inline vfsuid_t make_vfsuid(struct mnt_idmap *idmap,
-				   struct user_namespace *fs_userns,
-				   kuid_t kuid)
-{
-	uid_t uid;
-	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
-
-	if (no_idmapping(mnt_userns, fs_userns))
-		return VFSUIDT_INIT(kuid);
-	if (initial_idmapping(fs_userns))
-		uid = __kuid_val(kuid);
-	else
-		uid = from_kuid(fs_userns, kuid);
-	if (uid == (uid_t)-1)
-		return INVALID_VFSUID;
-	return VFSUIDT_INIT(make_kuid(mnt_userns, uid));
-}
-
-/**
- * make_vfsgid - map a filesystem kgid into a mnt_userns
- * @idmap: the mount's idmapping
- * @fs_userns: the filesystem's idmapping
- * @kgid : kgid to be mapped
- *
- * Take a @kgid and remap it from @fs_userns into @mnt_userns. Use this
- * function when preparing a @kgid to be reported to userspace.
- *
- * If no_idmapping() determines that this is not an idmapped mount we can
- * simply return @kgid unchanged.
- * If initial_idmapping() tells us that the filesystem is not mounted with an
- * idmapping we know the value of @kgid won't change when calling
- * from_kgid() so we can simply retrieve the value via __kgid_val()
- * directly.
- *
- * Return: @kgid mapped according to @mnt_userns.
- * If @kgid has no mapping in either @mnt_userns or @fs_userns INVALID_GID is
- * returned.
- */
-
-static inline vfsgid_t make_vfsgid(struct mnt_idmap *idmap,
-				   struct user_namespace *fs_userns,
-				   kgid_t kgid)
-{
-	gid_t gid;
-	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
-
-	if (no_idmapping(mnt_userns, fs_userns))
-		return VFSGIDT_INIT(kgid);
-	if (initial_idmapping(fs_userns))
-		gid = __kgid_val(kgid);
-	else
-		gid = from_kgid(fs_userns, kgid);
-	if (gid == (gid_t)-1)
-		return INVALID_VFSGID;
-	return VFSGIDT_INIT(make_kgid(mnt_userns, gid));
-}
-
-/**
- * from_vfsuid - map a vfsuid into the filesystem idmapping
- * @idmap: the mount's idmapping
- * @fs_userns: the filesystem's idmapping
- * @vfsuid : vfsuid to be mapped
- *
- * Map @vfsuid into the filesystem idmapping. This function has to be used in
- * order to e.g. write @vfsuid to inode->i_uid.
- *
- * Return: @vfsuid mapped into the filesystem idmapping
- */
-static inline kuid_t from_vfsuid(struct mnt_idmap *idmap,
-				 struct user_namespace *fs_userns,
-				 vfsuid_t vfsuid)
-{
-	uid_t uid;
-	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
-
-	if (no_idmapping(mnt_userns, fs_userns))
-		return AS_KUIDT(vfsuid);
-	uid = from_kuid(mnt_userns, AS_KUIDT(vfsuid));
-	if (uid == (uid_t)-1)
-		return INVALID_UID;
-	if (initial_idmapping(fs_userns))
-		return KUIDT_INIT(uid);
-	return make_kuid(fs_userns, uid);
-}
+kgid_t from_vfsgid(struct mnt_idmap *idmap,
+		   struct user_namespace *fs_userns, vfsgid_t vfsgid);
 
 /**
  * vfsuid_has_fsmapping - check whether a vfsuid maps into the filesystem
@@ -312,34 +165,6 @@ static inline kuid_t vfsuid_into_kuid(vfsuid_t vfsuid)
 	return AS_KUIDT(vfsuid);
 }
 
-/**
- * from_vfsgid - map a vfsgid into the filesystem idmapping
- * @idmap: the mount's idmapping
- * @fs_userns: the filesystem's idmapping
- * @vfsgid : vfsgid to be mapped
- *
- * Map @vfsgid into the filesystem idmapping. This function has to be used in
- * order to e.g. write @vfsgid to inode->i_gid.
- *
- * Return: @vfsgid mapped into the filesystem idmapping
- */
-static inline kgid_t from_vfsgid(struct mnt_idmap *idmap,
-				 struct user_namespace *fs_userns,
-				 vfsgid_t vfsgid)
-{
-	gid_t gid;
-	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
-
-	if (no_idmapping(mnt_userns, fs_userns))
-		return AS_KGIDT(vfsgid);
-	gid = from_kgid(mnt_userns, AS_KGIDT(vfsgid));
-	if (gid == (gid_t)-1)
-		return INVALID_GID;
-	if (initial_idmapping(fs_userns))
-		return KGIDT_INIT(gid);
-	return make_kgid(fs_userns, gid);
-}
-
 /**
  * vfsgid_has_fsmapping - check whether a vfsgid maps into the filesystem
  * @idmap: the mount's idmapping
@@ -416,4 +241,7 @@ static inline kgid_t mapped_fsgid(struct mnt_idmap *idmap,
 	return from_vfsgid(idmap, fs_userns, VFSGIDT_INIT(current_fsgid()));
 }
 
+bool check_fsmapping(const struct mnt_idmap *idmap,
+		     const struct super_block *sb);
+
 #endif /* _LINUX_MNT_IDMAPPING_H */
diff --git a/include/linux/mount.h b/include/linux/mount.h
index 02db5909d5c2..52f452b2259a 100644
--- a/include/linux/mount.h
+++ b/include/linux/mount.h
@@ -74,7 +74,6 @@ struct vfsmount {
 	struct mnt_idmap *mnt_idmap;
 } __randomize_layout;
 
-struct user_namespace *mnt_idmap_owner(const struct mnt_idmap *idmap);
 static inline struct mnt_idmap *mnt_idmap(const struct vfsmount *mnt)
 {
 	/* Pairs with smp_store_release() in do_idmap_mount(). */

-- 
2.34.1

