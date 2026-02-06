Return-Path: <linux-fsdevel+bounces-76574-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8GMyGsbMhWlWGgQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76574-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 12:13:10 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ED091FD10B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 12:13:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E7A813070DD8
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Feb 2026 11:10:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5075399003;
	Fri,  6 Feb 2026 11:10:02 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ECB72FC876;
	Fri,  6 Feb 2026 11:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770376202; cv=none; b=mYN7stl6DLPrUmPkrks0nKngv/esNEHlXiF8LBdx2TZ89n2Hg7rWug1/Qzvl0Qt/QKKzs1fBrpvD+RKPYNgjcZXZAMeKQtOU5nB1ClK1PZi5w7uAZaeWaYDE3byGtQJzaAaSskkz6YKJDs5sAgpEsheowV94gAeettuwH9IkGO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770376202; c=relaxed/simple;
	bh=ieAGYcihW1ZN1usXW1lEn5Yo7YWJAUzlJ/jq3+seTm4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qrE+0boYZdGzYzQ1FJ162YGOjRXcUBKMEZEM9UTpvLp/dd1SJkcJdOa8Lutt4xrW/m7g1ZUbJnJID7TzNuzQgWbbK2hfsU/g/l09pmYcXqOjiHg1QYsCu4pYphtBjSBUMBfDPt7l2xwGZ/Effit46hNafJUidrIg0u5hAlsThwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4f6rv62L3JzYQtyT;
	Fri,  6 Feb 2026 19:09:06 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 159534058D;
	Fri,  6 Feb 2026 19:09:56 +0800 (CST)
Received: from [10.174.178.152] (unknown [10.174.178.152])
	by APP4 (Coremail) with SMTP id gCh0CgCX+PgCzIVpeC3aGQ--.22087S3;
	Fri, 06 Feb 2026 19:09:55 +0800 (CST)
Message-ID: <3ea033c1-8d32-4c82-baea-c383fa1d9e2a@huaweicloud.com>
Date: Fri, 6 Feb 2026 19:09:53 +0800
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
 <1dad3113-7b84-40a0-8c7e-da30ae5cba8e@huaweicloud.com>
 <7hy5g3bp5whis4was5mqg3u6t37lwayi6j7scvpbuoqsbe5adc@mh5zxvml3oe7>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <7hy5g3bp5whis4was5mqg3u6t37lwayi6j7scvpbuoqsbe5adc@mh5zxvml3oe7>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgCX+PgCzIVpeC3aGQ--.22087S3
X-Coremail-Antispam: 1UD129KBjvJXoW3XFy5WrW3Kw4xAFykKF13twb_yoW7Zry8pF
	WUK3Z8tr1vg343urn7ZF4xtF1Fv3y5JrW7JF95KrsFvas8WFn7KFWSqayFgFyjkrs3ta42
	qr4UtFZ7uF98ZFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-76574-lists,linux-fsdevel=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.987];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: ED091FD10B
X-Rspamd-Action: no action

