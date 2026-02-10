Return-Path: <linux-fsdevel+bounces-76847-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0BEPGXVVi2k1UAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76847-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 16:57:41 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C97B311CD65
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 16:57:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0D52430498F2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 15:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81D9738734A;
	Tue, 10 Feb 2026 15:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="InO6h68u"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA048385EC5
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Feb 2026 15:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770739037; cv=none; b=Ttcv+KhznI5682y/FUL0Gu9wAXTIvnD3+LigFqfmf88Kl9w4bavdoOn/WyNJFu5llBPVVYbVJ6dsWQlZa9Cq3ou4wkazut2cvp5BJCqiClxE4km3ORna6b8xZF+BUzh4PfynW1EeUChx1cRWrkDKywFQWKgD+zQscuEjErmllvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770739037; c=relaxed/simple;
	bh=ZjnvTuiYbrA1uIqajO+7i2psmuxO7DSmNzcrr8AuSt8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HvkCByba1IFxonKdpGTbLGFpNpqYRlaBC/lcQnn26NWXHbd5uynvwR6e8ZYXjhvwOi4XJFHYUpSVPoeA+yBoXLuUByqOWUmsDu38y2kP2Uq6l7aU40hChaf2wWLIjuJEhIGOrUPHZlAkpl+yM0ekd7kBEe3rtFUkj95Ooq+8UBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=InO6h68u; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-823075fed75so3416102b3a.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Feb 2026 07:57:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770739035; x=1771343835; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bVZRNpm49w3gc4RCu4RyEyFBgJ9/rzWmQll910jJSYo=;
        b=InO6h68uWUDRBnUYwcDbR8iSmyskLWlyz5hkOJUrdBa2BWgXXeNAIDrnd4V92UfFQZ
         JGmrdf4RoAyzERFL0pUnFEBnOUE1XTfDKF0SnlIi52lcg4HBrqzN1gAP2Tg/aB0glI7m
         yLTJe+1r5fQHIowahCj/XkdWwGPBBuQJ0H9KXHxHRBEgvBXI3wZrL1+6Q/+nKl/E1ZoF
         JgZiqEOqTflHTy26jDt5hZYQC8udOY9Ib44zpi5pZRCIkoTnHHYT4gNW4qSTF6BAWY/J
         taq4eR1+4hXSGSN/esWXzuSbNL+KsLMTnVotyO1fYEZeiMkZFYXH5ad7JnQdouPijuhe
         b7fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770739035; x=1771343835;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bVZRNpm49w3gc4RCu4RyEyFBgJ9/rzWmQll910jJSYo=;
        b=fx3BHFaNafZiyghZ5LOqZSkVVuopcSTrhy7T50R4u6KJnZZCRF/2wHSoeXBmSQuPnG
         Dr9inwVd1Imf4cUg36Our7wuJIboWOqy+l46Puj5navoSLpnyl9QqA32c6DkAomct5f2
         Pn6l4iDiUVvxkCd4eKDowIt8IhRw9vLEDOMO9HiYEq0aEch8QYYDsYdalZajBApsVJTj
         rEhyhSqlm1/P+lMo7FTujI4MyV2MxZtAnx2gmy0OQio2DX7uvJNHfQnUslqQXmmRnaWQ
         jc/Npb1IqX8Iqe8nO7LnwprQr7fTr6sw+JeP2NxgY+ltE4tVkEa5r5F+AZ/dXdl0L82u
         aH7w==
X-Forwarded-Encrypted: i=1; AJvYcCWiBll8FhkbQRyRZcZahnVTKQMM6p7ddXv32Ro9hxgN07CDXkr+tKrFw+xbeFlGEWlXF1BfTaM6W1PQ6s7n@vger.kernel.org
X-Gm-Message-State: AOJu0YwlNTvDsUQHG+titbBX/BWeMJ7dpYEwPreQ16sE03VQxF4ZiRfP
	qbfb+7OrLODmKuw1G9c2e2yuxcFH849G+f/D4ZzMdDrTUWSjxqhSkZUl
