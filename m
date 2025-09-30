Return-Path: <linux-fsdevel+bounces-63120-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 09CDBBAE404
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Sep 2025 19:56:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9458D192397C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Sep 2025 17:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5595125C804;
	Tue, 30 Sep 2025 17:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tqkiA8q+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9C31C860F;
	Tue, 30 Sep 2025 17:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759254994; cv=none; b=bGbOHt+I0ZZdr1TEwMuhXcMOi5QZ+r7FSvlB3+GzywDPQRXTH2Tb4o/a3mgAIWYoJUABRSA2FHDwoddU9vAIJKnqRsYB5ejtsnEP4zAv6NX76kHmeGcYBJPvxQ7Knq3tFljNHxD6n3ML9nCYCSkf8J0PV9R5qJ2zjAB83X0kP4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759254994; c=relaxed/simple;
	bh=rpAqBN6DoV7Aez42y6SIifZ7vtMitRdhOyUJO2U6BtY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DLcX6/MQz2pwcNmuCpyzpRfT9pjVbGZKyRRebqZemK94mzzwZnPCEh6g2weRPToglxZgPT6tJXNG4SBYZay1tpFMKz21GF1of2FQbXcZFF0JAcpV6yf7nMlBy69eEM+Dbh6TmUXpCddFeIFxyszSeGBMIp5koh1sRjLA/qG7rOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tqkiA8q+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31226C4CEF0;
	Tue, 30 Sep 2025 17:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759254994;
	bh=rpAqBN6DoV7Aez42y6SIifZ7vtMitRdhOyUJO2U6BtY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tqkiA8q+LPr4e8LwLaeqOSom8wUeitG454sg9Y43pYLxCL4CmPpvX5DE/u0UHC/c0
	 c+6GpFk+GhzZ/o3VAuN9eFMzT5bNk30kUMep2n+paX5n2yqQ894ptu1ZIbnC5+lOTd
	 PUaHzSUOCEp37Tn/FUTImYxo8vzuAUCCGectlGGx3TCIz/WTjuthmEt1hWcCde6U3q
	 UgpqCc8WIj0vQPgUPSwhffE2ZSoSeWb9ytu4HpFE7C9E70zNPYmJFUYmpUfyi0p7Wr
	 s+2YZ5/+ST+lPoLsc/huwd238hx6etnuG4Ncld7OrIk1/dvHak1MhYtGUQJ4CYlpfE
	 elmFNbJ4MA5qQ==
Date: Tue, 30 Sep 2025 10:56:33 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: bernd@bsbernd.com, linux-xfs@vger.kernel.org, John@groves.net,
	linux-fsdevel@vger.kernel.org, neal@gompa.dev,
	joannelkoong@gmail.com
Subject: Re: [PATCH 2/8] fuse: flush pending fuse events before aborting the
 connection
Message-ID: <20250930175633.GQ8117@frogsfrogsfrogs>
References: <CAJfpegtW++UjUioZA3XqU3pXBs29ewoUOVys732jsusMo2GBDA@mail.gmail.com>
 <20250923145413.GH8117@frogsfrogsfrogs>
 <CAJfpegsytZbeQdO3aL+AScJa1Yr8b+_cWxZFqCuJBrV3yaoqNw@mail.gmail.com>
 <20250923205936.GI1587915@frogsfrogsfrogs>
 <20250923223447.GJ1587915@frogsfrogsfrogs>
 <CAJfpegthiP32O=O5O8eAEjYbY2sAJ1SFA0nS8NGjM85YvWBNuA@mail.gmail.com>
 <20250924175056.GO8117@frogsfrogsfrogs>
 <CAJfpegsCBnwXY8BcnJkSj0oVjd-gHUAoJFssNjrd3RL_3Dr3Xw@mail.gmail.com>
 <20250924205426.GO1587915@frogsfrogsfrogs>
 <CAJfpegshs37-R9HZEba=sPi=YT2bph4WxMDZB3gd9P8sUpTq0w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegshs37-R9HZEba=sPi=YT2bph4WxMDZB3gd9P8sUpTq0w@mail.gmail.com>

On Tue, Sep 30, 2025 at 12:29:30PM +0200, Miklos Szeredi wrote:
> On Wed, 24 Sept 2025 at 22:54, Darrick J. Wong <djwong@kernel.org> wrote:
> 
> > I think we don't want stuck task warnings because the "stuck" task
> > (umount) is not the task that is actually doing the work.
> 
> Agreed.
> 
> I do wonder why this isn't happening during normal operation.  There
> could be multiple explanations:
> 
>  - release is async, so this particular case would not trigger the hang warning

<nod> I confirm that a normal release takes place asynchronously, so
nothing in the kernel gets hung up if ->release takes a long time.

It's only my new code that causes the hang warnings, and only because
it's using the non-interruptible wait_event variant to flush the
requests.

(I /could/ solve the problem differently by calling
wait_event_interruptible in a loop and ignoring the EINTR, but that
seems like a misuse of APIs.)

>  - some other op could be taking a long time to complete (fsync?), but
> request_wait_answer() starts with interruptible sleep and falls back
> to uninterruptible sleep after a signal is received.  So unless
> there's a signal, even a very slow request would fail to trigger the
> hang warning.

Yes, that's what happens if I inject a "stall" into, say, fallocate by
adding a gdb breakpoint on the fallocate handler in fuse4fs.  The xfs_io
process calling fallocate() then just blocks in interruptible sleep
and I see no complaints from the hangcheck timer.  But it's fallocate(),
which is quite interruptible.

Unmount is different -- the kernel has already torn down some of the
mount state, so we can't back out after some sort of interruption.

> A more generic solution would be to introduce a mechanism that would
> tell the kernel that while the request is taking long, it's not
> stalled (e.g. periodic progress reports).
> 
> But I also get the feeling that this is not very urgent and possibly
> more of a test checkbox than a real life issue.

It's probably not an issue for 99% of filesystems and use cases, but
unprivileged userspace can set up the conditions for a stall warning.
Some customers file bug reports for /any/ kernel backtrace, even if it's
a stall warning caused by slow IO, so I'd prefer not to create a new
opening for this to happen.

--D

> 
> Thanks,
> Miklos

