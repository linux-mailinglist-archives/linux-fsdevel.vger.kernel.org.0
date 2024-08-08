Return-Path: <linux-fsdevel+bounces-25470-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C5B494C58C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2024 22:16:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE26A1C218BC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2024 20:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AC04156649;
	Thu,  8 Aug 2024 20:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QNjLZ+iw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A62BE40;
	Thu,  8 Aug 2024 20:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723148171; cv=none; b=fIGe0/abZ4HJHhQ5e+60DwXF4NS2sSxtmmt+FOjUaMvwjDkJpZiCse+wrygg6JusNU0ScUNpGW3rzUMb5wwcywOBG9I6QS6nevnA86g5wpR9rqNJF5ZlEH6THdccPMoTI202zDxJGwk2aVUbIBGasxt6g1aC4HKZeqsLsggDVJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723148171; c=relaxed/simple;
	bh=1VATYZR/Sx6XzuRI+vz5kOPW/GseT44vsEYuTyqp7A4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SpWNQ19EtirUHuqH0YNxbREgBPUsfXAmaIkBbJzFV7ShlYORw5dHVCQexzGRzs3P6VKJIOtMFwxAJNQfrmkU27/G8SWTZQ+NF1R3NUf2MdEjdEvd34Q5EAsvcNK2rwVqTlFzvKIJyNWGkdSQDjbEXy8h6oy5N/D7xK+8yl8Fu9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QNjLZ+iw; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-52f04150796so1737015e87.3;
        Thu, 08 Aug 2024 13:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723148168; x=1723752968; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5WswxgKgPlMEM9A/VnwmibPK7y43zuvqRAPNbAJdAqw=;
        b=QNjLZ+iwpRWH8d2Si+KRsmZU9bSi8Zel0285OCdM1ev/TsJHk24eHmo3WcG++bDWyv
         kZ9iJiYw0sV400FHP+QU8Add1AWVUxhF+EUdM7nveiyGmNqHGe+0ILhTTr/EVlvyBGxm
         ztJqTxeW0gED2CXUf9sDavFC++78RXSgv1nwL738FkaDdo/fgnRtqk4VV+J/6AZWjLwT
         zZ6XID2k3VwpIIMHdM8FtIC0eOOecbWsdjp7rpo0JgOf71OFVUp4p3X+N6jKHsPs0PhK
         lB1Up8t7JrH1bF2BDk9YiElHITwmzEcQqVc2uvL0eyU2lhu7V25/AvWx2q18DNcSjlY5
         sWjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723148168; x=1723752968;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5WswxgKgPlMEM9A/VnwmibPK7y43zuvqRAPNbAJdAqw=;
        b=WgvOTilJWGWIZCu+JEEj9Wgx/mFbGgD62yIISKVZiO+mwFts/ZnZLsyTmS82O2eCsT
         Z/ZwGFHMNthQeXidm+Eodm+PPbi1ERpc6Y46+dSsExD1NPZEeOBx+fXkNdbTlyq/KfrS
         v13VmoVv8JWe/3J1n5D/WHJ9HLOfDBBGK1/Na2hN1S33NLZnhCL679f2xOEuEZQuPn01
         5knYiZeEH7OtDRgC0sUtmBxpuBfKaWbR+cAnfYzziO1FAo1lM331FYwQ0SJV3R44WzuO
         QP3wGxHnhACrdPnK1r1/k1L6t4efP324bhPdWVBQF0qx3OfA1C3CKqbmpErA4naFqfKI
         RD8g==
X-Forwarded-Encrypted: i=1; AJvYcCXoPd7BKAt7Xj/mObBgdZNh1NjdcL4ITCaKmpAFvOeMzqokady6+U+MZDCesNJ8vdyeQ1BR01tTAHwJuGHLMIpzY2RKVgPqaNke7DmuiUtqVCrGaJa+smeGCcc9N//GjLhWPA==
X-Gm-Message-State: AOJu0YzpurxPxRi9UMIBRRS4WjvUCujj1CcnzHbXLL+sHOwpWLGnvaiQ
	GKS70VoFkfsB8bvQlu/gs4UDnKVg34LaII40MKd8aGL41HiY1VJDoFAhp0mz7DwKTWEKhGe+173
	svtb3QGTiG+IeNghThfFPm0+66b0=
