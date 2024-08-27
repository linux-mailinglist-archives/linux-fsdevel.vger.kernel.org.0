Return-Path: <linux-fsdevel+bounces-27455-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12790961943
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 23:32:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F532B22BF0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 21:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B5261D4149;
	Tue, 27 Aug 2024 21:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FJ+Vxdy9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23478197A7E
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 Aug 2024 21:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724794263; cv=none; b=o/NK3OyWU4TimThb7rXADvfKk6I8++JA3NSwJ/EaJoVE8/DlsXPn9J7FSjbDlrxkzBEECp95iq+gwtpuNvYdysanWmRSA8fbqc5X2EdblofThL59MnA/9Oio35uf9eC0otCYHhK8HYCgsobuj6op5ldS+NjWiAUAE1p0U87tU4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724794263; c=relaxed/simple;
	bh=PT4qqBG/eAqWztL4ohiS4mw5KZPktRx4byT45TZxxf0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HBWqS6zzb2cA/y8I6Mn+SCC2GJ0j88X2baFdjB0GJCttrDrryfbhwKYALvDF+kyV67uJKRVwV0tnTkfipv+CMT7XA/XmBW+XyZSEdvXoMKUo1M1DXm+1xVrxLuk5xI3WD8JfzAt7IY3xsF7sM7ttYBQcjK2iu7jhO2RtFNFloWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FJ+Vxdy9; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4503ccbc218so784181cf.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Aug 2024 14:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724794261; x=1725399061; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7UC9q13LRBfBsODQoa37ejFbFiZLT9U8n0Ty88+QhB8=;
        b=FJ+Vxdy9RiyxTiAAFcbRTanj+nV1yTPyW1VgWjnbtAtAaONd4UVNkqbjdEMPNLCynr
         VqvEelDfIny6GqE5/vlezNDpqah1LgCzfGyJfFG9O9YjP32vy1LT10oioBi9vjWuvfZC
         UTPJ3zPHeJCAc9cR2O/Wr4bZfTB/VY6czTeGN5NLQZLomYUylBQV/gNDT7v+sne573Rp
         Zu09EebLlTjK+5eMJ6og08W2J1bhzBYE5uNk26iKla/PE6jGnrKbC7bViCWQrDU57PNO
         fZYiwv0z1ddIGRPCuyDLe+AEf9ShVNRy2hmNlR05wWFF/s3HsZkk/IdRQRAMegfmaYt/
         nxpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724794261; x=1725399061;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7UC9q13LRBfBsODQoa37ejFbFiZLT9U8n0Ty88+QhB8=;
        b=eFr1A763bwLO06HdNsE1Xds1FIUJMS6sRJ8JgujEAipZwR50YXC/+5b/xsKfBNTmbK
         V8FczvwdeAQZFzt3LbpJ9Z2J6W9buORXxMl4Gu5G8ITMZBMy2XBkVBTLS7Vnm5DSckwg
         xTCqNZvSjILdfgVeSs01LX4M1X05MRny9jd8UPEuCN1P9YYkuF6hm9slO69c3CYBrHNK
         KO+W3vfBCp1u8zUp+15k62raGxJttG3SUWe6R1R09pozlNV+ujzZPr5xkttDPETIo8A7
         Ys5CAiFelgc0GId0C1AEQkVZJiNp3tO4y3b1TweK2lKfSKJoNJU572h9ojSEcNaMRfQA
         wrRA==
X-Gm-Message-State: AOJu0YzbISkBY6f2tnWk9aW9Jttuhxd2BhNVz/0DBA5z7HBA0fXD8bqB
	4xro4oxyMybwnz6eZnNwmTebN5ZLBSUf4Th1uQ0cG6y+MnAchgCkHPStH+eHFfC1GJILZf1sX1z
	8dpyCrmXK18TR54CPYweeNCv3K24L4pJZ
