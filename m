Return-Path: <linux-fsdevel+bounces-58096-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23779B293E6
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Aug 2025 17:37:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 643EA17FCC7
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Aug 2025 15:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E12DB23B629;
	Sun, 17 Aug 2025 15:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Vz7uq8DB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D86BF3176EB
	for <linux-fsdevel@vger.kernel.org>; Sun, 17 Aug 2025 15:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755444987; cv=none; b=jf0G7Z09KJUBs1e8CBKo3g/ZHnZxzsmAqCR/4PhhMNUExwkahHOFq9H2pmwX2R2huOmPyX6lUCvdjLNUwPNCoA4sOjrLZxeOjbpgAEGr18Ru/AIaibunHZelg0qDJBrBRKr4f6G1dnXyKIFeyhmWyMAxLJ03IV3WGr8MGCg/EjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755444987; c=relaxed/simple;
	bh=8zIH/Vxiw6+4KJA8zM1NgdPLSuYjydXDROzPgQyncUc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bxc0g8im8fpxE+Xe9HVoeoCVPLZ7/t7usCmS7rAzyTnuwOZrHSlkderkvfBpzlEohOtRlWSn6weZrFizI4k4eKe+DSPgzWfSmUEsaay09UOpZ7cP7DiHMBcQiUS/Wqh/Jy1TYQCL5WvuUODddYUmBe8Bef3gdtrzCDI1QqHSy4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Vz7uq8DB; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-afcb7a3b3a9so494469566b.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 17 Aug 2025 08:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1755444983; x=1756049783; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Uf4r+lmHvMNXzAtZIlS23aMvnorO7UZ/20ObTrW0tww=;
        b=Vz7uq8DBoqsZzPg4TvvLkrql9+ykopBv/5ddnoxu9Mu29Sk2LpBIhgaqNAooHLHOBu
         cNK12qUgEMCn+gEYUlaClSHIpu/CJYi7J5cpBOQhegirps0FZ+bJBA6dDOr47Q3N3uWg
         xRvfHFOnXdFjlv9/PtRtRarrMnHGk4ZxsyGL0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755444983; x=1756049783;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Uf4r+lmHvMNXzAtZIlS23aMvnorO7UZ/20ObTrW0tww=;
        b=DfaAnQ9CvdKSGkGe2KAq9EBsyLoqecalHt26tN23hivzFYbk18lAnKxc5ZI9ZwP4Kz
         8nobLA7KDYM0pgZFKSLrK7KuanBlyFZYzwSjr22KHGC51b0Aj1dpVGT4yt9SMAlpQjhq
         TNpxwI3L6NIAEL82qC0nj8uztQm72OVOlb54iA+sfnWR/n8deGc5g5W0cOlTKyjl1VTj
         S4WGz2TDFjI/7aC9MldLsoRP03A4KEx68aI7XiYXA+h8n3I8bG8Lx1rfKzs42xkIjZ+6
         9K2B46cFLd2cZbfwtdYpE4SJewBWGGf8Bk++UEgKvNus7ruuH95yF3tlGxtFLzrnUokl
         FloA==
X-Forwarded-Encrypted: i=1; AJvYcCUYDGPVa2DqJdCBlYIjQHRwV0+jr1Z6jmnoskAE7XDA/LOun5T0H08KikNT5yog73xq43zVlMBqs/BgIewq@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/uLb22prec2KeDfE9ha0NTIQE41S+k6FnkRjxHfrq8CFxCM/s
	0igkBBnmxpnvxcskJbkFBi/OzblRSubAZsaxI81Af54qq0Svg2pjKsBfgAPNc7m6x3V+B68L167
	x0jdEEko=
