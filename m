Return-Path: <linux-fsdevel+bounces-51617-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F8C0AD9629
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jun 2025 22:22:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9E523BA220
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jun 2025 20:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B150A246BA9;
	Fri, 13 Jun 2025 20:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YmKWoMsW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95CBA18A6DF
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Jun 2025 20:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749846154; cv=none; b=Mj+4T98z1YN+R0RVf240IrmDvxFsCxKmlpUZjJQmyGlL6wndTUuGDkA1BLIUc6xxCwrmhCPuOp1x2oExZnv8B9xPBUg0MT4bXCBmEUH7aqxz1iwQsF+L5EcnC8h0CTJ2gJl2QFs0dHz0w01bMNiR0Gi0t27+x7tQa+xVk/B5WN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749846154; c=relaxed/simple;
	bh=rEaBzL51ZQEiXvPh9KhsxoXDIYaXVqvhec4DasUC0Mc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QC9K0i56dl+NV8YC7evrqKB5ZyaS23HE8bT0NZoD1VHe2YeTTATnL24EoWo4+b5owW9DSe6mkQCZ1Z8Zspk+fc7osUPny7QPpkaP6Owitiu06zo3Z4iEZpqGdaebXJolN/8AXaLQZHAcfpJNDwPineBaZZYzn9JyGkQBzUIrq2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YmKWoMsW; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7c5f720c717so376776785a.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Jun 2025 13:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749846151; x=1750450951; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qLcllCLFd4zefQG19CPjTWzckVtVDSse4w9Q4Nd2jWI=;
        b=YmKWoMsWhKITQxuNJQDMIh9vM7fA/kl3apgjiEDhGG7d1z1aAAKFXB8Pg3YzyMPkr8
         RyCW3wX5+bOcYf7/kgT4iDSgX7k1efMY27G20vCQiOTHwWgfTPuuYuLNgbi0G8775j3e
         4YpdSCquVeMs7yixkNDhUwii23X9WOuQtsi0Cc1evvihyfosAs8KNZo59UVPvS2PcDgz
         dIIn6R/0Abdp0rJ6lanRWSFyRqfh4M+ZOS4/z0vxc9mnJWoxaB+Mo8CeSYrsKXwy+nGG
         TX6MCqn8vPgbn0oau2VxmkGzzIyI4Xi/oBLl61Z9gLxwoe7pbO7nl9GVtR9hNqLzQ6OL
         tCyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749846151; x=1750450951;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qLcllCLFd4zefQG19CPjTWzckVtVDSse4w9Q4Nd2jWI=;
        b=aDA0RQL+1CGO4dt2nXdKL2cCsZbawn1x7umtatJTvi8cOoGldnEktUhFVEK5TlrXWy
         cXtt+IgXoXWY49JJKa9UGYKHTzYhePRXExJw6a6jttQ8YWYw9zguTW1zJbjUJyQRzfVm
         xNnayw2PB+ZIlOJ/6UE/bOlmb9t90xI9nq91NLwAfdT2HBtlf6aeOVN6ome2SqsIXzEj
         tgmMDhnByw3TRte8YWaYXtleOkg29QKsVXI7Y02i1tWBwTxlJEbmEJN+fusW6VG2T6AX
         wTx/Brl3dllROMTeool/gSmq7pySMx3vSa4HT2faK3yAQd45Ct+K9HSuRgYKtWu2Uvbu
         jRRw==
X-Forwarded-Encrypted: i=1; AJvYcCX8hI3H/wUqxmPhn0UuXrqzHZX4pwaWYgimfN/N9I13WBQ/UfRH+lw+uBEbX5NPsurCE2UGrfL3DwNtGGPJ@vger.kernel.org
X-Gm-Message-State: AOJu0YzgX2B2flzz60BUEQfZQVTh9x1Wide8LQSI/ZSf7BFK3Q4vbLNm
	LmIjDIGVWMTFAsotoLikNErMI9Rs5RyE0HPDUM83ZMh1SA5ttZidFc2K30NNxZ+eswhD0/Kjkv8
	aG3B+zofkXBcLX8USF0mWdrsSrjfztfFwCRKS
