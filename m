Return-Path: <linux-fsdevel+bounces-24645-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD50E9423C0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jul 2024 02:20:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94B66284EEB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jul 2024 00:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE1D8748F;
	Wed, 31 Jul 2024 00:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F2JQEOlp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C76E4C6E;
	Wed, 31 Jul 2024 00:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722385192; cv=none; b=ucm57QmRQZQY4vvy1FgZ1BKhLqEWyERSRPNuwfb4Xo0FyLfJLHwC07mRKIbaPL3etWNxbBwTzmaEZi2fNu+5GUhSyzljeoIx9G1YWGvJPSYwbtSvJr/WWb3KbuNTTNt3lEz22jyPoP74D+RhAhWXd1oqt9w8KK6omRKih9DDo6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722385192; c=relaxed/simple;
	bh=XS8798meb7b62XTDYeSlTAKZTvCRt5eg3kHo45ma4d0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H1hHNuCZj3j6FWH+v02JPZIhM/pF61UpLBsnWR4LA/BjHIabgkW3qkzHd56rjZi8YLbn9LT7FYKPBcYH3qabVR0xWDiOMoNjgtswD+uccDGAtbV5OCLV/gV+jNSMf9rEmSbYCoJibvWeX2ODcyY8fmdWFYdMpU6gTPP0nCU8gIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F2JQEOlp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DF52C32782;
	Wed, 31 Jul 2024 00:19:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722385191;
	bh=XS8798meb7b62XTDYeSlTAKZTvCRt5eg3kHo45ma4d0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F2JQEOlpNAddu48Uo7ro7hXZsnT2J1AHfmBLud9T/zPSNutpjpg1+4/UGoUZxu9yU
	 Qu4BolfZa19gjIkkSvfRyvLwG+1mnAk7J5jRo+yfgwVHit1UZKCR7yYob58wlv6cwo
	 BJaEhrZ6xz95j+4PGLOjLMPt4Q0l3/hknkqd7FseitYzRxd2Luo/pB/Y60ZsacHYMC
	 Q/ZLolMtQlDsaEpxiKo5pTFQCc1h067568+sSb7A0HkheNqBY/KVSFF0iKyhPeJdzf
	 woefoAi+Q6B/dyjKxCVfrfzeDmfUwyzDrU3iLQUnEntb/78J77miXhv5YXAa3D7cPi
	 B2gFRm5pkDZIA==
Date: Tue, 30 Jul 2024 17:19:50 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Chandan Babu R <chandanbabu@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	xfs <linux-xfs@vger.kernel.org>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>, x86@kernel.org,
	tglx@linutronix.de
Subject: Re: Are jump labels broken on 6.11-rc1?
Message-ID: <20240731001950.GN6352@frogsfrogsfrogs>
References: <20240730033849.GH6352@frogsfrogsfrogs>
 <87o76f9vpj.fsf@debian-BULLSEYE-live-builder-AMD64>
 <20240730132626.GV26599@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240730132626.GV26599@noisy.programming.kicks-ass.net>

On Tue, Jul 30, 2024 at 03:26:26PM +0200, Peter Zijlstra wrote:
> On Tue, Jul 30, 2024 at 01:00:02PM +0530, Chandan Babu R wrote:
> > On Mon, Jul 29, 2024 at 08:38:49 PM -0700, Darrick J. Wong wrote:
> > > Hi everyone,
> > >
> > > I got the following splat on 6.11-rc1 when I tried to QA xfs online
> > > fsck.  Does this ring a bell for anyone?  I'll try bisecting in the
> > > morning to see if I can find the culprit.
> > 
> > xfs/566 on v6.11-rc1 would consistently cause the oops mentioned below.
> > However, I was able to get xfs/566 to successfully execute for five times on a
> > v6.11-rc1 kernel with the following commits reverted,
> > 
> > 83ab38ef0a0b2407d43af9575bb32333fdd74fb2
> > 695ef796467ed228b60f1915995e390aea3d85c6
> > 9bc2ff871f00437ad2f10c1eceff51aaa72b478f
> > 
> > Reinstating commit 83ab38ef0a0b2407d43af9575bb32333fdd74fb2 causes the kernel
> > to oops once again.
> 
> Durr, does this help?

Yes, it does!  After ~8, a full fstests run completes without incident.

(vs. before where it would blow up within 2 minutes)

Thanks for the fix; you can add
Tested-by: Darrick J. Wong <djwong@kernel.org>

--D

> 
> diff --git a/kernel/jump_label.c b/kernel/jump_label.c
> index 4ad5ed8adf96..57f70dfa1f3d 100644
> --- a/kernel/jump_label.c
> +++ b/kernel/jump_label.c
> @@ -236,7 +236,7 @@ void static_key_disable_cpuslocked(struct static_key *key)
>  	}
>  
>  	jump_label_lock();
> -	if (atomic_cmpxchg(&key->enabled, 1, 0))
> +	if (atomic_cmpxchg(&key->enabled, 1, 0) == 1)
>  		jump_label_update(key);
>  	jump_label_unlock();
>  }
> 

