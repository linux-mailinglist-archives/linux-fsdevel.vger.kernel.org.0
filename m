Return-Path: <linux-fsdevel+bounces-76939-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WDsXHsdvjGlmngAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76939-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Feb 2026 13:02:15 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 997C11240C1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Feb 2026 13:02:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D9CA03037406
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Feb 2026 12:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E45AF318EDA;
	Wed, 11 Feb 2026 12:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VKPUqg4k"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC9CB318BA7
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Feb 2026 12:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770811301; cv=none; b=M7xuUYxsS12wbKUdzQNv9sYMT8ETTxnNXehWN/KhxQ83fpD1jRzq1/VELHLMg+ix7rwAzgApVBr4AuxS27g2wpILczoNAXwoSv21vA3juZZXURptnMRfOb0zwrtXNUfmrRKIP4xR1tZeIb9M2l1igHSxS2bRvNlRzIQOSX+uvsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770811301; c=relaxed/simple;
	bh=HUIjgRr8pyUlGBYxv3kHRQuhqqEiXYOKBDCFk6t3bh4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EIJlHVYjz5wrJvWDrmvPyi/QLAGWp4ZEhVUwPZyr+sJg0FrlNIrjFNVHyGf8eFrL7rxgUjhcXosuHexTVQujfcYGXjiP/2Kmu67wgs/eKHr7s7sNMBSWDW2UsIofwkJbCGwdELspgDfGgaJnoh/OQJO7wNFdQjbQF0Ne8AXlz2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VKPUqg4k; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-47ee07570deso47958575e9.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Feb 2026 04:01:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770811298; x=1771416098; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zkPWn0/4hwFjUwyAg6nWUt//DXDat9TtbbMZeyvNbgE=;
        b=VKPUqg4kq1lVED+wvqMSZ9u7QDw0Y9INAivWPT7QdhJ72c0o3QmIAmadKwEnoT5XS4
         2lVpPMjZJt9OyU3DM1AGb8dJkuomUll+KxcDxusxb9ZYbLpAlCS8FuP5ijvmT/s/tEhp
         Rtq3f0qxm+GST+g/HopfWE51mX+sdEe2zwig30Yvb6Zx/vt9LuwmKKlb1KkcQds8gpqO
         J3s9RPoY9Jqsw0EBsKsoPoDdCyCOuNWWP85s2VPRyNMPJLBrx4yVfdvZA4FNMS0dTLD1
         sXdapdCI7hvXXRDTTK9OtM60kS107bZWXN503LeiUJpiOMfh5sOMbnJWl9ZuzzNfwqZg
         traw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770811298; x=1771416098;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zkPWn0/4hwFjUwyAg6nWUt//DXDat9TtbbMZeyvNbgE=;
        b=bUz9qSBqLqOcAewbl/INd7XY3sLs3c9PNpHeZ31tKACye3t/6XYpFX52fq0Wi0UCq3
         IDYTlqvP5OG6lkyt1ehKYzqKd4KBDIVrgKwMKgIyS0d8fY4t3ip1TGYgwnGAuyUW4frC
         nJL27JoKOwnyiwb+jd4MxG4Pjiyr+OaMFxaxdijUMrzBvpPmySCQsWg9Q0uulJ5kNq+9
         ESK+unFycAxmyx+/rbbtHJa2NgHSdrkwVsn86+NsvkypP/L2EDxZLuKCNXZIAltMYEPX
         1dLKYdSC8FN1FmWV0vLHUbQQSOp2+UU4uLFXDwWz+z8hReG2WRdVYk7zEC7z68Jz7Exs
         iMuw==
X-Forwarded-Encrypted: i=1; AJvYcCXqLHfdIXgW88KNq5bYv0mkLLnzQmkbYjCOGn8jR/kxmSHQrKqILUJRuocql7hYfQGyJ2g5Y923LGVwbNB0@vger.kernel.org
X-Gm-Message-State: AOJu0Yxllfgd2AxkVrIVdzgv158DjEWwgmFvZXKkW3aMMInjjefd4TgI
	b8ycq3GmfrGED+qgdfCL9g0ntm1w54/Jk7NRLsPe60m9WrBTmHbvq/AYZ6Fb2Ao1
