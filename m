Return-Path: <linux-fsdevel+bounces-37119-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6877E9EDDAE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2024 03:32:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65F44167E2D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2024 02:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D608213D8A0;
	Thu, 12 Dec 2024 02:32:16 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A50118643;
	Thu, 12 Dec 2024 02:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733970736; cv=none; b=u9Psjav3wJZg5zbkIDw5koqb27lvnaenG0NM0AaxxvWxnQZS2mimDYxOyBqd0hxr/6i3isyE46qBAqpaBPRuiuDXlKDxZ5x27x5L24mWlvd0ukJcodEAKg/Md6uZUJQKkXWioJkq629KpWbrGN2UMMh5AuENzl2FyRcCiloZ7fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733970736; c=relaxed/simple;
	bh=rKZ/KG4T+fTKfGekYUiXkO22lNRzWENVTAxOndLl3F0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oQDXQX4Is5iUnFGUyK0UKvS3LwJj/TLKtb15HIwkNKcl5AM1w29yBG9jvH3DWZ6ebSROK1BBlWN73UykYWQWrmrSizfamPEspYyTGeBYdT73IB4OyrSjDHRJGjf56qsOPGWR2NhV81ZguX/sI7qiWeToR1NjzW2j191XtUz+Ugs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Y7xLR1Q6lz4f3kvh;
	Thu, 12 Dec 2024 10:31:43 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 7A1E81A0568;
	Thu, 12 Dec 2024 10:32:03 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP4 (Coremail) with SMTP id gCh0CgCXvoIhS1pnt2NnEQ--.26851S3;
	Thu, 12 Dec 2024 10:32:03 +0800 (CST)
Message-ID: <dc719f19-9839-4fa7-b9f8-5dfcdde92c45@huaweicloud.com>
Date: Thu, 12 Dec 2024 10:32:01 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/27] ext4: introduce seq counter for the extent status
 entry
To: Jan Kara <jack@suse.cz>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
 ritesh.list@gmail.com, hch@infradead.org, djwong@kernel.org,
 david@fromorbit.com, zokeefe@google.com, yi.zhang@huawei.com,
 chengzhihao1@huawei.com, yukuai3@huawei.com, yangerkun@huawei.com
References: <20241022111059.2566137-1-yi.zhang@huaweicloud.com>
 <20241022111059.2566137-13-yi.zhang@huaweicloud.com>
 <20241204124221.aix7qxjl2n4ya3b7@quack3>
 <c831732e-38c5-4a82-ab30-de17cff29584@huaweicloud.com>
 <20241206162102.w4hw35ims5sdf4ik@quack3>
 <5049c794-9a92-462c-a455-2bdf94cdebef@huaweicloud.com>
 <20241210125726.gzcx6mpuecifqdwe@quack3>
 <95c631d7-84da-412b-b7dc-f4785739f41a@huaweicloud.com>
 <20241211160047.qnxvodmbzngo3jtr@quack3>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <20241211160047.qnxvodmbzngo3jtr@quack3>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgCXvoIhS1pnt2NnEQ--.26851S3
X-Coremail-Antispam: 1UD129KBjvJXoWxCw17ZF48WF45GrykZw1kZrb_yoW5Kw17pF
	W3CF4akan5t348Xr9rtwn7XF15Gw4UJF47JFy3GF17AF1DWFySqFWjya1jkFy8WFsaqF42
	vFWjq34kA398AaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkEb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2
	j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7x
	kEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AK
	xVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
	0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFyl
	IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxV
	AFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j
	6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UAwI
	DUUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 2024/12/12 0:00, Jan Kara wrote:
> On Wed 11-12-24 15:59:51, Zhang Yi wrote:
>> On 2024/12/10 20:57, Jan Kara wrote:
>>> On Mon 09-12-24 16:32:41, Zhang Yi wrote:
>>> b) evict all page cache in the affected range -> should stop writeback -
>>>    *but* currently there's one case which could be problematic. Assume we
>>>    do punch hole 0..N and the page at N+1 is dirty. Punch hole does all of
>>>    the above and starts removing blocks, needs to restart transaction so it
>>>    drops i_data_sem. Writeback starts for page N+1, needs to load extent
>>>    block into memory, ext4_cache_extents() now loads back some extents
>>>    covering range 0..N into extent status tree. 
>>
>> This completely confuses me. Do you mention the case below,
>>
>> There are many extent entries in the page range 0..N+1, for example,
>>
>>    0                                  N N+1
>>    |                                  |/
>>   [www][wwwwww][wwwwwwww]...[wwwww][wwww]...
>>                 |      |
>>                 N-a    N-b
>>
>> Punch hole is removing each extent entries from N..0
>> (ext4_ext_remove_space() removes blocks from end to start), and could
>> drop i_data_sem just after manipulating(removing) the extent entry
>> [N-a,N-b], At the same time, a concurrent writeback start write back
>> page N+1 since the writeback only hold page lock, doesn't hold i_rwsem
>> and invalidate_lock. It may load back the extents 0..N-a into the
>> extent status tree again while finding extent that contains N+1?
> 
> Yes, because when we load extents from extent tree, we insert all extents
> from the leaf of the extent tree into extent status tree. That's what
> ext4_cache_extents() call does.
> 
>> Finally it may left some stale extent status entries after punch hole
>> is done?
> 
> Yes, there may be stale extents in the extent status tree when
> ext4_ext_remove_space() returns. But punch hole in particular then does:
> 
> ext4_es_insert_extent(inode, first_block, hole_len, ~0,
>                                       EXTENT_STATUS_HOLE, 0);
> 
> which overwrites these stale extents with appropriate information.
> 

Yes, that's correct! I missed this insert yesterday. It looks fine now,
as it holds the i_rwsem and invalidate_lock, and has evicted the page
cache in this case. Thanks a lot for your detail explanation. I will
add these document in my next iteration.

Thanks!
Yi.

>> If my understanding is correct, isn't that a problem that exists now?
>> I mean without this patch series.
> 
> Yes, the situation isn't really related to your patches. But with your
> patches we are starting to rely even more on extent status tree vs extent
> tree consistecy. So I wanted to spell out this situation to verify new
> problem isn't introduced and so that we create rules that handle this
> situation well.
> 
>>>    So the only protection
>>>    against using freed blocks is that nobody should be mapping anything in
>>>    the range 0..N because we hold those locks & have evicted page cache.
>>>
>>> So I think we need to also document, that anybody mapping blocks needs to
>>> hold i_rwsem or invalidate_lock or a page lock, ideally asserting that in
>>> ext4_map_blocks() to catch cases we missed. Asserting for page lock will
>>> not be really doable but luckily only page writeback needs that so that can
>>> get some extemption from the assert.
>>
>> In the case above, it seems that merely holding a page lock is
>> insufficient?
> 
> Well, holding page lock(s) for the range you are operating on is enough to
> make sure there cannot be parallel operations on that range like truncate,
> punch hole or similar, because they always remove the page cache before
> starting their work and because they hold invalidate_lock, new pages cannot
> be created while they are working.
> 
> 								Honza


