Return-Path: <linux-fsdevel+bounces-20797-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEA318D7E1B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jun 2024 11:07:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E005B2437F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jun 2024 09:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AB1A7E792;
	Mon,  3 Jun 2024 09:07:13 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 205CB537E7;
	Mon,  3 Jun 2024 09:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717405633; cv=none; b=vGM6IT8z2WRxJaGjobTm9HM1nTANxrAoeWrpcrAZTRMOiBQ1osyy++1aSd6xB36BxXhAGEZpgfbwqs6lr5mEgsWOfpNEQd0FQbjWGBFJ7TxqUCOthzXcKiETG63gzV5mWXw6PUOlxAVFQZMy/Ni6xA2jeg092I5MfPBBI/3b7ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717405633; c=relaxed/simple;
	bh=871het3VtC7LTGp81p5U+w2hz47qYXgg7Ly20kzRsmg=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=tmmkOChtcFLVP2lyGDBZeYc2YM2+zwCvSmJrLtFd86/sZdEyBZWGIqSQA2gsxw2XTmkI2IV92GU5oaXBXpmJFLx6eN9NRtW3v56+I8WmWgrOjmCr7Lv3XeknJgbkJyXNj//TQaA196etV7JPMhzP9ms9R0G370ki8vADanQdja8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Vt7C76gv2z4f3kpq;
	Mon,  3 Jun 2024 17:06:59 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 2D9151A0840;
	Mon,  3 Jun 2024 17:07:06 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP2 (Coremail) with SMTP id Syh0CgAXOQy2h11mYAk7Ow--.23407S3;
	Mon, 03 Jun 2024 17:07:04 +0800 (CST)
Subject: Re: [RFC PATCH v4 1/8] iomap: zeroing needs to be pagecache aware
To: Brian Foster <bfoster@redhat.com>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, djwong@kernel.org, hch@infradead.org,
 brauner@kernel.org, david@fromorbit.com, chandanbabu@kernel.org,
 jack@suse.cz, willy@infradead.org, yi.zhang@huawei.com,
 chengzhihao1@huawei.com, yukuai3@huawei.com
References: <20240529095206.2568162-1-yi.zhang@huaweicloud.com>
 <20240529095206.2568162-2-yi.zhang@huaweicloud.com>
 <ZlxRz9LPNuoOZOtl@bfoster>
From: Zhang Yi <yi.zhang@huaweicloud.com>
Message-ID: <cc7e0a68-185f-a3e0-d60a-989b8b014608@huaweicloud.com>
Date: Mon, 3 Jun 2024 17:07:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZlxRz9LPNuoOZOtl@bfoster>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgAXOQy2h11mYAk7Ow--.23407S3
X-Coremail-Antispam: 1UD129KBjvJXoWxJw1UtryxXryrKFWUZF45GFg_yoWrZFWUpF
	yftFnrKr48Ja47J3ZFyFyUXryrGwn5AFW7Gw15GasYvw1rZF1rtF47Gr40kFWUWrW5Gr1U
	Zr45t342vryUAaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
	Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q
	6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
	kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE
	14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf
	9x07UWE__UUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 2024/6/2 19:04, Brian Foster wrote:
