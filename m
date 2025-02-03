Return-Path: <linux-fsdevel+bounces-40661-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F001A26425
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2025 20:57:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 154D51884851
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2025 19:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1333C20B20E;
	Mon,  3 Feb 2025 19:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CIyML9FF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9183020A5CF;
	Mon,  3 Feb 2025 19:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738612657; cv=none; b=I2O/HWWnoMTEPW8EX+V81U9AiJYlaQ3VKiGe7ed+1tcoLbyt3WdnUgW6LGfiFNvsSaaI/DPdY76+JR0tFAg922QPswBvVJghmYJQ1t+kwp1uop7vFMK40UhD7wXhGemvz8xMxMRnvJCxIGr7/NyxCkLbhl3AfW64rVrw30I6JuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738612657; c=relaxed/simple;
	bh=aJLGf9rt7RJBKSWKwJY1V28seWbyQrp3nkxewi8SGkk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sfbfYCjYazZ/5sHUyI9HTn9axNgNsgR8M4KC3oF7LnM+mwRSwiAAlGxRUTgb4GHObMH4n5Gpq2zNstVRisLMk3CyVTsCOmoYrkNtLLsXjstnxWtUH7CWK8qvJd9RgBaKtH2/3OYd7+PmYojDsH8CJ5kuPV0YnN934P2lRWZpCKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CIyML9FF; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-46c8474d8daso34848071cf.3;
        Mon, 03 Feb 2025 11:57:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738612654; x=1739217454; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V/iUwPXHZRDZRAGVFGYSyCI4n2Uhk2otndrYzROnkAY=;
        b=CIyML9FFEaWvKabCZR4sLgPqiMqz1CVQbM94hB1fyktaGXjhnL85ijAoH1V/sfPlJ0
         JuLbrfgcEz7A+tdwYHfl14oeYNcfWRqbMYTRw7jwlFnZfi9tJQuE2AsA9IBsmHrr9hYv
         PXE5D2fDd5xpTXxZhfovnWVIk3nQMOJMzsOiRmRCx9KpMrS4iuyfmq8U6UmsVpXFRNX5
         jfLVhV3/0sY5UosMbDB99rzEQoED6G8Y7x+m5+k3VKAMRF5REBkcgarK4qStF92AtNQq
         ZwJAL7s8hAiKfQ+8RK+rmYzJX8Fg1EVL/AZSrzF3piszc0q61mZ/yITMxGEQ5Sk7kQrL
         3E/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738612654; x=1739217454;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V/iUwPXHZRDZRAGVFGYSyCI4n2Uhk2otndrYzROnkAY=;
        b=p1ek5FeehIxviQ9BPP7awfQ+q9og+4ZeCt9+PIjiFFgkuq4muwSvUbFGWH+P7/zjnu
         ajvSgui+oLtofFPj+B4exGmOzVgpqU5UdvTlNHAk3gprW4KB71a285DpZAK3dAPBrgVc
         vnEAaRRrANgZdP2mWQGy4+V9zWdGCJuGaT6yqBHVHdEHLjahXj9KC7n7IKof+c4qlVas
         LeNmEyjeqVHlPYLsDR9XLL3zaJFD4rwQKBybrhuMhxuo+boZhLMm7ukHW2ss80dfMM46
         tsQ44UNRIgoMq+nS2LepRyzcHhRb7TqHnKBAmQY4zHe86VhZnGOxQ+SRwFVgWrVNG6do
         fYPw==
X-Forwarded-Encrypted: i=1; AJvYcCVyGFc5N0ZdOoeVf5ByVK/1yDGSg07ilLQkwlWpsTyB5gMGn5BqcXimlySez96s3v+sFsxWf78S@vger.kernel.org, AJvYcCW2qHuiZPCEEs3g1qLLM5kPAY/Bi3AO1fN+kgtQFhueJMoj74hwEEV73LQMWNcdSSPi6ABXjESUVXuBsKZrXw==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywi0qtJYfZmLJTCHIRFRk3XpbLn6Ah8Q6ING0YA6Q3ki10X0aG6
	h5PaESUGlBRhrttRWkclIpm0aQpEnxQmkOPaCE83YG3nHqmrnUzCyi9+Wg1sTSKCXUbjVdKiL5u
	vi0GfYZcvyk22kVpW4jDecHlRkB8=
