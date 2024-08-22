Return-Path: <linux-fsdevel+bounces-26818-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 715C995BCCA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 19:09:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE5F11F24AF3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 17:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 424B61CEABB;
	Thu, 22 Aug 2024 17:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E0+N5jiR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D7BE1CDFBA
	for <linux-fsdevel@vger.kernel.org>; Thu, 22 Aug 2024 17:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724346521; cv=none; b=GiDdJIdZGX1P9AKF2bxcAsJSSuRkkGl04YIY10FaDCNmKDBrEgZEA0p3+SADV5BHhXpK7fvq1CBxxim/HIA+szkhPRO95W+3IRbUIGRNtby4YQrIPZr2gXWjDbq0OvXP+/iVCk3jPwXrXJGnWxL5L2v03A4IcZkLQpt2VWFB+yI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724346521; c=relaxed/simple;
	bh=3wKQzYQnvdE/yPGt1aHthNioVkRvdqew5PEeFMSgxXg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K2GXXB0Regc96jfYa95e8f/T5EnDuLZD1ES+My6DnhRrwcKHPX7OPb/eIQ6kFsgVrxj1BMdqYrVCUrOW67tiBsneswJ1JyfgMhn3m8eMoVpJFf1es6wsBsonmJB+uJggJMmOzJ4vfkddlX7pHZjMiZ0wVS7XSqRgLepDjE0ujV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E0+N5jiR; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-450059a25b9so8961571cf.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Aug 2024 10:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724346519; x=1724951319; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YPvkRFNIkJjQuZvSR40tCLpYCByHMVdneAwwuipVvI8=;
        b=E0+N5jiRQsSL94gygnXzmuC9HbIugSVB7NhZltPqgKlVSSfBLARbOSmbyo60aovfGO
         VwMAb5UG8kzO9Oob1UTJko80CsyygEdspsEZE9hS1qUW+K0jkuFneJ3h/Qg6B3mC9qou
         i7gni7NcaCwPZWrhd2r9pUb9U+TCHsGPrNtIzmtIEoe/B5mCODKB9nCYBaWi8TfM1pof
         /4iAqG0Yy4FrhS3TtJs0vITb+KUhMZ5h3IgP6YTjRWwY5c8Z5DRqKrYKoKAopTFDXYav
         tgVzGS1iUwXZ44t6dcSciKafd5hHwdijL+M5Rbo3lpHb/2OC9i04JQOo9Rvc+Nh6bo8s
         jcCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724346519; x=1724951319;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YPvkRFNIkJjQuZvSR40tCLpYCByHMVdneAwwuipVvI8=;
        b=QH8u/waS14rvPAmCgnGiMz+nLHt6YHFu6SIWCjwgGMA40i8LG8yp82S8kLkjPk9zq8
         ir54+g1ElZaS7G/KAqKGV6/hn/oXHAOrlXlo3Eq0e+trQa7KKgVbFX0voJa1HJKFK1nw
         glQ4gCc+DVITIL0Ii0fXvKqcYHsHGs7mWfmUixv/93Puo1jXVlBXLKPERFvYrVPZ545v
         srTn/t3mYogg1l/ycLT7mCRFc7v/H0gqg/fngodxTrXSwRfhTOus1nm0ZjiKy2iKGqLQ
         fjbNUCkDuHYKyhTXPcJBmYeeQY1dx8o5yXGJKrGZ4tUuIqs91gfDM4yLyhUtJAsndzne
         dC2A==
X-Gm-Message-State: AOJu0Yy5t+OpEfnTeNbVHoI2xihDan2i7OfKvxrxjU11tG2mQX0BHbLP
	1FC35lejNFY+nJLSuUOrr91HQ3A+78DRJkLXTEira+qv4zC5hn+YpFVNFfh+BOLID4PUGhFXBDp
	MzBY56V+SYxB831p1zua1rb9khhI=
X-Google-Smtp-Source: AGHT+IEKuxzAg9fylgegjeezgrp+U3UvoeDn/92am35/gzv11L7BWHucbNM3mRLA7dzWVXi5YGQDlwOL0rSzjTEjIF8=
X-Received: by 2002:ac8:5a86:0:b0:43e:1231:1040 with SMTP id
 d75a77b69052e-454faebebe5mr69376871cf.20.1724346518674; Thu, 22 Aug 2024
 10:08:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240821232241.3573997-1-joannelkoong@gmail.com>
 <20240821232241.3573997-9-joannelkoong@gmail.com> <CAJfpegt6eZrXC6PAa8dvb6duPSTxhSOm3_JzXjzB6hzOnw6z9A@mail.gmail.com>
In-Reply-To: <CAJfpegt6eZrXC6PAa8dvb6duPSTxhSOm3_JzXjzB6hzOnw6z9A@mail.gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Thu, 22 Aug 2024 10:08:28 -0700
Message-ID: <CAJnrk1Y6gYThf9ea6-TPjJM=7Jr+8ytng+NcTfg2tpd3W2zqkg@mail.gmail.com>
Subject: Re: [PATCH v2 8/9] fuse: refactor out shared logic in
 fuse_writepages_fill() and fuse_writepage_locked()
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org, josef@toxicpanda.com, 
	bernd.schubert@fastmail.fm, jefflexu@linux.alibaba.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 22, 2024 at 2:58=E2=80=AFAM Miklos Szeredi <miklos@szeredi.hu> =
