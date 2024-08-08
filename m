Return-Path: <linux-fsdevel+bounces-25383-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4766A94B46A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2024 03:09:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD90A1F22B51
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2024 01:09:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A44D4A2D;
	Thu,  8 Aug 2024 01:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P2QUwYqu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A718BE5;
	Thu,  8 Aug 2024 01:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723079342; cv=none; b=jNjAxizEV5G5oiEMeQe5drKReLMxqTbOcjS3yfeTEk2hsDWvI/cO4Coqi/TihFyyNfHhkHtDjDtupiIL5SNFN35Ha8eHbL78p+N5NTtC0vjCEfVvrRn1Jv2cfahohO7Od+S4JE4C8OTD3gVx581TZOu2DsK1LVtp0siPdgt8fkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723079342; c=relaxed/simple;
	bh=p6TMbu29Ztu3GEjIYHWPxXMQEpgnACG53n0NegCDJXo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S63+i28MwzPUek0yhC0madH+DskE124t8bxdui8uJ1LhfZK7VyfkjNuheY9QkiAYBJGUNby3dqg76neTTdpe5Ef0uOLwwXtQHUQj228tCsgZBvCjbJdcRdTY9rjOK6/niH7dfSQdlwq1PZ0igCztQ9fZ1xMn0QWg5tzfJj8+rGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P2QUwYqu; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2cb4c584029so398055a91.3;
        Wed, 07 Aug 2024 18:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723079340; x=1723684140; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CxzHlt6vvopbfCStqQ0Tcft5Trj2uHaZfiHIKSMbhw8=;
        b=P2QUwYquOrqhdMPufdazlW6zqXVVOoG5auNqqbesRFTNG6Xd8aBcp/eT0YjAsdkV2W
         Io0COohT0nb65689Dv49QgETDfG8q0jYdrtIC2pmQ5q9FoHZUhAYW1xsV4KE+zDOtHrl
         UpfiItu293toXINa9UTziTasfL18xYS9gnhoubigUWXIOLObCQledcFrEcE6qj7qf+Zm
         RViApjAUgEQbFEHYHcPMMOjHAF52MNONItUomKwBIr8mAtAUgPXyJsIbPXyjSGHDzHfE
         POWa1in/tQWL7wpGdEr+4qvplosoFxOuaDrXP5DaJrPRPS1ZC/U7rM+uFIgYXszKpHjN
         MyCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723079340; x=1723684140;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CxzHlt6vvopbfCStqQ0Tcft5Trj2uHaZfiHIKSMbhw8=;
        b=CeZLrN6pK1nprPPL6vR/R0Wcsp75XvYGINOznIpRaH4zGN+47JF8M68z3HiMFeDJF5
         F8AGrheuj1xHIxHhn4lFx60VeRhMgM98LaXStC3hVWz5SgW7FcB78MRS1sqfBtonoNDf
         4bgtqlGcUKCKcQGnVdaMOaGSMapd6DzBfIILOHjkBkGbTiqQSCUvrH/u4IvBweZMyKjG
         jodq8f638xv6UdJGVj9XqG3vjbShCbjWn5YAvTfM3B33udWZQhF7zmXYKBRthFd8mWjH
         EdBETAmHydwZj3axNqvvZRC2HQ9HPBi/Y9qGYZgWAQUEgVPooeQZPNtK52PKMHjSW2Ax
         iHgA==
X-Forwarded-Encrypted: i=1; AJvYcCVOFQeC64RksYlkfTZ/ljPnohx21EWwQbTS+BKx7ZffbQ0nr9A5fDMJG9IKWet20T28ZcOCzuV3XXP5+TfsU0i+bvBLTwokpF1UpQ81kn2XSqEmsABf8Cap5dCDqCqkNAO4JA==
X-Gm-Message-State: AOJu0Yxv99sPV+p0+VN4bF4gL/z+k/umnGXglU7j7KPTYqCSHIVqpJra
	QW8oZIQYlvNtR07K/rpyjWpbbLxMAyneqUWk4t9aZ/K1s721hNVthnKqZoT0vnXTN0AVPDKQr5C
	KFZ3/fMYh/wUrFJe2QvVHvCoKgCM=