X-Gm-Gg: ASbGncuMT18Ul87QLTUdkoRuXjCX6XO5dkeH0JOhwXDlJY42keUIhAQ+gQuXbSes2ti
	siDcT3/zquyLOcXMYuQV6Yz2F/LXWi5Wz23wxe24prG1vj1TPfOFWGoxgEYmOTXFQf1yn58tTG/
	KZP3EawKRzl+hR
X-Google-Smtp-Source: AGHT+IEShNIG1G0/OcrdbgPhgxqL7o33coH6rHEwwFujnfJxWvNZYl8NcdTLswynC375epELE6PR1Qil6KhKCLst9c8=
X-Received: by 2002:a05:622a:8e11:b0:46f:d6c3:2def with SMTP id
 d75a77b69052e-46fd6c33038mr198357021cf.49.1738612654304; Mon, 03 Feb 2025
 11:57:34 -0800 (PST)
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
 <20250203194147.GA134498@frogsfrogsfrogs>
In-Reply-To: <20250203194147.GA134498@frogsfrogsfrogs>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Mon, 3 Feb 2025 11:57:23 -0800
X-Gm-Features: AWEUYZkhTMP28pdk3ZOYW0sUusLLyckMhNkJuRdkHz7eGUcjxbWvV8JChRhB8Tw
Message-ID: <CAJnrk1Y_eDFOnob3N78O3jcRoHy6Y0jaxnXbgVT0okBjwJue3g@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] fsx: support reads/writes from buffers backed by hugepages
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, bfoster@redhat.com, nirjhar@linux.ibm.com, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 3, 2025 at 11:41=E2=80=AFAM Darrick J. Wong <djwong@kernel.org>=
 wrote:
>
> On Mon, Feb 03, 2025 at 11:23:20AM -0800, Joanne Koong wrote:
> > On Mon, Feb 3, 2025 at 10:59=E2=80=AFAM Darrick J. Wong <djwong@kernel.=
org> wrote:
> > >
> > > On Mon, Feb 03, 2025 at 10:04:04AM -0800, Joanne Koong wrote:
> > > > On Sun, Feb 2, 2025 at 6:25=E2=80=AFAM Zorro Lang <zlang@redhat.com=
> wrote:
> > > > >
> > > > > On Tue, Jan 21, 2025 at 01:56:40PM -0800, Joanne Koong wrote:
> > > > > > Add support for reads/writes from buffers backed by hugepages.
> > > > > > This can be enabled through the '-h' flag. This flag should onl=
y be used
> > > > > > on systems where THP capabilities are enabled.
> > > > > >
> > > > > > This is motivated by a recent bug that was due to faulty handli=
ng of
> > > > > > userspace buffers backed by hugepages. This patch is a mitigati=
on
> > > > > > against problems like this in the future.
> > > > > >
> > > > > > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > > > > > Reviewed-by: Brian Foster <bfoster@redhat.com>
> > > > > > Reviewed-by: Darrick J. Wong <djwong@kernel.org>
> > > > > > ---
> > > > >
> > > > > Those two test cases fail on old system which doesn't support
> > > > > MADV_COLLAPSE:
> > > > >
> > > > >    fsx -N 10000 -l 500000 -h
> > > > >   -fsx -N 10000 -o 8192 -l 500000 -h
> > > > >   -fsx -N 10000 -o 128000 -l 500000 -h
> > > > >   +MADV_COLLAPSE not supported. Can't support -h
> > > > >
> > > > > and
> > > > >
> > > > >    fsx -N 10000 -l 500000 -r PSIZE -t BSIZE -w BSIZE -Z -R -W -h
> > > > >   -fsx -N 10000 -o 8192 -l 500000 -r PSIZE -t BSIZE -w BSIZE -Z -=
R -W -h
> > > > >   -fsx -N 10000 -o 128000 -l 500000 -r PSIZE -t BSIZE -w BSIZE -Z=
 -R -W -h
