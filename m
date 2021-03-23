Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E86234646F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Mar 2021 17:07:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232984AbhCWQG6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Mar 2021 12:06:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:38944 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233053AbhCWQGg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Mar 2021 12:06:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616515595;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=dX/ayVfh5rEV5Yovv43n14UWOPJP+O8wg+HRW8qFYCA=;
        b=SZO9gW9jAa+CYi+l0I5S7zkAGdRNPnjAiwLQQ9fEEXDoRFmyhRvXRrWwk7gq3k/RFH/xl4
        6WclvYtsMNhVoksZh5zffFhgeEAaLhuHY1PqoMre3MQbPfpep2biB3+nGOkCAFPmEKbsrn
        IuYZAsNpEfUPSpOLw75lu5+yBcli7S4=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-554-HDW2WWVyP_-J7vvqD4oCMQ-1; Tue, 23 Mar 2021 12:06:33 -0400
X-MC-Unique: HDW2WWVyP_-J7vvqD4oCMQ-1
Received: by mail-ed1-f72.google.com with SMTP id i19so1178141edy.18
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Mar 2021 09:06:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dX/ayVfh5rEV5Yovv43n14UWOPJP+O8wg+HRW8qFYCA=;
        b=RrWfu9xm9G4TGMJ/t94fzVHig6xaBh5/hc5E+XQjnjfz/zESj1jiIMAeBCyJAcd7dV
         3ErukQ+L3F/5/KOJCaQDfJThWz7bjfoE/cJYexjAdiRej+TsvvuvElriwEaAMHfeGNaP
         blNWuGT+UR23YngsIGZn++lvxsJm3pWhDWhowU+ucAMXoAYccMhe3HmDdtYKTClJbl6U
         fmJU0pkZyJoYMG5NcyZZOibKGW1Cl3vTFk5BekbEVPCG93Cqx6nt8TIiyTfAV13Ga5wp
         /6n1qs8BEl4c2gUYc51acI2uTGL3agpsorJEiQfPTk5Hd1YLv7/5o3M8kDrEgsyj7fCw
         2z8A==
X-Gm-Message-State: AOAM533qMag/r2oFt7sZOC0E6qt81w2xYu1rETN0AqHReCU3Wnex2wXo
        /dVdUXHCLQK0+8fSvaIWeS7yqeyB4Bx8ze6Ulh8lF6rH6hc5qmV65g/HalHD1E5hEF97l6cciYu
        swrRoHGcfgRmwCd5C4SGJAHJdLA==
X-Received: by 2002:a17:906:2a16:: with SMTP id j22mr5669357eje.247.1616515591805;
        Tue, 23 Mar 2021 09:06:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw2MM0RHSKms0I/eIPiyz9c5bKOQ/k0ort32dinOjBJNXyxS/0kZSrUc97LXbRV0sFYSkRuqg==
X-Received: by 2002:a17:906:2a16:: with SMTP id j22mr5669318eje.247.1616515591501;
        Tue, 23 Mar 2021 09:06:31 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (catv-86-101-169-67.catv.broadband.hu. [86.101.169.67])
        by smtp.gmail.com with ESMTPSA id hd37sm10920653ejc.114.2021.03.23.09.06.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 09:06:30 -0700 (PDT)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, garyhuang <zjh.20052005@163.com>
Subject: [PATCH] vfs: allow stacked ->get_acl() in RCU lookup
Date:   Tue, 23 Mar 2021 17:06:29 +0100
Message-Id: <20210323160629.228597-1-mszeredi@redhat.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Overlayfs does not cache ACL's to avoid double caching with all its
problems.  Instead it just calls the underlying filesystem's
i_op->get_acl(), which will return the cached value, if possible.

In rcu path walk, however, get_cached_acl_rcu() is employed to get the
value from the cache, which will fail on overlayfs resulting in dropping
out of rcu walk mode.  This can result in a big performance hit in certain
situations.

Add a flags argument to the ->get_acl() callback, and allow
get_cached_acl_rcu() to call the ->get_acl() method with LOOKUP_RCU.

Don't do this for the generic case of a cache miss, only in case of
ACL_DONT_CACHE.

