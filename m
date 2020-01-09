Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 38FB9135A34
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jan 2020 14:35:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730542AbgAINfA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Jan 2020 08:35:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:34354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728974AbgAINfA (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Jan 2020 08:35:00 -0500
Received: from tleilax.poochiereds.net (68-20-15-154.lightspeed.rlghnc.sbcglobal.net [68.20.15.154])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0E05F20661;
        Thu,  9 Jan 2020 13:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578576899;
        bh=B5yzemeRMvzL4pKKGwpH7BIBwVJZXFC+F4JbFhOpfek=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=FP854yG1iF6PZ3f6ByuN1p2Ck1GBxOzQ7bJVht0FIaYDlv1ZpMklxdzoRLjXc24xu
         yLKaBtnOxLxgrrHRlvX1FPMkTu5c2imI1AWkgiKt56QokkSQZHzV5fJTLYZBVp6zDp
         o7s2RWwZqfybKsBicS2CNXr6XgOrIP1D8y9ov0kg=
Message-ID: <03e0e79fefcd9e7985a5defce5d5833d3175847a.camel@kernel.org>
Subject: Re: [PATCH v4] fs: Fix page_mkwrite off-by-one errors
From:   Jeff Layton <jlayton@kernel.org>
To:     Andreas Gruenbacher <agruenba@redhat.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Sage Weil <sage@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Richard Weinberger <richard@nod.at>,
        Artem Bityutskiy <dedekind1@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        ceph-devel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-mtd@lists.infradead.org, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        Jan Kara <jack@suse.cz>, YueHaibing <yuehaibing@huawei.com>,
        Arnd Bergmann <arnd@arndb.de>, Chao Yu <yuchao0@huawei.com>
Date:   Thu, 09 Jan 2020 08:34:56 -0500
In-Reply-To: <20200108131528.4279-1-agruenba@redhat.com>
References: <20200108131528.4279-1-agruenba@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.2 (3.34.2-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 2020-01-08 at 14:15 +0100, Andreas Gruenbacher wrote:
> Hi Darrick,
> 
> here's an updated version with the latest feedback incorporated.  Hope
> you find that useful.
> 
> As far as the f2fs merge conflict goes, I've been told by Linus not to
> resolve those kinds of conflicts but to point them out when sending the
> merge request.  So this shouldn't be a big deal.
> 
> Changes:
> 
> * Turn page_mkwrite_check_truncate into a non-inline function.
> * Get rid of now-unused mapping variable in ext4_page_mkwrite.
> * In btrfs_page_mkwrite, don't ignore the return value of
>   block_page_mkwrite_return (no change in behavior).
> * Clean up the f2fs_vm_page_mkwrite changes as suggested by
>   Jaegeuk Kim.
> 
> Thanks,
> Andreas
> 
> --
> 
> The check in block_page_mkwrite that is meant to determine whether an
> offset is within the inode size is off by one.  This bug has been copied
> into iomap_page_mkwrite and several filesystems (ubifs, ext4, f2fs,
> ceph).
> 
> Fix that by introducing a new page_mkwrite_check_truncate helper that
> checks for truncate and computes the bytes in the page up to EOF.  Use
> the helper in the above mentioned filesystems.
> 
> In addition, use the new helper in btrfs as well.
> 
> Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
> Acked-by: David Sterba <dsterba@suse.com> (btrfs)
> Acked-by: Richard Weinberger <richard@nod.at> (ubifs)
> Acked-by: Theodore Ts'o <tytso@mit.edu> (ext4)
> Acked-by: Chao Yu <yuchao0@huawei.com> (f2fs)
> ---
>  fs/btrfs/inode.c        | 16 +++++-----------
>  fs/buffer.c             | 16 +++-------------
>  fs/ceph/addr.c          |  2 +-
>  fs/ext4/inode.c         | 15 ++++-----------
>  fs/f2fs/file.c          | 19 +++++++------------
>  fs/iomap/buffered-io.c  | 18 +++++-------------
>  fs/ubifs/file.c         |  3 +--
>  include/linux/pagemap.h |  2 ++
>  mm/filemap.c            | 28 ++++++++++++++++++++++++++++
>  9 files changed, 56 insertions(+), 63 deletions(-)
> 
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index e3c76645cad7..23e6f614e000 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -9011,16 +9011,15 @@ vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf)
>  		goto out_noreserve;
>  	}
>  
> -	ret = VM_FAULT_NOPAGE; /* make the VM retry the fault */
>  again:
>  	lock_page(page);
> -	size = i_size_read(inode);
>  
> -	if ((page->mapping != inode->i_mapping) ||
> -	    (page_start >= size)) {
> -		/* page got truncated out from underneath us */
> +	ret2 = page_mkwrite_check_truncate(page, inode);
> +	if (ret2 < 0) {
> +		ret = block_page_mkwrite_return(ret2);
>  		goto out_unlock;
>  	}
> +	zero_start = ret2;
>  	wait_on_page_writeback(page);
>  
>  	lock_extent_bits(io_tree, page_start, page_end, &cached_state);
> @@ -9041,6 +9040,7 @@ vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf)
>  		goto again;
>  	}
>  
> +	size = i_size_read(inode);
>  	if (page->index == ((size - 1) >> PAGE_SHIFT)) {
>  		reserved_space = round_up(size - page_start,
>  					  fs_info->sectorsize);
> @@ -9073,12 +9073,6 @@ vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf)
>  	}
>  	ret2 = 0;
>  
> -	/* page is wholly or partially inside EOF */
> -	if (page_start + PAGE_SIZE > size)
> -		zero_start = offset_in_page(size);
> -	else
> -		zero_start = PAGE_SIZE;
> -
>  	if (zero_start != PAGE_SIZE) {
>  		kaddr = kmap(page);
>  		memset(kaddr + zero_start, 0, PAGE_SIZE - zero_start);
> diff --git a/fs/buffer.c b/fs/buffer.c
> index d8c7242426bb..53aabde57ca7 100644
> --- a/fs/buffer.c
> +++ b/fs/buffer.c
> @@ -2499,23 +2499,13 @@ int block_page_mkwrite(struct vm_area_struct *vma, struct vm_fault *vmf,
>  	struct page *page = vmf->page;
>  	struct inode *inode = file_inode(vma->vm_file);
>  	unsigned long end;
> -	loff_t size;
>  	int ret;
>  
>  	lock_page(page);
> -	size = i_size_read(inode);
> -	if ((page->mapping != inode->i_mapping) ||
> -	    (page_offset(page) > size)) {
> -		/* We overload EFAULT to mean page got truncated */
> -		ret = -EFAULT;
> +	ret = page_mkwrite_check_truncate(page, inode);
> +	if (ret < 0)
>  		goto out_unlock;
> -	}
> -
> -	/* page is wholly or partially inside EOF */
> -	if (((page->index + 1) << PAGE_SHIFT) > size)
> -		end = size & ~PAGE_MASK;
> -	else
> -		end = PAGE_SIZE;
> +	end = ret;
>  
>  	ret = __block_write_begin(page, 0, end, get_block);
>  	if (!ret)
> diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
> index 7ab616601141..ef958aa4adb4 100644
> --- a/fs/ceph/addr.c
> +++ b/fs/ceph/addr.c
> @@ -1575,7 +1575,7 @@ static vm_fault_t ceph_page_mkwrite(struct vm_fault *vmf)
>  	do {
>  		lock_page(page);
>  
> -		if ((off > size) || (page->mapping != inode->i_mapping)) {
> +		if (page_mkwrite_check_truncate(page, inode) < 0) {
>  			unlock_page(page);
>  			ret = VM_FAULT_NOPAGE;
>  			break;


You can add my Acked-by on the ceph part.

-- 
Jeff Layton <jlayton@kernel.org>