X-Gm-Gg: AZuq6aK8wvpDiGPaq5aK4/d50ymbEWxi9pDWBCK8fEvP59f93EBagV2zJ/63yOhw4h3
	xMaa1ORuBIEEdlzdn7trhyrnLqmcLnmnOCl1CSFxG8c2oBhkxKDBRrSRxHo4ikT8QDtXyTwBQES
	9FBkCGAxuWwD4QeqeBtAuJGOSG6sB9fBYWr13mPMJIp7r/i4WgjGxHqRPoDcNNBQ02jNt3n4uEk
	H4i2XPi36A7FOuLJWNQxApSY5ArxailPj26EY9j9oDXtG6jZ9XO6LW2TPwB3KTpd8oQcCdd8kEj
	kalSQ4o9vKA4vIqRimL8XFLujByBdQmPzAprIpbX8umjuHDMHDz8DQf6Y5UX7tDPyZRvr3ST7Ow
	lMrKA4mUto32lS5T4Vzriun+jFo/QSBRVRdV6y/B/Tw7a3QQWBdOs1WeZkFBFSf1HvdhtNQyaR5
	Nv2Mw4lq8Sa2NuuRFN839cKTg4998VQWoUb0ZRDDzvOKrGXMAwNnNWgbMDFx8WvUnf26kRE6Xm6
	A==
X-Received: by 2002:a05:6a00:399b:b0:81f:4708:b46e with SMTP id d2e1a72fcca58-824877cafd2mr2557597b3a.20.1770739035023;
        Tue, 10 Feb 2026 07:57:15 -0800 (PST)
Received: from ?IPV6:240e:390:a90:6d21:e579:6116:b665:1484? ([240e:390:a90:6d21:e579:6116:b665:1484])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8244168fdf5sm14013049b3a.17.2026.02.10.07.57.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Feb 2026 07:57:14 -0800 (PST)
Message-ID: <04b0a510-0a97-464f-a6d3-8410fff9243d@gmail.com>
Date: Tue, 10 Feb 2026 23:57:03 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next v2 03/22] ext4: only order data when partially block
 truncating down
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>, Zhang Yi <yi.zhang@huawei.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
 jack@suse.cz, ritesh.list@gmail.com, hch@infradead.org, djwong@kernel.org,
 yi.zhang@huaweicloud.com, libaokun1@huawei.com, yangerkun@huawei.com,
 yukuai@fnnas.com
References: <20260203062523.3869120-1-yi.zhang@huawei.com>
 <20260203062523.3869120-4-yi.zhang@huawei.com>
 <aYrYwhO5LvIYbxWg@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
Content-Language: en-US
From: Zhang Yi <yizhang089@gmail.com>
In-Reply-To: <aYrYwhO5LvIYbxWg@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-76847-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,mit.edu,dilger.ca,suse.cz,gmail.com,infradead.org,kernel.org,huaweicloud.com,huawei.com,fnnas.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yizhang089@gmail.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C97B311CD65
X-Rspamd-Action: no action

On 2/10/2026 3:05 PM, Ojaswin Mujoo wrote:
> On Tue, Feb 03, 2026 at 02:25:03PM +0800, Zhang Yi wrote:
>> Currently, __ext4_block_zero_page_range() is called in the following
>> four cases to zero out the data in partial blocks:
>>
>> 1. Truncate down.
>> 2. Truncate up.
>> 3. Perform block allocation (e.g., fallocate) or append writes across a
>>     range extending beyond the end of the file (EOF).
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
>>
>> Case 4 does not require ordered data because the entire punch hole
>> operation does not provide atomicity guarantees. Therefore, it's safe to
>> move the ordered data operation from __ext4_block_zero_page_range() to
>> ext4_truncate().
>>
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
> 
> Hi Yi,
> 
> Took me quite some time to understand what we are doing here, I'll
> just add my understanding here to confirm/document :)

Hi, Ojaswin!

Thank you for review and test this series.

