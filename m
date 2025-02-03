Return-Path: <linux-fsdevel+bounces-40667-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA942A265D8
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2025 22:41:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 505F8162B6D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2025 21:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54FDD20FAA1;
	Mon,  3 Feb 2025 21:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="abIQkgv+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E3F20FA80;
	Mon,  3 Feb 2025 21:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738618853; cv=none; b=H/jSv0wIgJmALumDfJ5ZOg/FZIjjs+vO+4COnSA+UgzQXGOKBnco9SXz7es+TFbZOmVkPZi2jx0JpVkDYQQ0VPKkVrlv3/+fd31AkAjw6/kUVoPHWusAduUg5I7aZcWdEuc9PjJ4ubA05y6+RlgIoTX4qhaRXiLgB1ik73mFyU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738618853; c=relaxed/simple;
	bh=sxx4WQ1GZmEaNn0cUR8e8RHJC7x+3YmEaVoQjtBdgb8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rUqJUvp3iOS0uR9BRCFwXzbfpOJVe4krCQVwXD2JERNgxCMaI5rol6fYUhOpp9wqLWIS1tlOctjRdrimko/NHl7LCieaCCnMY1gXLGjFnRKaUB8NgadkaInge1bmwcXCHbY3wTzfZIrYFOxsA4KoSUhLdo3f193PYWf+JAmWNLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=abIQkgv+; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-46e28597955so44612201cf.0;
        Mon, 03 Feb 2025 13:40:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738618850; x=1739223650; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rcx7OVdhxzaE6m1Yvxm97i2zJjqZm8p3llVaXLA/SyM=;
        b=abIQkgv+YWFxzoKIoTN5MOjgfx2GJ3CDyX5zU/RF8rUMBBzHSg9T8z75s6CQtFHbRg
         AMxoZ+w+om51IeVxyzEB+WxMOLmpJf5PDE8F1a2raEzK2ZxcBqLzeQ6yWA4z2Q0PMzBM
         WNeqT4tuQa4I0t91otlV+YsnuaxErbnbgw+fqdlfmjWy9IJ/k60PPG9FlYbinsSk4VBq
         Q6tkMTxDYf/0vuTt3QaLXcBrm7v0O1LWHkuSAAozKBi26G7jILFsRGgJkzKfnO8BnRQ7
         e4IzkIjzBBHL26UnZ7AY+9Rxrsn1IMVIrIEfXm2OaCMn+Jjlgd2hGz5b7U7WGPVfGh6R
         827w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738618850; x=1739223650;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rcx7OVdhxzaE6m1Yvxm97i2zJjqZm8p3llVaXLA/SyM=;
        b=JowaUoTn+iNrt1xKpfvYQPtKXDjvNRg0UIB799jXsJvK+Kb4/Mbh+SynEBd/ETR4kt
         koMpErUGE+oOOAqGLzQNIn0pUNeql3Lu/FEPjDxb3YW+yRwNBHI2NIifj1Zcol/dXsZ4
         3dBUYPi0D3jTywsB4U+DsJDQj7tb8rz5zpc8JZgEtVc/57nK6ALyXUFcJT4tMDmbmqY6
         a73aYDrBupah9VQ9jydhOraA0tLAFcm5DNRExUg948FYoH8i1t1X3we3I+2FRU+zTVNc
         kfM9cMLv+LwxprJG/amYx1Akc3nlFF4q7ku2JMMmLPHFXY1Mm2uVfu7ApncFBM84mKD7
         86Uw==
X-Forwarded-Encrypted: i=1; AJvYcCVADM91onV0ibNu6lpt7Dv6icK4lxBZmT44GTnAdLSgADf1vFSwAw5FH8SmQE4hg4qAsms5v9cjS1W0IAlydQ==@vger.kernel.org, AJvYcCWYOGkfGRUBwzTYM++kecVd560rm9jVLsScZVCeIQ0uDJqL2GNvYyajqEEXXSVco2IRmlHZBU0s@vger.kernel.org
X-Gm-Message-State: AOJu0YyjOf5ihrFoIrPtDhIeyvbghGwpozezxga4QcMNZ57pzss5XE7X
	DaSZGVhkPKPdltH/6A+EwBrkxfrinxJEcPPwsk1poqK2mrD/X/W3Ggr3Q6mRMLVyqXwW8WnRV+s
	aEnZofRCi+j2n17bBxIg/AsgaQLk=
