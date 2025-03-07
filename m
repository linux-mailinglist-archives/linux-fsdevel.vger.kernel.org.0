Return-Path: <linux-fsdevel+bounces-43439-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB49AA56A70
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Mar 2025 15:33:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 776553A9B23
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Mar 2025 14:33:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FC4721C18A;
	Fri,  7 Mar 2025 14:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HNHn2sH4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDDF521B9F8
	for <linux-fsdevel@vger.kernel.org>; Fri,  7 Mar 2025 14:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741358011; cv=none; b=kT8TE+usp5jk7Y869HHUjA5Z7n4GRJzQLkFgWBBCFEhKR4FFqwrAy+wvu/NgWoqpAi0dOVjJdUcZiolPzfEc8FSo54c75Lb19pG4ybjNzBEJmJqVrW2SnXI1kx2F5RB+j0u6zRoYf1gw5ML4lSWX62IFlJBJJTwJDAcbLKlWxz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741358011; c=relaxed/simple;
	bh=Ah4V9gXkZcRUGClC4NNQfVikJonjsRQKb6mmES319Ls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vA5OnE84LHlaxalEwoZk9rlIe5Iegipce+APy/QN5VCivQKCK9HwLWCIrANwbGbX6gauV5Vj3WXpwUeXpS1ed5tEo5eoOWS5MTwfEprFDoHt+k6Uw7JIOQcgAf/oa3Vw6h2bWu9BufPVRbApTIzkEJhZi041sjZPZ56SPZKgTWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HNHn2sH4; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 7 Mar 2025 09:33:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741357997;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pjl4DWZrTPv6Tr4FNOs316geaz13POhQ8HdzhOPafp4=;
	b=HNHn2sH4TmKROiCNrlgy55VVMpv0UiAHVP0vg32Y3CS2ja80qLsGIH4VdDN9iDe/zIguTc
	PEDWTMHpSa0EfPUotQQzJp1KT0hBG1F23NqBN26eVa4ivdYBAlrjOnyFq/yT/pKsIHdQce
	E+3G/SgFM6ZbO42nj6arUVVkNFZe69A=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Theodore Ts'o <tytso@mit.edu>
Cc: Hector Martin <marcan@marcan.st>, 
	syzbot <syzbot+4364ec1693041cad20de@syzkaller.appspotmail.com>, broonie@kernel.org, joel.granados@kernel.org, kees@kernel.org, 
	linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bcachefs?] general protection fault in proc_sys_compare
Message-ID: <a5avbx7c6pilz4bnp3iv7ivuxtth7udo6ypepemhumsxvuawrw@qa7kec5sxyhp>
References: <67ca5dd0.050a0220.15b4b9.0076.GAE@google.com>
 <239cbc8a-9886-4ebc-865c-762bb807276c@marcan.st>
 <ph6whomevsnlsndjuewjxaxi6ngezbnlmv2hmutlygrdu37k3w@k57yfx76ptih>
 <20250307133126.GA8837@mit.edu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250307133126.GA8837@mit.edu>
X-Migadu-Flow: FLOW_OUT

On Fri, Mar 07, 2025 at 08:31:26AM -0500, Theodore Ts'o wrote:
> On Fri, Mar 07, 2025 at 06:51:23AM -0500, Kent Overstreet wrote:
> > 
> > Better bisection algorithm? Standand bisect does really badly when fed
> > noisy data, but it wouldn't be hard to fix that: after N successive
> > passes or fails, which is unlikely because bisect tests are coinflips,
> > backtrack and gather more data in the part of the commit history where
> > you don't have much.
> 
> My general approach when handling some test failure is to try running
> the reproducer 5-10 times on the original commit where the failure was
> detected, to see if the reproducer is reliable.  Once it's been
> established whether the failure reproduces 100% of the time, or some
> fraction of the time, say 25% of the time, then we can estalbish how
> times we should try running the reproducer before we can conclude the
> that a particular commit is "good" --- and the first time we detect a
> failure, we can declare the commit is "bad", even if it happens on the
> 2nd out of the 25 tries that we might need to run a test if it is
> particularly flaky.

That does sound like a nice trick. I think we'd probably want both
approaches though, I've seen cases where a test starts out failing
perhasp 5% of the time and then jumps up to 40% later on - some other
behavioural change makes your race or what have you easier to hit.

Really what we're trying to do is determine the shape of an unknown
function sampling; we hope it's just a single stepwise change
but if not we need to keep gathering more data until we get a clear
enough picture (and we need a way to present that data, too).

> 
> Maybe this is something Syzbot could implement?

Wouldn't it be better to have it in 'git bisect'?

> And if someone is familiar with the Go language, patches to implement
> this in gce-xfstests's ltm server would be great!  It's something I've
> wanted to do, but I haven't gotten around to implementing it yet so it
> can be fully automated.  Right now, ltm's git branch watcher reruns
> any failing test 5 times, so I get an idea of whether a failure is
> flaky or not.  I'll then manually run a potentially flaky test 30
> times, and based on how reliable or flaky the test failure happens to
> be, I then tell gce-xfstests to do a bisect running each test N times,
> without having it stop once the test fails.  It wasts a bit of test
> resources, but since it doesn't block my personal time (results land
> in my inbox when the bisect completes), it hasn't risen to the top of
> my todo list.

If only we had interns and grad students for this sort of thing :)

