Return-Path: <linux-fsdevel+bounces-15145-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EAFC88762A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Mar 2024 01:36:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A075B284BC9
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Mar 2024 00:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C9BCEDE;
	Sat, 23 Mar 2024 00:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="L4PYCEcX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D739D7FD
	for <linux-fsdevel@vger.kernel.org>; Sat, 23 Mar 2024 00:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711154203; cv=none; b=a6pU8+UB8vTKwtYK2+ubWoJsAv081TGsjVfl3oY3lcVDJPCBEc5b3O9HttnZYlRVEN96NV/yuhQa+/65ojFZfiRQevUPB/sdwUGQtszNBslvZYM4Qi8HwvEpoEeYsJW9cf/Z9n6LcEaYTzxjIloyXdHbBnfSUVotRiWUIq7ARVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711154203; c=relaxed/simple;
	bh=j7JyDQ2Yopzv+1fWqR18eqoGt0JNvJeLXCqR09mac8o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iP3L6x8GlrmQPIb7fqW2YNDxI0+f+W7zT3dIxqzZ7YJa+NahSvCLv3wf/Y9noUcm0nL2A/0KwTMOVgNbNEAzXEOv9XJod83STxHUl8HBuC0DSOAc0FR/RN/WdynCvKHzY6QHIEOIIHZdzAmqvVfG9PMl7fnTGwjAn81PwBakom8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=L4PYCEcX; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a4734ae95b3so139814766b.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Mar 2024 17:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1711154200; x=1711759000; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GNrld7J3rRC7RvH2KCmmyzFGDmF8jJ8gCeKdRT3S6xQ=;
        b=L4PYCEcX9f0TdE3n36duh7tt88y4aFc0X7ZzmIUpGxv+WOvnY3ks1BqEgvCi9xFBsU
         X+pc6m/51l+k898fuDpVytIPQAnrOzVhh0mThAAFlc4395miT/sRxj7dr2Zt6hJF+tBm
         cOcpdQp+H3QjFKPUEObosevOfQek439sAZ/6Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711154200; x=1711759000;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GNrld7J3rRC7RvH2KCmmyzFGDmF8jJ8gCeKdRT3S6xQ=;
        b=MB+eeMCNjsUx8/48JjiJcwbR5C0JU1wNW53AyUdVz+tyQ0w6N6ss5fFoRJ7M9j691E
         STMbKVOV/4uVzcupO+OMpSZiZniCi11X8ENGdj/GKhqmtx3M6kcI16zzRMPRVGoecEbx
         zAAF0mHxiceGcCl+EiC2x+E8s1R5mpQn8inT7FMKhMvGkmCKPopbVVJruYqE9XB/tr4H
         1j82T7meF6DJXqmHPblLRlSnedNnrWv13zLHEokeTTnNeELp29zK4O63ebcX/vY+43oh
         2/BpkmYzCpOoUY4WWBNaKSkyNZo0w8UenpC0XSqah+kL2nsnSPnnPAL1EQeNq0gAN0C4
         qOwQ==
X-Forwarded-Encrypted: i=1; AJvYcCV9TXihL3exCtT//ze7otWB+DB20Bq5r/WIsDPgExMMKHFysgEumz5FlYXYdnZMhck/M8RrLFacuVu8PyjWvWAHO9v47AWCjPvNWdDmAw==
X-Gm-Message-State: AOJu0YyZh4T2wi5sPgO5OT+kEd9XfVDbvFctrkfYP7hHGAMjzOrQKL33
	jwCr4kiAoREI5RzsKYpdLyUpwjEvvSXoh6cfb5hEFF3agRJgurxuDlw99RgwwZrJgtCEd1+lqeL
	5OUyzVg==
