Return-Path: <linux-fsdevel+bounces-30323-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAFA298993C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Sep 2024 04:31:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5E5E1C20C75
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Sep 2024 02:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E69651BC49;
	Mon, 30 Sep 2024 02:31:02 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C965A383
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Sep 2024 02:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727663462; cv=none; b=H7zBhmCcbx42UZZ6GXWdpJAUZbekTvILIenS1eedjTIEPU3S/DqvVK04iD+rUDo2WKBuaLd3HxiEnKTy2qpdhYRszXlmaOlzWkb22HPnddwt64ZrVvuyIcM2oSdqQ1sixnBjFCvE7x2gMJPYuR3IoWyMPpLXYaB1lpPM3WASpqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727663462; c=relaxed/simple;
	bh=AKELPCtTfiwgpDzkYmmDw6QVuaWYsINPKxNVZaPW2+Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=qMYAzkjKci5YMqaGkb5WsDer0Qi0TtXVtbj2p8WlQXxk0DidDrhJagr4sx/E1e/JgaL9boPJo1YAz1iT+KED7aA3KF6nDLBl+WVplyubIifGTz7xys8PoEz98sC7e7Z9BAey6akWg/9FJH/qaO76+31SRw3YTT9Z7fyg48VmMwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4XH4mC1zVZz1SBK2;
	Mon, 30 Sep 2024 10:30:03 +0800 (CST)
Received: from dggpemf100008.china.huawei.com (unknown [7.185.36.138])
	by mail.maildlp.com (Postfix) with ESMTPS id 303171401E9;
	Mon, 30 Sep 2024 10:30:57 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemf100008.china.huawei.com (7.185.36.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 30 Sep 2024 10:30:56 +0800
Message-ID: <8c5d01b2-f070-4395-aa72-5ad56d6423e5@huawei.com>
Date: Mon, 30 Sep 2024 10:30:56 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] tmpfs: fault in smaller chunks if large folio
 allocation not allowed
To: Baolin Wang <baolin.wang@linux.alibaba.com>, Matthew Wilcox
	<willy@infradead.org>, "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
CC: Andrew Morton <akpm@linux-foundation.org>, Hugh Dickins
	<hughd@google.com>, Alexander Viro <viro@zeniv.linux.org.uk>, Christian
 Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Anna Schumaker
	<Anna.Schumaker@netapp.com>, <linux-fsdevel@vger.kernel.org>,
	<linux-mm@kvack.org>
References: <20240914140613.2334139-1-wangkefeng.wang@huawei.com>
 <20240920143654.1008756-1-wangkefeng.wang@huawei.com>
 <Zu9mbBHzI-MyRoHa@casper.infradead.org>
 <1d4f98aa-f57d-4801-8510-5c44e027c4e4@huawei.com>
 <nhnpbkyxbbvjl2wg77x2f7gx3b3wj7jujfkucc33tih3d4jnpx@5dg757r4go64>
 <ZvVnO777wfXcfjYX@casper.infradead.org>
 <1e5357de-3356-4ae7-bc69-b50edca3852b@linux.alibaba.com>
Content-Language: en-US
From: Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <1e5357de-3356-4ae7-bc69-b50edca3852b@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemf100008.china.huawei.com (7.185.36.138)



On 2024/9/30 10:02, Baolin Wang wrote:
> 
> 
> On 2024/9/26 21:52, Matthew Wilcox wrote:
>> On Thu, Sep 26, 2024 at 10:38:34AM +0200, Pankaj Raghav (Samsung) wrote:
>>>> So this is why I don't use mapping_set_folio_order_range() here, but
>>>> correct me if I am wrong.
>>>
>>> Yeah, the inode is active here as the max folio size is decided based on
>>> the write size, so probably mapping_set_folio_order_range() will not be
>>> a safe option.
>>
>> You really are all making too much of this.  Here's the patch I think we
>> need:
>>
>> +++ b/mm/shmem.c
>> @@ -2831,7 +2831,8 @@ static struct inode *__shmem_get_inode(struct 
>> mnt_idmap *idmap,
>>          cache_no_acl(inode);
>>          if (sbinfo->noswap)
>>                  mapping_set_unevictable(inode->i_mapping);
>> -       mapping_set_large_folios(inode->i_mapping);
>> +       if (sbinfo->huge)
>> +               mapping_set_large_folios(inode->i_mapping);
>>
>>          switch (mode & S_IFMT) {
>>          default:
> 
> IMHO, we no longer need the the 'sbinfo->huge' validation after adding 
> support for large folios in the tmpfs write and fallocate paths [1].
> 
> Kefeng, can you try if the following RFC patch [1] can solve your 
> problem? Thanks.
> (PS: I will revise the patch according to Matthew's suggestion)

Sure, will try once I come back, but [1] won't solve the issue when set
force/deny at runtime, eg, mount with always/within_size, but set deny 
when runtime, we still fault in large chunks, but we can't allocate 
large folio, the performance of write will be degradation.


> 
> [1] https://lore.kernel.org/all/ 
> c03ec1cb1392332726ab265a3d826fe1c408c7e7.1727338549.git.baolin.wang@linux.alibaba.com/


