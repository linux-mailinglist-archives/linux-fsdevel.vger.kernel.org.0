Return-Path: <linux-fsdevel+bounces-30321-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74EAF9898F2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Sep 2024 03:27:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A915A2839F0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Sep 2024 01:27:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FE8B2F30;
	Mon, 30 Sep 2024 01:27:41 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0DC936D
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Sep 2024 01:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727659661; cv=none; b=pP9pLzjDL0WBBnVuf8TAieesKsUAumecoWkqFkHGxBtgO3LMZPxT8/+c2iRl/qCgpJE2mug0J6BgFIM5kTBrR+f02K8kY6z7/kQH59nmC5+7wdUTA9L2yWiCDTMwy6qPK/h15x63ztUN5aQFuuOl1TJ8kfh6rJjY5nAGPzMlOIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727659661; c=relaxed/simple;
	bh=TCsmi1curqm/akYnsUVFl0nOyebe7klRcWD/xIjX7oM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=caeFFt22RsqvL4KzLUka6Tf7EunnUt1MKQ3iKIDz2ytwZX0p9yphC0ealZbtsWdg/90qGL5kAkeQwn4A9R4/XjXHMOfBPipRtbNeoXg51Dnqd9g+8EX0D35zPAGeP7VgUzkNRP2mPMq5C+aWiyl1z5KcYmg1c9afvRoQ5uxPiFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4XH3NB4QL4z1ymhF;
	Mon, 30 Sep 2024 09:27:38 +0800 (CST)
Received: from dggpemf100008.china.huawei.com (unknown [7.185.36.138])
	by mail.maildlp.com (Postfix) with ESMTPS id 101CF180041;
	Mon, 30 Sep 2024 09:27:36 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemf100008.china.huawei.com (7.185.36.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 30 Sep 2024 09:27:35 +0800
Message-ID: <579518dd-a04c-491b-9c46-0880fa9fdf9c@huawei.com>
Date: Mon, 30 Sep 2024 09:27:34 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] tmpfs: fault in smaller chunks if large folio
 allocation not allowed
To: Matthew Wilcox <willy@infradead.org>
CC: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>, Andrew Morton
	<akpm@linux-foundation.org>, Hugh Dickins <hughd@google.com>, Alexander Viro
	<viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara
	<jack@suse.cz>, Anna Schumaker <Anna.Schumaker@netapp.com>,
	<linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>, Baolin Wang
	<baolin.wang@linux.alibaba.com>
References: <20240914140613.2334139-1-wangkefeng.wang@huawei.com>
 <20240920143654.1008756-1-wangkefeng.wang@huawei.com>
 <Zu9mbBHzI-MyRoHa@casper.infradead.org>
 <1d4f98aa-f57d-4801-8510-5c44e027c4e4@huawei.com>
 <nhnpbkyxbbvjl2wg77x2f7gx3b3wj7jujfkucc33tih3d4jnpx@5dg757r4go64>
 <ZvVnO777wfXcfjYX@casper.infradead.org>
 <9a420cea-b0c0-4c25-8c31-0eb2e2f33549@huawei.com>
 <ZvV2fAELufMuNdWh@casper.infradead.org>
Content-Language: en-US
From: Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <ZvV2fAELufMuNdWh@casper.infradead.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemf100008.china.huawei.com (7.185.36.138)



On 2024/9/26 22:58, Matthew Wilcox wrote:
> On Thu, Sep 26, 2024 at 10:20:54PM +0800, Kefeng Wang wrote:
>> On 2024/9/26 21:52, Matthew Wilcox wrote:
>>> On Thu, Sep 26, 2024 at 10:38:34AM +0200, Pankaj Raghav (Samsung) wrote:
>>>>> So this is why I don't use mapping_set_folio_order_range() here, but
>>>>> correct me if I am wrong.
>>>>
>>>> Yeah, the inode is active here as the max folio size is decided based on
>>>> the write size, so probably mapping_set_folio_order_range() will not be
>>>> a safe option.
>>>
>>> You really are all making too much of this.  Here's the patch I think we
>>> need:
>>>
>>> -       mapping_set_large_folios(inode->i_mapping);
>>> +       if (sbinfo->huge)
>>> +               mapping_set_large_folios(inode->i_mapping);
>>
>> But it can't solve all issue, eg,
>>    mount with huge = SHMEM_HUGE_WITHIN_SIZE, or
> 
> The page cache will not create folios which overhang the end of the file
> by more than the minimum folio size for that mapping.  So this is wrong.


Sorry for the late, not very familiar with it, will test after back to 
the office in next few days.

> 
>>    mount with SHMEM_HUGE_ALWAYS  +  runtime SHMEM_HUGE_DENY
> 
> That's a tweak to this patch, not a fundamental problem with it.
> 
>> and the above change will break
>>    mount with SHMEM_HUGE_NEVER + runtime SHMEM_HUGE_FORCE
> 
> Likewise.
> 

But the SHMEM_HUGE_DENY/FORCE could be changed at runtime, I don't find
a better way to fix, any more suggestion will be appreciate, thanks.



