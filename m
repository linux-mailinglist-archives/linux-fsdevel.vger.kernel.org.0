Return-Path: <linux-fsdevel+bounces-14959-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70BF3885633
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Mar 2024 10:08:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3227E282943
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Mar 2024 09:08:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C26D43B2A8;
	Thu, 21 Mar 2024 09:08:10 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83669BE47;
	Thu, 21 Mar 2024 09:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711012090; cv=none; b=ikEezFnWezKUyGK722y7GdEVmbacNftzutGDl9a+lmuyXhdpAMX92PyPEifMWTCFmUN0+NKtVjROaW9d7A9ovDIx6BxRiUE++0zO1mC3oVKJaMOO93lq6U75pXwMVOzT3q1dwwKLfug2eFb6HLrbOmv7mU5ahItI41oXfcJoLfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711012090; c=relaxed/simple;
	bh=Qpcx0mFyj0lNkiDCl/naVg0tO54qntAJp1uhqBMPplg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=bhrANU3MMLoOHas+yD0RjmvbFNComuyO2Zuoaw8fkwPr2iqBfDfdJ3/UefH5jvCtDuVqNozOXZIW90VIbkhU3J6OJk1Jm27QqJZHLL8cnTetiScUAfDBvrwbjM6pn8Wwxw+xH74wqGssuthdCSz87yO+Zh2Paz1vmBFbHH1CZ3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4V0fgV0SgqzwPtl;
	Thu, 21 Mar 2024 17:05:26 +0800 (CST)
Received: from dggpemm100001.china.huawei.com (unknown [7.185.36.93])
	by mail.maildlp.com (Postfix) with ESMTPS id BC47E140114;
	Thu, 21 Mar 2024 17:07:59 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 21 Mar 2024 17:07:59 +0800
Message-ID: <45a2ab40-bc03-417e-9b9a-bb140e5f3444@huawei.com>
Date: Thu, 21 Mar 2024 17:07:58 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] fs: aio: use a folio in aio_setup_ring()
Content-Language: en-US
To: Alexander Viro <viro@zeniv.linux.org.uk>, Benjamin LaHaise
	<bcrl@kvack.org>, Christian Brauner <brauner@kernel.org>, Jan Kara
	<jack@suse.cz>, <linux-kernel@vger.kernel.org>, Matthew Wilcox
	<willy@infradead.org>
CC: <linux-aio@kvack.org>, <linux-fsdevel@vger.kernel.org>
References: <20240321082733.614329-1-wangkefeng.wang@huawei.com>
 <20240321082733.614329-2-wangkefeng.wang@huawei.com>
From: Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <20240321082733.614329-2-wangkefeng.wang@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm100001.china.huawei.com (7.185.36.93)



On 2024/3/21 16:27, Kefeng Wang wrote:
> Use a folio throughout aio_setup_ring() to remove calls to compound_head().
> 
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>   fs/aio.c | 21 ++++++++++++---------
>   1 file changed, 12 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/aio.c b/fs/aio.c
> index 9cdaa2faa536..d7f6c8705016 100644
> --- a/fs/aio.c
> +++ b/fs/aio.c
> @@ -527,17 +527,20 @@ static int aio_setup_ring(struct kioctx *ctx, unsigned int nr_events)
>   	}
>   
>   	for (i = 0; i < nr_pages; i++) {
> -		struct page *page;
> -		page = find_or_create_page(file->f_mapping,
> -					   i, GFP_USER | __GFP_ZERO);
> -		if (!page)
> +		struct folio *folio;
> +
> +		folio = __filemap_get_folio(file->f_mapping, i,
> +					    FGP_LOCK | FGP_ACCESSED | FGP_CREAT,
> +					    GFP_USER | __GFP_ZERO);
> +		if (!folio)
Oh, this should be  if (IS_ERR(folio)), will update.

>   			break;
> -		pr_debug("pid(%d) page[%d]->count=%d\n",
> -			 current->pid, i, page_count(page));
> -		SetPageUptodate(page);
> -		unlock_page(page);
>   
> -		ctx->ring_pages[i] = page;
> +		pr_debug("pid(%d) [%d] folio->count=%d\n", current->pid, i,
> +			 folio_ref_count(folio));
> +		folio_mark_uptodate(folio);
> +		folio_unlock(folio);
> +
> +		ctx->ring_pages[i] = &folio->page;
>   	}
>   	ctx->nr_pages = i;
>   

