Return-Path: <linux-fsdevel+bounces-21701-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 121BE908933
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Jun 2024 12:06:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25AFC1C2696E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Jun 2024 10:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75AEB19308C;
	Fri, 14 Jun 2024 10:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A1NDvVVb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 915421922C1;
	Fri, 14 Jun 2024 10:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718359213; cv=none; b=cZ+yqrIlnXr1LJKpV8BASP2PGl/jwgYlgRaHTs0qeBnVY4hsPqSN5QGFzqOuqAaeGBt6TGVYGmaRxLn2oit1ZGTGsWjCIDsQio6vbLQRCY/e+xV3Cle+41W54ux6qasizPIpy/NhjT1dyp769EXjXo65TO9xAJfDZ1sF95K+mns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718359213; c=relaxed/simple;
	bh=CBAdIAt33/2nqpZ8vIydnCg5rpba2GT3bMlI628Yd0U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eMIXotHGamaub2vS3otYATeksw0w4sOUxPQ77ZxqJKB0c/YUobOEGpMZjzsKgnxDNjHIBIscE7xc36fFo8vVOxXMyUCx6SXkq5biHywGoEiLwVNoURlKal07iN3o+Vn4Aez06XUiNc7jwZND/Q3sNKH8zWt4CeN9HZuEy435XYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A1NDvVVb; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2c2d25b5432so1585457a91.2;
        Fri, 14 Jun 2024 03:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718359212; x=1718964012; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CBAdIAt33/2nqpZ8vIydnCg5rpba2GT3bMlI628Yd0U=;
        b=A1NDvVVbY6oMwaoScrvnM3MGnNBW9TVmvzNSrBMGgj+qpwqmfDrOPBZa7/KBvdLQ2S
         WpcBo0Xi9RwX7KjhckidjeTz3jtUKRcDDtlDeQvCN6UTryj5VNwRaauMbm/9yiiov2j9
         XliRBsMVEFbH9Hu4rikLsxSiiNx0QoZeycNXWljDIAOoGZTCGXNPIoQJbGD2XyIbABck
         shrsl/asSYj93VRCpE7BXwEIke7ym2GSAaI1NGdinK31lrCTsBj8zvRbCdy+GCBTzS7W
         b1Ssw1tiRwM9ASmNusJGscScfKnP2ONwZX9J0+0he/bwfbEirqO7fPBSqQ66IBOBLoUw
         39+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718359212; x=1718964012;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CBAdIAt33/2nqpZ8vIydnCg5rpba2GT3bMlI628Yd0U=;
        b=A+R9LigVLNB2oZI2Ne7f4ZzSXJGR8BWfne/XwZAif+7pbHGdmYgJc7PhhQmTeKbDF/
         l3aVjKK8DUVUITXTrdBDZyZrmZ23eirHzV/byuw7r7KDJZSt5Xue0lneZKtBbVu7yxGy
         pGrjqEaxGOClBTGfp4exfucDM6WV4PuK8mYcW9iV1f5BHbHlDBEk0ugrlMXhYu+/6g1Z
         53WrCXdINx9uTDrCHkSZ23GhG8qFGVKC7oYyRl6AzcZfx2GeL/YHS6nTWyB25qrH0Y4E
         KaNPo65Wt+BaeldHMLSkifubqWwcaF+R9Yx9S+eNTYaq/yTpCwzFjOmXTLcAXiFkAOpj
         2FPg==
X-Forwarded-Encrypted: i=1; AJvYcCXC7iHel95lQChOmvBo545nVyyU2xsFShvQol7V9rvAUbBNTxN8ukeIb80R38c38862Y0L+0oyFHVBOgDPXVMmmhgkyoFk4EbmEwyaWOgMEEVW4W2liVoAnSLWMC1jJlWnROYR50g6oA0TrLu42IHtI2yUW5Zzmk+bKCh2K0QdHeoB6crbylEmlDiOSsxMfbevx+R3o+LJriynhJnRfR9/XJyRHtnb2dQ==
X-Gm-Message-State: AOJu0YzzMeXYKwIhVcfxnl6RCx7Znm8J3qojkRUUGDKN5DSoVGAFHd6D
	XMoKJwGuHaT/Ibv3xuFlXpEbTK5qzdKa3Wj2fpVxoleHDobzSwoJQSzE4OkPBeJi/mZ32bCzzMZ
	ZiBy5lEMmCcHD7CUBdDEdsuEwD1s=
X-Google-Smtp-Source: AGHT+IHt+gI7Y4iz2Wee6JixIaqyBgOUnOLbE8M8v+YAFmEE+Srhye3lGnfgQDBv3QdFdYRKtbIcxZaM2XWpe/OGK9M=
X-Received: by 2002:a17:90a:d383:b0:2c2:f2f9:a121 with SMTP id
 98e67ed59e1d1-2c4db8589c0mr2098796a91.39.1718359210973; Fri, 14 Jun 2024
 03:00:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240612223025.1158537-1-boqun.feng@gmail.com>
 <20240612223025.1158537-3-boqun.feng@gmail.com> <20240613144432.77711a3a@eugeo>
 <ZmseosxVQXdsQjNB@boqun-archlinux> <CANiq72myhoCCWs7j0eZuxfoYMbTez7cPa795T57+gz2Dpd+xAw@mail.gmail.com>
 <ZmtC7h7v1t6XJ6EI@boqun-archlinux>
In-Reply-To: <ZmtC7h7v1t6XJ6EI@boqun-archlinux>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 14 Jun 2024 11:59:58 +0200
Message-ID: <CANiq72=JdqTRPiUfT=-YMTTN+bHeAe2Pba8nERxU3cN8Q-BEOw@mail.gmail.com>
Subject: Re: [RFC 2/2] rust: sync: Add atomic support
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Gary Guo <gary@garyguo.net>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
	llvm@lists.linux.dev, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
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
	"H. Peter Anvin" <hpa@zytor.com>, Catalin Marinas <catalin.marinas@arm.com>, torvalds@linux-foundation.org, 
	linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org, 
	Trevor Gross <tmgross@umich.edu>, dakr@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 13, 2024 at 9:05=E2=80=AFPM Boqun Feng <boqun.feng@gmail.com> w=
rote:
>
> Does this make sense?

Implementation-wise, if you think it is simpler or more clear/elegant
to have the extra lower level layer, then that sounds fine.

However, I was mainly talking about what we would eventually expose to
users, i.e. do we want to provide `Atomic<T>` to begin with? If yes,
then we could make the lower layer private already.

We can defer that extra layer/work if needed even if we go for
`Atomic<T>`, but it would be nice to understand if we have consensus
for an eventual user-facing API, or if someone has any other opinion
or concerns on one vs. the other.

Cheers,
Miguel

