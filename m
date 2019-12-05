Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A1B0B114476
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Dec 2019 17:08:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730052AbfLEQIX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Dec 2019 11:08:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:44856 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730020AbfLEQIX (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Dec 2019 11:08:23 -0500
Received: from tleilax.poochiereds.net (68-20-15-154.lightspeed.rlghnc.sbcglobal.net [68.20.15.154])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EEFA624249;
        Thu,  5 Dec 2019 16:08:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575562101;
        bh=4BBbM4w57ZUGYAZen6Z4sS7m2spu0jjZRJ7n/AxkzNQ=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=dO9ySgKuhd+dTs2uIHnmBXmTkx0+ZaIVZNTu8iWwCnF73ueH7IvQFP4butiJMIPWF
         DrHILJMHUlFjMuOZuIePpNG09ojuE33AD3P3sEdbn/qU8mR8Kn5MD046didGRRAJv4
         rfh3B8BnmLPWjGlyroSsRsXW6d5MmvBprLYDPcEY=
Message-ID: <388342be7cd03e34bcccb1287d790cac04376e85.camel@kernel.org>
Subject: Re: [PATCH 1/1] fs: Use inode_lock/unlock class of provided APIs in
 filesystems
From:   Jeff Layton <jlayton@kernel.org>
To:     Ritesh Harjani <riteshh@linux.ibm.com>, willy@infradead.org,
        linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk
Cc:     ceph-devel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-nfs@vger.kernel.org, devel@lists.orangefs.org,
        linux-unionfs@vger.kernel.org
Date:   Thu, 05 Dec 2019 11:08:19 -0500
In-Reply-To: <20191205103902.23618-2-riteshh@linux.ibm.com>
References: <20191205103902.23618-1-riteshh@linux.ibm.com>
         <20191205103902.23618-2-riteshh@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.2 (3.34.2-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 2019-12-05 at 16:09 +0530, Ritesh Harjani wrote:
> This defines 4 more APIs which some of the filesystem needs
> and reduces the direct use of i_rwsem in filesystem drivers.
> Instead those are replaced with inode_lock/unlock_** APIs.
> 
> Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
> ---
>  fs/btrfs/delayed-inode.c |  2 +-
>  fs/btrfs/ioctl.c         |  4 ++--
>  fs/ceph/io.c             | 24 ++++++++++++------------
>  fs/nfs/io.c              | 24 ++++++++++++------------
>  fs/orangefs/file.c       |  4 ++--
>  fs/overlayfs/readdir.c   |  2 +-
>  fs/readdir.c             |  4 ++--
>  include/linux/fs.h       | 21 +++++++++++++++++++++
>  8 files changed, 53 insertions(+), 32 deletions(-)
> 
> diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
> index d3e15e1d4a91..c3e92f2fd915 100644
> --- a/fs/btrfs/delayed-inode.c
> +++ b/fs/btrfs/delayed-inode.c
> @@ -1644,7 +1644,7 @@ void btrfs_readdir_put_delayed_items(struct inode *inode,
>  	 * The VFS is going to do up_read(), so we need to downgrade back to a
>  	 * read lock.
>  	 */
> -	downgrade_write(&inode->i_rwsem);
> +	inode_lock_downgrade(inode);
>  }
>  
>  int btrfs_should_delete_dir_index(struct list_head *del_list,
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index a1ee0b775e65..1cbd763a46d8 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -955,7 +955,7 @@ static noinline int btrfs_mksubvol(const struct path *parent,
>  	struct dentry *dentry;
>  	int error;
>  
> -	error = down_write_killable_nested(&dir->i_rwsem, I_MUTEX_PARENT);
> +	error = inode_lock_killable_nested(dir, I_MUTEX_PARENT);
>  	if (error == -EINTR)
>  		return error;
>  
> @@ -2863,7 +2863,7 @@ static noinline int btrfs_ioctl_snap_destroy(struct file *file,
>  		goto out;
>  
>  
> -	err = down_write_killable_nested(&dir->i_rwsem, I_MUTEX_PARENT);
> +	err = inode_lock_killable_nested(dir, I_MUTEX_PARENT);
>  	if (err == -EINTR)
>  		goto out_drop_write;
>  	dentry = lookup_one_len(vol_args->name, parent, namelen);
> diff --git a/fs/ceph/io.c b/fs/ceph/io.c
> index 97602ea92ff4..e94186259c2e 100644
> --- a/fs/ceph/io.c
> +++ b/fs/ceph/io.c
> @@ -53,14 +53,14 @@ ceph_start_io_read(struct inode *inode)
>  	struct ceph_inode_info *ci = ceph_inode(inode);
>  
>  	/* Be an optimist! */
> -	down_read(&inode->i_rwsem);
> +	inode_lock_shared(inode);
>  	if (!(READ_ONCE(ci->i_ceph_flags) & CEPH_I_ODIRECT))
>  		return;
> -	up_read(&inode->i_rwsem);
> +	inode_unlock_shared(inode);
>  	/* Slow path.... */
> -	down_write(&inode->i_rwsem);
> +	inode_lock(inode);
>  	ceph_block_o_direct(ci, inode);
> -	downgrade_write(&inode->i_rwsem);
> +	inode_lock_downgrade(inode);
>  }
>  
>  /**
> @@ -73,7 +73,7 @@ ceph_start_io_read(struct inode *inode)
>  void
>  ceph_end_io_read(struct inode *inode)
>  {
> -	up_read(&inode->i_rwsem);
> +	inode_unlock_shared(inode);
>  }
>  
>  /**
> @@ -86,7 +86,7 @@ ceph_end_io_read(struct inode *inode)
>  void
>  ceph_start_io_write(struct inode *inode)
>  {
> -	down_write(&inode->i_rwsem);
> +	inode_lock(inode);
>  	ceph_block_o_direct(ceph_inode(inode), inode);
>  }
>  
> @@ -100,7 +100,7 @@ ceph_start_io_write(struct inode *inode)
>  void
>  ceph_end_io_write(struct inode *inode)
>  {
> -	up_write(&inode->i_rwsem);
> +	inode_unlock(inode);
>  }
>  
>  /* Call with exclusively locked inode->i_rwsem */
> @@ -139,14 +139,14 @@ ceph_start_io_direct(struct inode *inode)
>  	struct ceph_inode_info *ci = ceph_inode(inode);
>  
>  	/* Be an optimist! */
> -	down_read(&inode->i_rwsem);
> +	inode_lock_shared(inode);
>  	if (READ_ONCE(ci->i_ceph_flags) & CEPH_I_ODIRECT)
>  		return;
> -	up_read(&inode->i_rwsem);
> +	inode_unlock_shared(inode);
>  	/* Slow path.... */
> -	down_write(&inode->i_rwsem);
> +	inode_lock(inode);
>  	ceph_block_buffered(ci, inode);
> -	downgrade_write(&inode->i_rwsem);
> +	inode_lock_downgrade(inode);
>  }
>  
>  /**
> @@ -159,5 +159,5 @@ ceph_start_io_direct(struct inode *inode)
>  void
>  ceph_end_io_direct(struct inode *inode)
>  {
> -	up_read(&inode->i_rwsem);
> +	inode_unlock_shared(inode);
>  }
> diff --git a/fs/nfs/io.c b/fs/nfs/io.c
> index 5088fda9b453..bf5ed7bea59d 100644
> --- a/fs/nfs/io.c
> +++ b/fs/nfs/io.c
> @@ -44,14 +44,14 @@ nfs_start_io_read(struct inode *inode)
>  {
>  	struct nfs_inode *nfsi = NFS_I(inode);
>  	/* Be an optimist! */
> -	down_read(&inode->i_rwsem);
> +	inode_lock_shared(inode);
>  	if (test_bit(NFS_INO_ODIRECT, &nfsi->flags) == 0)
>  		return;
> -	up_read(&inode->i_rwsem);
> +	inode_unlock_shared(inode);
>  	/* Slow path.... */
> -	down_write(&inode->i_rwsem);
> +	inode_lock(inode);
>  	nfs_block_o_direct(nfsi, inode);
> -	downgrade_write(&inode->i_rwsem);
> +	inode_lock_downgrade(inode);
>  }
>  
>  /**
> @@ -64,7 +64,7 @@ nfs_start_io_read(struct inode *inode)
>  void
>  nfs_end_io_read(struct inode *inode)
>  {
> -	up_read(&inode->i_rwsem);
> +	inode_unlock_shared(inode);
>  }
>  
>  /**
> @@ -77,7 +77,7 @@ nfs_end_io_read(struct inode *inode)
>  void
>  nfs_start_io_write(struct inode *inode)
>  {
> -	down_write(&inode->i_rwsem);
> +	inode_lock(inode);
>  	nfs_block_o_direct(NFS_I(inode), inode);
>  }
>  
> @@ -91,7 +91,7 @@ nfs_start_io_write(struct inode *inode)
>  void
>  nfs_end_io_write(struct inode *inode)
>  {
> -	up_write(&inode->i_rwsem);
> +	inode_unlock(inode);
>  }
>  
>  /* Call with exclusively locked inode->i_rwsem */
> @@ -124,14 +124,14 @@ nfs_start_io_direct(struct inode *inode)
>  {
>  	struct nfs_inode *nfsi = NFS_I(inode);
>  	/* Be an optimist! */
> -	down_read(&inode->i_rwsem);
> +	inode_lock_shared(inode);
>  	if (test_bit(NFS_INO_ODIRECT, &nfsi->flags) != 0)
>  		return;
> -	up_read(&inode->i_rwsem);
> +	inode_unlock_shared(inode);
>  	/* Slow path.... */
> -	down_write(&inode->i_rwsem);
> +	inode_lock(inode);
>  	nfs_block_buffered(nfsi, inode);
> -	downgrade_write(&inode->i_rwsem);
> +	inode_lock_downgrade(inode);
>  }
>  
>  /**
> @@ -144,5 +144,5 @@ nfs_start_io_direct(struct inode *inode)
>  void
>  nfs_end_io_direct(struct inode *inode)
>  {
> -	up_read(&inode->i_rwsem);
> +	inode_unlock_shared(inode);
>  }
> diff --git a/fs/orangefs/file.c b/fs/orangefs/file.c
> index a5612abc0936..6420503e1275 100644
> --- a/fs/orangefs/file.c
> +++ b/fs/orangefs/file.c
> @@ -328,14 +328,14 @@ static ssize_t orangefs_file_read_iter(struct kiocb *iocb,
>  		ro->blksiz = iter->count;
>  	}
>  
> -	down_read(&file_inode(iocb->ki_filp)->i_rwsem);
> +	inode_lock_shared(file_inode(iocb->ki_filp));
>  	ret = orangefs_revalidate_mapping(file_inode(iocb->ki_filp));
>  	if (ret)
>  		goto out;
>  
>  	ret = generic_file_read_iter(iocb, iter);
>  out:
> -	up_read(&file_inode(iocb->ki_filp)->i_rwsem);
> +	inode_unlock_shared(file_inode(iocb->ki_filp));
>  	return ret;
>  }
>  
> diff --git a/fs/overlayfs/readdir.c b/fs/overlayfs/readdir.c
> index 47a91c9733a5..c203e73160b0 100644
> --- a/fs/overlayfs/readdir.c
> +++ b/fs/overlayfs/readdir.c
> @@ -273,7 +273,7 @@ static int ovl_check_whiteouts(struct dentry *dir, struct ovl_readdir_data *rdd)
>  
>  	old_cred = ovl_override_creds(rdd->dentry->d_sb);
>  
> -	err = down_write_killable(&dir->d_inode->i_rwsem);
> +	err = inode_lock_killable(dir->d_inode);
>  	if (!err) {
>  		while (rdd->first_maybe_whiteout) {
>  			p = rdd->first_maybe_whiteout;
> diff --git a/fs/readdir.c b/fs/readdir.c
> index d26d5ea4de7b..10a34efa0af0 100644
> --- a/fs/readdir.c
> +++ b/fs/readdir.c
> @@ -52,9 +52,9 @@ int iterate_dir(struct file *file, struct dir_context *ctx)
>  		goto out;
>  
>  	if (shared)
> -		res = down_read_killable(&inode->i_rwsem);
> +		res = inode_lock_shared_killable(inode);
>  	else
> -		res = down_write_killable(&inode->i_rwsem);
> +		res = inode_lock_killable(inode);
>  	if (res)
>  		goto out;
>  
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 98e0349adb52..2b407464fac1 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -831,6 +831,27 @@ static inline void inode_lock_shared_nested(struct inode *inode, unsigned subcla
>  	down_read_nested(&inode->i_rwsem, subclass);
>  }
>  
> +static inline void inode_lock_downgrade(struct inode *inode)
> +{
> +	downgrade_write(&inode->i_rwsem);
> +}
> +
> +static inline int inode_lock_killable(struct inode *inode)
> +{
> +	return down_write_killable(&inode->i_rwsem);
> +}
> +
> +static inline int inode_lock_shared_killable(struct inode *inode)
> +{
> +	return down_read_killable(&inode->i_rwsem);
> +}
> +
> +static inline int inode_lock_killable_nested(struct inode *inode,
> +					     unsigned subclass)
> +{
> +	return down_write_killable_nested(&inode->i_rwsem, subclass);
> +}
> +
>  void lock_two_nondirectories(struct inode *, struct inode*);
>  void unlock_two_nondirectories(struct inode *, struct inode*);
>  

Nice little cleanup.

Reviewed-by: Jeff Layton <jlayton@kernel.org>