wrote:
>
> On Thu, 22 Aug 2024 at 01:25, Joanne Koong <joannelkoong@gmail.com> wrote=
:
> >
> > This change refactors the shared logic in fuse_writepages_fill() and
> > fuse_writepages_locked() into two separate helper functions,
> > fuse_writepage_args_page_fill() and fuse_writepage_args_setup().
> >
> > No functional changes added.
> >
> > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > ---
> >  fs/fuse/file.c | 102 +++++++++++++++++++++++++++----------------------
> >  1 file changed, 57 insertions(+), 45 deletions(-)
> >
> > diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> > index 812b3d043b26..fe8ae19587fb 100644
> > --- a/fs/fuse/file.c
> > +++ b/fs/fuse/file.c
> > @@ -1936,7 +1936,6 @@ static void fuse_writepage_end(struct fuse_mount =
*fm, struct fuse_args *args,
> >
> >                 wpa->next =3D next->next;
> >                 next->next =3D NULL;
> > -               next->ia.ff =3D fuse_file_get(wpa->ia.ff);
> >                 tree_insert(&fi->writepages, next);
> >
> >                 /*
> > @@ -2049,50 +2048,78 @@ static void fuse_writepage_add_to_bucket(struct=
 fuse_conn *fc,
> >         rcu_read_unlock();
> >  }
> >
> > +static void fuse_writepage_args_page_fill(struct fuse_writepage_args *=
wpa, struct folio *folio,
> > +                                         struct folio *tmp_folio, uint=
32_t page_index)
> > +{
> > +       struct inode *inode =3D folio->mapping->host;
> > +       struct fuse_args_pages *ap =3D &wpa->ia.ap;
> > +
> > +       folio_copy(tmp_folio, folio);
> > +
> > +       ap->pages[page_index] =3D &tmp_folio->page;
> > +       ap->descs[page_index].offset =3D 0;
> > +       ap->descs[page_index].length =3D PAGE_SIZE;
> > +
> > +       inc_wb_stat(&inode_to_bdi(inode)->wb, WB_WRITEBACK);
> > +       inc_node_page_state(&tmp_folio->page, NR_WRITEBACK_TEMP);
> > +}
> > +
> > +static struct fuse_writepage_args *fuse_writepage_args_setup(struct fo=
lio *folio,
> > +                                                            struct fus=
e_file *ff)
> > +{
> > +       struct inode *inode =3D folio->mapping->host;
> > +       struct fuse_conn *fc =3D get_fuse_conn(inode);
> > +       struct fuse_writepage_args *wpa;
> > +       struct fuse_args_pages *ap;
> > +
> > +       wpa =3D fuse_writepage_args_alloc();
> > +       if (!wpa)
> > +              return NULL;
> > +
> > +       fuse_writepage_add_to_bucket(fc, wpa);
> > +       fuse_write_args_fill(&wpa->ia, ff, folio_pos(folio), 0);
> > +       wpa->ia.write.in.write_flags |=3D FUSE_WRITE_CACHE;
> > +       wpa->inode =3D inode;
> > +       wpa->ia.ff =3D ff;
> > +
> > +       ap =3D &wpa->ia.ap;
> > +       ap->args.in_pages =3D true;
> > +       ap->args.end =3D fuse_writepage_end;
> > +
> > +       return wpa;
> > +}
> > +
> >  static int fuse_writepage_locked(struct folio *folio)
> >  {
> >         struct address_space *mapping =3D folio->mapping;
> >         struct inode *inode =3D mapping->host;
> > -       struct fuse_conn *fc =3D get_fuse_conn(inode);
> >         struct fuse_inode *fi =3D get_fuse_inode(inode);
> >         struct fuse_writepage_args *wpa;
> >         struct fuse_args_pages *ap;
> >         struct folio *tmp_folio;
> > +       struct fuse_file *ff;
> >         int error =3D -ENOMEM;
> >
> > -       wpa =3D fuse_writepage_args_alloc();
> > -       if (!wpa)
> > -               goto err;
> > -
> >         tmp_folio =3D folio_alloc(GFP_NOFS | __GFP_HIGHMEM, 0);
> >         if (!tmp_folio)
> > -               goto err_free;
> > +               goto err;
> >
> >         error =3D -EIO;
> > -       wpa->ia.ff =3D fuse_write_file_get(fi);
> > -       if (!wpa->ia.ff)
> > +       ff =3D fuse_write_file_get(fi);
> > +       if (!ff)
> >                 goto err_nofile;
> >
> > -       fuse_writepage_add_to_bucket(fc, wpa);
> > -       fuse_write_args_fill(&wpa->ia, wpa->ia.ff, folio_pos(folio), 0)=
;
> > -
> > -       wpa->ia.write.in.write_flags |=3D FUSE_WRITE_CACHE;
> > -       wpa->next =3D NULL;
> > -       wpa->inode =3D inode;
> > +       wpa =3D fuse_writepage_args_setup(folio, ff);
> > +       if (!wpa) {
> > +               error =3D -ENOMEM;
> > +               goto err_writepage_args;
> > +       }
>
> Please use the following pattern, unless there's a good reason not to:
>
> +       error =3D -ENOMEM;
> +       if (!wpa)
> +               goto err_writepage_args;

Gotcha. I'll use this pattern and drop the last patch in this series.

Thanks,
Joanne

