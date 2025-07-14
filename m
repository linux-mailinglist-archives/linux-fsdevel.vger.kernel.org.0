Return-Path: <linux-fsdevel+bounces-54892-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E87BB049AB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jul 2025 23:44:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AA7E4E021D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jul 2025 21:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26A0926B955;
	Mon, 14 Jul 2025 21:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MTww6hNz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C88136347
	for <linux-fsdevel@vger.kernel.org>; Mon, 14 Jul 2025 21:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752529436; cv=none; b=W6tEbsxEiu9n1di5CEYPLRJEsWIjWfso7Qz8V+zQOxIG4v/+oBFAOGdXVsPw7DwUOT3ExljI1+wwPqMlVeqceYx1ww6jTnsx3IlbPH2GtWMRjkWtvb0ADBD3paYY5jnC3Gy+J3GOxRaNXHurHe28UgLBgmW2fxEkrd/cC002AMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752529436; c=relaxed/simple;
	bh=C5iI4w+koGwkYDtpTiw5Ji6BhW1u0WPGX8bv9mUK/Uo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lxtgBivmkd9okg4heEfq6DfkuYI5a3a7DI6IGoO7B44s13aDEaYVLDmVhYcSDm7u8J0KzFCHkp8lKDru7EdKu3YV4Ftcd5vPgHK/zXpGndFgIQfkwe6aSZMv3klN3HNX1D9AgYrfziNrFOrW0WFylEZtFMrz6j+MCX03+Y3Cdpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MTww6hNz; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7d7f0fcef86so446710285a.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Jul 2025 14:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752529434; x=1753134234; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o6LvIxXxNbW+rLGUH1QijXJo9uzg22KXtqVWPi1cj9g=;
        b=MTww6hNzzr4S0NqoeQ9TUXGQdd6VOsniylpaDXtxZv5iVLmyU9rMt+NOpoREUSFA3Q
         2KxX/Y2Qw+b9fn3gkSEOfE0q/2oH+ECZYmu5T4NUA7v2gHBqqRPJUwstuxCeQ0xB/Smf
         gktOAejfgi7yxcOR6ea2+ZlTHO32KUcAR6nqrmK7bkt4W48JY0ffoEhQrks6lgUBzh86
         kdnKKvQmi22g8LJLYTJXuzYs+MdHT/BN5n1KgKzazIE4SdTZnif38IfSCt7uGC7W1Sc/
         sp8C4ywsueW4Kp5GxJS04rJ/rcZo8WXbuMhrVru+In83Y1vVuxKhAuQsL/x6QA9mM5G/
         Hf3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752529434; x=1753134234;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o6LvIxXxNbW+rLGUH1QijXJo9uzg22KXtqVWPi1cj9g=;
        b=GUH90xD8qoC+SfCK15xX9ClKtSjZqgFqo9PA06nR9Ah7FtT1vMqSYOwf2qUiulo44F
         BmMaR8iYc13cQZ7FAa9Mqw2x2QTKFGWnbGzq2YxOr8dHzwMM56uPKnlolAEKCX6zkNBy
         aygQISNbOoBzvkddyDXqyU82MbZQktQHu4mCe1klY+RxO+0B9mWaqvUB+hRsXJYmXasK
         BlUHcjttLac7l+7zE3vdYzmCBHlDxhrM+5W8IXSN+O7R5kDc75Y53X7zDWfmamSHT/3W
         Jc+Ao59xc9xxh601kkXSFOIEV6ogBSe1CFXB/tFJNKD73owKax14fOiP6SyyyFnJoD0S
         K4Yg==
X-Gm-Message-State: AOJu0YwOYvxvezHClkeizHtgLe+PAaLQ2DWc7pT6nmdLCbyuDI2O8sON
	Glh27MvJ+6xRdAnvcZEIqQMo3I+5DMBXMeVLnap2UIsldDJ5eKcXlO1GjLoF04ilrGFg9tJVL+8
	IA7//Uh7pTGx+ovjfVBheqFCUJFAQBS4=
X-Gm-Gg: ASbGncu0499QehD8UZZRpShj24rxTEeYw5aev8c1WO5fMhyNStLVZSlAqg/aCWqI3Ie
	U/GnmRjZYi6ZQyjYtn00hIrwhuoi37maEbe3a8jd15sj6e16MNuadlUURxgVBRO/s3AFS27kUj7
	qCj9ZL5kDs3Mf05CQULxST43np2ITLxQjxKTW/7Qp3s21D4o0ja2ZScmN4hrlOF5yu5a8RbxEfq
	2WGyX3Y55H31QM4xQ==
