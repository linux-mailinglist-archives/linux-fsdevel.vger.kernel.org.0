Return-Path: <linux-fsdevel+bounces-16383-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFEFF89CCC7
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Apr 2024 22:06:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 972AD28415F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Apr 2024 20:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 108F7146A8D;
	Mon,  8 Apr 2024 20:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="NeBowQXY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93206146A7D
	for <linux-fsdevel@vger.kernel.org>; Mon,  8 Apr 2024 20:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712606763; cv=none; b=u7GGGz0nltQPnwJhw/Q9TdlJ0hOAVIKEF0OjYPiPERgx/WbIMwWVC26z2Rymv0SnNqxrjxnWkxKmqkzWH2MTx6mq3y0cs4aZNh7W0t1BF91i0VzlRSgROAoM09ErjyehoVxx5GF3SYZsI/zoiobhWqllDIUdTwpp/TLaagN7GFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712606763; c=relaxed/simple;
	bh=82F1MgsQLgdYIQgatWxiRfAXR/TCmhkAjQEqWWRhptw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KpbjJLHjAexjAZ4GZ89Q9o2+KnlB9NLHmShIdRFejhvAh58xnCRbDCOr6w09E1UdolFLsN4SzuCB05RuuBqMKvcCK6zxAN5YtPxY5L8HCNTAb3DMftos0XrjVVchFm/G6Ny2vta5tLasWk0kTUGSNe80jleX5vSRUW6UQE8z088=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=NeBowQXY; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-56e2b3e114fso4535801a12.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 08 Apr 2024 13:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1712606760; x=1713211560; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rRKPouMe4xkFwANgjkQYrxaOlNKZlWPMAGzB1iq7Iyc=;
        b=NeBowQXYFkFLQ2VqL8uOTa2v5kMOg/Rt1Im3jX3Dv3n65l2EEkFKevjgzuZCykxsqh
         tHRGI8o5gOaw+ycB9MkppI7arf3T59ZubcJXpk7VyJZRTbTvTOo99iepNdgHZPA/3zZ8
         rSQDYMEa3fq/6DvZbmrL2+NeuVY+2L88oVdFg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712606760; x=1713211560;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rRKPouMe4xkFwANgjkQYrxaOlNKZlWPMAGzB1iq7Iyc=;
        b=IJIuLHt5dMQoyUGt5XCwILXtZI94sD8vSyeJFaBpCzNpFiwX5HiMtOBxHFloNWqMkp
         Zf/b7M005an2lSPYb8SmW2IoVPZhIw1b50h+vS+Fqi6yRVr9EhC9tbJSv5g3r8a0gK3O
         h1o5ixo2wDql+9a7Fb6S0097xszkPh+omuJkYZTB1JZNK9cLoQ63bpgsk2KdIOdu0Jyi
         faZgoHn5lfyHNYcn2qOUSIbQKNN7zVJJIB8o5j/A/CNGms0J35SGEl3ybeKHjzBXiVAa
         rhXdZOZDq/rEk/6ifs2boGl3v015LoJSlUw0J2uycFWa9alnRSlzKoOKaycn69Q4HNUy
         P1lA==
X-Forwarded-Encrypted: i=1; AJvYcCW9vbdeA6A7I9co4ODLR1Z1fyL+Axi2ZFZRO3tiDZqLEHiTbMif56F/cE7RDLEOTchrhJJcdpWJxc+70jrHA/++Pdw0pgeiTrtk5Z6OiA==
X-Gm-Message-State: AOJu0YwrRzv/wl2QERk13+mgNs8zaRcNfJ+szMQMIakOfAXMiSYWGjB5
	cDjbPeao+ITmUnXDZAMTacP+8+2pXOm4ASVdaNjeuBrSpl0vKep+Rl0QjUNjtzpZ5ZHU3jSSrKd
	m6e+I3Q==
