Return-Path: <linux-fsdevel+bounces-48137-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0AF4AA9EC0
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 00:06:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CA1A3A27FC
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 May 2025 22:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 016482750E0;
	Mon,  5 May 2025 22:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E+7PgkAj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48FD013AF2
	for <linux-fsdevel@vger.kernel.org>; Mon,  5 May 2025 22:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746482766; cv=none; b=tTEF+zqhgySjs5p9oSFL0vLXiSTIOk6WlC6pbWDrIhrXjH4JWx6/1Xu3++XuWbeWsXHC4W6r1zgRPerPoJVzg4/4dwHbqX6e+HIvjzw/F9Ea7HzRM8sDJPBD5PinTbM1gcUQ8O5bxnYP3MYpmlylqiAQsc4X2z9a3gPujSZITdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746482766; c=relaxed/simple;
	bh=GDDwy+NWk/ooKHAQC2EwLcIGIn4SgwfMCtAJegzq790=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QoEQu1sufx90V6pxGDxIWlxPkysGVozxMsZLo0OUaSUZce8e/VED/KJrILdiVG7h5HnMAXUp7E0ga3C6Y2w1xEAavKeSsm6gNdRhSrK2svpc1Ygb73WqFqZ9st+0XWEdvHw3Dj16BMTB5JQQLPxgq5lskuKjFZ6EjuW0YrNlv0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E+7PgkAj; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-476ac73c76fso56503101cf.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 05 May 2025 15:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746482763; x=1747087563; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D/V3Ns0tienEYUpQF5hT0UyE38tAAlg+XreIb9U7XkE=;
        b=E+7PgkAjQVzoN+WGzTNoUjkhzuRV5xz9K2L1k7rD4T7aOFlw4akMVBtPJzBNUVBHhf
         JsSauQ+1rfg0iTQqQzfEYYmMIHKcsuqe5RqilwIaQYN0OsoTZtkNyd5qY+EqoiebLK5J
         ikIKVEpTmKWWJNHktsO+aJeJ6EAtC2ZFg87B0mSylov/HXhgy12jNbgmZtUMhvaiaiZu
         cEjpyVG3IuWGSepcl1HbE+t7lXeFcaUGriV0CASk6N9P/133Jiy3Jj4tKa2LKBuus+xO
         VJY2UUWCMZFyEQpllp1lMDShH+/IkcsbDn8v7Uh/zUWXzORp5k+U0H6N7VLXLEZBWsds
         BNkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746482763; x=1747087563;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D/V3Ns0tienEYUpQF5hT0UyE38tAAlg+XreIb9U7XkE=;
        b=cQ9EU77dklyVzWGsnkvL9Q6vWcrhhaQQWRgC0AB0ECzVFj0KfcRO/aLf82o+U+wric
         2/FJ0D27oLgVFEWfUPlyjgGNIFd0zVkah3riTLDSEtNSlNoD7AU+IEykHlXoahzllDBN
         UFzWCzqWPwH9TNo4a3jZCp+g3YWgVVo+Dz9XafArgfYrUBlortClDm1PAqcTRIc+RyEU
         9mwNIIjC+kqQ3tjx+p3KObd8Wn0yTx7wKhYTcItNKN0exceomPMpPlUBQzOef5CJjuo/
         VIVsbTUhIZ1GMi9DFOQ5jSiJ9fcXelGf0llc3QcuUyCf8GW2q8gCIaTj3X7ud4wO72tM
         Qq1A==
X-Forwarded-Encrypted: i=1; AJvYcCUdut76QezS23+EeTPszTBQvzBVeNP5vrRWnlLlw78piSbDSm2ag0cyVgcZfprMKaymX5LoUOgIFHdh8Dyz@vger.kernel.org
X-Gm-Message-State: AOJu0YysMwy/se0JUDFfZ0H/Oob9GOLnWA1D5S0LfFxzceJyMzTWJ13Q
	CRqiUdsoxcP6x5U8inZZpMRllp9k7drChbne/KyatXbtMlF3cjAsFGCTUGr91oNyc0mPi/xLdtO
	lMaBiqWdcuKtKBXYKvidnpvDgSyY=
