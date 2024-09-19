Return-Path: <linux-fsdevel+bounces-29683-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD6C397C379
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Sep 2024 06:48:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54A0F1F231D7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Sep 2024 04:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9C1C2943F;
	Thu, 19 Sep 2024 04:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="gQpSkQJ6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 796AB28E37
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Sep 2024 04:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726721229; cv=none; b=dQKgkzxBq62jE8ShQ6sp52ZImwr33NPpJt5kyC29p599yIJ/bRbc9XalWQG1DLseMmS1znocpgveWWbz0oSvAnjxbhusBi9XgNoNkPGyAcQ1qgEqDrY7kvLfv6ReHcSa5e+nxFx7Uguc8FpUYYZ0eHBHtH77ZW1ZWC67eHMoww4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726721229; c=relaxed/simple;
	bh=0x90BrRaLqj/i8vH0YC0E0hwcTLNOAmqTSYD3JcCxfY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BotdnvTsecpA8ZwYw/gGk2c1LfUAw+xzQUhYXE8+hBO+Kt0u75L5Ic9bRRnR+Fx21GWm59L38DQk3TAfK7aWYRjSSDLrDSY7dFmy2kfhdyjlHPRNSp7eW9F1J3+u2MXIjW61ckgfmTm3hN9NCIOeJlV3Qoo8+nluiezOmeneZxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=gQpSkQJ6; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5c275491c61so583788a12.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Sep 2024 21:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1726721226; x=1727326026; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=v5K6WdNxpXbbHrFkTCJEcTGagR1i25Nnb2d6KDOnxQ4=;
        b=gQpSkQJ6vqQ1y97z7BQjKHYP1LBMTb/TP32/OFGANn63TxesWuhpyPL9/5CChtK8cW
         aXjTpoMAknDFKn9bnJUlOLvzuQrxaarRypMk8Igz+vRlkOB45sSj/LAAwK8qfCNyaoiW
         YpNSlKcsXyY041Xz9Kdw68pvlPXCykqdVHl/I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726721226; x=1727326026;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v5K6WdNxpXbbHrFkTCJEcTGagR1i25Nnb2d6KDOnxQ4=;
        b=Tia0hBf9HowvJLLoKpEaQYbEC1l1V5yMPsnnehRjwz6Wkv3dH/8oRvCKDBinOFWlms
         lbEUbxjsLmF2PcBkwBzCskZPf1qlJsMtIYmyxr7TBHkJXzNM6ksH7ATNmBsh7ADCeiBn
         8p7nY4J8K5/TdjykDIFI4iqnJVMojYSHsBSHfRtmDVYuEnXG+0EC0gXKBS5R0CLI8Q74
         AC+yejih7hQYidlfxtuWssks/j9jKG+JpCd2y7k0E8TVocIBiz0wwnmEBXfOQEQpZ8j/
         UiBx9XDqz+ECNR6fuqAKwQjGU2jnALnzmD2a/fyeHByt1I/XxHJTkT/WgZA3WNylGk/V
         cgPQ==
X-Forwarded-Encrypted: i=1; AJvYcCU9nLE0weCoOv0eiOjsiAbMIXc2+DCUHyJFupgVAiHg9gbgtw1+1zfKPqMt3wR9i8nqKW2YqpC45e3ff7Ja@vger.kernel.org
X-Gm-Message-State: AOJu0YzE1eZT4ubs86G78EAefq0uu/9k9BCpHh/Iy28j2HrvgSB58mJ2
	UmoQ6Gj/W27BDu/8LVfZGs3R6g4ub+Mt9bhjg1BxBC1OjICOgbHlaPOEdrUFU2Dgt6z+YdrEPGf
	Mvv9TWg==
