Return-Path: <linux-fsdevel+bounces-40651-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 45C9AA263B3
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2025 20:23:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE2B3164022
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2025 19:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 596821DC9B5;
	Mon,  3 Feb 2025 19:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SRzxexQ4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0319B1B6CFB;
	Mon,  3 Feb 2025 19:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738610614; cv=none; b=O6GCObhCZ4GeHozsWMzsfZdRRMw2OUoV5bE0qskxhNeOmVAVvryGbqjYaSOTnm0padyeZNgE8fNrMGAAs00j5PlRjxC9i9nGc/Ar7IqiDxJCg+psMcO3os9qBJQ5y5sUxkh21yezmfp+0ih+S4zhcKP78SGPLxzC8Np63sybYyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738610614; c=relaxed/simple;
	bh=VhKvB0ZcKoBC9RLfFAiQBCZDg2Hbp5AxlT/JKLATwQ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GI49/srQ32mbDzAUWHc9lXcfhfgMwM2FZb3Dz8v+KNfp1MHmdIVT4am/slx5zQ8Hm2FpZBoI1AxuG00Tto/txe0PFmV1PgssRNq6rDw6tFSHRZ2aW5l3glhsAmV5qVznTPxqwHHU4IoNcWDt9Yw/MqdB84hqvj4uYE+GLXEeafU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SRzxexQ4; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-467a37a2a53so56335211cf.2;
        Mon, 03 Feb 2025 11:23:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738610612; x=1739215412; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rohxl4zZiS/taVuHO00Hh6zhOctYPzquWwwGHx3zWmw=;
        b=SRzxexQ4PJFruXe5mPO4WX/MOanWnhBqyc1ySD9Durm6ydkP79hPzg70zMnh5R43Z1
         qB1V5JxuHY2GDPL7Aes8B5WNwlDeO7YQm8ll21UZainySupTVIBnnW00o55dNFO9jXBJ
         c2Uq5rRLaTKf3UepvuwrsUy2s2gUix9Jr+87wDfBUUaPWaQHAt6XI+fk5P6NxQFz2EiI
         8X6qwqhM1uNFlXuPzhKObsXKpbjgtql4G6MARkH1FeWCioOM40ljQ4LnZI2sVP5LO9xa
         kqxeYH4ygMyFXT978Gj9rBYALlA564tqy55fhMoU1GTkviRDqx6DAvYuLSuzF7FYTiT6
         qU2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738610612; x=1739215412;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rohxl4zZiS/taVuHO00Hh6zhOctYPzquWwwGHx3zWmw=;
        b=AcAtRtr3U/kZsAxEMYirS2EmQEJmzmsg3FBds60cUiUqSkcMRlrU+CM9Yput2Z4QrP
         Sg/na0DXntnVB6UV4aV6QZI5KsvExipZd6YQxSEUkzpHMzeuRT9cy6IAMmwQ3kzG510U
         Futn77ZKW08vgscS9U3nI7QEmRwQ3Qb/puXXcQeKkGHlls6D79gkqLiCItoKo6PQb49S
         ZYNP2vfjpuvqIb8iMSwy9GqLQk/sjpkzXS1SfM9/8yVpwIREK/zGMTJXf5MDdXJ7jhF0
         fwP3q7G4uvmL1lNORksE/jK8gtCgOthssVNKhav561CIqqEpwu6Ki0NLvN7VzqdjaKAj
         6mPQ==
X-Forwarded-Encrypted: i=1; AJvYcCVjQ+ysuTLL3xcoP84gvAI54QAzRZsSI5aQBvDKCyt2678tEWHFGtCWPmJTRiLbIV6wkknNWEKG@vger.kernel.org, AJvYcCXHHc/BCKLveElxlZLvbmOVEpPV0JDHz+NR67CKXRKQ0jq8c1+EQIr8GAndosbuJKF3qw3NK/mRVqJYnr1y8w==@vger.kernel.org
X-Gm-Message-State: AOJu0YyGlkZC31EH2AAmO+9xvtO7ePvs/8oi7H7M0a+c38QiV4Szzo7T
	vM91W0bkPik5cvDB5V0wO+MWYgcxqtnMIm0A46FtYJLI3GJfDGt+3pUAZDUOx0sv+RyRjDW5DUo
	c4SX45qqrtj9aCOVTRxhsiyP+Wyc=
