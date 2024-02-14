Return-Path: <linux-fsdevel+bounces-11611-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFF658554F6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Feb 2024 22:37:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACADD28AEC1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Feb 2024 21:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21A3D13F008;
	Wed, 14 Feb 2024 21:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GI7a4rEJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71FA013EFFA;
	Wed, 14 Feb 2024 21:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707946648; cv=none; b=R4K/ly5O4gaNI5dHNbsCz12RJnnt1rdF46lQxSCmDAyKwYdIURRV8+2cc+K1j3InJWHQQdHTWAjOFiPCFhapC/YhUe6al8UTiH5LVOyCE2+yKGT8XXZKvRDzt9Hz5SlyoAvLGshPUzB1Xers8Q9O1GrxsamQtsm+M35A+fEjvu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707946648; c=relaxed/simple;
	bh=TsPOCXsLDMYvW8y1m6lrloJ2qWdhkM2QRD0tOx+Oj5s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AMNXxss2YRMvdh0KdbbLaPQ7eU4xH2MG28hE2qhd7By8etxfmnOPBEap0rPWX8vb0/jyI8riQSZz1W1tpGMPMFt3Xc8mX98LYNbg8tC/Ezp+8w2xYDPzXrf8k48zyvRVetBp81f4LFVzxm0cdE/c9PdVoLwYhUxrgxcFjRnhKAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GI7a4rEJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD14FC43142;
	Wed, 14 Feb 2024 21:37:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707946647;
	bh=TsPOCXsLDMYvW8y1m6lrloJ2qWdhkM2QRD0tOx+Oj5s=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=GI7a4rEJz27vG5jhdk9ife44YZUKF+HF6XmYHsfRxhkOg/dSqgCLc/gDhgyVTx8er
	 KBmSQv6h5xkSh53IaFu53JIZt9Kqrt/0r3gty9Vm/u+LcHrFWDTlSP4Pg3XzrJIFOG
	 7jgwDwg6LXLyHAxzqwlZ2vzfhTR2fzXQUJk/w6hCLQfVxrv3ZEVQNge3YmiA9lTnYC
	 ELYph0Euvs8SO2maNzGbgGSrwhxLWd5XHdbapnVMjdeKOgRNpIu6HKWzi99An6FsgD
	 iVuAO2q1QRmYgKLAz3XIJ/G2aLWSa0YjwZEXT95JvD5c8WtYJ9g+JqCoFX0LmQ9eR+
	 NCoLiD1o3YYNQ==
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5114b2b3b73so232483e87.0;
        Wed, 14 Feb 2024 13:37:27 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUzkZn9aZ8xX4fAQYwpZ4dRIhF/a9lgCqlTpwu17UGTHXnOhh6c+9jYNnKbuppDwejr1529/Snd85BJYSSPL1sZqh5nHmFfr60PXPKrzGg9jxI5PepWsq0EW4rTQ/W+i2pcKTfd00ol5SSP4KNHDtBaWFJY/d0krbxld3WD1AvVIhJvgZOxXYp4
X-Gm-Message-State: AOJu0YypDnYrXCZ5F/s8h0lKHYsXJxhPyQn94WM6X8tfVzvxchQITmlP
	oEtnsUTkbeDixcJrClahGjmbpKFZxxHfMIPe0Pq0lSktlmdFAshDxCu5s+Jxcx0ePEuTQ+p5zOQ
	5vGoca0a90bmNZTmEHIspeeIGT5A=
X-Google-Smtp-Source: AGHT+IGaABfu32aIgi1zbQgkMqIdb4dPd13u5g3Nueo8bVIDR4Cw4/c9BLtkrRJueICXYtotHNpf4oplutFFocoODpY=
X-Received: by 2002:a05:6512:b82:b0:511:a477:64aa with SMTP id
 b2-20020a0565120b8200b00511a47764aamr25874lfv.51.1707946646162; Wed, 14 Feb
 2024 13:37:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240207171020.41036-1-yoann.congal@smile.fr> <20240207171020.41036-2-yoann.congal@smile.fr>
 <CAK7LNAQb=n1dWdEAJy_aJWnkW2M3bR768WKpxnUv=CtBEi28Xw@mail.gmail.com> <d845be0d-d0e4-4494-9572-753102f3fa24@smile.fr>
