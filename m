Return-Path: <linux-fsdevel+bounces-69145-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AC9ACC710DB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Nov 2025 21:42:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sto.lore.kernel.org (Postfix) with ESMTPS id 1605028A14
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Nov 2025 20:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E78436212F;
	Wed, 19 Nov 2025 20:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lg7pSp/L"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F9E2698AF
	for <linux-fsdevel@vger.kernel.org>; Wed, 19 Nov 2025 20:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763584909; cv=none; b=KTApnLV+tII7llZslf2OhVqrJBTfJe9imfU5ihryZAqKbjylxZZTYLCRwMH+0he56V/wWFLpakMAtwW3O0eoJJZaZaPRCgRoBLlRE3Q9wXFsPVsBq/3+HPJxfiCNtklrfG6NeDpRtxSwOOEepkHbRW5LyNitJVB5TpWt/Zk/UD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763584909; c=relaxed/simple;
	bh=b+tz1p7cNrPG0l2WOwFQAs2o5Jrd5luq9hX59BpI1j4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mb07ergL7NmFKXJR69EX2W/KebILPO/YGuMUTPR8B+1M+mrkHKsAnzpV1MMeQPgKhlXE00a8dkIGaPdQjXPpKjM3qJCtInp0BpeBd9lCjQGdoB09vsSjwEX8NMgDUBoWJCrFLtQu+FYpWlPuXRYZHLKrHArvJTfOJcmWoGI8wh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lg7pSp/L; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b737502f77bso28063766b.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Nov 2025 12:41:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763584906; x=1764189706; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IppogAUHH18tItkEdw5dwAaoGmxwsbCBpiBhH6VrP7U=;
        b=lg7pSp/LftZ0m8jWr84wIZwJFDTujHKlmBH6Fzd3oObYUE6PuUPV9VrqEuQ2qjbpGw
         UQRGgDjd8YeJdcwDEX2fkbC24tqbZx4vOhGqaVPMiccsTFWNPuz7RB1O937p7UZyQRo9
         QG0l72rij1Xi4Vt/FGZdTeDUBJjL7jl2pAHchXXOMAq/A2mLoVvsHDydZRz2Cw8hTukH
         IfGAnIvU8BaR/I9j3Y1JsaZ+iQj9VhRx+vkN7SOFh0E2aTIJQY9m+/QmBPPAX/c7A3v3
         z46M+u5IsGmbyM6amJ7RxnCvmW0jYsvsmCuO+iAbQQl06PV/hOBTOBGLWsD9NMTp/9ad
         fRAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763584906; x=1764189706;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IppogAUHH18tItkEdw5dwAaoGmxwsbCBpiBhH6VrP7U=;
        b=Li028a/fEB4eTlOAUGkUpI4wZoij1uksO6iHqkW2hmoeytsGowUAXaneIJtW2/51TX
         p4z5wVhSFkeum7XO0YsVVS9A4VbrfXs7V/69F4nvFIhwVZ8fGNLLgEwei/fRgEWWH/wv
         Fo4NBl4hZDSatr5MyQK4SikYEnkNs2aUk9l62AbLdkzvgBBMmqQMBgER5nO+C/w4MfG0
         83z9W/sg+41PYBzdVfU9KW837JPOUC+FhgtMFi3MAYXV+0zLIEN+hE2MtZppSVm8SRY4
         v8h8vsEzp+SbYXWHWSJnWfGw2PkfBdFcXqI0w8Lcj600zJS9ksiukEhBEbqMSuUFFLWO
         KICQ==
X-Forwarded-Encrypted: i=1; AJvYcCXcG0sM2BS/rZ2XbRJP0IvUCgWNe3ZVaNzkWw9VQAl218yCcFc3pcTPxR+/5wDPAt92/3QqfVCgtSOwME98@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+RA5RkItb+0sqYQubW2F3DaN2uMJqnNRUDYTH6cNTQxnbEzQu
	4kdqo7yCtQNLTtODtQDoeqa+Q9C9s/VqpFPQhbqly+LQ9ydFBE7Z3azLKqujt3aU+qnqx9pVGNf
	JGAd8E4DtSO+VEzPb4Y6yIgQE1mJkLx8=
