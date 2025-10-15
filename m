Return-Path: <linux-fsdevel+bounces-64251-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E0EF3BDF850
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Oct 2025 18:02:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 83BBC4F9E51
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Oct 2025 16:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A6332BE632;
	Wed, 15 Oct 2025 16:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uLwXVID7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A36D127144B;
	Wed, 15 Oct 2025 16:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760544121; cv=none; b=s/Bt68eOz5bsA5Cvhmir4BsFAU/cEllecRIYpv4adJQHk/KtGV0p3Q4IZ8WckLop7cTUnKJFgzvXgDQzpxbtkqikQz4HTVx1qNVriOPBN2ZZXzzmy/Ga1RcMzuOqaaINii2qa/T9vfgN8xbQLbv0hC8TClRfKzk4UouyiMNMg9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760544121; c=relaxed/simple;
	bh=Ib8plWshjqLsG29fR6AtQ9r2xzraj9E0iv8tvd4lfz8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N7VxhYwwvp+sNsldrtr7HsushwBBfOej73TMWWx3Cevw5HoXnmUQMGe9O/gjCv135Dt7jbN2SNUJUD4WXolINGAn4G5aa7KqKqszlmpp7Bq6h0lx6Pli2KamiPM//JzOtLGoBVpSJH2Fu9vjs325+gZGmj2lql4L+bt94DqAf+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uLwXVID7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15EC5C4CEF8;
	Wed, 15 Oct 2025 16:01:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760544119;
	bh=Ib8plWshjqLsG29fR6AtQ9r2xzraj9E0iv8tvd4lfz8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uLwXVID7J6t4Rv9G7dC4W2pXTpcm0X4qDwvtPeJ0mY8cQ0yP0HE4IMGRLMGWOlPuZ
	 n6Xnc0z/SiK6bYdQgEbj/tXlFcK5sXF9cFQ8KvMuyU+2J9G27eBZYH5TuYOLXNIE2J
	 qIzK9ICGR2xvC01O2JWBzcNR98P/Gd9fWPoosuHyDeDjQBm/Ts9WhgMSmvilDztM09
	 BEOF7VNY8WpY7lgu2b/iJnmY753f27HjVDq4ivY/C4yFTCNnupHYOFlb+HIbpKl5iw
	 yNYyxnIaPzZloPbTSEL5+0Nsi5ZDbTj19jYrAGXieKH58h8EBhaSFcjp3XG7P3Lwpt
	 WQ/UoETM0hNeA==
Date: Wed, 15 Oct 2025 09:01:58 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Carlos Maiolino <cem@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>, willy@infradead.org,
	dlemoal@kernel.org, hans.holmberg@wdc.com, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 3/3] xfs: set s_min_writeback_pages for zoned file systems
Message-ID: <20251015160158.GA6188@frogsfrogsfrogs>
References: <20251015062728.60104-1-hch@lst.de>
 <20251015062728.60104-4-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251015062728.60104-4-hch@lst.de>

On Wed, Oct 15, 2025 at 03:27:16PM +0900, Christoph Hellwig wrote:
> Set s_min_writeback_pages to the zone size, so that writeback always
> writes up to a full zone.  This ensures that writeback does not add
> spurious file fragmentation when writing back a large number of
> files that are larger than the zone size.
> 
> Fixes: 4e4d52075577 ("xfs: add the zoned space allocator")
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/xfs/xfs_zone_alloc.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/xfs/xfs_zone_alloc.c b/fs/xfs/xfs_zone_alloc.c
> index 1147bacb2da8..0f4e460fd3ea 100644
> --- a/fs/xfs/xfs_zone_alloc.c
> +++ b/fs/xfs/xfs_zone_alloc.c
> @@ -1215,6 +1215,7 @@ xfs_mount_zones(
>  		.mp		= mp,
>  	};
>  	struct xfs_buftarg	*bt = mp->m_rtdev_targp;
> +	xfs_extlen_t		zone_blocks = mp->m_groups[XG_TYPE_RTG].blocks;
>  	int			error;
>  
>  	if (!bt) {
> @@ -1245,10 +1246,12 @@ xfs_mount_zones(
>  		return -ENOMEM;
>  
>  	xfs_info(mp, "%u zones of %u blocks (%u max open zones)",
> -		 mp->m_sb.sb_rgcount, mp->m_groups[XG_TYPE_RTG].blocks,
> -		 mp->m_max_open_zones);
> +		 mp->m_sb.sb_rgcount, zone_blocks, mp->m_max_open_zones);
>  	trace_xfs_zones_mount(mp);
>  
> +	mp->m_super->s_min_writeback_pages =
> +		XFS_FSB_TO_B(mp, zone_blocks) >> PAGE_SHIFT;

Hmm.  The maximum rtgroup (and hence zone) size is 2^31-1 blocks.
That quantity is casted to int64_t by FSB_TO_B, then shifted down by
PAGE_SHIFT.  So I think there's no chance of an overflow here,
especially if s_min_writeback_pages becomes type long.

Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> +
>  	if (bdev_is_zoned(bt->bt_bdev)) {
>  		error = blkdev_report_zones(bt->bt_bdev,
>  				XFS_FSB_TO_BB(mp, mp->m_sb.sb_rtstart),
> -- 
> 2.47.3
> 
> 

