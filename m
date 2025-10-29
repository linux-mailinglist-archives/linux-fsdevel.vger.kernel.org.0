Return-Path: <linux-fsdevel+bounces-66294-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 099C9C1A997
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 14:19:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFD871883FD3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 13:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D89229E0F7;
	Wed, 29 Oct 2025 13:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nMnKmgbU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51D9329ACFD;
	Wed, 29 Oct 2025 13:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761743067; cv=none; b=nn1jA5KY+rsEyVaSwgqOfytNUXF9pz7wOdDMUVvfBhGXcEFqEM31eevHRg/LfHAk5p/YHRMT/SnssndUZq61GlxLVwcjcKReXEESmYFxXmbghFXwjVNEYz+Ij+cocs0w8NWkHf5dyZxNulfGK7U7zZusHibC6R78nHha+9U3EdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761743067; c=relaxed/simple;
	bh=fE8QG9lwew0oeKgQNAFBdRSfba6pmQFQ0pQ1K4aw6h8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PyRHKcmW9MKnvC8Uc8SXzjNmO8JoVxBH095Wo6YRT/vqMASmftIwWwZpUin6T07Mz3d+ta6RhWrTiO6vPAJP8WxwUeq0zSJm42rxRPjXj7t3DU1eIjw80mszZknxqJTP6mpYW9XCFPHiI9MAdxHdkwWxVC+2Uc+pUztjeRZEZQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nMnKmgbU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1BBAC4CEF7;
	Wed, 29 Oct 2025 13:04:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761743066;
	bh=fE8QG9lwew0oeKgQNAFBdRSfba6pmQFQ0pQ1K4aw6h8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nMnKmgbUkMNGtKk2BRBuHSCL2+AIuPvigBhRlrMg0BGXz2TsoBd8SL1+DEB5fZ4/Z
	 ZJXQpx9O/3z47O4apzXbIZ0ZnIPyZ2nNZqV6tfYMJ669PkqdRyLWEObxaIoGzUz24r
	 zjJhRL/jHBdXucZndgexGA0+ikPcr4EBYuI5FX4uUDurP5qojmd8jmqEG4ByLakzHq
	 9rRg60BRMPrsdKSrgzkFejWk+aU/5X3vmtVHCp9n1LEuBnirTWGzoyh8xYduBkdgFw
	 ZH270/i2hB+BCZOJOVXV7ic4idjSDYGTtxC+sK9Ij3e1BZj3Gzxcip1Ggp6mNfFDY6
	 +5GtD6AOdSGeg==
Date: Wed, 29 Oct 2025 14:04:15 +0100
From: Christian Brauner <brauner@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Chuck Lever <chuck.lever@oracle.com>, 
	Alexander Aring <alex.aring@gmail.com>, Trond Myklebust <trondmy@kernel.org>, 
	Anna Schumaker <anna@kernel.org>, Steve French <sfrench@samba.org>, 
	Paulo Alcantara <pc@manguebit.org>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, 
	Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, 
	Bharath SM <bharathsm@microsoft.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
	David Howells <dhowells@redhat.com>, Tyler Hicks <code@tyhicks.com>, NeilBrown <neil@brown.name>, 
	Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
	Amir Goldstein <amir73il@gmail.com>, Namjae Jeon <linkinjeon@kernel.org>, 
	Steve French <smfrench@gmail.com>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Carlos Maiolino <cem@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org, 
	linux-cifs@vger.kernel.org, samba-technical@lists.samba.org, netfs@lists.linux.dev, 
	ecryptfs@vger.kernel.org, linux-unionfs@vger.kernel.org, linux-xfs@vger.kernel.org, 
	netdev@vger.kernel.org
Subject: Re: [PATCH v3 03/13] vfs: allow mkdir to wait for delegation break
 on parent
Message-ID: <20251029-zeltlager-auspuff-0e3070d1a9c3@brauner>
References: <20251021-dir-deleg-ro-v3-0-a08b1cde9f4c@kernel.org>
 <20251021-dir-deleg-ro-v3-3-a08b1cde9f4c@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251021-dir-deleg-ro-v3-3-a08b1cde9f4c@kernel.org>

