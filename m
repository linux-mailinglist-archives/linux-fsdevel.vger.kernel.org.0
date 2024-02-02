Return-Path: <linux-fsdevel+bounces-9947-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59C528465F8
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 03:44:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 798641C24322
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 02:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 351D9BE74;
	Fri,  2 Feb 2024 02:44:47 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F576BA24
	for <linux-fsdevel@vger.kernel.org>; Fri,  2 Feb 2024 02:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706841886; cv=none; b=m+U2T4CnzfvjwXssOKOOlFAOUL4v6YnfRlOnRvIlLjhKcvGfpsFBUNcjR285SDvr+VFmqADUPGKvlhzyPTQfQ6LEpZzzboXu6Bq352+mRTgnD+g3WH343FRAQe2olKbg4H5pffd0fwfZ1IyiF5c9j3P3CWJVuaVgZUYOl7x5GE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706841886; c=relaxed/simple;
	bh=8vyusMtu8dUf4s3qPAwUi0oKk7NbhmkgRv/hQjQCJeE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=LclU/W4sSNJjbaN6qXqwbWON5FNLk+wWdOL5VqzFdrJHliDKaBLZvXpBtAjddYSV8njBPUZAuwfm4QSGVUmKMMHpYNMRcHKhJpShs8LvfGneBwGEcXC5hJyybOP7zhpMipKPRGGFjswMndSDOreaucn1aJuv6N67S+ASQdhe7o8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4TR0S91L6fz1Q8YQ;
	Fri,  2 Feb 2024 10:42:49 +0800 (CST)
Received: from dggpemm100001.china.huawei.com (unknown [7.185.36.93])
	by mail.maildlp.com (Postfix) with ESMTPS id 6B3071A016C;
	Fri,  2 Feb 2024 10:44:41 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 2 Feb 2024 10:44:40 +0800
Message-ID: <c168486c-bf46-4232-b058-fd826555deca@huawei.com>
Date: Fri, 2 Feb 2024 10:44:40 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rfc 2/9] mm: migrate_device: use more folio in
 __migrate_device_pages()
Content-Language: en-US
To: Matthew Wilcox <willy@infradead.org>
CC: Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>, Tony Luck
	<tony.luck@intel.com>, Naoya Horiguchi <naoya.horiguchi@nec.com>, Miaohe Lin
	<linmiaohe@huawei.com>, David Hildenbrand <david@redhat.com>, Muchun Song
	<muchun.song@linux.dev>, Benjamin LaHaise <bcrl@kvack.org>,
	<jglisse@redhat.com>, <linux-aio@kvack.org>, <linux-fsdevel@vger.kernel.org>
References: <20240129070934.3717659-1-wangkefeng.wang@huawei.com>
 <20240129070934.3717659-3-wangkefeng.wang@huawei.com>
 <ZbvwuvqIjnFnaerW@casper.infradead.org>
From: Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <ZbvwuvqIjnFnaerW@casper.infradead.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm100001.china.huawei.com (7.185.36.93)



On 2024/2/2 3:27, Matthew Wilcox wrote:
> On Mon, Jan 29, 2024 at 03:09:27PM +0800, Kefeng Wang wrote:
>> Use newfolio/folio for migrate_folio_extra()/migrate_folio() to
>> save three compound_head() calls.
> 
> I've looked at this function before and I get stuck on the question of
> whether a device page truly is a folio or not.  I think for the moment,
> we've decided that it is, so ..
> 
> Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> 
> Although ...
> 
>> @@ -729,13 +730,12 @@ static void __migrate_device_pages(unsigned long *src_pfns,
>>   		}
>>   
>>   		mapping = page_mapping(page);
>> +		folio = page_folio(page);
>> +		newfolio = page_folio(newpage);
> 
> you should save one more call to compound_head() by changing the
> page_mapping() to folio_mapping().

Missing this one, will update, thanks.
> 

