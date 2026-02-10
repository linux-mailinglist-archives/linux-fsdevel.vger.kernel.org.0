Return-Path: <linux-fsdevel+bounces-76838-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IGWGK5wei2n7QAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76838-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 13:03:40 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D11611A877
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 13:03:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D902C3045234
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 12:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EA6F328613;
	Tue, 10 Feb 2026 12:03:06 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 191F131A556;
	Tue, 10 Feb 2026 12:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770724986; cv=none; b=WYq6kQ5GsSTpho/kdLHSNDpQ/oA9dfxZqEtbFnFraCKm2v6EwFgUKhLHQ8CXy4p0VIBU7rfonGXSOXBQYBmZ1x+vRbKqRcnyoOglwkRXlGaFYKOSdzPsOQ0wZWjiip1HKR9CcyDUZJxQHwC7qEIm3lmhbRHSR35YPzkF3TdI9Mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770724986; c=relaxed/simple;
	bh=F9Yl6wa0zMf5ZkeobHYoTCPMvPU+6N/7LiFs2T71+xg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UfzMJZIEDqrakdHWVsJ97uFdzECBIMxd5rbf/jc8rqsjo6Hgn/42ggf/DI0VtLHjCNMy3R7HbhL00EGu06s97ApwmUzhUBEkDd5ZMXzXOKMjewzx8qXTgOsTqIJtzafny1Q/jVgkMmjGMI0K/AYyboUpEgCSdviKkLaGKJzYpXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4f9KtB5HDTzYQtxY;
	Tue, 10 Feb 2026 20:01:54 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id D38FC40575;
	Tue, 10 Feb 2026 20:02:53 +0800 (CST)
Received: from [10.174.178.152] (unknown [10.174.178.152])
	by APP4 (Coremail) with SMTP id gCh0CgB3JPVrHotpVVXAGw--.6145S3;
	Tue, 10 Feb 2026 20:02:53 +0800 (CST)
Message-ID: <ac1f8bd8-926e-4182-a5a3-a111b49ecafc@huaweicloud.com>
Date: Tue, 10 Feb 2026 20:02:51 +0800
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
 djwong@kernel.org, yizhang089@gmail.com, libaokun1@huawei.com,
 yangerkun@huawei.com, yukuai@fnnas.com, Zhang Yi <yi.zhang@huaweicloud.com>
References: <20260203062523.3869120-1-yi.zhang@huawei.com>
 <20260203062523.3869120-4-yi.zhang@huawei.com>
 <jgotl7vzzuzm6dvz5zfgk6haodxvunb4hq556pzh4hqqwvnhxq@lr3jiedhqh7c>
 <b889332b-9c0c-46d1-af61-1f2426c8c305@huaweicloud.com>
 <ocwepmhnw45k5nwwrooe2li2mzavw5ps2ncmowrc32u4zeitgp@gqsz3iee3axr>
 <1dad3113-7b84-40a0-8c7e-da30ae5cba8e@huaweicloud.com>
 <7hy5g3bp5whis4was5mqg3u6t37lwayi6j7scvpbuoqsbe5adc@mh5zxvml3oe7>
 <3ea033c1-8d32-4c82-baea-c383fa1d9e2a@huaweicloud.com>
 <yhy4cgc4fnk7tzfejuhy6m6ljo425ebpg6khss6vtvpidg6lyp@5xcyabxrl6zm>
 <665b8293-60a2-4d4d-aef5-cb1f9c3c0c13@huaweicloud.com>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <665b8293-60a2-4d4d-aef5-cb1f9c3c0c13@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgB3JPVrHotpVVXAGw--.6145S3
