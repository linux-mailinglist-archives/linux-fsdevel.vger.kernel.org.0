Return-Path: <linux-fsdevel+bounces-17914-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 100CF8B3B75
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Apr 2024 17:30:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3488D1C2231A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Apr 2024 15:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1132F14900B;
	Fri, 26 Apr 2024 15:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QoSp2oTc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 697E71DFFC;
	Fri, 26 Apr 2024 15:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714145390; cv=none; b=oN0NBkzT0SZhKhmuahI1zJazSU1RiQR+cEVTNlnKawtkk9uIM9k3rmetj0er0RE8cQndMv73ZCmIlCZw6TPQzj7PRU8Wd5jbi9MosywwGpa5E4Sk46/pDLz9hhxhH4nBvp9tIch4Mxltcn9Ki6lHzp6v3YpLT3nx9E+wPMzvkKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714145390; c=relaxed/simple;
	bh=OZSrojHsn8GkyDowOuo52apAxWpSj01mTeLzKxIjld8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dQ8fYpXmMEy3q0SSE4NePYkt0GupQ1CuOdFTk+e1sAZaIXl+uM+J4hRbZbIUfXYDK+gZjEIDVuuVl/0tvqzYhvZRybBBwZOhg9pAj+SPWwRn8pF1FK5RM8Gx0JvIVzBaP6pf8D5476FH/AGnZP6aMaYbKSAMSkNGAm5atuWq2Qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QoSp2oTc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D757AC116B1;
	Fri, 26 Apr 2024 15:29:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714145389;
	bh=OZSrojHsn8GkyDowOuo52apAxWpSj01mTeLzKxIjld8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QoSp2oTcc1mzKixsWldn/pcMmDbKbSKz1AMNcPMCERKtgxDxH5kb1dOnvKesqVLuN
	 tfYAk6gFMq+ut058i+s1zT0tXIN36BSz1RVWgaetSQ0drD/mIN7UX1B+Vb9lX1z3Ea
	 lZPrLmP37H4I6K13C+C+pCriezxRLEWYd6uqpZi5Lh0R5aim/T3qjNE7FphJeNTcWy
	 9QgORl4eWKoGeEMG1Uykes2VGw/pQ6hHym9CdlWLs9YtTqh3tPHu/UEwSuMc5jqqON
	 bxstqt+cFw5GEhjwHssYpu7FdQgUthS+nNWWcqGgKcMcShzDc3SjqkwgPE4mTo+O2+
	 w18WxRtiv8EZw==
Date: Fri, 26 Apr 2024 08:29:49 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc: linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>, Jan Kara <jack@suse.cz>
Subject: Re: [RFCv3 2/7] ext2: Convert ext2 regular file buffered I/O to use
 iomap
Message-ID: <20240426152949.GJ360919@frogsfrogsfrogs>
References: <cover.1714046808.git.ritesh.list@gmail.com>
 <54d3fdabeb82e494fab83204cd49e75b58ef298e.1714046808.git.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54d3fdabeb82e494fab83204cd49e75b58ef298e.1714046808.git.ritesh.list@gmail.com>

