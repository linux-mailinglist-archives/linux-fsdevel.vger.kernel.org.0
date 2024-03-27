Return-Path: <linux-fsdevel+bounces-15471-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A71A988EEDE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Mar 2024 20:08:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C46511C2E9CA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Mar 2024 19:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0DAF1514DF;
	Wed, 27 Mar 2024 19:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Ti5/AJ6f"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E0AE149DE0
	for <linux-fsdevel@vger.kernel.org>; Wed, 27 Mar 2024 19:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711566488; cv=none; b=OlHntoU18Kz0ISmeoIvTC5Wd8oXKxtLLDqvsDOTfXJ+W4cQFLC4YqklEvv9uP9fqk3edzBp5HKcMXFUzMXsSfghkagN3sw8bPaBgR6hdNScUK6Ci1loubPrI9FaUvaaeXkesYC4wH/Gs/4G/o8r1svTZ45IM0BMDyHsT90cVxlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711566488; c=relaxed/simple;
	bh=jMoBfFRvYMHbxV9SVPKA1xW7pPTPIbFhe56hTJM1VbQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E4v/Bq4zVxzTwMZSicslGiFehvcjRkEJ4O6QdnQot9Zv4f3dzhldzC/ICtVxLTN2/e0qwcyZbAsJRSGk85QsuPGiNQrDzVbs7biPVWDzJUvkh92qd7us+WX889ELs89drL9BmG8yHaTiRo4QXzp6HaZ3fVkEtFaotxCKvep8yAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Ti5/AJ6f; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2d68c6a4630so894801fa.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Mar 2024 12:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1711566484; x=1712171284; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WdyHGSi984C+8z92+nQdjQTGDoXLLzpQZD6STeLATA0=;
        b=Ti5/AJ6fEcv1DOgSy3XC+qCXwL1VJJjezJGceIpBOwy1+Nyt95CqgvKhLt0Exh6wMs
         GoqfODInLE6uiA+6O28U6W5AAud9hjT8VLEzmhoHQWh22njPBsXqbCouQs/euUtZx21G
         hxcpov9PcaX/6miIQqHLuiEhvd+AljtbaOq1Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711566484; x=1712171284;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WdyHGSi984C+8z92+nQdjQTGDoXLLzpQZD6STeLATA0=;
        b=Z8jmnIoGiWDJE5mMxYvc5yIBI3KmYCD+vcG8GD+uMiGVIrcrhA6l7Fi+IVYcPcvaF7
         884Gj7T712VnYOjHkaDFufbprWkg4NDqg3i+rvy15JMxlIsrHNcOy/9BsHBlTq2yCSoV
         lhxdvXv3tBcGUfPT5THHeIfQSTnDM90lvKZgyu/fSpJiagtph4jlxbPtH2dBkx8pF54Y
         Fq5QRiC+8af5ZoUh1LM7uCZVT5uAK5r6RlbqiZhpSlindyoDb8s5V1LoUj4MxUjZBWfq
         n6zm/sFj9/4m1ByGxAgJnktogNGd6UZFAJ6c3+LPMPawUfpQ5a3CpzLIEhaalm7h21/2
         GcUw==
X-Forwarded-Encrypted: i=1; AJvYcCWr8tn5+cCuuZWUbOUQb1ID3dhX59vdgepFVammwKRTDNqiFXBAzk6halfZkNu954hQWgeK2MrrXXUs6Cuwkf4w1tkDwcy0wPMhl1f9Ew==
X-Gm-Message-State: AOJu0YxihKgSx8KHLpywhZ1oGJKnnKTDSCECjVYoR4nbntUpmHMDRm8w
	0F6WqPoM3zgwAacmQLg0rdvr1Bom2+kzzrXZfALtUrW09jajKaebvnETyq+Pv62YGulhh+A6iDk
	7LxE=
