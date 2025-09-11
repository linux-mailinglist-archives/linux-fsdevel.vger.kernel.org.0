Return-Path: <linux-fsdevel+bounces-60872-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11854B5258B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Sep 2025 03:10:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06DFE1C27200
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Sep 2025 01:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 796261C7012;
	Thu, 11 Sep 2025 01:10:26 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7063D189906;
	Thu, 11 Sep 2025 01:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757553026; cv=none; b=QVXYi3qHOKg069p34j9YdxiszOlxBRf3h+2YTEM8RmoO8CIm+cKYR9XeCGY4CxGKEWlT3uOwj6M0jciuymbCsf9y1+YKJ/d25qRyFzR/MR7XN3iKF0bzsS4g0hGk80BmOPsCwuhvZ7vjcnWEL2Pt0Lx9ltBhEpHLcSjQkf6KG4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757553026; c=relaxed/simple;
	bh=bZUjLK5SgTEcv0bBLzldU8xIbeeQxwJdj07Qn7BaKg0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=mEU82/QrYZNUU41HtdN2dmco1waJ+IIFsCkM0mekHWITdMbKUvaCrHB7i3QREOB4kD2/NeMraAa2IoQQbeHEusETAqHFdaSSMX7acSBBJMvyKumbQrbNQaCpXwA1Tb0S+i9s7oRsHFHtb/Gvy9YTCJXtEc8PRIQcr3NDqmTYUQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4cMfXl1TFQz2TTNq;
	Thu, 11 Sep 2025 09:07:03 +0800 (CST)
Received: from kwepemo500015.china.huawei.com (unknown [7.202.194.227])
	by mail.maildlp.com (Postfix) with ESMTPS id E89B51800B2;
	Thu, 11 Sep 2025 09:10:19 +0800 (CST)
Received: from [10.174.179.92] (10.174.179.92) by
 kwepemo500015.china.huawei.com (7.202.194.227) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 11 Sep 2025 09:10:19 +0800
Message-ID: <d82a3e6f-25a2-4943-9e97-73337b33cfcc@huawei.com>
Date: Thu, 11 Sep 2025 09:10:07 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] ext4: increase i_disksize to offset + len in
 ext4_update_disksize_before_punch()
To: Jan Kara <jack@suse.cz>
CC: <linux-ext4@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<tytso@mit.edu>, <yangerkun@huawei.com>, <yi.zhang@huawei.com>,
	<libaokun1@huawei.com>, <chengzhihao1@huawei.com>
References: <20250910042516.3947590-1-sunyongjian@huaweicloud.com>
 <hsnzaxvcwphxncr6mmoepqnbokh7jblkytuqqyzpqsk7w3wsmr@bwutehzrrhys>
From: Sun Yongjian <sunyongjian1@huawei.com>
In-Reply-To: <hsnzaxvcwphxncr6mmoepqnbokh7jblkytuqqyzpqsk7w3wsmr@bwutehzrrhys>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemo500015.china.huawei.com (7.202.194.227)



在 2025/9/10 16:11, Jan Kara 写道:
> On Wed 10-09-25 12:25:16, Yongjian Sun wrote:
>> From: Yongjian Sun <sunyongjian1@huawei.com>
>>
>> After running a stress test combined with fault injection,
>> we performed fsck -a followed by fsck -fn on the filesystem
>> image. During the second pass, fsck -fn reported:
>>
>> Inode 131512, end of extent exceeds allowed value
>> 	(logical block 405, physical block 1180540, len 2)
>>
>> This inode was not in the orphan list. Analysis revealed the
>> following call chain that leads to the inconsistency:
>>
>>                               ext4_da_write_end()
>>                                //does not update i_disksize
>>                               ext4_punch_hole()
>>                                //truncate folio, keep size
>> ext4_page_mkwrite()
>>   ext4_block_page_mkwrite()
>>    ext4_block_write_begin()
>>      ext4_get_block()
>>       //insert written extent without update i_disksize
>> journal commit
>> echo 1 > /sys/block/xxx/device/delete
>>
>> da-write path updates i_size but does not update i_disksize. Then
>> ext4_punch_hole truncates the da-folio yet still leaves i_disksize
>> unchanged(in the ext4_update_disksize_before_punch function, the
>> condition offset + len < size is met). Then ext4_page_mkwrite sees
>> ext4_nonda_switch return 1 and takes the nodioread_nolock path, the
>> folio about to be written has just been punched out, and it’s offset
>> sits beyond the current i_disksize. This may result in a written
>> extent being inserted, but again does not update i_disksize. If the
>> journal gets committed and then the block device is yanked, we might
>> run into this. It should be noted that replacing ext4_punch_hole with
>> ext4_zero_range in the call sequence may also trigger this issue, as
>> neither will update i_disksize under these circumstances.
>>
>> To fix this, we can modify ext4_update_disksize_before_punch to
>> increase i_disksize to min(offset + len) when both i_size and
>> (offset + len) are greater than i_disksize.
>>
>> Signed-off-by: Yongjian Sun <sunyongjian1@huawei.com>
>> ---
>> Changes in v3:
>> - Add a condition to avoid increasing i_disksize and include some comments.
>> - Link to v2: https://lore.kernel.org/all/20250908063355.3149491-1-sunyongjian@huaweicloud.com/
>> Changes in v2:
>> - The modification of i_disksize should be moved into ext4_update_disksize_before_punch,
>>    rather than being done in ext4_page_mkwrite.
>> - Link to v1: https://lore.kernel.org/all/20250731140528.1554917-1-sunyongjian@huaweicloud.com/
> 
> Very nice! Just some language improvements below but otherwise feel free to
> add:
> 
> Reviewed-by: Jan Kara <jack@suse.cz>
> 
>> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
>> index 5b7a15db4953..3df03469d405 100644
>> --- a/fs/ext4/inode.c
>> +++ b/fs/ext4/inode.c
>> @@ -4287,7 +4287,10 @@ int ext4_can_truncate(struct inode *inode)
>>    * We have to make sure i_disksize gets properly updated before we truncate
>>    * page cache due to hole punching or zero range. Otherwise i_disksize update
>>    * can get lost as it may have been postponed to submission of writeback but
>> - * that will never happen after we truncate page cache.
>> + * 1) that will never happen after we truncate page cache to the end of i_size;
>> + * 2) that will get deferred after we truncate page cache in i_size but beyond
>> + *    i_disksize, another concurrent write page fault can allocate written
>> + *    blocks in the range and lead to filesystem inconsistency.
> 
> I'd phrase this:
>   ... that will never happen if we remove the folio containing i_size from
> the page cache. Also if we punch hole within i_size but above i_disksize,
> following ext4_page_mkwrite() may mistakenly allocate written blocks over
> the hole and thus introduce allocated blocks beyond i_disksize which is not
> allowed (e2fsck would complain in case of crash).
> 
> 								Honza
> 
Thank you, Jan! This does make it simpler and easier to understand. I'll 
improve it.

>>    */
>>   int ext4_update_disksize_before_punch(struct inode *inode, loff_t offset,
>>   				      loff_t len)
>> @@ -4298,9 +4301,11 @@ int ext4_update_disksize_before_punch(struct inode *inode, loff_t offset,
>>   	loff_t size = i_size_read(inode);
>>   
>>   	WARN_ON(!inode_is_locked(inode));
>> -	if (offset > size || offset + len < size)
>> +	if (offset > size)
>>   		return 0;
>>   
>> +	if (offset + len < size)
>> +		size = offset + len;
>>   	if (EXT4_I(inode)->i_disksize >= size)
>>   		return 0;
>>   
>> -- 
>> 2.39.2
>>


