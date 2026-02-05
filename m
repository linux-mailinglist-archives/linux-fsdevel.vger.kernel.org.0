Return-Path: <linux-fsdevel+bounces-76370-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MEXQMhRMhGm82QMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76370-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Feb 2026 08:51:48 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 72379EF9BE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Feb 2026 08:51:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 69DB130214F4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Feb 2026 07:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C3E235F8C6;
	Thu,  5 Feb 2026 07:50:46 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B12339866;
	Thu,  5 Feb 2026 07:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770277845; cv=none; b=On2N9DAciDVW/SwuXed+vb5TJQEdqgADWLPwbQXp1ADO5BOPb/OPMP2AMmBAjQVXjo+fA7SZpSVpJt6f5T6GsMX+DFLeizkMmWN4E32ui3c9j8oJeScpOkWAKRteejMvhYaSehrrwRdRIGQuLFlW3DJTtRVoyoBfgjHjxUnCDf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770277845; c=relaxed/simple;
	bh=3OPun5VLdvE4KzjOLUgJ60a4wVQqIQokJeo7x11Pf40=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V2WsYiMJ/iztFFoyQZhlkA419GHRhZx/aef0TvhobNoirOC7emRDcYjIdKo44CY/gc8f1+Sm7oG7TZHpFtfyjDoErLn8AHUv5F5CRogj6QIF1Di9l+q9ozHu2uWq3vsHP6ToBREK1C+7Tx8IgdyRnkzpi6/tGbhhR5lcESs6YdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4f68Wf1h74zYQv1Q;
	Thu,  5 Feb 2026 15:49:50 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 9C7AE4056F;
	Thu,  5 Feb 2026 15:50:40 +0800 (CST)
Received: from [10.174.178.152] (unknown [10.174.178.152])
	by APP4 (Coremail) with SMTP id gCh0CgAXePjOS4RpY6hRGQ--.56480S3;
	Thu, 05 Feb 2026 15:50:40 +0800 (CST)
Message-ID: <1dad3113-7b84-40a0-8c7e-da30ae5cba8e@huaweicloud.com>
Date: Thu, 5 Feb 2026 15:50:38 +0800
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
 djwong@kernel.org, Zhang Yi <yi.zhang@huawei.com>, yizhang089@gmail.com,
 libaokun1@huawei.com, yangerkun@huawei.com, yukuai@fnnas.com
References: <20260203062523.3869120-1-yi.zhang@huawei.com>
 <20260203062523.3869120-4-yi.zhang@huawei.com>
 <jgotl7vzzuzm6dvz5zfgk6haodxvunb4hq556pzh4hqqwvnhxq@lr3jiedhqh7c>
 <b889332b-9c0c-46d1-af61-1f2426c8c305@huaweicloud.com>
 <ocwepmhnw45k5nwwrooe2li2mzavw5ps2ncmowrc32u4zeitgp@gqsz3iee3axr>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <ocwepmhnw45k5nwwrooe2li2mzavw5ps2ncmowrc32u4zeitgp@gqsz3iee3axr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgAXePjOS4RpY6hRGQ--.56480S3
X-Coremail-Antispam: 1UD129KBjvJXoWxuw4fuw13KF13Xr1xWr13twb_yoWxAFWkpF
	W5K3W5Kr4DGryrAwn2vF40qF1Fyw4rJw47JFyagrsrZas0gF1IkFyaqa109Fyjkrs3Jw1j
	vr4jyr93Wa4DZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-76370-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[huaweicloud.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,mit.edu,dilger.ca,linux.ibm.com,gmail.com,infradead.org,kernel.org,huawei.com,fnnas.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yi.zhang@huaweicloud.com,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.987];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huaweicloud.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 72379EF9BE
X-Rspamd-Action: no action