X-Google-Smtp-Source: AGHT+IH8UwwFkSqjYvCuoXLR0JmWs21b5/EETZDyCs+FwggLnPxrbK5jvOW2XaI568evJg10QAkd28UN4zumUB3X80Q=
X-Received: by 2002:a17:90b:1a89:b0:2c2:deda:8561 with SMTP id
 98e67ed59e1d1-2d1c346b5d3mr351912a91.41.1723079340300; Wed, 07 Aug 2024
 18:09:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240807234029.456316-1-andrii@kernel.org> <20240807234029.456316-3-andrii@kernel.org>
 <CAG48ez3apg4N2JJrNyssE_sDda10yAUHnn1YF_GLHvVCUoLGkw@mail.gmail.com>
In-Reply-To: <CAG48ez3apg4N2JJrNyssE_sDda10yAUHnn1YF_GLHvVCUoLGkw@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 7 Aug 2024 18:08:48 -0700
Message-ID: <CAEf4BzZ7OAugtMN04X0E024hsyMkp+jz9hBtcGRY2UECJW=hEA@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 02/10] lib/buildid: add single folio-based
 file reader abstraction
To: Jann Horn <jannh@google.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, linux-mm@kvack.org, 
	akpm@linux-foundation.org, adobriyan@gmail.com, shakeel.butt@linux.dev, 
	hannes@cmpxchg.org, ak@linux.intel.com, osandov@osandov.com, song@kernel.org, 
	linux-fsdevel@vger.kernel.org, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 7, 2024 at 5:51=E2=80=AFPM Jann Horn <jannh@google.com> wrote:
>
> On Thu, Aug 8, 2024 at 1:40=E2=80=AFAM Andrii Nakryiko <andrii@kernel.org=
> wrote:
> > Add freader abstraction that transparently manages fetching and local
> > mapping of the underlying file page(s) and provides a simple direct dat=
a
> > access interface.
> >
> > freader_fetch() is the only and single interface necessary. It accepts
> > file offset and desired number of bytes that should be accessed, and
> > will return a kernel mapped pointer that caller can use to dereference
> > data up to requested size. Requested size can't be bigger than the size
> > of the extra buffer provided during initialization (because, worst case=
,
> > all requested data has to be copied into it, so it's better to flag
> > wrongly sized buffer unconditionally, regardless if requested data rang=
e
> > is crossing page boundaries or not).
> >
> > If folio is not paged in, or some of the conditions are not satisfied,
> > NULL is returned and more detailed error code can be accessed through
> > freader->err field. This approach makes the usage of freader_fetch()
> > cleaner.
> >
> > To accommodate accessing file data that crosses folio boundaries, user
> > has to provide an extra buffer that will be used to make a local copy,
> > if necessary. This is done to maintain a simple linear pointer data
> > access interface.
> >
> > We switch existing build ID parsing logic to it, without changing or
> > lifting any of the existing constraints, yet. This will be done
> > separately.
> >
> > Given existing code was written with the assumption that it's always
> > working with a single (first) page of the underlying ELF file, logic
> > passes direct pointers around, which doesn't really work well with
> > freader approach and would be limiting when removing the single page (f=
olio)
> > limitation. So we adjust all the logic to work in terms of file offsets=
.
> >
> > There is also a memory buffer-based version (freader_init_from_mem())
> > for cases when desired data is already available in kernel memory. This
> > is used for parsing vmlinux's own build ID note. In this mode assumptio=
n
> > is that provided data starts at "file offset" zero, which works great
> > when parsing ELF notes sections, as all the parsing logic is relative t=
o
> > note section's start.
> >
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> [...]
> > +static int freader_get_folio(struct freader *r, loff_t file_off)
> > +{
> > +       /* check if we can just reuse current folio */
> > +       if (r->folio && file_off >=3D r->folio_off &&
> > +           file_off < r->folio_off + folio_size(r->folio))
> > +               return 0;
> > +
> > +       freader_put_folio(r);
> > +
> > +       r->folio =3D filemap_get_folio(r->mapping, file_off >> PAGE_SHI=
FT);
> > +       if (IS_ERR(r->folio) || !folio_test_uptodate(r->folio)) {
>
> Can you also fix the uptodate stuff in patch 1, or in another
> stable-backportable patch? (I guess alternatively we can fix it with a
> custom patch in stable after it's been fixed in mainline, but that
> feels kinda hacky to me.)

Ah, right, damn, forgot to do that also in patch #1... I'll fix it
locally so I don't forget, will give others time to review and provide
feedback or acks, so I don't spam the list too much.

