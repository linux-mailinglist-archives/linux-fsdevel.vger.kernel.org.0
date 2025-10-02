Return-Path: <linux-fsdevel+bounces-63322-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19CD7BB4EE5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 02 Oct 2025 20:48:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC779423418
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Oct 2025 18:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE5EA27A446;
	Thu,  2 Oct 2025 18:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VUMrSvKv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD71B15539A
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Oct 2025 18:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759430910; cv=none; b=VfwZ4dUk2wEuu5hw/l01zft9O7Uz7hL7o8fzb3i3r+CoIz9WZWpmdLjHR6EEbR+I2fIsF5Cu87/yPf2OJtYFEALmB5yZMV5XyFKx0UtNnmv2A9QFtboLrNSJKRbp3GgFoEC8Pi744vFqoiwoCdZ/l577eXl6SxFijyoGpvtRVZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759430910; c=relaxed/simple;
	bh=doOvg/9J4AUYwzmUXltPYDkCP5ehIFVQlI77JtYdodY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AIXD0EvowPucq+wlaPO9wITCHH/czYZFSBRrQ2lBjx83ExMbd4xhCKKYJt6qiNG22xSITT0XAVo1m3rfQKEqJqSrCER2amamgQ4sPIrYiUVQq4EwpBB28Dv1TRBC5MVn9pQGFjuEse3M6JOHBYNetUCod+w/3EoOMcLqFY62juI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VUMrSvKv; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3f2cf786abeso943722f8f.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Oct 2025 11:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759430907; x=1760035707; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fgjf4Q8TmMxBgFclVgV3Hi99Hhu3hDBuYkmCSxYCGGs=;
        b=VUMrSvKvH42kNeYxO3CURO3jIlY+hKi5ZVACWW0HOxw8sMp61LVIQzM3vFNTY9s9ns
         uNspZRAb5hWzaHMugEmjLMKauzhoseYEG6MvWENkXZ/dDvgIi+y1aDKUMmmzrFDozJwO
         YrS7yDwGbU5KhrxT+Y+YTHEFhfHTwbBOdBc68EjzNryhjRExhJnQ9KYrvovc40yCEvJ8
         mYvkdUE0uWAiN+/WKqwFzhroI0bxR39mCddIFsu7OGpZUTXSBFKO5G7F8VDGdW50csHj
         CWLfIqmGKWxp8ISTUFniitcJegdmmvpMk7SVESOOzJ5VyFYyC7/pzzBGqxI0Q9Uph0Kr
         iaAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759430907; x=1760035707;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fgjf4Q8TmMxBgFclVgV3Hi99Hhu3hDBuYkmCSxYCGGs=;
        b=wCfx2hZ4Z+CTQsv3hLofbsphg8zdT4tRsbOkI6bipsHBI/5iPzWnqWnQEVY4qS9kCO
         sZU6D3f+zRngPEuWLqEtxJDd1u3c+t5iJ6MD3DfLBMNAUN4fXKrwa4ULFSAH43+GzVMt
         dRsOd/TSYRW0Ev9/2qS0rKIsYVbKNZ8UrzBySHpDswpOZqn/M/90IAzhdTaE+4cdndAU
         O4i32n3PL0bEiRSNpUb720zhswOzsmtKkmE3Gal35kT5uC6fkGgOp1sIrMHx1+Qsz7z2
         ZFzdsCrCdi9NDfgGg7vsI9Waodfqoj7tgZccHLPkPYtUXqHyiS2WR93pHp/MsSAB5Z4a
         vVOA==
X-Forwarded-Encrypted: i=1; AJvYcCVYz7NGbJxdT9nMWZZrprArCWoo8vT9Yh3cPG5WYTGNaoe44pQTe9uogvVuEFbV+D3LJQBOdwL6ueDTSzD7@vger.kernel.org
X-Gm-Message-State: AOJu0YwtM6Pj8dOn1h4vaq6SX/PS4uZfFklZ+rK5JKj1P6tR2mwl8NpL
	AtNjznS8933fwZf09+5iKE3E8zzvVyFXdkbAG9Qohj0udqm5H1y2js8q
