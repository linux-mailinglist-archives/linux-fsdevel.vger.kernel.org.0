Return-Path: <linux-fsdevel+bounces-18091-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 991F48B56A3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 13:31:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5A161C23623
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 11:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF7E051C2C;
	Mon, 29 Apr 2024 11:29:04 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8367537EC;
	Mon, 29 Apr 2024 11:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714390144; cv=none; b=NjN4Qxm+0s5XajKPyEjJnK1rL1VaDfDGrPdFSDUbtMvmSGPmIkl6tLBV1AlwoX/V8H2sRa/OksZlI/Mtx+SFXtDyPi6B6QLH+BAJ1f1CH92PKymsQYFVem1crCImH3psByDiJTnVrQc1uEGBPwP6KQjFkdprcaFXYWc30B4hQjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714390144; c=relaxed/simple;
	bh=Q4YhIWurI1eqly+A5hDZxZhbfpMnuu6xWDxs0fo7FOI=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=N8zBLJNoFeeZYVQlyIDbsR+GvA64mjfyKhE21QSCHVWQC53I112E+Zhoz5Z4XArecn87IWn/o1CMNpO2aVvhOLRhzXhexgBPN0gzwB2bTLrxfj3QbGP/cXw6oIFVUBB3BiPS6MfzS1dxKTxwrGkOxsglyWTH9XDv42/MksFBtDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VSh110pF6z4f3k5r;
	Mon, 29 Apr 2024 19:28:53 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 23F2E1A0175;
	Mon, 29 Apr 2024 19:28:58 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP2 (Coremail) with SMTP id Syh0CgBHaw54hC9mo0AoLg--.8933S3;
	Mon, 29 Apr 2024 19:28:57 +0800 (CST)
Subject: Re: [PATCH v2 3/9] ext4: trim delalloc extent
To: Jan Kara <jack@suse.cz>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, tytso@mit.edu,
 adilger.kernel@dilger.ca, yi.zhang@huawei.com, chengzhihao1@huawei.com,
 yukuai3@huawei.com
References: <20240410034203.2188357-1-yi.zhang@huaweicloud.com>
 <20240410034203.2188357-4-yi.zhang@huaweicloud.com>
 <20240425155640.ktvqqwhteitysaby@quack3>
 <acd4e7c9-c68b-9edc-bba4-dce5e8ce7879@huaweicloud.com>
 <20240429102550.sx4vdl75whxovmc2@quack3>
From: Zhang Yi <yi.zhang@huaweicloud.com>
Message-ID: <9d4d958b-7b70-c8f5-e091-174a99f506b6@huaweicloud.com>
Date: Mon, 29 Apr 2024 19:28:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240429102550.sx4vdl75whxovmc2@quack3>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgBHaw54hC9mo0AoLg--.8933S3
X-Coremail-Antispam: 1UD129KBjvJXoWxZF18JFyfAr13GF4DXFW5Jrb_yoW5Ary3p3
	s2kF15Ga1xK3WI9FZ2vF1UX3WFkw18JF4jqws8WryUZFyqgFyfGFyDJa1j9FykXr4fGF4Y
	vFWUtF97u3ZFvaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyEb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0E
	wIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E74
	80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0
	I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04
	k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY
	1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1zuWJUUUUU==
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 2024/4/29 18:25, Jan Kara wrote:
> On Fri 26-04-24 17:38:23, Zhang Yi wrote:
>> On 2024/4/25 23:56, Jan Kara wrote:
>>> On Wed 10-04-24 11:41:57, Zhang Yi wrote:
>>>> From: Zhang Yi <yi.zhang@huawei.com>
>>>>
>>>> The cached delalloc or hole extent should be trimed to the map->map_len
>>>> if we map delalloc blocks in ext4_da_map_blocks(). But it doesn't
>>>> trigger any issue now because the map->m_len is always set to one and we
>>>> always insert one delayed block once a time. Fix this by trim the extent
>>>> once we get one from the cached extent tree, prearing for mapping a
>>>> extent with multiple delalloc blocks.
>>>>
>>>> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
>>>
>>> Well, but we already do the trimming in ext4_da_map_blocks(), don't we? You
>>> just move it to a different place... Or do you mean that we actually didn't
>>> set 'map' at all in some cases and now we do? 
>>
>> Yeah, now we only trim map len if we found an unwritten extent or written
>> extent in the cache, this isn't okay if we found a hole and
>> ext4_insert_delayed_block() and ext4_da_map_blocks() support inserting
>> map->len blocks. If we found a hole which es->es_len is shorter than the
>> length we want to write, we could delay more blocks than we expected.
>>
>> Please assume we write data [A, C) to a file that contains a hole extent
>> [A, B) and a written extent [B, D) in cache.
>>
>>                       A     B  C  D
>> before da write:   ...hhhhhh|wwwwww....
>>
>> Then we will get extent [A, B), we should trim map->m_len to B-A before
>> inserting new delalloc blocks, if not, the range [B, C) is duplicated.
> 
> Thanks for explanation!
> 

Current change log is not clear enough now, I will put this explanation
into the changelog in my nextn iteratio, make it easier to understand.

>>> In either case the 'map'
>>> handling looks a bit sloppy in ext4_da_map_blocks() as e.g. the
>>> 'add_delayed' case doesn't seem to bother with properly setting 'map' based
>>> on what it does. So maybe we should clean that up to always set 'map' just
>>> before returning at the same place where we update the 'bh'? And maybe bh
>>> update could be updated in some common helper because it's content is
>>> determined by the 'map' content?
>>>
>>
>> I agree with you, it looks that we should always revise the map->m_len
>> once we found an extent from the cache, and then do corresponding handling
>> according to the extent type. so it's hard to put it to a common place.
>> But we can merge the handling of written and unwritten extent, I've moved
>> the bh updating into ext4_da_get_block_prep() and do some cleanup in
>> patch 9, please look at that patch, does it looks fine to you?
> 
> Oh, yes, what patch 9 does improve things significantly and it addresses my
> concern. So feel free to add:
> 
> Reviewed-by: Jan Kara <jack@suse.cz>
> 
> Maybe in the changelog you can just mention that the remaining cases not
> setting map->m_len will be handled in patch 9.
> 

Sure.

Thanks,
Yi.


