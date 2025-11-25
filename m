Return-Path: <linux-fsdevel+bounces-69729-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C1CF0C83B56
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Nov 2025 08:26:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B4E174E51C8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Nov 2025 07:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33E7B2D8DA8;
	Tue, 25 Nov 2025 07:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ajmyGoTx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08BB1284894;
	Tue, 25 Nov 2025 07:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764055607; cv=none; b=brlwTWdjHa8Og4r2+vqrts2I+6NC23w//nT8dwERW/pI+fQSZrzsmN1Zo30q6k74IyUd4emPQMHeaam7TT1+tagFOxfbDZ/+QHYipetQiv1TxADLVk2nb+ngpN9VMzd0EUc7dSsriimR7iVl+WnMBeeUfNCOQvSNVsXhai4IyI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764055607; c=relaxed/simple;
	bh=9mdsxCvmPORP6x/kkAzRpRo8wfCkIdAbgUXDrADFtXc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m6I6jlFvUXebfo72ysMhsgTLZ3ruAstK7aJ8PL5xwDKBYS07rP3pq3Sxn8CL68SIthDx5xJJU4if8yzzZuHy568nVoWejmzIrICFzaWWMzqUcJEmVn22oVjYVYabrP8JcbfsCmrPNJHJUHzoNJBttZZ7Vhm+1Fh0Zq4+RZE4vus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ajmyGoTx; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1764055601; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=0Uxmp0g/ndfq0DIx8Uvjc1YRe5YIKKC7/SKltPqqPDU=;
	b=ajmyGoTxfmBiII1MGqSsORXnwXaD9QVbnD3sUtDvorwLjzp+FotHgCWhHE+6Y4w0HUZXTh0fd0iXZtoL3K0gTq61MDw07gGo3yUKyETEm731Gd/XkXppjLKDFj1YGj8hO6aZ/cD2WH3Tmd6qjl3nPIn6zazYSuHdDi+iz+FE738=
Received: from 30.221.132.26(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WtMd-uA_1764055600 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 25 Nov 2025 15:26:40 +0800
Message-ID: <db90b7b3-bf94-4531-8329-d9e0dbc6a997@linux.alibaba.com>
Date: Tue, 25 Nov 2025 15:26:39 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: calling into file systems directly from ->queue_rq, was Re:
 [PATCH V5 0/6] loop: improve loop aio perf by IOCB_NOWAIT
To: Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@infradead.org>
Cc: linux-block@vger.kernel.org, Mikulas Patocka <mpatocka@redhat.com>,
 Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
 Dave Chinner <dchinner@redhat.com>, linux-fsdevel@vger.kernel.org,
 Jens Axboe <axboe@kernel.dk>
References: <20251015110735.1361261-1-ming.lei@redhat.com>
 <aSP3SG_KaROJTBHx@infradead.org> <aSQfC2rzoCZcMfTH@fedora>
 <aSQf6gMFzn-4ohrh@infradead.org> <aSUbsDjHnQl0jZde@fedora>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <aSUbsDjHnQl0jZde@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Ming and Christoph,

On 2025/11/25 11:00, Ming Lei wrote:
> On Mon, Nov 24, 2025 at 01:05:46AM -0800, Christoph Hellwig wrote:
>> On Mon, Nov 24, 2025 at 05:02:03PM +0800, Ming Lei wrote:
>>> On Sun, Nov 23, 2025 at 10:12:24PM -0800, Christoph Hellwig wrote:
>>>> FYI, with this series I'm seeing somewhat frequent stack overflows when
>>>> using loop on top of XFS on top of stacked block devices.
>>>
>>> Can you share your setting?
>>>
>>> BTW, there are one followup fix:
>>>
>>> https://lore.kernel.org/linux-block/20251120160722.3623884-1-ming.lei@redhat.com/
>>>
>>> I just run 'xfstests -q quick' on loop on top of XFS on top of dm-stripe,
>>> not see stack overflow with the above fix against -next.
>>
>> This was with a development tree with lots of local code.  So the
>> messages aren't applicable (and probably a hint I need to reduce my
>> stack usage).  The observations is that we now stack through from block
>> submission context into the file system write path, which is bad for a
>> lot of reasons.  journal_info being the most obvious one.
>>
>>>> In other words:  I don't think issuing file system I/O from the
>>>> submission thread in loop can work, and we should drop this again.
>>>
>>> I don't object to drop it one more time.
>>>
>>> However, can we confirm if it is really a stack overflow because of
>>> calling into FS from ->queue_rq()?
>>
>> Yes.
>>
>>> If yes, it could be dead end to improve loop in this way, then I can give up.
>>
>> I think calling directly into the lower file system without a context
>> switch is very problematic, so IMHO yes, it is a dead end.
I've already explained the details in
https://lore.kernel.org/r/8c596737-95c1-4274-9834-1fe06558b431@linux.alibaba.com

to zram folks why block devices act like this is very
risky (in brief, because virtual block devices don't
have any way (unlike the inner fs itself) to know enough
about whether the inner fs already did something without
context save (a.k.a side effect) so a new task context
is absolutely necessary for virtual block devices to
access backing fses for stacked usage.

So whether a nested fs can success is intrinsic to
specific fses (because either they assure no complex
journal_info access or save all effected contexts before
transiting to the block layer.  But that is not bdev can
do since they need to do any block fs.

But they seem they don't get any point, so I gave up.

Thanks,
Gao Xiang


