Return-Path: <linux-fsdevel+bounces-72541-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A7C33CFAAAF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 06 Jan 2026 20:30:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 24B263068BC6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Jan 2026 19:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4FFD3446CE;
	Tue,  6 Jan 2026 19:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DdVd2RVi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C3F348879
	for <linux-fsdevel@vger.kernel.org>; Tue,  6 Jan 2026 19:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767727761; cv=none; b=oHnOt43xHdO9FhjEvkWe9C/d3jdv/u8NBVCylrg3q794r2CLxq3vGwcppmYWnZH0BCwOcRqx3Qxc0LNJt/jMLoI0JE/BCUssk2Co1ebKbJUQLNcWyGQbfaCAcuv5PKUuaIfY/XQtgTfLebVEzprsphdMVlvR/jbSKE7MeIpOP+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767727761; c=relaxed/simple;
	bh=uKZhJrrDxZ2O667E2POc5W6fPGmhpIxg+TUJPzHN/Nw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i0iDJyNSuY8YQnwsecW220BKF5sN4WY9RoOzKhRlo2mlIXVwm2W9hNQjC/KhYTOEeYqSjVd/iePWZ9/wotaQnIH70qgEmfyWkItF6Af4LZSwFvnlrWanjGIFhVQQdTAdtvf3N2gCYQF9D6dWn5XKjtgSi/Sq09Y7gWdacHgS6Dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DdVd2RVi; arc=none smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-11f42e97340so779504c88.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 06 Jan 2026 11:29:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767727758; x=1768332558; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=h+fw2uOH7rfXDKHv296LmegV1D5QyXRSiBc8OZxA9qs=;
        b=DdVd2RViVBiw91LbThfocB/P8RNuE+Dx3pt+rprMhGk+WK686kDbdCstnXu9JeeubA
         F99qu94LzkyQO0EvUdR7Jq+Pqx94Z00/97ewQbmd9rDmvAFgmKmXxCxwJ/exXDgUK9JG
         2Cr2m8WgNwOq0kWuiA2FH6c7d3zg5Q1ESmq7QGDQROhXUiGQwFnvA40P7y0fLCpJtpLJ
         0knLmwV+3lZuFeBgci4+OMJAplFJxYrH1Vrdt4NWVAoui702JSieCQ71tQX7izrZMUux
         pYwKRxaC83QMXQS8/Pqub1c0VgAJID06qwcWPnJqo8nIsm/dps9Uyz5VkU8LUZYEglQo
         FSlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767727758; x=1768332558;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h+fw2uOH7rfXDKHv296LmegV1D5QyXRSiBc8OZxA9qs=;
        b=JSi51S9l1Z8/bK/D8lA6uKc3R7J7dhFXwQ2RSUglobegmLcoJ4zIm+JAMAjCEh3qmH
         unVaSd/6dCptTdFhXsNH0HSIMM4maQikLbUN8H6E/nTEInew5AWTM7MNkOLZA/ZtWdK0
         GTTJl4ARMXC4rcOWdipX4pT5nrGEJ1EacXBHPBJGFOnX9f2xDZhYWLfv4QMU927dKZe0
         nY15QQBWq5/XIzFPOMyea1+WVd57bqCg14PmOnILXhIGEf+fOPCnX7FEXzyv4zcWkbK8
         atOoA0CUA7jSHpS8WrqTn7wX8sTT8MMcHIvg3BfaFQnhUr9yP+8pT29rH5y6JMg98p/P
         oSJA==
X-Forwarded-Encrypted: i=1; AJvYcCUNJuOfjlpIt8AcKrAoWC9FN/jfYoefa25zkW6G9/4mN3QMTQdZJLeDKAFPhOSq86M7RbNOtqj/7TTKQ0+2@vger.kernel.org
X-Gm-Message-State: AOJu0Ywho74A687pWp4/YpxSes59g7mVYj9qUhXQtjUL1zEMIHYgOqC/
	389JmuDrDWzDgUG9lWUGSM850ADbDq375IXna8yOiCwha0c+pxwHUM4VBh51DDvfKsWO9Qf+TwB
	G8iQ1ajhadKemPKx4gJ3MJAWJLo7RnGkwvlSp3RgT
X-Gm-Gg: AY/fxX5FYEGZW+17wPFn2hWnvq0c0YHC6S3TK01X6ofKiCmzPJQb8QRnKyoMlz8gxkK
	MCYGAF3JMZXpkcAfmQG38MsEmIdEF0P1gK1I2gdRuIpeLQO7Mr8TEXQkLQXK4ltYx1NQYXaYroA
	6CcUhLheNctfd2sqPuD2K/hhLzyAootIKnQjMTNqjIatDCVLV1EyLl5GDZ1Ld7gc8obW2FyNp20
	Qai07LEtiTsqqW6tFZPDkoXMFegKRBJpVvWvZQ4THvV/mAnLJQTDvbllor//fvInzsAVa6Bo8a0
	jVNN9t17z+Wj3J7iJTpLThGx8gk=
