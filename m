Return-Path: <linux-fsdevel+bounces-9353-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 11BA08403CC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 12:28:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E97BB234F6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 11:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACA8B5BAF0;
	Mon, 29 Jan 2024 11:28:20 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F165B5CD;
	Mon, 29 Jan 2024 11:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706527700; cv=none; b=n/o8lWMyiJ+p/bX24R6nYBASCsbsYWTVCNCoe6ojOy1zckIU8N+YoZWp0PTmogOIRwQmj4MBYE72jdoSvPdGMDiAnqj68s1ri/RCvMsqAuFqTvO37i9rFuZo4CZpfBRCJQbAbpxaX0BYtcsaNH5YDSyK6T3nP9Q0sFSCdJEK8Qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706527700; c=relaxed/simple;
	bh=wUsw0Cdio9HIrTvMxrO42mW+tn58+wtV3cvI3mNAlIw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aZqZ0SRCUW8eOMKTWfki+mOJv7i4GjKJwc3xxZj9vOsgfSUp+OjmWXpSEIPllQS7OH52AYls+ukB/rNRRT1+QV9RWyO4/ms3RQ2oNb4fK+H90WOPmyEf8tjS4c9vIR5576Ums3ZDd4sblihv4TONvqzfknqaMELKv65s0rAJb0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-33ae7ae9ec5so761131f8f.0;
        Mon, 29 Jan 2024 03:28:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706527696; x=1707132496;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+4YIyrQZE84MPTT9aFfLJsVlImUVjj/WiMP0MbsJFK8=;
        b=bxDjjpdbYVrbvgrk85XsyQIeiQ3NQF4dyseEuGAUFsJTF4VVjAexL1GMorDbS80JeA
         L1SGZhLECgpEdVF/A0HuDwPw1VcrUILR/8zEUk8RNHoFZkcDekNduQefYr0XTsF3wgTB
         JHnwDQDp8VdlnFg98OKoyfjjyhg2XiC/92HNzfOcIXFMeuwOorOMhtLpBHpGDlJRmMV9
         3mf7iBaAEDTYWxO817GBPV/5UdqeH8nnyq0J970fs5ohFv0cGEyokcIusXaFv1i31K6J
         sQiCOyLach1hHT2OdSLCYSlO9CU8NnVz3XuEMeAE2SjPeiOHp9rnNzqx+XGlCn+lw2WG
         /KOg==
X-Gm-Message-State: AOJu0YwDfltBkjPs999tpdR2Ob5GKB+m042lOitGvsiUgJexBwYXIO0o
	hbxLWcWKZiF0fh/7cfkVo+mnGUU4PeP5gwRAwxpbZ4MC/h+MN/oVxFr6i34iHOfz+A==
X-Google-Smtp-Source: AGHT+IEaAgkMciKh96CklypfXQvchezdlr4EWgvPfmyOveJ47Dl07/Gru+XwDh2076+YamMTLmSoJw==
X-Received: by 2002:adf:f5d1:0:b0:33a:e6f4:d22f with SMTP id k17-20020adff5d1000000b0033ae6f4d22fmr2889443wrp.13.1706527696400;
        Mon, 29 Jan 2024 03:28:16 -0800 (PST)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:59? ([2a0b:e7c0:0:107::aaaa:59])
        by smtp.gmail.com with ESMTPSA id h9-20020a05600016c900b0033aedb71269sm2419045wrf.88.2024.01.29.03.28.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jan 2024 03:28:15 -0800 (PST)
Message-ID: <60deb891-dab3-4440-82ff-c179486c0a79@kernel.org>
Date: Mon, 29 Jan 2024 12:28:13 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] printk: Remove redundant CONFIG_BASE_SMALL
Content-Language: en-US
To: Yoann Congal <yoann.congal@smile.fr>, x86@kernel.org,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
Cc: linux-kbuild@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>,
 "Luis R . Rodriguez" <mcgrof@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Matthew Wilcox <willy@infradead.org>, Peter Zijlstra <peterz@infradead.org>,
 Darren Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>,
 =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>,
 Masahiro Yamada <masahiroy@kernel.org>
References: <20240127220026.1722399-1-yoann.congal@smile.fr>
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <20240127220026.1722399-1-yoann.congal@smile.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 27. 01. 24, 23:00, Yoann Congal wrote:
> CONFIG_BASE_SMALL is currently a type int but is only used as a boolean
> equivalent to !CONFIG_BASE_FULL.
> 
> So, remove it entirely and move every usage to !CONFIG_BASE_FULL.
> 
> In addition, recent kconfig changes (see the discussion in Closes: tag)
> revealed that using:
>    config SOMETHING
>       default "some value" if X
> does not work as expected if X is not of type bool.
> 
> CONFIG_BASE_SMALL was used that way in init/Kconfig:
>    config LOG_CPU_MAX_BUF_SHIFT
>    	default 12 if !BASE_SMALL
>    	default 0 if BASE_SMALL
> 
> Note: This changes CONFIG_LOG_CPU_MAX_BUF_SHIFT=12 to
> CONFIG_LOG_CPU_MAX_BUF_SHIFT=0 for some defconfigs, but that will not be
> a big impact due to this code in kernel/printk/printk.c:
>    /* by default this will only continue through for large > 64 CPUs */
>    if (cpu_extra <= __LOG_BUF_LEN / 2)
>            return;
> 
> Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Closes: https://lore.kernel.org/all/CAMuHMdWm6u1wX7efZQf=2XUAHascps76YQac6rdnQGhc8nop_Q@mail.gmail.com/
> Fixes: 4e244c10eab3 ("kconfig: remove unneeded symbol_empty variable")
> ---
> v1 patch was named "treewide: Change CONFIG_BASE_SMALL to bool type"
> https://lore.kernel.org/all/20240126163032.1613731-1-yoann.congal@smile.fr/
> 
> v1 -> v2: Applied Masahiro Yamada's comments (Thanks!):
> * Changed from "Change CONFIG_BASE_SMALL to type bool" to
>    "Remove it and switch usage to !CONFIG_BASE_FULL"
> * Fixed "Fixes:" tag and reference to the mailing list thread.
> * Added a note about CONFIG_LOG_CPU_MAX_BUF_SHIFT changing.
...
> --- a/drivers/tty/vt/vc_screen.c
> +++ b/drivers/tty/vt/vc_screen.c
> @@ -51,7 +51,7 @@
>   #include <asm/unaligned.h>
>   
>   #define HEADER_SIZE	4u
> -#define CON_BUF_SIZE (CONFIG_BASE_SMALL ? 256 : PAGE_SIZE)
> +#define CON_BUF_SIZE (IS_ENABLED(CONFIG_BASE_FULL) ? PAGE_SIZE : 256)

Why is the IS_ENABLED() addition needed? You don't say anything about 
that in the commit log.

thanks,
-- 
js
suse labs


