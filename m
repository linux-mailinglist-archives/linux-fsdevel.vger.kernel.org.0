Return-Path: <linux-fsdevel+bounces-77146-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wFM1L/VCj2nCOgEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77146-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 16:27:49 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DAD5137894
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 16:27:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EAAB43070B26
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 15:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95AD3363C66;
	Fri, 13 Feb 2026 15:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mEWTxD3T"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C44B363C62
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Feb 2026 15:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770996414; cv=none; b=YcvcmDFQ3DzeBj7/lb7IahKh11ceaP4dYczW9y3LZ1ntFa/i06tO8kiY8sJN6nSfkjn5D4prf7/pRHBDwZbz8LKwfDQZ2k3RNS2Wiaw2Jq/AvEzmVrvCEwCdpnVP0gsi/Ury5ONesIi8Jb0SnljFcabH9XqCfGjq4km8IlvseZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770996414; c=relaxed/simple;
	bh=ZOS80lbmRMfYa/310ijWUkIiyNNISu16g3TZCTbEzUw=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=AQtPX6j82OdgjdOLjHGyZEzjgDOabs8cuzpCjpy4dV2KS/3qlkHxFs1hpYojT6RGrdG+x3/7KTXz7AoMmSnKix2PfGMTtsBuUpRIPf3euSPjpLYlZxxsBR0Cr8ngMzg6BaaSakK5+HojmxH4S4cac7nVXImackWPwdjaKzWwyeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mEWTxD3T; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-65941c07e8dso1451184a12.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Feb 2026 07:26:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770996411; x=1771601211; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Lx/LOpSFTJ9Gk6MC+hqRpttZmTauQsIbepmZ+nPrmqE=;
        b=mEWTxD3TlBOFjYFDXSjwaxFWdyjpS2u8aWgmQTQx4xnjC/O3LqnAJ19RQlSfRUCmAy
         3kOzkcgDZxvFtQZPFgazYtMDBN5PkC9z7eWFm/NLi7htNmsGhKJrxQMiTakOzr4PiUT6
         Bhm3baU1MF3YLQp55HFlZ8myjc9MHAK534Z99DgOe27ZEfAcgbw8x10ap0Jb817mKjJp
         tKXB9DA26C9DdHqLBEz95Cgx/KnFsNpB1vtOdUw3se2JqGv6f6UivGKLH61k9F5W9swy
         4OUjL7XKokjXX99aSYJORkR1oJQVjaixHpHvksZXU2rbPGI1HgtYKy8JfvuMCDlKoVZt
         /sSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770996411; x=1771601211;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Lx/LOpSFTJ9Gk6MC+hqRpttZmTauQsIbepmZ+nPrmqE=;
        b=WYbvogMPQfgQOiLvYteYtTw0Oufa0azf3XRshRdhT8CF44ia6/d03e/bMzr33VKIVd
         rOfyTp/In93a2gVePfgWtSZBTYr4JdXfz7NU91cT0BjKBwg04UCIChl8UF9Ptc9yMWqW
         G6rE5dtKlSteSQZcxmt9l2PPTeQYS3aeRBSpgJM5AVK+n3QgpdTRsKSvHmAdQa9XqPGT
         75KZVv5zA7V3DTQnKUbNAwkGPQjwHundsZhW6FksDLhXJYmwtBfC09wobgGb+r05LXI+
         zmZP9pl0OJVvbeNWVQQFIQ2psBxJuKvGCsIxE4RZm21kmoTBh55T4Cijzk/84NsCJxSG
         bBjA==
X-Forwarded-Encrypted: i=1; AJvYcCXgmNXsibPct1JGpg9N89N6bEMBn41YOeen/ukRLgo176MhkyAgxoq1JEXDf5+U/ExgVfjZ4LrkrwhIBAsn@vger.kernel.org
X-Gm-Message-State: AOJu0YwcYP6Xmd7r2PtxIGfW55dM5znPuuccrpg6RcG5D1N+VIOkEoBd
	vCnsqBDSwWVb9I8loTOrPgzPC4AN90MQRcKkPJKTzeCVkhtvVoY/bD9I