X-Coremail-Antispam: 1UD129KBjvJXoW3Jw4UJFWkXr4xAF1DCry5XFb_yoW3GrW5pr
	W5K3WDKr1Dt34rAr1Iva1xtr1Fv3y5JrWUWFy5Wr42vr9093WIqFWSg3yF9FWjyrn3ta42
	qr4qvFZ7ZF9YvFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvE14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
	0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7
	v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF
	1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIx
	AIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI
	42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWI
	evJa73UjIFyTuYvjfUonmRUUUUU
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
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-76838-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[huaweicloud.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,mit.edu,dilger.ca,linux.ibm.com,gmail.com,infradead.org,kernel.org,huawei.com,fnnas.com,huaweicloud.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yi.zhang@huaweicloud.com,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,huaweicloud.com:mid]
X-Rspamd-Queue-Id: 2D11611A877
X-Rspamd-Action: no action

On 2/9/2026 4:28 PM, Zhang Yi wrote:
> On 2/6/2026 11:35 PM, Jan Kara wrote:
>> On Fri 06-02-26 19:09:53, Zhang Yi wrote:
>>> On 2/5/2026 11:05 PM, Jan Kara wrote:
>>>> So how about the following:
>>>
>>> Let me see, please correct me if my understanding is wrong, ana there are
>>> also some points I don't get.
>>>
>>>> We expand our io_end processing with the
>>>> ability to journal i_disksize updates after page writeback completes. Then

While I was extending the end_io path of buffered_head to support updating
i_disksize, I found another problem that requires discussion.

Supporting updates to i_disksize in end_io requires starting a handle, which
conflicts with the data=ordered mode because folios written back through the
journal process cannot initiate any handles; otherwise, this may lead to a
deadlock. This limitation does not affect the iomap path, as it does not use
the data=ordered mode at all.  However, in the buffered_head path, online
defragmentation (if this change works, it should be the last user) still uses
the data=ordered mode.

Assume that during online defragmentation, after the EOF partial block is
copied and swapped, the transaction submitting process could be raced by a
concurrent truncate-up operation. Then, when the journal process commits this
block, the i_disksize needs to be updated after the I/O is complete. Finally,
it may trigger a deadlock issue when it starting a new transaction. Conversely,
if we do truncate up first, and then perform the EOF block swap operation just
after it, the same problem will also occur.

Even if we perform synchronous writeback for the EOF block in mext_move_extent(),
it still won't work. This is because swapped blocks that have entered the
ordered list could potentially become EOF blocks at any time before the
transaction is committed (e.g., a concurrent truncate down happens).

Therefore, I was thinking, perhaps currently we have to keep the buffer_head
path as it is, and only modify the truncate up and append write for the iomap
path. What do you think?

Cheers,
Yi.