X-Gm-Gg: ASbGncvTL8IecdfNlh0ukS/xKKpj+PhWD+QKfpKWobIm/MohDZ1NMnpx+UXgOwtIMtu
	4bDmkCrFGhkA7Tm495tyYAz4RA3Lh2fw838QnFSCcmo/HZhKjJJYv9ReQ+2eedj7U5ZTpiy5EHH
	eunjJhKEHOQoRXQUi4qv/2oYal9m0US43t2ItwZA==
X-Google-Smtp-Source: AGHT+IH++qQjhWACtCQsLnHCDb9oGYJHO7kzqj9VMQEVNJY3dsB05a4K0acTn8I0NBe6BYj4TwjCZjPCTiN5CN0umDk=
X-Received: by 2002:a05:622a:3d0:b0:476:9e90:101d with SMTP id
 d75a77b69052e-48e0126351bmr136253111cf.38.1746482762796; Mon, 05 May 2025
 15:06:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250426000828.3216220-1-joannelkoong@gmail.com>
 <20250426000828.3216220-10-joannelkoong@gmail.com> <007d07bf-4f0b-4f4c-af59-5be85c43fca3@fastmail.fm>
 <20250505144024.GK1035866@frogsfrogsfrogs> <e66ed6f1-eee4-4a3e-9807-0fdb575fcd4a@fastmail.fm>
In-Reply-To: <e66ed6f1-eee4-4a3e-9807-0fdb575fcd4a@fastmail.fm>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Mon, 5 May 2025 15:05:51 -0700
X-Gm-Features: ATxdqUFidjNX-8D78nVhSOgH6tRh78xVZRprohCN9aWYIYgD7ZzOqtSZWc1HbQ0
Message-ID: <CAJnrk1YaVSjRvbSpy-1_TtR5GSHFN2Ccx3Q271LgqHNw=yFyCg@mail.gmail.com>
Subject: Re: [PATCH v5 09/11] fuse: support large folios for readahead
To: Bernd Schubert <bernd.schubert@fastmail.fm>
Cc: "Darrick J. Wong" <djwong@kernel.org>, miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, 
	jlayton@kernel.org, jefflexu@linux.alibaba.com, josef@toxicpanda.com, 
	willy@infradead.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 5, 2025 at 8:23=E2=80=AFAM Bernd Schubert
<bernd.schubert@fastmail.fm> wrote:
>
>
>
> On 5/5/25 16:40, Darrick J. Wong wrote:
> > On Sun, May 04, 2025 at 09:13:44PM +0200, Bernd Schubert wrote:
> >>
> >>
> >> On 4/26/25 02:08, Joanne Koong wrote:
> >>> Add support for folios larger than one page size for readahead.
> >>>
> >>> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> >>> Reviewed-by: Jeff Layton <jlayton@kernel.org>
> >>> ---
> >>>  fs/fuse/file.c | 36 +++++++++++++++++++++++++++---------
> >>>  1 file changed, 27 insertions(+), 9 deletions(-)
> >>>
> >>> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> >>> index 1d38486fae50..9a31f2a516b9 100644
> >>> --- a/fs/fuse/file.c
> >>> +++ b/fs/fuse/file.c
> >>> @@ -876,14 +876,13 @@ static void fuse_readpages_end(struct fuse_moun=
t *fm, struct fuse_args *args,
> >>>     fuse_io_free(ia);
> >>>  }
> >>>
> >>> -static void fuse_send_readpages(struct fuse_io_args *ia, struct file=
 *file)
