Return-Path: <linux-fsdevel+bounces-76690-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2GrJIKWaiWkv/gQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76690-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Feb 2026 09:28:21 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id AB20610CF18
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Feb 2026 09:28:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1E3303004057
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Feb 2026 08:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47654309F09;
	Mon,  9 Feb 2026 08:28:13 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DE73308F34;
	Mon,  9 Feb 2026 08:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770625693; cv=none; b=mUI+IooRfeD+YgY/2U/siwSvRd93bgfNdgWASCkn3n09s2cHszEZwJBCv5/ZeLq9w3O1fHs/fJ6Pt+FimzVt7UTPj+MPFLiIklXhBVHp9b1GdR88MdTCuHwq+qj0J48ghvoyGcBGXaGcMd28Do0N3nC9cUqwbIn1zNDh0R37K8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770625693; c=relaxed/simple;
	bh=YETcwavk85wQHDnaLKbov3ELSZ81zv+k5Di6YMEXv3A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iwnVb5yPQpvC7or8TEXueypenycqImasObSoXblGsAGLZaXboF1dmbsizqRt3bWxB8m296GST573C5f7LLbNaNX85tctCqKiH5KgHMASoUXRflxLqR6kd9kTiSplCl0p70movnjsMn2edF5v2cmL4VrGirbTMIO4+3trJgBcx24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4f8d9P64mLzKHMjX;
	Mon,  9 Feb 2026 16:27:37 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 86F0440579;
	Mon,  9 Feb 2026 16:28:08 +0800 (CST)
Received: from [10.174.178.152] (unknown [10.174.178.152])
	by APP4 (Coremail) with SMTP id gCh0CgC3ZPWWmolpY6I2Gw--.34976S3;
	Mon, 09 Feb 2026 16:28:08 +0800 (CST)
Message-ID: <665b8293-60a2-4d4d-aef5-cb1f9c3c0c13@huaweicloud.com>
Date: Mon, 9 Feb 2026 16:28:06 +0800
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
 <3ea033c1-8d32-4c82-baea-c383fa1d9e2a@huaweicloud.com>
 <yhy4cgc4fnk7tzfejuhy6m6ljo425ebpg6khss6vtvpidg6lyp@5xcyabxrl6zm>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <yhy4cgc4fnk7tzfejuhy6m6ljo425ebpg6khss6vtvpidg6lyp@5xcyabxrl6zm>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgC3ZPWWmolpY6I2Gw--.34976S3
X-Coremail-Antispam: 1UD129KBjvJXoW3Aw1UtFW7XF43Xw1UGw1kAFb_yoW7Zr4xpr
	W5K3WDKr1Dt345Arn2vF1xtryFy3y5Jr1UGFyrWr42vr98u3W0qFWSg3yFgrWUArn3Ka42
	vr4DuFWkCFyFvFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-76690-lists,linux-fsdevel=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.929];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huaweicloud.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AB20610CF18
X-Rspamd-Action: no action

