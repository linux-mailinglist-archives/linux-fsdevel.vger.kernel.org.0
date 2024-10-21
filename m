Return-Path: <linux-fsdevel+bounces-32538-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B87C9A92DB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Oct 2024 00:04:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 471B7281CD3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Oct 2024 22:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 098071FEFB3;
	Mon, 21 Oct 2024 22:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KEgldEB7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6E0D19581F
	for <linux-fsdevel@vger.kernel.org>; Mon, 21 Oct 2024 22:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729548191; cv=none; b=TbCyv4cI7nqhvUQ45TxZelGAwkQTBAETOHnr7K8gGQQSRvjsJ0cc/sugX65/vu0kDs+AM5l2BqXZckBwzyE3w3MEskSVuiqRyqodzXHMpIatRrf4Z+0sRxWneTkLMQ/OFSoZEfbU2V5xPnlqiseA4BmyASSGdo4kx33N615bV8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729548191; c=relaxed/simple;
	bh=HfUT3pZj1x4Ckyq9JBDqChEraVi1Hk1zJvgg0n7qpAI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KJOTyJ4xOsg0TjgorIwImUR2m/8zxBfcd6b4LauMgwoCpsCCR1XAOzoW+Ga8Hi6AsXoTJuN7eG942Wyrybwu12P7o7TPY9w/XRhbFvLtZVU6QxnH1c93GUqr3m/e2a/zucUuxzLnPsGrlhjuebL/49/U3CU3ev7Lz5gNotKiG40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KEgldEB7; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-46097806aaeso35263161cf.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Oct 2024 15:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729548188; x=1730152988; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j6x/tCH8OrdsBUI3+xZ9NeaxY2Vt0lvuWW+T3PABZqw=;
        b=KEgldEB7XbqO2vhZi+UX+7QeWLejVvYWRQ4XfhxjwtGIW9lJAAjbAhh3rnG+uZ72FJ
         qgYHCtLa6rWfNZQg7i/Lg6sY15FxA8Kom4Ze7+ERfUvzmLj5WihWCKLUocNWwajFvMC3
         XbUE2GehTTUukXHwwypr86waM7iT3d5+ykFwhOB5AutjydfOExHPez+5hIO30TNoTsnp
         XrZBZ1M2hT9d0WWnmFk32pA8OsqIpjzWSv+Y2couY/f8Aw4i6CnSzc12hCtFgQLCQeqJ
         gfSMdO6LbSgPwrXN+P3McQ1BhfMLpa81uPVJ3q+GuCnxOoG/DIJqeXq55Xdm4irzjA9m
         ZSjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729548188; x=1730152988;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j6x/tCH8OrdsBUI3+xZ9NeaxY2Vt0lvuWW+T3PABZqw=;
        b=o8GzMM4sISyj6qpFpwwdA4rvPVdj8DJjuyoVGXkj4LaNWzfN1iB+TNx5omEgWQyPuj
         TukR6N1E1S9BDj/gi+8j4XxvgAKHqZI42Huj+NLENx/H2H1lftvvU3ukEuh/93GA4e5l
         hrYatjbPZqQ/xGRS+AZhWDH8gi3uvpwqFLoxSFBVIyiLcgYtzjztXgsRMRKGfhK/2nWF
         NqH+KIL07ne4v7M+qE9g41np5R/xaHaPqjl5IahWmrIOtX2PEn50XkNXyichy/bEphNR
         C7pywZeJFFxN92eDtS5JHcmDCvtwk4cb8XOuXJ9LDX7Fzzawg94ufzTP7UCBL+97XftS
         X9Iw==
X-Forwarded-Encrypted: i=1; AJvYcCX3T7iHtxmjzWPCh1yW/YwpwrFQDUvgZIu5yiK3w+kExum9nUBk6lUl4UtrysRNfoVdtSZo+7I1PsDRCJnL@vger.kernel.org
X-Gm-Message-State: AOJu0YyLOA1Z19RAQ4KDAMBrrVeNHnriKW5sGjkRBhGC/r8H3GeWGO4S
	dq3MnnOe213+fzRNd4ONvlgjJQRMFaa/XOE04V5Hc3on/mAagP9br1n4CoqPMa+mVmBaJCBvN0l
	K4vNg8JUSCITwx37LeS77/dIpUtfo7I54
