Return-Path: <linux-fsdevel+bounces-40524-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9415AA24591
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Feb 2025 00:03:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 323E51884394
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Jan 2025 23:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3FDC1F426A;
	Fri, 31 Jan 2025 23:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SoANj1i7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E08169397;
	Fri, 31 Jan 2025 23:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738364589; cv=none; b=c0MuSFWYVYc59s7rGABWm+rxsjqw04Eb0JiL4DFsYQLdvqF6qX2VqEQqiam59IctB7uvqH95DHdSsaVHjabNIcDMxCadQQyOOQqMOLyM7ne7pSdZUUqsIGV4BMAPjKEBnYImjmTrtTASylLou0kxJooAHgEAcyH9yr4C7cZAaTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738364589; c=relaxed/simple;
	bh=ECvrADFKO+JO1OIYd7W9HzcU4KYHzpYZYv/Lgir63/c=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Gp/osjsP+dLsnx1aNda/+tGbVm0i9i/TS7msCBWR6Xa28kBkaZw1XWRWlsrZoMXI4IqWWyeSuKjotNSdOeGUK4fSoLpHLUrfI+yCQ/HTk6WLQodBXEmz878cJpDYa1i6K0MeLM4btL0GoYE1O50O42Ve5rtoQd3+T/xFYQqtTRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SoANj1i7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D137C4CED1;
	Fri, 31 Jan 2025 23:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738364588;
	bh=ECvrADFKO+JO1OIYd7W9HzcU4KYHzpYZYv/Lgir63/c=;
	h=Date:From:To:Cc:Subject:Reply-To:From;
	b=SoANj1i7fF/2nxDE3KUxRrsljAaVjBeDTC6LQC4Lb0Ca6b1D1VxAn7836nyKhHk/J
	 zEZZJenMUHFlOLpjny8rzKx0cw4lgaAAbw4E2zk64y51Hyks2oAe5xFUbW1D5+pN9z
	 +iz9/YFG3JWGxZsnYk0Wqy4lFAtu9EFieljY1PA/ELFRFX+2Q/LYOSoAHtV3CWtjl/
	 iKRs3t7RkeRY3nacYj1OfmQstA9EKCWzH8/vX3i9d78e45dVydnXsn4gL64Y4Xfh83
	 hh2JSL/kG+k0Yqn+H4OPsUoreF3jySJsfcwET93X2oPVTwH04s86HVaiZCUHjlZM4Y
	 dcAQm4OLh8aFg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 16203CE37DA; Fri, 31 Jan 2025 15:03:08 -0800 (PST)
Date: Fri, 31 Jan 2025 15:03:08 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: lsf-pc@lists.linux-foundation.org
Cc: bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-block@vger.kernel.org
Subject: [LSF/MM/BPF TOPIC] An SRCU that is faster than RCU Tasks Trace
Message-ID: <dab29bdf-1c33-416d-a5d7-fcc6829a4b60@paulmck-laptop>
Reply-To: paulmck@kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello!

Some recent patches [1] include changes providing srcu_read_lock_fast(),
srcu_read_unlock_fast(), srcu_down_read(), and srcu_up_read(),
which incur about 20% less read-side overhead than RCU Tasks
Trace's rcu_read_lock_trace() and rcu_read_unlock_trace(), as well
as about an order of magnitude less overhead than srcu_read_lock()
and srcu_read_unlock().  In both cases, these performance numbers were
collected using an unrealistic empty-reader benchmark on my laptop.

These new SRCU-fast read-side APIs are likely to be used for uretprobes
[2], but might be useful elsewhere.

The goal of this proposal is to gain additional feedback for SRCU-fast
and to see what other uses it might be put to.  A quick "find" command
locate instances of srcu_read_lock() in the fs, mm, and block subsystems,
so I CCed those lists just in case.  If things go well, I expect these
to go into the v6.15 merge window.

More details and tradeoffs below.

							Thanx, Paul

------------------------------------------------------------------------

SRCU-fast's increased read-side performance does not come for free.
Here are some downsides compared to both RCU Tasks Trace and stock SRCU
(as in the srcu_read_lock() function):

o	SRCU-fast readers are permitted only where rcu_is_watching()
	returns true.

Downsides compared to stock SRCU:

o	In the absence of readers, a synchronize_srcu() having _fast()
	readers will incur the latency of at least two normal RCU grace
	periods.  For purposes of comparison, in the absence of readers,
	an isolated stock SRCU grace period might incur sub-millisecond
	latency.  (However, this latency is artificially increased when
	there are concurrent SRCU grace periods for the same srcu_struct
	in order to limit CPU utilization.)

o	The srcu_read_lock() function returns an int that must be
	passed to the matching srcu_read_unlock(), which is a 32-bit
	quantity.  In contrast, on 64-bit systems srcu_read_lock_fast()
	returns a 64-bit pointer that must be passed to the matching
	srcu_read_unlock_fast().

o	SRCU-fast readers are NMI-safe (as are those of RCU Tasks
	Trace), which means that they incur additional atomic-instruction
	overhead on systems having NMIs but not NMI-safe implementations
	of this_cpu_inc().  These systems are arm, mips, powerpc, sh,
	and sparc.  Note "arm", as in 32-bit.  The 64-bit arm64 systems
	have full-speed SRCU-fast readers.

Downsides compared to RCU Tasks Trace:

o	There are no SRCU CPU stall warnings.  (Some might consider this
	an advantage, at least until they were in a debugging session
	in need of such warnings.)

o	The rcu_read_lock_trace() function is of void type.  In contrast,
	srcu_read_lock_fast() returns a pointer that must be passed to
	the matching srcu_read_unlock_fast().

o	Neither RCU Tasks Trace nor SRCU provide priority boosting,
	in part because boosting a blocked (as opposed to preempted)
	reader is unhelpful.  However, if some use case arose where
	boosting actually made sense, it could be added to RCU Tasks
	Trace more easily (and with less overhead) than to SRCU.

On the other hand, SRCU-fast has a couple of advantages compared to RCU
Tasks Trace:

o	RCU Tasks Trace uses a scheduler hook, and SRCU (whether fast
	or otherwise) needs no such hook.

o	SRCU-fast provides the srcu_down_read_fast() and
	srcu_up_read_fast() functions, which allow entering a read-side
	critical section in one context (for example, task level)
	and exiting it in another (for example, in a timer handler).
	This might not be impossible to provide in RCU Tasks Trace,
	but some thought would be required due to RCU Tasks Trace's
	current reliance on the task_struct structure.

[1] https://lore.kernel.org/all/1034ef54-b6b3-42bb-9bd8-4c37c164950d@paulmck-laptop/
[2] https://lore.kernel.org/all/20240903174603.3554182-1-andrii@kernel.org/

