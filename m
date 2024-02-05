Return-Path: <linux-fsdevel+bounces-10236-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 422CD8492A0
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 04:02:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDCEA1F228A8
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 03:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B95FF8F51;
	Mon,  5 Feb 2024 03:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MtGBMVqV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D01B641;
	Mon,  5 Feb 2024 03:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707102161; cv=none; b=NACliYw/N0PLwG5FwMqO9x7KqBncfxYEIgQiiqh62Zs35SxHb156LRiioPCgCWJmrJfagFWIvE+kCZ2gSs5nZ61ACkn8yIvttf39+Npjz8CPZ0/cdg5l1drgvGpS93HMxEYFhmoUL7f92ZsruzH/TcGyEkcJ8p/Dx7TU8V5V3qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707102161; c=relaxed/simple;
	bh=qT1MX0tGgCIx01o3HUieKOe4gx2/zz2JUXpblxvvwKI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KsKL85z+ywsMGFyYI+9Y0KeIDo/HLlyPDpchOx3C34BiEoX4KUdV+dAapVKHGl8T9wEtmRdtGj1UGJIAOfhrazazKNlZsSIilz5fYtY8SZtxKrQgNB6XxCjpHUuxECXdTafQKaVlFGUlJfYrAbEkH745Ge+gheZmpAt6bb/agLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MtGBMVqV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89C87C43399;
	Mon,  5 Feb 2024 03:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707102160;
	bh=qT1MX0tGgCIx01o3HUieKOe4gx2/zz2JUXpblxvvwKI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=MtGBMVqV1HxT1psSgWLfa+yj7pd4hPZTmqsSJwZQf0pijI2cHLKNzDWlPoSaG9fQN
	 J+H06NHSF2GNeET60cObpiGeC6Uub7eHViRIXL8i02hhzaJAtgwYdT/PLgKzPwJl53
	 NItPVNnvB25TrUe6W7t7OEuGxDx4uYx3eoofPl09TeGLojGFj1ZkIF9qoBzby2FjzR
	 UoHHbn+nbYJuHAIY2kslg+/Mcy3OfY68vJmOmO01Ec5kLdZREUlgoKBqU3WaWcA1G2
	 +cyKdSm65xvIWCYN8PkmkKY9JMbL0VlmLDJ0rB9vUCw8Mdk0eqzkNFlnmCy0dMEXDJ
	 CoGu6w78wHgTw==
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-51147d0abd1so1057144e87.1;
        Sun, 04 Feb 2024 19:02:40 -0800 (PST)
X-Gm-Message-State: AOJu0Yx4GlxN1deUoqdEdDq3QC1C1lEpYpGxUOX9kDjvKfsKK6/g7A4t
	+HuHyHXyCzRSItLOcmzarDCJ4f8mEVa7VT81Onb7f8em9us6ZLyvS1JsaudmGGSLKKlbpQoHdWf
	EK0Amfs4O9EZgb6ln7txJ8VzCNu0=
X-Google-Smtp-Source: AGHT+IHl/iymdtYFHK5JZ/elmXzWFAyQO/YXGJl1pBkrHnzTDx/qV2jzdGznk2tAe71KL2dLd8K1Hu3B2prE18d8Gvg=
X-Received: by 2002:a05:6512:3e05:b0:511:3232:954f with SMTP id
 i5-20020a0565123e0500b005113232954fmr8402346lfv.2.1707102159152; Sun, 04 Feb
 2024 19:02:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240204232945.1576403-1-yoann.congal@smile.fr> <20240204232945.1576403-2-yoann.congal@smile.fr>
In-Reply-To: <20240204232945.1576403-2-yoann.congal@smile.fr>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Mon, 5 Feb 2024 12:02:03 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQU-mpu5GxFSeakOG+xkHGsVD8i4t-y9PnPw_fGT8XgdA@mail.gmail.com>
Message-ID: <CAK7LNAQU-mpu5GxFSeakOG+xkHGsVD8i4t-y9PnPw_fGT8XgdA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] printk: Fix LOG_CPU_MAX_BUF_SHIFT when BASE_SMALL
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

On Mon, Feb 5, 2024 at 8:30=E2=80=AFAM Yoann Congal <yoann.congal@smile.fr>=
 wrote:
>
> LOG_CPU_MAX_BUF_SHIFT default value depends on BASE_SMALL:
>   config LOG_CPU_MAX_BUF_SHIFT
>         default 12 if !BASE_SMALL
>         default 0 if BASE_SMALL
> But, BASE_SMALL is a config of type int and "!BASE_SMALL" is always
> evaluated to true whatever is the value of BASE_SMALL.
>
> This patch fixes this by using BASE_FULL (type bool) which is equivalent
> to BASE_SMALL=3D=3D0.
>
> Note: This changes CONFIG_LOG_CPU_MAX_BUF_SHIFT=3D12 to
> CONFIG_LOG_CPU_MAX_BUF_SHIFT=3D0 for BASE_SMALL defconfigs, but that will
> not be a big impact due to this code in kernel/printk/printk.c:
>   /* by default this will only continue through for large > 64 CPUs */
>   if (cpu_extra <=3D __LOG_BUF_LEN / 2)
>           return;
> Systems using CONFIG_BASE_SMALL and having 64+ CPUs should be quite
> rare.
>
> John Ogness <john.ogness@linutronix.de> (printk reviewer) wrote:
> > For printk this will mean that BASE_SMALL systems were probably
> > previously allocating/using the dynamic ringbuffer and now they will
> > just continue to use the static ringbuffer. Which is fine and saves
> > memory (as it should).
>
> Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Closes: https://lore.kernel.org/all/CAMuHMdWm6u1wX7efZQf=3D2XUAHascps76YQ=
ac6rdnQGhc8nop_Q@mail.gmail.com/
> Reported-by: Vegard Nossum <vegard.nossum@oracle.com>
> Closes: https://lore.kernel.org/all/f6856be8-54b7-0fa0-1d17-39632bf29ada@=
oracle.com/
> Fixes: 4e244c10eab3 ("kconfig: remove unneeded symbol_empty variable")
> ---
>  init/Kconfig | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)



Reviewed-by: Masahiro Yamada <masahiroy@kernel.org>



--=20
Best Regards
Masahiro Yamada