X-Google-Smtp-Source: AGHT+IG8zXtA66gOH6qDdUHkT/lEoTKFobRNHohXHRjws9E0ZabdJCDZpdxYO7mhp47cY1TwaJrRtn2/ub6YftOwgFg=
X-Received: by 2002:a05:622a:4cf:b0:460:9450:ce6f with SMTP id
 d75a77b69052e-460aed85df1mr190391591cf.33.1729548188468; Mon, 21 Oct 2024
 15:03:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241002165253.3872513-1-joannelkoong@gmail.com>
 <20241002165253.3872513-13-joannelkoong@gmail.com> <20241018200245.GC2473677@perftesting>
In-Reply-To: <20241018200245.GC2473677@perftesting>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Mon, 21 Oct 2024 15:02:57 -0700
Message-ID: <CAJnrk1aYt=CD0kgOf3_rx9vprZKdwv5pXVWKFRofa+Zzs4FAxA@mail.gmail.com>
Subject: Re: [PATCH 12/13] fuse: convert direct io to use folios
To: Josef Bacik <josef@toxicpanda.com>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, 
	bernd.schubert@fastmail.fm, willy@infradead.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 18, 2024 at 1:02=E2=80=AFPM Josef Bacik <josef@toxicpanda.com> =
wrote:
>
> On Wed, Oct 02, 2024 at 09:52:52AM -0700, Joanne Koong wrote:
> > Convert direct io requests to use folios instead of pages.
> >
> > No functional changes.
> >
> > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > ---
> >  fs/fuse/file.c | 88 ++++++++++++++++++++++----------------------------
> >  1 file changed, 38 insertions(+), 50 deletions(-)
> >
> > diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> > index 1fa870fb3cc4..38ed9026f286 100644
> > --- a/fs/fuse/file.c
> > +++ b/fs/fuse/file.c
> > @@ -665,11 +665,11 @@ static void fuse_release_user_pages(struct fuse_a=
rgs_pages *ap,
> >  {
> >       unsigned int i;
> >
> > -     for (i =3D 0; i < ap->num_pages; i++) {
> > +     for (i =3D 0; i < ap->num_folios; i++) {
> >               if (should_dirty)
> > -                     set_page_dirty_lock(ap->pages[i]);
> > +                     folio_mark_dirty_lock(ap->folios[i]);
> >               if (ap->args.is_pinned)
> > -                     unpin_user_page(ap->pages[i]);
> > +                     unpin_folio(ap->folios[i]);
> >       }
> >  }
> >
> > @@ -739,24 +739,6 @@ static void fuse_aio_complete(struct fuse_io_priv =
*io, int err, ssize_t pos)
> >       kref_put(&io->refcnt, fuse_io_release);
> >  }
> >
> > -static struct fuse_io_args *fuse_io_alloc(struct fuse_io_priv *io,
> > -                                       unsigned int npages)
> > -{
> > -     struct fuse_io_args *ia;
> > -
> > -     ia =3D kzalloc(sizeof(*ia), GFP_KERNEL);
> > -     if (ia) {
> > -             ia->io =3D io;
> > -             ia->ap.pages =3D fuse_pages_alloc(npages, GFP_KERNEL,
> > -                                             &ia->ap.descs);
> > -             if (!ia->ap.pages) {
> > -                     kfree(ia);
> > -                     ia =3D NULL;
> > -             }
> > -     }
> > -     return ia;
> > -}
> > -
> >  static struct fuse_io_args *fuse_io_folios_alloc(struct fuse_io_priv *=
io,
> >                                                unsigned int nfolios)
> >  {
> > @@ -776,12 +758,6 @@ static struct fuse_io_args *fuse_io_folios_alloc(s=
truct fuse_io_priv *io,
> >       return ia;
> >  }
> >
> > -static void fuse_io_free(struct fuse_io_args *ia)
> > -{
> > -     kfree(ia->ap.pages);
> > -     kfree(ia);
> > -}
> > -
> >  static void fuse_io_folios_free(struct fuse_io_args *ia)
> >  {
> >       kfree(ia->ap.folios);
> > @@ -814,7 +790,7 @@ static void fuse_aio_complete_req(struct fuse_mount=
 *fm, struct fuse_args *args,
> >       }
> >
> >       fuse_aio_complete(io, err, pos);
> > -     fuse_io_free(ia);
> > +     fuse_io_folios_free(ia);
> >  }
> >
> >  static ssize_t fuse_async_req_send(struct fuse_mount *fm,
> > @@ -1518,10 +1494,11 @@ static inline size_t fuse_get_frag_size(const s=
truct iov_iter *ii,
> >
> >  static int fuse_get_user_pages(struct fuse_args_pages *ap, struct iov_=
iter *ii,
> >                              size_t *nbytesp, int write,
> > -                            unsigned int max_pages)
> > +                            unsigned int max_folios)
> >  {
> >       size_t nbytes =3D 0;  /* # bytes already packed in req */
> >       ssize_t ret =3D 0;
> > +     ssize_t i =3D 0;
> >
> >       /* Special case for kernel I/O: can copy directly into the buffer=
 */
> >       if (iov_iter_is_kvec(ii)) {
> > @@ -1538,15 +1515,23 @@ static int fuse_get_user_pages(struct fuse_args=
_pages *ap, struct iov_iter *ii,
> >               return 0;
> >       }
> >
> > -     while (nbytes < *nbytesp && ap->num_pages < max_pages) {
> > -             unsigned npages;
> > +     /*
> > +      * Until there is support for iov_iter_extract_folios(), we have =
to
> > +      * manually extract pages using iov_iter_extract_pages() and then
> > +      * copy that to a folios array.
> > +      */
> > +     struct page **pages =3D kzalloc((max_folios - ap->num_folios) * s=
izeof(struct page *),
> > +                                   GFP_KERNEL);
> > +     if (!pages)
> > +             return -ENOMEM;
> > +
> > +     while (nbytes < *nbytesp && ap->num_folios < max_folios) {
> > +             unsigned nfolios;
> >               size_t start;
> > -             struct page **pt_pages;
> >
> > -             pt_pages =3D &ap->pages[ap->num_pages];
> > -             ret =3D iov_iter_extract_pages(ii, &pt_pages,
> > +             ret =3D iov_iter_extract_pages(ii, &pages,
> >                                            *nbytesp - nbytes,
> > -                                          max_pages - ap->num_pages,
> > +                                          max_folios - ap->num_folios,
> >                                            0, &start);
> >               if (ret < 0)
> >                       break;
> > @@ -1554,15 +1539,18 @@ static int fuse_get_user_pages(struct fuse_args=
_pages *ap, struct iov_iter *ii,
> >               nbytes +=3D ret;
> >
> >               ret +=3D start;
> > -             npages =3D DIV_ROUND_UP(ret, PAGE_SIZE);
> > +             nfolios =3D DIV_ROUND_UP(ret, PAGE_SIZE);
> >
> > -             ap->descs[ap->num_pages].offset =3D start;
> > -             fuse_page_descs_length_init(ap->descs, ap->num_pages, npa=
ges);
> > +             ap->folio_descs[ap->num_folios].offset =3D start;
> > +             fuse_folio_descs_length_init(ap->folio_descs, ap->num_fol=
ios, nfolios);
>
> With this conversion fuse_page_descs_length_init now has no users, so I'd=
 add a
> followup patch at the end of the series to remove it.  Thanks,

Great catch. Thanks for reviewing these patches. I agree with your
other comments as well and will make sure to address those for v2.

Thanks,
Joanne
>
> Josef