X-Gm-Gg: ASbGncu0XbUUvURvHwoDSqcF572CbNb2YJLh5xA/isOrtAOr0uNax0ewKQGf7bnnB/e
	8ZOjy9VlyZJ7dczEiadZtqmXnzk1XblDzfA/Fx2VPCgZkPcoCCtgk+vWB6gFeXvRDQnJq3J6yz2
	yAoOrDh5NR/JJzmh7MZeHbpjHzOgZei7lV9lqveDp01rcCag0oxXcOIG2KXFU=
X-Google-Smtp-Source: AGHT+IE8cTzf7clV1kAnSYiOxESvkgKEB0pmolSj03tgjZ21reV621kUPr5b8ZVYX5KdEZp6avtHQxi8yWxJusAArhg=
X-Received: by 2002:a05:620a:4443:b0:7d3:acfa:de46 with SMTP id
 af79cd13be357-7d3c520058cmr303707785a.21.1749846151012; Fri, 13 Jun 2025
 13:22:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250613164646.3139481-1-willy@infradead.org> <20250613164646.3139481-2-willy@infradead.org>
 <CAJnrk1ZJ+Oi6kQWQawLFBdH22kS_z3WCgAXs8bsHdbVvnDSjDA@mail.gmail.com>
In-Reply-To: <CAJnrk1ZJ+Oi6kQWQawLFBdH22kS_z3WCgAXs8bsHdbVvnDSjDA@mail.gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Fri, 13 Jun 2025 13:22:19 -0700
X-Gm-Features: AX0GCFvu0w1EH1vwMiBBLPznlBZub-rTq1-bTB3lDZIQun40qvFHTwUhA6exteg
Message-ID: <CAJnrk1bD3XtzXh=LR9d63ViLe6n5F1S5vbg70R59t-+cBQiPtQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] fuse: Use a folio in fuse_add_dirent_to_cache()
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 13, 2025 at 1:14=E2=80=AFPM Joanne Koong <joannelkoong@gmail.co=
m> wrote:
>
> On Fri, Jun 13, 2025 at 9:46=E2=80=AFAM Matthew Wilcox (Oracle)
> <willy@infradead.org> wrote:
> >
> > Retrieve a folio from the page cache and use it throughout.
> > Removes three hidden calls to compound_head().
> >
> > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
>
> Reviewed-by: Joanne Koong <joannelkoong@gmail.com>
>
> > ---
> >  fs/fuse/readdir.c | 23 ++++++++++++-----------
> >  1 file changed, 12 insertions(+), 11 deletions(-)
> >
> > diff --git a/fs/fuse/readdir.c b/fs/fuse/readdir.c
> > index c2aae2eef086..09bed488ee35 100644
> > --- a/fs/fuse/readdir.c
> > +++ b/fs/fuse/readdir.c
> > @@ -35,7 +35,7 @@ static void fuse_add_dirent_to_cache(struct file *fil=
e,
> >         struct fuse_inode *fi =3D get_fuse_inode(file_inode(file));
> >         size_t reclen =3D FUSE_DIRENT_SIZE(dirent);
> >         pgoff_t index;
> > -       struct page *page;
> > +       struct folio *folio;
> >         loff_t size;
> >         u64 version;
> >         unsigned int offset;
> > @@ -62,12 +62,13 @@ static void fuse_add_dirent_to_cache(struct file *f=
ile,
> >         spin_unlock(&fi->rdc.lock);
> >
> >         if (offset) {
> > -               page =3D find_lock_page(file->f_mapping, index);
> > +               folio =3D filemap_lock_folio(file->f_mapping, index);
> >         } else {
> > -               page =3D find_or_create_page(file->f_mapping, index,
> > -                                          mapping_gfp_mask(file->f_map=
ping));
> > +               folio =3D __filemap_get_folio(file->f_mapping, index,
> > +                               FGP_LOCK | FGP_ACCESSED | FGP_CREAT,
> > +                               mapping_gfp_mask(file->f_mapping));
>
> nit: in the fuse codebase, the convention for line breaks is for the
> next line to have the same indentation as where the previous line's
> args start

Just noticed this, it looks like the filemap_grab_folio() api does the
same thing and can be used here.

>
> >         }
> > -       if (!page)
> > +       if (!folio)

I think this needs to be "if (IS_ERR(folio))" instead

> >                 return;

