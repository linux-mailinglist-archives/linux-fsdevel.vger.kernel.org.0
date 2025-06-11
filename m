Return-Path: <linux-fsdevel+bounces-51239-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B336AD4D6D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 09:50:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E04457AB117
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 07:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EAFF227BA9;
	Wed, 11 Jun 2025 07:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="nhx1dBwG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECDC927718
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Jun 2025 07:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749628230; cv=none; b=XJJQ6eM9PJmphH1wj+NtZsqRkqg3OTH4hEp6Vco1Co5Rx0bB/kvvo2LMz27BsUbWwc0PmT79fmvZ22bHmJ+9NIxkzvrEvdFMUM2TD4AjuTSwYfYI0sqBuWdH12Sk6BLhpP1p5xt9Rj1aexBTgIBUq6NROJ9JvslqzH9vA3t37G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749628230; c=relaxed/simple;
	bh=6Dspywsd2C/c92REUsPEh35A6Hr8NFLOPuZPIJyVgoc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gZodUeSvWiO6GgwxlowO48P04qZ9MbdYQVvTkVxzPVL6w29xWg3wSWehsbzfrahyzRbC+iq0gebSsomROYgMWnWD9ERRiY3skgDinFiOP75uoiQPE2P0tnq3kvYZFyp9+jOk+76kVUiZK8FnXAHSpzMmY+jbmd7tYzPYLBPLcxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=nhx1dBwG; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=aFgAi28pV+daoBCgDAFDCSReU6VmQiyPHzRvDEEoqmI=; b=nhx1dBwGzxFfzF5ueUYfVShJzc
	HlhuO8jDQdafKdLUh6mr8tsT2JoZ5oXkuY9Jqm1m3K6k2B/sKzaZNnI4o3RSRppTtXc2bvymGBM42
	hcM2i0XEnsqVAl9uXbihSnNKN47QZvKSLpDpB7k3vScgrDaz5vKJ6A3NxNdaIUXjcHnO8PtG/JvZx
	NqHGW6UTE92RzK4vBQsJiqFHT/H8cNGYCSEkvUmKOGe8KDEhkzxdLaJ60No1hMwZaX3Sm8ADc2D19
	9YiKa468jUgqsck0YnYIg+7mnEp49QI7fArOu5+ENBiNwwi3g/CX9Y9uIOPqZjD9uuAZZ16rNdbad
	QO/qXf0w==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPGE3-0000000HRf3-2wcJ;
	Wed, 11 Jun 2025 07:50:23 +0000
Date: Wed, 11 Jun 2025 08:50:23 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Neil Brown <neilb@suse.de>, Miklos Szeredi <miklos@szeredi.hu>,
	Jan Kara <jack@suse.cz>
Subject: [RFC][PATCHES v2] dentry->d_flags locking
Message-ID: <20250611075023.GJ299672@ZenIV>
References: <20250224010624.GT1977892@ZenIV>
 <20250224-anrief-schwester-33e6ca8774de@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250224-anrief-schwester-33e6ca8774de@brauner>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Feb 24, 2025 at 12:45:49PM +0100, Christian Brauner wrote:

> Also mentioned in my other reply: Can you please make the unhashed case
> really explicit ideally at dentry allocation time. IOW, that there's a
> flag or some other way of simply identifying a dentry as belonging to an
> fs that will never hash them?

This really doesn't make sense; on all those filesystems we *do* want
everything positive to be hashed.  So I don't see anything useful that
fs/dcache.c could check, not to mention how much I dislike behaviour
that depends upon "feature flags" in file_system_type in general.

All dentries are allocated unhashed negative; a plenty of such fs
go through the normal lookup helpers when they populate their
trees.  Sure, we could have their ->lookup() just return NULL
and be done with that, but then we'd have to modify the code
that handles attaching the damn things to inodes accordingly...

I don't see any point, especially since it would just create churn
for tree-in-dcache series porting^Wresurrection, which I'm going
to do this weekend.

Or are you talking about DCACHE_DONTCACHE (i.e. "unhash as soon as
refcount hits 0", rather than "never hash it at all")?

Anyway, I have ported the "safe ->d_flags" series (this thread) to
6.16-rc1.  Changes:

* several commits got dropped (merged or, as in afs dynroot case, invalidated)
* procfs flag moved to include/linux/procfs.h, deconflicted.
* tracefs told to set DCACHE_DONTCACHE on everything; it is a behaviour
change, and IMO the correct one.
* in "simple_lookup(): just set DCACHE_DONTCACHE", don't set the flag if
->d_op had been set and DCACHE_DONTCACHE wasn't already present.  That
matches the mainline logics.  See comments in that commit...

Force-pushed into
git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git #work.dcache
Individual patches in followups; if nobody comes up with objections,
into #for-next it goes.  Folks, please review.

