Return-Path: <linux-fsdevel+bounces-15251-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E69088B07D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Mar 2024 20:53:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5A4A1FA163F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Mar 2024 19:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E90B7224FB;
	Mon, 25 Mar 2024 19:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="e2y/SNwg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 383871CF94
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 Mar 2024 19:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711396375; cv=none; b=dhoaLlTF91RdMa9s+77UKWvXeK2wNiTpRV7PhYbRbQFvy70c/si6bQHLOBtobbWt+UPooLw/CU1Nq9mtLPutnyahXMnr5K6KTOZpdkPzMTaxIOjn2zZE8q/Eyka+mHNm8nVTTftVJ7tMjUaLwBqpYMfnkmn8vTR1ulJtVUAlAE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711396375; c=relaxed/simple;
	bh=A9iFiK6Y1wte6MuOGQxLuhRQjW57DRplpjuGYIs8fYM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uEt4o/RPXDMEIIxLF7/utrAZhQODya4d9R3bDghBmtj88HvwAW2TAmLXNV/zj1Af0AovNdSzo4LGfZ9FMVomLlb87wZJIC9ucNLJPxqmykGS5MbWPurCd8zsMTA88oOCto9icIUB/BXhUdxpWhlOaB5P1Qns37zIB5euwa4B1ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=e2y/SNwg; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-515a86daf09so2374482e87.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Mar 2024 12:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1711396371; x=1712001171; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/SDMeVL08gBgcdBP5iWFLp8wMiMUpYFhuW9V2Wg1OXU=;
        b=e2y/SNwgLwTYq0ZjWJ8X5RcIG0wIwPMYUWDr8RWE8pyrQESXoFPn9BJJFwibqqpIhl
         gIHFfFDXy7AWRyWPJ2kSoBHTMu/61x3WouhDC/REBJGHrsxKd1eYcGZyYeDCkhi59+hJ
         O2/ORRHJXsTUht2N3zzAWwRvhC7d1W940oOHY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711396371; x=1712001171;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/SDMeVL08gBgcdBP5iWFLp8wMiMUpYFhuW9V2Wg1OXU=;
        b=AmJOrHYOd8QnHl6ToVuzxV8cED/shHs9o5bvY0oRlVKqtwJxw3xpEPT586TMTrZao3
         z6VgGisPQvwrXtfpjJ22TPt3SkMfG4IM3ssb5MZ23974Q83nhdi8TDPhv+5U50zJBPxp
         IA1CNaqoReat/OqD0mF3d52nUboTt624PRURrlzIRsUPgg/SvrUZaPV4ADidOXm2XJau
         3+Zfc8WgahmUr7HySmz9y8TmaoKePBzaPzwEuRcv/wOTAVaJjUrXdYgTVboQ+TOl+mEm
         MpxyAqKRI7fTWzreCl8rLfOAeSaCuzyFAioZ8L2ShgWW1lX9oVGvNVvBu3Khh23TEJDZ
         rjpQ==
X-Forwarded-Encrypted: i=1; AJvYcCViMtAD2nrHLWoZsVxS5DqFcTTlgBVYNUefqz9EpkB+bCRjFkmWDo5wdWMN7TxcGPFDY2UX2gUZ9aFY56HaIdL6KYFTI+e4i57OJTeSRg==
X-Gm-Message-State: AOJu0YwhupADBT2B6f5mHPiwcyPicJOeq23LFNO8w7CMPGkR9odTYYjP
	zfGG/O6Puwdjtm26oFOOn4E6/LimSvMsfesrjEsujt7ZOZR6EQ1uN0cZv+x71RTdwsNTuPXspjm
	MWpigsQ==
X-Google-Smtp-Source: AGHT+IHHXH05+Mgkf9B0zE67knKOep7dNTL4050gbGksXq4WRhDK5vBX1zYulvqcD/gT4G3UVJyWvQ==
X-Received: by 2002:a05:6512:32cc:b0:515:acdc:fcdb with SMTP id f12-20020a05651232cc00b00515acdcfcdbmr3365107lfg.24.1711396371105;
        Mon, 25 Mar 2024 12:52:51 -0700 (PDT)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com. [209.85.128.52])
        by smtp.gmail.com with ESMTPSA id lb25-20020a170907785900b00a3d11feb32esm3368792ejc.186.2024.03.25.12.52.50
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Mar 2024 12:52:50 -0700 (PDT)
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4148c607f31so3209995e9.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Mar 2024 12:52:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXc5ros3N1ueIohHKaxku3gUh9/Ay+yiPBJypyaIAjF2oTBmLVZrYila2IUrLhs0X8H/u7Kf+AUdLHqK4chzEHnoZ7L6Bn0e6PKpVdRCg==
X-Received: by 2002:a17:906:4a56:b0:a46:9b7c:c962 with SMTP id
 a22-20020a1709064a5600b00a469b7cc962mr5818699ejv.47.1711395890869; Mon, 25
 Mar 2024 12:44:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240322233838.868874-1-boqun.feng@gmail.com> <s2jeqq22n5ef5jknaps37mfdjvuqrns4w7i22qp2r7r4bzjqs2@my3eyxoa3pl3>
 <CAHk-=whY5A=S=bLwCFL=043DoR0TTgSDUmfPDx2rXhkk3KANPQ@mail.gmail.com>
 <u2suttqa4c423q4ojehbucaxsm6wguqtgouj7vudp55jmuivq3@okzfgryarwnv>
 <CAHk-=whkQk=zq5XiMcaU3xj4v69+jyoP-y6Sywhq-TvxSSvfEA@mail.gmail.com>
 <c51227c9a4103ad1de43fc3cda5396b1196c31d7.camel@redhat.com>
 <CAHk-=wjP1i014DGPKTsAC6TpByC3xeNHDjVA4E4gsnzUgJBYBQ@mail.gmail.com> <bu3seu56hfozsvgpdqjarbdkqo3lsjfc4lhluk5oj456xmrjc7@lfbbjxuf4rpv>
