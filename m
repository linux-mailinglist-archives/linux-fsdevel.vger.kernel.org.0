Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E1D7453DFC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Nov 2021 02:58:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232694AbhKQCB3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Nov 2021 21:01:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232661AbhKQCB1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Nov 2021 21:01:27 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09318C061766
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Nov 2021 17:58:29 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id m78-20020a252651000000b005c1f44d3c7bso1455927ybm.22
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Nov 2021 17:58:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:cc;
        bh=FvEzou+fI7ey46MBiHS/yrF3RR3FO5ooWBZC3muCnCM=;
        b=fE89ZoI2ZYzKSziFiLMNws3++j/kp3NVux5O76sSWOLEpdfkw5DeAGp0II6c/jN6y3
         XSbUqs6TMcS7V9/lAC8SIrM+SA1O/ccc6Ayo1Dm5wdtv729qxKKXrvnD2gg5cE64yjJT
         3ZdZn978PM/eickcU56r9mN0aeBCfajeFiDtrsRIYFGvI18r4lBYitVavFrtujufPzjY
         761pa7KOFeor+//Jct/9Pbhf0/DkjFmV4ixJCJvKVCifM45UFyNuKx8OcybRCYhLCIsD
         LkKAqJg6Ysxr5OEaSq/xwaFl/5TdQslSpnY5OQcbg3RkyDGJ75Fbzw889gI0sJQ3APoW
         fYHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:cc;
        bh=FvEzou+fI7ey46MBiHS/yrF3RR3FO5ooWBZC3muCnCM=;
        b=llWqgWXKnSPAM4CoyFBC2/PcFUPG7x1SBlHS7mJC8E9OSu0g2JASxJLqVrydvgHBuN
         IbC5LKJIv0PxtgXGyNNqi12PPijLHi9Q4bchvmK3x9cI+uY2feYhFTVoWZ7BJvht2z1E
         UGNxen9D9nV5wbOPigdy8b/NB8eU7GbFWG5KthlggvzHlPN6QrUT3LrqH5lYkURxlFph
         EkUB4x0rj6q0+IZs0v/XUqPgdOSP1iESSqxVjuZE6+F63R53enhLL+JpdjfnvybN9nxY
         AhNcw72Zo8VL0f7Kxfw2D7wmsVreDDbrOjL3zsgsx4UVOnkq0gx/42HTYkpWKjR/evWd
         t/4Q==
X-Gm-Message-State: AOAM531YxhY0ZVM2b7WE50IROArjwIhGoGlC/mRgextcbDdl1977FIgH
        tUvCAARbY6KwEL5TOczeQXKcxp0mzkd/
X-Google-Smtp-Source: ABdhPJx958FOvMsDxCg7SdPpAPGjvhNAoTV7iHce45B/z1rPP8zVDY6vjMBMIOS1BCLmiD9ieeJuwFQLZSJ+
X-Received: from dvandertop.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:2862])
 (user=dvander job=sendgmr) by 2002:a25:d283:: with SMTP id
 j125mr13664794ybg.476.1637114308279; Tue, 16 Nov 2021 17:58:28 -0800 (PST)
Date:   Wed, 17 Nov 2021 01:58:03 +0000
In-Reply-To: <20211117015806.2192263-1-dvander@google.com>
Message-Id: <20211117015806.2192263-2-dvander@google.com>
Mime-Version: 1.0
References: <20211117015806.2192263-1-dvander@google.com>
X-Mailer: git-send-email 2.34.0.rc1.387.gb447b232ab-goog
Subject: [PATCH v19 1/4] Add flags option to get xattr method paired to __vfs_getxattr
From:   David Anderson <dvander@google.com>
Cc:     David Anderson <dvander@google.com>,
        Mark Salyzyn <salyzyn@android.com>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        David Sterba <dsterba@suse.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Mike Marshall <hubcap@omnibond.com>,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        Stephen Smalley <sds@tycho.nsa.gov>,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, kernel-team@android.com,
        selinux@vger.kernel.org, paulmoore@microsoft.com,
        Luca.Boccassi@microsoft.com
Content-Type: text/plain; charset="UTF-8"
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add a flag option to get xattr method that could have a bit flag of
XATTR_NOSECURITY passed to it.  XATTR_NOSECURITY is generally then
set in the __vfs_getxattr path when called by security
infrastructure.

This handles the case of a union filesystem driver that is being
requested by the security layer to report back the xattr data.

For the use case where access is to be blocked by the security layer.

The path then could be security(dentry) ->
__vfs_getxattr(dentry...XATTR_NOSECURITY) ->
handler->get(dentry...XATTR_NOSECURITY) ->
__vfs_getxattr(lower_dentry...XATTR_NOSECURITY) ->
lower_handler->get(lower_dentry...XATTR_NOSECURITY)
which would report back through the chain data and success as
expected, the logging security layer at the top would have the
data to determine the access permissions and report back the target
context that was blocked.

Without the get handler flag, the path on a union filesystem would be
the errant security(dentry) -> __vfs_getxattr(dentry) ->
handler->get(dentry) -> vfs_getxattr(lower_dentry) -> nested ->
security(lower_dentry, log off) -> lower_handler->get(lower_dentry)
which would report back through the chain no data, and -EACCES.

For selinux for both cases, this would translate to a correctly
determined blocked access. In the first case with this change a correct avc
log would be reported, in the second legacy case an incorrect avc log
would be reported against an uninitialized u:object_r:unlabeled:s0
context making the logs cosmetically useless for audit2allow.

This patch series is inert and is the wide-spread addition of the
flags option for xattr functions, and a replacement of __vfs_getxattr
with __vfs_getxattr(...XATTR_NOSECURITY).

Signed-off-by: Mark Salyzyn <salyzyn@android.com>
Signed-off-by: David Anderson <dvander@google.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Acked-by: Jan Kara <jack@suse.cz>
Acked-by: Jeff Layton <jlayton@kernel.org>
Acked-by: David Sterba <dsterba@suse.com>
Acked-by: Darrick J. Wong <darrick.wong@oracle.com>
Acked-by: Mike Marshall <hubcap@omnibond.com>
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-unionfs@vger.kernel.org
Cc: Stephen Smalley <sds@tycho.nsa.gov>
Cc: linux-kernel@vger.kernel.org
Cc: linux-security-module@vger.kernel.org
Cc: kernel-team@android.com
Cc: selinux@vger.kernel.org
Cc: paulmoore@microsoft.com
Cc: Luca.Boccassi@microsoft.com

v19
- rebase

v18
- rebase

v17
- rebase with additional change to fs/ext4/xattr_hurd.c

v16
- rebase

v15
- revert back to v4 as struct xattr_gs_args was not acceptable by the
  wider audience. Incorporate any relevant fixes on the way.

v14 (new series):
- Reincorporate back into the bugfix series for overlayfs

v8:
- Documentation reported 'struct xattr_gs_flags' rather than
'struct xattr_gs_flags *args' as argument to get and set methods.

v7:
- missed spots in fs/9p/acl.c, fs/afs/xattr.c, fs/ecryptfs/crypto.c,
fs/ubifs/xattr.c, fs/xfs/libxfs/xfs_attr.c,
security/integrity/evm/evm_main.c and security/smack/smack_lsm.c.

v6:
- kernfs missed a spot

v5:
- introduce struct xattr_gs_args for get and set methods,
__vfs_getxattr and __vfs_setxattr functions.
- cover a missing spot in ext2.
- switch from snprintf to scnprintf for correctness.

v4:
- ifdef __KERNEL__ around XATTR_NOSECURITY to
keep it colocated in uapi headers.

v3:
- poor aim on ubifs not ubifs_xattr_get, but static xattr_get

v2:
- Missed a spot: ubifs, erofs and afs.

v1:
- Removed from an overlayfs patch set, and made independent.
  Expect this to be the basis of some security improvements.
