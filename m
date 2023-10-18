Return-Path: <linux-fsdevel+bounces-708-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C2327CE9AC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Oct 2023 23:05:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14A7F281E37
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Oct 2023 21:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B35A842920;
	Wed, 18 Oct 2023 21:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PUZ5sZGn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E2B04290A
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Oct 2023 21:05:04 +0000 (UTC)
Received: from out-196.mta0.migadu.com (out-196.mta0.migadu.com [IPv6:2001:41d0:1004:224b::c4])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A27B84698
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Oct 2023 14:05:02 -0700 (PDT)
Date: Wed, 18 Oct 2023 17:04:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1697663100;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/1ArYLLOZBAUcL76jk5+IqwZHBWHE65QdqzM7Jwfn30=;
	b=PUZ5sZGnRytk4geioVimacEw2cEuvdXKXjA5NiIVXtas9kSdhr6BFkPxNbVKPSrukOW87F
	F71gKsf1bZPDpHFT6N0KA2B5Fx+VMtGdZDzbT0nStxQme5LPclO6KxT+fTjoo57XsVndUG
	Shn/ZsqKI1EPv+jv39uCiZhMgQZ+Iow=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Ingo Molnar <mingo@kernel.org>
Cc: Waiman Long <longman@redhat.com>, linux-bcachefs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Boqun Feng <boqun.feng@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [NAK] Re: [PATCH 11/20] locking/osq: Export osq_(lock|unlock)
Message-ID: <20231018210456.lgdicnuekvmvcgvm@moria.home.lan>
References: <20230712211115.2174650-1-kent.overstreet@linux.dev>
 <20230712211115.2174650-12-kent.overstreet@linux.dev>
 <bb77f456-8804-b63a-7868-19e0cd9e697f@redhat.com>
 <20230802204407.lk5mnj7ua6idddbd@moria.home.lan>
 <11d39248-31fc-c625-7c06-341f0146bd67@redhat.com>
 <20230802214211.y3x3swic4jbphmtg@moria.home.lan>
 <ZSUGwr5S5Nflbiay@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZSUGwr5S5Nflbiay@gmail.com>
X-Migadu-Flow: FLOW_OUT

On Tue, Oct 10, 2023 at 10:09:38AM +0200, Ingo Molnar wrote:
> > Waiman, if you think you can add all the features of six locks to rwsem,
> > knock yourself out - but right now this is a vaporware idea for you, not
> > something I can seriously entertain. I'm looking to merge bcachefs next
> > cycle, not sit around and bikeshed for the next six months.
> 
> That's an entirely inappropriate response to valid review feedback.
> 
> Not having two overlapping locking facilities is not 'bikeshedding' at all ...

Well, there was already a long off-list discussion about adding six lock
features to rwsem.

Basically, it looks to me like a total redesign of rwsem in order to do
it correctly, and I don't think that would fly. The rwsem code has
separate entrypoints for every lock state, and adding a third lock state
would at a minimum add a lot of new - nearly duplicate - code.

There's also features and optimizations in six locks that rwsem doesn't
have, and it's not clear to me that it would be appropriate to add them
to rwsem - each of them would need real discussion. The big ones are:

 - percpu reader mode, used for locks for interior nodes and subvolume
   keys in bcachefs
 - exposing of waitlist entries (and this requires nontrivial guarantees
   to do correctly!), so that bcachefs can do cycle detection deadlock
   avoidance on top.

In short, this would _not_ be a small project, and I think the saner
approach if we really did want to condense down to a single locking
implementation would be to replace rwsem with six locks. But before even
contemplating that we'd want to see six locks getting wider usage and
testing first.

Hence why we're at leaving six locks in fs/bcachefs/ for now.

> > If you start making a serious effort on adding those features to rwsem
> > I'll start walking you through everything six locks has, but right now
> > this is a major digression on a patch that just exports two symbols.
> 
> In Linux the burden of work is on people submitting new code, not on 
> reviewers. The rule is that you should not reinvent the wheel in new
> features - extend existing locking facilities please.
> 
> Waiman gave you some pointers as to how to extend rwsems.
> 
> Meanwhile, NAK on the export of osq_(lock|unlock):

Perhaps we could get some justification for why you want osq locks to be
private?

My initial pull request had six locks in kernel/locking/, specifically
to keep osq locks private, as requested by locking people (some years
back). But since Linus shot that down, I need an alternative.

If you're really dead set against exporting osq locks (and again, why?),
my only alternative will be to either take optimistic spinning out of
six locks, or implement optimistic spinning another way (which is
something I was already looking at before; the way lock handoff works in
six locks now makes that an attractive idea anyways, but of course the
devil is in the details with locking code).

