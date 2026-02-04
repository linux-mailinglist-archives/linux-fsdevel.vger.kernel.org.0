Return-Path: <linux-fsdevel+bounces-76259-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uLbfH3nqgmnqewMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76259-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Feb 2026 07:43:05 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A2BFE25F3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Feb 2026 07:43:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 68D93303741C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Feb 2026 06:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0492A385511;
	Wed,  4 Feb 2026 06:42:53 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F173C3806D7;
	Wed,  4 Feb 2026 06:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770187372; cv=none; b=HOAktoVyL6RfyIgOJc3NWVnFMLQ7q78fVzWj2w67BjLfSfhQ77YOowPvqkGhWVY0z++ZoIeaTrYEmL14HJXqzS/eQXS0ASwfVyxClfZQl/Nt2IwsYGofjUS8ceB4iGrEMS25F0ckRdEUC2dceV620mSG9jtlObl8CL8uZzkY7Q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770187372; c=relaxed/simple;
	bh=vJF1vmoXVFqMWekmVYwxfYKGr/9SW31RmEZAGBIVgmg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Btyhh8ePdzfMAqAW3by9JCP2EI98F5JNxRJaiM9Czr74h4auWpMyj2Y8VjJuIrDdKkpPlM5NFI2VQp1ytO/+yAPTIQbbf2wQuVe3aZEVDQgA7v4cHqwOO1YkqIGlSk91MAhiYRmArDhI3Gc34bqBb/7euS3pqxv8nCvr7j1Jlic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4f5W4K4WG3zKHMZy;
	Wed,  4 Feb 2026 14:42:25 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 7DEAB4058D;
	Wed,  4 Feb 2026 14:42:48 +0800 (CST)
Received: from [10.174.178.152] (unknown [10.174.178.152])
	by APP4 (Coremail) with SMTP id gCh0CgC3ZPVm6oJpP1HUGA--.12916S3;
	Wed, 04 Feb 2026 14:42:48 +0800 (CST)
Message-ID: <b889332b-9c0c-46d1-af61-1f2426c8c305@huaweicloud.com>
Date: Wed, 4 Feb 2026 14:42:46 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next v2 03/22] ext4: only order data when partially block
 truncating down
To: Jan Kara <jack@suse.cz>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
 ojaswin@linux.ibm.com, ritesh.list@gmail.com, hch@infradead.org,
 djwong@kernel.org, Zhang Yi <yi.zhang@huawei.com>, yi.zhang@huaweicloud.com,
 yizhang089@gmail.com, libaokun1@huawei.com, yangerkun@huawei.com,
 yukuai@fnnas.com
References: <20260203062523.3869120-1-yi.zhang@huawei.com>
 <20260203062523.3869120-4-yi.zhang@huawei.com>
 <jgotl7vzzuzm6dvz5zfgk6haodxvunb4hq556pzh4hqqwvnhxq@lr3jiedhqh7c>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <jgotl7vzzuzm6dvz5zfgk6haodxvunb4hq556pzh4hqqwvnhxq@lr3jiedhqh7c>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgC3ZPVm6oJpP1HUGA--.12916S3
X-Coremail-Antispam: 1UD129KBjvJXoW3AFyrtrWkZFy3ZFy8uF1kuFg_yoWxJF4fpF
	y3K3WxGr1DG34UCwn7ZFn7XF1Yv3WrCr4xJFW3Ww4vv3s8Wr1IkFy3Kay0kFWUKr43Gw40
	vF4jyr97W3WqyaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvE14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
	0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7
	v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF
	1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIx
	AIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI
	42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWI
	evJa73UjIFyTuYvjfUOv38UUUUU
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-76259-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[huaweicloud.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,mit.edu,dilger.ca,linux.ibm.com,gmail.com,infradead.org,kernel.org,huawei.com,huaweicloud.com,fnnas.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yi.zhang@huaweicloud.com,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.988];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,huaweicloud.com:mid]
X-Rspamd-Queue-Id: 2A2BFE25F3
X-Rspamd-Action: no action

Hi, Jan!

On 2/3/2026 5:59 PM, Jan Kara wrote:
> On Tue 03-02-26 14:25:03, Zhang Yi wrote:
>> Currently, __ext4_block_zero_page_range() is called in the following
>> four cases to zero out the data in partial blocks:
>>
>> 1. Truncate down.
>> 2. Truncate up.
>> 3. Perform block allocation (e.g., fallocate) or append writes across a
>>    range extending beyond the end of the file (EOF).
>> 4. Partial block punch hole.
>>
>> If the default ordered data mode is used, __ext4_block_zero_page_range()
>> will write back the zeroed data to the disk through the order mode after
>> zeroing out.
>>
>> Among the cases 1,2 and 3 described above, only case 1 actually requires
>> this ordered write. Assuming no one intentionally bypasses the file
>> system to write directly to the disk. When performing a truncate down
>> operation, ensuring that the data beyond the EOF is zeroed out before
>> updating i_disksize is sufficient to prevent old data from being exposed
>> when the file is later extended. In other words, as long as the on-disk
>> data in case 1 can be properly zeroed out, only the data in memory needs
>> to be zeroed out in cases 2 and 3, without requiring ordered data.
> 
> Hum, I'm not sure this is correct. The tail block of the file is not
> necessarily zeroed out beyond EOF (as mmap writes can race with page
> writeback and modify the tail block contents beyond EOF before we really
> submit it to the device). Thus after this commit if you truncate up, just
> zero out the newly exposed contents in the page cache and dirty it, then
> the transaction with the i_disksize update commits (I see nothing
> preventing it) and then you crash, you can observe file with the new size
> but non-zero content in the newly exposed area. Am I missing something?
> 

