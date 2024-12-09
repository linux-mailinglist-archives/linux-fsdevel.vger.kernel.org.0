Return-Path: <linux-fsdevel+bounces-36857-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B3F819E9E4B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2024 19:47:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A0231883AEB
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2024 18:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E44B15666A;
	Mon,  9 Dec 2024 18:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HmdeRUcO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F8013B59A
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Dec 2024 18:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733770069; cv=none; b=QKUDyj8jvX4yyFHd/J6kMMEQK+Uym8gq/9PrfLPLs9iTvWJ2ebKeHsJUW/QLM8jvbBBshMeqbePaYmtLYHoUu0PjqukDgIhZdn7t8pYLAZ+bB5nsci+2/YdDaM4V2gzR/9XgOx3Jq78lq+vWw0g2DLX04RQwdsi8X5BO/OTzhR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733770069; c=relaxed/simple;
	bh=ywfsShpjQduf9zOXZMIUaYNF6HKmXYQciqrsdKnSJ20=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RmhDR7HxxZLI3frLn450Y+qjWKWlcjrcIgYwSsGpVSIDyxM/xeOnjQj9wxS1eF9mufBO4TDGGrj4gHJbhnXeMSZ0EXbpK90M+hOOvjn5ymWVIiX1T2FKa2//86VYrq8U88AFcqQtMe6HLjWh8E5AzCmpq9b9+JwirDsIylac/eI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HmdeRUcO; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-46753242ef1so27529371cf.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Dec 2024 10:47:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733770067; x=1734374867; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TMObDXodcGKvp5YyM9xIKEHYBe0ifrzxcSj8g+zyDF0=;
        b=HmdeRUcOKFYJo+ygSIJ+/2rH/5HoYgGHsEoMexvOZDSE1lz4znzPu6gQj2KYmX5ZNe
         a7vXI8jK17lXwdxtQm51rYl6R1O4M7p7OsPbs8USiTyejTU3ydupRcfQxu226URy9kl4
         44nEkVs9rtubHfHz59T1ajsTdI9Cgq8mXpdkRhy9YkCPn6Q0V6UI+DP6yr57SOUKGEQV
         5HkFt/Pk66Digx6UdwikVllqAnxzUvbX/vYTVaFo2FSby68Vd1rDt2m4QEzR30oszi+G
         AK+Efsa3RIgSQDjo7wN9ZNUKAYVkMH6sgISKttfMLZeVPr0Jpm0kAao1T0tsvm4jvrz1
         LwbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733770067; x=1734374867;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TMObDXodcGKvp5YyM9xIKEHYBe0ifrzxcSj8g+zyDF0=;
        b=O6GP1wApp/lVTHFe0vcDFOrHpO0/tEbaeQX9uOTmzeueeyCTN6P3fP8XxmxGcea5ee
         v3Fp5bUq7vw5VbCpZ4znpKGpNJ1KByBQ91Ln1H7TzaDX45e8Zvi7kOCJDVzYbFTGUlWO
         LtbyUQAfGkdtY43oLHoKU3yEuWYSH7aYHCf6UdcQ2X2phvZgvsj72ZYVkLji9rbv6czS
         qcQuvzrQj5rUqViKUV7ZCYSoi8mLkxE4mfK0vfzUUDNhuMlZFWd41QEzgwFVTg6UIcFt
         EncgMlv0rBvWq4dk5kOxqJMpDsA97QzvTejmbQoo+Lccfrcpxtp8lrIIzC6Hy0em2tfY
         cRCg==
X-Forwarded-Encrypted: i=1; AJvYcCVqxZDnmD3ffq4Y1mdEdGwFbUaU9p1IEn553Btzk+H69xP5EQEsCNg4Jc1zPEjOYuBz1Bb5tIQx2f+ISnRc@vger.kernel.org
X-Gm-Message-State: AOJu0YzUYMy9AJLsf1qJm70cz7/t6T/ic8FNyHbJgBrR5CGcoQb6BJ4l
	pF/6EhlM8VNn8uGMSMXDq+A3hQoIxybJSgt6Utckp8WgIBoXsrPYb+CkZwdGmpMdZOnC1rJEP+s
	zRfir55rOPrZ1QSWm1IQsi+2wAUk=
X-Gm-Gg: ASbGncsV8h7MF6f4hrzTNaJ7VhwpSneqDY/YrDVQanHSvdw1GZDYoscxDKMLsE/ff8D
	DUZ+YZNpLA27O5Kwl1DlsyA1eSrHsFhNww2wp9HvPugWaWYjVoDo=
X-Google-Smtp-Source: AGHT+IGJytVZM4HFmeEty8gGbHxwxdbWBbu0o5d6WXFfvwalMdc2PSej1wQXZJcFbiniM4de7khRu0OUG6jBjrFuWv0=
X-Received: by 2002:a05:622a:44e:b0:467:6692:c18a with SMTP id
 d75a77b69052e-46771ecf7efmr30427431cf.13.1733770066761; Mon, 09 Dec 2024
 10:47:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <p3iss6hssbvtdutnwmuddvdadubrhfkdoosgmbewvo674f7f3y@cwnwffjqltzw>
 <cb2ceebc-529e-4ed1-89fa-208c263f24fd@tnxip.de> <Z1T09X8l3H5Wnxbv@casper.infradead.org>
 <68a165ea-e58a-40ef-923b-43dfd85ccd68@tnxip.de> <2143b747-f4af-4f61-9c3e-a950ab9020cf@tnxip.de>
 <20241209144948.GE2840216@perftesting> <Z1cMjlWfehN6ssRb@casper.infradead.org>
 <20241209154850.GA2843669@perftesting> <4707aea6-addb-4dc3-96f7-691d2e94ab25@tnxip.de>
