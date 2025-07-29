Return-Path: <linux-fsdevel+bounces-56288-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4769FB1554F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Jul 2025 00:33:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61EE956083B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Jul 2025 22:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE4A9265CA2;
	Tue, 29 Jul 2025 22:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MeHwVQEJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34FFE125B2;
	Tue, 29 Jul 2025 22:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753828388; cv=none; b=tOcaj6ZwdlmPTP7EJzSt7PucIMwpk5urrLLoWH5VlQwLcztXdAo9fIt1lyLeGdPLmtspgg70vxo43NRk3Umt8EwhEh9encnIAWe3QCr7x1zbzQM7cf1KwWY6kcdfTuBZyOxELLbdlLDujF8QABLnzXaTNWaUhxpg8U+xlCbGats=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753828388; c=relaxed/simple;
	bh=ZjZ3r1uxA/Z8/ovTFJEd9CzOFrEmUcsWB1pWpXSJy64=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F4SMKktBKAZ8aJgu9F0sx5/wecOA9LmlRu3xmtJ1+JO1FFioAUGqs/AVTx+iDqS8Gc1WBNwvXOyqYY9nRFUzjpvQRt/IDwlR652g3m9l1p8HRCFMj5DOhofE3CJ/QYD7jvJvram3ZhOOK8nq60AmXLaQnMP3MhjVzp/glthGIG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MeHwVQEJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A839C4CEEF;
	Tue, 29 Jul 2025 22:33:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753828388;
	bh=ZjZ3r1uxA/Z8/ovTFJEd9CzOFrEmUcsWB1pWpXSJy64=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MeHwVQEJlDTEkg36VCdVFZAze1gRFTYQ1t+c4grZbNvxx/PHxzcOUrFeW37+v4tP6
	 vntbI22zaHi/e7T4Bl71OCa0bsjK6BLJ+vr8E0TmUI6E0/BSRcWm2XTTpAmuK1I/Eo
	 RfIbk7D4MlsyREpIlC1dnlGwXkH7oe/XdekSnLQr+pFj5dK9M0NjTlhk5cLgnycvDs
	 4rEIZTi8V3P3l0VK0rKhfY1hZTvpwfxrQGdTyUa6dhrftlCo3K9zL6F6Fpff/nWG5H
	 BjTUsxJGo0j8jaWplz4l5nEgxpkVEFLLVgmpJcfqm6WLRKovFbiMCVp+OmXvlBIUtR
	 DCMCP7nvZao1w==
Date: Tue, 29 Jul 2025 15:33:07 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Andrey Albershteyn <aalbersh@redhat.com>
Cc: fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org, david@fromorbit.com, ebiggers@kernel.org,
	hch@lst.de, Andrey Albershteyn <aalbersh@kernel.org>
Subject: Re: [PATCH RFC 21/29] xfs: add writeback and iomap reading of Merkel
 tree pages
Message-ID: <20250729223307.GL2672049@frogsfrogsfrogs>
References: <20250728-fsverity-v1-0-9e5443af0e34@kernel.org>
 <20250728-fsverity-v1-21-9e5443af0e34@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250728-fsverity-v1-21-9e5443af0e34@kernel.org>

> Subject: [PATCH RFC 21/29] xfs: add writeback and iomap reading of Merkel tree pages

s/Merkel/Merkle/

On Mon, Jul 28, 2025 at 10:30:25PM +0200, Andrey Albershteyn wrote:
> In the writeback path use unbound write interface, meaning that inode
> size is not updated and none of the file size checks are applied.
> 
> In read path let iomap know that data is stored beyond EOF via flag.
> This leads to skipping of post EOF zeroing.
> 
> Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
> ---
>  fs/xfs/xfs_aops.c  | 21 ++++++++++++++-------
>  fs/xfs/xfs_iomap.c |  9 +++++++--
>  2 files changed, 21 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
> index 63151feb9c3f..02e2c04b36c1 100644
> --- a/fs/xfs/xfs_aops.c
> +++ b/fs/xfs/xfs_aops.c
> @@ -22,6 +22,7 @@
>  #include "xfs_icache.h"
>  #include "xfs_zone_alloc.h"
>  #include "xfs_rtgroup.h"
> +#include "xfs_fsverity.h"
>  
>  struct xfs_writepage_ctx {
>  	struct iomap_writepage_ctx ctx;
> @@ -628,10 +629,12 @@ static const struct iomap_writeback_ops xfs_zoned_writeback_ops = {
>  
>  STATIC int
>  xfs_vm_writepages(
> -	struct address_space	*mapping,
> -	struct writeback_control *wbc)
> +	struct address_space		*mapping,
> +	struct writeback_control	*wbc)
>  {
> -	struct xfs_inode	*ip = XFS_I(mapping->host);
> +	struct xfs_inode		*ip = XFS_I(mapping->host);
> +	struct xfs_writepage_ctx	wpc = { };
> +
>  
>  	xfs_iflags_clear(ip, XFS_ITRUNCATED);
>  
> @@ -644,12 +647,16 @@ xfs_vm_writepages(
>  		if (xc.open_zone)
>  			xfs_open_zone_put(xc.open_zone);
>  		return error;
> -	} else {
> -		struct xfs_writepage_ctx	wpc = { };
> +	}
>  
> -		return iomap_writepages(mapping, wbc, &wpc.ctx,
> -				&xfs_writeback_ops);
> +	if (xfs_iflags_test(ip, XFS_VERITY_CONSTRUCTION)) {
> +		wbc->range_start = XFS_FSVERITY_MTREE_OFFSET;

Where is XFS_FSVERITY_MTREE_OFFSET defined?

(Oh, the next patch)

Do you need to update wbc->nr if you change range_start?

--D

> +		wbc->range_end = LLONG_MAX;
> +		return iomap_writepages_unbound(mapping, wbc, &wpc.ctx,
> +						&xfs_writeback_ops);
>  	}
> +
> +	return iomap_writepages(mapping, wbc, &wpc.ctx, &xfs_writeback_ops);
>  }
>  
>  STATIC int
> diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
> index 00ec1a738b39..c8725508165c 100644
> --- a/fs/xfs/xfs_iomap.c
> +++ b/fs/xfs/xfs_iomap.c
> @@ -2031,6 +2031,7 @@ xfs_read_iomap_begin(
>  	bool			shared = false;
>  	unsigned int		lockmode = XFS_ILOCK_SHARED;
>  	u64			seq;
> +	int			iomap_flags;
>  
>  	ASSERT(!(flags & (IOMAP_WRITE | IOMAP_ZERO)));
>  
> @@ -2050,8 +2051,12 @@ xfs_read_iomap_begin(
>  	if (error)
>  		return error;
>  	trace_xfs_iomap_found(ip, offset, length, XFS_DATA_FORK, &imap);
> -	return xfs_bmbt_to_iomap(ip, iomap, &imap, flags,
> -				 shared ? IOMAP_F_SHARED : 0, seq);
> +	iomap_flags = shared ? IOMAP_F_SHARED : 0;
> +
> +	if (fsverity_active(inode) && offset >= XFS_FSVERITY_MTREE_OFFSET)
> +		iomap_flags |= IOMAP_F_BEYOND_EOF;
> +
> +	return xfs_bmbt_to_iomap(ip, iomap, &imap, flags, iomap_flags, seq);
>  }
>  
>  const struct iomap_ops xfs_read_iomap_ops = {
> 
> -- 
> 2.50.0
> 
> 

