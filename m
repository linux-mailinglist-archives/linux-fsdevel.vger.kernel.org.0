Return-Path: <linux-fsdevel+bounces-40794-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 38668A27B69
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 20:38:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC1AB18849E6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 19:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49086204C21;
	Tue,  4 Feb 2025 19:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="FjRxU40s";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xjwTMYT7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A38A0204698
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Feb 2025 19:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738697896; cv=none; b=QaJLieCkR4F2Z2Zprm7L5TpM57f22nGkwM52tH5m1m2l31sAp2UQzHF4XeyQvUZGnfqNreh3IOuvpEBaAeTnjs2dLZINGwfyBa6XcVExjJCQ73qhVTKp1Fg186ShBshsuyg9qVZBtminu5pDgfPzO0KQONsdg8VffIL6vHzOJgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738697896; c=relaxed/simple;
	bh=PildS/sssDQ56sE8g3QZGLYd2/1lAcX/8Q45RNFNoEE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BL2eGUvRaAWlfQWYSaBVjd7SQtK3VKdRtkbtReYtKbetDeOIPPRNK4wPjm5BE4Wl7F90mSzBRvTfxYWM0ZM+09eXPK4HPMFe90JdKDfoqZ2n7RuUakZbBGIvu3U+BzVqtq8YmAk5xbFaEcfYpLtfd2kXHckLVFsv2D1Y3Mkq908=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=FjRxU40s; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=xjwTMYT7; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A25F711401D0;
	Tue,  4 Feb 2025 14:38:12 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Tue, 04 Feb 2025 14:38:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1738697892; x=1738784292; bh=/zyNGh/DaX
	g/2OEZZBf+r5cr8F7gOmTC9VifxotaZOw=; b=FjRxU40sCHeIGQ5idD59yVo2HB
	wJmZh6IHPXQIyQ3P+MD38219xBresqpm8/0iJF3HgPavvhZe/QesO6V90EPwpeog
	wCh1n0+0g8xd3v/W9itbZSnahZN91OWgqKE4Lefva7VD0CpnMLIonL+Xqowjz1vr
	2l+2qepEpdNAIcTAPXHKxrSnoOnuHF0Dyxk+OqqJc/+u2ykHCV2MwPJ4Fct/4zyj
	QnrHfxvvN3791hpBVwmmFjQ5QfXqUy4yRg4TJjEg7fs96DGcVKXRQjkqkCZ4lD5u
	nhXew8eVuyU9qVRFAyPDlCxlQ3CpZer+NvUrt04BlWaxO4gKborYFRDQRwYg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738697892; x=1738784292; bh=/zyNGh/DaXg/2OEZZBf+r5cr8F7gOmTC9Vi
	fxotaZOw=; b=xjwTMYT7ro+ZB/bJNaz8vPQn+yrZ4gf80l/eEufg69shnHUdohs
	dAP4NOI6DM0AKt4kCmo/TRWnYmwV1G16VGz4JDi+Ag+AE8F+zgZhFMdavUXGt4YS
	SPm7e4TWGKxOUocTNqwxbN5DCswjQCNtQknryP8IMb8aTYZL0Eui/7WcH7dz2i6v
	mDmixeyAnDS4V0tX6y6rlvbl7rxA1vN755nBxMRzkJ0o0em6o/Clc9s5fpRlWVMy
	B5qUEGktfqRGvH6E3hGOvP26OLgLf7esjQb0EDjpxZhYWLRMu8Xd8d5s11dyjV2S
	AQuKaKny2YT2uXSADcDdMazIMhTaJOhqhcQ==
X-ME-Sender: <xms:pGyiZ82JbQzprc5529e3zFSz8-OT5uuoazzLMykNSpA8IXps2MFSeQ>
    <xme:pGyiZ3H2Y8slrjAaUItG1sucTdjvEi2jsaZ_pKHn5x8tBd58Qp9NnIKygdSmeEWM_
    ejd60EsGCkW6T8f3mg>
X-ME-Received: <xmr:pGyiZ07MhY6Y386u_ljKLtb4tPTtJTq80pbrTynGpCnf42jCLJyUxVZN9z3ny2Y_57GpQSnS-qwrDUNEnP-fn35a35M>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvudeflecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheqne
    cuggftrfgrthhtvghrnhephedthfevgffhtdevgffhlefhgfeuueegtdevudeiheeiheet
    leeghedvfeegfeegnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhssegsuhhrrdhi
    ohdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepug
    hjfihonhhgsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlshhfqdhptgeslhhishht
    shdrlhhinhhugidqfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtoheplhhinhhugi
    dqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:pGyiZ119USVCnX-DSdQprP0ClJLqvIEMQeGQI4SVV2fd1rgYHevP_A>
    <xmx:pGyiZ_GyU45qNA4eiKQyu-H2dn3Jc_C99bbsJOPUAWUNsy9atPgYqw>
    <xmx:pGyiZ-9SekGS5IBXCa-ssWLfnbQ1JmhclkXBNUQV3NTBv0NlnvXaAQ>
    <xmx:pGyiZ0mbifDfut3vXg07NR1WHknL_p_iLqCOzttdfQdZzs1uvlK_yA>
    <xmx:pGyiZ3CHer2-igmbgkL6dIyxougVOc-ljqYhkRkSUJYqF-S80BobYoky>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Feb 2025 14:38:11 -0500 (EST)
