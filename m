Return-Path: <linux-fsdevel+bounces-33496-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 946AA9B972C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2024 19:13:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BEE28B21660
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2024 18:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EE441CDFD3;
	Fri,  1 Nov 2024 18:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UHetmEKU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 134E11CDA35;
	Fri,  1 Nov 2024 18:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730484790; cv=none; b=H9HxCLwBhqJiVcQrP9Esit2ZBtMfAwcfIVLDV96bkVmZg7oFQETHpqcV8Y1rVa0ymcSyFvCE3PUzjbM56Jx2nvNzxzpq5d67hO72fsClC7iZonSX1UwFoz60EDdkBE9SttDCjG1CzDOHqj0vpHTNNsB4AyyPPMT48YWW/hWhUsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730484790; c=relaxed/simple;
	bh=NmGNWEO778eZ5xMOzouTP+rKGh09L8t95Tna+go8GGY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=It7/GQ6kWE8tBtB/b8hsBrjEZStd47fZcS0NK5Fn0QlFDUUjXc7YEtGudLL3HK7MF07yS5nCn/tQfYDcotUXftZyqcsle/uRbH940LuoaCL+DP41xYc8YanqUjh2xEwGurzvNSOl/7e+5VONQTNMJ1psXfOWH1FzAHmrElo6DSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UHetmEKU; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-720cb6ac25aso1091299b3a.3;
        Fri, 01 Nov 2024 11:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730484788; x=1731089588; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PiW9SEzE14uWJXxy3FOB2Ud96GmiPqBall1rSE+SePk=;
        b=UHetmEKUqtmkHAIWZDHjCu97GsC+K0ipogPE6US5QyYqvT3XwOmquIsDKnNmGPCHEC
         4wRMRV0N8Fjf5j3BFkBNxffS3b1y08siN8s0LOno3sjEDrT50gRr7RmzE6WIdueJe7Tv
         psM/2WXGbHlPIdr/0HjmdNeDy2eDL7kk7DXgxZV8W9hnwMXm85ff6PAa+Ac3cUxTT6vF
         XIFVZDPFDcx6dXTXqaZ/At6r1J5DJkBbr0BcSTCqIF5V6il9IziCGgCus2ykWwySwCTw
         ZGgJ8KgeExJd676x4ndagCT2OyIXfIVc6ukZVh4HExrekX2j59VeFhAIU99r5dwsep4o
         UZMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730484788; x=1731089588;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PiW9SEzE14uWJXxy3FOB2Ud96GmiPqBall1rSE+SePk=;
        b=bozwg0HpvuAnACzgf7INJkagNPKsy1+kUin5HJeQvTwYbA/E6njqepe0wq4NXbLs40
         1yMDQlIzByRrJ99hTDcV8QHuK4r3aqH27VFwj9AXei+oS+kocqsFzkOIEqbD+nzdHb4C
         QZbtycHwGNMi96AQaO7n19DfohQWlqj2cwRSulLFT/MQqAEIOn7EmaZ8/PjOdVBX/4uJ
         ZV8HJotn2KDli5D/MZ/imxwkMU4J/iHlGzndxMruIEU5h91MOEcOycAUS5csydMtYFa/
         bRiNHYX4NiIBToBe2ni9vFtRQduPVg6P2Ka5OM/6RA8rNEmmEp78fsq22mXKpU+bZQVQ
         cOPg==
X-Forwarded-Encrypted: i=1; AJvYcCVUbpOobXIw8OKFfZle1Sta9vEWWCvCp9gSZc/cbsL6DzPmzlboiw3lQTivH8jvXvxfVke5tXCl@vger.kernel.org, AJvYcCXPK9vvCSdEf9naV4xMCoNLCjWI9ioRNLVl/cRTxdNk2aX4513Ig8aowEwv15CobPKmyA4Mncir/Fg7JD1m2w==@vger.kernel.org, AJvYcCXaPzJsjurkTXbJ+7p+UnFydc5zZHwR5fEudFn14SPQBFbbxL2Cnl5sVYY5arSOJD9B/x4=@vger.kernel.org
X-Gm-Message-State: AOJu0YztsWxqcgbX5+TZuIFGoHGRBy328djVkxNF7iXqHKCKEYnvo1g1
	ks1W3wR9NuMlTx2ficFSS29xybShUTfRHV/sgGTzYNsKDJ13JhaIQalGNlJP1ZQZTo2/9gFKR/s
	IZcIm0vvALwuGvFE++eSSX2IvVxo=
