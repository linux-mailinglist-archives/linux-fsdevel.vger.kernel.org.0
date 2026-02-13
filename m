Return-Path: <linux-fsdevel+bounces-77139-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CNdLFvAbj2kkJAEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77139-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 13:41:20 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EB0E81361AE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 13:41:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 082E0300D958
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 12:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBC94340286;
	Fri, 13 Feb 2026 12:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OJTCt4jg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D6C534D4CB
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Feb 2026 12:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770986471; cv=none; b=q8R5RYqP631YqqlLOyc9rYwmyWOLVVZW4bxt7aFFd4MC799tJAi6fBA8av9nrS3s3FMBRqHN39tq7E8Ah4s6knHYNJVf7BVk7WLNEYE2Ma6vJ60rehsvlXPZrWmADBvur3dD2eEsu1PwKAtVamiJC1nnKAzdtI/bcpTQbKCWHPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770986471; c=relaxed/simple;
	bh=C3QxlzLnm76HOlE+ksstGgh1DACXGucn/hlzo8CopDs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Su3H9U0P+gp4vqUCSD2EgCEKruEoRtgkrDGiA80uejz2Bau6KCNvf7/otPdcxY/D1LKKbxGBtQ03iklrNFIe0sqMvKVD/4Da3l6VWmCymnK4RuFnl/1GIZ9QPbcLkhyNCcIBvG+BA7QdRXY64XmDJyYICal+ZwkIsOud+cMxGAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OJTCt4jg; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b884a84e622so119890166b.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Feb 2026 04:41:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770986468; x=1771591268; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yzeK2Mvd8UNW+VLQJ4AGhR6CR2m1sGVJWg1Xszvoqm4=;
        b=OJTCt4jghdX32Jug5/Jqg0ivWGjN4xuC8l1ZGcyyhS2VEpeEifLWhNhZLigjhvi5hQ
         4mhShYg6zihOg1iUGzC24LyaSpKXAopBd48idhLMAr4mjC8mULGN8ErvUonlfuiQTtWE
         T6AKtVw8Rc6gvpGUxYop48T8b/4rxD2zUff5PyjQhHrYsPRlPn2WXE209A0O8HCd7hii
         8OUEbZlm1aaCFDuGyXlwylGmVjPVtJ8BAq8jZPLpxnZZb0T2dyUWLr6O98vRA6kHKU35
         8wx3oLmvIdj7LTfZtm9eVt8tM7L74T7VgiJyPeoWSPg5Z62P1I7DYky4XC0KoDF4z0k7
         utQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770986468; x=1771591268;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yzeK2Mvd8UNW+VLQJ4AGhR6CR2m1sGVJWg1Xszvoqm4=;
        b=rxJ7vcU2R9D3LMJEnjerQ+SM6CKNH7iggQOlFIzUaqU2cpZVuHBUDyM2us7WIzvwJw
         DV/zjyYVKm0uqegKt7DEIcHDIfS5E7XXRooZeKX7Ycz1D6G6LkF6kWPMSccberXksf4j
         DFhpCNhmDM8e1UuxKFZx+jkmtlBjITLuMQIF3atqBknw8zRfkrNcU0kwyDnkjqjqSTbs
         gjVdInww3yRyX6KabJsTRvSVW7X0bT96V2FCYIt5byjUYwLErosuIUDkNogbHrtFjfq7
         7r3K+6ZCACELMaVamn94qCHCRpUEcungoE2XvFc4dwBPtjLTCXBk6hl8r39YKIQfjZET
         rh0Q==
X-Forwarded-Encrypted: i=1; AJvYcCXjwFw/HXWsCjx7bg1nx7FIY+N1BQNDG4j1N+7NB1OVkHs5JEycteJCsXIzU9PPtH0eW75JxDwrExvpsi4s@vger.kernel.org
X-Gm-Message-State: AOJu0YxEP3MQWjmrDXsZKB5xNKoNsf1MOftWDjuajvNCM8hV01m8YODJ
	kDPtObDThIQF9vLe6Z9f0cxRVmd+Xz4Wvy5fII+hIGvZbtbh+H5ZQKBd
X-Gm-Gg: AZuq6aIXYCN/h51bOJG67cr+cPcHl+n+VGRwCTfv1j7w6xKcEQ5GLn0GScNNG0xvvsC
	isUlxDPEvEyUyVC89oNR/n7vfi86BU1foWTuEly1526sClCIMQwSKCGWr3rsPhjiZanhMVzDYjc
	ctfdAroShEhFIdyJlIusKZOPMSzE+W5uj03Fw3XndhNftlFZBSdcUdLe1uh3/kl619tIWWxCW26
	11yLtHockPIrQLCIgFYZkH2QIGfNiBuFxH5u7ElQIF1lMnPyl2NywDq/AqfsBHMFNtm145g9oNC
	E3n+vEOSqwFfuQbjb9OP5MMc4O6Go4sN0e3jDDP1tVcbqOsBMJnlz2zfxWwEg26bU8zty+U2VFE
	NyGPoQCSHQvtkHtBCEWiVtxYBxmfWWuftSxzaB+vGzXL6/Kla8DGEoli2i25dR2fPiaMRxFvlcR
	3ICBWPb/aqtqz1Z3OK8JR9NTs2RtZP/HYFaeJ8gyyrttglQXMGMi8P9CvTljPhFquUCjn/OBFd3
	6m7qBDvpHHN7xyaMz4zC5WqH6R23/NrsLcRwT75tVXZWFGeOzdAvLjzzQ==