> >>> +static void fuse_send_readpages(struct fuse_io_args *ia, struct file=
 *file,
> >>> +                           unsigned int count)
> >>>  {
> >>>     struct fuse_file *ff =3D file->private_data;
> >>>     struct fuse_mount *fm =3D ff->fm;
> >>>     struct fuse_args_pages *ap =3D &ia->ap;
> >>>     loff_t pos =3D folio_pos(ap->folios[0]);
> >>> -   /* Currently, all folios in FUSE are one page */
> >>> -   size_t count =3D ap->num_folios << PAGE_SHIFT;
> >>>     ssize_t res;
> >>>     int err;
> >>>
> >>> @@ -918,6 +917,7 @@ static void fuse_readahead(struct readahead_contr=
ol *rac)
> >>>     struct inode *inode =3D rac->mapping->host;
> >>>     struct fuse_conn *fc =3D get_fuse_conn(inode);
> >>>     unsigned int max_pages, nr_pages;
> >>> +   struct folio *folio =3D NULL;
> >>>
> >>>     if (fuse_is_bad(inode))
> >>>             return;
> >>> @@ -939,8 +939,8 @@ static void fuse_readahead(struct readahead_contr=
ol *rac)
> >>>     while (nr_pages) {
> >>>             struct fuse_io_args *ia;
> >>>             struct fuse_args_pages *ap;
> >>> -           struct folio *folio;
> >>>             unsigned cur_pages =3D min(max_pages, nr_pages);
> >>> +           unsigned int pages =3D 0;
> >>>
> >>>             if (fc->num_background >=3D fc->congestion_threshold &&
> >>>                 rac->ra->async_size >=3D readahead_count(rac))
> >>> @@ -952,10 +952,12 @@ static void fuse_readahead(struct readahead_con=
trol *rac)
> >>>
> >>>             ia =3D fuse_io_alloc(NULL, cur_pages);
> >>>             if (!ia)
> >>> -                   return;
> >>> +                   break;
> >>>             ap =3D &ia->ap;
> >>>
> >>> -           while (ap->num_folios < cur_pages) {
> >>> +           while (pages < cur_pages) {
> >>> +                   unsigned int folio_pages;
> >>> +
> >>>                     /*
> >>>                      * This returns a folio with a ref held on it.
> >>>                      * The ref needs to be held until the request is
> >>> @@ -963,13 +965,29 @@ static void fuse_readahead(struct readahead_con=
trol *rac)
> >>>                      * fuse_try_move_page()) drops the ref after it's
> >>>                      * replaced in the page cache.
> >>>                      */
> >>> -                   folio =3D __readahead_folio(rac);
> >>> +                   if (!folio)
> >>> +                           folio =3D  __readahead_folio(rac);
> >>> +
> >>> +                   folio_pages =3D folio_nr_pages(folio);
> >>> +                   if (folio_pages > cur_pages - pages)
> >>> +                           break;
> >>> +
> >>
> >> Hmm, so let's assume this would be a 2MB folio, but fc->max_pages is
> >> limited to 1MB - we not do read-ahead anymore?
> >
> > It's hard for me to say without seeing the actual enablement patches,
> > but filesystems are supposed to call mapping_set_folio_order_range to
> > constrain the sizes of the folios that the pagecache requests.

Yes, exactly. For enabling fuse, I envision adding something like this
in fuse_init_file_inode():

max_pages =3D min(min(fc->max_write, fc->max_read) >> PAGE_SHIFT, fc->max_p=
ages);
max_order =3D ilog2(max_pages);
mapping_set_folio_order_range(inode->i_mapping, 0, max_order);

>
> I think large folios do not get enabled ye in this series. Could we have
> a comment here that folio size is supposed to be restricted to
> fc->max_pages? And wouldn't that be a case for unlikely()?

Large folios are not enabled yet in this series. The cover letter
explains a bit why,

"This does not yet switch fuse to using large folios. Using large folios in
fuse is dependent on adding granular dirty-page tracking. This will be done
in a separate patchset that will have fuse use iomap [1]. There also needs
to be a followup (also part of future work) for having dirty page balancing
not tank performance for unprivileged servers where bdi limits lead to subp=
ar
throttling [1], before enabling large folios for fuse."

[1] https://lore.kernel.org/linux-fsdevel/CAJnrk1a38pv3OgFZRfdTiDMXuPWuBgN8=
KY47XfOsYHj=3DN2wxAg@mail.gmail.com/#t

I'll add a comment about this in v6.

Thanks,
Joanne
>
>
> Thanks,
> Bernd