Well, I think you are right! I missed the mmap write race condition that
happens during the writeback submitting I/O. Thank you a lot for pointing
this out. I thought of two possible solutions:

1. We also add explicit writeback operations to the truncate-up and
   post-EOF append writes. This solution is the most straightforward but
   may cause some performance overhead. However, since at most only one
   block is written, the impact is likely limited. Additionally, I
   observed that the implementation of the XFS file system also adopts a
   similar approach in its truncate up and down operation. (But it is
   somewhat strange that XFS also appears to have the same issue with
   post-EOF append writes; it only zero out the partial block in
   xfs_file_write_checks(), but it neither explicitly writeback zeroed
   data nor employs any other mechanism to ensure that the zero data
   writebacks before the metadata is written to disk.)

2. Resolve this race condition, ensure that there are no non-zero data
   in the post-EOF partial blocks on the disk. I observed that after the
   writeback holds the folio lock and calls folio_clear_dirty_for_io(),
   mmap writes will re-trigger the page fault. Perhaps we can filter out
   the EOF folio based on i_size in ext4_page_mkwrite(),
   block_page_mkwrite() and iomap_page_mkwrite(), and then call
   folio_wait_writeback() to wait for this partial folio writeback to
   complete. This seems can break the race condition without introducing
   too much overhead (no?).

What do you think? Any other suggestions are also welcome.

Thanks,
Yi.

>> Case 4 does not require ordered data because the entire punch hole
>> operation does not provide atomicity guarantees. Therefore, it's safe to
>> move the ordered data operation from __ext4_block_zero_page_range() to
>> ext4_truncate().
> 
> I agree hole punching can already expose intermediate results in case of
> crash so there removing the ordered mode handling is safe.
> 
> 								Honza
> 
>> It should be noted that after this change, we can only determine whether
>> to perform ordered data operations based on whether the target block has
>> been zeroed, rather than on the state of the buffer head. Consequently,
>> unnecessary ordered data operations may occur when truncating an
>> unwritten dirty block. However, this scenario is relatively rare, so the
>> overall impact is minimal.
>>
>> This is prepared for the conversion to the iomap infrastructure since it
>> doesn't use ordered data mode and requires active writeback, which
>> reduces the complexity of the conversion.
>>
>> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
>> ---
>>  fs/ext4/inode.c | 32 +++++++++++++++++++-------------
>>  1 file changed, 19 insertions(+), 13 deletions(-)
>>
>> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
>> index f856ea015263..20b60abcf777 100644
>> --- a/fs/ext4/inode.c
>> +++ b/fs/ext4/inode.c
>> @@ -4106,19 +4106,10 @@ static int __ext4_block_zero_page_range(handle_t *handle,
>>  	folio_zero_range(folio, offset, length);
>>  	BUFFER_TRACE(bh, "zeroed end of block");
>>  
>> -	if (ext4_should_journal_data(inode)) {
>> +	if (ext4_should_journal_data(inode))
>>  		err = ext4_dirty_journalled_data(handle, bh);
>> -	} else {
>> +	else
>>  		mark_buffer_dirty(bh);
>> -		/*
>> -		 * Only the written block requires ordered data to prevent
>> -		 * exposing stale data.
>> -		 */
>> -		if (!buffer_unwritten(bh) && !buffer_delay(bh) &&
>> -		    ext4_should_order_data(inode))
>> -			err = ext4_jbd2_inode_add_write(handle, inode, from,
>> -					length);
>> -	}
>>  	if (!err && did_zero)
>>  		*did_zero = true;
>>  
>> @@ -4578,8 +4569,23 @@ int ext4_truncate(struct inode *inode)
>>  		goto out_trace;
>>  	}
>>  
>> -	if (inode->i_size & (inode->i_sb->s_blocksize - 1))
>> -		ext4_block_truncate_page(handle, mapping, inode->i_size);
>> +	if (inode->i_size & (inode->i_sb->s_blocksize - 1)) {
>> +		unsigned int zero_len;
>> +
>> +		zero_len = ext4_block_truncate_page(handle, mapping,
>> +						    inode->i_size);
>> +		if (zero_len < 0) {
>> +			err = zero_len;
>> +			goto out_stop;
>> +		}
>> +		if (zero_len && !IS_DAX(inode) &&
>> +		    ext4_should_order_data(inode)) {
>> +			err = ext4_jbd2_inode_add_write(handle, inode,
>> +					inode->i_size, zero_len);
>> +			if (err)
>> +				goto out_stop;
>> +		}
>> +	}
>>  
>>  	/*
>>  	 * We add the inode to the orphan list, so that if this
>> -- 
>> 2.52.0
>>


