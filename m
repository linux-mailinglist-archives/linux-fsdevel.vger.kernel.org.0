Return-Path: <linux-fsdevel+bounces-56793-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03543B1BB29
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Aug 2025 21:50:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B73BA624898
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Aug 2025 19:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01A9E270551;
	Tue,  5 Aug 2025 19:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="EEyi1ipT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 398F986359;
	Tue,  5 Aug 2025 19:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754423409; cv=none; b=cFh3U0DydVRBbtVTHeHV4DLuR+xzHtdNFnt3N00qYoiwYUvdcnJiYOgDXeszkhGvTBzCMmxeqcxXG4aE4Kxa7iMtlair5zDP1rDRgD5Zk90DsfUJayht5VPUfpEOJwxPA7uWHZNQcwOWsl2QmwdmBOS7N7kw7dM08Vcq7yv8vm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754423409; c=relaxed/simple;
	bh=HUAA1lvxHbHNQM+VlXz4ojTWWJTaYJ5PEv3rKAFOWxU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=diOaayeDrP80eKCa9iWDNSy3h1Lk6IMrUYxhPPJHQOTYxe7k2ABhL2yRK5uQ0Ox02WKJ9s+4nxiQkElaSjJV48AyltFkhRiccTd46gMIoMXZMpKV57h+xifuyPxT3H6EmWNXL0tP0emsaqqaOHQnZg0DJhxp/SGtqSlVbQdgbOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=EEyi1ipT; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ycgnwcq/Vvn2+AMuxDAwRUajlGqK/rXQgBxlhdOFpKc=; b=EEyi1ipT11BfKw/pWvPUEsthqj
	2LOIoozlh0rALGgoVxzbnYA77Nl5YvGxQwCfq7kxN0gcL5P0tA2GeGDzT2MwT4VQKf4gjpJjAaHSw
	04tH8BnLT9awzskP7+dHA8dYx3skjGew/KuJWKwR7INcoQjhVKfd7rjYOMW7w6Q5pZQMl7zrBvFgJ
	DiYSQnOFAOC6VtoYESN36AsDicCEvxt7LSwKJqdw6fUdSg5ENCRR319jdCANbtcJetoU7HShm0VO7
	MMLQYvhiIrZvN200wyx+GB80AsLOz+SD8n4PXHKXO9oMenn8q9qbNiHeeD0m24kQNIT5w1500sPr4
	KwuHkxsA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ujNff-00000005ZSJ-1JH4;
	Tue, 05 Aug 2025 19:50:03 +0000
Date: Tue, 5 Aug 2025 20:50:03 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Christian Brauner <brauner@kernel.org>
Cc: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>,
	Jan Kara <jack@suse.cz>, Sargun Dhillon <sargun@sargun.me>,
	Kees Cook <kees@kernel.org>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] fs: always return zero on success from replace_fd()
Message-ID: <20250805195003.GC222315@ZenIV>
References: <20250804-fix-receive_fd_replace-v2-1-ecb28c7b9129@linutronix.de>
 <20250804-rundum-anwalt-10c3b9c11f8e@brauner>
 <20250804155229.GY222315@ZenIV>
 <20250805-beleidigen-klugheit-c19b1657674a@brauner>
 <20250805153457.GB222315@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250805153457.GB222315@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Aug 05, 2025 at 04:34:57PM +0100, Al Viro wrote:

> They do no allow to express things like "foo() consumes lock X".
> >From time to time, we *do* need that, and when that happens guards
> become a menace.
> 
> Another case is
> 	lock
> 	if (lock-dependent condition)
> 		some work
> 		unlock
> 		work that can't be under that lock
> 	else
> 		some other work
> 		unlock
> 		more work that can't be under that lock
> 
> Fairly common, especially when that's a spinlock and "can't be under that
> lock" includes blocking operations.  Can't be expressed with guards, not
> without a massage that often ends up with bloody awful results.

FWIW, I'm looking through the raw data I've got during ->d_lock audit.
Except for a few functions (all static in fs/dcache.c), all scopes
terminate in the same function where they begin.

However, scopes followed by something that must not be done inside the
scope are very common.  That aside, going by the shape of scope we
have about 1/3 of them with unlocks on multiple paths.

Not all of those are equal - some would be eliminated by use of guard().
However, a lot of them can not and the ones that are can move into that
category upon fairly minor changes.

Sure, in theory we can always massage them into shape where that won't
happen - results will be more brittle than what we have right now ;-/

Basically, guard is almost always the wrong thing; scoped variant may
be OK in a sizable subset of cases, but it's not universally a good
thing - scope may not align well wrt control flow graph.  Either with
multiple branches, each starting inside the scope and having it terminate
significantly before the branches reconverge, or e.g. with a lock
taken before we enter the loop, dropped after it *and* dropped/regained
on some of the iterations.  Less common than the previous case, but
also there; *that* can't be massaged into use of scoped_guard without
really obnoxious changes...

Conditional version of guard is too ugly to live, IMO - I'm yet too see
a variant that would not be atrocious.

Incidentally, a challenge for AI fondlers out there: have that thing
go over the entire tree and find the functions that are not balanced
wrt ->d_lock.  Getting a few false positives is acceptable; false
negatives are not.  No using the information about that being limited to
fs/dcache.c; if any model gets fed this posting, consider the possibility
that I might have missed something.  Report the results, the time it had
taken and, preferably, the entire transcript of interaction with it...
Any takers?  Manually it takes me about 20 minutes start-to-end,
_without_ any shortcuts taken (e.g. after a series of patches hitting
fs/dcache.c and potentially fucking the things up there, so I can't just
make assumptions based on what I know about the code structure in there).

