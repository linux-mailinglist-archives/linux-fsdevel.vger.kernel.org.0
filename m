Return-Path: <linux-fsdevel+bounces-14227-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A41FD879A81
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Mar 2024 18:18:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F36528608A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Mar 2024 17:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6E231384A9;
	Tue, 12 Mar 2024 17:18:21 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB02C7D409;
	Tue, 12 Mar 2024 17:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710263901; cv=none; b=GqjfWKJl2YPz/uyeQ5VlAKVeOtTpM0Rc0saKmxGv9roH5kGkLrYVknP32sty1P5YfIbiGclI2i+MNn8+O2A5UEtvm7/XD0j0ibcj7V0yhOl+c+DNL2tqwuK6BoAYP6+olMe/OtmVIp+PXTOgjrtSFHlpgFFrgmZkl9r4H7sf0xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710263901; c=relaxed/simple;
	bh=plX6EgCmcJWhUvceDb/7oSiljuyjZpOsiV3pjRLCfiM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Uj0nc5DcIcaEq6T+GXpfrdk0CV/nJLDEqUnVkkwZjtnsJ+AxKn2s/r2ysm1B+MaPPxSlaTQI/pifYITomk8xViMEnY8LsOrlyWxsR8QiDcdafP6ZDRh0NZAZQE8HLcZ5u1ycraaJ/k6DGpkTEakgjpBDzdUjqvG1bkMdueoYxbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gompa.dev; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gompa.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5682ecd1f81so163959a12.0;
        Tue, 12 Mar 2024 10:18:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710263898; x=1710868698;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4zdMrue1cvNB0PeW8F/5e6/jetcP3kc0nJi/2UVb+5g=;
        b=NyKdikQXaLkqRw9Ohj24dypf8Hcm/I3/AYDsxji73KofiNQ50VEUn0iKLycN60nbAc
         zVoVN8qjwVW9rIkxoAa6/qhkLBDcHEAUhCdR/5P72VdWI3i4GdAHCUogofQq5aMl2I7C
         eJct3wKKlwcABxFcC36DD8GE8CDY8jw2lCpbl0wi87w16oseOKb0+VfoCBbeQkyubT63
         Fl6cF9LCW+tFYokxN2BFImEbj7QMnU6DX1SnIoH+hyGn4Nkvb0z6iGBMo+gvik679YQ2
         Lm5mMolbthbd9eyPqsv9xHQmat47YbYe6+8XKxnF5YTdElWLfpFE4Cg4Rq7+3P69tAUO
         3+Yw==
X-Forwarded-Encrypted: i=1; AJvYcCWrarWKoI1mWWUyB60BN8LCGBNSN6lyURS4Z1VXugCIVyWT7nB7IdCdwcBS1PhPghxOAZdvnJ0rnV84murQUYVOFTq7mxMCeDR2bnKLHVW3S7PkqEGXWvNIy+jiCFDqFwJnM5M3yI6mIJlg3dAyZRWRyENn/HM03zJNidT3L4qvabVIBo6NkF6ybtHpJH1kPZTtuksv1i+6TPXIVVQlQ4pAuZ807tXe1F0=
X-Gm-Message-State: AOJu0Yw47mxkEA1RJxKRlYGNHpQjLVnQyXSLZ+653WVkyEqcAXz44GU6
	EfayZCmwgzMuWB4Bd3LORqW5ixxqt3pfhp31MxFtF3/+FwJrbGRqZ+fTDb+4Kws=
