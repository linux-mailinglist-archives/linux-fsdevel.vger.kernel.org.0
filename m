Return-Path: <linux-fsdevel+bounces-25331-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03A0E94AE5C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 18:48:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25E021C20B8E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 16:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C553A13AD0F;
	Wed,  7 Aug 2024 16:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Psd9+5ko"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B505F2D05D;
	Wed,  7 Aug 2024 16:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723049280; cv=none; b=VDFXrx4nmfRwC34c/k8Q3xASYsTKzKOR0HVsU22H+O/Qkd2JmVtQLr1UMqQ3xHVqWJWrh3wjCGIFvxt+YJFk2iqZ+0pXqv/+PWPJPVB12TqnehhvyzkrK0ZBhtT0WcrxZ9p/iQc432N0ZJMd3j8igRstd+/TURcqUh9+LVDgB7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723049280; c=relaxed/simple;
	bh=uLNkIH+VLgoManrhmSXJCVGi1WPYdQcn+s58XS/3R4M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qKSwdyziCZVJkdBQZj8ChjGf2CtPtsNP7j6lN5Si3jx59XRYZxRrSLc45/8Y6wbnk/Y0ByC/VmZ/IvgiUqQGsyGw9FbRMqwxgejP5JvKbMVbsCR3oRbeaK5ALtxf4llC6RrpeJYx54njnHqohq+l5DNgyVJ8k6jJO65YDTq21D0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Psd9+5ko; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2cb53da06a9so46151a91.0;
        Wed, 07 Aug 2024 09:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723049278; x=1723654078; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0pVZ2dit0aE/3HJ5+JrWqMQmfjhnYPQMARk+CNwPiyE=;
        b=Psd9+5ko4hcFZjBmvdk6vag/djRTaL1P2cUEncPtAib5D5a17kOJB15zk0q0q46XQZ
         0W8JjfgtNA/knc4mpPL7/su1TQMu/paNrbqkWEUoYAn54rdcoO3j1tAyX9Fur3gRnGyR
         wUBcsYHJsiQH0suNzvQf3euhD3eEY5BHrcuELkucLAc/SbDkSTUaIVKw+RAVtIi9nJUv
         rmsIs9O5BYWSaXIdSCf8RmBTfNPq+PSyz4Qays59pbL4Tdzo7NDSq5DL3n8nLXfN6NpF
         ctk9dQrifgG2UxTEzra7LYU3taJbu8a0RbPTB4BN60jORlNc1yryFb5vz4MpULzvLAUq
         KQmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723049278; x=1723654078;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0pVZ2dit0aE/3HJ5+JrWqMQmfjhnYPQMARk+CNwPiyE=;
        b=OB9ie/VlYFFb9VaN63TUFRpVIHZXiPn8VcfHvJP8xvcQxy469viGt9RzxTmzd0fhGA
         CuNdG4Bq8LmqSCqgHc7YPwpK6x98YFG7lDsu/TgNmXeuk5FOBWQB5fUxf9Smxq/UWorA
         uNOy7wQr6UMq0krEpeVMjA7jXmYQzTOyhQlQIE18GKPlr6DPo1RYWmkWK/qrh/oI3oT1
         Gkx2C9bOTJ5/NPLeqbb0OLYjHjHIhw50lgbjmC4CYcBpK9z99B/c2UWn+EOWUqOOn+35
         Md/gf0OoLFFpurXLHnctnLRCt6cjbC9WiBP+swg+XvlgNv8V5pSLnUpvN3yuJXm2UhpG
         n4Bg==
X-Forwarded-Encrypted: i=1; AJvYcCXmUouKRb5rc5HwAGdohPvdOBBFmJo8QW+epH0jNvTXgQ7dIAd97nhUXxOMAEKEqSuZxglpbk1PvxVSWpNQpaGuv0XxiVyeY6uR5sZrf3WefbYczFkTcXRZuN9CE/gGpOZ2DENVWsvNpONp4eA0ctxLEwOD8kE/9L7Anw==
X-Gm-Message-State: AOJu0YyMjcTDHSFsoIc6iRdWId2PZQ253ZivfPBIRW+EU5HOTzUAl3xE
	L7GHw50lMDR+UoDMxKPrGbzeQwBfMpI1H4K0eTbIgNKro0qry6gD82Cv7SSTPtNUDJ2sMCq4oL7
	V0R5ESyXMA2RBiSOUCur9CA2GBf4=