X-Gm-Gg: ASbGncuJtmxgoSusK2rNqO4Pi63PPasB9LEzQnyNkvLfdplhQHpsMrZI5IAG278r+ly
	eoYb2xOhY1Gp4KffSVOoQYDStyp7uFwIOIYSDo01fc6Da6maaDAQwYBOF3GEQuIWMAmGl/c7ZWE
	c+ruIOdqPFEyNu
X-Google-Smtp-Source: AGHT+IELbzKlxD9T4JRY/NUSsk5p6dTcI/VKsJlC9fp4qfZ76mkypbl4/H07CDFS3fAz7iMqK8pxy2/nkmq2ONkSI9Y=
X-Received: by 2002:a05:622a:59ca:b0:46c:870f:f621 with SMTP id
 d75a77b69052e-46fd0ace15amr319280841cf.26.1738610611681; Mon, 03 Feb 2025
 11:23:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250121215641.1764359-1-joannelkoong@gmail.com>
 <20250121215641.1764359-2-joannelkoong@gmail.com> <20250202142518.r3xvf7mvfo2nhb7t@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <CAJnrk1YwBJQnFwYBcO50Xy2dA6df_SqQsHdpLux4wa-Yw5rXdg@mail.gmail.com> <20250203185948.GB134532@frogsfrogsfrogs>
In-Reply-To: <20250203185948.GB134532@frogsfrogsfrogs>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Mon, 3 Feb 2025 11:23:20 -0800
X-Gm-Features: AWEUYZmS0cbLm1pIPu12q3pW75kSLXikUiNL6GMOBkdw2AQ90lN_BTxgV8WUdVA
Message-ID: <CAJnrk1bX27KAOxChMs5pRNmrjjuxjYu11GG==vTN0sa8Qf2Uqw@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] fsx: support reads/writes from buffers backed by hugepages
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, bfoster@redhat.com, nirjhar@linux.ibm.com, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 3, 2025 at 10:59=E2=80=AFAM Darrick J. Wong <djwong@kernel.org>=
 wrote:
>
> On Mon, Feb 03, 2025 at 10:04:04AM -0800, Joanne Koong wrote:
> > On Sun, Feb 2, 2025 at 6:25=E2=80=AFAM Zorro Lang <zlang@redhat.com> wr=
ote:
> > >
> > > On Tue, Jan 21, 2025 at 01:56:40PM -0800, Joanne Koong wrote:
> > > > Add support for reads/writes from buffers backed by hugepages.
> > > > This can be enabled through the '-h' flag. This flag should only be=
 used
> > > > on systems where THP capabilities are enabled.
> > > >
> > > > This is motivated by a recent bug that was due to faulty handling o=
f
> > > > userspace buffers backed by hugepages. This patch is a mitigation
> > > > against problems like this in the future.
> > > >
> > > > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > > > Reviewed-by: Brian Foster <bfoster@redhat.com>
> > > > Reviewed-by: Darrick J. Wong <djwong@kernel.org>
> > > > ---
> > >
> > > Those two test cases fail on old system which doesn't support
> > > MADV_COLLAPSE:
> > >
> > >    fsx -N 10000 -l 500000 -h
> > >   -fsx -N 10000 -o 8192 -l 500000 -h
> > >   -fsx -N 10000 -o 128000 -l 500000 -h
> > >   +MADV_COLLAPSE not supported. Can't support -h
> > >
> > > and
> > >
> > >    fsx -N 10000 -l 500000 -r PSIZE -t BSIZE -w BSIZE -Z -R -W -h
> > >   -fsx -N 10000 -o 8192 -l 500000 -r PSIZE -t BSIZE -w BSIZE -Z -R -W=
 -h
