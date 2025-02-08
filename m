Return-Path: <linux-fsdevel+bounces-41302-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7FD3A2D991
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Feb 2025 00:05:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFB811886C35
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Feb 2025 23:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D82B243393;
	Sat,  8 Feb 2025 23:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ahrljPBF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0997D243369;
	Sat,  8 Feb 2025 23:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739055906; cv=none; b=DMK9BY0vIrMh1V3IiDVXdnpzeL5ViwNvC4z+SrPGK91mNPvNekMblCvJ15UTCbugUfaHlCmM+DsjDiqVEqk0qix6cDFunXp6KAY+Qj2EmXhasivrWlwkQvRTgtZ6Zav311oEOf9TZGNvu9d0JN9AXacesLkEMmwfEhMssSZxIzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739055906; c=relaxed/simple;
	bh=JKUGn4Qoq9C5pcGlPkGhe7+elclkJ83B4uplIMzEjU8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JZ8X3YGextM6lIshS4S/zyd2xzEhQLWI2pwKRVdD0uAsqV34EGDHdwpMAszG1QxwnRuJnaAoAZsyOwp3ul6ZKQ47MXYAI4TxDArUaTT5Xwf5ocPB97hF4wFoBQ+yB3U3AJxzv75Wufi/AZpquiD7a+AjqMz77oefcxA14z/CMQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ahrljPBF; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-436341f575fso38118435e9.1;
        Sat, 08 Feb 2025 15:05:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739055903; x=1739660703; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jx+hNvPmHOpHVq9VFKq5DNfIsRdCbXvYRGw+9lYGTxQ=;
        b=ahrljPBFXMc9YhV3UKNwDYh27S/RQKt6jwYNcEpyT86GWCIXunRNCUrFEweNQo02dU
         YCXhWuQi0RXhuRv9yr11jJx4P0DofKD+0vB9qYtLbQO9kMK4dA50spB1eEFdby7uqyXw
         LIqAYSWVPjLZyB4dQc0zIPZQn+KEhOotsisB7eeNjE8kYh5ZYaSpvPOIB4cdKuF0Fy6R
         9aElGOc5W3lKeK89eEQ+LEpv9wlJZv4m+hmfobb/hYKGsRr7EYDNdvQlXEIWEor+dkid
         XiUeaf5tgUcf1WZgT4Bs4ylM1/RLYIFcjpo9x0RIFc3FR9S1+RS02xX+ru16rvPfdY4/
         J06A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739055903; x=1739660703;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jx+hNvPmHOpHVq9VFKq5DNfIsRdCbXvYRGw+9lYGTxQ=;
        b=MYALv7COpn3B6GGhqQgTXkMYRGGasIZh1Y5X8pOyrX6dUtBbnHHyFECo7z+HAi7M3m
         QhkWKaP2NiiNusC/Jp9Q8cDHncEzNgWGRrRRoNimXRj2wns1s8TZ+ZuQCL6xOWMyhQKA
         nHj1FcLZjJZCN/d6mU6waDCbL7hnd7/gQCIw8KS8D2btAdc3WFbpSuVkfOKe11HEm43T
         QLkFC3cajTmhdId2fFQ7YmJsPMcSj+bd4QA88G8J92wKb3umD4No1rzFm3f2T+zdKnpk
         bbFeMSn9ErRQ61osAduuY/0P8sn4MAWv5ZlsAyoSKq8DxuyY9v7aq6SH1QuC9jYXgrKA
         bhNQ==
X-Forwarded-Encrypted: i=1; AJvYcCX0DsBUPxNBt8/HJTOGHMbvIA5bDsJKwj9RwchTiGRFUTCdyKd45gB3xy45k7o++4Irquqiap41u3braZwK@vger.kernel.org, AJvYcCX7MTua+FWrN1z84otG7fKHPMKtCtjx7HhdD9E0nRCUJrA3EScFTn2A3+oOMWVjFw6VzYn27jfXyulUF/um@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5TvAiNg6kjQx4eAKbw9yhT2B2PIa0Qkyi+J4kXMq9trv+Uq7D
	CX4Wqm/9TulLDewTXeFB74Fz4QemLJmphzMSh9RboxBLdCMEFj/4
X-Gm-Gg: ASbGncthJ9HTOIiAceoPYmX5E4K5MiEjZ2OszUitaPUL7ZrcpbCQIx589iExYEbt9yy
	Rv+MxckgQfXAWRoMzIz3G4CH9oxYkgT7B2YSXdYyNAWIyGvBD8kUAq3E/H+tXpA0NanYyl1c656
	ioMxof4k0nG9ed/6M/IGyGYjEbgX4/Cu8UqvkC+0r+IlalpfhGTI2i/4Uhj1UOr8TTxWUb03bbB
	0WPrDerTbq6LxQwxR9u/7TaYa8JX+ufIlMZrRF8z9ZXgHZ8EdZVkczE2lfSg5bEd/6I00nUmUC2
	oGpEpJrgaiifVfPNQx3z9zjKztGi3WzVWaJcj56BXQXTaBWzBXYcsg==
