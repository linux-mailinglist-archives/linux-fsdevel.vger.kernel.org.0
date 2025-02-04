Return-Path: <linux-fsdevel+bounces-40826-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C140CA27DC7
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 22:52:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34D973A5E7D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 21:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A18AA21A446;
	Tue,  4 Feb 2025 21:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gyy5IP9M"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CFF72B9BB;
	Tue,  4 Feb 2025 21:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738705965; cv=none; b=c6MkKQbqG9THZkfj6H4PnyxietsK23tFmhb5Rj3OrwvedvmLtobrpJ60fZVfl/zkoUnxfs971IT7TCSPu0G89mITWLYYClfrH3V1E0yu6XMVowc/aeD6H4L9C8JvJCsnCe80+mlv3Gpxde1ufhEmoLcTccbE4QABA0RE3s2o/cQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738705965; c=relaxed/simple;
	bh=Emh2g4WsTovX0lw5b42NOik56EBc4iFnQmI9xIBmi2A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rNYEKrcq8kvMn8ssodhV/7TTunTGBBK4aB66TAuM8ZeShVOUjnkzmZOgIwJpIJ7eO/gdxkZygD3ae15G5JK/c/bgV8yrnCFaXbfvgC3fPYxi3fusZ73OdRPqZ0lUL8UO0Yzaaj9os5Be9F6gL9ipyIuBqtjEgMRSNO+Pjz4n4Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gyy5IP9M; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5401c52000dso6641608e87.3;
        Tue, 04 Feb 2025 13:52:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738705960; x=1739310760; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Eru0pKCg71K/YJtbqyE+0IbsaUIxsNP7n0k8zmA6cmM=;
        b=Gyy5IP9MN4/egWY0y35rJTVIWxv6zwkz1Ui4fr0VEF5jW2V0iKGUsNISiPblAWpc8Y
         TKp4iaV+YnpRwR06lA3sfnyCU+7CJpk7IqcccgFkNic0DyR503iq7bBkWsW97M1Ooi5e
         AcmPyEXxBuonEoI2QmcMx15wyeiTbq1WJvIbQw13JMAXrtYaY2TLWPJmgUz3s4xSIHKt
         YkrJsw67y71dp/jbZMgP8a/qD1njV9glPasSrJdA1yHTqxVdx4uQmoVyu7/b4GTW/n7i
         xsTRhq7NRoTHiNXUjAUSfn9nFFn7FPpJJSykJl2pzTYoTWAJaaleI7afh0/cw4enBexA
         NDYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738705960; x=1739310760;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Eru0pKCg71K/YJtbqyE+0IbsaUIxsNP7n0k8zmA6cmM=;
        b=d/W3UTHAMsXHVW/ltp/hzAM/w+Y/F6CZjT8ZTXlLd1FcAT3JP7xIGvsMmgk9psm2nU
         CLZJIdolbqvgEZ4F6nbuIAC0mY04YQMEb3QirTidXfCu624StKpm8A21+CVpi4BoOxhG
         b/Dp5HkJoH6MKsMlaFVsE01mo3Lf9JsL4khGBW/5isIA1kk+lgdFUk78m1zucfTFMKyY
         WPAXR26HFGAHLJMcSTREo4Mqse88MSrnlIliCfWAo0J0zxF+N4Fzj22yYnh6Ga3naiCE
         ZFTy84WVxSmAl6Y8aVeE+fLxKIraPjiIoiI82GQ9N7c1TGEp8j+R/GLbarT3aQZE2k1d
         AWyg==
X-Forwarded-Encrypted: i=1; AJvYcCWxnU+rkOulk//DgpQ8x8W423p7gtNxKzCVI22zBw3OmsBET4tr9KXkr57rK8tOyBAwNpXhvRBQ@vger.kernel.org, AJvYcCXsnnwTNgQlMabiL2KQzSjoczrVl20fBG54xwBeR8W0QWNkKOMhCXLju7jQc6QllFQtJUwNGwdn4fBvsqkQ2A==@vger.kernel.org
X-Gm-Message-State: AOJu0YzfibwKopu+UWxUAA5QpBE3woofYsmaLldsGkZcb6VKFAJGXn7m
	v2m0Xu8kgPDYqdmf71lVEjdsydNyyl1w5TctPXSy+MVnc51HexRo6gIWowGHECdw+c/SCu2K8D8
	wl9P+FrFNRD8QUmDkiCCtJEJi/zI=
X-Gm-Gg: ASbGncv1PXkM1uUgNFpAGAGr0Z1zR6F46gtQdflEOuflXf9bwxa7YXfX8fNT3wnk1aw
	88DbplVJHBoDAkRJ0U3p7C424J/BDu+bG8vWqqI2z0IyxFGdC7bG4mqKsnq5HpPxLjY4nRZCoBg
	==
X-Google-Smtp-Source: AGHT+IF142XEnRfcSsZGarx/eoc/G6Bd7tCDE3WsA93KYElcUWpA/dp4v0YXQvBn/J6idzozTi4gr/3/viBbYr0RIYg=
X-Received: by 2002:ac2:4c4b:0:b0:53e:39e6:a1c2 with SMTP id
 2adb3069b0e04-54405a71925mr99671e87.44.1738705960089; Tue, 04 Feb 2025
 13:52:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJnrk1YwBJQnFwYBcO50Xy2dA6df_SqQsHdpLux4wa-Yw5rXdg@mail.gmail.com>
 <20250203185948.GB134532@frogsfrogsfrogs> <CAJnrk1bX27KAOxChMs5pRNmrjjuxjYu11GG==vTN0sa8Qf2Uqw@mail.gmail.com>
 <20250203194147.GA134498@frogsfrogsfrogs> <CAJnrk1Y_eDFOnob3N78O3jcRoHy6Y0jaxnXbgVT0okBjwJue3g@mail.gmail.com>
 <20250203200149.GC134490@frogsfrogsfrogs> <CAJnrk1apX266i33s8CA4JwCv0z9sNmGm=+EXt0kSESvzicEhJQ@mail.gmail.com>
 <20250203215432.GC134532@frogsfrogsfrogs> <20250204042136.GA21799@frogsfrogsfrogs>
 <CAJnrk1bTpOvZG=PHW1LeoQ8xCb276X6At8gm8=M9UdinaVY1+Q@mail.gmail.com> <20250204213119.GE21799@frogsfrogsfrogs>
In-Reply-To: <20250204213119.GE21799@frogsfrogsfrogs>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 4 Feb 2025 13:52:27 -0800
X-Gm-Features: AWEUYZmavL6O5K8GpvzRaXc0Ai6LnFpYAlzezVtV6kCBQEGnJ-QnpNqw99p1LV4
Message-ID: <CAJnrk1bwnCb_dJ2SyBvNyzrto5N+BYwNkbZKNvkukxWoHpvGUQ@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] fsx: support reads/writes from buffers backed by hugepages
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, bfoster@redhat.com, nirjhar@linux.ibm.com, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 4, 2025 at 1:31=E2=80=AFPM Darrick J. Wong <djwong@kernel.org> =
wrote:
>
> On Tue, Feb 04, 2025 at 12:50:04PM -0800, Joanne Koong wrote:
> > On Mon, Feb 3, 2025 at 8:21=E2=80=AFPM Darrick J. Wong <djwong@kernel.o=
rg> wrote:
> > >
> > > On Mon, Feb 03, 2025 at 01:54:32PM -0800, Darrick J. Wong wrote:
> > > > On Mon, Feb 03, 2025 at 01:40:39PM -0800, Joanne Koong wrote:
> > > > > On Mon, Feb 3, 2025 at 12:01=E2=80=AFPM Darrick J. Wong <djwong@k=
ernel.org> wrote:
> > > > > >
> > > > > > On Mon, Feb 03, 2025 at 11:57:23AM -0800, Joanne Koong wrote:
> > > > > > > On Mon, Feb 3, 2025 at 11:41=E2=80=AFAM Darrick J. Wong <djwo=
ng@kernel.org> wrote:
> > > > > > > >
> > > > > > > > On Mon, Feb 03, 2025 at 11:23:20AM -0800, Joanne Koong wrot=
e:
> > > > > > > > > On Mon, Feb 3, 2025 at 10:59=E2=80=AFAM Darrick J. Wong <=
djwong@kernel.org> wrote:
> > > > > > > > > >
> > > > > > > > > > On Mon, Feb 03, 2025 at 10:04:04AM -0800, Joanne Koong =
wrote:
> > > > > > > > > > > On Sun, Feb 2, 2025 at 6:25=E2=80=AFAM Zorro Lang <zl=
ang@redhat.com> wrote:
> > > > > > > > > > > >
> > > > > > > > > > > > On Tue, Jan 21, 2025 at 01:56:40PM -0800, Joanne Ko=
ong wrote:
> > > > > > > > > > > > > Add support for reads/writes from buffers backed =
by hugepages.
> > > > > > > > > > > > > This can be enabled through the '-h' flag. This f=
lag should only be used
> > > > > > > > > > > > > on systems where THP capabilities are enabled.
> > > > > > > > > > > > >
> > > > > > > > > > > > > This is motivated by a recent bug that was due to=
 faulty handling of
> > > > > > > > > > > > > userspace buffers backed by hugepages. This patch=
 is a mitigation
> > > > > > > > > > > > > against problems like this in the future.
> > > > > > > > > > > > >
> > > > > > > > > > > > > Signed-off-by: Joanne Koong <joannelkoong@gmail.c=
om>
> > > > > > > > > > > > > Reviewed-by: Brian Foster <bfoster@redhat.com>
> > > > > > > > > > > > > Reviewed-by: Darrick J. Wong <djwong@kernel.org>
> > > > > > > > > > > > > ---
> > > > > > > > > > > >
> > > > > > > > > > > > Those two test cases fail on old system which doesn=
't support
> > > > > > > > > > > > MADV_COLLAPSE:
> > > > > > > > > > > >
> > > > > > > > > > > >    fsx -N 10000 -l 500000 -h
> > > > > > > > > > > >   -fsx -N 10000 -o 8192 -l 500000 -h
> > > > > > > > > > > >   -fsx -N 10000 -o 128000 -l 500000 -h
> > > > > > > > > > > >   +MADV_COLLAPSE not supported. Can't support -h
> > > > > > > > > > > >
> > > > > > > > > > > > and
> > > > > > > > > > > >
> > > > > > > > > > > >    fsx -N 10000 -l 500000 -r PSIZE -t BSIZE -w BSIZ=
E -Z -R -W -h
> > > > > > > > > > > >   -fsx -N 10000 -o 8192 -l 500000 -r PSIZE -t BSIZE=
 -w BSIZE -Z -R -W -h
