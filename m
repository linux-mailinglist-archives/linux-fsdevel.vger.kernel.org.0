Return-Path: <linux-fsdevel+bounces-52814-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 622B9AE71B2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 23:50:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F00353B0D4B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 21:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79E1A25A63D;
	Tue, 24 Jun 2025 21:50:35 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 913F1259CB3;
	Tue, 24 Jun 2025 21:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.228.1.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750801835; cv=none; b=pmKlaHSrIFbQLcWmAQ7HH6khthP+1vFrnJdJEJhZxUMV4d5O0gxhnj314tyAeRbCqJ5IzLXSxw6Dzsyj7w+htyE0B7Qf7ah+ot0KkePwq1kGYuGtRoqqkyuMnyRY2ksIUBBPqlXKXAXAqyyvPgNX1g6DuDYO0mkA/duqwtxTTzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750801835; c=relaxed/simple;
	bh=ZSkB+ub3q81ogKAZ6R3Jrke3PKT4q1GPBEWVpJfap0g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Mime-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c4OpW0E///wX+r17H8AFiPxg2Wk/Nw7aFWfjROU4E92P/cV+Z4WoTZ0dOER0OouyLvm8mosmqAqYusNt+BzMzgM3LwrS1b5rCWISUpgGnJRjgVDcTXNJ5EZeOZEANmoDY3bXx2nnV4P57CQ1tGCPYRNTa/cYNbi/8LaIJe84hYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org; spf=pass smtp.mailfrom=kernel.crashing.org; arc=none smtp.client-ip=63.228.1.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.crashing.org
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 55OLbO3g015495;
	Tue, 24 Jun 2025 16:37:25 -0500
Received: (from segher@localhost)
	by gate.crashing.org (8.14.1/8.14.1/Submit) id 55OLbDMs015480;
	Tue, 24 Jun 2025 16:37:13 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date: Tue, 24 Jun 2025 16:37:12 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: David Laight <david.laight.linux@gmail.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>, Naveen N Rao <naveen@kernel.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Andre Almeida <andrealmeid@igalia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 0/5] powerpc: Implement masked user access
Message-ID: <20250624213712.GI17294@gate.crashing.org>
References: <cover.1750585239.git.christophe.leroy@csgroup.eu> <20250622172043.3fb0e54c@pumpkin> <ff2662ca-3b86-425b-97f8-3883f1018e83@csgroup.eu> <20250624093258.4906c0e0@pumpkin>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250624093258.4906c0e0@pumpkin>
User-Agent: Mutt/1.4.2.3i

Hi!

On Tue, Jun 24, 2025 at 09:32:58AM +0100, David Laight wrote:
> > So GCC uses the 'unlikely' variant of the branch instruction to force 
> > the correct prediction, doesn't it ?
> 
> Nope...
> Most architectures don't have likely/unlikely variants of branches.

In GCC, "likely" means 80%. "Very likely" means 99.95%.  Most things get
something more appropriate than such coarse things predicted.

Most of the time GCC uses these predicted branch probabilities to lay
out code in such a way that the fall-through path is the expected one.

Target backends can do special things with it as well, but usually that
isn't necessary.

There are many different predictors.  GCC usually can predict things
not bad by just looking at the shape of the code, using various
heuristics.  Things like profile-guided optimisation allow to use a
profile from an actual execution to optimise the code such that it will
work faster (assuming that future executions of the code will execute
similarly!)

You also can use __builtin_expect() in the source code, to put coarse
static prediction in.  That is what the kernel "{un,}likely" macros do.

If the compiler knows some branch is not very predictable, it can
optimise the code knowing that.  Like, it could use other strategies
than conditional branches.

On old CPUs something like "this branch is taken 50% of the time" makes
it a totally unpredictable branch.  But if say it branches exactly every
second time, it is 100% predicted correctly by more advanced predictors,
not just 50%.

To properly model modern branch predictors we need to record a "how
predictable is this branch" score as well for every branch, not just a
"how often does it branch instead of falling through" score.  We're not
there yet.


Segher