In-Reply-To: <4707aea6-addb-4dc3-96f7-691d2e94ab25@tnxip.de>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Mon, 9 Dec 2024 10:47:35 -0800
Message-ID: <CAJnrk1apXjQw7LEgSTmjt1xywzjp=+QMfYva4k1x=H0q2S6mag@mail.gmail.com>
Subject: Re: silent data corruption in fuse in rc1
To: =?UTF-8?Q?Malte_Schr=C3=B6der?= <malte.schroeder@tnxip.de>
Cc: Josef Bacik <josef@toxicpanda.com>, Matthew Wilcox <willy@infradead.org>, 
	Kent Overstreet <kent.overstreet@linux.dev>, Miklos Szeredi <mszeredi@redhat.com>, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 9, 2024 at 9:07=E2=80=AFAM Malte Schr=C3=B6der <malte.schroeder=
@tnxip.de> wrote:
>
> On 09/12/2024 16:48, Josef Bacik wrote:
> > On Mon, Dec 09, 2024 at 03:28:14PM +0000, Matthew Wilcox wrote:
> >> On Mon, Dec 09, 2024 at 09:49:48AM -0500, Josef Bacik wrote:
> >>>> Ha! This time I bisected from f03b296e8b51 to d1dfb5f52ffc. I ended =
up
> >>>> with 3b97c3652d91 as the culprit.
> >>> Willy, I've looked at this code and it does indeed look like a 1:1 co=
nversion,
> >>> EXCEPT I'm fuzzy about how how this works with large folios.  Previou=
sly, if we
> >>> got a hugepage in, we'd get each individual struct page back for the =
whole range
> >>> of the hugepage, so if for example we had a 2M hugepage, we'd fill in=
 the
> >>> ->offset for each "middle" struct page as 0, since obviously we're co=
nsuming
> >>> PAGE_SIZE chunks at a time.
> >>>
> >>> But now we're doing this
> >>>
> >>>     for (i =3D 0; i < nfolios; i++)
> >>>             ap->folios[i + ap->num_folios] =3D page_folio(pages[i]);
> >>>
> >>> So if userspace handed us a 2M hugepage, page_folio() on each of the
> >>> intermediary struct page's would return the same folio, correct?  So =
we'd end up
> >>> with the wrong offsets for our fuse request, because they should be b=
ased from
> >>> the start of the folio, correct?
> >> I think you're 100% right.  We could put in some nice asserts to check
> >> this is what's happening, but it does seem like a rather incautious
> >> conversion.  Yes, all folios _in the page cache_ for fuse are small, b=
ut
> >> that's not guaranteed to be the case for folios found in userspace for
> >> directio.  At least the comment is wrong, and I'd suggest the code is =
too.
> > Ok cool, Malte can you try the attached only compile tested patch and s=
ee if the
> > problem goes away?  Thanks,
> >
> > Josef
> >
> > diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> > index 88d0946b5bc9..c4b93ead99a5 100644
> > --- a/fs/fuse/file.c
> > +++ b/fs/fuse/file.c
> > @@ -1562,9 +1562,19 @@ static int fuse_get_user_pages(struct fuse_args_=
pages *ap, struct iov_iter *ii,
> >               nfolios =3D DIV_ROUND_UP(ret, PAGE_SIZE);
> >
> >               ap->descs[ap->num_folios].offset =3D start;
> > -             fuse_folio_descs_length_init(ap->descs, ap->num_folios, n=
folios);
> > -             for (i =3D 0; i < nfolios; i++)
> > -                     ap->folios[i + ap->num_folios] =3D page_folio(pag=
es[i]);
> > +             for (i =3D 0; i < nfolios; i++) {
> > +                     struct folio *folio =3D page_folio(pages[i]);
> > +                     unsigned int offset =3D start +
> > +                             (folio_page_idx(folio, pages[i]) << PAGE_=
SHIFT);
> > +                     unsigned int len =3D min_t(unsigned int, ret, fol=
io_size(folio) - offset);
> > +
> > +                     len =3D min_t(unsigned int, len, PAGE_SIZE);
> > +
> > +                     ap->descs[ap->num_folios + i].offset =3D offset;
> > +                     ap->descs[ap->num_folios + i].length =3D len;
> > +                     ap->folios[i + ap->num_folios] =3D folio;
> > +                     start =3D 0;
> > +             }
> >
> >               ap->num_folios +=3D nfolios;
> >               ap->descs[ap->num_folios - 1].length -=3D
>
> The problem persists with this patch.
>

Catching up on this thread now. I'll investigate this today.

>
> /Malte
>

