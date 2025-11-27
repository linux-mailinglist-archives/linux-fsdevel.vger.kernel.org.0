Return-Path: <linux-fsdevel+bounces-69984-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C3DA0C8D175
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 08:27:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D6C8834E3CA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 07:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD8063195F4;
	Thu, 27 Nov 2025 07:27:35 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E8931B122;
	Thu, 27 Nov 2025 07:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764228455; cv=none; b=Mou3+CL+3iL7HP7XZiyTkDMaUVikgRphWchY8BXqZbatHmIZEWimBCid7Q5KQmKxLJEaZZhRnZScPuk9uF3CMGEdMfyziJpl2fSAWNrrDjTfEElr7cNPRoSIjhXTZxDDKnKRd6V3PlVEJ2BA5njzvuuZO07IpPu2euDR8b1Y4Aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764228455; c=relaxed/simple;
	bh=re38NH/FH7emZULZmonviOO0fvpwwVdERFF2VlTBOms=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sQdsRdT28IlTuwrJA8OzFRPOIitMNCKgP3FTkKLsDdHKNREweiXD8vMyriyrBVbM2mPBv+OkV690He92HEiGVYK0n6/io7Jqjc/vhCGsXCWN2emigCgxj4h3R2sND2ebSh3Ol2lzWDZXPubJqZgF/RqeZJ84vAuVNrdk+S8hMNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4dH7K72QYZzYQtgC;
	Thu, 27 Nov 2025 15:26:35 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 86B421A0359;
	Thu, 27 Nov 2025 15:27:28 +0800 (CST)
Received: from [10.174.178.152] (unknown [10.174.178.152])
	by APP2 (Coremail) with SMTP id Syh0CgCH5Xte_Sdpk5uyCA--.20141S3;
	Thu, 27 Nov 2025 15:27:28 +0800 (CST)
Message-ID: <8680efcd-dc84-4b4e-ab75-216de959ec88@huaweicloud.com>
Date: Thu, 27 Nov 2025 15:27:26 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/13] ext4: drop extent cache before splitting extent
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
 jack@suse.cz, yi.zhang@huawei.com, yizhang089@gmail.com,
 libaokun1@huawei.com, yangerkun@huawei.com
References: <20251121060811.1685783-1-yi.zhang@huaweicloud.com>
 <20251121060811.1685783-8-yi.zhang@huaweicloud.com>
 <aSbxjVypU3vdOUmK@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <aSbxjVypU3vdOUmK@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgCH5Xte_Sdpk5uyCA--.20141S3
X-Coremail-Antispam: 1UD129KBjvJXoWxZF1kWF1kGFW7JFWfZFyxXwb_yoWrGFWxpF
	92ka1UGr4kA348K34xG3WDKryv9r1kGrWxArW3Gr12q3Z8trya9rn7WayUZFyIgr48ZF1Y
	vr40ya4rGas8AFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

On 11/26/2025 8:24 PM, Ojaswin Mujoo wrote:
> On Fri, Nov 21, 2025 at 02:08:05PM +0800, Zhang Yi wrote:
>> From: Zhang Yi <yi.zhang@huawei.com>
>>
>> When splitting an unwritten extent in the middle and converting it to
>> initialized in ext4_split_extent() with the EXT4_EXT_MAY_ZEROOUT and
>> EXT4_EXT_DATA_VALID2 flags set, it could leave a stale unwritten extent.
>>
>> Assume we have an unwritten file and buffered write in the middle of it
>> without dioread_nolock enabled, it will allocate blocks as written
>> extent.
>>
>>        0  A      B  N
>>        [UUUUUUUUUUUU] on-disk extent      U: unwritten extent
>>        [UUUUUUUUUUUU] extent status tree
>>        [--DDDDDDDD--]                     D: valid data
>>           |<-  ->| ----> this range needs to be initialized
>>
>> ext4_split_extent() first try to split this extent at B with
>> EXT4_EXT_DATA_PARTIAL_VALID1 and EXT4_EXT_MAY_ZEROOUT flag set, but
>> ext4_split_extent_at() failed to split this extent due to temporary lack
>> of space. It zeroout B to N and leave the entire extent as unwritten.
>>
>>        0  A      B  N
>>        [UUUUUUUUUUUU] on-disk extent
>>        [UUUUUUUUUUUU] extent status tree
>>        [--DDDDDDDDZZ]                     Z: zeroed data
>>
>> ext4_split_extent() then try to split this extent at A with
>> EXT4_EXT_DATA_VALID2 flag set. This time, it split successfully and
>> leave
>> an written extent from A to N.
> 
> Hi Yi, 
> 
> thanks for the detailed description. I'm trying to understand the
> codepath a bit and I believe you are talking about:
> 
> ext4_ext_handle_unwritten_extents()
>   ext4_ext_convert_to_initialized()
> 	  // Case 5: split 1 unwrit into 3 parts and convert to init
> 		ext4_split_extent()

Yes, but in fact, it should be Case 1: split the extent into three
extents.

> 
> in which case, after the second split succeeds
>>
>>        0  A      B   N
>>        [UU|WWWWWWWWWW] on-disk extent     W: written extent
>>        [UU|UUUUUUUUUU] extent status tree
> 
> WHen will extent status get split into 2 unwrit extents as you show
> above? I seem to be missing that call since IIUC ext4_ext_insert_extent
> itself doesn't seem to be accounting for the newly inserted extent in es.
> 

Sorry for the confusion. This was drawn because I couldn't find a
suitable symbol, so I followed the representation method used for
on-disk extents. In fact, there is no splitting of extent status entries
here. I have updated the last two graphs as follows(different types of
extents are considered as different extents):

           0  A      B  N
           [UUWWWWWWWWWW] on-disk extent     W: written extent
           [UUUUUUUUUUUU] extent status tree
           [--DDDDDDDDZZ]

           0  A      B  N
           [UUWWWWWWWWWW] on-disk extent     W: written extent
           [UUWWWWWWWWUU] extent status tree
           [--DDDDDDDDZZ]

Will this make it easier to understand?

Cheers,
Yi.


> Regards,
> ojaswin
> 
>>        [--|DDDDDDDDZZ]
> 
>>
>> Finally ext4_map_create_blocks() only insert extent A to B to the extent
>> status tree, and leave an stale unwritten extent in the status tree.
>>
>>        0  A      B   N
>>        [UU|WWWWWWWWWW] on-disk extent     W: written extent
>>        [UU|WWWWWWWWUU] extent status tree
>>        [--|DDDDDDDDZZ]
>>
>> Fix this issue by always remove cached extent status entry before
>> splitting extent.
>>
>> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
>> ---
>>  fs/ext4/extents.c | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
>> index 2b5aec3f8882..9bb80af4b5cf 100644
>> --- a/fs/ext4/extents.c
>> +++ b/fs/ext4/extents.c
>> @@ -3367,6 +3367,12 @@ static struct ext4_ext_path *ext4_split_extent(handle_t *handle,
>>  	ee_len = ext4_ext_get_actual_len(ex);
>>  	unwritten = ext4_ext_is_unwritten(ex);
>>  
>> +	/*
>> +	 * Drop extent cache to prevent stale unwritten extents remaining
>> +	 * after zeroing out.
>> +	 */
>> +	ext4_es_remove_extent(inode, ee_block, ee_len);
>> +
>>  	/* Do not cache extents that are in the process of being modified. */
>>  	flags |= EXT4_EX_NOCACHE;
>>  
>> -- 
>> 2.46.1
>>


