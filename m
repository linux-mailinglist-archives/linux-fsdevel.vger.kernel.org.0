Return-Path: <linux-fsdevel+bounces-25480-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BF4CA94C646
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2024 23:24:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1CF40B22A0F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2024 21:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3030815B0FC;
	Thu,  8 Aug 2024 21:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mXufhgop"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 273FE1552E7;
	Thu,  8 Aug 2024 21:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723152255; cv=none; b=pAkwWQQ7E56jgUi1bjtm9balOy2SGlcHJohW9wGsiT3mtRMBnxzNNjrhHtqr7/DzFnz38C5rm2sfMm1tMoJuO71v60nWHRwgMdsmUDN//niENpY8hh90u8ATSQ0pLaGpsuHiiJ5a8j9sxRwIBMumJF0VKTKMvmhII+Y1ZMIFA3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723152255; c=relaxed/simple;
	bh=3uniwC4MhHtBCUAwEWCQ/ca8MwUrYn9p/guuEWzpUCo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fjCjQZvsgwvtx2o2rsYUv6VIMSx7BpgUxouaHyIK/vDAXSiydX/37n5WLUqkNusJlf5bvhKBFgSRsvD/sCqj1Z/31Neu6IjlQVcXRIZLEgPNk9aQR4TqYSK0G+qohhxg+MmC+Om1HBW6gKxo5o29mHtTzX1r6quyrAArNCVyY+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mXufhgop; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2caff99b1c9so1222861a91.3;
        Thu, 08 Aug 2024 14:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723152253; x=1723757053; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gEQ3fDRPE5tarteAmLXwRvAJxIkK+5tTVa+taW/N4OA=;
        b=mXufhgopGe4DCvdM+kqRh1mu/qpKlJmrruaac8ODrbOCCBbGgYGukxTcthwX90xw87
         8fUkaaye7kqCSFCNIEpV3wCtkc6vvQ+Ly6/5srvALpbWX43RhWCxEc5q0K0hlA8nHV+w
         1KvjE7pVEdd+em1fZLiXsJePSCsBCdy1ToFbvg/07g4AbMOcp4+Pz84dov1XLTSqNZy6
         +oL+EifEWSD1/8wxgWGPsTDkxPVbcxJTsc3Lad2/Ei3xVw8DWUTI8loPsm6a+JXtvQOP
         df7xrKU0Dq8VZ5RRYzasahYQ0XA+5MPq5/tD3zWZpN5rFTocNr6jWK+/nt0tlZGuC4WO
         NI+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723152253; x=1723757053;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gEQ3fDRPE5tarteAmLXwRvAJxIkK+5tTVa+taW/N4OA=;
        b=lu1F/rVk5sQvWQ6OMEv39sG87J3ky9GV9VfLk2yYbwIJXgq1M9LPpBPpucakV+sfX8
         Y2hbaknoDJSf7wzI+ub2NJGXgExWHHHS7+W0bCZ6WKMqLZgrRaPPWEHf5ycDvQLfUkHh
         BrHTWCcDj0Q0gVDJEo4iDQAxwjzyN4o7lzHjDQCRx9WaRXn5NwNaRz2iznqOT3+rZujV
         j3B42o0BU6uwxobFpPkblIbgSO0o0r80BgHItOx0gFVCI+ZUCcVQqhNHUmcVE+nFmchK
         VIbO546lfWOR3oJ9EwWQpChQItfNOEJOKYHooWmtxUxhy0XkLLJTEnEjYt0T8YACkeeH
         RyQw==
X-Forwarded-Encrypted: i=1; AJvYcCXSe6QSay/PBbV1aVG0eni8PzyKYftBpgJnX73hBdsJirIlnY7+CFqeO9Lf7+asV4ZvL7uIe9r6e9tlU7WQXpLhX/l2gpJR8vTnRRT7L8vOxsc8d+EJ+kosakhM8iIqJT9YZg==
X-Gm-Message-State: AOJu0YzGVx3bjd2imFuIF+PXisM8weFFMsMAohNerPWcgUenOfBcNejE
	NlSAiJ8XHRvrr87eigEjnmyDxrzrmvhtuMVhiubHEV+oc5hQXYPqKiMDqDTlZNCpne6T9DOSP+w
	/6om/uaYBd4Mm1hCbfja+NH2IS+0=
