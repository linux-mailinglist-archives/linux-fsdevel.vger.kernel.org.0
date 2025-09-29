Return-Path: <linux-fsdevel+bounces-63038-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC2D8BA9E01
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Sep 2025 17:54:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D60A16A2AB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Sep 2025 15:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 254C430C111;
	Mon, 29 Sep 2025 15:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="OxM0XP+A"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B1E30B520
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Sep 2025 15:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759161240; cv=none; b=NrdUJewSBpUewf/zzpcF0HxYfWyXamA6WKSs5FDyazWoC5kJycGhiWgOZDSSenlkvRSqdqsuQ5S0q4dTwZzv9r4Qj+QvbhP3ophLzv5q4M7PFnrCCQNPQwdFVf4vJWCQNKuw1BoaWVXlsLG3uBhfirPuShG01jXFdJKwqhfzdxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759161240; c=relaxed/simple;
	bh=Vjm8rZ14V77HWC/fLQ6JHPrBH0h5AirUfmFPeFyAxHQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GfZHSm3Sphe9lqXD+brrvxnYDC1whEr2StHWpidI8px3ZeLg6IzYvCqSVecLVDV9FuQNt8Rm48vbHu9h/7g2ta51Tf8c0jHpcQpWrKXFFWc7/3iKzuQ76kFBi08zmM/oSXyP1aR/Fc79ogKm+aogIRfpG+ytHE08JNdXbt5WA0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=OxM0XP+A; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-afcb7ae31caso689162666b.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Sep 2025 08:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1759161237; x=1759766037; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8bogWF7ZzmqTQ/ldKkIp7R7jAOYo/1qoIHxhZsbi1nU=;
        b=OxM0XP+AVojK9/2XY2TUwGGccPBmByd/3UrCcjiSMYcWcjmBd8KukerL0Z1eyQDMdO
         v7v9zkTJtVEjLhyTgEHqSH4Cd9A6/xR52V0M5xC4Djh7vuf7sD3zrRKt7BLwDt5Ca0Yv
         ygFOEMAGDi/i3Of8/IFOBQQudyPfhRedgZttg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759161237; x=1759766037;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8bogWF7ZzmqTQ/ldKkIp7R7jAOYo/1qoIHxhZsbi1nU=;
        b=NZsMl+lRS005uHHpNGKN9Owl210pqsNBQvJpOLshe7ayCwaha/56lHu4tLA7LbVGPa
         vBFbR+RfWJLTgWFwBw+59sVcjaS6prDYskvGLQemtruJdQ8tBcXYCchZHy3KttOL+cXc
         ZQM+AkOr/f+zoYq66dOv3v9J+tVq5MWjngPK7AiihTaBzpPHDpOMkKQVwqmZvkyr27MK
         PZZR8EdTIJSR2eOeB/2JMXAddFQoUZkVcbgjamGf7PwrEEKPp5blpbjkf6UJBC1Wdv0A
         htrIhbGd2enDGoHH1egnGSrymLP2l+5z9MjGwTZfEBv3lzs1bplJlLItJb7ERAV+zfBm
         hQkQ==
X-Forwarded-Encrypted: i=1; AJvYcCXKgw/7hdifCD5yzFJRuZ4vk15KCU4Da8WHRuJje1u2npB9SznqnEfXuBkC/gDLa//00o6f8IzaD4HLz2bY@vger.kernel.org
X-Gm-Message-State: AOJu0YzVNLexM8YRYQovtNFbD87K7EqePY+dsh3OMX82jhFYmk9zaUwc
	nxFMz2XDjP7UwnPh/0eShrRksqPbz2vkzlGKyC//yLQsvnnxfhW7cZTeB/vRiCkioqsH59bOQj0
	id51wYds=
X-Gm-Gg: ASbGncuWDPYNbrsRxrBWNmPGKYExHJfP5Vkl3z1G1U4KvXd6SSZFi2X7zI6yxomZ/JY
	y4HUyHfvBFKvkiDrLpx4SGKMZdpM+wMw92qdxt2MWQ9Tm2A+S8AQ1Wb/6p9iBsKEyN50p5VT6JM
	b3Gb3A2OGLnmMqxI6tqrMH4q9+G4QC0Wja9LQoad/19rBoCyBiCiT4DDB6p8wA08uyvW+poyoYI
	kKZPtdjO9b/9kwLbUqwDMBad69RZyjtYI7xNJhrNvHCz0xYgYDVo84UOa9PgCV5mW1Zqogz2C/L
	PgaCjT3W8ejnvm6dd/oqMi0AIvPNPCYG2FsEh3IPU45QnBv0K4HPxYgZaPd6e6Swlx/6K5WqqJT
	czzNgaPI9dJooKx/M/7Ht3Zai/Ksxd/xtSVd3N1ksg5gytFzVDppfrZT33e+OEHY+daQYEevD