X-Received: by 2002:a17:906:fe43:b0:b87:fad:442b with SMTP id a640c23a62f3a-b8facca2fb6mr135128366b.3.1770986468044;
        Fri, 13 Feb 2026 04:41:08 -0800 (PST)
Received: from ?IPV6:2620:10d:c096:325:77fd:1068:74c8:af87? ([2620:10d:c092:600::1:8b14])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8fad57accfsm71602966b.16.2026.02.13.04.41.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Feb 2026 04:41:07 -0800 (PST)
Message-ID: <34cf24a3-f7f3-46ed-96be-bf716b2db060@gmail.com>
Date: Fri, 13 Feb 2026 12:41:07 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 03/11] io_uring/kbuf: add support for kernel-managed
 buffer rings
To: Christoph Hellwig <hch@infradead.org>
Cc: Joanne Koong <joannelkoong@gmail.com>, axboe@kernel.dk,
 io-uring@vger.kernel.org, csander@purestorage.com, krisman@suse.de,
 bernd@bsbernd.com, linux-fsdevel@vger.kernel.org
References: <20260210002852.1394504-1-joannelkoong@gmail.com>
 <20260210002852.1394504-4-joannelkoong@gmail.com>
 <89c75fc1-2def-4681-a790-78b12b45478a@gmail.com>
 <aYykILfX_u9-feH-@infradead.org>
 <bd488a4e-a856-4fa5-b2bb-427280e6a053@gmail.com>
 <aY7QX-BIW-SMJ3h_@infradead.org>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <aY7QX-BIW-SMJ3h_@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.dk,vger.kernel.org,purestorage.com,suse.de,bsbernd.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-77139-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
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
X-Rspamd-Queue-Id: EB0E81361AE
X-Rspamd-Action: no action

On 2/13/26 07:18, Christoph Hellwig wrote:
> On Thu, Feb 12, 2026 at 10:44:44AM +0000, Pavel Begunkov wrote:
>>>
>>> Any pages mapped to userspace can be allocated in the kernel as well.
>>
>> pow2 round ups will waste memory. 1MB allocations will never
>> become 2MB huge pages. And there is a separate question of
>> 1GB huge pages. The user can be smarter about all placement
>> decisions.
> 
> Sure.  But if the application cares that much about TLB pressure
> I'd just round up to nice multtiple of PTE levels.
> 
>>
>>> And I really do like this design, because it means we can have a
>>> buffer ring that is only mapped read-only into userspace.  That way
>>> we can still do zero-copy raids if the device requires stable pages
>>> for checksumming or raid.  I was going to implement this as soon
>>> as this series lands upstream.
>>
>> That's an interesting case. To be clear, user provided memory is
>> an optional feature for pbuf rings / regions / etc., and I think
>> the io_uring uapi should leave fields for the feature. However, I
>> have nothing against fuse refusing to bind to buffer rings it
>> doesn't like.
> 
> Can you clarify what you mean with 'pbuf'?  The only fixed buffer API I
> know is io_uring_register_buffers* which always takes user provided
> buffers, so I have a hard time parsing what you're saying there.  But
> that might just be sign that I'm no expert in io_uring APIs, and that
> web searches have degraded to the point of not being very useful
> anymore.

Registered, aka fixed, buffers are the ones you pass to
IORING_OP_[READ,WRITE]_FIXED and some other requests. It's normally
created by io_uring_register_buffers*() / IORING_REGISTER_BUFFERS*
with user memory, but there are special cases when it's installed
internally by other kernel components, e.g. ublk.
This series has nothing to do with them, and relevant parts of
the discussion here don't mention them either.

Provided buffer rings, a.k.a pbuf rings, IORING_REGISTER_PBUF_RING
is a kernel-user shared ring. The entries are user buffers
{uaddr, size}. The user space adds entries, the kernel (io_uring
requests) consumes them and issues I/O using the user addresses.
E.g. you can issue a IORING_OP_RECV request (+IOSQE_BUFFER_SELECT)
and it'll grab a buffer from the ring instead of using sqe->addr.

pbuf rings, IORING_REGISTER_MEM_REGION, completion/submission
queues and all other kernel-user rings/etc. are internally based
on so called regions. All of them support both user allocated
memory and kernel allocations + mmap.

This series essentially creates provided buffer rings, where
1. the ring now contains kernel addresses
2. the ring itself is in-kernel only and not shared with user space
3. it also allocates kernel buffers (as a region), populates the ring
    with them, and allows mapping the buffers into the user space.

Fuse is doing both adding (kernel) buffers to the ring and consuming
them. At which point it's not clear:

1. Why it even needs io_uring provided buffer rings, it can be all
    contained in fuse. Maybe it's trying to reuse pbuf ring code as
    basically an internal memory allocator, but then why expose buffer
    rings as an io_uring uapi instead of keeping it internally.

    That's also why I mentioned whether those buffers are supposed to
    be used with other types of io_uring requests like recv, etc.

2. Why making io_uring to allocate payload memory. The answer to which
    is probably to reuse the region api with mmap and so on. And why
    payload buffers are inseparably created together with the ring
    and via a new io_uring uapi.

    And yes, I believe in the current form it's inflexible, it requires
    a new io_uring uapi. It requires the number of buffers to match
    the number of ring entries, which are related but not the same
    thing. You can't easily add more memory as it's bound to the ring
    object. The buffer memory won't even have same lifetime as the
    ring object -- allow using that km buffer ring with recv requests
    and highly likely I'll most likely give you a way to crash the
    kernel.

But hey, I'm tired. I don't have any beef here and am only trying
to make it a bit cleaner and flexible for fuse in the first place
without even questioning the I/O path. If everyone believes
everything is right, just ask Jens to merge it.

-- 
Pavel Begunkov


