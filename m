Return-Path: <linux-fsdevel+bounces-53743-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77BC3AF6629
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jul 2025 01:20:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB8531C42B7E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 23:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 149A02566DD;
	Wed,  2 Jul 2025 23:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bRAlTf1d"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C716C238150;
	Wed,  2 Jul 2025 23:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751498425; cv=none; b=j0OLCT8/0Bd/96c5jcV3Q8YoFS+2VuL3jUK4wmeDD7DX69hqb0OiQXfybnAmRfhrHOlTDpzzoyxSdDE4mb4dZ9hqrkGO/veC3QHIncrsGC9vzNjV0WczZWOIcBYBYRZtL9ZDEP/LBrhDPocc0IEDPaQNf2dxYSlyIVNFxKZltpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751498425; c=relaxed/simple;
	bh=blCkfpz21rn1nv9mgJ/oPvUVXFZla3hl/MNsev/a4Gw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kvtnDnqt5EkQxKm52Es/3E50jJz3eE/Ipd/z8ewEq7FINZ1toGspAGhbdO6ShcuSc3bQYiVeyI4rhQoQKDfP6wliVvN1pKoz8ANq8+vXxbp7L3t46beKVuv79H5BJlXfM3DM3F9PD0ssvMb2b+lxcBu0XfhVVu3m4sTrnDh01L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bRAlTf1d; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4a7a8c2b7b9so74607291cf.1;
        Wed, 02 Jul 2025 16:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751498423; x=1752103223; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zRo94/lWqiwbS1Rl5pxqVdA19w+jpv0tMe/8YRHBmYg=;
        b=bRAlTf1dpsSHIjZpvRZE6SSfYL89fCi6Gy/gWlmoM7/easYngMnn6BeeGt++qo9+j/
         hYlOimNN8GhU4bG8WMS90KQZ6stLsqL+FnqqUs/+7lno9PLSaesWeqKOt4of8zA6QfPo
         O5qsXQ151SC9HJUEzSvqCWbbuL0Z4thknjEPlfqtYHLUfPQWPuCikeUJ0Tum7nyJhKQ1
         ZiY6/KqufwyOmJQZTvwsxuRa7fUfDBQysclTRsUXKhkQMJn1hpW7I2YIhGd3EqlIw6/R
         3EQx5KEpXobQtIBEQ5hur1oMpV4K3W1+KCUtvWO9xzjhsiUppjEOYL+w9CP9k4reiYk8
         8TLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751498423; x=1752103223;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zRo94/lWqiwbS1Rl5pxqVdA19w+jpv0tMe/8YRHBmYg=;
        b=smIM6p4n47eBcCQfsAUuRoC7GdjIdi8K0qhX4k2QkOVJRmGOl7HMQrBpYbtgEAINxz
         Gy5iFPXWoZOnujzQddOg1GL2gUjRTOqgqLD5hOYgrUPCXAobORZfu5xwv55xeBE6TlQm
         deyUh0Fc/EP/iwXj6+hLgFoYo3GJI8g50eOg7NxjLWB78yR8q2JWO8cVVfZNnoBrYhtR
         Ee3S3hvSZRBrupll3jMM7iSH+KD7oRSSI8vk1XIYnUql6aKDTWlOO6Mz3eIVJEzuC+Ww
         YofCFMN7VTcew9YpJXtPcIlq+ucEZCzqxwRODOeWaUINIBX3k3ZGbI69mTr6HDBbKTfx
         AdsQ==
X-Forwarded-Encrypted: i=1; AJvYcCUokt1xJKp5XZnyZ+78/jxMauwAVp7+yYdw62ai70pD0rmVZ7lt7lec22+LB/6Gk3pTYn8UBGGBxUm/Lg==@vger.kernel.org, AJvYcCVJxdX9KkQxD4x/YQJZq7gztsvVXppDBjdzdCp4vUOVIevb+5s9ZJtPWZSZvoP1beER3e7Y7jW/Lis9@vger.kernel.org, AJvYcCWZbC28ZArO1T0nFEOGFF98uTz+xZO+9gDesWzWo8K2Oc+OhcWcaLhmQgb0imjPImLEAHjcazXwgimD@vger.kernel.org
X-Gm-Message-State: AOJu0YyHpxbxW32Ig8wagYwIMRuIuiluuG2A2zRumHEx4nmTBFPemLLw
	9nizXE2rFpt84HhbOBv11yTRp/yBRZEEkAXWAVa2E/iUZGRE3o3A7FcVoLezovbzx3UEt6fOUSH
	COZBE+YXhPI54mwewG5QM/eaaQC7yxdE=
X-Gm-Gg: ASbGncs589+ktyq7h4x1F9u6tFd3QUHRSWLvqXijpiLOoULKasu5ohGsX4R9kNDBtWz
	IeL2czMJBCOQVPznMykXAbHwQV5+KEDb4cu7lfsQX7CiJ/ar1HVxdV5IKtX5eXBL+PbzQd549D8
	PFHQjTIAW/7nTIMXk5i9Dx9IvOsnuhISIbTtXZoaSJEms7eEl4S6IIio76StQ=
