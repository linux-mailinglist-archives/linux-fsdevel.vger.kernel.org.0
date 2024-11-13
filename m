Return-Path: <linux-fsdevel+bounces-34689-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CBF59C7B6F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 19:42:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52AB31F22103
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 18:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFB08205AA7;
	Wed, 13 Nov 2024 18:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IDHWt4GY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A418E1E0B7C
	for <linux-fsdevel@vger.kernel.org>; Wed, 13 Nov 2024 18:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731523333; cv=none; b=rJnR4GcNNf7ZjscAArIkyQjJ4qMGI90bsw4D7o4K4aK26Ei3n1su9B00vztdrl8Y5GvWVHFCE8V7z9Hni0R0UDp+gWdeQDj3Gpmrfw/Poavv2kQEjSYDtjgC/GJi5pvO7A3JT10n+8cdzjSMHWya7U7vV2jF3FrQoUho/4B6ubU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731523333; c=relaxed/simple;
	bh=bALj6RItpp2XFxtyeUZQWjBnjWR++G6zwAZg5p4hhPg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dCXNNjnhNd+m7KhB+Y7ojBDj6GxjC3AXAUOsagjsDxS89SymKvlk8cjxJ41Qndz2QRT+6STurb932ttDXkiPmbp/0pM4BBLL/bQn8HKV1E752dYUiA8TvlC8m4WGoCz8wGKfEuYzI0x0t4c/yvmT+41oGWTOu8K1dFGBeBjSYMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IDHWt4GY; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-5ee8eaa1694so1062883eaf.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Nov 2024 10:42:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731523331; x=1732128131; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ceJTSlWuM/JNUYkltl6vujvEJQAqWWiXDvrQdMIwTew=;
        b=IDHWt4GYuoqsfOCbjPPz9ReKT30QFVPrl15XVtlrDWiaS/+ObSIRflnjMJuN6ODgTt
         VxliHj+pCGAMHPbz3Gfksb7VTPVtihaZ1D5H0SwzkgkR/gBt8zNCtce62uM8v/av4mdm
         VM6eeXs85JC3l5VhwetCUC8FN264qIq/8AwUIg7YKJkX02sSdwT1Xxvx+ugBBgQSCzMO
         JiaBFEsnExZxa8tC0wFqm7g/Jy5oNEWsKN/W1/J4p4GFSboIVOOVVBtTvAV+m7M7Qt91
         m78MTrLmY3mTOMAQvDDo25/8smxbTMqO2C6pCMhMLXev+mX4EM6qIR+QcwbLOiUdUMyf
         df5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731523331; x=1732128131;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ceJTSlWuM/JNUYkltl6vujvEJQAqWWiXDvrQdMIwTew=;
        b=rrG7peUTmgUH3K35pqG3Q0Mj9TVDL7qJq6DqiCRNWIH1dObEmkCtIHUMBhMYIg+GYp
         /ORi3Sk72IKfJ6VyJhPfeCEnfLngdpZ4SXxD0r6xYMYBemRso27cTbe4Y7ILXJlZloMS
         fIJ1XzkuPWprF8aHNzO4EwzwKynAUz/ZNo86iLQlk/RLczqiV4ExCZlHrQbpvRMU5o19
         FPdTXsEKxDR4hwVphG3uuVwVGRdtFJy4CzuU4UZ7zJ80tZx71fk6913VFMOZ6VCOEKQA
         x1GseF4fPBmMk4oPx7sSoYfGeuN8tRV8+P/OPTz18gPIkSAboaLKOla9Q1IxNC4eMbIB
         Lufg==
X-Forwarded-Encrypted: i=1; AJvYcCUPdYWpz7VukQKbLN4gCWIr85d8G5A/nzXsvz+ALRyQQWwfoEEjjWBMec/Fngm9powAe3pBmergt9kLOM8Z@vger.kernel.org
X-Gm-Message-State: AOJu0YwwOMop/LbUwP8XT5YccY/mPUsj0T+PJWDNGTEm87yS9ZzjSEcZ
	89CHeKHIloCbGKQOugdjgNt0cJx6YvPygGnF84Qioh7TWikSGPiZJvQOWXlbegnnt9c7gmWoBLV
	CftpUAh6WQ8XC1zdl3YLHCR2lxUI=
X-Google-Smtp-Source: AGHT+IE/IKVk4fhIILoFqgkiaOz9gKT/gyxcf4qZAImj5hg+XCGHe+CY1fgBpis13IUE6WGtJFcOwwR/du9uIG9jSBo=
X-Received: by 2002:a05:6359:4195:b0:1c6:3661:e010 with SMTP id
 e5c5f4694b2df-1c66f23584dmr518107155d.19.1731523330679; Wed, 13 Nov 2024
 10:42:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241109001258.2216604-1-joannelkoong@gmail.com>
 <20241109001258.2216604-5-joannelkoong@gmail.com> <CAJnrk1Zx6TpXgKfKX=uio-GpN9CDL4GxdnmLcjkWHyHfWsTxqg@mail.gmail.com>
