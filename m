Return-Path: <linux-fsdevel+bounces-16451-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4427389DE75
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Apr 2024 17:15:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 748381C2110E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Apr 2024 15:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D76113AA3C;
	Tue,  9 Apr 2024 15:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S/FKe7It"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DAA8139CE0
	for <linux-fsdevel@vger.kernel.org>; Tue,  9 Apr 2024 15:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712675423; cv=none; b=I45PWjM2pTUGQGKDyBrnKSNqlmTPswc6EkcBIfmGCdsH8Sp+/v0MQ1H2YGJ6CWe4TEh2/ldlPMJtIO8xploCif38C+lZJ9cNS8G/gQTwQcPxL8x9vUqFAkW0RYKJIBMBjfYGLSabzFYDECMmcquqFhlNGdrhEYK0PUsDPythR0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712675423; c=relaxed/simple;
	bh=X9n636BoRD2rDr+juzDsX7xi3W2uGxWIcYOhDtrre/s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VpzVq5aSlN4ukBZ08bfbPG7p1v+KHdKZzzxh7WkIAIIJYm3gXgWqndrPG9skhctMuRsoeMBEE+gNo4TqtOK7IRLHJGZSzISqrd65p+2Xy0llKZBrWvWkHWEI4CfBAFM819OyfgPsUBxfCVvhv4eBL4Zs9GDpXCcNLDa0FY7FjBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S/FKe7It; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-69b20ac7d04so8004136d6.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 09 Apr 2024 08:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712675421; x=1713280221; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e6Mg4GqymOZNTt5RSyzScfxx7MaZf7Il9BQOl4uVI1A=;
        b=S/FKe7ItNWeccqj2OgnfKiHHlkeElWOuF22+Uo0ifMQsdpHp5cvoP7RQLKBxfLfFu0
         hNYK5/C36DaqbttEXnRRf3nApVW0xjSgD0dnTciBeMpBQhmQySNnqNdxECJ7p8ISU1ud
         YHpVuKGx14Hc1pT3PPUyTxxpCC108RbAZsbN5a7GcqJPt2qAht51W7xkXp4hlP3smice
         RO+SumbpOCL20GwMjGZCxFD+nmrUbbe37OIvcaC9ix1M4MNZSxxs+wSMWuNflX5F4NBu
         WWRCT+7RP6VNbETeGcfnRJDYNrtCPcsovwhYoYWImXHMF0Q/hD55ARoG/W6RACyLy3rh
         q5ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712675421; x=1713280221;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e6Mg4GqymOZNTt5RSyzScfxx7MaZf7Il9BQOl4uVI1A=;
        b=XAOYQUB0XqEp1PGv80U/OME8md4purnp7V7sJ1Hxry3Ld1gHnpqmS+DlUftnS7slBc
         NiMK7lN6BjLt7S7GYh2UsiD3BZqGZIOP5IUBFkeNRPUhxI+rwsye5G7m+9Nz2t0n6T2I
         Xpwy2zNJn7E3dZrgLT7EutSk17dU0NfM2Y+ps6FboWYJHImcKRwxHYtf8beqm6qrzh2S
         lctXqUvcptNF0FX6F1iBmGLYbKV5+3LnAIDLNLVC14ns7xgWzt32KNJJ12GL/XKOnYvn
         LL/uaUjrF4QKuGN6mJmxuTrS2OKPFSmq6PYC7ZZhyrDfjtPaN4R+d//qfCj2GlpwpUU8
         KGkw==
X-Forwarded-Encrypted: i=1; AJvYcCX8vIfz1WcKtPJKjl1vtm9G2T0Z1PFTXi9c2TLkqticbgwNvZ9f8/1ebjumLkxRBhcY5lbMMR5ltkfiE56R/JP1uRoJzOesmWyHSqNqPA==
X-Gm-Message-State: AOJu0YxikyBU974DuWh+k0EYTjJPxe5mpBJkZNyBvzRkPPWOp7SsE8ES
	yRmJLWya98R65WEUpCZG9By65JzaAaee7UdwUi9dvQJtfmKwtgR/FcAY43Aucwp6NIRIbtqA5O4
	9LMdM4JKM5rLt9TZKzzs8sDcZJIE=
