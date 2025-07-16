Return-Path: <linux-fsdevel+bounces-55128-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D37D7B07154
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 11:12:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B92A16D945
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 09:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5BD22F430F;
	Wed, 16 Jul 2025 09:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wga44eKK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A64C72F3C37;
	Wed, 16 Jul 2025 09:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752656981; cv=none; b=QxqcNrWtUtMo9zE5qItqq3QF5lQj2mvWQAURALz1ebAim7T9elpV6bRVpX1D/K/PZAOWXJyr9KoPd1PTsna8IrbuPp5n2ONATWgafQwcH+F2Zy8BR0nbV6zt9tMHkVoE8rmocdNWgkTsR0/y+VTpIozXRBrLlyxu2kjDV+cCUGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752656981; c=relaxed/simple;
	bh=GEEVZpyyyvUI0P8FsVR+okBxk/TQKqapbni6lSlYRrw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jzlO9ji/j4wCBk4U7qqlT4K4gAGWODxMYTPCCrJs00CK5mVZEIq7/CACSikDEWS7LXR76vWpritfUfTILMe+65pPC3GtrE9lpaSFm65aJqbCJy3CtjUVF+CtGZxYdWpcTgGSMb7SE+2yjMOQeXo8IubwAd5QBJSrb+vXsO+EvGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wga44eKK; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-60c51860bf5so10586987a12.1;
        Wed, 16 Jul 2025 02:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752656978; x=1753261778; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GEEVZpyyyvUI0P8FsVR+okBxk/TQKqapbni6lSlYRrw=;
        b=Wga44eKK6Ijg7I29QS+SbePeTrl2vCReql8yCaP2hXL+a4LAOHG7vYVnavQl2hThSL
         6ZMz/WRA2KmhNSymygK9ubxvqor2owbhKDF0h4sdTmArcjMmq9AsnwttjoCuY7TY62mT
         9cDu5GxYYAOfQtW2+tAEHfl03s0OkDl6CdWz5Bi6U8SdPaOQgv3IDQu3c7y29C/6jUYj
         x5YB8l1A1Y6gE7JLzWXwwvBZoXsbfe9RnRcdXwaOJrNEsiY3ex3MIwe1aNbUzbWIWPSt
         tJluc8OKRzwT8gSGItpsEKKZzG1keYEUbDNi2hvYyjsAEiiRSul3vz7ErmgMxFslrOgx
         IjMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752656978; x=1753261778;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GEEVZpyyyvUI0P8FsVR+okBxk/TQKqapbni6lSlYRrw=;
        b=mwMO4l3Fjfi4GRcU4LWNHislYdcVewBchT1ojyD7bqKej7qrjurvVMZEYtY8ex091X
         RBzFqgZPG2Gy5ijCeA5fakgD+hJh1cABbgvM2jGY9zM8zml1k9xgKyi3GvwW5+676wR4
         Bw4jOJq7ogxZPOoVK2V5IO6s2WqA58yB4+bzc9wcZ2buemdhmGB2urfE1eBmbAHbqYhS
         lnqSTetSMgGF1XVyckc3gUcXnIgb/spdRpSdHx3czZ4ukDc6eswox/Fp7SUj88tZqU6e
         N+giVPW4G9pBMrLfS6J9SLBRxEdoKQFlgB5E2ODGmQgrXmFaWsoZnBgy2E52n7Go5Jio
         kR+w==
X-Forwarded-Encrypted: i=1; AJvYcCUm87IfAKMtGKylyaournn+kioQcJazh56Z8nvixy+4psU6UPf0Bpqdlh1uDpHEksmSsn6J83ooRJw9zluI@vger.kernel.org, AJvYcCV34ZSizU3XoHbxupBYAgkyzGwEvzST5Id3CGQ7lLoE+SWaVJYFjgBJupZhyqxyEa1g6VcvEIzm1mHGNbeCzQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxnjqFDnTE9c8pBRSVygKmEJCI/I3IbBCh4Df/Rs7nCYg0/hhW1
	c0bTMUWPZTxs8QW/uv/7ulHuM6oXLnpyS3gOXsqRiQhBgQEyw1qkGhK0pt8baOOk3R2LF4iFpvG
	sET+C6OM7G5bZiuoaZWjbwEzGL7yqsSw=
