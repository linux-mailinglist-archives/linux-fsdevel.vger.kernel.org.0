Return-Path: <linux-fsdevel+bounces-10531-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 693E684C097
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 00:04:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1DA67B25187
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 23:04:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 447E71C69E;
	Tue,  6 Feb 2024 23:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="llIjhFqs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 929941C2BC;
	Tue,  6 Feb 2024 23:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707260631; cv=none; b=FMhs5cKzl4fk1ICjPO2SzkqF5sO3GDJm5OtZtNfSlVn6wUslUL6vPjwYAEVTG7XXB3JRye1nK+Wtd3rWdVzloP//0pBeLWb04+pQNZ3KMaIRCsaTHHP0+DCFyXxrfbiqhsqUsPXpFSAthYINOc3ppmV1M4oElnEzfrCuyNM0J6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707260631; c=relaxed/simple;
	bh=4dxokc2QPwkquTf9uWdCyBwcesXL5u1vQk+9x9lj0w8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=noHMu5Vd2sCzxqhdo4etUhC8Ga9QdZkvF2qcHAJMyQf9NkIv5mSLvlFO7gshR3AqAm+4dFetUzjYMuFvBnOqlh91QOPMNrm9Yxvvnj+2Cat6MH22YmBl4iGtMw7Ip32WNKGasyVkn11jYC3mM/sCOcpu3xzNrG7VyOEVl4BS+VM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=llIjhFqs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BDBFC4166D;
	Tue,  6 Feb 2024 23:03:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707260631;
	bh=4dxokc2QPwkquTf9uWdCyBwcesXL5u1vQk+9x9lj0w8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=llIjhFqsMot38UiBSgpMbrU3q1EyAar3dbkYydDusLNp4etlKKxgYYA8CSCeeJgMR
	 UHtcQccrBub4GX8gC81MohKFqixZ/LPqBUqQeqjwgIsDVkb+lLLrjkuvyiIUscVXlS
	 OZ1xXJcD/bBDPoJHZL2lZyY7GMfq/MMnxGSEOKq1kfuy4wKIXLj7l/5coA+anl82ix
	 e/QN5QfVMxTuW9iMTOKVDNts3oDTcQjExG/33DV8FaDOwpCDPvsmZR3tJGMCCBoDMA
	 dtHox/jdzVMmhApZ0Gl2cEi4q+/8X5Ljl6cKOsOdXAwtmkuaARNvjVrTzTGX9WMGj4
	 76dgvpN+M1BpQ==
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2d0a0e40672so589871fa.0;
        Tue, 06 Feb 2024 15:03:51 -0800 (PST)
X-Gm-Message-State: AOJu0Yze7ZGktVyPat4K3p5Z3AB6GtagCPm/vgD7gSQbkmqgQ1pIiqsX
	hJY+NJ++HLazxM6Q9dslRAS6HBLh1VaXtE9SOIBzYqXGchC8czp8y3jenBKGKmLwR9jKMRvqrWv
	sEJA9CC0O/LpYmdlYYS3DezS9Vrs=
X-Google-Smtp-Source: AGHT+IHPsbwOOGRL3EAJfktD49MBO4GuGXVhAKtmtpsW8IP5vCf4bzzoS6Arg8OttOMnwkUGeLZmSyzohQ9br6sVeOs=
X-Received: by 2002:a2e:95d3:0:b0:2d0:af6e:5cb4 with SMTP id
 y19-20020a2e95d3000000b002d0af6e5cb4mr1383013ljh.16.1707260629362; Tue, 06
 Feb 2024 15:03:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240206001333.1710070-1-yoann.congal@smile.fr> <20240206001333.1710070-2-yoann.congal@smile.fr>
In-Reply-To: <20240206001333.1710070-2-yoann.congal@smile.fr>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Wed, 7 Feb 2024 08:03:12 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQ22qMJi3jQD8R_+7bi5DTz-pgMAEs91m-cDcnfOmES+A@mail.gmail.com>
Message-ID: <CAK7LNAQ22qMJi3jQD8R_+7bi5DTz-pgMAEs91m-cDcnfOmES+A@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] printk: Fix LOG_CPU_MAX_BUF_SHIFT when BASE_SMALL
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

On Tue, Feb 6, 2024 at 9:13=E2=80=AFAM Yoann Congal <yoann.congal@smile.fr>=
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



Reviewed-by: Masahiro Yamada <masahiroy@kernel.org>





--=20
Best Regards
Masahiro Yamada