> On Wed, May 29, 2024 at 05:51:59PM +0800, Zhang Yi wrote:
>> From: Dave Chinner <dchinner@redhat.com>
>>
>> Unwritten extents can have page cache data over the range being
>> zeroed so we can't just skip them entirely. Fix this by checking for
>> an existing dirty folio over the unwritten range we are zeroing
>> and only performing zeroing if the folio is already dirty.
>>
>> XXX: how do we detect a iomap containing a cow mapping over a hole
>> in iomap_zero_iter()? The XFS code implies this case also needs to
>> zero the page cache if there is data present, so trigger for page
>> cache lookup only in iomap_zero_iter() needs to handle this case as
>> well.
>>
>> Before:
>>
>> $ time sudo ./pwrite-trunc /mnt/scratch/foo 50000
>> path /mnt/scratch/foo, 50000 iters
>>
>> real    0m14.103s
>> user    0m0.015s
>> sys     0m0.020s
>>
>> $ sudo strace -c ./pwrite-trunc /mnt/scratch/foo 50000
>> path /mnt/scratch/foo, 50000 iters
>> % time     seconds  usecs/call     calls    errors syscall
>> ------ ----------- ----------- --------- --------- ----------------
>>  85.90    0.847616          16     50000           ftruncate
>>  14.01    0.138229           2     50000           pwrite64
>> ....
>>
>> After:
>>
>> $ time sudo ./pwrite-trunc /mnt/scratch/foo 50000
>> path /mnt/scratch/foo, 50000 iters
>>
>> real    0m0.144s
>> user    0m0.021s
>> sys     0m0.012s
>>
>> $ sudo strace -c ./pwrite-trunc /mnt/scratch/foo 50000
>> path /mnt/scratch/foo, 50000 iters
>> % time     seconds  usecs/call     calls    errors syscall
>> ------ ----------- ----------- --------- --------- ----------------
>>  53.86    0.505964          10     50000           ftruncate
>>  46.12    0.433251           8     50000           pwrite64
>> ....
>>
>> Yup, we get back all the performance.
>>
>> As for the "mmap write beyond EOF" data exposure aspect
>> documented here:
>>
>> https://lore.kernel.org/linux-xfs/20221104182358.2007475-1-bfoster@redhat.com/
>>
>> With this command:
>>
>> $ sudo xfs_io -tfc "falloc 0 1k" -c "pwrite 0 1k" \
>>   -c "mmap 0 4k" -c "mwrite 3k 1k" -c "pwrite 32k 4k" \
>>   -c fsync -c "pread -v 3k 32" /mnt/scratch/foo
>>
>> Before:
>>
>> wrote 1024/1024 bytes at offset 0
>> 1 KiB, 1 ops; 0.0000 sec (34.877 MiB/sec and 35714.2857 ops/sec)
>> wrote 4096/4096 bytes at offset 32768
>> 4 KiB, 1 ops; 0.0000 sec (229.779 MiB/sec and 58823.5294 ops/sec)
>> 00000c00:  58 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58
>> XXXXXXXXXXXXXXXX
>> 00000c10:  58 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58
>> XXXXXXXXXXXXXXXX
>> read 32/32 bytes at offset 3072
>> 32.000000 bytes, 1 ops; 0.0000 sec (568.182 KiB/sec and 18181.8182
>>    ops/sec
>>
>> After:
>>
>> wrote 1024/1024 bytes at offset 0
>> 1 KiB, 1 ops; 0.0000 sec (40.690 MiB/sec and 41666.6667 ops/sec)
>> wrote 4096/4096 bytes at offset 32768
>> 4 KiB, 1 ops; 0.0000 sec (150.240 MiB/sec and 38461.5385 ops/sec)
>> 00000c00:  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>> ................
>> 00000c10:  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>> ................
>> read 32/32 bytes at offset 3072
>> 32.000000 bytes, 1 ops; 0.0000 sec (558.036 KiB/sec and 17857.1429
>>    ops/sec)
>>
>> We see that this post-eof unwritten extent dirty page zeroing is
>> working correctly.
>>
> 
> I've pointed this out in the past, but IIRC this implementation is racy
> vs. reclaim. Specifically, relying on folio lookup after mapping lookup
> doesn't take reclaim into account, so if we look up an unwritten mapping
> and then a folio flushes and reclaims by the time the scan reaches that
> offset, it incorrectly treats that subrange as already zero when it
> actually isn't (because the extent is actually stale by that point, but
> the stale extent check is skipped).
> 

Hello, Brian!

I'm confused, how could that happen? We do stale check under folio lock,
if the folio flushed and reclaimed before we get&lock that folio in
iomap_zero_iter()->iomap_write_begin(), the ->iomap_valid() would check
this stale out and zero again in the next iteration. Am I missing
something?

Thanks,
Yi.

> A simple example to demonstrate this is something like the following:
> 
> # looping truncate zeroing
> while [ true ]; do
> 	xfs_io -fc "truncate 0" -c "falloc 0 32K" -c "pwrite 0 4k" -c "truncate 2k" <file>
> 	xfs_io -c "mmap 0 4k" -c "mread -v 2k 16" <file> | grep cd && break
> done
> 
> vs.
> 
> # looping writeback and reclaim
> while [ true ]; do
> 	xfs_io -c "sync_range -a 0 0" -c "fadvise -d 0 0" <file>
> done
> 
> If I ran that against this patch, the first loop will eventually detect
> stale data exposed past eof.
> 
> Brian
> 


