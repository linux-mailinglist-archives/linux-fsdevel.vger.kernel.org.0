Return-Path: <linux-fsdevel+bounces-20979-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FF048FBB4B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2024 20:10:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C6781C22985
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2024 18:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15B2614A0AD;
	Tue,  4 Jun 2024 18:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KczMb7JN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAFC3179BC
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Jun 2024 18:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717524589; cv=none; b=ssZgjdO4RYFpoiS10ds4EN5vu7hZCIbkbevENMZgHzDpJONH5DLK14eBXlcOyWw74FwdF11ZuhXotvWifOetWTUcnRgOuO3uhepSz0IRRPaG79GxvOBH/19fz6ZWB7riMNeW/aFe6mrkOGcxlyubImNwcvQkSBRdV2iykDnVas4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717524589; c=relaxed/simple;
	bh=Q/vqJhAwI6RsLZCudsHBw6Pj5sVNgMSrhmb9L69ADyI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HIZNGoi0n4jKrzrOyKSwGr1vCXkYV9MCPidPu0aJmdA6KYI279OJEwJCT0JvCs7A1UGBxK2MTEVBBrfIkh/VIpr93jrEV2iUW0inqZrKwWTsoLHE15h2GzgRxcjXSoxoPRSl8yPoGQC8zP7Ow7TdsGJKZ4xsgzJgvK/Sz50tk7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=KczMb7JN; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2eaa80cb573so45846301fa.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Jun 2024 11:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1717524586; x=1718129386; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jTkkByq7ZwISyvxejcvHZtm+hsmFHE1SVWn4MBX6fv0=;
        b=KczMb7JNT2nU+12hEbMhbsxnbd/lWbN1vhzvqifwOO+S0jnkohBvt7oSPp0hf3WW2P
         TbisRTmSR12I2kKF21N17tD9AaIiK02YcVmwprsJm0tNDIGodusFecgFJGGdFs1CDbM9
         V+CHcDLmygRY29L1X274FX3BjGL7hqXakv5HU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717524586; x=1718129386;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jTkkByq7ZwISyvxejcvHZtm+hsmFHE1SVWn4MBX6fv0=;
        b=k2uJj/b86EjQJinifjE6EYQxbsAylaV/pdxkLkMW9gYOXbt/PYlbyjvvVzFvZNaGSy
         Pi6RjdBeSR4PtYthypoZeA/IlJFNFZCdBuftgoKVmtZn82t+3yTVt8+PZWsrA0UASaNj
         nZQnal4LtON9eyYJk0f+3OEMiORHQhfyuaRnp2yyamDQBoIcezVOXjSZlXw/PgCG25uf
         hq9PGfzxqp/R023O5Z7kAczmzjM7ZV347WiRP2JvG9n4NDf/6hpDOxkvzZV7+WZhCfjL
         owIalozBDT0cjfk+Soa+j6hxffnLjVS4XqVpUEx/wSb0frKZ+kkeaiJMxyyIfBeQ2x6C
         5PfQ==
X-Forwarded-Encrypted: i=1; AJvYcCW/+yYcZeK9LncbCp9yiv0SGuiLBKMncX1Q54QIB0oShWYy/VnQ6no4hp+b60+2QmsEto8WtaPPDvs6CmqI9Q4RuNRFW27CEYS9f1hB0g==
X-Gm-Message-State: AOJu0YxWzA+RutSxN3WsQnh8NbI0dLdSR2BeK1YbzpBPG+9V3FQsZUIi
	XTzesnBuoB3j9Mc4cCIwRHUqh5FIZywmQNek316T/AMVyz3LjtaMcf11gnRk/pCH1gdL+yJPfnA
	Ivg==
X-Google-Smtp-Source: AGHT+IH9b10fzE6AldGNmeWBtkryeQV/l3jKHl8GrmbwrG4LAMkPZrlSaq4rQLXVScBtG60BhSG8gA==
X-Received: by 2002:a2e:9dc5:0:b0:2ea:8895:ae9c with SMTP id 38308e7fff4ca-2eac79c2d06mr370721fa.17.1717524585578;
        Tue, 04 Jun 2024 11:09:45 -0700 (PDT)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ea91bb4a3dsm16478541fa.41.2024.06.04.11.09.44
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jun 2024 11:09:45 -0700 (PDT)
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-52b82d57963so6264140e87.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Jun 2024 11:09:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUKJ63f2rLp4wOVqONeMIEbaAg+HIAsQKhtoyi5uh7i14D4HEGm+aY95KG36mIteJlXsHrk9xEvwbv43rU88vZ7CI37mLBSkJvzUlS0cA==
X-Received: by 2002:a05:6512:3ca2:b0:52b:8613:9d2d with SMTP id
 2adb3069b0e04-52bab4fa5d3mr197824e87.55.1717524584300; Tue, 04 Jun 2024
 11:09:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <SI2PR06MB53852C83901A0DDE55624063FFF32@SI2PR06MB5385.apcprd06.prod.outlook.com>
 <b55cb50b3ecf8d6132f8633ce346b6adc159b38c.camel@nvidia.com>
 <CAJfpegsppbYbbLaECO+K2xpg8v0XZaQKFRZRTj=gJc9p7swdvQ@mail.gmail.com>
 <bbf427150d16122da9dd2a8ebec0ab1c9a758b56.camel@nvidia.com>
 <CAJfpegshNFmJ-LVfRQW0YxNyWGyMMOmzLAoH65DLg4JxwBYyAA@mail.gmail.com> <20240603134427.GA1680150@fedora.redhat.com>
