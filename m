Return-Path: <linux-fsdevel+bounces-41355-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 657E1A2E373
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2025 06:16:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 105B73A56D0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2025 05:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D07B18870C;
	Mon, 10 Feb 2025 05:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="TMxNddSr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA9708C0B;
	Mon, 10 Feb 2025 05:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739164558; cv=none; b=hgu7uQ5FmAU9LhxMZJI6G+CuVoxErLK799a64vZ83TNZTGqVDZRSyZGx0Tq7dd8zomYTHiZkZuGQaGSLhnq+EjF4K+QzzPM6pWn0JVMqk4NswJQlXuaqwSpQbClBJPQvZzGxqSNMlSpHvRx/6UTYoZ0j77Qxa6oPqq2jiFWsvRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739164558; c=relaxed/simple;
	bh=OJu3BGyWsUK/tM3k/2c/DM4FetgxbYziS06WslKXQYg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gtv5Bb9DscJfP0OmQUNbBNSoK4iCAGJHLDzrK96xaSq4yHxVBax43ksHVRGG/8mzfyaUbBIWcW2CjxOlj+yLXCMJ1z1JV5w0B6E7QEmSjBx3FUHH0omO34bZ8MCf1iyVt9xh2r6NosPEv0pRyfkyolwy47KWJ5Ocx67J3DYkIhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=TMxNddSr; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=9G9DHZZukJQ/6fkgrKhDxF23sIsnisr7SFtP9D2rEbI=; b=TMxNddSrJs6TvBpEM233D+uAOq
	Ni9isBUBYmazrLcceu8RFo3N2IF1JbJbOW7Q0Ao/zJ3b5ibXA0GCaqztRwFMC5SOwsGnlyFn2rJW7
	2rfsnvPgh1PWqKRvtMkmE+MH6lUhTTolT3bepAagGOJ5LXQcn0sVlQWFa4vK5Ic8b1XcIPhpLjfmh
	qh4ApwDHOyBfItSVUwScU+FBaPXUKJIkdYmzCeHHKqUHf7DjLcy7Fy+2IAJExfTYjBfrJ2h2s9gpp
	rgcb2HjgCjp/x5CuMbs+dBUcy+fRQL3rNZ0gDz9/2FlEoHeiKy82qVldgT2Mrh6LBM3uakwRnan0w
	6MzC9LFg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1thM9B-000000092oI-0ICR;
	Mon, 10 Feb 2025 05:15:53 +0000
Date: Mon, 10 Feb 2025 05:15:53 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: NeilBrown <neilb@suse.de>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jeff Layton <jlayton@kernel.org>,
	Dave Chinner <david@fromorbit.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/19] VFS: use global wait-queue table for
 d_alloc_parallel()
Message-ID: <20250210051553.GY1977892@ZenIV>
References: <>
 <20250207193215.GD1977892@ZenIV>
 <173916348251.22054.1170999043107860979@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <173916348251.22054.1170999043107860979@noble.neil.brown.name>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Feb 10, 2025 at 03:58:02PM +1100, NeilBrown wrote:
> On Sat, 08 Feb 2025, Al Viro wrote:
> > 1) what's wrong with using middle bits of dentry as index?  What the hell
> > is that thing about pid for?
> 
> That does "hell" have to do with it?
> 
> All we need here is a random number.  Preferably a cheap random number.
> pid is cheap and quite random.
> The dentry pointer would be even cheaper (no mem access) providing it
> doesn't cost much to get the randomness out.  I considered hash_ptr()
> but thought that was more code that it was worth.
> 
> Do you have a formula for selecting the "middle" bits in a way that is
> expected to still give good randomness?

((unsigned long) dentry / L1_CACHE_BYTES) % <table size>

Bits just over the cacheline size should have uniform distribution...

> > 2) part in d_add_ci() might be worth a comment re d_lookup_done() coming
> > for the original dentry, no matter what.
> 
> I think the previous code deserved explanation more than the new, but
> maybe I missed something.
> In each case, d_wait_lookup() will wait for the given dentry to no
> longer be d_in_lookup() which means waiting for DCACHE_PAR_LOOKUP to be
> cleared.  The only place which clears DCACHE_PAR_LOOKUP is
> __d_lookup_unhash_wake(). which always wakes the target.
> In the previous code it would wake both the non-case-exact dentry and
> the case-exact dentry waiters but they would go back to sleep if their
> DCACHE_PAR_LOOKUP hadn't been cleared, so no interesting behaviour.
> Reusing the wq from one to the other is a sensible simplification, but
> not something we need any reminder of once it is no longer needed.

It's not just about the wakeups; any in-lookup dentry should be taken
out of in-lookup hash before it gets dropped.
 
> > 3) the dance with conditional __wake_up() is worth a helper, IMO.

I mean an inlined helper function.

