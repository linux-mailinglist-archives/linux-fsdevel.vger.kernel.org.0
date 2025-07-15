Return-Path: <linux-fsdevel+bounces-54914-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56125B050F0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 07:28:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE3BD7ACA78
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 05:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 644972D3EDC;
	Tue, 15 Jul 2025 05:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iD8TyC3g"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC0135975;
	Tue, 15 Jul 2025 05:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752557292; cv=none; b=AFg9m4sOcZYxrmQH/9sAKrbQcPfZbbwiqZQZgMR+ZU8xnAGKswDM8kJ+rXE5xZzaZP2Tlc5VAEI5DoxdMntdZtUhdEFf/zZS/42KLEA7RyFKIIlQrPnmwAIseVRD29RVDWCOOOiyKc8Z3vtYBwFSdnNp2KTFeI7S6l4FDrKXlI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752557292; c=relaxed/simple;
	bh=Fg4QHr5nbV2aZx8L9EV+fyurQsVPPodPUNC6K6KJdww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fsLC5r1o5DlXf+e3m+O/dV3NOHTsFdk+fGd99BO11wlGkmL1phoOX+YaKzUsNuAb4d4l57I7lC1L7n8oGBcjcJbqo47hMqe6xLaRqSsk5KGa/OMkQLcQ660EpoWL7Hb0IEkNdLZzDDQVDbXHYheLb9xVNJKOZAopY06RYc095UY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iD8TyC3g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DDC4C4CEE3;
	Tue, 15 Jul 2025 05:28:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752557292;
	bh=Fg4QHr5nbV2aZx8L9EV+fyurQsVPPodPUNC6K6KJdww=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iD8TyC3gHnSdkmAy9IfybIXXI0dow7Pq8ChIFnatGKhnh/uzI26ZfpMiz+Ga9dRYo
	 6rDLSQb9lXESjWAg/nI7u0b+eddc1yI5EVAjEmqsjwuQZvYYaYTs9uOs97ggyAoiPd
	 kjvXx+HAt0mX275WGu4XsUjZq50BZco/FoZqpy7pCbTxCBvs9iYh3KeEXZY0dGMcr3
	 Xe7sZkD5RmJpz9Q0yJBBw+TBRUt1Se2wj8WUt2+1uN8If7El01mjTq5YB6uXhnCiby
	 o97ZgmgYiJMaDtPHPCrPEXTSZJqeexmGYKSwq+JSvo04riK0WcQuadp10+MjUQiZ/V
	 sWQ7VEptyZFZw==
Date: Mon, 14 Jul 2025 22:28:11 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Brian Foster <bfoster@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-mm@kvack.org, hch@infradead.org, willy@infradead.org
Subject: Re: [PATCH v3 5/7] xfs: fill dirty folios on zero range of unwritten
 mappings
Message-ID: <20250715052811.GQ2672049@frogsfrogsfrogs>
References: <20250714204122.349582-1-bfoster@redhat.com>
 <20250714204122.349582-6-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250714204122.349582-6-bfoster@redhat.com>

On Mon, Jul 14, 2025 at 04:41:20PM -0400, Brian Foster wrote:
> Use the iomap folio batch mechanism to select folios to zero on zero
> range of unwritten mappings. Trim the resulting mapping if the batch
> is filled (unlikely for current use cases) to distinguish between a
> range to skip and one that requires another iteration due to a full
> batch.
> 
> Signed-off-by: Brian Foster <bfoster@redhat.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/xfs/xfs_iomap.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
> index b5cf5bc6308d..63054f7ead0e 100644
> --- a/fs/xfs/xfs_iomap.c
> +++ b/fs/xfs/xfs_iomap.c
> @@ -1691,6 +1691,8 @@ xfs_buffered_write_iomap_begin(
>  	struct iomap		*iomap,
>  	struct iomap		*srcmap)
>  {
> +	struct iomap_iter	*iter = container_of(iomap, struct iomap_iter,
> +						     iomap);
>  	struct xfs_inode	*ip = XFS_I(inode);
>  	struct xfs_mount	*mp = ip->i_mount;
>  	xfs_fileoff_t		offset_fsb = XFS_B_TO_FSBT(mp, offset);
> @@ -1762,6 +1764,7 @@ xfs_buffered_write_iomap_begin(
>  	 */
>  	if (flags & IOMAP_ZERO) {
>  		xfs_fileoff_t eof_fsb = XFS_B_TO_FSB(mp, XFS_ISIZE(ip));
> +		u64 end;
>  
>  		if (isnullstartblock(imap.br_startblock) &&
>  		    offset_fsb >= eof_fsb)
> @@ -1769,6 +1772,26 @@ xfs_buffered_write_iomap_begin(
>  		if (offset_fsb < eof_fsb && end_fsb > eof_fsb)
>  			end_fsb = eof_fsb;
>  
> +		/*
> +		 * Look up dirty folios for unwritten mappings within EOF.
> +		 * Providing this bypasses the flush iomap uses to trigger
> +		 * extent conversion when unwritten mappings have dirty
> +		 * pagecache in need of zeroing.
> +		 *
> +		 * Trim the mapping to the end pos of the lookup, which in turn
> +		 * was trimmed to the end of the batch if it became full before
> +		 * the end of the mapping.
> +		 */
> +		if (imap.br_state == XFS_EXT_UNWRITTEN &&
> +		    offset_fsb < eof_fsb) {
> +			loff_t len = min(count,
> +					 XFS_FSB_TO_B(mp, imap.br_blockcount));
> +
> +			end = iomap_fill_dirty_folios(iter, offset, len);
> +			end_fsb = min_t(xfs_fileoff_t, end_fsb,
> +					XFS_B_TO_FSB(mp, end));

Hrmm.  XFS_B_TO_FSB and not _FSBT?  Can the rounding up behavior result
in a missed byte range?  I think the answer is no because @end should be
aligned to a folio boundary, and folios can't be smaller than an
fsblock.

If the answer to the second question is indeed "no" then I think this is
ok and
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D


> +		}
> +
>  		xfs_trim_extent(&imap, offset_fsb, end_fsb - offset_fsb);
>  	}
>  
> -- 
> 2.50.0
> 
> 