X-Google-Smtp-Source: AGHT+IGBu/VSKgXWgCGsXgFXVRU7MiOUyr/hCi1GoaySMkLFfa0gO/5ARkiPXy+828Gou06G8RpEW7rkeSU10uNhwQo=
X-Received: by 2002:a17:90b:128e:b0:2c2:4109:9466 with SMTP id
 98e67ed59e1d1-2d1b2d1cf07mr3976143a91.8.1723049277742; Wed, 07 Aug 2024
 09:47:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240730203914.1182569-1-andrii@kernel.org> <20240730203914.1182569-2-andrii@kernel.org>
 <CAG48ez16gwq4YZrnPn2OmuSyz2rXM0KKVgb+UjB5GocKZGNgQQ@mail.gmail.com>
In-Reply-To: <CAG48ez16gwq4YZrnPn2OmuSyz2rXM0KKVgb+UjB5GocKZGNgQQ@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 7 Aug 2024 09:47:45 -0700
Message-ID: <CAEf4BzZEwgAYU-FW_yxXdmYA9Y9CaZxGazEHVyUs+X-1hGwbxA@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 01/10] lib/buildid: harden build ID parsing logic
To: Jann Horn <jannh@google.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Matthew Wilcox <willy@infradead.org>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, bpf@vger.kernel.org, linux-mm@kvack.org, 
	akpm@linux-foundation.org, adobriyan@gmail.com, shakeel.butt@linux.dev, 
	hannes@cmpxchg.org, ak@linux.intel.com, osandov@osandov.com, song@kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 7, 2024 at 8:12=E2=80=AFAM Jann Horn <jannh@google.com> wrote:
>
> +Matthew and fsdevel list for pagecache question
>
> On Tue, Jul 30, 2024 at 10:39=E2=80=AFPM Andrii Nakryiko <andrii@kernel.o=
rg> wrote:
> > Harden build ID parsing logic, adding explicit READ_ONCE() where it's
> > important to have a consistent value read and validated just once.
> >
> > Fixes tag below points to the code that moved this code into
> > lib/buildid.c, and then subsequently was used in perf subsystem, making
> > this code exposed to perf_event_open() users in v5.12+.
>
> One thing that still seems dodgy to me with this patch applied is the
> call from build_id_parse() to find_get_page(), followed by reading the
> page contents. My understanding of the page cache (which might be
> incorrect) is that find_get_page() can return a page whose contents
> have not been initialized yet, and you're supposed to check for
> PageUptodate() or something like that before reading from it.
>
> Maybe Matthew can check if I understood that right?
>
>
> Also, it might be a good idea to liberally spray READ_ONCE() around
> all the remaining unannotated shared memory accesses in
> build_id_parse(), get_build_id_32(), get_build_id_64() and
> parse_build_id_buf().

Andi was against that, so I kept READ_ONCE() only where strictly
necessary, AFAICT.

