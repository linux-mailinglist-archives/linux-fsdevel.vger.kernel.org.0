Return-Path: <linux-fsdevel+bounces-11056-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C424A850754
	for <lists+linux-fsdevel@lfdr.de>; Sun, 11 Feb 2024 00:45:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 307C5283832
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Feb 2024 23:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CFF75FF09;
	Sat, 10 Feb 2024 23:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G+EJlIyq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD161E4B0;
	Sat, 10 Feb 2024 23:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707608718; cv=none; b=Yh0vmi0aww3M5Q4aAiELZHPRpGD3zk2KEZg0p0UnvbkJwz+KHwyfu4n/JTutVxFjw7D5rYzWUj7z1AJztE4PX9iABhgl5Gb2kYJuR55QMD7eXQMPMeFZZaUY6a4lO6bwChdwKyR+D9RMkPQCNXMy2ZI2LWrYP3Adfemw+yyvT0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707608718; c=relaxed/simple;
	bh=Fo4q6uKanit7DMEeutkjQprz06QV0NMnT7elbjPA5t8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bZlWDe/R4wHfnpjVcvFrryUaQQ7B5KAg6L4xzSXwpN//NH/kk+44rABPyi+PY8ST5jsVwHrKrQ4KiML6f2hM8B9LQXQ6pkF2tZVDv7aP2VJ91QLiGaOn/gL34b5OLOcxVjZZF5n1ufWXMbGsCHfhBiWXQsIymU7rJ/If9xpFQpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G+EJlIyq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3982C433B1;
	Sat, 10 Feb 2024 23:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707608717;
	bh=Fo4q6uKanit7DMEeutkjQprz06QV0NMnT7elbjPA5t8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=G+EJlIyqaiKDL9BWVAXmw6u8mg6m9erdRhWFBuS9WCfaCAqaaGmWHpkmUaGYJAQUZ
	 wmLROIsYt0Y+TKHfyXOHlXjxRmPFbARjO85gOTGFoAMWJEUv8M+e2eiGuSyW/3r5aI
	 R4+hSJYfyhtAm2etDxEfJHduEbs1NwzaQekSJzEpe8bbN32MlIPCP/19vL3poHAG5K
	 7KlLTeLJWLjvZNk+gQqgfHFgvOtKR/GpxukLBnjVdiKULPLlTR5ZUcTpjxVsUbjcIN
	 Q7uu6IR4316ZsvZ8ezrVFNJrTnpn3dDAXFBoD5D2O3H0UC3rk5oH2d2ZJ4WP6UGJNT
	 NuUnhMgDWfx0Q==
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2d0e5210151so9493191fa.3;
        Sat, 10 Feb 2024 15:45:17 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUWpCa7Hu0n7sWlBLWLi3qBFLNNSDqnIx0KwzBxIITI+GiLD91qw+MDWlP8Gywun03KpF+TRFNNAavrYgjr97q3s+SCORUTDI/VqSn1D466Aosofgj4i6y1aiIIU2keaMwti4CXHNG4fqsuYbnusmLvD1moLQrTlJ/+CScT/1GoLZmAxKq0KRkO
X-Gm-Message-State: AOJu0YyOwBKdIxFu5RgsKqs1FJ9D0+MBKHoI/fJuKw9SOAUwMl+z7WHZ
	0cweEwRJAFtEhA3Q8gh3uBEPqaWSMgb+KdPTYCpZ9nfqOoCEsT9EE0BL6HRg2a6/UZp8Lk27EMv
	oCWTjiR6ByVVMwMNTgirMy2pBkNQ=
X-Google-Smtp-Source: AGHT+IGPHsYqAJLhvEbkGBhJi/WuePNI23sDQy/NTp1/QzgwlvnFf/YB3uD6cIhglHQbMTvsBhy0thwEuG71yQQoaDI=
X-Received: by 2002:ac2:4ada:0:b0:511:62a2:bafe with SMTP id
 m26-20020ac24ada000000b0051162a2bafemr1943955lfp.30.1707608716334; Sat, 10
 Feb 2024 15:45:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240207171020.41036-1-yoann.congal@smile.fr> <20240207171020.41036-3-yoann.congal@smile.fr>
In-Reply-To: <20240207171020.41036-3-yoann.congal@smile.fr>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Sun, 11 Feb 2024 08:44:40 +0900
X-Gmail-Original-Message-ID: <CAK7LNAS0BY3sAzcVj1=pGhBfCi72trvE8aMHB2KtmrRc3hfrNw@mail.gmail.com>
Message-ID: <CAK7LNAS0BY3sAzcVj1=pGhBfCi72trvE8aMHB2KtmrRc3hfrNw@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] printk: Change type of CONFIG_BASE_SMALL to bool
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

On Thu, Feb 8, 2024 at 2:10=E2=80=AFAM Yoann Congal <yoann.congal@smile.fr>=
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







This is almost the same as v4, which had these tags:

Reviewed-by: Petr Mladek <pmladek@suse.com>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Masahiro Yamada <masahiroy@kernel.org>






--=20
Best Regards
Masahiro Yamada