On Thu, Apr 25, 2024 at 06:58:46PM +0530, Ritesh Harjani (IBM) wrote:
> This patch converts ext2 regular file's buffered-io path to use iomap.
> - buffered-io path using iomap_file_buffered_write
> - DIO fallback to buffered-io now uses iomap_file_buffered_write
> - writeback path now uses a new aops - ext2_file_aops
> - truncate now uses iomap_truncate_page
> - mmap path of ext2 continues to use generic_file_vm_ops
> 
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> ---
>  fs/ext2/file.c  | 20 ++++++++++++--
>  fs/ext2/inode.c | 69 ++++++++++++++++++++++++++++++++++++++++++++-----
>  2 files changed, 81 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/ext2/file.c b/fs/ext2/file.c
> index 4ddc36f4dbd4..ee5cd4a2f24f 100644
> --- a/fs/ext2/file.c
> +++ b/fs/ext2/file.c
> @@ -252,7 +252,7 @@ static ssize_t ext2_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
>  
>  		iocb->ki_flags &= ~IOCB_DIRECT;
>  		pos = iocb->ki_pos;
> -		status = generic_perform_write(iocb, from);
> +		status = iomap_file_buffered_write(iocb, from, &ext2_iomap_ops);
>  		if (unlikely(status < 0)) {
>  			ret = status;
>  			goto out_unlock;
> @@ -278,6 +278,22 @@ static ssize_t ext2_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
>  	return ret;
>  }
>  
> +static ssize_t ext2_buffered_write_iter(struct kiocb *iocb,
> +					struct iov_iter *from)
> +{
> +	ssize_t ret = 0;
> +	struct inode *inode = file_inode(iocb->ki_filp);
> +
> +	inode_lock(inode);
> +	ret = generic_write_checks(iocb, from);
> +	if (ret > 0)
> +		ret = iomap_file_buffered_write(iocb, from, &ext2_iomap_ops);
> +	inode_unlock(inode);
> +	if (ret > 0)
> +		ret = generic_write_sync(iocb, ret);
> +	return ret;
> +}
> +
>  static ssize_t ext2_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
>  {
>  #ifdef CONFIG_FS_DAX
> @@ -299,7 +315,7 @@ static ssize_t ext2_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
>  	if (iocb->ki_flags & IOCB_DIRECT)
>  		return ext2_dio_write_iter(iocb, from);
>  
> -	return generic_file_write_iter(iocb, from);
> +	return ext2_buffered_write_iter(iocb, from);
>  }
>  
>  const struct file_operations ext2_file_operations = {
> diff --git a/fs/ext2/inode.c b/fs/ext2/inode.c
> index c4de3a94c4b2..f90d280025d9 100644
> --- a/fs/ext2/inode.c
> +++ b/fs/ext2/inode.c
> @@ -877,10 +877,14 @@ ext2_iomap_end(struct inode *inode, loff_t offset, loff_t length,
>  	if ((flags & IOMAP_DIRECT) && (flags & IOMAP_WRITE) && written == 0)
>  		return -ENOTBLK;
>  
> -	if (iomap->type == IOMAP_MAPPED &&
> -	    written < length &&
> -	    (flags & IOMAP_WRITE))
> +	if (iomap->type == IOMAP_MAPPED && written < length &&
> +	   (flags & IOMAP_WRITE)) {
>  		ext2_write_failed(inode->i_mapping, offset + length);
> +		return 0;
> +	}
> +
> +	if (iomap->flags & IOMAP_F_SIZE_CHANGED)
> +		mark_inode_dirty(inode);
>  	return 0;
>  }
>  
> @@ -912,6 +916,16 @@ static void ext2_readahead(struct readahead_control *rac)
>  	mpage_readahead(rac, ext2_get_block);
>  }
>  
> +static int ext2_file_read_folio(struct file *file, struct folio *folio)
> +{
> +	return iomap_read_folio(folio, &ext2_iomap_ops);
> +}
> +
> +static void ext2_file_readahead(struct readahead_control *rac)
> +{
> +	iomap_readahead(rac, &ext2_iomap_ops);
> +}
> +
>  static int
>  ext2_write_begin(struct file *file, struct address_space *mapping,
>  		loff_t pos, unsigned len, struct page **pagep, void **fsdata)
> @@ -941,12 +955,41 @@ static sector_t ext2_bmap(struct address_space *mapping, sector_t block)
>  	return generic_block_bmap(mapping,block,ext2_get_block);
>  }
>  
> +static sector_t ext2_file_bmap(struct address_space *mapping, sector_t block)
> +{
> +	return iomap_bmap(mapping, block, &ext2_iomap_ops);
> +}
> +
>  static int
>  ext2_writepages(struct address_space *mapping, struct writeback_control *wbc)
>  {
>  	return mpage_writepages(mapping, wbc, ext2_get_block);
>  }
>  
> +static int ext2_write_map_blocks(struct iomap_writepage_ctx *wpc,
> +				 struct inode *inode, loff_t offset,
> +				 unsigned len)
> +{
> +	if (offset >= wpc->iomap.offset &&
> +	    offset < wpc->iomap.offset + wpc->iomap.length)
> +		return 0;
> +
> +	return ext2_iomap_begin(inode, offset, inode->i_sb->s_blocksize,
> +				IOMAP_WRITE, &wpc->iomap, NULL);
> +}

Soooo... this is almost a directio write of the pagecache? ;)

> +
> +static const struct iomap_writeback_ops ext2_writeback_ops = {
> +	.map_blocks		= ext2_write_map_blocks,
> +};
> +
> +static int ext2_file_writepages(struct address_space *mapping,
> +				struct writeback_control *wbc)
> +{
> +	struct iomap_writepage_ctx wpc = { };
> +
> +	return iomap_writepages(mapping, wbc, &wpc, &ext2_writeback_ops);
> +}
> +
>  static int
>  ext2_dax_writepages(struct address_space *mapping, struct writeback_control *wbc)
>  {
> @@ -955,6 +998,20 @@ ext2_dax_writepages(struct address_space *mapping, struct writeback_control *wbc
>  	return dax_writeback_mapping_range(mapping, sbi->s_daxdev, wbc);
>  }
>  
> +const struct address_space_operations ext2_file_aops = {
> +	.dirty_folio		= iomap_dirty_folio,
> +	.release_folio 		= iomap_release_folio,

trailing space here   ^

> +	.invalidate_folio	= iomap_invalidate_folio,
> +	.read_folio		= ext2_file_read_folio,
> +	.readahead		= ext2_file_readahead,
> +	.bmap			= ext2_file_bmap,
> +	.direct_IO		= noop_direct_IO,

Nowadays, it is preferred to set FMODE_CAN_ODIRECT and skip setting
->direct_IO.  But I see that ext2 hasn't been converted, so this is a
minor point.

> +	.writepages		= ext2_file_writepages,
> +	.migrate_folio		= filemap_migrate_folio,
> +	.is_partially_uptodate	= iomap_is_partially_uptodate,
> +	.error_remove_folio	= generic_error_remove_folio,
> +};
> +
>  const struct address_space_operations ext2_aops = {

I wonder, could directories and symlinks get converted to iomap at some
point?  (It's ok if that is not in scope for this series.)

Looks good to me,
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

>  	.dirty_folio		= block_dirty_folio,
>  	.invalidate_folio	= block_invalidate_folio,
> @@ -1279,8 +1336,8 @@ static int ext2_setsize(struct inode *inode, loff_t newsize)
>  		error = dax_truncate_page(inode, newsize, NULL,
>  					  &ext2_iomap_ops);
>  	else
> -		error = block_truncate_page(inode->i_mapping,
> -				newsize, ext2_get_block);
> +		error = iomap_truncate_page(inode, newsize, NULL,
> +					    &ext2_iomap_ops);
>  	if (error)
>  		return error;
>  
> @@ -1370,7 +1427,7 @@ void ext2_set_file_ops(struct inode *inode)
>  	if (IS_DAX(inode))
>  		inode->i_mapping->a_ops = &ext2_dax_aops;
>  	else
> -		inode->i_mapping->a_ops = &ext2_aops;
> +		inode->i_mapping->a_ops = &ext2_file_aops;
>  }
>  
>  struct inode *ext2_iget (struct super_block *sb, unsigned long ino)
> -- 
> 2.44.0
> 
> 

