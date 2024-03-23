Return-Path: <linux-fsdevel+bounces-15163-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18BC6887A1A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Mar 2024 20:10:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C89FE282095
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Mar 2024 19:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A3ED59149;
	Sat, 23 Mar 2024 19:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gH2PGpXO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C34863D;
	Sat, 23 Mar 2024 19:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711221024; cv=none; b=tficyJZVrPhkJQDz0xXn9VG4B55gZIN30oBgTxL7aeZcrLhNjKnlZ8Qa6zlbTACybbub7gs5lOPudk8rz18cSvv/7ra6TCUtKG9eveCFvVudM/KGErkGgxZW5gas8XgXZp2NEQExmbqwyb8pNawBfykZ/SyW+lWZ7TV4BnhXXHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711221024; c=relaxed/simple;
	bh=ueCTxwBoM4hJHV9z5OKPHfj7Mct2XSkw55kGkcJ/dgY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YP6nRtunY4KFRs3NqiqSxtuenCKUwcwZAaLhqsmtXVKwWwDt6ndxAs4mIq/aSvo35uvZWMwRg9ewa4oIdxyK6GZlIESgb1vT4tzPJ0NmKUzXwb08OHk7GBqlbkX6BPShNkOvfySvjy92C8xv151uLz1hI/+BKKGAWts1jgJXwqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gH2PGpXO; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-29b7164eef6so2378456a91.2;
        Sat, 23 Mar 2024 12:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711221022; x=1711825822; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ueCTxwBoM4hJHV9z5OKPHfj7Mct2XSkw55kGkcJ/dgY=;
        b=gH2PGpXOvYL/AV4fSRqSj4etmY+yAZCC+0xmFq8jzXgvyRHkRSnfKUpscXJ4ghA3EA
         ef1xQtZ6qODMz1DvjD7ETJPjrJQvh2OxeXx0xGWZIBJsz9T5DhA75z7BVSZ2/6CO6fzX
         zHjV1Xi8mEj5yQdIqEB5k87wD6dmVVT5gRftt0SOs+ZK3JSgFUtLptCeaGSFP37ycDQ5
         u0MOFQSHqB1R3AgaRSf+TDOr+tIHNZ7xISwkwAYORXWhEjIpBGk0tXU1AUUxvtWkTMdT
         Lq3p0ioCBFEYgi4UXL7ll1URBKqycBD/aTZbjN5NzjifSTgk/YUZZU7Xt8qLKKLaYZkx
         b2EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711221022; x=1711825822;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ueCTxwBoM4hJHV9z5OKPHfj7Mct2XSkw55kGkcJ/dgY=;
        b=qiNj0noY4XUgyZQiTGBC4UwO3YsLINIMOV3H2HeD3DyB81rPD6bBh9zQPqcAXelXbg
         hIedEN/fNBUd03tFSNjzSJqh9iMxPrDXKp0jLl1hAKW9Tbrexy4bbHl8aB2OpPeaTCaP
         OWwuwDO+Y2SqVdyaadlX+qJFT7q2FxG+mAXWt/FTobsZEb0JT8VbbaA36MlYeOnp/QUM
         DWz2je90T+UftSodSWr4PGxxx50OXR1zfcPjMgFsdqG38iv7/IOS7ni2IN46E9/g0F0L
         2l1/8xkVbjRooNDVcP4ZRZXIbap+EqreG4ohuz1jvzdCtEjtBsR5eL9vacA7sjgnKvsq
         JDvA==
X-Forwarded-Encrypted: i=1; AJvYcCXbYAc+rW5JobqTAwWKY0S4Bec+I/kGIfhEHXckPdwKvSSjbr2XxuJnASH5EgSpug6KBOsekvsQY3HdRlY0VqXXuC4O2ZqqYSJSg2likVXpZXcsPHgCyhImGAYuBhV5pSMd0jpE+sTiwixnLNrjI0YhNpOFMN1gNjPamh8fFhKQjd2GJA/yOJtOq2BHSeCTdhApNmnA0wJRo5Ovt+ZVxYtXfdN/q7aAqg==
X-Gm-Message-State: AOJu0YzPEIFMWKXDTf39W/vZIugo3RN+PF9DGl/mYLUKoUa/ZmhSrW90
	PSeCsS6iw6otgKhKnvVLMpdJKjJi8h+l9Q+ZV6qg1mX1lrvjPyP1QXKHKr3ew4VzngisWtwjR1D
	BMTq50XLBrLobaPikdGadGv7eqfU=
X-Google-Smtp-Source: AGHT+IGwahkkdd9J1rTcWINtRLDJq4UgsSSVueZO7bQhn7sYYNOp7aQF0yI108KG9KgG8wRB0n2yrE30IMHnBoQhcjw=
X-Received: by 2002:a17:90a:4947:b0:2a0:2f8e:76fc with SMTP id
 c65-20020a17090a494700b002a02f8e76fcmr2513410pjh.28.1711221021961; Sat, 23
 Mar 2024 12:10:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240322233838.868874-1-boqun.feng@gmail.com> <20240322233838.868874-2-boqun.feng@gmail.com>
 <068a5983-8216-48a5-9eb5-784a42026836@lunn.ch> <CAH5fLggdVDccDwBa3z+3YfjKFLegh7ZvcSzfhnEbAGSk=THKrw@mail.gmail.com>
 <497668ec-c2d5-4cb4-9c2d-8e6f7129a42e@lunn.ch>
In-Reply-To: <497668ec-c2d5-4cb4-9c2d-8e6f7129a42e@lunn.ch>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sat, 23 Mar 2024 20:09:57 +0100
Message-ID: <CANiq72m4n2B0K5t1ZESMcL_k=Wgttuwd8=THBbOYYPq_D+4hsg@mail.gmail.com>
Subject: Re: [WIP 1/3] rust: Introduce atomic module
To: Andrew Lunn <andrew@lunn.ch>
Cc: Alice Ryhl <aliceryhl@google.com>, Boqun Feng <boqun.feng@gmail.com>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, llvm@lists.linux.dev, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alan Stern <stern@rowland.harvard.edu>, Andrea Parri <parri.andrea@gmail.com>, 
	Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Nicholas Piggin <npiggin@gmail.com>, David Howells <dhowells@redhat.com>, 
	Jade Alglave <j.alglave@ucl.ac.uk>, Luc Maranget <luc.maranget@inria.fr>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Akira Yokosawa <akiyks@gmail.com>, 
	Daniel Lustig <dlustig@nvidia.com>, Joel Fernandes <joel@joelfernandes.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, kent.overstreet@gmail.com, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, elver@google.com, 
	Mark Rutland <mark.rutland@arm.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Catalin Marinas <catalin.marinas@arm.com>, torvalds@linux-foundation.org, 
	linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 23, 2024 at 3:10=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> Just looking down the road a bit, are there other features in the
> standard library which are not applicable to Linux kernel space?
> Ideally we want a solution not just for atomics but a generic solution
> which can disable a collection of features? Maybe one by one?

We requested a few of these in the past for both `core` [1] and
`alloc` [2], and we got some which we use (see the `cfg(no_*)`s). It
is what we called "modularization of `core`" too.

[1] https://github.com/Rust-for-Linux/linux/issues/514
[2] https://github.com/Rust-for-Linux/linux/issues/408

Cheers,
Miguel

