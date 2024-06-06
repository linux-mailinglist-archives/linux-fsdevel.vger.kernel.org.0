Return-Path: <linux-fsdevel+bounces-21081-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D844C8FDDA5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jun 2024 05:58:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7224C1F22608
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jun 2024 03:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF90B20326;
	Thu,  6 Jun 2024 03:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DVMUxfaX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C301F5FD
	for <linux-fsdevel@vger.kernel.org>; Thu,  6 Jun 2024 03:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717646323; cv=none; b=U0HV6kA3ajbzj9k0joDGC6ur3dC0rIAUo/QcNhLci7Tpn/Q5U9mbfRSISyxFB2k8l8atMft2UuiAU1mm/BkpTxh4w9cRoaAb7YDLhRj9Qiz6gZT5wpaMp/LiZ9kYgmwj1FcE24ELYLEYetg7RheoiEJXPhbVwDz8SQUJQnczFFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717646323; c=relaxed/simple;
	bh=vpsuPTfK/Wr8/pI6YQeoUnszK9p1F0GRcf+yqa/pH+k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fm914Ur5XBXqmvN7Ou0ytllo/UE3j5YNVgnNTTfEB27uDtpW/SdQXFjAgNd7a30VQXKT9hbym2kz0xlWNjP40XbOMPRlvIm5kmPBNDb9vfkFbGS1bjNrFzNwzcyLlkxDx/2YPHnw0Tg8Pyuio7kgsYoqbfJsBmq11XSpOLtIvuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DVMUxfaX; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-57a1fe63a96so449949a12.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 05 Jun 2024 20:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717646320; x=1718251120; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rV+ldZSxw1c9ETltd8F6B+FMdBj8HOY+j33ilU0KXqM=;
        b=DVMUxfaX4y803BUQ4tIp8resA6LzdIRceNTiurhCYpOO9zWxv2IIKfchRvNPxULd0l
         FUH7qQYfQoSXcM2lZQQa17nSIvugJ/5SRL9avuNZHTQYjx6M8NAK2CJAZUIidb90n47L
         PAGFtTw7g3ofDZAdT7NScg0qmE2gChmCrNDKePlC9nq1t8SpPLE28DDBRFjli50L8cQL
         pxOV0JCetf/urAX21DOG8/u4ukaX5fvMcBnBqHWsCy/959yieHpg1IaFG97Bp643r8Xg
         vUe+icEek0z51H6Ma2E7fpFrJl9jFKuSRMGkn6WQmhsc2r0M+EpDTnkaGhk4xEma4y6O
         XmSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717646320; x=1718251120;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rV+ldZSxw1c9ETltd8F6B+FMdBj8HOY+j33ilU0KXqM=;
        b=RpqdAOhFEAtjX+B2UwmeNstGpRPQ1mlaro2yqCdE0UYhKQ3Pa/NH7Lk6Ix6E8ghX8Z
         14YMn5bXXtdvalc8b/tNrZYPJpG9ml3n1c+QB7f1DG2NHV9RRggvOY9a6qNgTB2fYpUH
         XYZIqw+3E2wnVbN7klPJBhfuhqQPF7KP5U9Zjn94VeEiTt4LdoldDK5XG1xdmXS/6K/t
         kbFR/OtPf9yEym2DA16GrS1IdsrIv2Ec/LY0vbP08GJbA4sl1saO2Aa7PzWh5PRFSiOG
         xGy24fM32Fdjq4Pe4jvqL1nC4pP1TlVyxXfHPcHiKIK0HU2LHZppbjHcnzEnlHEQF9sD
         5cmg==
X-Forwarded-Encrypted: i=1; AJvYcCVQXKsljs9n3fRnUyYeWioKW3lg6YRAsQ2s4YmN0rBgYj7Fn3trDzhWJSsR+0ATQdxN58OuzJhNwCCNlQC0njFygIc8It60mDM8h59Ixg==
X-Gm-Message-State: AOJu0Yyf6XeW/GccuthMjpDhTO2+4MKybnmILr1uXaSrtMyanPQJWJyu
	fwXaQI1oOtXi+dz4keAHAMm1GE+Ck6dsQTh2clz+jT5Y98e/jnzhR1tro73a0scWsnJ4sa5G1Hj
	3fYz0sef+Tlt7AYj2Gehwh9wdCBE=
