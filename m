Return-Path: <linux-fsdevel+bounces-18837-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 62FB88BCF95
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 May 2024 16:02:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 193E61F2294C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 May 2024 14:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D362A8174C;
	Mon,  6 May 2024 14:02:27 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFB25811F7;
	Mon,  6 May 2024 14:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715004147; cv=none; b=JeOSdDIM6flGsGZNLiL8s3ADaeAH+3gbSFeqlLqzdo0JTpsrTGVCKOIcEaPgZFt1crlJgy6TtLAgEMLX5D72iUAY+3umTP+nqIM1xtfk6XnPIlC4IUEqhx6p07HI3iqk1U54zkbP7qFrZ+nj3dIu5q+wh9xU/KZMhlKgG+ewuew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715004147; c=relaxed/simple;
	bh=a/rC19e2I9iHG3TMQmCrv2WuR6H592ekcahsLjx1u+I=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=PPY8rWEN+ZwCu3LKT4Ajbsf3yAgJmBDMXqd0mqtit3fZMTSj5p8e2hDGt/iC9VX00vUcZ8EPHbPJE8LEJdulwLSPoXAc9tw2YLfBSfhipVfupz9iKYw0TQot5dbvvNCZbiCd3Iq9ZHH/KRkQQbEvMy1yF86PXK4/DUObVKtZSCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VY34g13G2z4f3lfy;
	Mon,  6 May 2024 22:02:11 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id E08041A0179;
	Mon,  6 May 2024 22:02:20 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP2 (Coremail) with SMTP id Syh0CgDnCg7q4jhmTvnUMA--.48428S3;
	Mon, 06 May 2024 22:02:20 +0800 (CST)
Subject: Re: [RFC PATCH v4 33/34] ext4: don't mark IOMAP_F_DIRTY for buffer
 write
To: Dave Chinner <david@fromorbit.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, tytso@mit.edu,
 adilger.kernel@dilger.ca, jack@suse.cz, ritesh.list@gmail.com,
 hch@infradead.org, djwong@kernel.org, willy@infradead.org,
 zokeefe@google.com, yi.zhang@huawei.com, chengzhihao1@huawei.com,
 yukuai3@huawei.com, wangkefeng.wang@huawei.com
References: <20240410142948.2817554-1-yi.zhang@huaweicloud.com>
 <20240410150313.2820364-5-yi.zhang@huaweicloud.com>
 <ZjILCPNZRHeazSqV@dread.disaster.area>
From: Zhang Yi <yi.zhang@huaweicloud.com>
Message-ID: <349d0d44-2ffc-6177-cf00-db7a3f48b60d@huaweicloud.com>
Date: Mon, 6 May 2024 22:02:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZjILCPNZRHeazSqV@dread.disaster.area>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgDnCg7q4jhmTvnUMA--.48428S3
X-Coremail-Antispam: 1UD129KBjvJXoWxur1DAF1DKw4rZr1kAF47Jwb_yoW5ArWDpr
	Z7Ka1rX3WkXry7ur4IqF47ZrZ7tayUKr4DGrW8tw12y398Gw1xtF1FgFyrAF98Gr1fWw42
	q3Wjqr97Ww17AaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvab4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS
	07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
	02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_
	WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
	CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWrZr1UMIIF0xvEx4A2jsIE
	14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyT
	uYvjxUFDGOUUUUU
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 2024/5/1 17:27, Dave Chinner wrote:
> On Wed, Apr 10, 2024 at 11:03:12PM +0800, Zhang Yi wrote:
>> From: Zhang Yi <yi.zhang@huawei.com>
>>
>> The data sync dirty check in ext4_inode_datasync_dirty() is expansive
>> since jbd2_transaction_committed() holds journal->j_state lock when
>> journal is enabled, it costs a lot in high-concurrency iomap buffered
>> read/write paths, but we never check IOMAP_F_DIRTY in these cases, so
>> let's check it only in swap file, dax and direct IO cases. Tested by
>> Unixbench on 100GB ramdisk:
>>
>> ./Run -c 128 -i 10 fstime fsbuffer fsdisk
>>
>>   == without this patch ==
>>   128 CPUs in system; running 128 parallel copies of tests
>>
>>   File Copy 1024 bufsize 2000 maxblocks       6332521.0 KBps
>>   File Copy 256 bufsize 500 maxblocks         1639726.0 KBps
>>   File Copy 4096 bufsize 8000 maxblocks      24018572.0 KBps
>>
>>   == with this patch ==
>>   128 CPUs in system; running 128 parallel copies of tests
>>
>>   File Copy 1024 bufsize 2000 maxblocks      49229257.0 KBps
>>   File Copy 256 bufsize 500 maxblocks        24057510.0 KBps
>>   File Copy 4096 bufsize 8000 maxblocks      75704437.0 KBps
>>
>> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
>> ---
>>  fs/ext4/inode.c | 10 +++++++---
>>  1 file changed, 7 insertions(+), 3 deletions(-)
>>
>> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
>> index 1cb219d347af..269503749ef5 100644
>> --- a/fs/ext4/inode.c
>> +++ b/fs/ext4/inode.c
>> @@ -3281,9 +3281,13 @@ static void ext4_set_iomap(struct inode *inode, struct iomap *iomap,
>>  	 * there is no other metadata changes being made or are pending.
>>  	 */
>>  	iomap->flags = 0;
>> -	if (ext4_inode_datasync_dirty(inode) ||
>> -	    offset + length > i_size_read(inode))
>> -		iomap->flags |= IOMAP_F_DIRTY;
>> +	if ((flags & (IOMAP_DAX | IOMAP_REPORT)) ||
>> +	    ((flags & (IOMAP_WRITE | IOMAP_DIRECT)) ==
>> +	     (IOMAP_WRITE | IOMAP_DIRECT))) {
>> +		if (offset + length > i_size_read(inode) ||
>> +		    ext4_inode_datasync_dirty(inode))
>> +			iomap->flags |= IOMAP_F_DIRTY;
>> +	}
> 
> NACK. This just adds a nasty landmine that anyone working on the
> iomap infrastructure can step on. i.e. any time we add a new check
> for IOMAP_F_DIRTY in the generic infrastructure, ext4 is going to
> break because it won't set the IOMAP_F_DIRTY flag correctly.
> 
> If checking an inode is dirty is expensive on ext4, then make it
> less expensive and everyone will benefit.
> 
> /me goes and looks at jbd2_transaction_committed()
> 
> Oh, it it's just a sequence number comparison, and it needs a lock
> because it has to dereference the running/committed transactions
> structures to get the current sequence numbers. Why not just store
> the commiting/running transaction tids in the journal_t, and then
> you can sample them without needing any locking and the whole
> ext4_inode_datasync_dirty() scalability problem goes away...
> 

Indeed, it could be useful, and it seems could also simplify many
other jbd2 processes.

Thanks,
Yi.