X-Gm-Gg: AZuq6aL7spTRU5FBeiAFez/ZwoLrE3HmwuIFefguyC2bK6TmbKctI3ALCHSlTnsjQ+J
	Czm6Jc8LN0yw/PFVPBx/YooDEi5LEWeIZBRrYlxIUoe8QrbKaBjN9hIQx1OSKU236b2yowGOnXE
	VKEHrceeUgdf3b6grXOxwEFDFEPuF//j/MpS8xX5FAoeez23RqEKoHrRCsO6Nx+PZMNuQLNkTFf
	DprK4xrrt+X5BX6ovcna9SSXPnBIa3FFj45yh8vEYzfvUmMyG617o4KwCzQJAtzKaknxJT3asVN
	/4BPZNNAn4fjCjew5H9VMF/UZynSA7+yY2r8JKB1g9mj0iKgIipefYHeVq9NMpqynDSvYiLc3O+
	qrRg/I71cjyYH6rjDbukK2wUQqeavvpxpFFKzZMY7ifiS6FW9Qtwr8j9NyKoKGy119YAt4h/QnK
	P0Vpkb4/LlhG74Hxjm/r6SNjkjryyXB09INuC6/It/+nvZlWociqY9FrWCq7nrpfsDDYKBP0dC2
	NHh4weaiEadnmVr93Mps6RRUrMXfVi92p6i+S024DRQZ+8388RVl1edwr0=
X-Received: by 2002:a05:600c:444b:b0:477:7af8:c8ad with SMTP id 5b1f17b1804b1-4835b96ffa9mr32346815e9.31.1770811297778;
        Wed, 11 Feb 2026 04:01:37 -0800 (PST)
Received: from ?IPV6:2620:10d:c096:325:77fd:1068:74c8:af87? ([2620:10d:c092:600::1:b997])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43783d48954sm3882529f8f.12.2026.02.11.04.01.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Feb 2026 04:01:37 -0800 (PST)
Message-ID: <1c657f67-0862-4e13-9c71-7217aeecef61@gmail.com>
Date: Wed, 11 Feb 2026 12:01:35 +0000
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
Cc: axboe@kernel.dk, io-uring@vger.kernel.org, csander@purestorage.com,
 krisman@suse.de, bernd@bsbernd.com, hch@infradead.org,
 linux-fsdevel@vger.kernel.org
References: <20260210002852.1394504-1-joannelkoong@gmail.com>
 <20260210002852.1394504-4-joannelkoong@gmail.com>
 <89c75fc1-2def-4681-a790-78b12b45478a@gmail.com>
 <CAJnrk1ZZyYmwtzcHAnv2x8rt=ZVsz7CXCVV6jtgMMDZytyxp3A@mail.gmail.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <CAJnrk1ZZyYmwtzcHAnv2x8rt=ZVsz7CXCVV6jtgMMDZytyxp3A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-76939-lists,linux-fsdevel=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 997C11240C1
X-Rspamd-Action: no action

