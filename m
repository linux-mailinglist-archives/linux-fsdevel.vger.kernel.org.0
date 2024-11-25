Return-Path: <linux-fsdevel+bounces-35844-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 270839D8CD1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2024 20:25:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED973B28190
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2024 19:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A897B1BA86C;
	Mon, 25 Nov 2024 19:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cXxyV/ie"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 797841B87E1
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 Nov 2024 19:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732562624; cv=none; b=W+0lvjA7iNm6gVlyXw1ISbt/7nftf79dFG9UKQB8qwzH0PozpX0K5DDT9yJA4N0UGk3E+3VxHvU/h1QribR0gcfAz1A2oiSUgDi0wfs+IW1H6hm7+j4Bw0qjnBS/JKecc2b1TXYJ85J5F1n6OwryXSADmp4zqWOcyj6a/moH7gQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732562624; c=relaxed/simple;
	bh=BebRrrr+Ol57iYck7TYq8P0gSw5vYYy9aWTOBSfvMwE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bq7jhwNnmt01MAEzcBqv5J/S/8BkZhoF/rRlGI0dUKX1Y+/1d9jx0CNgH1RT+bn/jqzLlcQX65fV+OUZq0q3ed4U2zKIyX8MtnwZmdu1Y8m9OZcs0ZEzRi7kfnmWi36wNsXNwX3lgPpbgPpU0+OB3tva5FNyvEk74fBbZYfZvi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cXxyV/ie; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-46679337c08so10554351cf.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Nov 2024 11:23:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732562620; x=1733167420; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+DQfzkwaUC4KgsXJFw5+jiGgmXstc/mOVC86TPGf9Rc=;
        b=cXxyV/ieRF+ciIaIZdHEQbbkmO+pnBTn9qV3phKhdKl++wxn61hwKMCWWMy7m0Ijky
         nODw4maANsJDCDrHPEGT9PcAnC469j9OkPal0MzVZizwf4TrPssRiR6sBxVtoL36lXky
         vDxOxIThqX12vRtNaTW3DE5k1CA1NznJbwUqgYZFz7tnxD1EmRnmr3irUZk5iMg2UOlx
         cynB0dUjelqAi+kNbZzsZL5D3pHW3EHSCaHe+1qvA/wbgkOhWP3pp4a+LRgcbhSVwCHm
         z6frhS2jJUFKT1vBmvZKt5FYwNTOtBoBcp1DIiEZpKC1uZPQ9VJGsQ5PjpGoQGh7oqm0
         IRqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732562620; x=1733167420;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+DQfzkwaUC4KgsXJFw5+jiGgmXstc/mOVC86TPGf9Rc=;
        b=rajO5Q31Z5Qf+L4VVTmGekzKPUaV7lMmAfPxTDXtt7kiWiUkZivWN+0INDJPzCdD00
         SIwB3A0OmUJ33nOXvUEvev9OOEL970CTz4rd3k+w+9NzFBIuF6ZvbupWp05rctDXa2GE
         Nac5HKzqEqibxSkSBhH+fl1tX19spdGCgmQmxyxkJ+uhSTy+URCEopCvixsOvwOYOuiD
         4u+elzt9j1RkiQrTbSVagVIAfAaSaujqVmIvdJdXAyq5nyjEgqD7TrE9xk274As0ADzU
         iojZzpWX7rNXJwu5l5nNx5DFvK/zyQK5THXTruNxofORZo0X8Z0AqwYPsK+Ntnr27zkL
         ZvHQ==
X-Forwarded-Encrypted: i=1; AJvYcCWYK06cUZuOhjIfauN+3y+m309Kve0qkzxQUTsnIRAuhm60+rFzhJ/xY9G4d4qMZtMQ7ZTSv9eKBumG7HT1@vger.kernel.org
X-Gm-Message-State: AOJu0YyGblNdLuPfIywagaw4NdhXu1h0sc6jCK/Ml5d18PtuaXwfk5lA
	Eu4U+sUVmZWNE/lb1zrMeKVUYj3mDOsTgfiK0GNI34UUAAIwS52WLRP9WB8BvukQ6ODX9/yVhj7
	Hmj448yCrZ0SOCktNKoLX3s95asE=
X-Gm-Gg: ASbGncuOTn3uIMgIzuqpVcwa3raa71pQQ66pPhh3bMvCC3ko6Cy6cIbthPSCUxsSxTJ
	tE7zNjlRdGxcrsndYoaowzVLMj/fei1ee1JkNGgbbcjEx4lk=
