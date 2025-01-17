Return-Path: <linux-fsdevel+bounces-39490-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 246B3A15071
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jan 2025 14:25:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FC543A38FB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jan 2025 13:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E35C01FF7AC;
	Fri, 17 Jan 2025 13:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SV9dulOv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D2271FCCEE
	for <linux-fsdevel@vger.kernel.org>; Fri, 17 Jan 2025 13:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737120322; cv=none; b=J+g5zO/OGAy4p0dNhjSk8acYI9sRHS2H7ncyuJQMm340uraF+LpqYzFiqPbjFilTwDifDUywyp2i05eqpbLfrqaa5vV2fGu/iYKyfb8aOuCnM2UumRktegDEJ3CohY7XMXt9D/O9r/BxLk7vTXcxy0W/5f2xhMorfDk0JY9mTIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737120322; c=relaxed/simple;
	bh=PuGWgm9aXpoZczOseYYy7rTSdJxA1jPkTqCgXRnu4q8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AhLh1TlDwmzbyBxaxixEIuxmjRZrJh8swbXjyQ39Cgn0Je5KVco3zcfzz65NOjSxuedFXJWrchkq9PTERy3Bm6NuCkbKHqNUO6nKnLsE+h0eDINMXSmjL0aCYTHIpht/QwApPhFZw5nftlN6H8Z+E5hnOrMeRsAeUZ51rpaL1dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SV9dulOv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737120319;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4ZwlJkT4kSzz85F25JNg7GGzj9gJZf8M0r2nGcAuAv8=;
	b=SV9dulOv4Akf/jM285H8koTaJfKOLo9inEadqVZqpPI9lJhaqwY/9sTDZtgTlQ9uAY16UL
	bf0d42657ujgduW2Q0JbH4zWxea6Ax/HIjc3TJoDiVd8d/426hWpay6j82TgUA0UsGvR7i
	EcPqZuqe3EIdcUVyJOkC6wfnOndG7NU=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-300-zmuvjanYO0u7Bayc_ssbWQ-1; Fri,
 17 Jan 2025 08:25:15 -0500
X-MC-Unique: zmuvjanYO0u7Bayc_ssbWQ-1
X-Mimecast-MFC-AGG-ID: zmuvjanYO0u7Bayc_ssbWQ
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9AD2D1955DDF;
	Fri, 17 Jan 2025 13:25:13 +0000 (UTC)
Received: from bfoster (unknown [10.22.80.118])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 342E219560AF;
	Fri, 17 Jan 2025 13:25:12 +0000 (UTC)
Date: Fri, 17 Jan 2025 08:27:24 -0500
From: Brian Foster <bfoster@redhat.com>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: "Darrick J. Wong" <djwong@kernel.org>, fstests@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, nirjhar@linux.ibm.com,
	zlang@redhat.com, kernel-team@meta.com
Subject: Re: [PATCH v3 1/2] fsx: support reads/writes from buffers backed by
 hugepages
Message-ID: <Z4pavNG_GKxPSRBy@bfoster>
References: <20250115183107.3124743-1-joannelkoong@gmail.com>
 <20250115183107.3124743-2-joannelkoong@gmail.com>
 <20250115213713.GE3557695@frogsfrogsfrogs>
 <CAJnrk1YXa++SrifrCfXf7WPQF34V20cet3+x+7wVuDf9CPoR7w@mail.gmail.com>
 <20250116005919.GK3557553@frogsfrogsfrogs>
 <Z4kBYq0K919C9k4M@bfoster>
 <CAJnrk1ZO9jp6PUtz2iz2k=yRfbH+_w_0BZREHcrBuRo3pYiVPg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJnrk1ZO9jp6PUtz2iz2k=yRfbH+_w_0BZREHcrBuRo3pYiVPg@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Thu, Jan 16, 2025 at 05:26:31PM -0800, Joanne Koong wrote:
> On Thu, Jan 16, 2025 at 4:51 AM Brian Foster <bfoster@redhat.com> wrote:
> >
> > On Wed, Jan 15, 2025 at 04:59:19PM -0800, Darrick J. Wong wrote:
> > > On Wed, Jan 15, 2025 at 04:47:30PM -0800, Joanne Koong wrote:
> > > > On Wed, Jan 15, 2025 at 1:37 PM Darrick J. Wong <djwong@kernel.org> wrote:
> > > > >
> > > > > On Wed, Jan 15, 2025 at 10:31:06AM -0800, Joanne Koong wrote:
> > > > > > Add support for reads/writes from buffers backed by hugepages.
> > > > > > This can be enabled through the '-h' flag. This flag should only be used
> > > > > > on systems where THP capabilities are enabled.
> > > > > >
> > > > > > This is motivated by a recent bug that was due to faulty handling of
> > > > > > userspace buffers backed by hugepages. This patch is a mitigation
> > > > > > against problems like this in the future.
> > > > > >
> > > > > > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > > > > > Reviewed-by: Brian Foster <bfoster@redhat.com>
> > > > > > ---
> > > > > >  ltp/fsx.c | 119 +++++++++++++++++++++++++++++++++++++++++++++++++-----
> > > > > >  1 file changed, 108 insertions(+), 11 deletions(-)
> > > > > >
> > > > > > diff --git a/ltp/fsx.c b/ltp/fsx.c
> > > > > > index 41933354..8d3a2e2c 100644
> > > > > > --- a/ltp/fsx.c
> > > > > > +++ b/ltp/fsx.c
> > > > > > @@ -190,6 +190,7 @@ int       o_direct;                       /* -Z */
> > > > > >  int  aio = 0;
> > > > > >  int  uring = 0;
> > > > > >  int  mark_nr = 0;
> > > > > > +int  hugepages = 0;                  /* -h flag */
> > > > > >
> > > > > >  int page_size;
> > > > > >  int page_mask;
> > > > > > @@ -2471,7 +2472,7 @@ void
> > > > > >  usage(void)
> > > > > >  {
> > > > > >       fprintf(stdout, "usage: %s",
> > > > > > -             "fsx [-dfknqxyzBEFHIJKLORWXZ0]\n\
> > > > > > +             "fsx [-dfhknqxyzBEFHIJKLORWXZ0]\n\
> > > > > >          [-b opnum] [-c Prob] [-g filldata] [-i logdev] [-j logid]\n\
> > > > > >          [-l flen] [-m start:end] [-o oplen] [-p progressinterval]\n\
> > > > > >          [-r readbdy] [-s style] [-t truncbdy] [-w writebdy]\n\
> > > > > > @@ -2484,6 +2485,7 @@ usage(void)
> > > > > >       -e: pollute post-eof on size changes (default 0)\n\
> > > > > >       -f: flush and invalidate cache after I/O\n\
> > > > > >       -g X: write character X instead of random generated data\n\
> > > > > > +     -h hugepages: use buffers backed by hugepages for reads/writes\n\
> > > > >
> > > > > If this requires MADV_COLLAPSE, then perhaps the help text shouldn't
> > > > > describe the switch if the support wasn't compiled in?
> > > > >
> > > > > e.g.
> > > > >
> > > > >         -g X: write character X instead of random generated data\n"
> > > > > #ifdef MADV_COLLAPSE
> > > > > "       -h hugepages: use buffers backed by hugepages for reads/writes\n"
> > > > > #endif
> > > > > "       -i logdev: do integrity testing, logdev is the dm log writes device\n\
> > > > >
> > > > > (assuming I got the preprocessor and string construction goo right; I
> > > > > might be a few cards short of a deck due to zombie attack earlier)
> > > >
> > > > Sounds great, I'll #ifdef out the help text -h line. Hope you feel better.
> > > > >
> > > > > >       -i logdev: do integrity testing, logdev is the dm log writes device\n\
> > > > > >       -j logid: prefix debug log messsages with this id\n\
> > > > > >       -k: do not truncate existing file and use its size as upper bound on file size\n\
> > > > [...]
> > > > > > +}
> > > > > > +
> > > > > > +#ifdef MADV_COLLAPSE
> > > > > > +static void *
> > > > > > +init_hugepages_buf(unsigned len, int hugepage_size, int alignment)
> > > > > > +{
> > > > > > +     void *buf;
> > > > > > +     long buf_size = roundup(len, hugepage_size) + alignment;
> > > > > > +
> > > > > > +     if (posix_memalign(&buf, hugepage_size, buf_size)) {
> > > > > > +             prterr("posix_memalign for buf");
> > > > > > +             return NULL;
> > > > > > +     }
> > > > > > +     memset(buf, '\0', buf_size);
> > > > > > +     if (madvise(buf, buf_size, MADV_COLLAPSE)) {
> > > > >
> > > > > If the fsx runs for a long period of time, will it be necessary to call
> > > > > MADV_COLLAPSE periodically to ensure that reclaim doesn't break up the
> > > > > hugepage?
> > > > >
> > > >
> > > > imo, I don't think so. My understanding is that this would be a rare
> > > > edge case that happens when the system is constrained on memory, in
> > > > which case subsequent calls to MADV_COLLAPSE would most likely fail
> > > > anyways.
> > >
> > > Hrmmm... well I /do/ like to run memory constrained VMs to prod reclaim
> > > into stressing the filesystem more.  But I guess there's no good way for
> > > fsx to know that something happened to it.  Unless there's some even
> > > goofier way to force a hugepage, like shmem/hugetlbfs (ugh!) :)
> > >
> > > Will have to ponder hugepage renewasl -- maybe we should madvise every
> > > few thousand fsxops just to be careful?
> > >
> >
> > I wonder.. is there test value in doing collapses to the target file as
> > well, either as a standalone map/madvise command or a random thing
> > hitched onto preexisting commands? If so, I could see how something like
> > that could potentially lift the current init time only approach into
> > something that occurs with frequency, which then could at the same time
> > (again maybe randomly) reinvoke for internal buffers as well.
> 
> My understanding is that if a filesystem has support enabled for large
> folios, then doing large writes/reads (which I believe is currently
> supported in fsx via the -o flag) will already automatically test the
> functionality of how the filesystem handles hugepages. I don't think
> this would be different from what doing a collapse on the target file
> would do.
> 

Ah, that is a good point. So maybe not that useful to have something
that would hook into writes. OTOH, fsx does a lot of random ops in the
general case. I wonder how likely it is to sustain large folios in a
typical long running test and whether explicit madvise calls thrown into
the mix would make any difference at all.

I suppose there may also be an argument that doing collapses provides
more test coverage than purely doing larger folio allocations at write
time..? I don't know the code well enough to say whether there is any
value there. FWIW, what I think is more interesting from the fsx side is
the oddball sequences of operations that it can create to uncover
similarly odd problems. IOW, in theory if we had a randomish "collapse
target range before next operation," would that effectively provide more
coverage with how the various supported ops interact with large folios
over current behavior?

But anyways, this is all nebulous and strikes me more as maybe something
interesting to play with as a potential future enhancement more than
anything. BTW, is there any good way to measure use of large folios in
general and/or on a particular file? I.e., collapse/split stats or some
such thing..? Thanks.

Brian

> 
> Thanks,
> Joanne
> 
> >
> > All that said, this is new functionality and IIUC provides functional
> > test coverage for a valid issue. IMO, it would be nice to get this
> > merged as a baseline feature and explore these sort of enhancements as
> > followon work. Just my .02.
> >
> > Brian
> >
> > > --D
> > >
> > > >
> > > > Thanks,
> > > > Joanne
> > > >
> > > > > > +             prterr("madvise collapse for buf");
> > > > > > +             free(buf);
> > > > > > +             return NULL;
> > > > > > +     }
> > > > > > +
> > > > > > +     return buf;
> > > > > > +}
> > > > > > +#else
> > > > > > +static void *
> > > > > > +init_hugepages_buf(unsigned len, int hugepage_size, int alignment)
> > > > > > +{
> > > > > > +     return NULL;
> > > > > > +}
> > > > > > +#endif
> > > > > > +
> > > > > > +static void
> > > > > > +init_buffers(void)
> > > > > > +{
> > > > > > +     int i;
> > > > > > +
> > > > > > +     original_buf = (char *) malloc(maxfilelen);
> > > > > > +     for (i = 0; i < maxfilelen; i++)
> > > > > > +             original_buf[i] = random() % 256;
> > > > > > +     if (hugepages) {
> > > > > > +             long hugepage_size = get_hugepage_size();
> > > > > > +             if (hugepage_size == -1) {
> > > > > > +                     prterr("get_hugepage_size()");
> > > > > > +                     exit(102);
> > > > > > +             }
> > > > > > +             good_buf = init_hugepages_buf(maxfilelen, hugepage_size, writebdy);
> > > > > > +             if (!good_buf) {
> > > > > > +                     prterr("init_hugepages_buf failed for good_buf");
> > > > > > +                     exit(103);
> > > > > > +             }
> > > > > > +
> > > > > > +             temp_buf = init_hugepages_buf(maxoplen, hugepage_size, readbdy);
> > > > > > +             if (!temp_buf) {
> > > > > > +                     prterr("init_hugepages_buf failed for temp_buf");
> > > > > > +                     exit(103);
> > > > > > +             }
> > > > > > +     } else {
> > > > > > +             unsigned long good_buf_len = maxfilelen + writebdy;
> > > > > > +             unsigned long temp_buf_len = maxoplen + readbdy;
> > > > > > +
> > > > > > +             good_buf = calloc(1, good_buf_len);
> > > > > > +             temp_buf = calloc(1, temp_buf_len);
> > > > > > +     }
> > > > > > +     good_buf = round_ptr_up(good_buf, writebdy, 0);
> > > > > > +     temp_buf = round_ptr_up(temp_buf, readbdy, 0);
> > > > > > +}
> > > > > > +
> > > > > >  static struct option longopts[] = {
> > > > > >       {"replay-ops", required_argument, 0, 256},
> > > > > >       {"record-ops", optional_argument, 0, 255},
> > > > > > @@ -2883,7 +2980,7 @@ main(int argc, char **argv)
> > > > > >       setvbuf(stdout, (char *)0, _IOLBF, 0); /* line buffered stdout */
> > > > > >
> > > > > >       while ((ch = getopt_long(argc, argv,
> > > > > > -                              "0b:c:de:fg:i:j:kl:m:no:p:qr:s:t:uw:xyABD:EFJKHzCILN:OP:RS:UWXZ",
> > > > > > +                              "0b:c:de:fg:hi:j:kl:m:no:p:qr:s:t:uw:xyABD:EFJKHzCILN:OP:RS:UWXZ",
> > > > > >                                longopts, NULL)) != EOF)
> > > > > >               switch (ch) {
> > > > > >               case 'b':
> > > > > > @@ -2916,6 +3013,14 @@ main(int argc, char **argv)
> > > > > >               case 'g':
> > > > > >                       filldata = *optarg;
> > > > > >                       break;
> > > > > > +             case 'h':
> > > > > > +                     #ifndef MADV_COLLAPSE
> > > > >
> > > > > Preprocessor directives should start at column 0, like most of the rest
> > > > > of fstests.
> > > > >
> > > > > --D
> > > > >
> > >
> >
> 