On 2/6/2026 11:35 PM, Jan Kara wrote:
> On Fri 06-02-26 19:09:53, Zhang Yi wrote:
>> On 2/5/2026 11:05 PM, Jan Kara wrote:
>>> So how about the following:
>>
>> Let me see, please correct me if my understanding is wrong, ana there are
>> also some points I don't get.
>>
>>> We expand our io_end processing with the
>>> ability to journal i_disksize updates after page writeback completes. Then
>>> when doing truncate up or appending writes, we keep i_disksize at the old
>>> value and just zero folio tails in the page cache, mark the folio dirty and
>>> update i_size.
>>
>> I think we need to submit this zeroed folio here as well. Because,
>>
>> 1) In the case of truncate up, if we don't submit, the i_disksize may have to
>>    wait a long time (until the folio writeback is complete, which takes about
>>    30 seconds by default) before being updated, which is too long.
> 
> Correct but I'm not sure it matters. Current delalloc writes behave in the
> same way already. For simplicity I'd thus prefer to not treat truncate up
> in a special way but if we decide this indeed desirable, we can either
> submit the tail folio immediately, or schedule work with earlier writeback.
> 
>> 2) In the case of appending writes. Assume that the folio written beyond this
>>    one is written back first, we have to wait this zeroed folio to be write
>>    back and then update i_disksize, so we can't wait too long either.
> 
> Correct, update of i_disksize after writeback of folios beyond current
> i_disksize is blocked by the writeback of the tail folio.
> 
>>> When submitting writeback for a folio beyond current
>>> i_disksize we make sure writepages submits IO for all the folios from
>>> current i_disksize upwards.
>>
>> Why "all the folios"? IIUC, we only wait the zeroed EOF folio is sufficient.
> 
> I was worried about a case like:
> 
> We have 4k blocksize, file is i_disksize 2k. Now you do:
> pwrite(file, buf, 1, 6k);
> pwrite(file, buf, 1, 10k);
> pwrite(file, buf, 1, 14k);
> 
> The pwrite at offset 6k needs to zero the tail of the folio with index 0,
> pwrite at 10k needs to zero the tail of the folio with index 1, etc. And
> for us to safely advance i_disksize to 14k+1, I though all the folios (and
> zeroed out tails) need to be written out. But that's actually not the case.
> We need to make sure the zeroed tail is written out only if the underlying
> block is already allocated and marked as written at the time of zeroing.
> And the blocks underlying intermediate i_size values will never be allocated
> and written without advancing i_disksize to them. So I think you're
> correct, we always have at most one tail folio - the one surrounding
> current i_disksize - which needs to be written out to safely advance
> i_disksize and we don't care about folios inbetween.
> 
>>> When io_end processing happens after completed
>>> folio writeback, we update i_disksize to min(i_size, end of IO).
>>
>> Yeah, in the case of append write back. Assume we append write the folio 2
>> and folio 3,
>>
>>        old_idisksize  new_isize
>>        |             |
>>      [WWZZ][WWWW][WWWW]
>>        1  |  2     3
>>           A
>>
>> Assume that folio 1 first completes the writeback, then we update i_disksize
>> to pos A when the writeback is complete. Assume that folio 2 or 3 completes
>> first, we should wait(e.g. call filemap_fdatawait_range_keep_errors() or
>> something like) folio 1 to complete and then update i_disksize to new_isize.
>>
>> But in the case of truncate up, We will only write back this zeroed folio. If
>> the new i_size exceeds the end of this folio, how should we update i_disksize
>> to the correct value?
>>
>> For example, we truncate the file from old old_idisksize to new_isize, but we
>> only zero and writeback folio 1, in the end_io processing of folio 1, we can
>> only update the i_disksize to A, but we can never update it to new_isize. Am
>> I missing something ?
>>
>>        old_idisksize new_isize
>>        |             |
>>      [WWZZ]...hole ...
>>        1  |
>>           A
> 
> Good question. Based on the analysis above one option would be to setup
> writeback of page straddling current i_disksize to update i_disksize to
> current i_size on completion. That would be simple but would have an
> unpleasant side effect that in case of a crash after append write we could
> see increased i_disksize but zeros instead of written data. Another option
> would be to update i_disksize on completion to the beginning of the first
> dirty folio behind the written back range or i_size of there's not such
> folio. This would still be relatively simple and mostly deal with "zeros
> instead of data" problem.

Ha, good idea! I think it should work. I will try the second option, thank
you a lot for this suggestion. :)

> 
>>> This
>>> should take care of non-zero data exposure issues and with "delay map"
>>> processing Baokun works on all the inode metadata updates will happen after
>>> IO completion anyway so it will be nicely batched up in one transaction.
>>
>> Currently, my iomap convert implementation always enables dioread_nolock,
> 
> Yes, BTW I think you could remove no-dioread_nolock paths before doing the
> conversion to simplify matters a bit. I don't think it's seriously used
> anywhere anymore.
> 

Sure. After removing the no-dioread_nolock paths, the behavior of the
buffer_head path (extents-based and no-journal data mode) and the iomap path
in append write and truncate operations can be made consistent.

Cheers,
Yi.

>> so I feel that this solution can be achieved even without the "delay map"
>> feature. After we have the "delay map", we can extend this to the
>> buffer_head path.
> 
> I agree, delay map is not necessary for this to work. But it will make
> things likely faster.
> 
> 								Honza


