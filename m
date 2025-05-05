Return-Path: <linux-fsdevel+bounces-48133-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68DF9AA9E35
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 May 2025 23:36:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94AC63A8877
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 May 2025 21:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23FD9270548;
	Mon,  5 May 2025 21:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jmTffsjh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D864C16D9C2
	for <linux-fsdevel@vger.kernel.org>; Mon,  5 May 2025 21:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746480984; cv=none; b=uLta9Knrboli3hr6vGMrSrlXzpnDJYZz1t7sCfOw6rFu0pgXItxxw9ZyPLXNvgKZDRhAMPHqXe6ZFPuf5OcVubGn503O9A+gSHqqv6DKTq/RMo+tofraXHg4hA/Lumo/n4zo/dGItXoHvu8LmJwey0lGMngeg17T3M15i4ZkVEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746480984; c=relaxed/simple;
	bh=pcde79aPM2DGzeVQ+RSPVyIkz7iVWVvx/1kkJ41F8C4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dp+fGRxNYKIory/Pxyt4a76yP8CkOHOW4BUGutA6b7zz2jHKUVtD0CcZlUtPA58fEO60PseFyijTSnanYrdXGekb99W9pPce6acHDnHz8xywFwYrIH0IadPkvqtU9zHDsGHY7+455nhk2E8OBKAVUoYXZ1BPpQgf/RbRruSkhtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jmTffsjh; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-476ae781d21so58600781cf.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 05 May 2025 14:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746480982; x=1747085782; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=45/96eBaM9ZINtW8VM6K65heSO0Rx66T0R4EDTWH+wM=;
        b=jmTffsjh/vfH3eIh+lDd/SI5vrlx2+xrtOkdwqPpFg3ARvJVnlWOtwz13QbIVG8iGU
         zZjpUT80b41WlFcTvc4g4VaDjwvom7FKIwZb01ekeylIm3MnOezFp9ZzGZV0bKtovhZZ
         KIBf18Vn0hpsRzLHJMOewkkVADFrkymRXrX0voTNDA0fgwmtvaxEBj3HFzzIamiccCdD
         4NOpHXnY2Pe73KZBVgP/a/1M59Dkn4J4ZM0ooMcVL9ftZ7jMiqZ47GstCPQpqfqtAMGk
         Ot3So6Tu3/YyZBqY4peiyt+dkM2iRJBAMlMXJ/l/QD9LSye9HbyPQfY0O8WJj4Rah12N
         fNMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746480982; x=1747085782;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=45/96eBaM9ZINtW8VM6K65heSO0Rx66T0R4EDTWH+wM=;
        b=PQ33GyxPXVK/YadK8el8k28rYStgP9676T3t0PY+zjizTTvw9eHfjzgT/gIRAZgJQ5
         qgA7OiCrLmsD2sjOggI5vXWTNAfRaXesqnx3fJUBdJxF+3vbDW2S6edz3rHXB0zgYhYV
         6TqwUtYnt/uXEXgO3uELgrHy5H3oq/PJnilStKD/EUVIDNeEGG16s5IXbsgVZYqSojRb
         BI9epoc46Gx+FTXBwEeoOpLvyG3txeF35rJ/6/W11HtZRr9lhOGY3V/F5B7B0iC9d8Ki
         Myz+d+S8X0Pw7OtZrn57QKMX96lz+PvjKxJP0OytxX4zmbQPgFXwpNSas11d/CDhek5G
         VNyg==
X-Forwarded-Encrypted: i=1; AJvYcCWA86dAHObJeYMO5sdiZnONLnjcsKI2soND5wnUkmNokHmwLHs+M8b/ezyEXrcBSAzaJnmgU++sl+egTj+z@vger.kernel.org
X-Gm-Message-State: AOJu0YyH2KUUlwJN8GYZS5JtIXLpmBi2ojPs/+HoPR83YLFymvstwMgo
	ub8KWP3fYBJIB1OcC/TvR1Gev1tDRy9289Ul6WNzMIDSQETQlkEp7zV8KugIKvvFXe4AJU6fVoG
	CmAj7d2vOSJF1g1ST3DYBzOV+11E=
X-Gm-Gg: ASbGncsY/PymrfOf40NUQZDVTjnmcEpTanXrFLeICIAJ3EJ5OOgv5nZQ5A/pcAW4ZFd
	K6h5JPPd8xRDafCdoMAklNu2lN7l8jfY7oFMwxWfOKdoIPoGih7FdPlXLG5fyTA6mCMVzZ4MTw1
	u2uR3mnQHhd+CMQ5s9ldo4iaP45U9oV35hxeURsA==
X-Google-Smtp-Source: AGHT+IEnFrvZdu8y5goGlkBZwIamtQ1K87uITB8T7t1UUdgw9e4692ZzaVDxP8RteuGvTYNbZ/XmuBFsPiWgejK9Bl4=
X-Received: by 2002:ac8:5d13:0:b0:476:9474:9b73 with SMTP id
 d75a77b69052e-490f2d817fdmr12353301cf.42.1746480981618; Mon, 05 May 2025
 14:36:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250426000828.3216220-1-joannelkoong@gmail.com>
 <20250426000828.3216220-5-joannelkoong@gmail.com> <7056a0db-106d-4a4a-8d4a-848458bd13e0@fastmail.fm>
