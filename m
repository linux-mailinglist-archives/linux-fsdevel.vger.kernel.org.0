Return-Path: <linux-fsdevel+bounces-13175-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A377686C46A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Feb 2024 10:02:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F9BE1F26871
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Feb 2024 09:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F68756B87;
	Thu, 29 Feb 2024 09:01:58 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6666354FBB;
	Thu, 29 Feb 2024 09:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709197318; cv=none; b=pJVY8H9oTB0hfKQp481moFDzEsA6NUVLC+CSsEKvgl23vl9274JE9KhdGEV6N/W+NSDTuY+veBaWsHFpYf7OEwokj6mwHZvOLamt+QACR68gQbImQ5naA3PVLdozDcngaPPUHy8yyeQroqVJC18rR5hzfmQyBFfq8QfjO9yM0Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709197318; c=relaxed/simple;
	bh=tGt35rOchIvnckjwFcnfZTJwKdw0prhUTLXYJLxetSs=;
	h=Subject:To:References:CC:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=tj30YPlT4zJUVbW+rjDJn84OPrj8OMujjcNN62ZsqyCnzS2F3w0osOsAS34S4MRc4gmVf5fUSdAgl11ZU3hkA2icGDSlq7PdV3ZBlD59jvnPmO3u4Vif2WHDYq8ZF60gq3vGMf22bImhdyYwuzGRHpaS1L6eoErUEPxjSS594n4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4TllYJ2Vfdz1xpnW;
	Thu, 29 Feb 2024 17:00:20 +0800 (CST)
Received: from dggpemd200004.china.huawei.com (unknown [7.185.36.141])
	by mail.maildlp.com (Postfix) with ESMTPS id 7ECDE140416;
	Thu, 29 Feb 2024 17:01:51 +0800 (CST)
Received: from [10.174.179.24] (10.174.179.24) by
 dggpemd200004.china.huawei.com (7.185.36.141) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Thu, 29 Feb 2024 17:01:50 +0800
Subject: Re: [PATCH 2/2] mm/readahead: limit sync readahead while too many
 active refault
To: Jan Kara <jack@suse.cz>
References: <20240201100835.1626685-1-liushixin2@huawei.com>
 <20240201100835.1626685-3-liushixin2@huawei.com>
 <20240201093749.ll7uzgt7ixy7kkhw@quack3>
 <c768cab9-4ccb-9618-24a8-b51d3f141340@huawei.com>
 <20240201173130.frpaqpy7iyzias5j@quack3>
 <78ee0c12-e706-875d-2baf-cb51dea9cfc4@huawei.com>
CC: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner
	<brauner@kernel.org>, Matthew Wilcox <willy@infradead.org>, Andrew Morton
	<akpm@linux-foundation.org>, <linux-fsdevel@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
From: Liu Shixin <liushixin2@huawei.com>
Message-ID: <0ea62dea-94d1-a387-a527-5b0aa0a5fba6@huawei.com>
Date: Thu, 29 Feb 2024 17:01:50 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <78ee0c12-e706-875d-2baf-cb51dea9cfc4@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemd200004.china.huawei.com (7.185.36.141)



On 2024/2/2 17:02, Liu Shixin wrote:
>
> On 2024/2/2 1:31, Jan Kara wrote:
>> On Thu 01-02-24 18:41:30, Liu Shixin wrote:
>>> On 2024/2/1 17:37, Jan Kara wrote:
>>>> On Thu 01-02-24 18:08:35, Liu Shixin wrote:
>>>>> When the pagefault is not for write and the refault distance is close,
>>>>> the page will be activated directly. If there are too many such pages in
>>>>> a file, that means the pages may be reclaimed immediately.
>>>>> In such situation, there is no positive effect to read-ahead since it will
>>>>> only waste IO. So collect the number of such pages and when the number is
>>>>> too large, stop bothering with read-ahead for a while until it decreased
>>>>> automatically.
>>>>>
>>>>> Define 'too large' as 10000 experientially, which can solves the problem
>>>>> and does not affect by the occasional active refault.
>>>>>
>>>>> Signed-off-by: Liu Shixin <liushixin2@huawei.com>
>>>> So I'm not convinced this new logic is needed. We already have
>>>> ra->mmap_miss which gets incremented when a page fault has to read the page
>>>> (and decremented when a page fault found the page already in cache). This
>>>> should already work to detect trashing as well, shouldn't it? If it does
>>>> not, why?
>>>>
>>>> 								Honza
>>> ra->mmap_miss doesn't help, it increased only one in do_sync_mmap_readahead()
>>> and then decreased one for every page in filemap_map_pages(). So in this scenario,
>>> it can't exceed MMAP_LOTSAMISS.
>> I see, OK. But that's a (longstanding) bug in how mmap_miss is handled. Can
>> you please test whether attached patches fix the trashing for you? At least
>> now I can see mmap_miss properly increments when we are hitting uncached
>> pages...  Thanks!
>>
>> 								Honza
> The patch doesn't seem to have much effect. I will try to analyze why it doesn't work.
> The attached file is my testcase.
>
> Thanks,

I think I figured out why mmap_miss doesn't work. After do_sync_mmap_readahead(), there is a
__filemap_get_folio() to make sure the page is ready. Then, it is ready too in filemap_map_pages(),
so the mmap_miss will decreased once. mmap_miss goes back to 0, and can't stop read-ahead.
Overall, I don't think mmap_miss can solve this problem.

.


