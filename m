Return-Path: <linux-fsdevel+bounces-40648-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B1369A26332
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2025 20:00:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B03D618869AA
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2025 19:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1005F1CAA63;
	Mon,  3 Feb 2025 18:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e4QcMkTh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F6AE1ADC98;
	Mon,  3 Feb 2025 18:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738609189; cv=none; b=t1a8iMeQUkKW6WizI6Igbn1w7I5wVlheAyH2hMqUyP9bi3+pN+dNiIX9HdZsjET/RpnXpula46fBYTfMlSIlqjencLXH8ciNhfaeYsc/X84MCGV/ZT2T0OXk2DRfrUKAc6WO93akRiWLIslRIsrLt9U3hCWJ702u6+xJN0g63Yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738609189; c=relaxed/simple;
	bh=qsuhz0QxD5DdLwuhG3U2qre9n+6uOa2G3UJ6fhCLvYs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CplqaSDFNy625pKsn/VBYPwH72wY3NECsAis1BdZB88umNuVkJqmJa8GZiZsPLnWrmEZqex70Be50KXPTwJIqnCctHvtWFQTYgxsVhXy4pQmfH/X8bG1qfFU8HRSaJ3QlnPTJSPV2S3Xg2xeOanUUfeNCnRSkployKT0dRYw7wU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e4QcMkTh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C49B9C4CED2;
	Mon,  3 Feb 2025 18:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738609188;
	bh=qsuhz0QxD5DdLwuhG3U2qre9n+6uOa2G3UJ6fhCLvYs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e4QcMkThqxk9+Xt7EIYtHDPtZVD7PkKL2TFcDdkXGMPy8pwZ4Fkx8vvn3+JAjCdr2
	 cBlLluy2M+LVFJnzYlxJryHNDH+o4Lez31MfDCPeVO3mErZSNJAbjDySKnKCY5Fjz0
	 D+bviEqpI4TMG2pNq7QtGk7AST3+x9FYQZcu03oug4SosOQRNha4psnpNxoa363gQ/
	 tfEfRqll2mLe6LvkuedMXQVbygdCaNJ6I0VbmzcRbqwbfKrHARmUDOSRhQyKUNv64m
	 rGq2/DgQ4W7Du/Obnav0jgeZXA8EYVGnxtvEUFn7/5pe+/dEgdQzlcCVuhYzXfTm8l
	 NZ2xec0+sRBOg==
Date: Mon, 3 Feb 2025 10:59:48 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, bfoster@redhat.com,
	nirjhar@linux.ibm.com, kernel-team@meta.com
Subject: Re: [PATCH v5 1/2] fsx: support reads/writes from buffers backed by
 hugepages
Message-ID: <20250203185948.GB134532@frogsfrogsfrogs>
References: <20250121215641.1764359-1-joannelkoong@gmail.com>
 <20250121215641.1764359-2-joannelkoong@gmail.com>
 <20250202142518.r3xvf7mvfo2nhb7t@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <CAJnrk1YwBJQnFwYBcO50Xy2dA6df_SqQsHdpLux4wa-Yw5rXdg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJnrk1YwBJQnFwYBcO50Xy2dA6df_SqQsHdpLux4wa-Yw5rXdg@mail.gmail.com>

