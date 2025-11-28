Return-Path: <linux-fsdevel+bounces-70110-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 66BBCC90D63
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Nov 2025 05:37:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4DF854E42FF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Nov 2025 04:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 429372C21C6;
	Fri, 28 Nov 2025 04:37:42 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D41F523FC54;
	Fri, 28 Nov 2025 04:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764304661; cv=none; b=maDAz8+AGuIj9+ZTrQ2Pdb8sMEJiAVGuVLPiBbfszmvST76B+O9pmePEm+gmF3HMCmEXavOtelMptGx8TTYEh4DxStqQVpMrwkGInpOqZActEurtl9fABzZbQTVi3iWKK2uFJnX8tozd9eSEAJkCggdR8nGbSdbweN8dhtyH3i8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764304661; c=relaxed/simple;
	bh=DUu94xoWkd0dJmcKHRRWZcxzmUg1M/vuXxP1BqNy6cI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r7hY90cl8iosSiHU8Qivkax+FJTuIeWA04ljT1kH/YQDzO6J6BBKGffB/YlZUJmn5cNpT/nObP9PkkA9HOTSQevQeCi8DU0kHlAle6oYJewgDzsPKPOVuMOtF8ZyyDKery5yRXVkwMg7ggUP3ciRiCKouPmezF1msdN/+CM1PoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4dHgVd1pXPzYQtsB;
	Fri, 28 Nov 2025 12:36:41 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id E39841A0359;
	Fri, 28 Nov 2025 12:37:35 +0800 (CST)
Received: from [10.174.178.152] (unknown [10.174.178.152])
	by APP2 (Coremail) with SMTP id Syh0CgA3lHoNJylpAv0YCQ--.15906S3;
	Fri, 28 Nov 2025 12:37:35 +0800 (CST)
Message-ID: <bb5b9323-d7ea-467b-a59f-ef6e415e766a@huaweicloud.com>
Date: Fri, 28 Nov 2025 12:37:33 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/13] ext4: replace ext4_es_insert_extent() when
 caching on-disk extents
To: Jan Kara <jack@suse.cz>
Cc: Ojaswin Mujoo <ojaswin@linux.ibm.com>, linux-ext4@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, tytso@mit.edu,
 adilger.kernel@dilger.ca, yi.zhang@huawei.com, yizhang089@gmail.com,
 libaokun1@huawei.com, yangerkun@huawei.com
References: <20251121060811.1685783-1-yi.zhang@huaweicloud.com>
 <aSLoN-oEqS-OpLKE@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <9cef3b97-083e-48e6-aced-3e250df364e3@huaweicloud.com>
 <yfekmxz7biiuvairgen2pw6laccs4qvblt56uxmqenyckt2pp6@rfagttgqpdfr>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <yfekmxz7biiuvairgen2pw6laccs4qvblt56uxmqenyckt2pp6@rfagttgqpdfr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgA3lHoNJylpAv0YCQ--.15906S3
X-Coremail-Antispam: 1UD129KBjvJXoWxXw17ur4fWrW5uw47JFW3GFg_yoWrJFW5pr
	ZIkayYkw4kCa4vvr92yF42qw48tayfGrZrCryFqrWUAayDX3sFqrW5Kw4j9a4j9rn5Kw42
	vrWUK3sxC3Wjy3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

On 11/27/2025 8:24 PM, Jan Kara wrote:
> Hi Yi!
> 
> On Mon 24-11-25 13:04:04, Zhang Yi wrote:
>> On 11/23/2025 6:55 PM, Ojaswin Mujoo wrote:
>>> On Fri, Nov 21, 2025 at 02:07:58PM +0800, Zhang Yi wrote:
>>>> Changes since v1:
>>>>  - Rebase the codes based on the latest linux-next 20251120.
>>>>  - Add patches 01-05, fix two stale data problems caused by
>>>
>>> Hi Zhang, thanks for the patches.
>>>
>>
>> Thank you for take time to look at this series.
>>
>>> I've always felt uncomfortable with the ZEROOUT code here because it
>>> seems to have many such bugs as you pointed out in the series. Its very
>>> fragile and the bugs are easy to miss behind all the data valid and
>>> split flags mess. 
>>>
>>
>> Yes, I agree with you. The implementation of EXT4_EXT_MAY_ZEROOUT has
>> significantly increased the complexity of split extents and the
>> potential for bugs.
> 
> Yep, that code is complex and prone to bugs.
> 
>>> As per my understanding, ZEROOUT logic seems to be a special best-effort
>>> try to make the split/convert operation "work" when dealing with
>>> transient errors like ENOSPC etc. I was just wondering if it makes sense
>>> to just get rid of the whole ZEROOUT logic completely and just reset the
>>> extent to orig state if there is any error. This allows us to get rid of
>>> DATA_VALID* flags as well and makes the whole ext4_split_convert_extents() 
>>> slightly less messy.
>>>
>>> Maybe we can have a retry loop at the top level caller if we want to try
>>> again for say ENOSPC or ENOMEM. 
>>>
>>> Would love to hear your thoughts on it.
>>
>> I think this is a direction worth exploring. However, what I am
>> currently considering is that we need to address this scenario of
>> splitting extent during the I/O completion. Although the ZEROOUT logic
>> is fragile and has many issues recently, it currently serves as a
>> fallback solution for handling ENOSPC errors that arise when splitting
>> extents during I/O completion. It ensures that I/O operations do not
>> fail due to insufficient extent blocks.
> 
> Also partial extent zeroout offers a good performance win when the
> portion needing zeroout is small (we can save extent splitting). And I
> agree it is a good safety net for ENOSPC issues - otherwise there's no
> guarantee page writeback can finish without hitting ENOSPC. We do have
> reserved blocks for these cases but the pool is limited so you can still
> run out of blocks if you try hard enough.

Yes, Indeed!

> 
>> Please see ext4_convert_unwritten_extents_endio(). Although we have made
>> our best effort to tried to split extents using
>> EXT4_GET_BLOCKS_IO_CREATE_EXT before issuing I/Os, we still have not
>> covered all scenarios. Moreover, after converting the buffered I/O path
>> to the iomap infrastructure in the future, we may need to split extents
>> during the I/O completion worker[1].
> 
> Yes, this might be worth exploring. The advantage of doing extent splitting
> in advance is that on IO submission you have the opportunity of restarting
> the transaction on ENOSPC to possibly release some blocks. This is not
> easily doable e.g. on writeback completion so the pressure on the pool of
> reserved blocks is going to be more common (previously you needed reserved
> blocks only when writeback was racing with fallocate or similar, now you
> may need them each time you write in the middle of unwritten extent). So I
> think the change will need some testing whether it isn't too easy to hit
> ENOSPC conditions on IO completion without EXT4_GET_BLOCKS_IO_CREATE_EXT.
> But otherwise it's always nice to remove code :)
>  
> 								Honza

Yes, we need to be very careful about this, I have written a POC patch and
am currently conducting related tests. I hope it works.  :-)

Thanks,
Yi.


