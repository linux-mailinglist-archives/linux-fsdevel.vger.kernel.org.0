Return-Path: <linux-fsdevel+bounces-9945-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A0EE846567
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 02:25:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3AA81F26950
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 01:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76BEEC130;
	Fri,  2 Feb 2024 01:25:21 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02F69BE59;
	Fri,  2 Feb 2024 01:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706837121; cv=none; b=YOY1CZ6ScwokZFqICPM/T5HIJoCItIoEpQ0GUpEsC7VMZi664ITB5SkylID3NLG55nQB1aCjKPUYkFG3HfgcBSf4bdUxYeofVPzfRn3y0Mb4E7nQoGBzkwhISvm7uLPgyeUZMLVg/FDcrhyzGadbpc/GY6pMARfTlFmPNN3EX8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706837121; c=relaxed/simple;
	bh=9pXzTZRahveJlD2529M3LyLuJv0HB2sVEZBmB7s4/Xk=;
	h=Subject:To:References:CC:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=MZFJDWfTexA3wjoJnAy+zPr5GqmYPve8fkcZH5F6/ANK+QjwBk9j247hw5297QVLoLdinzlXQykNNSpljfNZvRAP+UbHotlYqm5IG4piIcdnTA9Shb4OxNzDiATjU/9/kCJ0IYypGXcIjSt0+l3xYo4eWdOqwIaj6dwe9tWqyEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4TQyjV0rxwz1xn6M;
	Fri,  2 Feb 2024 09:24:14 +0800 (CST)
Received: from dggpemd200004.china.huawei.com (unknown [7.185.36.141])
	by mail.maildlp.com (Postfix) with ESMTPS id CC7AC140384;
	Fri,  2 Feb 2024 09:25:15 +0800 (CST)
Received: from [10.174.179.24] (10.174.179.24) by
 dggpemd200004.china.huawei.com (7.185.36.141) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1258.28; Fri, 2 Feb 2024 09:25:15 +0800
Subject: Re: [PATCH 2/2] mm/readahead: limit sync readahead while too many
 active refault
To: Jan Kara <jack@suse.cz>
References: <20240201100835.1626685-1-liushixin2@huawei.com>
 <20240201100835.1626685-3-liushixin2@huawei.com>
 <20240201093749.ll7uzgt7ixy7kkhw@quack3>
 <c768cab9-4ccb-9618-24a8-b51d3f141340@huawei.com>
 <20240201173130.frpaqpy7iyzias5j@quack3>
CC: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner
	<brauner@kernel.org>, Matthew Wilcox <willy@infradead.org>, Andrew Morton
	<akpm@linux-foundation.org>, <linux-fsdevel@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
From: Liu Shixin <liushixin2@huawei.com>
Message-ID: <b9e9ddc7-6e12-b9af-e08b-8e85b8372607@huawei.com>
Date: Fri, 2 Feb 2024 09:25:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240201173130.frpaqpy7iyzias5j@quack3>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemd200004.china.huawei.com (7.185.36.141)


On 2024/2/2 1:31, Jan Kara wrote:
> On Thu 01-02-24 18:41:30, Liu Shixin wrote:
>> On 2024/2/1 17:37, Jan Kara wrote:
>>> On Thu 01-02-24 18:08:35, Liu Shixin wrote:
>>>> When the pagefault is not for write and the refault distance is close,
>>>> the page will be activated directly. If there are too many such pages in
>>>> a file, that means the pages may be reclaimed immediately.
>>>> In such situation, there is no positive effect to read-ahead since it will
>>>> only waste IO. So collect the number of such pages and when the number is
>>>> too large, stop bothering with read-ahead for a while until it decreased
>>>> automatically.
>>>>
>>>> Define 'too large' as 10000 experientially, which can solves the problem
>>>> and does not affect by the occasional active refault.
>>>>
>>>> Signed-off-by: Liu Shixin <liushixin2@huawei.com>
>>> So I'm not convinced this new logic is needed. We already have
>>> ra->mmap_miss which gets incremented when a page fault has to read the page
>>> (and decremented when a page fault found the page already in cache). This
>>> should already work to detect trashing as well, shouldn't it? If it does
>>> not, why?
>>>
>>> 								Honza
>> ra->mmap_miss doesn't help, it increased only one in do_sync_mmap_readahead()
>> and then decreased one for every page in filemap_map_pages(). So in this scenario,
>> it can't exceed MMAP_LOTSAMISS.
> I see, OK. But that's a (longstanding) bug in how mmap_miss is handled. Can
> you please test whether attached patches fix the trashing for you? At least
> now I can see mmap_miss properly increments when we are hitting uncached
> pages...  Thanks!
>
> 								Honza
Thanks for the patch, I will test it.
>


