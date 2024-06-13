Return-Path: <linux-fsdevel+bounces-21662-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 32C3D9079BE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2024 19:23:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB0371F249B4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2024 17:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7BE814A0A8;
	Thu, 13 Jun 2024 17:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X/ZuGi4h"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 938EC12EBC7;
	Thu, 13 Jun 2024 17:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718299393; cv=none; b=R66iAfcQyUupY4KFNE7VjWlQEg2Um7d915RneneyYrpfFTSUUKYMt5PnM0NsLtL8vkb1HpwRFRa4evMMVEYzimrOY229b1bQnYfvD2p/F8HTsKGXsF0mKJXn2FSlmGRDJjAhKw9ZviZbL59c7cgfal8iXy9nUDf0F6fxQrQWBIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718299393; c=relaxed/simple;
	bh=+2OFmWNM47yOmDpYrRVafvbtoDEP6ZH+OhJE24NiP7Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WdIA06eakQAImUPTQaoPl5g7V1bkxRcKShAU/SRI5jTnlxX2NlSIQi8mOgkQd01boSaSCHTFcXDY4whmAkIWJRcrRZ7zxbSiqnCeuMkXh4Kvl0BplL64Dx2e5MCaHpG5WBB1EksNaZVOT+roG+aS8RDTA9kNVMeJR0lunJEzHcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X/ZuGi4h; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-52962423ed8so1585980e87.2;
        Thu, 13 Jun 2024 10:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718299390; x=1718904190; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+2OFmWNM47yOmDpYrRVafvbtoDEP6ZH+OhJE24NiP7Q=;
        b=X/ZuGi4hpLYlpYP9fC/otv0zfejU7gw2cCeiAVZozGvpPnZwH/3shGDTbHKx5s1tDi
         Yu4vDuhte3S8ctsdv9+XHGfBnzHo6ghrxNuj3TfYG2Wxha3fUAlvifvv4oVCymxzUH2t
         Wt4ZmHQ7UKWAgyLaUbMG2BTKL8FGmP1Q25NRELGU7ihxmr0lSeDLQ7Koz2aw3m6+YNAE
         5m1O43E7y28iUojXbKBvyxIqyTuokxyQFd0NqSSKsv03UaOPAiMrH3R3g2mcPW9aKrqJ
         JHqUwbwxpJEid4voCWz9kXyezHj04YL+fvpFHF5OeCuraBNn9G40F1k0x434LJnR2f/p
         romQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718299390; x=1718904190;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+2OFmWNM47yOmDpYrRVafvbtoDEP6ZH+OhJE24NiP7Q=;
        b=YGEMpNNwHcBNcGZz/JVTVq4tsF5nFJLE5njHmQgIvScn8ArMf/gqG8Vn7Cx5vHXljT
         noT9rz3/lWQTVXlhyuUWrHoZjcF77ZlErHw8wXtJoNtSomCDRZc6mMFM4AfgOAWBZwqy
         riksTqe1O5BEKFyR4pUXXrXZ/TPjZvo5U2Ujx0NeHzrqFrnVqgyklomniGyHEa2f5KRL
         Etj1nDlaXrXUWI5YEm0hx1ck5FUxLCK9KtIo01UrdbcpauWZTuWU9cSbwTLC5Na1zCeg
         0kR/wop+fUGRZI4D25+AXYXgaqngi0DRgiNkUVJi/89dzrxdfQi2R826uPuAt5dnL8xZ
         RVhQ==
X-Forwarded-Encrypted: i=1; AJvYcCVhZw9agQ80UDAXHLrki/bBeG/ekFqdJ87F+ehWX3I+yb58/6nxJvom0MSEhGqZp7FrPF1QBswRoNKhMv2chd5/N+xIuRME6hycpZohcVUd7ZpLSyo37EoJHkUo23imZKnGOOUN5guwanImpQH6roPRsu7QHrrfv1jSuqOP11S0Ozg8VWZ3eHGaT/PasT5PGP/EtoHc9v8KpanBQuvH4dX5Qm5IoYRCMg==
X-Gm-Message-State: AOJu0YzKQqJvndN/iM04TMPnIJAHtwVvZp+kysXnVmKsCYaBljywv4/f
	LvYdfynZxfGEWFjFMUYM10VzgXYxRRYnOXe0B+jCAnhRF06fyQHIxLT9C7qiubI6vuKDaBx1tr9
	O+b/vZ6iWKpq0tgp5jsu2Xsf2l8Y=
X-Google-Smtp-Source: AGHT+IHBcqtVQqqbJMgNvgEQsiEKAsC+ECQLUgw7lRmSnRMkCyd3LvZGmOtmkguEXtv4jf53dBnmhQo3pJvMSYWBMNM=
X-Received: by 2002:a19:e013:0:b0:52c:8206:b986 with SMTP id
 2adb3069b0e04-52ca6e9b23cmr241057e87.56.1718299389509; Thu, 13 Jun 2024
 10:23:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240612223025.1158537-1-boqun.feng@gmail.com>
 <20240612223025.1158537-3-boqun.feng@gmail.com> <20240613144432.77711a3a@eugeo>
 <ZmseosxVQXdsQjNB@boqun-archlinux>
In-Reply-To: <ZmseosxVQXdsQjNB@boqun-archlinux>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 13 Jun 2024 19:22:54 +0200
Message-ID: <CANiq72myhoCCWs7j0eZuxfoYMbTez7cPa795T57+gz2Dpd+xAw@mail.gmail.com>
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

On Thu, Jun 13, 2024 at 6:31=E2=80=AFPM Boqun Feng <boqun.feng@gmail.com> w=
rote:
>
> So let's start with some basic and simple until we really have a need
> for generic `Atomic<T>`. Thoughts?

I don't want to delay this, but using generics would be more flexible,
right? e.g. it could allow us to have atomics of, say, newtypes, if
that were to be useful.

Is there a particular disadvantage of using the generics? The two
cases you mentioned would just be written explicitly, right?

One disadvantage would be that they are different from the Rust
standard library ones, e.g. in case we wanted third-party code to use
them, but could be provided if needed later on.

Cheers,
Miguel

