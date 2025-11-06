Return-Path: <linux-fsdevel+bounces-67306-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19AA3C3B1D4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 06 Nov 2025 14:13:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 438981893BAD
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Nov 2025 13:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D068F3314BB;
	Thu,  6 Nov 2025 13:02:43 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 251AA32E74C;
	Thu,  6 Nov 2025 13:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762434163; cv=none; b=SbDbhZ10Rw9yT5rAIWK9dmPXTvlZd5s4UXAkGSHzOhi8f2cRaCrpLJV0iOYoGfimgONqH/XEchPhYB/9IhkB70BBSXcUj+MpOmcYTfCTRBza7pBUhvbmW6g/7+A0dAMxmlMBpqNrj7gLnhZvgxm0SlD/4WpAxg+yHSUadHp8DZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762434163; c=relaxed/simple;
	bh=eR2/DoiDVKUeitzoaYzhEuiWZe1Z03sdP3dv30RGhDU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RlDcXbfWxiNEqAaAUOrDE0cUHgIwkP633x9mnTdZjv0Zw9kXb1v1QMZuX3yYEK1cSnoPtLw5i7+OLPpLUHZkWWBJ8OIHEkdCj+JGjN3vA2dEOTidZw2TeXJZ+y3v/9qAk01RJ4C/po1JPGr1bxqw2tq2Tlz0kevWUkR5dKvmIYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4d2MmC1KwhzYQtr6;
	Thu,  6 Nov 2025 21:02:19 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 8D1901A159D;
	Thu,  6 Nov 2025 21:02:37 +0800 (CST)
Received: from [10.174.178.152] (unknown [10.174.178.152])
	by APP2 (Coremail) with SMTP id Syh0CgBnCEFrnAxpmRKgCw--.24175S3;
	Thu, 06 Nov 2025 21:02:37 +0800 (CST)
Message-ID: <ee200d75-6f3e-4514-8fd4-8cdcbd3754d4@huaweicloud.com>
Date: Thu, 6 Nov 2025 21:02:35 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] ext4: make ext4_es_cache_extent() support overwrite
 existing extents
To: Jan Kara <jack@suse.cz>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
 yi.zhang@huawei.com, libaokun1@huawei.com, yangerkun@huawei.com
References: <20251031062905.4135909-1-yi.zhang@huaweicloud.com>
 <20251031062905.4135909-2-yi.zhang@huaweicloud.com>
 <l7tb75bsk52ybeok737b7o4ag4zeleowtddf3v6wcbnhbom4tx@xv643wp5wp6a>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <l7tb75bsk52ybeok737b7o4ag4zeleowtddf3v6wcbnhbom4tx@xv643wp5wp6a>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgBnCEFrnAxpmRKgCw--.24175S3
X-Coremail-Antispam: 1UD129KBjvJXoWxtF4rAFy8ArWktryxKFyUKFg_yoW3CFyUpr
	ZIkr1UGrW8X34vkayxJ3WUXr1Fgw4xGrW7AryfKw1SkFy5ZFyIgF18tayYvFy0grW8X3WY
	vF40kw1UWa15AaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUylb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAK
	I48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
	67AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUF1v3UUUUU
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

Hi! Thank you for the review and suggestions!

