Return-Path: <linux-fsdevel+bounces-25479-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C174F94C641
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2024 23:21:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D8631F23632
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2024 21:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4086B15AADA;
	Thu,  8 Aug 2024 21:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bwyETodD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE70B1D554;
	Thu,  8 Aug 2024 21:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723152100; cv=none; b=LqPHLC/YfjsxO2XBBxkj48Pmn7Sbd7qIUQm62pxinhbjrT3n8aqwXMOk4wOk+kpPD0Neuks/OKGe1+0OC8MNx9Oh8tp0FEpXFwUfpMQR/cidI10yw9GMhrklvJqIeHmpg1WPFdz41SuaSgTcRws9flzdTIx7yGrdpCZxpau2xFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723152100; c=relaxed/simple;
	bh=xVcXK04BFaT6p7GMcHRJi858rYapC+3Nsqq3QXDLIg8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K12fZmoCJDPD8pftutyLaZJgglOX0WymnjqGik3Au8N/VmplQ3JEaEDQwb3P6K2D/C6BSyYju4/emiVu/pRR4n3vu1VthYcI8MMe2ir0e6HTUvcEPTdKle94jHp7oexAFoMjet6nNJ9hKY61iGIzxCll04bYKmb4PjCdfh5yToY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bwyETodD; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a7a81bd549eso126529466b.3;
        Thu, 08 Aug 2024 14:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723152097; x=1723756897; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0JclHXfYDnbuGnbRE8EV1RltyDub11sOgtZzsv2IjQE=;
        b=bwyETodDSRdIhqrsuPFLdMIrqRd+AkQwM81D9vILyAq6qfKnXBPEJZ5zJN4yhbOJ4K
         eZMaBQcFbGcutA9s8uSBcsLeIm1FXIPuwS7xQVCNY6FHfx2ofNkEo+nCyN32X/9K1WPx
         daW2tH2EigLWY03ntBhcK9mfIv4U4vDcQhOzK5CLmZbDa0v4+hPeIVjFyt1/75xS6L+i
         /8FP02zTfnmoUXs6TRh8bYm8fmJWhcsO5Mkk5TaNVrhThR80vexU5oSojWuZ2OPDBr4D
         U7FVx+ZDpwpIfyngQ7MFSUMFdSJvBbvqWKSIe3bofhZJhP8YJQ2FIyOAAwZXtZtmmgb6
         6c2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723152097; x=1723756897;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0JclHXfYDnbuGnbRE8EV1RltyDub11sOgtZzsv2IjQE=;
        b=oorU6OOOD6b3EwhcvnItFjsEhYQ/FV4++L6NpesVOPl6plvsJtZtTjDrPPBA/9oTNb
         hGLRzMzY/Q+RpXK4M45fZiU36lbwS0JARadRgyT85IDtNcY4aCIEp7sl6D1e+2GhUL7y
         VOMa+4MWzXtYMvHNMUSdXlPs/UAiQ2u5exlS/UdxwLwyEynScLP3FfTeCl0yiXuYaMjp
         SmDFeGbtCoAvJZmo5U+q8cBVOk8X2MByZ78ArVEy4rHGPkqZ/RJPqv2xETdovbittADs
         a2X7pZ4i3D8IOeZPE88uxqnZdpzX0lVYoB1dgta6c1tpO/gWtIiS//irCYWuxICY6DVq
         9cxg==
X-Forwarded-Encrypted: i=1; AJvYcCXKcMkx7kJsMAv8PjIAeq7GMn+Ehq4QxuJ9Psio2SKG/NRAokBgPxADpk2WSST5joTFB93uOCYD53w8cZ7Pd8v+I833ZS7CmtNymZBwyhy5Pn+mDWzecx/c2ENoTDrxKrCu9A==
X-Gm-Message-State: AOJu0Yx0Ur3FmjdSRYInLENTTFgYdwp6hJFaEdKiR3TZOE0dvayqmnBO
	AWiRVlDVlRUO9/F/7AdUfzJ1yhD1+gmlUiYPnGChLO+kiS6SAElMJBTPT8oxum8puXGv6LZQEO7
	Od5Se2+n5x3lVxpKLt3x6j9J6ZqU=
X-Google-Smtp-Source: AGHT+IHAfWZuVZQYtiKRzjjCbfmEdzWeFZyhDDivJYrgxVAj7xBmUcYdzvDc6aLLE5erDZ3wIrvXL6Etc+8R/4JeF4o=
X-Received: by 2002:a17:906:f59c:b0:a6f:59dc:4ece with SMTP id
 a640c23a62f3a-a8090c25982mr183186266b.2.1723152096588; Thu, 08 Aug 2024
 14:21:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240807234029.456316-1-andrii@kernel.org> <20240807234029.456316-7-andrii@kernel.org>
 <f3iayd76egugsgmk3evwrzn4bcko5ax2nohatgcdyxss2ilwup@pmrkbledcpc3>
 <CAEf4BzZ-EB9mV8A+pqcVj4HeZvjJummhK4XK0NHRs0C8WahK0Q@mail.gmail.com> <tmty3p7rduxdcixm2yprinndgabwzkdbvt6h2ksn6ezbc3hbaa@ta7t5r6btwsu>