On 2/5/2026 11:05 PM, Jan Kara wrote:
> On Thu 05-02-26 15:50:38, Zhang Yi wrote:
>> On 2/4/2026 10:18 PM, Jan Kara wrote:
>>> So why do you need to get rid of these data=ordered
>>> mode usages? I guess because with iomap keeping our transaction handle ->
>>> folio lock ordering is complicated? Last time I looked it seemed still
>>> possible to keep it though.
>>
>> Yes, that's one reason. There's another reason is that we also need to
>> implement partial folio submits for iomap.
>>
>> When the journal process is waiting for a folio to be written back
>> (which contains an ordered block), and the folio also contains unmapped
>> blocks with a block size smaller than the folio size, if the regular
>> writeback process has already started committing this folio (and set the
>> writeback flag), then a deadlock may occur while mapping the remaining
>> unmapped blocks. This is because the writeback flag is cleared only
>> after the entire folio are processed and committed. If we want to support
>> partial folio submit for iomap, we need to be careful to prevent adding
>> additional performance overhead in the case of severe fragmentation.
> 
> Yeah, this logic is currently handled by ext4_bio_write_folio(). And the
> deadlocks are currently resolved by grabbing transaction handle before we
> go and lock any page for writeback. But I agree that with iomap it may be
> tricky to keep this scheme.
> 
>> Therefore, this aspect of the logic is complicated and subtle. As we
>> discussed in patch 0, if we can avoid using the data=ordered mode in
>> append write and online defrag, then this would be the only remaining
>> corner case. I'm not sure if it is worth implementing this and adjusting
>> the lock ordering.
>>
>>> Another possibility would be to just *submit* the write synchronously and
>>> use data=ordered mode machinery only to wait for IO to complete before the
>>> transaction commits. That way it should be safe to start a transaction
>>
>> IIUC, this solution seems can avoid adjusting the lock ordering, but partial
>> folio submission still needs to be implemented, is my understanding right?
>> This is because although we have already submitted this zeroed partial EOF
>> block, when the journal process is waiting for this folio, this folio is
>> being written back, and there are other blocks in this folio that need to be
>> mapped.
> 
> That's a good question. If we submit the tail folio from truncation code,
> we could just submit the full folio write and there's no need to restrict
> ourselves only to mapped blocks. But you are correct that if this IO
> completes but the folio had holes in it and the hole gets filled in by
> write before the transaction with i_disksize update commits, jbd2 commit
> could still race with flush worker writing this folio again and the
> deadlock could happen. Hrm...
> 
Yes!

> So how about the following:

Let me see, please correct me if my understanding is wrong, ana there are
also some points I don't get.

> We expand our io_end processing with the
> ability to journal i_disksize updates after page writeback completes. Then
> when doing truncate up or appending writes, we keep i_disksize at the old
> value and just zero folio tails in the page cache, mark the folio dirty and
> update i_size.

I think we need to submit this zeroed folio here as well. Because,

1) In the case of truncate up, if we don't submit, the i_disksize may have to
   wait a long time (until the folio writeback is complete, which takes about
   30 seconds by default) before being updated, which is too long.
2) In the case of appending writes. Assume that the folio written beyond this
   one is written back first, we have to wait this zeroed folio to be write
   back and then update i_disksize, so we can't wait too long either.

Right?

> When submitting writeback for a folio beyond current
> i_disksize we make sure writepages submits IO for all the folios from
> current i_disksize upwards.

Why "all the folios"? IIUC, we only wait the zeroed EOF folio is sufficient.

> When io_end processing happens after completed
> folio writeback, we update i_disksize to min(i_size, end of IO).

Yeah, in the case of append write back. Assume we append write the folio 2
and folio 3,

       old_idisksize  new_isize
       |             |
     [WWZZ][WWWW][WWWW]
       1  |  2     3
          A

Assume that folio 1 first completes the writeback, then we update i_disksize
to pos A when the writeback is complete. Assume that folio 2 or 3 completes
first, we should wait(e.g. call filemap_fdatawait_range_keep_errors() or
something like) folio 1 to complete and then update i_disksize to new_isize.

But in the case of truncate up, We will only write back this zeroed folio. If
the new i_size exceeds the end of this folio, how should we update i_disksize
to the correct value?

For example, we truncate the file from old old_idisksize to new_isize, but we
only zero and writeback folio 1, in the end_io processing of folio 1, we can
only update the i_disksize to A, but we can never update it to new_isize. Am
I missing something ?

       old_idisksize new_isize
       |             |
     [WWZZ]...hole ...
       1  |
          A

> This
> should take care of non-zero data exposure issues and with "delay map"
> processing Baokun works on all the inode metadata updates will happen after
> IO completion anyway so it will be nicely batched up in one transaction.

Currently, my iomap convert implementation always enables dioread_nolock,
so I feel that this solution can be achieved even without the "delay map"
feature. After we have the "delay map", we can extend this to the
buffer_head path.

Thanks,
Yi.

> It's a big change but so far I think it should work. What do you think?
> 
> 								Honza


