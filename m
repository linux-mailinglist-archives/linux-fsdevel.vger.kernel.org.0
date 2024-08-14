Return-Path: <linux-fsdevel+bounces-25852-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 009DB9511E6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 04:14:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF9541C224EA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 02:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA54E1F956;
	Wed, 14 Aug 2024 02:14:20 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 185851CD00;
	Wed, 14 Aug 2024 02:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723601660; cv=none; b=aX3W4X3Tgl2dBh6B9EEo/+KV8ti6xpXtXRHbUhzbuWNIFaF+iG0F/b6mrXfJPw+dvuW5hbqQFeEvTTeHetC3/kUy4Wpjsr8aJCn75Q5/D3Q3UJoXljqc7MNusbiw48YUkhOXHlkIspGs/ssU8VnrNBMZu11YUQIzdaLIgta6p/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723601660; c=relaxed/simple;
	bh=HyJXPEkHYTcoabYth+nyd9Ejhv6HAsD8uYPKH7RVmbI=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=sHXH8g1KEVyv/0ziK67zZCvvLEwHyTl/4t9EHCR7qnMc5PAB705S0Pyy7Us98dyLQBgpmXhgJaPp2VhGuIr0xuL0ZWoT7IaYpx5NWPTI8Tei6AwAXZqEiE9Tkp5zW3Qjusvq0ZH6UWvIUiMryWsVkzQbx0epMeSe2PxyUQY+rRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4WkBdF5HHqz4f3jMf;
	Wed, 14 Aug 2024 10:13:53 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 7A38B1A058E;
	Wed, 14 Aug 2024 10:14:07 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP4 (Coremail) with SMTP id gCh0CgB37ILpErxmVISHBg--.38663S3;
	Wed, 14 Aug 2024 10:14:03 +0800 (CST)
Subject: Re: [PATCH v2 0/6] iomap: some minor non-critical fixes and
 improvements when block size < folio size
To: Dave Chinner <david@fromorbit.com>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, djwong@kernel.org, hch@infradead.org,
 brauner@kernel.org, jack@suse.cz, willy@infradead.org, yi.zhang@huawei.com,
 chengzhihao1@huawei.com, yukuai3@huawei.com
References: <20240812121159.3775074-1-yi.zhang@huaweicloud.com>
 <ZrwNG9ftNaV4AJDd@dread.disaster.area>
From: Zhang Yi <yi.zhang@huaweicloud.com>
Message-ID: <feead66e-5b83-7e54-1164-c7c61e78e7be@huaweicloud.com>
Date: Wed, 14 Aug 2024 10:14:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZrwNG9ftNaV4AJDd@dread.disaster.area>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgB37ILpErxmVISHBg--.38663S3
X-Coremail-Antispam: 1UD129KBjvJXoWxXFyUCw15uF1kCrykZr15CFg_yoW5Xw17pF
	Waga4kKryDGr1xt3s29wsrZF1vyw1rtF1rGF1rtwsrCFsxWF4IqFyIqr98ua95Jr4Ikr4j
	vw1jqF97ury5Z3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Ib4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4I
	kC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWU
	WwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr
	0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWU
	JVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJb
	IYCTnIWIevJa73UjIFyTuYvjxUF1v3UUUUU
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 2024/8/14 9:49, Dave Chinner wrote:
> On Mon, Aug 12, 2024 at 08:11:53PM +0800, Zhang Yi wrote:
>> From: Zhang Yi <yi.zhang@huawei.com>
>>
>> Changes since v1:
>>  - Patch 5 fix a stale data exposure problem pointed out by Willy, drop
>>    the setting of uptodate bits after zeroing out unaligned range.
>>  - As Dave suggested, in order to prevent increasing the complexity of
>>    maintain the state_lock, don't just drop all the state_lock in the
>>    buffered write path, patch 6 introduce a new helper to set uptodate
>>    bit and dirty bits together under the state_lock, reduce one time of
>>    locking per write, the benefits of performance optimization do not
>>    change too much.
> 
> It's helpful to provide a lore link to the previous version so that
> reviewers don't have to go looking for it themselves to remind them
> of what was discussed last time.
> 
> https://lore.kernel.org/linux-xfs/20240731091305.2896873-1-yi.zhang@huaweicloud.com/T/

Sure, will add in my later iterations.

> 
>> This series contains some minor non-critical fixes and performance
>> improvements on the filesystem with block size < folio size.
>>
>> The first 4 patches fix the handling of setting and clearing folio ifs
>> dirty bits when mark the folio dirty and when invalidat the folio.
>> Although none of these code mistakes caused a real problem now, it's
>> still deserve a fix to correct the behavior.
>>
>> The second 2 patches drop the unnecessary state_lock in ifs when setting
>> and clearing dirty/uptodate bits in the buffered write path, it could
>> improve some (~8% on my machine) buffer write performance. I tested it
>> through UnixBench on my x86_64 (Xeon Gold 6151) and arm64 (Kunpeng-920)
>> virtual machine with 50GB ramdisk and xfs filesystem, the results shows
>> below.
>>
>> UnixBench test cmd:
>>  ./Run -i 1 -c 1 fstime-w
>>
>> Before:
>> x86    File Write 1024 bufsize 2000 maxblocks       524708.0 KBps
>> arm64  File Write 1024 bufsize 2000 maxblocks       801965.0 KBps
>>
>> After:
>> x86    File Write 1024 bufsize 2000 maxblocks       569218.0 KBps
>> arm64  File Write 1024 bufsize 2000 maxblocks       871605.0 KBps
> 
> Those are the same performance numbers as you posted for the
> previous version of the patch. How does this new version perform
> given that it's a complete rework of the optimisation? It's

It's not exactly the same, but the difference is small, I've updated
the performance number in this cover letter.

> important to know if the changes made actually provided the benefit
> we expected them to make....
> 
> i.e. this is the sort of table of results I'd like to see provided:
> 
> platform	base		v1		v2
> x86		524708.0	569218.0	????
> arm64		801965.0	871605.0	????
> 

 platform	base		v1		v2
 x86		524708.0	571315.0 	569218.0
 arm64		801965.0	876077.0	871605.0

Thanks,
Yi.


