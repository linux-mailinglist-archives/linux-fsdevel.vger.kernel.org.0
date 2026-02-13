Return-Path: <linux-fsdevel+bounces-77152-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cFs1GA5Rj2nnPgEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77152-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 17:27:58 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A83E5137F16
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 17:27:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 80E00300EF8B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 16:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8EB4239E6C;
	Fri, 13 Feb 2026 16:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nriOc/hv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0506225775
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Feb 2026 16:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771000068; cv=none; b=Vf8fNBHXSIM0fpgNOPWXI7+oqgvLzZa+tyV0h4F01lIQoOp72i7aR9MXwPQQ4n6qNl4pnFtAyTLoliwPquP42278ARbfBuKiFabQ+l3cCbzlvS5Kft1FPh5gi4EbStxqddAq9kcSct2w+kyCCxgMHuDauLEhhnbWFFBWz3y+q+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771000068; c=relaxed/simple;
	bh=h93AKSTKzi5zEuindQhhmx04N9ZUYnakNHWeCWjpQrY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WSpDMvEON/6RvEt5g7wpwBiviMYuDJZMdRnAZzU2oM38ssuZKt+IaitQ8v92CXw0tRM7NJzjKlZL/pJugBJIzLSh+1mAq2g4eUxNIiQNNXxtsHOgggDhq1gCSay1mPLapRaP5RYDBXt965nyAlsvE6i/l8cvQI3FY5fQRpC5mRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nriOc/hv; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-48378136adcso3178895e9.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Feb 2026 08:27:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771000065; x=1771604865; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VBGU4idcpky/R9won3MMlrbrb5JjRsUVw3j0JK145eM=;
        b=nriOc/hv1aGjlmVivrJ/s/I2hLOAV9k1cqw//BIVfL+0QKnwEHS7Z/2hQi691nlaTv
         GA3SGvvSyMepmnJKLwk/XK5xJYCq3zR0NLYZ+GbHGpk4tkLegWZdkx253nnozHv/tkwn
         XXQfXDZort/+RtIADEBwRpqTKOmNo/MY6J50S5MFr7Quh3JNE2L66kY4p9hvq1Rkqozw
         hXdARdd1aLE3ZV1qFPZ212ADCUIc38BC4YtydX3cBPr5E8IVnqvylIoPCtNUoKxv7Qq3
         tiwxwL4dTLo5BNPT/6VFMh2O3Ez0S0dxhIZf9XEsyh55idbuTgv5pgMAAjKv41n1LknO
         Va/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771000065; x=1771604865;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VBGU4idcpky/R9won3MMlrbrb5JjRsUVw3j0JK145eM=;
        b=UODjIgKwJOqoRtA0FMeWpmDqVDVV8axPopHMuYy57GSH57/GB0D8qv/H59HcBm/Kdt
         fQr7nagZYA3nMa/LvYSLs5GA5NkHz/S3OmWrtcxsyhFq+EUz1LJUJBtR9WflAu120bJ7
         PhCqAMAYoA9EgdjRn0+JkNkO2FrkmQVNY9Oxp+/0ufPyejld2t0p98BFcIA0f00z4C3K
         7VA8om3vp58RxJa3ecqcBrfbe6VjpqGhEdhUK7t6ZVdsRPaAIuYEjvc30w9ZTCwNjx6P
         QZCVZ2b/1kRwk5F5Pq4PBJRi3SkdmHssKCLWKxv4BLMy9CZk0Jp9J3b6DEnEWk7asCcK
         3tHA==
X-Forwarded-Encrypted: i=1; AJvYcCVwo9TVR8aAwx24MAxS0RdCraJ/R51lwTteTEaTDABz9dKgrnah9N5kNEFo19ePx4bp0C76FvIRUf3jb5lk@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8uVSnua/nXC8t2F9H1hX5SphIu4t0KTav08fsb6E4GGWUhO9P
	E15e27PaphW1BYeLzPQuePQSrhJtXiPShKnj/vILoshJhPXgSA8np7fP
