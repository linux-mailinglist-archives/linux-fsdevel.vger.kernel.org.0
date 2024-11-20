Return-Path: <linux-fsdevel+bounces-35255-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 313599D324E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2024 03:57:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9B851F23B70
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2024 02:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 825DD6026A;
	Wed, 20 Nov 2024 02:57:08 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4866520B22;
	Wed, 20 Nov 2024 02:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732071428; cv=none; b=a66cbsNx9cmcDc2nskxXCkkfrVXpdQ0ZRLtN/8zZQW3nY5AUvE8Lt+3EESPR6wSiTYIhdaMYg4FaPaytXTPKIL50DbPMpdzT9G6EQZqpa3+YqbtyWJFsud1ttusQGGlcxzVnjJX8+HZdKBZGqoJ7cVvBQyM1G8oadEnnGJSKyoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732071428; c=relaxed/simple;
	bh=/+bqiin+NU850O+KzQiUKl814nrZU3HnvH7ew7mfLDY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SPrDE7/1li+It+HxOAWjPYI1Phi1mKR+Rlrv1Sw9CmllFoTyrzr1iLMPELtbByxW6+zPBbI2Qnm/3uTRYepzftk5V0w/pIu0UmpuFytoLvfcWdnzHF4uSlvG1N9Laxs2yFL3koP5mBG6DV+/iQ52Spgbe2o68zisU3AeethwP9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4XtQxK03hRz4f3kFj;
	Wed, 20 Nov 2024 10:56:37 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 7F0271A07B6;
	Wed, 20 Nov 2024 10:56:55 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP4 (Coremail) with SMTP id gCh0CgBHIob1Tz1nvscpCQ--.55033S3;
	Wed, 20 Nov 2024 10:56:55 +0800 (CST)
Message-ID: <56e451a7-e6ae-468a-81d8-f2513245f87f@huaweicloud.com>
Date: Wed, 20 Nov 2024 10:56:53 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/27] ext4: don't write back data before punch hole in
 nojournal mode
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
 jack@suse.cz, ritesh.list@gmail.com, hch@infradead.org, david@fromorbit.com,
 zokeefe@google.com, yi.zhang@huawei.com, chengzhihao1@huawei.com,
 yukuai3@huawei.com, yangerkun@huawei.com
References: <20241022111059.2566137-1-yi.zhang@huaweicloud.com>
 <20241022111059.2566137-4-yi.zhang@huaweicloud.com>
 <20241118231521.GA9417@frogsfrogsfrogs>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <20241118231521.GA9417@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgBHIob1Tz1nvscpCQ--.55033S3
X-Coremail-Antispam: 1UD129KBjvJXoWxCr4xCr4DtFyxZF4xur4rXwb_yoWrGw15pr
	9akry5tr40gayqkr1ftFsFqryFg34vkrW8GryfG3s7Za90ywn2kF4DKw10ka4Ut398Gw40
	qF48JasrWFyqvFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

On 2024/11/19 7:15, Darrick J. Wong wrote:
> On Tue, Oct 22, 2024 at 07:10:34PM +0800, Zhang Yi wrote:
>> From: Zhang Yi <yi.zhang@huawei.com>
>>
>> There is no need to write back all data before punching a hole in
>> data=ordered|writeback mode since it will be dropped soon after removing
>> space, so just remove the filemap_write_and_wait_range() in these modes.
>> However, in data=journal mode, we need to write dirty pages out before
>> discarding page cache in case of crash before committing the freeing
>> data transaction, which could expose old, stale data.
> 
> Can't the same thing happen with non-journaled data writes?
> 
> Say you write 1GB of "A"s to a file and fsync.  Then you write "B"s to
> the same 1GB of file and immediately start punching it.  If the system
> reboots before the mapping updates all get written to disk, won't you
> risk seeing some of those "A" because we no longer flush the "B"s?
> 
> Also, since the program didn't explicitly fsync the Bs, why bother
> flushing the dirty data at all?  Are data=journal writes supposed to be
> synchronous flushing writes nowadays?

Thanks you for your replay.

This case is not exactly the problem that can occur in data=journal
mode, the problem is even if we fsync "B"s before punching the hole, we
may still encounter old data ("A"s or even order) if the system reboots
before the hole-punching process is completed.

The details of this problem is the ext4_punch_hole()->
truncate_pagecache_range()-> ..->journal_unmap_buffer() will drop the
checkpoint transaction, which may contain B's journaled data. Consequently,
the journal tail could move advance beyond this point. If we do not flush
the data before dropping the cache and a crash occurs before the punching
transaction is committed, B's transaction will never recover, resulting
in the loss of B's data. Therefore, this cannot happen in non-journaled
data writes.

This flush logic is copied from ext4_zero_range() since it has the same
problem, Jan added it in commit 783ae448b7a2 ("ext4: Fix special handling
of journalled data from extent zeroing"), please see it for more details.
Jan, please correct me if my understanding is incorrect.

Thanks,
Yi.

> 
> --D
> 
>> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
>> ---
>>  fs/ext4/inode.c | 26 +++++++++++++++-----------
>>  1 file changed, 15 insertions(+), 11 deletions(-)
>>
>> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
>> index f8796f7b0f94..94b923afcd9c 100644
>> --- a/fs/ext4/inode.c
>> +++ b/fs/ext4/inode.c
>> @@ -3965,17 +3965,6 @@ int ext4_punch_hole(struct file *file, loff_t offset, loff_t length)
>>  
>>  	trace_ext4_punch_hole(inode, offset, length, 0);
>>  
>> -	/*
>> -	 * Write out all dirty pages to avoid race conditions
>> -	 * Then release them.
>> -	 */
>> -	if (mapping_tagged(mapping, PAGECACHE_TAG_DIRTY)) {
>> -		ret = filemap_write_and_wait_range(mapping, offset,
>> -						   offset + length - 1);
>> -		if (ret)
>> -			return ret;
>> -	}
>> -
>>  	inode_lock(inode);
>>  
>>  	/* No need to punch hole beyond i_size */
>> @@ -4037,6 +4026,21 @@ int ext4_punch_hole(struct file *file, loff_t offset, loff_t length)
>>  		ret = ext4_update_disksize_before_punch(inode, offset, length);
>>  		if (ret)
>>  			goto out_dio;
>> +
>> +		/*
>> +		 * For journalled data we need to write (and checkpoint) pages
>> +		 * before discarding page cache to avoid inconsitent data on
>> +		 * disk in case of crash before punching trans is committed.
>> +		 */
>> +		if (ext4_should_journal_data(inode)) {
>> +			ret = filemap_write_and_wait_range(mapping,
>> +					first_block_offset, last_block_offset);
>> +			if (ret)
>> +				goto out_dio;
>> +		}
>> +
>> +		ext4_truncate_folios_range(inode, first_block_offset,
>> +					   last_block_offset + 1);
>>  		truncate_pagecache_range(inode, first_block_offset,
>>  					 last_block_offset);
>>  	}
>> -- 
>> 2.46.1
>>
>>