X-Gm-Gg: ASbGnctU4+PTW8YB6AKKTbHBZe8z5XCrLrSqGc/T1Oksd2tH5o2iRviBGf8loTGb54J
	s6WABnfPxspWDX2DkXd4ZZcWuGhnQ5GBrg/KwPbSq7Sue68VG0Yi+kbQQM01L8W2ST4fZSN5sBB
	HsfaoM9/i4MWn2oh+p90t9lHFV7aqSs1rN1ZpdyETXEx66LteSA21QDmM6UENvEpDYTokUjSYjW
	bJRJbbz3zXnYauJ5UWBRuKvdJ1A+UdQjU3LFiMC9UY0UvpmkaHTCxDoyko2UJ8eLJw9XZ/1fZqe
	Aa9lL89mYAt+JazpBpQmfHSkSeqAx8/7YIJ9X49DKLoQCnkvOsEkZhbFQnzy8iFdI7pcwetmtj7
	io4kgtQxotG9c53n6AkrsVsRflQmGap2JmuQGTJ6Se+5NNNGv0SocqHBbd5h15hHxdOQDVUr9ca
	REmdI8meFvuNHk
X-Google-Smtp-Source: AGHT+IGPZyy98EunzVJ6yivTxgcZu+hh+n+arOejBmpGA2ZRyOHrbEnCoAuwnsGkUwYPhwrqhwXocA==
X-Received: by 2002:a05:6000:603:b0:3ee:3dce:f672 with SMTP id ffacd0b85a97d-4256712a5dcmr209162f8f.4.1759430906615;
        Thu, 02 Oct 2025 11:48:26 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8f083asm4640243f8f.43.2025.10.02.11.48.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 11:48:26 -0700 (PDT)
Date: Thu, 2 Oct 2025 19:47:34 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Peter Zijlstra
 <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Nathan
 Chancellor <nathan@kernel.org>, LKML <linux-kernel@vger.kernel.org>, kernel
 test robot <lkp@intel.com>, Russell King <linux@armlinux.org.uk>,
 linux-arm-kernel@lists.infradead.org, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Darren Hart <dvhart@infradead.org>,
 Davidlohr Bueso <dave@stgolabs.net>, =?UTF-8?B?QW5kcsOp?= Almeida
 <andrealmeid@igalia.com>, x86@kernel.org, Alexander Viro
 <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara
 <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Subject: Re: [patch V2a 2/6] kbuild: Disable CC_HAS_ASM_GOTO_OUTPUT on clang
 < version 17
Message-ID: <20251002194734.7cb2be8e@pumpkin>
In-Reply-To: <CAHk-=whmf8OKRBKW_xi6SLrvicif8a2e7Pn9v6Qi+ioDJxnqmg@mail.gmail.com>
References: <20250916163004.674341701@linutronix.de>
	<20250916163252.100835216@linutronix.de>
	<20250916184440.GA1245207@ax162>
	<87ikhi9lhg.ffs@tglx>
	<87frcm9kvv.ffs@tglx>
	<CAMuHMdVvAQbN8g7TJyK2MCLusGPwDbzrQJHw8uxDhOvjAh7_Pw@mail.gmail.com>
	<20250929100852.GD3245006@noisy.programming.kicks-ass.net>
	<CAMuHMdW_5QOw69Uyrrw=4BPM3DffG2=k5BAE4Xr=gfei7vV=+g@mail.gmail.com>
	<20250929110400.GL3419281@noisy.programming.kicks-ass.net>
	<CAMuHMdWtE_E75_2peNaNDEcV6+5=hqJdi=FD37a3fazSNNeUSg@mail.gmail.com>
	<CAHk-=whmf8OKRBKW_xi6SLrvicif8a2e7Pn9v6Qi+ioDJxnqmg@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 29 Sep 2025 08:53:37 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Mon, 29 Sept 2025 at 04:10, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> >  
> > >
> > > Ah, d'0h indeed.
> > >
> > > void b(void **);void* c();int f(void){{asm goto(""::::l0);return 0;l0:return 1;}void *x __attribute__((cleanup(b))) = c();{asm goto(""::::l1);return 2;l1:return 1;}}

Should that be 'void *c(void);' (with an extra void) to avoid failing because
of the K&R function declaration?

	David

> > >
> > > Seems to still finger the issue on x86_64. That should build on !x86
> > > too, right?  
> >
> > Thanks, builds fine on arm32, arm64, riscv, m68k, powerpc, mips, s390.  
> 
> Ok, I just applied that fix directly. It's clearly not a fatal bug
> since it just falls back on the non-optimal code, but it's one of
> those "silly and subtle code generation issues" so I'd rather have it
> fixed asap in the upstream kernel.
> 
> Geert, thanks for noticing.
> 
>              Linus
> 


