Return-Path: <linux-fsdevel+bounces-64088-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFEE2BD786D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Oct 2025 08:06:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C6353B4402
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Oct 2025 06:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A710A30E0CB;
	Tue, 14 Oct 2025 06:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="feuEu4GR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LMmTDW13"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow-a5-smtp.messagingengine.com (flow-a5-smtp.messagingengine.com [103.168.172.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C3B30CDAB;
	Tue, 14 Oct 2025 06:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760421897; cv=none; b=OkiEv8+ktHZDGzhravyd/r6qy28b+reRDiexcz3iVdYWsW/blocqZRcGVI0OavFyU5jk08yhGHYOwZkfUc7Q+Tw115US+jU9zmz9U5qPRD9ofy+3B7sWY1Ko45cm4WDqWSZ53ZSPFPYBSgoexSsMftKPVC6LfaULXdC66HboHms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760421897; c=relaxed/simple;
	bh=v2JPSGhSphxT4CRQrxJsBzP2zNqZpcixsb06q7URYzs=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=VU/kFYtaUTW8F+DZGeUYVMHHJtAdauFvyYSFYdIGKYkSy4YygMrdxjogYWrgwCOZ6qPIt9uh7Ub2NQJV2k1EaNqId3dPUg4YJJAEiGPLQdtMFKSgNrQwieRkdzNaTzc55LgFuVzNnKWUV2e1aJPHBCdSc1f1p8T3STov6ONRGaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=feuEu4GR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LMmTDW13; arc=none smtp.client-ip=103.168.172.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailflow.phl.internal (Postfix) with ESMTP id 62E6C13802DE;
	Tue, 14 Oct 2025 02:04:54 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Tue, 14 Oct 2025 02:04:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm2; t=
	1760421894; x=1760429094; bh=E4Iph9Kl8wZz1HAHn20rKGPeYlZdEw1yUQf
	1mGdkCUQ=; b=feuEu4GRf6dcErALPk+2jItHSg4i5KWiC9i417b4FIhcTbE2y2T
	+Bt4amVdnCGAM1tUKaufU8N3iC3xA2wxgMF91QjmRsfDtS8TkU58KsBcsHLC3Qe9
	9uGqg12zMyyNWlr0tHrmSZMAjHsrqR6wDDn9puU8TZhvuKVCpBBV0N4hnJN5njSM
	BHj+IqFdfGfwsjivQNzH5S2eCArfr2wTYNfe0VVD6mjQGTf1nZkL/z9FmU6wkxeC
	XP7HcSdYhv3lxXdbaxFn3pGRdVj5H/ibkL+9weFKyTuxGadyOlFat4dNTrwfckpc
	EQEtGwZGFoj2V5Cu3Q3Qg7NpyQpILU9t7YQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760421894; x=
	1760429094; bh=E4Iph9Kl8wZz1HAHn20rKGPeYlZdEw1yUQf1mGdkCUQ=; b=L
	MmTDW13ZQy/vvnXJJHqO2e4Nwp/4f0wIhr5NAnj31qKE+wHoQadph71IrqSc5Ib0
	lhC6eeRCRQGeEFwXVh03+zoKg7JvrvXHWp4EZblBZwrgx5uc1e3QbyqDIz2/xuRM
	x58UYYm8Gs2/BlOkdLgAp+C2Ud0eKKK7HOOKvovGP+SYaw8MNisjOrZV9Q+WOQVr
	FACIlwg4aSWFz83NZUIVVjDgZX3yrjk6q9Sx+4ahYsr/hpjT7Or3pU7QIuTtJpqV
	mwz8Vk/OvGuxNfinjrygxj11QA1kr2UinaJmSCRd7/tXGKs1xZ9lzd3VsMgSyHLG
	tetmXGjlWtEDy8ZH9tV3g==
X-ME-Sender: <xms:_eftaCHyqV6o3FVefhsjNT8IhmMyfFHwk8jZHMhbo-HUFu5X_n6urg>
    <xme:_eftaEnN6jBrfj20h2AuPNDCuOMyqF6Plg83kg-Wm7c0-k_CfdsL7XEtnlxZx9Zc4
    vdnWYhYYsNNXJvyiFNgoRvI7Kazc6WaYj_Vgo60bnGRd5AR>
X-ME-Received: <xmr:_eftaD6dxLXuqheOCQURHeHPfO7bW-CXtJ1AseJtZXeLq0oSGG1WRKKPAy8NkEw4I49DhwHKvB2Po8CEgxiioKrKzekCRYBLjrQ5r26_DkV4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduudeljeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurheptgfgggfhvfevufgjfhffkfhrsehtjeertddttdejnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epudetfefhudevhedvfeeufedvffekveekgfdtfefggfekheejgefhteeihffggfelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsg
    esohifnhhmrghilhdrnhgvthdpnhgspghrtghpthhtohepudegledpmhhouggvpehsmhht
    phhouhhtpdhrtghpthhtohephhhprgesiiihthhorhdrtghomhdprhgtphhtthhopehlih
    hnkhesvhhivhhordgtohhmpdhrtghpthhtoheprhgtuhesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehlihhnuhigqdhnfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtoheplhhinhhugidqmhhoughulhgvshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehlihhnuhigqdhmvgguihgrsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtoheplhhinhhugidqihguvgesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:_eftaCbgmYlvEUe7c8diYxkm08sFcYy0h1FLId3hRvl3Wygr1PpoUA>
    <xmx:_eftaO0MJ_hLSTek3S8a6e-GF_TCbTx0v6w4rpkXwlvonZGXG2N4kw>
    <xmx:_eftaNhIc-WZoUYTLfzJpLzI2fsWLLjvzv3kaEG6CxTMcM2aAlX2EQ>
    <xmx:_eftaFhY4IYteGvByEUJUmCKSZRYVweFZ66sE_nYkeHRJBJf5cUvxA>
    <xmx:BujtaI-jqBpV57I5Iv3W1WU6_3vCyGvF2hAPelzIt6ARNYBJwHSB75rK>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Oct 2025 02:04:01 -0400 (EDT)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Byungchul Park" <byungchul@sk.com>
Cc: linux-kernel@vger.kernel.org, kernel_team@skhynix.com,
 torvalds@linux-foundation.org, damien.lemoal@opensource.wdc.com,
 linux-ide@vger.kernel.org, adilger.kernel@dilger.ca,
 linux-ext4@vger.kernel.org, mingo@redhat.com, peterz@infradead.org,
 will@kernel.org, tglx@linutronix.de, rostedt@goodmis.org,
 joel@joelfernandes.org, sashal@kernel.org, daniel.vetter@ffwll.ch,
 duyuyang@gmail.com, johannes.berg@intel.com, tj@kernel.org,
 tytso@mit.edu, willy@infradead.org, david@fromorbit.com,
 amir73il@gmail.com, gregkh@linuxfoundation.org, kernel-team@lge.com,
 linux-mm@kvack.org, akpm@linux-foundation.org, mhocko@kernel.org,
 minchan@kernel.org, hannes@cmpxchg.org, vdavydov.dev@gmail.com,
 sj@kernel.org, jglisse@redhat.com, dennis@kernel.org, cl@linux.com,
 penberg@kernel.org, rientjes@google.com, vbabka@suse.cz,
 ngupta@vflare.org, linux-block@vger.kernel.org, josef@toxicpanda.com,
 linux-fsdevel@vger.kernel.org, jack@suse.cz, jlayton@kernel.org,
 dan.j.williams@intel.com, hch@infradead.org, djwong@kernel.org,
 dri-devel@lists.freedesktop.org, rodrigosiqueiramelo@gmail.com,
 melissa.srw@gmail.com, hamohammed.sa@gmail.com, harry.yoo@oracle.com,
 chris.p.wilson@intel.com, gwan-gyeong.mun@intel.com,
 max.byungchul.park@gmail.com, boqun.feng@gmail.com, longman@redhat.com,
 yunseong.kim@ericsson.com, ysk@kzalloc.com, yeoreum.yun@arm.com,
 netdev@vger.kernel.org, matthew.brost@intel.com, her0gyugyu@gmail.com,
 corbet@lwn.net, catalin.marinas@arm.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 luto@kernel.org, sumit.semwal@linaro.org, gustavo@padovan.org,
 christian.koenig@amd.com, andi.shyti@kernel.org, arnd@arndb.de,
 lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, rppt@kernel.org,
 surenb@google.com, mcgrof@kernel.org, petr.pavlu@suse.com,
 da.gomez@kernel.org, samitolvanen@google.com, paulmck@kernel.org,
 frederic@kernel.org, neeraj.upadhyay@kernel.org, joelagnelf@nvidia.com,
 josh@joshtriplett.org, urezki@gmail.com, mathieu.desnoyers@efficios.com,
 jiangshanlai@gmail.com, qiang.zhang@linux.dev, juri.lelli@redhat.com,
 vincent.guittot@linaro.org, dietmar.eggemann@arm.com, bsegall@google.com,
 mgorman@suse.de, vschneid@redhat.com, chuck.lever@oracle.com,
 okorniev@redhat.com, Dai.Ngo@oracle.com, tom@talpey.com,
 trondmy@kernel.org, anna@kernel.org, kees@kernel.org,
 bigeasy@linutronix.de, clrkwllms@kernel.org, mark.rutland@arm.com,
 ada.coupriediaz@arm.com, kristina.martsenko@arm.com,
 wangkefeng.wang@huawei.com, broonie@kernel.org, kevin.brodsky@arm.com,
 dwmw@amazon.co.uk, shakeel.butt@linux.dev, ast@kernel.org,
 ziy@nvidia.com, yuzhao@google.com, baolin.wang@linux.alibaba.com,
 usamaarif642@gmail.com, joel.granados@kernel.org,
 richard.weiyang@gmail.com, geert+renesas@glider.be,
 tim.c.chen@linux.intel.com, linux@treblig.org,
 alexander.shishkin@linux.intel.com, lillian@star-ark.net,
 chenhuacai@kernel.org, francesco@valla.it, guoweikang.kernel@gmail.com,
 link@vivo.com, jpoimboe@kernel.org, masahiroy@kernel.org,
 brauner@kernel.org, thomas.weissschuh@linutronix.de, oleg@redhat.com,
 mjguzik@gmail.com, andrii@kernel.org, wangfushuai@baidu.com,
 linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
 linux-i2c@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-modules@vger.kernel.org, rcu@vger.kernel.org,
 linux-nfs@vger.kernel.org, linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH v17 28/47] dept: add documentation for dept
In-reply-to: <20251013052354.GA75512@system.software.com>
References: <20251002081247.51255-1-byungchul@sk.com>,
 <20251002081247.51255-29-byungchul@sk.com>,
 <175947451487.247319.6809470356431942803@noble.neil.brown.name>,
 <20251013052354.GA75512@system.software.com>
Date: Tue, 14 Oct 2025 17:03:58 +1100
Message-id: <176042183810.1793333.13639772065939276568@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Mon, 13 Oct 2025, Byungchul Park wrote:
> On Fri, Oct 03, 2025 at 04:55:14PM +1000, NeilBrown wrote:
> > On Thu, 02 Oct 2025, Byungchul Park wrote:
> > > This document describes the concept and APIs of dept.
> > >
> > 
> > Thanks for the documentation.  I've been trying to understand it.
> 
> You're welcome.  Feel free to ask me if you have any questions.
> 
> > > +How DEPT works
> > > +--------------
> > > +
> > > +Let's take a look how DEPT works with the 1st example in the section
> > > +'Limitation of lockdep'.
> > > +
> > > +   context X    context Y       context Z
> > > +
> > > +                mutex_lock A
> > > +   folio_lock B
> > > +                folio_lock B <- DEADLOCK
> > > +                                mutex_lock A <- DEADLOCK
> > > +                                folio_unlock B
> > > +                folio_unlock B
> > > +                mutex_unlock A
> > > +                                mutex_unlock A
> > > +
> > > +Adding comments to describe DEPT's view in terms of wait and event:
> > > +
> > > +   context X    context Y       context Z
> > > +
> > > +                mutex_lock A
> > > +                /* wait for A */
> > > +   folio_lock B
> > > +   /* wait for A */
> > > +   /* start event A context */
> > > +
> > > +                folio_lock B
> > > +                /* wait for B */ <- DEADLOCK
> > > +                /* start event B context */
> > > +
> > > +                                mutex_lock A
> > > +                                /* wait for A */ <- DEADLOCK
> > > +                                /* start event A context */
> > > +
> > > +                                folio_unlock B
> > > +                                /* event B */
> > > +                folio_unlock B
> > > +                /* event B */
> > > +
> > > +                mutex_unlock A
> > > +                /* event A */
> > > +                                mutex_unlock A
> > > +                                /* event A */
> > > +
> > 
> > I can't see the value of the above section.
> > The first section with no comments is useful as it is easy to see the
> > deadlock being investigate.  The section below is useful as it add
> > comments to explain how DEPT sees the situation.  But the above section,
> > with some but not all of the comments, does seem (to me) to add anything
> > useful.
> 
> I just wanted to convert 'locking terms' to 'wait and event terms' by
> one step.  However, I can remove the section you pointed out that you
> thought was useless.

But it seems you did it in two steps???

If you think the middle section with some but not all of the comments
adds value (And maybe it does - maybe I just haven't seen it yet), the
please explain what value is being added at each step.

It is currently documented as:

 +Adding comments to describe DEPT's view in terms of wait and event:

then

 +Adding more supplementary comments to describe DEPT's view in detail:

Maybe if you said more DEPT's view so at this point so that when we see
the supplementary comments, we can understand how they relate to DEPT's
view.


> 
> > > +
> > > +   context X    context Y       context Z
> > > +
> > > +                mutex_lock A
> > > +                /* might wait for A */
> > > +                /* start to take into account event A's context */
> > 
> > What do you mean precisely by "context".
> 
> That means one of task context, irq context, wq worker context (even
> though it can also be considered as task context), or something.

OK, that makes sense.  If you provide this definition for "context"
before you use the term, I think that will help the reader.


> > If the examples that follow It seems that the "context" for event A
> > starts at "mutex lock A" when it (possibly) waits for a mutex and ends
> > at "mutex unlock A" - which are both in the same process.  Clearly
> > various other events that happen between these two points in the same
> > process could be seen as the "context" for event A.
> > 
> > However event B starts in "context X" with "folio_lock B" and ends in
> > "context Z" or "context Y" with "folio_unlock B".  Is that right?
> 
> Right.
> 
> > My question then is: how do you decide which, of all the event in all
> > the processes in all the system, between the start[S] and the end[E] are
> > considered to be part of the "context" of event A.
> 
> DEPT can identify the "context" of event A only *once* the event A is
> actually executed, and builds dependencies between the event and the
> recorded waits in the "context" of event A since [S].

So a dependency is an ordered set of pairs of "context" and "wait" or
"context" and "event".  "wait"s and "event"s are linked by some abstract
identifier for the event (like lockdep's lock classes).
How are the contexts abstracted. Is it just "same" or "different"

I'll try reading the document again and see how much further I get.

Thanks,
NeilBrown