X-Gm-Gg: ASbGncsyUs2YBOmMZEWtA2fZfeK+L1mbGrEoyQZy7UALAwVKe9UdhEhF3xyXMSreb0o
	1rYHJI5Sw9RvHjDurzAEptKVTOgzRjkkfbcDArJsLt0r9Ywl4QJ7xCpaKO8ipB8uRHo8vsrR/nz
	pO6OosiqK/p47d
X-Google-Smtp-Source: AGHT+IEFbPdy70iJTglq8HqOIu7Cuec/rK6vSJCH+BwGYyPl7rPQSioUL9u5FracyfW6fcMBvdytTx1d+SXOKrpdUYI=
X-Received: by 2002:a05:622a:13d2:b0:46e:59a3:6db7 with SMTP id
 d75a77b69052e-46fd0aa2a98mr384354691cf.23.1738618850155; Mon, 03 Feb 2025
 13:40:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250121215641.1764359-1-joannelkoong@gmail.com>
 <20250121215641.1764359-2-joannelkoong@gmail.com> <20250202142518.r3xvf7mvfo2nhb7t@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <CAJnrk1YwBJQnFwYBcO50Xy2dA6df_SqQsHdpLux4wa-Yw5rXdg@mail.gmail.com>
 <20250203185948.GB134532@frogsfrogsfrogs> <CAJnrk1bX27KAOxChMs5pRNmrjjuxjYu11GG==vTN0sa8Qf2Uqw@mail.gmail.com>
 <20250203194147.GA134498@frogsfrogsfrogs> <CAJnrk1Y_eDFOnob3N78O3jcRoHy6Y0jaxnXbgVT0okBjwJue3g@mail.gmail.com>
 <20250203200149.GC134490@frogsfrogsfrogs>
In-Reply-To: <20250203200149.GC134490@frogsfrogsfrogs>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Mon, 3 Feb 2025 13:40:39 -0800
X-Gm-Features: AWEUYZmQ51z0UEvwL2zRzFgGYLUc2TBgs3SFvUgdZFbkCAdNZIY0aMHvVJypeFQ
Message-ID: <CAJnrk1apX266i33s8CA4JwCv0z9sNmGm=+EXt0kSESvzicEhJQ@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] fsx: support reads/writes from buffers backed by hugepages
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, bfoster@redhat.com, nirjhar@linux.ibm.com, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 3, 2025 at 12:01=E2=80=AFPM Darrick J. Wong <djwong@kernel.org>=
 wrote:
>
> On Mon, Feb 03, 2025 at 11:57:23AM -0800, Joanne Koong wrote:
> > On Mon, Feb 3, 2025 at 11:41=E2=80=AFAM Darrick J. Wong <djwong@kernel.=
org> wrote:
> > >
> > > On Mon, Feb 03, 2025 at 11:23:20AM -0800, Joanne Koong wrote:
> > > > On Mon, Feb 3, 2025 at 10:59=E2=80=AFAM Darrick J. Wong <djwong@ker=
nel.org> wrote:
> > > > >
> > > > > On Mon, Feb 03, 2025 at 10:04:04AM -0800, Joanne Koong wrote:
> > > > > > On Sun, Feb 2, 2025 at 6:25=E2=80=AFAM Zorro Lang <zlang@redhat=
.com> wrote:
> > > > > > >
> > > > > > > On Tue, Jan 21, 2025 at 01:56:40PM -0800, Joanne Koong wrote:
> > > > > > > > Add support for reads/writes from buffers backed by hugepag=
es.
> > > > > > > > This can be enabled through the '-h' flag. This flag should=
 only be used
