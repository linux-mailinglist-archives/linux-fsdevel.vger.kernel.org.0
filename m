Return-Path: <linux-fsdevel+bounces-795-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 200C77D0496
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Oct 2023 00:00:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 485171C20F30
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Oct 2023 22:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 431F741A87;
	Thu, 19 Oct 2023 22:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OFtLhVmd";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WY4r1ywq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D6A3FE24
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Oct 2023 22:00:49 +0000 (UTC)
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D683115;
	Thu, 19 Oct 2023 15:00:46 -0700 (PDT)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1697752844;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=o2kQGRnjkpW8NV5UEGIjy6i2Lw5zLDk1wI9xtQ0It5Y=;
	b=OFtLhVmdGAGajfdsQU77o4un/tVAdYcM7cfwt20W9su0nN9zUiglcL5C4pDEb4q88MJzLO
	x5HDKpnT1/1lsSU8vKySCq1RLS7VJye3ei4+VMtw0uCD0w7qgUgZRlBSUcaicBnbHq4OQM
	mqC4nMnW3ootEGH3Z7j1ETk8ZUrXdgmgAMC4DzuoxhllzQY4nnoXxM5gbzdAXXNXSWD5Sa
	lHnIfI/VC1YvapORPfXS8oxP8OeBmd70rwTvUJoTfYU3S+x3sfwVydywAwIgsgZgP0p9N5
	3FVR3vXv1ON8t+fn6QllxjFsOKixj4rzsRVi/dN/W6MmEfKFJhO4iRcGMvCxFA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1697752844;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=o2kQGRnjkpW8NV5UEGIjy6i2Lw5zLDk1wI9xtQ0It5Y=;
	b=WY4r1ywqpIX7pjSgKhtd/YMTG9q7nuDraudwOpgvLzXDgf0mNyLuwtbpuWmgdtYAMHYJV3
	PfofEjkkaGKIMBCg==
To: Jeff Layton <jlayton@kernel.org>, Linus Torvalds
 <torvalds@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, John Stultz <jstultz@google.com>,
 Stephen Boyd <sboyd@kernel.org>, Chandan Babu R <chandan.babu@oracle.com>,
 "Darrick J. Wong" <djwong@kernel.org>, Dave Chinner <david@fromorbit.com>,
 Theodore Ts'o <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>,
 Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, David Sterba
 <dsterba@suse.com>, Hugh Dickins <hughd@google.com>, Andrew Morton
 <akpm@linux-foundation.org>, Amir Goldstein <amir73il@gmail.com>, Jan Kara
 <jack@suse.de>, David Howells <dhowells@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-btrfs@vger.kernel.org, linux-mm@kvack.org,
 linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH RFC 2/9] timekeeping: new interfaces for multigrain
 timestamp handing
In-Reply-To: <20231018-mgtime-v1-2-4a7a97b1f482@kernel.org>
Date: Fri, 20 Oct 2023 00:00:43 +0200
Message-ID: <87o7gu2rxw.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff!

On Wed, Oct 18 2023 at 13:41, Jeff Layton wrote:
> +void ktime_get_mg_fine_ts64(struct timespec64 *ts)
> +{
> +	struct timekeeper *tk = &tk_core.timekeeper;
> +	unsigned long flags;
> +	u32 nsecs;
> +
> +	WARN_ON(timekeeping_suspended);
> +
> +	raw_spin_lock_irqsave(&timekeeper_lock, flags);
> +	write_seqcount_begin(&tk_core.seq);

Depending on the usage scenario, this will end up as a scalability issue
which affects _all_ of timekeeping.

The usage of timekeeper_lock and the sequence count has been carefully
crafted to be as non-contended as possible. We went a great length to
optimize that because the ktime_get*() functions are really hotpath all
over the place.

Exposing such an interface which wreckages that is a recipe for disaster
down the road. It might be a non-issue today, but once we hit the
bottleneck of that global lock, we are up the creek without a
paddle. Well not really, but all we can do then is fall back to
ktime_get_real(). So let me ask the obvious question:

     Why don't we do that right away?

Many moons ago when we added ktime_get_real_coarse() the main reason was
that reading the time from the underlying hardware was insanely
expensive.

Many moons later this is not true anymore, except for the stupid case
where the BIOS wreckaged the TSC, but that's a hopeless case for
performance no matter what. Optimizing for that would be beyond stupid.

I'm well aware that ktime_get_real_coarse() is still faster than
ktime_get_real() in micro-benchmarks, i.e. 5ns vs. 15ns on the four
years old laptop I'm writing this.

Many moons ago it was in the ballpark of 40ns vs. 5us due to TSC being
useless and even TSC read was way more expensive (factor 8-10x IIRC) in
comparison. That really mattered for FS, but does todays overhead still
make a difference in the real FS use case scenario?

I'm not in the position of running meaningful FS benchmarks to analyze
that, but I think the delta between ktime_get_real_coarse() and
ktime_get_real() on contemporary hardware is small enough that it
justifies this question.

The point is that both functions have pretty much the same D-cache
pattern because they access the same data in the very same
cacheline. The only difference is the actual TSC read and the extra
conversion, but that's it. The TSC read has been massively optimized by
the CPU vendors. I know that the ARM64 counter has been optimized too,
though I have no idea about PPC64 and S390, but I would be truly
surprised if they didn't optimize the hell out of it because time read
is really used heavily both in kernel and user space.

Does anyone have numbers on contemporary hardware to shed some light on
that in the context of FS and the problem at hand?

Thanks,

        tglx

