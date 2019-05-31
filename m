Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 561D031568
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 May 2019 21:34:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727322AbfEaTeZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 31 May 2019 15:34:25 -0400
Received: from fieldses.org ([173.255.197.46]:42478 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727199AbfEaTeY (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 31 May 2019 15:34:24 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id 006861E29; Fri, 31 May 2019 15:34:23 -0400 (EDT)
Date:   Fri, 31 May 2019 15:34:23 -0400
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     "Darrick J . Wong" <darrick.wong@oracle.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        Olga Kornievskaia <olga.kornievskaia@gmail.com>,
        Luis Henriques <lhenriques@suse.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        ceph-devel@vger.kernel.org, linux-api@vger.kernel.org,
        Dave Chinner <dchinner@redhat.com>
Subject: Re: [PATCH v2 5/8] vfs: copy_file_range needs to strip setuid bits
Message-ID: <20190531193423.GA3812@fieldses.org>
References: <20190526061100.21761-1-amir73il@gmail.com>
 <20190526061100.21761-6-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190526061100.21761-6-amir73il@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, May 26, 2019 at 09:10:56AM +0300, Amir Goldstein wrote:
> The file we are copying data into needs to have its setuid bit
> stripped before we start the data copy so that unprivileged users
> can't copy data into executables that are run with root privs.
> 
> [Amir] Introduce the helper generic_copy_file_range_prep() modelled
> after generic_remap_file_range_prep(). Helper is called by filesystem
> before the copy_file_range operation and with output inode locked.
> 
> For ceph and for default generic_copy_file_range() implementation there
> is no inode lock held throughout the copy operation, so we do best
> effort and remove setuid bit before copy starts. This does not protect
> suid file from changing if suid bit is set after copy started.

I'm not sure what it would accomplish to make setuid-clearing atomic
with the write.

If an attacker could write concurrently with your setting the setuid
bit, then they could probably also perform the write just before you set
the setuid bit.

I think clearing it at the start is all that's necessary, unless I'm
missing something.

--b.


> 
> Signed-off-by: Dave Chinner <dchinner@redhat.com>
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
>  fs/ceph/file.c     |  9 +++++++++
>  fs/cifs/cifsfs.c   |  9 ++++++---
>  fs/fuse/file.c     |  4 ++++
>  fs/nfs/nfs42proc.c |  8 +++++---
>  fs/read_write.c    | 31 +++++++++++++++++++++++++++++++
>  include/linux/fs.h |  2 ++
>  6 files changed, 57 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/ceph/file.c b/fs/ceph/file.c
> index e87f7b2023af..54cfc877a6ef 100644
> --- a/fs/ceph/file.c
> +++ b/fs/ceph/file.c
> @@ -1947,6 +1947,15 @@ static ssize_t __ceph_copy_file_range(struct file *src_file, loff_t src_off,
>  		goto out;
>  	}
>  
> +	/* Should inode lock be held throughout the copy operation? */
> +	inode_lock(dst_inode);
> +	ret = generic_copy_file_range_prep(src_file, dst_file);
> +	inode_unlock(dst_inode);
> +	if (ret < 0) {
> +		dout("failed to copy from src to dst file (%zd)\n", ret);
> +		goto out;
> +	}
> +
>  	/*
>  	 * We need FILE_WR caps for dst_ci and FILE_RD for src_ci as other
>  	 * clients may have dirty data in their caches.  And OSDs know nothing
> diff --git a/fs/cifs/cifsfs.c b/fs/cifs/cifsfs.c
> index c65823270313..e103b499aaa8 100644
> --- a/fs/cifs/cifsfs.c
> +++ b/fs/cifs/cifsfs.c
> @@ -1096,6 +1096,10 @@ ssize_t cifs_file_copychunk_range(unsigned int xid,
>  		goto out;
>  	}
>  
> +	rc = -EOPNOTSUPP;
> +	if (!target_tcon->ses->server->ops->copychunk_range)
> +		goto out;
> +
>  	/*
>  	 * Note: cifs case is easier than btrfs since server responsible for
>  	 * checks for proper open modes and file type and if it wants
> @@ -1107,11 +1111,10 @@ ssize_t cifs_file_copychunk_range(unsigned int xid,
>  	/* should we flush first and last page first */
>  	truncate_inode_pages(&target_inode->i_data, 0);
>  
> -	if (target_tcon->ses->server->ops->copychunk_range)
> +	rc = generic_copy_file_range_prep(src_file, dst_file);
> +	if (!rc)
>  		rc = target_tcon->ses->server->ops->copychunk_range(xid,
>  			smb_file_src, smb_file_target, off, len, destoff);
> -	else
> -		rc = -EOPNOTSUPP;
>  
>  	/* force revalidate of size and timestamps of target file now
>  	 * that target is updated on the server
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index e03901ae729b..3531d4a3d9ec 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -3128,6 +3128,10 @@ static ssize_t __fuse_copy_file_range(struct file *file_in, loff_t pos_in,
>  
>  	inode_lock(inode_out);
>  
> +	err = generic_copy_file_range_prep(file_in, file_out);
> +	if (err)
> +		goto out;
> +
>  	if (fc->writeback_cache) {
>  		err = filemap_write_and_wait_range(inode_out->i_mapping,
>  						   pos_out, pos_out + len);
> diff --git a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
> index 5196bfa7894d..b387951e1d86 100644
> --- a/fs/nfs/nfs42proc.c
> +++ b/fs/nfs/nfs42proc.c
> @@ -345,9 +345,11 @@ ssize_t nfs42_proc_copy(struct file *src, loff_t pos_src,
>  
>  	do {
>  		inode_lock(file_inode(dst));
> -		err = _nfs42_proc_copy(src, src_lock,
> -				dst, dst_lock,
> -				&args, &res);
> +		err = generic_copy_file_range_prep(src, dst);
> +		if (!err)
> +			err = _nfs42_proc_copy(src, src_lock,
> +					       dst, dst_lock,
> +					       &args, &res);
>  		inode_unlock(file_inode(dst));
>  
>  		if (err >= 0)
> diff --git a/fs/read_write.c b/fs/read_write.c
> index b0fb1176b628..e16bcafc0da2 100644
> --- a/fs/read_write.c
> +++ b/fs/read_write.c
> @@ -1565,6 +1565,28 @@ COMPAT_SYSCALL_DEFINE4(sendfile64, int, out_fd, int, in_fd,
>  }
>  #endif
>  
> +/*
> + * Prepare inodes for copy from @file_in to @file_out.
> + *
> + * Caller must hold output inode lock.
> + */
> +int generic_copy_file_range_prep(struct file *file_in, struct file *file_out)
> +{
> +	int ret;
> +
> +	WARN_ON_ONCE(!inode_is_locked(file_inode(file_out)));
> +
> +	/*
> +	 * Clear the security bits if the process is not being run by root.
> +	 * This keeps people from modifying setuid and setgid binaries.
> +	 */
> +	ret = file_remove_privs(file_out);
> +
> +	return ret;
> +
> +}
> +EXPORT_SYMBOL(generic_copy_file_range_prep);
> +
>  /**
>   * generic_copy_file_range - copy data between two files
>   * @file_in:	file structure to read from
> @@ -1590,6 +1612,15 @@ ssize_t generic_copy_file_range(struct file *file_in, loff_t pos_in,
>  				struct file *file_out, loff_t pos_out,
>  				size_t len, unsigned int flags)
>  {
> +	int ret;
> +
> +	/* Should inode lock be held throughout the copy operation? */
> +	inode_lock(file_inode(file_out));
> +	ret = generic_copy_file_range_prep(file_in, file_out);
> +	inode_unlock(file_inode(file_out));
> +	if (ret)
> +		return ret;
> +
>  	return do_splice_direct(file_in, &pos_in, file_out, &pos_out,
>  				len > MAX_RW_COUNT ? MAX_RW_COUNT : len, 0);
>  }
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index e4d382c4342a..3e03a96d9ab6 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -1889,6 +1889,8 @@ extern ssize_t vfs_readv(struct file *, const struct iovec __user *,
>  		unsigned long, loff_t *, rwf_t);
>  extern ssize_t vfs_copy_file_range(struct file *, loff_t , struct file *,
>  				   loff_t, size_t, unsigned int);
> +extern int generic_copy_file_range_prep(struct file *file_in,
> +					struct file *file_out);
>  extern ssize_t generic_copy_file_range(struct file *file_in, loff_t pos_in,
>  				       struct file *file_out, loff_t pos_out,
>  				       size_t len, unsigned int flags);
> -- 
> 2.17.1
