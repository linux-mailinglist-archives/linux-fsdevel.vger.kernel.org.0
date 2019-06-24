Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 974C550986
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jun 2019 13:14:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728981AbfFXLNz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jun 2019 07:13:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:50242 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727103AbfFXLNz (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jun 2019 07:13:55 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id EE700AC20;
        Mon, 24 Jun 2019 11:13:51 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 6211D1E2F23; Mon, 24 Jun 2019 13:13:49 +0200 (CEST)
Date:   Mon, 24 Jun 2019 13:13:49 +0200
From:   Jan Kara <jack@suse.cz>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     matthew.garrett@nebula.com, yuchao0@huawei.com, tytso@mit.edu,
        ard.biesheuvel@linaro.org, josef@toxicpanda.com, clm@fb.com,
        adilger.kernel@dilger.ca, viro@zeniv.linux.org.uk, jack@suse.com,
        dsterba@suse.com, jaegeuk@kernel.org, jk@ozlabs.org,
        reiserfs-devel@vger.kernel.org, linux-efi@vger.kernel.org,
        devel@lists.orangefs.org, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
        linux-mm@kvack.org, linux-nilfs@vger.kernel.org,
        linux-mtd@lists.infradead.org, ocfs2-devel@oss.oracle.com,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/7] mm/fs: don't allow writes to immutable files
Message-ID: <20190624111349.GF32376@quack2.suse.cz>
References: <156116141046.1664939.11424021489724835645.stgit@magnolia>
 <156116141836.1664939.12249697737780481978.stgit@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <156116141836.1664939.12249697737780481978.stgit@magnolia>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 21-06-19 16:56:58, Darrick J. Wong wrote:
> From: Darrick J. Wong <darrick.wong@oracle.com>
> 
> The chattr manpage has this to say about immutable files:
> 
> "A file with the 'i' attribute cannot be modified: it cannot be deleted
> or renamed, no link can be created to this file, most of the file's
> metadata can not be modified, and the file can not be opened in write
> mode."
> 
> Once the flag is set, it is enforced for quite a few file operations,
> such as fallocate, fpunch, fzero, rm, touch, open, etc.  However, we
> don't check for immutability when doing a write(), a PROT_WRITE mmap(),
> a truncate(), or a write to a previously established mmap.
> 
> If a program has an open write fd to a file that the administrator
> subsequently marks immutable, the program still can change the file
> contents.  Weird!
> 
> The ability to write to an immutable file does not follow the manpage
> promise that immutable files cannot be modified.  Worse yet it's
> inconsistent with the behavior of other syscalls which don't allow
> modifications of immutable files.
> 
> Therefore, add the necessary checks to make the write, mmap, and
> truncate behavior consistent with what the manpage says and consistent
> with other syscalls on filesystems which support IMMUTABLE.
> 
> Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>

Looks good to me. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/attr.c    |   13 ++++++-------
>  mm/filemap.c |    3 +++
>  mm/memory.c  |    3 +++
>  mm/mmap.c    |    8 ++++++--
>  4 files changed, 18 insertions(+), 9 deletions(-)
> 
> 
> diff --git a/fs/attr.c b/fs/attr.c
> index d22e8187477f..1fcfdcc5b367 100644
> --- a/fs/attr.c
> +++ b/fs/attr.c
> @@ -233,19 +233,18 @@ int notify_change(struct dentry * dentry, struct iattr * attr, struct inode **de
>  
>  	WARN_ON_ONCE(!inode_is_locked(inode));
>  
> -	if (ia_valid & (ATTR_MODE | ATTR_UID | ATTR_GID | ATTR_TIMES_SET)) {
> -		if (IS_IMMUTABLE(inode) || IS_APPEND(inode))
> -			return -EPERM;
> -	}
> +	if (IS_IMMUTABLE(inode))
> +		return -EPERM;
> +
> +	if ((ia_valid & (ATTR_MODE | ATTR_UID | ATTR_GID | ATTR_TIMES_SET)) &&
> +	    IS_APPEND(inode))
> +		return -EPERM;
>  
>  	/*
>  	 * If utimes(2) and friends are called with times == NULL (or both
>  	 * times are UTIME_NOW), then we need to check for write permission
>  	 */
>  	if (ia_valid & ATTR_TOUCH) {
> -		if (IS_IMMUTABLE(inode))
> -			return -EPERM;
> -
>  		if (!inode_owner_or_capable(inode)) {
>  			error = inode_permission(inode, MAY_WRITE);
>  			if (error)
> diff --git a/mm/filemap.c b/mm/filemap.c
> index aac71aef4c61..dad85e10f5f8 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -2935,6 +2935,9 @@ inline ssize_t generic_write_checks(struct kiocb *iocb, struct iov_iter *from)
>  	loff_t count;
>  	int ret;
>  
> +	if (IS_IMMUTABLE(inode))
> +		return -EPERM;
> +
>  	if (!iov_iter_count(from))
>  		return 0;
>  
> diff --git a/mm/memory.c b/mm/memory.c
> index ddf20bd0c317..4311cfdade90 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -2235,6 +2235,9 @@ static vm_fault_t do_page_mkwrite(struct vm_fault *vmf)
>  
>  	vmf->flags = FAULT_FLAG_WRITE|FAULT_FLAG_MKWRITE;
>  
> +	if (vmf->vma->vm_file && IS_IMMUTABLE(file_inode(vmf->vma->vm_file)))
> +		return VM_FAULT_SIGBUS;
> +
>  	ret = vmf->vma->vm_ops->page_mkwrite(vmf);
>  	/* Restore original flags so that caller is not surprised */
>  	vmf->flags = old_flags;
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 7e8c3e8ae75f..ac1e32205237 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -1483,8 +1483,12 @@ unsigned long do_mmap(struct file *file, unsigned long addr,
>  		case MAP_SHARED_VALIDATE:
>  			if (flags & ~flags_mask)
>  				return -EOPNOTSUPP;
> -			if ((prot&PROT_WRITE) && !(file->f_mode&FMODE_WRITE))
> -				return -EACCES;
> +			if (prot & PROT_WRITE) {
> +				if (!(file->f_mode & FMODE_WRITE))
> +					return -EACCES;
> +				if (IS_IMMUTABLE(file_inode(file)))
> +					return -EPERM;
> +			}
>  
>  			/*
>  			 * Make sure we don't allow writing to an append-only
> 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