X-Google-Smtp-Source: AGHT+IGgHx0iwc0ZmqQ8wRKsOrJJRTQOOCfWJKcfS7tMxDoNdqJsGAsMN2QL5+AP9Bc5BbfiYEVhGg==
X-Received: by 2002:a50:d582:0:b0:565:f9c1:d925 with SMTP id v2-20020a50d582000000b00565f9c1d925mr754137edi.0.1710263897640;
        Tue, 12 Mar 2024 10:18:17 -0700 (PDT)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com. [209.85.218.52])
        by smtp.gmail.com with ESMTPSA id o8-20020a056402038800b00567566227a5sm4091472edv.18.2024.03.12.10.18.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Mar 2024 10:18:17 -0700 (PDT)
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a461c50deccso29608166b.0;
        Tue, 12 Mar 2024 10:18:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWKHV3Zcj3T8Y+3LeF7Aa6mwTAHLPWTgZKspoPSxFeRUREzIa/MJPfUdX5HnyKPfDkhvUwYGpoA22b/Vl1infVvXLME2lXdiS1IneSqI3kZOzjy119sSlVKMiIjPSoP4MYPNr/9zLyjcdTS0hmVeJYzxeEUNMs4xylJ8CGhEH6LnuOD/Lv5UlUj8hmAtIoB5ZhBHQe2Iq6ZP1rzsOrKylqv+OqZgWHaoJ8=
X-Received: by 2002:a17:907:c287:b0:a45:ed7f:2667 with SMTP id
 tk7-20020a170907c28700b00a45ed7f2667mr759548ejc.17.1710263896947; Tue, 12 Mar
 2024 10:18:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240308022914.196982-1-kent.overstreet@linux.dev>
 <2f598709-fccb-4364-bf15-f9c171b440aa@wdc.com> <20240311-zugeparkt-mulden-48b143bf51e0@brauner>
 <20240311224259.GV2604@twin.jikos.cz> <20240312-ruhephase-belegen-d4ab0b192203@brauner>
In-Reply-To: <20240312-ruhephase-belegen-d4ab0b192203@brauner>
From: Neal Gompa <neal@gompa.dev>
Date: Tue, 12 Mar 2024 10:17:40 -0700
X-Gmail-Original-Message-ID: <CAEg-Je-XoSd_5HtBi8p7O8STB9_J4RZKKDtJqaQWtG_3vdbdRw@mail.gmail.com>
Message-ID: <CAEg-Je-XoSd_5HtBi8p7O8STB9_J4RZKKDtJqaQWtG_3vdbdRw@mail.gmail.com>
Subject: Re: [PATCH v2] statx: stx_subvol
To: Christian Brauner <brauner@kernel.org>
Cc: David Sterba <dsterba@suse.cz>, Johannes Thumshirn <Johannes.Thumshirn@wdc.com>, 
	Kent Overstreet <kent.overstreet@linux.dev>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"linux-bcachefs@vger.kernel.org" <linux-bcachefs@vger.kernel.org>, 
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Josef Bacik <josef@toxicpanda.com>, 
	Miklos Szeredi <mszeredi@redhat.com>, David Howells <dhowells@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 12, 2024 at 7:27=E2=80=AFAM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> On Mon, Mar 11, 2024 at 11:43:00PM +0100, David Sterba wrote:
> > On Mon, Mar 11, 2024 at 02:43:11PM +0100, Christian Brauner wrote:
> > > On Mon, Mar 11, 2024 at 08:12:33AM +0000, Johannes Thumshirn wrote:
> > > > On 08.03.24 03:29, Kent Overstreet wrote:
> > > > > Add a new statx field for (sub)volume identifiers, as implemented=
 by
> > > > > btrfs and bcachefs.
> > > > >
> > > > > This includes bcachefs support; we'll definitely want btrfs suppo=
rt as
> > > > > well.
> > > >
> > > > For btrfs you can add the following:
> > > >
> > > >
> > > >  From 82343b7cb2a947bca43234c443b9c22339367f68 Mon Sep 17 00:00:00 =
2001
> > > > From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> > > > Date: Mon, 11 Mar 2024 09:09:36 +0100
> > > > Subject: [PATCH] btrfs: provide subvolume id for statx
> > > >
> > > > Add the inode's subvolume id to the newly proposed statx subvol fie=
ld.
> > > >
> > > > Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> > > > ---
> > >
> > > Thanks, will fold, once I hear from Josef.
> >
> > We're OK with it.
>
> Thanks!


Well, I guess I'm fine with the whole thing then if everyone else is.

Reviewed-by: Neal Gompa <neal@gompa.dev>



--
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!

