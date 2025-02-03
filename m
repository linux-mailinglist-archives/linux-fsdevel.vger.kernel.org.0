Return-Path: <linux-fsdevel+bounces-40663-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A576DA26430
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2025 21:01:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A1DC161B3D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2025 20:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAB201E98EC;
	Mon,  3 Feb 2025 20:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d5wzg1pH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B323339A1;
	Mon,  3 Feb 2025 20:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738612911; cv=none; b=fNvn9/Yf3JXllDbFEpb3dwE4eOb83RrCVACpVkkAjfcBAhcXm5KZpd8p3b4O3X1OGEzwwCIivIOD+/aZwD3dBp7AhF6oPU8KfauV7cV86yG5nNYbB+ZLa+C57C0mA1QQSV+4NMGvSnHTc1YrJBVhzZddemcigReXQF5OUQfm5Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738612911; c=relaxed/simple;
	bh=E7LtpE/KUSKiXqvvDSB+x7EzPxna1N9mH7FkAJQiLBc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lv+EWgi5uzIL1dekEs2cCBQLHaLqqdjoP6odHf4G32hRgYhvHUWXeQ8oPbpZSI7Ok/d37T6i2aup98pz78CPI2SJ3YOK1HERTKDz7b/QsrvUGWPsk/wndw8f90VF5tLp2eRTTxuB5YN4Nz8vRz43QHVulu5xzhgUUZ9muBEANHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d5wzg1pH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AE96C4CED2;
	Mon,  3 Feb 2025 20:01:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738612910;
	bh=E7LtpE/KUSKiXqvvDSB+x7EzPxna1N9mH7FkAJQiLBc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d5wzg1pHUTFzW3ewDz1RzZs4vSd3Nz/TUrpLkui40eavnpTbYv8iL7rBoQt3Mqyw3
	 XUFNk61JGSlbKvPH+rpoBo4hD8d+ZPmQOkUlCYCZbJHHORg3u04t9Fk67z574h9x3+
	 p5WugvT7a8xGlZTx2O/qnlKL8fVFEA0SI1pZH1xkpwddin8f2SM/kH/9uFgcXvbcMh
	 ORSteFFUVmbAmHTjuKjE9X+CfaymRaa/iBqUNFhAqhkCT9UpPwkxVTbB0GNMR4E9Ke
	 FJ5OL14prO78km30jphRqVhGtcFJKEnnGUC7gJAb/gYoZ8WdY4JBeYpRGGWi7bd+Je
	 kBwyfpfTKFavw==
Date: Mon, 3 Feb 2025 12:01:49 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, bfoster@redhat.com,
	nirjhar@linux.ibm.com, kernel-team@meta.com
Subject: Re: [PATCH v5 1/2] fsx: support reads/writes from buffers backed by
 hugepages
Message-ID: <20250203200149.GC134490@frogsfrogsfrogs>
References: <20250121215641.1764359-1-joannelkoong@gmail.com>
 <20250121215641.1764359-2-joannelkoong@gmail.com>
 <20250202142518.r3xvf7mvfo2nhb7t@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <CAJnrk1YwBJQnFwYBcO50Xy2dA6df_SqQsHdpLux4wa-Yw5rXdg@mail.gmail.com>
 <20250203185948.GB134532@frogsfrogsfrogs>
 <CAJnrk1bX27KAOxChMs5pRNmrjjuxjYu11GG==vTN0sa8Qf2Uqw@mail.gmail.com>
 <20250203194147.GA134498@frogsfrogsfrogs>
 <CAJnrk1Y_eDFOnob3N78O3jcRoHy6Y0jaxnXbgVT0okBjwJue3g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJnrk1Y_eDFOnob3N78O3jcRoHy6Y0jaxnXbgVT0okBjwJue3g@mail.gmail.com>