X-Google-Smtp-Source: AGHT+IFeNTQyInzCGk7QdCKnVIeboMpjI0G1AaZ8yOYpBUA1DNOVwFKzjmoul5eacrGUYj5443gaKwuKmZD++o6Bt48=
X-Received: by 2002:ac8:5ac5:0:b0:466:a2c2:f36e with SMTP id
 d75a77b69052e-466a2c2f5e8mr11115771cf.44.1732562620182; Mon, 25 Nov 2024
 11:23:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241109001258.2216604-1-joannelkoong@gmail.com>
 <20241109001258.2216604-10-joannelkoong@gmail.com> <20241122144735.GE2001301@perftesting>
In-Reply-To: <20241122144735.GE2001301@perftesting>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Mon, 25 Nov 2024 11:23:29 -0800
Message-ID: <CAJnrk1YG=Pke=0wLmzw5FEGW4vWsyx0wC7CyNFaVHGepmzKQzA@mail.gmail.com>
Subject: Re: [PATCH 09/12] fuse: support large folios for readahead
To: Josef Bacik <josef@toxicpanda.com>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, 
	bernd.schubert@fastmail.fm, jefflexu@linux.alibaba.com, willy@infradead.org, 
	shakeel.butt@linux.dev, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 22, 2024 at 6:47=E2=80=AFAM Josef Bacik <josef@toxicpanda.com> =
wrote:
>
> On Fri, Nov 08, 2024 at 04:12:55PM -0800, Joanne Koong wrote:
> > Add support for folios larger than one page size for readahead.
> >
> > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > ---
> >  fs/fuse/file.c | 28 +++++++++++++++++++---------
> >  1 file changed, 19 insertions(+), 9 deletions(-)
> >
> > diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> > index 44a65bdfe8fb..255c7f2f2ed4 100644
> > --- a/fs/fuse/file.c
> > +++ b/fs/fuse/file.c
> > @@ -885,14 +885,13 @@ static void fuse_readpages_end(struct fuse_mount =
*fm, struct fuse_args *args,
> >       fuse_io_free(ia);
> >  }
> >
> > -static void fuse_send_readpages(struct fuse_io_args *ia, struct file *=
file)
> > +static void fuse_send_readpages(struct fuse_io_args *ia, struct file *=
file,
> > +                             unsigned int count)
> >  {
> >       struct fuse_file *ff =3D file->private_data;
> >       struct fuse_mount *fm =3D ff->fm;
> >       struct fuse_args_pages *ap =3D &ia->ap;
> >       loff_t pos =3D folio_pos(ap->folios[0]);
> > -     /* Currently, all folios in FUSE are one page */
> > -     size_t count =3D ap->num_folios << PAGE_SHIFT;
> >       ssize_t res;
> >       int err;
> >
> > @@ -929,6 +928,7 @@ static void fuse_readahead(struct readahead_control=
 *rac)
> >       unsigned int max_pages, nr_pages;
> >       loff_t first =3D readahead_pos(rac);
> >       loff_t last =3D first + readahead_length(rac) - 1;
> > +     struct folio *folio =3D NULL;
> >
> >       if (fuse_is_bad(inode))
> >               return;
> > @@ -952,8 +952,8 @@ static void fuse_readahead(struct readahead_control=
 *rac)
> >       while (nr_pages) {
> >               struct fuse_io_args *ia;
> >               struct fuse_args_pages *ap;
> > -             struct folio *folio;
> >               unsigned cur_pages =3D min(max_pages, nr_pages);
> > +             unsigned int pages =3D 0;
> >
> >               if (fc->num_background >=3D fc->congestion_threshold &&
> >                   rac->ra->async_size >=3D readahead_count(rac))
> > @@ -968,14 +968,24 @@ static void fuse_readahead(struct readahead_contr=
ol *rac)
> >                       return;
> >               ap =3D &ia->ap;
> >
> > -             while (ap->num_folios < cur_pages) {
> > -                     folio =3D readahead_folio(rac);
> > +             while (pages < cur_pages) {
> > +                     unsigned int folio_pages;
> > +
> > +                     if (!folio)
> > +                             folio =3D readahead_folio(rac);
> > +
> > +                     folio_pages =3D folio_nr_pages(folio);
> > +                     if (folio_pages > cur_pages - pages)
> > +                             break;
> > +
> >                       ap->folios[ap->num_folios] =3D folio;
> > -                     ap->descs[ap->num_folios].length =3D folio_size(f=
olio);
> > +                     ap->descs[ap->num_folios].length =3D folio_pages =
<< PAGE_SHIFT;
>
> Why change this?  Aren't these equivalent?  Thanks,

Yes, these are equivalent. Don't know why I modified this, thanks for
noting. I'll change this back to the original line for v2.


Thanks,
Joanne
>
> Josef