X-Google-Smtp-Source: AGHT+IGliwrwLuAyX4owoZ7On6ziXtdwhIjOFeRO7gnLhGct6FfVwQ2qScZ4poa11nAnzwXf4Yr32LBN2Cn1QulxWgA=
X-Received: by 2002:a05:6214:2a4a:b0:69b:2515:4197 with SMTP id
 jf10-20020a0562142a4a00b0069b25154197mr3896085qvb.13.1712675420868; Tue, 09
 Apr 2024 08:10:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240407155758.575216-1-amir73il@gmail.com> <20240407155758.575216-2-amir73il@gmail.com>
 <CAJfpegs+Uc=hrE508Wkif6BbYOMTp3wjQwrbo==FkL2r6sr0Uw@mail.gmail.com>
In-Reply-To: <CAJfpegs+Uc=hrE508Wkif6BbYOMTp3wjQwrbo==FkL2r6sr0Uw@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 9 Apr 2024 18:10:09 +0300
Message-ID: <CAOQ4uxgFBqfpU=w6qBvHCWXYzrfG6VXtxi_wMaJTtjnDAmZs3Q@mail.gmail.com>
Subject: Re: [PATCH 1/3] fuse: fix wrong ff->iomode state changes from
 parallel dio write
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Bernd Schubert <bernd.schubert@fastmail.fm>, 
	Sweet Tea Dorminy <sweettea-kernel@dorminy.me>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 9, 2024 at 4:33=E2=80=AFPM Miklos Szeredi <miklos@szeredi.hu> w=
rote:
>
> On Sun, 7 Apr 2024 at 17:58, Amir Goldstein <amir73il@gmail.com> wrote:
> >
> > There is a confusion with fuse_file_uncached_io_{start,end} interface.
> > These helpers do two things when called from passthrough open()/release=
():
> > 1. Take/drop negative refcount of fi->iocachectr (inode uncached io mod=
e)
> > 2. State change ff->iomode IOM_NONE <-> IOM_UNCACHED (file uncached ope=
n)
> >
> > The calls from parallel dio write path need to take a reference on
> > fi->iocachectr, but they should not be changing ff->iomode state,
> > because in this case, the fi->iocachectr reference does not stick aroun=
d
> > until file release().
>
> Okay.
>
> >
> > Factor out helpers fuse_inode_uncached_io_{start,end}, to be used from
> > parallel dio write path and rename fuse_file_*cached_io_{start,end}
> > helpers to fuse_file_*cached_io_{open,release} to clarify the differenc=
e.
> >
> > Add a check of ff->iomode in mmap(), so that fuse_file_cached_io_open()
> > is called only on first mmap of direct_io file.
>
> Is this supposed to be an optimization?

No.
The reason I did this is because I wanted to differentiate
the refcount semantics (start/end)
from the state semantics (open/release)
and to make it clearer that there is only one state change
and refcount increment on the first mmap().

> AFAICS it's wrong, because it
> moves the check outside of any relevant locks.
>

Aren't concurrent mmap serialized on some lock?

Anyway, I think that the only "bug" that this can trigger is the
WARN_ON(ff->iomode !=3D IOM_NONE)
so if we ....

>
> > @@ -56,8 +57,7 @@ int fuse_file_cached_io_start(struct inode *inode, st=
ruct fuse_file *ff)
> >                 return -ETXTBSY;
> >         }
> >
> > -       WARN_ON(ff->iomode =3D=3D IOM_UNCACHED);
> > -       if (ff->iomode =3D=3D IOM_NONE) {
> > +       if (!WARN_ON(ff->iomode !=3D IOM_NONE)) {
>
> This double negation is ugly.  Just let the compiler optimize away the
> second comparison.

...drop this change, we should be good.

If you agree, do you need me to re-post?

Thanks,
Amir.