> > >   -fsx -N 10000 -o 128000 -l 500000 -r PSIZE -t BSIZE -w BSIZE -Z -R =
-W -h
> > >   +mapped writes DISABLED
> > >   +MADV_COLLAPSE not supported. Can't support -h
> > >
> > > I'm wondering ...
> > >
> > > >  ltp/fsx.c | 166 +++++++++++++++++++++++++++++++++++++++++++++++++-=
----
> > > >  1 file changed, 153 insertions(+), 13 deletions(-)
> > > >
> > > > diff --git a/ltp/fsx.c b/ltp/fsx.c
> > > > index 41933354..3be383c6 100644
> > > > --- a/ltp/fsx.c
> > > > +++ b/ltp/fsx.c
> > > >  static struct option longopts[] =3D {
> > > >       {"replay-ops", required_argument, 0, 256},
> > > >       {"record-ops", optional_argument, 0, 255},
> > > > @@ -2883,7 +3023,7 @@ main(int argc, char **argv)
> > > >       setvbuf(stdout, (char *)0, _IOLBF, 0); /* line buffered stdou=
t */
> > > >
> > > >       while ((ch =3D getopt_long(argc, argv,
> > > > -                              "0b:c:de:fg:i:j:kl:m:no:p:qr:s:t:uw:=
xyABD:EFJKHzCILN:OP:RS:UWXZ",
> > > > +                              "0b:c:de:fg:hi:j:kl:m:no:p:qr:s:t:uw=
:xyABD:EFJKHzCILN:OP:RS:UWXZ",
> > > >                                longopts, NULL)) !=3D EOF)
> > > >               switch (ch) {
> > > >               case 'b':
> > > > @@ -2916,6 +3056,14 @@ main(int argc, char **argv)
> > > >               case 'g':
> > > >                       filldata =3D *optarg;
> > > >                       break;
> > > > +             case 'h':
> > > > +#ifndef MADV_COLLAPSE
> > > > +                     fprintf(stderr, "MADV_COLLAPSE not supported.=
 "
> > > > +                             "Can't support -h\n");
> > > > +                     exit(86);
> > > > +#endif
> > > > +                     hugepages =3D 1;
> > > > +                     break;
> > >
> > > ...
> > > if we could change this part to:
> > >
> > > #ifdef MADV_COLLAPSE
> > >         hugepages =3D 1;
> > > #endif
> > >         break;
> > >
> > > to avoid the test failures on old systems.
> > >
> > > Or any better ideas from you :)
> >
> > Hi Zorro,
> >
> > It looks like MADV_COLLAPSE was introduced in kernel version 6.1. What
> > do you think about skipping generic/758 and generic/759 if the kernel
> > version is older than 6.1? That to me seems more preferable than the
> > paste above, as the paste above would execute the test as if it did
> > test hugepages when in reality it didn't, which would be misleading.
>
> Now that I've gotten to try this out --
>
> There's a couple of things going on here.  The first is that generic/759
> and 760 need to check if invoking fsx -h causes it to spit out the
> "MADV_COLLAPSE not supported" error and _notrun the test.
>
> The second thing is that userspace programs can ensure the existence of
> MADV_COLLAPSE in multiple ways.  The first way is through sys/mman.h,
> which requires that the underlying C library headers are new enough to
> include a definition.  glibc 2.37 is new enough, but even things like
> Debian 12 and RHEL 9 aren't new enough to have that.  Other C libraries
> might not follow glibc's practice of wrapping and/or redefining symbols
> in a way that you hope is the same as...
>
> The second way is through linux/mman.h, which comes from the kernel
> headers package; and the third way is for the program to define it
> itself if nobody else does.
>
> So I think the easiest way to fix the fsx.c build is to include
> linux/mman.h in addition to sys/mman.h.  Sorry I didn't notice these

Thanks for your input. Do we still need sys/mman.h if linux/mman.h is added=
?

For generic/758 and 759, does it suffice to gate this on whether the
kernel version if 6.1+ and _notrun if not? My understanding is that
any kernel version 6.1 or newer will have MADV_COLLAPSE in its kernel
headers package and support the feature.


Thanks,
Joanne

> details when I reviewed your patch; I'm a little attention constrained
> ATM trying to get a large pile of bugfixes and redesigns reviewed so
> for-next can finally move forward again.
>
> --D
>
> >
> > Thanks,
> > Joanne
> >
> > >
> > > Thanks,
> > > Zorro
> > >
> > > >               case 'i':
> > > >                       integrity =3D 1;
> > > >                       logdev =3D strdup(optarg);
> > > > @@ -3229,15 +3377,7 @@ main(int argc, char **argv)
> > > >                       exit(95);
> > > >               }
> > > >       }
> > > > -     original_buf =3D (char *) malloc(maxfilelen);
> > > > -     for (i =3D 0; i < maxfilelen; i++)
> > > > -             original_buf[i] =3D random() % 256;
> > > > -     good_buf =3D (char *) malloc(maxfilelen + writebdy);
> > > > -     good_buf =3D round_ptr_up(good_buf, writebdy, 0);
> > > > -     memset(good_buf, '\0', maxfilelen);
> > > > -     temp_buf =3D (char *) malloc(maxoplen + readbdy);
> > > > -     temp_buf =3D round_ptr_up(temp_buf, readbdy, 0);
> > > > -     memset(temp_buf, '\0', maxoplen);
> > > > +     init_buffers();
> > > >       if (lite) {     /* zero entire existing file */
> > > >               ssize_t written;
> > > >
> > > > --
> > > > 2.47.1
> > > >
> > >