X-Gm-Gg: AZuq6aKCsONg4pF+Jk1zqv/4gd7cstOf5FKwAMLTHC+b0vilMqzZoq2Wn843emzyfgP
	dWxHIuat3E9LMb17143uknh9WrtO/pVyGrUkmsKMSgIgo+pVkCoGHtoyE61QDJbGtotfxTkr6uj
	eyIvOx+uw0hXsbOrX99zgP0ltmJDcrrWgDUhhRzpvkr2UXjpkCZ9HaPkHo7xeeYccZoCeES4G/I
	6WrBTIObngHfoormrbKlblf8p7/wcaM4tl9lyb1Q0tzNrt+mIKvFe+mnu9lV5HjmlMyymdk/j45
	gGzorunpl808JLc6ZUTqkYI7X4/UWOfEsznAP3kzWEKHfJGauOibZzEfoHwJAaJ/EGvGAtxy/Bs
	56NepREY9p2MkjGi8zldzmwoh1b7vKcm4nr/tjqeF4sklD2lSmNjUhe0j61BAjyfa/l+RJ7WP9n
	pSV01Dzonb3Cn4JDzk3FkcNvSne6EI+BMCNeheBRM893KCf7uz86RWZlJT2xn3z0g004CTu/hjp
	4nJ9VVLjSnsCxPu4iQ5/IxoY2pbLB/5CmjihWHLR/N82u5WSONtFSB/rw==
X-Received: by 2002:a05:6402:5109:b0:658:d541:968f with SMTP id 4fb4d7f45d1cf-65bb13aa719mr968905a12.21.1770996410603;
        Fri, 13 Feb 2026 07:26:50 -0800 (PST)
Received: from ?IPV6:2620:10d:c096:325:77fd:1068:74c8:af87? ([2620:10d:c092:600::1:c974])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-65bad3e390bsm745971a12.17.2026.02.13.07.26.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Feb 2026 07:26:50 -0800 (PST)
Message-ID: <43f34edf-6a34-4afb-b0a3-0d81ec037a96@gmail.com>
Date: Fri, 13 Feb 2026 15:26:50 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Pavel Begunkov <asml.silence@gmail.com>
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
 <1c657f67-0862-4e13-9c71-7217aeecef61@gmail.com>
 <CAJnrk1YXmxqUnT561-J7seaicxFRJTyJ=F3_MX1rmtAROC6Ybg@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAJnrk1YXmxqUnT561-J7seaicxFRJTyJ=F3_MX1rmtAROC6Ybg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-77146-lists,linux-fsdevel=lfdr.de];
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
X-Rspamd-Queue-Id: 5DAD5137894
X-Rspamd-Action: no action

On 2/11/26 22:06, Joanne Koong wrote:
> On Wed, Feb 11, 2026 at 4:01 AM Pavel Begunkov <asml.silence@gmail.com> wrote:
>> On 2/10/26 19:39, Joanne Koong wrote:
>>> On Tue, Feb 10, 2026 at 8:34 AM Pavel Begunkov <asml.silence@gmail.com> wrote:
...
>>> checking) and different allocation calls (eg
>>> io_region_allocate_pages() vs io_region_allocate_pages_multi_buf()).
>>
>> I saw that and saying that all memmap.c changes can get dropped.
>> You're using it as one big virtually contig kernel memory range then
>> chunked into buffers, and that's pretty much what you're getting with
>> normal io_create_region(). I get that you only need it to be
>> contiguous within a single buffer, but that's not what you're doing,
>> and it'll be only worse than default io_create_region() e.g.
>> effectively disabling any usefulness of io_mem_alloc_compound(),
>> and ultimately you don't need to care.
> 
> When I originally implemented it, I had it use
> io_region_allocate_pages() but this fails because it's allocating way
> too much memory at once. For fuse's use case, each buffer is usually
> at least 1 MB if not more. Allocating the memory one buffer a time in
> io_region_allocate_pages_multi_buf() bypasses the allocation errors I
> was seeing. That's the main reason I don't think this can just use
> io_create_region().

Let's fix that then. For now, just work it around by wrapping
into a loop.

Btw, I thought you're going to use it for metadata like some
fuse headers and payloads would be zero copied by installing
it as registered buffers.

...
>>>> Provided buffer rings with kernel addresses could be an interesting
>>>> abstraction, but why is it also responsible for allocating buffers?
>>>
>>> Conceptually, I think it makes the interface and lifecycle management
>>> simpler/cleaner. With registering it from userspace, imo there's
>>> additional complications with no tangible benefits, eg it's not
>>> guaranteed that the memory regions registered for the buffers are the
>>> same size, with allocating it from the kernel-side we can guarantee
>>> that the pages are allocated physically contiguously, userspace setup
>>> with user-allocated buffers is less straightforward, etc. In general,
>>> I'm just not really seeing what advantages there are in allocating the
>>> buffers from userspace. Could you elaborate on that part more?
>>
>> I don't think I follow. I'm saying that it might be interesting
>> to separate rings from how and with what they're populated on the
>> kernel API level, but the fuse kernel module can do the population
> 
> Oh okay, from your first message I (and I think christoph too) thought
> what you were saying is that the user should be responsible for
> allocating the buffers with complete ownership over them, and then
> just pass those allocated to the kernel to use. But what you're saying
> is that just use a different way for getting the kernel to allocate
> the buffers (eg through the IORING_REGISTER_MEM_REGION interface). Am
> I reading this correctly?

