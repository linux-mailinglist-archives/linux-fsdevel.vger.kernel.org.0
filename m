Return-Path: <linux-fsdevel+bounces-55497-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ECD6AB0AE70
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Jul 2025 09:34:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65B221AA4A16
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Jul 2025 07:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B28232253BA;
	Sat, 19 Jul 2025 07:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AQGHgaMz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C1F721D3CC
	for <linux-fsdevel@vger.kernel.org>; Sat, 19 Jul 2025 07:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752910471; cv=none; b=PwS68cXrHDxs7zAYHs6CH6f+2qfpfGhISB/nAUEFd+4GRfy7wzlxIM21x+S0+JBEubuzqSsSzGw7CbOOvU98q76weMnXZhGc2ix1Jd5lffIugmcZlTQyExfOzZH2q2fxZyghUWOEWrMSlXMCmHXT8OUfdQqeB1ywRCjaKYOo22k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752910471; c=relaxed/simple;
	bh=66L5ZPZhBwGCNY468myAWRS+rfToJ+z0QZwNYXnDsOk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ipQmiw5gfRCBHPvuPitKa/KtiHhyTedLwS9ggIir9Hh5jgfySxVrd7EVF+BOMdS9VLyUloBMXHNFK229jxXx1nNTE78UIqUpKeIzJkPATdzJ4EkEytSJS7G1y+63NY+u+xHfD1UlgxYmaBilPp7Ze9TcF4/OV2sc4rJlgzW8rWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AQGHgaMz; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-60c60f7eeaaso4804568a12.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 19 Jul 2025 00:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752910468; x=1753515268; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aPfeTnzuV3Q+5MtlN7y/D8Uc9elqDVBX1luJ6856lzY=;
        b=AQGHgaMzGWQZmokKVM8BTQW11XBmOYIEzKDKlImrNDI0ybA7gQ1Ndtly+Gi9rUQH1X
         SR5Fys+lIxQj26N0Tlf5lHudGL22TtIHpokE+7it8Vs4u6oCyALd7Mseaix4pl9UZGUw
         lLeilKozCR5/ANqcaSFGaLKYNnvOeX1idOD2TrxXdFZ1GU7qT4Znz4ToJyY/LwZxvQZD
         mP1DIx+WoZ83/dEbrUnYzZnVxaUovie5k38LiPi8ARI5rTfLaaebkvX0B3G0ArAH+BOS
         UjO6AnBcY/4OlPROMjQ/Cqet25TFzwyLXvp+dX3BEyGavsJsxKHhp9NeNzoUDeRjok3F
         JrCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752910468; x=1753515268;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aPfeTnzuV3Q+5MtlN7y/D8Uc9elqDVBX1luJ6856lzY=;
        b=QmIYFQfaDME0OsGvCn1+ZvEx434DkfyQlnebA6p+5qeJIBG+FPOQ32jnJTIdD7A9y3
         n4AZvspPwTbqc18ObtDnDtQmuwqoiI8F9LFs255CqHUs+CMqIB0Q9f3o5ZLYRLTKCHe4
         rc7ncWj1gCTk/Jg0zRAIm7fJlPaHPu+OuI3BManfKWajybhIfkgSN+ZjNCKZJhdfWyLt
         6fdKRHT/CQsKpL9s5wMk2axOVPku8oDUr0meWB8cgtrWmGjK1AVoXCF1Wl6t77BS9O4X
         9HDCl5u46qASit1PlA1jugRNfTR/7sr5RjR43BoWq2W/lyGjmFvnU4nTXMHS5dwgbPyS
         K3Kw==
X-Forwarded-Encrypted: i=1; AJvYcCUnCiwcOvt1KYLX+0HkvJMdWTBNqMgnA+ltEcLAKEf8MyxrygP2eQgJrvmcUca1VIbLoOHomMs2LuRw4Z8U@vger.kernel.org
X-Gm-Message-State: AOJu0YzngJrzS9UX9jdJMRl+DN1QfiFe/sVcp7ZvfPGoOsbqOfNuOtBe
	EEvyK+eqoWf3Fv2FJ3Ti0sgryOPCsIElWI9hDIG7IAmNJXVuyJCIGuh05sNXH+Xb4G9e3L6t1VL
	+dU6pANa+wHS4Uob3hVIVyoXLaJ+zIxg=
X-Gm-Gg: ASbGncvxTdYOpRbi86KxdOI6JiywA/XyH+AUGXgWvGxTQSHqoJXmZQMKIZPDhFbFWyu
	bCzT7jmej/vQpB/O85c9LONIhbm/kyHNZBdJ2krpRVMnAri1aoXkUwULNpP3mlnYeIUrjXS/y1n
	bre9XilQ6oX3zm6mlB/z2FBZeYNpkSa3BY575qjtGiTAYhbQ8Gxr4SPLI/NQ3twlTe3qepIILhD
	hRuDyY=
