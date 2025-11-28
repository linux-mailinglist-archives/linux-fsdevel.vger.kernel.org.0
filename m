Return-Path: <linux-fsdevel+bounces-70102-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 06E82C909D0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Nov 2025 03:22:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EAE204E4120
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Nov 2025 02:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7B8826738D;
	Fri, 28 Nov 2025 02:22:48 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B78221546;
	Fri, 28 Nov 2025 02:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764296568; cv=none; b=oxfYbZfC35/KQieS0XlNAmo8aCtPPoskg1DRIFaTjaxl49N6gTusP5QzDbOKTT1abww2LHLcUGb3WFZh+iPzKPcRBXM38h+FGJlMK7w/X1+tQ6bhzpMd41YaBqpxF2AAVyO0ukDri18uX/lisBxgsaA43QANblncl22UtevP0Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764296568; c=relaxed/simple;
	bh=kC3oOnje8pBH0WizvFwxCNOdofUBJukRnsqJVBOTqPk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GLHr+F3hEoVkRh0Q6E8nsCEDtHe8+MuoWKYkKUreFOfEPhSUcCznVcdNutDknHemK6muA7x6hOcJrH5xENyKrMU2GTVFPSl6XgQQ6O9EhvTdzpOfWlaIQsHxNGHm0gWjYqlWHVgctAA2lB5VBEkb/Ugmj47eZrHkQu3qA+9mdVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4dHcWF370vzKHMNp;
	Fri, 28 Nov 2025 10:22:01 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 8F2D61A07BB;
	Fri, 28 Nov 2025 10:22:42 +0800 (CST)
Received: from [10.174.178.152] (unknown [10.174.178.152])
	by APP2 (Coremail) with SMTP id Syh0CgCHMXhwBylpHC4OCQ--.55753S3;
	Fri, 28 Nov 2025 10:22:42 +0800 (CST)
Message-ID: <06ab1faa-ea54-400e-9f21-46a20ac04403@huaweicloud.com>
Date: Fri, 28 Nov 2025 10:22:40 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/13] ext4: cleanup zeroout in ext4_split_extent_at()
To: Jan Kara <jack@suse.cz>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
 yi.zhang@huawei.com, yizhang089@gmail.com, libaokun1@huawei.com,
 yangerkun@huawei.com
References: <20251121060811.1685783-1-yi.zhang@huaweicloud.com>
 <20251121060811.1685783-2-yi.zhang@huaweicloud.com>
 <msavgjqicoxnjloi53fa6stdurfqjxho5fwka7dusyrrjrdtep@spfzuymowwdd>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <msavgjqicoxnjloi53fa6stdurfqjxho5fwka7dusyrrjrdtep@spfzuymowwdd>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgCHMXhwBylpHC4OCQ--.55753S3
X-Coremail-Antispam: 1UD129KBjvJXoWxZrWfWr4DWr17WFW7WryrXrb_yoWrGrW8pF
	nakF1fKr1rJa4UW3yIqFsrZF1a93WfGr1UGFWfWw1Fqa12vF93KFyfKa10qFyayFW0qayF
	qFW8ta4DC3ZrGFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8
	ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUF1
	v3UUUUU
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 11/27/2025 8:02 PM, Jan Kara wrote:
> On Fri 21-11-25 14:07:59, Zhang Yi wrote:
>> From: Zhang Yi <yi.zhang@huawei.com>
>>
>> zero_ex is a temporary variable used only for writing zeros and
>> inserting extent status entry, it will not be directly inserted into the
>> tree. Therefore, it can be assigned values from the target extent in
>> various scenarios, eliminating the need to explicitly assign values to
>> each variable individually.
>>
>> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> 
> Nice simplification. I'd just note that the new method copies also the
> unwritten state of the original extent to zero_ex (the old method didn't do
> this). It doesn't matter in this case but it might still be nice to add a
> comment about it before the code doing the copying. Feel free to add:
> 
> Reviewed-by: Jan Kara <jack@suse.cz>
> 
> 								Honza

Thank you a lot for reviewing this series! It seems that calling
ext4_ext_mark_initialized() after copying is also acceptable.

