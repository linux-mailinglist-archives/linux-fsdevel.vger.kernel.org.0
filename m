Return-Path: <linux-fsdevel+bounces-38668-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D62BA063CA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jan 2025 18:54:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BA501883E43
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jan 2025 17:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1E56200B9C;
	Wed,  8 Jan 2025 17:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uX5Dw/pE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0EF220125C;
	Wed,  8 Jan 2025 17:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736358841; cv=none; b=d3muPuOWBRmx3PgDyVHIYmLiQOPm1h309pYlp9bjeE3hSm6zjeXVHlViLGVDfrDCbnCxmSry317V62Mu8t72zDz6p6VVrhMBLsV9QMv1urykp+/M+1q8vnpuFnGTexDyhEHIpFq1j9zaFVMp83EWfacLPAL2Txj2IgFzSCB6UmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736358841; c=relaxed/simple;
	bh=Q1c3/3DbUd0P+MtXDw49ne6s4AUUeCoRFzfzF/oK9Bc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VnTl8QVSJep5s02XSzcJqX73r7T7u6PkWCzyc5wz5PJMIvzBzuWj2XphRiKv298l1vlzA14b1FMv5jMljZ68KER8uf8po1a6O12bsyuH1Wqv9gWu7e2YcKdC7qHeVJvtB4WMPY/r/+A9t6kwpA17Rk1MRmuttZc9sd8175sScNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uX5Dw/pE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08E20C4CEE1;
	Wed,  8 Jan 2025 17:54:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736358840;
	bh=Q1c3/3DbUd0P+MtXDw49ne6s4AUUeCoRFzfzF/oK9Bc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uX5Dw/pEHtivzEPdMnqzho3rt/SjWveeCKtz5Yv+BXW/ANSBHZuED7sEbBCE8t20a
	 7LDUgEfD9di/OeDCzWIEQ/zMHS0BRiidmyco7cUQ9DBQOircsxFmcKEpdCIs8srkwe
	 eXwxei3299OO+uopDDLWZD4vWzHOYJr25BkERWWV6ApqgwQQXZXYQm07St1k3yY1n6
	 BJmyOk23cpA93KL6XzucVtamFeydDmw4BFRSGzgOHvXH2YUMtOubfZrh+W6Q6AeOrB
	 dcDvFuIvDdU+xaYF6fpjuR5cNyR4eJT975/JsJp8zuP8J18tC7hkEYkEhFrnQB2weq
	 KK+x2X1pCqMzw==
Date: Wed, 8 Jan 2025 09:53:58 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Chandan Babu R <chandan.babu@oracle.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Hongbo Li <lihongbo22@huawei.com>,
	Ryusuke Konishi <konishi.ryusuke@gmail.com>,
	linux-nilfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: Re: [PATCH 4/5] xfs: report the correct read/write dio alignment for
 reflinked inodes
Message-ID: <20250108175358.GA29347@sol.localdomain>
References: <20250108085549.1296733-1-hch@lst.de>
 <20250108085549.1296733-5-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250108085549.1296733-5-hch@lst.de>

On Wed, Jan 08, 2025 at 09:55:32AM +0100, Christoph Hellwig wrote:
> For I/O to reflinked blocks we always need to write an entire new
> file system block, and the code enforces the file system block alignment
> for the entire file if it has any reflinked blocks.
> 
> Use the new STATX_DIO_READ_ALIGN flag to report the asymmetric read
> vs write alignments for reflinked files.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
> ---
>  fs/xfs/xfs_iops.c | 21 ++++++++++++++++++---
>  1 file changed, 18 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
> index 6b0228a21617..40289fe6f5b2 100644
> --- a/fs/xfs/xfs_iops.c
> +++ b/fs/xfs/xfs_iops.c
> @@ -580,9 +580,24 @@ xfs_report_dioalign(
>  	struct xfs_buftarg	*target = xfs_inode_buftarg(ip);
>  	struct block_device	*bdev = target->bt_bdev;
>  
> -	stat->result_mask |= STATX_DIOALIGN;
> +	stat->result_mask |= STATX_DIOALIGN | STATX_DIO_READ_ALIGN;
>  	stat->dio_mem_align = bdev_dma_alignment(bdev) + 1;
> -	stat->dio_offset_align = bdev_logical_block_size(bdev);
> +
> +	/*
> +	 * For COW inodes, we can only perform out of place writes of entire
> +	 * allocation units (blocks or RT extents).
> +	 * For writes smaller than the allocation unit, we must fall back to
> +	 * buffered I/O to perform read-modify-write cycles.  At best this is
> +	 * highly inefficient; at worst it leads to page cache invalidation
> +	 * races.  Tell applications to avoid this by reporting the larger write
> +	 * alignment in dio_offset_align, and the smaller read alignment in
> +	 * dio_read_offset_align.
> +	 */
> +	stat->dio_read_offset_align = bdev_logical_block_size(bdev);
> +	if (xfs_is_cow_inode(ip))
> +		stat->dio_offset_align = xfs_inode_alloc_unitsize(ip);
> +	else
> +		stat->dio_offset_align = stat->dio_read_offset_align;

This contradicts the proposed man page, which says the following about
stx_dio_read_offset_align offset:

          If non-zero this value must be smaller than  stx_dio_offset_align
          which  must be provided by the file system.

The proposed code sets stx_dio_read_offset_align and stx_dio_offset_align to the
same value in some cases.

Perhaps the documentation should say "less than or equal to"?

Also, the claim that stx_dio_offset_align "must be provided by the file system"
if stx_dio_read_offset_align is nonzero should probably be conditional on
STATX_DIOALIGN being provided too.

- Eric