X-Google-Smtp-Source: AGHT+IGVRfIguTiPhpRZDLzALKME5MkzlcTVbZxfJPo4esdHKCxvxb9Le+bif4m5Wa/Y76Aw5ZbBdA==
X-Received: by 2002:a17:907:edc7:b0:b3d:5088:213d with SMTP id a640c23a62f3a-b3d50882582mr538750766b.42.1759161236756;
        Mon, 29 Sep 2025 08:53:56 -0700 (PDT)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com. [209.85.208.49])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b35446f79besm951138466b.69.2025.09.29.08.53.54
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Sep 2025 08:53:54 -0700 (PDT)
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-628f29d68ecso9966806a12.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Sep 2025 08:53:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUB1gdgBuWB3AT0ZZWvPjU32ZopEwlOgu+UbFhZgPuIxDE7d+2B7LwsPglzLvtJt3+DD3Xdl1ju/fRLMG+N@vger.kernel.org
X-Received: by 2002:a17:907:720a:b0:b40:664c:3317 with SMTP id
 a640c23a62f3a-b40664c5446mr230881766b.43.1759161234098; Mon, 29 Sep 2025
 08:53:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916163004.674341701@linutronix.de> <20250916163252.100835216@linutronix.de>
 <20250916184440.GA1245207@ax162> <87ikhi9lhg.ffs@tglx> <87frcm9kvv.ffs@tglx>
 <CAMuHMdVvAQbN8g7TJyK2MCLusGPwDbzrQJHw8uxDhOvjAh7_Pw@mail.gmail.com>
 <20250929100852.GD3245006@noisy.programming.kicks-ass.net>
 <CAMuHMdW_5QOw69Uyrrw=4BPM3DffG2=k5BAE4Xr=gfei7vV=+g@mail.gmail.com>
 <20250929110400.GL3419281@noisy.programming.kicks-ass.net> <CAMuHMdWtE_E75_2peNaNDEcV6+5=hqJdi=FD37a3fazSNNeUSg@mail.gmail.com>
In-Reply-To: <CAMuHMdWtE_E75_2peNaNDEcV6+5=hqJdi=FD37a3fazSNNeUSg@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 29 Sep 2025 08:53:37 -0700
X-Gmail-Original-Message-ID: <CAHk-=whmf8OKRBKW_xi6SLrvicif8a2e7Pn9v6Qi+ioDJxnqmg@mail.gmail.com>
X-Gm-Features: AS18NWA_sOSQWHCpV2l3Y3mPQhfU2h00coqPdVCtJP07FYq0uVp2OVr9zTyIh6I
Message-ID: <CAHk-=whmf8OKRBKW_xi6SLrvicif8a2e7Pn9v6Qi+ioDJxnqmg@mail.gmail.com>
Subject: Re: [patch V2a 2/6] kbuild: Disable CC_HAS_ASM_GOTO_OUTPUT on clang <
 version 17
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Nathan Chancellor <nathan@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	kernel test robot <lkp@intel.com>, Russell King <linux@armlinux.org.uk>, 
	linux-arm-kernel@lists.infradead.org, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Darren Hart <dvhart@infradead.org>, 
	Davidlohr Bueso <dave@stgolabs.net>, =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>, 
	x86@kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 29 Sept 2025 at 04:10, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> >
> > Ah, d'0h indeed.
> >
> > void b(void **);void* c();int f(void){{asm goto(""::::l0);return 0;l0:return 1;}void *x __attribute__((cleanup(b))) = c();{asm goto(""::::l1);return 2;l1:return 1;}}
> >
> > Seems to still finger the issue on x86_64. That should build on !x86
> > too, right?
>
> Thanks, builds fine on arm32, arm64, riscv, m68k, powerpc, mips, s390.

Ok, I just applied that fix directly. It's clearly not a fatal bug
since it just falls back on the non-optimal code, but it's one of
those "silly and subtle code generation issues" so I'd rather have it
fixed asap in the upstream kernel.

Geert, thanks for noticing.

             Linus

