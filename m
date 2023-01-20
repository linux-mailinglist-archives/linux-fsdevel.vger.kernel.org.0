Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACCE46753E5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Jan 2023 12:55:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbjATLzZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Jan 2023 06:55:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbjATLzX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Jan 2023 06:55:23 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F711A3152
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Jan 2023 03:55:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2ED86B82608
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Jan 2023 11:55:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD7EEC433EF;
        Fri, 20 Jan 2023 11:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674215714;
        bh=knx/Gz5yGZv7oLgiyU5vNuZr7RfnF0fyyvz/YB0R9pE=;
        h=From:Date:Subject:To:Cc:From;
        b=UT4yhau5HjQ+xbrN3TQfoRJXMsfOw1V66X4ph0tOOCgvJpbIm50IfSgIfkyuVtkBO
         WFfIjW1iCbu0GT+xEFAHDA3AYlMhg9wzoGSIrqf2aa9OfzjBhCMh5NmaBHLeb22n2D
         gFBbr9hqHJPTC+UzJh+wravqjcAy2uBZQfOce6PJX+0ldm99Q11VmfqHX9DiVE5qwE
         i2oRgDIDkREe/o9tdIPT65Yfaxvek86837z1iKQUz7KC4Rh1aYrueS1zQuro34fNmR
         dXeWBsCJNZ0OOagnOFFNcwlCdS7ejLghJ6k60p/MkCKbepzEz74kSTUaEsZscSdqX3
         39IpW0veHC7Hg==
From:   Christian Brauner <brauner@kernel.org>
Date:   Fri, 20 Jan 2023 12:55:04 +0100
Subject: [PATCH] fuse: fixes after adapting to new posix acl api
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230118-fs-fuse-acl-v1-1-a628a9bb55ef@kernel.org>
X-B4-Tracking: v=1; b=H4sIABiBymMC/x2NQQrCQAwAv1JyNtBdRVq/Ih6yabYN6CpJW4TSv
 7v1OAzDbOBiKg63ZgOTVV3fpUI4NcATlVFQh8oQ23huQ+gwO+bFBYmfyDldrjGkvh8YapGoimR
 UeDqaF/ksdoiPSdbvf3N/7PsP35Vs5nYAAAA=
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-fsdevel@vger.kernel.org, Seth Forshee <sforshee@kernel.org>,
        "Christian Brauner (Microsoft)" <brauner@kernel.org>
X-Mailer: b4 0.12-dev-5b205
X-Developer-Signature: v=1; a=openpgp-sha256; l=14096; i=brauner@kernel.org;
 h=from:subject:message-id; bh=knx/Gz5yGZv7oLgiyU5vNuZr7RfnF0fyyvz/YB0R9pE=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSSfalRMWjzzSZuMy8OFqf0TWpdLz5jTPG2qs9wd6XdXemz3
 RD7z6ihlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZiIjQfD/8jWl4t5Bd7srJp93epo6K
 HLTnGMMd3tO00i5HuSfkw2F2dkWLn3v769Cn/lGxuu1aJ30ndctlJ2vXZ+Qd0JRnlDdsXzLAA=
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

This cycle we ported all filesystems to the new posix acl api. While
looking at further simplifications in this area to remove the last
remnants of the generic dummy posix acl handlers we realized that we
regressed fuse daemons that don't set FUSE_POSIX_ACL but still make use
of posix acls.

With the change to a dedicated posix acl api interacting with posix acls
doesn't go through the old xattr codepaths anymore and instead only
relies the get acl and set acl inode operations.

Before this change fuse daemons that don't set FUSE_POSIX_ACL were able
to get and set posix acl albeit with two caveats. First, that posix acls
aren't cached. And second, that they aren't used for permission checking
in the vfs.

We regressed that use-case as we currently refuse to retrieve any posix
acls if they aren't enabled via FUSE_POSIX_ACL. So older fuse daemons
would see a change in behavior.

