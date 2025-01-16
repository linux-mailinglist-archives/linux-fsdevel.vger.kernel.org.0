Return-Path: <linux-fsdevel+bounces-39346-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B7503A13062
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2025 01:59:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E62CC1656A4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2025 00:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD1AD1F942;
	Thu, 16 Jan 2025 00:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sfRx1TK2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 414751C695;
	Thu, 16 Jan 2025 00:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736989160; cv=none; b=HLsI+ZPVA3Zvv+1/5HByy0yNkHopWTDQ58KR0PSQhe95xAc70yA9ZJNIGlrz2eXdV/wvALBTwqbrW88ueL7VYmOTDOxMIf+F2Jt0aHFaHTHzaiOKjwnEHq9C9eGIvDd6uJvqP/fwYwOrnJ94KHuYzhNPbU1Ze04KgGakXbWymx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736989160; c=relaxed/simple;
	bh=ImMCwY7QVTMAavcCAhR3QzUeA/aLOiL8OwUV6ldVi+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CYhKaiAfo/4YGJ8DYLVZPmFi3Uo21YxH1jMT4csoxuMwMRfeXf7TM9cWXDgAnBiFEbrV2fhTlBjnoLdnxyYJTebOYsSK/2Bmv84j45aFNbcoxW9L1f09VS2rsugBEgUY5dicHyfgaRyf0/sGIMxlqTw0O7rcyQhqc87aPQmibQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sfRx1TK2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD317C4CED1;
	Thu, 16 Jan 2025 00:59:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736989159;
	bh=ImMCwY7QVTMAavcCAhR3QzUeA/aLOiL8OwUV6ldVi+I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sfRx1TK2n8JMjX21kcv84Nmi1MeYpULHhBnc5YWAehVQoRhGO3dZeUfLxvkoeWBhf
	 Wi0owFnvzmhwh96s3GZQtRfEYDpxa0NPdIvQ7CZTRT445V7N7CJ8P99M+BvPHbcBEk
	 dd0LyFyHvda407FblIoN5xX+XhBOBf4jC/iwLG7nHQ2BY7D1imkK5OBWwo7qJ6U5fJ
	 8u3CRm3I2yHh+a76eE7poKE/K9qHjuFKfSD1y4K8B3LCCNYgaTtgaFQll1ojEL2nS9
	 zXVqj8goWFke21FOzwgvjaM1wnUZZEcJM5OsTMKdn/MaXNv4i5NTunnXPSkBPXOtpK
	 noMZKQeMcqBkQ==
Date: Wed, 15 Jan 2025 16:59:19 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: fstests@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	bfoster@redhat.com, nirjhar@linux.ibm.com, zlang@redhat.com,
	kernel-team@meta.com
Subject: Re: [PATCH v3 1/2] fsx: support reads/writes from buffers backed by
 hugepages
Message-ID: <20250116005919.GK3557553@frogsfrogsfrogs>
References: <20250115183107.3124743-1-joannelkoong@gmail.com>
 <20250115183107.3124743-2-joannelkoong@gmail.com>
 <20250115213713.GE3557695@frogsfrogsfrogs>
 <CAJnrk1YXa++SrifrCfXf7WPQF34V20cet3+x+7wVuDf9CPoR7w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJnrk1YXa++SrifrCfXf7WPQF34V20cet3+x+7wVuDf9CPoR7w@mail.gmail.com>