X-Gm-Gg: ASbGncvwhKVFGoJbg18sjFQ0kRSvcQxECdt0X21gX0iGJJCxFYwGVABY4+fKjGrBsrM
	+dLlPKLdN+d0FujrRb/5z1frZbW7QRzRDmbBdEVBlMETS4HHDMm7OK1KmZDpaDfRYeRnsGfBGYA
	Wos3PaGEnWpITE+cjxxqdRWWUTqC699kfk9DN7x7wiuSLMfNrkiq/pKri9HMnKM8jKPL21+e6ku
	XmE7hk=
X-Google-Smtp-Source: AGHT+IG/a+IHRmG4SCgHl2avPCS43BlYaqU3FXcq3gGNJ0FOlgRfHWn75YyY9qb3qnnqT5kOyTXPdiJmyReQIGVl3A8=
X-Received: by 2002:a17:907:7252:b0:ae3:5e70:32f7 with SMTP id
 a640c23a62f3a-ae9c9b72f2cmr262706266b.47.1752656977505; Wed, 16 Jul 2025
 02:09:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOQ4uxiHNyBmJUSwFxpvkor_-h=GJEeZuD4Kkxus-1X81bgVEQ@mail.gmail.com>
 <175265310294.2234665.3973700598223000667@noble.neil.brown.name>
In-Reply-To: <175265310294.2234665.3973700598223000667@noble.neil.brown.name>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 16 Jul 2025 11:09:26 +0200
X-Gm-Features: Ac12FXzAElWjiiin4RG-BKjz0ujRw1ltr7G1hEgHVXNV0p3t_wph2ke5n0Q_scU
Message-ID: <CAOQ4uxgDqJdPxugDRh0yrKudmx_eJYekhXBY7NSzmkGauO8i=Q@mail.gmail.com>
Subject: Re: [PATCH v3 00/21] ovl: narrow regions protected by i_rw_sem
To: NeilBrown <neil@brown.name>, Christian Brauner <brauner@kernel.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-unionfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 16, 2025 at 10:05=E2=80=AFAM NeilBrown <neil@brown.name> wrote:
>
> On Wed, 16 Jul 2025, Amir Goldstein wrote:
> > On Wed, Jul 16, 2025 at 9:19=E2=80=AFAM NeilBrown <neil@brown.name> wro=
te:
> > >
> > > On Wed, 16 Jul 2025, Amir Goldstein wrote:
> > > > On Wed, Jul 16, 2025 at 2:47=E2=80=AFAM NeilBrown <neil@brown.name>=
 wrote:
> > > > >
> > > > > More excellent review feedback - more patches :-)
> > > > >
> > > > > I've chosen to use ovl_parent_lock() here as a temporary and leav=
e the
> > > > > debate over naming for the VFS version of the function until all =
the new
> > > > > names are introduced later.
> > > >
> > > > Perfect.
> > > >
> > > > Please push v3 patches to branch pdirops, or to a clean branch
> > > > based on vfs-6.17.file, so I can test them.
> > >
> > > There is a branch "ovl" which is based on vfs.all as I depend on a
> > > couple of other vfs changes.
> >
> > ok I will test this one.
> >
> > Do you mean that ovl branch depends on other vfs changes or that pdirop=
s
> > which is based on ovl branch depends on other vfs changes?
>
> ovl branch depends on
>
> Commit bc9241367aac ("VFS: change old_dir and new_dir in struct renamedat=
a to dentrys")

I see.

Anyway, testing looks good on your branch.

Christian,

From eyeballing the changes on vfs.all, I do not see any apparent dependenc=
y
of the commit above with any of the commits in other vfs branches.

Since vfs-6.17.file currently has two ovl patches and one vfs patch which i=
s a
prep patch for ovl, may I propose to collect all ovl patches and ovl
prep patches
on a single branch for 6.17:

1. Rename vfs-6.17.file to vfs-6.17.ovl (or not up to you)
2. Move commit bc9241367aac from vfs-6.17.misc to vfs-6.17.ovl
3. Apply Neil's patches from this series (all have my RVB)

Logically, these changes could be broken up to more than 1 PR,
but that's up to you. I can also do the ovl-only PR myself if we agree on
a stable vfs branch and its content.

WDYT?

Thanks,
Amir.

