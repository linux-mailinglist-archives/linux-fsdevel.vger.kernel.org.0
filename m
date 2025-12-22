Return-Path: <linux-fsdevel+bounces-71823-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E8416CD5CC8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Dec 2025 12:24:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 25AE330572F1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Dec 2025 11:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9201315D5A;
	Mon, 22 Dec 2025 11:23:07 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DA3B312832;
	Mon, 22 Dec 2025 11:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766402587; cv=none; b=gz0vsoezC2GCn6C4JL20wdzwMWB4u6K/wj+xK8O87xjZ2bCK+6F0QFSSVFxBXRxHbtt355toD+vrCR+51aE1VZmFHD4LbEGmpmID9+A4QC912jvc33DMNKluxcoZi1VZW7zF5yjjXfopVq2GwXCFuvlzI5pOlxLq5LCTNdFe9+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766402587; c=relaxed/simple;
	bh=rre3/0sOTYhp8REZM3GPUCzJMH2TP3dGJrlNsI3p2pY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XlTl14tepcd9RLzb5evrSA6jlefX7dbKIg1MzudUHT4zr1161a0ZsqdylBStqNw652XhXUom2vLhIuCC1/nyq2pGYXDDjsDPkFXpwYP6tG88x16QQS2xz2qd97XoqnSnoe0+wmg/P4GVmcrozr5IdlBDghd9tDcJNG+/c2YS1Mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4dZbMj5BRlzYQv95;
	Mon, 22 Dec 2025 19:22:25 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id DC7AD40577;
	Mon, 22 Dec 2025 19:23:00 +0800 (CST)
Received: from [10.174.178.152] (unknown [10.174.178.152])
	by APP4 (Coremail) with SMTP id gCh0CgAHZ_cHKklpCUhVBA--.46821S3;
	Mon, 22 Dec 2025 19:22:48 +0800 (CST)
Message-ID: <482d8078-995f-404f-83cb-310352308bf5@huaweicloud.com>
Date: Mon, 22 Dec 2025 19:22:47 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ext4: don't order data when zeroing unwritten or delayed
 block
To: Jan Kara <jack@suse.cz>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
 ojaswin@linux.ibm.com, ritesh.list@gmail.com, yi.zhang@huawei.com,
 yizhang089@gmail.com, libaokun1@huawei.com, yangerkun@huawei.com,
 yukuai@fnnas.com
References: <20251222013136.2658907-1-yi.zhang@huaweicloud.com>
 <iih22kuucq6s2pdkhdcdosaaclfapmpanuikbvvzw4zf45pqw2@23kqz7drc6pr>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <iih22kuucq6s2pdkhdcdosaaclfapmpanuikbvvzw4zf45pqw2@23kqz7drc6pr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgAHZ_cHKklpCUhVBA--.46821S3
X-Coremail-Antispam: 1UD129KBjvJXoW7AF13Ww1UuFWfGw1kAr47Arb_yoW8uFW3pa
	4fK3W0kr4kG34j9a4IvF1xXryjya18Gr4xGF4rGrW8Z343XF1a9Fn29Fy093W2yrWxG3WY
	qF4UWa4293ZIy3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AF
	wI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUOB
	MKDUUUU
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 12/22/2025 6:48 PM, Jan Kara wrote:
> On Mon 22-12-25 09:31:36, Zhang Yi wrote:
>> From: Zhang Yi <yi.zhang@huawei.com>
>>
>> When zeroing out a written partial block, it is necessary to order the
>> data to prevent exposing stale data on disk. However, if the buffer is
>> unwritten or delayed, it is not allocated as written, so ordering the
>> data is not required. This can prevent strange and unnecessary ordered
>> writes when appending data across a region within a block.
>>
>> Assume we have a 2K unwritten file on a filesystem with 4K blocksize,
>> and buffered write from 3K to 4K. Before this patch,
>> __ext4_block_zero_page_range() would add the range [2k,3k) to the
>> ordered range, and then the JBD2 commit process would write back this
>> block. However, it does nothing since the block is not mapped, this
> 							^^^ by this you
> mean that the block is unwritten, don't you?
> 

Yes, that is exactly what I wanted to express. The term "not mapped" might
indeed be unclear and prone to misunderstanding. I will revise it to "the
block is not mapped as written" in v2.

Thanks,
Yi.

>> folio will be redirtied and written back agian through the normal write
>> back process.
>>
>> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> 
> The patch looks good. Feel free to add:
> 
> Reviewed-by: Jan Kara <jack@suse.cz>
> 
> 								Honza
> 
>> ---
>>  fs/ext4/inode.c | 8 ++++++--
>>  1 file changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
>> index fa579e857baf..fc16a89903b9 100644
>> --- a/fs/ext4/inode.c
>> +++ b/fs/ext4/inode.c
>> @@ -4104,9 +4104,13 @@ static int __ext4_block_zero_page_range(handle_t *handle,
>>  	if (ext4_should_journal_data(inode)) {
>>  		err = ext4_dirty_journalled_data(handle, bh);
>>  	} else {
>> -		err = 0;
>>  		mark_buffer_dirty(bh);
>> -		if (ext4_should_order_data(inode))
>> +		/*
>> +		 * Only the written block requires ordered data to prevent
>> +		 * exposing stale data.
>> +		 */
>> +		if (!buffer_unwritten(bh) && !buffer_delay(bh) &&
>> +		    ext4_should_order_data(inode))
>>  			err = ext4_jbd2_inode_add_write(handle, inode, from,
>>  					length);
>>  	}
>> -- 
>> 2.52.0
>>