The main point is disentangling memory allocation from ring
creation in the io_uring uapi, and moving ring population
into fuse instead of doing it at creation. And it'll still be
populated by the kernel (fuse), user space doesn't have access
to the ring. IORING_REGISTER_MEM_REGION is just the easiest way
to achieve that without any extra uapi.

...
>> Pinning can be gated on that flag as well. Pretty likely uapi
>> and internals will be a bit cleaner, but that's not a huge deal,
>> just don't see why would you roll out a separate set of uapi
>> ([un]register, offsets, etc.) when essentially it can be treated
>> as the same thing.
> 
> imo, it looked cleaner as a separate api because it has different
> expectations and behaviors and squashing kmbuf into the pbuf api makes
> the pbuf api needlessly more complex. Though I guess from the

It appeared to me that they're different because of special
region path and embedded buffer allocations, and otherwise
differences would be minimal. But if you think it's still
better to be made as a separate opcode, I'm not opposing it,
go for it.

> userspace pov, liburing could have a wrapper that takes care of
> setting up the pbuf details for kernel-managed pbufs. But in my head,
> having pbufs vs. kmbufs makes it clearer what each one does vs regular
> pbufs vs. pbufs that are kernel-managed.
> 
> Especially with now having kmbufs go through the ioring mem region
> interface, it makes things more confusing imo if they're combined, eg
> pbufs that are kernel-managed are created empty and then populated
> from the kernel side by whatever subsystem is using them. Right now
> there's only one mem region supported per ring, but in the future if
> there's the possibility that multiple mem regions can be registered

That shouldn't be a problem

> (eg if userspace doesn't know upfront what mem region length they'll
> need), then we should also probably add in a region id param for the
> registration arg, which if kmbuf rings go through the pbuf ring
> registration api, is not possible to do.

Not having patches using the functionality is inconvenient. How
fuse looks up the buffer ring from io_uring? I could imagine you
have some control path io-uring command:

case FUSE_CMD_BIND_BUFFER_RING:
	return bind_queue(params);

Then you can pass all necessary parameters to it, pseudo code:

struct fuse_bind_kmbuf_ring_params {
	region_id;
	buf_ring_id;
	...
};

bind_queue(cmd, struct fuse_bind_kmbuf_ring_params *p)
{
	region = io_uring_get_region(cmd, p->region_id);
	// get exclusive access:
	buf_ring = io_uring_get_buf_ring(cmd, p->buf_ring_id);

	if (!validate_buf_ring(buf_ring))
		return NOTSUPPORTED;

	io_uring_pin(buf_ring);
	fuse_populate_buf_ring(buf_ring, region, ...);
}

Does that match expectations? I don't think you even need
the ring part exposed as an io_uring uapi, tbh, as it
stays completely in fuse and doesn't meaningfully interact
with the rest of io_uring.

...
>>>> 3. Require the user to register a memory region of appropriate size,
>>>>       see IORING_REGISTER_MEM_REGION, ctx->param_region. Make fuse
>>>>       populating the buffer ring using the memory region.
>>
>> To explain why, I don't think that creating many small regions
>> is a good direction going forward. In case of kernel allocation,
>> it's extra mmap()s, extra user space management, and wasted space.
> 
> To clarify, is this in reply to why the individual buffers shouldn't
> be allocated separately by the kernel?

That was about an argument for using IORING_REGISTER_MEM_REGION
instead a separate region. And it's separate from whether
buffers should be bound to the ring.

> I added a comment about this above in the discussion about
> io_region_allocate_pages_multi_buf(), and if the memory allocation
> issue I was seeing is bypassable and the region can be allocated all
> at once, I'm happy to make that change. With having the allocation be
> separate buffers though, I'm not sure I agree that there are extra
> mmaps / userspace management. All the pages across the buffers are
> vmapped together and the userspace just needs to do 1 mmap call for
> them. On the userspace side, I don't think there's more management
> since the mmapped address represents the range across all the buffers.
> I'm not seeing how there's wasted space either since the only

I shouldn't affect you much since you have such large buffers,
but imagine the total allocation size is not being pow2, and
the kernel allocating it as a single folio. E.g. 3 buffers,
0.5 MB each, total = 1.5MB, and the kernel allocates a 2MB
huge page.

-- 
Pavel Begunkov