X-Google-Smtp-Source: AGHT+IEk5xx3/JFmK3SmabSdACLb2Y3za3f+3kE6RcmNc7n4e0XhM9sTxifeXbsjGY0xW5T523PyYTIoJXLl8NRIFS0=
X-Received: by 2002:a05:6a21:78c:b0:1d9:261c:5942 with SMTP id
 adf61e73a8af0-1d9a8403ce0mr30567357637.28.1730484788340; Fri, 01 Nov 2024
 11:13:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240829174232.3133883-1-andrii@kernel.org> <20240829174232.3133883-2-andrii@kernel.org>
 <ZyTde66MF0GUqbvB@krava>
In-Reply-To: <ZyTde66MF0GUqbvB@krava>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 1 Nov 2024 11:12:55 -0700
Message-ID: <CAEf4BzaFd2G0HqXLSd5JbQ4HYwzTzAsAskQJNbE9hb8KuTEWTg@mail.gmail.com>
Subject: Re: [PATCH v7 bpf-next 01/10] lib/buildid: harden build ID parsing logic
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, linux-mm@kvack.org, 
	akpm@linux-foundation.org, adobriyan@gmail.com, shakeel.butt@linux.dev, 
	hannes@cmpxchg.org, ak@linux.intel.com, osandov@osandov.com, song@kernel.org, 
	jannh@google.com, linux-fsdevel@vger.kernel.org, willy@infradead.org, 
	stable@vger.kernel.org, Eduard Zingerman <eddyz87@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 1, 2024 at 6:54=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wrote=
