Return-Path: <linux-fsdevel+bounces-41431-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 46AA1A2F68E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2025 19:14:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87D057A1F6C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2025 18:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BB0B255E4B;
	Mon, 10 Feb 2025 18:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YBRFAMbl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F7322E412;
	Mon, 10 Feb 2025 18:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739211246; cv=none; b=L38449pxsy9Hgfi6v8dwg70p37Z74Dgu+iROtRQ5/KvSAKSF8vE5B6XEg0ILmCL4ObDUeP/ItU3sv08fiMiOaFfCKnX70r4DQqwVTd+zNdhyCwzRFkmVTTXpkrUdb7H7eEQ/jDVBMl19hSiOG7rTmtsoC5UHS99oMfEXs93FA9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739211246; c=relaxed/simple;
	bh=VpbyY1Ghxa+2INjf8c3BfLUMYL0IPb0Mb1W29+1Ek4A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=geFeoWwwMyn9U5pKLRvoceMgBjmpXXsrCHcNaxyxhKuPD2lzmOu63eM4EcQvLl7HFgaf8sZc+aMB6AiT2/s4DLXbrKupzkaiE5RHsuxQh2iWCYuD8QXQR9hiFUc8rkTpSPfy76ZjIrexR8ebjpc3dDEYU/ZQvfdTaf5KYiSRf/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YBRFAMbl; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-471a01060f3so1807151cf.0;
        Mon, 10 Feb 2025 10:14:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739211244; x=1739816044; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9GAon67fTF+Z/QksfmcN1Wg362w+GO/sYKO+48/Qp2g=;
        b=YBRFAMbljysCdAOobEFbrwcO2w1kQI8qtFhyjqLOr/zylmrSTdjSDHNO6uSxSovkaC
         mkVPFWyt3SJDqxEi901Me7kbkKKAEoG5lDz49Hsfpb4RXHD7BTPoqfw+3tvWRlfAR6K5
         rSa+J/66wXV14JNeqhuHorUmqcShi5EYRmz/E3I53h0PEWHd2qbyiHTscSLnBQX2KwK7
         Ie41D647kb5xX8ZjYy069OMGhkrAnfhN4c3vuMfrxddIMOI3MVviRsnsII6TYbh47/Wl
         a76hyM0Kt/TCScrQbBSES4qdu74PYNPcZlib69q1d/Q5wLURR5wJF/p7cJj6qVs2Yksi
         gsvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739211244; x=1739816044;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9GAon67fTF+Z/QksfmcN1Wg362w+GO/sYKO+48/Qp2g=;
        b=mk/DAVodbWVdNq6p0F47BJlLagZCUAUSyfO60FmMLJbmn6/8Bz7TbJBDn0jWH1ZhZe
         LUvTh5IM/dLMc3Oly590+xv5Ndoc78gkAq6V9BDvG139rqqFN/KMt3cF/VaPQPKyPBFJ
         15E99eqmQ6I5hqBBM8dvlw9rOS+9I9LsoVJ9fR1i8RmRU0iP6mubji8awYqYzy2WCkre
         Bg4TR1NZ2Bb7z5HK+LnQ0KCPDScGWFd8HPxEg01iPn4uYlX9JZSrICr0V+K7Y0ZLK3Ty
         sHoMbsGSFOQrZ9JnZqmAFrpsLX7KK1eHEBvJ6Dr7xtWsgGRD+WGwfY4r2V2bwg/kU8cy
         /aVQ==
X-Forwarded-Encrypted: i=1; AJvYcCVX8VWmsEID2iRZhzapRWbWHZdLb56ZCXBemPrIk9gwm1qYkXkFuFZniOYkP38ysImYttgyFZg2wdDcC3Vt@vger.kernel.org, AJvYcCWae+3gWKpeijNJrGAnUt3DDTEqQFVdzaOaao9Jl4iOjDQrHy5UJpQDUD+4ebmDsgDX34EIJqB9KOD26Bhz@vger.kernel.org
X-Gm-Message-State: AOJu0Yz46Rcvx4ficOG5W/JDvYK4xUE/b9RiyMBKdUdfp8N5zlAQ/Kn2
	avL4MdNuAXCV3UciWe9v+jQqM8PuJj5aAHgUtp8ha8zegBt19mhYGE1wQMwDHnHpwmUu/IFIxNC
	PGpPQ9aku+qc/+rT9J2ts9zs1Zuw=
X-Gm-Gg: ASbGncv0JR3DgEWKWIGeu4+Tscbp3IVOIoMbTIkwuFcQQtmnw9nm/piMs/NsEEPUREQ
	Zz3kYdg8bzsK9sbUKKVrb4J/tAwKeVDLIy0Wp3QYUPdtwMKA9bQSq13iC8i/HM0Ke6Tc2/Hbxzv
	fPl+v7oTHoFmBD
