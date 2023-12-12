Return-Path: <linux-fsdevel+bounces-5608-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 061C980E11C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 02:53:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76082B216E7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 01:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6E2115AE;
	Tue, 12 Dec 2023 01:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="srhwMK7o"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85F71A1
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 Dec 2023 17:53:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=bMGkXdoiuPbjjp+6zuH53AaOzzoK64saaBUvDGSCb5o=; b=srhwMK7osbrGSCS7E0+XVTYNNS
	XTebSjsGYU//9TvYJQoEsLS/u0uXE8pIoTE2G3BcK9ODY2sAJi6ia7DkDhcyAQh7ODDYPzyeXoYdF
	r91ERJ75cTgLwDMilpOxZqy132o5b3RY0+itEKFIoop5zWCQdxOatvqDP5OG8ngZdmcMripuGteb3
	vrhFvnJNCn9//T4Bmy2xopbthKHxIibE7BZgsbtguJcb+gztjVuSYZkUE2/do0WM0BvXorCqdV3eL
	oU1S+Ehj/9DT1DKJ+/kSQQ2z5+vF/dPerl69C+1XeUr8WziGrBrt7cGPSdpt+Bbem+/krvpTB0sOw
	YmBA4Kng==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rCrxh-009UMX-TJ; Tue, 12 Dec 2023 01:53:29 +0000
Date: Tue, 12 Dec 2023 01:53:29 +0000
From: Matthew Wilcox <willy@infradead.org>
To: John Sanpe <sanpeqf@gmail.com>
Cc: linkinjeon@kernel.org, sj1557.seo@samsung.com,
	linux-fsdevel@vger.kernel.org, Andy.Wu@sony.com,
	Wataru.Aoyama@sony.com, cpgs@samsung.com
Subject: Re: [PATCH] exfat/balloc: using ffs instead of internal logic
Message-ID: <ZXe9Gd+qHm4dt1Ss@casper.infradead.org>
References: <20231207234701.566133-1-sanpeqf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231207234701.566133-1-sanpeqf@gmail.com>

On Fri, Dec 08, 2023 at 07:47:01AM +0800, John Sanpe wrote:
>  	WARN_ON(clu < EXFAT_FIRST_CLUSTER);
> -	ent_idx = CLUSTER_TO_BITMAP_ENT(clu);
> -	clu_base = BITMAP_ENT_TO_CLUSTER(ent_idx & ~(BITS_PER_BYTE_MASK));
> +	ent_idx = ALIGN_DOWN(CLUSTER_TO_BITMAP_ENT(clu), BITS_PER_LONG);
> +	clu_base = BITMAP_ENT_TO_CLUSTER(ent_idx);
>  	clu_mask = IGNORED_BITS_REMAINED(clu, clu_base);
>  
>  	map_i = BITMAP_OFFSET_SECTOR_INDEX(sb, ent_idx);
>  	map_b = BITMAP_OFFSET_BYTE_IN_SECTOR(sb, ent_idx);
>  
>  	for (i = EXFAT_FIRST_CLUSTER; i < sbi->num_clusters;
> -	     i += BITS_PER_BYTE) {
> -		k = *(sbi->vol_amap[map_i]->b_data + map_b);
> +	     i += BITS_PER_LONG) {
> +		bitval = *(__le_long *)(sbi->vol_amap[map_i]->b_data + map_b);

Is this guaranteed to be word-aligned, or might we end up doing
misaligned loads here?