X-Google-Smtp-Source: AGHT+IF2sNOFB360GCZK9hqHVVeOO7fw4coGvPYlRyu4LADmYO8xxa9etGGwyKe9RIFFF0djk7Ub34fp7JaS+kLAK/A=
X-Received: by 2002:a17:907:962a:b0:ae3:5e27:8e66 with SMTP id
 a640c23a62f3a-ae9c99c07e6mr1397342866b.27.1752910467210; Sat, 19 Jul 2025
 00:34:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <175279459673.714161.10658209239262310420.stgit@frogsfrogsfrogs>
 <175279459857.714161.8213814053864249949.stgit@frogsfrogsfrogs>
 <CAOQ4uxjM6A1DpB+r+J6NU3Zj7zhGmh4138RFS8c3T6hL067fcQ@mail.gmail.com> <20250718154808.GR2672029@frogsfrogsfrogs>
In-Reply-To: <20250718154808.GR2672029@frogsfrogsfrogs>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sat, 19 Jul 2025 09:34:15 +0200
X-Gm-Features: Ac12FXxYBL7drkXz1LWTCL2c5MVQUgfKBWrIOpih6VS9ew4b_BbOP2XIwn2JtG0
Message-ID: <CAOQ4uxirHdPw8z0qm4zd5=0pCXeSDYpj8_iqZ1Y4=T9QgcBVew@mail.gmail.com>
Subject: Re: [PATCH 07/14] libfuse: add a reply function to send FUSE_ATTR_*
 to the kernel
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: bschubert@ddn.com, John@groves.net, joannelkoong@gmail.com, 
	linux-fsdevel@vger.kernel.org, bernd@bsbernd.com, neal@gompa.dev, 
	miklos@szeredi.hu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 18, 2025 at 5:48=E2=80=AFPM Darrick J. Wong <djwong@kernel.org>=
 wrote:
>
> On Fri, Jul 18, 2025 at 04:10:18PM +0200, Amir Goldstein wrote:
> > On Fri, Jul 18, 2025 at 1:36=E2=80=AFAM Darrick J. Wong <djwong@kernel.=
org> wrote:
> > >
> > > From: Darrick J. Wong <djwong@kernel.org>
> > >
> > > Create new fuse_reply_{attr,create,entry}_iflags functions so that we
> > > can send FUSE_ATTR_* flags to the kernel when instantiating an inode.
> > > Servers are expected to send FUSE_IFLAG_* values, which will be
> > > translated into what the kernel can understand.
> > >
> > > Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> > > ---
> > >  include/fuse_common.h   |    3 ++
> > >  include/fuse_lowlevel.h |   87 +++++++++++++++++++++++++++++++++++++=
++++++++--
> > >  lib/fuse_lowlevel.c     |   69 ++++++++++++++++++++++++++++++-------
> > >  lib/fuse_versionscript  |    4 ++
> > >  4 files changed, 146 insertions(+), 17 deletions(-)
>
> <snip for brevity>
>
> > > diff --git a/lib/fuse_lowlevel.c b/lib/fuse_lowlevel.c
> > > index d26043fa54c036..568db13502a7d7 100644
> > > --- a/lib/fuse_lowlevel.c
> > > +++ b/lib/fuse_lowlevel.c
> > > @@ -545,7 +573,22 @@ int fuse_reply_attr(fuse_req_t req, const struct=
 stat *attr,
> > >         memset(&arg, 0, sizeof(arg));
> > >         arg.attr_valid =3D calc_timeout_sec(attr_timeout);
> > >         arg.attr_valid_nsec =3D calc_timeout_nsec(attr_timeout);
> > > -       convert_stat(attr, &arg.attr);
> > > +       convert_stat(attr, &arg.attr, 0);
> > > +
> > > +       return send_reply_ok(req, &arg, size);
> > > +}
> > > +
> > > +int fuse_reply_attr_iflags(fuse_req_t req, const struct stat *attr,
> > > +                          unsigned int iflags, double attr_timeout)
> > > +{
> > > +       struct fuse_attr_out arg;
> > > +       size_t size =3D req->se->conn.proto_minor < 9 ?
> > > +               FUSE_COMPAT_ATTR_OUT_SIZE : sizeof(arg);
> > > +
> > > +       memset(&arg, 0, sizeof(arg));
> > > +       arg.attr_valid =3D calc_timeout_sec(attr_timeout);
> > > +       arg.attr_valid_nsec =3D calc_timeout_nsec(attr_timeout);
> > > +       convert_stat(attr, &arg.attr, iflags);
> > >
> > >         return send_reply_ok(req, &arg, size);
> > >  }
> >
> > I wonder why fuse_reply_attr() is not implemented as a wrapper to
> > fuse_reply_attr_iflags()?
>
> oops.  I meant to convert this one, and apparently forgot. :(
>
> > FWIW, the flags field was added in minor version 23 for
> > FUSE_ATTR_SUBMOUNT, but I guess that doesn't matter here.
>
> <nod> Hopefully nobody will call fuse_reply_attr_iflags when
> proto_minor < 23.  Do I need to check for that explicitly in libfuse and
> zero out iflags?  Or is it safe enough to assume that the os kernel
> ignores flags bits that it doesn't understand and/or are not enabled on
> the fuse_mount?
>

AFAICS the server ignores other flags, so I think it's fine.
It only ever checks the bits it knows about in fuse_iget() and in
fuse_dentry_revalidate() to make sure they did not change.

Thanks,
Amir.