X-Google-Smtp-Source: AGHT+IFqFy2qWsQVyTBJPeO7ZrpW4eGNrK9SOlISyRNKO6lK5ofjv75R/t8Qycb57sV0Vd0n6bjclg==
X-Received: by 2002:a05:651c:1988:b0:2d4:3d99:3708 with SMTP id bx8-20020a05651c198800b002d43d993708mr674114ljb.29.1711566484478;
        Wed, 27 Mar 2024 12:08:04 -0700 (PDT)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id n25-20020a2e7219000000b002d6ec8a619fsm546122ljc.120.2024.03.27.12.08.03
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Mar 2024 12:08:03 -0700 (PDT)
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2d476d7972aso1388171fa.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Mar 2024 12:08:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXjwCOjryjShJFa0vUHumWkRod+RN20foHJiDP/VoQOOOfhZhyFfmv5OgtePYXqXipMQRMN9sBDfCWzxIuQ4lmlg+6FpB3jKXUtI42ISw==
X-Received: by 2002:a17:906:6d5:b0:a4e:14b3:e7e1 with SMTP id
 v21-20020a17090606d500b00a4e14b3e7e1mr172960ejb.42.1711566462952; Wed, 27 Mar
 2024 12:07:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=whY5A=S=bLwCFL=043DoR0TTgSDUmfPDx2rXhkk3KANPQ@mail.gmail.com>
 <u2suttqa4c423q4ojehbucaxsm6wguqtgouj7vudp55jmuivq3@okzfgryarwnv>
 <CAHk-=whkQk=zq5XiMcaU3xj4v69+jyoP-y6Sywhq-TvxSSvfEA@mail.gmail.com>
 <c51227c9a4103ad1de43fc3cda5396b1196c31d7.camel@redhat.com>
 <CAHk-=wjP1i014DGPKTsAC6TpByC3xeNHDjVA4E4gsnzUgJBYBQ@mail.gmail.com>
 <bu3seu56hfozsvgpdqjarbdkqo3lsjfc4lhluk5oj456xmrjc7@lfbbjxuf4rpv>
 <CAHk-=wgLGWBXvNODAkzkVHEj7zrrnTq_hzMft62nKNkaL89ZGQ@mail.gmail.com>
 <ZgIRXL5YM2AwBD0Y@gallifrey> <CAHk-=wjwxKD9CxYsf5x+K5fJbJa_JYZh1eKB4PT5cZJq1+foGw@mail.gmail.com>
 <160DB953-1588-418E-A490-381009CD8DE0@gmail.com> <qyjrex54hbhvhw4gmn7b6l2hr45o56bwt6fazfalykwcp5zzkx@vwt7k3d6kdwt>
In-Reply-To: <qyjrex54hbhvhw4gmn7b6l2hr45o56bwt6fazfalykwcp5zzkx@vwt7k3d6kdwt>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 27 Mar 2024 12:07:26 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgQy+FRKjO_BvZgZN56w6-+jDO8p-Mt=X=zM70CG=CVBQ@mail.gmail.com>
Message-ID: <CAHk-=wgQy+FRKjO_BvZgZN56w6-+jDO8p-Mt=X=zM70CG=CVBQ@mail.gmail.com>
Subject: Re: [WIP 0/3] Memory model and atomic API in Rust
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: comex <comexk@gmail.com>, "Dr. David Alan Gilbert" <dave@treblig.org>, 
	Philipp Stanner <pstanner@redhat.com>, Boqun Feng <boqun.feng@gmail.com>, 
	rust-for-linux <rust-for-linux@vger.kernel.org>, linux-kernel@vger.kernel.org, 
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
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Marco Elver <elver@google.com>, 
	Mark Rutland <mark.rutland@arm.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 27 Mar 2024 at 11:51, Kent Overstreet <kent.overstreet@linux.dev> wrote:
>
> On Wed, Mar 27, 2024 at 09:16:09AM -0700, comex wrote:
> > Meanwhile, Rust intentionally lacks strict aliasing.
>
> I wasn't aware of this. Given that unrestricted pointers are a real
> impediment to compiler optimization, I thought that with Rust we were
> finally starting to nail down a concrete enough memory model to tackle
> this safely. But I guess not?

Strict aliasing is a *horrible* mistake.

It's not even *remotely* "tackle this safely". It's the exact
opposite. It's completely broken.

Anybody who thinks strict aliasing is a good idea either

 (a) doesn't understand what it means

 (b) has been brainwashed by incompetent compiler people.

it's a horrendous crock that was introduced by people who thought it
was too complicated to write out "restrict" keywords, and that thought
that "let's break old working programs and make it harder to write new
programs" was a good idea.

Nobody should ever do it. The fact that Rust doesn't do the C strict
aliasing is a good thing. Really.

I suspect you have been fooled by the name. Because "strict aliasing"
sounds like a good thing. It sounds like "I know these strictly can't
alias". But despite that name, it's the complete opposite of that, and
means "I will ignore actual real aliasing even if it exists, because I
will make aliasing decisions on entirely made-up grounds".

Just say no to strict aliasing. Thankfully, there's an actual compiler
flag for that: -fno-strict-aliasing. It should absolutely have been
the default.

                 Linus