X-Google-Smtp-Source: AGHT+IE7pwan4J5BvQqugoNSlOXJwIp+Tqzzrm0VP0d2TMU3Lx8D6B90iRFqUaMQl4pSboE6Z0Tz4Q==
X-Received: by 2002:a17:907:72c2:b0:a4e:2570:ff56 with SMTP id du2-20020a17090772c200b00a4e2570ff56mr8465163ejc.0.1712606759590;
        Mon, 08 Apr 2024 13:05:59 -0700 (PDT)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com. [209.85.218.49])
        by smtp.gmail.com with ESMTPSA id gx26-20020a1709068a5a00b00a46b4c09670sm4833883ejc.131.2024.04.08.13.05.58
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Apr 2024 13:05:58 -0700 (PDT)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a4715991c32so683951866b.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 08 Apr 2024 13:05:58 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWy1D3THiWnY8IAwFwCE4MtXT5TfdcZPR9OFERimZSYwCNrAd9JKdDje7vAkLNjCcaEvEdfLj7AAQaFlj4Caba6S0zYsMYyQUcvDfWIjg==
X-Received: by 2002:a05:6512:60f:b0:516:9fdc:2621 with SMTP id
 b15-20020a056512060f00b005169fdc2621mr6538971lfe.0.1712606737016; Mon, 08 Apr
 2024 13:05:37 -0700 (PDT)
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
 <CAHk-=wjP1i014DGPKTsAC6TpByC3xeNHDjVA4E4gsnzUgJBYBQ@mail.gmail.com>
 <ZhQVHZnU3beOhEGU@casper.infradead.org> <CAHk-=whmmeU_r_o+sPMcr7tPr-EU+HLnmL+GaWUkMUW0kDzDxw@mail.gmail.com>
 <20240408181436.GO538574@ZenIV>
In-Reply-To: <20240408181436.GO538574@ZenIV>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 8 Apr 2024 13:05:20 -0700
X-Gmail-Original-Message-ID: <CAHk-=wispSt+JezguriGPKnJ0xOUWG_LFDgaM-NVJu6cVa+-xw@mail.gmail.com>
Message-ID: <CAHk-=wispSt+JezguriGPKnJ0xOUWG_LFDgaM-NVJu6cVa+-xw@mail.gmail.com>
Subject: Re: [WIP 0/3] Memory model and atomic API in Rust
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Matthew Wilcox <willy@infradead.org>, Philipp Stanner <pstanner@redhat.com>, 
	Kent Overstreet <kent.overstreet@linux.dev>, Boqun Feng <boqun.feng@gmail.com>, 
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

On Mon, 8 Apr 2024 at 11:14, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> FWIW, PA-RISC is no better - the same "fetch and replace with constant"
> kind of primitive as for sparc32, only the constant is (u32)0 instead
> of (u8)~0.  And unlike sparc64, 64bit variant didn't get better.

Heh. The thing about PA-RISC is that it is actually *so* much worse
that it was never useful for an arithmetic type.

IOW, the fact that sparc used just a byte meant that the aotmic_t
hackery on sparc still gave us 24 useful bits in a 32-bit atomic_t.

So long ago, we used to have an arithmetic atomic_t that was 32-bit on
all sane architectures, but only had a 24-bit range on sparc.

And I know you know all this, I'm just explaining the horror for the audience.

On PA-RISC you couldn't do that horrendous trick, so parist just used
the "we use a hashed spinlock for all atomics", and "atomic_t" was a
regular full-sized integer type.

Anyway, the sparc 24-bit atomics were actually replaced by the PA-RISC
version back twenty years ago (almost to the day):

   https://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.git/commit/?id=373f1583c5c5

and while we still had some left-over of that horror in the git tree
up until 2011 (until commit 348738afe530: "sparc32: drop unused
atomic24 support") we probably should have made the
"arch_atomic_xyz()" ops work on generic types rather than "atomic_t"
for a long long time, so that you could use them on other things than
"atomic_t" and friends.

You can see the casting horror here, for example:

   include/asm-generic/bitops/atomic.h

where we do that cast from "volatile unsigned long *p" to
"atomic_long_t *" just to use the raw_atomic_long_xyz() operations.

It would make more sense if the raw atomics took that "native"
volatile unsigned long pointer directly.

(And here that "volatile" is not because it's necessary used as a
volatile - it is - but simply because it's the most permissive type of
pointer. You can see other places using "const volatile unsigned long"
pointers for the same reason: passing in a non-const or non-volatile
pointer is perfectly fine).

              Linus

