Return-Path: <linux-fsdevel+bounces-36615-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C3989E6961
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Dec 2024 09:55:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B4F1167A07
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Dec 2024 08:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FA0E1E0E00;
	Fri,  6 Dec 2024 08:55:12 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 251051D9A48;
	Fri,  6 Dec 2024 08:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733475312; cv=none; b=HTHXQFkkIUayAulQI/01zelu1QwxXDDXKcXK7zES0FAo9YQhlD1HGO9Ev9EncPz6y7dFeITLi61qH9hK+zpqTn9qAI7dgxR45jJpDt074JrXM08DPlxmAA9EN2sKFg2nJ+FuOPccjuyHqy5IODG/S4i9uT5F3Rd7yp6btjsfk6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733475312; c=relaxed/simple;
	bh=6amPin9F3atmc7mQBPJ6QiqmXojPFyeez5KUoWEI5FM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C5/0Lkwzk57PZ+PvIjCCNsL2JmzK7kZw1R+By0ZKaMqLw/NPyhlgazkXh0dMUMMLJ/uWGNLfDoBcItVjKmd5aCqOwBz0WbYWpz8jYAxmB+haoBiwXBoOr0RPfEyAH7PORw4GHtYmkaVo4WCEnuqrqg6BH4n1jiTm/SWxKkL+kfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Y4Q772vSsz4f3lVL;
	Fri,  6 Dec 2024 16:54:43 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 7611F1A07B6;
	Fri,  6 Dec 2024 16:55:03 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP4 (Coremail) with SMTP id gCh0CgCnzoLlu1Jn6clADw--.11146S3;
	Fri, 06 Dec 2024 16:55:03 +0800 (CST)
Message-ID: <c831732e-38c5-4a82-ab30-de17cff29584@huaweicloud.com>
Date: Fri, 6 Dec 2024 16:55:01 +0800
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
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <20241204124221.aix7qxjl2n4ya3b7@quack3>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgCnzoLlu1Jn6clADw--.11146S3
X-Coremail-Antispam: 1UD129KBjvJXoWxWFy7ZryrWF1kXw4rCr18AFb_yoWrGFyfpF
	ZIk3Z8tFs8J3WFkryIva17Zr1rGa48GrW7GF9Igw4vka98WFyfKF1UKFWjvF18WrWvqw1j
	vF4Fk347C3Wjva7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
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

On 2024/12/4 20:42, Jan Kara wrote:
> On Tue 22-10-24 19:10:43, Zhang Yi wrote:
>> From: Zhang Yi <yi.zhang@huawei.com>
>>
>> In the iomap_write_iter(), the iomap buffered write frame does not hold
>> any locks between querying the inode extent mapping info and performing
>> page cache writes. As a result, the extent mapping can be changed due to
>> concurrent I/O in flight. Similarly, in the iomap_writepage_map(), the
>> write-back process faces a similar problem: concurrent changes can
>> invalidate the extent mapping before the I/O is submitted.
>>
>> Therefore, both of these processes must recheck the mapping info after
>> acquiring the folio lock. To address this, similar to XFS, we propose
>> introducing an extent sequence number to serve as a validity cookie for
>> the extent. We will increment this number whenever the extent status
>> tree changes, thereby preparing for the buffered write iomap conversion.
>> Besides, it also changes the trace code style to make checkpatch.pl
>> happy.
>>
>> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> 
> Overall using some sequence counter makes sense.
> 
>> diff --git a/fs/ext4/extents_status.c b/fs/ext4/extents_status.c
>> index c786691dabd3..bea4f87db502 100644
>> --- a/fs/ext4/extents_status.c
>> +++ b/fs/ext4/extents_status.c
>> @@ -204,6 +204,13 @@ static inline ext4_lblk_t ext4_es_end(struct extent_status *es)
>>  	return es->es_lblk + es->es_len - 1;
>>  }
>>  
>> +static inline void ext4_es_inc_seq(struct inode *inode)
>> +{
>> +	struct ext4_inode_info *ei = EXT4_I(inode);
>> +
>> +	WRITE_ONCE(ei->i_es_seq, READ_ONCE(ei->i_es_seq) + 1);
>> +}
> 
> This looks potentially dangerous because we can loose i_es_seq updates this
> way. Like
> 
> CPU1					CPU2
> x = READ_ONCE(ei->i_es_seq)
> 					x = READ_ONCE(ei->i_es_seq)
> 					WRITE_ONCE(ei->i_es_seq, x + 1)
> 					...
> 					potentially many times
> WRITE_ONCE(ei->i_es_seq, x + 1)
>   -> the counter goes back leading to possibly false equality checks
> 

In my current implementation, I don't think this race condition can
happen since all ext4_es_inc_seq() invocations are under
EXT4_I(inode)->i_es_lock. So I think it works fine now, or was I
missed something?

> I think you'll need to use atomic_t and appropriate functions here.
> 
>> @@ -872,6 +879,7 @@ void ext4_es_insert_extent(struct inode *inode, ext4_lblk_t lblk,
>>  	BUG_ON(end < lblk);
>>  	WARN_ON_ONCE(status & EXTENT_STATUS_DELAYED);
>>  
>> +	ext4_es_inc_seq(inode);
> 
> I'm somewhat wondering: Are extent status tree modifications the right
> place to advance the sequence counter? The counter needs to advance
> whenever the mapping information changes. This means that we'd be
> needlessly advancing the counter (and thus possibly forcing retries) when
> we are just adding new information from ordinary extent tree into cache.
> Also someone can be doing extent tree manipulations without touching extent
> status tree (if the information was already pruned from there). 

Sorry, I don't quite understand here. IIUC, we can't modify the extent
tree without also touching extent status tree; otherwise, the extent
status tree will become stale, potentially leading to undesirable and
unexpected outcomes later on, as the extent lookup paths rely on and
always trust the status tree. If this situation happens, would it be
considered a bug? Additionally, I have checked the code but didn't find
any concrete cases where this could happen. Was I overlooked something?

> So I think
> needs some very good documentation what are the expectations from the
> sequence counter and explanations why they are satisfied so that we don't
> break this in the future.
> 

Yeah, it's a good suggestion, where do you suggest putting this
documentation, how about in the front of extents_status.c?

Thanks,
Yi.


