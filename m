Return-Path: <linux-fsdevel+bounces-24674-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DA37942C9E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jul 2024 12:56:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08B97B24A8B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jul 2024 10:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7600D1AC452;
	Wed, 31 Jul 2024 10:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="h+CM5vcR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79CF11AC42F;
	Wed, 31 Jul 2024 10:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722423369; cv=none; b=IGwlQHl1sTNeLNsMohra/BcZcEWqqSNjQQQ0YhCed2ceAeuyUi9oF8Reau7zry4/a6FqGvz/qjt+HhRq9TkMfmL0/pLMb64L2A4TqF2eHDAFot5fDP3sqrMEgRreJQm4l7176mS1Y285uUAN8Se4tN2BEPDhSv4bnd2fzMGIGSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722423369; c=relaxed/simple;
	bh=HK4h1PFqWgIByDXpPjcpyxuXOnL9guHIjO5eOafVgLs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DZR9WpnFbQTdpA/SXVNeBUL6YkNRNzOVRvnA+A20a1HEX/sknnFWsfhMw/d2YkOJWAg4x2wB8q2hy6VPeW0Nxjw7XUIaibaERPsXT92JRRRlQsr4ObgBNzSExDdZZcVj1n8F/7lDhr8u9vmTjgQuxVIHjK8IagZgcDsb31asoUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=h+CM5vcR; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=nxI5JiXjoal3A364js3YMeIq5EhIREJ3YhkGWH1VbfM=; b=h+CM5vcRayI6+QBa/cSQz5xCHm
	PKDRuI5uMx5uFljH1IemEufmdLO6UdSfXWiFdQVXs6SLgNpGCGL19hmP6JUsSrCBc8EQtNPzyQ8Q7
	MFljp6bktgPE7ajtZp5PTlOQ6dE/PtUu5V40foFXDAGdvOvNnOlmePIRc8hjMFoh0KSht1LncExKn
	4zTJU+CkO6ZJ5K9y1mbXXTTZAGm9sIBOzKF8ygGsWnqEhhrKaGxWyFrrhZLFAJJjFDxa4ZboN4dI+
	qODgfU8wVWP/z4hVNCcqBXNe+7o0U2Rl8VBLK7QgDxApYMuvrFytKTgOeN/xJEIPCZ1spg2mlcZTT
	P7nJCAZA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sZ6zu-0000000G1C8-2TvP;
	Wed, 31 Jul 2024 10:55:58 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id A63EB300820; Wed, 31 Jul 2024 12:55:57 +0200 (CEST)
Date: Wed, 31 Jul 2024 12:55:57 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Chandan Babu R <chandanbabu@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	xfs <linux-xfs@vger.kernel.org>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>, x86@kernel.org,
	tglx@linutronix.de
Subject: Re: Are jump labels broken on 6.11-rc1?
Message-ID: <20240731105557.GY33588@noisy.programming.kicks-ass.net>
References: <20240730033849.GH6352@frogsfrogsfrogs>
 <87o76f9vpj.fsf@debian-BULLSEYE-live-builder-AMD64>
 <20240730132626.GV26599@noisy.programming.kicks-ass.net>
 <20240731001950.GN6352@frogsfrogsfrogs>
 <20240731031033.GP6352@frogsfrogsfrogs>
 <20240731053341.GQ6352@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240731053341.GQ6352@frogsfrogsfrogs>

On Tue, Jul 30, 2024 at 10:33:41PM -0700, Darrick J. Wong wrote:

> Sooooo... it turns out that somehow your patch got mismerged on the
> first go-round, and that worked.  The second time, there was no
> mismerge, which mean that the wrong atomic_cmpxchg() callsite was
> tested.
> 
> Looking back at the mismerge, it actually changed
> __static_key_slow_dec_cpuslocked, which had in 6.10:
> 
> 	if (atomic_dec_and_test(&key->enabled))
> 		jump_label_update(key);
> 
> Decrement, then return true if the value was set to zero.  With the 6.11
> code, it looks like we want to exchange a 1 with a 0, and act only if
> the previous value had been 1.
> 
> So perhaps we really want this change?  I'll send it out to the fleet
> and we'll see what it reports tomorrow morning.

Bah yes, I missed we had it twice. Definitely both sites want this.

I'll tentatively merge the below patch in tip/locking/urgent. I can
rebase if there is need.

---
Subject: jump_label: Fix the fix, brown paper bags galore
From: Peter Zijlstra <peterz@infradead.org>
Date: Wed Jul 31 12:43:21 CEST 2024

Per the example of:

  !atomic_cmpxchg(&key->enabled, 0, 1)

the inverse was written as:

  atomic_cmpxchg(&key->enabled, 1, 0)

except of course, that while !old is only true for old == 0, old is
true for everything except old == 0.

Fix it to read:

  atomic_cmpxchg(&key->enabled, 1, 0) == 1

such that only the 1->0 transition returns true and goes on to disable
the keys.

Fixes: 83ab38ef0a0b ("jump_label: Fix concurrency issues in static_key_slow_dec()")
Reported-by: Darrick J. Wong <djwong@kernel.org>
Tested-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/jump_label.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/kernel/jump_label.c
+++ b/kernel/jump_label.c
@@ -236,7 +236,7 @@ void static_key_disable_cpuslocked(struc
 	}
 
 	jump_label_lock();
-	if (atomic_cmpxchg(&key->enabled, 1, 0))
+	if (atomic_cmpxchg(&key->enabled, 1, 0) == 1)
 		jump_label_update(key);
 	jump_label_unlock();
 }
@@ -289,7 +289,7 @@ static void __static_key_slow_dec_cpuslo
 		return;
 
 	guard(mutex)(&jump_label_mutex);
-	if (atomic_cmpxchg(&key->enabled, 1, 0))
+	if (atomic_cmpxchg(&key->enabled, 1, 0) == 1)
 		jump_label_update(key);
 	else
 		WARN_ON_ONCE(!static_key_slow_try_dec(key));