In-Reply-To: <20240603134427.GA1680150@fedora.redhat.com>
From: Daniel Verkamp <dverkamp@chromium.org>
Date: Tue, 4 Jun 2024 11:09:16 -0700
X-Gmail-Original-Message-ID: <CABVzXAkJGjJyP1DCrh-r+ZeA1v8VV9C8BkqxzhLGyhYw8qhcaA@mail.gmail.com>
Message-ID: <CABVzXAkJGjJyP1DCrh-r+ZeA1v8VV9C8BkqxzhLGyhYw8qhcaA@mail.gmail.com>
Subject: Re: Addressing architectural differences between FUSE driver and fs -
 Re: virtio-fs tests between host(x86) and dpu(arm64)
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Peter-Jan Gootzen <pgootzen@nvidia.com>, Idan Zach <izach@nvidia.com>, 
	Yoray Zack <yorayz@nvidia.com>, 
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>, Parav Pandit <parav@nvidia.com>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"bin.yang@jaguarmicro.com" <bin.yang@jaguarmicro.com>, Max Gurtovoy <mgurtovoy@nvidia.com>, 
	"mszeredi@redhat.com" <mszeredi@redhat.com>, Eliav Bar-Ilan <eliavb@nvidia.com>, 
	"mst@redhat.com" <mst@redhat.com>, "lege.wang@jaguarmicro.com" <lege.wang@jaguarmicro.com>, Oren Duer <oren@nvidia.com>, 
	"angus.chen@jaguarmicro.com" <angus.chen@jaguarmicro.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 3, 2024 at 6:44=E2=80=AFAM Stefan Hajnoczi <stefanha@redhat.com=
> wrote:
>
> On Mon, Jun 03, 2024 at 11:06:19AM +0200, Miklos Szeredi wrote:
> > On Mon, 3 Jun 2024 at 10:53, Peter-Jan Gootzen <pgootzen@nvidia.com> wr=
ote:
> >
> > > We also considered this idea, it would kind of be like locking FUSE i=
nto
> > > being x86. However I think this is not backwards compatible. Currentl=
y
> > > an ARM64 client and ARM64 server work just fine. But making such a
> > > change would break if the client has the new driver version and the
> > > server is not updated to know that it should interpret x86 specifical=
ly.
> >
> > This would need to be negotiated, of course.
> >
> > But it's certainly simpler to just indicate the client arch in the
> > INIT request.   Let's go with that for now.
>
> In the long term it would be cleanest to choose a single canonical
> format instead of requiring drivers and devices to implement many
> arch-specific formats. I liked the single canonical format idea you
> suggested.
>
> My only concern is whether there are more commands/fields in FUSE that
> operate in an arch-specific way (e.g. ioctl)? If there really are parts
> that need to be arch-specific, then it might be necessary to negotiate
> an architecture after all.

For the purposes of virtio, it would definitely be preferable to
define the FUSE protocol in a single, canonical,
architecture-independent form. Ideally, this definition would be
sufficient to implement a working virtio-fs client or server without
referring to any Linux headers; currently, the virtio-fs spec just
links to the Linux FUSE uapi header, which seems suboptimal for a
protocol that is meant to be OS-agnostic (and has the problem of
depending on arch-specific values, as discussed in this thread).

One possible problem that I have noticed is that the interpretation of
the max_pages field in fuse_init_out depends on the value of
PAGE_SIZE, which could differ between host and guest even within the
same architecture (e.g. ARM64 with 4K vs. 64K pages); architecture
negotiation would not help with this particular problem. It would be
nice if it could be specified in a canonical way as well, perhaps
changing the definition so that it is always in units of 4096 bytes.

Thanks,
-- Daniel