On Mon, Feb 03, 2025 at 11:57:23AM -0800, Joanne Koong wrote:
> On Mon, Feb 3, 2025 at 11:41 AM Darrick J. Wong <djwong@kernel.org> wrote:
> >
> > On Mon, Feb 03, 2025 at 11:23:20AM -0800, Joanne Koong wrote:
> > > On Mon, Feb 3, 2025 at 10:59 AM Darrick J. Wong <djwong@kernel.org> wrote:
> > > >
> > > > On Mon, Feb 03, 2025 at 10:04:04AM -0800, Joanne Koong wrote:
> > > > > On Sun, Feb 2, 2025 at 6:25 AM Zorro Lang <zlang@redhat.com> wrote:
> > > > > >
> > > > > > On Tue, Jan 21, 2025 at 01:56:40PM -0800, Joanne Koong wrote:
> > > > > > > Add support for reads/writes from buffers backed by hugepages.
> > > > > > > This can be enabled through the '-h' flag. This flag should only be used
> > > > > > > on systems where THP capabilities are enabled.
> > > > > > >
> > > > > > > This is motivated by a recent bug that was due to faulty handling of
> > > > > > > userspace buffers backed by hugepages. This patch is a mitigation
> > > > > > > against problems like this in the future.
> > > > > > >
> > > > > > > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > > > > > > Reviewed-by: Brian Foster <bfoster@redhat.com>
> > > > > > > Reviewed-by: Darrick J. Wong <djwong@kernel.org>
> > > > > > > ---
> > > > > >
> > > > > > Those two test cases fail on old system which doesn't support
> > > > > > MADV_COLLAPSE:
> > > > > >
> > > > > >    fsx -N 10000 -l 500000 -h
> > > > > >   -fsx -N 10000 -o 8192 -l 500000 -h
> > > > > >   -fsx -N 10000 -o 128000 -l 500000 -h
> > > > > >   +MADV_COLLAPSE not supported. Can't support -h
> > > > > >
> > > > > > and
> > > > > >
> > > > > >    fsx -N 10000 -l 500000 -r PSIZE -t BSIZE -w BSIZE -Z -R -W -h
> > > > > >   -fsx -N 10000 -o 8192 -l 500000 -r PSIZE -t BSIZE -w BSIZE -Z -R -W -h
> > > > > >   -fsx -N 10000 -o 128000 -l 500000 -r PSIZE -t BSIZE -w BSIZE -Z -R -W -h
> > > > > >   +mapped writes DISABLED
> > > > > >   +MADV_COLLAPSE not supported. Can't support -h
> > > > > >
> > > > > > I'm wondering ...
> > > > > >
> > > > > > >  ltp/fsx.c | 166 +++++++++++++++++++++++++++++++++++++++++++++++++-----
> > > > > > >  1 file changed, 153 insertions(+), 13 deletions(-)
> > > > > > >
> > > > > > > diff --git a/ltp/fsx.c b/ltp/fsx.c
> > > > > > > index 41933354..3be383c6 100644
> > > > > > > --- a/ltp/fsx.c
> > > > > > > +++ b/ltp/fsx.c
> > > > > > >  static struct option longopts[] = {
> > > > > > >       {"replay-ops", required_argument, 0, 256},
> > > > > > >       {"record-ops", optional_argument, 0, 255},
> > > > > > > @@ -2883,7 +3023,7 @@ main(int argc, char **argv)
> > > > > > >       setvbuf(stdout, (char *)0, _IOLBF, 0); /* line buffered stdout */
> > > > > > >
> > > > > > >       while ((ch = getopt_long(argc, argv,
> > > > > > > -                              "0b:c:de:fg:i:j:kl:m:no:p:qr:s:t:uw:xyABD:EFJKHzCILN:OP:RS:UWXZ",
> > > > > > > +                              "0b:c:de:fg:hi:j:kl:m:no:p:qr:s:t:uw:xyABD:EFJKHzCILN:OP:RS:UWXZ",
> > > > > > >                                longopts, NULL)) != EOF)
> > > > > > >               switch (ch) {
> > > > > > >               case 'b':
> > > > > > > @@ -2916,6 +3056,14 @@ main(int argc, char **argv)
> > > > > > >               case 'g':
> > > > > > >                       filldata = *optarg;
> > > > > > >                       break;
> > > > > > > +             case 'h':
> > > > > > > +#ifndef MADV_COLLAPSE
> > > > > > > +                     fprintf(stderr, "MADV_COLLAPSE not supported. "
> > > > > > > +                             "Can't support -h\n");
> > > > > > > +                     exit(86);
> > > > > > > +#endif
> > > > > > > +                     hugepages = 1;
> > > > > > > +                     break;
> > > > > >
> > > > > > ...
> > > > > > if we could change this part to:
> > > > > >
> > > > > > #ifdef MADV_COLLAPSE
> > > > > >         hugepages = 1;
> > > > > > #endif
> > > > > >         break;
> > > > > >
> > > > > > to avoid the test failures on old systems.
> > > > > >
> > > > > > Or any better ideas from you :)
> > > > >
> > > > > Hi Zorro,
> > > > >
> > > > > It looks like MADV_COLLAPSE was introduced in kernel version 6.1. What
> > > > > do you think about skipping generic/758 and generic/759 if the kernel
> > > > > version is older than 6.1? That to me seems more preferable than the
> > > > > paste above, as the paste above would execute the test as if it did
> > > > > test hugepages when in reality it didn't, which would be misleading.
> > > >
> > > > Now that I've gotten to try this out --
> > > >
> > > > There's a couple of things going on here.  The first is that generic/759
> > > > and 760 need to check if invoking fsx -h causes it to spit out the
> > > > "MADV_COLLAPSE not supported" error and _notrun the test.
> > > >
> > > > The second thing is that userspace programs can ensure the existence of
> > > > MADV_COLLAPSE in multiple ways.  The first way is through sys/mman.h,
> > > > which requires that the underlying C library headers are new enough to
> > > > include a definition.  glibc 2.37 is new enough, but even things like
> > > > Debian 12 and RHEL 9 aren't new enough to have that.  Other C libraries
> > > > might not follow glibc's practice of wrapping and/or redefining symbols
> > > > in a way that you hope is the same as...
> > > >
> > > > The second way is through linux/mman.h, which comes from the kernel
> > > > headers package; and the third way is for the program to define it
> > > > itself if nobody else does.
> > > >
> > > > So I think the easiest way to fix the fsx.c build is to include
> > > > linux/mman.h in addition to sys/mman.h.  Sorry I didn't notice these
> > >
> > > Thanks for your input. Do we still need sys/mman.h if linux/mman.h is added?
> >
> > Yes, because glibc provides the mmap() function that wraps
> > syscall(__NR_mmap, ...);
> >
> > > For generic/758 and 759, does it suffice to gate this on whether the
> > > kernel version if 6.1+ and _notrun if not? My understanding is that
> > > any kernel version 6.1 or newer will have MADV_COLLAPSE in its kernel
> > > headers package and support the feature.
> >
> > No, because some (most?) vendors backport new features into existing
> > kernels without revving the version number of that kernel.
> 
> Oh okay, I see. That makes sense, thanks for the explanation.
> 
> >
> > Maybe the following fixes things?
> >
> > --D
> >
> > generic/759,760: fix MADV_COLLAPSE detection and inclusion
> >
> > On systems with "old" C libraries such as glibc 2.36 in Debian 12, the
> > MADV_COLLAPSE flag might not be defined in any of the header files
> > pulled in by sys/mman.h, which means that the fsx binary might not get
> > built with any of the MADV_COLLAPSE code.  If the kernel supports THP,
> > the test will fail with:
> >
> > >  QA output created by 760
> > >  fsx -N 10000 -l 500000 -r PSIZE -t BSIZE -w BSIZE -Z -R -W -h
> > > -fsx -N 10000 -o 8192 -l 500000 -r PSIZE -t BSIZE -w BSIZE -Z -R -W -h
> > > -fsx -N 10000 -o 128000 -l 500000 -r PSIZE -t BSIZE -w BSIZE -Z -R -W -h
> > > +mapped writes DISABLED
> > > +MADV_COLLAPSE not supported. Can't support -h
> >
> > Fix both tests to detect fsx binaries that don't support MADV_COLLAPSE,
> > then fix fsx.c to include the mman.h from the kernel headers (aka
> > linux/mman.h) so that we can actually test IOs to and from THPs if the
> > kernel is newer than the rest of userspace.
> >
> > Cc: <fstests@vger.kernel.org> # v2025.02.02
> > Fixes: 627289232371e3 ("generic: add tests for read/writes from hugepages-backed buffers")
> > Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> > ---
> >  ltp/fsx.c         |    1 +
> >  tests/generic/759 |    3 +++
> >  tests/generic/760 |    3 +++
> >  3 files changed, 7 insertions(+)
> >
> > diff --git a/ltp/fsx.c b/ltp/fsx.c
> > index 634c496ffe9317..cf9502a74c17a7 100644
> > --- a/ltp/fsx.c
> > +++ b/ltp/fsx.c
> > @@ -20,6 +20,7 @@
> >  #include <strings.h>
> >  #include <sys/file.h>
> >  #include <sys/mman.h>
> > +#include <linux/mman.h>
> >  #include <sys/uio.h>
> >  #include <stdbool.h>
> >  #ifdef HAVE_ERR_H
> > diff --git a/tests/generic/759 b/tests/generic/759
> > index 6c74478aa8a0e0..3549c5ed6a9299 100755
> > --- a/tests/generic/759
> > +++ b/tests/generic/759
> > @@ -14,6 +14,9 @@ _begin_fstest rw auto quick
> >  _require_test
> >  _require_thp
> >
> > +$here/ltp/fsx -N 0 -h $TEST_DIR 2>&1 | grep -q 'MADV_COLLAPSE not supported' && \
> > +       _notrun "fsx binary does not support MADV_COLLAPSE"
> > +
> >  run_fsx -N 10000            -l 500000 -h
> >  run_fsx -N 10000  -o 8192   -l 500000 -h
> >  run_fsx -N 10000  -o 128000 -l 500000 -h
> > diff --git a/tests/generic/760 b/tests/generic/760
> > index c71a196222ad3b..2fbd28502ae678 100755
> > --- a/tests/generic/760
> > +++ b/tests/generic/760
> > @@ -15,6 +15,9 @@ _require_test
> >  _require_odirect
> >  _require_thp
> >
> > +$here/ltp/fsx -N 0 -h $TEST_DIR 2>&1 | grep -q 'MADV_COLLAPSE not supported' && \
> > +       _notrun "fsx binary does not support MADV_COLLAPSE"
> > +
> 
> I tried this out locally and it works for me:
> 
> generic/759 8s ... [not run] fsx binary does not support MADV_COLLAPSE
> Ran: generic/759
> Not run: generic/759
> Passed all 1 tests
> 
> SECTION       -- fuse
> =========================
> Ran: generic/759
> Not run: generic/759
> Passed all 1 tests

Does the test actually run if you /do/ have kernel/libc headers that
define MADV_COLLAPSE?  And if so, does that count as a Tested-by?

--D

> 
> Thanks,
> Joanne
> 
> >  psize=`$here/src/feature -s`
> >  bsize=`$here/src/min_dio_alignment $TEST_DIR $TEST_DEV`
> >
> 

