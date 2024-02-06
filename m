Return-Path: <linux-fsdevel+bounces-10533-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 91EEE84C0A1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 00:06:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB3ABB24049
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 23:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B51C41CD30;
	Tue,  6 Feb 2024 23:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lvdPV+2C"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 116651CD17;
	Tue,  6 Feb 2024 23:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707260746; cv=none; b=C9YOGDie0z0fGTyTItR/963g1X/yi+Npx57RYc3AYLjcGpBYa7+BmU999fwNDFIAqO1Z5bxMD2vN/BApOlNsKsgH+4lgFFNgSsa3jVcAd/e5IL2WDIB3YIiKOi7oFC1ieVV7R2O+z5qOyAd/ltvDe/9Kh7nN/m99T3iT0DA5IuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707260746; c=relaxed/simple;
	bh=nXdR+a6VM2WRCvGRjAN8VSBuD/Uz2750SQd0svzgACE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U/RX5sZG5jsC1KL9VQKOhFOXKqHODe5qb4MkyDhKh4nn1alRW1SoyWiPd7oGfrAZo6OO/fgD36485eJOfideI4EaMfvldZm11p7s845pWvhl8hmxK+pMpJR7ILX9ibY8wSEuB0Jz9LpznevBTXxWYd+uSTjFqd8rGjegQfmmwLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lvdPV+2C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79C8CC43390;
	Tue,  6 Feb 2024 23:05:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707260745;
	bh=nXdR+a6VM2WRCvGRjAN8VSBuD/Uz2750SQd0svzgACE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=lvdPV+2CPODujZO0/HwvdGmj+dOSacaeKhUlP6vw58sJ0Ma4KA4zQykKw+t9xrg5m
	 w68WaeMmWfvypFp5tWxvktWHVRcfq/xHLo118H2GWtP1h/UA5Z3MXG/YgH+U4Y01rc
	 1O/PZPRBOsO2b1AHg/hb0Jad3P5vBT6EgiqMz6TV2Hus3Gf4cXST1P0yHCQ+hBoWvS
	 o6XbCxb6/EVZo5PcgPYDf40uXMcxDy5f1fjKZvn2xWvo4rHBq8vh7xMP2/GFaUi0AL
	 dfvT4a1zZrVren6mbnuoxq2n4ZXvzWOU8iHQVs9zQYHOa48KGhr2R7mMZEou0b8zLF
	 OeI7JLD9NCZ4w==
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-511490772f6so856e87.2;
        Tue, 06 Feb 2024 15:05:45 -0800 (PST)
X-Gm-Message-State: AOJu0YzgAWMBoyYqw7PkvH1DniGTfHESsEZvHqHy/wXd+nuJ4RniQ9Sd
	2BOxsB0UtUbBbCI0OcfWfbfG4534ks8Z4O/b2hT3UrFDS05ye8ZtysVtrbAN+QmLCEN9MKKEQY5
	gX9ifcFNW6anQbU3GaEX2Ei/vzss=
X-Google-Smtp-Source: AGHT+IEMbrPIpSm6OEH2wjHQ/bmWih8c7TetX4tr5aYc278nyCtvtcRboPNHPHMJOQ4NGrPQiVcY9Z4OoBcazk1ridA=
X-Received: by 2002:a2e:b6c6:0:b0:2d0:aa83:c5a4 with SMTP id
 m6-20020a2eb6c6000000b002d0aa83c5a4mr2463469ljo.51.1707260744020; Tue, 06 Feb
 2024 15:05:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240206001333.1710070-1-yoann.congal@smile.fr> <20240206001333.1710070-3-yoann.congal@smile.fr>
In-Reply-To: <20240206001333.1710070-3-yoann.congal@smile.fr>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Wed, 7 Feb 2024 08:05:07 +0900
X-Gmail-Original-Message-ID: <CAK7LNATzkZSK=hYbShOER=PnR7KVUBrDN=RL2Yyw413uMueiXw@mail.gmail.com>
Message-ID: <CAK7LNATzkZSK=hYbShOER=PnR7KVUBrDN=RL2Yyw413uMueiXw@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] printk: Change type of CONFIG_BASE_SMALL to bool
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
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 6, 2024 at 9:13=E2=80=AFAM Yoann Congal <yoann.congal@smile.fr>=
 wrote:
