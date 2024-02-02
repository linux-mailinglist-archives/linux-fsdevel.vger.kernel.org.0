Return-Path: <linux-fsdevel+bounces-9952-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63563846647
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 04:05:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 026FE1F27511
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 03:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A2B4C131;
	Fri,  2 Feb 2024 03:05:28 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC69BE5A
	for <linux-fsdevel@vger.kernel.org>; Fri,  2 Feb 2024 03:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706843128; cv=none; b=AddUaeYnZi9aK7OvjaGQPljuh4Ru6Wpbz5WGynsPVXY3AHa2CNEuzm3K3u7d6n/R2SpUWdgIpHSyYPNiXalJDwQqJPwzsIckuATLPMq4mrB4RqJH+eH3IFL9grVP7VCS2Q8VVBMDQR8EwnwzQxnF8g7DwMPaGRd2ixnFoapgdts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706843128; c=relaxed/simple;
	bh=JRekS3WddbaaxMrX/64wljfBNx5CrWBGJq+qA+uUbOw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=na7+oBc/0IXYqDP8vba9BCiupagyyrwDqYNYuuwi6N9WOInopQ9EtThPn4TS0VozdiqFaBqqtnUHxku0xrUZjgfYYamlorGAqMg99wSW4bjmmO0+xcP8iegUrqzUfqc683x8nWWmJMnoxrm08mfYvsZt8DqL0RL4/PUhnUAXCPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4TR0vd2M8Wz29l70;
	Fri,  2 Feb 2024 11:03:09 +0800 (CST)
Received: from dggpemm100001.china.huawei.com (unknown [7.185.36.93])
	by mail.maildlp.com (Postfix) with ESMTPS id 411F51400CC;
	Fri,  2 Feb 2024 11:05:01 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 2 Feb 2024 11:05:00 +0800
Message-ID: <b2e90e4b-f41f-4e1a-a089-55b2696c2e62@huawei.com>
Date: Fri, 2 Feb 2024 11:04:59 +0800
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
To: Matthew Wilcox <willy@infradead.org>
CC: Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>, Tony Luck
	<tony.luck@intel.com>, Naoya Horiguchi <naoya.horiguchi@nec.com>, Miaohe Lin
	<linmiaohe@huawei.com>, David Hildenbrand <david@redhat.com>, Muchun Song
	<muchun.song@linux.dev>, Benjamin LaHaise <bcrl@kvack.org>,
	<jglisse@redhat.com>, <linux-aio@kvack.org>, <linux-fsdevel@vger.kernel.org>
References: <20240129070934.3717659-1-wangkefeng.wang@huawei.com>
 <20240129070934.3717659-7-wangkefeng.wang@huawei.com>
 <ZbwAWXhz26Q7ZYMr@casper.infradead.org>
From: Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <ZbwAWXhz26Q7ZYMr@casper.infradead.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm100001.china.huawei.com (7.185.36.93)



On 2024/2/2 4:34, Matthew Wilcox wrote:
> On Mon, Jan 29, 2024 at 03:09:31PM +0800, Kefeng Wang wrote:
>> In order to support poisoned folio copy recover from migrate folio,
>> let's use folio_mc_copy() and move it in the begin of the function
>> of __migrate_folio(), which could simply error handling since there
>> is no turning back if folio_migrate_mapping() return success, the
>> downside is the folio copied even though folio_migrate_mapping()
>> return fail, a small optimization is to check whether folio does
>> not have extra refs before we do more work ahead in __migrate_folio(),
>> which could help us avoid unnecessary folio copy.
> 
> OK, I see why you've done it this way.
> 
> Would it make more sense if we pulled the folio refcount freezing
> out of folio_migrate_mapping() into its callers?  That way
> folio_migrate_mapping() could never fail.

Will try this way, thank.

