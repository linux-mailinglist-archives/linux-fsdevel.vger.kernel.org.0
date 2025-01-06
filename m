Return-Path: <linux-fsdevel+bounces-38462-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AEC5FA02F08
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jan 2025 18:33:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F4AD163204
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jan 2025 17:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2B271DF25A;
	Mon,  6 Jan 2025 17:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RMzsOHkA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24167E574;
	Mon,  6 Jan 2025 17:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736184793; cv=none; b=Mt2EtULKaDmpWixsLzJPSvk1wGPuZpHj9g4b9b3/72UNWx7BIKydEn/6Ha+EZ5gxAQDaPl2Jzm93Mq6D3GbT30tgjXrvnL0UA07Rxl968r/4qg6ETpj1J72gyuwoApX2/rvdXNmnakTRfcWuy0E8CVIqnI7bvUno2v+GRvXLBic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736184793; c=relaxed/simple;
	bh=a5B9Vyn3GdtW/B3eLbuUPWlZ4hnhRppUBqWmUKJ3FaU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bkGeJIfaA5Lv0qzpAOwEEaysN5LrgggJqQiNrrcqyOroYGAihS3eZ0pOcRPXR70E3F8pUYrLukMe9vVnBnoit/l/fvFA9CGz+sYP9sa1enLfVmuT1vffRfJTz/II1oWKHAgU8itJ3Sqz9VAeeBgnQ4tvHGFGY0rgRgsNZQoEVas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RMzsOHkA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B8CFC4CED2;
	Mon,  6 Jan 2025 17:33:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736184792;
	bh=a5B9Vyn3GdtW/B3eLbuUPWlZ4hnhRppUBqWmUKJ3FaU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RMzsOHkAcW3tYN0Ct5jRj433FSkYo2ITb22ylqVjtyAClPYa6YIibD+nmzZ5oF+sG
	 EG9MkYR2pVts6ok1ffj7tbwDCR+k4jFL1yevoegN7sk7aFJj69FjXzUfIHO0zFGvp2
	 b6rEHj5n9KH/ruUr6YEWXB26z8xRiGGFZU/Ch8yk6zXxVK3aFqZLWEryiQIXQ66PM6
	 CdgwVSCpI2DSLGszU5ffjsc9eLMdftXtAkAJB8v2ReVq4mfz2kQrmqOthuSerqF48O
	 h+f7Wgw7QvMfeQzOx36v4IAI/GB6guTL/6CeouonFuhArNGs41z+3RuVUp6fRCBvP6
	 eNHZ+5kM6NBbQ==
Date: Mon, 6 Jan 2025 09:33:12 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Chandan Babu R <chandan.babu@oracle.com>,
	Hongbo Li <lihongbo22@huawei.com>,
	Ryusuke Konishi <konishi.ryusuke@gmail.com>,
	linux-nilfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: Re: [PATCH 4/4] xfs: report the correct read/write dio alignment for
 reflinked inodes
Message-ID: <20250106173312.GC6174@frogsfrogsfrogs>
References: <20250106151607.954940-1-hch@lst.de>
 <20250106151607.954940-5-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250106151607.954940-5-hch@lst.de>

On Mon, Jan 06, 2025 at 04:15:57PM +0100, Christoph Hellwig wrote:
> For I/O to reflinked blocks we always need to write an entire new
> file system block, and the code enforces the file system block alignment
> for the entire file if it has any reflinked blocks.
> 
> Use the new STATX_DIO_READ_ALIGN flag to report the asymmetric read
> vs write alignments for reflinked files.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/xfs/xfs_iops.c | 24 +++++++++++++++++++++---
>  1 file changed, 21 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
> index 6b0228a21617..053d05f5567d 100644
> --- a/fs/xfs/xfs_iops.c
> +++ b/fs/xfs/xfs_iops.c
> @@ -580,9 +580,27 @@ xfs_report_dioalign(
>  	struct xfs_buftarg	*target = xfs_inode_buftarg(ip);
>  	struct block_device	*bdev = target->bt_bdev;
>  
> -	stat->result_mask |= STATX_DIOALIGN;
> +	stat->result_mask |= STATX_DIOALIGN | STATX_DIO_READ_ALIGN;
>  	stat->dio_mem_align = bdev_dma_alignment(bdev) + 1;
> -	stat->dio_offset_align = bdev_logical_block_size(bdev);
> +	stat->dio_read_offset_align = bdev_logical_block_size(bdev);
> +
> +	/*
> +	 * On COW inodes we are forced to always rewrite an entire file system
> +	 * block or RT extent.
> +	 *
> +	 * Because applications assume they can do sector sized direct writes
> +	 * on XFS we fall back to buffered I/O for sub-block direct I/O in that
> +	 * case.  Because that needs to copy the entire block into the buffer
> +	 * cache it is highly inefficient and can easily lead to page cache
> +	 * invalidation races.
> +	 *
> +	 * Tell applications to avoid this case by reporting the natively
> +	 * supported direct I/O read alignment.
> +	 */
> +	if (xfs_is_cow_inode(ip))
> +		stat->dio_offset_align = xfs_inode_alloc_unitsize(ip);
> +	else
> +		stat->dio_offset_align = stat->dio_read_offset_align;

This is a good improvement!
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

>  }
>  
>  static void
> @@ -658,7 +676,7 @@ xfs_vn_getattr(
>  		stat->rdev = inode->i_rdev;
>  		break;
>  	case S_IFREG:
> -		if (request_mask & STATX_DIOALIGN)
> +		if (request_mask & (STATX_DIOALIGN | STATX_DIO_READ_ALIGN))
>  			xfs_report_dioalign(ip, stat);
>  		if (request_mask & STATX_WRITE_ATOMIC)
>  			xfs_report_atomic_write(ip, stat);
> -- 
> 2.45.2
> 
> 

