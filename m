Return-Path: <linux-fsdevel+bounces-24655-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 299EF9425C5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jul 2024 07:33:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B0FC1C231E0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jul 2024 05:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5453249630;
	Wed, 31 Jul 2024 05:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DMTlpjo5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA7451AA3EE;
	Wed, 31 Jul 2024 05:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722404022; cv=none; b=j2C2oiYth0IihSAeHLvC5YQ/0PxZrALcOtMBfufR1tKB6a33DcGhbuEzyXTtCOM9gFHWHI6S0LZikjcwk1q90Xt31YWE9LwhsFBgOodJci+RhB9JIhM4gP9BWUP0G2EIvUWAnbKDX6xxWRF5YLGcRsTcVELtrVnuPQpYfgUFnh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722404022; c=relaxed/simple;
	bh=cIplJEtc1yp2C456R0mbwx1P4JkE7YIn1wl1j8Zp9P4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oSc4Zp69kwXOVanQALSP+jWC4w0N+Wnm9PhnZpfwjQ6O+r5v+C834Ng3OgtxuTbqsJwSbWvlpWy1XImUnjq7hqxFsbGhyo9da12MmeaeergW0dtbDdu2BWw0L0ew+mlU0CjZeeG+TbAtueTL2vfTjTacrrGZTTXilXVw/ZLuAqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DMTlpjo5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D2D7C116B1;
	Wed, 31 Jul 2024 05:33:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722404022;
	bh=cIplJEtc1yp2C456R0mbwx1P4JkE7YIn1wl1j8Zp9P4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DMTlpjo5g8eU1fdLX5KpER+hevXoRzUV2mOPY+eMW2xpaoXs/8S9MrI2Iathlid30
	 ExvyF82GvFWt4S2Zp0NA8wQrL7C+U2V3pJgHKhfmfi9sCENu5yAXNxkTt5QT/THveO
	 ADemdMoMOSybDx4pIwbVLGYKq3x4YrKkyY/tLDjRyGE3yEljVEBlhoafOk87pEzQG9
	 K7PJtk3hBHhrru46h3tJvZ247bZ2cMqy58QWY7BgF+g7Sa7CUpJ70kQPVAu8/oOj4G
	 UeuDVUtZton4JhkShnoRTujPTH4Qc+PQDvjBwPYedLMLmgoztcO+1M6tzqwC5ne16m
	 lhWel/6nj6ezA==
Date: Tue, 30 Jul 2024 22:33:41 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Chandan Babu R <chandanbabu@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	xfs <linux-xfs@vger.kernel.org>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>, x86@kernel.org,
	tglx@linutronix.de
Subject: Re: Are jump labels broken on 6.11-rc1?
Message-ID: <20240731053341.GQ6352@frogsfrogsfrogs>
References: <20240730033849.GH6352@frogsfrogsfrogs>
 <87o76f9vpj.fsf@debian-BULLSEYE-live-builder-AMD64>
 <20240730132626.GV26599@noisy.programming.kicks-ass.net>
 <20240731001950.GN6352@frogsfrogsfrogs>
 <20240731031033.GP6352@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240731031033.GP6352@frogsfrogsfrogs>

On Tue, Jul 30, 2024 at 08:10:33PM -0700, Darrick J. Wong wrote:
> On Tue, Jul 30, 2024 at 05:19:50PM -0700, Darrick J. Wong wrote:
> > On Tue, Jul 30, 2024 at 03:26:26PM +0200, Peter Zijlstra wrote:
> > > On Tue, Jul 30, 2024 at 01:00:02PM +0530, Chandan Babu R wrote:
> > > > On Mon, Jul 29, 2024 at 08:38:49 PM -0700, Darrick J. Wong wrote:
> > > > > Hi everyone,
> > > > >
> > > > > I got the following splat on 6.11-rc1 when I tried to QA xfs online
> > > > > fsck.  Does this ring a bell for anyone?  I'll try bisecting in the
> > > > > morning to see if I can find the culprit.
> > > > 
> > > > xfs/566 on v6.11-rc1 would consistently cause the oops mentioned below.
> > > > However, I was able to get xfs/566 to successfully execute for five times on a
> > > > v6.11-rc1 kernel with the following commits reverted,
> > > > 
> > > > 83ab38ef0a0b2407d43af9575bb32333fdd74fb2
> > > > 695ef796467ed228b60f1915995e390aea3d85c6
> > > > 9bc2ff871f00437ad2f10c1eceff51aaa72b478f
> > > > 
> > > > Reinstating commit 83ab38ef0a0b2407d43af9575bb32333fdd74fb2 causes the kernel
> > > > to oops once again.
> > > 
> > > Durr, does this help?
> > 
> > Yes, it does!  After ~8, a full fstests run completes without incident.
> > 
> > (vs. before where it would blow up within 2 minutes)
> > 
> > Thanks for the fix; you can add
> > Tested-by: Darrick J. Wong <djwong@kernel.org>
> 
> Ofc as soon as this I push it to the whole fleet then things start
> failing again. :(

Sooooo... it turns out that somehow your patch got mismerged on the
first go-round, and that worked.  The second time, there was no
mismerge, which mean that the wrong atomic_cmpxchg() callsite was
tested.

Looking back at the mismerge, it actually changed
__static_key_slow_dec_cpuslocked, which had in 6.10:

	if (atomic_dec_and_test(&key->enabled))
		jump_label_update(key);

Decrement, then return true if the value was set to zero.  With the 6.11
code, it looks like we want to exchange a 1 with a 0, and act only if
the previous value had been 1.

So perhaps we really want this change?  I'll send it out to the fleet
and we'll see what it reports tomorrow morning.

--D

diff --git a/kernel/jump_label.c b/kernel/jump_label.c
index 4ad5ed8adf96..5f80c128e90e 100644
--- a/kernel/jump_label.c
+++ b/kernel/jump_label.c
@@ -289,7 +289,7 @@ static void __static_key_slow_dec_cpuslocked(struct static_key *key)
 		return;
 
 	guard(mutex)(&jump_label_mutex);
-	if (atomic_cmpxchg(&key->enabled, 1, 0))
+	if (atomic_cmpxchg(&key->enabled, 1, 0) == 1)
 		jump_label_update(key);
 	else
 		WARN_ON_ONCE(!static_key_slow_try_dec(key));