Reported-by: garyhuang <zjh.20052005@163.com>
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/9p/acl.c                   |  2 +-
 fs/9p/acl.h                   |  2 +-
 fs/bad_inode.c                |  2 +-
 fs/btrfs/acl.c                |  2 +-
 fs/btrfs/ctree.h              |  2 +-
 fs/ceph/acl.c                 |  2 +-
 fs/ceph/super.h               |  2 +-
 fs/erofs/xattr.c              |  2 +-
 fs/erofs/xattr.h              |  2 +-
 fs/ext2/acl.c                 |  2 +-
 fs/ext2/acl.h                 |  2 +-
 fs/ext4/acl.c                 |  2 +-
 fs/ext4/acl.h                 |  2 +-
 fs/f2fs/acl.c                 |  2 +-
 fs/f2fs/acl.h                 |  2 +-
 fs/fuse/acl.c                 |  2 +-
 fs/fuse/fuse_i.h              |  2 +-
 fs/gfs2/acl.c                 |  2 +-
 fs/gfs2/acl.h                 |  2 +-
 fs/jffs2/acl.c                |  2 +-
 fs/jffs2/acl.h                |  2 +-
 fs/jfs/acl.c                  |  2 +-
 fs/jfs/jfs_acl.h              |  2 +-
 fs/nfs/nfs3_fs.h              |  2 +-
 fs/nfs/nfs3acl.c              |  2 +-
 fs/ocfs2/acl.c                |  2 +-
 fs/ocfs2/acl.h                |  2 +-
 fs/orangefs/acl.c             |  2 +-
 fs/orangefs/orangefs-kernel.h |  2 +-
 fs/overlayfs/inode.c          |  6 +++++-
 fs/overlayfs/overlayfs.h      |  2 +-
 fs/posix_acl.c                | 10 ++++++++--
 fs/reiserfs/acl.h             |  2 +-
 fs/reiserfs/xattr_acl.c       |  2 +-
 fs/xfs/xfs_acl.c              |  2 +-
 fs/xfs/xfs_acl.h              |  4 ++--
 include/linux/fs.h            |  2 +-
 37 files changed, 49 insertions(+), 39 deletions(-)

diff --git a/fs/9p/acl.c b/fs/9p/acl.c
index bb1b286c49ae..48d0a8fcc038 100644
--- a/fs/9p/acl.c
+++ b/fs/9p/acl.c
@@ -97,7 +97,7 @@ static struct posix_acl *v9fs_get_cached_acl(struct inode *inode, int type)
 	return acl;
 }
 
