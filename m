Return-Path: <linux-fsdevel+bounces-40811-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3350BA27C4C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 20:58:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1C071885445
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 19:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9690321767D;
	Tue,  4 Feb 2025 19:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="znSuin8k";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Er2rDR0a"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84517158558;
	Tue,  4 Feb 2025 19:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738699097; cv=none; b=er06V3KsGEzbG//0EKuhs6UdztckNXB7xidxs0BI9eK9N95wyutdxb9FUur3v+a7pNaVdC6/hpB7BBw6trDpgcEjzQSB0RT9P99Smyi/8uBxzNpwBUpVlwFE9W1e5opUbtKcMaV+TF8/GITIv0bNhIEU6uUSRsDYXFwnzA2jUjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738699097; c=relaxed/simple;
	bh=02FT8D66wI55dclyaSjT58HkAwVzlKF9AGLNKYVuIXA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pfIuO24iT8tz2O4hFKa3Y6zVShuve7+tDjxxwMWexH0dupmS/t0Shgiw/Kjuf8h0fsZHrOpWBRFrjgoysSqd3FYn7dhaEevvNZVJfo+Y6zyo8IiLoL8uh8ZTI5qWc+e0M79BHhum5EHwC3GdgHFHm7iFBMMwtjadh82OGgOGWQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=znSuin8k; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Er2rDR0a; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8B1AF1140161;
	Tue,  4 Feb 2025 14:58:13 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Tue, 04 Feb 2025 14:58:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1738699093;
	 x=1738785493; bh=QkQWo5dv37k9vHqtVSa+5oI/vxYIdzDHygSyMSt/E2Y=; b=
	znSuin8kS2hIgdSPRBbpAhtrXTIEQ7fnICz99XBjrDXFvGS7nbN2fB9hij89W8Mr
	7GNhdYxWenIftKPUNX5rhdyHg7BPA+LY3px9p1cNbL6iNkzO9gRkxa85FjhxRbDI
	rPvfhifePBTRmmAvcnWjQ6G3QhUgbkt+FWEzUJEkzzLlIpIRP3ixfSC9dGbIz+g5
	3UdaCGJY1u9epVf539613+iAC+WY/1FsRByY3k9iXtzgeft+9Dhu6NmYyxWKyBJy
	tDMKPYdudPTF5LBFuKdDwyzKH0Aj44y1j5/g5ZhJ26v1safR071VZJiSnL9Tvdj0
	HsbQc++J27cFIIH3OOTn0g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738699093; x=
	1738785493; bh=QkQWo5dv37k9vHqtVSa+5oI/vxYIdzDHygSyMSt/E2Y=; b=E
	r2rDR0aNcylS0KCDfMJ8AgTF3o/2MheLZszqw9v/V5F2vRVWlz01exp9YEPyrGEX
	igOBsLNua9hY9ZssIm+tPvPylFbY9KemM6zevdDYMQeL9KnLAVFtnJb0vT2mn9Sf
	duLtIqJES7OKZjgNJe0oXRh4Oe1I/4nUAxqtbaHjNRaUYSHXRXr2dzQa5LQhzujq
	0GMV2wahD453KkVBBtr/iqJvDa37Qz44P37VxKNHgUHLgx16VqsssIz2rHkm3SAo
	H2GfaNVIXK0d4xfOkfwJ7VSRfTp0R2dtHgXYYfpt9COPnFUB47l/t5AOmVMTCphr
	ChxITARofEKEi4levMk0A==
X-ME-Sender: <xms:VXGiZ_PQpBtIH8MzDQnrO9MTQ5KerWLqYI3RRRj6Ib2q7CM3wT8rJA>
    <xme:VXGiZ59l4XpxAX-Z-NG8va0uh2xvMDt67MdrtVyG9zxZzJbYMOOgkWrfCkB0eBEe3
    TDQzvmJzfEkIaUDdMM>
