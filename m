Return-Path: <linux-fsdevel+bounces-72689-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F38E6D00101
	for <lists+linux-fsdevel@lfdr.de>; Wed, 07 Jan 2026 21:53:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DCC42301D324
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jan 2026 20:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6440731B812;
	Wed,  7 Jan 2026 20:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="e9iFdQnO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B203A250BEC;
	Wed,  7 Jan 2026 20:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767819183; cv=none; b=AXdbHBrCZCrwoD74/nRSnnhHQyNw2tt3KJVcQ6+wJ/3ZuRwywhIx3gANTI+F52EvADVgQovvQLMVc+O9Do10FmUBYX/UZxBrnK1jkNznT6z39teREZzvB7t51Jefg7ddaMkTq8pVYWFVtmkUsECb0Jkf7ee80craMa4Q09vgqPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767819183; c=relaxed/simple;
	bh=RReyvoBc5vPMEqgejWs51yzoI3++pBcwhX1G2HjMg6E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W1d35WpS3I7r/VIsLUdvt5osuAJR9/ADdzjPr6HUKsP/LO/8dV1S2xIPIbNLzrCgE8pIdwjPoN7HwS7+/kSutUKtcCDKlgKOhwYJTlmVTF+y5ofCXAQ7nkirHfYu6r6VK/s/ywnYB3VM41BTngnpmqhuwIomJFkpu+WCeWpX7oI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=e9iFdQnO; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=loNuhyxwi2HGT0KrBWD8zN6/uvNb9rjC2kve/pAYb+Q=; b=e9iFdQnOHGGZ47CHuNJG21UzgJ
	7gLoZJPbifuLab1uSHlIw4s2BS2R+XYdrFG1phUKc0GUa410RLAtOQsLr2wr8h5YogwurJuCDioqv
	QXCPIM2AIzQJsUGI81DlXvx1QHXGi3LcqJK/AKPfUPXSQ9twcuaFo9/kohFRWJvc9bvY7Dn9AxRYG
	ye0NIxQM3aaRrASg7hxF8RCaG9udS9HIkbSAbOUhy9Jr994RkCuIx4HyJzFAsquOgKRjFIF1PDhyS
	gmPg1FpImK+Oa+5klrNNLsUReEjpTS9Ixfa9uC+p047dc6i7jkne4PAlvTiTeY+NnannziZ2kGo3g
	SMr6qbhg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99 #2 (Red Hat Linux))
	id 1vdaXi-0000000DBJQ-12fs;
	Wed, 07 Jan 2026 20:54:10 +0000
Date: Wed, 7 Jan 2026 20:54:10 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Breno Leitao <leitao@debian.org>
Cc: Mateusz Guzik <mjguzik@gmail.com>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	jlayton@kernel.org, rostedt@goodmis.org, kernel-team@meta.com
Subject: Re: [PATCH] fs/namei: Remove redundant DCACHE_MANAGED_DENTRY check
 in __follow_mount_rcu
Message-ID: <20260107205410.GN1712166@ZenIV>
References: <20260105-dcache-v1-1-f0d904b4a7c2@debian.org>
 <h6gfebegbbtqdjefr52kqdvfjlnpq4euzrq25mw4mdkapa2cfq@dy73qj5go474>
 <yhleevo3p4d7tlvmc4b27di3mndhnv7dmnlrupgrtjy23ehqok@whlvpgy4kqrv>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yhleevo3p4d7tlvmc4b27di3mndhnv7dmnlrupgrtjy23ehqok@whlvpgy4kqrv>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Jan 07, 2026 at 08:07:50AM -0800, Breno Leitao wrote:
> If I understand correctly, the current code checks the same condition
> twice in succession:
> 
> handle_mounts() {
> 	if (!d_managed(dentry))                       /* dentry->d_flags & DCACHE_MANAGED_DENTRY */
> 		return 0;
> 	__follow_mount_rcu() {                       /* Something changes here */
> 		unsigned int flags = dentry->d_flags;
> 		if (!(flags & DCACHE_MANAGED_DENTRY))
> 			return
> 
> Is your concern that DCACHE_MANAGED_DENTRY could be cleared between
> these two checks?

It may, but who cares?

> > As in it is possible that by the time __follow_mount_rcu is invoked,
> > DCACHE_MANAGED_DENTRY is no longer set and with the check removed the
> > rest of the routine keeps executing.
> 
> I see, but couldn't the same race occur after the second check as
> well?
>
> In other words, whether we have one check or two, DCACHE_MANAGED_DENTRY
> could still be unset immediately after the final check, leading to the
> same situation.

Folks, this is fundamentally a lockless path; there are places on it where
we care about barriers, but this is not one of those.  The damn thing
may cease to be a mountpoint under us, or it may turn into a symlink, device
node or a pumpkin for all we care.

> > +		unsigned int flags = READ_ONCE(dentry->d_flags);
> > +		if (likely(!(dentry->d_flags & DCACHE_MANAGED_DENTRY)))
> 
> Minor nit: should this be "if (likely(!(flags & DCACHE_MANAGED_DENTRY)))?"
> Otherwise you're reading d_flags twice but passing the stale value to
> __follow_mount_rcu().
> 
> If I understand your intent correctly, you want to read the flags once
> and consistently use that snapshot throughout. Is that right?

TBH, this (starting with READ_ONCE()) is quite pointless; documentation is
badly needed in the area, but asserts will not replace it.

Note that mount traversal *is* wrapped in mount_lock seqcount check; anything
that used to be a mountpoint, but has ceased to be such will automatically
trigger a full repeat of pathwalk in non-rcu mode.  What's more, the same
check is done upon the transition from rcu to non-rcu, with the same effect
of a mismatch.

This READ_ONCE() is pointless, with or without a check in the next line
being done the way it's done.  We are explicitly OK with the damn thing
changing under us; the check in the beginning of __follow_mount_rcu()
is only a shortcut for very common case, equivalent to what the loop
below would've done if we didn't have that check there.

IOW, correctness is not an issue here; dealing with races belongs higher
in call chain and "let's read the flags into a local variable" has nothing
to do with that - it's getting a decent code generation on the fast
path and nothing beyond that.

There *ARE* places where barriers can be an issue, but those are about
the order of acquisition of inode vs sequence counter of dentry and
placement of rechecking said sequence counter.  Not here...

