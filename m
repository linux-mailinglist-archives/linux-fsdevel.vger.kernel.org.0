Return-Path: <linux-fsdevel+bounces-76359-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ADukJUD7g2kXwgMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76359-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Feb 2026 03:06:56 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EA183EDDA3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Feb 2026 03:06:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CB6ED301185F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Feb 2026 02:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D4E625A64C;
	Thu,  5 Feb 2026 02:06:24 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29102243367;
	Thu,  5 Feb 2026 02:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770257184; cv=none; b=Z1fuVnUVdtWmy6DsMjs+0hlwOczIQDLPnWM64NsMXGoe7J7kgMJgPFsJweBcQiA1MhO1Dp0sYbA7Ndwsy1Ir7fTmDQ0i94+sF9lj+FcnjWDdtD6ik4zJF1JEd/qtTG2ZsDrMKIT/crDgvpUZTfCQKdcXOJkPUIPsOh2qeEC4Vkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770257184; c=relaxed/simple;
	bh=a0NRoClyqFjfjnO8d/DwtdKwo2mnhXY/TzfEFzmuz4Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r0oemJK9dWXOm0rDYdjaor7b0QCM3G+vxGeMd/15v03vPv5lPzdV6mpwi3AvCU8htYGw9bu55mhc148G7qCsMpPP9xDwCqbPLvLGgv1NrzYCemRMjYqs1mRijsoxLa27UL9Z45jWWV4kBcAmZevFMhrShkFrwvo6RPOzPjneECE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4f60tC3w3DzYQtpM;
	Thu,  5 Feb 2026 10:05:23 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 8737140578;
	Thu,  5 Feb 2026 10:06:13 +0800 (CST)
Received: from [10.174.178.152] (unknown [10.174.178.152])
	by APP4 (Coremail) with SMTP id gCh0CgAHZ_cT+4NpfNI0GQ--.52769S3;
	Thu, 05 Feb 2026 10:06:13 +0800 (CST)
Message-ID: <e186c712-1594-4f66-aa89-5517696f70ec@huaweicloud.com>
Date: Thu, 5 Feb 2026 10:06:11 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next v2 00/22] ext4: use iomap for regular file's
 buffered I/O path
To: Jan Kara <jack@suse.cz>, Baokun Li <libaokun1@huawei.com>
Cc: Theodore Tso <tytso@mit.edu>, Christoph Hellwig <hch@infradead.org>,
 linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, adilger.kernel@dilger.ca,
 ojaswin@linux.ibm.com, ritesh.list@gmail.com, djwong@kernel.org,
 Zhang Yi <yi.zhang@huawei.com>, yizhang089@gmail.com, yangerkun@huawei.com,
 yukuai@alb-78bjiv52429oh8qptp.cn-shenzhen.alb.aliyuncs.com,
 libaokun9@gmail.com
References: <20260203062523.3869120-1-yi.zhang@huawei.com>
 <aYGZB_hugPRXCiSI@infradead.org>
 <77c14b3e-33f9-4a00-83a4-0467f73a7625@huaweicloud.com>
 <20260203131407.GA27241@macsyma.lan>
 <9666679c-c9f7-435c-8b67-c67c2f0c19ab@huawei.com>
 <eldlhdvhc4sdlmfed5omg6huv5rl6m7ummstlygh2bownaejqn@bykrybkyywzp>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <eldlhdvhc4sdlmfed5omg6huv5rl6m7ummstlygh2bownaejqn@bykrybkyywzp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAHZ_cT+4NpfNI0GQ--.52769S3
