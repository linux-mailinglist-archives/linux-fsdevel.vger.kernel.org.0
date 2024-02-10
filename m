Return-Path: <linux-fsdevel+bounces-11055-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D55F850750
	for <lists+linux-fsdevel@lfdr.de>; Sun, 11 Feb 2024 00:42:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 245AF1F22AB1
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Feb 2024 23:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B21DE5FF07;
	Sat, 10 Feb 2024 23:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N8sfitrJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E03B5F552;
	Sat, 10 Feb 2024 23:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707608529; cv=none; b=LKgqHKVOeeBswNlBJWNt6Yk211ROqcw6WK0mKol2QBsbW63jjnwf1IB7qxsB2MLD876L0JMXO9I3TQSzL/zYPPRi4BPgYVN+6TRwuuZO+g4Lr2cS7RlK1tsDPRtdtkZ98d6sSfpNx1iDZ7knQ9QVMGahQuBlbXxdFmVbYjpKlCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707608529; c=relaxed/simple;
	bh=tFeQveoRiLrfsqwNncZbXzJt0Qth44vsHgw3n1Z0lF8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tS3pLqGNtEqjVUqsz/VbtjrTO2qWiTJL/yespRiyxE6zV57wmEgpHuNsskjaHJj/p42UTi6t8MaOCpwbMCuxT4UwFLCyLU/0jOge72HCO/K0+nJGhncsCSzm/wF6LUFbEenXUStLawe2iJ3YCzMMqAWr3I0ty1OPWpvz7bEe/8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N8sfitrJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 780E0C43390;
	Sat, 10 Feb 2024 23:42:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707608528;
	bh=tFeQveoRiLrfsqwNncZbXzJt0Qth44vsHgw3n1Z0lF8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=N8sfitrJHun5EHWTiV+Zk9uE6MBFV43sOsK1wsuiYVMMUJdcz6Vp/bZLhwlvmFUOT
	 QH3iKkHx4nFkY00vyvrnSbVCDPMQFv01B+hB09STZPrZnqj7dob8TNVJ5+TbbPDfPa
	 Rmemwde9W3hEqiyDGQrpH3vcmOJcBqtkjctTFIaNpYBvejdYHtqg9DgMVMoWB+SIke
	 ofj/yToMLimy1zhMVkuAHAb9GLia3VgsGTvmbpKUZpWI2T7rx2ztcLmtp8JH9uvys+
	 8QUhZV4hb51er5SbRXPnGtbtJa7V7Kq3Vd2w3nPd2/C5Sj+wnsHYFWA01kJ0z4FcQ/
	 9c0cFjdvQSrGw==
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2d0cdbd67f0so28139971fa.3;
        Sat, 10 Feb 2024 15:42:08 -0800 (PST)
X-Gm-Message-State: AOJu0YwThSOfbZbrtLiYyxjB8B9PdXpK1vtvbSV7waAW7+LInYCG90IJ
	p4P5yljlOELOMNu0+gk3Q3oMvQ7T/cHmgNxQs8LhPs/z/jq9xSXzgm/9ClLbLCjohMvrBKD5r3l
	4XFhkIfpqahPBqllZJIve2khiy/c=
X-Google-Smtp-Source: AGHT+IEbJqaoSU1K/Jh9ePGBhLd0QyFl6xt2h9LMrFdHvv6qvuDg0vyFqvf0hRxTlY1FOCSFhj2zXOVaAxK8ZWQxkSI=
X-Received: by 2002:a05:6512:ba0:b0:511:6f79:46e2 with SMTP id
 b32-20020a0565120ba000b005116f7946e2mr2646301lfv.64.1707608527006; Sat, 10
 Feb 2024 15:42:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240207171020.41036-1-yoann.congal@smile.fr> <20240207171020.41036-2-yoann.congal@smile.fr>
In-Reply-To: <20240207171020.41036-2-yoann.congal@smile.fr>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Sun, 11 Feb 2024 08:41:30 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQb=n1dWdEAJy_aJWnkW2M3bR768WKpxnUv=CtBEi28Xw@mail.gmail.com>
Message-ID: <CAK7LNAQb=n1dWdEAJy_aJWnkW2M3bR768WKpxnUv=CtBEi28Xw@mail.gmail.com>
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

On Thu, Feb 8, 2024 at 2:10=E2=80=AFAM Yoann Congal <yoann.congal@smile.fr>=
 wrote:
>
> LOG_CPU_MAX_BUF_SHIFT default value depends on BASE_SMALL:
>   config LOG_CPU_MAX_BUF_SHIFT
>         default 12 if !BASE_SMALL
>         default 0 if BASE_SMALL
> But, BASE_SMALL is a config of type int and "!BASE_SMALL" is always
> evaluated to true whatever is the value of BASE_SMALL.
>
> This patch fixes this by using the correct conditional operator for int
> type : BASE_SMALL !=3D 0.
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
> Petr Mladek <pmladek@suse.com> (printk maintainer) wrote:
> > More precisely, it allocated the buffer dynamically when the sum
> > of per-CPU-extra space exceeded half of the default static ring
> > buffer. This happened for systems with more than 64 CPUs with
> > the default config values.
>
> Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Closes: https://lore.kernel.org/all/CAMuHMdWm6u1wX7efZQf=3D2XUAHascps76YQ=
ac6rdnQGhc8nop_Q@mail.gmail.com/
> Reported-by: Vegard Nossum <vegard.nossum@oracle.com>
> Closes: https://lore.kernel.org/all/f6856be8-54b7-0fa0-1d17-39632bf29ada@=
oracle.com/
> Fixes: 4e244c10eab3 ("kconfig: remove unneeded symbol_empty variable")
>



All the Reviewed-by tags are dropped every time, annoyingly.




This is equivalent to v4, which had these tags:

Reviewed-by: Petr Mladek <pmladek@suse.com>
Reviewed-by: Masahiro Yamada <masahiroy@kernel.org>











> ---
> v3->v4:
> * Fix BASE_SMALL usage instead of switching to BASE_FULL because
>   BASE_FULL will be removed in the next patches of this series.
> ---
>  init/Kconfig | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/init/Kconfig b/init/Kconfig
> index deda3d14135bb..d50ebd2a2ce42 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -734,8 +734,8 @@ config LOG_CPU_MAX_BUF_SHIFT
>         int "CPU kernel log buffer size contribution (13 =3D> 8 KB, 17 =
=3D> 128KB)"
>         depends on SMP
>         range 0 21
> -       default 12 if !BASE_SMALL
> -       default 0 if BASE_SMALL
> +       default 0 if BASE_SMALL !=3D 0
> +       default 12
>         depends on PRINTK
>         help
>           This option allows to increase the default ring buffer size
> --
> 2.39.2
>
>


--
Best Regards
Masahiro Yamada