X-Gm-Gg: ASbGnctPuLiKtWuwYbUYXfhVxaT2p3dvMi8Qq5z6NuF4zE/KtIjqjcl5dU2vFf8T8bd
	n07AKGqpVow8q3mkDV/v5k5j7EzS0y354DDuO8T+3WbXbnkuHOKoGsHjHdpmJDhwTz2TsO+8WoJ
	ugbbgULp0RKbp613xm/fsWRjg3710Fa5ibPIKv2pyMcIoNarK2SRwMK2e+O6lH+6VlBtx45MgaN
	QytMlP5OkzyvInfMlDJ2x+sMsiM4eSmP1WdBx+gl4Ie+LHBVFJbkFNPXk5yVh2YHJbgeqnkVd36
	bazjjEllut2+b1wayBz730fLtxt8WkCf4U25ofoFbMf2pMuVlf8uWi9xnDl/Ngy1qtOtPMonqro
	jEso5mBJc2z6dFjHkwXjJvXL0mYFTioZAuylb55G3ctQoPRKJ4UNS1uudZyYDdTeXA1ZKsj+z
X-Google-Smtp-Source: AGHT+IELTwJtQdgGO14Oj6xekQmcANnh8C2zz5jE+cAVAtud67vavQrXLsXA958KVb/V6wV3Y/wmbA==
X-Received: by 2002:a17:906:a849:b0:af9:e3d3:a458 with SMTP id a640c23a62f3a-afcdc288d59mr626051066b.28.1755444983223;
        Sun, 17 Aug 2025 08:36:23 -0700 (PDT)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afcdce9ed8fsm620423466b.53.2025.08.17.08.36.22
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Aug 2025 08:36:23 -0700 (PDT)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6188b5f620dso3643030a12.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 17 Aug 2025 08:36:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUUneOGGvzggf/hmk7l984KsThS2et5NcZyq8sW+TX70pe/oe8+xXCYKKj0h0QMmqfDgKP4FrdZKCGwsEQT@vger.kernel.org
X-Received: by 2002:a05:6402:42c6:b0:618:1cd9:4af2 with SMTP id
 4fb4d7f45d1cf-618b054b7b9mr8315276a12.22.1755444982424; Sun, 17 Aug 2025
 08:36:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250813150610.521355442@linutronix.de> <20250817144943.76b9ee62@pumpkin>
 <CAHk-=wjsACUbLM-dAikbHzHBy6RFqyB1TdpHOMAJiGyNYM+FHA@mail.gmail.com> <20250817162945.64c943e1@pumpkin>
In-Reply-To: <20250817162945.64c943e1@pumpkin>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 17 Aug 2025 08:36:05 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgpAJiSSU-pVr297PX5kax_VvftXhDaKSrx8mpPxyfHRg@mail.gmail.com>
X-Gm-Features: Ac12FXw9gByTZpcG1G0n1kBC-N-MQtnZ68IaWz9cANis1ZGolEBil5sRRGcnMw4
Message-ID: <CAHk-=wgpAJiSSU-pVr297PX5kax_VvftXhDaKSrx8mpPxyfHRg@mail.gmail.com>
Subject: Re: [patch 0/4] uaccess: Provide and use helpers for user masked access
To: David Laight <david.laight.linux@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Peter Zijlstra <peterz@infradead.org>, 
	Darren Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>, 
	=?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>, x86@kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 17 Aug 2025 at 08:29, David Laight <david.laight.linux@gmail.com> wrote:
>
> Just requiring the caller pass &user_ptr would make it more obvious.
> The generated code (with 'src' -> *&src) will be the same.

I personally absolutely detest passing pointers in and then hoping the
compiler will fix it up and not make the assembler do the stupid thing
that the source code does.

That's actually true in general - I strive to make the source code and
the generated code line up fairly closely, rather than "compilers fix
up the mistakes in the source code".

> > We've done this before, and I have done it myself. The classic example
> > is the whole "do_div()" macro that everybody hated because it did
> > exactly the same thing
>
> Divide is (well was, I think my zen5 has a fast divide) also slow enough that
> I doubt it would have mattered.

It mattered for code generation quality and smaller simpler code to look at.

I still look at the generated asm (not for do_div(), but other
things), and having compiler-generated code that makes sense and
matches the source is a big plus in my book.

                 Linus