:
>
> On Thu, Aug 29, 2024 at 10:42:23AM -0700, Andrii Nakryiko wrote:
> > Harden build ID parsing logic, adding explicit READ_ONCE() where it's
> > important to have a consistent value read and validated just once.
> >
> > Also, as pointed out by Andi Kleen, we need to make sure that entire EL=
F
> > note is within a page bounds, so move the overflow check up and add an
> > extra note_size boundaries validation.
> >
> > Fixes tag below points to the code that moved this code into
> > lib/buildid.c, and then subsequently was used in perf subsystem, making
> > this code exposed to perf_event_open() users in v5.12+.
> >
> > Cc: stable@vger.kernel.org
> > Reviewed-by: Eduard Zingerman <eddyz87@gmail.com>
> > Reviewed-by: Jann Horn <jannh@google.com>
> > Suggested-by: Andi Kleen <ak@linux.intel.com>
> > Fixes: bd7525dacd7e ("bpf: Move stack_map_get_build_id into lib")
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
> >  lib/buildid.c | 76 +++++++++++++++++++++++++++++----------------------
> >  1 file changed, 44 insertions(+), 32 deletions(-)
> >
> > diff --git a/lib/buildid.c b/lib/buildid.c
> > index e02b5507418b..26007cc99a38 100644
> > --- a/lib/buildid.c
> > +++ b/lib/buildid.c
> > @@ -18,31 +18,37 @@ static int parse_build_id_buf(unsigned char *build_=
id,
> >                             const void *note_start,
> >                             Elf32_Word note_size)
> >  {
> > -     Elf32_Word note_offs =3D 0, new_offs;
> > -
> > -     while (note_offs + sizeof(Elf32_Nhdr) < note_size) {
> > -             Elf32_Nhdr *nhdr =3D (Elf32_Nhdr *)(note_start + note_off=
s);
> > +     const char note_name[] =3D "GNU";
> > +     const size_t note_name_sz =3D sizeof(note_name);
> > +     u64 note_off =3D 0, new_off, name_sz, desc_sz;
> > +     const char *data;
> > +
> > +     while (note_off + sizeof(Elf32_Nhdr) < note_size &&
> > +            note_off + sizeof(Elf32_Nhdr) > note_off /* overflow */) {
> > +             Elf32_Nhdr *nhdr =3D (Elf32_Nhdr *)(note_start + note_off=
);
> > +
> > +             name_sz =3D READ_ONCE(nhdr->n_namesz);
> > +             desc_sz =3D READ_ONCE(nhdr->n_descsz);
> > +
> > +             new_off =3D note_off + sizeof(Elf32_Nhdr);
> > +             if (check_add_overflow(new_off, ALIGN(name_sz, 4), &new_o=
ff) ||
> > +                 check_add_overflow(new_off, ALIGN(desc_sz, 4), &new_o=
ff) ||
> > +                 new_off > note_size)
> > +                     break;
> >
> >               if (nhdr->n_type =3D=3D BUILD_ID &&
> > -                 nhdr->n_namesz =3D=3D sizeof("GNU") &&
> > -                 !strcmp((char *)(nhdr + 1), "GNU") &&
> > -                 nhdr->n_descsz > 0 &&
> > -                 nhdr->n_descsz <=3D BUILD_ID_SIZE_MAX) {
> > -                     memcpy(build_id,
> > -                            note_start + note_offs +
> > -                            ALIGN(sizeof("GNU"), 4) + sizeof(Elf32_Nhd=
r),
> > -                            nhdr->n_descsz);
> > -                     memset(build_id + nhdr->n_descsz, 0,
> > -                            BUILD_ID_SIZE_MAX - nhdr->n_descsz);
> > +                 name_sz =3D=3D note_name_sz &&
> > +                 memcmp(nhdr + 1, note_name, note_name_sz) =3D=3D 0 &&
> > +                 desc_sz > 0 && desc_sz <=3D BUILD_ID_SIZE_MAX) {
> > +                     data =3D note_start + note_off + ALIGN(note_name_=
sz, 4);
> > +                     memcpy(build_id, data, desc_sz);
> > +                     memset(build_id + desc_sz, 0, BUILD_ID_SIZE_MAX -=
 desc_sz);
> >                       if (size)
> > -                             *size =3D nhdr->n_descsz;
> > +                             *size =3D desc_sz;
> >                       return 0;
> >               }
>
> hi,
> this fix is causing stable kernels to return wrong build id,
> the change below seems to fix that (based on 6.6 stable)
>
> if we agree on the fix I'll send it to all affected stable trees
>
> jirka
>
>
> ---
> The parse_build_id_buf does not account Elf32_Nhdr header size
> when getting the build id data pointer and returns wrong build
> id data as result.
>
> This is problem only stable trees that merged c83a80d8b84f fix,
> the upstream build id code was refactored and returns proper
> build id.
>
> Fixes: c83a80d8b84f ("lib/buildid: harden build ID parsing logic")
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  lib/buildid.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/lib/buildid.c b/lib/buildid.c
> index d3bc3d0528d5..9fc46366597e 100644
> --- a/lib/buildid.c
> +++ b/lib/buildid.c
> @@ -40,7 +40,7 @@ static int parse_build_id_buf(unsigned char *build_id,
>                     name_sz =3D=3D note_name_sz &&
>                     memcmp(nhdr + 1, note_name, note_name_sz) =3D=3D 0 &&
>                     desc_sz > 0 && desc_sz <=3D BUILD_ID_SIZE_MAX) {
> -                       data =3D note_start + note_off + ALIGN(note_name_=
sz, 4);
> +                       data =3D note_start + note_off + sizeof(Elf32_Nhd=
r) + ALIGN(note_name_sz, 4);

ah, my screw up, sorry. LGTM

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>                         memcpy(build_id, data, desc_sz);
>                         memset(build_id + desc_sz, 0, BUILD_ID_SIZE_MAX -=
 desc_sz);
>                         if (size)
> --
> 2.47.0
>