In-Reply-To: <bu3seu56hfozsvgpdqjarbdkqo3lsjfc4lhluk5oj456xmrjc7@lfbbjxuf4rpv>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 25 Mar 2024 12:44:34 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgLGWBXvNODAkzkVHEj7zrrnTq_hzMft62nKNkaL89ZGQ@mail.gmail.com>
Message-ID: <CAHk-=wgLGWBXvNODAkzkVHEj7zrrnTq_hzMft62nKNkaL89ZGQ@mail.gmail.com>
Subject: Re: [WIP 0/3] Memory model and atomic API in Rust
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Philipp Stanner <pstanner@redhat.com>, Boqun Feng <boqun.feng@gmail.com>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, llvm@lists.linux.dev, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alice Ryhl <aliceryhl@google.com>, Alan Stern <stern@rowland.harvard.edu>, 
	Andrea Parri <parri.andrea@gmail.com>, Will Deacon <will@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Nicholas Piggin <npiggin@gmail.com>, 
	David Howells <dhowells@redhat.com>, Jade Alglave <j.alglave@ucl.ac.uk>, 
	Luc Maranget <luc.maranget@inria.fr>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Akira Yokosawa <akiyks@gmail.com>, Daniel Lustig <dlustig@nvidia.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, kent.overstreet@gmail.com, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, elver@google.com, 
	Mark Rutland <mark.rutland@arm.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 25 Mar 2024 at 11:59, Kent Overstreet <kent.overstreet@linux.dev> wrote:
>
> To be fair, "volatile" dates from an era when we didn't have the haziest
> understanding of what a working memory model for C would look like or
> why we'd even want one.

I don't disagree, but I find it very depressing that now that we *do*
know about memory models etc, the C++ memory model basically doubled
down on the same "object" model.

> The way the kernel uses volatile in e.g. READ_ONCE() is fully in line
> with modern thinking, just done with the tools available at the time. A
> more modern version would be just
>
> __atomic_load_n(ptr, __ATOMIC_RELAXED)

Yes. Again, that's the *right* model in many ways, where you mark the
*access*, not the variable. You make it completely and utterly clear
that this is a very explicit access to memory.

But that's not what C++ actually did. They went down the same old
"volatile object" road, and instead of marking the access, they mark
the object, and the way you do the above is

    std::atomic_int value;

and then you just access 'value' and magic happens.

EXACTLY the same way that

   volatile int value;

works, in other words. With exactly the same downsides.

And yes, I think that model is a nice shorthand. But it should be a
*shorthand*, not the basis of the model.

I do find it annoying, because the C++ people literally started out
with shorthands. The whole "pass by reference" is literally nothing
but a shorthand for pointers (ooh, scary scary pointers), where the
address-of is implied at the call site, and the 'dereference'
operation is implied at use.

So it's not that shorthands are wrong. And it's not that C++ isn't
already very fundamentally used to them. But despite that, the C++
memory model is very much designed around the broken object model, and
as already shown in this thread, it causes actual immediate problems.

And it's not just C++. Rust is supposed to be the really moden thing.
And it made the *SAME* fundamental design mistake.

IOW, the whole access size problem that Boqun described is
*inherently* tied to the fact that the C++ and Rust memory model is
badly designed from the wrong principles.

Instead of designing it as a "this is an atomic object that you can do
these operations on", it should have been "this is an atomic access,
and you can use this simple object model to have the compiler generate
the accesses for you".

This is why I claim that LKMM is fundamentally better. It didn't start
out from a bass-ackwards starting point of marking objects "atomic".

And yes, the LKMM is a bit awkward, because we don't have the
shorthands, so you have to write out "atomic_read()" and friends.

Tough. It's better to be correct than to be simple.

             Linus

