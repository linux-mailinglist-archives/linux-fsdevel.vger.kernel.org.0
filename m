Return-Path: <linux-fsdevel+bounces-18097-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BC92E8B5795
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 14:13:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CDBFDB24D24
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 12:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B7207E57C;
	Mon, 29 Apr 2024 12:09:55 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB6067D3E0;
	Mon, 29 Apr 2024 12:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714392594; cv=none; b=Zwm7stsfPJcLTD2sq7sRh/QUOegsB5HVwex0TSP86FGQs3ziC2JD4+xEX9rB2tcOjXLXptfAhUPLBvcGY30O/IunnUc+LhItHyM7jubZa052sRkIzvuOaoQ5BxRvlCIxflWBoSJV6RNijiCsrz2xOxldWPMHI2xiJdCoJKfr2NY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714392594; c=relaxed/simple;
	bh=TUCu9XVhEOju+HxGzwiVcDLCjAEKpa8UzsEieUNRn9o=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=eadTpxbCzPFGYOoM+OUVMgdC852sqYXV+F7dawJ6i7ODFI1WW1PIfnUIED9ksTR7j3P7QSl4Zrcumz4ydUyy15b8zMRhVNptsPC/ds+eYzLUtZ8ECTwZC+N8Qe/Ukcw2ylk/p5Sw/HDwG4Q5GyvyPMSRt9asdWXAzM1fLJCeh/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VShw258fhz4f3tNT;
	Mon, 29 Apr 2024 20:09:38 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 289D41A0DB9;
	Mon, 29 Apr 2024 20:09:48 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP2 (Coremail) with SMTP id Syh0CgAXOQwKji9mt_kqLg--.29450S3;
	Mon, 29 Apr 2024 20:09:48 +0800 (CST)
Subject: Re: [PATCH v2 5/9] ext4: make ext4_es_insert_delayed_block() insert
 multi-blocks
To: Jan Kara <jack@suse.cz>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, tytso@mit.edu,
 adilger.kernel@dilger.ca, yi.zhang@huawei.com, chengzhihao1@huawei.com,
 yukuai3@huawei.com
References: <20240410034203.2188357-1-yi.zhang@huaweicloud.com>
 <20240410034203.2188357-6-yi.zhang@huaweicloud.com>
 <20240429091638.bghtdkbufbmhlw3r@quack3>
