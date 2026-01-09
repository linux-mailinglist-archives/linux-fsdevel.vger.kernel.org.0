Return-Path: <linux-fsdevel+bounces-73045-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A62C1D09284
	for <lists+linux-fsdevel@lfdr.de>; Fri, 09 Jan 2026 13:01:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D683B300925B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jan 2026 12:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98CF335A922;
	Fri,  9 Jan 2026 12:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jNMdYXPw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9748E359FBB
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 Jan 2026 12:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767960059; cv=none; b=EZ6J9+b6E0aKSQeNGY1k+5rV+E9cubX4bZ+GUcZ8n+J55/NB93H16gIxJoALS8qu06myEjWbbe9RF2qn8P3yvUzvnzzexloMsVV7BqEaP0tNXVYJO7eIom9aOGkwGPACp2PLYCpi7BJ2qtHkYTYzq0++jfPw7XSTtLa4fcKC17w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767960059; c=relaxed/simple;
	bh=UznriGhvPdMXopWmxqdYE06e8kOqyoTAoTC4x2EkwLM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mMxVLluIq+/7/GmdedEXBQus5EMAzp6dM0w4Y7myWs01gUA6DrMB/1RlLvGL3+GuLDM+RMWulOnboYtNN9IM1HHjWZTQGKW4P+7BBU7zpQQSjACylG/1zEUlFu7Qbwq0Gf6EIMummFV6zjNvLB8KuLZCzTHbJ+Flzfe/vpUgqNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jNMdYXPw; arc=none smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-121b14efeb8so382213c88.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 09 Jan 2026 04:00:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767960057; x=1768564857; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8T/N0YjJdMPLkCw5fXXL5pxg8eGLGcQ3fujG7tmwcHw=;
        b=jNMdYXPwHAkePPH57quq73z7jHRvkOS3WInF4J8dZ5MQixo2oE+Vzpj5MwDypGKBGl
         V896nwkFyVBAHrgdjsvScsrSjCXPMnyZa4lYtv3vdeBsxeFSQny7t8IjCkpBCzUOSQuf
         TdEo1hjfyh84A1DRPOKLBYqwczMXYl5HT333DFF8E1uOsxI87KKmN7hTYWrBQCkPRswk
         H30rzjmXN6jR+6hyDg8RQblbk5t8E+H5Li1K6557uipY5Lu3szZy1jcxE+vgmkhiQiDj
         NuzE0Bj2voyiUAnpGYUZUtenHwgODxZmMkjwyrRgyPQXoxClRzYDnFpMvUUEwKqZviCd
         Ohxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767960057; x=1768564857;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8T/N0YjJdMPLkCw5fXXL5pxg8eGLGcQ3fujG7tmwcHw=;
        b=g4RYmOYQfZK0u0fxCdhoXETA7KSgaTS9AhnBmSfDvZ4ZeHUtNrh9ggVg3lLWcmTvwn
         l8eD5AmALp4gcLhe0THLIzHBU0HdKQRMQQ1DwQt4LX0fSB0x0Y9JOzx/Nael/UNNvrwv
         Oc0+LZRcTUAHxnwLdHlaHmcE1r8ru8BffY+wLJiVDXcPD88NX8vFy3JP8fvKC6f+LMsR
         91B4EkcRU/89iVJ4ymVg/O8t+59DueDsEV7RatQy2FLQVfDz+JR1xxl7WOEnVlYyGXQu
         csSvi4EmhlXgLwJ6oKXlHUzRnnZE+eLfTB6iZ47Dtr0YVTPEXOoXqtvSkonXqSL05jMM
         d1yw==
X-Forwarded-Encrypted: i=1; AJvYcCVXsWCKwQjz2UuDb902+UFaL3ZJuNScIH2hD+GN0v17GWWfRw6YLyKCsc/BvwsD6BZhuZ+GvRWlly5ogUKL@vger.kernel.org
X-Gm-Message-State: AOJu0YyOESLPKu/F39iy2m8ynIYpEOm0yE8kiSNYCWO2WkC5in31rj+O
	pAwt1dtyFIyyC+7YHDzZxCJrj1N81xAtia448d1quWW6G2MfKS/r0heLZlkZrnTVg1JjGQjrIyk
	Sgm8Ik32RhMfKuJC8cW49e5+JoCzp8mH4b7MdimDw
X-Gm-Gg: AY/fxX4Ab0sodQKyKAGU8rXbqXFtAOqywuNaEolV3ldSdX5ZbQ1GS2GmcfBEeQ739yy
	Cpd7Z9D80s/VRROcvyPAdru+RhAhHHIVUePtPfIt7bJ2wNc9qZO9823Oty3RTJPKb8mChxSGCxD
	wBhvggCUmf/dvT+E32s75AlCdtxIAu1FLEasXQEWcgu6LaC821EgitaceLXHrUf75yNZUI7+2Kf
	54jYWXAzyOeL+0rpitW/e4c0cH8xZz3TBWwJZrXh6UAiGWUSNfx9GCUlRJkoVYVGTZbTh59GFcS
	uLM0dixHuKsynadga2LxO8VAhe0=
