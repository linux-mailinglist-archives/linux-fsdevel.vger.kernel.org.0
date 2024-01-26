Return-Path: <linux-fsdevel+bounces-9098-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ECEF683E283
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jan 2024 20:29:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77D521F23357
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jan 2024 19:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3263224F1;
	Fri, 26 Jan 2024 19:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UG5PAIoQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F47224D6;
	Fri, 26 Jan 2024 19:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706297362; cv=none; b=sEzDmW2eDnxrB+gHY5I/47JjbEaPRRCuC5OQbU4fXJnzuVHW8RzRBN5qiXWXyFMf9AcVeArzfHXH7f509adMyRUPPEpm2fNsrSf3H737ev/0UtKMCxKpa4EMmDtdiDao5ZdgAtJxHSe20Xma5+c87pGBU/5bn6HS9YhWGGImri0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706297362; c=relaxed/simple;
	bh=d3Qu7fTD7gUmS4YxN8SU+XVz/xymqzmIYwrU9V8q+A8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CaR+MNk0hJniCWWRUaHGWSRUYErRqEMPMF9rZGewaKba2rx9ZRZRnjxI2xSpOKe+0OloeMmkBtYyKvu7+otpzzR4p6/A80+l8lhZIDQWMlO+HIA7xAartCwSxApoxZz/0rxhBP7YS2wASGHkqkBGanCArHGzlPQ2I3xzTGVU9BI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UG5PAIoQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C390AC433C7;
	Fri, 26 Jan 2024 19:29:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706297361;
	bh=d3Qu7fTD7gUmS4YxN8SU+XVz/xymqzmIYwrU9V8q+A8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=UG5PAIoQNc/rIV0+PySIJVCq/4e9QH5zQqPq2nWFlVdsw0jPSIMh+4NOG+BFkWBVW
	 a6FOGcoGks+njs5MpjghIJO1BGBm420jYkghw+AvvcC0CELQDsk/N6OowDapHtL9SC
	 /R/T9CjhHlgI2Wce51LOylljbIIL6WhGIWyc4V40nAcInRO4gD59Mw+y9vrdAe4lcQ
	 GsxOS2TjyIQRHmz4aO+gfTI6yEUJ9Kv284VPsXcQbeeITOpvO4DrkFWhea40xKOHBw
	 3aIKgJKlLkumLADg88iFkA/apZcWFOZVaA9pkb8cIVXmVbKYFWoI3+mbp5mfj+k1vM
	 jcci+ufOM011Q==
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-21499c9650cso267095fac.1;
        Fri, 26 Jan 2024 11:29:21 -0800 (PST)
X-Gm-Message-State: AOJu0Yw9o1sonzCQCq0BuTu9rw+lEtN+OAoQeeFbSu/UMcVTSmlBxBo9
	GCpoTm1q137gYol20UM1yH8JiaLWkLJu/jXoPRQzVFRBuPM/MgMoKHduKQnGFcnULZLUJhFzbW3
	8VtG6cMwGL9cURCYflavEdJYFMlI=
X-Google-Smtp-Source: AGHT+IEwN+Jm0hybJL+QMO3pbnwQyEfotqNcyNNuh4RaRJKmR9XEsrQrq0wEa2qeZ6bmANtzA2xc290OTJJLWYifDaU=
X-Received: by 2002:a05:6871:228a:b0:214:940e:9953 with SMTP id
 sd10-20020a056871228a00b00214940e9953mr160162oab.24.1706297361123; Fri, 26
 Jan 2024 11:29:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240126163032.1613731-1-yoann.congal@smile.fr>
In-Reply-To: <20240126163032.1613731-1-yoann.congal@smile.fr>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Sat, 27 Jan 2024 04:28:44 +0900
X-Gmail-Original-Message-ID: <CAK7LNATBvhcyQXt58j74Q++Y74ZgjdC3r3rtnAuU0YMt_K_A7g@mail.gmail.com>
Message-ID: <CAK7LNATBvhcyQXt58j74Q++Y74ZgjdC3r3rtnAuU0YMt_K_A7g@mail.gmail.com>
Subject: Re: [PATCH] treewide: Change CONFIG_BASE_SMALL to bool type
To: Yoann Congal <yoann.congal@smile.fr>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Matthew Wilcox <willy@infradead.org>, 
	Peter Zijlstra <peterz@infradead.org>, Darren Hart <dvhart@infradead.org>, 
	Davidlohr Bueso <dave@stgolabs.net>, =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>, 
	"Luis R. Rodriguez" <mcgrof@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

(+CC: Luis R. Rodriguez, author of 23b2899f7f194)


On Sat, Jan 27, 2024 at 1:30=E2=80=AFAM Yoann Congal <yoann.congal@smile.fr=
> wrote:
>
> CONFIG_BASE_SMALL is currently a type int but is only used as a boolean:
> CONFIG_BASE_SMALL =3D=3D 0 vs CONFIG_BASE_SMALL !=3D 0.
>
> So change it to the more logical bool type.
>
> Furthermore, recent kconfig changes (see Fixes: tags) revealed that using

Seeing the Fixes tage does not reveal this issue.

The discussion in Closes: thread explains the issue.



>   config SOMETHING
>      default "some value" if X
> does not work as expected if X is not of type bool.
>
> CONFIG_BASE_SMALL is used that way in init/Kconfig:
>   config LOG_CPU_MAX_BUF_SHIFT
>         default 12 if !BASE_SMALL
>         default 0 if BASE_SMALL