X-Google-Smtp-Source: AGHT+IG6tgTaAUIsmllnfrJnFnI29H90R31F0gcvZVra/rSkPJGVdkL6zymzotb5m1a0PUAksO9iiJBRwr26DBOovAE=
X-Received: by 2002:a05:620a:4402:b0:7e2:d113:ede7 with SMTP id
 af79cd13be357-7e2d113f0f9mr977152085a.22.1752529433812; Mon, 14 Jul 2025
 14:43:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250709221023.2252033-1-joannelkoong@gmail.com>
 <20250709221023.2252033-3-joannelkoong@gmail.com> <20250712044156.GH2672029@frogsfrogsfrogs>
In-Reply-To: <20250712044156.GH2672029@frogsfrogsfrogs>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Mon, 14 Jul 2025 14:43:43 -0700
X-Gm-Features: Ac12FXyByFnFCr-Ki7WGhxq-8qa3eade7Rqbp93_WnLSrzNw3DmaQzzsiQEpcQ0
Message-ID: <CAJnrk1b7mWBjdmiFk9BEgRJu7fskgZN9+rDT0yrx5w3og_DHDQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/5] fuse: use iomap for writeback
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, hch@lst.de, miklos@szeredi.hu, 
	brauner@kernel.org, anuj20.g@samsung.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 11, 2025 at 9:41=E2=80=AFPM Darrick J. Wong <djwong@kernel.org>=
 wrote:
>
> On Wed, Jul 09, 2025 at 03:10:20PM -0700, Joanne Koong wrote:
> > Use iomap for dirty folio writeback in ->writepages().
> > This allows for granular dirty writeback of large folios.
> >
> > Only the dirty portions of the large folio will be written instead of
> > having to write out the entire folio. For example if there is a 1 MB
> > large folio and only 2 bytes in it are dirty, only the page for those
> > dirty bytes will be written out.
> >
> > .dirty_folio needs to be set to iomap_dirty_folio so that the bitmap
> > iomap uses for dirty tracking correctly reflects dirty regions that nee=
d
> > to be written back.
> >
> > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > ---
> >  fs/fuse/file.c | 127 +++++++++++++++++++++++++++++--------------------
> >  1 file changed, 76 insertions(+), 51 deletions(-)
> >
> > diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> > index cadad61ef7df..70bbc8f26459 100644
> > --- a/fs/fuse/file.c
> > +++ b/fs/fuse/file.c
> > @@ -2100,7 +2101,7 @@ struct fuse_fill_wb_data {
> >       struct fuse_file *ff;
> >       struct inode *inode;
> >       unsigned int max_folios;
> > -     unsigned int nr_pages;
> > +     unsigned int nr_bytes;
>
> I don't know if fuse servers are ever realistically going to end up with
> a large number of 1M folios, but at least in theory iomap is capable of
> queuing ~4096 folios into a single writeback context.  Does this need to
> account for that?

In fuse_writepage_need_send(), the writeback request gets sent out if
max pages can be exceeded (eg if ((data->nr_bytes + len) / PAGE_SIZE >
fc->max_pages)). max pages has a limit of 65535, which gives a limit
in bytes of 256 MB (eg 65535 * PAGE_SIZE), so I think having unsigned
int here for nr_bytes is okay.

>
> >  };
> >
> >  static bool fuse_pages_realloc(struct fuse_fill_wb_data *data)
> > @@ -2141,22 +2142,29 @@ static void fuse_writepages_send(struct fuse_fi=
ll_wb_data *data)
> >       spin_unlock(&fi->lock);
> >  }
> >
> > -static bool fuse_writepage_need_send(struct fuse_conn *fc, struct foli=
o *folio,
> > -                                  struct fuse_args_pages *ap,
> > +static bool fuse_writepage_need_send(struct fuse_conn *fc, loff_t pos,
> > +                                  unsigned len, struct fuse_args_pages=
 *ap,
> >                                    struct fuse_fill_wb_data *data)
> >  {
> > +     struct folio *prev_folio;
> > +     struct fuse_folio_desc prev_desc;
> > +     loff_t prev_pos;
> > +
> >       WARN_ON(!ap->num_folios);
> >
> >       /* Reached max pages */
> > -     if (data->nr_pages + folio_nr_pages(folio) > fc->max_pages)
> > +     if ((data->nr_bytes + len) / PAGE_SIZE > fc->max_pages)
>
>  >> PAGE_SHIFT ?

Nice, i'll change this to >> PAGE_SHIFT. Thanks for looking through
the patchset.
>
> Otherwise this looks decent to me.
>
> --D
>
> >               return true;