X-Gm-Gg: AZuq6aI3fy9kXi1QmEDr53BUgIlkRjptPlknAo8hS8GS6VcmmyCIAn7ubi8ZuhBwOjS
	WzyaidT7Kkx4duesU/pDiiRMWOo1SQskR4tf9jpgoHZ2SxfPAlyzzBMZKMzI+WnYOsqeCKUln2n
	P55QVxcldjpWBwd6MT3V95DT3pv6YoxLlY7guz1amsgdT0zzNg0uGknkapjAe1/QBTba3a/gZYH
	4KFnCG4egbFjmNFWKUb5iyLExb3jqJc5xbQXyrJTabJPiiBWi+xZikPFc8py0eIAvzcGN+SA07L
	GSs7Y74rmA8s7XR9xLoGYGIc+KPb3YlYnDPzoa00T3ZS0iDhosVSv2Xl6JTmaZaBSlLq3iyJgiL
	QzfKgaogisRFxObE5p/Vx9awAQUWVQ8pOnLl76yget0VxrUMbDkel11xng6/kg7uvS5ir/1GnrT
	ufHgZWP3A/S8YlZfZBLtq/SZYomJWuK9pw9DS2jLBMhuxORIiSCFcZAa04VtPIyURPtYfYwpOac
	WQ+2R9CmhPK0BUo+nfS5wJXVESHqmFKP5U25/gHmmHw50OiOfmb4Yip5Q==
X-Received: by 2002:a05:600c:314f:b0:47e:e807:a05a with SMTP id 5b1f17b1804b1-48373a7b22dmr37445155e9.33.1771000064894;
        Fri, 13 Feb 2026 08:27:44 -0800 (PST)
Received: from ?IPV6:2620:10d:c096:325:77fd:1068:74c8:af87? ([2620:10d:c092:600::1:c974])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4834d930902sm239682835e9.15.2026.02.13.08.27.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Feb 2026 08:27:44 -0800 (PST)
Message-ID: <cecca7f8-064b-475e-b887-057891377b87@gmail.com>
Date: Fri, 13 Feb 2026 16:27:44 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 03/11] io_uring/kbuf: add support for kernel-managed
 buffer rings
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>, axboe@kernel.dk,
 io-uring@vger.kernel.org, csander@purestorage.com, krisman@suse.de,
 bernd@bsbernd.com, linux-fsdevel@vger.kernel.org
