Return-Path: <linux-fsdevel+bounces-50361-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16F17ACB2FA
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Jun 2025 16:37:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0466941F37
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Jun 2025 14:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF308238D22;
	Mon,  2 Jun 2025 14:20:25 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3148D238C19;
	Mon,  2 Jun 2025 14:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748874025; cv=none; b=EnEiQMH1e8pmg3mhyD4f+hmRxdDut7eQAw8PL2lfKNq5iUO1TyBww5JzdZZVV/HpW9Y1gwYh/NVYslM3a14tAosyqTxdcjMJ9X7iVZ8/ZGjgggthnkYfTzL7ev1QZ90L4hOtAIRr7z0QbBaKjHLxNfbltAswPxhOeIcHEEYS/0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748874025; c=relaxed/simple;
	bh=zCgshzsKmF7pas1vo72pFDw8H/xGl8C/SjDTx69IRAo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ui9uKNW3fXj8CVCPEqg7amunmZQE+zzGNAg8d5wm0+oMPFSn7eZgBBPqFNGDndUluoNP9H2lvz9DQIizBVJRl9byNHqZFthsnlrynSVB/Ikh3CkGHk931MIIOizmcmZzG+vOJLtNPUMx8ZZiOMQB9YXgeZIz4XKh1Lnbn7QyhfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id E5B2B68C7B; Mon,  2 Jun 2025 16:20:19 +0200 (CEST)
Date: Mon, 2 Jun 2025 16:20:19 +0200
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
Subject: Re: [PATCH 09/13] f2fs: add support in f2fs to handle multiple
 writeback contexts
Message-ID: <20250602142019.GB21996@lst.de>
References: <20250529111504.89912-1-kundan.kumar@samsung.com> <CGME20250529113253epcas5p1a28e77b2d9824d55f594ccb053725ece@epcas5p1.samsung.com> <20250529111504.89912-10-kundan.kumar@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250529111504.89912-10-kundan.kumar@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

>  	} else if (type == DIRTY_DENTS) {
> -		if (sbi->sb->s_bdi->wb_ctx_arr[0]->wb.dirty_exceeded)
> -			return false;
> +		for_each_bdi_wb_ctx(sbi->sb->s_bdi, bdi_wb_ctx)
> +			if (bdi_wb_ctx->wb.dirty_exceeded)
> +				return false;

I think we need to figure out what the dirty_exceeded here and in
the other places in f2fs and gfs2 is trying to do and factor that into
well-documented core helpers instead of adding these loops in places
that should not really poke into writeback internals.