X-Google-Smtp-Source: AGHT+IHkqsIfmF0FluQuDu53MIRkzwgbeeQdzuawZsTGXquSsN/434sV7j/4310j+FEbQ9rNU7DnJdRzHaNlwPlcWDM=
X-Received: by 2002:a05:7022:4199:b0:11b:ca88:c4f7 with SMTP id
 a92af1059eb24-121f8b67cc0mr8303949c88.40.1767960054556; Fri, 09 Jan 2026
 04:00:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251231-rwonce-v1-0-702a10b85278@google.com> <20251231151216.23446b64.gary@garyguo.net>
 <aVXFk0L-FegoVJpC@google.com> <OFUIwAYmy6idQxDq-A3A_s2zDlhfKE9JmkSgcK40K8okU1OE_noL1rN6nUZD03AX6ixo4Xgfhi5C4XLl5RJlfA==@protonmail.internalid>
 <aVXKP8vQ6uAxtazT@tardis-2.local> <87fr8ij4le.fsf@t14s.mail-host-address-is-not-set>
 <aV0JkZdrZn97-d7d@tardis-2.local> <20260106145622.GB3707837@noisy.programming.kicks-ass.net>
 <7fa2c07e-acf9-4f9a-b056-4d4254ea61e5@paulmck-laptop> <CANpmjNPdnuCNTfo=q5VPxAfdvpeAt8DhesQu0jy+9ZpH3DcUnQ@mail.gmail.com>
 <b0f3b2a6-e69c-4718-9f05-607b8c02d745@paulmck-laptop>
In-Reply-To: <b0f3b2a6-e69c-4718-9f05-607b8c02d745@paulmck-laptop>
From: Marco Elver <elver@google.com>
Date: Fri, 9 Jan 2026 13:00:00 +0100
X-Gm-Features: AQt7F2pBr33IaeEZzEbVtkwEGkq72MjCI-S9aarJ4oQjqFT6bTaIuZHUMWVHI0k
Message-ID: <CANpmjNNSCNm+A=nKdeSDAkcgiKXMEdcQUeMb4PZxWoP2t-z=3A@mail.gmail.com>
Subject: Re: [PATCH 0/5] Add READ_ONCE and WRITE_ONCE to Rust
To: paulmck@kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Gary Guo <gary@garyguo.net>, Will Deacon <will@kernel.org>, 
	Richard Henderson <richard.henderson@linaro.org>, Matt Turner <mattst88@gmail.com>, 
	Magnus Lindholm <linmag7@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Miguel Ojeda <ojeda@kernel.org>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	FUJITA Tomonori <fujita.tomonori@gmail.com>, Frederic Weisbecker <frederic@kernel.org>, 
	Lyude Paul <lyude@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Anna-Maria Behnsen <anna-maria@linutronix.de>, John Stultz <jstultz@google.com>, 
	Stephen Boyd <sboyd@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org, 
	linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	rust-for-linux@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	kasan-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 9 Jan 2026 at 03:09, Paul E. McKenney <paulmck@kernel.org> wrote:
>
> On Tue, Jan 06, 2026 at 08:28:41PM +0100, Marco Elver wrote:
> > On Tue, 6 Jan 2026 at 19:18, 'Paul E. McKenney' via kasan-dev
> > <kasan-dev@googlegroups.com> wrote:
> > > On Tue, Jan 06, 2026 at 03:56:22PM +0100, Peter Zijlstra wrote:
> > > > On Tue, Jan 06, 2026 at 09:09:37PM +0800, Boqun Feng wrote:
> > > >
> > > > > Some C code believes a plain write to a properly aligned location is
> > > > > atomic (see KCSAN_ASSUME_PLAIN_WRITES_ATOMIC, and no, this doesn't mean
> > > > > it's recommended to assume such), and I guess that's the case for
> > > > > hrtimer, if it's not much a trouble you can replace the plain write with
> > > > > WRITE_ONCE() on C side ;-)
> > > >
> > > > GCC used to provide this guarantee, some of the older code was written
> > > > on that. GCC no longer provides that guarantee (there are known cases
> > > > where it breaks and all that) and newer code should not rely on this.
> > > >
> > > > All such places *SHOULD* be updated to use READ_ONCE/WRITE_ONCE.
> > >
> > > Agreed!
> > >
> > > In that vein, any objections to the patch shown below?
> >
> > I'd be in favor, as that's what we did in the very initial version of
> > KCSAN (we started strict and then loosened things up).
> >
> > However, the fallout will be even more perceived "noise", despite
> > being legitimate data races. These config knobs were added after much
> > discussion in 2019/2020, somewhere around this discussion (I think
> > that's the one that spawned KCSAN_REPORT_VALUE_CHANGE_ONLY, can't find
> > the source for KCSAN_ASSUME_PLAIN_WRITES_ATOMIC):
> > https://lore.kernel.org/all/CAHk-=wgu-QXU83ai4XBnh7JJUo2NBW41XhLWf=7wrydR4=ZP0g@mail.gmail.com/
>
> Fair point!
>
> > While the situation has gotten better since 2020, we still have latent
> > data races that need some thought (given papering over things blindly
> > with *ONCE is not right either). My recommendation these days is to
> > just set CONFIG_KCSAN_STRICT=y for those who care (although I'd wish
> > everyone cared the same amount :-)).
> >
> > Should you feel the below change is appropriate for 2026, feel free to
> > carry it (consider this my Ack).
> >
> > However, I wasn't thinking of tightening the screws until the current
> > set of known data races has gotten to a manageable amount (say below
> > 50)
> > https://syzkaller.appspot.com/upstream?manager=ci2-upstream-kcsan-gce
> > Then again, on syzbot the config can remain unchanged.
>
> Is there an easy way to map from a report to the SHA-1 that the
> corresponding test ran against?  Probably me being blind, but I am not
> seeing it.  Though I do very much like the symbolic names in those
> stack traces!

When viewing a report page, at the bottom in the "Crashes" table it's
in the "Commit" column.