X-Google-Smtp-Source: AGHT+IG5sK/sBO7DQ99xdhWCFp9Zi1Ta/VcdaHjVkbOOcjHIlN9UPaqOTevYdJddqyhsk0T7fJPaN77INrnqhXT63ec=
X-Received: by 2002:a05:6512:b8f:b0:52c:e030:1450 with SMTP id
 2adb3069b0e04-530e5829a11mr1761286e87.14.1723148167572; Thu, 08 Aug 2024
 13:16:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240807234029.456316-1-andrii@kernel.org> <20240807234029.456316-7-andrii@kernel.org>
 <f3iayd76egugsgmk3evwrzn4bcko5ax2nohatgcdyxss2ilwup@pmrkbledcpc3>
In-Reply-To: <f3iayd76egugsgmk3evwrzn4bcko5ax2nohatgcdyxss2ilwup@pmrkbledcpc3>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 8 Aug 2024 13:15:52 -0700
Message-ID: <CAEf4BzZ-EB9mV8A+pqcVj4HeZvjJummhK4XK0NHRs0C8WahK0Q@mail.gmail.com>
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

On Thu, Aug 8, 2024 at 11:40=E2=80=AFAM Shakeel Butt <shakeel.butt@linux.de=
v> wrote:
>
> On Wed, Aug 07, 2024 at 04:40:25PM GMT, Andrii Nakryiko wrote:
> > Extend freader with a flag specifying whether it's OK to cause page
> > fault to fetch file data that is not already physically present in
> > memory. With this, it's now easy to wait for data if the caller is
> > running in sleepable (faultable) context.
> >
> > We utilize read_cache_folio() to bring the desired folio into page
> > cache, after which the rest of the logic works just the same at folio l=
evel.
> >
> > Suggested-by: Omar Sandoval <osandov@fb.com>
> > Cc: Shakeel Butt <shakeel.butt@linux.dev>
> > Cc: Johannes Weiner <hannes@cmpxchg.org>
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
> >  lib/buildid.c | 44 ++++++++++++++++++++++++++++----------------
> >  1 file changed, 28 insertions(+), 16 deletions(-)
> >
> > diff --git a/lib/buildid.c b/lib/buildid.c
> > index 5e6f842f56f0..e1c01b23efd8 100644
> > --- a/lib/buildid.c
> > +++ b/lib/buildid.c
> > @@ -20,6 +20,7 @@ struct freader {
> >                       struct folio *folio;
> >                       void *addr;
> >                       loff_t folio_off;
> > +                     bool may_fault;
> >               };
> >               struct {
> >                       const char *data;
> > @@ -29,12 +30,13 @@ struct freader {
> >  };
> >
> >  static void freader_init_from_file(struct freader *r, void *buf, u32 b=
uf_sz,
> > -                                struct address_space *mapping)
> > +                                struct address_space *mapping, bool ma=
y_fault)
> >  {
> >       memset(r, 0, sizeof(*r));
> >       r->buf =3D buf;
> >       r->buf_sz =3D buf_sz;
> >       r->mapping =3D mapping;
> > +     r->may_fault =3D may_fault;
> >  }
> >
> >  static void freader_init_from_mem(struct freader *r, const char *data,=
 u64 data_sz)
> > @@ -63,6 +65,11 @@ static int freader_get_folio(struct freader *r, loff=
_t file_off)
> >       freader_put_folio(r);
> >
> >       r->folio =3D filemap_get_folio(r->mapping, file_off >> PAGE_SHIFT=
);
> > +
> > +     /* if sleeping is allowed, wait for the page, if necessary */
> > +     if (r->may_fault && (IS_ERR(r->folio) || !folio_test_uptodate(r->=
folio)))
> > +             r->folio =3D read_cache_folio(r->mapping, file_off >> PAG=
E_SHIFT, NULL, NULL);
>
> Willy's network fs comment is bugging me. If we pass NULL for filler,
> the kernel will going to use fs's read_folio() callback. I have checked
> read_folio() for fuse and nfs and it seems like for at least these two
> filesystems the callback is accessing file->private_data. So, if the elf
> file is on these filesystems, we might see null accesses.
>

Isn't that just a huge problem with the read_cache_folio() interface
then? That file is optional, in general, but for some specific FS
types it's not. How generic code is supposed to know this?

Or maybe it's a bug with the nfs_read_folio() and fuse_read_folio()
implementation that they can't handle NULL file argument?
netfs_read_folio(), for example, seems to be working with file =3D=3D NULL
just fine.

Matthew, can you please advise what's the right approach here? I can,
of course, always get file refcount, but most of the time it will be
just an unnecessary overhead, so ideally I'd like to avoid that. But
if I have to check each read_folio callback implementation to know
whether it's required or not, then that's not great...

