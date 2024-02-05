Return-Path: <linux-fsdevel+bounces-10235-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5855584929D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 04:02:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3DC7B22510
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 03:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A51C8F56;
	Mon,  5 Feb 2024 03:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hXVQUf9r"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC9EAD21;
	Mon,  5 Feb 2024 03:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707102139; cv=none; b=r/ey8shZ9Z4YuoWMqZgNFvg9WjE5ZROYEuCu4oIf7gDoVdw+t1BoAeVg9lqVFuo22TZYxhdAKCc+PpQ5PuK6kMFbpys9Tvb//vXLVM8e1EjoH0Fbdsped6vbUfquqxl0nn6+DaxS/pRwSGzr1fJdU+m3vpzBTExvj9K5mIVwMXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707102139; c=relaxed/simple;
	bh=TYbzh/OEFiQDfXywnv9g98Qc220BQK26IRhqjsDlQQg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S8tUcg21Zelo8Yh/LfpqFO6M37jMx3pvJP3yc/J7vqaCFydO8YoL2W3Rn+ft6QmMW+hf+J3FOqd/DAoLHvKXAV4CLVDcXWV1bXchL7ycc1CqQYCl3dT/LjFRsaS1MZJRZVhSdc8dqoQb/4JhIOCV94A+A8dBqthVAPXh4zWkZEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hXVQUf9r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15BA7C43609;
	Mon,  5 Feb 2024 03:02:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707102139;
	bh=TYbzh/OEFiQDfXywnv9g98Qc220BQK26IRhqjsDlQQg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=hXVQUf9re+xMnRlzHi1W9+RCp+TT9ar4Lfi//XgCnigPGlWx4bgBAB0qmza+VVSKW
	 JsfzYJkSWmnVqh22UivT9FtW/gch/ZuyTfRQwFkoxvLFs0Tc68R+mp2ZKfE8Hv+cI3
	 6UH6jrKEB5aqtvH6qajHPviez4l6hCPDkHsoOSIySNITBfk7bdxcMnf2t7+UR6W0mY
	 2Wl/hrDuecwULCxNAYjZ17q7Tf+idYbKAzutvfLtMhq83jXRL3tNy0cC4ux81pQw6N
	 s5cAAFSei6w381nA1HCtZxkSwsnXkzU85kj5VHNg1DHGLM4eY6jTC1d0udO3y3IVdc
	 wjgMjelUO+DWg==
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2cf4a22e10dso47048631fa.3;
        Sun, 04 Feb 2024 19:02:19 -0800 (PST)
X-Gm-Message-State: AOJu0YxpZ4VR88WVdtMZEWQN6F+uOj7fQi+pg5MLAzv5bdjXW9WvBVK3
	/z3apcF9cTlCCoxIqLMNCxdGlm2oWjwhf6+Wyjs9YUVRe5qFyJNwKzt6NFl2+ReyGzvuxp7ZOz7
	4JnimRGHH9FpmFyLD7GWWuXhD5mY=
X-Google-Smtp-Source: AGHT+IE+oJIKXe4uY3Gsvbm7z773Z4pZ2tZdt67pNuGnUMgz4RUWeqBZDz2H1tdItXFr1Wy/1gVW7KXq6gX2/tmVaHk=
X-Received: by 2002:a05:651c:1a06:b0:2d0:a6c5:61a8 with SMTP id
 by6-20020a05651c1a0600b002d0a6c561a8mr2484307ljb.38.1707102137535; Sun, 04
 Feb 2024 19:02:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240204232945.1576403-1-yoann.congal@smile.fr> <20240204232945.1576403-3-yoann.congal@smile.fr>
In-Reply-To: <20240204232945.1576403-3-yoann.congal@smile.fr>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Mon, 5 Feb 2024 12:01:40 +0900
X-Gmail-Original-Message-ID: <CAK7LNAR6ZfMTQivsNBhm-Gu1e6XyqCFeRM=OR4rR=Wk2xMWW0Q@mail.gmail.com>
Message-ID: <CAK7LNAR6ZfMTQivsNBhm-Gu1e6XyqCFeRM=OR4rR=Wk2xMWW0Q@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] printk: Remove redundant CONFIG_BASE_SMALL
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

On Mon, Feb 5, 2024 at 8:30=E2=80=AFAM Yoann Congal <yoann.congal@smile.fr>=
 wrote:
>
> CONFIG_BASE_SMALL is currently a type int but is only used as a boolean
> equivalent to !CONFIG_BASE_FULL.
>
> So, remove it entirely and move every usage to !CONFIG_BASE_FULL:
> Since CONFIG_BASE_FULL is a type bool config,
> CONFIG_BASE_SMALL =3D=3D 0 becomes  IS_ENABLED(CONFIG_BASE_FULL) and
> CONFIG_BASE_SMALL !=3D 0 becomes !IS_ENABLED(CONFIG_BASE_FULL).
>
> Signed-off-by: Yoann Congal <yoann.congal@smile.fr>



Reviewed-by: Masahiro Yamada <masahiroy@kernel.org>




--=20
Best Regards
Masahiro Yamada