On Mon, Feb 03, 2025 at 10:04:04AM -0800, Joanne Koong wrote:
> On Sun, Feb 2, 2025 at 6:25 AM Zorro Lang <zlang@redhat.com> wrote:
> >
> > On Tue, Jan 21, 2025 at 01:56:40PM -0800, Joanne Koong wrote:
> > > Add support for reads/writes from buffers backed by hugepages.
> > > This can be enabled through the '-h' flag. This flag should only be used
> > > on systems where THP capabilities are enabled.
> > >
> > > This is motivated by a recent bug that was due to faulty handling of
> > > userspace buffers backed by hugepages. This patch is a mitigation
> > > against problems like this in the future.
> > >
> > > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > > Reviewed-by: Brian Foster <bfoster@redhat.com>
> > > Reviewed-by: Darrick J. Wong <djwong@kernel.org>
> > > ---
> >
> > Those two test cases fail on old system which doesn't support
> > MADV_COLLAPSE:
> >
> >    fsx -N 10000 -l 500000 -h
> >   -fsx -N 10000 -o 8192 -l 500000 -h
> >   -fsx -N 10000 -o 128000 -l 500000 -h
> >   +MADV_COLLAPSE not supported. Can't support -h
> >
> > and
> >
> >    fsx -N 10000 -l 500000 -r PSIZE -t BSIZE -w BSIZE -Z -R -W -h
> >   -fsx -N 10000 -o 8192 -l 500000 -r PSIZE -t BSIZE -w BSIZE -Z -R -W -h
> >   -fsx -N 10000 -o 128000 -l 500000 -r PSIZE -t BSIZE -w BSIZE -Z -R -W -h
> >   +mapped writes DISABLED
> >   +MADV_COLLAPSE not supported. Can't support -h
> >
> > I'm wondering ...
> >
> > >  ltp/fsx.c | 166 +++++++++++++++++++++++++++++++++++++++++++++++++-----
> > >  1 file changed, 153 insertions(+), 13 deletions(-)
> > >
> > > diff --git a/ltp/fsx.c b/ltp/fsx.c
> > > index 41933354..3be383c6 100644
> > > --- a/ltp/fsx.c
> > > +++ b/ltp/fsx.c
> > > @@ -190,6 +190,16 @@ int      o_direct;                       /* -Z */
> > >  int  aio = 0;
> > >  int  uring = 0;
> > >  int  mark_nr = 0;
> > > +int  hugepages = 0;                  /* -h flag */
> > > +
> > > +/* Stores info needed to periodically collapse hugepages */
> > > +struct hugepages_collapse_info {
> > > +     void *orig_good_buf;
> > > +     long good_buf_size;
> > > +     void *orig_temp_buf;
> > > +     long temp_buf_size;
> > > +};
> > > +struct hugepages_collapse_info hugepages_info;
> > >
> > >  int page_size;
> > >  int page_mask;
> > > @@ -2471,7 +2481,7 @@ void
> > >  usage(void)
> > >  {
> > >       fprintf(stdout, "usage: %s",
> > > -             "fsx [-dfknqxyzBEFHIJKLORWXZ0]\n\
> > > +             "fsx [-dfhknqxyzBEFHIJKLORWXZ0]\n\
> > >          [-b opnum] [-c Prob] [-g filldata] [-i logdev] [-j logid]\n\
> > >          [-l flen] [-m start:end] [-o oplen] [-p progressinterval]\n\
> > >          [-r readbdy] [-s style] [-t truncbdy] [-w writebdy]\n\
> > > @@ -2483,8 +2493,11 @@ usage(void)
> > >       -d: debug output for all operations\n\
> > >       -e: pollute post-eof on size changes (default 0)\n\
> > >       -f: flush and invalidate cache after I/O\n\
> > > -     -g X: write character X instead of random generated data\n\
> > > -     -i logdev: do integrity testing, logdev is the dm log writes device\n\
> > > +     -g X: write character X instead of random generated data\n"
> > > +#ifdef MADV_COLLAPSE
> > > +"    -h hugepages: use buffers backed by hugepages for reads/writes\n"
> > > +#endif
> > > +"    -i logdev: do integrity testing, logdev is the dm log writes device\n\
> > >       -j logid: prefix debug log messsages with this id\n\
> > >       -k: do not truncate existing file and use its size as upper bound on file size\n\
> > >       -l flen: the upper bound on file size (default 262144)\n\
> > > @@ -2833,11 +2846,41 @@ __test_fallocate(int mode, const char *mode_str)
> > >  #endif
> > >  }
> > >
> > > +/*
> > > + * Reclaim may break up hugepages, so do a best-effort collapse every once in
> > > + * a while.
> > > + */
> > > +static void
> > > +collapse_hugepages(void)
> > > +{
> > > +#ifdef MADV_COLLAPSE
> > > +     int ret;
> > > +
> > > +     /* re-collapse every 16k fsxops after we start */
> > > +     if (!numops || (numops & ((1U << 14) - 1)))
> > > +             return;
> > > +
> > > +     ret = madvise(hugepages_info.orig_good_buf,
> > > +                   hugepages_info.good_buf_size, MADV_COLLAPSE);
> > > +     if (ret)
> > > +             prt("collapsing hugepages for good_buf failed (numops=%llu): %s\n",
> > > +                  numops, strerror(errno));
> > > +     ret = madvise(hugepages_info.orig_temp_buf,
> > > +                   hugepages_info.temp_buf_size, MADV_COLLAPSE);
> > > +     if (ret)
> > > +             prt("collapsing hugepages for temp_buf failed (numops=%llu): %s\n",
> > > +                  numops, strerror(errno));
> > > +#endif
> > > +}
> > > +
> > >  bool
> > >  keep_running(void)
> > >  {
> > >       int ret;
> > >
> > > +     if (hugepages)
> > > +             collapse_hugepages();
> > > +
> > >       if (deadline.tv_nsec) {
> > >               struct timespec now;
> > >
> > > @@ -2856,6 +2899,103 @@ keep_running(void)
> > >       return numops-- != 0;
> > >  }
> > >
> > > +static long
> > > +get_hugepage_size(void)
> > > +{
> > > +     const char str[] = "Hugepagesize:";
> > > +     size_t str_len =  sizeof(str) - 1;
> > > +     unsigned int hugepage_size = 0;
> > > +     char buffer[64];
> > > +     FILE *file;
> > > +
> > > +     file = fopen("/proc/meminfo", "r");
> > > +     if (!file) {
> > > +             prterr("get_hugepage_size: fopen /proc/meminfo");
> > > +             return -1;
> > > +     }
> > > +     while (fgets(buffer, sizeof(buffer), file)) {
> > > +             if (strncmp(buffer, str, str_len) == 0) {
> > > +                     sscanf(buffer + str_len, "%u", &hugepage_size);
> > > +                     break;
> > > +             }
> > > +     }
> > > +     fclose(file);
> > > +     if (!hugepage_size) {
> > > +             prterr("get_hugepage_size: failed to find "
> > > +                     "hugepage size in /proc/meminfo\n");
> > > +             return -1;
> > > +     }
> > > +
> > > +     /* convert from KiB to bytes */
> > > +     return hugepage_size << 10;
> > > +}
> > > +
> > > +static void *
> > > +init_hugepages_buf(unsigned len, int hugepage_size, int alignment, long *buf_size)
> > > +{
> > > +     void *buf = NULL;
> > > +#ifdef MADV_COLLAPSE
> > > +     int ret;
> > > +     long size = roundup(len, hugepage_size) + alignment;
> > > +
> > > +     ret = posix_memalign(&buf, hugepage_size, size);
> > > +     if (ret) {
> > > +             prterr("posix_memalign for buf");
> > > +             return NULL;
> > > +     }
> > > +     memset(buf, '\0', size);
> > > +     ret = madvise(buf, size, MADV_COLLAPSE);
> > > +     if (ret) {
> > > +             prterr("madvise collapse for buf");
> > > +             free(buf);
> > > +             return NULL;
> > > +     }
> > > +
> > > +     *buf_size = size;
> > > +#endif
> > > +     return buf;
> > > +}
> > > +
> > > +static void
> > > +init_buffers(void)
> > > +{
> > > +     int i;
> > > +
> > > +     original_buf = (char *) malloc(maxfilelen);
> > > +     for (i = 0; i < maxfilelen; i++)
> > > +             original_buf[i] = random() % 256;
> > > +     if (hugepages) {
> > > +             long hugepage_size = get_hugepage_size();
> > > +             if (hugepage_size == -1) {
> > > +                     prterr("get_hugepage_size()");
> > > +                     exit(102);
> > > +             }
> > > +             good_buf = init_hugepages_buf(maxfilelen, hugepage_size, writebdy,
> > > +                                           &hugepages_info.good_buf_size);
> > > +             if (!good_buf) {
> > > +                     prterr("init_hugepages_buf failed for good_buf");
> > > +                     exit(103);
> > > +             }
> > > +             hugepages_info.orig_good_buf = good_buf;
> > > +
> > > +             temp_buf = init_hugepages_buf(maxoplen, hugepage_size, readbdy,
> > > +                                           &hugepages_info.temp_buf_size);
> > > +             if (!temp_buf) {
> > > +                     prterr("init_hugepages_buf failed for temp_buf");
> > > +                     exit(103);
> > > +             }
> > > +             hugepages_info.orig_temp_buf = temp_buf;
> > > +     } else {
> > > +             unsigned long good_buf_len = maxfilelen + writebdy;
> > > +             unsigned long temp_buf_len = maxoplen + readbdy;
> > > +
> > > +             good_buf = calloc(1, good_buf_len);
> > > +             temp_buf = calloc(1, temp_buf_len);
> > > +     }
> > > +     good_buf = round_ptr_up(good_buf, writebdy, 0);
> > > +     temp_buf = round_ptr_up(temp_buf, readbdy, 0);
> > > +}
> > > +
> > >  static struct option longopts[] = {
> > >       {"replay-ops", required_argument, 0, 256},
> > >       {"record-ops", optional_argument, 0, 255},
> > > @@ -2883,7 +3023,7 @@ main(int argc, char **argv)
> > >       setvbuf(stdout, (char *)0, _IOLBF, 0); /* line buffered stdout */
> > >
> > >       while ((ch = getopt_long(argc, argv,
> > > -                              "0b:c:de:fg:i:j:kl:m:no:p:qr:s:t:uw:xyABD:EFJKHzCILN:OP:RS:UWXZ",
> > > +                              "0b:c:de:fg:hi:j:kl:m:no:p:qr:s:t:uw:xyABD:EFJKHzCILN:OP:RS:UWXZ",
> > >                                longopts, NULL)) != EOF)
> > >               switch (ch) {
> > >               case 'b':
> > > @@ -2916,6 +3056,14 @@ main(int argc, char **argv)
> > >               case 'g':
> > >                       filldata = *optarg;
> > >                       break;
> > > +             case 'h':
> > > +#ifndef MADV_COLLAPSE
> > > +                     fprintf(stderr, "MADV_COLLAPSE not supported. "
> > > +                             "Can't support -h\n");
> > > +                     exit(86);
> > > +#endif
> > > +                     hugepages = 1;
> > > +                     break;
> >
> > ...
> > if we could change this part to:
> >
> > #ifdef MADV_COLLAPSE
> >         hugepages = 1;
> > #endif
> >         break;
> >
> > to avoid the test failures on old systems.
> >
> > Or any better ideas from you :)
> 
> Hi Zorro,
> 
> It looks like MADV_COLLAPSE was introduced in kernel version 6.1. What
> do you think about skipping generic/758 and generic/759 if the kernel
> version is older than 6.1? That to me seems more preferable than the
> paste above, as the paste above would execute the test as if it did
> test hugepages when in reality it didn't, which would be misleading.

Now that I've gotten to try this out --

There's a couple of things going on here.  The first is that generic/759
and 760 need to check if invoking fsx -h causes it to spit out the
"MADV_COLLAPSE not supported" error and _notrun the test.

The second thing is that userspace programs can ensure the existence of
MADV_COLLAPSE in multiple ways.  The first way is through sys/mman.h,
which requires that the underlying C library headers are new enough to
include a definition.  glibc 2.37 is new enough, but even things like
Debian 12 and RHEL 9 aren't new enough to have that.  Other C libraries
might not follow glibc's practice of wrapping and/or redefining symbols
in a way that you hope is the same as...

The second way is through linux/mman.h, which comes from the kernel
headers package; and the third way is for the program to define it
itself if nobody else does.

So I think the easiest way to fix the fsx.c build is to include
linux/mman.h in addition to sys/mman.h.  Sorry I didn't notice these
details when I reviewed your patch; I'm a little attention constrained
ATM trying to get a large pile of bugfixes and redesigns reviewed so
for-next can finally move forward again.

--D

> 
> Thanks,
> Joanne
> 
> >
> > Thanks,
> > Zorro
> >
> > >               case 'i':
> > >                       integrity = 1;
> > >                       logdev = strdup(optarg);
> > > @@ -3229,15 +3377,7 @@ main(int argc, char **argv)
> > >                       exit(95);
> > >               }
> > >       }
> > > -     original_buf = (char *) malloc(maxfilelen);
> > > -     for (i = 0; i < maxfilelen; i++)
> > > -             original_buf[i] = random() % 256;
> > > -     good_buf = (char *) malloc(maxfilelen + writebdy);
> > > -     good_buf = round_ptr_up(good_buf, writebdy, 0);
> > > -     memset(good_buf, '\0', maxfilelen);
> > > -     temp_buf = (char *) malloc(maxoplen + readbdy);
> > > -     temp_buf = round_ptr_up(temp_buf, readbdy, 0);
> > > -     memset(temp_buf, '\0', maxoplen);
> > > +     init_buffers();
> > >       if (lite) {     /* zero entire existing file */
> > >               ssize_t written;
> > >
> > > --
> > > 2.47.1
> > >
> >

