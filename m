Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6C58779BFD
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Aug 2023 02:42:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237210AbjHLAmE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Aug 2023 20:42:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237156AbjHLAmD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Aug 2023 20:42:03 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F563A6;
        Fri, 11 Aug 2023 17:42:02 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id CA75F218ED;
        Sat, 12 Aug 2023 00:42:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1691800920; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CmJfT1nmKi9TBJihLOUVJWtNn9PwJXKiJfPTJpvjICw=;
        b=TbWt1QoVCbqhLC1oqUn8dcFnmT/avQk/jNM+pLBhceF0W2enoNQHWV3P0g9YUrz50HGMyj
        Kt/FYahT7bxBVbVaDLwMcYYoCtk1MvNTroqMrid3o0TY7xrfKLcG63B7Fn9zFohdNY6oh6
        XEhfaeJGi/LwzBxsqM5hEbICqAOTA0w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1691800920;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CmJfT1nmKi9TBJihLOUVJWtNn9PwJXKiJfPTJpvjICw=;
        b=KcDPHboekPO5hHU9Pf8PEunD2KIoLFC2Fe5YJYije4zkP9sCDw1m/dcea2ghZt8UuXXcKp
        +VK3WJRATfGFnuAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7BA0313592;
        Sat, 12 Aug 2023 00:42:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Vxm5GFjV1mQUEAAAMHmgww
        (envelope-from <krisman@suse.de>); Sat, 12 Aug 2023 00:42:00 +0000
From:   Gabriel Krisman Bertazi <krisman@suse.de>
To:     viro@zeniv.linux.org.uk, brauner@kernel.org, tytso@mit.edu,
        ebiggers@kernel.org, jaegeuk@kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        Gabriel Krisman Bertazi <krisman@suse.de>,
        Gabriel Krisman Bertazi <krisman@collabora.com>
Subject: [PATCH v5 04/10] fs: Expose name under lookup to d_revalidate hooks
Date:   Fri, 11 Aug 2023 20:41:40 -0400
Message-ID: <20230812004146.30980-5-krisman@suse.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230812004146.30980-1-krisman@suse.de>
References: <20230812004146.30980-1-krisman@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Gabriel Krisman Bertazi <krisman@collabora.com>

Negative dentries support on case-insensitive ext4/f2fs will require
access to the name under lookup to ensure it matches the dentry.  This
adds the information on d_revalidate and updates its implementation.

This was done through a Coccinelle hook and tested by building with
allyesconfig.

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>

---
Changes since v3:
  - Merge d_revalidate_name with d_revalidate (Christian)
  - Drop Ted's r-b since patch changed quite a bit. (Me)
Changes since v2:
  - Document d_revalidate_name hook. (Eric)
---
 Documentation/filesystems/locking.rst |  3 ++-
 Documentation/filesystems/vfs.rst     | 11 ++++++++++-
 fs/9p/vfs_dentry.c                    |  5 +++--
 fs/afs/dir.c                          |  6 ++++--
 fs/afs/dynroot.c                      |  4 +++-
 fs/ceph/dir.c                         |  3 ++-
 fs/coda/dir.c                         |  3 ++-
 fs/crypto/fname.c                     |  3 ++-
 fs/ecryptfs/dentry.c                  |  5 +++--
 fs/exfat/namei.c                      |  3 ++-
 fs/fat/namei_vfat.c                   |  6 ++++--
 fs/fuse/dir.c                         |  3 ++-
 fs/gfs2/dentry.c                      |  3 ++-
 fs/hfs/sysdep.c                       |  3 ++-
 fs/jfs/namei.c                        |  3 ++-
 fs/kernfs/dir.c                       |  3 ++-
 fs/namei.c                            | 18 ++++++++++--------
 fs/nfs/dir.c                          |  9 ++++++---
 fs/ocfs2/dcache.c                     |  4 +++-
 fs/orangefs/dcache.c                  |  3 ++-
 fs/overlayfs/super.c                  | 20 ++++++++++++--------
 fs/proc/base.c                        |  6 ++++--
 fs/proc/fd.c                          |  3 ++-
 fs/proc/generic.c                     |  6 ++++--
 fs/proc/proc_sysctl.c                 |  3 ++-
 fs/reiserfs/xattr.c                   |  3 ++-
 fs/smb/client/dir.c                   |  3 ++-
 fs/vboxsf/dir.c                       |  4 +++-
 include/linux/dcache.h                |  2 +-
 include/linux/fscrypt.h               |  4 +++-
 30 files changed, 103 insertions(+), 52 deletions(-)