X-Google-Smtp-Source: AGHT+IG4D6jKjc9mRv0nPldy/vqf8Iq7H5+Dh01OErS9SkOQIDHhcdUD54t2r2Lyah5L/93mE712T5tBJ7Ryn7LgEdY=
X-Received: by 2002:ac8:5782:0:b0:44f:ca11:3927 with SMTP id
 d75a77b69052e-4566e671ea1mr1914801cf.25.1724794260848; Tue, 27 Aug 2024
 14:31:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1724791233.git.josef@toxicpanda.com> <fb8b6509ff4f2f282048de6884f764f2eeefee12.1724791233.git.josef@toxicpanda.com>
In-Reply-To: <fb8b6509ff4f2f282048de6884f764f2eeefee12.1724791233.git.josef@toxicpanda.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 27 Aug 2024 14:30:49 -0700
Message-ID: <CAJnrk1ZKo70gkgQn0uLuy6QFYPJwhujxcZBS+GFj_X2_-kpS0g@mail.gmail.com>
Subject: Re: [PATCH 03/11] fuse: convert fuse_fill_write_pages to use folios
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-fsdevel@vger.kernel.org, amir73il@gmail.com, miklos@szeredi.hu, 
	bschubert@ddn.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 27, 2024 at 1:46=E2=80=AFPM Josef Bacik <josef@toxicpanda.com> =
wrote:
>
> Convert this to grab the folio directly, and update all the helpers to
> use the folio related functions.
>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/fuse/file.c | 28 +++++++++++++++-------------
>  1 file changed, 15 insertions(+), 13 deletions(-)
>
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index 3621dbc17167..8cd3911446b6 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -1215,7 +1215,7 @@ static ssize_t fuse_fill_write_pages(struct fuse_io=
_args *ia,
>
>         do {
>                 size_t tmp;
> -               struct page *page;
> +               struct folio *folio;
>                 pgoff_t index =3D pos >> PAGE_SHIFT;
>                 size_t bytes =3D min_t(size_t, PAGE_SIZE - offset,
>                                      iov_iter_count(ii));
> @@ -1227,25 +1227,27 @@ static ssize_t fuse_fill_write_pages(struct fuse_=
io_args *ia,
>                 if (fault_in_iov_iter_readable(ii, bytes))
>                         break;
>
> -               err =3D -ENOMEM;
> -               page =3D grab_cache_page_write_begin(mapping, index);
> -               if (!page)
> +               folio =3D __filemap_get_folio(mapping, index, FGP_WRITEBE=
GIN,
> +                                           mapping_gfp_mask(mapping));
> +               if (!IS_ERR(folio)) {

I think you meant to put IS_ERR here instead of !IS_ERR?

> +                       err =3D PTR_ERR(folio);
>                         break;
> +               }
>
>                 if (mapping_writably_mapped(mapping))
> -                       flush_dcache_page(page);
> +                       flush_dcache_folio(folio);
>
> -               tmp =3D copy_page_from_iter_atomic(page, offset, bytes, i=
i);
> -               flush_dcache_page(page);
> +               tmp =3D copy_folio_from_iter_atomic(folio, offset, bytes,=
 ii);
> +               flush_dcache_folio(folio);
>
>                 if (!tmp) {
> -                       unlock_page(page);
> -                       put_page(page);
> +                       folio_unlock(folio);
> +                       folio_put(folio);
>                         goto again;
>                 }
>
>                 err =3D 0;
> -               ap->pages[ap->num_pages] =3D page;
> +               ap->pages[ap->num_pages] =3D &folio->page;
>                 ap->descs[ap->num_pages].length =3D tmp;
>                 ap->num_pages++;
>
> @@ -1257,10 +1259,10 @@ static ssize_t fuse_fill_write_pages(struct fuse_=
io_args *ia,
>
>                 /* If we copied full page, mark it uptodate */
>                 if (tmp =3D=3D PAGE_SIZE)
> -                       SetPageUptodate(page);
> +                       folio_mark_uptodate(folio);
>
> -               if (PageUptodate(page)) {
> -                       unlock_page(page);
> +               if (folio_test_uptodate(folio)) {
> +                       folio_unlock(folio);
>                 } else {
>                         ia->write.page_locked =3D true;
>                         break;
> --
> 2.43.0
>

