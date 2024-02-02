Return-Path: <linux-fsdevel+bounces-9971-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BACBE846B87
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 10:06:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5BF31B25659
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 09:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59A8367E97;
	Fri,  2 Feb 2024 09:06:15 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B20A13418B
	for <linux-fsdevel@vger.kernel.org>; Fri,  2 Feb 2024 09:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706864775; cv=none; b=e/n1z+gei55pGlaKF6rMFw8qKSUtJHss2VHrj684yLcm5IRB8O9xGjFdPUCFkFYzAV7R6i/CznDpGGGMm9uK8jV0C+Yiton7G44G7ZzNpKlpJHYqobAIhqS0obSjfarOTrsp/boa/pptVcgsQE14E1OZrSLsjLbuiG3dgXZiqAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706864775; c=relaxed/simple;
	bh=Dby0MxRtoSEhf4Z9awB2xdUr9FUrsLg/0TDWF8iDx2o=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=IyOIT90RjSe9GnXSfDV3GGsFutRXllGruBzATrotEGJzTlXpqCyWYZOsynOj4ta/HC3NOk76P2xyLzaJVZf688kDyB6NW7ruV7K/0qpK7XE47IvAUBQtvlFSL26J4de2hQoAdxykNKVpxSgvQy/y+WFeIoeP5nawb+GymImbl4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4TR8wQ4xDFzvVL3;
	Fri,  2 Feb 2024 17:04:22 +0800 (CST)
Received: from dggpemm100001.china.huawei.com (unknown [7.185.36.93])
	by mail.maildlp.com (Postfix) with ESMTPS id 86FC41404F8;
	Fri,  2 Feb 2024 17:06:04 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 2 Feb 2024 17:06:03 +0800
Message-ID: <d5f38cf9-4be7-4da1-ab0e-77dcbe07ef6c@huawei.com>
Date: Fri, 2 Feb 2024 17:06:03 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rfc 6/9] mm: migrate: support poisoned recover from
 migrate folio
Content-Language: en-US
From: Kefeng Wang <wangkefeng.wang@huawei.com>
To: Matthew Wilcox <willy@infradead.org>
CC: Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>, Tony Luck
	<tony.luck@intel.com>, Naoya Horiguchi <naoya.horiguchi@nec.com>, Miaohe Lin
	<linmiaohe@huawei.com>, David Hildenbrand <david@redhat.com>, Muchun Song
	<muchun.song@linux.dev>, Benjamin LaHaise <bcrl@kvack.org>,
	<jglisse@redhat.com>, <linux-aio@kvack.org>, <linux-fsdevel@vger.kernel.org>
References: <20240129070934.3717659-1-wangkefeng.wang@huawei.com>
 <20240129070934.3717659-7-wangkefeng.wang@huawei.com>
 <ZbwAWXhz26Q7ZYMr@casper.infradead.org>
 <b2e90e4b-f41f-4e1a-a089-55b2696c2e62@huawei.com>
In-Reply-To: <b2e90e4b-f41f-4e1a-a089-55b2696c2e62@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm100001.china.huawei.com (7.185.36.93)



On 2024/2/2 11:04, Kefeng Wang wrote:
> 
> 
> On 2024/2/2 4:34, Matthew Wilcox wrote:
>> On Mon, Jan 29, 2024 at 03:09:31PM +0800, Kefeng Wang wrote:
>>> In order to support poisoned folio copy recover from migrate folio,
>>> let's use folio_mc_copy() and move it in the begin of the function
>>> of __migrate_folio(), which could simply error handling since there
>>> is no turning back if folio_migrate_mapping() return success, the
>>> downside is the folio copied even though folio_migrate_mapping()
>>> return fail, a small optimization is to check whether folio does
>>> not have extra refs before we do more work ahead in __migrate_folio(),
>>> which could help us avoid unnecessary folio copy.
>>
>> OK, I see why you've done it this way.
>>
>> Would it make more sense if we pulled the folio refcount freezing
>> out of folio_migrate_mapping() into its callers?  That way
>> folio_migrate_mapping() could never fail.
> 
Question, the folio ref freezing is under the xas_lock_irq(), it can't
be moved out of lock, and if with xas lock irq, we couldn't call
folio_mc_copy(), so the above way is not feasible, or maybe I missing
something?