X-Google-Smtp-Source: AGHT+IEctXxI4GtfsbdvgU18kpz1czwdQNe5VudddT1bGZDUNSoKC4wJNkZPBYg4PSmVrTNyE8PVkahfhKPmWMOZJU4=
X-Received: by 2002:a17:90a:f682:b0:2c3:2557:3de8 with SMTP id
 98e67ed59e1d1-2d1c34585d8mr3673610a91.33.1723152253191; Thu, 08 Aug 2024
 14:24:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240807234029.456316-1-andrii@kernel.org> <20240807234029.456316-7-andrii@kernel.org>
 <f3iayd76egugsgmk3evwrzn4bcko5ax2nohatgcdyxss2ilwup@pmrkbledcpc3>
 <CAEf4BzZ-EB9mV8A+pqcVj4HeZvjJummhK4XK0NHRs0C8WahK0Q@mail.gmail.com> <CAG48ez1SkqF7q+FydGcUunYMriG+rt8eWyJuSH8meaDAUJbECw@mail.gmail.com>
In-Reply-To: <CAG48ez1SkqF7q+FydGcUunYMriG+rt8eWyJuSH8meaDAUJbECw@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 8 Aug 2024 14:23:59 -0700
Message-ID: <CAEf4BzZY7asE51qDVWMuvQiocaxkMNvRKy555-S+asVksDeTKQ@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 06/10] lib/buildid: implement sleepable
 build_id_parse() API
To: Jann Horn <jannh@google.com>
Cc: Shakeel Butt <shakeel.butt@linux.dev>, Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, 
	linux-mm@kvack.org, akpm@linux-foundation.org, adobriyan@gmail.com, 
	hannes@cmpxchg.org, ak@linux.intel.com, osandov@osandov.com, song@kernel.org, 
	linux-fsdevel@vger.kernel.org, willy@infradead.org, 
	Omar Sandoval <osandov@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 8, 2024 at 1:58=E2=80=AFPM Jann Horn <jannh@google.com> wrote:
>
> On Thu, Aug 8, 2024 at 10:16=E2=80=AFPM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
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
>
> I think you have to think about it the other way around. The file is

Fair enough:

  > @file: Passed to filler function, may be NULL if not required.

But then you look at mapping_read_folio_gfp() which *always*
unconditionally passes NULL for filler and file, and that makes you
think that file is some special *extra* parameter.

But regardless, as you pointed out, I won't have to take extra ref, so
my concerns about performance are wrong. I'll pass the file.

> required, unless you know the filler function that will be used
> doesn't use the file. Which you don't know when you're coming from
> generic code, so generic code has to pass in a file.
>
> As far as I can tell, most of the callers of read_cache_folio() (via
> read_mapping_folio()) are inside filesystem implementations, not
> generic code, so they know what the filler function will do. You're
> generic code, so I think you have to pass in a file.
>

Yep, I guess this is a bit of trailblazing use case. I was confused by
some other helpers passing NULL for file unconditionally, which made
me think that NULL is a supported default use case. Clearly I was
wrong.

> > Or maybe it's a bug with the nfs_read_folio() and fuse_read_folio()
> > implementation that they can't handle NULL file argument?
> > netfs_read_folio(), for example, seems to be working with file =3D=3D N=
ULL
> > just fine.
> >
> > Matthew, can you please advise what's the right approach here? I can,
> > of course, always get file refcount, but most of the time it will be
> > just an unnecessary overhead, so ideally I'd like to avoid that. But
> > if I have to check each read_folio callback implementation to know
> > whether it's required or not, then that's not great...
>
> Why would you need to increment the file refcount? As far as I can
> tell, all your accesses to the file would happen under
> __build_id_parse(), which is borrowing the refcounted reference from
> vma->vm_file; the file can't go away as long as your caller is holding
> the mmap lock.

Yep, agreed.