> > > > > > > > on systems where THP capabilities are enabled.
> > > > > > > >
> > > > > > > > This is motivated by a recent bug that was due to faulty ha=
ndling of
> > > > > > > > userspace buffers backed by hugepages. This patch is a miti=
gation
> > > > > > > > against problems like this in the future.
> > > > > > > >
> > > > > > > > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > > > > > > > Reviewed-by: Brian Foster <bfoster@redhat.com>
> > > > > > > > Reviewed-by: Darrick J. Wong <djwong@kernel.org>
> > > > > > > > ---
> > > > > > >
> > > > > > > Those two test cases fail on old system which doesn't support
> > > > > > > MADV_COLLAPSE:
> > > > > > >
> > > > > > >    fsx -N 10000 -l 500000 -h
> > > > > > >   -fsx -N 10000 -o 8192 -l 500000 -h
> > > > > > >   -fsx -N 10000 -o 128000 -l 500000 -h
> > > > > > >   +MADV_COLLAPSE not supported. Can't support -h
> > > > > > >
> > > > > > > and
> > > > > > >
> > > > > > >    fsx -N 10000 -l 500000 -r PSIZE -t BSIZE -w BSIZE -Z -R -W=
 -h
> > > > > > >   -fsx -N 10000 -o 8192 -l 500000 -r PSIZE -t BSIZE -w BSIZE =
-Z -R -W -h
> > > > > > >   -fsx -N 10000 -o 128000 -l 500000 -r PSIZE -t BSIZE -w BSIZ=
E -Z -R -W -h
> > > > > > >   +mapped writes DISABLED
> > > > > > >   +MADV_COLLAPSE not supported. Can't support -h
> > > > > > >
> > > > > > > I'm wondering ...
> > > > > > >
> > > > > > > >  ltp/fsx.c | 166 ++++++++++++++++++++++++++++++++++++++++++=
+++++++-----
> > > > > > > >  1 file changed, 153 insertions(+), 13 deletions(-)
> > > > > > > >
> > > > > > > > diff --git a/ltp/fsx.c b/ltp/fsx.c
> > > > > > > > index 41933354..3be383c6 100644
> > > > > > > > --- a/ltp/fsx.c
> > > > > > > > +++ b/ltp/fsx.c
> > > > > > > >  static struct option longopts[] =3D {
> > > > > > > >       {"replay-ops", required_argument, 0, 256},
> > > > > > > >       {"record-ops", optional_argument, 0, 255},
> > > > > > > > @@ -2883,7 +3023,7 @@ main(int argc, char **argv)
> > > > > > > >       setvbuf(stdout, (char *)0, _IOLBF, 0); /* line buffer=
ed stdout */
> > > > > > > >
> > > > > > > >       while ((ch =3D getopt_long(argc, argv,
> > > > > > > > -                              "0b:c:de:fg:i:j:kl:m:no:p:qr=
:s:t:uw:xyABD:EFJKHzCILN:OP:RS:UWXZ",
> > > > > > > > +                              "0b:c:de:fg:hi:j:kl:m:no:p:q=
r:s:t:uw:xyABD:EFJKHzCILN:OP:RS:UWXZ",
> > > > > > > >                                longopts, NULL)) !=3D EOF)
> > > > > > > >               switch (ch) {
> > > > > > > >               case 'b':
> > > > > > > > @@ -2916,6 +3056,14 @@ main(int argc, char **argv)
> > > > > > > >               case 'g':
> > > > > > > >                       filldata =3D *optarg;
> > > > > > > >                       break;
> > > > > > > > +             case 'h':
> > > > > > > > +#ifndef MADV_COLLAPSE
> > > > > > > > +                     fprintf(stderr, "MADV_COLLAPSE not su=
pported. "
> > > > > > > > +                             "Can't support -h\n");
> > > > > > > > +                     exit(86);
> > > > > > > > +#endif
> > > > > > > > +                     hugepages =3D 1;
> > > > > > > > +                     break;
> > > > > > >
> > > > > > > ...
> > > > > > > if we could change this part to:
> > > > > > >
> > > > > > > #ifdef MADV_COLLAPSE
> > > > > > >         hugepages =3D 1;
> > > > > > > #endif
> > > > > > >         break;
> > > > > > >
> > > > > > > to avoid the test failures on old systems.
> > > > > > >
> > > > > > > Or any better ideas from you :)
> > > > > >
> > > > > > Hi Zorro,
> > > > > >
> > > > > > It looks like MADV_COLLAPSE was introduced in kernel version 6.=
1. What
> > > > > > do you think about skipping generic/758 and generic/759 if the =
kernel
> > > > > > version is older than 6.1? That to me seems more preferable tha=
n the
> > > > > > paste above, as the paste above would execute the test as if it=
 did
> > > > > > test hugepages when in reality it didn't, which would be mislea=
ding.
> > > > >
> > > > > Now that I've gotten to try this out --
> > > > >
> > > > > There's a couple of things going on here.  The first is that gene=
ric/759
> > > > > and 760 need to check if invoking fsx -h causes it to spit out th=
e
> > > > > "MADV_COLLAPSE not supported" error and _notrun the test.
> > > > >
> > > > > The second thing is that userspace programs can ensure the existe=
nce of
> > > > > MADV_COLLAPSE in multiple ways.  The first way is through sys/mma=
n.h,
> > > > > which requires that the underlying C library headers are new enou=
gh to
> > > > > include a definition.  glibc 2.37 is new enough, but even things =
like
> > > > > Debian 12 and RHEL 9 aren't new enough to have that.  Other C lib=
raries
> > > > > might not follow glibc's practice of wrapping and/or redefining s=
ymbols
> > > > > in a way that you hope is the same as...
> > > > >
> > > > > The second way is through linux/mman.h, which comes from the kern=
el
> > > > > headers package; and the third way is for the program to define i=
t
> > > > > itself if nobody else does.
> > > > >
> > > > > So I think the easiest way to fix the fsx.c build is to include
> > > > > linux/mman.h in addition to sys/mman.h.  Sorry I didn't notice th=
ese
> > > >
> > > > Thanks for your input. Do we still need sys/mman.h if linux/mman.h =
is added?
> > >
> > > Yes, because glibc provides the mmap() function that wraps
> > > syscall(__NR_mmap, ...);
> > >
> > > > For generic/758 and 759, does it suffice to gate this on whether th=
e
> > > > kernel version if 6.1+ and _notrun if not? My understanding is that
> > > > any kernel version 6.1 or newer will have MADV_COLLAPSE in its kern=
el
> > > > headers package and support the feature.
> > >
> > > No, because some (most?) vendors backport new features into existing
> > > kernels without revving the version number of that kernel.
> >
> > Oh okay, I see. That makes sense, thanks for the explanation.
> >
> > >
> > > Maybe the following fixes things?
> > >
> > > --D
> > >
> > > generic/759,760: fix MADV_COLLAPSE detection and inclusion
> > >
> > > On systems with "old" C libraries such as glibc 2.36 in Debian 12, th=
e
> > > MADV_COLLAPSE flag might not be defined in any of the header files
> > > pulled in by sys/mman.h, which means that the fsx binary might not ge=
t
> > > built with any of the MADV_COLLAPSE code.  If the kernel supports THP=
,
> > > the test will fail with:
> > >
> > > >  QA output created by 760
> > > >  fsx -N 10000 -l 500000 -r PSIZE -t BSIZE -w BSIZE -Z -R -W -h
> > > > -fsx -N 10000 -o 8192 -l 500000 -r PSIZE -t BSIZE -w BSIZE -Z -R -W=
 -h
> > > > -fsx -N 10000 -o 128000 -l 500000 -r PSIZE -t BSIZE -w BSIZE -Z -R =
-W -h
> > > > +mapped writes DISABLED
> > > > +MADV_COLLAPSE not supported. Can't support -h
> > >
> > > Fix both tests to detect fsx binaries that don't support MADV_COLLAPS=
E,
> > > then fix fsx.c to include the mman.h from the kernel headers (aka
> > > linux/mman.h) so that we can actually test IOs to and from THPs if th=
e
> > > kernel is newer than the rest of userspace.
> > >
> > > Cc: <fstests@vger.kernel.org> # v2025.02.02
> > > Fixes: 627289232371e3 ("generic: add tests for read/writes from hugep=
ages-backed buffers")
> > > Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> > > ---
> > >  ltp/fsx.c         |    1 +
> > >  tests/generic/759 |    3 +++
> > >  tests/generic/760 |    3 +++
> > >  3 files changed, 7 insertions(+)
> > >
> > > diff --git a/ltp/fsx.c b/ltp/fsx.c
> > > index 634c496ffe9317..cf9502a74c17a7 100644
> > > --- a/ltp/fsx.c
> > > +++ b/ltp/fsx.c
> > > @@ -20,6 +20,7 @@
> > >  #include <strings.h>
> > >  #include <sys/file.h>
> > >  #include <sys/mman.h>
> > > +#include <linux/mman.h>
> > >  #include <sys/uio.h>
> > >  #include <stdbool.h>
> > >  #ifdef HAVE_ERR_H
> > > diff --git a/tests/generic/759 b/tests/generic/759
> > > index 6c74478aa8a0e0..3549c5ed6a9299 100755
> > > --- a/tests/generic/759
> > > +++ b/tests/generic/759
> > > @@ -14,6 +14,9 @@ _begin_fstest rw auto quick
> > >  _require_test
> > >  _require_thp
> > >
> > > +$here/ltp/fsx -N 0 -h $TEST_DIR 2>&1 | grep -q 'MADV_COLLAPSE not su=
pported' && \
> > > +       _notrun "fsx binary does not support MADV_COLLAPSE"
> > > +
> > >  run_fsx -N 10000            -l 500000 -h
> > >  run_fsx -N 10000  -o 8192   -l 500000 -h
> > >  run_fsx -N 10000  -o 128000 -l 500000 -h
> > > diff --git a/tests/generic/760 b/tests/generic/760
> > > index c71a196222ad3b..2fbd28502ae678 100755
> > > --- a/tests/generic/760
> > > +++ b/tests/generic/760
> > > @@ -15,6 +15,9 @@ _require_test
> > >  _require_odirect
> > >  _require_thp
> > >
> > > +$here/ltp/fsx -N 0 -h $TEST_DIR 2>&1 | grep -q 'MADV_COLLAPSE not su=
pported' && \
> > > +       _notrun "fsx binary does not support MADV_COLLAPSE"
> > > +
> >
> > I tried this out locally and it works for me:
> >
> > generic/759 8s ... [not run] fsx binary does not support MADV_COLLAPSE
> > Ran: generic/759
> > Not run: generic/759
> > Passed all 1 tests
> >
> > SECTION       -- fuse
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> > Ran: generic/759
> > Not run: generic/759
> > Passed all 1 tests
>
> Does the test actually run if you /do/ have kernel/libc headers that
> define MADV_COLLAPSE?  And if so, does that count as a Tested-by?
>

I'm not sure if I fully understand the subtext of your question but
yes, the test runs on my system when MADV_COLLAPSE is defined in the
kernel/libc headers.
For sanity checking the inverse case, (eg MADV_COLLAPSE not defined),
I tried this out by modifying the ifdef/ifndef checks in fsx to
MADV_COLLAPSE_ to see if the '$here/ltp/fsx -N 0 -h $TEST_DIR 2>&1 |
grep -q 'MADV_COLLAPSE not supported'' line catches that.


> --D
>
> >
> > Thanks,
> > Joanne
> >
> > >  psize=3D`$here/src/feature -s`
> > >  bsize=3D`$here/src/min_dio_alignment $TEST_DIR $TEST_DEV`
> > >
> >