On 2/4/2026 10:18 PM, Jan Kara wrote:
> On Wed 04-02-26 14:42:46, Zhang Yi wrote:
>> On 2/3/2026 5:59 PM, Jan Kara wrote:
>>> On Tue 03-02-26 14:25:03, Zhang Yi wrote:
>>>> Currently, __ext4_block_zero_page_range() is called in the following
>>>> four cases to zero out the data in partial blocks:
>>>>
>>>> 1. Truncate down.
>>>> 2. Truncate up.
>>>> 3. Perform block allocation (e.g., fallocate) or append writes across a
>>>>    range extending beyond the end of the file (EOF).
>>>> 4. Partial block punch hole.
>>>>
>>>> If the default ordered data mode is used, __ext4_block_zero_page_range()
>>>> will write back the zeroed data to the disk through the order mode after
>>>> zeroing out.
>>>>
>>>> Among the cases 1,2 and 3 described above, only case 1 actually requires
>>>> this ordered write. Assuming no one intentionally bypasses the file
>>>> system to write directly to the disk. When performing a truncate down
>>>> operation, ensuring that the data beyond the EOF is zeroed out before
>>>> updating i_disksize is sufficient to prevent old data from being exposed
>>>> when the file is later extended. In other words, as long as the on-disk
>>>> data in case 1 can be properly zeroed out, only the data in memory needs
>>>> to be zeroed out in cases 2 and 3, without requiring ordered data.
>>>
>>> Hum, I'm not sure this is correct. The tail block of the file is not
>>> necessarily zeroed out beyond EOF (as mmap writes can race with page
>>> writeback and modify the tail block contents beyond EOF before we really
>>> submit it to the device). Thus after this commit if you truncate up, just
>>> zero out the newly exposed contents in the page cache and dirty it, then
>>> the transaction with the i_disksize update commits (I see nothing
>>> preventing it) and then you crash, you can observe file with the new size
>>> but non-zero content in the newly exposed area. Am I missing something?
>>>
>>
>> Well, I think you are right! I missed the mmap write race condition that
>> happens during the writeback submitting I/O. Thank you a lot for pointing
>> this out. I thought of two possible solutions:
>>
>> 1. We also add explicit writeback operations to the truncate-up and
>>    post-EOF append writes. This solution is the most straightforward but
>>    may cause some performance overhead. However, since at most only one
>>    block is written, the impact is likely limited. Additionally, I
>>    observed that the implementation of the XFS file system also adopts a
>>    similar approach in its truncate up and down operation. (But it is
>>    somewhat strange that XFS also appears to have the same issue with
>>    post-EOF append writes; it only zero out the partial block in
>>    xfs_file_write_checks(), but it neither explicitly writeback zeroed
>>    data nor employs any other mechanism to ensure that the zero data
>>    writebacks before the metadata is written to disk.)
>>
>> 2. Resolve this race condition, ensure that there are no non-zero data
>>    in the post-EOF partial blocks on the disk. I observed that after the
>>    writeback holds the folio lock and calls folio_clear_dirty_for_io(),
>>    mmap writes will re-trigger the page fault. Perhaps we can filter out
>>    the EOF folio based on i_size in ext4_page_mkwrite(),
>>    block_page_mkwrite() and iomap_page_mkwrite(), and then call
>>    folio_wait_writeback() to wait for this partial folio writeback to
>>    complete. This seems can break the race condition without introducing
>>    too much overhead (no?).
>>
>> What do you think? Any other suggestions are also welcome.
> 
> Hum, I like the option 2 because IMO non-zero data beyond EOF is a
> corner-case quirk which unnecessarily complicates rather common paths. But
> I'm not sure we can easily get rid of it. It can happen for example when
> you do appending write inside a block. The page is written back but before
> the transaction with i_disksize update commits we crash. Then again we have
> a non-zero content inside the block beyond EOF.

Yes, indeed. From this perspective, it seems difficult to avoid non-zero
content within the block beyond the EOF.

> 
> So the only realistic option I see is to ensure tail of the block gets
> zeroed on disk before the transaction with i_disksize update commits in the
> cases of truncate up or write beyond EOF. data=ordered mode machinery is an
> asynchronous way how to achieve this. We could also just synchronously
> writeback the block where needed but the latency hit of such operation is
> going to be significant so I'm quite sure some workload somewhere will
> notice although the truncate up / write beyond EOF operations triggering this
> are not too common.

Yes, I agree.

> So why do you need to get rid of these data=ordered
> mode usages? I guess because with iomap keeping our transaction handle ->
> folio lock ordering is complicated? Last time I looked it seemed still
> possible to keep it though.
> 

Yes, that's one reason. There's another reason is that we also need to
implement partial folio submits for iomap.

When the journal process is waiting for a folio to be written back
(which contains an ordered block), and the folio also contains unmapped
blocks with a block size smaller than the folio size, if the regular
writeback process has already started committing this folio (and set the
writeback flag), then a deadlock may occur while mapping the remaining
unmapped blocks. This is because the writeback flag is cleared only
after the entire folio are processed and committed. If we want to support
partial folio submit for iomap, we need to be careful to prevent adding
additional performance overhead in the case of severe fragmentation.

Therefore, this aspect of the logic is complicated and subtle. As we
discussed in patch 0, if we can avoid using the data=ordered mode in
append write and online defrag, then this would be the only remaining
corner case. I'm not sure if it is worth implementing this and adjusting
the lock ordering.

> Another possibility would be to just *submit* the write synchronously and
> use data=ordered mode machinery only to wait for IO to complete before the
> transaction commits. That way it should be safe to start a transaction
> while holding folio lock and thus the iomap conversion would be easier.
> 
> 								Honza

IIUC, this solution seems can avoid adjusting the lock ordering, but partial
folio submission still needs to be implemented, is my understanding right?
This is because although we have already submitted this zeroed partial EOF
block, when the journal process is waiting for this folio, this folio is
being written back, and there are other blocks in this folio that need to be
mapped.

Cheers,
Yi.


