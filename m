Return-Path: <linux-fsdevel+bounces-26119-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F513954AC9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Aug 2024 15:11:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD8FD1C244A1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Aug 2024 13:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1567A1B8E85;
	Fri, 16 Aug 2024 13:11:12 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F26312AAC6
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 Aug 2024 13:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723813871; cv=none; b=mKOmy8x3eUX1mpFbMXOQhK09fUuhGVBiF8ZzWgC0YJP/3KhdrkQHyAGev3l3bYOfld+peHKIoXmVWBc2c+/13LRQ9vzIAzlrc1TM+uTPPVXVDag5EDRb9SaJfRIgDUF2qUYYhVrXTYRStebIejgK/PdtIYrb26Kg3FZr/2T3YnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723813871; c=relaxed/simple;
	bh=w8Ip1//9kYQcGBhpfLhrAq3wVXM1PVIW2plqun89e94=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=IsQtELtfBeskE/TJbrquJR62y30Oc2CpqBB/qG9Ogc9UlUvTanRnK1483EvFuEfX6xWWtb0lboCbn9NolrHZAFjnZVVCZnIDHnndzgO1htjY3rvocPB3/qocWdPwZuz3OvM7UZPGCF7feVkL7LKfhLL7TMbZ00up2VBott572UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Wlj601F4Pz1T7MZ;
	Fri, 16 Aug 2024 21:10:32 +0800 (CST)
Received: from kwepemm000013.china.huawei.com (unknown [7.193.23.81])
	by mail.maildlp.com (Postfix) with ESMTPS id A7E011400E3;
	Fri, 16 Aug 2024 21:11:04 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemm000013.china.huawei.com (7.193.23.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 16 Aug 2024 21:11:03 +0800
Subject: Re: [PATCH 2/2] jffs2: Use a folio in jffs2_garbage_collect_dnode()
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>, David Woodhouse
	<dwmw2@infradead.org>
CC: Richard Weinberger <richard@nod.at>, <linux-mtd@lists.infradead.org>,
	<linux-fsdevel@vger.kernel.org>, Christian Brauner <brauner@kernel.org>
References: <20240814195915.249871-1-willy@infradead.org>
 <20240814195915.249871-3-willy@infradead.org>
From: Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <61d4e3a3-20f7-0236-79b8-b6be135a0124@huawei.com>
Date: Fri, 16 Aug 2024 21:10:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240814195915.249871-3-willy@infradead.org>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm000013.china.huawei.com (7.193.23.81)

ÔÚ 2024/8/15 3:59, Matthew Wilcox (Oracle) Ð´µÀ:
> Call read_cache_folio() instead of read_cache_page() to get the folio
> containing the page.  No attempt is made here to support large folios
> as I assume that will never be interesting for jffs2.  Includes a switch
> from kmap to kmap_local which looks safe.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>   fs/jffs2/gc.c | 25 ++++++++++++-------------
>   1 file changed, 12 insertions(+), 13 deletions(-)

Reviewed-by: Zhihao Cheng <chengzhihao1@huawei.com>
> 
> diff --git a/fs/jffs2/gc.c b/fs/jffs2/gc.c
> index 5c6602f3c189..822949d0eb00 100644
> --- a/fs/jffs2/gc.c
> +++ b/fs/jffs2/gc.c
> @@ -1171,7 +1171,7 @@ static int jffs2_garbage_collect_dnode(struct jffs2_sb_info *c, struct jffs2_era
>   	uint32_t alloclen, offset, orig_end, orig_start;
>   	int ret = 0;
>   	unsigned char *comprbuf = NULL, *writebuf;
> -	struct page *page;
> +	struct folio *folio;
>   	unsigned char *pg_ptr;
>   
>   	memset(&ri, 0, sizeof(ri));
> @@ -1317,25 +1317,25 @@ static int jffs2_garbage_collect_dnode(struct jffs2_sb_info *c, struct jffs2_era
>   		BUG_ON(start > orig_start);
>   	}
>   
> -	/* The rules state that we must obtain the page lock *before* f->sem, so
> +	/* The rules state that we must obtain the folio lock *before* f->sem, so
>   	 * drop f->sem temporarily. Since we also hold c->alloc_sem, nothing's
>   	 * actually going to *change* so we're safe; we only allow reading.
>   	 *
>   	 * It is important to note that jffs2_write_begin() will ensure that its
> -	 * page is marked Uptodate before allocating space. That means that if we
> -	 * end up here trying to GC the *same* page that jffs2_write_begin() is
> -	 * trying to write out, read_cache_page() will not deadlock. */
> +	 * folio is marked uptodate before allocating space. That means that if we
> +	 * end up here trying to GC the *same* folio that jffs2_write_begin() is
> +	 * trying to write out, read_cache_folio() will not deadlock. */
>   	mutex_unlock(&f->sem);
> -	page = read_cache_page(inode->i_mapping, start >> PAGE_SHIFT,
> +	folio = read_cache_folio(inode->i_mapping, start >> PAGE_SHIFT,
>   			       __jffs2_read_folio, NULL);
> -	if (IS_ERR(page)) {
> -		pr_warn("read_cache_page() returned error: %ld\n",
> -			PTR_ERR(page));
> +	if (IS_ERR(folio)) {
> +		pr_warn("read_cache_folio() returned error: %ld\n",
> +			PTR_ERR(folio));
>   		mutex_lock(&f->sem);
> -		return PTR_ERR(page);
> +		return PTR_ERR(folio);
>   	}
>   
> -	pg_ptr = kmap(page);
> +	pg_ptr = kmap_local_folio(folio, 0);
>   	mutex_lock(&f->sem);
>   
>   	offset = start;
> @@ -1400,7 +1400,6 @@ static int jffs2_garbage_collect_dnode(struct jffs2_sb_info *c, struct jffs2_era
>   		}
>   	}
>   
> -	kunmap(page);
> -	put_page(page);
> +	folio_release_kmap(folio, pg_ptr);
>   	return ret;
>   }
> 