X-ME-Received: <xmr:VXGiZ-R2OVvklP-9uDpwpBluWg-uSZjkegNpxupPVGfkowfAvs73AVYpVWK02L020ViTnfn9icTljF1Bckpr5XMnPU4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvudegfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvf
    evuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpeeuohhrihhsuceuuhhrkhho
    vhcuoegsohhrihhssegsuhhrrdhioheqnecuggftrfgrthhtvghrnhephefhudehgfekhe
    dufedvtefgteelueeigfefhfefgeejkeefhefhgfekjefhvdehnecuffhomhgrihhnpehk
    vghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpegsohhrihhssegsuhhrrdhiohdpnhgspghrtghpthhtohephedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepuggrvhhiugesfhhrohhmohhrsghithdrtghomh
    dprhgtphhtthhopegrmhhirhejfehilhesghhmrghilhdrtghomhdprhgtphhtthhopehl
    shhfqdhptgeslhhishhtshdrlhhinhhugidqfhhouhhnuggrthhiohhnrdhorhhgpdhrtg
    hpthhtoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehfshhtvghsthhssehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:VXGiZzvjWw_DZs2cD9tx_mY38fPeNX5u3QVUA8SRCP0ra5NgQQyabQ>
    <xmx:VXGiZ3eG7vgKVmQIsBGveqf8y0rwgkUI-HJl2pHPAeXixKleI13V6g>
    <xmx:VXGiZ_3G-PLWPr6IlfnywV7IV819jVETUkp3MJOfaBN9YwFd-06Qeg>
    <xmx:VXGiZz-ZjUC533UIYt66QGz9tBfcs6HkI4JDejMZCrrQR9Vy7BmH6A>
    <xmx:VXGiZ4HftS9pY5v5vm3ch0n8No_m-3xPbHIYbNugdXfxkWlpNL2a4tWf>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Feb 2025 14:58:12 -0500 (EST)
Date: Tue, 4 Feb 2025 11:58:46 -0800
From: Boris Burkov <boris@bur.io>
To: Dave Chinner <david@fromorbit.com>
Cc: Amir Goldstein <amir73il@gmail.com>, lsf-pc@lists.linux-foundation.org,
	linux-fsdevel@vger.kernel.org, fstests <fstests@vger.kernel.org>
Subject: Re: [LSF/MM/BPF TOPIC] Long Duration Stress Testing Filesystems
Message-ID: <20250204195846.GB3657803@zen.localdomain>
References: <20250203185519.GA2888598@zen.localdomain>
 <CAOQ4uxjiYQHUVkYnv5owPHHvs6BP128Zvuf_LGciENjyJkLa6w@mail.gmail.com>
 <Z6Fl5d34STRzC3K2@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z6Fl5d34STRzC3K2@dread.disaster.area>

On Tue, Feb 04, 2025 at 11:57:09AM +1100, Dave Chinner wrote:
> On Mon, Feb 03, 2025 at 08:12:59PM +0100, Amir Goldstein wrote:
> > CC fstests
> > 
> > On Mon, Feb 3, 2025 at 7:54 PM Boris Burkov <boris@bur.io> wrote:
> > >
> > > At Meta, we currently primarily rely on fstests 'auto' runs for
> > > validating Btrfs as a general purpose filesystem for all of our root
> > > drives. While this has obviously proven to be a very useful test suite
> > > with rich collaboration across teams and filesystems, we have observed a
> > > recent trend in our production filesystem issues that makes us question
> > > if it is sufficient.
> > >
> > > Over the last few years, we have had a number of issues (primarily in
> > > Btrfs, but at least one notable one in Xfs) that have been detected in
> > > production, then reproduced with an unreliable non-specific stressor
> > > that takes hours or even days to trigger the issue.
> > > Examples:
> > > - Btrfs relocation bugs
> > > https://lore.kernel.org/linux-btrfs/68766e66ed15ca2e7550585ed09434249db912a2.1727212293.git.josef@toxicpanda.com/
> > > https://lore.kernel.org/linux-btrfs/fc61fb63e534111f5837c204ec341c876637af69.1731513908.git.josef@toxicpanda.com/
> > > - Btrfs extent map merging corruption
> > > https://lore.kernel.org/linux-btrfs/9b98ba80e2cf32f6fb3b15dae9ee92507a9d59c7.1729537596.git.boris@bur.io/
> > > - Btrfs dio data corruptions from bio splitting
> > > (mostly our internal errors trying to make minimal backports of
> > > https://lore.kernel.org/linux-btrfs/cover.1679512207.git.boris@bur.io/
> > > and Christoph's related series)
> > > - Xfs large folios
> > > https://lore.kernel.org/linux-fsdevel/effc0ec7-cf9d-44dc-aee5-563942242522@meta.com/
> > >
> > > In my view, the common threads between these are that:
> > > - we used fstests to validate these systems, in some cases even with
> > >   specific regression tests for highly related bugs, but still missed
> > >   the bugs until they hit us during our production release process. In
> > >   all cases, we had passing 'fstests -g auto' runs.
> 
> Have you considered the 'soak' test group with a long SOAK_DURATION
> and then increasing the load using LOAD_FACTOR? Also there is a
> 'stress' group that TIME_FACTOR acts on.
> 
> For XFS, there's also bunch of fuzzing tests (in the
> dangerous_fuzzers group) that use the same SOAK_DURATION
> infrastructure via common/fuzzy.