X-Google-Smtp-Source: AGHT+IG9s4tMDn5+3npL/jz5mUHQ8KIgvpktx7fqFXcoH4WVcqnLgRMMx//WSoYNhumBoQZLuaZJvAAWFENRUKnlPLs=
X-Received: by 2002:ac8:7f89:0:b0:4a8:eb1:9b7 with SMTP id d75a77b69052e-4a9769f4383mr79493981cf.49.1751498422475;
 Wed, 02 Jul 2025 16:20:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250624022135.832899-1-joannelkoong@gmail.com>
 <20250624022135.832899-14-joannelkoong@gmail.com> <20250702181324.GH10009@frogsfrogsfrogs>
In-Reply-To: <20250702181324.GH10009@frogsfrogsfrogs>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 2 Jul 2025 16:20:11 -0700
X-Gm-Features: Ac12FXyBoj6U4xrAWUwxsCBkfqXVQVy6soHuMPeiWNU01YCndBaQj6kmRs9zfcA
Message-ID: <CAJnrk1Z8ycJpyj3RuWvb-snKM6JxUQL5-RAhaHdVm+wz3u1+7w@mail.gmail.com>
Subject: Re: [PATCH v3 13/16] fuse: use iomap for writeback
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, hch@lst.de, miklos@szeredi.hu, 
	brauner@kernel.org, anuj20.g@samsung.com, linux-xfs@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-block@vger.kernel.org, gfs2@lists.linux.dev, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 2, 2025 at 11:13=E2=80=AFAM Darrick J. Wong <djwong@kernel.org>=
 wrote:
