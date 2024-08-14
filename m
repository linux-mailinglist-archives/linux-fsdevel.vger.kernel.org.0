Return-Path: <linux-fsdevel+bounces-25884-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D357295148B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 08:32:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10A6C1C22BB3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 06:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88A88136658;
	Wed, 14 Aug 2024 06:32:16 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D9A5812;
	Wed, 14 Aug 2024 06:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723617136; cv=none; b=ovDbNwlqlrDgHleQENz99hMYo7K2HecGPuPk2cY1LM9CZsj5dWa2VHYPZ38PgywUZz3sW8CDa62a5qT+BsdcXkd7m8EyZNZLUR6jWc0v4bCUrVIT62HljmWXl39rrQcWngt2RjX9N6f7n1sZGs+n/1z0ENGK11oc74bKrzOilbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723617136; c=relaxed/simple;
	bh=olRYBGMNsorTwPCYBoL7eLIAFKG7rISs4n6vF9qdV7c=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=IyJMsDuCJXtddWsQuC4Wf5Boiovaidymi569ZQmrw7Rh4uiZucpbGYFc+PfkoWpbEs58dYRcZNU1XVflXpYRzvK8cbgtKSKFe3F803vf+HOcreVBRHAA7j7EWQihF/RyjHcS3NHtuvG/wyqmK638ewItGEHLa/oTWqC9n06H5FM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4WkJM25ywYz4f3jk7;
	Wed, 14 Aug 2024 14:31:58 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 2AF711A058E;
	Wed, 14 Aug 2024 14:32:08 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP4 (Coremail) with SMTP id gCh0CgB3n4VmT7xmlkqYBg--.46036S3;
	Wed, 14 Aug 2024 14:32:08 +0800 (CST)
Subject: Re: [PATCH v2 0/6] iomap: some minor non-critical fixes and
 improvements when block size < folio size
To: Dave Chinner <david@fromorbit.com>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, djwong@kernel.org, hch@infradead.org,
 brauner@kernel.org, jack@suse.cz, willy@infradead.org, yi.zhang@huawei.com,
 chengzhihao1@huawei.com, yukuai3@huawei.com
References: <20240812121159.3775074-1-yi.zhang@huaweicloud.com>
 <ZrwNG9ftNaV4AJDd@dread.disaster.area>
 <feead66e-5b83-7e54-1164-c7c61e78e7be@huaweicloud.com>
 <Zrwap10baOW8XeIv@dread.disaster.area>
 <a08a9491-61d7-b300-55ba-b016dd5aad5a@huaweicloud.com>
 <Zrw9lBma/kbKV8Ls@dread.disaster.area>
From: Zhang Yi <yi.zhang@huaweicloud.com>
Message-ID: <de4ca3ad-0eb0-834c-2ab4-bd6008d385cb@huaweicloud.com>
Date: Wed, 14 Aug 2024 14:32:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <Zrw9lBma/kbKV8Ls@dread.disaster.area>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgB3n4VmT7xmlkqYBg--.46036S3
X-Coremail-Antispam: 1UD129KBjvJXoWxWF4Utr1DZw1rGryDXrWxCrg_yoW5Aw48pF
	WagF9YkFn8tr4fXrn2yr40qryFy345JFn5W34rJ34jvrs0qr1xJF4xKFWruFZrXrs7Wr4j
	vr48J34xuF15ZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Ib4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4I
	kC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWU
	WwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr
	0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWU
	JVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJb
	IYCTnIWIevJa73UjIFyTuYvjxUF1v3UUUUU
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 2024/8/14 13:16, Dave Chinner wrote:
> On Wed, Aug 14, 2024 at 11:57:03AM +0800, Zhang Yi wrote:
>> On 2024/8/14 10:47, Dave Chinner wrote:
>>> On Wed, Aug 14, 2024 at 10:14:01AM +0800, Zhang Yi wrote:
>>>> On 2024/8/14 9:49, Dave Chinner wrote:
>>>>> important to know if the changes made actually provided the benefit
>>>>> we expected them to make....
>>>>>
>>>>> i.e. this is the sort of table of results I'd like to see provided:
>>>>>
>>>>> platform	base		v1		v2
>>>>> x86		524708.0	569218.0	????
>>>>> arm64		801965.0	871605.0	????
>>>>>
>>>>
>>>>  platform	base		v1		v2
>>>>  x86		524708.0	571315.0 	569218.0
>>>>  arm64	801965.0	876077.0	871605.0
>>>
>>> So avoiding the lock cycle in iomap_write_begin() (in patch 5) in
>>> this partial block write workload made no difference to performance
>>> at all, and removing a lock cycle in iomap_write_end provided all
>>> that gain?
>>
>> Yes.
>>
>>>
>>> Is this an overwrite workload or a file extending workload? The
>>> result implies that iomap_block_needs_zeroing() is returning false,
>>> hence it's an overwrite workload and it's reading partial blocks
>>> from disk. i.e. it is doing synchronous RMW cycles from the ramdisk
>>> and so still calling the uptodate bitmap update function rather than
>>> hitting the zeroing case and skipping it.
>>>
>>> Hence I'm just trying to understand what the test is doing because
>>> that tells me what the result should be...
>>>
>>
>> I forgot to mentioned that I test this on xfs with 1K block size, this
>> is a simple case of block size < folio size that I can direct use
>> UnixBench.
> 
> OK. So it's an even more highly contrived microbenchmark than I
> thought. :/
> 
> What is the impact on a 4kB block size filesystem running that same
> 1kB write test? That's going to be a far more common thing to occur
> in production machines for such small IO, 

Yeah, I agree with you, the original test case I want to test is
buffered overwrite with bs=4K to the 4KB filesystem which has existing
larger size folios (> 4KB), this is one kind of common case of
block size < folio size after large folio is enabled. But I don't find
a benchmark tool can do this test easily, so I use the above tests
parameters to simulate this case.

> let's make sure that we
> haven't regressed that case in optimising for this one.

Sure, I will test this case either.

> 
>> This test first do buffered append write with bs=1K,count=2000 in the
>> first round, and then do overwrite from the start position with the same
>> parameters repetitively in 30 seconds. All the write operations are
>> block size aligned, so iomap_write_begin() just continue after
>> iomap_adjust_read_range(), don't call iomap_set_range_uptodate() to set
>> range uptodate originally, hence there is no difference whether with or
>> without patch 5 in this test case.
> 
> Ok, so you really need to come up with an equivalent test that
> exercises the paths that patch 5 modifies, because right now we have
> no real idea of what the impact of that change will be...
> 

Sure.

Thanks,
Yi.