References: <20260210002852.1394504-1-joannelkoong@gmail.com>
 <20260210002852.1394504-4-joannelkoong@gmail.com>
 <89c75fc1-2def-4681-a790-78b12b45478a@gmail.com>
 <CAJnrk1ZZyYmwtzcHAnv2x8rt=ZVsz7CXCVV6jtgMMDZytyxp3A@mail.gmail.com>
 <1c657f67-0862-4e13-9c71-7217aeecef61@gmail.com>
 <CAJnrk1YXmxqUnT561-J7seaicxFRJTyJ=F3_MX1rmtAROC6Ybg@mail.gmail.com>
 <aY2mdLkqPM0KfPMC@infradead.org>
 <809cd04b-007b-46c6-9418-161e757e0e80@gmail.com>
 <CAJnrk1Y6YSw6Rkdh==RfL==n4qEYrrTcdbbS32sBn12jaCoeXg@mail.gmail.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <CAJnrk1Y6YSw6Rkdh==RfL==n4qEYrrTcdbbS32sBn12jaCoeXg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-77152-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[asmlsilence@gmail.com,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A83E5137F16
X-Rspamd-Action: no action

On 2/12/26 17:29, Joanne Koong wrote:
> On Thu, Feb 12, 2026 at 2:52 AM Pavel Begunkov <asml.silence@gmail.com> wrote:
>>
>> On 2/12/26 10:07, Christoph Hellwig wrote:
>>> On Wed, Feb 11, 2026 at 02:06:18PM -0800, Joanne Koong wrote:
>>>>> I don't think I follow. I'm saying that it might be interesting
>>>>> to separate rings from how and with what they're populated on the
>>>>> kernel API level, but the fuse kernel module can do the population
>>>>
>>>> Oh okay, from your first message I (and I think christoph too) thought
>>>> what you were saying is that the user should be responsible for
>>>> allocating the buffers with complete ownership over them, and then
>>>> just pass those allocated to the kernel to use. But what you're saying
>>>> is that just use a different way for getting the kernel to allocate
>>>> the buffers (eg through the IORING_REGISTER_MEM_REGION interface). Am
>>>> I reading this correctly?
>>>
>>> I'm arguing exactly against this.  For my use case I need a setup
>>> where the kernel controls the allocation fully and guarantees user
>>> processes can only read the memory but never write to it.  I'd love
> 
> By "control the allocation fully" do you mean for your use case, the
> allocation/setup isn't triggered by userspace but is initiated by the
> kernel (eg user never explicitly registers any kbuf ring, the kernel
> just uses the kbuf ring data structure internally and users can read
> the buffer contents)? If userspace initiates the setup of the kbuf
> ring, going through IORING_REGISTER_MEM_REGION would be semantically
> the same, except the buffer allocation by the kernel now happens
> before the ring is created and then later populated into the ring.
> userspace would still need to make an mmap call to the region and the
> kernel could enforce that as read-only. But if userspace doesn't
> initiate the setup, then going through IORING_REGISTER_MEM_REGION gets
> uglier.
> 
>>> to be able to piggy back than onto your work.
>>
>> IORING_REGISTER_MEM_REGION supports both types of allocations. It can
>> have a new registration flag for read-only, and then you either make
>> the bounce avoidance optional or reject binding fuse to unsupported
>> setups during init. Any arguments against that? I need to go over
>> Joanne's reply, but I don't see any contradiction in principal with
>> your use case.
> 
> So i guess the flow would have to be:
> a) user calls io_uring_register_region(&ring, &mem_region_reg) with
> mem_region_reg.region_uptr's size field set to the total buffer size
> (and mem_region_reg.flags read-only bit set if needed)
>       kernel allocates region
> b) user calls mmap() to get the address of the region. If read-only
> bit was set, it gets a read-only address
> c) user calls io_uring_register_buf_ring(&ring, &buf_reg, flags) with
> buf_reg.flags |= IOU_PBUF_RING_KERNEL_MANAGED
>       kernel creates an empty kernel-managed ring. None of the buffers
> are populated
> d) user tells X subsystem to populate the ring starting from offset Z
> in the registered mem region
> e) on the kernel side, the subsystem populates the ring starting from
> offset Z, filling it up using the buf_size and ring_entries values
> that the user registered the ring with in c)
> 
> To be completely honest, the more I look at this the more this feels
> like overkill / over-engineered to me. I get that now the user can do
> the PMD optimization, but does that actually lead to noticeable
> performance benefits? It seems especially confusing with them going

No, it's mainly about not keeping payload buffers and rings in the same
object from the io_uring uapi perspective.

1. If it's an io_uring uapi, it shouldn't be fuse specific or with
a bunch of use case specific expectations attached. Why does it
require all buffers to be uniform in size? Why does it require
the ring size to match the number of buffers? Why does it require
buffers to be allocated by io_uring in the first place? Maybe some
subsystem got memory from somewhere else and wants to do use it
with io_uring. Why does it need to know the total size at creation,
and what would you do if you want to add more memory at runtime
while using the same ring?

2. If it's meant to be fuse specific and _not_ used with other requests
like recv/read/etc., then what's the point of having it as an io_uring
uapi? Which also adds additional trouble like the once you're solving
with pinning.

If it's supposed to be used with other requests, then buffers and
rings will have different in-kernel lifetime expectations imposed
by io_uring, so having them together won't even help with
management.

I have a strong opinion about the memmap.c change. For the
rest, if you believe it's fine, just send it out and let Jens
decide.

> through the same pbuf ring interface but having totally different
> expectations.

It's predicated on separating buffers from rings, see above,
and assuming that I'm not sure what expectations are different
apart from one being in-kernel with kernel addresses and the
other user visible with user addresses.

-- 
Pavel Begunkov


