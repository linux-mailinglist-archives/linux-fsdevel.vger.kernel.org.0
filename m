Return-Path: <linux-fsdevel+bounces-19242-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 117EF8C1C40
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 May 2024 03:55:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 433531C2175B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 May 2024 01:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CC7A13B797;
	Fri, 10 May 2024 01:55:36 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE9412D769
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 May 2024 01:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715306135; cv=none; b=tUuDPbi2cWSd42u/pY9BfVe9QSc6OLRmVrZ2vrR6+UHO45R/FIlikhActTniQIBJ0SY5KvF61eVwHfbzc933aCV8POfWPbySwjK8z63U61ZOR8dTzvxVo1nLvBSaQiDV6bFXCufWjQUSHk9S8TGuw6oMFJvlfM92D2zyB1k2bQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715306135; c=relaxed/simple;
	bh=dzxY4kHMeydwfSetqCjwoR0XB8YoNyiGJsY4amzV1To=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=UxlAxHINrL7snMwZ0QdFBRrLwGXqDQg5ok5+1tO/LYYfbtx4NKdKOlehRL26XG2anVF5EGN0MuF/J2R2KMERJGedzd0YyLQ9UbP7gnvkLc0Sm+1Q1hQzY3GpkSiDJQQFA0mjoyy4y9gCoOaKP9b7EGOyCgImmDxklTGQ4Wc6+gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4VbBhQ3lrDz1j4cY;
	Fri, 10 May 2024 09:52:06 +0800 (CST)
Received: from dggpemm100001.china.huawei.com (unknown [7.185.36.93])
	by mail.maildlp.com (Postfix) with ESMTPS id 57DC0180045;
	Fri, 10 May 2024 09:55:24 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 10 May 2024 09:55:23 +0800
Message-ID: <5a1eb9ca-663c-4d38-855a-c29297ecbeab@huawei.com>
Date: Fri, 10 May 2024 09:55:23 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rfc 4/4] mm: filemap: try to batch lruvec stat updating
Content-Language: en-US
To: Johannes Weiner <hannes@cmpxchg.org>
CC: Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand
	<david@redhat.com>, Michal Hocko <mhocko@kernel.org>, Roman Gushchin
	<roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, "Matthew
 Wilcox (Oracle)" <willy@infradead.org>, <linux-mm@kvack.org>,
	<linux-fsdevel@vger.kernel.org>, Muchun Song <muchun.song@linux.dev>
References: <20240429072417.2146732-1-wangkefeng.wang@huawei.com>
 <20240429072417.2146732-5-wangkefeng.wang@huawei.com>
 <411eb896-56c6-4895-a2ba-6c492f8b51fd@huawei.com>
 <20240509140149.GA374370@cmpxchg.org>
From: Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <20240509140149.GA374370@cmpxchg.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm100001.china.huawei.com (7.185.36.93)



On 2024/5/9 22:01, Johannes Weiner wrote:
> On Tue, May 07, 2024 at 05:06:57PM +0800, Kefeng Wang wrote:
>>> +static void filemap_lruvec_stat_update(struct mem_cgroup *memcg,
>>> +				       pg_data_t *pgdat, int nr)
>>> +{
>>> +	struct lruvec *lruvec;
>>> +
>>> +	if (!memcg) {
>>> +		__mod_node_page_state(pgdat, NR_FILE_MAPPED, nr);
>>> +		return;
>>> +	}
>>> +
>>> +	lruvec = mem_cgroup_lruvec(memcg, pgdat);
>>> +	__mod_lruvec_state(lruvec, NR_FILE_MAPPED, nr);
>>> +}
>>> +
>>>    vm_fault_t filemap_map_pages(struct vm_fault *vmf,
>>>    			     pgoff_t start_pgoff, pgoff_t end_pgoff)
>>>    {
>>> @@ -3628,6 +3642,9 @@ vm_fault_t filemap_map_pages(struct vm_fault *vmf,
>>>    	vm_fault_t ret = 0;
>>>    	unsigned long rss = 0;
>>>    	unsigned int nr_pages = 0, mmap_miss = 0, mmap_miss_saved, folio_type;
>>> +	struct mem_cgroup *memcg, *memcg_cur;
>>> +	pg_data_t *pgdat, *pgdat_cur;
>>> +	int nr_mapped = 0;
>>>    
>>>    	rcu_read_lock();
>>>    	folio = next_uptodate_folio(&xas, mapping, end_pgoff);
>>> @@ -3648,9 +3665,20 @@ vm_fault_t filemap_map_pages(struct vm_fault *vmf,
>>>    	}
>>>    
>>>    	folio_type = mm_counter_file(folio);
>>> +	memcg = folio_memcg(folio);
>>> +	pgdat = folio_pgdat(folio);
> 
> You should be able to do:
> 
> 	lruvec = folio_lruvec(folio);
> 
> and then pass that directly to filemap_lruvec_stat_update().

It's obviously better, will update and address David's comment in 
patch3, thank you.

