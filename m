Return-Path: <linux-fsdevel+bounces-10462-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF03F84B64A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 14:26:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A5B31F25D3C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 13:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51774130E3A;
	Tue,  6 Feb 2024 13:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E7EeiG77"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D02130AE8;
	Tue,  6 Feb 2024 13:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707225982; cv=none; b=Z5ivhBZaKw63SoIWM5qvTtI4QWQpT6QOhyFsk2m3tbCsMrA6pZRfwT6wCNerrYevl7wWqFrtMxli1e4VQJthOwzriyjClJDb/pGZIblGDh+PQrsd6gsKKeEPZTjuOYDJiQL2ZO3q5HqYZsnIOYUWRkfTy3xwghHyG6jeMNqJJCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707225982; c=relaxed/simple;
	bh=TIFO8gUqQl8VkEe9RY5Z1blMtAjsU3qzRmne20uAnpk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JNIoLPiV5Gyf6L8tx+yehY//yaBEEEvPzg/WyMiFiTtBENMQGat9Xt0LgC4y23qlbcbaxjJm3F29LOiwsNBpTyr60UejiXzSgyHHppbJgSzzVlo4NU2Jwf6YehXFgcF/1epplOQnEnGHWQd+yrcmCaGhWI82aqZK/YeAeSwEmPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E7EeiG77; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B17DC4166A;
	Tue,  6 Feb 2024 13:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707225982;
	bh=TIFO8gUqQl8VkEe9RY5Z1blMtAjsU3qzRmne20uAnpk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=E7EeiG77Ofh6vxf9juuo6IqjVmfqWbjXrUeDdCP6AHe2FZgtO0FCqyfGmCZhhXpgs
	 qi0YDrUzhy8cXxysZGgyx7uyip5GuvNfK8Oi21ZQaLumhjpJcdaZB2crrikxvPKJgz
	 hOPlcWHaTqGJsc+ODjpb2GgM6l9OyQg+H79aQw/Hnw1bQD1q/cuWILI5uMcYPREVmE
	 /f7eVkohOf96HdMBaI6AEp38fzOvx6vcCCWrVee+Q5WonhwCqGPISvKD/KhfZ7BwZB
	 stGzqsRtds9y+ywMkSh7gR3Sx6gu3yFP/KXJiiVMJA8jpdXJKG63frKBf28xuQJ2iv
	 oqhW88P+xREsA==
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5114c05806eso1367380e87.1;
        Tue, 06 Feb 2024 05:26:22 -0800 (PST)
X-Gm-Message-State: AOJu0YwCXJbvjxta5qUd0RpCyMPmtay5+TNgr/jl9SL/0zZIJVRrtcUj
	X4WVWpqHqm+SC+EG0fbChPIavKlXU0Q1+qjldrINZanwwjg7oZIHPSXSSPcruDpyp2Rnjd93qRg
	O7+Nky3qX5SFFvpPVRdy0hksfhl4=
X-Google-Smtp-Source: AGHT+IEa5QC0ai6rRaO2r0XCAaqM1VhyQj0kTWdttgrBOWUVAsLokpbZFN/c+ZpoGyEexQKQjYcFnhHQr7nN/qROzLE=
X-Received: by 2002:a05:6512:1091:b0:511:5ca2:2a3f with SMTP id
 j17-20020a056512109100b005115ca22a3fmr1990570lfg.9.1707225980312; Tue, 06 Feb
 2024 05:26:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240206001333.1710070-1-yoann.congal@smile.fr> <20240206001333.1710070-4-yoann.congal@smile.fr>
In-Reply-To: <20240206001333.1710070-4-yoann.congal@smile.fr>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Tue, 6 Feb 2024 22:25:43 +0900
X-Gmail-Original-Message-ID: <CAK7LNARUdHkihZhdw54i1Yx=Ew7vQqmXCF_D6O3r3hMbMFev0g@mail.gmail.com>
Message-ID: <CAK7LNARUdHkihZhdw54i1Yx=Ew7vQqmXCF_D6O3r3hMbMFev0g@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] printk: Remove redundant CONFIG_BASE_FULL
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
> CONFIG_BASE_FULL is equivalent to !CONFIG_BASE_SMALL and is enabled by
> default: CONFIG_BASE_SMALL is the special case to take care of.
> So, remove CONFIG_BASE_FULL and move the config choice to
> CONFIG_BASE_SMALL (which defaults to 'n')
>
> Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
> ---
> v3->v4:
> * Split "switch CONFIG_BASE_SMALL to bool" and "Remove the redundant
>   config" (this patch) into two patches
> * keep CONFIG_BASE_SMALL instead of CONFIG_BASE_FULL
> ---
>  init/Kconfig | 13 ++++---------
>  1 file changed, 4 insertions(+), 9 deletions(-)
>
> diff --git a/init/Kconfig b/init/Kconfig
> index d4b16cad98502..4ecf2572d00ee 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -1581,11 +1581,11 @@ config PCSPKR_PLATFORM
>           This option allows to disable the internal PC-Speaker
>           support, saving some memory.
>
> -config BASE_FULL
> -       default y
> -       bool "Enable full-sized data structures for core" if EXPERT
> +config BASE_SMALL
> +       default n



A nit.

Please drop the redundant 'default n' next time
(as it seems you will have a change to send v5)







> +       bool "Enable smaller-sized data structures for core" if EXPERT
>         help
> -         Disabling this option reduces the size of miscellaneous core
> +         Enabling this option reduces the size of miscellaneous core
>           kernel data structures. This saves memory on small machines,
>           but may reduce performance.
>
> @@ -1940,11 +1940,6 @@ config RT_MUTEXES
>         bool
>         default y if PREEMPT_RT
>
> -config BASE_SMALL
> -       bool
> -       default y if !BASE_FULL
> -       default n
> -
>  config MODULE_SIG_FORMAT
>         def_bool n
>         select SYSTEM_DATA_VERIFICATION
> --
> 2.39.2
>


--=20
Best Regards
Masahiro Yamada