>>>> when doing truncate up or appending writes, we keep i_disksize at the old
>>>> value and just zero folio tails in the page cache, mark the folio dirty and
>>>> update i_size.
>>>
>>> I think we need to submit this zeroed folio here as well. Because,
>>>
>>> 1) In the case of truncate up, if we don't submit, the i_disksize may have to
>>>    wait a long time (until the folio writeback is complete, which takes about
>>>    30 seconds by default) before being updated, which is too long.
>>
>> Correct but I'm not sure it matters. Current delalloc writes behave in the
>> same way already. For simplicity I'd thus prefer to not treat truncate up
>> in a special way but if we decide this indeed desirable, we can either
>> submit the tail folio immediately, or schedule work with earlier writeback.
>>
>>> 2) In the case of appending writes. Assume that the folio written beyond this
>>>    one is written back first, we have to wait this zeroed folio to be write
>>>    back and then update i_disksize, so we can't wait too long either.
>>
>> Correct, update of i_disksize after writeback of folios beyond current
>> i_disksize is blocked by the writeback of the tail folio.
>>
>>>> When submitting writeback for a folio beyond current
>>>> i_disksize we make sure writepages submits IO for all the folios from
>>>> current i_disksize upwards.
>>>
>>> Why "all the folios"? IIUC, we only wait the zeroed EOF folio is sufficient.
>>
>> I was worried about a case like:
>>
>> We have 4k blocksize, file is i_disksize 2k. Now you do:
>> pwrite(file, buf, 1, 6k);
>> pwrite(file, buf, 1, 10k);
>> pwrite(file, buf, 1, 14k);
>>
>> The pwrite at offset 6k needs to zero the tail of the folio with index 0,
>> pwrite at 10k needs to zero the tail of the folio with index 1, etc. And
>> for us to safely advance i_disksize to 14k+1, I though all the folios (and
>> zeroed out tails) need to be written out. But that's actually not the case.
>> We need to make sure the zeroed tail is written out only if the underlying
>> block is already allocated and marked as written at the time of zeroing.
>> And the blocks underlying intermediate i_size values will never be allocated
>> and written without advancing i_disksize to them. So I think you're
>> correct, we always have at most one tail folio - the one surrounding
>> current i_disksize - which needs to be written out to safely advance
>> i_disksize and we don't care about folios inbetween.
>>
>>>> When io_end processing happens after completed
>>>> folio writeback, we update i_disksize to min(i_size, end of IO).
>>>
>>> Yeah, in the case of append write back. Assume we append write the folio 2
>>> and folio 3,
>>>
>>>        old_idisksize  new_isize
>>>        |             |
>>>      [WWZZ][WWWW][WWWW]
>>>        1  |  2     3
>>>           A
>>>
>>> Assume that folio 1 first completes the writeback, then we update i_disksize
>>> to pos A when the writeback is complete. Assume that folio 2 or 3 completes
>>> first, we should wait(e.g. call filemap_fdatawait_range_keep_errors() or
>>> something like) folio 1 to complete and then update i_disksize to new_isize.
>>>
>>> But in the case of truncate up, We will only write back this zeroed folio. If
>>> the new i_size exceeds the end of this folio, how should we update i_disksize
>>> to the correct value?
>>>
>>> For example, we truncate the file from old old_idisksize to new_isize, but we
>>> only zero and writeback folio 1, in the end_io processing of folio 1, we can
>>> only update the i_disksize to A, but we can never update it to new_isize. Am
>>> I missing something ?
>>>
>>>        old_idisksize new_isize
>>>        |             |
>>>      [WWZZ]...hole ...
>>>        1  |
>>>           A
>>
>> Good question. Based on the analysis above one option would be to setup
>> writeback of page straddling current i_disksize to update i_disksize to
>> current i_size on completion. That would be simple but would have an
>> unpleasant side effect that in case of a crash after append write we could
>> see increased i_disksize but zeros instead of written data. Another option
>> would be to update i_disksize on completion to the beginning of the first
>> dirty folio behind the written back range or i_size of there's not such
>> folio. This would still be relatively simple and mostly deal with "zeros
>> instead of data" problem.
> 
> Ha, good idea! I think it should work. I will try the second option, thank
> you a lot for this suggestion. :)
> 
>>
>>>> This
>>>> should take care of non-zero data exposure issues and with "delay map"
>>>> processing Baokun works on all the inode metadata updates will happen after
>>>> IO completion anyway so it will be nicely batched up in one transaction.
>>>
>>> Currently, my iomap convert implementation always enables dioread_nolock,
>>
>> Yes, BTW I think you could remove no-dioread_nolock paths before doing the
>> conversion to simplify matters a bit. I don't think it's seriously used
>> anywhere anymore.
>>
> 
> Sure. After removing the no-dioread_nolock paths, the behavior of the
> buffer_head path (extents-based and no-journal data mode) and the iomap path
> in append write and truncate operations can be made consistent.
> 
> Cheers,
> Yi.
> 
>>> so I feel that this solution can be achieved even without the "delay map"
>>> feature. After we have the "delay map", we can extend this to the
>>> buffer_head path.
>>
>> I agree, delay map is not necessary for this to work. But it will make
>> things likely faster.
>>
>> 								Honza
> 