X-Google-Smtp-Source: AGHT+IHw7qyHtO12sVFUjn+ibik5SqtRzWi/aq5Gq5MrMU1FTFBx2agmOq4G5FuHhwgn6PL4m2EdV38mrVh7lb23k5M=
X-Received: by 2002:a05:622a:1f06:b0:471:997f:39ec with SMTP id
 d75a77b69052e-471997f3e9cmr41192771cf.30.1739211243688; Mon, 10 Feb 2025
 10:14:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2f681f48-00f5-4e09-8431-2b3dbfaa881e@heusel.eu>
 <CAJfpegtaTET+R7Tc1MozTQWmYfgsRp6Bzc=HKonO=Uq1h6Nzgw@mail.gmail.com>
 <9cd88643-daa8-4379-be0a-bd31de277658@suse.cz> <20250207172917.GA2072771@perftesting>
 <8f7333f2-1ba9-4df4-bc54-44fd768b3d5b@suse.cz> <CAJnrk1aNVMCfTjL0vo-Qki68-5t1W+6-bJHg+x67kHEo_-q0Eg@mail.gmail.com>
 <Z6ct4bEdeZwmksxS@casper.infradead.org> <CAJnrk1aY0ZFcS4JvmJL=icigencsCD8g4qmZiTuoPWj2S2Y_LQ@mail.gmail.com>
 <81298bd1-e630-4940-ae5b-7882576b6bf4@suse.cz>
In-Reply-To: <81298bd1-e630-4940-ae5b-7882576b6bf4@suse.cz>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Mon, 10 Feb 2025 10:13:51 -0800
X-Gm-Features: AWEUYZnd9EDodvxc9WlMkRecfw_ALKaRXXREZ3ZlXO6DJg6l6ogEuCyV301mPcc
Message-ID: <CAJnrk1aBc5uvL78s3kdpXojH-B11wtOPSDUJ0XnCzmHH+eO2Nw@mail.gmail.com>
Subject: Re: [REGRESSION][BISECTED] Crash with Bad page state for FUSE/Flatpak
 related applications since v6.13
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Matthew Wilcox <willy@infradead.org>, Josef Bacik <josef@toxicpanda.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, Christian Heusel <christian@heusel.eu>, 
	Miklos Szeredi <mszeredi@redhat.com>, regressions@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-mm <linux-mm@kvack.org>, =?UTF-8?Q?Mantas_Mikul=C4=97nas?= <grawity@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 10, 2025 at 12:27=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> w=
rote:
>
> On 2/8/25 16:46, Joanne Koong wrote:
> > On Sat, Feb 8, 2025 at 2:11=E2=80=AFAM Matthew Wilcox <willy@infradead.=
org> wrote:
> >>
> >> On Fri, Feb 07, 2025 at 04:22:56PM -0800, Joanne Koong wrote:
> >> > > Thanks, Josef. I guess we can at least try to confirm we're on the=
 right track.
> >> > > Can anyone affected see if this (only compile tested) patch fixes =
the issue?
> >> > > Created on top of 6.13.1.
> >> >
> >> > This fixes the crash for me on 6.14.0-rc1. I ran the repro using
> >> > Mantas's instructions for Obfuscate. I was able to trigger the crash
> >> > on a clean build and then with this patch, I'm not seeing the crash
> >> > anymore.
> >>
> >> Since this patch fixes the bug, we're looking for one call to folio_pu=
t()
> >> too many.  Is it possibly in fuse_try_move_page()?  In particular, thi=
s
> >> one:
> >>
> >>         /* Drop ref for ap->pages[] array */
> >>         folio_put(oldfolio);
> >>
> >> I don't know fuse very well.  Maybe this isn't it.
> >
> > Yeah, this looks it to me. We don't grab a folio reference for the
> > ap->pages[] array for readahead and it tracks with Mantas's
> > fuse_dev_splice_write() dmesg. this patch fixed the crash for me when
> > I tested it yesterday:
> >
> > diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> > index 7d92a5479998..172cab8e2caf 100644
> > --- a/fs/fuse/file.c
> > +++ b/fs/fuse/file.c
> > @@ -955,8 +955,10 @@ static void fuse_readpages_end(struct fuse_mount
> > *fm, struct fuse_args *args,
> >                 fuse_invalidate_atime(inode);
> >         }
> >
> > -       for (i =3D 0; i < ap->num_folios; i++)
> > +       for (i =3D 0; i < ap->num_folios; i++) {
> >                 folio_end_read(ap->folios[i], !err);
> > +               folio_put(ap->folios[i]);
> > +       }
> >         if (ia->ff)
> >                 fuse_file_put(ia->ff, false);
> >
> > @@ -1049,6 +1051,7 @@ static void fuse_readahead(struct readahead_contr=
ol *rac)
> >
> >                 while (ap->num_folios < cur_pages) {
> >                         folio =3D readahead_folio(rac);
> > +                       folio_get(folio);
>
> This is almost the same as my patch, but balances the folio_put() in
> readahead_folio() with another folio_get(), while mine uses
> __readahead_folio() that does not do folio_put() in the first place.
>
> But I think neither patch proves the extraneous folio_put() comes from
> fuse_try_move_page().
>
> >                         ap->folios[ap->num_folios] =3D folio;
> >                         ap->descs[ap->num_folios].length =3D folio_size=
(folio);
> >                         ap->num_folios++;
> >
> >
> > I reran it just now with a printk by that ref drop in
> > fuse_try_move_page() and I'm indeed seeing that path get hit.
>
> It might get hit, but is it hit in the readahead paths? One way to test
> would be to instead of yours above or mine change, to stop doing the
> foio_put() in fuse_try_move_page(). But maybe it's called also from other
> contexts that do expect it, and will leak memory otherwise.

When I tested it a few days ago, I printk-ed the address of the folio
and it matched in fuse_readahead() and try_move_page(). I think that
proves that the extra folio_put() came from fuse_try_move_page()
through the readahead path.

>
> > Not sure why fstests didn't pick this up though since splice is
> > enabled by default in passthrough_hp, i'll look into this next week.
> >
>

