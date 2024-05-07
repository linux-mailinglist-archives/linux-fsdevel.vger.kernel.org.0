Return-Path: <linux-fsdevel+bounces-18885-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 335568BDDC1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 May 2024 11:07:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 654831C21D84
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 May 2024 09:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7924814D6E4;
	Tue,  7 May 2024 09:07:06 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CCB714D452
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 May 2024 09:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715072826; cv=none; b=FKRBvh2A9VP0chOIEGr8NOgo678Nur9C3jWSIGmLH6BrOkhC1hb4+SHM/ybuuMXDdOOiZzfDTf8h28ltP0RBdtYYdftRYbEUugwMPO/Tv/3D5Oy7wiqSGB/0Yi0PMGSjXI9qhTdlGy6zbREoHrX04clz4mErfkjvHohU/9dnJTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715072826; c=relaxed/simple;
	bh=hVFgkrfMqog8kHdMSQOC3KgRp8Jq7BHJ4VHLzN/AxRY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=CJzltL/arrIFQWWoygGP9kES72o6D9fDHDcpU+N9tcNImn8arOQnBvAP12QYPsnWKvfdW/1E14a2xXmncVe0Cxoo9NOIwq74egyTPWIvO1h+p/oZVZHdyV6skYGxIWsLGv3CGeNwG6cxAaVgEAPjOsxLvRK5XHpJagsSvZQ1QIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4VYXPm0YqCz1R8sZ;
	Tue,  7 May 2024 17:03:40 +0800 (CST)
Received: from dggpemm100001.china.huawei.com (unknown [7.185.36.93])
	by mail.maildlp.com (Postfix) with ESMTPS id 798AA18007B;
	Tue,  7 May 2024 17:06:58 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 7 May 2024 17:06:57 +0800
Message-ID: <411eb896-56c6-4895-a2ba-6c492f8b51fd@huawei.com>
Date: Tue, 7 May 2024 17:06:57 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rfc 4/4] mm: filemap: try to batch lruvec stat updating
Content-Language: en-US
To: Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand
	<david@redhat.com>, Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko
	<mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt
	<shakeel.butt@linux.dev>
CC: "Matthew Wilcox (Oracle)" <willy@infradead.org>, <linux-mm@kvack.org>,
	<linux-fsdevel@vger.kernel.org>, Muchun Song <muchun.song@linux.dev>
References: <20240429072417.2146732-1-wangkefeng.wang@huawei.com>
 <20240429072417.2146732-5-wangkefeng.wang@huawei.com>
From: Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <20240429072417.2146732-5-wangkefeng.wang@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm100001.china.huawei.com (7.185.36.93)

+ memcg maintainers and David too, please check all patches from link

https://lore.kernel.org/linux-mm/20240429072417.2146732-1-wangkefeng.wang@huawei.com/

Thanks

On 2024/4/29 15:24, Kefeng Wang wrote:
> The filemap_map_pages() tries to map few pages(eg, 16 pages), but the
> lruvec stat updating is called on each mapping, since the updating is
> time-consuming, especially with memcg, so try to batch it when the memcg
> and pgdat are same during the mapping, if luckily, we could save most of
> time of lruvec stat updating, the lat_pagefault shows 3~4% improvement.
> 
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>   mm/filemap.c | 33 ++++++++++++++++++++++++++++++---
>   1 file changed, 30 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 3966b6616d02..b27281707098 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -3615,6 +3615,20 @@ static vm_fault_t filemap_map_order0_folio(struct vm_fault *vmf,
>   	return ret;
>   }
>   
> +static void filemap_lruvec_stat_update(struct mem_cgroup *memcg,
> +				       pg_data_t *pgdat, int nr)
> +{
> +	struct lruvec *lruvec;
> +
> +	if (!memcg) {
> +		__mod_node_page_state(pgdat, NR_FILE_MAPPED, nr);
> +		return;
> +	}
> +
> +	lruvec = mem_cgroup_lruvec(memcg, pgdat);
> +	__mod_lruvec_state(lruvec, NR_FILE_MAPPED, nr);
> +}
> +
>   vm_fault_t filemap_map_pages(struct vm_fault *vmf,
>   			     pgoff_t start_pgoff, pgoff_t end_pgoff)
>   {
> @@ -3628,6 +3642,9 @@ vm_fault_t filemap_map_pages(struct vm_fault *vmf,
>   	vm_fault_t ret = 0;
>   	unsigned long rss = 0;
>   	unsigned int nr_pages = 0, mmap_miss = 0, mmap_miss_saved, folio_type;
> +	struct mem_cgroup *memcg, *memcg_cur;
> +	pg_data_t *pgdat, *pgdat_cur;
> +	int nr_mapped = 0;
>   
>   	rcu_read_lock();
>   	folio = next_uptodate_folio(&xas, mapping, end_pgoff);
> @@ -3648,9 +3665,20 @@ vm_fault_t filemap_map_pages(struct vm_fault *vmf,
>   	}
>   
>   	folio_type = mm_counter_file(folio);
> +	memcg = folio_memcg(folio);
> +	pgdat = folio_pgdat(folio);
>   	do {
>   		unsigned long end;
> -		int nr_mapped = 0;
> +
> +		memcg_cur = folio_memcg(folio);
> +		pgdat_cur = folio_pgdat(folio);
> +
> +		if (unlikely(memcg != memcg_cur || pgdat != pgdat_cur)) {
> +			filemap_lruvec_stat_update(memcg, pgdat, nr_mapped);
> +			nr_mapped = 0;
> +			memcg = memcg_cur;
> +			pgdat = pgdat_cur;
> +		}
>   
>   		addr += (xas.xa_index - last_pgoff) << PAGE_SHIFT;
>   		vmf->pte += xas.xa_index - last_pgoff;
> @@ -3668,11 +3696,10 @@ vm_fault_t filemap_map_pages(struct vm_fault *vmf,
>   					nr_pages, &rss, &nr_mapped,
>   					&mmap_miss);
>   
> -		__lruvec_stat_mod_folio(folio, NR_FILE_MAPPED, nr_mapped);
> -
>   		folio_unlock(folio);
>   		folio_put(folio);
>   	} while ((folio = next_uptodate_folio(&xas, mapping, end_pgoff)) != NULL);
> +	filemap_lruvec_stat_update(memcg, pgdat, nr_mapped);
>   	add_mm_counter(vma->vm_mm, folio_type, rss);
>   	pte_unmap_unlock(vmf->pte, vmf->ptl);
>   out:

