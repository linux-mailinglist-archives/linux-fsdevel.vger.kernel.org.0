Return-Path: <linux-fsdevel+bounces-40817-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 611B8A27CED
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 21:50:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24C4718859FD
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 20:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B11021A43A;
	Tue,  4 Feb 2025 20:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OINE8KwX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 856EC206F16;
	Tue,  4 Feb 2025 20:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738702218; cv=none; b=UlCAlmyfOn7wrX4zdcdzcC4VtK6lW/V/Hm4FQ9l0aw+eG+Cp2g9rseAav5/WB7u65OQSfUUmLJmK2IIGA40DiFFJMB3ZAwKivUvxsyTrpp09ACgRM10UDcg+4b1/j7YrtE5I/tArGMI/R6n7V9M9C/dUfAK1qF1A49Yq9DZ9Z7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738702218; c=relaxed/simple;
	bh=EfqotukzcpDCV3ZSYISIXnSxcW8AW7Syyg0OUHOrIpI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gl7PPVY+s+x8rr41KTHNGXc/NIpnwsC2R+aj1F+QeonJzOfqibDI73742sH8Y7p1rXrlhjeqkYZQa03vBdTxKRF/5D9cjzqkrNLC7g97GCWkq61mZe/5yPo93U1+gmor/h89WXf56cchKcoowU5X/8l5SAydviFsjqxUQr9MxJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OINE8KwX; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-46c8474d8daso43088761cf.3;
        Tue, 04 Feb 2025 12:50:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738702215; x=1739307015; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J3q/9LTOK1m2RNFGy8txqtDxvIMl4dVGU30eFdIrCIo=;
        b=OINE8KwXCAXVqNOF3aD9lYj0ITyN7kSpjQmWeGfXJcL+pCWzeZdQLA7G5UzGGI3dSI
         C/ApeIBl1XmcTxXdvzi2PFpCO9SDaX5Nzqqqii2NaEPWpwua9b8ZiUld60ZxIJ9I+VkS
         8+gdkGlhJ78SOQ0p7tGAkCOP6T+n0sIUd6u4cqlMZcZmRRFulk8hDCUZvOQ8xSidDNc3
         QFoJB8njEcO4vUMlmxDE9fgQAGrA4tC3wmgpB04kCOw2dOFfa4Up4KCS1G7XjlyyyFpH
         kisqkINwre/qHN5w26byLAFCE3N7qkRx7bXD5yEMipPcNxSUuvHh1Ix/Bkf25p9GcJaz
         459g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738702215; x=1739307015;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J3q/9LTOK1m2RNFGy8txqtDxvIMl4dVGU30eFdIrCIo=;
        b=SYTgNOtRqCjBKC1V0czhgNP6wRbMfsue9SgS1bMIU7myZM58axB5mTZyNy2S9nM6Xr
         Guq5AP3CpeuDgnbSBkp/tRuFwpegCcahUy6ZnGkMuKW3FL91heNITLwq1tc2NwNhi5pL
         lwvymWwCzWvIsmpGoLIoUCvEu7vPbUftk+QBF0gZHAc+6O0a/RF0IIzN5MLKQ02h7Gos
         x2Syj3oUTrVtmtke9K1p2vtyzFzF3seTcRFlCMoROgzErw5tJQNNT+Et4VzaXjO8REQ3
         BIRAaOoZMoCIUg4Mbrv/klEJI0fV0cPHjmbT0DMpm8EOsOICCJ19zyF5JcdU7o9KzJx9
         96ZQ==
X-Forwarded-Encrypted: i=1; AJvYcCWRDRSWw3USlCQepY0wXPoX9RT/Mfal5EnGXOJCldLoq8/qnsIV6wbcMDZfCkh4dK4mCqD+YRN2@vger.kernel.org, AJvYcCX5hvm7hBkMq72BJrJQ53VUHFcYGuqBAYa5dImsQ8jSzFWIfiN+nFtD/XgbdQ+pdFYx2Uti/hPMYKyTnjDT/w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxmd97Ihl5NI2w5eFqLVy05q7QiywIwk50zDkvuAOgqFzQSK6Nn
	qzuczGD5Utlq3F2/pIv2p6MXKRgzgVVOLS0nLl84zV7GRz7OfF16G9RgBJ/tov7ZjwLIUOneiqo
	4oC25n3XUv811x6DfwnFJxSWTTlo=
X-Gm-Gg: ASbGncudIcWXbZqpfHcYLWTYTGpWWleNAxQ+b0ZDnOs04DjA83uxGM6UmPRnm93Avhy
	wLn/iCUW9vXOIAR4aulVMJJG368225HpbRV/3t/uxOFiKLRYG4EteAqv59HwXSwOjZ+DdrGMwDg
	==
X-Google-Smtp-Source: AGHT+IHTTlTAo8kEiZjjPF6urEJAekmCPdZzPK5XWZGbtPyNP4jLgbbbRpKGXvYX9ftdXGHLaejfT74EsC3Ize1dgUo=
X-Received: by 2002:a05:622a:6099:b0:467:613d:9a1 with SMTP id
 d75a77b69052e-4702831f49cmr1129861cf.48.1738702214969; Tue, 04 Feb 2025
 12:50:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250121215641.1764359-2-joannelkoong@gmail.com>
 <20250202142518.r3xvf7mvfo2nhb7t@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <CAJnrk1YwBJQnFwYBcO50Xy2dA6df_SqQsHdpLux4wa-Yw5rXdg@mail.gmail.com>
 <20250203185948.GB134532@frogsfrogsfrogs> <CAJnrk1bX27KAOxChMs5pRNmrjjuxjYu11GG==vTN0sa8Qf2Uqw@mail.gmail.com>
 <20250203194147.GA134498@frogsfrogsfrogs> <CAJnrk1Y_eDFOnob3N78O3jcRoHy6Y0jaxnXbgVT0okBjwJue3g@mail.gmail.com>
 <20250203200149.GC134490@frogsfrogsfrogs> <CAJnrk1apX266i33s8CA4JwCv0z9sNmGm=+EXt0kSESvzicEhJQ@mail.gmail.com>
 <20250203215432.GC134532@frogsfrogsfrogs> <20250204042136.GA21799@frogsfrogsfrogs>
In-Reply-To: <20250204042136.GA21799@frogsfrogsfrogs>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 4 Feb 2025 12:50:04 -0800
X-Gm-Features: AWEUYZlr6Dfog9k_k-e0VnMxSCkNginETTtcDTi82kIPLIR-rrLoPjnIRneXzrU
Message-ID: <CAJnrk1bTpOvZG=PHW1LeoQ8xCb276X6At8gm8=M9UdinaVY1+Q@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] fsx: support reads/writes from buffers backed by hugepages
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, bfoster@redhat.com, nirjhar@linux.ibm.com, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 3, 2025 at 8:21=E2=80=AFPM Darrick J. Wong <djwong@kernel.org> =
wrote:
>
> On Mon, Feb 03, 2025 at 01:54:32PM -0800, Darrick J. Wong wrote:
> > On Mon, Feb 03, 2025 at 01:40:39PM -0800, Joanne Koong wrote:
> > > On Mon, Feb 3, 2025 at 12:01=E2=80=AFPM Darrick J. Wong <djwong@kerne=
l.org> wrote:
> > > >
> > > > On Mon, Feb 03, 2025 at 11:57:23AM -0800, Joanne Koong wrote:
> > > > > On Mon, Feb 3, 2025 at 11:41=E2=80=AFAM Darrick J. Wong <djwong@k=
ernel.org> wrote:
> > > > > >
> > > > > > On Mon, Feb 03, 2025 at 11:23:20AM -0800, Joanne Koong wrote:
> > > > > > > On Mon, Feb 3, 2025 at 10:59=E2=80=AFAM Darrick J. Wong <djwo=
ng@kernel.org> wrote:
> > > > > > > >
> > > > > > > > On Mon, Feb 03, 2025 at 10:04:04AM -0800, Joanne Koong wrot=
e:
> > > > > > > > > On Sun, Feb 2, 2025 at 6:25=E2=80=AFAM Zorro Lang <zlang@=
redhat.com> wrote:
> > > > > > > > > >
> > > > > > > > > > On Tue, Jan 21, 2025 at 01:56:40PM -0800, Joanne Koong =
wrote:
> > > > > > > > > > > Add support for reads/writes from buffers backed by h=
ugepages.
> > > > > > > > > > > This can be enabled through the '-h' flag. This flag =
should only be used
> > > > > > > > > > > on systems where THP capabilities are enabled.
> > > > > > > > > > >
> > > > > > > > > > > This is motivated by a recent bug that was due to fau=
lty handling of
> > > > > > > > > > > userspace buffers backed by hugepages. This patch is =
a mitigation
> > > > > > > > > > > against problems like this in the future.
> > > > > > > > > > >
> > > > > > > > > > > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > > > > > > > > > > Reviewed-by: Brian Foster <bfoster@redhat.com>
> > > > > > > > > > > Reviewed-by: Darrick J. Wong <djwong@kernel.org>
> > > > > > > > > > > ---
> > > > > > > > > >
> > > > > > > > > > Those two test cases fail on old system which doesn't s=
upport
> > > > > > > > > > MADV_COLLAPSE:
> > > > > > > > > >
> > > > > > > > > >    fsx -N 10000 -l 500000 -h
> > > > > > > > > >   -fsx -N 10000 -o 8192 -l 500000 -h
> > > > > > > > > >   -fsx -N 10000 -o 128000 -l 500000 -h
> > > > > > > > > >   +MADV_COLLAPSE not supported. Can't support -h
> > > > > > > > > >
> > > > > > > > > > and
> > > > > > > > > >
> > > > > > > > > >    fsx -N 10000 -l 500000 -r PSIZE -t BSIZE -w BSIZE -Z=
 -R -W -h
> > > > > > > > > >   -fsx -N 10000 -o 8192 -l 500000 -r PSIZE -t BSIZE -w =
BSIZE -Z -R -W -h
> > > > > > > > > >   -fsx -N 10000 -o 128000 -l 500000 -r PSIZE -t BSIZE -=
w BSIZE -Z -R -W -h
> > > > > > > > > >   +mapped writes DISABLED
> > > > > > > > > >   +MADV_COLLAPSE not supported. Can't support -h
> > > > > > > > > >
> > > > > > > > > > I'm wondering ...
> > > > > > > > > >
> > > > > > > > > > >  ltp/fsx.c | 166 ++++++++++++++++++++++++++++++++++++=
+++++++++++++-----
> > > > > > > > > > >  1 file changed, 153 insertions(+), 13 deletions(-)
> > > > > > > > > > >
> > > > > > > > > > > diff --git a/ltp/fsx.c b/ltp/fsx.c
> > > > > > > > > > > index 41933354..3be383c6 100644
> > > > > > > > > > > --- a/ltp/fsx.c
> > > > > > > > > > > +++ b/ltp/fsx.c
> > > > > > > > > > >  static struct option longopts[] =3D {
> > > > > > > > > > >       {"replay-ops", required_argument, 0, 256},
> > > > > > > > > > >       {"record-ops", optional_argument, 0, 255},
> > > > > > > > > > > @@ -2883,7 +3023,7 @@ main(int argc, char **argv)
> > > > > > > > > > >       setvbuf(stdout, (char *)0, _IOLBF, 0); /* line =
buffered stdout */
> > > > > > > > > > >
> > > > > > > > > > >       while ((ch =3D getopt_long(argc, argv,
> > > > > > > > > > > -                              "0b:c:de:fg:i:j:kl:m:n=
o:p:qr:s:t:uw:xyABD:EFJKHzCILN:OP:RS:UWXZ",
> > > > > > > > > > > +                              "0b:c:de:fg:hi:j:kl:m:=
no:p:qr:s:t:uw:xyABD:EFJKHzCILN:OP:RS:UWXZ",
> > > > > > > > > > >                                longopts, NULL)) !=3D =
EOF)
> > > > > > > > > > >               switch (ch) {
> > > > > > > > > > >               case 'b':
> > > > > > > > > > > @@ -2916,6 +3056,14 @@ main(int argc, char **argv)
> > > > > > > > > > >               case 'g':
> > > > > > > > > > >                       filldata =3D *optarg;
> > > > > > > > > > >                       break;
> > > > > > > > > > > +             case 'h':
> > > > > > > > > > > +#ifndef MADV_COLLAPSE
> > > > > > > > > > > +                     fprintf(stderr, "MADV_COLLAPSE =
not supported. "
> > > > > > > > > > > +                             "Can't support -h\n");
> > > > > > > > > > > +                     exit(86);
> > > > > > > > > > > +#endif
> > > > > > > > > > > +                     hugepages =3D 1;
> > > > > > > > > > > +                     break;
> > > > > > > > > >
> > > > > > > > > > ...
> > > > > > > > > > if we could change this part to:
> > > > > > > > > >
> > > > > > > > > > #ifdef MADV_COLLAPSE
> > > > > > > > > >         hugepages =3D 1;
> > > > > > > > > > #endif
> > > > > > > > > >         break;
> > > > > > > > > >
> > > > > > > > > > to avoid the test failures on old systems.
> > > > > > > > > >
> > > > > > > > > > Or any better ideas from you :)
> > > > > > > > >
> > > > > > > > > Hi Zorro,
> > > > > > > > >
> > > > > > > > > It looks like MADV_COLLAPSE was introduced in kernel vers=
ion 6.1. What
> > > > > > > > > do you think about skipping generic/758 and generic/759 i=
f the kernel
> > > > > > > > > version is older than 6.1? That to me seems more preferab=
le than the
> > > > > > > > > paste above, as the paste above would execute the test as=
 if it did
> > > > > > > > > test hugepages when in reality it didn't, which would be =
misleading.
> > > > > > > >
> > > > > > > > Now that I've gotten to try this out --
> > > > > > > >
> > > > > > > > There's a couple of things going on here.  The first is tha=
t generic/759
> > > > > > > > and 760 need to check if invoking fsx -h causes it to spit =
out the
> > > > > > > > "MADV_COLLAPSE not supported" error and _notrun the test.
> > > > > > > >
> > > > > > > > The second thing is that userspace programs can ensure the =
existence of
> > > > > > > > MADV_COLLAPSE in multiple ways.  The first way is through s=
ys/mman.h,
> > > > > > > > which requires that the underlying C library headers are ne=
w enough to
> > > > > > > > include a definition.  glibc 2.37 is new enough, but even t=
hings like
> > > > > > > > Debian 12 and RHEL 9 aren't new enough to have that.  Other=
 C libraries
> > > > > > > > might not follow glibc's practice of wrapping and/or redefi=
ning symbols
> > > > > > > > in a way that you hope is the same as...
> > > > > > > >
> > > > > > > > The second way is through linux/mman.h, which comes from th=
e kernel
> > > > > > > > headers package; and the third way is for the program to de=
fine it
> > > > > > > > itself if nobody else does.
> > > > > > > >
> > > > > > > > So I think the easiest way to fix the fsx.c build is to inc=
lude
> > > > > > > > linux/mman.h in addition to sys/mman.h.  Sorry I didn't not=
ice these
> > > > > > >
> > > > > > > Thanks for your input. Do we still need sys/mman.h if linux/m=
man.h is added?
> > > > > >
> > > > > > Yes, because glibc provides the mmap() function that wraps
> > > > > > syscall(__NR_mmap, ...);
> > > > > >
> > > > > > > For generic/758 and 759, does it suffice to gate this on whet=
her the
> > > > > > > kernel version if 6.1+ and _notrun if not? My understanding i=
s that
> > > > > > > any kernel version 6.1 or newer will have MADV_COLLAPSE in it=
s kernel
> > > > > > > headers package and support the feature.
> > > > > >
> > > > > > No, because some (most?) vendors backport new features into exi=
sting
> > > > > > kernels without revving the version number of that kernel.
> > > > >
> > > > > Oh okay, I see. That makes sense, thanks for the explanation.
> > > > >
> > > > > >
> > > > > > Maybe the following fixes things?
> > > > > >
> > > > > > --D
> > > > > >
> > > > > > generic/759,760: fix MADV_COLLAPSE detection and inclusion
> > > > > >
> > > > > > On systems with "old" C libraries such as glibc 2.36 in Debian =
12, the
> > > > > > MADV_COLLAPSE flag might not be defined in any of the header fi=
les
> > > > > > pulled in by sys/mman.h, which means that the fsx binary might =
not get
> > > > > > built with any of the MADV_COLLAPSE code.  If the kernel suppor=
ts THP,
> > > > > > the test will fail with:
> > > > > >
> > > > > > >  QA output created by 760
> > > > > > >  fsx -N 10000 -l 500000 -r PSIZE -t BSIZE -w BSIZE -Z -R -W -=
h
> > > > > > > -fsx -N 10000 -o 8192 -l 500000 -r PSIZE -t BSIZE -w BSIZE -Z=
 -R -W -h
> > > > > > > -fsx -N 10000 -o 128000 -l 500000 -r PSIZE -t BSIZE -w BSIZE =
-Z -R -W -h
> > > > > > > +mapped writes DISABLED
> > > > > > > +MADV_COLLAPSE not supported. Can't support -h
> > > > > >
> > > > > > Fix both tests to detect fsx binaries that don't support MADV_C=
OLLAPSE,
> > > > > > then fix fsx.c to include the mman.h from the kernel headers (a=
ka
> > > > > > linux/mman.h) so that we can actually test IOs to and from THPs=
 if the
> > > > > > kernel is newer than the rest of userspace.
> > > > > >
> > > > > > Cc: <fstests@vger.kernel.org> # v2025.02.02
> > > > > > Fixes: 627289232371e3 ("generic: add tests for read/writes from=
 hugepages-backed buffers")
> > > > > > Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> > > > > > ---
> > > > > >  ltp/fsx.c         |    1 +
> > > > > >  tests/generic/759 |    3 +++
> > > > > >  tests/generic/760 |    3 +++
> > > > > >  3 files changed, 7 insertions(+)
> > > > > >
> > > > > > diff --git a/ltp/fsx.c b/ltp/fsx.c
> > > > > > index 634c496ffe9317..cf9502a74c17a7 100644
> > > > > > --- a/ltp/fsx.c
> > > > > > +++ b/ltp/fsx.c
> > > > > > @@ -20,6 +20,7 @@
> > > > > >  #include <strings.h>
> > > > > >  #include <sys/file.h>
> > > > > >  #include <sys/mman.h>
> > > > > > +#include <linux/mman.h>
> > > > > >  #include <sys/uio.h>
> > > > > >  #include <stdbool.h>
> > > > > >  #ifdef HAVE_ERR_H
> > > > > > diff --git a/tests/generic/759 b/tests/generic/759
> > > > > > index 6c74478aa8a0e0..3549c5ed6a9299 100755
> > > > > > --- a/tests/generic/759
> > > > > > +++ b/tests/generic/759
> > > > > > @@ -14,6 +14,9 @@ _begin_fstest rw auto quick
> > > > > >  _require_test
> > > > > >  _require_thp
> > > > > >
> > > > > > +$here/ltp/fsx -N 0 -h $TEST_DIR 2>&1 | grep -q 'MADV_COLLAPSE =
not supported' && \
> > > > > > +       _notrun "fsx binary does not support MADV_COLLAPSE"
> > > > > > +
> > > > > >  run_fsx -N 10000            -l 500000 -h
> > > > > >  run_fsx -N 10000  -o 8192   -l 500000 -h
> > > > > >  run_fsx -N 10000  -o 128000 -l 500000 -h
> > > > > > diff --git a/tests/generic/760 b/tests/generic/760
> > > > > > index c71a196222ad3b..2fbd28502ae678 100755
> > > > > > --- a/tests/generic/760
> > > > > > +++ b/tests/generic/760
> > > > > > @@ -15,6 +15,9 @@ _require_test
> > > > > >  _require_odirect
> > > > > >  _require_thp
> > > > > >
> > > > > > +$here/ltp/fsx -N 0 -h $TEST_DIR 2>&1 | grep -q 'MADV_COLLAPSE =
not supported' && \
> > > > > > +       _notrun "fsx binary does not support MADV_COLLAPSE"
> > > > > > +
> > > > >
> > > > > I tried this out locally and it works for me:
> > > > >
> > > > > generic/759 8s ... [not run] fsx binary does not support MADV_COL=
LAPSE
> > > > > Ran: generic/759
> > > > > Not run: generic/759
> > > > > Passed all 1 tests
> > > > >
> > > > > SECTION       -- fuse
> > > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> > > > > Ran: generic/759
> > > > > Not run: generic/759
> > > > > Passed all 1 tests
> > > >
> > > > Does the test actually run if you /do/ have kernel/libc headers tha=
t
> > > > define MADV_COLLAPSE?  And if so, does that count as a Tested-by?
> > > >
> > >
> > > I'm not sure if I fully understand the subtext of your question but
> > > yes, the test runs on my system when MADV_COLLAPSE is defined in the
> > > kernel/libc headers.
> >
> > Yep, you understood me correctly. :)
> >
> > > For sanity checking the inverse case, (eg MADV_COLLAPSE not defined),
> > > I tried this out by modifying the ifdef/ifndef checks in fsx to
> > > MADV_COLLAPSE_ to see if the '$here/ltp/fsx -N 0 -h $TEST_DIR 2>&1 |
> > > grep -q 'MADV_COLLAPSE not supported'' line catches that.
> >
> > <nod> Sounds good then; I'll add this to my test clod and run it
> > overnight.
>
> The arm64 vms with 64k base pages spat out this:
>
> --- /run/fstests/bin/tests/generic/759.out      2025-02-02 08:36:28.00724=
8055 -0800
> +++ /var/tmp/fstests/generic/759.out.bad        2025-02-03 16:51:34.86296=
4640 -0800
> @@ -1,4 +1,5 @@
>  QA output created by 759
>  fsx -N 10000 -l 500000 -h
> -fsx -N 10000 -o 8192 -l 500000 -h
> -fsx -N 10000 -o 128000 -l 500000 -h
> +Seed set to 1
> +madvise collapse for buf: Cannot allocate memory
> +init_hugepages_buf failed for good_buf: Cannot allocate memory
>
> Note that it was trying to create a 512M page(!) on a VM with 8G of
> memory.  Normally one doesn't use large base page size in low memory
> environments, but this /is/ fstestsland. 8-)
>
> From commit 7d8faaf155454f ("mm/madvise: introduce MADV_COLLAPSE sync
> hugepage collapse") :
>
>         ENOMEM  Memory allocation failed or VMA not found
>         EBUSY   Memcg charging failed
>         EAGAIN  Required resource temporarily unavailable.  Try again
>                 might succeed.
>         EINVAL  Other error: No PMD found, subpage doesn't have Present
>                 bit set, "Special" page no backed by struct page, VMA
>                 incorrectly sized, address not page-aligned, ...
>
> It sounds like ENOMEM/EBUSY/EINVAL should result in
> _notrun "Could not generate hugepage" ?  What are your thoughts?
>

Thanks for running it overnight. This sounds good to me, but will this
be robust against false negatives? For example, if it succeeds when
we're doing the

$here/ltp/fsx -N 0 -h $TEST_DIR 2>&1 | grep -q 'MADV_COLLAPSE not
supported' &&  _notrun "fsx binary does not support MADV_COLLAPSE"

check, does that guarantee that the actual run won't error out with
ENOMEM/EBUSY/EINVAL? It seems like there could be the case where it
passes the check but then when it actually runs, the system state
memory state may have changed and now memcg charging or the memory
allocation fails? EAGAIN seems a bit iffy to me - hopefully this
doesn't happen often but if it does, it would likely be a false
negative fail for the generic test?

Maybe instead of "$here/ltp/fsx -N 0 -h $TEST_DIR 2>&1 | grep -q
'MADV_COLLAPSE not supported' &&  _notrun "fsx binary does not support
MADV_COLLAPSE"", we should run the test and then if the output to the
.out file is "MADV_COLLAPSE not supported", then we deem that a
pass/success? Not sure if this is possible in the fstest
infrastructure though for checking against two possible outputs in the
.out file. What are your thoughts?


Thanks,
Joanne

> --D
>
> > --D
> >
> > >
> > > > --D
> > > >
> > > > >
> > > > > Thanks,
> > > > > Joanne
> > > > >
> > > > > >  psize=3D`$here/src/feature -s`
> > > > > >  bsize=3D`$here/src/min_dio_alignment $TEST_DIR $TEST_DEV`
> > > > > >
> > > > >
> >