---
 Documentation/filesystems/locking.rst |  2 +-
 fs/9p/acl.c                           |  3 +-
 fs/9p/xattr.c                         |  3 +-
 fs/afs/xattr.c                        | 10 +++----
 fs/attr.c                             |  2 +-
 fs/btrfs/xattr.c                      |  3 +-
 fs/ceph/xattr.c                       |  3 +-
 fs/cifs/xattr.c                       |  2 +-
 fs/ecryptfs/inode.c                   |  6 ++--
 fs/ecryptfs/mmap.c                    |  5 ++--
 fs/erofs/xattr.c                      |  3 +-
 fs/ext2/xattr_security.c              |  2 +-
 fs/ext2/xattr_trusted.c               |  2 +-
 fs/ext2/xattr_user.c                  |  2 +-
 fs/ext4/xattr_hurd.c                  |  2 +-
 fs/ext4/xattr_security.c              |  2 +-
 fs/ext4/xattr_trusted.c               |  2 +-
 fs/ext4/xattr_user.c                  |  2 +-
 fs/f2fs/xattr.c                       |  4 +--
 fs/fuse/xattr.c                       |  4 +--
 fs/gfs2/xattr.c                       |  3 +-
 fs/hfs/attr.c                         |  2 +-
 fs/hfsplus/xattr.c                    |  3 +-
 fs/hfsplus/xattr_security.c           |  3 +-
 fs/hfsplus/xattr_trusted.c            |  3 +-
 fs/hfsplus/xattr_user.c               |  3 +-
 fs/inode.c                            |  7 +++--
 fs/internal.h                         |  3 +-
 fs/jffs2/security.c                   |  3 +-
 fs/jffs2/xattr_trusted.c              |  3 +-
 fs/jffs2/xattr_user.c                 |  3 +-
 fs/jfs/xattr.c                        |  5 ++--
 fs/kernfs/inode.c                     |  3 +-
 fs/nfs/nfs4proc.c                     |  9 ++++--
 fs/ntfs3/xattr.c                      |  2 +-
 fs/ocfs2/xattr.c                      |  9 ++++--
 fs/open.c                             |  2 +-
 fs/orangefs/xattr.c                   |  3 +-
 fs/overlayfs/super.c                  |  8 +++--
 fs/posix_acl.c                        |  2 +-
 fs/reiserfs/xattr_security.c          |  3 +-
 fs/reiserfs/xattr_trusted.c           |  3 +-
 fs/reiserfs/xattr_user.c              |  3 +-
 fs/squashfs/xattr.c                   |  2 +-
 fs/ubifs/xattr.c                      |  3 +-
 fs/xattr.c                            | 42 ++++++++++++++-------------
 fs/xfs/xfs_xattr.c                    |  3 +-
 include/linux/lsm_hook_defs.h         |  3 +-
 include/linux/security.h              |  6 ++--
 include/linux/xattr.h                 |  6 ++--
 include/uapi/linux/xattr.h            |  7 +++--
 mm/shmem.c                            |  3 +-
 net/socket.c                          |  3 +-
 security/commoncap.c                  | 11 ++++---
 security/integrity/evm/evm_main.c     | 13 +++++----
 security/security.c                   |  5 ++--
 security/selinux/hooks.c              | 19 +++++++-----
 security/smack/smack_lsm.c            | 18 +++++++-----
 58 files changed, 178 insertions(+), 118 deletions(-)