Date: Tue, 4 Feb 2025 11:38:45 -0800
From: Boris Burkov <boris@bur.io>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org
Subject: Re: [LSF/MM/BPF TOPIC] Long Duration Stress Testing Filesystems
Message-ID: <20250204193845.GA3657803@zen.localdomain>
References: <20250203185519.GA2888598@zen.localdomain>
 <20250203195343.GA134490@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250203195343.GA134490@frogsfrogsfrogs>

On Mon, Feb 03, 2025 at 11:53:43AM -0800, Darrick J. Wong wrote:
> On Mon, Feb 03, 2025 at 10:55:19AM -0800, Boris Burkov wrote:
> > At Meta, we currently primarily rely on fstests 'auto' runs for
> > validating Btrfs as a general purpose filesystem for all of our root
> > drives. While this has obviously proven to be a very useful test suite
> > with rich collaboration across teams and filesystems, we have observed a
> > recent trend in our production filesystem issues that makes us question
> > if it is sufficient.
> > 
> > Over the last few years, we have had a number of issues (primarily in
> > Btrfs, but at least one notable one in Xfs) that have been detected in
> > production, then reproduced with an unreliable non-specific stressor
> > that takes hours or even days to trigger the issue.
> > Examples:
> > - Btrfs relocation bugs
> > https://lore.kernel.org/linux-btrfs/68766e66ed15ca2e7550585ed09434249db912a2.1727212293.git.josef@toxicpanda.com/
> > https://lore.kernel.org/linux-btrfs/fc61fb63e534111f5837c204ec341c876637af69.1731513908.git.josef@toxicpanda.com/
> > - Btrfs extent map merging corruption
> > https://lore.kernel.org/linux-btrfs/9b98ba80e2cf32f6fb3b15dae9ee92507a9d59c7.1729537596.git.boris@bur.io/
> > - Btrfs dio data corruptions from bio splitting
> > (mostly our internal errors trying to make minimal backports of
> > https://lore.kernel.org/linux-btrfs/cover.1679512207.git.boris@bur.io/
> > and Christoph's related series)
> > - Xfs large folios 
> > https://lore.kernel.org/linux-fsdevel/effc0ec7-cf9d-44dc-aee5-563942242522@meta.com/
> > 
> > In my view, the common threads between these are that:
> > - we used fstests to validate these systems, in some cases even with
> >   specific regression tests for highly related bugs, but still missed
> >   the bugs until they hit us during our production release process. In
> >   all cases, we had passing 'fstests -g auto' runs.
> > - were able to reproduce the bugs with a predictable concoction of "run
> >   a workload and some known nasty btrfs operations in parallel". The most
> >   common form of this was running 'fsstress' and 'btrfs balance', but it
> >   wasn't quite universal. Sometimes we needed reflink threads, or
> >   drop_caches, or memory pressure, etc. to trigger a bug.
> > - The relatively generic stressing reproducers took hours or days to
> >   produce an issue then the investigating engineer could try to tweak and
> >   tune it by trial and error to bring that time down for a particular bug.
> > 
> > This leads me to the conclusion that there is some room for improvement in
> > stress testing filesystems (at least Btrfs).
> > 
> > I attempted to study the prior art on this and so far have found:
> > - fsstress/fsx and the attendant tests in fstests/. There are ~150-200
> >   tests using fsstress and fsx in fstests/. Most of them are xfs and
> >   btrfs tests following the aforementioned pattern of racing fsstress
> >   with some scary operations. Most of them tend to run for 30s, though
> >   some are longer (and of course subject to TIME_FACTOR configuration)
> > - Similar duration error injection tests in fstests (e.g. generic/475)
> > - The NFSv4 Test Project
> >   https://www.kernel.org/doc/ols/2006/ols2006v2-pages-275-294.pdf 
> >   A choice quote regarding stress testing:
> >   "One year after we started using FSSTRESS (in April 2005) Linux NFSv4
> >   was able to sustain the concurrent load of 10 processes during 24
> >   hours, without any problem. Three months later, NFSv4 reached 72 hours
> >   of stress under FSSTRESS, without any bugs. From this date, NFSv4
> >   filesystem tree manipulation is considered to be stable."
> > 
> > 
> > I would like to discuss:
> > - Am I missing other strategies people are employing? Apologies if there
> >   are obvious ones, but I tried to hunt around for a few days :)
> 
> At the moment I start six VMs per "configuration", which each run one of:
> 
> generic/521	(directio)
> generic/522	(bufferedio)
> generic/476	(fsstress)
> generic/388	(fsstress + log recovery)
> xfs/285		(online fsck)
> xfs/286		(online metadata rebuild)