>
> On Mon, Jun 23, 2025 at 07:21:32PM -0700, Joanne Koong wrote:
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
> >  fs/fuse/file.c | 124 ++++++++++++++++++++++++++++++-------------------
> >  1 file changed, 75 insertions(+), 49 deletions(-)
> >
> > diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> > index a7f11c1a4f89..2b4b950eaeed 100644
> > --- a/fs/fuse/file.c
> > +++ b/fs/fuse/file.c
> > @@ -1837,7 +1837,7 @@ static void fuse_writepage_finish(struct fuse_wri=
tepage_args *wpa)
> >                * scope of the fi->lock alleviates xarray lock
> >                * contention and noticeably improves performance.
> >                */
> > -             folio_end_writeback(ap->folios[i]);
> > +             iomap_finish_folio_write(inode, ap->folios[i], 1);
> >               dec_wb_stat(&bdi->wb, WB_WRITEBACK);
> >               wb_writeout_inc(&bdi->wb);
> >       }
> > @@ -2024,19 +2024,20 @@ static void fuse_writepage_add_to_bucket(struct=
 fuse_conn *fc,
> >  }
> >
> >  static void fuse_writepage_args_page_fill(struct fuse_writepage_args *=
wpa, struct folio *folio,
> > -                                       uint32_t folio_index)
> > +                                       uint32_t folio_index, loff_t of=
fset, unsigned len)
> >  {
> >       struct inode *inode =3D folio->mapping->host;
> >       struct fuse_args_pages *ap =3D &wpa->ia.ap;
> >
> >       ap->folios[folio_index] =3D folio;
> > -     ap->descs[folio_index].offset =3D 0;
> > -     ap->descs[folio_index].length =3D folio_size(folio);
> > +     ap->descs[folio_index].offset =3D offset;
> > +     ap->descs[folio_index].length =3D len;
> >
> >       inc_wb_stat(&inode_to_bdi(inode)->wb, WB_WRITEBACK);
> >  }
> >
> >  static struct fuse_writepage_args *fuse_writepage_args_setup(struct fo=
lio *folio,
> > +                                                          size_t offse=
t,
> >                                                            struct fuse_=
file *ff)
> >  {
> >       struct inode *inode =3D folio->mapping->host;
> > @@ -2049,7 +2050,7 @@ static struct fuse_writepage_args *fuse_writepage=
_args_setup(struct folio *folio
> >               return NULL;
> >
> >       fuse_writepage_add_to_bucket(fc, wpa);
> > -     fuse_write_args_fill(&wpa->ia, ff, folio_pos(folio), 0);
> > +     fuse_write_args_fill(&wpa->ia, ff, folio_pos(folio) + offset, 0);
> >       wpa->ia.write.in.write_flags |=3D FUSE_WRITE_CACHE;
> >       wpa->inode =3D inode;
> >       wpa->ia.ff =3D ff;
> > @@ -2075,7 +2076,7 @@ static int fuse_writepage_locked(struct folio *fo=
lio)
> >       if (!ff)
> >               goto err;
> >
> > -     wpa =3D fuse_writepage_args_setup(folio, ff);
> > +     wpa =3D fuse_writepage_args_setup(folio, 0, ff);
> >       error =3D -ENOMEM;
> >       if (!wpa)
> >               goto err_writepage_args;
> > @@ -2084,7 +2085,7 @@ static int fuse_writepage_locked(struct folio *fo=
lio)
> >       ap->num_folios =3D 1;
> >
> >       folio_start_writeback(folio);
> > -     fuse_writepage_args_page_fill(wpa, folio, 0);
> > +     fuse_writepage_args_page_fill(wpa, folio, 0, 0, folio_size(folio)=
);
> >
> >       spin_lock(&fi->lock);
> >       list_add_tail(&wpa->queue_entry, &fi->queued_writes);
> > @@ -2105,7 +2106,7 @@ struct fuse_fill_wb_data {
> >       struct fuse_file *ff;
> >       struct inode *inode;
> >       unsigned int max_folios;
> > -     unsigned int nr_pages;
> > +     unsigned int nr_bytes;
> >  };
> >
> >  static bool fuse_pages_realloc(struct fuse_fill_wb_data *data)
> > @@ -2147,21 +2148,28 @@ static void fuse_writepages_send(struct fuse_fi=
ll_wb_data *data)
> >  }
> >
> >  static bool fuse_writepage_need_send(struct fuse_conn *fc, struct foli=
o *folio,
> > +                                  loff_t offset, unsigned len,
> >                                    struct fuse_args_pages *ap,
> >                                    struct fuse_fill_wb_data *data)
> >  {
> > +     struct folio *prev_folio;
> > +     struct fuse_folio_desc prev_desc;
> > +
> >       WARN_ON(!ap->num_folios);
> >
> >       /* Reached max pages */
> > -     if (data->nr_pages + folio_nr_pages(folio) > fc->max_pages)
> > +     if ((data->nr_bytes + len) / PAGE_SIZE > fc->max_pages)
> >               return true;
> >
> >       /* Reached max write bytes */
> > -     if ((data->nr_pages * PAGE_SIZE) + folio_size(folio) > fc->max_wr=
ite)
> > +     if (data->nr_bytes + len > fc->max_write)
> >               return true;
> >
> >       /* Discontinuity */
> > -     if (folio_next_index(ap->folios[ap->num_folios - 1]) !=3D folio->=
index)
> > +     prev_folio =3D ap->folios[ap->num_folios - 1];
> > +     prev_desc =3D ap->descs[ap->num_folios - 1];
> > +     if ((folio_pos(prev_folio) + prev_desc.offset + prev_desc.length)=
 !=3D
> > +         folio_pos(folio) + offset)
> >               return true;
> >
> >       /* Need to grow the pages array?  If so, did the expansion fail? =
*/
> > @@ -2171,85 +2179,103 @@ static bool fuse_writepage_need_send(struct fu=
se_conn *fc, struct folio *folio,
> >       return false;
> >  }
> >
> > -static int fuse_writepages_fill(struct folio *folio,
> > -             struct writeback_control *wbc, void *_data)
> > +static ssize_t fuse_iomap_writeback_range(struct iomap_writepage_ctx *=
wpc,
> > +                                       struct folio *folio, u64 pos,
> > +                                       unsigned len, u64 end_pos)
> >  {
> > -     struct fuse_fill_wb_data *data =3D _data;
> > +     struct fuse_fill_wb_data *data =3D wpc->wb_ctx;
> >       struct fuse_writepage_args *wpa =3D data->wpa;
> >       struct fuse_args_pages *ap =3D &wpa->ia.ap;
> >       struct inode *inode =3D data->inode;
> >       struct fuse_inode *fi =3D get_fuse_inode(inode);
> >       struct fuse_conn *fc =3D get_fuse_conn(inode);
> > -     int err;
> > +     loff_t offset =3D offset_in_folio(folio, pos);
> > +
> > +     WARN_ON_ONCE(!data);
> > +     /* len will always be page aligned */
> > +     WARN_ON_ONCE(len & (PAGE_SIZE - 1));
> >
> >       if (!data->ff) {
> > -             err =3D -EIO;
> >               data->ff =3D fuse_write_file_get(fi);
> >               if (!data->ff)
> > -                     goto out_unlock;
> > +                     return -EIO;
> >       }
> >
> > -     if (wpa && fuse_writepage_need_send(fc, folio, ap, data)) {
> > +     iomap_start_folio_write(inode, folio, 1);
> > +
> > +     if (wpa && fuse_writepage_need_send(fc, folio, offset, len, ap, d=
ata)) {
> >               fuse_writepages_send(data);
> >               data->wpa =3D NULL;
> > -             data->nr_pages =3D 0;
> > +             data->nr_bytes =3D 0;
> >       }
> >
> >       if (data->wpa =3D=3D NULL) {
> > -             err =3D -ENOMEM;
> > -             wpa =3D fuse_writepage_args_setup(folio, data->ff);
> > +             wpa =3D fuse_writepage_args_setup(folio, offset, data->ff=
);
> >               if (!wpa)
> > -                     goto out_unlock;
> > +                     return -ENOMEM;
>
> If we error out here, what subtracts from write_bytes_pending the
> quantity that we just added in iomap_start_folio_write?
>
> (It would have helped a lot if the cover letter had linked to a git
> branch so I could go look at the final product for myself...)
>

Ugh you're right, this needs to be accounted for in the error cases.
I'll fix this in v4. Thanks for spotting this. I'll make a git branch
and include a link to it in v4 as well.

> --D
>

