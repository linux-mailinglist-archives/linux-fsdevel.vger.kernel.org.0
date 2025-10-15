Return-Path: <linux-fsdevel+bounces-64291-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 812B2BE02E2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Oct 2025 20:29:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2D1443559C7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Oct 2025 18:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C36523254BC;
	Wed, 15 Oct 2025 18:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="JsGnA7DW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7DFD32548C
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 Oct 2025 18:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760552950; cv=none; b=flBVFwkn1wxV1/TZv5Sk3L/SensvH7Q/Ga4rCb3XJpRyU9hX3fpDVa5Bnjc0YqYVin6tB9iTU8UpRkOFxNmH8kG9m/vAN1qjR4rZwgoCz/4W64LCRswxLIcc3oiTKiMUAKPQweCyfTw5HkR9QaHJpL0VVaQkP6LXiQeHKYHXRjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760552950; c=relaxed/simple;
	bh=wbibfM4ofUcZSoS7gjDUyO0kU/LntBZDbIXEHP19UxI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=GnDMAffJ+ubvVCw7yqlL0wllKv8O6TAV8SnQxAHv3HXeONk1PvJ7uFiIQp4VrR0X4SVElfgt55QdXZloiAfs1AXDhrl2ULxGu1Io+ozesSDDWh37+JS2IFtDLPTC73uUroypcPdv2xgjRdBzFRkfoBTHjKZ5moMQCC2BOVhd4L4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=JsGnA7DW; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1760552935; h=Message-ID:Date:MIME-Version:Subject:From:To:Content-Type;
	bh=qz9uDYR0DquZkRGYyrL49gP8UBnrp4Wf+axv8IFVOvE=;
	b=JsGnA7DW3zEqog4pHk0kF3TJ10Q2ClrnoGUNkdIwE6CskHXJB8utHJecv5e3fW5qqj+9auWA8CrZL6FQ8J9znmfQYT4Mw5goWras6lL2ROV2hidSKb4il+bcAFnp/rUxvjp/OrifwKe9c3zaHbBEn+agW/PoZeu7no3E1P09yHc=
Received: from 30.134.15.121(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WqHFMMC_1760552933 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 16 Oct 2025 02:28:54 +0800
Message-ID: <cff53c73-f050-44e2-9c61-96552c0e85ab@linux.alibaba.com>
Date: Thu, 16 Oct 2025 02:28:53 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/9] iomap: account for unaligned end offsets when
 truncating read range
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>, brauner@kernel.org,
 djwong@kernel.org, bfoster@redhat.com, linux-fsdevel@vger.kernel.org,
 kernel-team@meta.com
References: <20251009225611.3744728-1-joannelkoong@gmail.com>
 <20251009225611.3744728-2-joannelkoong@gmail.com>
 <aOxrXWkq8iwU5ns_@infradead.org>
 <CAJnrk1YpsBjfkY0_Y+roc3LzPJw1mZKyH-=N6LO9T8qismVPyQ@mail.gmail.com>
 <a8c02942-69ca-45b1-ad51-ed3038f5d729@linux.alibaba.com>
 <CAJnrk1aEy-HUJiDVC4juacBAhtL3RxriL2KFE+q=JirOyiDgRw@mail.gmail.com>
 <c3fe48f4-9b2e-4e57-aed5-0ca2adc8572a@linux.alibaba.com>
In-Reply-To: <c3fe48f4-9b2e-4e57-aed5-0ca2adc8572a@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2025/10/16 02:06, Gao Xiang wrote:
> 
> 
> On 2025/10/16 01:49, Joanne Koong wrote:
>> On Wed, Oct 15, 2025 at 10:40 AM Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
>>>
>>> On 2025/10/16 01:34, Joanne Koong wrote:
>>>> On Sun, Oct 12, 2025 at 8:00 PM Christoph Hellwig <hch@infradead.org> wrote:
>>>>>
>>>>> On Thu, Oct 09, 2025 at 03:56:03PM -0700, Joanne Koong wrote:
>>>>>> The end position to start truncating from may be at an offset into a
>>>>>> block, which under the current logic would result in overtruncation.
>>>>>>
>>>>>> Adjust the calculation to account for unaligned end offsets.
>>>>>
>>>>> Should this get a fixes tag?
>>>>
>>>> I don't think this needs a fixes tag because when it was originally
>>>> written (in commit 9dc55f1389f9 ("iomap: add support for sub-pagesize
>>>> buffered I/O without buffer heads") in 2018), it was only used by xfs.
>>>> think it was when erofs started using iomap that iomap mappings could
>>>> represent non-block-aligned data.
>>>
>>> What non-block-aligned data exactly? erofs is a strictly block-aligned
>>> filesystem except for tail inline data.
>>>
>>> Is it inline data? gfs2 also uses the similar inline data logic.
>>
>> This is where I encountered it in erofs: [1] for the "WARNING in
>> iomap_iter_advance" syz repro. (this syzbot report was generated in
>> response to this patchset version [2]).
>>
>> When I ran that syz program locally, I remember seeing pos=116 and length=3980.
> 
> I just ran the C repro locally with the upstream codebase (but I
> didn't use the related Kconfig), and it doesn't show anything.
> 
> I feel strange why pos is unaligned, does this warning show
> without your patchset on your side?

I've confirmed that it's a valid IOMAP_INLINE extent returned by
.iomap_begin():

iomap {offset 0 length 116 type 4(IOMAP_INLINE) addr 1184}

Because INLINE extent can return unaligned lengths, and the
new warning is unexpected.

If it's a regression out of iomap itself or out of the new
patchset, please add "fixes" tag.

Thanks,
Gao Xiang

> 
> Thanks,
> Gao Xiang
> 
>>
>> Thanks,
>> Joanne
>>
>> [1] https://ci.syzbot.org/series/6845596a-1ec9-4396-b9c4-48bddc606bef
>> [2] https://lore.kernel.org/linux-fsdevel/68ca71bd.050a0220.2ff435.04fc.GAE@google.com/
>>
>>>
>>> Thanks,
>>> Gao Xiang
>>>

