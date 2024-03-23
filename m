Return-Path: <linux-fsdevel+bounces-15142-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CD6868875F7
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Mar 2024 01:13:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4334EB228D1
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Mar 2024 00:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0D3838F;
	Sat, 23 Mar 2024 00:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="gMxX3Kjq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D40399
	for <linux-fsdevel@vger.kernel.org>; Sat, 23 Mar 2024 00:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711152792; cv=none; b=ojoVJ/rj0ghxMoVrHU7ZGtst1SMwNL8fcetlt68M8op4Yo+3X8NFCr5FNhjKT8YwkR3TnX/AY3dCRXPFPQHaIcR/1DuP/XkaT2ouSl2pJrbfFjKbS1U8rn+iuUTT3T5d3tdofoqFCqlvxAdxd/Q34JMx5oW7cmRd8O1WCWkfXaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711152792; c=relaxed/simple;
	bh=buaytYj6XnQEMslfX8wQQCXJQT/19Ph5hoNeBiv9PMs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dO+zbcK5h4RsuOn8rauGuceJb2Jwo7rM2B2YoatWw6jRSvo1WYyVdl7x7HpB6c94y9ASmRWxKaxe2buWGudch2SHZ2AIBdfO9omipsBle1fSIxL8aaCYPxZnoIIw33iw8noQcb2znm29p9XVMZYkQWumz4KCNIsVu1pWOmLmR7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=gMxX3Kjq; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-563c403719cso3158361a12.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Mar 2024 17:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1711152788; x=1711757588; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/DcKs5LOC+9m7c+sQfRFSymnyXVGhlvaNbRKaUaILEw=;
        b=gMxX3KjqXaiJvgkX0Nq3HaSJ8PIDKZc0x/yXgkwW7YMnSCp80fHIvHxZL//j6W7IIR
         mOXf9P5/Ty513id+egBItW1+znpugzfa3fdtVZ9SiLW8GUDrR57Ccf5UR1Yiv2MAvP+Y
         0/cRmt/Nyw+bpDE/Q3mLQMgPK1UK2uzJ3H0aY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711152788; x=1711757588;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/DcKs5LOC+9m7c+sQfRFSymnyXVGhlvaNbRKaUaILEw=;
        b=VqGyvLMcjO+0IB3zV2sr/GEEAUaRRdYferYJL6lYcEMWm1rQv9A/RIWiseWKCFSHTm
         6Jj2x35swpx+3qjTfC45spaD2pVmv5f1cwGoCsIzmiTY2Ybse5SQR5Ri1hWtphRw6rbQ
         R7tXiuSvXW5eFUubsuHAEqK0b7NLMkR9ToCN53utjGTuveeETQ6uoKq6dYFzcmwe+uM2
         Gn8z/KaQS698bA1/02iEhIHl/yo4NuP544g2QY0Ze8/aE6r6yRqpMPqBRb/kh6I2i1Ef
         xcav9IL3lSaHfmzIxUs7FO6tRzG2RN7K6hGv0zKH1hxVkHVQqtbrRtLFOa5LX2Fh/ZAJ
         tI3A==
X-Forwarded-Encrypted: i=1; AJvYcCVHmng6Ch6pivAuv9ifJwkpQ5PiuvuzB7UvaMkRsEDEvylAlLAZjg6poUrBYuOlkWKd0PH4ejeDkzegKjdaLc6G2P0REyqDs+5DKfLBtg==
X-Gm-Message-State: AOJu0YxK8ZgTaIS+HE+eVZUi1Sb2tCEJYpVAF4nus9L/6dctiJCRkNXo
	S6n7e+PD0Z/6eLtXlgjXc0F3yMrN43C7qe5S1gpPgrDx04K7+SnXUH4oqOPWOk8ioTB1BZNf64g
	9vAs=
X-Google-Smtp-Source: AGHT+IGEVDT01e132s8R8ZxDRBTNmdlxoX7udvyQ637NjZ/w5cJJitts1HYxn9UHf61WD1EpN+QVrQ==
X-Received: by 2002:a50:bb47:0:b0:56b:d139:490 with SMTP id y65-20020a50bb47000000b0056bd1390490mr677992ede.6.1711152788714;
        Fri, 22 Mar 2024 17:13:08 -0700 (PDT)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com. [209.85.221.41])
        by smtp.gmail.com with ESMTPSA id r10-20020a508d8a000000b0056ba017ca7fsm319716edh.87.2024.03.22.17.13.07
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Mar 2024 17:13:07 -0700 (PDT)
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-33ed4d8e9edso1657049f8f.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Mar 2024 17:13:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXKImLsJHda3DsL8RtzUZNxTBcyrnImnfDqxq/evJTg9PNn/WfMoMgV9XyJqOKdsk7DZUIab9BsXH01QjUqPole9KUDQaVvYyoeu1CF/A==
X-Received: by 2002:a17:906:6b0b:b0:a46:7ee2:f834 with SMTP id
 q11-20020a1709066b0b00b00a467ee2f834mr791117ejr.11.1711152766110; Fri, 22 Mar
 2024 17:12:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240322233838.868874-1-boqun.feng@gmail.com> <s2jeqq22n5ef5jknaps37mfdjvuqrns4w7i22qp2r7r4bzjqs2@my3eyxoa3pl3>
In-Reply-To: <s2jeqq22n5ef5jknaps37mfdjvuqrns4w7i22qp2r7r4bzjqs2@my3eyxoa3pl3>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 22 Mar 2024 17:12:29 -0700
X-Gmail-Original-Message-ID: <CAHk-=whY5A=S=bLwCFL=043DoR0TTgSDUmfPDx2rXhkk3KANPQ@mail.gmail.com>
Message-ID: <CAHk-=whY5A=S=bLwCFL=043DoR0TTgSDUmfPDx2rXhkk3KANPQ@mail.gmail.com>
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

On Fri, 22 Mar 2024 at 16:57, Kent Overstreet <kent.overstreet@linux.dev> wrote:
>
> I wonder about that. The disadvantage of only supporting LKMM atomics is
> that we'll be incompatible with third party code, and we don't want to
> be rolling all of our own data structures forever.

Honestly, having seen the shit-show that is language standards bodies
and incomplete compiler support, I do not understand why people think
that we wouldn't want to roll our own.

The C++ memory model may be reliable in another decade. And then a
decade after *that*, we can drop support for the pre-reliable
compilers.

People who think that compilers do things right just because they are
automated simply don't know what they are talking about.

It was just a couple of days ago that I was pointed at

    https://github.com/llvm/llvm-project/issues/64188

which is literally the compiler completely missing a C++ memory barrier.

And when the compiler itself is fundamentally buggy, you're kind of
screwed. When you roll your own, you can work around the bugs in
compilers.

And this is all doubly true when it is something that the kernel does,
and very few other projects do. For example, we're often better off
using inline asm over dubious builtins that have "native" compiler
support for them, but little actual real coverage. It really is often
a "ok, this builtin has actually been used for a decade, so it's
hopefully stable now".

We have years of examples of builtins either being completely broken
(as in "immediate crash" broken), or simply generating crap code that
is actively worse than using the inline asm.

The memory ordering isn't going to be at all different. Moving it into
the compiler doesn't solve problems. It creates them.

                 Linus