X-Google-Smtp-Source: AGHT+IHEqAuYkDoBaL8jlCJ2O9545GYOHHz2G/kfJtKIV15c/30yp6eR8Tcj1uaV0E4ahFYKQrDvaA==
X-Received: by 2002:a05:6402:510f:b0:5c2:6083:6256 with SMTP id 4fb4d7f45d1cf-5c413e12255mr21939033a12.10.1726721225583;
        Wed, 18 Sep 2024 21:47:05 -0700 (PDT)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com. [209.85.218.43])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c42bc88d82sm5654112a12.81.2024.09.18.21.47.03
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Sep 2024 21:47:04 -0700 (PDT)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a8ce5db8668so55684466b.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Sep 2024 21:47:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUGVDZT0F5sAHNp2DF+AtLPYZzdaVYgoEtw4RLhxLIbbRXpJJJajrsPDTbwnV/rN4/gcTNyEuBuvyp9Em2a@vger.kernel.org
X-Received: by 2002:a17:907:efc6:b0:a86:9c71:ec93 with SMTP id
 a640c23a62f3a-a9029438edemr2426724866b.24.1726721223112; Wed, 18 Sep 2024
 21:47:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZulMlPFKiiRe3iFd@casper.infradead.org> <52d45d22-e108-400e-a63f-f50ef1a0ae1a@meta.com>
 <ZumDPU7RDg5wV0Re@casper.infradead.org> <5bee194c-9cd3-47e7-919b-9f352441f855@kernel.dk>
 <459beb1c-defd-4836-952c-589203b7005c@meta.com> <ZurXAco1BKqf8I2E@casper.infradead.org>
 <ZuuBs762OrOk58zQ@dread.disaster.area> <CAHk-=wjsrwuU9uALfif4WhSg=kpwXqP2h1ZB+zmH_ORDsrLCnQ@mail.gmail.com>
 <CAHk-=wgQ_OeAaNMA7A=icuf66r7Atz1-NNs9Qk8O=2gEjd=qTw@mail.gmail.com>
 <8697e349-d22f-43a0-8469-beb857eb44a1@kernel.dk> <ZuuqPEtIliUJejvw@casper.infradead.org>
In-Reply-To: <ZuuqPEtIliUJejvw@casper.infradead.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 19 Sep 2024 06:46:46 +0200
X-Gmail-Original-Message-ID: <CAHk-=whPYGhCWOD-K2zCTwDrCK27Y0GST-nt+cb9QPzxO-iSHw@mail.gmail.com>
Message-ID: <CAHk-=whPYGhCWOD-K2zCTwDrCK27Y0GST-nt+cb9QPzxO-iSHw@mail.gmail.com>
Subject: Re: Known and unfixed active data loss bug in MM + XFS with large
 folios since Dec 2021 (any kernel from 6.1 upwards)
To: Matthew Wilcox <willy@infradead.org>
Cc: Jens Axboe <axboe@kernel.dk>, Dave Chinner <david@fromorbit.com>, Chris Mason <clm@meta.com>, 
	Christian Theune <ct@flyingcircus.io>, linux-mm@kvack.org, 
	"linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Daniel Dao <dqminh@cloudflare.com>, 
	regressions@lists.linux.dev, regressions@leemhuis.info
Content-Type: text/plain; charset="UTF-8"

On Thu, 19 Sept 2024 at 06:36, Matthew Wilcox <willy@infradead.org> wrote:
>
> Probably xas_split_alloc() needs to just do the alloc, like the name
> says, and drop the 'entry' argument.  ICBW, but I think it explains
> what you're seeing?  Maybe it doesn't?

.. or we make the rule be that you have to re-check that the order and
the entry still matches when you do the actual xas_split()..

Like commit 6758c1128ceb does, in this case.

We do have another xas_split_alloc() - in the hugepage case - but
there we do have

                xas_lock(&xas);
                xas_reset(&xas);
                if (xas_load(&xas) != folio)
                        goto fail;

and the folio is locked over the whole sequence, so I think that code
is probably safe and guarantees that we're splitting with the same
details we alloc'ed.

                Linus