Cheers,
Yi.

> 
>> ---
>>  fs/ext4/extents.c | 63 ++++++++++++++++++-----------------------------
>>  1 file changed, 24 insertions(+), 39 deletions(-)
>>
>> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
>> index c7d219e6c6d8..91682966597d 100644
>> --- a/fs/ext4/extents.c
>> +++ b/fs/ext4/extents.c
>> @@ -3278,46 +3278,31 @@ static struct ext4_ext_path *ext4_split_extent_at(handle_t *handle,
>>  	ex = path[depth].p_ext;
>>  
>>  	if (EXT4_EXT_MAY_ZEROOUT & split_flag) {
>> -		if (split_flag & (EXT4_EXT_DATA_VALID1|EXT4_EXT_DATA_VALID2)) {
>> -			if (split_flag & EXT4_EXT_DATA_VALID1) {
>> -				err = ext4_ext_zeroout(inode, ex2);
>> -				zero_ex.ee_block = ex2->ee_block;
>> -				zero_ex.ee_len = cpu_to_le16(
>> -						ext4_ext_get_actual_len(ex2));
>> -				ext4_ext_store_pblock(&zero_ex,
>> -						      ext4_ext_pblock(ex2));
>> -			} else {
>> -				err = ext4_ext_zeroout(inode, ex);
>> -				zero_ex.ee_block = ex->ee_block;
>> -				zero_ex.ee_len = cpu_to_le16(
>> -						ext4_ext_get_actual_len(ex));
>> -				ext4_ext_store_pblock(&zero_ex,
>> -						      ext4_ext_pblock(ex));
>> -			}
>> -		} else {
>> -			err = ext4_ext_zeroout(inode, &orig_ex);
>> -			zero_ex.ee_block = orig_ex.ee_block;
>> -			zero_ex.ee_len = cpu_to_le16(
>> -						ext4_ext_get_actual_len(&orig_ex));
>> -			ext4_ext_store_pblock(&zero_ex,
>> -					      ext4_ext_pblock(&orig_ex));
>> -		}
>> +		if (split_flag & EXT4_EXT_DATA_VALID1)
>> +			memcpy(&zero_ex, ex2, sizeof(zero_ex));
>> +		else if (split_flag & EXT4_EXT_DATA_VALID2)
>> +			memcpy(&zero_ex, ex, sizeof(zero_ex));
>> +		else
>> +			memcpy(&zero_ex, &orig_ex, sizeof(zero_ex));
>>  
>> -		if (!err) {
>> -			/* update the extent length and mark as initialized */
>> -			ex->ee_len = cpu_to_le16(ee_len);
>> -			ext4_ext_try_to_merge(handle, inode, path, ex);
>> -			err = ext4_ext_dirty(handle, inode, path + path->p_depth);
>> -			if (!err)
>> -				/* update extent status tree */
>> -				ext4_zeroout_es(inode, &zero_ex);
>> -			/* If we failed at this point, we don't know in which
>> -			 * state the extent tree exactly is so don't try to fix
>> -			 * length of the original extent as it may do even more
>> -			 * damage.
>> -			 */
>> -			goto out;
>> -		}
>> +		err = ext4_ext_zeroout(inode, &zero_ex);
>> +		if (err)
>> +			goto fix_extent_len;
>> +
>> +		/* update the extent length and mark as initialized */
>> +		ex->ee_len = cpu_to_le16(ee_len);
>> +		ext4_ext_try_to_merge(handle, inode, path, ex);
>> +		err = ext4_ext_dirty(handle, inode, path + path->p_depth);
>> +		if (!err)
>> +			/* update extent status tree */
>> +			ext4_zeroout_es(inode, &zero_ex);
>> +		/*
>> +		 * If we failed at this point, we don't know in which
>> +		 * state the extent tree exactly is so don't try to fix
>> +		 * length of the original extent as it may do even more
>> +		 * damage.
>> +		 */
>> +		goto out;
>>  	}
>>  
>>  fix_extent_len:
>> -- 
>> 2.46.1
>>


