Return-Path: <linux-fsdevel+bounces-53907-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66280AF8CC5
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jul 2025 10:52:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC4AA3B9252
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jul 2025 08:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E96E42DAFC3;
	Fri,  4 Jul 2025 08:47:16 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA64E2DAFAE;
	Fri,  4 Jul 2025 08:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751618836; cv=none; b=iJhqJXNZfbvXH3pf4sgT60tSosHANbjfaEBjgrIBXY0d+oDKi6Vbjy8WE+yy3aqmd13nnwQJPYH4HW86ljshEEILnuPyizjYYlaQVINzJAw6paMRfV/ZP7S5mCRHbuMkUpS9Uqls2PrAAxB7IasnOvP9RaC5VBKIvrd3wCRlcDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751618836; c=relaxed/simple;
	bh=TWmJdeIYeEuBJcd9NqV2O8kqXLjlEAjWmbj91C+OgL4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=udNd4EOufPCYQiE7crXgRXmgl5FeK/fRsVZhSena5gMjwxYHefuvL5ImX8LRksfqMv34z3SECKzuG72XP7y+tgcML7s9UbZS4DwORtsi0zerXq8ass4lI3G+ZUwB4qvkIdtGRdzR6S/OO1zK0aG4O80fWBVmNWk7YAf6Rf51KmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4bYS1Y0LSQzKHMkC;
	Fri,  4 Jul 2025 16:47:13 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 72C061A06E6;
	Fri,  4 Jul 2025 16:47:11 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP3 (Coremail) with SMTP id _Ch0CgBXuSYNlWdoU6BzAg--.32297S3;
	Fri, 04 Jul 2025 16:47:11 +0800 (CST)
Message-ID: <6a47b6f2-08d5-49ae-aee5-9068a421de05@huaweicloud.com>
Date: Fri, 4 Jul 2025 16:47:09 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/10] ext4: restart handle if credits are insufficient
 during allocating blocks
To: Jan Kara <jack@suse.cz>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
 ojaswin@linux.ibm.com, sashal@kernel.org, yi.zhang@huawei.com,
 libaokun1@huawei.com, yukuai3@huawei.com, yangerkun@huawei.com
References: <20250701130635.4079595-1-yi.zhang@huaweicloud.com>
 <20250701130635.4079595-6-yi.zhang@huaweicloud.com>
 <i7lzmvk5prgnw2zri46adshfjhfq63r7le5w5sv67wmkiimbhc@a24oub5o6xtg>
 <ceb8c9c1-f426-4cd0-b7d8-841190631a90@huaweicloud.com>
 <zqrcmug26tnhhjombztjjqwcorbnk4elqg2dqayhtfo2gkx3e3@wvzykthigny6>
 <f73b6973-3f7c-4e0e-9908-3a3f151715b5@huaweicloud.com>
 <mk5f4g4rwp37ob6qmd7asocumeepjcnufqzjvazr3yukbyzq3y@6gp6x6zvxf7r>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <mk5f4g4rwp37ob6qmd7asocumeepjcnufqzjvazr3yukbyzq3y@6gp6x6zvxf7r>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_Ch0CgBXuSYNlWdoU6BzAg--.32297S3
X-Coremail-Antispam: 1UD129KBjvJXoWxAFyDZw47Kw4fAFW3WF17Wrg_yoW5ArWDpr
	WfCF1jyr47GFyUAF40vw18XF13t348CrWUXrZ8Wryqq3Z09r1fKF18Ja4jkFyjyrW8WF4U
	Zr4Ut343WF15ArJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8
	ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1
	7KsUUUUUU==
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 2025/7/4 16:18, Jan Kara wrote:
> On Fri 04-07-25 09:40:23, Zhang Yi wrote:
>> On 2025/7/4 0:27, Jan Kara wrote:
>>> On Thu 03-07-25 10:13:07, Zhang Yi wrote:
>>>> On 2025/7/2 22:18, Jan Kara wrote:
>>>>> On Tue 01-07-25 21:06:30, Zhang Yi wrote:
>>>>>> From: Zhang Yi <yi.zhang@huawei.com>
>>>>>>
>>>>>> After large folios are supported on ext4, writing back a sufficiently
>>>>>> large and discontinuous folio may consume a significant number of
>>>>>> journal credits, placing considerable strain on the journal. For
>>>>>> example, in a 20GB filesystem with 1K block size and 1MB journal size,
>>>>>> writing back a 2MB folio could require thousands of credits in the
>>>>>> worst-case scenario (when each block is discontinuous and distributed
>>>>>> across different block groups), potentially exceeding the journal size.
>>>>>> This issue can also occur in ext4_write_begin() and ext4_page_mkwrite()
>>>>>> when delalloc is not enabled.
>>>>>>
>>>>>> Fix this by ensuring that there are sufficient journal credits before
>>>>>> allocating an extent in mpage_map_one_extent() and
>>>>>> ext4_block_write_begin(). If there are not enough credits, return
>>>>>> -EAGAIN, exit the current mapping loop, restart a new handle and a new
>>>>>> transaction, and allocating blocks on this folio again in the next
>>>>>> iteration.
>>>>>>
>>>>>> Suggested-by: Jan Kara <jack@suse.cz>
>>>>>> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
>>>>>
>>>>> Very nice. Feel free to add:
>>>>>
>>>>> Reviewed-by: Jan Kara <jack@suse.cz>
>>>>>
>>>>> One small comment below:
>>>>>
>>>>>> +/*
>>>>>> + * Make sure that the current journal transaction has enough credits to map
>>>>>> + * one extent. Return -EAGAIN if it cannot extend the current running
>>>>>> + * transaction.
>>>>>> + */
>>>>>> +static inline int ext4_journal_ensure_extent_credits(handle_t *handle,
>>>>>> +						     struct inode *inode)
>>>>>> +{
>>>>>> +	int credits;
>>>>>> +	int ret;
>>>>>> +
>>>>>> +	if (!handle)
>>>>>
>>>>> Shouldn't this rather be ext4_handle_valid(handle) to catch nojournal mode
>>>>> properly?
>>>>>
>>>> __ext4_journal_ensure_credits() already calls ext4_handle_valid() to handle
>>>> nojournal mode, and the '!handle' check here is to handle the case where
>>>> ext4_block_write_begin() passes in a NULL 'handle'.
>>>
>>> Ah, right. But then you don't need the test at all, do you? Anyway,
>>> whatever you decide to do with this (or nothing) is fine by me.
>>>
>>
>> Yeah, remove this test is fine with me. I added this one is because the
>> comments in ext4_handle_valid() said "Do not use this for NULL handles."
>> I think it is best to follow this rule. :)
> 
> Right, I didn't read that comment :) So maybe the best fix will be just
> adding a comment before the test like:
> 
> 	/* Called from ext4_da_write_begin() which has no handle started? */
> 	if (!handle)
> 		return 0;
> 

Sure, it looks good, will do.

Thanks,
Yi.