Or, an even cleaner way is to remove BASE_SMALL because it is
the same as !BASE_FULL.


    config LOG_CPU_MAX_BUF_SHIFT
           default 12 if BASE_FULL
           default 0

You also need to invert the logic in C as well.



Perhaps, it might be worth mentioning this changes
CONFIG_LOG_CPU_MAX_BUF_SHIFT=3D12 to
CONFIG_LOG_CPU_MAX_BUF_SHIFT=3D0 for some defconfigs,
but that will not be a big impact due to this code:

 /* by default this will only continue through for large > 64 CPUs */
 if (cpu_extra <=3D __LOG_BUF_LEN / 2)
         return;




>
> Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Closes: https://lore.kernel.org/all/CAMuHMdWm6u1wX7efZQf=3D2XUAHascps76YQ=
ac6rdnQGhc8nop_Q@mail.gmail.com/
> Fixes: 6262afa10ef7 ("kconfig: default to zero if int/hex symbol lacks de=
fault property")

This tag is not relevant.


> Fixes: 4e244c10eab3 ("kconfig: remove unneeded symbol_empty variable")

This is correct.






> ---
> CC: Thomas Gleixner <tglx@linutronix.de>
> CC: Ingo Molnar <mingo@redhat.com>
> CC: Borislav Petkov <bp@alien8.de>
> CC: Dave Hansen <dave.hansen@linux.intel.com>
> CC: "H. Peter Anvin" <hpa@zytor.com>
> CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> CC: Jiri Slaby <jirislaby@kernel.org>
> CC: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> CC: Matthew Wilcox <willy@infradead.org>
> CC: Peter Zijlstra <peterz@infradead.org>
> CC: Darren Hart <dvhart@infradead.org>
> CC: Davidlohr Bueso <dave@stgolabs.net>
> CC: "Andr=C3=A9 Almeida" <andrealmeid@igalia.com>
> CC: Masahiro Yamada <masahiroy@kernel.org>
> CC: x86@kernel.org
> CC: linux-kernel@vger.kernel.org
> CC: linux-serial@vger.kernel.org
> CC: linux-fsdevel@vger.kernel.org
> CC: linux-kbuild@vger.kernel.org
> ---
>  arch/x86/include/asm/mpspec.h | 2 +-
>  drivers/tty/vt/vc_screen.c    | 2 +-
>  include/linux/threads.h       | 4 ++--
>  include/linux/udp.h           | 2 +-
>  include/linux/xarray.h        | 2 +-
>  init/Kconfig                  | 6 +++---
>  kernel/futex/core.c           | 2 +-
>  kernel/user.c                 | 2 +-
>  8 files changed, 11 insertions(+), 11 deletions(-)
>
> diff --git a/arch/x86/include/asm/mpspec.h b/arch/x86/include/asm/mpspec.=
h
> index 4b0f98a8d338d..ebe4b6121b698 100644
> --- a/arch/x86/include/asm/mpspec.h
> +++ b/arch/x86/include/asm/mpspec.h
> @@ -15,7 +15,7 @@ extern int pic_mode;
>   * Summit or generic (i.e. installer) kernels need lots of bus entries.
>   * Maximum 256 PCI busses, plus 1 ISA bus in each of 4 cabinets.
>   */
> -#if CONFIG_BASE_SMALL =3D=3D 0
> +#ifndef CONFIG_BASE_SMALL
>  # define MAX_MP_BUSSES         260
>  #else
>  # define MAX_MP_BUSSES         32
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
> index 8d4e836e1b6b1..766a7ac8c5ea4 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -1941,9 +1941,9 @@ config RT_MUTEXES
>         default y if PREEMPT_RT
>
>  config BASE_SMALL
> -       int
> -       default 0 if BASE_FULL
> -       default 1 if !BASE_FULL
> +       bool
> +       default n if BASE_FULL
> +       default y if !BASE_FULL
>
>  config MODULE_SIG_FORMAT
>         def_bool n
> diff --git a/kernel/futex/core.c b/kernel/futex/core.c
> index e0e853412c158..5f7aa4fc2f9ee 100644
> --- a/kernel/futex/core.c
> +++ b/kernel/futex/core.c
> @@ -1141,7 +1141,7 @@ static int __init futex_init(void)
>         unsigned int futex_shift;
>         unsigned long i;
>
> -#if CONFIG_BASE_SMALL
> +#ifdef CONFIG_BASE_SMALL
>         futex_hashsize =3D 16;
>  #else
>         futex_hashsize =3D roundup_pow_of_two(256 * num_possible_cpus());
> diff --git a/kernel/user.c b/kernel/user.c
> index 03cedc366dc9e..aa1162deafe49 100644
> --- a/kernel/user.c
> +++ b/kernel/user.c
> @@ -88,7 +88,7 @@ EXPORT_SYMBOL_GPL(init_user_ns);
>   * when changing user ID's (ie setuid() and friends).
>   */
>
> -#define UIDHASH_BITS   (CONFIG_BASE_SMALL ? 3 : 7)
> +#define UIDHASH_BITS   (IS_ENABLED(CONFIG_BASE_SMALL) ? 3 : 7)
>  #define UIDHASH_SZ     (1 << UIDHASH_BITS)
>  #define UIDHASH_MASK           (UIDHASH_SZ - 1)
>  #define __uidhashfn(uid)       (((uid >> UIDHASH_BITS) + uid) & UIDHASH_=
MASK)
> --
> 2.39.2
>


--=20
Best Regards
Masahiro Yamada