In-Reply-To: <CAJnrk1Zx6TpXgKfKX=uio-GpN9CDL4GxdnmLcjkWHyHfWsTxqg@mail.gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 13 Nov 2024 10:41:59 -0800
Message-ID: <CAJnrk1aPVwNmv2uxYLwtdwGqe=QUROUXmZc8BiLAV=uqrnCrrw@mail.gmail.com>
Subject: Re: [PATCH 04/12] fuse: support large folios for non-writeback writes
To: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org
Cc: josef@toxicpanda.com, bernd.schubert@fastmail.fm, 
	jefflexu@linux.alibaba.com, willy@infradead.org, shakeel.butt@linux.dev, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 12, 2024 at 9:32=E2=80=AFAM Joanne Koong <joannelkoong@gmail.co=
m> wrote:
>
> On Fri, Nov 8, 2024 at 4:13=E2=80=AFPM Joanne Koong <joannelkoong@gmail.c=
om> wrote:
> >
> > Add support for folios larger than one page size for non-writeback
>
> I'll change this naming from "non-writeback" to "writethrough"
>
> > writes.
> >
> > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > ---
> >  fs/fuse/file.c | 29 ++++++++++++++++++-----------
> >  1 file changed, 18 insertions(+), 11 deletions(-)
> >
> > diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> > index a89fdc55a40b..6ee23ab9b7f2 100644
> > --- a/fs/fuse/file.c
> > +++ b/fs/fuse/file.c
> > @@ -1146,19 +1146,15 @@ static ssize_t fuse_fill_write_pages(struct fus=
e_io_args *ia,
> >         num =3D min(num, max_pages << PAGE_SHIFT);
> >
> >         ap->args.in_pages =3D true;
> > -       ap->descs[0].offset =3D offset;
> >
> >         while (num) {
> >                 size_t tmp;
> >                 struct folio *folio;
> >                 pgoff_t index =3D pos >> PAGE_SHIFT;
> > -               unsigned int bytes =3D min(PAGE_SIZE - offset, num);
> > -
> > - again:
> > -               err =3D -EFAULT;
> > -               if (fault_in_iov_iter_readable(ii, bytes))
> > -                       break;
> > +               unsigned int bytes;
> > +               unsigned int folio_offset;
> >
> > +       again:
> >                 folio =3D __filemap_get_folio(mapping, index, FGP_WRITE=
BEGIN,
> >                                             mapping_gfp_mask(mapping));
>
> This __filemap_get_folio() call (and the one in fuse_write_begin() as
> well) needs to also set the order on the fgf flag to enable large
> folios, else all folios returned will be order 0.
>
> I'll fix this in v2.

Ran some benchmarks and trying to get the largest folios possible from
__filemap_get_folio() is an over-optimization and slows down writes
significantly. I'll leave this as is for v2, and we could look into
optimizing this in the future.

>
> >                 if (IS_ERR(folio)) {
> > @@ -1166,10 +1162,20 @@ static ssize_t fuse_fill_write_pages(struct fus=
e_io_args *ia,
> >                         break;
> >                 }
> >
> > +               folio_offset =3D ((index - folio->index) << PAGE_SHIFT)=
 + offset;
> > +               bytes =3D min(folio_size(folio) - folio_offset, num);
> > +
> > +               err =3D -EFAULT;
> > +               if (fault_in_iov_iter_readable(ii, bytes)) {
> > +                       folio_unlock(folio);
> > +                       folio_put(folio);
> > +                       break;
> > +               }
> > +
> >                 if (mapping_writably_mapped(mapping))
> >                         flush_dcache_folio(folio);
> >
> > -               tmp =3D copy_folio_from_iter_atomic(folio, offset, byte=
s, ii);
> > +               tmp =3D copy_folio_from_iter_atomic(folio, folio_offset=
, bytes, ii);
> >                 flush_dcache_folio(folio);
> >
> >                 if (!tmp) {
> > @@ -1180,6 +1186,7 @@ static ssize_t fuse_fill_write_pages(struct fuse_=
io_args *ia,
> >
> >                 err =3D 0;
> >                 ap->folios[ap->num_folios] =3D folio;
> > +               ap->descs[ap->num_folios].offset =3D folio_offset;
> >                 ap->descs[ap->num_folios].length =3D tmp;
> >                 ap->num_folios++;
> >
> > @@ -1187,11 +1194,11 @@ static ssize_t fuse_fill_write_pages(struct fus=
e_io_args *ia,
> >                 pos +=3D tmp;
> >                 num -=3D tmp;
> >                 offset +=3D tmp;
> > -               if (offset =3D=3D PAGE_SIZE)
> > +               if (offset =3D=3D folio_size(folio))
> >                         offset =3D 0;
> >
> > -               /* If we copied full page, mark it uptodate */
> > -               if (tmp =3D=3D PAGE_SIZE)
> > +               /* If we copied full folio, mark it uptodate */
> > +               if (tmp =3D=3D folio_size(folio))
> >                         folio_mark_uptodate(folio);
> >
> >                 if (folio_test_uptodate(folio)) {
> > --
> > 2.43.5
> >