>
> > Cc: stable@vger.kernel.org
> > Cc: Jann Horn <jannh@google.com>
> > Suggested-by: Andi Kleen <ak@linux.intel.com>
> > Fixes: bd7525dacd7e ("bpf: Move stack_map_get_build_id into lib")
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
> >  lib/buildid.c | 51 +++++++++++++++++++++++++++------------------------
> >  1 file changed, 27 insertions(+), 24 deletions(-)
> >
> > diff --git a/lib/buildid.c b/lib/buildid.c
> > index e02b5507418b..d21d86f6c19a 100644
> > --- a/lib/buildid.c
> > +++ b/lib/buildid.c
> > @@ -18,28 +18,29 @@ static int parse_build_id_buf(unsigned char *build_=
id,
> >                               const void *note_start,
> >                               Elf32_Word note_size)
> >  {
> > +       const char note_name[] =3D "GNU";
> > +       const size_t note_name_sz =3D sizeof(note_name);
> >         Elf32_Word note_offs =3D 0, new_offs;
> > +       u32 name_sz, desc_sz;
> > +       const char *data;
> >
> >         while (note_offs + sizeof(Elf32_Nhdr) < note_size) {
> >                 Elf32_Nhdr *nhdr =3D (Elf32_Nhdr *)(note_start + note_o=
ffs);
> >
> > +               name_sz =3D READ_ONCE(nhdr->n_namesz);
> > +               desc_sz =3D READ_ONCE(nhdr->n_descsz);
> >                 if (nhdr->n_type =3D=3D BUILD_ID &&
> > -                   nhdr->n_namesz =3D=3D sizeof("GNU") &&
> > -                   !strcmp((char *)(nhdr + 1), "GNU") &&
> > -                   nhdr->n_descsz > 0 &&
> > -                   nhdr->n_descsz <=3D BUILD_ID_SIZE_MAX) {
> > -                       memcpy(build_id,
> > -                              note_start + note_offs +
> > -                              ALIGN(sizeof("GNU"), 4) + sizeof(Elf32_N=
hdr),
> > -                              nhdr->n_descsz);
> > -                       memset(build_id + nhdr->n_descsz, 0,
> > -                              BUILD_ID_SIZE_MAX - nhdr->n_descsz);
> > +                   name_sz =3D=3D note_name_sz &&
> > +                   strcmp((char *)(nhdr + 1), note_name) =3D=3D 0 &&
> > +                   desc_sz > 0 && desc_sz <=3D BUILD_ID_SIZE_MAX) {
> > +                       data =3D note_start + note_offs + ALIGN(note_na=
me_sz, 4);
>
> I don't think we have any guarantee here that this addition won't
> result in an OOB pointer?
>
> > +                       memcpy(build_id, data, desc_sz);
>
> I think this can access OOB data (because "data" can already be OOB
> and because "desc_sz" hasn't been checked against the amount of
> remaining space in the page).

Andi already pointed this out and I fixed it locally, thanks.

>
> > +                       memset(build_id + desc_sz, 0, BUILD_ID_SIZE_MAX=
 - desc_sz);
> >                         if (size)
> > -                               *size =3D nhdr->n_descsz;
> > +                               *size =3D desc_sz;
> >                         return 0;
> >                 }
> > -               new_offs =3D note_offs + sizeof(Elf32_Nhdr) +
> > -                       ALIGN(nhdr->n_namesz, 4) + ALIGN(nhdr->n_descsz=
, 4);
> > +               new_offs =3D note_offs + sizeof(Elf32_Nhdr) + ALIGN(nam=
e_sz, 4) + ALIGN(desc_sz, 4);
> >                 if (new_offs <=3D note_offs)  /* overflow */
> >                         break;
>
> You check whether "new_offs" has wrapped here, but then on the next
> loop iteration, you check for "note_offs + sizeof(Elf32_Nhdr) <
> note_size". So if new_offs is 0xffffffff at this point, then I think
> the overflow check here will be passed, the loop condition will be
> true on 32-bit kernels (on 64-bit kernels it won't be because the
> addition happens on 64-bit numbers thanks to sizeof()), and "nhdr"
> will point in front of the note?

Correct, and so I moved this new_offs calculation and overflow check
to the beginning of the loop, which I think should capture this issue.

For the while() condition itself I have:

        if (check_add_overflow(note_offs, note_size, &note_end))
                return -EINVAL;

        while (note_offs < note_end - sizeof(Elf32_Nhdr) - note_name_sz) {
            ...
        }

I'll try to post an updated version soon-ish, have been waiting for mm
folks feedback before posting a new version.

>
> >                 note_offs =3D new_offs;

