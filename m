Return-Path: <linux-fsdevel+bounces-39460-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 58A59A147CF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jan 2025 02:57:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA0D8188C65A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jan 2025 01:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7419E1E1044;
	Fri, 17 Jan 2025 01:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VopfbC2J"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE3D61E0DE5;
	Fri, 17 Jan 2025 01:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737079046; cv=none; b=sbyeruFAjd9hIrzK+8/oN69gqxgvD27Ok60buvNCxsERYKexAzJn0tapCgxjR0Y4oOH1+YLgccPHIzwSZSFPV98sZibuBZV6s213cMGUbCb+DfGmOnQvYcMUQR1MKlfVtOfG2LoIwJMdoymGsAAzFhBPRw9s8yVRhAOfUqUF3/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737079046; c=relaxed/simple;
	bh=Wgeovid6QxZE/4ogsN4wOmyhUKc8Kjkdbx+NHGhuLlc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NgoMaBLcy/rse1hwG6X0hSbzqQG0993l8JM7wmIzFhyhNzihoJbtSc7YFOj5zSWQ8uYDx5j7lciujs1w0gMHnsh5STn846bqLaM9Ahnoya/GaW7YIpPSql7/twiDbiAEnH/56cD0DEL16RgsC5VNJjsrRFI8JMHfynA+b2nbzlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VopfbC2J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53FA0C4CED6;
	Fri, 17 Jan 2025 01:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737079046;
	bh=Wgeovid6QxZE/4ogsN4wOmyhUKc8Kjkdbx+NHGhuLlc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VopfbC2Jgt5zgUGDe0FsOsroJC/bj26Tz+/OWGf5xOIAe1ecEjZ9NBAJVQcdQ4WyF
	 G69qB1wNLpuKjyWpG6M399FlhmQF1lubFliVf8pMsOP2Rf41pOjt1R1mn5RoJrDZPa
	 nTQLsQsjCwejuUA/+VVaDMoLM+50GI66UYDr51pUBvNAcyri61Mve4K6AEwvQwcjA6
	 GtByolQ6uIOF4iCXZlbI1H69MeZFmGDGkpyMOYgOSgCVSRe5GEafP0WcsVnZP1nwuo
	 BDOkH4PGziOTV6wY8JrMghUAnZYdaT7AaVBnKRLWJiR2TuZrMy4qS6MJo/LYI2KHmA
	 JhLqFTEW9OhIw==
Date: Thu, 16 Jan 2025 17:57:24 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: fstests@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	bfoster@redhat.com, nirjhar@linux.ibm.com, zlang@redhat.com,
	kernel-team@meta.com
Subject: Re: [PATCH v3 1/2] fsx: support reads/writes from buffers backed by
 hugepages
Message-ID: <20250117015724.GL3557553@frogsfrogsfrogs>
References: <20250115183107.3124743-1-joannelkoong@gmail.com>
 <20250115183107.3124743-2-joannelkoong@gmail.com>
 <20250115213713.GE3557695@frogsfrogsfrogs>
 <CAJnrk1YXa++SrifrCfXf7WPQF34V20cet3+x+7wVuDf9CPoR7w@mail.gmail.com>
 <20250116005919.GK3557553@frogsfrogsfrogs>
 <CAJnrk1ZpjnAL26x7KdX_33bgX7YdJN1hnPmn6zAgM38p4uBopw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJnrk1ZpjnAL26x7KdX_33bgX7YdJN1hnPmn6zAgM38p4uBopw@mail.gmail.com>

