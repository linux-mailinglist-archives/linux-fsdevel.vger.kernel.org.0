Return-Path: <linux-fsdevel+bounces-25696-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF67F94F4B9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2024 18:33:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E269D1C20D0C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2024 16:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90B58186E38;
	Mon, 12 Aug 2024 16:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k8FLyvqw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6221186E33;
	Mon, 12 Aug 2024 16:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723480421; cv=none; b=R+4B3aDCZF3qG2j7BOv5dPQXbxKdhaJ38DzI670iTWcmoODyqUhQAiwLFS1Q+mtK76zPyEYEv2o22441O+4oimwX9/1deHHf/FXFTw1KWfmpIYB7E858gaUpqL6c/NkbP+oeZ1r7rUNWk57P1NepwS1jUSU+ZsUi8N3/b2msnUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723480421; c=relaxed/simple;
	bh=WmL869a4ewwYi7s/OKKxovTDNlv44X8vvMJuu+PGBJc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZJqUSugXqdMa3HURuSQXPMTI77ei3LVhom3kuzwMNiE0bWWZpaFAK1Golu+Q0AEX+1GZ0ukRnxlwN5nj4EWC2xHD2uYjajMV0J2JSRouxh+bBn9kVPgTwaXh1g3E+2jAM8yFxaVcWxXIAp47Q9MN1eKWFxtI5cr6nK9bvCX1v+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k8FLyvqw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7277BC4AF0D;
	Mon, 12 Aug 2024 16:33:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723480420;
	bh=WmL869a4ewwYi7s/OKKxovTDNlv44X8vvMJuu+PGBJc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k8FLyvqwISb5t1RJ8XaY2JruX6rtvrjBaAkRMM2ACtEgJpq/xFWJw1vZHqrxLq+Zo
	 5hBl7ZkOWMqmkgeGFnILGWM5/AoojduIYKc/B2BFKKpFN1qf+8R9vnrJpuP+gxK8ir
	 8mmT5SsdfzI/utJ3Jf+yN0ojBKxEOsZDYsqdgeWtNAye/9qgiIiJu8PvfTqhaFBAVv
	 O1tZr2tVRkMGkTWbVjuvZbTCqW8F1t4ezCUJMMRkhZq5yFsSEn+tu5OItYcO3e3GO+
	 weHyinGtCDDpqST5Oteu5MkJN6g1/9xzmtyucF+EF9Kzane8WVphXGjGm6/tqBtFah
	 9argB4ZYitjiQ==
Date: Mon, 12 Aug 2024 09:33:39 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, hch@infradead.org, brauner@kernel.org,
	david@fromorbit.com, jack@suse.cz, willy@infradead.org,
	yi.zhang@huawei.com, chengzhihao1@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH v2 1/6] iomap: correct the range of a partial dirty clear
Message-ID: <20240812163339.GD6043@frogsfrogsfrogs>
References: <20240812121159.3775074-1-yi.zhang@huaweicloud.com>
 <20240812121159.3775074-2-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240812121159.3775074-2-yi.zhang@huaweicloud.com>

On Mon, Aug 12, 2024 at 08:11:54PM +0800, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> The block range calculation in ifs_clear_range_dirty() is incorrect when
> partial clear a range in a folio. We can't clear the dirty bit of the
> first block or the last block if the start or end offset is blocksize
> unaligned, this has not yet caused any issue since we always clear a
> whole folio in iomap_writepage_map()->iomap_clear_range_dirty(). Fix
> this by round up the first block and round down the last block and
> correct the calculation of nr_blks.
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> ---
>  fs/iomap/buffered-io.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index f420c53d86ac..4da453394aaf 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -138,11 +138,14 @@ static void ifs_clear_range_dirty(struct folio *folio,
>  {
>  	struct inode *inode = folio->mapping->host;
>  	unsigned int blks_per_folio = i_blocks_per_folio(inode, folio);
> -	unsigned int first_blk = (off >> inode->i_blkbits);
> -	unsigned int last_blk = (off + len - 1) >> inode->i_blkbits;
> -	unsigned int nr_blks = last_blk - first_blk + 1;
> +	unsigned int first_blk = DIV_ROUND_UP(off, i_blocksize(inode));

Is there a round up macro that doesn't involve integer division?

--D

> +	unsigned int last_blk = (off + len) >> inode->i_blkbits;
> +	unsigned int nr_blks = last_blk - first_blk;
>  	unsigned long flags;
>  
> +	if (!nr_blks)
> +		return;
> +
>  	spin_lock_irqsave(&ifs->state_lock, flags);
>  	bitmap_clear(ifs->state, first_blk + blks_per_folio, nr_blks);
>  	spin_unlock_irqrestore(&ifs->state_lock, flags);
> -- 
> 2.39.2
> 
> 