X-Google-Smtp-Source: AGHT+IFiRHskLlnG7qWHcNDWY2mzjvXiWOgQovcFApO+FbQQhWbtyFRZOSXWqcX9YSAeO4iVY5BbmjGIzs+tTyqeQvA=
X-Received: by 2002:a05:7022:4199:b0:11b:ca88:c4f7 with SMTP id
 a92af1059eb24-121f8b67cc0mr18897c88.40.1767727757907; Tue, 06 Jan 2026
 11:29:17 -0800 (PST)
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
 <7fa2c07e-acf9-4f9a-b056-4d4254ea61e5@paulmck-laptop>
In-Reply-To: <7fa2c07e-acf9-4f9a-b056-4d4254ea61e5@paulmck-laptop>
From: Marco Elver <elver@google.com>
Date: Tue, 6 Jan 2026 20:28:41 +0100
X-Gm-Features: AQt7F2pduEl0iy3ZX0HLxlaIYaHR9bRxCAH-5viQta6DXK6OToIwGPr_JhTocFA
Message-ID: <CANpmjNPdnuCNTfo=q5VPxAfdvpeAt8DhesQu0jy+9ZpH3DcUnQ@mail.gmail.com>
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

On Tue, 6 Jan 2026 at 19:18, 'Paul E. McKenney' via kasan-dev
<kasan-dev@googlegroups.com> wrote:
> On Tue, Jan 06, 2026 at 03:56:22PM +0100, Peter Zijlstra wrote:
> > On Tue, Jan 06, 2026 at 09:09:37PM +0800, Boqun Feng wrote:
> >
> > > Some C code believes a plain write to a properly aligned location is
> > > atomic (see KCSAN_ASSUME_PLAIN_WRITES_ATOMIC, and no, this doesn't mean
> > > it's recommended to assume such), and I guess that's the case for
> > > hrtimer, if it's not much a trouble you can replace the plain write with
> > > WRITE_ONCE() on C side ;-)
> >
> > GCC used to provide this guarantee, some of the older code was written
> > on that. GCC no longer provides that guarantee (there are known cases
> > where it breaks and all that) and newer code should not rely on this.
> >
> > All such places *SHOULD* be updated to use READ_ONCE/WRITE_ONCE.
>
> Agreed!
>
> In that vein, any objections to the patch shown below?

I'd be in favor, as that's what we did in the very initial version of
KCSAN (we started strict and then loosened things up).

However, the fallout will be even more perceived "noise", despite
being legitimate data races. These config knobs were added after much
discussion in 2019/2020, somewhere around this discussion (I think
that's the one that spawned KCSAN_REPORT_VALUE_CHANGE_ONLY, can't find
the source for KCSAN_ASSUME_PLAIN_WRITES_ATOMIC):
https://lore.kernel.org/all/CAHk-=wgu-QXU83ai4XBnh7JJUo2NBW41XhLWf=7wrydR4=ZP0g@mail.gmail.com/

While the situation has gotten better since 2020, we still have latent
data races that need some thought (given papering over things blindly
with *ONCE is not right either). My recommendation these days is to
just set CONFIG_KCSAN_STRICT=y for those who care (although I'd wish
everyone cared the same amount :-)).

Should you feel the below change is appropriate for 2026, feel free to
carry it (consider this my Ack).

However, I wasn't thinking of tightening the screws until the current
set of known data races has gotten to a manageable amount (say below
50)
https://syzkaller.appspot.com/upstream?manager=ci2-upstream-kcsan-gce
Then again, on syzbot the config can remain unchanged.

Thanks,
-- Marco

>                                                         Thanx, Paul
>
> ------------------------------------------------------------------------
>
> diff --git a/lib/Kconfig.kcsan b/lib/Kconfig.kcsan
> index 4ce4b0c0109cb..e827e24ab5d42 100644
> --- a/lib/Kconfig.kcsan
> +++ b/lib/Kconfig.kcsan
> @@ -199,7 +199,7 @@ config KCSAN_WEAK_MEMORY
>
>  config KCSAN_REPORT_VALUE_CHANGE_ONLY
>         bool "Only report races where watcher observed a data value change"
> -       default y
> +       default n
>         depends on !KCSAN_STRICT
>         help
>           If enabled and a conflicting write is observed via a watchpoint, but
> @@ -208,7 +208,7 @@ config KCSAN_REPORT_VALUE_CHANGE_ONLY
>
>  config KCSAN_ASSUME_PLAIN_WRITES_ATOMIC
>         bool "Assume that plain aligned writes up to word size are atomic"
> -       default y
> +       default n
>         depends on !KCSAN_STRICT
>         help
>           Assume that plain aligned writes up to word size are atomic by
>

