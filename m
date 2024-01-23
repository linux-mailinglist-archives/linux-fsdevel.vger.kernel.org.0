Return-Path: <linux-fsdevel+bounces-8541-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF31D838DCE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 12:46:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96D8C1F23722
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 11:46:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBD675D8F9;
	Tue, 23 Jan 2024 11:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rwkl0mjP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A665D5D8E3;
	Tue, 23 Jan 2024 11:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706010411; cv=none; b=NyaQyMI6ZEJCBaN6VA/GhKQjM2SYu6NQ+IaKqTV9WvUrrUcpBBnQ3ohUmOyRH3m6tkONblwoxpwHA1MFavXVT87klOcBBPYEePXcVEDnjKWujfFM8oYjp8gK62uA228AV4IoxwBYgndy41JyTXBmzZca6h0Pq31WEZjz+vgJN40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706010411; c=relaxed/simple;
	bh=JfDnCgpZ1rLdrOgkkhaHxpw3ewpX/BXePWtymb5m778=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Cgi7a9i2UGsh3uMKQdyBH9NPoyZbBv9nlTvsBIPciGWc7AfrxY1Gfkj5e16NKEXMTXI9elm/pv6l860LHpZbVKJ+LGctDT+A8+hGfbhmTR1IJwSxSzHFyE1oxbGFHzuMDKNApcIpN0m0BqGyZzfa+OhlgPiQIiRAtl73qdQTCao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rwkl0mjP; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2cf03521306so17490421fa.2;
        Tue, 23 Jan 2024 03:46:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706010407; x=1706615207; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8TaiIgW9Sn1shcjlwEwCYruc13n/CneHnu8Td2T3w5k=;
        b=Rwkl0mjPREY2NVkL4Vx7jCml4tUWz9NzVwdwL0d3VIR6zoHqvWk/XI/QOBRl7NPdXz
         ymvQUYuqZhjagG+onhpGPB9LMnwa53vqmDIN+XF9JVZgUMj5sQ4GtZlSNRw3PGF6jMjq
         aHhiT5VU7wu0mMRuuv5D5U8cU386EJQ21WupXIU13Kf4pZ/vu0fTZztiqe7wk/IXF/FY
         b3RniLSF/Sm2J6jbR2vSBGp86IYPCUoXf+HoEtsfTNn//PUkx1CgbeG2rPdN8WQTgRKE
         qJFY176KiGbIkV7wklB7BZlBFLoglBAG9JYNgnJqDc1jo4UitA1pEXfG8xxZuEm5ewBF
         VcyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706010407; x=1706615207;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8TaiIgW9Sn1shcjlwEwCYruc13n/CneHnu8Td2T3w5k=;
        b=EG6FKalFxGsWwGlUo5MJCpILl6XTCFh7RPvRsvUSuVrorTur8xgkc2B7spUd/pOPCr
         2+vUINRDfxnYuSspXJtxS2dMmCYiIVxkwFSrpf23Gb63KWf6F9IKs/fF3fGCbiuZMehK
         Mh6z8R+J4eQynr41bfae69GqGmLCK39jTuy1zoEtbapax2nKBQW0q3jaM6CrJswYko8U
         gEDLt3RztFvsGcrCLsVQuUXCkw+kJkhsOUnY8X6v3wEAXsDwQaPgxlp8HYZ0AFyz8i7a
         pBYXJyAdOy0ykXtRzUj4QVwKrLUQzE8+0QfdEhMfg938pygXLZQ0j4tdONo5Ay1JG+/L
         DHYQ==
X-Gm-Message-State: AOJu0Yy0k8TfdT2B3087fi0XGS1MXPF7zxvWNr5L7guK4wd+W7VsFc6o
	92IwSFArVfPbkbMSSawoG90DK/jPgeOdtKjJd3ojzMNbFLt14kPVzK7xPamy3G/SzqRQwKlxDLo
	ruL9cn1mXhyfFIXJphqRKDYL+xaEBxZVrY/FODfzh