diff --git a/Documentation/filesystems/locking.rst b/Documentation/filesystems/locking.rst
index d36fe79167b3..322466cbb650 100644
--- a/Documentation/filesystems/locking.rst
+++ b/Documentation/filesystems/locking.rst
@@ -130,7 +130,7 @@ prototypes::
 	bool (*list)(struct dentry *dentry);
 	int (*get)(const struct xattr_handler *handler, struct dentry *dentry,
 		   struct inode *inode, const char *name, void *buffer,
-		   size_t size);
+		   size_t size, int flags);
 	int (*set)(const struct xattr_handler *handler,
                    struct user_namespace *mnt_userns,
                    struct dentry *dentry, struct inode *inode, const char *name,
diff --git a/fs/9p/acl.c b/fs/9p/acl.c
index 4dac4a0dc5f4..66389aaa2385 100644
--- a/fs/9p/acl.c
+++ b/fs/9p/acl.c
@@ -210,7 +210,8 @@ int v9fs_acl_mode(struct inode *dir, umode_t *modep,
 
 static int v9fs_xattr_get_acl(const struct xattr_handler *handler,
 			      struct dentry *dentry, struct inode *inode,
-			      const char *name, void *buffer, size_t size)
+			      const char *name, void *buffer, size_t size,
+			      int flags)
 {
 	struct v9fs_session_info *v9ses;
 	struct posix_acl *acl;
diff --git a/fs/9p/xattr.c b/fs/9p/xattr.c
index a824441b95a2..213ca59b1c35 100644
--- a/fs/9p/xattr.c
+++ b/fs/9p/xattr.c
@@ -141,7 +141,8 @@ ssize_t v9fs_listxattr(struct dentry *dentry, char *buffer, size_t buffer_size)
 
 static int v9fs_xattr_handler_get(const struct xattr_handler *handler,
 				  struct dentry *dentry, struct inode *inode,
-				  const char *name, void *buffer, size_t size)
+				  const char *name, void *buffer, size_t size,
+				  int flags)
 {
 	const char *full_name = xattr_full_name(handler, name);
 
diff --git a/fs/afs/xattr.c b/fs/afs/xattr.c
index 7751b0b3f81d..172013d3e0dd 100644
--- a/fs/afs/xattr.c
+++ b/fs/afs/xattr.c
@@ -36,7 +36,7 @@ static const struct afs_operation_ops afs_fetch_acl_operation = {
 static int afs_xattr_get_acl(const struct xattr_handler *handler,
 			     struct dentry *dentry,
 			     struct inode *inode, const char *name,
-			     void *buffer, size_t size)
+			     void *buffer, size_t size, int flags)
 {
 	struct afs_operation *op;
 	struct afs_vnode *vnode = AFS_FS_I(inode);
@@ -138,7 +138,7 @@ static const struct afs_operation_ops yfs_fetch_opaque_acl_operation = {
 static int afs_xattr_get_yfs(const struct xattr_handler *handler,
 			     struct dentry *dentry,
 			     struct inode *inode, const char *name,
-			     void *buffer, size_t size)
+			     void *buffer, size_t size, int flags)
 {
 	struct afs_operation *op;
 	struct afs_vnode *vnode = AFS_FS_I(inode);
@@ -268,7 +268,7 @@ static const struct xattr_handler afs_xattr_yfs_handler = {
 static int afs_xattr_get_cell(const struct xattr_handler *handler,
 			      struct dentry *dentry,
 			      struct inode *inode, const char *name,
-			      void *buffer, size_t size)
+			      void *buffer, size_t size, int flags)
 {
 	struct afs_vnode *vnode = AFS_FS_I(inode);
 	struct afs_cell *cell = vnode->volume->cell;
@@ -295,7 +295,7 @@ static const struct xattr_handler afs_xattr_afs_cell_handler = {
 static int afs_xattr_get_fid(const struct xattr_handler *handler,
 			     struct dentry *dentry,
 			     struct inode *inode, const char *name,
-			     void *buffer, size_t size)
+			     void *buffer, size_t size, int flags)
 {
 	struct afs_vnode *vnode = AFS_FS_I(inode);
 	char text[16 + 1 + 24 + 1 + 8 + 1];
@@ -333,7 +333,7 @@ static const struct xattr_handler afs_xattr_afs_fid_handler = {
 static int afs_xattr_get_volume(const struct xattr_handler *handler,
 			      struct dentry *dentry,
 			      struct inode *inode, const char *name,
-			      void *buffer, size_t size)
+			      void *buffer, size_t size, int flags)
 {
 	struct afs_vnode *vnode = AFS_FS_I(inode);
 	const char *volname = vnode->volume->name;
diff --git a/fs/attr.c b/fs/attr.c
index 473d21b3a86d..caa6662cb14a 100644
--- a/fs/attr.c
+++ b/fs/attr.c
@@ -342,7 +342,7 @@ int notify_change(struct user_namespace *mnt_userns, struct dentry *dentry,
 		attr->ia_mtime = timestamp_truncate(attr->ia_mtime, inode);
 
 	if (ia_valid & ATTR_KILL_PRIV) {
-		error = security_inode_need_killpriv(dentry);
+		error = security_inode_need_killpriv(mnt_userns, dentry);
 		if (error < 0)
 			return error;
 		if (error == 0)
diff --git a/fs/btrfs/xattr.c b/fs/btrfs/xattr.c
index 2837b4c8424d..7d9f7a56e7c0 100644
--- a/fs/btrfs/xattr.c
+++ b/fs/btrfs/xattr.c
@@ -378,7 +378,8 @@ ssize_t btrfs_listxattr(struct dentry *dentry, char *buffer, size_t size)
 
 static int btrfs_xattr_handler_get(const struct xattr_handler *handler,
 				   struct dentry *unused, struct inode *inode,
-				   const char *name, void *buffer, size_t size)
+				   const char *name, void *buffer, size_t size,
+				   int flags)
 {
 	name = xattr_full_name(handler, name);
 	return btrfs_getxattr(inode, name, buffer, size);
diff --git a/fs/ceph/xattr.c b/fs/ceph/xattr.c
index fcf7dfdecf96..0f4971025387 100644
--- a/fs/ceph/xattr.c
+++ b/fs/ceph/xattr.c
@@ -1256,7 +1256,8 @@ int __ceph_setxattr(struct inode *inode, const char *name,
 
 static int ceph_get_xattr_handler(const struct xattr_handler *handler,
 				  struct dentry *dentry, struct inode *inode,
-				  const char *name, void *value, size_t size)
+				  const char *name, void *value, size_t size,
+				  int flags)
 {
 	if (!ceph_is_valid_xattr(name))
 		return -EOPNOTSUPP;
diff --git a/fs/cifs/xattr.c b/fs/cifs/xattr.c
index 7d8b72d67c80..e55bb399916f 100644
--- a/fs/cifs/xattr.c
+++ b/fs/cifs/xattr.c
@@ -279,7 +279,7 @@ static int cifs_creation_time_get(struct dentry *dentry, struct inode *inode,
 
 static int cifs_xattr_get(const struct xattr_handler *handler,
 			  struct dentry *dentry, struct inode *inode,
-			  const char *name, void *value, size_t size)
+			  const char *name, void *value, size_t size, int flags)
 {
 	ssize_t rc = -EOPNOTSUPP;
 	unsigned int xid;
diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
index 16d50dface59..f3a20a14dd8b 100644
--- a/fs/ecryptfs/inode.c
+++ b/fs/ecryptfs/inode.c
@@ -1050,7 +1050,8 @@ ecryptfs_getxattr_lower(struct dentry *lower_dentry, struct inode *lower_inode,
 		goto out;
 	}
 	inode_lock(lower_inode);
-	rc = __vfs_getxattr(lower_dentry, lower_inode, name, value, size);
+	rc = __vfs_getxattr(&init_user_ns, lower_dentry, lower_inode, name,
+			    value, size, XATTR_NOSECURITY);
 	inode_unlock(lower_inode);
 out:
 	return rc;
@@ -1156,7 +1157,8 @@ const struct inode_operations ecryptfs_main_iops = {
 
 static int ecryptfs_xattr_get(const struct xattr_handler *handler,
 			      struct dentry *dentry, struct inode *inode,
-			      const char *name, void *buffer, size_t size)
+			      const char *name, void *buffer, size_t size,
+			      int flags)
 {
 	return ecryptfs_getxattr(dentry, inode, name, buffer, size);
 }
diff --git a/fs/ecryptfs/mmap.c b/fs/ecryptfs/mmap.c
index 7d85e64ea62f..8635390f2bcb 100644
--- a/fs/ecryptfs/mmap.c
+++ b/fs/ecryptfs/mmap.c
@@ -422,8 +422,9 @@ static int ecryptfs_write_inode_size_to_xattr(struct inode *ecryptfs_inode)
 		goto out;
 	}
 	inode_lock(lower_inode);
-	size = __vfs_getxattr(lower_dentry, lower_inode, ECRYPTFS_XATTR_NAME,
-			      xattr_virt, PAGE_SIZE);
+	size = __vfs_getxattr(&init_user_ns, lower_dentry, lower_inode,
+			      ECRYPTFS_XATTR_NAME, xattr_virt, PAGE_SIZE,
+			      XATTR_NOSECURITY);
 	if (size < 0)
 		size = 8;
 	put_unaligned_be64(i_size_read(ecryptfs_inode), xattr_virt);
diff --git a/fs/erofs/xattr.c b/fs/erofs/xattr.c
index 01c581e93c5f..a900976b0f77 100644
--- a/fs/erofs/xattr.c
+++ b/fs/erofs/xattr.c
@@ -470,7 +470,8 @@ int erofs_getxattr(struct inode *inode, int index,
 
 static int erofs_xattr_generic_get(const struct xattr_handler *handler,
 				   struct dentry *unused, struct inode *inode,
-				   const char *name, void *buffer, size_t size)
+				   const char *name, void *buffer, size_t size,
+				   int flags)
 {
 	struct erofs_sb_info *const sbi = EROFS_I_SB(inode);
 
diff --git a/fs/ext2/xattr_security.c b/fs/ext2/xattr_security.c
index ebade1f52451..91c716ec140f 100644
--- a/fs/ext2/xattr_security.c
+++ b/fs/ext2/xattr_security.c
@@ -11,7 +11,7 @@
 static int
 ext2_xattr_security_get(const struct xattr_handler *handler,
 			struct dentry *unused, struct inode *inode,
-			const char *name, void *buffer, size_t size)
+			const char *name, void *buffer, size_t size, int flags)
 {
 	return ext2_xattr_get(inode, EXT2_XATTR_INDEX_SECURITY, name,
 			      buffer, size);
diff --git a/fs/ext2/xattr_trusted.c b/fs/ext2/xattr_trusted.c
index 18a87d5dd1ab..362f83e43c4c 100644
--- a/fs/ext2/xattr_trusted.c
+++ b/fs/ext2/xattr_trusted.c
@@ -18,7 +18,7 @@ ext2_xattr_trusted_list(struct dentry *dentry)
 static int
 ext2_xattr_trusted_get(const struct xattr_handler *handler,
 		       struct dentry *unused, struct inode *inode,
-		       const char *name, void *buffer, size_t size)
+		       const char *name, void *buffer, size_t size, int flags)
 {
 	return ext2_xattr_get(inode, EXT2_XATTR_INDEX_TRUSTED, name,
 			      buffer, size);
diff --git a/fs/ext2/xattr_user.c b/fs/ext2/xattr_user.c
index 58092449f8ff..37936d5979c8 100644
--- a/fs/ext2/xattr_user.c
+++ b/fs/ext2/xattr_user.c
@@ -20,7 +20,7 @@ ext2_xattr_user_list(struct dentry *dentry)
 static int
 ext2_xattr_user_get(const struct xattr_handler *handler,
 		    struct dentry *unused, struct inode *inode,
-		    const char *name, void *buffer, size_t size)
+		    const char *name, void *buffer, size_t size, int flags)
 {
 	if (!test_opt(inode->i_sb, XATTR_USER))
 		return -EOPNOTSUPP;
diff --git a/fs/ext4/xattr_hurd.c b/fs/ext4/xattr_hurd.c
index c78df5790377..7cce47e56a10 100644
--- a/fs/ext4/xattr_hurd.c
+++ b/fs/ext4/xattr_hurd.c
@@ -21,7 +21,7 @@ ext4_xattr_hurd_list(struct dentry *dentry)
 static int
 ext4_xattr_hurd_get(const struct xattr_handler *handler,
 		    struct dentry *unused, struct inode *inode,
-		    const char *name, void *buffer, size_t size)
+		    const char *name, void *buffer, size_t size, int flags)
 {
 	if (!test_opt(inode->i_sb, XATTR_USER))
 		return -EOPNOTSUPP;
diff --git a/fs/ext4/xattr_security.c b/fs/ext4/xattr_security.c
index 8213f66f7b2d..f85699f6ad17 100644
--- a/fs/ext4/xattr_security.c
+++ b/fs/ext4/xattr_security.c
@@ -15,7 +15,7 @@
 static int
 ext4_xattr_security_get(const struct xattr_handler *handler,
 			struct dentry *unused, struct inode *inode,
-			const char *name, void *buffer, size_t size)
+			const char *name, void *buffer, size_t size, int flags)
 {
 	return ext4_xattr_get(inode, EXT4_XATTR_INDEX_SECURITY,
 			      name, buffer, size);
diff --git a/fs/ext4/xattr_trusted.c b/fs/ext4/xattr_trusted.c
index 7c21ffb26d25..9b550a8a5c0b 100644
--- a/fs/ext4/xattr_trusted.c
+++ b/fs/ext4/xattr_trusted.c
@@ -22,7 +22,7 @@ ext4_xattr_trusted_list(struct dentry *dentry)
 static int
 ext4_xattr_trusted_get(const struct xattr_handler *handler,
 		       struct dentry *unused, struct inode *inode,
-		       const char *name, void *buffer, size_t size)
+		       const char *name, void *buffer, size_t size, int flags)
 {
 	return ext4_xattr_get(inode, EXT4_XATTR_INDEX_TRUSTED,
 			      name, buffer, size);
diff --git a/fs/ext4/xattr_user.c b/fs/ext4/xattr_user.c
index 2fe7ff0a479c..5483b158c5b5 100644
--- a/fs/ext4/xattr_user.c
+++ b/fs/ext4/xattr_user.c
@@ -21,7 +21,7 @@ ext4_xattr_user_list(struct dentry *dentry)
 static int
 ext4_xattr_user_get(const struct xattr_handler *handler,
 		    struct dentry *unused, struct inode *inode,
-		    const char *name, void *buffer, size_t size)
+		    const char *name, void *buffer, size_t size, int flags)
 {
 	if (!test_opt(inode->i_sb, XATTR_USER))
 		return -EOPNOTSUPP;
diff --git a/fs/f2fs/xattr.c b/fs/f2fs/xattr.c
index e348f33bcb2b..a73a3d0510f1 100644
--- a/fs/f2fs/xattr.c
+++ b/fs/f2fs/xattr.c
@@ -45,7 +45,7 @@ static void xattr_free(struct f2fs_sb_info *sbi, void *xattr_addr,
 
 static int f2fs_xattr_generic_get(const struct xattr_handler *handler,
 		struct dentry *unused, struct inode *inode,
-		const char *name, void *buffer, size_t size)
+		const char *name, void *buffer, size_t size, int flags)
 {
 	struct f2fs_sb_info *sbi = F2FS_SB(inode->i_sb);
 
@@ -101,7 +101,7 @@ static bool f2fs_xattr_trusted_list(struct dentry *dentry)
 
 static int f2fs_xattr_advise_get(const struct xattr_handler *handler,
 		struct dentry *unused, struct inode *inode,
-		const char *name, void *buffer, size_t size)
+		const char *name, void *buffer, size_t size, int flags)
 {
 	if (buffer)
 		*((char *)buffer) = F2FS_I(inode)->i_advise;
diff --git a/fs/fuse/xattr.c b/fs/fuse/xattr.c
index 0d3e7177fce0..d77d5844e6c2 100644
--- a/fs/fuse/xattr.c
+++ b/fs/fuse/xattr.c
@@ -180,7 +180,7 @@ int fuse_removexattr(struct inode *inode, const char *name)
 
 static int fuse_xattr_get(const struct xattr_handler *handler,
 			 struct dentry *dentry, struct inode *inode,
-			 const char *name, void *value, size_t size)
+			 const char *name, void *value, size_t size, int flags)
 {
 	if (fuse_is_bad(inode))
 		return -EIO;
@@ -210,7 +210,7 @@ static bool no_xattr_list(struct dentry *dentry)
 
 static int no_xattr_get(const struct xattr_handler *handler,
 			struct dentry *dentry, struct inode *inode,
-			const char *name, void *value, size_t size)
+			const char *name, void *value, size_t size, int flags)
 {
 	return -EOPNOTSUPP;
 }
diff --git a/fs/gfs2/xattr.c b/fs/gfs2/xattr.c
index 0c5650fe1fd1..d4e8fb14b18e 100644
--- a/fs/gfs2/xattr.c
+++ b/fs/gfs2/xattr.c
@@ -602,7 +602,8 @@ static int __gfs2_xattr_get(struct inode *inode, const char *name,
 
 static int gfs2_xattr_get(const struct xattr_handler *handler,
 			  struct dentry *unused, struct inode *inode,
-			  const char *name, void *buffer, size_t size)
+			  const char *name, void *buffer, size_t size,
+			  int flags)
 {
 	struct gfs2_inode *ip = GFS2_I(inode);
 	struct gfs2_holder gh;
diff --git a/fs/hfs/attr.c b/fs/hfs/attr.c
index 2bd54efaf416..c42385c33d2a 100644
--- a/fs/hfs/attr.c
+++ b/fs/hfs/attr.c
@@ -115,7 +115,7 @@ static ssize_t __hfs_getxattr(struct inode *inode, enum hfs_xattr_type type,
 
 static int hfs_xattr_get(const struct xattr_handler *handler,
 			 struct dentry *unused, struct inode *inode,
-			 const char *name, void *value, size_t size)
+			 const char *name, void *value, size_t size, int flags)
 {
 	return __hfs_getxattr(inode, handler->flags, value, size);
 }
diff --git a/fs/hfsplus/xattr.c b/fs/hfsplus/xattr.c
index e2855ceefd39..65e625aa4fa9 100644
--- a/fs/hfsplus/xattr.c
+++ b/fs/hfsplus/xattr.c
@@ -838,7 +838,8 @@ static int hfsplus_removexattr(struct inode *inode, const char *name)
 
 static int hfsplus_osx_getxattr(const struct xattr_handler *handler,
 				struct dentry *unused, struct inode *inode,
-				const char *name, void *buffer, size_t size)
+				const char *name, void *buffer, size_t size,
+				int flags)
 {
 	/*
 	 * Don't allow retrieving properly prefixed attributes
diff --git a/fs/hfsplus/xattr_security.c b/fs/hfsplus/xattr_security.c
index c1c7a16cbf21..1b28b83c201e 100644
--- a/fs/hfsplus/xattr_security.c
+++ b/fs/hfsplus/xattr_security.c
@@ -15,7 +15,8 @@
 
 static int hfsplus_security_getxattr(const struct xattr_handler *handler,
 				     struct dentry *unused, struct inode *inode,
-				     const char *name, void *buffer, size_t size)
+				     const char *name, void *buffer,
+				     size_t size, int flags)
 {
 	return hfsplus_getxattr(inode, name, buffer, size,
 				XATTR_SECURITY_PREFIX,
diff --git a/fs/hfsplus/xattr_trusted.c b/fs/hfsplus/xattr_trusted.c
index e150372ec564..7caeff6243d7 100644
--- a/fs/hfsplus/xattr_trusted.c
+++ b/fs/hfsplus/xattr_trusted.c
@@ -14,7 +14,8 @@
 
 static int hfsplus_trusted_getxattr(const struct xattr_handler *handler,
 				    struct dentry *unused, struct inode *inode,
-				    const char *name, void *buffer, size_t size)
+				    const char *name, void *buffer,
+				    size_t size, int flags)
 {
 	return hfsplus_getxattr(inode, name, buffer, size,
 				XATTR_TRUSTED_PREFIX,
diff --git a/fs/hfsplus/xattr_user.c b/fs/hfsplus/xattr_user.c
index a6b60b153916..ca74443eb123 100644
--- a/fs/hfsplus/xattr_user.c
+++ b/fs/hfsplus/xattr_user.c
@@ -14,7 +14,8 @@
 
 static int hfsplus_user_getxattr(const struct xattr_handler *handler,
 				 struct dentry *unused, struct inode *inode,
-				 const char *name, void *buffer, size_t size)
+				 const char *name, void *buffer, size_t size,
+				 int flags)
 {
 
 	return hfsplus_getxattr(inode, name, buffer, size,
diff --git a/fs/inode.c b/fs/inode.c
index 3eba0940ffcf..a8234909ca5a 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -1907,7 +1907,8 @@ EXPORT_SYMBOL(should_remove_suid);
  * response to write or truncate. Return 0 if nothing has to be changed.
  * Negative value on error (change should be denied).
  */
-int dentry_needs_remove_privs(struct dentry *dentry)
+int dentry_needs_remove_privs(struct user_namespace *mnt_userns,
+			      struct dentry *dentry)
 {
 	struct inode *inode = d_inode(dentry);
 	int mask = 0;
@@ -1917,7 +1918,7 @@ int dentry_needs_remove_privs(struct dentry *dentry)
 		return 0;
 
 	mask = should_remove_suid(dentry);
-	ret = security_inode_need_killpriv(dentry);
+	ret = security_inode_need_killpriv(mnt_userns, dentry);
 	if (ret < 0)
 		return ret;
 	if (ret)
@@ -1958,7 +1959,7 @@ int file_remove_privs(struct file *file)
 	if (IS_NOSEC(inode) || !S_ISREG(inode->i_mode))
 		return 0;
 
-	kill = dentry_needs_remove_privs(dentry);
+	kill = dentry_needs_remove_privs(file_mnt_user_ns(file), dentry);
 	if (kill < 0)
 		return kill;
 	if (kill)
diff --git a/fs/internal.h b/fs/internal.h
index 7979ff8d168c..2ed729447c4d 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -138,7 +138,8 @@ extern int vfs_open(const struct path *, struct file *);
  * inode.c
  */
 extern long prune_icache_sb(struct super_block *sb, struct shrink_control *sc);
-extern int dentry_needs_remove_privs(struct dentry *dentry);
+extern int dentry_needs_remove_privs(struct user_namespace *mnt_userns,
+				     struct dentry *dentry);
 
 /*
  * fs-writeback.c
diff --git a/fs/jffs2/security.c b/fs/jffs2/security.c
index aef5522551db..c443c4e47208 100644
--- a/fs/jffs2/security.c
+++ b/fs/jffs2/security.c
@@ -50,7 +50,8 @@ int jffs2_init_security(struct inode *inode, struct inode *dir,
 /* ---- XATTR Handler for "security.*" ----------------- */
 static int jffs2_security_getxattr(const struct xattr_handler *handler,
 				   struct dentry *unused, struct inode *inode,
-				   const char *name, void *buffer, size_t size)
+				   const char *name, void *buffer, size_t size,
+				   int flags)
 {
 	return do_jffs2_getxattr(inode, JFFS2_XPREFIX_SECURITY,
 				 name, buffer, size);
diff --git a/fs/jffs2/xattr_trusted.c b/fs/jffs2/xattr_trusted.c
index cc3f24883e7d..95ed9ce1eaaf 100644
--- a/fs/jffs2/xattr_trusted.c
+++ b/fs/jffs2/xattr_trusted.c
@@ -18,7 +18,8 @@
 
 static int jffs2_trusted_getxattr(const struct xattr_handler *handler,
 				  struct dentry *unused, struct inode *inode,
-				  const char *name, void *buffer, size_t size)
+				  const char *name, void *buffer, size_t size,
+				  int flags)
 {
 	return do_jffs2_getxattr(inode, JFFS2_XPREFIX_TRUSTED,
 				 name, buffer, size);
diff --git a/fs/jffs2/xattr_user.c b/fs/jffs2/xattr_user.c
index fb945977c013..418bb8d2758f 100644
--- a/fs/jffs2/xattr_user.c
+++ b/fs/jffs2/xattr_user.c
@@ -18,7 +18,8 @@
 
 static int jffs2_user_getxattr(const struct xattr_handler *handler,
 			       struct dentry *unused, struct inode *inode,
-			       const char *name, void *buffer, size_t size)
+			       const char *name, void *buffer, size_t size,
+			       int flags)
 {
 	return do_jffs2_getxattr(inode, JFFS2_XPREFIX_USER,
 				 name, buffer, size);
diff --git a/fs/jfs/xattr.c b/fs/jfs/xattr.c
index f9273f6901c8..8728df337090 100644
--- a/fs/jfs/xattr.c
+++ b/fs/jfs/xattr.c
@@ -925,7 +925,7 @@ static int __jfs_xattr_set(struct inode *inode, const char *name,
 
 static int jfs_xattr_get(const struct xattr_handler *handler,
 			 struct dentry *unused, struct inode *inode,
-			 const char *name, void *value, size_t size)
+			 const char *name, void *value, size_t size, int flags)
 {
 	name = xattr_full_name(handler, name);
 	return __jfs_getxattr(inode, name, value, size);
@@ -943,7 +943,8 @@ static int jfs_xattr_set(const struct xattr_handler *handler,
 
 static int jfs_xattr_get_os2(const struct xattr_handler *handler,
 			     struct dentry *unused, struct inode *inode,
-			     const char *name, void *value, size_t size)
+			     const char *name, void *value, size_t size,
+			     int flags)
 {
 	if (is_known_namespace(name))
 		return -EOPNOTSUPP;
diff --git a/fs/kernfs/inode.c b/fs/kernfs/inode.c
index c0eae1725435..d56210c657f0 100644
--- a/fs/kernfs/inode.c
+++ b/fs/kernfs/inode.c
@@ -313,7 +313,8 @@ int kernfs_xattr_set(struct kernfs_node *kn, const char *name,
 
 static int kernfs_vfs_xattr_get(const struct xattr_handler *handler,
 				struct dentry *unused, struct inode *inode,
-				const char *suffix, void *value, size_t size)
+				const char *suffix, void *value, size_t size,
+				int flags)
 {
 	const char *name = xattr_full_name(handler, suffix);
 	struct kernfs_node *kn = inode->i_private;
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index ee3bc79f6ca3..4e5f66623cda 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -7542,7 +7542,8 @@ static int nfs4_xattr_set_nfs4_acl(const struct xattr_handler *handler,
 
 static int nfs4_xattr_get_nfs4_acl(const struct xattr_handler *handler,
 				   struct dentry *unused, struct inode *inode,
-				   const char *key, void *buf, size_t buflen)
+				   const char *key, void *buf, size_t buflen,
+				   int flags)
 {
 	return nfs4_proc_get_acl(inode, buf, buflen);
 }
@@ -7568,7 +7569,8 @@ static int nfs4_xattr_set_nfs4_label(const struct xattr_handler *handler,
 
 static int nfs4_xattr_get_nfs4_label(const struct xattr_handler *handler,
 				     struct dentry *unused, struct inode *inode,
-				     const char *key, void *buf, size_t buflen)
+				     const char *key, void *buf, size_t buflen,
+				     int flags)
 {
 	if (security_ismaclabel(key))
 		return nfs4_get_security_label(inode, buf, buflen);
@@ -7646,7 +7648,8 @@ static int nfs4_xattr_set_nfs4_user(const struct xattr_handler *handler,
 
 static int nfs4_xattr_get_nfs4_user(const struct xattr_handler *handler,
 				    struct dentry *unused, struct inode *inode,
-				    const char *key, void *buf, size_t buflen)
+				    const char *key, void *buf, size_t buflen,
+				    int flags)
 {
 	struct nfs_access_entry cache;
 	ssize_t ret;
diff --git a/fs/ntfs3/xattr.c b/fs/ntfs3/xattr.c
index afd0ddad826f..fdc54f7573d5 100644
--- a/fs/ntfs3/xattr.c
+++ b/fs/ntfs3/xattr.c
@@ -710,7 +710,7 @@ ssize_t ntfs_listxattr(struct dentry *dentry, char *buffer, size_t size)
 
 static int ntfs_getxattr(const struct xattr_handler *handler, struct dentry *de,
 			 struct inode *inode, const char *name, void *buffer,
-			 size_t size)
+			 size_t size, int flags)
 {
 	int err;
 	struct ntfs_inode *ni = ntfs_i(inode);
diff --git a/fs/ocfs2/xattr.c b/fs/ocfs2/xattr.c
index dd784eb0cd7c..bd019ed56555 100644
--- a/fs/ocfs2/xattr.c
+++ b/fs/ocfs2/xattr.c
@@ -7240,7 +7240,8 @@ int ocfs2_init_security_and_acl(struct inode *dir,
  */
 static int ocfs2_xattr_security_get(const struct xattr_handler *handler,
 				    struct dentry *unused, struct inode *inode,
-				    const char *name, void *buffer, size_t size)
+				    const char *name, void *buffer, size_t size,
+				    int flags)
 {
 	return ocfs2_xattr_get(inode, OCFS2_XATTR_INDEX_SECURITY,
 			       name, buffer, size);
@@ -7313,7 +7314,8 @@ const struct xattr_handler ocfs2_xattr_security_handler = {
  */
 static int ocfs2_xattr_trusted_get(const struct xattr_handler *handler,
 				   struct dentry *unused, struct inode *inode,
-				   const char *name, void *buffer, size_t size)
+				   const char *name, void *buffer, size_t size,
+				   int flags)
 {
 	return ocfs2_xattr_get(inode, OCFS2_XATTR_INDEX_TRUSTED,
 			       name, buffer, size);
@@ -7340,7 +7342,8 @@ const struct xattr_handler ocfs2_xattr_trusted_handler = {
  */
 static int ocfs2_xattr_user_get(const struct xattr_handler *handler,
 				struct dentry *unused, struct inode *inode,
-				const char *name, void *buffer, size_t size)
+				const char *name, void *buffer, size_t size,
+				int flags)
 {
 	struct ocfs2_super *osb = OCFS2_SB(inode->i_sb);
 
diff --git a/fs/open.c b/fs/open.c
index f732fb94600c..0591189a169a 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -53,7 +53,7 @@ int do_truncate(struct user_namespace *mnt_userns, struct dentry *dentry,
 	}
 
 	/* Remove suid, sgid, and file capabilities on truncate too */
-	ret = dentry_needs_remove_privs(dentry);
+	ret = dentry_needs_remove_privs(mnt_userns, dentry);
 	if (ret < 0)
 		return ret;
 	if (ret)
diff --git a/fs/orangefs/xattr.c b/fs/orangefs/xattr.c
index 9a5b757fbd2f..2cc3bc61235b 100644
--- a/fs/orangefs/xattr.c
+++ b/fs/orangefs/xattr.c
@@ -542,7 +542,8 @@ static int orangefs_xattr_get_default(const struct xattr_handler *handler,
 				      struct inode *inode,
 				      const char *name,
 				      void *buffer,
-				      size_t size)
+				      size_t size,
+				      int flags)
 {
 	return orangefs_inode_getxattr(inode, name, buffer, size);
 
diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index 265181c110ae..359aa5772cb7 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -1004,7 +1004,7 @@ static unsigned int ovl_split_lowerdirs(char *str)
 static int __maybe_unused
 ovl_posix_acl_xattr_get(const struct xattr_handler *handler,
 			struct dentry *dentry, struct inode *inode,
-			const char *name, void *buffer, size_t size)
+			const char *name, void *buffer, size_t size, int flags)
 {
 	return ovl_xattr_get(dentry, inode, handler->name, buffer, size);
 }
@@ -1067,7 +1067,8 @@ ovl_posix_acl_xattr_set(const struct xattr_handler *handler,
 
 static int ovl_own_xattr_get(const struct xattr_handler *handler,
 			     struct dentry *dentry, struct inode *inode,
-			     const char *name, void *buffer, size_t size)
+			     const char *name, void *buffer, size_t size,
+			     int flags)
 {
 	return -EOPNOTSUPP;
 }
@@ -1083,7 +1084,8 @@ static int ovl_own_xattr_set(const struct xattr_handler *handler,
 
 static int ovl_other_xattr_get(const struct xattr_handler *handler,
 			       struct dentry *dentry, struct inode *inode,
-			       const char *name, void *buffer, size_t size)
+			       const char *name, void *buffer, size_t size,
+			       int flags)
 {
 	return ovl_xattr_get(dentry, inode, name, buffer, size);
 }
diff --git a/fs/posix_acl.c b/fs/posix_acl.c
index 9323a854a60a..e6cd6065ddd0 100644
--- a/fs/posix_acl.c
+++ b/fs/posix_acl.c
@@ -887,7 +887,7 @@ EXPORT_SYMBOL (posix_acl_to_xattr);
 static int
 posix_acl_xattr_get(const struct xattr_handler *handler,
 		    struct dentry *unused, struct inode *inode,
-		    const char *name, void *value, size_t size)
+		    const char *name, void *value, size_t size, int flags)
 {
 	struct posix_acl *acl;
 	int error;
diff --git a/fs/reiserfs/xattr_security.c b/fs/reiserfs/xattr_security.c
index 8965c8e5e172..1fd1359a98ba 100644
--- a/fs/reiserfs/xattr_security.c
+++ b/fs/reiserfs/xattr_security.c
@@ -11,7 +11,8 @@
 
 static int
 security_get(const struct xattr_handler *handler, struct dentry *unused,
-	     struct inode *inode, const char *name, void *buffer, size_t size)
+	     struct inode *inode, const char *name, void *buffer, size_t size,
+	     int flags)
 {
 	if (IS_PRIVATE(inode))
 		return -EPERM;
diff --git a/fs/reiserfs/xattr_trusted.c b/fs/reiserfs/xattr_trusted.c
index d853cea2afcd..f54b848e9504 100644
--- a/fs/reiserfs/xattr_trusted.c
+++ b/fs/reiserfs/xattr_trusted.c
@@ -10,7 +10,8 @@
 
 static int
 trusted_get(const struct xattr_handler *handler, struct dentry *unused,
-	    struct inode *inode, const char *name, void *buffer, size_t size)
+	    struct inode *inode, const char *name, void *buffer, size_t size,
+	    int flags)
 {
 	if (!capable(CAP_SYS_ADMIN) || IS_PRIVATE(inode))
 		return -EPERM;
diff --git a/fs/reiserfs/xattr_user.c b/fs/reiserfs/xattr_user.c
index 65d9cd10a5ea..ddd98cdab24d 100644
--- a/fs/reiserfs/xattr_user.c
+++ b/fs/reiserfs/xattr_user.c
@@ -9,7 +9,8 @@
 
 static int
 user_get(const struct xattr_handler *handler, struct dentry *unused,
-	 struct inode *inode, const char *name, void *buffer, size_t size)
+	 struct inode *inode, const char *name, void *buffer, size_t size,
+	 int flags)
 {
 	if (!reiserfs_xattrs_user(inode->i_sb))
 		return -EOPNOTSUPP;
diff --git a/fs/squashfs/xattr.c b/fs/squashfs/xattr.c
index e1e3f3dd5a06..d8d58c990652 100644
--- a/fs/squashfs/xattr.c
+++ b/fs/squashfs/xattr.c
@@ -204,7 +204,7 @@ static int squashfs_xattr_handler_get(const struct xattr_handler *handler,
 				      struct dentry *unused,
 				      struct inode *inode,
 				      const char *name,
-				      void *buffer, size_t size)
+				      void *buffer, size_t size, int flags)
 {
 	return squashfs_xattr_get(inode, handler->flags, name,
 		buffer, size);
diff --git a/fs/ubifs/xattr.c b/fs/ubifs/xattr.c
index e4f193eae4b2..681663f5bfa1 100644
--- a/fs/ubifs/xattr.c
+++ b/fs/ubifs/xattr.c
@@ -689,7 +689,8 @@ int ubifs_init_security(struct inode *dentry, struct inode *inode,
 
 static int xattr_get(const struct xattr_handler *handler,
 			   struct dentry *dentry, struct inode *inode,
-			   const char *name, void *buffer, size_t size)
+			   const char *name, void *buffer, size_t size,
+			   int flags)
 {
 	dbg_gen("xattr '%s', ino %lu ('%pd'), buf size %zd", name,
 		inode->i_ino, dentry, size);
diff --git a/fs/xattr.c b/fs/xattr.c
index 5c8c5175b385..4c36ddd6ac3c 100644
--- a/fs/xattr.c
+++ b/fs/xattr.c
@@ -369,7 +369,7 @@ vfs_getxattr_alloc(struct user_namespace *mnt_userns, struct dentry *dentry,
 		return PTR_ERR(handler);
 	if (!handler->get)
 		return -EOPNOTSUPP;
-	error = handler->get(handler, dentry, inode, name, NULL, 0);
+	error = handler->get(handler, dentry, inode, name, NULL, 0, 0);
 	if (error < 0)
 		return error;
 
@@ -380,33 +380,22 @@ vfs_getxattr_alloc(struct user_namespace *mnt_userns, struct dentry *dentry,
 		memset(value, 0, error + 1);
 	}
 
-	error = handler->get(handler, dentry, inode, name, value, error);
+	error = handler->get(handler, dentry, inode, name, value, error, 0);
 	*xattr_value = value;
 	return error;
 }
 
 ssize_t
-__vfs_getxattr(struct dentry *dentry, struct inode *inode, const char *name,
-	       void *value, size_t size)
+__vfs_getxattr(struct user_namespace *mnt_userns, struct dentry *dentry,
+	       struct inode *inode, const char *name, void *value,
+	       size_t size, int flags)
 {
 	const struct xattr_handler *handler;
-
-	handler = xattr_resolve_name(inode, &name);
-	if (IS_ERR(handler))
-		return PTR_ERR(handler);
-	if (!handler->get)
-		return -EOPNOTSUPP;
-	return handler->get(handler, dentry, inode, name, value, size);
-}
-EXPORT_SYMBOL(__vfs_getxattr);
-
-ssize_t
-vfs_getxattr(struct user_namespace *mnt_userns, struct dentry *dentry,
-	     const char *name, void *value, size_t size)
-{
-	struct inode *inode = dentry->d_inode;
 	int error;
 
+	if (flags & XATTR_NOSECURITY)
+		goto nolsm;
+
 	error = xattr_permission(mnt_userns, inode, name, MAY_READ);
 	if (error)
 		return error;
@@ -429,7 +418,20 @@ vfs_getxattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 		return ret;
 	}
 nolsm:
-	return __vfs_getxattr(dentry, inode, name, value, size);
+	handler = xattr_resolve_name(inode, &name);
+	if (IS_ERR(handler))
+		return PTR_ERR(handler);
+	if (!handler->get)
+		return -EOPNOTSUPP;
+	return handler->get(handler, dentry, inode, name, value, size, flags);
+}
+EXPORT_SYMBOL(__vfs_getxattr);
+
+ssize_t
+vfs_getxattr(struct user_namespace *mnt_userns, struct dentry *dentry,
+	     const char *name, void *value, size_t size)
+{
+	return __vfs_getxattr(mnt_userns, dentry, dentry->d_inode, name, value, size, 0);
 }
 EXPORT_SYMBOL_GPL(vfs_getxattr);
 
diff --git a/fs/xfs/xfs_xattr.c b/fs/xfs/xfs_xattr.c
index 0d050f8829ef..296b494e67c6 100644
--- a/fs/xfs/xfs_xattr.c
+++ b/fs/xfs/xfs_xattr.c
@@ -21,7 +21,8 @@
 
 static int
 xfs_xattr_get(const struct xattr_handler *handler, struct dentry *unused,
-		struct inode *inode, const char *name, void *value, size_t size)
+		struct inode *inode, const char *name, void *value, size_t size,
+		int flags)
 {
 	struct xfs_da_args	args = {
 		.dp		= XFS_I(inode),
diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index df8de62f4710..999375766635 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -147,7 +147,8 @@ LSM_HOOK(int, 0, inode_getxattr, struct dentry *dentry, const char *name)
 LSM_HOOK(int, 0, inode_listxattr, struct dentry *dentry)
 LSM_HOOK(int, 0, inode_removexattr, struct user_namespace *mnt_userns,
 	 struct dentry *dentry, const char *name)
-LSM_HOOK(int, 0, inode_need_killpriv, struct dentry *dentry)
+LSM_HOOK(int, 0, inode_need_killpriv, struct user_namespace *mnt_userns,
+	 struct dentry *dentry)
 LSM_HOOK(int, 0, inode_killpriv, struct user_namespace *mnt_userns,
 	 struct dentry *dentry)
 LSM_HOOK(int, -EOPNOTSUPP, inode_getsecurity, struct user_namespace *mnt_userns,
diff --git a/include/linux/security.h b/include/linux/security.h
index bbf44a466832..c48992c71295 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -150,7 +150,8 @@ int cap_inode_setxattr(struct dentry *dentry, const char *name,
 		       const void *value, size_t size, int flags);
 int cap_inode_removexattr(struct user_namespace *mnt_userns,
 			  struct dentry *dentry, const char *name);
-int cap_inode_need_killpriv(struct dentry *dentry);
+int cap_inode_need_killpriv(struct user_namespace *mnt_userns,
+			    struct dentry *dentry);
 int cap_inode_killpriv(struct user_namespace *mnt_userns,
 		       struct dentry *dentry);
 int cap_inode_getsecurity(struct user_namespace *mnt_userns,
@@ -364,7 +365,8 @@ int security_inode_getxattr(struct dentry *dentry, const char *name);
 int security_inode_listxattr(struct dentry *dentry);
 int security_inode_removexattr(struct user_namespace *mnt_userns,
 			       struct dentry *dentry, const char *name);
-int security_inode_need_killpriv(struct dentry *dentry);
+int security_inode_need_killpriv(struct user_namespace *mnt_userns,
+				 struct dentry *dentry);
 int security_inode_killpriv(struct user_namespace *mnt_userns,
 			    struct dentry *dentry);
 int security_inode_getsecurity(struct user_namespace *mnt_userns,
diff --git a/include/linux/xattr.h b/include/linux/xattr.h
index 4c379d23ec6e..663a04ae6223 100644
--- a/include/linux/xattr.h
+++ b/include/linux/xattr.h
@@ -34,7 +34,7 @@ struct xattr_handler {
 	bool (*list)(struct dentry *dentry);
 	int (*get)(const struct xattr_handler *, struct dentry *dentry,
 		   struct inode *inode, const char *name, void *buffer,
-		   size_t size);
+		   size_t size, int flags);
 	int (*set)(const struct xattr_handler *,
 		   struct user_namespace *mnt_userns, struct dentry *dentry,
 		   struct inode *inode, const char *name, const void *buffer,
@@ -49,7 +49,9 @@ struct xattr {
 	size_t value_len;
 };
 
-ssize_t __vfs_getxattr(struct dentry *, struct inode *, const char *, void *, size_t);
+ssize_t __vfs_getxattr(struct user_namespace *mnt_userns, struct dentry *dentry,
+		       struct inode *inode, const char *name, void *buffer,
+		       size_t size, int flags);
 ssize_t vfs_getxattr(struct user_namespace *, struct dentry *, const char *,
 		     void *, size_t);
 ssize_t vfs_listxattr(struct dentry *d, char *list, size_t size);
diff --git a/include/uapi/linux/xattr.h b/include/uapi/linux/xattr.h
index 9463db2dfa9d..d22191a3cf09 100644
--- a/include/uapi/linux/xattr.h
+++ b/include/uapi/linux/xattr.h
@@ -18,8 +18,11 @@
 #if __UAPI_DEF_XATTR
 #define __USE_KERNEL_XATTR_DEFS
 
-#define XATTR_CREATE	0x1	/* set value, fail if attr already exists */
-#define XATTR_REPLACE	0x2	/* set value, fail if attr does not exist */
+#define XATTR_CREATE	 0x1	/* set value, fail if attr already exists */
+#define XATTR_REPLACE	 0x2	/* set value, fail if attr does not exist */
+#ifdef __KERNEL__ /* following is kernel internal, colocated for maintenance */
+#define XATTR_NOSECURITY 0x4	/* get value, do not involve security check */
+#endif
 #endif
 
 /* Namespaces */
diff --git a/mm/shmem.c b/mm/shmem.c
index dc038ce78700..ece9a84c7701 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -3152,7 +3152,8 @@ static int shmem_initxattrs(struct inode *inode,
 
 static int shmem_xattr_handler_get(const struct xattr_handler *handler,
 				   struct dentry *unused, struct inode *inode,
-				   const char *name, void *buffer, size_t size)
+				   const char *name, void *buffer, size_t size,
+				   int flags)
 {
 	struct shmem_inode_info *info = SHMEM_I(inode);
 
diff --git a/net/socket.c b/net/socket.c
index 7f64a6eccf63..8704bbf55eda 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -364,7 +364,8 @@ static const struct dentry_operations sockfs_dentry_operations = {
 
 static int sockfs_xattr_get(const struct xattr_handler *handler,
 			    struct dentry *dentry, struct inode *inode,
-			    const char *suffix, void *value, size_t size)
+			    const char *suffix, void *value, size_t size,
+			    int flags)
 {
 	if (value) {
 		if (dentry->d_name.len + 1 > size)
diff --git a/security/commoncap.c b/security/commoncap.c
index 3f810d37b71b..05a5bc2c0db9 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -292,12 +292,14 @@ int cap_capset(struct cred *new,
  * Return: 1 if security.capability has a value, meaning inode_killpriv()
  * is required, 0 otherwise, meaning inode_killpriv() is not required.
  */
-int cap_inode_need_killpriv(struct dentry *dentry)
+int cap_inode_need_killpriv(struct user_namespace *mnt_userns,
+			    struct dentry *dentry)
 {
 	struct inode *inode = d_backing_inode(dentry);
 	int error;
 
-	error = __vfs_getxattr(dentry, inode, XATTR_NAME_CAPS, NULL, 0);
+	error = __vfs_getxattr(mnt_userns, dentry, inode, XATTR_NAME_CAPS,
+			       NULL, 0, XATTR_NOSECURITY);
 	return error > 0;
 }
 
@@ -660,8 +662,9 @@ int get_vfs_caps_from_disk(struct user_namespace *mnt_userns,
 		return -ENODATA;
 
 	fs_ns = inode->i_sb->s_user_ns;
-	size = __vfs_getxattr((struct dentry *)dentry, inode,
-			      XATTR_NAME_CAPS, &data, XATTR_CAPS_SZ);
+	size = __vfs_getxattr(mnt_userns, (struct dentry *)dentry, inode,
+			      XATTR_NAME_CAPS, &data, XATTR_CAPS_SZ,
+			      XATTR_NOSECURITY);
 	if (size == -ENODATA || size == -EOPNOTSUPP)
 		/* no data, that's ok */
 		return -ENODATA;
diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
index 08f907382c61..e8335fb04c7a 100644
--- a/security/integrity/evm/evm_main.c
+++ b/security/integrity/evm/evm_main.c
@@ -145,7 +145,8 @@ static int evm_find_protected_xattrs(struct dentry *dentry)
 		return -EOPNOTSUPP;
 
 	list_for_each_entry_lockless(xattr, &evm_config_xattrnames, list) {
-		error = __vfs_getxattr(dentry, inode, xattr->name, NULL, 0);
+		error = __vfs_getxattr(&init_user_ns, dentry, inode,
+				       xattr->name, NULL, 0, XATTR_NOSECURITY);
 		if (error < 0) {
 			if (error == -ENODATA)
 				continue;
@@ -343,8 +344,9 @@ int evm_read_protected_xattrs(struct dentry *dentry, u8 *buffer,
 	int rc, size, total_size = 0;
 
 	list_for_each_entry_lockless(xattr, &evm_config_xattrnames, list) {
-		rc = __vfs_getxattr(dentry, d_backing_inode(dentry),
-				    xattr->name, NULL, 0);
+		rc = __vfs_getxattr(&init_user_ns, dentry,
+				    d_backing_inode(dentry), xattr->name, NULL,
+				    0, XATTR_NOSECURITY);
 		if (rc < 0 && rc == -ENODATA)
 			continue;
 		else if (rc < 0)
@@ -372,10 +374,11 @@ int evm_read_protected_xattrs(struct dentry *dentry, u8 *buffer,
 		case 'v':
 			size = rc;
 			if (buffer) {
-				rc = __vfs_getxattr(dentry,
+				rc = __vfs_getxattr(&init_user_ns, dentry,
 					d_backing_inode(dentry), xattr->name,
 					buffer + total_size,
-					buffer_size - total_size);
+					buffer_size - total_size,
+					XATTR_NOSECURITY);
 				if (rc < 0)
 					return rc;
 			}
diff --git a/security/security.c b/security/security.c
index c88167a414b4..cc75b37dedc0 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1404,9 +1404,10 @@ int security_inode_removexattr(struct user_namespace *mnt_userns,
 	return evm_inode_removexattr(mnt_userns, dentry, name);
 }
 
-int security_inode_need_killpriv(struct dentry *dentry)
+int security_inode_need_killpriv(struct user_namespace *mnt_userns,
+				 struct dentry *dentry)
 {
-	return call_int_hook(inode_need_killpriv, 0, dentry);
+	return call_int_hook(inode_need_killpriv, 0, mnt_userns, dentry);
 }
 
 int security_inode_killpriv(struct user_namespace *mnt_userns,
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 62d30c0a30c2..84c12072e38a 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -490,7 +490,7 @@ static int selinux_is_sblabel_mnt(struct super_block *sb)
 	}
 }
 
-static int sb_check_xattr_support(struct super_block *sb)
+static int sb_check_xattr_support(struct user_namespace *mnt_userns, struct super_block *sb)
 {
 	struct superblock_security_struct *sbsec = sb->s_security;
 	struct dentry *root = sb->s_root;
@@ -511,7 +511,8 @@ static int sb_check_xattr_support(struct super_block *sb)
 		goto fallback;
 	}
 
-	rc = __vfs_getxattr(root, root_inode, XATTR_NAME_SELINUX, NULL, 0);
+	rc = __vfs_getxattr(mnt_userns, root, root_inode, XATTR_NAME_SELINUX, NULL, 0,
+			    XATTR_NOSECURITY);
 	if (rc < 0 && rc != -ENODATA) {
 		if (rc == -EOPNOTSUPP) {
 			pr_warn("SELinux: (dev %s, type %s) has no security xattr handler\n",
@@ -547,7 +548,7 @@ static int sb_finish_set_opts(struct super_block *sb)
 	int rc = 0;
 
 	if (sbsec->behavior == SECURITY_FS_USE_XATTR) {
-		rc = sb_check_xattr_support(sb);
+		rc = sb_check_xattr_support(sb->s_user_ns, sb);
 		if (rc)
 			return rc;
 	}
@@ -1371,12 +1372,15 @@ static int inode_doinit_use_xattr(struct inode *inode, struct dentry *dentry,
 		return -ENOMEM;
 
 	context[len] = '\0';
-	rc = __vfs_getxattr(dentry, inode, XATTR_NAME_SELINUX, context, len);
+	rc = __vfs_getxattr(&init_user_ns, dentry, inode, XATTR_NAME_SELINUX,
+			    context, len, XATTR_NOSECURITY);
 	if (rc == -ERANGE) {
 		kfree(context);
 
 		/* Need a larger buffer.  Query for the right size. */
-		rc = __vfs_getxattr(dentry, inode, XATTR_NAME_SELINUX, NULL, 0);
+		rc = __vfs_getxattr(&init_user_ns, dentry, inode,
+				    XATTR_NAME_SELINUX, NULL, 0,
+				    XATTR_NOSECURITY);
 		if (rc < 0)
 			return rc;
 
@@ -1386,8 +1390,9 @@ static int inode_doinit_use_xattr(struct inode *inode, struct dentry *dentry,
 			return -ENOMEM;
 
 		context[len] = '\0';
-		rc = __vfs_getxattr(dentry, inode, XATTR_NAME_SELINUX,
-				    context, len);
+		rc = __vfs_getxattr(&init_user_ns, dentry, inode,
+				    XATTR_NAME_SELINUX, context, len,
+				    XATTR_NOSECURITY);
 	}
 	if (rc < 0) {
 		kfree(context);
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index efd35b07c7f8..5ea91eae1054 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -277,8 +277,9 @@ static int smk_bu_credfile(const struct cred *cred, struct file *file,
  * Returns a pointer to the master list entry for the Smack label,
  * NULL if there was no label to fetch, or an error code.
  */
-static struct smack_known *smk_fetch(const char *name, struct inode *ip,
-					struct dentry *dp)
+static struct smack_known *smk_fetch(struct user_namespace *mnt_userns,
+				     const char *name, struct inode *ip,
+				     struct dentry *dp)
 {
 	int rc;
 	char *buffer;
@@ -291,7 +292,8 @@ static struct smack_known *smk_fetch(const char *name, struct inode *ip,
 	if (buffer == NULL)
 		return ERR_PTR(-ENOMEM);
 
-	rc = __vfs_getxattr(dp, ip, name, buffer, SMK_LONGLABEL);
+	rc = __vfs_getxattr(mnt_userns, dp, ip, name, buffer, SMK_LONGLABEL,
+			    XATTR_NOSECURITY);
 	if (rc < 0)
 		skp = ERR_PTR(rc);
 	else if (rc == 0)
@@ -3414,7 +3416,7 @@ static void smack_d_instantiate(struct dentry *opt_dentry, struct inode *inode)
 		 * Get the dentry for xattr.
 		 */
 		dp = dget(opt_dentry);
-		skp = smk_fetch(XATTR_NAME_SMACK, inode, dp);
+		skp = smk_fetch(&init_user_ns, XATTR_NAME_SMACK, inode, dp);
 		if (!IS_ERR_OR_NULL(skp))
 			final = skp;
 
@@ -3438,9 +3440,9 @@ static void smack_d_instantiate(struct dentry *opt_dentry, struct inode *inode)
 					TRANS_TRUE, TRANS_TRUE_SIZE,
 					0);
 			} else {
-				rc = __vfs_getxattr(dp, inode,
+				rc = __vfs_getxattr(&init_user_ns, dp, inode,
 					XATTR_NAME_SMACKTRANSMUTE, trattr,
-					TRANS_TRUE_SIZE);
+					TRANS_TRUE_SIZE, XATTR_NOSECURITY);
 				if (rc >= 0 && strncmp(trattr, TRANS_TRUE,
 						       TRANS_TRUE_SIZE) != 0)
 					rc = -EINVAL;
@@ -3451,13 +3453,13 @@ static void smack_d_instantiate(struct dentry *opt_dentry, struct inode *inode)
 		/*
 		 * Don't let the exec or mmap label be "*" or "@".
 		 */
-		skp = smk_fetch(XATTR_NAME_SMACKEXEC, inode, dp);
+		skp = smk_fetch(&init_user_ns, XATTR_NAME_SMACKEXEC, inode, dp);
 		if (IS_ERR(skp) || skp == &smack_known_star ||
 		    skp == &smack_known_web)
 			skp = NULL;
 		isp->smk_task = skp;
 
-		skp = smk_fetch(XATTR_NAME_SMACKMMAP, inode, dp);
+		skp = smk_fetch(&init_user_ns, XATTR_NAME_SMACKMMAP, inode, dp);
 		if (IS_ERR(skp) || skp == &smack_known_star ||
 		    skp == &smack_known_web)
 			skp = NULL;
-- 
2.34.0.rc1.387.gb447b232ab-goog