I hadn't realized people were running these for multi-day durations.
Thanks for pointing them out and for your other inline answers to my
questions.

> 
> 
> > > - were able to reproduce the bugs with a predictable concoction of "run
> > >   a workload and some known nasty btrfs operations in parallel". The most
> > >   common form of this was running 'fsstress' and 'btrfs balance', but it
> > >   wasn't quite universal. Sometimes we needed reflink threads, or
> > >   drop_caches, or memory pressure, etc. to trigger a bug.
> 
> That's pretty much what check-parallel does to a system. Loads of
> tests run things like drop_caches, memory compaction, CPU hotplug,
> etc. check-parallel essentially exposes every test to these sorts
> of background perturbations rather than just the one test that is
> running that perturbation. IOWs, even the most basic correctness
> test now gets exercised while cpu hotplug and memory compaction are
> going on in the background....
> 
> Eventually, I plan to implement these background perturbations as
> separate control tasks for check-parallel so we don't need specific
> tests that run a background perturbation whilst the rest of the
> system is under test.

I think that a framework for introducing background perturbations while
running tests is definitely what I'm getting at. If check-parallel is a
good version of that, then that sounds great to me. I am particularly
excited about your point that it will smash together *every* stimulus
with *every* test. I do have some questions in my head about how that
would work in practice.

My main questions/concerns are:

How much do you randomize the interleaving of tests? Does
check-parallel run them in a random order?

Similarly, their durations are not at all tuned to maximize
interesting interactions. If test X and test Y would collide on some
faulty interaction, but test X runs once in 1 second, then you would
likely never see test X interfere with some interesting moment during
test Y. Are you considering feeding the tests back into the run-queue
as they finish for these stress style runs?

It seems that the two objectives of the test harness are sort of in
tension with using check-parallel to stress things. On one hand you
want tests to independently succeed or fail and on the other hand you
want noise from one test to disturb the other. I fear more of the
failures will turn out to be "Oh, well, when THAT happens, we would
expect this condition to be violated". Especially for the more "unit
test" style fstests that carefully use sync to check specific conditions
during a run.

This variant also feels like it would be at the extreme of difficulty
for attempting to distill a failure into a reproducer.