On Tue, Oct 21, 2025 at 11:25:38AM -0400, Jeff Layton wrote:
> In order to add directory delegation support, we need to break
> delegations on the parent whenever there is going to be a change in the
> directory.
> 
> Add a new delegated_inode parameter to vfs_mkdir. All of the existing
> callers set that to NULL for now, except for do_mkdirat which will
> properly block until the lease is gone.
> 
> Reviewed-by: Jan Kara <jack@suse.cz>
> Reviewed-by: NeilBrown <neil@brown.name>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  drivers/base/devtmpfs.c  |  2 +-
>  fs/cachefiles/namei.c    |  2 +-
>  fs/ecryptfs/inode.c      |  2 +-
>  fs/init.c                |  2 +-
>  fs/namei.c               | 24 ++++++++++++++++++------
>  fs/nfsd/nfs4recover.c    |  2 +-
>  fs/nfsd/vfs.c            |  2 +-
>  fs/overlayfs/overlayfs.h |  2 +-
>  fs/smb/server/vfs.c      |  2 +-
>  fs/xfs/scrub/orphanage.c |  2 +-
>  include/linux/fs.h       |  2 +-
>  11 files changed, 28 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/base/devtmpfs.c b/drivers/base/devtmpfs.c
> index 9d4e46ad8352257a6a65d85526ebdbf9bf2d4b19..0e79621cb0f79870003b867ca384199171ded4e0 100644
> --- a/drivers/base/devtmpfs.c
> +++ b/drivers/base/devtmpfs.c
> @@ -180,7 +180,7 @@ static int dev_mkdir(const char *name, umode_t mode)
>  	if (IS_ERR(dentry))
>  		return PTR_ERR(dentry);
>  
> -	dentry = vfs_mkdir(&nop_mnt_idmap, d_inode(path.dentry), dentry, mode);
> +	dentry = vfs_mkdir(&nop_mnt_idmap, d_inode(path.dentry), dentry, mode, NULL);
>  	if (!IS_ERR(dentry))
>  		/* mark as kernel-created inode */
>  		d_inode(dentry)->i_private = &thread;
> diff --git a/fs/cachefiles/namei.c b/fs/cachefiles/namei.c
> index d1edb2ac38376c4f9d2a18026450bb3c774f7824..50c0f9c76d1fd4c05db90d7d0d1bad574523ead0 100644
> --- a/fs/cachefiles/namei.c
> +++ b/fs/cachefiles/namei.c
> @@ -130,7 +130,7 @@ struct dentry *cachefiles_get_directory(struct cachefiles_cache *cache,
>  			goto mkdir_error;
>  		ret = cachefiles_inject_write_error();
>  		if (ret == 0)
> -			subdir = vfs_mkdir(&nop_mnt_idmap, d_inode(dir), subdir, 0700);
> +			subdir = vfs_mkdir(&nop_mnt_idmap, d_inode(dir), subdir, 0700, NULL);
>  		else
>  			subdir = ERR_PTR(ret);
>  		if (IS_ERR(subdir)) {
> diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
> index ed1394da8d6bd7065f2a074378331f13fcda17f9..35830b3144f8f71374a78b3e7463b864f4fc216e 100644
> --- a/fs/ecryptfs/inode.c
> +++ b/fs/ecryptfs/inode.c
> @@ -508,7 +508,7 @@ static struct dentry *ecryptfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
>  		goto out;
>  
>  	lower_dentry = vfs_mkdir(&nop_mnt_idmap, lower_dir,
> -				 lower_dentry, mode);
> +				 lower_dentry, mode, NULL);
>  	rc = PTR_ERR(lower_dentry);
>  	if (IS_ERR(lower_dentry))
>  		goto out;
> diff --git a/fs/init.c b/fs/init.c
> index 07f592ccdba868509d0f3aaf9936d8d890fdbec5..895f8a09a71acfd03e11164e3b441a7d4e2de146 100644
> --- a/fs/init.c
> +++ b/fs/init.c
> @@ -233,7 +233,7 @@ int __init init_mkdir(const char *pathname, umode_t mode)
>  	error = security_path_mkdir(&path, dentry, mode);
>  	if (!error) {
>  		dentry = vfs_mkdir(mnt_idmap(path.mnt), path.dentry->d_inode,
> -				  dentry, mode);
> +				  dentry, mode, NULL);
>  		if (IS_ERR(dentry))
>  			error = PTR_ERR(dentry);
>  	}
> diff --git a/fs/namei.c b/fs/namei.c
> index 6e61e0215b34134b1690f864e2719e3f82cf71a8..86cf6eca1f485361c6732974e4103cf5ea721539 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -4407,10 +4407,11 @@ SYSCALL_DEFINE3(mknod, const char __user *, filename, umode_t, mode, unsigned, d
>  
>  /**
>   * vfs_mkdir - create directory returning correct dentry if possible
> - * @idmap:	idmap of the mount the inode was found from
> - * @dir:	inode of the parent directory
> - * @dentry:	dentry of the child directory
> - * @mode:	mode of the child directory
> + * @idmap:		idmap of the mount the inode was found from
> + * @dir:		inode of the parent directory
> + * @dentry:		dentry of the child directory
> + * @mode:		mode of the child directory
> + * @delegated_inode:	returns parent inode, if the inode is delegated.

I wonder if it would be feasible and potentially elegant if delegated
inodes were returned as separate type like struct delegated_inode
similar to the vfsuid_t just a struct wrapper around the inode itself.
The advantage is that it's not possible to accidently abuse this thing
as we're passing that stuff around to try_break_deleg() and so on.

>   *
>   * Create a directory.
>   *
> @@ -4427,7 +4428,8 @@ SYSCALL_DEFINE3(mknod, const char __user *, filename, umode_t, mode, unsigned, d
>   * In case of an error the dentry is dput() and an ERR_PTR() is returned.
>   */
>  struct dentry *vfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
> -			 struct dentry *dentry, umode_t mode)
> +			 struct dentry *dentry, umode_t mode,
> +			 struct inode **delegated_inode)
>  {
>  	int error;
>  	unsigned max_links = dir->i_sb->s_max_links;
> @@ -4450,6 +4452,10 @@ struct dentry *vfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
>  	if (max_links && dir->i_nlink >= max_links)
>  		goto err;
>  
> +	error = try_break_deleg(dir, delegated_inode);
> +	if (error)
> +		goto err;
> +
>  	de = dir->i_op->mkdir(idmap, dir, dentry, mode);
>  	error = PTR_ERR(de);
>  	if (IS_ERR(de))
> @@ -4473,6 +4479,7 @@ int do_mkdirat(int dfd, struct filename *name, umode_t mode)
>  	struct path path;
>  	int error;
>  	unsigned int lookup_flags = LOOKUP_DIRECTORY;
> +	struct inode *delegated_inode = NULL;
>  
>  retry:
>  	dentry = filename_create(dfd, name, &path, lookup_flags);
> @@ -4484,11 +4491,16 @@ int do_mkdirat(int dfd, struct filename *name, umode_t mode)
>  			mode_strip_umask(path.dentry->d_inode, mode));
>  	if (!error) {
>  		dentry = vfs_mkdir(mnt_idmap(path.mnt), path.dentry->d_inode,
> -				  dentry, mode);
> +				   dentry, mode, &delegated_inode);
>  		if (IS_ERR(dentry))
>  			error = PTR_ERR(dentry);
>  	}
>  	end_creating_path(&path, dentry);
> +	if (delegated_inode) {
> +		error = break_deleg_wait(&delegated_inode);
> +		if (!error)
> +			goto retry;
> +	}
>  	if (retry_estale(error, lookup_flags)) {
>  		lookup_flags |= LOOKUP_REVAL;
>  		goto retry;
> diff --git a/fs/nfsd/nfs4recover.c b/fs/nfsd/nfs4recover.c
> index b1005abcb9035b2cf743200808a251b00af7e3f4..423dd102b51198ea7c447be2b9a0a5020c950dba 100644
> --- a/fs/nfsd/nfs4recover.c
> +++ b/fs/nfsd/nfs4recover.c
> @@ -202,7 +202,7 @@ nfsd4_create_clid_dir(struct nfs4_client *clp)
>  		 * as well be forgiving and just succeed silently.
>  		 */
>  		goto out_put;
> -	dentry = vfs_mkdir(&nop_mnt_idmap, d_inode(dir), dentry, S_IRWXU);
> +	dentry = vfs_mkdir(&nop_mnt_idmap, d_inode(dir), dentry, 0700, NULL);
>  	if (IS_ERR(dentry))
>  		status = PTR_ERR(dentry);
>  out_put:
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index 8b2dc7a88aab015d1e39da0dd4e6daf7e276aabe..5f24af289d509bea54a324b8851fa06de6050353 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -1645,7 +1645,7 @@ nfsd_create_locked(struct svc_rqst *rqstp, struct svc_fh *fhp,
>  			nfsd_check_ignore_resizing(iap);
>  		break;
>  	case S_IFDIR:
> -		dchild = vfs_mkdir(&nop_mnt_idmap, dirp, dchild, iap->ia_mode);
> +		dchild = vfs_mkdir(&nop_mnt_idmap, dirp, dchild, iap->ia_mode, NULL);
>  		if (IS_ERR(dchild)) {
>  			host_err = PTR_ERR(dchild);
>  		} else if (d_is_negative(dchild)) {
> diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
> index c8fd5951fc5ece1ae6b3e2a0801ca15f9faf7d72..0f65f9a5d54d4786b39e4f4f30f416d5b9016e70 100644
> --- a/fs/overlayfs/overlayfs.h
> +++ b/fs/overlayfs/overlayfs.h
> @@ -248,7 +248,7 @@ static inline struct dentry *ovl_do_mkdir(struct ovl_fs *ofs,
>  {
>  	struct dentry *ret;
>  
> -	ret = vfs_mkdir(ovl_upper_mnt_idmap(ofs), dir, dentry, mode);
> +	ret = vfs_mkdir(ovl_upper_mnt_idmap(ofs), dir, dentry, mode, NULL);
>  	pr_debug("mkdir(%pd2, 0%o) = %i\n", dentry, mode, PTR_ERR_OR_ZERO(ret));
>  	return ret;
>  }
> diff --git a/fs/smb/server/vfs.c b/fs/smb/server/vfs.c
> index 891ed2dc2b7351a5cb14a2241d71095ffdd03f08..3d2190f26623b23ea79c63410905a3c3ad684048 100644
> --- a/fs/smb/server/vfs.c
> +++ b/fs/smb/server/vfs.c
> @@ -230,7 +230,7 @@ int ksmbd_vfs_mkdir(struct ksmbd_work *work, const char *name, umode_t mode)
>  	idmap = mnt_idmap(path.mnt);
>  	mode |= S_IFDIR;
>  	d = dentry;
> -	dentry = vfs_mkdir(idmap, d_inode(path.dentry), dentry, mode);
> +	dentry = vfs_mkdir(idmap, d_inode(path.dentry), dentry, mode, NULL);
>  	if (IS_ERR(dentry))
>  		err = PTR_ERR(dentry);
>  	else if (d_is_negative(dentry))
> diff --git a/fs/xfs/scrub/orphanage.c b/fs/xfs/scrub/orphanage.c
> index 9c12cb8442311ca26b169e4d1567939ae44a5be0..91c9d07b97f306f57aebb9b69ba564b0c2cb8c17 100644
> --- a/fs/xfs/scrub/orphanage.c
> +++ b/fs/xfs/scrub/orphanage.c
> @@ -167,7 +167,7 @@ xrep_orphanage_create(
>  	 */
>  	if (d_really_is_negative(orphanage_dentry)) {
>  		orphanage_dentry = vfs_mkdir(&nop_mnt_idmap, root_inode,
> -					     orphanage_dentry, 0750);
> +					     orphanage_dentry, 0750, NULL);
>  		error = PTR_ERR(orphanage_dentry);
>  		if (IS_ERR(orphanage_dentry))
>  			goto out_unlock_root;
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index c895146c1444be36e0a779df55622cc38c9419ff..1040df3792794cd353b86558b41618294e25b8a6 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -2113,7 +2113,7 @@ bool inode_owner_or_capable(struct mnt_idmap *idmap,
>  int vfs_create(struct mnt_idmap *, struct inode *,
>  	       struct dentry *, umode_t, bool);
>  struct dentry *vfs_mkdir(struct mnt_idmap *, struct inode *,
> -			 struct dentry *, umode_t);
> +			 struct dentry *, umode_t, struct inode **);
>  int vfs_mknod(struct mnt_idmap *, struct inode *, struct dentry *,
>                umode_t, dev_t);
>  int vfs_symlink(struct mnt_idmap *, struct inode *,
> 
> -- 
> 2.51.0
> 

