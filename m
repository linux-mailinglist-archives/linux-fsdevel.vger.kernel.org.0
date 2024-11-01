Return-Path: <linux-fsdevel+bounces-33477-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EBC4B9B9337
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2024 15:30:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EE531F23153
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2024 14:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 804991A727D;
	Fri,  1 Nov 2024 14:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="clV2wVvV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 398E4136347;
	Fri,  1 Nov 2024 14:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730471416; cv=none; b=Xu+SgMz6JaGunDGMu2Fq9AODMmPrFttoWivmL8jxk86Fr6BQm0h7D1kAE5pKATSlhkgzjJcETevsgZ1255zmbF+BfhG4rmWVjIvqiRxK+Y7KUHtOVL7RTlKOgMxB5y/NOCD5Jfo3axWpA5beUNJn8qoKRQdXwEa6QqKkQyImVhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730471416; c=relaxed/simple;
	bh=TKAtd4Xz8cLFFFmnHPins+tJ+Mfne7qr3bvUedak18U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j6wmE/oqM9AwxvXH8nR8oJgRZ1XVDz7CLXIhNJ6n7Cmgis6bd98yN3rBn5s5mpwexO0KkVshvPcpl53RbechQlAXtYmTDYEkGufCG66tlDIaan7AUXLx5lb5AoHXm5/eOc4ua3iJjQ+paPaXU56MSF6UO7Cm/+4KdIloIJqWxvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=clV2wVvV; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-7ea64af4bbbso270847a12.1;
        Fri, 01 Nov 2024 07:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730471414; x=1731076214; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TKAtd4Xz8cLFFFmnHPins+tJ+Mfne7qr3bvUedak18U=;
        b=clV2wVvVpvtg73poXDClHokmVTSuMI+Fz7X8wserVsovSY/SBHAduC3FMs7xF2EzMo
         J7MoqPO90lgbhyOCFiRhe+CUurxGxwrZBB/AjpbCvM7EQYTm8jVjIbLwUE+mRigT04Ui
         FNfMp0t63MjMY3/0xPiC0lf0yBuIZ+BEPTrriV7x9MsDJ4DbcPXxhzptDSdX8xMKPgsd
         JcP4SFXzzFW1IhWBaGafFUEGxCR1zB41f78L8esOaOdxX+Rwd8X0UJtJC2S7tmTHWkoF
         eHgzm1FYmYPIl6uaDUqe0GWZSq3D8a3GnkFbdXzJnRE8zgU1QduTCURKo1K9atvS0H2/
         ShNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730471414; x=1731076214;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TKAtd4Xz8cLFFFmnHPins+tJ+Mfne7qr3bvUedak18U=;
        b=reMdGsOJNS3fZey1MPu4eBzWV9N5DBt65fzufp2TKDSUPj5grOXt630EohOxbz4PZ8
         6psCDrP4aWzGIvREos6hLEVAouteOAjf/H1LdCCA7EprgpqhWgqOwc0LwY5ecm0WDZp4
         aX7mgGuqPUXIL4k76SEySmsdzDUX7j5iNVAfP1Jju8XKmY50mWn6Dp+vEJcI4t25zu36
         juLNujfc4pMZpj6zx8sf2t1alr3tOcLlUBP6OnQaQQ00Q8Vp3fbdHu79miLLnl4Xvc36
         9Pr8k53thK9c3hv0iWIiu3HxsB8niiUuKaxbeJLlVT23A8ozeuyWueVTD0kecBXSQDNV
         YdgQ==
X-Forwarded-Encrypted: i=1; AJvYcCUcddTIFhAUva6E5m4fxOb8nt4UIPOxfdXgU8wI57ZcNJRdfqeZhg6tbyN49RbIM1jZHBDBJme4OlNk@vger.kernel.org, AJvYcCUe3POq1CKgdLDMz2qn3xbpuLOLoSsK/fl8duCYWjEs7l/wSnwKZhUbvjf4F4JsgTHviP7x@vger.kernel.org, AJvYcCW7KYjj/XP8jOjd80nepQYw5wHuokjARoOMr5Vh2TzM71baJx52ZVYCxXp12zmT9sTzTUlSihPKlMTEF5VupA==@vger.kernel.org, AJvYcCWrA/gIKCcGyaQx5vpm3q4Og4KhwKLVz+LCd+2n1tRcNXKzL/YvgTqdfmqaaPII85tiyBSx1iU0eM71ilrO@vger.kernel.org
X-Gm-Message-State: AOJu0YyMAIo/qasMDLO6pQZELkxNxXHnLXTQGTEwCEIl7IwDDjqIkZCZ
	42F/dGLW/ZJH/dFvpluA70bgmKWcstTjINT737cHaAoBoWFWqqqdO6HjCDCd7Yay+70EslMIpTK
	7TC5LglDHoBK6OFmm/sZ+os4p2RU=
X-Google-Smtp-Source: AGHT+IGOQhefEp7FLZkdniAIiiIsTLBIszMwpP4/Ctt+MCmEaSNoKLq4eMcSMtSjAgS5QbXUeuU5N7LkDLjPkosOQVw=
X-Received: by 2002:a17:902:d50c:b0:20c:5da8:47b8 with SMTP id
 d9443c01a7336-210c689759amr141323595ad.5.1730471414470; Fri, 01 Nov 2024
 07:30:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241101060237.1185533-1-boqun.feng@gmail.com>
In-Reply-To: <20241101060237.1185533-1-boqun.feng@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 1 Nov 2024 15:30:01 +0100
Message-ID: <CANiq72ndWJtzSQSFYuVkRPhdan_PvNpvGEhQXKAZKESnt7JVAA@mail.gmail.com>
Subject: Re: [RFC v2 00/13] LKMM *generic* atomics in Rust
To: Boqun Feng <boqun.feng@gmail.com>
Cc: rust-for-linux@vger.kernel.org, rcu@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
	llvm@lists.linux.dev, lkmm@lists.linux.dev, Miguel Ojeda <ojeda@kernel.org>, 
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
	"H. Peter Anvin" <hpa@zytor.com>, Catalin Marinas <catalin.marinas@arm.com>, torvalds@linux-foundation.org, 
	linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org, 
	Trevor Gross <tmgross@umich.edu>, dakr@redhat.com, 
	Frederic Weisbecker <frederic@kernel.org>, Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, 
	Josh Triplett <josh@joshtriplett.org>, Uladzislau Rezki <urezki@gmail.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 1, 2024 at 7:03=E2=80=AFAM Boqun Feng <boqun.feng@gmail.com> wr=
ote:
>
> This time, I try implementing a generic atomic type `Atomic<T>`, since
> Benno and Gary suggested last time, and also Rust standard library is
> also going to that direction [1].

I would like to thank Boqun for trying out this approach, even when he
wasn't (and maybe still isn't) convinced.

Cheers,
Miguel