> > > > >   +mapped writes DISABLED
> > > > >   +MADV_COLLAPSE not supported. Can't support -h
> > > > >
> > > > > I'm wondering ...
> > > > >
> > > > > >  ltp/fsx.c | 166 ++++++++++++++++++++++++++++++++++++++++++++++=
+++-----
> > > > > >  1 file changed, 153 insertions(+), 13 deletions(-)
> > > > > >
> > > > > > diff --git a/ltp/fsx.c b/ltp/fsx.c
> > > > > > index 41933354..3be383c6 100644
> > > > > > --- a/ltp/fsx.c
> > > > > > +++ b/ltp/fsx.c
> > > > > >  static struct option longopts[] =3D {
> > > > > >       {"replay-ops", required_argument, 0, 256},
> > > > > >       {"record-ops", optional_argument, 0, 255},
> > > > > > @@ -2883,7 +3023,7 @@ main(int argc, char **argv)
> > > > > >       setvbuf(stdout, (char *)0, _IOLBF, 0); /* line buffered s=
tdout */
> > > > > >
> > > > > >       while ((ch =3D getopt_long(argc, argv,
> > > > > > -                              "0b:c:de:fg:i:j:kl:m:no:p:qr:s:t=
:uw:xyABD:EFJKHzCILN:OP:RS:UWXZ",
> > > > > > +                              "0b:c:de:fg:hi:j:kl:m:no:p:qr:s:=
t:uw:xyABD:EFJKHzCILN:OP:RS:UWXZ",
> > > > > >                                longopts, NULL)) !=3D EOF)
> > > > > >               switch (ch) {
> > > > > >               case 'b':
> > > > > > @@ -2916,6 +3056,14 @@ main(int argc, char **argv)
> > > > > >               case 'g':
> > > > > >                       filldata =3D *optarg;
> > > > > >                       break;
> > > > > > +             case 'h':
> > > > > > +#ifndef MADV_COLLAPSE
> > > > > > +                     fprintf(stderr, "MADV_COLLAPSE not suppor=
ted. "
> > > > > > +                             "Can't support -h\n");
> > > > > > +                     exit(86);
> > > > > > +#endif
> > > > > > +                     hugepages =3D 1;
> > > > > > +                     break;
> > > > >
> > > > > ...
> > > > > if we could change this part to:
> > > > >
> > > > > #ifdef MADV_COLLAPSE
> > > > >         hugepages =3D 1;
> > > > > #endif
> > > > >         break;
> > > > >
> > > > > to avoid the test failures on old systems.
> > > > >
> > > > > Or any better ideas from you :)
> > > >
> > > > Hi Zorro,
> > > >
> > > > It looks like MADV_COLLAPSE was introduced in kernel version 6.1. W=
hat
> > > > do you think about skipping generic/758 and generic/759 if the kern=
el
> > > > version is older than 6.1? That to me seems more preferable than th=
e
> > > > paste above, as the paste above would execute the test as if it did
> > > > test hugepages when in reality it didn't, which would be misleading=
.
> > >
> > > Now that I've gotten to try this out --
> > >
> > > There's a couple of things going on here.  The first is that generic/=
759
> > > and 760 need to check if invoking fsx -h causes it to spit out the
> > > "MADV_COLLAPSE not supported" error and _notrun the test.
> > >
> > > The second thing is that userspace programs can ensure the existence =
of
> > > MADV_COLLAPSE in multiple ways.  The first way is through sys/mman.h,
> > > which requires that the underlying C library headers are new enough t=
o
> > > include a definition.  glibc 2.37 is new enough, but even things like
> > > Debian 12 and RHEL 9 aren't new enough to have that.  Other C librari=
es
> > > might not follow glibc's practice of wrapping and/or redefining symbo=
ls
> > > in a way that you hope is the same as...
> > >
> > > The second way is through linux/mman.h, which comes from the kernel
> > > headers package; and the third way is for the program to define it
> > > itself if nobody else does.
> > >
> > > So I think the easiest way to fix the fsx.c build is to include
> > > linux/mman.h in addition to sys/mman.h.  Sorry I didn't notice these
> >
> > Thanks for your input. Do we still need sys/mman.h if linux/mman.h is a=
dded?
>
> Yes, because glibc provides the mmap() function that wraps
> syscall(__NR_mmap, ...);
>
> > For generic/758 and 759, does it suffice to gate this on whether the
> > kernel version if 6.1+ and _notrun if not? My understanding is that
> > any kernel version 6.1 or newer will have MADV_COLLAPSE in its kernel
> > headers package and support the feature.
>
> No, because some (most?) vendors backport new features into existing
> kernels without revving the version number of that kernel.

Oh okay, I see. That makes sense, thanks for the explanation.

>
> Maybe the following fixes things?
>
> --D
>
> generic/759,760: fix MADV_COLLAPSE detection and inclusion
>
> On systems with "old" C libraries such as glibc 2.36 in Debian 12, the
> MADV_COLLAPSE flag might not be defined in any of the header files
> pulled in by sys/mman.h, which means that the fsx binary might not get
> built with any of the MADV_COLLAPSE code.  If the kernel supports THP,
> the test will fail with:
>
> >  QA output created by 760
> >  fsx -N 10000 -l 500000 -r PSIZE -t BSIZE -w BSIZE -Z -R -W -h
> > -fsx -N 10000 -o 8192 -l 500000 -r PSIZE -t BSIZE -w BSIZE -Z -R -W -h
> > -fsx -N 10000 -o 128000 -l 500000 -r PSIZE -t BSIZE -w BSIZE -Z -R -W -=
h
> > +mapped writes DISABLED
> > +MADV_COLLAPSE not supported. Can't support -h
>
> Fix both tests to detect fsx binaries that don't support MADV_COLLAPSE,
> then fix fsx.c to include the mman.h from the kernel headers (aka
> linux/mman.h) so that we can actually test IOs to and from THPs if the
> kernel is newer than the rest of userspace.
>
> Cc: <fstests@vger.kernel.org> # v2025.02.02
> Fixes: 627289232371e3 ("generic: add tests for read/writes from hugepages=
-backed buffers")
> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> ---
>  ltp/fsx.c         |    1 +
>  tests/generic/759 |    3 +++
>  tests/generic/760 |    3 +++
>  3 files changed, 7 insertions(+)
>
> diff --git a/ltp/fsx.c b/ltp/fsx.c
> index 634c496ffe9317..cf9502a74c17a7 100644
> --- a/ltp/fsx.c
> +++ b/ltp/fsx.c
> @@ -20,6 +20,7 @@
>  #include <strings.h>
>  #include <sys/file.h>
>  #include <sys/mman.h>
> +#include <linux/mman.h>
>  #include <sys/uio.h>
>  #include <stdbool.h>
>  #ifdef HAVE_ERR_H
> diff --git a/tests/generic/759 b/tests/generic/759
> index 6c74478aa8a0e0..3549c5ed6a9299 100755
> --- a/tests/generic/759
> +++ b/tests/generic/759
> @@ -14,6 +14,9 @@ _begin_fstest rw auto quick
>  _require_test
>  _require_thp
>
> +$here/ltp/fsx -N 0 -h $TEST_DIR 2>&1 | grep -q 'MADV_COLLAPSE not suppor=
ted' && \
> +       _notrun "fsx binary does not support MADV_COLLAPSE"
> +
>  run_fsx -N 10000            -l 500000 -h
>  run_fsx -N 10000  -o 8192   -l 500000 -h
>  run_fsx -N 10000  -o 128000 -l 500000 -h
> diff --git a/tests/generic/760 b/tests/generic/760
> index c71a196222ad3b..2fbd28502ae678 100755
> --- a/tests/generic/760
> +++ b/tests/generic/760
> @@ -15,6 +15,9 @@ _require_test
>  _require_odirect
>  _require_thp
>
> +$here/ltp/fsx -N 0 -h $TEST_DIR 2>&1 | grep -q 'MADV_COLLAPSE not suppor=
ted' && \
> +       _notrun "fsx binary does not support MADV_COLLAPSE"
> +

I tried this out locally and it works for me:

generic/759 8s ... [not run] fsx binary does not support MADV_COLLAPSE
Ran: generic/759
Not run: generic/759
Passed all 1 tests

SECTION       -- fuse
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Ran: generic/759
Not run: generic/759
Passed all 1 tests


Thanks,
Joanne

>  psize=3D`$here/src/feature -s`
>  bsize=3D`$here/src/min_dio_alignment $TEST_DIR $TEST_DEV`
>