On 2/10/26 19:39, Joanne Koong wrote:
> On Tue, Feb 10, 2026 at 8:34 AM Pavel Begunkov <asml.silence@gmail.com> wrote:
...
>>> -/* argument for IORING_(UN)REGISTER_PBUF_RING */
>>> +/* argument for IORING_(UN)REGISTER_PBUF_RING and
>>> + * IORING_(UN)REGISTER_KMBUF_RING
>>> + */
>>>    struct io_uring_buf_reg {
>>> -     __u64   ring_addr;
>>> +     union {
>>> +             /* used for pbuf rings */
>>> +             __u64   ring_addr;
>>> +             /* used for kmbuf rings */
>>> +             __u32   buf_size;
>>
>> If you're creating a region, there should be no reason why it
>> can't work with user passed memory. You're fencing yourself off
>> optimisations that are already there like huge pages.
> 
> Are there any optimizations with user-allocated buffers that wouldn't
> be possible with kernel-allocated buffers? For huge pages, can't the
> kernel do this as well (eg I see in io_mem_alloc_compound(), it calls
> into alloc_pages() with order > 0)?

Yes, there is handful of differences. To name one, 1MB allocation won't
get you a PMD mappable huge page, while user space can allocate 2MB,
register the first 1MB and reuse the rest for other purposes.

>>> +     };
>>>        __u32   ring_entries;
>>>        __u16   bgid;
>>>        __u16   flags;
>>> diff --git a/io_uring/kbuf.c b/io_uring/kbuf.c
>>> index aa9b70b72db4..9bc36451d083 100644
>>> --- a/io_uring/kbuf.c
>>> +++ b/io_uring/kbuf.c
>> ...
>>> +static int io_setup_kmbuf_ring(struct io_ring_ctx *ctx,
>>> +                            struct io_buffer_list *bl,
>>> +                            struct io_uring_buf_reg *reg)
>>> +{
>>> +     struct io_uring_buf_ring *ring;
>>> +     unsigned long ring_size;
>>> +     void *buf_region;
>>> +     unsigned int i;
>>> +     int ret;
>>> +
>>> +     /* allocate pages for the ring structure */
>>> +     ring_size = flex_array_size(ring, bufs, bl->nr_entries);
>>> +     ring = kzalloc(ring_size, GFP_KERNEL_ACCOUNT);
>>> +     if (!ring)
>>> +             return -ENOMEM;
>>> +
>>> +     ret = io_create_region_multi_buf(ctx, &bl->region, bl->nr_entries,
>>> +                                      reg->buf_size);
>>
>> Please use io_create_region(), the new function does nothing new
>> and only violates abstractions.
> 
> There's separate checks needed between io_create_region() and
> io_create_region_multi_buf() (eg IORING_MEM_REGION_TYPE_USER flag

If io_create_region() is too strict, let's discuss that in
examples if there are any, but it's likely not a good idea changing
that. If it's too lax, filter arguments in the caller. IOW, don't
pass IORING_MEM_REGION_TYPE_USER if it's not used.

> checking) and different allocation calls (eg
> io_region_allocate_pages() vs io_region_allocate_pages_multi_buf()).

I saw that and saying that all memmap.c changes can get dropped.
You're using it as one big virtually contig kernel memory range then
chunked into buffers, and that's pretty much what you're getting with
normal io_create_region(). I get that you only need it to be
contiguous within a single buffer, but that's not what you're doing,
and it'll be only worse than default io_create_region() e.g.
effectively disabling any usefulness of io_mem_alloc_compound(),
and ultimately you don't need to care.

Regions shouldn't know anything about your buffers, how it's
subdivided after, etc.

> Maybe I'm misinterpreting your comment (or the code), but I'm not
> seeing how this can just use io_create_region().

struct io_uring_region_desc rd = {};
total_size = nr_bufs * buf_size;
rd.size = PAGE_ALIGN(total_size);
io_create_region(&region, &rd);

Add something like this for user provided memory:

if (use_user_memory) {
	rd.user_addr = uaddr;
	rd.flags |= IORING_MEM_REGION_TYPE_USER;
}


>> Provided buffer rings with kernel addresses could be an interesting
>> abstraction, but why is it also responsible for allocating buffers?
> 
> Conceptually, I think it makes the interface and lifecycle management
> simpler/cleaner. With registering it from userspace, imo there's
> additional complications with no tangible benefits, eg it's not
> guaranteed that the memory regions registered for the buffers are the
> same size, with allocating it from the kernel-side we can guarantee
> that the pages are allocated physically contiguously, userspace setup
> with user-allocated buffers is less straightforward, etc. In general,
> I'm just not really seeing what advantages there are in allocating the
> buffers from userspace. Could you elaborate on that part more?

I don't think I follow. I'm saying that it might be interesting
to separate rings from how and with what they're populated on the
kernel API level, but the fuse kernel module can do the population
and get exactly same layout as you currently have:

int fuse_create_ring(size_t region_offset /* user space argument */) {
	struct io_mapped_region *mr = get_mem_region(ctx);
	// that can take full control of the ring
	ring = grab_empty_ring(io_uring_ctx);

	size = nr_bufs * buf_size;
	if (region_offset + size > get_size(mr)) // + other validation
		return error;

	buf = mr_get_ptr(mr) + offset;
	for (i = 0; i < nr_bufs; i++) {
		ring_push_buffer(ring, buf, buf_size);
		buf += buf_size;
	}
}

fuse might not care, but with empty rings other users will get a
channel they can use to do IO (e.g. read requests) using their
kernel addresses in the future. 	

>> What I'd do:
>>
>> 1. Strip buffer allocation from IORING_REGISTER_KMBUF_RING.
>> 2. Replace *_REGISTER_KMBUF_RING with *_REGISTER_PBUF_RING + a new flag.
>>      Or maybe don't expose it to the user at all and create it from
>>      fuse via internal API.
> 
> If kmbuf rings are squashed into pbuf rings, then pbuf rings will need
> to support pinning. In fuse, there are some contexts where you can't

It'd change uapi but not internals, you already piggy back it
on pbuf implementation and differentiate with a flag.

It could basically be:

if (flags & IOU_PBUF_RING_KM)
	bl->flags |= IOBL_KERNEL_MANAGED;

Pinning can be gated on that flag as well. Pretty likely uapi
and internals will be a bit cleaner, but that's not a huge deal,
just don't see why would you roll out a separate set of uapi
([un]register, offsets, etc.) when essentially it can be treated
as the same thing.

> grab the uring mutex because you're running in atomic context and this
> can be encountered while recycling the buffer. I originally had a
> patch adding pinning to pbuf rings (to mitigate the overhead of
> registered buffers lookups) 

IIRC, you was pinning the registered buffer table and not provided
buffer rings? Which would indeed be a bad idea. Thinking about it,
fwiw, instead of creating multiple registered buffers and trying to
lock the entire table, you could've kept all memory in one larger
registered buffer and pinned only it. It's already refcounted, so
shouldn't have been much of a problem.

> but dropped it when Jens and Caleb didn't
> like the idea. But for kmbuf rings, pinning will be necessary for
> fuse.
> 
>> 3. Require the user to register a memory region of appropriate size,
>>      see IORING_REGISTER_MEM_REGION, ctx->param_region. Make fuse
>>      populating the buffer ring using the memory region.

To explain why, I don't think that creating many small regions
is a good direction going forward. In case of kernel allocation,
it's extra mmap()s, extra user space management, and wasted space.
For user provided memory it's over-accounting and extra memory
footprint. It'll also give you better lifecycle guarantees, i.e.
you won't be able to free buffers while there are requests for the
context. I'm not so sure about ring bound memory, let's say I have
my suspicions, and you'd need to be extra careful about buffer
lifetimes even after a fuse instance dies.

>> I wanted to make regions shareable anyway (need it for other purposes),
>> I can toss patches for that tomorrow.
>>
>> A separate question is whether extending buffer rings is the right
>> approach as it seems like you're only using it for fuse requests and
>> not for passing buffers to normal requests, but I don't see the
> 
> What are 'normal requests'? For fuse's use case, there are only fuse requests.

Any kind of read/recv/etc. that can use provided buffers. It's
where kernel memory filled rings would shine, as you'd be able
to use them together without changing any opcode specific code.
I.e. not changes in read request implementation, only kbuf.c

-- 
Pavel Begunkov