>
> CONFIG_BASE_SMALL is currently a type int but is only used as a boolean.
>
> So, change its type to bool and adapt all usages:
> CONFIG_BASE_SMALL =3D=3D 0 becomes !IS_ENABLED(CONFIG_BASE_SMALL) and
> CONFIG_BASE_SMALL !=3D 0 becomes  IS_ENABLED(CONFIG_BASE_SMALL).
>
> Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
> ---
> NB: This is preliminary work for the following patch removing
> CONFIG_BASE_FULL (now equivalent to !CONFIG_BASE_SMALL)
>
> v3->v4:
> * Split "switch CONFIG_BASE_SMALL to bool" (this patch) and "Remove the r=
edundant
>   config" into two patches
> * keep CONFIG_BASE_SMALL instead of CONFIG_BASE_FULL
> ---
>  arch/x86/include/asm/mpspec.h | 6 +++---
>  drivers/tty/vt/vc_screen.c    | 2 +-
>  include/linux/threads.h       | 4 ++--
>  include/linux/udp.h           | 2 +-
>  include/linux/xarray.h        | 2 +-
>  init/Kconfig                  | 8 ++++----
>  kernel/futex/core.c           | 2 +-
>  kernel/user.c                 | 2 +-
>  8 files changed, 14 insertions(+), 14 deletions(-)
>
> diff --git a/arch/x86/include/asm/mpspec.h b/arch/x86/include/asm/mpspec.=
h
> index 4b0f98a8d338d..c01d3105840cf 100644
> --- a/arch/x86/include/asm/mpspec.h
> +++ b/arch/x86/include/asm/mpspec.h
> @@ -15,10 +15,10 @@ extern int pic_mode;
>   * Summit or generic (i.e. installer) kernels need lots of bus entries.
>   * Maximum 256 PCI busses, plus 1 ISA bus in each of 4 cabinets.
>   */
> -#if CONFIG_BASE_SMALL =3D=3D 0
> -# define MAX_MP_BUSSES         260
> -#else
> +#ifdef CONFIG_BASE_SMALL
>  # define MAX_MP_BUSSES         32
> +#else
> +# define MAX_MP_BUSSES         260
>  #endif
>
>  #define MAX_IRQ_SOURCES                256
> diff --git a/drivers/tty/vt/vc_screen.c b/drivers/tty/vt/vc_screen.c
> index 67e2cb7c96eec..da33c6c4691c0 100644
> --- a/drivers/tty/vt/vc_screen.c
> +++ b/drivers/tty/vt/vc_screen.c
> @@ -51,7 +51,7 @@
>  #include <asm/unaligned.h>
>
>  #define HEADER_SIZE    4u
> -#define CON_BUF_SIZE (CONFIG_BASE_SMALL ? 256 : PAGE_SIZE)
> +#define CON_BUF_SIZE (IS_ENABLED(CONFIG_BASE_SMALL) ? 256 : PAGE_SIZE)
>
>  /*
>   * Our minor space:
> diff --git a/include/linux/threads.h b/include/linux/threads.h
> index c34173e6c5f18..1674a471b0b4c 100644
> --- a/include/linux/threads.h
> +++ b/include/linux/threads.h
> @@ -25,13 +25,13 @@
>  /*
>   * This controls the default maximum pid allocated to a process
>   */
> -#define PID_MAX_DEFAULT (CONFIG_BASE_SMALL ? 0x1000 : 0x8000)
> +#define PID_MAX_DEFAULT (IS_ENABLED(CONFIG_BASE_SMALL) ? 0x1000 : 0x8000=
)
>
>  /*
>   * A maximum of 4 million PIDs should be enough for a while.
>   * [NOTE: PID/TIDs are limited to 2^30 ~=3D 1 billion, see FUTEX_TID_MAS=
K.]
>   */
> -#define PID_MAX_LIMIT (CONFIG_BASE_SMALL ? PAGE_SIZE * 8 : \
> +#define PID_MAX_LIMIT (IS_ENABLED(CONFIG_BASE_SMALL) ? PAGE_SIZE * 8 : \
>         (sizeof(long) > 4 ? 4 * 1024 * 1024 : PID_MAX_DEFAULT))
>
>  /*
> diff --git a/include/linux/udp.h b/include/linux/udp.h
> index d04188714dca1..b456417fb4515 100644
> --- a/include/linux/udp.h
> +++ b/include/linux/udp.h
> @@ -24,7 +24,7 @@ static inline struct udphdr *udp_hdr(const struct sk_bu=
ff *skb)
>  }
>
>  #define UDP_HTABLE_SIZE_MIN_PERNET     128
> -#define UDP_HTABLE_SIZE_MIN            (CONFIG_BASE_SMALL ? 128 : 256)
> +#define UDP_HTABLE_SIZE_MIN            (IS_ENABLED(CONFIG_BASE_SMALL) ? =
128 : 256)
>  #define UDP_HTABLE_SIZE_MAX            65536
>
>  static inline u32 udp_hashfn(const struct net *net, u32 num, u32 mask)
> diff --git a/include/linux/xarray.h b/include/linux/xarray.h
> index cb571dfcf4b16..3f81ee5f9fb9c 100644
> --- a/include/linux/xarray.h
> +++ b/include/linux/xarray.h
> @@ -1141,7 +1141,7 @@ static inline void xa_release(struct xarray *xa, un=
signed long index)
>   * doubled the number of slots per node, we'd get only 3 nodes per 4kB p=
age.
>   */
>  #ifndef XA_CHUNK_SHIFT
> -#define XA_CHUNK_SHIFT         (CONFIG_BASE_SMALL ? 4 : 6)
> +#define XA_CHUNK_SHIFT         (IS_ENABLED(CONFIG_BASE_SMALL) ? 4 : 6)
>  #endif
>  #define XA_CHUNK_SIZE          (1UL << XA_CHUNK_SHIFT)
>  #define XA_CHUNK_MASK          (XA_CHUNK_SIZE - 1)
> diff --git a/init/Kconfig b/init/Kconfig
> index d50ebd2a2ce42..d4b16cad98502 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -734,7 +734,7 @@ config LOG_CPU_MAX_BUF_SHIFT
>         int "CPU kernel log buffer size contribution (13 =3D> 8 KB, 17 =
=3D> 128KB)"
>         depends on SMP
>         range 0 21
> -       default 0 if BASE_SMALL !=3D 0
> +       default 0 if BASE_SMALL
>         default 12
>         depends on PRINTK
>         help
> @@ -1941,9 +1941,9 @@ config RT_MUTEXES
>         default y if PREEMPT_RT
>
>  config BASE_SMALL
> -       int
> -       default 0 if BASE_FULL
> -       default 1 if !BASE_FULL
> +       bool
> +       default y if !BASE_FULL
> +       default n



The shortest form would be:


config BASE_SMALL
        def_bool !BASE_FULL



But, that is not a big deal, as this hunk will
be removed by 3/3.




Reviewed-by: Masahiro Yamada <masahiroy@kernel.org>








--=20
Best Regards
Masahiro Yamada

