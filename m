Return-Path: <linux-fsdevel+bounces-25870-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB9DA951346
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 05:57:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E642C1C214B4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 03:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 888664D8D0;
	Wed, 14 Aug 2024 03:57:13 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AD353BB48;
	Wed, 14 Aug 2024 03:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723607833; cv=none; b=o6cQ+/VnC8nRM5kDS4h/Jwvil5m3rIUSJ2z4LE8FzmkjMPNBlXH227tZ+Vn4j72AS+x+Wtf8kKk/fgjsxn8C7lYe1VD4NeulRZZCbnWTSlu619O0EBiTCIGVVcTQaKp60s3l+bkxfww3bZB+baKDrohNZih06mww6rThvH+RHD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723607833; c=relaxed/simple;
	bh=JYZNJKXJCiVPWZkkBUJ1XzTfQ4lfrWXGF9nXpiX3Bvg=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=QtXMR5OfgYzlmKQst6MTxDknMvuqhKtnYuGt/qS0S5isthP2VffUZJ0fv+Ut0akpc0LG8e7OVmmX8mQpHOji1V87B6GEuV5bsKQ3jprqH1aJ0ZqfRLD6mPPT64cQLpu2BqlOiNyIVJe/4lYNGYvYS/Y7qFG3owyxlcArPB5xwHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4WkDw82KpYz4f3jjx;
	Wed, 14 Aug 2024 11:56:56 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id A04661A0568;
	Wed, 14 Aug 2024 11:57:05 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP4 (Coremail) with SMTP id gCh0CgBXzIIPK7xmIyWOBg--.9713S3;
	Wed, 14 Aug 2024 11:57:05 +0800 (CST)
Subject: Re: [PATCH v2 0/6] iomap: some minor non-critical fixes and
 improvements when block size < folio size
To: Dave Chinner <david@fromorbit.com>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, djwong@kernel.org, hch@infradead.org,
 brauner@kernel.org, jack@suse.cz, willy@infradead.org, yi.zhang@huawei.com,
 chengzhihao1@huawei.com, yukuai3@huawei.com
References: <20240812121159.3775074-1-yi.zhang@huaweicloud.com>
 <ZrwNG9ftNaV4AJDd@dread.disaster.area>
 <feead66e-5b83-7e54-1164-c7c61e78e7be@huaweicloud.com>
 <Zrwap10baOW8XeIv@dread.disaster.area>
From: Zhang Yi <yi.zhang@huaweicloud.com>
Message-ID: <a08a9491-61d7-b300-55ba-b016dd5aad5a@huaweicloud.com>
Date: Wed, 14 Aug 2024 11:57:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <Zrwap10baOW8XeIv@dread.disaster.area>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgBXzIIPK7xmIyWOBg--.9713S3
X-Coremail-Antispam: 1UD129KBjvJXoW7urW7Gw17WF13Jry8XF1xAFb_yoW8CF15pF
	yagF90krn5Kr4fXwn2qr40qr1vyw15GayrGFyrt34j9rs8Zr17JF4xKFyrCrZ2qwn7Xr4j
	vrWrG34xCF15Za7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

On 2024/8/14 10:47, Dave Chinner wrote:
> On Wed, Aug 14, 2024 at 10:14:01AM +0800, Zhang Yi wrote:
>> On 2024/8/14 9:49, Dave Chinner wrote:
>>> important to know if the changes made actually provided the benefit
>>> we expected them to make....
>>>
>>> i.e. this is the sort of table of results I'd like to see provided:
>>>
>>> platform	base		v1		v2
>>> x86		524708.0	569218.0	????
>>> arm64		801965.0	871605.0	????
>>>
>>
>>  platform	base		v1		v2
>>  x86		524708.0	571315.0 	569218.0
>>  arm64	801965.0	876077.0	871605.0
> 
> So avoiding the lock cycle in iomap_write_begin() (in patch 5) in
> this partial block write workload made no difference to performance
> at all, and removing a lock cycle in iomap_write_end provided all
> that gain?

Yes.

> 
> Is this an overwrite workload or a file extending workload? The
> result implies that iomap_block_needs_zeroing() is returning false,
> hence it's an overwrite workload and it's reading partial blocks
> from disk. i.e. it is doing synchronous RMW cycles from the ramdisk
> and so still calling the uptodate bitmap update function rather than
> hitting the zeroing case and skipping it.
> 
> Hence I'm just trying to understand what the test is doing because
> that tells me what the result should be...
> 

I forgot to mentioned that I test this on xfs with 1K block size, this
is a simple case of block size < folio size that I can direct use
UnixBench.

This test first do buffered append write with bs=1K,count=2000 in the
first round, and then do overwrite from the start position with the same
parameters repetitively in 30 seconds. All the write operations are
block size aligned, so iomap_write_begin() just continue after
iomap_adjust_read_range(), don't call iomap_set_range_uptodate() to set
range uptodate originally, hence there is no difference whether with or
without patch 5 in this test case.

Thanks,
Yi.