X-Google-Smtp-Source: AGHT+IHlWWqzoIlQojAWFJZ7vPMv6pE9NnK+PocpRlv6qnxxzk2UKRfbaPs6kFTCZchAn6hcApokDw==
X-Received: by 2002:a05:600c:3556:b0:434:a781:f5d9 with SMTP id 5b1f17b1804b1-4392498a1c0mr94726125e9.11.1739055902950;
        Sat, 08 Feb 2025 15:05:02 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4390d964c7csm132142945e9.17.2025.02.08.15.05.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Feb 2025 15:05:02 -0800 (PST)
Date: Sat, 8 Feb 2025 23:05:00 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, Christian Brauner <brauner@kernel.org>, Jan
 Kara <jack@suse.cz>
Subject: Re: [PATCH next 1/1] fs: Mark get_sigset_argpack() __always_inline
Message-ID: <20250208230500.05ad57a5@pumpkin>
In-Reply-To: <CAHk-=whvmGhOzJJr1LeZ7vdSNt_CE+VJCUJ9FcLe0-Nv8UqgoA@mail.gmail.com>
References: <20250208151347.89708-1-david.laight.linux@gmail.com>
	<CAHk-=wicUO4WaEE6b010icQPpq+Gk_ZK5V2hF2iBQe-FqmBc3Q@mail.gmail.com>
	<20250208190600.18075c88@pumpkin>
	<CAHk-=whvmGhOzJJr1LeZ7vdSNt_CE+VJCUJ9FcLe0-Nv8UqgoA@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 8 Feb 2025 12:03:09 -0800
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Sat, 8 Feb 2025 at 11:06, David Laight <david.laight.linux@gmail.com> wrote:
> >
> > Can the 'alternatives' be flipped so the .o doesn't contain loads of nops?  
> 
> Sadly, no. The instructions generate #UD if the CPU doesn't support SMAP.
> 
> Now, arguably the alternatives *should* be fixed up before the first
> user space access and thus it would be safe to switch, but honestly, I
> don't want to risk some early code doing odd things. The potential
> pain would be too damn high.
> 
> > It'd be nice to see the clac and lfence.  
> 
> Heh. I agree 100%, which is why my personal tree has a patch like this:
> 
>     -#define LOCK_PREFIX_HERE \
>     -           ".pushsection .smp_locks,\"a\"\n"       \
>     -           ".balign 4\n"                           \
>     -           ".long 671f - .\n" /* offset */         \
>     -           ".popsection\n"                         \
>     -           "671:"
>     +#define LOCK_PREFIX_HERE

That one is just hidden bloat. 40k on the kernel I'm building.
Is it really worth the effort for single-cpu systems.
I can't remember if you can still build a kernel with max-cpus of 1.
But a minor change of removing lock prefix at compile time might make sense.

>   ...
>     -#define barrier_nospec() alternative("", "lfence", X86_FEATURE_LFENCE_RDTSC)
>     +#define barrier_nospec() asm volatile("lfence":::"memory")

Isn't that testing the wrong feature bit?
LFENCE_RDTSC indicates that lfence serialises rdtsc.
lfence itself is predicated by XMM2 (see higher up the file) and is always
present for 64bit.

I'm not sure whether old 32bit cpu need a speculation barrier.
But I'm sure I remember something from a very old (p-pro era?) document
that mentioned avoiding interleaving data and code because the data might
be something like atan and the cpu would have to wait for it to finish
(and that would have been after a ret/jmp as well).
So that might have to be rmb() even on old cpu.

In any case it doesn't need to be an alternative on 64bit.

>   ...
>     -#define ASM_CLAC \
>     -   ALTERNATIVE "", "clac", X86_FEATURE_SMAP
>     -
>     -#define ASM_STAC \
>     -   ALTERNATIVE "", "stac", X86_FEATURE_SMAP
>     +#define ASM_CLAC   clac
>     +#define ASM_STAC   stac
>   ...
>     -   /* Note: a barrier is implicit in alternative() */
s/barrier/memory clobber/
>     -   alternative("", "clac", X86_FEATURE_SMAP);
>     +   asm volatile("clac":::"memory");
>   ...
>     -   /* Note: a barrier is implicit in alternative() */
>     -   alternative("", "stac", X86_FEATURE_SMAP);
>     +   asm volatile("stac":::"memory");

Is there any reason why we get three 0x90 bytes instead of a three-byte nop?
Indeed, since the flags can be changed there are a lot of choices.
Compare %rsp imm8 (83:fc:xx) would probably not affect anything.
It might even decode faster than three nop bytes.

>   ...
>     -#define ASM_BARRIER_NOSPEC ALTERNATIVE "", "lfence", X86_FEATURE_LFENCE_RDTSC
>     +#define ASM_BARRIER_NOSPEC lfence
> 
> but I've never made it a real usable patch for others. It would have
> to be some "modern CPU only" config variable, and nobody else has ever
> complained about this until now.

Defaulting to SMAP just requires a bit of bravery!
After all (as you said) it ought to get patched out before userspace exists.
It is still fairly new (Broadwell ix-5xxx).
I'm sure a lot of people are still running Linux on Sandy bridge cpu.
I've not used mine for a few years (since I stopped being an active NetBSD
developer), but might dig it back out for testing if I retire.
(Or just 'borrow' a slightly newer system from work.)

	David


> 
>              Linus


