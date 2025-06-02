Return-Path: <linux-fsdevel+bounces-50362-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CED9BACB365
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Jun 2025 16:42:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7F2F9429EF
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Jun 2025 14:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 209EF2236E3;
	Mon,  2 Jun 2025 14:22:03 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6603A2236F2;
	Mon,  2 Jun 2025 14:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748874122; cv=none; b=tFqG7iObdtxSrgW1Z7NjC///yAsCUJwJWofrmVajNul2T15u8BmS71dPVSw3VFOwuhaZ2k1pO0B1GwuLOp6wNVbUpuGFmog0kSuOBLDDDL8FPgtF9rND0eOAB7eACFhxSXiB1oB0hDKJy5mdLjTl6aVb/iwt2mPqR/kZ9+1sfAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748874122; c=relaxed/simple;
	bh=vyyY6TpPKEPVab6M3kTl2qVwwY64/F1P3XIyi3kfehQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TsPqFtiYZifpzfV7x5rstRrAOM0Z7XVzbFYdFWCcW6YE/2vug8DoyV9SgiMuAdtYbLbsdWVgWPHPbVagmJQSIAUswsVLsHmrwt9KaRgDcHquZNJiT2CyBaoJlPzKIgGOvqpE3dy7GAhaO+s64+PPHSq4XTgsDw2Uk18DnOxRwMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 448D468C7B; Mon,  2 Jun 2025 16:21:57 +0200 (CEST)
Date: Mon, 2 Jun 2025 16:21:57 +0200
From: Christoph Hellwig <hch@lst.de>
To: Kundan Kumar <kundan.kumar@samsung.com>
Cc: jaegeuk@kernel.org, chao@kernel.org, viro@zeniv.linux.org.uk,
	brauner@kernel.org, jack@suse.cz, miklos@szeredi.hu,
	agruenba@redhat.com, trondmy@kernel.org, anna@kernel.org,
	akpm@linux-foundation.org, willy@infradead.org, mcgrof@kernel.org,
	clm@meta.com, david@fromorbit.com, amir73il@gmail.com,
	axboe@kernel.dk, hch@lst.de, ritesh.list@gmail.com,
	djwong@kernel.org, dave@stgolabs.net, p.raghav@samsung.com,
	da.gomez@samsung.com, linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org, gfs2@lists.linux.dev,
	linux-nfs@vger.kernel.org, linux-mm@kvack.org, gost.dev@samsung.com,
	Anuj Gupta <anuj20.g@samsung.com>
Subject: Re: [PATCH 10/13] fuse: add support for multiple writeback
 contexts in fuse
Message-ID: <20250602142157.GC21996@lst.de>
References: <20250529111504.89912-1-kundan.kumar@samsung.com> <CGME20250529113257epcas5p4dbaf9c8e2dc362767c8553399632c1ea@epcas5p4.samsung.com> <20250529111504.89912-11-kundan.kumar@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250529111504.89912-11-kundan.kumar@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

>  static void fuse_writepage_finish_stat(struct inode *inode, struct folio *folio)
>  {
> -	struct backing_dev_info *bdi = inode_to_bdi(inode);
> +	struct bdi_writeback_ctx *bdi_wb_ctx = fetch_bdi_writeback_ctx(inode);
>  
> -	dec_wb_stat(&bdi->wb_ctx_arr[0]->wb, WB_WRITEBACK);
> +	dec_wb_stat(&bdi_wb_ctx->wb, WB_WRITEBACK);
>  	node_stat_sub_folio(folio, NR_WRITEBACK_TEMP);
> -	wb_writeout_inc(&bdi->wb_ctx_arr[0]->wb);
> +	wb_writeout_inc(&bdi_wb_ctx->wb);
>  }

There's nothing fuse-specific here except that nothing but fuse uses
NR_WRITEBACK_TEMP.  Can we try to move this into the core first so that
the patches don't have to touch file system code?

> -	inc_wb_stat(&inode_to_bdi(inode)->wb_ctx_arr[0]->wb, WB_WRITEBACK);
> +	inc_wb_stat(&bdi_wb_ctx->wb, WB_WRITEBACK);
>  	node_stat_add_folio(tmp_folio, NR_WRITEBACK_TEMP);

Same here.  On pattern is that fuse and nfs both touch the node stat
and the web stat, and having a common helper doing both would probably
also be very helpful.


