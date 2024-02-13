Return-Path: <linux-fsdevel+bounces-11327-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A03A852B1E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 09:28:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31BEB284440
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 08:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4F881B971;
	Tue, 13 Feb 2024 08:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oe1lbD0s"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C38B1B592;
	Tue, 13 Feb 2024 08:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707812849; cv=none; b=Y5/hEaECGh/Km9j16a8IHkxWZp8z40apHVFNt6DWLdL/ltro7MYB3vWJr+/5tS+F+7VWwo+3dNbyexpa2hFMNyL19LxNtcRosUiESBoOto+3K6qtnY4gMyewAZCqF+iK/mVH6dL1htmhcB5HACVbwMWOHgepdqFvQkIxSSv6kvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707812849; c=relaxed/simple;
	bh=uafGeBbQdA3tymCA3tWJBrlrcdnQCGekk71oGHgR4d0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fEgSa+xb7NseCfuw93YE3yXnGYiIOSuGcGk8icdWxgL0h2GFSx4aXFsE/fdxct4+NIzsbzt8FCnR9oqQ4iBvq32/77nA+cyPKM7b6DqfRCPb/YUioIpwRK06QsOgwLLrCQFl5HPIA+etwo7/1SbXWYPrEnmhwbewgl65DCTn0+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oe1lbD0s; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a3832ef7726so469289166b.0;
        Tue, 13 Feb 2024 00:27:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707812845; x=1708417645; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iNGA8ZHGAdrm/kUeu0sTwlf3VcWW6Pp9gwsOjSJOS+s=;
        b=Oe1lbD0sQSnEAzziF8TTz8fVz5XARWLd5y4xcYE8Xvycsf5EZPRTUpx/3qsKEitfXe
         x3yKNpHeAZN3Gssw58XVHxM1VHK8pNqW6huyK2XvPX+Ry+9CVmkdJ7ZHC2OfNB2XybFA
         17xqPjLqsgENJ5HzBSP7O9M+b0GmvFBylsPtjeh02o2MqraH/0WuQ17ce6dHl603qDCI
         KjSZBg8RhrXSr1hQGuR90a8M1ps7hZn0FDQSi9vGKdIWLX3OexXUvjdjIEaWUhlkR2ko
         Awtz8x+RHKoOgSlfSEmngWFCNKv2IsTkt4dShBJAPGEf5W4YVADo8/1ePS6yk35IzbQa
         fa4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707812845; x=1708417645;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iNGA8ZHGAdrm/kUeu0sTwlf3VcWW6Pp9gwsOjSJOS+s=;
        b=jtqHJEranLT1GzDFLuWn8d505Y+pmX1UWEPTRgvpY8xdiJA+yE/AA68ZsIq9Df604X
         XvsjmEm/lWwvYHqpbCOCsq7gi7T5zLwdFuxr0DZKBA5xhubji9KqWpvHEaC/LN3lh2NU
         qRsKN3hQ3Ce96SOkGsPlp8LRSgs9tfRAUT1tUjztcrnAeicAuX3B9MvW1qUrqHt2KZYO
         ZjIjFaUSMOb3nulROQn1qFsWxbvMN/WFVB8/htjYuATnrjx2TvPTX7uMURdyAM6gw7tE
         Gjg9C4ndudtzJg/OsgQXJchKOb3ynKoSDtnPFlOYK1TBKNhGXyqnJNlCrPAARBzlMuua
         ThCA==
X-Forwarded-Encrypted: i=1; AJvYcCVrh2/ngeAji7dpL+z2DAjEoXj22MZRchb+NMjojeiXH/MaXBLAWI1hSwK3AE+nl6fT6UXTKzDg6TSDiJNrkrASOuIjN8i6C3OVVb/fEl8DrapGu7iAitRWQr5mP1tdu0CN1ZekpUPRk1qQ50RJLVuGgt3OnL/3ki1zs00c+NUUkpIM8zpSxAQcRaIlPCwTiRo6Vp7HAmqGH5GMgSRME3eQj+C1ce+xcLgZybL/jJk/vkcMve02MXjlpH4VR8j/1ayiUqUI5ZQiA6aUlu/scxxjaitjOD7V2CWqsg==
X-Gm-Message-State: AOJu0YxJiMxKvyNyVyrbFX/absRDOGyfXHoufqJyR1vC3c6WUY5ftsrh
	1ZgJNvN93RNz1RQ6QRIeIe6ZZa42FfolVjOKOHnRG8gUiUGRv36c8SAZzZ9UlyJv73bb0KGLzYk
	d8JI87+u/5qI23hrqh5ofDXxJjTg=