That is sweet, and sorry I missed the soak category. I would love to
hear more about your experience with these tests! Do they catch a lot of
bugs? How hard is it to reduce the reproducer down to something smaller
and quicker when you do hit something? I'm also surprised at how few of
these you need. Does xfs just have a lot fewer online "admin" operations
like device replace, defrag, balance, enabling/disabling compression, etc.
than btrfs so you need fewer tests like that? Or do you just not think
that adding more noise would catch enough bugs to make it worth it?
Or does fsstress encompass all the operations you are interested in?

There are a bunch of similar btrfs tests (btrfs/060-074 race fsstress
with one or two interesting btrfs operations each) but we don't
currently run them for much longer than 30s. I am curious to try running
them as soak tests, now, and adding fsx running variants. That will end
up with like ~30 pretty similar tests, that I also feel could sort of
just be one big modular test?

Which kind of gets back to what I was getting at in the first place. I
don't know enough about xfs to fully grok what the various
configurations do to the test (I imagine they enable various features
you want to validate under the soak), but I imagine there are still more
nasty things to do to the system in parallel.

> 
> with SOAK_DURATION=6.5d so that they wrap up right around the time that
> each rc release drops.  I also set FSSTRESS_AVOID="-m 16" so that we
> don't end up with gigantic quota files.
> 
> There are two "configurations" per kernel tree.  The dot product of them
> are:
> 
> djwong-dev:
> -m metadir=1,autofsck=1,uquota,gquota,pquota,
> -m metadir=1,autofsck=1,uquota,gquota,pquota, -d rtinherit=1,
> 
> tot mainline:
> -m autofsck=1, -d rtinherit=1,
> -m autofsck=1,
> 
> for-next:
> -m metadir=1,autofsck=1,uquota,gquota,pquota,
> -m metadir=1,autofsck=1,uquota,gquota,pquota, -d rtinherit=1,
> 
> Actually, I just realized that with 6.14 I need to update the tot
> mainline configuration to have metadir=1.
> 
> > - What is the universe of interesting stressors (e.g., reflink, scrub,
> >   online repair, balance, etc.)
> 
> Prodding djwong and everyone else into loading up fsx/fsstress with
> all their weird new file io calls. ;)

I think this is quite interesting, actually. Fsstress already does
create and delete snapshots and makes reflinks, but there have been a
number of bugs that I have been unable to reproduce with raw fsstress
but if I run fsstress PLUS more external
reflinking/snapshotting/syncing/etc threads, then they reproduce. It
seems, logically, I could keep fussing with my fsstress invocation to
get there, but that was my experience.

Separately, how much do we want to be adding features that are only in
one or two filesystems to fsstress (similar to my points above regarding
test cardinality explosion)

> 
> > - What is the universe of interesting validation conditions (e.g.,
> >   kernel panic, read only fs, fsck failure, data integrity error, etc.)
> > - Is there any interest in automating longer running fsstress runs? Are
> >   people already doing this with varying TIME_FACTOR configurations in
> >   fstests?
> 
> I don't run with SOAK_DURATION > 14 days because I generally haven't
> found larger values to be useful in finding bugs.  However, these weekly
> long soak tests runs have been going since 2016.

That makes sense to me, it does feel like a day to a week is probably
the sweet spot.

> 
> FWIW that actually started because we had a lot of customer complaints
> in that era about log recovery failures in xfs, and only later did I
> spread it beyond generic/388 to the six profiles above.
> 
> > - There is relatively less testing with fsx than fsstress in fstests.
> >   I believe this creates gaps for data corruption bugs rather than
> >   "feature logic" issues that the fsstress feature set tends to hit.
> 
> Probably.  I wonder how much we're really flexing io_uring?
> 
> --D
> 
> > - Can we standardize on some modular "stressors" and stress durations
> >   to run to validate file systems?
> > 
> > In the short term, I have been working on these ideas in a separate
> > barebones stress testing framework which I am happy to share, but isn't
> > particularly interesting in and of itself. It is basically just a
> > skeleton for concurrently running some concurrent "stressors" and then
> > validating the fs with some generic "validators". I plan to run it
> > internally just to see if I can get some useful results on our next few
> > major kernel releases.
> > 
> > And of course, I would love to discuss anything else of interest to
> > people who like stress testing filesystems!
> > 
> > Thanks,
> > Boris
> > 

