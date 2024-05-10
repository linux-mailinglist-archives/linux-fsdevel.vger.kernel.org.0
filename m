Return-Path: <linux-fsdevel+bounces-19244-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C49C78C1D1D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 May 2024 05:40:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 515491F213CA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 May 2024 03:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A45B149DE0;
	Fri, 10 May 2024 03:39:58 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A96AF149005;
	Fri, 10 May 2024 03:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715312397; cv=none; b=DS6UVCg9f/DaNrQ6PRioa1GbvAsLOHwbrqoOVgKAI7cgzfIBB7Hdjvm/GLuKFEb7PL5CSBKJeQ1U6h6BUnljYZZjz5FRxpaPNjuhYqSe0hxUN6X3Slj6GDBobv7ziHO2CQ4Sb7XXMBjIOmkBaYPHHb5tmFORIubmhVB8DkRnVGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715312397; c=relaxed/simple;
	bh=MzGKN2htNtSO7ZY5plDbnHZ7Vi7jZ4+VgzmNjhBrdLk=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=mD3sUB8CE4Yl6vDEh+Plu9wbXJlHC7hvj0laxMS4nx+r5WWHiHp15UYcYBh/8QmZq0D0QEbF0KiGas3ndPkWfa+JgN+ReexQsNwYkMguONOqGVJoBehFMw066rPWZCj6Cqf9UXrb7soOzixbQAAJ4QqxVr7DSHnmM1HD/qCwl44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4VbF4Z2tlKz4f3kpL;
	Fri, 10 May 2024 11:39:42 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id C12281A0901;
	Fri, 10 May 2024 11:39:50 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP2 (Coremail) with SMTP id Syh0CgAnmAsElz1m8DcpMg--.16051S3;
	Fri, 10 May 2024 11:39:50 +0800 (CST)
Subject: Re: [PATCH v3 03/26] ext4: correct the hole length returned by
 ext4_map_blocks()
To: Luis Henriques <luis.henriques@linux.dev>, Theodore Ts'o <tytso@mit.edu>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, adilger.kernel@dilger.ca,
 jack@suse.cz, ritesh.list@gmail.com, hch@infradead.org, djwong@kernel.org,
 willy@infradead.org, zokeefe@google.com, yi.zhang@huawei.com,
 chengzhihao1@huawei.com, yukuai3@huawei.com, wangkefeng.wang@huawei.com
References: <20240127015825.1608160-1-yi.zhang@huaweicloud.com>
 <20240127015825.1608160-4-yi.zhang@huaweicloud.com>
 <87zfszuib1.fsf@brahms.olymp> <20240509163953.GI3620298@mit.edu>
 <87h6f6vqzj.fsf@brahms.olymp>
From: Zhang Yi <yi.zhang@huaweicloud.com>
Message-ID: <b9b93ad2-2253-6850-da38-afc42370303e@huaweicloud.com>
Date: Fri, 10 May 2024 11:39:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <87h6f6vqzj.fsf@brahms.olymp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgAnmAsElz1m8DcpMg--.16051S3
X-Coremail-Antispam: 1UD129KBjvJXoWxJFyxGw15KFWfuF4DAF4Dtwb_yoWrCw48pF
	WfAa1Utr1kG340krZ7Aw1rX3WS9w45C3y3ArWfWryfAas8ur1kGFyxKFWY9F97ur48u3ya
	qayjqFy7KF1qvFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
	Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a
	6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
	kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE
	14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf
	9x07UZ18PUUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 2024/5/10 1:23, Luis Henriques wrote:
> On Thu 09 May 2024 12:39:53 PM -04, Theodore Ts'o wrote;
> 
>> On Thu, May 09, 2024 at 04:16:34PM +0100, Luis Henriques wrote:
>>>
>>> It's looks like it's easy to trigger an infinite loop here using fstest
>>> generic/039.  If I understand it correctly (which doesn't happen as often
>>> as I'd like), this is due to an integer overflow in the 'if' condition,
>>> and should be fixed with the patch below.
>>
>> Thanks for the report.  However, I can't reproduce the failure, and
>> looking at generic/039, I don't see how it could be relevant to the
>> code path in question.  Generic/039 creates a test symlink with two
>> hard links in the same directory, syncs the file system, and then
>> removes one of the hard links, and then drops access to the block
>> device using dmflakey.  So I don't see how the extent code would be
>> involved at all.  Are you sure that you have the correct test listed?
> 
> Yep, I just retested and it's definitely generic/039.  I'm using a simple
> test environment, with virtme-ng.
> 
>> Looking at the code in question in fs/ext4/extents.c:
>>
>> again:
>> 	ext4_es_find_extent_range(inode, &ext4_es_is_delayed, hole_start,
>> 				  hole_start + len - 1, &es);
>> 	if (!es.es_len)
>> 		goto insert_hole;
>>
>>   	 * There's a delalloc extent in the hole, handle it if the delalloc
>>   	 * extent is in front of, behind and straddle the queried range.
>>   	 */
>>  -	if (lblk >= es.es_lblk + es.es_len) {
>>  +	if (lblk >= ((__u64) es.es_lblk) + es.es_len) {
>>   		/*
>>   		 * The delalloc extent is in front of the queried range,
>>   		 * find again from the queried start block.
>> 		len -= lblk - hole_start;
>> 		hole_start = lblk;
>> 		goto again;
>>
>> lblk and es.es_lblk are both __u32.  So the infinite loop is
>> presumably because es.es_lblk + es.es_len has overflowed.  This should
>> never happen(tm), and in fact we have a test for this case which
> 
> If I instrument the code, I can see that es.es_len is definitely set to
> EXT_MAX_BLOCKS, which will overflow.
> 

Thanks for the report. After looking at the code, I think the root
cause of this issue is the variable es was not initialized on replaying
fast commit. ext4_es_find_extent_range() will return directly when
EXT4_FC_REPLAY flag is set, and then the es.len becomes stall.

I can always reproduce this issue on generic/039 with
MKFS_OPTIONS="-O fast_commit".

This uninitialization problem originally existed in the old
ext4_ext_put_gap_in_cache(), but it didn't trigger any real problem
since we never check and use extent cache when replaying fast commit.
So I suppose the correct fix would be to unconditionally initialize
the es variable.

Thanks,
Yi.

>> *should* have gotten tripped when ext4_es_find_extent_range() calls
>> __es_tree_search() in fs/ext4/extents_status.c:
>>
>> static inline ext4_lblk_t ext4_es_end(struct extent_status *es)
>> {
>> 	BUG_ON(es->es_lblk + es->es_len < es->es_lblk);
>> 	return es->es_lblk + es->es_len - 1;
>> }
>>
>> So the patch is harmless, and I can see how it might fix what you were
>> seeing --- but I'm a bit nervous that I can't reproduce it and the
>> commit description claims that it reproduces easily; and we should
>> have never allowed the entry to have gotten introduced into the
>> extents status tree in the first place, and if it had been introduced,
>> it should have been caught before it was returned by
>> ext4_es_find_extent_range().
>>
>> Can you give more details about the reproducer; can you double check
>> the test id, and how easily you can trigger the failure, and what is
>> the hardware you used to run the test?
> 
> So, here's few more details that may clarify, and that I should have added
> to the commit description:
> 
> When the test hangs, the test is blocked mounting the flakey device:
> 
>    mount -t ext4 -o acl,user_xattr /dev/mapper/flakey-test /mnt/scratch
> 
> which will eventually call into ext4_ext_map_blocks(), triggering the bug.
> 
> Also, some more code instrumentation shows that after the call to
> ext4_ext_find_hole(), the 'hole_start' will be set to '1' and 'len' to
> '0xfffffffe'.  This '0xfffffffe' value is a bit odd, but it comes from the
> fact that, in ext4_ext_find_hole(), the call to
> ext4_ext_next_allocated_block() will return EXT_MAX_BLOCKS and 'len' will
> thus be set to 'EXT_MAX_BLOCKS - 1'.
> 
> Does this make sense?
> 
> Cheers,
> 