> 
> > > - The relatively generic stressing reproducers took hours or days to
> > >   produce an issue then the investigating engineer could try to tweak and
> > >   tune it by trial and error to bring that time down for a particular bug.
> > >
> > > This leads me to the conclusion that there is some room for improvement in
> > > stress testing filesystems (at least Btrfs).
> > >
> > > I attempted to study the prior art on this and so far have found:
> > > - fsstress/fsx and the attendant tests in fstests/. There are ~150-200
> > >   tests using fsstress and fsx in fstests/. Most of them are xfs and
> > >   btrfs tests following the aforementioned pattern of racing fsstress
> > >   with some scary operations. Most of them tend to run for 30s, though
> > >   some are longer (and of course subject to TIME_FACTOR configuration)
> 
> As per above, SOAK_DURATION.
> 
> > > - Similar duration error injection tests in fstests (e.g. generic/475)
> > > - The NFSv4 Test Project
> > >   https://www.kernel.org/doc/ols/2006/ols2006v2-pages-275-294.pdf
> > >   A choice quote regarding stress testing:
> > >   "One year after we started using FSSTRESS (in April 2005) Linux NFSv4
> > >   was able to sustain the concurrent load of 10 processes during 24
> > >   hours, without any problem. Three months later, NFSv4 reached 72 hours
> > >   of stress under FSSTRESS, without any bugs. From this date, NFSv4
> > >   filesystem tree manipulation is considered to be stable."
> > >
> > >
> > > I would like to discuss:
> > > - Am I missing other strategies people are employing? Apologies if there
> > >   are obvious ones, but I tried to hunt around for a few days :)
> 
> check-parallel.
> 
> > > - What is the universe of interesting stressors (e.g., reflink, scrub,
> > >   online repair, balance, etc.)
> 
> memory compaction, cpu hotplug, random reflinks of the underlying
> loop device image files to simulate dynamic VM image file snapshots,
> etc.
> 
> > > - What is the universe of interesting validation conditions (e.g.,
> > >   kernel panic, read only fs, fsck failure, data integrity error, etc.)
> 
> All of them. That's the point of check-parallel - it uses simple,
> existing filesystem correctness tests to generate a massively
> stressful load on the system...
> 
> > > - Is there any interest in automating longer running fsstress runs? Are
> > >   people already doing this with varying TIME_FACTOR configurations in
> > >   fstests?
> 
> At least for XFS, Darrick is already doing that, and I think Carlos
> may be as well.
> 
> > > - There is relatively less testing with fsx than fsstress in fstests.
> > >   I believe this creates gaps for data corruption bugs rather than
> > >   "feature logic" issues that the fsstress feature set tends to hit.
> > > - Can we standardize on some modular "stressors" and stress durations
> > >   to run to validate file systems?
> 
> I think we already have that with the "soak" and "stress" groups...
> 
> > > In the short term, I have been working on these ideas in a separate
> > > barebones stress testing framework which I am happy to share, but isn't
> > > particularly interesting in and of itself. It is basically just a
> > > skeleton for concurrently running some concurrent "stressors" and then
> > > validating the fs with some generic "validators". I plan to run it
> > > internally just to see if I can get some useful results on our next few
> > > major kernel releases.
> 
> check-parallel is effectively a massive concurrent stress workload
> for the system. It does this by running many individual correctness
> tests concurrently.
> 
> Run it on a 64p system or larger, and it will hammer both the test
> filesystems and base filesystem that all the loop device image files
> are laid out on.  I'm seeing it generate 5-6GB/s of IO load, 40-50GB
> of memory usage, and consistently use >90% of the CPU in the system
> stress the scheduler at over half a million context switches/s.

I will definitely invest some time into getting check-parallel to run
with btrfs, and hopefully it turns up some interesting stuff.

> 
> > > And of course, I would love to discuss anything else of interest to
> > > people who like stress testing filesystems!
> 
> Filesystem stress testing by itself isn't really interesting to me.
> Using filesystem correctness tests to create massively stressful
> workloads, OTOH, attacks the problem from multiple angles and
> exercises the system well outside the bounds of just filesystem
> code.

From what I see, today we have a handful of tests which race fsx or
fsstress with 0-2 operations under test, and you are proposing using
check-parallel to hammer the computer with the entirety of all 1000
tests in parallel (awesome). I think I am proposing something in between
where we run fsx AND fsstress AND ~10 known scary operations. That
has proven to dredge up bugs in btrfs (where the simpler fsstress plus
one thing doesn't). I think check-parallel will be more stressful, but
that this "mega fsstress run" will be more predictable and easier to
tune/get reproducers out of.

Thanks again for your thoughts,
Boris

> 
> -Dave.
> -- 
> Dave Chinner
> david@fromorbit.com