X-Coremail-Antispam: 1UD129KBjvJXoW3Jr1kXF4kur15AFy7XF1rXrb_yoW7CryUpF
	W5Ka4rtr4DW348Awn2vw48Xr4S93yfAFW3Jrn0qrsrZas8JF1SvFWxKw1j9a4vkrs7G3Wj
	qr4jvFyxu3WDZFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWr
	XwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1
	aFAJUUUUU==
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
	TAGGED_FROM(0.00)[bounces-76359-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[huaweicloud.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[mit.edu,infradead.org,vger.kernel.org,dilger.ca,linux.ibm.com,gmail.com,kernel.org,huawei.com,alb-78bjiv52429oh8qptp.cn-shenzhen.alb.aliyuncs.com];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,huaweicloud.com:mid]
X-Rspamd-Queue-Id: EA183EDDA3
X-Rspamd-Action: no action

On 2/4/2026 10:23 PM, Jan Kara wrote:
> On Wed 04-02-26 09:59:36, Baokun Li wrote:
>> On 2026-02-03 21:14, Theodore Tso wrote:
>>> On Tue, Feb 03, 2026 at 05:18:10PM +0800, Zhang Yi wrote:
>>>> This means that the ordered journal mode is no longer in ext4 used
>>>> under the iomap infrastructure.  The main reason is that iomap
>>>> processes each folio one by one during writeback. It first holds the
>>>> folio lock and then starts a transaction to create the block mapping.
>>>> If we still use the ordered mode, we need to perform writeback in
>>>> the logging process, which may require initiating a new transaction,
>>>> potentially leading to deadlock issues. In addition, ordered journal
>>>> mode indeed has many synchronization dependencies, which increase
>>>> the risk of deadlocks, and I believe this is one of the reasons why
>>>> ext4_do_writepages() is implemented in such a complicated manner.
>>>> Therefore, I think we need to give up using the ordered data mode.
>>>>
>>>> Currently, there are three scenarios where the ordered mode is used:
>>>> 1) append write,
>>>> 2) partial block truncate down, and
>>>> 3) online defragmentation.
>>>>
>>>> For append write, we can always allocate unwritten blocks to avoid
>>>> using the ordered journal mode.
>>> This is going to be a pretty severe performance regression, since it
>>> means that we will be doubling the journal load for append writes.
>>> What we really need to do here is to first write out the data blocks,
>>> and then only start the transaction handle to modify the data blocks
>>> *after* the data blocks have been written (to heretofore, unused
>>> blocks that were just allocated).  It means inverting the order in
>>> which we write data blocks for the append write case, and in fact it
>>> will improve fsync() performance since we won't be gating writing the
>>> commit block on the date blocks getting written out in the append
>>> write case.
>>
>> I have some local demo patches doing something similar, and I think this
>> work could be decoupled from Yi's patch set.
>>
>> Since inode preallocation (PA) maintains physical block occupancy with a
>> logical-to-physical mapping, and ensures on-disk data consistency after
>> power failure, it is an excellent location for recording temporary
>> occupancy. Furthermore, since inode PA often allocates more blocks than
>> requested, it can also help reduce file fragmentation.
>>
>> The specific approach is as follows:
>>
>> 1. Allocate only the PA during block allocation without inserting it into
>>    the extent status tree. Return the PA to the caller and increment its
>>    refcount to prevent it from being discarded.
>>
>> 2. Issue IOs to the blocks within the inode PA. If IO fails, release the
>>    refcount and return -EIO. If successful, proceed to the next step.
>>
>> 3. Start a handle upon successful IO completion to convert the inode PA to
>>    extents. Release the refcount and update the extent tree.
>>
>> 4. If a corresponding extent already exists, we’ll need to punch holes to
>>    release the old extent before inserting the new one.
> 
> Sounds good. Just if I understand correctly case 4 would happen only if you
> really try to do something like COW with this? Normally you'd just use the
> already present blocks and write contents into them?
> 
>> This ensures data atomicity, while jbd2—being a COW-like implementation
>> itself—ensures metadata atomicity. By leveraging this "delay map"
>> mechanism, we can achieve several benefits:
>>
>>  * Lightweight, high-performance COW.
>>  * High-performance software atomic writes (hardware-independent).
>>  * Replacing dio_readnolock, which might otherwise read unexpected zeros.
>>  * Replacing ordered data and data journal modes.
>>  * Reduced handle hold time, as it's only held during extent tree updates.
>>  * Paving the way for snapshot support.
>>
>> Of course, COW itself can lead to severe file fragmentation, especially
>> in small-scale overwrite scenarios.
> 
> I agree the feature can provide very interesting benefits and we were
> pondering about something like that for a long time, just never got to
> implementing it. I'd say the immediate benefits are you can completely get
> rid of dioread_nolock as well as the legacy dioread_lock modes so overall
> code complexity should not increase much. We could also mostly get rid of
> data=ordered mode use (although not completely - see my discussion with
> Zhang over patch 3) which would be also welcome simplification. These

I suppose this feature can also be used to get rid of the data=ordered mode
use in online defragmentation. With this feature, perhaps we can develop a
new method of online defragmentation that eliminates the need to pre-allocate
a donor file.  Instead, we can attempt to allocate as many contiguous blocks
as possible through PA. If the allocated length is longer than the original
extent, we can perform the swap and copy the data. Once the copy is complete,
we can atomically construct a new extent, then releases the original blocks
synchronously or asynchronously, similar to a regular copy-on-write (COW)
operation. What does this sounds?

Regards,
Yi.

> benefits alone are IMO a good enough reason to have the functionality :).
> Even without COW, atomic writes and other fancy stuff.
> 
> I don't see how you want to get rid of data=journal mode - perhaps that's
> related to the COW functionality?
> 
> 								Honza


