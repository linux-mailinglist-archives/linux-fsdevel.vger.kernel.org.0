Return-Path: <linux-fsdevel+bounces-36861-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B0039E9FDE
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2024 20:52:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D042B282152
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2024 19:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 906B41991CA;
	Mon,  9 Dec 2024 19:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V6HkNDBs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D41FD1991AA
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Dec 2024 19:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733773939; cv=none; b=H0BhqUkyS47vbNewcJkBLaQ8zf9VT/Cqosc4RWAK2titdgbbqJW/iabDVQcH4kCMkj2I248t1vJ9fXAibnzJCdy9nbosYyrT1nTgvBB94qxTV+qB5/tzy6LuAQ+JcX8lpHcG8zCB+Ql+LzHwkIf97Gjm9OwihuEcUBfv44MZ2hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733773939; c=relaxed/simple;
	bh=YaZDSLDI2oVCWgZrIUosAjGfHbAoO0V3dEuIjI/cCSg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ah1fdJM9bc3mUT31Ml27aQ8UAL3gG7Lv7+Oitox6OUvgRfIFufUHrRO/FCSifcRsRg1l/HiJi0UuQZR1YbD01edx4BBXXdGMynJFg6mdE1DMIzeSb3KH7368wTDLqYntDTVa+3TV+a/CHhA8YA9jRmgAooAQ1xpyloYcwlZBQC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V6HkNDBs; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4675ae3dcf9so15593511cf.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Dec 2024 11:52:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733773935; x=1734378735; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rCOM2ni8fkyD8MPlilBuWQShjaAJBcn+pAWQjviDykI=;
        b=V6HkNDBs1QlFgapEHmQwyluy0vSKeZQybgAepDblCH1ItBd3Eiq7yzzb+MJlb1c0eD
         ZNyx4INaIkKY9TOyfqXNm56bEeQdUPRlHK/1p8j6RmRxEQQKVz5RmZn6yTEv267wFMR1
         0g4cFONlmkIffmnoPMrVu9y2QyxCJX+MvF4d+7Yk1UfL6ckd5+LtAqfkD5er6NsS9FG3
         aLUH7KY5Z8ixZqULNZp7MU7uS0Jr9MfIPUz0LUpDiib642efbS/KXI72mSCm0180s2A1
         +TjeYynWX5nXNmw4bHxtmjDQsdM0g0bxIVS9EpIAiMsu/0nAd3lp+MMHMQj404HKQ+Rx
         3PWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733773935; x=1734378735;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rCOM2ni8fkyD8MPlilBuWQShjaAJBcn+pAWQjviDykI=;
        b=jSDNmZ3PNaD3zoQIEPjo/FjhJm18q/N/UySDEQo3kRzuO0Q2KPB1NFJAYp18v8dgbV
         iewSdzpwu4juDATgUTRrk9doKOw8H4BnSs3AFEUdVaLxvg2bgoK50i3jNfmhDo0sKfpx
         p1Q6hbzAl7Uul7SJwDeFoQDZS7AO2Q0CmowqccxFCPe0kSWlyRt6a7lG8rWIqjSsJvpN
         1/SiipObNTTLLY19glZ3edImDS0DoZHEupNKkU1H6seicDIq3p7d3P/8ulWdNrSA3tSW
         LsBpYFOrv/GV4br6jn+AeGsY+tg3U2qp0UTdKWtDt3/toLKm5I78Ap4TJKD/QBgo1Xqi
         TUHA==
X-Forwarded-Encrypted: i=1; AJvYcCXspPh8pqUBeiAePi8Vze4U0VUap6yDoJs5Z6rpdxFBdQniCiWR9x5k51vhAHG1LB0L3PiuZiL7gYQz3c/K@vger.kernel.org
X-Gm-Message-State: AOJu0YwoXODbnduH61E8Fn64UZ8TYk+86bRLGYkUvq/GOtHoXwwa0vBz
	eAeZI0Ku7PKjM8n1h4DPuhBiK/k7D6ym6GeVjAsKFG9tlxqAp7iGcyY+D0dh6HbOKOcgw3R2oNq
	HXvtTa2CdEG/sV04ac+Z+aj/UiMs=
X-Gm-Gg: ASbGncsiAuYoUX3tfbIOaGfn0grw1L+abIPOrqTqtsrTYwMdVDTeBYQgYboKM37fej5
	DUbXJ0XF3yQC//a69BK81KJlsij0xb4qzcphR/LYRiwXi7aE=
X-Google-Smtp-Source: AGHT+IGIvS+Ljps0QH6oCQrSHZtwm6Rcj+IxxTp0sCqKhC5OzrJW9j1tURe0ilg0hSW/YTaGkyteig1oWHIy0AhiHaU=
X-Received: by 2002:a05:622a:188c:b0:466:9507:624d with SMTP id
 d75a77b69052e-46771efb8acmr31571561cf.27.1733773935603; Mon, 09 Dec 2024
 11:52:15 -0800 (PST)
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
 <CAJnrk1apXjQw7LEgSTmjt1xywzjp=+QMfYva4k1x=H0q2S6mag@mail.gmail.com>