We can restore the old behavior in multiple ways. We could change the
new posix acl api and look for a dedicated xattr handler and if we find
one prefer that over the dedicated posix acl api. That would break the
consistency of the new posix acl api so we would very much prefer not to
do that.

We could introduce a new ACL_*_CACHE sentinel that would instruct the
vfs permission checking codepath to not call into the filesystem and
ignore acls.

But a more straightforward fix for v6.2 is to do the same thing that
Overlayfs does and give fuse a separate get acl method for permission
checking. Overlayfs uses this to express different needs for vfs
permission lookup and acl based retrieval via the regular system call
path as well. Let fuse do the same for now. This way fuse can continue
to refuse to retrieve posix acls for daemons that don't set
FUSE_POSXI_ACL for permission checking while allowing a fuse server to
retrieve it via the usual system calls.

In the future, we could extend the get acl inode operation to not just
pass a simple boolean to indicate rcu lookup but instead make it a flag
argument. Then in addition to passing the information that this is an
rcu lookup to the filesystem we could also introduce a flag that tells
the filesystem that this is a request from the vfs to use these acls for
permission checking. Then fuse could refuse the get acl request for
permission checking when the daemon doesn't have FUSE_POSIX_ACL set in
the same get acl method. This would also help Overlayfs and allow us to
remove the second method for it as well.

But since that change is more invasive as we need to update the get acl
inode operation for multiple filesystems we should not do this as a fix
for v6.2. Instead we will do this for the v6.3 merge window.

Fwiw, since posix acls are now always correctly translated in the new
posix acl api we could also allow them to be used for daemons without
FUSE_POSIX_ACL that are not mounted on the host. But this is behavioral
change and again if dones should be done for v6.3. For now, let's just
restore the original behavior.

A nice side-effect of this change is that for fuse daemons with and
without FUSE_POSIX_ACL the same code is used for posix acls in a
backwards compatible way. This also means we can remove the legacy xattr
handlers completely. We've also added comments to explain the expected
behavior for daemons without FUSE_POSIX_ACL into the code.

Fixes: 318e66856dde ("xattr: use posix acl api")
Signed-off-by: Seth Forshee (Digital Ocean) <sforshee@kernel.org>
Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
---

Hey Miklos,

If you're fine with this approach then could you please route this to
Linus during v6.2 still? If you prefer I do it I'm happy to as well.

Thanks!
Christian
---
 fs/fuse/acl.c    | 68 ++++++++++++++++++++++++++++++++++++++++++++++++++------
 fs/fuse/dir.c    |  6 +++--
 fs/fuse/fuse_i.h |  6 ++---
 fs/fuse/inode.c  | 21 +++++++++--------
 fs/fuse/xattr.c  | 51 ------------------------------------------
 5 files changed, 78 insertions(+), 74 deletions(-)

diff --git a/fs/fuse/acl.c b/fs/fuse/acl.c
index a4850aee2639..ad670369955f 100644
--- a/fs/fuse/acl.c
+++ b/fs/fuse/acl.c
@@ -11,9 +11,10 @@
 #include <linux/posix_acl.h>
 #include <linux/posix_acl_xattr.h>
 
-struct posix_acl *fuse_get_acl(struct inode *inode, int type, bool rcu)
+static struct posix_acl *__fuse_get_acl(struct fuse_conn *fc,
+					struct user_namespace *mnt_userns,
+					struct inode *inode, int type, bool rcu)
 {
-	struct fuse_conn *fc = get_fuse_conn(inode);
 	int size;
 	const char *name;
 	void *value = NULL;
@@ -25,7 +26,7 @@ struct posix_acl *fuse_get_acl(struct inode *inode, int type, bool rcu)
 	if (fuse_is_bad(inode))
 		return ERR_PTR(-EIO);
 
-	if (!fc->posix_acl || fc->no_getxattr)
+	if (fc->no_getxattr)
 		return NULL;
 
 	if (type == ACL_TYPE_ACCESS)
@@ -53,6 +54,46 @@ struct posix_acl *fuse_get_acl(struct inode *inode, int type, bool rcu)
 	return acl;
 }
 
