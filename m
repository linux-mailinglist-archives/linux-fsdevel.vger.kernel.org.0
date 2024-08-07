Return-Path: <linux-fsdevel+bounces-25237-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 204F994A246
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 10:00:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5046D1C23830
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 08:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D40B1C9DD1;
	Wed,  7 Aug 2024 07:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QMvjp/OO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1360D18FC9B;
	Wed,  7 Aug 2024 07:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723017588; cv=none; b=JRF+4BbaQCDJS7ulKXV1WuKw3Ukufy8VbEpq1/Vu+SSySB2ZydtJYkggBGHI/MPNzd4ytjOBu37cNk8w+7lk74YKIY2QohbEvRk5Fo0hQ7CbWwk88f9KVPLHRYNerPmkusQbPejs0XAGT0jit1pJpPG0PkZ4K64Ff/Yw4Bq5K/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723017588; c=relaxed/simple;
	bh=a3R1nAFpgbZ+ugVoveuOybAEJqCG/E+Hv2lrEJiQJpU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CLlR36B5gMPivuBpOAQ68hX+YJ/rB0qqc8WDJDmwKkLyflVi1JYNEj+rBeuBhW/+u9BVOIx3tMu4TlyFcwzzWVDbdd4Q5ImbQ9XqraB4bAqCfrNrZp2w+c63aZSIlk5z5SQPYzs01xEf1cf8wViwUjgQj7x3AG6Hm9yJIdVAres=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QMvjp/OO; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a7ad02501c3so160679166b.2;
        Wed, 07 Aug 2024 00:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723017585; x=1723622385; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OD041rVr0/bqnmQDK60pFVQ7SGAq6cO0PN7cSI2Hkxg=;
        b=QMvjp/OOdMWj6DbT4Y4HSMnboMnDNTewdmZP+RC+n4g8MssVVoRET2bJRnSqWXMShs
         hZKpTS3g8lB4TeafwsgZ6HCQ8tFWOTFELWto409ewKYAMBhPnSjTGDr/7kKXSuuFqUvV
         hBCezjVs1QY3RmjkZ4vRBJIENTA+s9al5l4QxzGQ6QAKTJmLCkt8U235PO4xUYu0t273
         pC8FceL+a9tWIINTCPVf1n2dvTVWtOGDDfAYFE94Mt0WUDMGMz8Tu3TdoNRCi2yGbls1
         265GfPB7E/p1Mccradf1alEVxgWVR9z4lxgYVrau5wWIQSkMJ8Kb+hZ47twg7KzbpXDK
         S4wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723017585; x=1723622385;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OD041rVr0/bqnmQDK60pFVQ7SGAq6cO0PN7cSI2Hkxg=;
        b=QIpWbrEtYW2SVeZfpmZ3/QP4rPBkzRJybXPBL6czmubfOUMEbwvKZ6TWiG2hXU3wBo
         D0f+9aQgYV6296N3qcHJ8jWjJnNSAM2Ip1deJGTMx/bs029vAu98zm+57mS9Tm5yJfol
         styxMyjoRTdEpkhpbg/OAvQ6Lh/RjwbybGSMwvVIotBzE95/MDxRFBeM84ls+LIG274j
         kVNpObInOfs9Dh0NFSHYH5GMaWqRj407MZwz0kR/fC+I8jqfr3MJTecmo/yQlbYyo3Ok
         NF3xFb1UX5P0NKqO2gaCw9hSp+ZHmgXBuJEK0QAQRp0P3M8OBZGkfpraE9foeDmtKWti
         rKGA==
X-Forwarded-Encrypted: i=1; AJvYcCVwsq3TY/O+en5uq+FRVjysfLrzP4NlCXlRtVTP73WLCSeW67rWFDqT+ZQFUiwmFx3uInB5GYl7toNWE7vAk6Crce4jRQEDTBw5rqr1Rvp16DfuLi8mZY989rplXTBT/8HdY5CwepIbDuRhBQ==
X-Gm-Message-State: AOJu0Yxo1zcsetklUM64zeaIDOMM6Mp5/rT+BFBbTjNMRMdkV4fvWYDC
	PXxJilrGG7rmE31BWDZA7epKHT0jQ7FyvRV0GGTtitx9RLHD67kiqwBAXqMeUGlQhbPJqRsyndn
	VQsGSzpkOpTwIZJ/MtLi6qa6KR78=