On Wed, Jan 15, 2025 at 04:47:30PM -0800, Joanne Koong wrote:
> On Wed, Jan 15, 2025 at 1:37 PM Darrick J. Wong <djwong@kernel.org> wrote:
> >
> > On Wed, Jan 15, 2025 at 10:31:06AM -0800, Joanne Koong wrote:
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
> > > ---
> > >  ltp/fsx.c | 119 +++++++++++++++++++++++++++++++++++++++++++++++++-----
> > >  1 file changed, 108 insertions(+), 11 deletions(-)
> > >
> > > diff --git a/ltp/fsx.c b/ltp/fsx.c
> > > index 41933354..8d3a2e2c 100644
> > > --- a/ltp/fsx.c
> > > +++ b/ltp/fsx.c
> > > @@ -190,6 +190,7 @@ int       o_direct;                       /* -Z */
> > >  int  aio = 0;
> > >  int  uring = 0;
> > >  int  mark_nr = 0;
> > > +int  hugepages = 0;                  /* -h flag */
> > >
> > >  int page_size;
> > >  int page_mask;
> > > @@ -2471,7 +2472,7 @@ void
> > >  usage(void)
> > >  {
> > >       fprintf(stdout, "usage: %s",
> > > -             "fsx [-dfknqxyzBEFHIJKLORWXZ0]\n\
> > > +             "fsx [-dfhknqxyzBEFHIJKLORWXZ0]\n\
> > >          [-b opnum] [-c Prob] [-g filldata] [-i logdev] [-j logid]\n\
> > >          [-l flen] [-m start:end] [-o oplen] [-p progressinterval]\n\
> > >          [-r readbdy] [-s style] [-t truncbdy] [-w writebdy]\n\
> > > @@ -2484,6 +2485,7 @@ usage(void)
> > >       -e: pollute post-eof on size changes (default 0)\n\
> > >       -f: flush and invalidate cache after I/O\n\
> > >       -g X: write character X instead of random generated data\n\
> > > +     -h hugepages: use buffers backed by hugepages for reads/writes\n\
> >
> > If this requires MADV_COLLAPSE, then perhaps the help text shouldn't
> > describe the switch if the support wasn't compiled in?
> >
> > e.g.
> >
> >         -g X: write character X instead of random generated data\n"
> > #ifdef MADV_COLLAPSE
> > "       -h hugepages: use buffers backed by hugepages for reads/writes\n"
> > #endif
> > "       -i logdev: do integrity testing, logdev is the dm log writes device\n\
> >
> > (assuming I got the preprocessor and string construction goo right; I
> > might be a few cards short of a deck due to zombie attack earlier)
> 
> Sounds great, I'll #ifdef out the help text -h line. Hope you feel better.
> >
> > >       -i logdev: do integrity testing, logdev is the dm log writes device\n\
> > >       -j logid: prefix debug log messsages with this id\n\
> > >       -k: do not truncate existing file and use its size as upper bound on file size\n\
> [...]
> > > +}
> > > +
> > > +#ifdef MADV_COLLAPSE
> > > +static void *
> > > +init_hugepages_buf(unsigned len, int hugepage_size, int alignment)
> > > +{
> > > +     void *buf;
> > > +     long buf_size = roundup(len, hugepage_size) + alignment;
> > > +
> > > +     if (posix_memalign(&buf, hugepage_size, buf_size)) {
> > > +             prterr("posix_memalign for buf");
> > > +             return NULL;
> > > +     }
> > > +     memset(buf, '\0', buf_size);
> > > +     if (madvise(buf, buf_size, MADV_COLLAPSE)) {
> >
> > If the fsx runs for a long period of time, will it be necessary to call
> > MADV_COLLAPSE periodically to ensure that reclaim doesn't break up the
> > hugepage?
> >
> 
> imo, I don't think so. My understanding is that this would be a rare
> edge case that happens when the system is constrained on memory, in
> which case subsequent calls to MADV_COLLAPSE would most likely fail
> anyways.

Hrmmm... well I /do/ like to run memory constrained VMs to prod reclaim
into stressing the filesystem more.  But I guess there's no good way for
fsx to know that something happened to it.  Unless there's some even
goofier way to force a hugepage, like shmem/hugetlbfs (ugh!) :)

Will have to ponder hugepage renewasl -- maybe we should madvise every
few thousand fsxops just to be careful?

--D

> 
> Thanks,
> Joanne
> 
> > > +             prterr("madvise collapse for buf");
> > > +             free(buf);
> > > +             return NULL;
> > > +     }
> > > +
> > > +     return buf;
> > > +}
> > > +#else
> > > +static void *
> > > +init_hugepages_buf(unsigned len, int hugepage_size, int alignment)
> > > +{
> > > +     return NULL;
> > > +}
> > > +#endif
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
> > > +             good_buf = init_hugepages_buf(maxfilelen, hugepage_size, writebdy);
> > > +             if (!good_buf) {
> > > +                     prterr("init_hugepages_buf failed for good_buf");
> > > +                     exit(103);
> > > +             }
> > > +
> > > +             temp_buf = init_hugepages_buf(maxoplen, hugepage_size, readbdy);
> > > +             if (!temp_buf) {
> > > +                     prterr("init_hugepages_buf failed for temp_buf");
> > > +                     exit(103);
> > > +             }
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
> > > @@ -2883,7 +2980,7 @@ main(int argc, char **argv)
> > >       setvbuf(stdout, (char *)0, _IOLBF, 0); /* line buffered stdout */
> > >
> > >       while ((ch = getopt_long(argc, argv,
> > > -                              "0b:c:de:fg:i:j:kl:m:no:p:qr:s:t:uw:xyABD:EFJKHzCILN:OP:RS:UWXZ",
> > > +                              "0b:c:de:fg:hi:j:kl:m:no:p:qr:s:t:uw:xyABD:EFJKHzCILN:OP:RS:UWXZ",
> > >                                longopts, NULL)) != EOF)
> > >               switch (ch) {
> > >               case 'b':
> > > @@ -2916,6 +3013,14 @@ main(int argc, char **argv)
> > >               case 'g':
> > >                       filldata = *optarg;
> > >                       break;
> > > +             case 'h':
> > > +                     #ifndef MADV_COLLAPSE
> >
> > Preprocessor directives should start at column 0, like most of the rest
> > of fstests.
> >
> > --D
> >