On Thu, Jan 16, 2025 at 05:03:41PM -0800, Joanne Koong wrote:
> On Wed, Jan 15, 2025 at 4:59 PM Darrick J. Wong <djwong@kernel.org> wrote:
> >
> > On Wed, Jan 15, 2025 at 04:47:30PM -0800, Joanne Koong wrote:
> > > On Wed, Jan 15, 2025 at 1:37 PM Darrick J. Wong <djwong@kernel.org> wrote:
> > > >
> > > > On Wed, Jan 15, 2025 at 10:31:06AM -0800, Joanne Koong wrote:
> > > > > Add support for reads/writes from buffers backed by hugepages.
> > > > > This can be enabled through the '-h' flag. This flag should only be used
> > > > > on systems where THP capabilities are enabled.
> > > > >
> > > > > This is motivated by a recent bug that was due to faulty handling of
> > > > > userspace buffers backed by hugepages. This patch is a mitigation
> > > > > against problems like this in the future.
> > > > >
> > > > > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > > > > Reviewed-by: Brian Foster <bfoster@redhat.com>
> > > > > ---
> > > > >  ltp/fsx.c | 119 +++++++++++++++++++++++++++++++++++++++++++++++++-----
> > > > >  1 file changed, 108 insertions(+), 11 deletions(-)
> > > > >
> > > > > diff --git a/ltp/fsx.c b/ltp/fsx.c
> > > > > index 41933354..8d3a2e2c 100644
> > > > > --- a/ltp/fsx.c
> > > > > +++ b/ltp/fsx.c
> > > > > @@ -190,6 +190,7 @@ int       o_direct;                       /* -Z */
> > > > >  int  aio = 0;
> > > > >  int  uring = 0;
> > > > >  int  mark_nr = 0;
> > > > > +int  hugepages = 0;                  /* -h flag */
> > > > >
> > > > >  int page_size;
> > > > >  int page_mask;
> > > > > @@ -2471,7 +2472,7 @@ void
> > > > >  usage(void)
> > > > >  {
> > > > >       fprintf(stdout, "usage: %s",
> > > > > -             "fsx [-dfknqxyzBEFHIJKLORWXZ0]\n\
> > > > > +             "fsx [-dfhknqxyzBEFHIJKLORWXZ0]\n\
> > > > >          [-b opnum] [-c Prob] [-g filldata] [-i logdev] [-j logid]\n\
> > > > >          [-l flen] [-m start:end] [-o oplen] [-p progressinterval]\n\
> > > > >          [-r readbdy] [-s style] [-t truncbdy] [-w writebdy]\n\
> > > > > @@ -2484,6 +2485,7 @@ usage(void)
> > > > >       -e: pollute post-eof on size changes (default 0)\n\
> > > > >       -f: flush and invalidate cache after I/O\n\
> > > > >       -g X: write character X instead of random generated data\n\
> > > > > +     -h hugepages: use buffers backed by hugepages for reads/writes\n\
> > > >
> > > > If this requires MADV_COLLAPSE, then perhaps the help text shouldn't
> > > > describe the switch if the support wasn't compiled in?
> > > >
> > > > e.g.
> > > >
> > > >         -g X: write character X instead of random generated data\n"
> > > > #ifdef MADV_COLLAPSE
> > > > "       -h hugepages: use buffers backed by hugepages for reads/writes\n"
> > > > #endif
> > > > "       -i logdev: do integrity testing, logdev is the dm log writes device\n\
> > > >
> > > > (assuming I got the preprocessor and string construction goo right; I
> > > > might be a few cards short of a deck due to zombie attack earlier)
> > >
> > > Sounds great, I'll #ifdef out the help text -h line. Hope you feel better.
> > > >
> > > > >       -i logdev: do integrity testing, logdev is the dm log writes device\n\
> > > > >       -j logid: prefix debug log messsages with this id\n\
> > > > >       -k: do not truncate existing file and use its size as upper bound on file size\n\
> > > [...]
> > > > > +}
> > > > > +
> > > > > +#ifdef MADV_COLLAPSE
> > > > > +static void *
> > > > > +init_hugepages_buf(unsigned len, int hugepage_size, int alignment)
> > > > > +{
> > > > > +     void *buf;
> > > > > +     long buf_size = roundup(len, hugepage_size) + alignment;
> > > > > +
> > > > > +     if (posix_memalign(&buf, hugepage_size, buf_size)) {
> > > > > +             prterr("posix_memalign for buf");
> > > > > +             return NULL;
> > > > > +     }
> > > > > +     memset(buf, '\0', buf_size);
> > > > > +     if (madvise(buf, buf_size, MADV_COLLAPSE)) {
> > > >
> > > > If the fsx runs for a long period of time, will it be necessary to call
> > > > MADV_COLLAPSE periodically to ensure that reclaim doesn't break up the
> > > > hugepage?
> > > >
> > >
> > > imo, I don't think so. My understanding is that this would be a rare
> > > edge case that happens when the system is constrained on memory, in
> > > which case subsequent calls to MADV_COLLAPSE would most likely fail
> > > anyways.
> >
> > Hrmmm... well I /do/ like to run memory constrained VMs to prod reclaim
> > into stressing the filesystem more.  But I guess there's no good way for
> > fsx to know that something happened to it.  Unless there's some even
> > goofier way to force a hugepage, like shmem/hugetlbfs (ugh!) :)
> 
> I can't think of a better way to force a hugepage either. I believe
> shmem and hugetlbfs would both require root privileges to do so, and
> if i'm not mistaken, shmem hugepages are still subject to being broken
> up by reclaim.
> 
> >
> > Will have to ponder hugepage renewasl -- maybe we should madvise every
> > few thousand fsxops just to be careful?
> 
> I can add this in, but on memory constrained VMs, would this be
> effective? To me, it seems like in the majority of cases, subsequent

They're not /so/ memory constrained that the initial collapsed page is
likely to get split/reclaimed before your regression test finishes...

> attempts at collapsing the broken pages back into a hugepage would
> fail due to memory still being constrained. In which case, I guess
> we'd exit the test altogether?

...but I was starting to wonder if this is something we'd actually want
in a long soak test, just in case there are weird effects on the system
after fsx has been running for a few days?

>                                It kind of seems to me like if the user
> wants to test out hugepages functionality of their filesystem, then
> the onus is on them to run the test in an environment that can
> adequately and consistently support hugepages.

I guess the hard part about analyzing that is is that long soak tests
aren't usually supposed to die on account of memory fragmentation.
Hence me wondering if there's an "easy" way to get one huge page and not
let it go.

Anyway don't let my blathering hold this up; I think once you fix the
help text and the #ifdef indenting around exit(86) this patch is good to
go.

--D

> 
> Thanks,
> Joanne
> 
> >
> > --D
> >
> > >
> > > Thanks,
> > > Joanne
> > >
> > > > > +             prterr("madvise collapse for buf");
> > > > > +             free(buf);
> > > > > +             return NULL;
> > > > > +     }
> > > > > +
> > > > > +     return buf;
> > > > > +}
> > > > > +#else
> > > > > +static void *
> > > > > +init_hugepages_buf(unsigned len, int hugepage_size, int alignment)
> > > > > +{
> > > > > +     return NULL;
> > > > > +}
> > > > > +#endif
> > > > > +
> > > > > +static void
> > > > > +init_buffers(void)
> > > > > +{
> > > > > +     int i;
> > > > > +
> > > > > +     original_buf = (char *) malloc(maxfilelen);
> > > > > +     for (i = 0; i < maxfilelen; i++)
> > > > > +             original_buf[i] = random() % 256;
> > > > > +     if (hugepages) {
> > > > > +             long hugepage_size = get_hugepage_size();
> > > > > +             if (hugepage_size == -1) {
> > > > > +                     prterr("get_hugepage_size()");
> > > > > +                     exit(102);
> > > > > +             }
> > > > > +             good_buf = init_hugepages_buf(maxfilelen, hugepage_size, writebdy);
> > > > > +             if (!good_buf) {
> > > > > +                     prterr("init_hugepages_buf failed for good_buf");
> > > > > +                     exit(103);
> > > > > +             }
> > > > > +
> > > > > +             temp_buf = init_hugepages_buf(maxoplen, hugepage_size, readbdy);
> > > > > +             if (!temp_buf) {
> > > > > +                     prterr("init_hugepages_buf failed for temp_buf");
> > > > > +                     exit(103);
> > > > > +             }
> > > > > +     } else {
> > > > > +             unsigned long good_buf_len = maxfilelen + writebdy;
> > > > > +             unsigned long temp_buf_len = maxoplen + readbdy;
> > > > > +
> > > > > +             good_buf = calloc(1, good_buf_len);
> > > > > +             temp_buf = calloc(1, temp_buf_len);
> > > > > +     }
> > > > > +     good_buf = round_ptr_up(good_buf, writebdy, 0);
> > > > > +     temp_buf = round_ptr_up(temp_buf, readbdy, 0);
> > > > > +}
> > > > > +
> > > > >  static struct option longopts[] = {
> > > > >       {"replay-ops", required_argument, 0, 256},
> > > > >       {"record-ops", optional_argument, 0, 255},
> > > > > @@ -2883,7 +2980,7 @@ main(int argc, char **argv)
> > > > >       setvbuf(stdout, (char *)0, _IOLBF, 0); /* line buffered stdout */
> > > > >
> > > > >       while ((ch = getopt_long(argc, argv,
> > > > > -                              "0b:c:de:fg:i:j:kl:m:no:p:qr:s:t:uw:xyABD:EFJKHzCILN:OP:RS:UWXZ",
> > > > > +                              "0b:c:de:fg:hi:j:kl:m:no:p:qr:s:t:uw:xyABD:EFJKHzCILN:OP:RS:UWXZ",
> > > > >                                longopts, NULL)) != EOF)
> > > > >               switch (ch) {
> > > > >               case 'b':
> > > > > @@ -2916,6 +3013,14 @@ main(int argc, char **argv)
> > > > >               case 'g':
> > > > >                       filldata = *optarg;
> > > > >                       break;
> > > > > +             case 'h':
> > > > > +                     #ifndef MADV_COLLAPSE
> > > >
> > > > Preprocessor directives should start at column 0, like most of the rest
> > > > of fstests.
> > > >
> > > > --D
> > > >