In-Reply-To: <d845be0d-d0e4-4494-9572-753102f3fa24@smile.fr>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Thu, 15 Feb 2024 06:36:50 +0900
X-Gmail-Original-Message-ID: <CAK7LNARJERFRF=EM3RKL5jMgLbq0H1Op7FSRLJaVjrcR_nv0NA@mail.gmail.com>
Message-ID: <CAK7LNARJERFRF=EM3RKL5jMgLbq0H1Op7FSRLJaVjrcR_nv0NA@mail.gmail.com>
Subject: Re: [PATCH v5 1/3] printk: Fix LOG_CPU_MAX_BUF_SHIFT when BASE_SMALL
 is enabled
To: Yoann Congal <yoann.congal@smile.fr>
Cc: linux-fsdevel@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, x86@kernel.org, 
	=?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>, 
	Borislav Petkov <bp@alien8.de>, Darren Hart <dvhart@infradead.org>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Davidlohr Bueso <dave@stgolabs.net>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"H . Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, Jiri Slaby <jirislaby@kernel.org>, 
	John Ogness <john.ogness@linutronix.de>, Josh Triplett <josh@joshtriplett.org>, 
	Matthew Wilcox <willy@infradead.org>, Peter Zijlstra <peterz@infradead.org>, 
	Petr Mladek <pmladek@suse.com>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Vegard Nossum <vegard.nossum@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024 at 4:01=E2=80=AFAM Yoann Congal <yoann.congal@smile.fr=
> wrote:
>
>
>
> Le 11/02/2024 =C3=A0 00:41, Masahiro Yamada a =C3=A9crit :
> > On Thu, Feb 8, 2024 at 2:10=E2=80=AFAM Yoann Congal <yoann.congal@smile=
.fr> wrote:
> >>
> >> LOG_CPU_MAX_BUF_SHIFT default value depends on BASE_SMALL:
> >>   config LOG_CPU_MAX_BUF_SHIFT
> >>         default 12 if !BASE_SMALL
> >>         default 0 if BASE_SMALL
> >> But, BASE_SMALL is a config of type int and "!BASE_SMALL" is always
> >> evaluated to true whatever is the value of BASE_SMALL.
> >>
> >> This patch fixes this by using the correct conditional operator for in=
t
> >> type : BASE_SMALL !=3D 0.
> >>
> >> Note: This changes CONFIG_LOG_CPU_MAX_BUF_SHIFT=3D12 to
> >> CONFIG_LOG_CPU_MAX_BUF_SHIFT=3D0 for BASE_SMALL defconfigs, but that w=
ill
> >> not be a big impact due to this code in kernel/printk/printk.c:
> >>   /* by default this will only continue through for large > 64 CPUs */
> >>   if (cpu_extra <=3D __LOG_BUF_LEN / 2)
> >>           return;
> >> Systems using CONFIG_BASE_SMALL and having 64+ CPUs should be quite
> >> rare.
> >>
> >> John Ogness <john.ogness@linutronix.de> (printk reviewer) wrote:
> >>> For printk this will mean that BASE_SMALL systems were probably
> >>> previously allocating/using the dynamic ringbuffer and now they will
> >>> just continue to use the static ringbuffer. Which is fine and saves
> >>> memory (as it should).
> >>
> >> Petr Mladek <pmladek@suse.com> (printk maintainer) wrote:
> >>> More precisely, it allocated the buffer dynamically when the sum
> >>> of per-CPU-extra space exceeded half of the default static ring
> >>> buffer. This happened for systems with more than 64 CPUs with
> >>> the default config values.
> >>
> >> Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
> >> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> >> Closes: https://lore.kernel.org/all/CAMuHMdWm6u1wX7efZQf=3D2XUAHascps7=
6YQac6rdnQGhc8nop_Q@mail.gmail.com/
> >> Reported-by: Vegard Nossum <vegard.nossum@oracle.com>
> >> Closes: https://lore.kernel.org/all/f6856be8-54b7-0fa0-1d17-39632bf29a=
da@oracle.com/
> >> Fixes: 4e244c10eab3 ("kconfig: remove unneeded symbol_empty variable")
> >>
> >
> >
> >
> > All the Reviewed-by tags are dropped every time, annoyingly.
>
> Hi!
>
> Was I supposed to gather these tags from patch version N to patch version=
 N+1?
> In that case, I'm sorry, I did not know that :-/
> Patch 1/3 is exactly the same but patch 2/3 is equivalent but different. =
Is there a rule written somewhere about when carrying the tags across revis=
ion and when not? (I could not find it)


I do not know any written rules either.


In my experience, people carry tags
when changes since the previous version are small.





--=20
Best Regards
Masahiro Yamada

