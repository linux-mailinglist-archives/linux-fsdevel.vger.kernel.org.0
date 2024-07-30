Return-Path: <linux-fsdevel+bounces-24609-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EC3F59413C4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2024 15:59:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 765EAB264F7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2024 13:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA26D1A08C2;
	Tue, 30 Jul 2024 13:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RbTcuUvN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E24119FA7B;
	Tue, 30 Jul 2024 13:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722347956; cv=none; b=tNBHx2Xrg9PXGVfYqsf8qhpm3SKDoKGVplI43uTfzHxoHhEECIpCHReIcz+RAHSb3mEBkqBbQJHz+85yg3TULjDD+4swBo67VOk8dUZynCqPgcI9mOXUHoSMMZdDDBZFdIe6tmkTrZDZn0CULXVnIcZ3ByMzLLe69dPDw+T+WMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722347956; c=relaxed/simple;
	bh=v264fgWbZ86U2QYV32HPmK4Z3wqxajv/pDVJ8OFhcf8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nDc+6h5nv/dnPeq4NPL3ovHgx9VmgJheXhiQCmwNcmh6q4HO6BXdA9i5aM+Jwc5C8vqxZznViHoXjqROhgNdQXiQH2gw6Jjew7YuoFRmEnFURovJI46FjC7KMRTuVSvr5VTPf6sNMxHorAeWpowILL9OjI2eKB0h0wdF5h9vyBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RbTcuUvN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE802C32782;
	Tue, 30 Jul 2024 13:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722347955;
	bh=v264fgWbZ86U2QYV32HPmK4Z3wqxajv/pDVJ8OFhcf8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RbTcuUvND6Vh1TUnuLWSSbuSylfTcMx3QwigTqWDVQ0pZcgn58kRpnY/R5hXM3IHU
	 aBRxeNRuWy3cTCcEmtLLqyNu4Xgy+y8yNvKErVj1KmWcN57M3P0fZcACbSr5il7530
	 XMb6Zry53zo7YvdCa0oLVzXvlfDefh5/Y7vlmFdD99pvhWAR5ujHLkZzV4a3+T0B9o
	 YntFVp3Rx4Ng6v6wKhi/Ams6Jer2algTtKpwqe1yasNNR93jgJXuH1HVrDMLicgZeZ
	 3axphw5nGuy4TN4ZmNVLlQk9JWIKc5oKKeh46VsUhQ3G8x6yfNMK4P9KtVNgYAcbVk
	 loTLeW5JT6UvA==
Date: Tue, 30 Jul 2024 06:59:15 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Chandan Babu R <chandanbabu@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	xfs <linux-xfs@vger.kernel.org>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>, x86@kernel.org,
	tglx@linutronix.de
Subject: Re: Are jump labels broken on 6.11-rc1?
Message-ID: <20240730135915.GI6352@frogsfrogsfrogs>
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
> 
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

Ah, because key->enabled can be -1 sometimes?  I'll throw that at the
fstests cloud for a few hours and report back.

--D

>  		jump_label_update(key);
>  	jump_label_unlock();
>  }
> 