> > > > > > > > > > > >   -fsx -N 10000 -o 128000 -l 500000 -r PSIZE -t BSI=
ZE -w BSIZE -Z -R -W -h
> > > > > > > > > > > >   +mapped writes DISABLED
> > > > > > > > > > > >   +MADV_COLLAPSE not supported. Can't support -h
> > > > > > > > > > > >
> > > > > > > > > > > > I'm wondering ...
> > > > > > > > > > > >
> > > > > > > > > > > > >  ltp/fsx.c | 166 ++++++++++++++++++++++++++++++++=
+++++++++++++++++-----
> > > > > > > > > > > > >  1 file changed, 153 insertions(+), 13 deletions(=
-)
> > > > > > > > > > > > >
> > > > > > > > > > > > > diff --git a/ltp/fsx.c b/ltp/fsx.c
> > > > > > > > > > > > > index 41933354..3be383c6 100644
> > > > > > > > > > > > > --- a/ltp/fsx.c
> > > > > > > > > > > > > +++ b/ltp/fsx.c
> > > > > > > > > > > > >  static struct option longopts[] =3D {
> > > > > > > > > > > > >       {"replay-ops", required_argument, 0, 256},
> > > > > > > > > > > > >       {"record-ops", optional_argument, 0, 255},
> > > > > > > > > > > > > @@ -2883,7 +3023,7 @@ main(int argc, char **argv)
> > > > > > > > > > > > >       setvbuf(stdout, (char *)0, _IOLBF, 0); /* l=
ine buffered stdout */
> > > > > > > > > > > > >
> > > > > > > > > > > > >       while ((ch =3D getopt_long(argc, argv,
> > > > > > > > > > > > > -                              "0b:c:de:fg:i:j:kl=
:m:no:p:qr:s:t:uw:xyABD:EFJKHzCILN:OP:RS:UWXZ",
> > > > > > > > > > > > > +                              "0b:c:de:fg:hi:j:k=
l:m:no:p:qr:s:t:uw:xyABD:EFJKHzCILN:OP:RS:UWXZ",
> > > > > > > > > > > > >                                longopts, NULL)) !=
=3D EOF)
> > > > > > > > > > > > >               switch (ch) {
> > > > > > > > > > > > >               case 'b':
> > > > > > > > > > > > > @@ -2916,6 +3056,14 @@ main(int argc, char **argv=
)
> > > > > > > > > > > > >               case 'g':
> > > > > > > > > > > > >                       filldata =3D *optarg;
> > > > > > > > > > > > >                       break;
> > > > > > > > > > > > > +             case 'h':
> > > > > > > > > > > > > +#ifndef MADV_COLLAPSE
> > > > > > > > > > > > > +                     fprintf(stderr, "MADV_COLLA=
PSE not supported. "
> > > > > > > > > > > > > +                             "Can't support -h\n=
");
> > > > > > > > > > > > > +                     exit(86);
> > > > > > > > > > > > > +#endif
> > > > > > > > > > > > > +                     hugepages =3D 1;
> > > > > > > > > > > > > +                     break;
> > > > > > > > > > > >
> > > > > > > > > > > > ...
> > > > > > > > > > > > if we could change this part to:
> > > > > > > > > > > >
> > > > > > > > > > > > #ifdef MADV_COLLAPSE
> > > > > > > > > > > >         hugepages =3D 1;
> > > > > > > > > > > > #endif
> > > > > > > > > > > >         break;
> > > > > > > > > > > >
> > > > > > > > > > > > to avoid the test failures on old systems.
> > > > > > > > > > > >
> > > > > > > > > > > > Or any better ideas from you :)
> > > > > > > > > > >
> > > > > > > > > > > Hi Zorro,
> > > > > > > > > > >
> > > > > > > > > > > It looks like MADV_COLLAPSE was introduced in kernel =
version 6.1. What
> > > > > > > > > > > do you think about skipping generic/758 and generic/7=
59 if the kernel
> > > > > > > > > > > version is older than 6.1? That to me seems more pref=
erable than the
> > > > > > > > > > > paste above, as the paste above would execute the tes=
t as if it did
> > > > > > > > > > > test hugepages when in reality it didn't, which would=
 be misleading.
> > > > > > > > > >
> > > > > > > > > > Now that I've gotten to try this out --
> > > > > > > > > >
> > > > > > > > > > There's a couple of things going on here.  The first is=
 that generic/759
> > > > > > > > > > and 760 need to check if invoking fsx -h causes it to s=
pit out the
> > > > > > > > > > "MADV_COLLAPSE not supported" error and _notrun the tes=
t.
> > > > > > > > > >
> > > > > > > > > > The second thing is that userspace programs can ensure =
the existence of
> > > > > > > > > > MADV_COLLAPSE in multiple ways.  The first way is throu=
gh sys/mman.h,
> > > > > > > > > > which requires that the underlying C library headers ar=
e new enough to
> > > > > > > > > > include a definition.  glibc 2.37 is new enough, but ev=
en things like
> > > > > > > > > > Debian 12 and RHEL 9 aren't new enough to have that.  O=
ther C libraries
> > > > > > > > > > might not follow glibc's practice of wrapping and/or re=
defining symbols
> > > > > > > > > > in a way that you hope is the same as...
> > > > > > > > > >
> > > > > > > > > > The second way is through linux/mman.h, which comes fro=
m the kernel
> > > > > > > > > > headers package; and the third way is for the program t=
o define it
> > > > > > > > > > itself if nobody else does.
> > > > > > > > > >
> > > > > > > > > > So I think the easiest way to fix the fsx.c build is to=
 include
> > > > > > > > > > linux/mman.h in addition to sys/mman.h.  Sorry I didn't=
 notice these
> > > > > > > > >
> > > > > > > > > Thanks for your input. Do we still need sys/mman.h if lin=
ux/mman.h is added?
> > > > > > > >
> > > > > > > > Yes, because glibc provides the mmap() function that wraps
> > > > > > > > syscall(__NR_mmap, ...);
> > > > > > > >
> > > > > > > > > For generic/758 and 759, does it suffice to gate this on =
whether the
> > > > > > > > > kernel version if 6.1+ and _notrun if not? My understandi=
ng is that
> > > > > > > > > any kernel version 6.1 or newer will have MADV_COLLAPSE i=
n its kernel
> > > > > > > > > headers package and support the feature.
> > > > > > > >
> > > > > > > > No, because some (most?) vendors backport new features into=
 existing
> > > > > > > > kernels without revving the version number of that kernel.
> > > > > > >
> > > > > > > Oh okay, I see. That makes sense, thanks for the explanation.
> > > > > > >
> > > > > > > >
> > > > > > > > Maybe the following fixes things?
> > > > > > > >
> > > > > > > > --D
> > > > > > > >
> > > > > > > > generic/759,760: fix MADV_COLLAPSE detection and inclusion
> > > > > > > >
> > > > > > > > On systems with "old" C libraries such as glibc 2.36 in Deb=
ian 12, the
> > > > > > > > MADV_COLLAPSE flag might not be defined in any of the heade=
r files
> > > > > > > > pulled in by sys/mman.h, which means that the fsx binary mi=
ght not get
> > > > > > > > built with any of the MADV_COLLAPSE code.  If the kernel su=
pports THP,
> > > > > > > > the test will fail with:
> > > > > > > >
> > > > > > > > >  QA output created by 760
> > > > > > > > >  fsx -N 10000 -l 500000 -r PSIZE -t BSIZE -w BSIZE -Z -R =
-W -h
> > > > > > > > > -fsx -N 10000 -o 8192 -l 500000 -r PSIZE -t BSIZE -w BSIZ=
E -Z -R -W -h
> > > > > > > > > -fsx -N 10000 -o 128000 -l 500000 -r PSIZE -t BSIZE -w BS=
IZE -Z -R -W -h
> > > > > > > > > +mapped writes DISABLED
> > > > > > > > > +MADV_COLLAPSE not supported. Can't support -h
> > > > > > > >
> > > > > > > > Fix both tests to detect fsx binaries that don't support MA=
DV_COLLAPSE,
> > > > > > > > then fix fsx.c to include the mman.h from the kernel header=
s (aka
> > > > > > > > linux/mman.h) so that we can actually test IOs to and from =
THPs if the
> > > > > > > > kernel is newer than the rest of userspace.
> > > > > > > >
> > > > > > > > Cc: <fstests@vger.kernel.org> # v2025.02.02
> > > > > > > > Fixes: 627289232371e3 ("generic: add tests for read/writes =
from hugepages-backed buffers")
> > > > > > > > Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> > > > > > > > ---
> > > > > > > >  ltp/fsx.c         |    1 +
> > > > > > > >  tests/generic/759 |    3 +++
> > > > > > > >  tests/generic/760 |    3 +++
> > > > > > > >  3 files changed, 7 insertions(+)
> > > > > > > >
> > > > > > > > diff --git a/ltp/fsx.c b/ltp/fsx.c
> > > > > > > > index 634c496ffe9317..cf9502a74c17a7 100644
> > > > > > > > --- a/ltp/fsx.c
> > > > > > > > +++ b/ltp/fsx.c
> > > > > > > > @@ -20,6 +20,7 @@
> > > > > > > >  #include <strings.h>
> > > > > > > >  #include <sys/file.h>
> > > > > > > >  #include <sys/mman.h>
> > > > > > > > +#include <linux/mman.h>
> > > > > > > >  #include <sys/uio.h>
> > > > > > > >  #include <stdbool.h>
> > > > > > > >  #ifdef HAVE_ERR_H
> > > > > > > > diff --git a/tests/generic/759 b/tests/generic/759
> > > > > > > > index 6c74478aa8a0e0..3549c5ed6a9299 100755
> > > > > > > > --- a/tests/generic/759
> > > > > > > > +++ b/tests/generic/759
> > > > > > > > @@ -14,6 +14,9 @@ _begin_fstest rw auto quick
> > > > > > > >  _require_test
> > > > > > > >  _require_thp
> > > > > > > >
> > > > > > > > +$here/ltp/fsx -N 0 -h $TEST_DIR 2>&1 | grep -q 'MADV_COLLA=
PSE not supported' && \
> > > > > > > > +       _notrun "fsx binary does not support MADV_COLLAPSE"
> > > > > > > > +
> > > > > > > >  run_fsx -N 10000            -l 500000 -h
> > > > > > > >  run_fsx -N 10000  -o 8192   -l 500000 -h
> > > > > > > >  run_fsx -N 10000  -o 128000 -l 500000 -h
> > > > > > > > diff --git a/tests/generic/760 b/tests/generic/760
> > > > > > > > index c71a196222ad3b..2fbd28502ae678 100755
> > > > > > > > --- a/tests/generic/760
> > > > > > > > +++ b/tests/generic/760
> > > > > > > > @@ -15,6 +15,9 @@ _require_test
> > > > > > > >  _require_odirect
> > > > > > > >  _require_thp
> > > > > > > >
> > > > > > > > +$here/ltp/fsx -N 0 -h $TEST_DIR 2>&1 | grep -q 'MADV_COLLA=
PSE not supported' && \
> > > > > > > > +       _notrun "fsx binary does not support MADV_COLLAPSE"
> > > > > > > > +
> > > > > > >
> > > > > > > I tried this out locally and it works for me:
> > > > > > >
> > > > > > > generic/759 8s ... [not run] fsx binary does not support MADV=
_COLLAPSE
> > > > > > > Ran: generic/759
> > > > > > > Not run: generic/759
> > > > > > > Passed all 1 tests
> > > > > > >
> > > > > > > SECTION       -- fuse
> > > > > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> > > > > > > Ran: generic/759
> > > > > > > Not run: generic/759
> > > > > > > Passed all 1 tests
> > > > > >
> > > > > > Does the test actually run if you /do/ have kernel/libc headers=
 that
> > > > > > define MADV_COLLAPSE?  And if so, does that count as a Tested-b=
y?
> > > > > >
> > > > >
> > > > > I'm not sure if I fully understand the subtext of your question b=
ut
> > > > > yes, the test runs on my system when MADV_COLLAPSE is defined in =
the
> > > > > kernel/libc headers.
> > > >
> > > > Yep, you understood me correctly. :)
> > > >
> > > > > For sanity checking the inverse case, (eg MADV_COLLAPSE not defin=
ed),
> > > > > I tried this out by modifying the ifdef/ifndef checks in fsx to
> > > > > MADV_COLLAPSE_ to see if the '$here/ltp/fsx -N 0 -h $TEST_DIR 2>&=
1 |
> > > > > grep -q 'MADV_COLLAPSE not supported'' line catches that.
> > > >
> > > > <nod> Sounds good then; I'll add this to my test clod and run it
> > > > overnight.
> > >
> > > The arm64 vms with 64k base pages spat out this:
> > >
> > > --- /run/fstests/bin/tests/generic/759.out      2025-02-02 08:36:28.0=
07248055 -0800
> > > +++ /var/tmp/fstests/generic/759.out.bad        2025-02-03 16:51:34.8=
62964640 -0800
> > > @@ -1,4 +1,5 @@
> > >  QA output created by 759
> > >  fsx -N 10000 -l 500000 -h
> > > -fsx -N 10000 -o 8192 -l 500000 -h
> > > -fsx -N 10000 -o 128000 -l 500000 -h
> > > +Seed set to 1
> > > +madvise collapse for buf: Cannot allocate memory
> > > +init_hugepages_buf failed for good_buf: Cannot allocate memory
> > >
> > > Note that it was trying to create a 512M page(!) on a VM with 8G of
> > > memory.  Normally one doesn't use large base page size in low memory
> > > environments, but this /is/ fstestsland. 8-)
> > >
> > > From commit 7d8faaf155454f ("mm/madvise: introduce MADV_COLLAPSE sync
> > > hugepage collapse") :
> > >
> > >         ENOMEM  Memory allocation failed or VMA not found
> > >         EBUSY   Memcg charging failed
> > >         EAGAIN  Required resource temporarily unavailable.  Try again
> > >                 might succeed.
> > >         EINVAL  Other error: No PMD found, subpage doesn't have Prese=
nt
> > >                 bit set, "Special" page no backed by struct page, VMA
> > >                 incorrectly sized, address not page-aligned, ...
> > >
> > > It sounds like ENOMEM/EBUSY/EINVAL should result in
> > > _notrun "Could not generate hugepage" ?  What are your thoughts?
> > >
> >
> > Thanks for running it overnight. This sounds good to me, but will this
> > be robust against false negatives? For example, if it succeeds when
> > we're doing the
> >
> > $here/ltp/fsx -N 0 -h $TEST_DIR 2>&1 | grep -q 'MADV_COLLAPSE not
> > supported' &&  _notrun "fsx binary does not support MADV_COLLAPSE"
> >
> > check, does that guarantee that the actual run won't error out with
> > ENOMEM/EBUSY/EINVAL?
>
> Nope.  That code only checks that the fsx binary was built with
> MADV_COLLAPSE support, not that any of it actually works.
>
> >                      It seems like there could be the case where it
> > passes the check but then when it actually runs, the system state
> > memory state may have changed and now memcg charging or the memory
> > allocation fails?
>
> Indeed, I think the error I saw is exactly this happening.
>
> In the end I turned the fsx -h invocation into a helper that checks for
> any of those three errors (ENOMEM/BUSY/INVAL) and _notruns the test if
> we can't even get a hugepage at the start.
>
> # Run fsx with -h(ugepage buffers).  If we can't set up a hugepage then s=
kip
> # the test, but if any other error occurs then exit the test.
> _run_hugepage_fsx() {
>         _run_fsx "$@" -h &> $tmp.hugepage_fsx
>         local res=3D$?
>         if [ $res -eq 103 ]; then
>                 # According to the MADV_COLLAPSE manpage, these three err=
ors
>                 # can happen if the kernel could not collapse a collectio=
n of
>                 # pages into a single huge page.
>                 grep -q -E ' for hugebuf: (Cannot allocate memory|Device =
or resource busy|Resource temporarily unavailable)' $tmp.hugepage_fsx && \
>                         _notrun "Could not set up huge page for test"
>         fi
>         cat $tmp.hugepage_fsx
>         rm -f $tmp.hugepage_fsx
>         test $res -ne 0 && exit 1
>         return 0
> }

Awesome, thank you!

>
> Note that it won't prevent or paper over subsequent MADV_COLLAPSE
> failures once the process is up and running, though as long as nothing
> else in fsx fails or corrupts the file, the collapse failures won't be
> reported.  (As is the case now).
>
> Anyway I'll send patches for both issues.
>
> > allocation fails? EAGAIN seems a bit iffy to me - hopefully this
> > doesn't happen often but if it does, it would likely be a false
> > negative fail for the generic test?
> >
> > Maybe instead of "$here/ltp/fsx -N 0 -h $TEST_DIR 2>&1 | grep -q
> > 'MADV_COLLAPSE not supported' &&  _notrun "fsx binary does not support
> > MADV_COLLAPSE"", we should run the test and then if the output to the
> > .out file is "MADV_COLLAPSE not supported", then we deem that a
> > pass/success? Not sure if this is possible in the fstest
> > infrastructure though for checking against two possible outputs in the
> > .out file. What are your thoughts?
>
> You ... can switch the .out(put) dynamically, but the mechanism to do it
> is underdocumented and quirky; and it makes understanding what the test
> does rather difficult.  See _link_out_file in xfs/614 if you want to
> open that Pandora's box.
>
> --D
>
> >
> >
> > Thanks,
> > Joanne
> >
> > > --D
> > >
> > > > --D
> > > >
> > > > >
> > > > > > --D
> > > > > >
> > > > > > >
> > > > > > > Thanks,
> > > > > > > Joanne
> > > > > > >
> > > > > > > >  psize=3D`$here/src/feature -s`
> > > > > > > >  bsize=3D`$here/src/min_dio_alignment $TEST_DIR $TEST_DEV`
> > > > > > > >
> > > > > > >
> > > >
> >

