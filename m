Return-Path: <linux-fsdevel+bounces-17716-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 61BB08B1ADC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 08:22:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 906A71C21714
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 06:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 121A73F9D2;
	Thu, 25 Apr 2024 06:22:05 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14CF127473;
	Thu, 25 Apr 2024 06:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714026124; cv=none; b=bo+rJdZNKIaZka8q8Xbtqx4/vzMNSeW3K8eDL/+foBA8UC4COSMC68UTtgZj19dhghijXXTNnbID0y+5CUqtmffdiy0r8E+KZO1ZLXZhYpUoUNJGqvndH2RFPoDkfmoyRNsQqvhratAwgaHvdr5ca+E5dwAiHbNNtdpVrXCSDOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714026124; c=relaxed/simple;
	bh=imaC7eO5xlYNPnUVBT7HZoIIKrPLl4rRi7nQZ9RsLxQ=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=aXPFoKZ85q3Qzt6IegUBnpi41Q/w6bn++gcSEVlH9JIaGKFAawDIYKVmi6jDPfXSF2BWNEnr/rDqeZjgan31ad1AWZ0Nsw77j5sjm+VRtGESwDPVPMIa7yLzUJLdTic/IAK4t+yrd30+aDiHBNtKC/75wDy+gWtq537WztB+a6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4VQ5KD4qPVz1R9NF;
	Thu, 25 Apr 2024 14:18:56 +0800 (CST)
Received: from canpemm500002.china.huawei.com (unknown [7.192.104.244])
	by mail.maildlp.com (Postfix) with ESMTPS id 273C01402E0;
	Thu, 25 Apr 2024 14:21:59 +0800 (CST)
Received: from [10.173.135.154] (10.173.135.154) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 25 Apr 2024 14:21:58 +0800
Subject: Re: [PATCH 3/6] memory-failure: Remove calls to page_mapping()
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
CC: <linux-fsdevel@vger.kernel.org>, <linux-fscrypt@vger.kernel.org>,
	<linux-f2fs-devel@lists.sourceforge.net>, Andrew Morton
	<akpm@linux-foundation.org>, <linux-mm@kvack.org>
References: <20240423225552.4113447-1-willy@infradead.org>
 <20240423225552.4113447-4-willy@infradead.org>
From: Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <82a80acf-7d2e-b207-07bb-2584ef874352@huawei.com>
Date: Thu, 25 Apr 2024 14:21:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240423225552.4113447-4-willy@infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500002.china.huawei.com (7.192.104.244)

On 2024/4/24 6:55, Matthew Wilcox (Oracle) wrote:
> This is mostly just inlining page_mapping() into the two callers.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Acked-by: Miaohe Lin <linmiaohe@huawei.com>
Thanks.
.

> ---
>  mm/memory-failure.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index e065dd9be21e..62aa3db17854 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -216,6 +216,7 @@ EXPORT_SYMBOL_GPL(hwpoison_filter_flags_value);
>  
>  static int hwpoison_filter_dev(struct page *p)
>  {
> +	struct folio *folio = page_folio(p);
>  	struct address_space *mapping;
>  	dev_t dev;
>  
> @@ -223,7 +224,7 @@ static int hwpoison_filter_dev(struct page *p)
>  	    hwpoison_filter_dev_minor == ~0U)
>  		return 0;
>  
> -	mapping = page_mapping(p);
> +	mapping = folio_mapping(folio);
>  	if (mapping == NULL || mapping->host == NULL)
>  		return -EINVAL;
>  
> @@ -1090,7 +1091,8 @@ static int me_pagecache_clean(struct page_state *ps, struct page *p)
>   */
>  static int me_pagecache_dirty(struct page_state *ps, struct page *p)
>  {
> -	struct address_space *mapping = page_mapping(p);
> +	struct folio *folio = page_folio(p);
> +	struct address_space *mapping = folio_mapping(folio);
>  
>  	/* TBD: print more information about the file. */
>  	if (mapping) {
> 


