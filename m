Return-Path: <linux-fsdevel+bounces-32672-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EEEB09ACFB7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Oct 2024 18:05:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C37BB25EE5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Oct 2024 16:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB84E1CB53D;
	Wed, 23 Oct 2024 16:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FSfv2Heq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B501CB325;
	Wed, 23 Oct 2024 16:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729699278; cv=none; b=tQgMI4vUqtuhVBCQm4cEOrcwcWQEJL4Id65EdLXw2eqyCRs5t//5anbRF+Rka059+mBE4to6LAbo+I2gqSAxGCebwhctKa3a7z0UsdSIo6D1kJFWZq8q9mNDMr1zHRcsE2+1rYmIuNI8lIw7rsErxP2B1C4moln2c2xsmfdpFmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729699278; c=relaxed/simple;
	bh=W5xFKetcwQ/QLsjWJsUT13T/vKZJ/kfXRLME8PuLU+Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aHw3JOhIKUs9pr2oWSFohAqJdB3NB+VatwCONTiuWH4qFlv403SRG3M3gY0/MwuLRoxbLJkYBzLQxtMIWuMvKPqfw7eHiBt/dx8yZ/UMDSIbRTiWB6isNG+16cAtEH/WegHxUrwkWcsDihcdUehRR+74asUgYaefTGCGfhoCi4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FSfv2Heq; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4609b968452so49535451cf.3;
        Wed, 23 Oct 2024 09:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729699275; x=1730304075; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K/1XJzYLbLLAyJGuYG7+ES3prZrlUcxYGKyNEplqU2E=;
        b=FSfv2HeqwnNShXj0lEOGrb+B+S4s9px/n8uNW5cHjONcdEhJK83LuqIDaYcEtynULe
         RGFX8hCf0ul+/1bWyvUKln5RDb5ectmppuYuE49Cj4JY+ymzzBGT0kLGZq90a9uwcF/g
         gF61maFMfdIC3Xx9S3Cvd4Bdpvf0yhMUYrz6QcAh4p2ZJpHyvR9nmSj5OJ2f8DY0zY/M
         C8cu/8vx7Ywb/woulhKMMxfgx89rSzjRsjiXpPbcHLPnVYQt8H90Asij54HfNz+x4qA0
         +mOVDPiKq1UVWH8SCQl1zqIi24Z3xhbscQ6WnFTdJ8dAKuM4dDBXdkWtIuDa+8ur8t0r
         cuKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729699275; x=1730304075;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K/1XJzYLbLLAyJGuYG7+ES3prZrlUcxYGKyNEplqU2E=;
        b=dfZaOw0d3HmUzsojg67ZaG0Ek05phYfz9G3BdMJXsxlEzafF+ffT9DJgNitJJVkdWf
         hS8AomqNssib29sxmRPldngFzlU814qrw0NaSEQsjyCSlr/6P3bhiZ2QXGgzgn/ayo3A
         f2Vtwl/7IJ36lmwV4qHU/ASITPboSR1m2A4lj1L+2dM09dKzgclEOkgkSLo0KKGjhspW
         Tw0Lb52CMO3VXg7mbB5c4FUVV0MrF+HWbM0hnkZlJPWuvN5tkgLRQ5SwZfytz3OvBoVC
         yp/YOzPFxlcDDonEoEqzmmt6soJo9d51M5V49Kw5UVtQSANyiYLU1AQ5I/8MH2+zFTc5
         TrdQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+QY60t438xQhoHilxvbrI68PK+L8ITgDOqXVvIagN6aiOL0cooZYT6jhn4FK0+wxObZIDj/qxp2REeV1Y@vger.kernel.org, AJvYcCXv6z16Y3XHtM1zX0IuMgU66erVQ5JVBIaYketiBDDNCXp425J1qCzDQ0N98AmJwyuU11NH+WlKMELL0/BYPw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwA5aRqAgoDlxMdRU7vlJPDrxkzYLJ/bURCp5U5wWVeHtx5Kkok
	xV+iPK8MVFyxOoFnG7RY2EfTlOlxuKWjTmDiz+/sUooGIFT/4fcWuUQ1sRu/3iNQ7IXuFd9XGIz
	NtiDKoCS+hP1ua/tXXzRpVIJUvWKeFk30
X-Google-Smtp-Source: AGHT+IEeUs0dNaqTeC+A52s+LqOitE1p7o2Pp7vrkDaTkylmfnvAgE1F69JGVrjhbggUQUF95JMgL+komefXR6klygg=
X-Received: by 2002:ac8:5f88:0:b0:461:1cf4:f2c1 with SMTP id
 d75a77b69052e-4611cf4f502mr19258331cf.46.1729699274789; Wed, 23 Oct 2024
 09:01:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241022155513.303860-1-mszeredi@redhat.com> <CAJfpegtfa5LbGPH9CLatQAKud2tU8-uSDu4qRPiFwpLzE1Ggpw@mail.gmail.com>
In-Reply-To: <CAJfpegtfa5LbGPH9CLatQAKud2tU8-uSDu4qRPiFwpLzE1Ggpw@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 23 Oct 2024 18:01:03 +0200
Message-ID: <CAOQ4uxhEU1K=_wdF5ri+WOMVJ3_t_B1JGyyxvnyeSw3nSUc=gg@mail.gmail.com>
Subject: Re: [PATCH] ovl: clarify dget/dput in ovl_cleanup()
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Miklos Szeredi <mszeredi@redhat.com>, linux-unionfs@vger.kernel.org, 
	Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 22, 2024 at 6:04=E2=80=AFPM Miklos Szeredi <miklos@szeredi.hu> =
wrote:
>
> On Tue, 22 Oct 2024 at 17:56, Miklos Szeredi <mszeredi@redhat.com> wrote:
> >
> > Add a comment explaining the reason for the seemingly pointless extra
> > reference.
> >
> > Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
> > Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> > ---
> >  fs/overlayfs/dir.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
> > index ab65e98a1def..9e97f7dffd90 100644
> > --- a/fs/overlayfs/dir.c
> > +++ b/fs/overlayfs/dir.c
> > @@ -28,6 +28,10 @@ int ovl_cleanup(struct ovl_fs *ofs, struct inode *wd=
ir, struct dentry *wdentry)
> >  {
> >         int err;
> >
> > +       /*
> > +        * Cached negative upper dentries are generally not useful, so =
grab a
> > +        * ref to the victim to keep it from turning negative.
> > +        */
>
> In fact an explicit d_drop() after the fact would have exactly the
> same effect, so maybe that would be cleaner...
>

Agree.

Thanks,
Amir.

