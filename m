Return-Path: <linux-fsdevel+bounces-27548-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BACB8962539
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 12:48:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDF251C21822
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 10:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11A9B16A37C;
	Wed, 28 Aug 2024 10:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hLUNT2+y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E531581E0
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Aug 2024 10:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724842082; cv=none; b=rVIZmotk2sJKG/7lfP8/q3k+uTrYwyMhuh8aFPYgVgLMVhMDh/+b6SKx7MXgWQU0FjYV6UfufBFxzFo02acwQu57dlUxTkmPOZP8Iqy9Y6hu1CLfi+MmapjlipQat+gICQXFxCbPSroyBSWAF03yPyNmHKK9Hf68pVMhW1YVoKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724842082; c=relaxed/simple;
	bh=25RFEZCC+MOPwsF2W/Qg8fFAOjsUPL7pT3dA0yn25jM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Iy7dTyJXsJcc4JBYvkTNWBnr9OfzyejqhS9tbxlx0HnfQkl0pSG7XkxrYdDpqzDJw98FNJlM9M5U5L6lNGKd6W0u3u59XXnoAbBgUAXPGc5jPVcAzKabE7eEflUGKsDh8e9JU8T51zYW+jwYZKmbV3Z5tJjcxJ7hD0gPadrNMIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hLUNT2+y; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6b99988b6ceso64661097b3.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Aug 2024 03:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724842080; x=1725446880; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=25RFEZCC+MOPwsF2W/Qg8fFAOjsUPL7pT3dA0yn25jM=;
        b=hLUNT2+y+f3sBMsifnTxhcZAJxq9Fmy912a+8X6Rtskrkntcje6JmEgeUagon+E/IJ
         a4v1njj+4KKmdQVI3vYL7ZWHjfhly+kednVWp6z+2MoI7+T1WAUy9GQuFnqzOx1C/mLu
         tQSaDHHLem6kClO9FC+PjcuBy2Z3x+A+O8t72OW8X3n6awARQ8HrK0cZ5oFfiDsaSfyC
         gbYNEWWyqQDEfOeHAA8lKUi6A1zvmm56221BM/zREYCRY49Q+rYvjXq7mvmNG1xMz0xT
         NyukQEjAKWR45jDepopFVBBjHuQtpHJMxEiK0orVVJ95xuMLPWdF4v6q9HJrpnclH9MX
         Dkkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724842080; x=1725446880;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=25RFEZCC+MOPwsF2W/Qg8fFAOjsUPL7pT3dA0yn25jM=;
        b=rVP1b8LE2VAjPdw1Edvp2xEEQYpsPqbkikMuHJ40CJk3B7B4j+ZLXCIliw+WevqP2f
         zfXNpQVDantQNdu65T6wyF3Gp5cYTCY6NpG+dmZmADhhaFonqHyA6Q1CntJDXIx4jIXU
         WIo3r2ywOFb5530t8koOEyTPndliklkO8HF3NJvj+gwmhGCDj9YJn64Ue1OxfZWGi4d2
         DUmtzt1oxRFmSUZki2ALpvGjZ3ifBX3ofgB80JR1p4Nun7lQyidv4P4bbN8WP4rkRNRf
         S1muWc20mf7BVcUkUmxBnUE6KOAuGXTE6+L1Ane2Xf3vB4JSaA9TKBAXkAgn6lluzmCZ
         qvgw==
X-Gm-Message-State: AOJu0Yz3MUSKg5NFoxpE3Q9PXZYR2pwbpan8rpD8itKcz6W+zuJ6JuJP
	LEzzfVZIDCh9xgJnZSd1GhwNShLS9Iiw9/32bRKuKBO0V9Ey648okcK15C+P4grCZwCJmL28NwN
	SZxaBgL9WzZoI8j1kpMpX81MTUWk=
X-Google-Smtp-Source: AGHT+IG9JQ4Rgqz6YdwhSPYEsS9qeAT3H9Auk+man0xTTkf6ywB7cKxKKdBWXzwOES9bnvfn87qT+6CZH1ysMB5KkJ4=
X-Received: by 2002:a05:690c:d8c:b0:664:db79:b275 with SMTP id
 00721157ae682-6c61f0bc1ffmr212737947b3.0.1724842079876; Wed, 28 Aug 2024
 03:47:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOw_e7bB3C_zbpq6U+FdrjbwJAOKFJk1ZLLETrR+5xqRmv44SQ@mail.gmail.com>
 <CAOQ4uxi=9WpKFb24=Hha_mwj9=bsj9qxiv0f0Z-FMfuBRCvdJA@mail.gmail.com>
 <CAOw_e7YnJwTioM-98CoXWf7AOmTcY29Jgtqz4uTGQFQgY+b1kg@mail.gmail.com>
 <CAOQ4uxhApT09b45snk=ssgrfUU4UOimRH+3xTeA5FJyX6qL07w@mail.gmail.com> <CAOw_e7axjatL=dwd2HAVcgC4j8_6A393kBj7kL_VHPUKfZJaqg@mail.gmail.com>
In-Reply-To: <CAOw_e7axjatL=dwd2HAVcgC4j8_6A393kBj7kL_VHPUKfZJaqg@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 28 Aug 2024 12:47:47 +0200
Message-ID: <CAOQ4uxgFbBCRLFM4QdQYK3xESMixWqxtC1Q9Hk4p=bjWeWk1ZQ@mail.gmail.com>
Subject: Re: FUSE passthrough: fd lifetime?
To: Han-Wen Nienhuys <hanwenn@gmail.com>
Cc: linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 28, 2024 at 12:33=E2=80=AFPM Han-Wen Nienhuys <hanwenn@gmail.co=
m> wrote:
>
> On Wed, Aug 28, 2024 at 12:06=E2=80=AFPM Amir Goldstein <amir73il@gmail.c=
om> wrote:
> >
> > On Wed, Aug 28, 2024 at 12:00=E2=80=AFPM Han-Wen Nienhuys <hanwenn@gmai=
l.com> wrote:
> > >
> > > On Tue, Aug 27, 2024 at 3:48=E2=80=AFPM Amir Goldstein <amir73il@gmai=
l.com> wrote:
> > >
> > > > BTW, since you are one of the first (publicly announced) users of
> > > > FUSE passthrough, it would be helpful to get feedback about API,
> > > > which could change down the road and about your wish list.
> > >
> > > I guess it is too late to change now, but I noticed that
> > > fuse_backing_map takes the file descriptors and backing IDs as signed
> > > int32. Why int32 and not uint32 ? open(2) is documented as never
> > > returning negative integers.
> > >
> >
> > It seemed safer this way and allows to extend the API with special
> > return codes later.
> > Why? what is to gain from uint32 in this API?
>
> Consistency. Almost all fields in the FUSE API are uint64 or uint32.
> Having it be different suggests that something special is going on,
> and that negative numbers have a valid use case. If they're always
> non-negative, that could be documented.
>
> Similarly, it looks like the first backing ID is usually 1. Is it
> guaranteed that 0 is never a valid backing ID? I am not sure, and it
> would certainly help implementation on my side.

No guarantee.
There was some suggestion about special use for value 0,
but I don't remember what it was right now.

Thanks,
Amir.