X-Google-Smtp-Source: AGHT+IGarevvMA2GwyFdnOl/o/iJjsdpd801TjZcbbnTbWED5hEeLiZQIWCyPqhwUplXEHevPgRILuZFPSBDDLMstbw=
X-Received: by 2002:a2e:9f54:0:b0:2cc:8bc7:5703 with SMTP id
 v20-20020a2e9f54000000b002cc8bc75703mr2222897ljk.18.1706010407252; Tue, 23
 Jan 2024 03:46:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Za9DUZoJbV0PYGN2@squish.home.loc> <6939adb3-c270-481f-8547-e267d642beea@leemhuis.info>
 <bbac350b-7a94-475e-88c9-35f6f8700af8@leemhuis.info> <e2f791e51feb09e671d59afbbb233c4d6128a8d2.camel@kernel.org>
In-Reply-To: <e2f791e51feb09e671d59afbbb233c4d6128a8d2.camel@kernel.org>
Reply-To: sedat.dilek@gmail.com
From: Sedat Dilek <sedat.dilek@gmail.com>
Date: Tue, 23 Jan 2024 12:46:10 +0100
Message-ID: <CA+icZUXaxysi1Oq1wKeDZ5LZVp7i585vmPQi67hw1CdW7nGC6A@mail.gmail.com>
Subject: Re: [REGRESSION] 6.6.10+ and 6.7+ kernels lock up early in init.
To: Jeff Layton <jlayton@kernel.org>
Cc: Linux regressions mailing list <regressions@lists.linux.dev>, stable@vger.kernel.org, 
	Linux-fsdevel <linux-fsdevel@vger.kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, 
	Paul Thompson <set48035@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 23, 2024 at 12:16=E2=80=AFPM Jeff Layton <jlayton@kernel.org> w=
rote:
>
> On Tue, 2024-01-23 at 07:39 +0100, Linux regression tracking (Thorsten
> Leemhuis) wrote:
> > [a quick follow up with an important correction from the reporter for
> > those I added to the list of recipients]
> >
> > On 23.01.24 06:37, Linux regression tracking (Thorsten Leemhuis) wrote:
> > > On 23.01.24 05:40, Paul Thompson wrote:
> > > >
> > > >   With my longstanding configuration, kernels upto 6.6.9 work fine.
> > > > Kernels 6.6.1[0123] and 6.7.[01] all lock up in early (open-rc) ini=
t,
> > > > before even the virtual filesystems are mounted.
> > > >
> > > >   The last thing visible on the console is the nfsclient service
> > > > being started and:
> > > >
> > > > Call to flock failed: Funtion not implemented. (twice)
> > > >
> > > >   Then the machine is unresponsive, numlock doesnt toggle the keybo=
ard led,
> > > > and the alt-sysrq chords appear to do nothing.
> > > >
> > > >   The problem is solved by changing my 6.6.9 config option:
> > > >
> > > > # CONFIG_FILE_LOCKING is not set
> > > > to
> > > > CONFIG_FILE_LOCKING=3Dy
> > > >
> > > > (This option is under File Systems > Enable POSIX file locking API)
> >
> > The reporter replied out-of-thread:
> > https://lore.kernel.org/all/Za9TRtSjubbX0bVu@squish.home.loc/
> >
> > """
> >       Now I feel stupid or like Im losing it, but I went back and grepp=
ed for
> > the CONFIG_FILE_LOCKING in my old Configs, and it was turned on in all
> > but 6.6.9. So, somehow I turned that off *after I built 6.6.9? Argh. I
> > just built 6.6.4 with it unset and that locked up too.
> >       Sorry if this is just noise, though one would have hoped the fail=
ure
> > was less severe...
> > """
> >
>
> Ok, so not necessarily a regression? It might be helpful to know the
> earliest kernel you can boot with CONFIG_FILE_LOCKING turned off.
>
> > >
> I'll give a try reproducing this later though.

Quote from Paul:
"
Now I feel stupid or like Im losing it, but I went back and grepped
for the CONFIG_FILE_LOCKING in my old Configs, and it was turned on in all
but 6.6.9. So, somehow I turned that off *after I built 6.6.9? Argh. I just
built 6.6.4 with it unset and that locked up too.
Sorry if this is just noise, though one would have hoped the failure
was less severe...
"

-Sedat-

https://lore.kernel.org/all/Za9TRtSjubbX0bVu@squish.home.loc/#t

> --
> Jeff Layton <jlayton@kernel.org>
>