X-Google-Smtp-Source: AGHT+IHiWMLrwo5bn92RcxNVJHJJozT1VynVrAKPo4QX0LJ4mwZF+SLpK21LEEy+wgmtP5RFPridAor3NfrCIEw3scE=
X-Received: by 2002:a17:906:ceca:b0:a38:3db5:a846 with SMTP id
 si10-20020a170906ceca00b00a383db5a846mr5777021ejb.67.1707812845309; Tue, 13
 Feb 2024 00:27:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240212213922.783301-1-surenb@google.com> <20240212213922.783301-2-surenb@google.com>
In-Reply-To: <20240212213922.783301-2-surenb@google.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 13 Feb 2024 10:26:48 +0200
Message-ID: <CAHp75Vek3DEYLHnpUDBo_bYSd-ksN_66=LQ5s0Z+EhnNvhybpw@mail.gmail.com>
Subject: Re: [PATCH v3 01/35] lib/string_helpers: Add flags param to string_get_size()
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, kent.overstreet@linux.dev, mhocko@suse.com, 
	vbabka@suse.cz, hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de, 
	dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com, 
	corbet@lwn.net, void@manifault.com, peterz@infradead.org, 
	juri.lelli@redhat.com, catalin.marinas@arm.com, will@kernel.org, 
	arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com, 
	dave.hansen@linux.intel.com, x86@kernel.org, peterx@redhat.com, 
	david@redhat.com, axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org, 
	nathan@kernel.org, dennis@kernel.org, tj@kernel.org, muchun.song@linux.dev, 
	rppt@kernel.org, paulmck@kernel.org, pasha.tatashin@soleen.com, 
	yosryahmed@google.com, yuzhao@google.com, dhowells@redhat.com, 
	hughd@google.com, andreyknvl@gmail.com, keescook@chromium.org, 
	ndesaulniers@google.com, vvvvvv@google.com, gregkh@linuxfoundation.org, 
	ebiggers@google.com, ytcoode@gmail.com, vincent.guittot@linaro.org, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	bristot@redhat.com, vschneid@redhat.com, cl@linux.com, penberg@kernel.org, 
	iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, glider@google.com, 
	elver@google.com, dvyukov@google.com, shakeelb@google.com, 
	songmuchun@bytedance.com, jbaron@akamai.com, rientjes@google.com, 
	minchan@google.com, kaleshsingh@google.com, kernel-team@android.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	iommu@lists.linux.dev, linux-arch@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, kasan-dev@googlegroups.com, 
	cgroups@vger.kernel.org, Andy Shevchenko <andy@kernel.org>, 
	Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, 
	Paul Mackerras <paulus@samba.org>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	=?UTF-8?Q?Noralf_Tr=C3=B8nnes?= <noralf@tronnes.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 12, 2024 at 11:39=E2=80=AFPM Suren Baghdasaryan <surenb@google.=
com> wrote:
>
> From: Kent Overstreet <kent.overstreet@linux.dev>
>
> The new flags parameter allows controlling
>  - Whether or not the units suffix is separated by a space, for
>    compatibility with sort -h
>  - Whether or not to append a B suffix - we're not always printing
>    bytes.
>
> Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>

It seems most of my points from the previous review were refused...

...

You can move the below under --- cutter, so it won't pollute the git histor=
y.

> Cc: Andy Shevchenko <andy@kernel.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: "Noralf Tr=C3=B8nnes" <noralf@tronnes.org>
> Cc: Jens Axboe <axboe@kernel.dk>
> ---

...

> --- a/include/linux/string_helpers.h
> +++ b/include/linux/string_helpers.h
> @@ -17,14 +17,13 @@ static inline bool string_is_terminated(const char *s=
, int len)

...

> -/* Descriptions of the types of units to
> - * print in */
> -enum string_size_units {
> -       STRING_UNITS_10,        /* use powers of 10^3 (standard SI) */
> -       STRING_UNITS_2,         /* use binary powers of 2^10 */
> +enum string_size_flags {
> +       STRING_SIZE_BASE2       =3D (1 << 0),
> +       STRING_SIZE_NOSPACE     =3D (1 << 1),
> +       STRING_SIZE_NOBYTES     =3D (1 << 2),
>  };

Do not kill documentation, I already said that. Or i.o.w. document this.
Also the _SIZE is ambigous (if you don't want UNITS, use SIZE_FORMAT.

Also why did you kill BASE10 here? (see below as well)

...

> --- a/lib/string_helpers.c
> +++ b/lib/string_helpers.c
> @@ -19,11 +19,17 @@
>  #include <linux/string.h>
>  #include <linux/string_helpers.h>
>
> +enum string_size_units {
> +       STRING_UNITS_10,        /* use powers of 10^3 (standard SI) */
> +       STRING_UNITS_2,         /* use binary powers of 2^10 */
> +};

Why do we need this duplication?

...

> +       enum string_size_units units =3D flags & flags & STRING_SIZE_BASE=
2
> +               ? STRING_UNITS_2 : STRING_UNITS_10;

Double flags check is redundant.

--=20
With Best Regards,
Andy Shevchenko