X-Google-Smtp-Source: AGHT+IHwimNNZy//sko04jo3rr+KtEs8q5tdKucpX48M+2C4K9TB3GSoEDgNQIQwinRE9ghbsXGyhQ==
X-Received: by 2002:a17:906:2b1b:b0:a46:1e16:317c with SMTP id a27-20020a1709062b1b00b00a461e16317cmr799515ejg.55.1711154200055;
        Fri, 22 Mar 2024 17:36:40 -0700 (PDT)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com. [209.85.221.44])
        by smtp.gmail.com with ESMTPSA id bm25-20020a170906c05900b00a4588098c5esm352764ejb.132.2024.03.22.17.36.38
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Mar 2024 17:36:39 -0700 (PDT)
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-33ec8f13c62so1960133f8f.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Mar 2024 17:36:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVObmvnEn73U9b9Qu8PpTcBn7JFomqzzdCJ1InIXFfRQPOD8b5/NNfykRsYP32IQLHyzZFA/Ied7s24nmjYBkTIw2X2EwC0hKluP6eALA==
X-Received: by 2002:a19:f806:0:b0:515:9d4a:d580 with SMTP id
 a6-20020a19f806000000b005159d4ad580mr604299lff.26.1711154177346; Fri, 22 Mar
 2024 17:36:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240322233838.868874-1-boqun.feng@gmail.com> <s2jeqq22n5ef5jknaps37mfdjvuqrns4w7i22qp2r7r4bzjqs2@my3eyxoa3pl3>
 <CAHk-=whY5A=S=bLwCFL=043DoR0TTgSDUmfPDx2rXhkk3KANPQ@mail.gmail.com> <u2suttqa4c423q4ojehbucaxsm6wguqtgouj7vudp55jmuivq3@okzfgryarwnv>
In-Reply-To: <u2suttqa4c423q4ojehbucaxsm6wguqtgouj7vudp55jmuivq3@okzfgryarwnv>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 22 Mar 2024 17:36:00 -0700
X-Gmail-Original-Message-ID: <CAHk-=whkQk=zq5XiMcaU3xj4v69+jyoP-y6Sywhq-TvxSSvfEA@mail.gmail.com>
Message-ID: <CAHk-=whkQk=zq5XiMcaU3xj4v69+jyoP-y6Sywhq-TvxSSvfEA@mail.gmail.com>
Subject: Re: [WIP 0/3] Memory model and atomic API in Rust
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Boqun Feng <boqun.feng@gmail.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
	llvm@lists.linux.dev, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Gary Guo <gary@garyguo.net>, 
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

On Fri, 22 Mar 2024 at 17:21, Kent Overstreet <kent.overstreet@linux.dev> wrote:
>
> Besides that there's cross arch support to think about - it's hard to
> imagine us ever ditching our own atomics.

Well, that's one of the advantages of using compiler builtins -
projects that do want cross-architecture support, but that aren't
actually maintaining their _own_ architecture support.

So I very much see the lure of compiler support for that kind of
situation - to write portable code without having to know or care
about architecture details.

This is one reason I think the kernel is kind of odd and special -
because in the kernel, we obviously very fundamentally have to care
about the architecture details _anyway_, so then having the
architecture also define things like atomics is just a pretty small
(and relatively straightforward) detail.

The same argument goes for compiler builtins vs inline asm. In the
kernel, we have to have people who are intimately familiar with the
architecture _anyway_, so inline asms and architecture-specific header
files aren't some big pain-point: they'd be needed _anyway_.

But in some random user level program, where all you want is an
efficient way to do "find first bit"? Then using a compiler intrinsic
makes a lot more sense.

> I was thinking about something more incremental - just an optional mode
> where our atomics were C atomics underneath. It'd probably give the
> compiler people a much more effective way to test their stuff than
> anything they have now.

I suspect it might be painful, and some compiler people would throw
their hands up in horror, because the C++ atomics model is based
fairly solidly on atomic types, and the kernel memory model is much
more fluid.

Boqun already mentioned the "mixing access sizes", which is actually
quite fundamental in the kernel, where we play lots of games with that
(typically around locking, where you find patterns line unlock writing
a zero to a single byte, even though the whole lock data structure is
a word). And sometimes the access size games are very explicit (eg
lib/lockref.c).

But it actually goes deeper than that. While we do have "atomic_t" etc
for arithmetic atomics, and that probably would map fairly well to C++
atomics, in other cases we simply base our atomics not on _types_, but
on code.

IOW, we do things like "cmpxchg()", and the target of that atomic
access is just a regular data structure field.

It's kind of like our "volatile" usage. If you read the C (and C++)
standards, you'll find that you should use "volatile" on data types.
That's almost *never* what the kernel does. The kernel uses "volatile"
in _code_ (ie READ_ONCE() etc), and uses it by casting etc.

Compiler people don't tend to really like those kinds of things.

            Linus