diff --git a/Documentation/filesystems/locking.rst b/Documentation/filesystems/locking.rst
index ed148919e11a..1603c53a1688 100644
--- a/Documentation/filesystems/locking.rst
+++ b/Documentation/filesystems/locking.rst
@@ -17,7 +17,8 @@ dentry_operations
 
 prototypes::
 
-	int (*d_revalidate)(struct dentry *, unsigned int);
+	int (*d_revalidate)(struct dentry *, const struct qstr *,
+			    unsigned int);
 	int (*d_weak_revalidate)(struct dentry *, unsigned int);
 	int (*d_hash)(const struct dentry *, struct qstr *);
 	int (*d_compare)(const struct dentry *,
diff --git a/Documentation/filesystems/vfs.rst b/Documentation/filesystems/vfs.rst
index cb2a97e49872..ddd542c2a722 100644
--- a/Documentation/filesystems/vfs.rst
+++ b/Documentation/filesystems/vfs.rst
@@ -1251,7 +1251,8 @@ defined:
 .. code-block:: c
 
 	struct dentry_operations {
-		int (*d_revalidate)(struct dentry *, unsigned int);
+		int (*d_revalidate)(struct dentry *, const struct qstr *,
+				    unsigned int);
 		int (*d_weak_revalidate)(struct dentry *, unsigned int);
 		int (*d_hash)(const struct dentry *, struct qstr *);
 		int (*d_compare)(const struct dentry *,
@@ -1284,6 +1285,14 @@ defined:
 	they can change and, in d_inode case, even become NULL under
 	us).
 
+	Filesystems shouldn't rely on the name under lookup, unless
+	there are particular filename encoding semantics to be handled
+	during revalidation.  Note the name under lookup can change from
+	under d_revalidate, so it must be protected with ->d_lock before
+	accessing.  The exception is when revalidating negative dentries
+	for creation, in which case the parent inode prevents it from
+	changing.
+
 	If a situation is encountered that rcu-walk cannot handle,
 	return
 	-ECHILD and it will be called again in ref-walk mode.
diff --git a/fs/9p/vfs_dentry.c b/fs/9p/vfs_dentry.c
index 0c6fa1f53530..de679d9505db 100644
--- a/fs/9p/vfs_dentry.c
+++ b/fs/9p/vfs_dentry.c
@@ -56,7 +56,8 @@ static void v9fs_dentry_release(struct dentry *dentry)
 	dentry->d_fsdata = NULL;
 }
 
-static int v9fs_lookup_revalidate(struct dentry *dentry, unsigned int flags)
+static int v9fs_lookup_revalidate(struct dentry *dentry,
+				  const struct qstr *name, unsigned int flags)
 {
 	struct p9_fid *fid;
 	struct inode *inode;
@@ -97,7 +98,7 @@ static int v9fs_lookup_revalidate(struct dentry *dentry, unsigned int flags)
 static int v9fs_lookup_weak_revalidate(struct dentry *dentry,
 				       unsigned int flags)
 {
-	return v9fs_lookup_revalidate(dentry, flags);
+	return v9fs_lookup_revalidate(dentry, NULL, flags);
 }
 
 const struct dentry_operations v9fs_cached_dentry_operations = {
diff --git a/fs/afs/dir.c b/fs/afs/dir.c
index 5219182e52e1..e3ba14512715 100644
--- a/fs/afs/dir.c
+++ b/fs/afs/dir.c
@@ -21,7 +21,8 @@ static struct dentry *afs_lookup(struct inode *dir, struct dentry *dentry,
 				 unsigned int flags);
 static int afs_dir_open(struct inode *inode, struct file *file);
 static int afs_readdir(struct file *file, struct dir_context *ctx);
-static int afs_d_revalidate(struct dentry *dentry, unsigned int flags);
+static int afs_d_revalidate(struct dentry *dentry, const struct qstr *name,
+			    unsigned int flags);
 static int afs_d_delete(const struct dentry *dentry);
 static void afs_d_iput(struct dentry *dentry, struct inode *inode);
 static bool afs_lookup_one_filldir(struct dir_context *ctx, const char *name, int nlen,
@@ -1084,7 +1085,8 @@ static int afs_d_revalidate_rcu(struct dentry *dentry)
  * - NOTE! the hit can be a negative hit too, so we can't assume we have an
  *   inode
  */
-static int afs_d_revalidate(struct dentry *dentry, unsigned int flags)
+static int afs_d_revalidate(struct dentry *dentry, const struct qstr *name,
+			    unsigned int flags)
 {
 	struct afs_vnode *vnode, *dir;
 	struct afs_fid fid;
diff --git a/fs/afs/dynroot.c b/fs/afs/dynroot.c
index d7d9402ff718..44a8f736eaf8 100644
--- a/fs/afs/dynroot.c
+++ b/fs/afs/dynroot.c
@@ -247,7 +247,9 @@ const struct inode_operations afs_dynroot_inode_operations = {
 /*
  * Dirs in the dynamic root don't need revalidation.
  */
-static int afs_dynroot_d_revalidate(struct dentry *dentry, unsigned int flags)
+static int afs_dynroot_d_revalidate(struct dentry *dentry,
+				    const struct qstr *name,
+				    unsigned int flags)
 {
 	return 1;
 }
diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
index 4a2b39d9a61a..dffc115adae0 100644
--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -1758,7 +1758,8 @@ static int dir_lease_is_valid(struct inode *dir, struct dentry *dentry,
 /*
  * Check if cached dentry can be trusted.
  */
-static int ceph_d_revalidate(struct dentry *dentry, unsigned int flags)
+static int ceph_d_revalidate(struct dentry *dentry, const struct qstr *name,
+			     unsigned int flags)
 {
 	int valid = 0;
 	struct dentry *parent;
diff --git a/fs/coda/dir.c b/fs/coda/dir.c
index 8450b1bd354b..bb2ecac4a7e7 100644
--- a/fs/coda/dir.c
+++ b/fs/coda/dir.c
@@ -452,7 +452,8 @@ static int coda_readdir(struct file *coda_file, struct dir_context *ctx)
 }
 
 /* called when a cache lookup succeeds */
-static int coda_dentry_revalidate(struct dentry *de, unsigned int flags)
+static int coda_dentry_revalidate(struct dentry *de, const struct qstr *name,
+				  unsigned int flags)
 {
 	struct inode *inode;
 	struct coda_inode_info *cii;
diff --git a/fs/crypto/fname.c b/fs/crypto/fname.c
index 6eae3f12ad50..d543e4648a0f 100644
--- a/fs/crypto/fname.c
+++ b/fs/crypto/fname.c
@@ -580,7 +580,8 @@ EXPORT_SYMBOL_GPL(fscrypt_fname_siphash);
  * Validate dentries in encrypted directories to make sure we aren't potentially
  * caching stale dentries after a key has been added.
  */
-int fscrypt_d_revalidate(struct dentry *dentry, unsigned int flags)
+int fscrypt_d_revalidate(struct dentry *dentry, const struct qstr *name,
+			 unsigned int flags)
 {
 	struct dentry *dir;
 	int err;
diff --git a/fs/ecryptfs/dentry.c b/fs/ecryptfs/dentry.c
index acaa0825e9bb..56093648d838 100644
--- a/fs/ecryptfs/dentry.c
+++ b/fs/ecryptfs/dentry.c
@@ -28,7 +28,8 @@
  * Returns 1 if valid, 0 otherwise.
  *
  */
-static int ecryptfs_d_revalidate(struct dentry *dentry, unsigned int flags)
+static int ecryptfs_d_revalidate(struct dentry *dentry,
+				 const struct qstr *name, unsigned int flags)
 {
 	struct dentry *lower_dentry = ecryptfs_dentry_to_lower(dentry);
 	int rc = 1;
@@ -37,7 +38,7 @@ static int ecryptfs_d_revalidate(struct dentry *dentry, unsigned int flags)
 		return -ECHILD;
 
 	if (lower_dentry->d_flags & DCACHE_OP_REVALIDATE)
-		rc = lower_dentry->d_op->d_revalidate(lower_dentry, flags);
+		rc = lower_dentry->d_op->d_revalidate(lower_dentry, name, flags);
 
 	if (d_really_is_positive(dentry)) {
 		struct inode *inode = d_inode(dentry);
diff --git a/fs/exfat/namei.c b/fs/exfat/namei.c
index e0ff9d156f6f..6220046a687b 100644
--- a/fs/exfat/namei.c
+++ b/fs/exfat/namei.c
@@ -31,7 +31,8 @@ static inline void exfat_d_version_set(struct dentry *dentry,
  * If it happened, the negative dentry isn't actually negative anymore.  So,
  * drop it.
  */
-static int exfat_d_revalidate(struct dentry *dentry, unsigned int flags)
+static int exfat_d_revalidate(struct dentry *dentry, const struct qstr *name,
+			      unsigned int flags)
 {
 	int ret;
 
diff --git a/fs/fat/namei_vfat.c b/fs/fat/namei_vfat.c
index c4d00999a433..73981b0e4ea7 100644
--- a/fs/fat/namei_vfat.c
+++ b/fs/fat/namei_vfat.c
@@ -53,7 +53,8 @@ static int vfat_revalidate_shortname(struct dentry *dentry)
 	return ret;
 }
 
-static int vfat_revalidate(struct dentry *dentry, unsigned int flags)
+static int vfat_revalidate(struct dentry *dentry, const struct qstr *name,
+			   unsigned int flags)
 {
 	if (flags & LOOKUP_RCU)
 		return -ECHILD;
@@ -64,7 +65,8 @@ static int vfat_revalidate(struct dentry *dentry, unsigned int flags)
 	return vfat_revalidate_shortname(dentry);
 }
 
-static int vfat_revalidate_ci(struct dentry *dentry, unsigned int flags)
+static int vfat_revalidate_ci(struct dentry *dentry, const struct qstr *name,
+			      unsigned int flags)
 {
 	if (flags & LOOKUP_RCU)
 		return -ECHILD;
diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 35bc174f9ba2..948bbfc1aae4 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -202,7 +202,8 @@ static void fuse_lookup_init(struct fuse_conn *fc, struct fuse_args *args,
  * the lookup once more.  If the lookup results in the same inode,
  * then refresh the attributes, timeouts and mark the dentry valid.
  */
-static int fuse_dentry_revalidate(struct dentry *entry, unsigned int flags)
+static int fuse_dentry_revalidate(struct dentry *entry,
+				  const struct qstr *name, unsigned int flags)
 {
 	struct inode *inode;
 	struct dentry *parent;
diff --git a/fs/gfs2/dentry.c b/fs/gfs2/dentry.c
index 2e215e8c3c88..3dd93d36aaf2 100644
--- a/fs/gfs2/dentry.c
+++ b/fs/gfs2/dentry.c
@@ -30,7 +30,8 @@
  * Returns: 1 if the dentry is ok, 0 if it isn't
  */
 
-static int gfs2_drevalidate(struct dentry *dentry, unsigned int flags)
+static int gfs2_drevalidate(struct dentry *dentry, const struct qstr *name,
+			    unsigned int flags)
 {
 	struct dentry *parent;
 	struct gfs2_sbd *sdp;
diff --git a/fs/hfs/sysdep.c b/fs/hfs/sysdep.c
index 2875961fdc10..68fb32f4fbb8 100644
--- a/fs/hfs/sysdep.c
+++ b/fs/hfs/sysdep.c
@@ -13,7 +13,8 @@
 
 /* dentry case-handling: just lowercase everything */
 
-static int hfs_revalidate_dentry(struct dentry *dentry, unsigned int flags)
+static int hfs_revalidate_dentry(struct dentry *dentry,
+				 const struct qstr *name, unsigned int flags)
 {
 	struct inode *inode;
 	int diff;
diff --git a/fs/jfs/namei.c b/fs/jfs/namei.c
index 9b030297aa64..0d2b5b54e2d8 100644
--- a/fs/jfs/namei.c
+++ b/fs/jfs/namei.c
@@ -1573,7 +1573,8 @@ static int jfs_ci_compare(const struct dentry *dentry,
 	return result;
 }
 
-static int jfs_ci_revalidate(struct dentry *dentry, unsigned int flags)
+static int jfs_ci_revalidate(struct dentry *dentry, const struct qstr *name,
+			     unsigned int flags)
 {
 	/*
 	 * This is not negative dentry. Always valid.
diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index 5a1a4af9d3d2..820988710ce5 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -1084,7 +1084,8 @@ struct kernfs_node *kernfs_create_empty_dir(struct kernfs_node *parent,
 	return ERR_PTR(rc);
 }
 
-static int kernfs_dop_revalidate(struct dentry *dentry, unsigned int flags)
+static int kernfs_dop_revalidate(struct dentry *dentry,
+				 const struct qstr *name, unsigned int flags)
 {
 	struct kernfs_node *kn;
 	struct kernfs_root *root;
diff --git a/fs/namei.c b/fs/namei.c
index e56ff39a79bc..7631c762217a 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -853,10 +853,12 @@ static bool try_to_unlazy_next(struct nameidata *nd, struct dentry *dentry)
 	return false;
 }
 
-static inline int d_revalidate(struct dentry *dentry, unsigned int flags)
+static inline int d_revalidate(struct dentry *dentry,
+			       const struct qstr *name,
+			       unsigned int flags)
 {
 	if (unlikely(dentry->d_flags & DCACHE_OP_REVALIDATE))
-		return dentry->d_op->d_revalidate(dentry, flags);
+		return dentry->d_op->d_revalidate(dentry, name, flags);
 	else
 		return 1;
 }
@@ -1565,7 +1567,7 @@ static struct dentry *lookup_dcache(const struct qstr *name,
 {
 	struct dentry *dentry = d_lookup(dir, name);
 	if (dentry) {
-		int error = d_revalidate(dentry, flags);
+		int error = d_revalidate(dentry, name, flags);
 		if (unlikely(error <= 0)) {
 			if (!error)
 				d_invalidate(dentry);
@@ -1636,19 +1638,19 @@ static struct dentry *lookup_fast(struct nameidata *nd)
 		if (read_seqcount_retry(&parent->d_seq, nd->seq))
 			return ERR_PTR(-ECHILD);
 
-		status = d_revalidate(dentry, nd->flags);
+		status = d_revalidate(dentry, &nd->last, nd->flags);
 		if (likely(status > 0))
 			return dentry;
 		if (!try_to_unlazy_next(nd, dentry))
 			return ERR_PTR(-ECHILD);
 		if (status == -ECHILD)
 			/* we'd been told to redo it in non-rcu mode */
-			status = d_revalidate(dentry, nd->flags);
+			status = d_revalidate(dentry, &nd->last, nd->flags);
 	} else {
 		dentry = __d_lookup(parent, &nd->last);
 		if (unlikely(!dentry))
 			return NULL;
-		status = d_revalidate(dentry, nd->flags);
+		status = d_revalidate(dentry, &nd->last, nd->flags);
 	}
 	if (unlikely(status <= 0)) {
 		if (!status)
@@ -1676,7 +1678,7 @@ static struct dentry *__lookup_slow(const struct qstr *name,
 	if (IS_ERR(dentry))
 		return dentry;
 	if (unlikely(!d_in_lookup(dentry))) {
-		int error = d_revalidate(dentry, flags);
+		int error = d_revalidate(dentry, name, flags);
 		if (unlikely(error <= 0)) {
 			if (!error) {
 				d_invalidate(dentry);
@@ -3421,7 +3423,7 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 		if (d_in_lookup(dentry))
 			break;
 
-		error = d_revalidate(dentry, nd->flags);
+		error = d_revalidate(dentry, &nd->last, nd->flags);
 		if (likely(error > 0))
 			break;
 		if (error)
diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 8f3112e71a6a..be162ef6a24e 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -1805,7 +1805,8 @@ __nfs_lookup_revalidate(struct dentry *dentry, unsigned int flags,
 	return ret;
 }
 
-static int nfs_lookup_revalidate(struct dentry *dentry, unsigned int flags)
+static int nfs_lookup_revalidate(struct dentry *dentry,
+				 const struct qstr *name, unsigned int flags)
 {
 	return __nfs_lookup_revalidate(dentry, flags, nfs_do_lookup_revalidate);
 }
@@ -1993,7 +1994,8 @@ void nfs_d_prune_case_insensitive_aliases(struct inode *inode)
 EXPORT_SYMBOL_GPL(nfs_d_prune_case_insensitive_aliases);
 
 #if IS_ENABLED(CONFIG_NFS_V4)
-static int nfs4_lookup_revalidate(struct dentry *, unsigned int);
+static int nfs4_lookup_revalidate(struct dentry *, const struct qstr *name,
+				  unsigned int);
 
 const struct dentry_operations nfs4_dentry_operations = {
 	.d_revalidate	= nfs4_lookup_revalidate,
@@ -2226,7 +2228,8 @@ nfs4_do_lookup_revalidate(struct inode *dir, struct dentry *dentry,
 	return nfs_do_lookup_revalidate(dir, dentry, flags);
 }
 
-static int nfs4_lookup_revalidate(struct dentry *dentry, unsigned int flags)
+static int nfs4_lookup_revalidate(struct dentry *dentry,
+				  const struct qstr *name, unsigned int flags)
 {
 	return __nfs_lookup_revalidate(dentry, flags,
 			nfs4_do_lookup_revalidate);
diff --git a/fs/ocfs2/dcache.c b/fs/ocfs2/dcache.c
index 04fc8344063a..277757f4fd2d 100644
--- a/fs/ocfs2/dcache.c
+++ b/fs/ocfs2/dcache.c
@@ -32,7 +32,9 @@ void ocfs2_dentry_attach_gen(struct dentry *dentry)
 }
 
 
-static int ocfs2_dentry_revalidate(struct dentry *dentry, unsigned int flags)
+static int ocfs2_dentry_revalidate(struct dentry *dentry,
+				   const struct qstr *name,
+				   unsigned int flags)
 {
 	struct inode *inode;
 	int ret = 0;    /* if all else fails, just return false */
diff --git a/fs/orangefs/dcache.c b/fs/orangefs/dcache.c
index 8bbe9486e3a6..435b88007809 100644
--- a/fs/orangefs/dcache.c
+++ b/fs/orangefs/dcache.c
@@ -94,7 +94,8 @@ static int orangefs_revalidate_lookup(struct dentry *dentry)
  *
  * Should return 1 if dentry can still be trusted, else 0.
  */
-static int orangefs_d_revalidate(struct dentry *dentry, unsigned int flags)
+static int orangefs_d_revalidate(struct dentry *dentry,
+				 const struct qstr *name, unsigned int flags)
 {
 	int ret;
 	unsigned long time = (unsigned long) dentry->d_fsdata;
diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index 5b069f1a1e44..1233e38d029d 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -77,7 +77,8 @@ static struct dentry *ovl_d_real(struct dentry *dentry,
 	return dentry;
 }
 
-static int ovl_revalidate_real(struct dentry *d, unsigned int flags, bool weak)
+static int ovl_revalidate_real(struct dentry *d, const struct qstr *name,
+			       unsigned int flags, bool weak)
 {
 	int ret = 1;
 
@@ -88,7 +89,7 @@ static int ovl_revalidate_real(struct dentry *d, unsigned int flags, bool weak)
 		if (d->d_flags & DCACHE_OP_WEAK_REVALIDATE)
 			ret =  d->d_op->d_weak_revalidate(d, flags);
 	} else if (d->d_flags & DCACHE_OP_REVALIDATE) {
-		ret = d->d_op->d_revalidate(d, flags);
+		ret = d->d_op->d_revalidate(d, name, flags);
 		if (!ret) {
 			if (!(flags & LOOKUP_RCU))
 				d_invalidate(d);
@@ -99,6 +100,7 @@ static int ovl_revalidate_real(struct dentry *d, unsigned int flags, bool weak)
 }
 
 static int ovl_dentry_revalidate_common(struct dentry *dentry,
+					const struct qstr *name,
 					unsigned int flags, bool weak)
 {
 	struct ovl_entry *oe = OVL_E(dentry);
@@ -114,22 +116,24 @@ static int ovl_dentry_revalidate_common(struct dentry *dentry,
 
 	upper = ovl_i_dentry_upper(inode);
 	if (upper)
-		ret = ovl_revalidate_real(upper, flags, weak);
+		ret = ovl_revalidate_real(upper, name, flags, weak);
 
 	for (i = 0; ret > 0 && i < ovl_numlower(oe); i++)
-		ret = ovl_revalidate_real(lowerstack[i].dentry, flags, weak);
+		ret = ovl_revalidate_real(lowerstack[i].dentry, name, flags, weak);
 
 	return ret;
 }
 
-static int ovl_dentry_revalidate(struct dentry *dentry, unsigned int flags)
+static int ovl_dentry_revalidate(struct dentry *dentry,
+				 const struct qstr *name, unsigned int flags)
 {
-	return ovl_dentry_revalidate_common(dentry, flags, false);
+	return ovl_dentry_revalidate_common(dentry, name, flags, false);
 }
 
-static int ovl_dentry_weak_revalidate(struct dentry *dentry, unsigned int flags)
+static int ovl_dentry_weak_revalidate(struct dentry *dentry,
+				      unsigned int flags)
 {
-	return ovl_dentry_revalidate_common(dentry, flags, true);
+	return ovl_dentry_revalidate_common(dentry, NULL, flags, true);
 }
 
 static const struct dentry_operations ovl_dentry_operations = {
diff --git a/fs/proc/base.c b/fs/proc/base.c
index 05452c3b9872..bdf212c52c8f 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -2005,7 +2005,8 @@ void pid_update_inode(struct task_struct *task, struct inode *inode)
  * performed a setuid(), etc.
  *
  */
-static int pid_revalidate(struct dentry *dentry, unsigned int flags)
+static int pid_revalidate(struct dentry *dentry, const struct qstr *name,
+			  unsigned int flags)
 {
 	struct inode *inode;
 	struct task_struct *task;
@@ -2138,7 +2139,8 @@ static int dname_to_vma_addr(struct dentry *dentry,
 	return 0;
 }
 
-static int map_files_d_revalidate(struct dentry *dentry, unsigned int flags)
+static int map_files_d_revalidate(struct dentry *dentry,
+				  const struct qstr *name, unsigned int flags)
 {
 	unsigned long vm_start, vm_end;
 	bool exact_vma_exists = false;
diff --git a/fs/proc/fd.c b/fs/proc/fd.c
index b3140deebbbf..efd604fe8d82 100644
--- a/fs/proc/fd.c
+++ b/fs/proc/fd.c
@@ -136,7 +136,8 @@ static void tid_fd_update_inode(struct task_struct *task, struct inode *inode,
 	security_task_to_inode(task, inode);
 }
 
-static int tid_fd_revalidate(struct dentry *dentry, unsigned int flags)
+static int tid_fd_revalidate(struct dentry *dentry, const struct qstr *name,
+			     unsigned int flags)
 {
 	struct task_struct *task;
 	struct inode *inode;
diff --git a/fs/proc/generic.c b/fs/proc/generic.c
index 42ae38ff6e7e..7cb15ab01a5a 100644
--- a/fs/proc/generic.c
+++ b/fs/proc/generic.c
@@ -216,7 +216,8 @@ void proc_free_inum(unsigned int inum)
 	ida_simple_remove(&proc_inum_ida, inum - PROC_DYNAMIC_FIRST);
 }
 
-static int proc_misc_d_revalidate(struct dentry *dentry, unsigned int flags)
+static int proc_misc_d_revalidate(struct dentry *dentry,
+				  const struct qstr *name, unsigned int flags)
 {
 	if (flags & LOOKUP_RCU)
 		return -ECHILD;
@@ -343,7 +344,8 @@ static const struct file_operations proc_dir_operations = {
 	.iterate_shared		= proc_readdir,
 };
 
-static int proc_net_d_revalidate(struct dentry *dentry, unsigned int flags)
+static int proc_net_d_revalidate(struct dentry *dentry,
+				 const struct qstr *name, unsigned int flags)
 {
 	return 0;
 }
diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index 5ea42653126e..d067ebff1c74 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -886,7 +886,8 @@ static const struct inode_operations proc_sys_dir_operations = {
 	.getattr	= proc_sys_getattr,
 };
 
-static int proc_sys_revalidate(struct dentry *dentry, unsigned int flags)
+static int proc_sys_revalidate(struct dentry *dentry, const struct qstr *name,
+			       unsigned int flags)
 {
 	if (flags & LOOKUP_RCU)
 		return -ECHILD;
diff --git a/fs/reiserfs/xattr.c b/fs/reiserfs/xattr.c
index 651027967159..2d09e4cdedd1 100644
--- a/fs/reiserfs/xattr.c
+++ b/fs/reiserfs/xattr.c
@@ -957,7 +957,8 @@ int reiserfs_permission(struct mnt_idmap *idmap, struct inode *inode,
 	return generic_permission(&nop_mnt_idmap, inode, mask);
 }
 
-static int xattr_hide_revalidate(struct dentry *dentry, unsigned int flags)
+static int xattr_hide_revalidate(struct dentry *dentry,
+				 const struct qstr *name, unsigned int flags)
 {
 	return -EPERM;
 }
diff --git a/fs/smb/client/dir.c b/fs/smb/client/dir.c
index 30b1e1bfd204..0ced1a98de9f 100644
--- a/fs/smb/client/dir.c
+++ b/fs/smb/client/dir.c
@@ -714,7 +714,8 @@ cifs_lookup(struct inode *parent_dir_inode, struct dentry *direntry,
 }
 
 static int
-cifs_d_revalidate(struct dentry *direntry, unsigned int flags)
+cifs_d_revalidate(struct dentry *direntry, const struct qstr *name,
+		  unsigned int flags)
 {
 	struct inode *inode;
 	int rc;
diff --git a/fs/vboxsf/dir.c b/fs/vboxsf/dir.c
index 075f15c43c78..81a03a7331a4 100644
--- a/fs/vboxsf/dir.c
+++ b/fs/vboxsf/dir.c
@@ -191,7 +191,9 @@ const struct file_operations vboxsf_dir_fops = {
  * This is called during name resolution/lookup to check if the @dentry in
  * the cache is still valid. the job is handled by vboxsf_inode_revalidate.
  */
-static int vboxsf_dentry_revalidate(struct dentry *dentry, unsigned int flags)
+static int vboxsf_dentry_revalidate(struct dentry *dentry,
+				    const struct qstr *name,
+				    unsigned int flags)
 {
 	if (flags & LOOKUP_RCU)
 		return -ECHILD;
diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index 6b351e009f59..9362e4ef0bad 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -126,7 +126,7 @@ enum dentry_d_lock_class
 };
 
 struct dentry_operations {
-	int (*d_revalidate)(struct dentry *, unsigned int);
+	int (*d_revalidate)(struct dentry *, const struct qstr *, unsigned int);
 	int (*d_weak_revalidate)(struct dentry *, unsigned int);
 	int (*d_hash)(const struct dentry *, struct qstr *);
 	int (*d_compare)(const struct dentry *,
diff --git a/include/linux/fscrypt.h b/include/linux/fscrypt.h
index c895b12737a1..d8c68a366a2b 100644
--- a/include/linux/fscrypt.h
+++ b/include/linux/fscrypt.h
@@ -353,7 +353,8 @@ int fscrypt_fname_disk_to_usr(const struct inode *inode,
 bool fscrypt_match_name(const struct fscrypt_name *fname,
 			const u8 *de_name, u32 de_name_len);
 u64 fscrypt_fname_siphash(const struct inode *dir, const struct qstr *name);
-int fscrypt_d_revalidate(struct dentry *dentry, unsigned int flags);
+int fscrypt_d_revalidate(struct dentry *dentry, const struct qstr *name,
+			 unsigned int flags);
 
 /* bio.c */
 bool fscrypt_decrypt_bio(struct bio *bio);
@@ -647,6 +648,7 @@ static inline u64 fscrypt_fname_siphash(const struct inode *dir,
 }
 
 static inline int fscrypt_d_revalidate(struct dentry *dentry,
+				       const struct qstr *name,
 				       unsigned int flags)
 {
 	return 1;
-- 
2.41.0