X-Gm-Gg: ASbGncu4+4AcGB0n4zvNWeYnMv56yxZStfsXH5VgZPnmLps5EUPQ6W9a29bGe7auNG/
	vq30f+NZHAopjoAO+SMWVrYqF1/3iRUU9N2hgJ97ISNQqklGkYDMSRBts6kLsBGopBvJ/QwGabE
	SMCoqM2xna+I3in9Ju9YafMyDlHAAMev34O3YNRoZTekcnT6EAfq5irzqOs1GQxCl9vg4AEpYtH
	rLXDgvzOvdeouE5jCyNeeFxJ077LH1xRfv0af3rbg9nlxkku2a9Z+qBtbYrNQFVgngnOGhqZtRl
	sNo7F5m4A/USPR3VsyXRuNBLXaRacTXHR56o
X-Google-Smtp-Source: AGHT+IEQWY7RlIdtRSIAcFO3h6vBua6A0S467L6rc89fhpvJJFeI4p9aqJvCV0G0/2YusxRVX5brJMpOMUjixth811Y=
X-Received: by 2002:a17:907:3da3:b0:b72:d117:1a29 with SMTP id
 a640c23a62f3a-b7654fe99abmr52041666b.51.1763584906262; Wed, 19 Nov 2025
 12:41:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251119184001.2942865-1-mjguzik@gmail.com> <20251119194210.GO2441659@ZenIV>
 <CAGudoHHroVs1pNe575f7wNDKm_+ZVvK3tJhOhk_+5ZgYjFkxCA@mail.gmail.com>
 <20251119202359.GP2441659@ZenIV> <CAGudoHEPAGu4T9WvuA_zG_ALyMAbnbaFDqv54y4-G9FgbqEqrg@mail.gmail.com>
In-Reply-To: <CAGudoHEPAGu4T9WvuA_zG_ALyMAbnbaFDqv54y4-G9FgbqEqrg@mail.gmail.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Wed, 19 Nov 2025 21:41:32 +0100
X-Gm-Features: AWmQ_bnM21UZOox7LjvzXYgFFQ6E1K_es0gEnj7jecOP-3_ad4YVOn9izB2BP00
Message-ID: <CAGudoHHfkwDz33Vzw=t8Fxjym21Wtg2jTj_wB2bYRgOPPD8XYA@mail.gmail.com>
Subject: Re: [PATCH] fs: inline step_into() and walk_component()
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: brauner@kernel.org, jack@suse.cz, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> On Wed, Nov 19, 2025 at 9:24=E2=80=AFPM Al Viro <viro@zeniv.linux.org.uk>=
 wrote:
> >
> > On Wed, Nov 19, 2025 at 08:49:36PM +0100, Mateusz Guzik wrote:
> > > btw, is there a way to combine DCACHE_MANAGED_DENTRY + symlink check
> > > into one branch? The compiler refuses at the moment due to type being
> > > a bitfield. Given how few free flags are remaining this is quite a
> > > bummer.
> >
> > Is that really worth bothering with?  Condition is "bits 15..17 are 000
> > and bits 19..21 are _not_ 110" and I don't see any clean way to change
> > the encoding so that it could be done in one test.  In theory we could
> > do something like swapping the "type" and "managed" bits and use the
> > fact that 6 (symlink) is the maximal type we might run into, turning
> > that into flags & ((7<<15)|(7<<19))) < (6<<15), but...  *ewww*
> >

Forgot to respond to this bit.

I was looking for something *trivial* and hoped I merely missed it.

I completely agree anything complicated/fancy is not warranted.

