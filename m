Return-Path: <linux-fsdevel+bounces-60660-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DF5AB4AC10
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Sep 2025 13:32:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 470984E3CB1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Sep 2025 11:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4784B326D67;
	Tue,  9 Sep 2025 11:31:02 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C52322DB6;
	Tue,  9 Sep 2025 11:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757417461; cv=none; b=ow5kv11TnwU7qLKx/6ASZcJLrijb9cuYU8rzPgg4XNOuVQnp1uV6mGmjJUk13TF08c2fd4l7SNga6IMjqD5eSZSx3Dk492PKeB7xwfsifvZCM8icrT/p3XsrW52PepO3n/CrYM4QmObu8YchqqLOOztxYfuvOEjFDK0a0mzSyug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757417461; c=relaxed/simple;
	bh=7OCyzakwEIIy7WQxVykqQp22fQ35IPTmyJgB87MBafo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=s/V8YrwJWQ9Cg+vSnyJZyuhrcf78c5sn4QTQjgjxzEMyJJgb2cXh/cgN1sHRkLJZNqRas+Yaye6rqHUFAqju6bk0WlABNxHYgehzXJSJ84uim8mY1j6nzm5NYqYS7Dy5FTFlSAu8aaLGOIbOzm+m7x69AGplaDwWV4nY53HuDm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4cLhSS4nlfztTS2;
	Tue,  9 Sep 2025 19:30:00 +0800 (CST)
Received: from kwepemo500015.china.huawei.com (unknown [7.202.194.227])
	by mail.maildlp.com (Postfix) with ESMTPS id ECCED1401F4;
	Tue,  9 Sep 2025 19:30:55 +0800 (CST)
Received: from [10.174.179.92] (10.174.179.92) by
 kwepemo500015.china.huawei.com (7.202.194.227) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 9 Sep 2025 19:30:55 +0800
Message-ID: <a52708a8-cb3f-41bb-b73c-7d19f4830709@huawei.com>
Date: Tue, 9 Sep 2025 19:30:43 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ext4: increase i_disksize to offset + len in
 ext4_update_disksize_before_punch()
To: Zhang Yi <yi.zhang@huaweicloud.com>, <linux-ext4@vger.kernel.org>
CC: <linux-fsdevel@vger.kernel.org>, <tytso@mit.edu>, <jack@suse.cz>,
	<yangerkun@huawei.com>, <libaokun1@huawei.com>, <chengzhihao1@huawei.com>
References: <20250908063355.3149491-1-sunyongjian@huaweicloud.com>
 <ce8aab6c-fcea-4692-ad75-e51fa9448276@huaweicloud.com>
From: Sun Yongjian <sunyongjian1@huawei.com>
In-Reply-To: <ce8aab6c-fcea-4692-ad75-e51fa9448276@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemo500015.china.huawei.com (7.202.194.227)



在 2025/9/8 15:58, Zhang Yi 写道:
> On 9/8/2025 2:33 PM, Yongjian Sun wrote:
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
>> To fix this, we can modify ext4_update_disksize_before_punch to always
>> increase i_disksize to offset + len.
>>
>> Signed-off-by: Yongjian Sun <sunyongjian1@huawei.com>
>> ---
>> Changes in v2:
>> - The modification of i_disksize should be moved into ext4_update_disksize_before_punch,
>>    rather than being done in ext4_page_mkwrite.
>> - Link to v1: https://lore.kernel.org/all/20250731140528.1554917-1-sunyongjian@huaweicloud.com/
>> ---
>>   fs/ext4/inode.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
>> index 5b7a15db4953..2b1ed729a0f0 100644
>> --- a/fs/ext4/inode.c
>> +++ b/fs/ext4/inode.c
>> @@ -4298,7 +4298,7 @@ int ext4_update_disksize_before_punch(struct inode *inode, loff_t offset,
>>   	loff_t size = i_size_read(inode);
>>   
>>   	WARN_ON(!inode_is_locked(inode));
>> -	if (offset > size || offset + len < size)
>> +	if (offset > size)
>>   		return 0;
>>   
>>   	if (EXT4_I(inode)->i_disksize >= size)
> 
> Hi, Yongjian!
> 
> I think this check also needs to be updated; otherwise, the limitation
> will be too lenient. If the end position of the punch hole
> is <= i_disksize, we should also avoid updating the i_disksize (this is
> a more general use case). Besides, I'd suggested updating the comment
> of ext4_update_disksize_before_punch() together.
> 
> Regards,
> Yi.
> 

Hi!

Thanks for the review! I agree with that and will send out the v3 ASAP ^_^

Cheers!

>> @@ -4307,7 +4307,7 @@ int ext4_update_disksize_before_punch(struct inode *inode, loff_t offset,
>>   	handle = ext4_journal_start(inode, EXT4_HT_MISC, 1);
>>   	if (IS_ERR(handle))
>>   		return PTR_ERR(handle);
>> -	ext4_update_i_disksize(inode, size);
>> +	ext4_update_i_disksize(inode, min_t(loff_t, size, offset + len));
>>   	ret = ext4_mark_inode_dirty(handle, inode);
>>   	ext4_journal_stop(handle);
>>   
> 