On 11/6/2025 5:15 PM, Jan Kara wrote:
> On Fri 31-10-25 14:29:02, Zhang Yi wrote:
>> From: Zhang Yi <yi.zhang@huawei.com>
>>
>> Currently, ext4_es_cache_extent() is used to load extents into the
>> extent status tree when reading on-disk extent blocks. Since it may be
>> called while moving or modifying the extent tree, so it does not
>> overwrite existing extents in the extent status tree and is only used
>> for the initial loading.
>>
>> There are many other places in ext4 where on-disk extents are inserted
>> into the extent status tree, such as in ext4_map_query_blocks().
>> Currently, they call ext4_es_insert_extent() to perform the insertion,
>> but they don't modify the extents, so ext4_es_cache_extent() would be a
>> more appropriate choice. However, when ext4_map_query_blocks() inserts
>> an extent, it may overwrite a short existing extent of the same type.
>> Therefore, to prepare for the replacements, we need to extend
>> ext4_es_cache_extent() to allow it to overwrite existing extents with
>> the same type.
>>
>> In addition, since cached extents can be more lenient than the extents
>> they modify and do not involve modifying reserved blocks, it is not
>> necessary to ensure that the insertion operation succeeds as strictly as
>> in the ext4_es_insert_extent() function.
>>
>> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> 
> Thanks for writing this series! I think we can actually simplify things
> event further. Extent status tree operations can be divided into three
> groups:
> 1) Lookups in es tree - protected only by i_es_lock.
> 2) Caching of on-disk state into es tree - protected by i_es_lock and
>    i_data_sem (at least in read mode).
> 3) Modification of existing state - protected by i_es_lock and i_data_sem
>    in write mode.

Yeah.

> 
> Now because 2) has exclusion vs 3) due to i_data_sem, the observation is
> that 2) should never see a real conflict - i.e., all intersecting entries
> in es tree have the same status, otherwise this is a bug.

While I was debugging, I observed two exceptions here.

A. The first exceptions is about the delay extent. Since there is no actual
   extent present in the extent tree on the disk, if a delayed extent
   already exists in the extent status tree and someone calls
   ext4_find_extent()->ext4_cache_extents() to cache an extent at the same
   location, then a status mismatch will occur (attempting to replace
   the delayed extent with a hole). This is not a bug.
B. I also observed that ext4_find_extent()->ext4_cache_extents() is called
   during splitting and conversion between unwritten and written states (in
   most scenarios, EXT4_EX_NOCACHE is not added). However, because the
   process is in an intermediate state of handling extents, there can be
   cases where the status do not match. I did not analyze this scenario in
   detail, but since ext4_es_insert_extent() is called at the end of the
   processing to ensure the final state is correct, I don't think this is a
   practical issue either.

Therefore, I believe that retaining non-overwriting is necessary for this
scenario involving ext4_cache_extents() because it will be called during
case 3). Except for ext4_cache_extents(), other scenarios theoretically
should not be involved.

> So I think that 
> ext4_es_cache_extent() should always walk the whole inserted range, verify
> the statuses match and merge all these entries into a single one. This
> isn't going to be slower than what we have today because your
> __es_remove_extent(), __es_insert_extent() pair is effectively doing the
> same thing, just without checking the statuses.

Yes, I agree that we can delegate the verification work in
ext4_es_cache_extent() to __es_remove_extent(). During the process of
overwriting extents, the first step is to remove the existing extents. If
the extent status does not match, an alarm will be triggered.

> That way we always get the
> checking and also ext4_es_cache_extent() doesn't have to have the
> overwriting and non-overwriting variant. What do you think?
> 
> 								Honza

For case A, we can add an exception during verification and skip the
warnings. For case B, We need to ensure that ext4_cache_extents() is not
allowed to be called during the intermediate processing of the extent
tree. This seems feasible in theory, but I guess it is somewhat fragile.
So, keep the non-overwriting mode?

Best Regards,
Yi.