X-Google-Smtp-Source: AGHT+IEn+9dywqjHwNP69lt4kLvHznMFKp/OWWFMn7LVHwBjIu5q5S/bAQmJAPSUX1x0O9C7MZazIpeLNUDIR8gfPyA=
X-Received: by 2002:a17:907:d16:b0:a7a:bae8:f297 with SMTP id
 a640c23a62f3a-a7dc5016569mr1194659966b.15.1723017585048; Wed, 07 Aug 2024
 00:59:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240806144628.874350-1-mjguzik@gmail.com> <20240806155319.GP5334@ZenIV>
 <CAGudoHFgtM8Px4mRNM_fsmi3=vAyCMPC3FBCzk5uE7ma7fdbdQ@mail.gmail.com>
 <20240807033820.GS5334@ZenIV> <CAGudoHFJe0X-OD42cWrgTObq=G_AZnqCHWPPGawy0ur1b84HGw@mail.gmail.com>
 <20240807062300.GU5334@ZenIV> <20240807063350.GV5334@ZenIV>
 <CAGudoHH29otD9u8Eaxhmc19xuTK2yBdQH4jW11BoS4BzGqkvOw@mail.gmail.com>
 <20240807070552.GW5334@ZenIV> <CAGudoHGMF=nt=Dr+0UDVOsd4nfGRr4xC8=oeQqs=Av9s0tXXXA@mail.gmail.com>
 <20240807075218.GX5334@ZenIV>
In-Reply-To: <20240807075218.GX5334@ZenIV>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Wed, 7 Aug 2024 09:59:33 +0200
Message-ID: <CAGudoHE1dPb4m=FsTPeMBiqittNOmFrD-fJv9CmX8Nx8_=njcQ@mail.gmail.com>
Subject: Re: [PATCH] vfs: avoid spurious dentry ref/unref cycle on open
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: brauner@kernel.org, jack@suse.cz, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 7, 2024 at 9:52=E2=80=AFAM Al Viro <viro@zeniv.linux.org.uk> wr=
ote:
>
> On Wed, Aug 07, 2024 at 09:22:59AM +0200, Mateusz Guzik wrote:
>
> > Well it's your call, you wrote the thing and I need the problem out of
> > the way, so I'm not going to argue about the patchset.
> >
> > I verified it boots and provides the expected perf win [I have to
> > repeat it is highly variable between re-runs because of ever-changing
> > offsets between different inode allocations resulting in different
> > false-sharing problems; i'm going to separately mail about that]
> >
> > I think it will be fine to copy the result from my commit message and
> > denote it's from a different variant achieving the same goal.
> >
> > That said feel free to use my commit message in whatever capacity,
> > there is no need to mention me.
>
> Original analysis had been yours, same for "let's change the calling
> conventions for do_dentry_open() wrt path refcounting", same for
> the version I'd transformed into that...  FWIW, my approach to
> that had been along the lines of "how do we get it consistently,
> whether we go through vfs_open() or finish_open()", which pretty
> much required keeping hold on the path until just before
> terminate_walk().  This "transfer from nd->path to whatever borrowed
> it" was copied from path_openat() (BTW, might be worth an inlined helper
> next to terminate_walk(), just to document that it's not an accidental
> property of terminate_walk()) and that was pretty much it.
>
> Co-developed-by: seems to be the usual notation these days for
> such situations - that really had been incremental changes.
>
> Anyway, I really need to get some sleep before writing something
> usable as commit messages...

Nobody is getting a Turing award for noticing the extra ref trip and elidin=
g it.

Co-developed-by is fine with me if you insist on sharing credit.

My only objective here is to expedite the fix so that I can get on
with speeding up refcount management. :)
--=20
Mateusz Guzik <mjguzik gmail.com>

