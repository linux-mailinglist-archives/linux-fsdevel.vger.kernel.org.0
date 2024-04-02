Return-Path: <linux-fsdevel+bounces-15942-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16CCD895FAD
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 00:42:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C17561F24722
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Apr 2024 22:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E80BF26AD3;
	Tue,  2 Apr 2024 22:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="E84EBHY9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29EB71E531;
	Tue,  2 Apr 2024 22:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712097759; cv=none; b=eDqTikItMHGt80/6D5ftrymZ9iAK2cVokzdsUvFpbGC4fRaMgqsqeROzcgJs9JBulJbgqH8/R3Zo/ZWRgteN75Zt9uQPjV/KpaziYy7vbU/fwYX6Op8x/lA40bvhs2OZOXNY23YcdoaMoGEGTULrOYFNs1lnAVcV6CzAjQ8KRk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712097759; c=relaxed/simple;
	bh=76n/dtlrdS4V3B69xGR2/C2+sMIqOX5IJ8MMCJoFQsE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jy+lajzzJGXcHY6Ge3NLY4adydlY+1wGWG5AZzs0yOKzlSY42fP/2X+7q6g4IUY6WLUInPPuY1WqleRiju2JcS+YW52wj5E853AI1KoG2qQpWHLKiukIStvsvOfmbBw3x4WzlrVzEAm1iUJjW4tdnw2a4C/MrO1SCqtgI7p5Yos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=E84EBHY9; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=9vuFRydjFmA3iR+UUnQHu939ajflmP5RxYpQ3S/7QEQ=; b=E84EBHY99VSck8VRb3I+xR7fQ3
	MOhva1SFDx4LcquqPIXb78cVrAuiJ/XZr+ypDL49prxUF9jv5V7KRYCJkx54WLbnYkrLnJDHRF5YU
	voQJIsae1qL9QyTm/6BE0udqedcbzXUyMZw7p4PsoxekPQgDlxlZ9VwZmDAOapcuSjP778b1WnVeE
	DvjhZUou0IYs9ZRuwXrEbW7JYnPGnlAA4pT+bVbjyaqvq5/ao6K97lRwm7bQokmatWc+o7fegbN9a
	hpC/U4c9t0XInAkGopJOxDFZfdLu5KxE3g7QsadDkZXiKyIMcK0WTEImfFaNPexLoYg3aB1n+zzsJ
	1e/Nt3EQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rrmpq-004St9-2e;
	Tue, 02 Apr 2024 22:42:30 +0000
Date: Tue, 2 Apr 2024 23:42:30 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Paul Moore <paul@paul-moore.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Roberto Sassu <roberto.sassu@huaweicloud.com>,
	linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-cifs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Roberto Sassu <roberto.sassu@huawei.com>
Subject: Re: [GIT PULL] security changes for v6.9-rc3
Message-ID: <20240402224230.GJ538574@ZenIV>
References: <20240402141145.2685631-1-roberto.sassu@huaweicloud.com>
 <CAHk-=wgepVMJCYj9s7J50_Tpb5BWq9buBoF0J5HAa1xjet6B8A@mail.gmail.com>
 <CAHk-=wjjx3oZ55Uyaw9N_kboHdiScLkXAu05CmPF_p_UhQ-tbw@mail.gmail.com>
 <20240402210035.GI538574@ZenIV>
 <CAHC9VhSWiQQ3shgczkNr+xYX6G5PX+LgeP3bsMepnM_cp4Gd4g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhSWiQQ3shgczkNr+xYX6G5PX+LgeP3bsMepnM_cp4Gd4g@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Apr 02, 2024 at 05:36:30PM -0400, Paul Moore wrote:

> >         1) location of that hook is wrong.  It's really "how do we catch
> > file creation that does not come through open() - yes, you can use
> > mknod(2) for that".  It should've been after the call of vfs_create(),
> > not the entire switch.  LSM folks have a disturbing fondness of inserting
> > hooks in various places, but IMO this one has no business being where
> > they'd placed it.
> 
> I know it's everyone's favorite hobby to bash the LSM and LSM devs,
> but it's important to note that we don't add hooks without working
> with the associated subsystem devs to get approval.  In the cases
> where we don't get an explicit ACK, there is an on-list approval, or
> several ignored on-list attempts over weeks/months/years.  We want to
> be good neighbors.
> 
> Roberto's original patch which converted from the IMA/EVM hook to the
> LSM hook was ACK'd by the VFS folks.
> 
> Regardless, Roberto if it isn't obvious by now, just move the hook
> back to where it was prior to v6.9-rc1.

The root cause is in the too vague documentation - it's very easy to
misread as "->mknod() must call d_instantiate()", so the authors of
that patchset and reviewers of the same had missed the subtlety
involved.  No arguments about that.

Unkind comments about the LSM folks' tendency to shove hooks in
places where they make no sense had been brought by many things,
the most recent instance being this:
	However, I thought, since we were promoting it as an LSM hook,
	we should be as generic possible, and support more usages than
	what was needed for IMA.
(https://lore.kernel.org/all/3441a4a1140944f5b418b70f557bca72@huawei.com/)

I'm not blaming Roberto - that really seems to be the general attitude
around LSM;  I've seen a _lot_ of "it doesn't matter if it makes any sense,
somebody might figure out some use for the data we have at that point in
control flow, eventually if not now" kind of responses over the years.
IME asking what this or that hook is for and what it expects from the objects
passed to it gets treated as invalid question.  Which invites treating
hooks as black boxes...

