Return-Path: <linux-fsdevel+bounces-27389-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93A799612B9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 17:34:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EAF92833A5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 15:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 403321C942C;
	Tue, 27 Aug 2024 15:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VaG2ACua"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 432CB1BFE01
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 Aug 2024 15:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724772747; cv=none; b=rE650imUHlzFqZNNFsO4opexz6mxQXpmqyI0prOH+q8/yioZZg772UBcIucDZ3wbu8hYt86zck0CMmfuOZSL+/ZPSb1dZsRmn+7YUsiM/ELMUF+J2FT6xE8Mgm/RYLDQ7upIbeJDsW+Uy5Q6+6TTgf01ZHGNnxBD72PKqjON5x4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724772747; c=relaxed/simple;
	bh=+G0P7m9P9Ql41ErlAbmI4kZCWChJR4V9ggEQP6aXa7U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a3/C+o4H7yrLAscqmIYRfNG5zyJF3WV75Un1y4rq516DsdBTeiSQzWJ2SJMecR13ol6aPFq1xwdFBxebDahMUcqoJJc8Fm6tqDGKMWfc/tk1Huomkk0U7UQ2gVEKERKdnqrzrB3Ygt1NNwzNJguNkVbqM2BVQxMrAJAXOWRbrdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VaG2ACua; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2d3b5f2f621so4112202a91.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Aug 2024 08:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724772745; x=1725377545; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zk4AzFBJa8dC60mmH+xnlDfktedvtplvnRYofBaChpE=;
        b=VaG2ACua0BlqgxxKfk9bfxONpkupJiH4YOq5jHUnJCndmsr0xcH0vgQ+w2FhN1nt3E
         gvo8YF0AK778fM0W6dKH7rR8GHcOWU2/K/PvUSAx1Zdr8Nu9qtWjsHrBnEZamggPZW1t
         jzxI5SjXCPK5nA7qjTroMmRnaocWGtg/hCEWNFHli86B/PDtd/3k7pNjZrhC3Bumc3KO
         3AK5izN23P6kKHZgkBybAx/0wHSp9m8UgHS70vs1DHhJpfMYqvUeYmP54zAHQGEKSCT6
         kK5D4JFR4B+mGx/8XBXwvy5dgshzTiRi23x11nwkgK0jm+qtnJ0Gp3IU5peaOhxIydaI
         PphA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724772745; x=1725377545;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zk4AzFBJa8dC60mmH+xnlDfktedvtplvnRYofBaChpE=;
        b=nNgy7sAS98VGtw3OL+vXhgPkWeEFO4EFzrY2IvxVNzFqVC47qEmI5yTcvs8R9jFifh
         sFhIw5NfUcKuHyQNKRWZjaN2JKcjndMh7II8hZxkhI2COrViXB6t7LvbOLTD0gJYaKCD
         Rcs7RZJbubcmSSP0SLJPpZDU+TfraBPQbQzAf8SrvtvApXjYXkc6wzIfjHc9MpPecnM/
         ao+jQ7V8VHVMwvzbOyWwBqsnWdrYZORMM0WWKN/sL7PInm70hpeUbGog6zohydSjAGgG
         +f9fIrfoELn58mPDFERNpJyacBaYmioL83vHfhjqFtD8UPFFMNXFNU+xWDiuDmSfMkJ6
         7s3Q==
X-Gm-Message-State: AOJu0Yw3+G9L+yS+IaVQdp1jypG8IwGqBJHxGRJztx2zUbsZQ0i3W7/8
	DI0ZitB7qOLlEhu/zLNcobLGS2Mvu+WWn7VmYqFK5qn9/r/HcP/PGCOxFqakJZj/l08NRrFxDQE
	8/tZWpegHLJss80rmb7QmRarHS/w=