+static inline bool fuse_no_acl(const struct fuse_conn *fc,
+			       const struct inode *inode)
+{
+	/*
+	 * Refuse interacting with POSIX ACLs for daemons that
+	 * don't support FUSE_POSIX_ACL and are not mounted on
+	 * the host to retain backwards compatibility.
+	 */
+	return !fc->posix_acl && (i_user_ns(inode) != &init_user_ns);
+}
+
+struct posix_acl *fuse_get_acl(struct user_namespace *mnt_userns,
+			       struct dentry *dentry, int type)
+{
+	struct inode *inode = d_inode(dentry);
+	struct fuse_conn *fc = get_fuse_conn(inode);
+
+	if (fuse_no_acl(fc, inode))
+		return ERR_PTR(-EOPNOTSUPP);
+
+	return __fuse_get_acl(fc, mnt_userns, inode, type, false);
+}
+
+struct posix_acl *fuse_get_inode_acl(struct inode *inode, int type, bool rcu)
+{
+	struct fuse_conn *fc = get_fuse_conn(inode);
+
+	/*
+	 * FUSE daemons before FUSE_POSIX_ACL was introduced could get and set
+	 * POSIX ACLs without them being used for permission checking by the
+	 * vfs. Retain that behavior for backwards compatibility as there are
+	 * filesystems that do all permission checking for acls in the daemon
+	 * and not in the kernel.
+	 */
+	if (!fc->posix_acl)
+		return NULL;
+
+	return __fuse_get_acl(fc, &init_user_ns, inode, type, rcu);
+}
+
 int fuse_set_acl(struct user_namespace *mnt_userns, struct dentry *dentry,
 		 struct posix_acl *acl, int type)
 {
@@ -64,7 +105,7 @@ int fuse_set_acl(struct user_namespace *mnt_userns, struct dentry *dentry,
 	if (fuse_is_bad(inode))
 		return -EIO;
 
-	if (!fc->posix_acl || fc->no_setxattr)
+	if (fc->no_setxattr || fuse_no_acl(fc, inode))
 		return -EOPNOTSUPP;
 
 	if (type == ACL_TYPE_ACCESS)
@@ -99,7 +140,13 @@ int fuse_set_acl(struct user_namespace *mnt_userns, struct dentry *dentry,
 			return ret;
 		}
 
-		if (!vfsgid_in_group_p(i_gid_into_vfsgid(&init_user_ns, inode)) &&
+		/*
+		 * Fuse daemons without FUSE_POSIX_ACL never changed the passed
+		 * through POSIX ACLs. Such daemons don't expect setgid bits to
+		 * be stripped.
+		 */
+		if (fc->posix_acl &&
+		    !vfsgid_in_group_p(i_gid_into_vfsgid(&init_user_ns, inode)) &&
 		    !capable_wrt_inode_uidgid(&init_user_ns, inode, CAP_FSETID))
 			extra_flags |= FUSE_SETXATTR_ACL_KILL_SGID;
 
@@ -108,8 +155,15 @@ int fuse_set_acl(struct user_namespace *mnt_userns, struct dentry *dentry,
 	} else {
 		ret = fuse_removexattr(inode, name);
 	}
-	forget_all_cached_acls(inode);
-	fuse_invalidate_attr(inode);
+
+	if (fc->posix_acl) {
+		/*
+		 * Fuse daemons without FUSE_POSIX_ACL never cached POSIX ACLs
+		 * and didn't invalidate attributes. Retain that behavior.
+		 */
+		forget_all_cached_acls(inode);
+		fuse_invalidate_attr(inode);
+	}
 
 	return ret;
 }
diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index cd1a071b625a..2725fb54328e 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -1942,7 +1942,8 @@ static const struct inode_operations fuse_dir_inode_operations = {
 	.permission	= fuse_permission,
 	.getattr	= fuse_getattr,
 	.listxattr	= fuse_listxattr,
-	.get_inode_acl	= fuse_get_acl,
+	.get_inode_acl	= fuse_get_inode_acl,
+	.get_acl	= fuse_get_acl,
 	.set_acl	= fuse_set_acl,
 	.fileattr_get	= fuse_fileattr_get,
 	.fileattr_set	= fuse_fileattr_set,
@@ -1964,7 +1965,8 @@ static const struct inode_operations fuse_common_inode_operations = {
 	.permission	= fuse_permission,
 	.getattr	= fuse_getattr,
 	.listxattr	= fuse_listxattr,
-	.get_inode_acl	= fuse_get_acl,
+	.get_inode_acl	= fuse_get_inode_acl,
+	.get_acl	= fuse_get_acl,
 	.set_acl	= fuse_set_acl,
 	.fileattr_get	= fuse_fileattr_get,
 	.fileattr_set	= fuse_fileattr_set,
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index c673faefdcb9..46797a171a84 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1264,11 +1264,11 @@ ssize_t fuse_getxattr(struct inode *inode, const char *name, void *value,
 ssize_t fuse_listxattr(struct dentry *entry, char *list, size_t size);
 int fuse_removexattr(struct inode *inode, const char *name);
 extern const struct xattr_handler *fuse_xattr_handlers[];
-extern const struct xattr_handler *fuse_acl_xattr_handlers[];
-extern const struct xattr_handler *fuse_no_acl_xattr_handlers[];
 
 struct posix_acl;
-struct posix_acl *fuse_get_acl(struct inode *inode, int type, bool rcu);
+struct posix_acl *fuse_get_inode_acl(struct inode *inode, int type, bool rcu);
+struct posix_acl *fuse_get_acl(struct user_namespace *mnt_userns,
+			       struct dentry *dentry, int type);
 int fuse_set_acl(struct user_namespace *mnt_userns, struct dentry *dentry,
 		 struct posix_acl *acl, int type);
 
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 6b3beda16c1b..de9b9ec5ce81 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -311,7 +311,8 @@ void fuse_change_attributes(struct inode *inode, struct fuse_attr *attr,
 		fuse_dax_dontcache(inode, attr->flags);
 }
 
-static void fuse_init_inode(struct inode *inode, struct fuse_attr *attr)
+static void fuse_init_inode(struct inode *inode, struct fuse_attr *attr,
+			    struct fuse_conn *fc)
 {
 	inode->i_mode = attr->mode & S_IFMT;
 	inode->i_size = attr->size;
@@ -333,6 +334,12 @@ static void fuse_init_inode(struct inode *inode, struct fuse_attr *attr)
 				   new_decode_dev(attr->rdev));
 	} else
 		BUG();
+	/*
+	 * Ensure that we don't cache acls for daemons without FUSE_POSIX_ACL
+	 * so they see the exact same behavior as before.
+	 */
+	if (!fc->posix_acl)
+		inode->i_acl = inode->i_default_acl = ACL_DONT_CACHE;
 }
 
 static int fuse_inode_eq(struct inode *inode, void *_nodeidp)
@@ -372,7 +379,7 @@ struct inode *fuse_iget(struct super_block *sb, u64 nodeid,
 		if (!inode)
 			return NULL;
 
-		fuse_init_inode(inode, attr);
+		fuse_init_inode(inode, attr, fc);
 		get_fuse_inode(inode)->nodeid = nodeid;
 		inode->i_flags |= S_AUTOMOUNT;
 		goto done;
@@ -388,7 +395,7 @@ struct inode *fuse_iget(struct super_block *sb, u64 nodeid,
 		if (!fc->writeback_cache || !S_ISREG(attr->mode))
 			inode->i_flags |= S_NOCMTIME;
 		inode->i_generation = generation;
-		fuse_init_inode(inode, attr);
+		fuse_init_inode(inode, attr, fc);
 		unlock_new_inode(inode);
 	} else if (fuse_stale_inode(inode, generation, attr)) {
 		/* nodeid was reused, any I/O on the old inode should fail */
@@ -1174,7 +1181,6 @@ static void process_init_reply(struct fuse_mount *fm, struct fuse_args *args,
 			if ((flags & FUSE_POSIX_ACL)) {
 				fc->default_permissions = 1;
 				fc->posix_acl = 1;
-				fm->sb->s_xattr = fuse_acl_xattr_handlers;
 			}
 			if (flags & FUSE_CACHE_SYMLINKS)
 				fc->cache_symlinks = 1;
@@ -1420,13 +1426,6 @@ static void fuse_sb_defaults(struct super_block *sb)
 	if (sb->s_user_ns != &init_user_ns)
 		sb->s_iflags |= SB_I_UNTRUSTED_MOUNTER;
 	sb->s_flags &= ~(SB_NOSEC | SB_I_VERSION);
-
-	/*
-	 * If we are not in the initial user namespace posix
-	 * acls must be translated.
-	 */
-	if (sb->s_user_ns != &init_user_ns)
-		sb->s_xattr = fuse_no_acl_xattr_handlers;
 }
 
 static int fuse_fill_super_submount(struct super_block *sb,
diff --git a/fs/fuse/xattr.c b/fs/fuse/xattr.c
index 0d3e7177fce0..9fe571ab569e 100644
--- a/fs/fuse/xattr.c
+++ b/fs/fuse/xattr.c
@@ -203,27 +203,6 @@ static int fuse_xattr_set(const struct xattr_handler *handler,
 	return fuse_setxattr(inode, name, value, size, flags, 0);
 }
 
-static bool no_xattr_list(struct dentry *dentry)
-{
-	return false;
-}
-
-static int no_xattr_get(const struct xattr_handler *handler,
-			struct dentry *dentry, struct inode *inode,
-			const char *name, void *value, size_t size)
-{
-	return -EOPNOTSUPP;
-}
-
-static int no_xattr_set(const struct xattr_handler *handler,
-			struct user_namespace *mnt_userns,
-			struct dentry *dentry, struct inode *nodee,
-			const char *name, const void *value,
-			size_t size, int flags)
-{
-	return -EOPNOTSUPP;
-}
-
 static const struct xattr_handler fuse_xattr_handler = {
 	.prefix = "",
 	.get    = fuse_xattr_get,
@@ -234,33 +213,3 @@ const struct xattr_handler *fuse_xattr_handlers[] = {
 	&fuse_xattr_handler,
 	NULL
 };
-
-const struct xattr_handler *fuse_acl_xattr_handlers[] = {
-	&posix_acl_access_xattr_handler,
-	&posix_acl_default_xattr_handler,
-	&fuse_xattr_handler,
-	NULL
-};
-
-static const struct xattr_handler fuse_no_acl_access_xattr_handler = {
-	.name  = XATTR_NAME_POSIX_ACL_ACCESS,
-	.flags = ACL_TYPE_ACCESS,
-	.list  = no_xattr_list,
-	.get   = no_xattr_get,
-	.set   = no_xattr_set,
-};
-
-static const struct xattr_handler fuse_no_acl_default_xattr_handler = {
-	.name  = XATTR_NAME_POSIX_ACL_DEFAULT,
-	.flags = ACL_TYPE_ACCESS,
-	.list  = no_xattr_list,
-	.get   = no_xattr_get,
-	.set   = no_xattr_set,
-};
-
-const struct xattr_handler *fuse_no_acl_xattr_handlers[] = {
-	&fuse_no_acl_access_xattr_handler,
-	&fuse_no_acl_default_xattr_handler,
-	&fuse_xattr_handler,
-	NULL
-};

---
base-commit: 292a089d78d3e2f7944e60bb897c977785a321e3
change-id: 20230118-fs-fuse-acl-cfb4621b99dc