In-Reply-To: <CAJnrk1apXjQw7LEgSTmjt1xywzjp=+QMfYva4k1x=H0q2S6mag@mail.gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Mon, 9 Dec 2024 11:52:04 -0800
Message-ID: <CAJnrk1YfeNNpt2puwaMRcpDefMVg1AhjYNY4ZsKNqr85=WLXDg@mail.gmail.com>
Subject: Re: silent data corruption in fuse in rc1
To: =?UTF-8?Q?Malte_Schr=C3=B6der?= <malte.schroeder@tnxip.de>
Cc: Josef Bacik <josef@toxicpanda.com>, Matthew Wilcox <willy@infradead.org>, 
	Kent Overstreet <kent.overstreet@linux.dev>, Miklos Szeredi <mszeredi@redhat.com>, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 9, 2024 at 10:47=E2=80=AFAM Joanne Koong <joannelkoong@gmail.co=
m> wrote:
>
> On Mon, Dec 9, 2024 at 9:07=E2=80=AFAM Malte Schr=C3=B6der <malte.schroed=
er@tnxip.de> wrote:
> >
> > On 09/12/2024 16:48, Josef Bacik wrote:
> > > On Mon, Dec 09, 2024 at 03:28:14PM +0000, Matthew Wilcox wrote:
> > >> On Mon, Dec 09, 2024 at 09:49:48AM -0500, Josef Bacik wrote:
> > >>>> Ha! This time I bisected from f03b296e8b51 to d1dfb5f52ffc. I ende=
d up
> > >>>> with 3b97c3652d91 as the culprit.
> > >>> Willy, I've looked at this code and it does indeed look like a 1:1 =
conversion,
> > >>> EXCEPT I'm fuzzy about how how this works with large folios.  Previ=
ously, if we
> > >>> got a hugepage in, we'd get each individual struct page back for th=
e whole range
> > >>> of the hugepage, so if for example we had a 2M hugepage, we'd fill =
in the
> > >>> ->offset for each "middle" struct page as 0, since obviously we're =
consuming
> > >>> PAGE_SIZE chunks at a time.
> > >>>
> > >>> But now we're doing this
> > >>>
> > >>>     for (i =3D 0; i < nfolios; i++)
> > >>>             ap->folios[i + ap->num_folios] =3D page_folio(pages[i])=
;
> > >>>
> > >>> So if userspace handed us a 2M hugepage, page_folio() on each of th=
e
> > >>> intermediary struct page's would return the same folio, correct?  S=
o we'd end up
> > >>> with the wrong offsets for our fuse request, because they should be=
 based from
> > >>> the start of the folio, correct?
> > >> I think you're 100% right.  We could put in some nice asserts to che=
ck
> > >> this is what's happening, but it does seem like a rather incautious
> > >> conversion.  Yes, all folios _in the page cache_ for fuse are small,=
 but
> > >> that's not guaranteed to be the case for folios found in userspace f=
or
> > >> directio.  At least the comment is wrong, and I'd suggest the code i=
s too.
> > > Ok cool, Malte can you try the attached only compile tested patch and=
 see if the
> > > problem goes away?  Thanks,
> > >
> > > Josef
> > >
> > > diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> > > index 88d0946b5bc9..c4b93ead99a5 100644
> > > --- a/fs/fuse/file.c
> > > +++ b/fs/fuse/file.c
> > > @@ -1562,9 +1562,19 @@ static int fuse_get_user_pages(struct fuse_arg=
s_pages *ap, struct iov_iter *ii,
> > >               nfolios =3D DIV_ROUND_UP(ret, PAGE_SIZE);
> > >
> > >               ap->descs[ap->num_folios].offset =3D start;
> > > -             fuse_folio_descs_length_init(ap->descs, ap->num_folios,=
 nfolios);
> > > -             for (i =3D 0; i < nfolios; i++)
> > > -                     ap->folios[i + ap->num_folios] =3D page_folio(p=
ages[i]);
> > > +             for (i =3D 0; i < nfolios; i++) {
> > > +                     struct folio *folio =3D page_folio(pages[i]);
> > > +                     unsigned int offset =3D start +
> > > +                             (folio_page_idx(folio, pages[i]) << PAG=
E_SHIFT);
> > > +                     unsigned int len =3D min_t(unsigned int, ret, f=
olio_size(folio) - offset);
> > > +
> > > +                     len =3D min_t(unsigned int, len, PAGE_SIZE);
> > > +
> > > +                     ap->descs[ap->num_folios + i].offset =3D offset=
;
> > > +                     ap->descs[ap->num_folios + i].length =3D len;
> > > +                     ap->folios[i + ap->num_folios] =3D folio;
> > > +                     start =3D 0;
> > > +             }
> > >
> > >               ap->num_folios +=3D nfolios;
> > >               ap->descs[ap->num_folios - 1].length -=3D
> >
> > The problem persists with this patch.
> >

Malte, could you try Josef's patch except with that last line
"ap->descs[ap->num_pages - 1].length  -=3D (PAGE_SIZE - ret) &
(PAGE_SIZE - 1);" also removed? I think we need that line removed as
well since that does a "-=3D" instead of a "=3D" and
ap->descs[ap->num_folios - 1].length gets set inside the for loop.

In the meantime, I'll try to get a local repro running on fsx so that
you don't have to keep testing out repos for us.

Thanks,
Joanne
>
> Catching up on this thread now. I'll investigate this today.
>
> >
> > /Malte
> >