In-Reply-To: <tmty3p7rduxdcixm2yprinndgabwzkdbvt6h2ksn6ezbc3hbaa@ta7t5r6btwsu>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 8 Aug 2024 14:21:20 -0700
Message-ID: <CAEf4BzYnstVCNyk_wCox_Usg7KA93JF03YsNTSbTw_j6E+9gow@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 06/10] lib/buildid: implement sleepable
 build_id_parse() API
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, linux-mm@kvack.org, 
	akpm@linux-foundation.org, adobriyan@gmail.com, hannes@cmpxchg.org, 
	ak@linux.intel.com, osandov@osandov.com, song@kernel.org, jannh@google.com, 
	linux-fsdevel@vger.kernel.org, willy@infradead.org, 
	Omar Sandoval <osandov@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 8, 2024 at 2:02=E2=80=AFPM Shakeel Butt <shakeel.butt@linux.dev=
> wrote:
>
> On Thu, Aug 08, 2024 at 01:15:52PM GMT, Andrii Nakryiko wrote:
> > On Thu, Aug 8, 2024 at 11:40=E2=80=AFAM Shakeel Butt <shakeel.butt@linu=
x.dev> wrote:
> > >
> > > On Wed, Aug 07, 2024 at 04:40:25PM GMT, Andrii Nakryiko wrote:
> > > > Extend freader with a flag specifying whether it's OK to cause page
> > > > fault to fetch file data that is not already physically present in
> > > > memory. With this, it's now easy to wait for data if the caller is
> > > > running in sleepable (faultable) context.
> > > >
> > > > We utilize read_cache_folio() to bring the desired folio into page
> > > > cache, after which the rest of the logic works just the same at fol=
io level.
> > > >
> > > > Suggested-by: Omar Sandoval <osandov@fb.com>
> > > > Cc: Shakeel Butt <shakeel.butt@linux.dev>
> > > > Cc: Johannes Weiner <hannes@cmpxchg.org>
> > > > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > > > ---
> > > >  lib/buildid.c | 44 ++++++++++++++++++++++++++++----------------
> > > >  1 file changed, 28 insertions(+), 16 deletions(-)
> > > >
> > > > diff --git a/lib/buildid.c b/lib/buildid.c
> > > > index 5e6f842f56f0..e1c01b23efd8 100644
> > > > --- a/lib/buildid.c
> > > > +++ b/lib/buildid.c
> > > > @@ -20,6 +20,7 @@ struct freader {
> > > >                       struct folio *folio;
> > > >                       void *addr;
> > > >                       loff_t folio_off;
> > > > +                     bool may_fault;
> > > >               };
> > > >               struct {
> > > >                       const char *data;
> > > > @@ -29,12 +30,13 @@ struct freader {
> > > >  };
> > > >
> > > >  static void freader_init_from_file(struct freader *r, void *buf, u=
32 buf_sz,
> > > > -                                struct address_space *mapping)
> > > > +                                struct address_space *mapping, boo=
l may_fault)
> > > >  {
> > > >       memset(r, 0, sizeof(*r));
> > > >       r->buf =3D buf;
> > > >       r->buf_sz =3D buf_sz;
> > > >       r->mapping =3D mapping;
> > > > +     r->may_fault =3D may_fault;
> > > >  }
> > > >
> > > >  static void freader_init_from_mem(struct freader *r, const char *d=
ata, u64 data_sz)
> > > > @@ -63,6 +65,11 @@ static int freader_get_folio(struct freader *r, =
loff_t file_off)
> > > >       freader_put_folio(r);
> > > >
> > > >       r->folio =3D filemap_get_folio(r->mapping, file_off >> PAGE_S=
HIFT);
> > > > +
> > > > +     /* if sleeping is allowed, wait for the page, if necessary */
> > > > +     if (r->may_fault && (IS_ERR(r->folio) || !folio_test_uptodate=
(r->folio)))
> > > > +             r->folio =3D read_cache_folio(r->mapping, file_off >>=
 PAGE_SHIFT, NULL, NULL);
> > >
> > > Willy's network fs comment is bugging me. If we pass NULL for filler,
> > > the kernel will going to use fs's read_folio() callback. I have check=
ed
> > > read_folio() for fuse and nfs and it seems like for at least these tw=
o
> > > filesystems the callback is accessing file->private_data. So, if the =
elf
> > > file is on these filesystems, we might see null accesses.
> > >
> >
> > Isn't that just a huge problem with the read_cache_folio() interface
> > then? That file is optional, in general, but for some specific FS
> > types it's not. How generic code is supposed to know this?
> >
> > Or maybe it's a bug with the nfs_read_folio() and fuse_read_folio()
> > implementation that they can't handle NULL file argument?
> > netfs_read_folio(), for example, seems to be working with file =3D=3D N=
ULL
> > just fine.
>
> If you go a bit down in netfs_alloc_request() there is the following
> code:
>
>         if (rreq->netfs_ops->init_request) {
>                 ret =3D rreq->netfs_ops->init_request(rreq, file);
>                 ...
>         ...
>
> I think this init_request is pointing to nfs_netfs_init_request which
> calls nfs_file_open_context(file) and access filp->private_data.

That's "nfs", which we know requires a file. For netfs implementations
(cifs_init_request() and v9fs_init_request()), they both treat file as
optional consistently.

But regardless, that's just pointless code archeology, I'll just pass
the file reference unconditionally.

>
> >
> > Matthew, can you please advise what's the right approach here? I can,
> > of course, always get file refcount, but most of the time it will be
> > just an unnecessary overhead, so ideally I'd like to avoid that. But
> > if I have to check each read_folio callback implementation to know
> > whether it's required or not, then that's not great...
>
> I don't think we will need file refcnt. We have mmap lock in read mode
> in this context because we are accessing vma and this vma has reference
> to the file. So, this file can not go away under us here.

Yep, good point, then it's not a problem, thanks! Will update.