X-Google-Smtp-Source: AGHT+IGKE+lmvn6uQ8wVPsGEBtshLzvmZ3KiZQOSZc0akA6R3wJY88V5YJ2BrXzsUWAxKE3viLi5M3L8MLihqCwWRDk=
X-Received: by 2002:a50:9518:0:b0:578:649e:e63e with SMTP id
 4fb4d7f45d1cf-57a8b6a92b0mr2749911a12.16.1717646319907; Wed, 05 Jun 2024
 20:58:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHB1NaicRULmaq8ks4JCtc3ay3AQ9mG77jc5t_bNdn3wMwMrMg@mail.gmail.com>
 <CAJfpegsELV80nfYUP0CvbE=c45re184T4_WtUEhhfRGVmpmpcQ@mail.gmail.com>
 <CAHB1NaiddGRxh7UjaXejWsYnJY52dYDvaB2oZpqQXqVocxTm+w@mail.gmail.com>
 <20240604092757.k5kkc67j3ssnc6um@quack3> <CAHB1NahP14FAMj04D-T-bWs7JAn_mXfmXSeKUEkRbALZrLeqAA@mail.gmail.com>
 <20240605102945.q4nu67xpdwfziiqd@quack3> <20240605195346.GC4182@mit.edu>
In-Reply-To: <20240605195346.GC4182@mit.edu>
From: JunChao Sun <sunjunchao2870@gmail.com>
Date: Thu, 6 Jun 2024 11:58:28 +0800
Message-ID: <CAHB1Nahi+d-CDb8TdZ_pdZySggc0XERxze0Zz2ia0sgbf6O4Rg@mail.gmail.com>
Subject: Re: Is is reasonable to support quota in fuse?
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: Jan Kara <jack@suse.cz>, Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Theodore Ts'o <tytso@mit.edu> =E4=BA=8E2024=E5=B9=B46=E6=9C=886=E6=97=A5=E5=
=91=A8=E5=9B=9B 03:53=E5=86=99=E9=81=93=EF=BC=9A
>
> On Wed, Jun 05, 2024 at 12:29:45PM +0200, Jan Kara wrote:
> >
> > But that's why I'm asking for usecases. For some usecases it may be fin=
e
> > that in case of unclean shutdown you run quotacheck program to update q=
uota
> > information based on current usage - non-journalling filesystems use th=
is
> > method. So where do you want to use quotas on a FUSE filesystem?
>
>
> > Something else to consider is whether you want to allow the user to
> > query the current quota information (e.g., the "quota" command), and
> > whether you want the system administrator to be able to set quota
> > limits, and whether you expect that when the soft quota limits are
> > exceeded that warnings get written to the user's tty.  All of this

Thanks a lot for your kind reminders and suggestions.

In the first step, I plan to implement basic functionalities. This
includes users being able to query quotas, administrators being able
to set quotas, and returning EDQUOT when the hard limit is exceeded.
However, it does not include issuing warnings to the user's tty when
the soft limit is exceeded or providing other full Linux quota support
beyond this.

> > would mean that the kernel fuse driver would need changes, and the
> > kernel<->userspae FUSE protocol would need to be extended as well.
> > And at that pointm you really want to get the FUSE maintainer
> > involved, since the FUSE protocol is somethign which is used on other
> > OS's (e.g., Windows, MacOS, etc.)

Yes, we need to extend the protocol to inform users about quota
updates. Reading may not require informing the user; it can be done
directly in the kernel, but careful consideration is needed on how to
implement this. And further discussion and thought are needed. After
completing the basic functional thinking and implementation design, I
will discuss with the FUSE maintainer which protocol extensions are
feasible and which are not.

>
> As Jan put it, it's all in the use cases that you expect to be able to
> support.  If you just want quota to be tracked, and for certain writes
> to return EDQUOT, that's one thing.  If you want the full Linux quota
> user experience, that's quite another.
>
> Cheers,
>
>                                                 - Ted


Best regards,
--=20
Junchao Sun <sunjunchao2870@gmail.com>

