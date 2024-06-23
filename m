Return-Path: <linux-fsdevel+bounces-22218-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A073F913F0C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jun 2024 01:16:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D91D01C21194
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Jun 2024 23:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED4C7186E21;
	Sun, 23 Jun 2024 23:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hoJ9m5DJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IM8gAc0L"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0BA3185E65;
	Sun, 23 Jun 2024 23:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719184579; cv=none; b=qeInKMx6zi1Ve0DDpVOodOh4ysLCymrQJglJlhzlxlKa9B9u58tyMojKd7D/MReaGRlhMzcrW1mz1CuIvWrsBQVvPWfcYjaD0oRJoDXGr2Z+17iGYcX0odzsp+cDtsAanw+1XZ2xKH0xs4Da3AWhPaSfjDUBO3kz2ztWR9/34MQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719184579; c=relaxed/simple;
	bh=klSscLWgORU9qCXLsS9wOM+PZEcgTp0Av7+cnFnQyio=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kywqXS407lp8aRwGCGqSThIukb8UCXcddKRi7p/3gVkYGWzrWBxiOvHqd8Mj2tJJWdhZsF2g6z4/ReqlVjswcVQvWalf+idu3Vv81expPLEngax3vazw9ahaJtM6qkcq/r8oo2Ev6vQAcTqN1CX/Sd69ZHreH6CF+CQ2mvNuh/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hoJ9m5DJ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IM8gAc0L; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1719184575;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Awfxb6K8YyyiKriFuf6T4876/ylOHxEjEiYm6TdruTc=;
	b=hoJ9m5DJ7CxadEFUBc8Yw75bhjjtIBXWTyZwXsKl3M5gg++/2sD4zfI880ytdCq8HzIMPH
	ggTH5f3dfYmWW+yfQuKgXEbQXGJR7t/wVl6Jc6AAYrwomrB8nnnckjZKRu2MVOsyZ4R28T
	AHOqtwKc53O1dti5K4KQ5jos815JM5z+gLC/LuA/OxxoYwSbiuiZwt+yfD3jezgI6Durtr
	5JTon4K4GJxEJm6n3ZpicI95PbhQUPRfI6Cnvn9MU5L7pYCGCQhFkXvav+hQM01Jhwql2n
	xXzqJYcdiui9xfZDyoIAWqHy9cEFBGMRZ5JzWEWoZHSeb5kwDJm+G70r1xQ77A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1719184575;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Awfxb6K8YyyiKriFuf6T4876/ylOHxEjEiYm6TdruTc=;
	b=IM8gAc0LXIokS5JU7NKxUScCyhyj4TWpOD9X5OJsotej6pOmvtVwVLl55Zq5uuVOvuMEnx
	QiSecQhayyiYIhBA==
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, Jens Axboe
 <axboe@kernel.dk>, brauner@kernel.org, viro@zeniv.linux.org.uk, Bernd
 Schubert <bernd.schubert@fastmail.fm>, linux-mm@kvack.org, Josef Bacik
 <josef@toxicpanda.com>
Subject: Re: [PATCH 3/5] fs: sys_ringbuffer
In-Reply-To: <odohwdryb2yhzi5kzvlwv65kazbhzqyps6fzr2wukksdewukmr@gono7fdsth5d>
References: <20240603003306.2030491-1-kent.overstreet@linux.dev>
 <20240603003306.2030491-4-kent.overstreet@linux.dev> <87frt39ujz.ffs@tglx>
 <odohwdryb2yhzi5kzvlwv65kazbhzqyps6fzr2wukksdewukmr@gono7fdsth5d>
Date: Mon, 24 Jun 2024 01:16:15 +0200
Message-ID: <87a5jb9rnk.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Kent!

On Sun, Jun 23 2024 at 18:21, Kent Overstreet wrote:
> On Mon, Jun 24, 2024 at 12:13:36AM +0200, Thomas Gleixner wrote:
>> > +	/*
>> > +	 * We use u32s because this type is shared between the kernel and
>> > +	 * userspace - ulong/size_t won't work here, we might be 32bit userland
>> > +	 * and 64 bit kernel, and u64 would be preferable (reduced probability
>> > +	 * of ABA) but not all architectures can atomically read/write to a u64;
>> > +	 * we need to avoid torn reads/writes.
>> 
>> union rbmagic {
>> 	u64	__val64;
>>         struct {
>>                 // TOOTIRED: Add big/little endian voodoo
>> 	        u32	__val32;
>>                 u32	__unused;
>>         };
>> };
>> 
>> Plus a bunch of accessors which depend on BITS_PER_LONG, no?
>
> Not sure I follow?
>
> I know biendian machines exist, but I've never heard of both big and
> little endian being used at the same time. Nor why we'd care about
> BITS_PER_LONG? This just uses fixed size integer types.

Read your comment above. Ideally you want to use u64, right?

The problem is that you can't do this unconditionally because of 32-bit
systems which do not support 64-bit atomics.

So a binary which is compiled for 32-bit might unconditionally want the
32-bit accessors. Ditto for 32-bit kernels.

The 64bit kernel where it runs on wants to utilize u64, right?

That's fortunately a unidirectional problem as 64-bit user space cannot
run on a 32-bit kernel ever.

struct ringbuffer_ctrl {
       union rbmagic	head;
...
};

#ifdef __BITS_PER_LONG == 64
static __always_inline u64 read_head(struct ringbuffer_ctrl *rb)
{
        return rb->head.__val64;
}

static __always_inline void write_head(struct ringbuffer_ctrl *rb, u64 val)
{
        rb->head.__val64 = val;
}
#else
static __always_inline u64 read_head(struct ringbuffer_ctrl *rb)
{
        return rb->head.__val32;
}

static __always_inline void write_head(struct ringbuffer_ctrl *rb, u64 val)
{
        rb->head.__val32 = (u32)val;
}
#endif

A 64-bit kernel uses u64 while a 32-bit kernel uses u32. Same for user
space.

The ABA concern for 32-bit does not go away, but for 64-bit userspace
you get what you want, no?

Now why do you have to care about endianess?

union rbmagic {
	u64	__val64;
	struct {
		u32	__val32;
		u32	__unused;
	};
};

works only correctly for LE. But it does not work for BE because BE
obviously requires the u32 members to be in reverse order:

union rbmagic {
	u64	__val64;
	struct {
		u32	__unused;
		u32	__val32;
	};
};

That's a compile time decision. You can't run a BE binary on a LE kernel
or the other way around.

So they have to agree on the endianess, but BE has the reverse byte
order. That's why you need to have another #ifdef there.

Thanks,

        tglx

