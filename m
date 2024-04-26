Return-Path: <linux-fsdevel+bounces-17881-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 150FF8B3449
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Apr 2024 11:38:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B3EEB244EA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Apr 2024 09:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F312A13F433;
	Fri, 26 Apr 2024 09:38:32 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E852644368;
	Fri, 26 Apr 2024 09:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714124312; cv=none; b=or6VyF4pyKtd5VMVBLkMo4umxZ7uBjgKZzbaUkV/r8ZZoCXrDftiMjUiCbYCt4ggztMjaX+vX71B0dWIzfG7wD3qMCAZKk7a9wTFV3fpx+/CHBGKN5jWM7/bjbSsm8kcD/xVGob/+9abFVpdbSiZIN15T9tZrk/7F6aEvKp39GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714124312; c=relaxed/simple;
	bh=HMXR4k8kWf2/LoJg9F4zyai4/xuY8MTcQIgUBq+lZyg=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=hd9hzMheulJl30hnqTmlRxsPcMK7KBa1UaVms8hWbsTTrcQ5oVL4S8+b/f4MinYJJBMtbX9Ip6qNuuJ74p1MmZwKqhcFkKEn01qG0Oekk4ACaYOfy6cm0oiChEdpkHJ4u2g8xZzCUuFFEc7iRJ5T3ugwFnv/Qu4jaxIt8kJ7kxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VQnhr2KBDz4f3m81;
	Fri, 26 Apr 2024 17:38:20 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 3F82A1A017C;
	Fri, 26 Apr 2024 17:38:25 +0800 (CST)
Received: from [10.174.176.34] (unknown [10.174.176.34])
	by APP1 (Coremail) with SMTP id cCh0CgAX5g4Pditms6EDLA--.28068S3;
	Fri, 26 Apr 2024 17:38:25 +0800 (CST)
Subject: Re: [PATCH v2 3/9] ext4: trim delalloc extent
To: Jan Kara <jack@suse.cz>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, tytso@mit.edu,
 adilger.kernel@dilger.ca, yi.zhang@huawei.com, chengzhihao1@huawei.com,
 yukuai3@huawei.com
References: <20240410034203.2188357-1-yi.zhang@huaweicloud.com>
 <20240410034203.2188357-4-yi.zhang@huaweicloud.com>
 <20240425155640.ktvqqwhteitysaby@quack3>
From: Zhang Yi <yi.zhang@huaweicloud.com>
Message-ID: <acd4e7c9-c68b-9edc-bba4-dce5e8ce7879@huaweicloud.com>
Date: Fri, 26 Apr 2024 17:38:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240425155640.ktvqqwhteitysaby@quack3>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:cCh0CgAX5g4Pditms6EDLA--.28068S3
X-Coremail-Antispam: 1UD129KBjvJXoWxZryDXFW5tr4kWrykZF48Xrb_yoWrGF4xp3
	92kF1rGr4fW34xua1xtF15XF1Fgw1UKF47Kr4rKr1Yva4DGFyfKFyDAa12yFy8trs3JFs5
	XFWjq348Can2yrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij
	64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42
	xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
	c7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UWE__UUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 2024/4/25 23:56, Jan Kara wrote:
> On Wed 10-04-24 11:41:57, Zhang Yi wrote:
>> From: Zhang Yi <yi.zhang@huawei.com>
>>
>> The cached delalloc or hole extent should be trimed to the map->map_len
>> if we map delalloc blocks in ext4_da_map_blocks(). But it doesn't
>> trigger any issue now because the map->m_len is always set to one and we
>> always insert one delayed block once a time. Fix this by trim the extent
>> once we get one from the cached extent tree, prearing for mapping a
>> extent with multiple delalloc blocks.
>>
>> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> 
> Well, but we already do the trimming in ext4_da_map_blocks(), don't we? You
> just move it to a different place... Or do you mean that we actually didn't
> set 'map' at all in some cases and now we do? 

Yeah, now we only trim map len if we found an unwritten extent or written
extent in the cache, this isn't okay if we found a hole and
ext4_insert_delayed_block() and ext4_da_map_blocks() support inserting
map->len blocks. If we found a hole which es->es_len is shorter than the
length we want to write, we could delay more blocks than we expected.

Please assume we write data [A, C) to a file that contains a hole extent
[A, B) and a written extent [B, D) in cache.

                      A     B  C  D
before da write:   ...hhhhhh|wwwwww....

Then we will get extent [A, B), we should trim map->m_len to B-A before
inserting new delalloc blocks, if not, the range [B, C) is duplicated.

> In either case the 'map'
> handling looks a bit sloppy in ext4_da_map_blocks() as e.g. the
> 'add_delayed' case doesn't seem to bother with properly setting 'map' based
> on what it does. So maybe we should clean that up to always set 'map' just
> before returning at the same place where we update the 'bh'? And maybe bh
> update could be updated in some common helper because it's content is
> determined by the 'map' content?
> 

I agree with you, it looks that we should always revise the map->m_len
once we found an extent from the cache, and then do corresponding handling
according to the extent type. so it's hard to put it to a common place.
But we can merge the handling of written and unwritten extent, I've moved
the bh updating into ext4_da_get_block_prep() and do some cleanup in
patch 9, please look at that patch, does it looks fine to you?

Thanks,
Yi.

> 								Honza
> 
>> ---
>>  fs/ext4/inode.c | 14 ++++++++++----
>>  1 file changed, 10 insertions(+), 4 deletions(-)
>>
>> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
>> index 118b0497a954..e4043ddb07a5 100644
>> --- a/fs/ext4/inode.c
>> +++ b/fs/ext4/inode.c
>> @@ -1734,6 +1734,11 @@ static int ext4_da_map_blocks(struct inode *inode, sector_t iblock,
>>  
>>  	/* Lookup extent status tree firstly */
>>  	if (ext4_es_lookup_extent(inode, iblock, NULL, &es)) {
>> +		retval = es.es_len - (iblock - es.es_lblk);
>> +		if (retval > map->m_len)
>> +			retval = map->m_len;
>> +		map->m_len = retval;
>> +
>>  		if (ext4_es_is_hole(&es))
>>  			goto add_delayed;
>>  
>> @@ -1750,10 +1755,6 @@ static int ext4_da_map_blocks(struct inode *inode, sector_t iblock,
>>  		}
>>  
>>  		map->m_pblk = ext4_es_pblock(&es) + iblock - es.es_lblk;
>> -		retval = es.es_len - (iblock - es.es_lblk);
>> -		if (retval > map->m_len)
>> -			retval = map->m_len;
>> -		map->m_len = retval;
>>  		if (ext4_es_is_written(&es))
>>  			map->m_flags |= EXT4_MAP_MAPPED;
>>  		else if (ext4_es_is_unwritten(&es))
>> @@ -1788,6 +1789,11 @@ static int ext4_da_map_blocks(struct inode *inode, sector_t iblock,
>>  	 * whitout holding i_rwsem and folio lock.
>>  	 */
>>  	if (ext4_es_lookup_extent(inode, iblock, NULL, &es)) {
>> +		retval = es.es_len - (iblock - es.es_lblk);
>> +		if (retval > map->m_len)
>> +			retval = map->m_len;
>> +		map->m_len = retval;
>> +
>>  		if (!ext4_es_is_hole(&es)) {
>>  			up_write(&EXT4_I(inode)->i_data_sem);
>>  			goto found;
>> -- 
>> 2.39.2
>>


