Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0C113F053D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Aug 2021 15:49:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238070AbhHRNuc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Aug 2021 09:50:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:44136 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237104AbhHRNuc (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Aug 2021 09:50:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2796A6109E;
        Wed, 18 Aug 2021 13:49:54 +0000 (UTC)
Date:   Wed, 18 Aug 2021 15:49:52 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Miklos Szeredi <mszeredi@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andreas Gruenbacher <agruenba@redhat.com>
Subject: Re: [PATCH v2 1/2] vfs: add flags argument to ->get_acl() callback
Message-ID: <20210818134952.4km5uvuaakhr6ezt@wittgenstein>
References: <20210818133400.830078-1-mszeredi@redhat.com>
 <20210818133400.830078-2-mszeredi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210818133400.830078-2-mszeredi@redhat.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 18, 2021 at 03:33:59PM +0200, Miklos Szeredi wrote:
> Add a flags argument to the ->get_acl() callback, to allow
> get_cached_acl_rcu() to call the ->get_acl() method with LOOKUP_RCU.
> 
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> ---
>  Documentation/filesystems/locking.rst | 2 +-
>  Documentation/filesystems/vfs.rst     | 2 +-
>  fs/9p/acl.c                           | 5 ++++-
>  fs/9p/acl.h                           | 2 +-
>  fs/bad_inode.c                        | 2 +-
>  fs/btrfs/acl.c                        | 5 ++++-
>  fs/btrfs/ctree.h                      | 2 +-
>  fs/ceph/acl.c                         | 5 ++++-
>  fs/ceph/super.h                       | 2 +-
>  fs/erofs/xattr.c                      | 5 ++++-
>  fs/erofs/xattr.h                      | 2 +-
>  fs/ext2/acl.c                         | 5 ++++-
>  fs/ext2/acl.h                         | 2 +-
>  fs/ext4/acl.c                         | 5 ++++-
>  fs/ext4/acl.h                         | 2 +-
>  fs/f2fs/acl.c                         | 5 ++++-
>  fs/f2fs/acl.h                         | 2 +-
>  fs/fuse/acl.c                         | 5 ++++-
>  fs/fuse/fuse_i.h                      | 2 +-
>  fs/gfs2/acl.c                         | 5 ++++-
>  fs/gfs2/acl.h                         | 2 +-
>  fs/jffs2/acl.c                        | 5 ++++-
>  fs/jffs2/acl.h                        | 2 +-
>  fs/jfs/acl.c                          | 5 ++++-
>  fs/jfs/jfs_acl.h                      | 2 +-
>  fs/nfs/nfs3_fs.h                      | 2 +-
>  fs/nfs/nfs3acl.c                      | 5 ++++-
>  fs/ocfs2/acl.c                        | 5 ++++-
>  fs/ocfs2/acl.h                        | 2 +-
>  fs/orangefs/acl.c                     | 5 ++++-
>  fs/orangefs/orangefs-kernel.h         | 2 +-
>  fs/overlayfs/inode.c                  | 5 ++++-
>  fs/overlayfs/overlayfs.h              | 2 +-
>  fs/posix_acl.c                        | 2 +-
>  fs/reiserfs/acl.h                     | 2 +-
>  fs/reiserfs/xattr_acl.c               | 5 ++++-
>  fs/xfs/xfs_acl.c                      | 5 ++++-
>  fs/xfs/xfs_acl.h                      | 4 ++--
>  include/linux/fs.h                    | 2 +-
>  39 files changed, 91 insertions(+), 40 deletions(-)
> 
> diff --git a/Documentation/filesystems/locking.rst b/Documentation/filesystems/locking.rst
> index 2183fd8cc350..a6a8f2b34331 100644
> --- a/Documentation/filesystems/locking.rst
> +++ b/Documentation/filesystems/locking.rst
> @@ -70,7 +70,7 @@ prototypes::
>  	const char *(*get_link) (struct dentry *, struct inode *, struct delayed_call *);
>  	void (*truncate) (struct inode *);
>  	int (*permission) (struct inode *, int, unsigned int);
> -	int (*get_acl)(struct inode *, int);
> +	struct posix_acl * (*get_acl)(struct inode *, int, int);
>  	int (*setattr) (struct dentry *, struct iattr *);
>  	int (*getattr) (const struct path *, struct kstat *, u32, unsigned int);
>  	ssize_t (*listxattr) (struct dentry *, char *, size_t);
> diff --git a/Documentation/filesystems/vfs.rst b/Documentation/filesystems/vfs.rst
> index 14c31eced416..dc9339acb66f 100644
> --- a/Documentation/filesystems/vfs.rst
> +++ b/Documentation/filesystems/vfs.rst
> @@ -432,7 +432,7 @@ As of kernel 2.6.22, the following members are defined:
>  		const char *(*get_link) (struct dentry *, struct inode *,
>  					 struct delayed_call *);
>  		int (*permission) (struct user_namespace *, struct inode *, int);
> -		int (*get_acl)(struct inode *, int);
> +		struct posix_acl * (*get_acl)(struct inode *, int, int);

Fwiw, I think this series is sane. The only thing I'd like to see change
is that the flag argument should really be "unsigned int" not "int".
Other than that:

Acked-by: Christian Brauner <christian.brauner@ubuntu.com>

>  		int (*setattr) (struct user_namespace *, struct dentry *, struct iattr *);
>  		int (*getattr) (struct user_namespace *, const struct path *, struct kstat *, u32, unsigned int);
>  		ssize_t (*listxattr) (struct dentry *, char *, size_t);
> diff --git a/fs/9p/acl.c b/fs/9p/acl.c
> index bb1b286c49ae..3ef7db80fe29 100644
> --- a/fs/9p/acl.c
> +++ b/fs/9p/acl.c
> @@ -97,10 +97,13 @@ static struct posix_acl *v9fs_get_cached_acl(struct inode *inode, int type)
>  	return acl;
>  }
>  
> -struct posix_acl *v9fs_iop_get_acl(struct inode *inode, int type)
> +struct posix_acl *v9fs_iop_get_acl(struct inode *inode, int type, int flags)
>  {
>  	struct v9fs_session_info *v9ses;
>  
> +	if (flags)
> +		return ERR_PTR(-EINVAL);
> +
>  	v9ses = v9fs_inode2v9ses(inode);
>  	if (((v9ses->flags & V9FS_ACCESS_MASK) != V9FS_ACCESS_CLIENT) ||
>  			((v9ses->flags & V9FS_ACL_MASK) != V9FS_POSIX_ACL)) {
> diff --git a/fs/9p/acl.h b/fs/9p/acl.h
> index e4f7e882272b..7b31cef9ef5a 100644
> --- a/fs/9p/acl.h
> +++ b/fs/9p/acl.h
> @@ -16,7 +16,7 @@
>  
>  #ifdef CONFIG_9P_FS_POSIX_ACL
>  extern int v9fs_get_acl(struct inode *, struct p9_fid *);
> -extern struct posix_acl *v9fs_iop_get_acl(struct inode *inode, int type);
> +extern struct posix_acl *v9fs_iop_get_acl(struct inode *inode, int type, int flags);
>  extern int v9fs_acl_chmod(struct inode *, struct p9_fid *);
>  extern int v9fs_set_create_acl(struct inode *, struct p9_fid *,
>  			       struct posix_acl *, struct posix_acl *);
> diff --git a/fs/bad_inode.c b/fs/bad_inode.c
> index 48e16144c1f7..dd34decddaa6 100644
> --- a/fs/bad_inode.c
> +++ b/fs/bad_inode.c
> @@ -121,7 +121,7 @@ static const char *bad_inode_get_link(struct dentry *dentry,
>  	return ERR_PTR(-EIO);
>  }
>  
> -static struct posix_acl *bad_inode_get_acl(struct inode *inode, int type)
> +static struct posix_acl *bad_inode_get_acl(struct inode *inode, int type, int flags)
>  {
>  	return ERR_PTR(-EIO);
>  }
> diff --git a/fs/btrfs/acl.c b/fs/btrfs/acl.c
> index d95eb5c8cb37..b53d55186e4a 100644
> --- a/fs/btrfs/acl.c
> +++ b/fs/btrfs/acl.c
> @@ -16,13 +16,16 @@
>  #include "btrfs_inode.h"
>  #include "xattr.h"
>  
> -struct posix_acl *btrfs_get_acl(struct inode *inode, int type)
> +struct posix_acl *btrfs_get_acl(struct inode *inode, int type, int flags)
>  {
>  	int size;
>  	const char *name;
>  	char *value = NULL;
>  	struct posix_acl *acl;
>  
> +	if (flags)
> +		return ERR_PTR(-EINVAL);
> +
>  	switch (type) {
>  	case ACL_TYPE_ACCESS:
>  		name = XATTR_NAME_POSIX_ACL_ACCESS;
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index e5e53e592d4f..460a64266066 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -3686,7 +3686,7 @@ static inline int __btrfs_fs_compat_ro(struct btrfs_fs_info *fs_info, u64 flag)
>  
>  /* acl.c */
>  #ifdef CONFIG_BTRFS_FS_POSIX_ACL
> -struct posix_acl *btrfs_get_acl(struct inode *inode, int type);
> +struct posix_acl *btrfs_get_acl(struct inode *inode, int type, int flags);
>  int btrfs_set_acl(struct user_namespace *mnt_userns, struct inode *inode,
>  		  struct posix_acl *acl, int type);
>  int btrfs_init_acl(struct btrfs_trans_handle *trans,
> diff --git a/fs/ceph/acl.c b/fs/ceph/acl.c
> index 529af59d9fd3..61e4f866d162 100644
> --- a/fs/ceph/acl.c
> +++ b/fs/ceph/acl.c
> @@ -29,7 +29,7 @@ static inline void ceph_set_cached_acl(struct inode *inode,
>  	spin_unlock(&ci->i_ceph_lock);
>  }
>  
> -struct posix_acl *ceph_get_acl(struct inode *inode, int type)
> +struct posix_acl *ceph_get_acl(struct inode *inode, int type, int flags)
>  {
>  	int size;
>  	unsigned int retry_cnt = 0;
> @@ -37,6 +37,9 @@ struct posix_acl *ceph_get_acl(struct inode *inode, int type)
>  	char *value = NULL;
>  	struct posix_acl *acl;
>  
> +	if (flags)
> +		return ERR_PTR(-EINVAL);
> +
>  	switch (type) {
>  	case ACL_TYPE_ACCESS:
>  		name = XATTR_NAME_POSIX_ACL_ACCESS;
> diff --git a/fs/ceph/super.h b/fs/ceph/super.h
> index 6b6332a5c113..528975f199eb 100644
> --- a/fs/ceph/super.h
> +++ b/fs/ceph/super.h
> @@ -1087,7 +1087,7 @@ void ceph_release_acl_sec_ctx(struct ceph_acl_sec_ctx *as_ctx);
>  /* acl.c */
>  #ifdef CONFIG_CEPH_FS_POSIX_ACL
>  
> -struct posix_acl *ceph_get_acl(struct inode *, int);
> +struct posix_acl *ceph_get_acl(struct inode *, int, int);
>  int ceph_set_acl(struct user_namespace *mnt_userns,
>  		 struct inode *inode, struct posix_acl *acl, int type);
>  int ceph_pre_init_acls(struct inode *dir, umode_t *mode,
> diff --git a/fs/erofs/xattr.c b/fs/erofs/xattr.c
> index 8dd54b420a1d..10c0d639d794 100644
> --- a/fs/erofs/xattr.c
> +++ b/fs/erofs/xattr.c
> @@ -673,12 +673,15 @@ ssize_t erofs_listxattr(struct dentry *dentry,
>  }
>  
>  #ifdef CONFIG_EROFS_FS_POSIX_ACL
> -struct posix_acl *erofs_get_acl(struct inode *inode, int type)
> +struct posix_acl *erofs_get_acl(struct inode *inode, int type, int flags)
>  {
>  	struct posix_acl *acl;
>  	int prefix, rc;
>  	char *value = NULL;
>  
> +	if (flags)
> +		return ERR_PTR(-EINVAL);
> +
>  	switch (type) {
>  	case ACL_TYPE_ACCESS:
>  		prefix = EROFS_XATTR_INDEX_POSIX_ACL_ACCESS;
> diff --git a/fs/erofs/xattr.h b/fs/erofs/xattr.h
> index 366dcb400525..ac35b5886eff 100644
> --- a/fs/erofs/xattr.h
> +++ b/fs/erofs/xattr.h
> @@ -80,7 +80,7 @@ static inline int erofs_getxattr(struct inode *inode, int index,
>  #endif	/* !CONFIG_EROFS_FS_XATTR */
>  
>  #ifdef CONFIG_EROFS_FS_POSIX_ACL
> -struct posix_acl *erofs_get_acl(struct inode *inode, int type);
> +struct posix_acl *erofs_get_acl(struct inode *inode, int type, int flags);
>  #else
>  #define erofs_get_acl	(NULL)
>  #endif
> diff --git a/fs/ext2/acl.c b/fs/ext2/acl.c
> index b9a9db98e94b..e203ebd224c4 100644
> --- a/fs/ext2/acl.c
> +++ b/fs/ext2/acl.c
> @@ -141,13 +141,16 @@ ext2_acl_to_disk(const struct posix_acl *acl, size_t *size)
>   * inode->i_mutex: don't care
>   */
>  struct posix_acl *
> -ext2_get_acl(struct inode *inode, int type)
> +ext2_get_acl(struct inode *inode, int type, int flags)
>  {
>  	int name_index;
>  	char *value = NULL;
>  	struct posix_acl *acl;
>  	int retval;
>  
> +	if (flags)
> +		return ERR_PTR(-EINVAL);
> +
>  	switch (type) {
>  	case ACL_TYPE_ACCESS:
>  		name_index = EXT2_XATTR_INDEX_POSIX_ACL_ACCESS;
> diff --git a/fs/ext2/acl.h b/fs/ext2/acl.h
> index 917db5f6630a..0bd53a953831 100644
> --- a/fs/ext2/acl.h
> +++ b/fs/ext2/acl.h
> @@ -55,7 +55,7 @@ static inline int ext2_acl_count(size_t size)
>  #ifdef CONFIG_EXT2_FS_POSIX_ACL
>  
>  /* acl.c */
> -extern struct posix_acl *ext2_get_acl(struct inode *inode, int type);
> +extern struct posix_acl *ext2_get_acl(struct inode *inode, int type, int flags);
>  extern int ext2_set_acl(struct user_namespace *mnt_userns, struct inode *inode,
>  			struct posix_acl *acl, int type);
>  extern int ext2_init_acl (struct inode *, struct inode *);
> diff --git a/fs/ext4/acl.c b/fs/ext4/acl.c
> index c5eaffccecc3..e4e27e34a221 100644
> --- a/fs/ext4/acl.c
> +++ b/fs/ext4/acl.c
> @@ -142,13 +142,16 @@ ext4_acl_to_disk(const struct posix_acl *acl, size_t *size)
>   * inode->i_mutex: don't care
>   */
>  struct posix_acl *
> -ext4_get_acl(struct inode *inode, int type)
> +ext4_get_acl(struct inode *inode, int type, int flags)
>  {
>  	int name_index;
>  	char *value = NULL;
>  	struct posix_acl *acl;
>  	int retval;
>  
> +	if (flags)
> +		return ERR_PTR(-EINVAL);
> +
>  	switch (type) {
>  	case ACL_TYPE_ACCESS:
>  		name_index = EXT4_XATTR_INDEX_POSIX_ACL_ACCESS;
> diff --git a/fs/ext4/acl.h b/fs/ext4/acl.h
> index 84b8942a57f2..b349365c7b33 100644
> --- a/fs/ext4/acl.h
> +++ b/fs/ext4/acl.h
> @@ -55,7 +55,7 @@ static inline int ext4_acl_count(size_t size)
>  #ifdef CONFIG_EXT4_FS_POSIX_ACL
>  
>  /* acl.c */
> -struct posix_acl *ext4_get_acl(struct inode *inode, int type);
> +struct posix_acl *ext4_get_acl(struct inode *inode, int type, int flags);
>  int ext4_set_acl(struct user_namespace *mnt_userns, struct inode *inode,
>  		 struct posix_acl *acl, int type);
>  extern int ext4_init_acl(handle_t *, struct inode *, struct inode *);
> diff --git a/fs/f2fs/acl.c b/fs/f2fs/acl.c
> index 239ad9453b99..4d1b348a0ab7 100644
> --- a/fs/f2fs/acl.c
> +++ b/fs/f2fs/acl.c
> @@ -196,8 +196,11 @@ static struct posix_acl *__f2fs_get_acl(struct inode *inode, int type,
>  	return acl;
>  }
>  
> -struct posix_acl *f2fs_get_acl(struct inode *inode, int type)
> +struct posix_acl *f2fs_get_acl(struct inode *inode, int type, int flags)
>  {
> +	if (flags)
> +		return ERR_PTR(-EINVAL);
> +
>  	return __f2fs_get_acl(inode, type, NULL);
>  }
>  
> diff --git a/fs/f2fs/acl.h b/fs/f2fs/acl.h
> index 986fd1bc780b..3b7b0deb2845 100644
> --- a/fs/f2fs/acl.h
> +++ b/fs/f2fs/acl.h
> @@ -33,7 +33,7 @@ struct f2fs_acl_header {
>  
>  #ifdef CONFIG_F2FS_FS_POSIX_ACL
>  
> -extern struct posix_acl *f2fs_get_acl(struct inode *, int);
> +extern struct posix_acl *f2fs_get_acl(struct inode *, int, int);
>  extern int f2fs_set_acl(struct user_namespace *, struct inode *,
>  			struct posix_acl *, int);
>  extern int f2fs_init_acl(struct inode *, struct inode *, struct page *,
> diff --git a/fs/fuse/acl.c b/fs/fuse/acl.c
> index 52b165319be1..194cb81634f9 100644
> --- a/fs/fuse/acl.c
> +++ b/fs/fuse/acl.c
> @@ -11,7 +11,7 @@
>  #include <linux/posix_acl.h>
>  #include <linux/posix_acl_xattr.h>
>  
> -struct posix_acl *fuse_get_acl(struct inode *inode, int type)
> +struct posix_acl *fuse_get_acl(struct inode *inode, int type, int flags)
>  {
>  	struct fuse_conn *fc = get_fuse_conn(inode);
>  	int size;
> @@ -19,6 +19,9 @@ struct posix_acl *fuse_get_acl(struct inode *inode, int type)
>  	void *value = NULL;
>  	struct posix_acl *acl;
>  
> +	if (flags)
> +		return ERR_PTR(-EINVAL);
> +
>  	if (fuse_is_bad(inode))
>  		return ERR_PTR(-EIO);
>  
> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> index 07829ce78695..ba3a419c6766 100644
> --- a/fs/fuse/fuse_i.h
> +++ b/fs/fuse/fuse_i.h
> @@ -1216,7 +1216,7 @@ extern const struct xattr_handler *fuse_acl_xattr_handlers[];
>  extern const struct xattr_handler *fuse_no_acl_xattr_handlers[];
>  
>  struct posix_acl;
> -struct posix_acl *fuse_get_acl(struct inode *inode, int type);
> +struct posix_acl *fuse_get_acl(struct inode *inode, int type, int flags);
>  int fuse_set_acl(struct user_namespace *mnt_userns, struct inode *inode,
>  		 struct posix_acl *acl, int type);
>  
> diff --git a/fs/gfs2/acl.c b/fs/gfs2/acl.c
> index 9165d70ead07..956132de223c 100644
> --- a/fs/gfs2/acl.c
> +++ b/fs/gfs2/acl.c
> @@ -57,13 +57,16 @@ static struct posix_acl *__gfs2_get_acl(struct inode *inode, int type)
>  	return acl;
>  }
>  
> -struct posix_acl *gfs2_get_acl(struct inode *inode, int type)
> +struct posix_acl *gfs2_get_acl(struct inode *inode, int type, int flags)
>  {
>  	struct gfs2_inode *ip = GFS2_I(inode);
>  	struct gfs2_holder gh;
>  	bool need_unlock = false;
>  	struct posix_acl *acl;
>  
> +	if (flags)
> +		return ERR_PTR(-EINVAL);
> +
>  	if (!gfs2_glock_is_locked_by_me(ip->i_gl)) {
>  		int ret = gfs2_glock_nq_init(ip->i_gl, LM_ST_SHARED,
>  					     LM_FLAG_ANY, &gh);
> diff --git a/fs/gfs2/acl.h b/fs/gfs2/acl.h
> index eccc6a43326c..cdf8f12089de 100644
> --- a/fs/gfs2/acl.h
> +++ b/fs/gfs2/acl.h
> @@ -11,7 +11,7 @@
>  
>  #define GFS2_ACL_MAX_ENTRIES(sdp) ((300 << (sdp)->sd_sb.sb_bsize_shift) >> 12)
>  
> -extern struct posix_acl *gfs2_get_acl(struct inode *inode, int type);
> +extern struct posix_acl *gfs2_get_acl(struct inode *inode, int type, int flags);
>  extern int __gfs2_set_acl(struct inode *inode, struct posix_acl *acl, int type);
>  extern int gfs2_set_acl(struct user_namespace *mnt_userns, struct inode *inode,
>  			struct posix_acl *acl, int type);
> diff --git a/fs/jffs2/acl.c b/fs/jffs2/acl.c
> index 55a79df70d24..35f4a0dcbd71 100644
> --- a/fs/jffs2/acl.c
> +++ b/fs/jffs2/acl.c
> @@ -173,12 +173,15 @@ static void *jffs2_acl_to_medium(const struct posix_acl *acl, size_t *size)
>  	return ERR_PTR(-EINVAL);
>  }
>  
> -struct posix_acl *jffs2_get_acl(struct inode *inode, int type)
> +struct posix_acl *jffs2_get_acl(struct inode *inode, int type, int flags)
>  {
>  	struct posix_acl *acl;
>  	char *value = NULL;
>  	int rc, xprefix;
>  
> +	if (flags)
> +		return ERR_PTR(-EINVAL);
> +
>  	switch (type) {
>  	case ACL_TYPE_ACCESS:
>  		xprefix = JFFS2_XPREFIX_ACL_ACCESS;
> diff --git a/fs/jffs2/acl.h b/fs/jffs2/acl.h
> index 62c50da9d493..afd6f924aacb 100644
> --- a/fs/jffs2/acl.h
> +++ b/fs/jffs2/acl.h
> @@ -27,7 +27,7 @@ struct jffs2_acl_header {
>  
>  #ifdef CONFIG_JFFS2_FS_POSIX_ACL
>  
> -struct posix_acl *jffs2_get_acl(struct inode *inode, int type);
> +struct posix_acl *jffs2_get_acl(struct inode *inode, int type, int flags);
>  int jffs2_set_acl(struct user_namespace *mnt_userns, struct inode *inode,
>  		  struct posix_acl *acl, int type);
>  extern int jffs2_init_acl_pre(struct inode *, struct inode *, umode_t *);
> diff --git a/fs/jfs/acl.c b/fs/jfs/acl.c
> index 43c285c3d2a7..344d047bcb97 100644
> --- a/fs/jfs/acl.c
> +++ b/fs/jfs/acl.c
> @@ -14,13 +14,16 @@
>  #include "jfs_xattr.h"
>  #include "jfs_acl.h"
>  
> -struct posix_acl *jfs_get_acl(struct inode *inode, int type)
> +struct posix_acl *jfs_get_acl(struct inode *inode, int type, int flags)
>  {
>  	struct posix_acl *acl;
>  	char *ea_name;
>  	int size;
>  	char *value = NULL;
>  
> +	if (flags)
> +		return ERR_PTR(-EINVAL);
> +
>  	switch(type) {
>  		case ACL_TYPE_ACCESS:
>  			ea_name = XATTR_NAME_POSIX_ACL_ACCESS;
> diff --git a/fs/jfs/jfs_acl.h b/fs/jfs/jfs_acl.h
> index 7ae389a7a366..e86997d1f123 100644
> --- a/fs/jfs/jfs_acl.h
> +++ b/fs/jfs/jfs_acl.h
> @@ -7,7 +7,7 @@
>  
>  #ifdef CONFIG_JFS_POSIX_ACL
>  
> -struct posix_acl *jfs_get_acl(struct inode *inode, int type);
> +struct posix_acl *jfs_get_acl(struct inode *inode, int type, int flags);
>  int jfs_set_acl(struct user_namespace *mnt_userns, struct inode *inode,
>  		struct posix_acl *acl, int type);
>  int jfs_init_acl(tid_t, struct inode *, struct inode *);
> diff --git a/fs/nfs/nfs3_fs.h b/fs/nfs/nfs3_fs.h
> index c8a192802dda..0f3ba2f3b8da 100644
> --- a/fs/nfs/nfs3_fs.h
> +++ b/fs/nfs/nfs3_fs.h
> @@ -11,7 +11,7 @@
>   * nfs3acl.c
>   */
>  #ifdef CONFIG_NFS_V3_ACL
> -extern struct posix_acl *nfs3_get_acl(struct inode *inode, int type);
> +extern struct posix_acl *nfs3_get_acl(struct inode *inode, int type, int flags);
>  extern int nfs3_set_acl(struct user_namespace *mnt_userns, struct inode *inode,
>  			struct posix_acl *acl, int type);
>  extern int nfs3_proc_setacls(struct inode *inode, struct posix_acl *acl,
> diff --git a/fs/nfs/nfs3acl.c b/fs/nfs/nfs3acl.c
> index 9ec560aa4a50..f94def1342c6 100644
> --- a/fs/nfs/nfs3acl.c
> +++ b/fs/nfs/nfs3acl.c
> @@ -44,7 +44,7 @@ static void nfs3_abort_get_acl(struct posix_acl **p)
>  	cmpxchg(p, sentinel, ACL_NOT_CACHED);
>  }
>  
> -struct posix_acl *nfs3_get_acl(struct inode *inode, int type)
> +struct posix_acl *nfs3_get_acl(struct inode *inode, int type, int flags)
>  {
>  	struct nfs_server *server = NFS_SERVER(inode);
>  	struct page *pages[NFSACL_MAXPAGES] = { };
> @@ -62,6 +62,9 @@ struct posix_acl *nfs3_get_acl(struct inode *inode, int type)
>  	};
>  	int status, count;
>  
> +	if (flags)
> +		return ERR_PTR(-EINVAL);
> +
>  	if (!nfs_server_capable(inode, NFS_CAP_ACLS))
>  		return ERR_PTR(-EOPNOTSUPP);
>  
> diff --git a/fs/ocfs2/acl.c b/fs/ocfs2/acl.c
> index 5c72a7e6d6c5..a4df6e30c017 100644
> --- a/fs/ocfs2/acl.c
> +++ b/fs/ocfs2/acl.c
> @@ -289,7 +289,7 @@ int ocfs2_iop_set_acl(struct user_namespace *mnt_userns, struct inode *inode,
>  	return status;
>  }
>  
> -struct posix_acl *ocfs2_iop_get_acl(struct inode *inode, int type)
> +struct posix_acl *ocfs2_iop_get_acl(struct inode *inode, int type, int flags)
>  {
>  	struct ocfs2_super *osb;
>  	struct buffer_head *di_bh = NULL;
> @@ -297,6 +297,9 @@ struct posix_acl *ocfs2_iop_get_acl(struct inode *inode, int type)
>  	int had_lock;
>  	struct ocfs2_lock_holder oh;
>  
> +	if (flags)
> +		return ERR_PTR(-EINVAL);
> +
>  	osb = OCFS2_SB(inode->i_sb);
>  	if (!(osb->s_mount_opt & OCFS2_MOUNT_POSIX_ACL))
>  		return NULL;
> diff --git a/fs/ocfs2/acl.h b/fs/ocfs2/acl.h
> index f59d8d0a61fa..e005c93b9153 100644
> --- a/fs/ocfs2/acl.h
> +++ b/fs/ocfs2/acl.h
> @@ -16,7 +16,7 @@ struct ocfs2_acl_entry {
>  	__le32 e_id;
>  };
>  
> -struct posix_acl *ocfs2_iop_get_acl(struct inode *inode, int type);
> +struct posix_acl *ocfs2_iop_get_acl(struct inode *inode, int type, int flags);
>  int ocfs2_iop_set_acl(struct user_namespace *mnt_userns, struct inode *inode,
>  		      struct posix_acl *acl, int type);
>  extern int ocfs2_acl_chmod(struct inode *, struct buffer_head *);
> diff --git a/fs/orangefs/acl.c b/fs/orangefs/acl.c
> index 18852b9ed82b..d93841d478ed 100644
> --- a/fs/orangefs/acl.c
> +++ b/fs/orangefs/acl.c
> @@ -10,12 +10,15 @@
>  #include "orangefs-bufmap.h"
>  #include <linux/posix_acl_xattr.h>
>  
> -struct posix_acl *orangefs_get_acl(struct inode *inode, int type)
> +struct posix_acl *orangefs_get_acl(struct inode *inode, int type, int flags)
>  {
>  	struct posix_acl *acl;
>  	int ret;
>  	char *key = NULL, *value = NULL;
>  
> +	if (flags)
> +		return ERR_PTR(-EINVAL);
> +
>  	switch (type) {
>  	case ACL_TYPE_ACCESS:
>  		key = XATTR_NAME_POSIX_ACL_ACCESS;
> diff --git a/fs/orangefs/orangefs-kernel.h b/fs/orangefs/orangefs-kernel.h
> index 0e6b97682e41..370bd89c670f 100644
> --- a/fs/orangefs/orangefs-kernel.h
> +++ b/fs/orangefs/orangefs-kernel.h
> @@ -106,7 +106,7 @@ enum orangefs_vfs_op_states {
>  extern int orangefs_init_acl(struct inode *inode, struct inode *dir);
>  extern const struct xattr_handler *orangefs_xattr_handlers[];
>  
> -extern struct posix_acl *orangefs_get_acl(struct inode *inode, int type);
> +extern struct posix_acl *orangefs_get_acl(struct inode *inode, int type, int flags);
>  extern int orangefs_set_acl(struct user_namespace *mnt_userns,
>  			    struct inode *inode, struct posix_acl *acl,
>  			    int type);
> diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
> index 5e828a1c98a8..727154a1d3ce 100644
> --- a/fs/overlayfs/inode.c
> +++ b/fs/overlayfs/inode.c
> @@ -448,12 +448,15 @@ ssize_t ovl_listxattr(struct dentry *dentry, char *list, size_t size)
>  	return res;
>  }
>  
> -struct posix_acl *ovl_get_acl(struct inode *inode, int type)
> +struct posix_acl *ovl_get_acl(struct inode *inode, int type, int flags)
>  {
>  	struct inode *realinode = ovl_inode_real(inode);
>  	const struct cred *old_cred;
>  	struct posix_acl *acl;
>  
> +	if (flags)
> +		return ERR_PTR(-EINVAL);
> +
>  	if (!IS_ENABLED(CONFIG_FS_POSIX_ACL) || !IS_POSIXACL(realinode))
>  		return NULL;
>  
> diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
> index 6ec73db4bf9e..daf6b75b9a54 100644
> --- a/fs/overlayfs/overlayfs.h
> +++ b/fs/overlayfs/overlayfs.h
> @@ -485,7 +485,7 @@ int ovl_xattr_set(struct dentry *dentry, struct inode *inode, const char *name,
>  int ovl_xattr_get(struct dentry *dentry, struct inode *inode, const char *name,
>  		  void *value, size_t size);
>  ssize_t ovl_listxattr(struct dentry *dentry, char *list, size_t size);
> -struct posix_acl *ovl_get_acl(struct inode *inode, int type);
> +struct posix_acl *ovl_get_acl(struct inode *inode, int type, int flags);
>  int ovl_update_time(struct inode *inode, struct timespec64 *ts, int flags);
>  bool ovl_is_private_xattr(struct super_block *sb, const char *name);
>  
> diff --git a/fs/posix_acl.c b/fs/posix_acl.c
> index f3309a7edb49..6b7f793e2b6f 100644
> --- a/fs/posix_acl.c
> +++ b/fs/posix_acl.c
> @@ -138,7 +138,7 @@ struct posix_acl *get_acl(struct inode *inode, int type)
>  		set_cached_acl(inode, type, NULL);
>  		return NULL;
>  	}
> -	acl = inode->i_op->get_acl(inode, type);
> +	acl = inode->i_op->get_acl(inode, type, 0);
>  
>  	if (IS_ERR(acl)) {
>  		/*
> diff --git a/fs/reiserfs/acl.h b/fs/reiserfs/acl.h
> index fd58618da360..bf10841b892d 100644
> --- a/fs/reiserfs/acl.h
> +++ b/fs/reiserfs/acl.h
> @@ -48,7 +48,7 @@ static inline int reiserfs_acl_count(size_t size)
>  }
>  
>  #ifdef CONFIG_REISERFS_FS_POSIX_ACL
> -struct posix_acl *reiserfs_get_acl(struct inode *inode, int type);
> +struct posix_acl *reiserfs_get_acl(struct inode *inode, int type, int flags);
>  int reiserfs_set_acl(struct user_namespace *mnt_userns, struct inode *inode,
>  		     struct posix_acl *acl, int type);
>  int reiserfs_acl_chmod(struct inode *inode);
> diff --git a/fs/reiserfs/xattr_acl.c b/fs/reiserfs/xattr_acl.c
> index a9547144a099..0fdb4f531098 100644
> --- a/fs/reiserfs/xattr_acl.c
> +++ b/fs/reiserfs/xattr_acl.c
> @@ -190,13 +190,16 @@ static void *reiserfs_posix_acl_to_disk(const struct posix_acl *acl, size_t * si
>   * inode->i_mutex: down
>   * BKL held [before 2.5.x]
>   */
> -struct posix_acl *reiserfs_get_acl(struct inode *inode, int type)
> +struct posix_acl *reiserfs_get_acl(struct inode *inode, int type, int flags)
>  {
>  	char *name, *value;
>  	struct posix_acl *acl;
>  	int size;
>  	int retval;
>  
> +	if (flags)
> +		return ERR_PTR(-EINVAL);
> +
>  	switch (type) {
>  	case ACL_TYPE_ACCESS:
>  		name = XATTR_NAME_POSIX_ACL_ACCESS;
> diff --git a/fs/xfs/xfs_acl.c b/fs/xfs/xfs_acl.c
> index d02bef24b32b..5f9b541e029d 100644
> --- a/fs/xfs/xfs_acl.c
> +++ b/fs/xfs/xfs_acl.c
> @@ -125,7 +125,7 @@ xfs_acl_to_disk(struct xfs_acl *aclp, const struct posix_acl *acl)
>  }
>  
>  struct posix_acl *
> -xfs_get_acl(struct inode *inode, int type)
> +xfs_get_acl(struct inode *inode, int type, int flags)
>  {
>  	struct xfs_inode	*ip = XFS_I(inode);
>  	struct xfs_mount	*mp = ip->i_mount;
> @@ -137,6 +137,9 @@ xfs_get_acl(struct inode *inode, int type)
>  	};
>  	int			error;
>  
> +	if (flags)
> +		return ERR_PTR(-EINVAL);
> +
>  	trace_xfs_get_acl(ip);
>  
>  	switch (type) {
> diff --git a/fs/xfs/xfs_acl.h b/fs/xfs/xfs_acl.h
> index 7bdb3a4ed798..38f933f2e281 100644
> --- a/fs/xfs/xfs_acl.h
> +++ b/fs/xfs/xfs_acl.h
> @@ -10,13 +10,13 @@ struct inode;
>  struct posix_acl;
>  
>  #ifdef CONFIG_XFS_POSIX_ACL
> -extern struct posix_acl *xfs_get_acl(struct inode *inode, int type);
> +extern struct posix_acl *xfs_get_acl(struct inode *inode, int type, int flags);
>  extern int xfs_set_acl(struct user_namespace *mnt_userns, struct inode *inode,
>  		       struct posix_acl *acl, int type);
>  extern int __xfs_set_acl(struct inode *inode, struct posix_acl *acl, int type);
>  void xfs_forget_acl(struct inode *inode, const char *name);
>  #else
> -static inline struct posix_acl *xfs_get_acl(struct inode *inode, int type)
> +static inline struct posix_acl *xfs_get_acl(struct inode *inode, int type, int flags)
>  {
>  	return NULL;
>  }
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 640574294216..1c56d4fc4efe 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -2065,7 +2065,7 @@ struct inode_operations {
>  	struct dentry * (*lookup) (struct inode *,struct dentry *, unsigned int);
>  	const char * (*get_link) (struct dentry *, struct inode *, struct delayed_call *);
>  	int (*permission) (struct user_namespace *, struct inode *, int);
> -	struct posix_acl * (*get_acl)(struct inode *, int);
> +	struct posix_acl * (*get_acl)(struct inode *, int, int);
>  
>  	int (*readlink) (struct dentry *, char __user *,int);
>  
> -- 
> 2.31.1
> 
