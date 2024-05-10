Return-Path: <linux-fsdevel+bounces-19262-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCDB38C23C2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 May 2024 13:41:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F10421C22C5A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 May 2024 11:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D465C16EC0B;
	Fri, 10 May 2024 11:41:07 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B168112AAC0;
	Fri, 10 May 2024 11:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715341267; cv=none; b=KBZWk+zfxKELB0qHR+YwdDfRRCLtLlen7jHONsddEtUOZz6RBpqfTwjUw5vKW1/ZFxcLDiLqP9FIUuUyR1l2+yLO2ywod/a8EY4s6ESIIo28C8JOTjt3odUzSsKvOScjPxTMSQnXdXVat9OT3qpxfEKN4xw6ttfMx9H4pAhghQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715341267; c=relaxed/simple;
	bh=hlouBtpydRVYfVMmQQ0wu/ck0rpVStqkPJRM3qUCENs=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=ace6pmEF6BCEz2XKdUJg5TmtrbF/vAleCPSNRrjLClFX8KhNjibyoBVQO20v3AO4ccsDuTDMSLbqmaJ58gwcjLDQgdtQ5NPFEsaVgHETRNrES++4AQfQCYiKL1FP1wp3HYvhwYiwteRMUQN1f6AzIQxwfVi6YME8V9cpJnfaIPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VbRlj2WyPz4f3m8q;
	Fri, 10 May 2024 19:40:49 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id B63811A0568;
	Fri, 10 May 2024 19:40:54 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP2 (Coremail) with SMTP id Syh0CgAXOQzEBz5mwBtJMg--.30386S3;
	Fri, 10 May 2024 19:40:54 +0800 (CST)
Subject: Re: [PATCH v3 03/26] ext4: correct the hole length returned by
 ext4_map_blocks()
To: Luis Henriques <luis.henriques@linux.dev>
Cc: Theodore Ts'o <tytso@mit.edu>, linux-ext4@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, adilger.kernel@dilger.ca, jack@suse.cz,
 ritesh.list@gmail.com, hch@infradead.org, djwong@kernel.org,
 willy@infradead.org, zokeefe@google.com, yi.zhang@huawei.com,
 chengzhihao1@huawei.com, yukuai3@huawei.com, wangkefeng.wang@huawei.com
References: <20240127015825.1608160-1-yi.zhang@huaweicloud.com>
 <20240127015825.1608160-4-yi.zhang@huaweicloud.com>
 <87zfszuib1.fsf@brahms.olymp> <20240509163953.GI3620298@mit.edu>
 <87h6f6vqzj.fsf@brahms.olymp>
 <b9b93ad2-2253-6850-da38-afc42370303e@huaweicloud.com>
 <87seyquhpi.fsf@brahms.olymp>
From: Zhang Yi <yi.zhang@huaweicloud.com>
Message-ID: <ea7d4019-fec7-d30c-e62a-37e665ccd610@huaweicloud.com>
Date: Fri, 10 May 2024 19:40:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <87seyquhpi.fsf@brahms.olymp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgAXOQzEBz5mwBtJMg--.30386S3
X-Coremail-Antispam: 1UD129KBjvJXoWxWFyUZry8uF13Cw4fZF4xJFb_yoW5tFW8pF
	WfZFnrtr4kJ348CrZ2yw1rXF10vr45Gr15Xr4rJryfAas09rykWF42kFWY9F97Wr40gw1U
	tF4jva9rWFyjvFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS
	07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
	02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_
	WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
	CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAF
	wI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa
	7IU13rcDUUUUU==
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 2024/5/10 17:41, Luis Henriques wrote:
> On Fri 10 May 2024 11:39:48 AM +08, Zhang Yi wrote;
> 
>> On 2024/5/10 1:23, Luis Henriques wrote:
>>> On Thu 09 May 2024 12:39:53 PM -04, Theodore Ts'o wrote;
>>>
>>>> On Thu, May 09, 2024 at 04:16:34PM +0100, Luis Henriques wrote:
>>>>>
>>>>> It's looks like it's easy to trigger an infinite loop here using fstest
>>>>> generic/039.  If I understand it correctly (which doesn't happen as often
>>>>> as I'd like), this is due to an integer overflow in the 'if' condition,
>>>>> and should be fixed with the patch below.
>>>>
>>>> Thanks for the report.  However, I can't reproduce the failure, and
>>>> looking at generic/039, I don't see how it could be relevant to the
>>>> code path in question.  Generic/039 creates a test symlink with two
>>>> hard links in the same directory, syncs the file system, and then
>>>> removes one of the hard links, and then drops access to the block
>>>> device using dmflakey.  So I don't see how the extent code would be
>>>> involved at all.  Are you sure that you have the correct test listed?
>>>
>>> Yep, I just retested and it's definitely generic/039.  I'm using a simple
>>> test environment, with virtme-ng.
>>>
>>>> Looking at the code in question in fs/ext4/extents.c:
>>>>
>>>> again:
>>>> 	ext4_es_find_extent_range(inode, &ext4_es_is_delayed, hole_start,
>>>> 				  hole_start + len - 1, &es);
>>>> 	if (!es.es_len)
>>>> 		goto insert_hole;
>>>>
>>>>   	 * There's a delalloc extent in the hole, handle it if the delalloc
>>>>   	 * extent is in front of, behind and straddle the queried range.
>>>>   	 */
>>>>  -	if (lblk >= es.es_lblk + es.es_len) {
>>>>  +	if (lblk >= ((__u64) es.es_lblk) + es.es_len) {
>>>>   		/*
>>>>   		 * The delalloc extent is in front of the queried range,
>>>>   		 * find again from the queried start block.
>>>> 		len -= lblk - hole_start;
>>>> 		hole_start = lblk;
>>>> 		goto again;
>>>>
>>>> lblk and es.es_lblk are both __u32.  So the infinite loop is
>>>> presumably because es.es_lblk + es.es_len has overflowed.  This should
>>>> never happen(tm), and in fact we have a test for this case which
>>>
>>> If I instrument the code, I can see that es.es_len is definitely set to
>>> EXT_MAX_BLOCKS, which will overflow.
>>>
>>
>> Thanks for the report. After looking at the code, I think the root
>> cause of this issue is the variable es was not initialized on replaying
>> fast commit. ext4_es_find_extent_range() will return directly when
>> EXT4_FC_REPLAY flag is set, and then the es.len becomes stall.
>>
>> I can always reproduce this issue on generic/039 with
>> MKFS_OPTIONS="-O fast_commit".
>>
>> This uninitialization problem originally existed in the old
>> ext4_ext_put_gap_in_cache(), but it didn't trigger any real problem
>> since we never check and use extent cache when replaying fast commit.
>> So I suppose the correct fix would be to unconditionally initialize
>> the es variable.
> 
> Oh, you're absolutely right -- the extent_status 'es' struct isn't being
> initialized in that case.  I totally failed to see that.  And yes, I also
> failed to mention I had 'fast_commit' feature enabled, sorry!
> 
> Thanks a lot for figuring this out, Yi.  I'm looking at this code and
> trying to understand if it would be safe to call __es_find_extent_range()
> when EXT4_FC_REPLAY is in progress.  Probably not, and probably better to
> simply do:
> 
> 	es->es_lblk = es->es_len = es->es_pblk = 0;
> 
> in that case.  I'll send out a patch later today.
> 

Yeah, I'm glad it could help.

Thanks,
Yi.