In-Reply-To: <7056a0db-106d-4a4a-8d4a-848458bd13e0@fastmail.fm>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Mon, 5 May 2025 14:36:10 -0700
X-Gm-Features: ATxdqUFnMje4r14zYGYOsD-lTmjRnygS0RbtP4HgxeoS7wrVJUOsAShrSU9N21g
Message-ID: <CAJnrk1a-bhOGfAdO_inXgMCgHJ=irFUDxQjSCvpvzos3SJSNXQ@mail.gmail.com>
Subject: Re: [PATCH v5 04/11] fuse: support large folios for writethrough writes
To: Bernd Schubert <bernd.schubert@fastmail.fm>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, jlayton@kernel.org, 
	jefflexu@linux.alibaba.com, josef@toxicpanda.com, willy@infradead.org, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 4, 2025 at 11:40=E2=80=AFAM Bernd Schubert
<bernd.schubert@fastmail.fm> wrote:
>
>
>
> On 4/26/25 02:08, Joanne Koong wrote:
> > Add support for folios larger than one page size for writethrough
> > writes.
> >
> > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > Reviewed-by: Jeff Layton <jlayton@kernel.org>
> > ---
> >  fs/fuse/file.c | 15 ++++++++++-----
> >  1 file changed, 10 insertions(+), 5 deletions(-)
> >
> > diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> > index edc86485065e..e44b6d26c1c6 100644
> > --- a/fs/fuse/file.c
> > +++ b/fs/fuse/file.c
> > @@ -1146,7 +1146,8 @@ static ssize_t fuse_fill_write_pages(struct fuse_=
io_args *ia,
> >               size_t tmp;
> >               struct folio *folio;
> >               pgoff_t index =3D pos >> PAGE_SHIFT;
> > -             unsigned bytes =3D min(PAGE_SIZE - offset, num);
> > +             unsigned int bytes;
> > +             unsigned int folio_offset;
> >
> >   again:
> >               folio =3D __filemap_get_folio(mapping, index, FGP_WRITEBE=
GIN,
> > @@ -1159,7 +1160,10 @@ static ssize_t fuse_fill_write_pages(struct fuse=
_io_args *ia,
> >               if (mapping_writably_mapped(mapping))
> >                       flush_dcache_folio(folio);
> >
> > -             tmp =3D copy_folio_from_iter_atomic(folio, offset, bytes,=
 ii);
> > +             folio_offset =3D ((index - folio->index) << PAGE_SHIFT) +=
 offset;
> > +             bytes =3D min(folio_size(folio) - folio_offset, num);
> > +
> > +             tmp =3D copy_folio_from_iter_atomic(folio, folio_offset, =
bytes, ii);
> >               flush_dcache_folio(folio);
> >
> >               if (!tmp) {f
> > @@ -1180,6 +1184,7 @@ static ssize_t fuse_fill_write_pages(struct fuse_=
io_args *ia,
> >
> >               err =3D 0;
> >               ap->folios[ap->num_folios] =3D folio;
> > +             ap->descs[ap->num_folios].offset =3D folio_offset;
> >               ap->descs[ap->num_folios].length =3D tmp;
> >               ap->num_folios++;
> >
> > @@ -1187,11 +1192,11 @@ static ssize_t fuse_fill_write_pages(struct fus=
e_io_args *ia,
> >               pos +=3D tmp;
> >               num -=3D tmp;
> >               offset +=3D tmp;
> > -             if (offset =3D=3D PAGE_SIZE)
> > +             if (offset =3D=3D folio_size(folio))
> >                       offset =3D 0;
> >
> > -             /* If we copied full page, mark it uptodate */
> > -             if (tmp =3D=3D PAGE_SIZE)
> > +             /* If we copied full folio, mark it uptodate */
> > +             if (tmp =3D=3D folio_size(folio))
> >                       folio_mark_uptodate(folio);
>
> Here am I confused. I think tmp can be a subpart of the folio, let's say
> the folio is 2MB and somehow the again loop would iterate through the
> folio in smaller steps. So the folio would be entirely written out, but
> tmp might not be folio_size? Doesn't this need to sum up tmp for per
> folio and then use that value?  And I actually wonder if we could use
> the above "(offset =3D=3D folio_size(folio)" as well. At least if the
> initial offset for a folio is 0 it should work.
>

Hi Bernd,

Thanks for taking a look at this series and reviewing.

I don't think this scenario is possible. In copy_folio_iter_atomic()
which ends up calling into __copy_from_iter(), I don't see anywhere
where only the subpart of the folio can be copied out. The iter is a
ubuf, and from what I see, either copy_folio_iter_atomic() will return
0 or memcpy all requested bytes (unless bytes is greater than the
bytes contained in the iter, which isn't possible here) into the
folio.

Thanks,
Joanne

>
> Thanks,
> Bernd
>
> >
> >               if (folio_test_uptodate(folio)) {
>