> 
>> ---
>>  fs/ext4/extents.c        |  4 ++--
>>  fs/ext4/extents_status.c | 28 +++++++++++++++++++++-------
>>  fs/ext4/extents_status.h |  2 +-
>>  3 files changed, 24 insertions(+), 10 deletions(-)
>>
>> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
>> index ca5499e9412b..c42ceb5aae37 100644
>> --- a/fs/ext4/extents.c
>> +++ b/fs/ext4/extents.c
>> @@ -537,12 +537,12 @@ static void ext4_cache_extents(struct inode *inode,
>>  
>>  		if (prev && (prev != lblk))
>>  			ext4_es_cache_extent(inode, prev, lblk - prev, ~0,
>> -					     EXTENT_STATUS_HOLE);
>> +					     EXTENT_STATUS_HOLE, false);
>>  
>>  		if (ext4_ext_is_unwritten(ex))
>>  			status = EXTENT_STATUS_UNWRITTEN;
>>  		ext4_es_cache_extent(inode, lblk, len,
>> -				     ext4_ext_pblock(ex), status);
>> +				     ext4_ext_pblock(ex), status, false);
>>  		prev = lblk + len;
>>  	}
>>  }
>> diff --git a/fs/ext4/extents_status.c b/fs/ext4/extents_status.c
>> index 31dc0496f8d0..f9546ecf7340 100644
>> --- a/fs/ext4/extents_status.c
>> +++ b/fs/ext4/extents_status.c
>> @@ -986,13 +986,19 @@ void ext4_es_insert_extent(struct inode *inode, ext4_lblk_t lblk,
>>  }
>>  
>>  /*
>> - * ext4_es_cache_extent() inserts information into the extent status
>> - * tree if and only if there isn't information about the range in
>> - * question already.
>> + * ext4_es_cache_extent() inserts extent information into the extent status
>> + * tree. If 'overwrite' is not set, it inserts extent only if there isn't
>> + * information about the specified range. Otherwise, it overwrites the
>> + * current information.
>> + *
>> + * Note that this interface is only used for caching on-disk extent
>> + * information and cannot be used to convert existing extents in the extent
>> + * status tree. To convert existing extents, use ext4_es_insert_extent()
>> + * instead.
>>   */
>>  void ext4_es_cache_extent(struct inode *inode, ext4_lblk_t lblk,
>>  			  ext4_lblk_t len, ext4_fsblk_t pblk,
>> -			  unsigned int status)
>> +			  unsigned int status, bool overwrite)
>>  {
>>  	struct extent_status *es;
>>  	struct extent_status newes;
>> @@ -1012,10 +1018,18 @@ void ext4_es_cache_extent(struct inode *inode, ext4_lblk_t lblk,
>>  	BUG_ON(end < lblk);
>>  
>>  	write_lock(&EXT4_I(inode)->i_es_lock);
>> -
>>  	es = __es_tree_search(&EXT4_I(inode)->i_es_tree.root, lblk);
>> -	if (!es || es->es_lblk > end)
>> -		__es_insert_extent(inode, &newes, NULL);
>> +	if (es && es->es_lblk <= end) {
>> +		if (!overwrite)
>> +			goto unlock;
>> +
>> +		/* Only extents of the same type can be overwritten. */
>> +		WARN_ON_ONCE(ext4_es_type(es) != status);
>> +		if (__es_remove_extent(inode, lblk, end, NULL, NULL))
>> +			goto unlock;
>> +	}
>> +	__es_insert_extent(inode, &newes, NULL);
>> +unlock:
>>  	write_unlock(&EXT4_I(inode)->i_es_lock);
>>  }
>>  
>> diff --git a/fs/ext4/extents_status.h b/fs/ext4/extents_status.h
>> index 8f9c008d11e8..415f7c223a46 100644
>> --- a/fs/ext4/extents_status.h
>> +++ b/fs/ext4/extents_status.h
>> @@ -139,7 +139,7 @@ extern void ext4_es_insert_extent(struct inode *inode, ext4_lblk_t lblk,
>>  				  bool delalloc_reserve_used);
>>  extern void ext4_es_cache_extent(struct inode *inode, ext4_lblk_t lblk,
>>  				 ext4_lblk_t len, ext4_fsblk_t pblk,
>> -				 unsigned int status);
>> +				 unsigned int status, bool overwrite);
>>  extern void ext4_es_remove_extent(struct inode *inode, ext4_lblk_t lblk,
>>  				  ext4_lblk_t len);
>>  extern void ext4_es_find_extent_range(struct inode *inode,
>> -- 
>> 2.46.1
>>