-struct posix_acl *v9fs_iop_get_acl(struct inode *inode, int type)
+struct posix_acl *v9fs_iop_get_acl(struct inode *inode, int type, int flags)
 {
 	struct v9fs_session_info *v9ses;
 
diff --git a/fs/9p/acl.h b/fs/9p/acl.h
index e4f7e882272b..7b31cef9ef5a 100644
--- a/fs/9p/acl.h
+++ b/fs/9p/acl.h
@@ -16,7 +16,7 @@
 
 #ifdef CONFIG_9P_FS_POSIX_ACL
 extern int v9fs_get_acl(struct inode *, struct p9_fid *);
-extern struct posix_acl *v9fs_iop_get_acl(struct inode *inode, int type);
+extern struct posix_acl *v9fs_iop_get_acl(struct inode *inode, int type, int flags);
 extern int v9fs_acl_chmod(struct inode *, struct p9_fid *);
 extern int v9fs_set_create_acl(struct inode *, struct p9_fid *,
 			       struct posix_acl *, struct posix_acl *);
diff --git a/fs/bad_inode.c b/fs/bad_inode.c
index 48e16144c1f7..dd34decddaa6 100644
--- a/fs/bad_inode.c
+++ b/fs/bad_inode.c
@@ -121,7 +121,7 @@ static const char *bad_inode_get_link(struct dentry *dentry,
 	return ERR_PTR(-EIO);
 }
 
-static struct posix_acl *bad_inode_get_acl(struct inode *inode, int type)
+static struct posix_acl *bad_inode_get_acl(struct inode *inode, int type, int flags)
 {
 	return ERR_PTR(-EIO);
 }
diff --git a/fs/btrfs/acl.c b/fs/btrfs/acl.c
index d95eb5c8cb37..1d70bfd31ac1 100644
--- a/fs/btrfs/acl.c
+++ b/fs/btrfs/acl.c
@@ -16,7 +16,7 @@
 #include "btrfs_inode.h"
 #include "xattr.h"
 
-struct posix_acl *btrfs_get_acl(struct inode *inode, int type)
+struct posix_acl *btrfs_get_acl(struct inode *inode, int type, int flags)
 {
 	int size;
 	const char *name;
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 9ae776ab3967..a450e5fc9df8 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -3639,7 +3639,7 @@ static inline int __btrfs_fs_compat_ro(struct btrfs_fs_info *fs_info, u64 flag)
 
 /* acl.c */
 #ifdef CONFIG_BTRFS_FS_POSIX_ACL
-struct posix_acl *btrfs_get_acl(struct inode *inode, int type);
+struct posix_acl *btrfs_get_acl(struct inode *inode, int type, int flags);
 int btrfs_set_acl(struct user_namespace *mnt_userns, struct inode *inode,
 		  struct posix_acl *acl, int type);
 int btrfs_init_acl(struct btrfs_trans_handle *trans,
diff --git a/fs/ceph/acl.c b/fs/ceph/acl.c
index 529af59d9fd3..2b72b03b0586 100644
--- a/fs/ceph/acl.c
+++ b/fs/ceph/acl.c
@@ -29,7 +29,7 @@ static inline void ceph_set_cached_acl(struct inode *inode,
 	spin_unlock(&ci->i_ceph_lock);
 }
 
-struct posix_acl *ceph_get_acl(struct inode *inode, int type)
+struct posix_acl *ceph_get_acl(struct inode *inode, int type, int flags)
 {
 	int size;
 	unsigned int retry_cnt = 0;
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index c48bb30c8d70..c12712c80668 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -1066,7 +1066,7 @@ void ceph_release_acl_sec_ctx(struct ceph_acl_sec_ctx *as_ctx);
 /* acl.c */
 #ifdef CONFIG_CEPH_FS_POSIX_ACL
 
-struct posix_acl *ceph_get_acl(struct inode *, int);
+struct posix_acl *ceph_get_acl(struct inode *, int, int);
 int ceph_set_acl(struct user_namespace *mnt_userns,
 		 struct inode *inode, struct posix_acl *acl, int type);
 int ceph_pre_init_acls(struct inode *dir, umode_t *mode,
diff --git a/fs/erofs/xattr.c b/fs/erofs/xattr.c
index 47314a26767a..84c971690292 100644
--- a/fs/erofs/xattr.c
+++ b/fs/erofs/xattr.c
@@ -674,7 +674,7 @@ ssize_t erofs_listxattr(struct dentry *dentry,
 }
 
 #ifdef CONFIG_EROFS_FS_POSIX_ACL
-struct posix_acl *erofs_get_acl(struct inode *inode, int type)
+struct posix_acl *erofs_get_acl(struct inode *inode, int type, int flags)
 {
 	struct posix_acl *acl;
 	int prefix, rc;
diff --git a/fs/erofs/xattr.h b/fs/erofs/xattr.h
index 815304bd335f..5e4b917cc6a7 100644
--- a/fs/erofs/xattr.h
+++ b/fs/erofs/xattr.h
@@ -81,7 +81,7 @@ static inline int erofs_getxattr(struct inode *inode, int index,
 #endif	/* !CONFIG_EROFS_FS_XATTR */
 
 #ifdef CONFIG_EROFS_FS_POSIX_ACL
-struct posix_acl *erofs_get_acl(struct inode *inode, int type);
+struct posix_acl *erofs_get_acl(struct inode *inode, int type, int flags);
 #else
 #define erofs_get_acl	(NULL)
 #endif
diff --git a/fs/ext2/acl.c b/fs/ext2/acl.c
index b9a9db98e94b..1dc220f205b3 100644
--- a/fs/ext2/acl.c
+++ b/fs/ext2/acl.c
@@ -141,7 +141,7 @@ ext2_acl_to_disk(const struct posix_acl *acl, size_t *size)
  * inode->i_mutex: don't care
  */
 struct posix_acl *
-ext2_get_acl(struct inode *inode, int type)
+ext2_get_acl(struct inode *inode, int type, int flags)
 {
 	int name_index;
 	char *value = NULL;
diff --git a/fs/ext2/acl.h b/fs/ext2/acl.h
index 917db5f6630a..0bd53a953831 100644
--- a/fs/ext2/acl.h
+++ b/fs/ext2/acl.h
@@ -55,7 +55,7 @@ static inline int ext2_acl_count(size_t size)
 #ifdef CONFIG_EXT2_FS_POSIX_ACL
 
 /* acl.c */
-extern struct posix_acl *ext2_get_acl(struct inode *inode, int type);
+extern struct posix_acl *ext2_get_acl(struct inode *inode, int type, int flags);
 extern int ext2_set_acl(struct user_namespace *mnt_userns, struct inode *inode,
 			struct posix_acl *acl, int type);
 extern int ext2_init_acl (struct inode *, struct inode *);
diff --git a/fs/ext4/acl.c b/fs/ext4/acl.c
index c5eaffccecc3..b2b06a80eb8b 100644
--- a/fs/ext4/acl.c
+++ b/fs/ext4/acl.c
@@ -142,7 +142,7 @@ ext4_acl_to_disk(const struct posix_acl *acl, size_t *size)
  * inode->i_mutex: don't care
  */
 struct posix_acl *
-ext4_get_acl(struct inode *inode, int type)
+ext4_get_acl(struct inode *inode, int type, int flags)
 {
 	int name_index;
 	char *value = NULL;
diff --git a/fs/ext4/acl.h b/fs/ext4/acl.h
index 84b8942a57f2..b349365c7b33 100644
--- a/fs/ext4/acl.h
+++ b/fs/ext4/acl.h
@@ -55,7 +55,7 @@ static inline int ext4_acl_count(size_t size)
 #ifdef CONFIG_EXT4_FS_POSIX_ACL
 
 /* acl.c */
-struct posix_acl *ext4_get_acl(struct inode *inode, int type);
+struct posix_acl *ext4_get_acl(struct inode *inode, int type, int flags);
 int ext4_set_acl(struct user_namespace *mnt_userns, struct inode *inode,
 		 struct posix_acl *acl, int type);
 extern int ext4_init_acl(handle_t *, struct inode *, struct inode *);
diff --git a/fs/f2fs/acl.c b/fs/f2fs/acl.c
index 965037a9c205..ae86df5e1472 100644
--- a/fs/f2fs/acl.c
+++ b/fs/f2fs/acl.c
@@ -195,7 +195,7 @@ static struct posix_acl *__f2fs_get_acl(struct inode *inode, int type,
 	return acl;
 }
 
-struct posix_acl *f2fs_get_acl(struct inode *inode, int type)
+struct posix_acl *f2fs_get_acl(struct inode *inode, int type, int flags)
 {
 	return __f2fs_get_acl(inode, type, NULL);
 }
diff --git a/fs/f2fs/acl.h b/fs/f2fs/acl.h
index 986fd1bc780b..3b7b0deb2845 100644
--- a/fs/f2fs/acl.h
+++ b/fs/f2fs/acl.h
@@ -33,7 +33,7 @@ struct f2fs_acl_header {
 
 #ifdef CONFIG_F2FS_FS_POSIX_ACL
 
-extern struct posix_acl *f2fs_get_acl(struct inode *, int);
+extern struct posix_acl *f2fs_get_acl(struct inode *, int, int);
 extern int f2fs_set_acl(struct user_namespace *, struct inode *,
 			struct posix_acl *, int);
 extern int f2fs_init_acl(struct inode *, struct inode *, struct page *,
diff --git a/fs/fuse/acl.c b/fs/fuse/acl.c
index e9c0f916349d..1ec289668d73 100644
--- a/fs/fuse/acl.c
+++ b/fs/fuse/acl.c
@@ -11,7 +11,7 @@
 #include <linux/posix_acl.h>
 #include <linux/posix_acl_xattr.h>
 
-struct posix_acl *fuse_get_acl(struct inode *inode, int type)
+struct posix_acl *fuse_get_acl(struct inode *inode, int type, int flags)
 {
 	struct fuse_conn *fc = get_fuse_conn(inode);
 	int size;
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 63d97a15ffde..8f34101c5c62 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1180,7 +1180,7 @@ extern const struct xattr_handler *fuse_acl_xattr_handlers[];
 extern const struct xattr_handler *fuse_no_acl_xattr_handlers[];
 
 struct posix_acl;
-struct posix_acl *fuse_get_acl(struct inode *inode, int type);
+struct posix_acl *fuse_get_acl(struct inode *inode, int type, int flags);
 int fuse_set_acl(struct user_namespace *mnt_userns, struct inode *inode,
 		 struct posix_acl *acl, int type);
 
diff --git a/fs/gfs2/acl.c b/fs/gfs2/acl.c
index 9165d70ead07..3455cb2079b9 100644
--- a/fs/gfs2/acl.c
+++ b/fs/gfs2/acl.c
@@ -57,7 +57,7 @@ static struct posix_acl *__gfs2_get_acl(struct inode *inode, int type)
 	return acl;
 }
 
-struct posix_acl *gfs2_get_acl(struct inode *inode, int type)
+struct posix_acl *gfs2_get_acl(struct inode *inode, int type, int flags)
 {
 	struct gfs2_inode *ip = GFS2_I(inode);
 	struct gfs2_holder gh;
diff --git a/fs/gfs2/acl.h b/fs/gfs2/acl.h
index eccc6a43326c..cdf8f12089de 100644
--- a/fs/gfs2/acl.h
+++ b/fs/gfs2/acl.h
@@ -11,7 +11,7 @@
 
 #define GFS2_ACL_MAX_ENTRIES(sdp) ((300 << (sdp)->sd_sb.sb_bsize_shift) >> 12)
 
-extern struct posix_acl *gfs2_get_acl(struct inode *inode, int type);
+extern struct posix_acl *gfs2_get_acl(struct inode *inode, int type, int flags);
 extern int __gfs2_set_acl(struct inode *inode, struct posix_acl *acl, int type);
 extern int gfs2_set_acl(struct user_namespace *mnt_userns, struct inode *inode,
 			struct posix_acl *acl, int type);
diff --git a/fs/jffs2/acl.c b/fs/jffs2/acl.c
index 55a79df70d24..3eade65c95eb 100644
--- a/fs/jffs2/acl.c
+++ b/fs/jffs2/acl.c
@@ -173,7 +173,7 @@ static void *jffs2_acl_to_medium(const struct posix_acl *acl, size_t *size)
 	return ERR_PTR(-EINVAL);
 }
 
-struct posix_acl *jffs2_get_acl(struct inode *inode, int type)
+struct posix_acl *jffs2_get_acl(struct inode *inode, int type, int flags)
 {
 	struct posix_acl *acl;
 	char *value = NULL;
diff --git a/fs/jffs2/acl.h b/fs/jffs2/acl.h
index 62c50da9d493..afd6f924aacb 100644
--- a/fs/jffs2/acl.h
+++ b/fs/jffs2/acl.h
@@ -27,7 +27,7 @@ struct jffs2_acl_header {
 
 #ifdef CONFIG_JFFS2_FS_POSIX_ACL
 
-struct posix_acl *jffs2_get_acl(struct inode *inode, int type);
+struct posix_acl *jffs2_get_acl(struct inode *inode, int type, int flags);
 int jffs2_set_acl(struct user_namespace *mnt_userns, struct inode *inode,
 		  struct posix_acl *acl, int type);
 extern int jffs2_init_acl_pre(struct inode *, struct inode *, umode_t *);
diff --git a/fs/jfs/acl.c b/fs/jfs/acl.c
index 43c285c3d2a7..b8a459cc649f 100644
--- a/fs/jfs/acl.c
+++ b/fs/jfs/acl.c
@@ -14,7 +14,7 @@
 #include "jfs_xattr.h"
 #include "jfs_acl.h"
 
-struct posix_acl *jfs_get_acl(struct inode *inode, int type)
+struct posix_acl *jfs_get_acl(struct inode *inode, int type, int flags)
 {
 	struct posix_acl *acl;
 	char *ea_name;
diff --git a/fs/jfs/jfs_acl.h b/fs/jfs/jfs_acl.h
index 7ae389a7a366..e86997d1f123 100644
--- a/fs/jfs/jfs_acl.h
+++ b/fs/jfs/jfs_acl.h
@@ -7,7 +7,7 @@
 
 #ifdef CONFIG_JFS_POSIX_ACL
 
-struct posix_acl *jfs_get_acl(struct inode *inode, int type);
+struct posix_acl *jfs_get_acl(struct inode *inode, int type, int flags);
 int jfs_set_acl(struct user_namespace *mnt_userns, struct inode *inode,
 		struct posix_acl *acl, int type);
 int jfs_init_acl(tid_t, struct inode *, struct inode *);
diff --git a/fs/nfs/nfs3_fs.h b/fs/nfs/nfs3_fs.h
index c8a192802dda..0f3ba2f3b8da 100644
--- a/fs/nfs/nfs3_fs.h
+++ b/fs/nfs/nfs3_fs.h
@@ -11,7 +11,7 @@
  * nfs3acl.c
  */
 #ifdef CONFIG_NFS_V3_ACL
-extern struct posix_acl *nfs3_get_acl(struct inode *inode, int type);
+extern struct posix_acl *nfs3_get_acl(struct inode *inode, int type, int flags);
 extern int nfs3_set_acl(struct user_namespace *mnt_userns, struct inode *inode,
 			struct posix_acl *acl, int type);
 extern int nfs3_proc_setacls(struct inode *inode, struct posix_acl *acl,
diff --git a/fs/nfs/nfs3acl.c b/fs/nfs/nfs3acl.c
index bb386a691e69..f78ad2f6a80a 100644
--- a/fs/nfs/nfs3acl.c
+++ b/fs/nfs/nfs3acl.c
@@ -44,7 +44,7 @@ static void nfs3_abort_get_acl(struct posix_acl **p)
 	cmpxchg(p, sentinel, ACL_NOT_CACHED);
 }
 
-struct posix_acl *nfs3_get_acl(struct inode *inode, int type)
+struct posix_acl *nfs3_get_acl(struct inode *inode, int type, int flags)
 {
 	struct nfs_server *server = NFS_SERVER(inode);
 	struct page *pages[NFSACL_MAXPAGES] = { };
diff --git a/fs/ocfs2/acl.c b/fs/ocfs2/acl.c
index 5259badabb56..2d0db332bd0e 100644
--- a/fs/ocfs2/acl.c
+++ b/fs/ocfs2/acl.c
@@ -291,7 +291,7 @@ int ocfs2_iop_set_acl(struct user_namespace *mnt_userns, struct inode *inode,
 	return status;
 }
 
-struct posix_acl *ocfs2_iop_get_acl(struct inode *inode, int type)
+struct posix_acl *ocfs2_iop_get_acl(struct inode *inode, int type, int flags)
 {
 	struct ocfs2_super *osb;
 	struct buffer_head *di_bh = NULL;
diff --git a/fs/ocfs2/acl.h b/fs/ocfs2/acl.h
index 4e86450917b2..b75028c4ab4b 100644
--- a/fs/ocfs2/acl.h
+++ b/fs/ocfs2/acl.h
@@ -18,7 +18,7 @@ struct ocfs2_acl_entry {
 	__le32 e_id;
 };
 
-struct posix_acl *ocfs2_iop_get_acl(struct inode *inode, int type);
+struct posix_acl *ocfs2_iop_get_acl(struct inode *inode, int type, int flags);
 int ocfs2_iop_set_acl(struct user_namespace *mnt_userns, struct inode *inode,
 		      struct posix_acl *acl, int type);
 extern int ocfs2_acl_chmod(struct inode *, struct buffer_head *);
diff --git a/fs/orangefs/acl.c b/fs/orangefs/acl.c
index 18852b9ed82b..7c61a21cfcb2 100644
--- a/fs/orangefs/acl.c
+++ b/fs/orangefs/acl.c
@@ -10,7 +10,7 @@
 #include "orangefs-bufmap.h"
 #include <linux/posix_acl_xattr.h>
 
-struct posix_acl *orangefs_get_acl(struct inode *inode, int type)
+struct posix_acl *orangefs_get_acl(struct inode *inode, int type, int flags)
 {
 	struct posix_acl *acl;
 	int ret;
diff --git a/fs/orangefs/orangefs-kernel.h b/fs/orangefs/orangefs-kernel.h
index 0e6b97682e41..370bd89c670f 100644
--- a/fs/orangefs/orangefs-kernel.h
+++ b/fs/orangefs/orangefs-kernel.h
@@ -106,7 +106,7 @@ enum orangefs_vfs_op_states {
 extern int orangefs_init_acl(struct inode *inode, struct inode *dir);
 extern const struct xattr_handler *orangefs_xattr_handlers[];
 
-extern struct posix_acl *orangefs_get_acl(struct inode *inode, int type);
+extern struct posix_acl *orangefs_get_acl(struct inode *inode, int type, int flags);
 extern int orangefs_set_acl(struct user_namespace *mnt_userns,
 			    struct inode *inode, struct posix_acl *acl,
 			    int type);
diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
index 003cf83bf78a..994ce7ecebae 100644
--- a/fs/overlayfs/inode.c
+++ b/fs/overlayfs/inode.c
@@ -11,6 +11,7 @@
 #include <linux/posix_acl.h>
 #include <linux/ratelimit.h>
 #include <linux/fiemap.h>
+#include <linux/namei.h>
 #include "overlayfs.h"
 
 
@@ -450,7 +451,7 @@ ssize_t ovl_listxattr(struct dentry *dentry, char *list, size_t size)
 	return res;
 }
 
-struct posix_acl *ovl_get_acl(struct inode *inode, int type)
+struct posix_acl *ovl_get_acl(struct inode *inode, int type, int flags)
 {
 	struct inode *realinode = ovl_inode_real(inode);
 	const struct cred *old_cred;
@@ -459,6 +460,9 @@ struct posix_acl *ovl_get_acl(struct inode *inode, int type)
 	if (!IS_ENABLED(CONFIG_FS_POSIX_ACL) || !IS_POSIXACL(realinode))
 		return NULL;
 
+	if (flags & LOOKUP_RCU)
+		return get_cached_acl_rcu(realinode, type);
+
 	old_cred = ovl_override_creds(inode->i_sb);
 	acl = get_acl(realinode, type);
 	revert_creds(old_cred);
diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index 95cff83786a5..d2284fe67978 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -456,7 +456,7 @@ int ovl_xattr_set(struct dentry *dentry, struct inode *inode, const char *name,
 int ovl_xattr_get(struct dentry *dentry, struct inode *inode, const char *name,
 		  void *value, size_t size);
 ssize_t ovl_listxattr(struct dentry *dentry, char *list, size_t size);
-struct posix_acl *ovl_get_acl(struct inode *inode, int type);
+struct posix_acl *ovl_get_acl(struct inode *inode, int type, int flags);
 int ovl_update_time(struct inode *inode, struct timespec64 *ts, int flags);
 bool ovl_is_private_xattr(struct super_block *sb, const char *name);
 
diff --git a/fs/posix_acl.c b/fs/posix_acl.c
index f3309a7edb49..4d1c6c266cf0 100644
--- a/fs/posix_acl.c
+++ b/fs/posix_acl.c
@@ -22,6 +22,7 @@
 #include <linux/xattr.h>
 #include <linux/export.h>
 #include <linux/user_namespace.h>
+#include <linux/namei.h>
 
 static struct posix_acl **acl_by_type(struct inode *inode, int type)
 {
@@ -56,7 +57,12 @@ EXPORT_SYMBOL(get_cached_acl);
 
 struct posix_acl *get_cached_acl_rcu(struct inode *inode, int type)
 {
-	return rcu_dereference(*acl_by_type(inode, type));
+	struct posix_acl *acl = rcu_dereference(*acl_by_type(inode, type));
+
+	if (acl == ACL_DONT_CACHE)
+		acl = inode->i_op->get_acl(inode, type, LOOKUP_RCU);
+
+	return acl;
 }
 EXPORT_SYMBOL(get_cached_acl_rcu);
 
@@ -138,7 +144,7 @@ struct posix_acl *get_acl(struct inode *inode, int type)
 		set_cached_acl(inode, type, NULL);
 		return NULL;
 	}
-	acl = inode->i_op->get_acl(inode, type);
+	acl = inode->i_op->get_acl(inode, type, 0);
 
 	if (IS_ERR(acl)) {
 		/*
diff --git a/fs/reiserfs/acl.h b/fs/reiserfs/acl.h
index fd58618da360..bf10841b892d 100644
--- a/fs/reiserfs/acl.h
+++ b/fs/reiserfs/acl.h
@@ -48,7 +48,7 @@ static inline int reiserfs_acl_count(size_t size)
 }
 
 #ifdef CONFIG_REISERFS_FS_POSIX_ACL
-struct posix_acl *reiserfs_get_acl(struct inode *inode, int type);
+struct posix_acl *reiserfs_get_acl(struct inode *inode, int type, int flags);
 int reiserfs_set_acl(struct user_namespace *mnt_userns, struct inode *inode,
 		     struct posix_acl *acl, int type);
 int reiserfs_acl_chmod(struct inode *inode);
diff --git a/fs/reiserfs/xattr_acl.c b/fs/reiserfs/xattr_acl.c
index a9547144a099..377507a1c7b8 100644
--- a/fs/reiserfs/xattr_acl.c
+++ b/fs/reiserfs/xattr_acl.c
@@ -190,7 +190,7 @@ static void *reiserfs_posix_acl_to_disk(const struct posix_acl *acl, size_t * si
  * inode->i_mutex: down
  * BKL held [before 2.5.x]
  */
-struct posix_acl *reiserfs_get_acl(struct inode *inode, int type)
+struct posix_acl *reiserfs_get_acl(struct inode *inode, int type, int flags)
 {
 	char *name, *value;
 	struct posix_acl *acl;
diff --git a/fs/xfs/xfs_acl.c b/fs/xfs/xfs_acl.c
index d02bef24b32b..27e6e6525cd3 100644
--- a/fs/xfs/xfs_acl.c
+++ b/fs/xfs/xfs_acl.c
@@ -125,7 +125,7 @@ xfs_acl_to_disk(struct xfs_acl *aclp, const struct posix_acl *acl)
 }
 
 struct posix_acl *
-xfs_get_acl(struct inode *inode, int type)
+xfs_get_acl(struct inode *inode, int type, int flags)
 {
 	struct xfs_inode	*ip = XFS_I(inode);
 	struct xfs_mount	*mp = ip->i_mount;
diff --git a/fs/xfs/xfs_acl.h b/fs/xfs/xfs_acl.h
index 7bdb3a4ed798..38f933f2e281 100644
--- a/fs/xfs/xfs_acl.h
+++ b/fs/xfs/xfs_acl.h
@@ -10,13 +10,13 @@ struct inode;
 struct posix_acl;
 
 #ifdef CONFIG_XFS_POSIX_ACL
-extern struct posix_acl *xfs_get_acl(struct inode *inode, int type);
+extern struct posix_acl *xfs_get_acl(struct inode *inode, int type, int flags);
 extern int xfs_set_acl(struct user_namespace *mnt_userns, struct inode *inode,
 		       struct posix_acl *acl, int type);
 extern int __xfs_set_acl(struct inode *inode, struct posix_acl *acl, int type);
 void xfs_forget_acl(struct inode *inode, const char *name);
 #else
-static inline struct posix_acl *xfs_get_acl(struct inode *inode, int type)
+static inline struct posix_acl *xfs_get_acl(struct inode *inode, int type, int flags)
 {
 	return NULL;
 }
diff --git a/include/linux/fs.h b/include/linux/fs.h
index ec8f3ddf4a6a..1683f16f3b06 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1931,7 +1931,7 @@ struct inode_operations {
 	struct dentry * (*lookup) (struct inode *,struct dentry *, unsigned int);
 	const char * (*get_link) (struct dentry *, struct inode *, struct delayed_call *);
 	int (*permission) (struct user_namespace *, struct inode *, int);
-	struct posix_acl * (*get_acl)(struct inode *, int);
+	struct posix_acl * (*get_acl)(struct inode *, int, int);
 
 	int (*readlink) (struct dentry *, char __user *,int);
 
-- 
2.30.2