> 
> So your argument is that currently all paths that change the i_size take
> care of zeroing the (newsize, eof block boundary) before i_size change
> is seen by users:
>    - dio does it in iomap_dio_bio_iter if IOMAP_UNWRITTEN (true for first allocation)
> 	- buffered IO/mmap write does it in ext4_da_write_begin() ->
> 		ext4_block_write_begin() for buffer_new (true for first allocation)
> 	- falloc doesn't zero the new eof block but it allocates an unwrit
> 		extent so no stale data issue. When an allocation happens from the
> 		above 2 methods then we anyways will zero it.

These two zeroing operations mentioned above are mainly used to 
initialize newly allocated blocks, which is not the main focus of this 
discussion.

The focus of this discussion is how to clear the portions of allocated 
blocks that extend beyond the EOF.

> 	- truncate down also takes care of this via ext4_truncate() ->
> 		ext4_block_truncate_page()
> 
> Now, parallely there are also codepaths that say grow the i_size but
> then also zero the (old_size, block boundary) range before the i_size
> commits. This is so that they want to be sure the newly visible range
> doesn't expose stale data.
> For example:
>    - truncate up from 2kb to 8kb will zero (2kb,4kb) via ext4_block_truncate_page()
>    - with i_size = 2kb, buffered IO at 6kb would zero 2kb,4kb in ext4_da_write_end()

Yes, you are right.

>    - I'm unable to see if/where we do it via dio path.

I don't see it too, so I think this is also a problem.

> 
> You originally proposed that we can remove the logic to zeroout
> (old_size, block_boundary) in data=ordered fashion, ie we don't need to
> trigger the zeroout IO before the i_size change commits, we can just zero the
> range in memory because we would have already zeroed them earlier when
> we had allocated at old_isize, or truncated down to old_isize.

Yes.

> 
> To this Jan pointed out that although we take care to zeroout (new_size,
> block_boundary) its not enough because we could still end up with data
> past eof:
> 
> 1. race of buffered write vs mmap write past eof. i_size = 2kb,
>     we write (2kb, 3kb).
> 2. The write goes through but we crash before i_size=3kb txn can commit.
>     Again we have data past 2kb ie the eof block.
> 

Yes.

> Now, Im still looking into this part but the reason we want to get rid of
> this data=ordered IO is so that we don't trigger a writeback due to
> journal commit which tries to acquire folio_lock of a folio already
> locked by iomap.

Yes, and iomap will start a new transaction under the folio lock, which 
may also wait the current committing transaction to finish.

> However we will now try an alternate way to get past
> this.
> 
> Is my understanding correct?

Yes.

Cheers,
Yi.

> 
> Regards,
> ojaswin
> 
> PS: -g auto tests are passing (no regressions) with 64k and 4k bs on
> powerpc 64k pagesize box so thats nice :D
> 
>>
>> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
>> ---
>>   fs/ext4/inode.c | 32 +++++++++++++++++++-------------
>>   1 file changed, 19 insertions(+), 13 deletions(-)
>>
>> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
>> index f856ea015263..20b60abcf777 100644
>> --- a/fs/ext4/inode.c
>> +++ b/fs/ext4/inode.c
>> @@ -4106,19 +4106,10 @@ static int __ext4_block_zero_page_range(handle_t *handle,
>>   	folio_zero_range(folio, offset, length);
>>   	BUFFER_TRACE(bh, "zeroed end of block");
>>   
>> -	if (ext4_should_journal_data(inode)) {
>> +	if (ext4_should_journal_data(inode))
>>   		err = ext4_dirty_journalled_data(handle, bh);
>> -	} else {
>> +	else
>>   		mark_buffer_dirty(bh);
>> -		/*
>> -		 * Only the written block requires ordered data to prevent
>> -		 * exposing stale data.
>> -		 */
>> -		if (!buffer_unwritten(bh) && !buffer_delay(bh) &&
>> -		    ext4_should_order_data(inode))
>> -			err = ext4_jbd2_inode_add_write(handle, inode, from,
>> -					length);
>> -	}
>>   	if (!err && did_zero)
>>   		*did_zero = true;
>>   
>> @@ -4578,8 +4569,23 @@ int ext4_truncate(struct inode *inode)
>>   		goto out_trace;
>>   	}
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
>>   	/*
>>   	 * We add the inode to the orphan list, so that if this
>> -- 
>> 2.52.0
>>