X-Google-Smtp-Source: AGHT+IEfYcWnz6cLtHY9lrqU1rt6Yoi5xAHXySnosUFvA0co//YOHKX7W76ryLEHZH3r7myaFCiYnIPE1/aEERQD4uc=
X-Received: by 2002:a17:90b:3884:b0:2d8:27c3:87d7 with SMTP id
 98e67ed59e1d1-2d827c38942mr3099445a91.8.1724772745079; Tue, 27 Aug 2024
 08:32:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOw_e7bB3C_zbpq6U+FdrjbwJAOKFJk1ZLLETrR+5xqRmv44SQ@mail.gmail.com>
 <CAOQ4uxi=9WpKFb24=Hha_mwj9=bsj9qxiv0f0Z-FMfuBRCvdJA@mail.gmail.com>
In-Reply-To: <CAOQ4uxi=9WpKFb24=Hha_mwj9=bsj9qxiv0f0Z-FMfuBRCvdJA@mail.gmail.com>
From: Han-Wen Nienhuys <hanwenn@gmail.com>
Date: Tue, 27 Aug 2024 17:32:13 +0200
Message-ID: <CAOw_e7bMbwXzv00YeGw2NjGDfUpasaQix40iXC2EcLHk=n2wTA@mail.gmail.com>
Subject: Re: FUSE passthrough: fd lifetime?
To: Amir Goldstein <amir73il@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 27, 2024 at 3:48=E2=80=AFPM Amir Goldstein <amir73il@gmail.com>=
 wrote:
>
> On Tue, Aug 27, 2024 at 11:42=E2=80=AFAM Han-Wen Nienhuys <hanwenn@gmail.=
com> wrote:
> >
> > Hi folks,
>
> Hi Han-Wen,
>
> For future reference, please CC FUSE and libfuse maintainers
> and FUSE passthrough developer (me) if you want to make sure
> that you got our attention.

Sure. Who is the libfuse maintainer these days?

> > I tried simply closing the backing FD right after obtaining the
> > backing ID, and it seems to work. Is this permitted?
>
> Yes.

awesome!

> BTW, since you are one of the first (publicly announced) users of
> FUSE passthrough, it would be helpful to get feedback about API,
> which could change down the road and about your wish list.

For full transparency, I just work on the go-fuse library for fun, I
don't have direct applications for passthrough at the moment. That
said, I have been trying to make it go faster, and obviously bypassing
user-space for reads/writes helps in a big way.

> Specifically, I have WIP patches for
> - readdir() passthrough
> - stat()/getxattr()/listxattr() passthrough
>
> and users feedback could help me decide how to prioritize between
> those (and other) FUSE passthrough efforts.

It's been useful in the past to defer all file operations to an
underlying file, and only change where in the tree a file is surfaced.
In that sense, it would be nice to just say "pass all operations on
this (open) file to this other file". Go-FUSE has a LoopbackFile and
LoopbackNode that lets you do that very easily, but it would be extra
attractive if that would also avoid kernel roundtrips.

For flexibility, it might be useful to pass a bitmask or a list of
FUSE opcodes back to the kernel, so you can select which operations
should be passed through.

The most annoying part of the current functionality is the
CAP_SYS_ADMIN restriction; I am not sure everyone is prepared to run
their file systems as root. Could the ioctl check that the file was
opened as O_RDWR, and stop checking for root?

If you are proposing to do xattr functions, that means that you also
will do passthrough for files that are not opened?

Right now, the backing ID is in the OpenOut structure; how would you
pass back the backing ID so it could be used for stat() ? IMO the most
natural solution would be to extend the lookup response so you can
directly insert a backing ID there.

I made a mistake in how I treat opendir/readdir in the high-level
go-fuse API. Until that is fixed, I cannot use passthrough for
readdir. That said, part of making FUSE filesystems go fast is to
amortize the cost of lookup using readdirplus. That wouldn't work with
readdir passthrough, so it may not be that useful.

So in summary, my wishlist for passthrough (decreasing importance):

1.  get rid of cap_sys_admin requirement
2. allow passthrough for all file operations (fallocate, fsync, flush,
setattr, etc.)

cheers,
--=20
Han-Wen Nienhuys - hanwenn@gmail.com - http://www.xs4all.nl/~hanwen