From: Zhang Yi <yi.zhang@huaweicloud.com>
Message-ID: <cf125f2c-d2f0-57f8-ee6f-9a93b9f5828d@huaweicloud.com>
Date: Mon, 29 Apr 2024 20:09:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240429091638.bghtdkbufbmhlw3r@quack3>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgAXOQwKji9mt_kqLg--.29450S3
X-Coremail-Antispam: 1UD129KBjvJXoWxuFykCFyUtry3tr15Jry7KFg_yoW7Aw1Upr
	Z8tF18Ca1UXw109F92qw1jqr1aqa1DJrWUGwsaqw13ZF98XFyfKF1DKF1FvFW0vr4xJ3ZI
	qFy5Cw17uan09a7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUk0b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij
	64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42
	xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv
	6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUrR6zUUUUU
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 2024/4/29 17:16, Jan Kara wrote:
> On Wed 10-04-24 11:41:59, Zhang Yi wrote:
>> From: Zhang Yi <yi.zhang@huawei.com>
>>
>> Rename ext4_es_insert_delayed_block() to ext4_es_insert_delayed_extent()
>> and pass length parameter to make it insert multi delalloc blocks once a
>> time. For the case of bigalloc, expand the allocated parameter to
>> lclu_allocated and end_allocated. lclu_allocated indicates the allocate
>> state of the cluster which containing the lblk, end_allocated represents
>> the end, and the middle clusters must be unallocated.
>>
>> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> 
> Looks mostly good, just one comment below:
> 
>> diff --git a/fs/ext4/extents_status.c b/fs/ext4/extents_status.c
>> index 4a00e2f019d9..2320b0d71001 100644
>> --- a/fs/ext4/extents_status.c
>> +++ b/fs/ext4/extents_status.c
>> @@ -2052,34 +2052,42 @@ bool ext4_is_pending(struct inode *inode, ext4_lblk_t lblk)
>>  }
>>  
>>  /*
>> - * ext4_es_insert_delayed_block - adds a delayed block to the extents status
>> - *                                tree, adding a pending reservation where
>> - *                                needed
>> + * ext4_es_insert_delayed_extent - adds some delayed blocks to the extents
>> + *                                 status tree, adding a pending reservation
>> + *                                 where needed
>>   *
>>   * @inode - file containing the newly added block
>> - * @lblk - logical block to be added
>> - * @allocated - indicates whether a physical cluster has been allocated for
>> - *              the logical cluster that contains the block
>> + * @lblk - start logical block to be added
>> + * @len - length of blocks to be added
>> + * @lclu_allocated/end_allocated - indicates whether a physical cluster has
>> + *                                 been allocated for the logical cluster
>> + *                                 that contains the block
> 						        ^^^^ "start / end
> block" to make it clearer...
> 
>> -void ext4_es_insert_delayed_block(struct inode *inode, ext4_lblk_t lblk,
>> -				  bool allocated)
>> +void ext4_es_insert_delayed_extent(struct inode *inode, ext4_lblk_t lblk,
>> +				   ext4_lblk_t len, bool lclu_allocated,
>> +				   bool end_allocated)
>>  {
>>  	struct extent_status newes;
>> +	ext4_lblk_t end = lblk + len - 1;
>>  	int err1 = 0, err2 = 0, err3 = 0;
>>  	struct extent_status *es1 = NULL;
>>  	struct extent_status *es2 = NULL;
>> -	struct pending_reservation *pr = NULL;
>> +	struct pending_reservation *pr1 = NULL;
>> +	struct pending_reservation *pr2 = NULL;
>>  
>>  	if (EXT4_SB(inode->i_sb)->s_mount_state & EXT4_FC_REPLAY)
>>  		return;
>>  
>> -	es_debug("add [%u/1) delayed to extent status tree of inode %lu\n",
>> -		 lblk, inode->i_ino);
>> +	es_debug("add [%u/%u) delayed to extent status tree of inode %lu\n",
>> +		 lblk, len, inode->i_ino);
>> +	if (!len)
>> +		return;
>>  
>>  	newes.es_lblk = lblk;
>> -	newes.es_len = 1;
>> +	newes.es_len = len;
>>  	ext4_es_store_pblock_status(&newes, ~0, EXTENT_STATUS_DELAYED);
>> -	trace_ext4_es_insert_delayed_block(inode, &newes, allocated);
>> +	trace_ext4_es_insert_delayed_extent(inode, &newes, lclu_allocated,
>> +					    end_allocated);
>>  
>>  	ext4_es_insert_extent_check(inode, &newes);
>>  
>> @@ -2088,11 +2096,15 @@ void ext4_es_insert_delayed_block(struct inode *inode, ext4_lblk_t lblk,
>>  		es1 = __es_alloc_extent(true);
>>  	if ((err1 || err2) && !es2)
>>  		es2 = __es_alloc_extent(true);
>> -	if ((err1 || err2 || err3) && allocated && !pr)
>> -		pr = __alloc_pending(true);
>> +	if (err1 || err2 || err3) {
>> +		if (lclu_allocated && !pr1)
>> +			pr1 = __alloc_pending(true);
>> +		if (end_allocated && !pr2)
>> +			pr2 = __alloc_pending(true);
>> +	}
>>  	write_lock(&EXT4_I(inode)->i_es_lock);
>>  
>> -	err1 = __es_remove_extent(inode, lblk, lblk, NULL, es1);
>> +	err1 = __es_remove_extent(inode, lblk, end, NULL, es1);
>>  	if (err1 != 0)
>>  		goto error;
>>  	/* Free preallocated extent if it didn't get used. */
>> @@ -2112,13 +2124,22 @@ void ext4_es_insert_delayed_block(struct inode *inode, ext4_lblk_t lblk,
>>  		es2 = NULL;
>>  	}
>>  
>> -	if (allocated) {
>> -		err3 = __insert_pending(inode, lblk, &pr);
>> +	if (lclu_allocated) {
>> +		err3 = __insert_pending(inode, lblk, &pr1);
>>  		if (err3 != 0)
>>  			goto error;
>> -		if (pr) {
>> -			__free_pending(pr);
>> -			pr = NULL;
>> +		if (pr1) {
>> +			__free_pending(pr1);
>> +			pr1 = NULL;
>> +		}
>> +	}
>> +	if (end_allocated) {
> 
> So there's one unclear thing here: What if 'lblk' and 'end' are in the same
> cluster? We don't want two pending reservation structures for the cluster.
> __insert_pending() already handles this gracefully but perhaps we don't
> need to allocate 'pr2' in that case and call __insert_pending() at all? I
> think it could be easily handled by something like:
> 
> 	if (EXT4_B2C(lblk) == EXT4_B2C(end))
> 		end_allocated = false;
> 
> at appropriate place in ext4_es_insert_delayed_extent().
> 

I've done the check "EXT4_B2C(lblk) == EXT4_B2C(end)" in the caller
ext4_insert_delayed_blocks() in patch 8, becasue there is no need to check
the allocation state if they are in the same cluster, so it could make sure
that end_allocated is always false when 'lblk' and 'end' are in the same
cluster. So I suppose check and set it here again maybe redundant, how about
add a wanging here in ext4_es_insert_delayed_extent(), like:

	WARN_ON_ONCE((EXT4_B2C(sbi, lblk) == EXT4_B2C(sbi, end)) &&
		     end_allocated);

and modify the 'lclu_allocated/end_allocated' parameter comments, note that
end_allocated should always be set to false if the extent is in one cluster.
Is it fine?

Thanks,
Yi.


