Return-Path: <linux-fsdevel+bounces-24653-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AF5E9424C6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jul 2024 05:10:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B7271C2296A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jul 2024 03:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 729B417C9B;
	Wed, 31 Jul 2024 03:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="byEVZr6z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C298C14F70;
	Wed, 31 Jul 2024 03:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722395434; cv=none; b=SEHSSN2w5ExJ2BPAdU2ouyt9rIL/rnAsNQPELS1H0noM/+Nstfm4D6GsrM4BMsVC9GIQDCWlZI3qd59hYKAubgVTA1otp7aAXUYh35OLmULV6Y5MECQ7sIAvQaNEWtXeaBCS6Lrm+nBPV/gQwxz4cbb9K32mS5iyl+aqHQ3HmhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722395434; c=relaxed/simple;
	bh=9ie4pLp3pAVOnQPUd20mgzpdOlf8Zbq6IbVvXxhk4kc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i13CH9FetNrwdO//9Lqd4eQPsVFbzGAta8Ajjuh+3+AY7LxlPKpZc1y5nTW2pO7Ihxat3mDmfMkK7O3Ey29QWqSOOiFHuJ42iXr8KbAtHpU5P4v3A4sP3iu3f0oZQsDv7mbKGTmQXrHOGuHTx43PulBbOKmVmpXfT6usRFgs05M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=byEVZr6z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CCF6C4AF0C;
	Wed, 31 Jul 2024 03:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722395434;
	bh=9ie4pLp3pAVOnQPUd20mgzpdOlf8Zbq6IbVvXxhk4kc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=byEVZr6zqOaQqQpmj5yViyLrF4GcyxWSsJSnBY5ZHDISWr1k/jEmzPxlLdIy0/RpJ
	 tPnk600JXLPaiK3XfiqHW3sIt1MRYNqFz3j7weFSqFNlRQOhW0DFCEqV7FcXs/epP8
	 UAz7fCYsKQG1GkYWUfnnilFqKxmEU3t448FtFivYptk5Fe3Uw1vJpl8d7mO/UwqLbV
	 929v5zjMy+cZG1L5EWE7Kj0wLXw0EmzuKHD4rcXbln7borxatAaUIR94F1ZiZgRI8u
	 ZsSVpeA6P/Z/xmeCwZ7xqsMSdQo1r7EtZTpMdnTYFYWOs4v8LzQvRbriEcmYqyRViX
	 QCt62WhT0ydPQ==
Date: Tue, 30 Jul 2024 20:10:33 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Chandan Babu R <chandanbabu@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	xfs <linux-xfs@vger.kernel.org>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>, x86@kernel.org,
	tglx@linutronix.de
Subject: Re: Are jump labels broken on 6.11-rc1?
Message-ID: <20240731031033.GP6352@frogsfrogsfrogs>
References: <20240730033849.GH6352@frogsfrogsfrogs>
 <87o76f9vpj.fsf@debian-BULLSEYE-live-builder-AMD64>
 <20240730132626.GV26599@noisy.programming.kicks-ass.net>
 <20240731001950.GN6352@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240731001950.GN6352@frogsfrogsfrogs>

On Tue, Jul 30, 2024 at 05:19:50PM -0700, Darrick J. Wong wrote:
> On Tue, Jul 30, 2024 at 03:26:26PM +0200, Peter Zijlstra wrote:
> > On Tue, Jul 30, 2024 at 01:00:02PM +0530, Chandan Babu R wrote:
> > > On Mon, Jul 29, 2024 at 08:38:49 PM -0700, Darrick J. Wong wrote:
> > > > Hi everyone,
> > > >
> > > > I got the following splat on 6.11-rc1 when I tried to QA xfs online
> > > > fsck.  Does this ring a bell for anyone?  I'll try bisecting in the
> > > > morning to see if I can find the culprit.
> > > 
> > > xfs/566 on v6.11-rc1 would consistently cause the oops mentioned below.
> > > However, I was able to get xfs/566 to successfully execute for five times on a
> > > v6.11-rc1 kernel with the following commits reverted,
> > > 
> > > 83ab38ef0a0b2407d43af9575bb32333fdd74fb2
> > > 695ef796467ed228b60f1915995e390aea3d85c6
> > > 9bc2ff871f00437ad2f10c1eceff51aaa72b478f
> > > 
> > > Reinstating commit 83ab38ef0a0b2407d43af9575bb32333fdd74fb2 causes the kernel
> > > to oops once again.
> > 
> > Durr, does this help?
> 
> Yes, it does!  After ~8, a full fstests run completes without incident.
> 
> (vs. before where it would blow up within 2 minutes)
> 
> Thanks for the fix; you can add
> Tested-by: Darrick J. Wong <djwong@kernel.org>

Ofc as soon as this I push it to the whole fleet then things start
failing again. :(

> --D
> 
> > 
> > diff --git a/kernel/jump_label.c b/kernel/jump_label.c
> > index 4ad5ed8adf96..57f70dfa1f3d 100644
> > --- a/kernel/jump_label.c
> > +++ b/kernel/jump_label.c
> > @@ -236,7 +236,7 @@ void static_key_disable_cpuslocked(struct static_key *key)
> >  	}
> >  
> >  	jump_label_lock();
> > -	if (atomic_cmpxchg(&key->enabled, 1, 0))
> > +	if (atomic_cmpxchg(&key->enabled, 1, 0) == 1)
> >  		jump_label_update(key);
> >  	jump_label_unlock();
> >  }
> > 
> 

