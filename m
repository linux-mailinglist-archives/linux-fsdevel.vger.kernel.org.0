Return-Path: <linux-fsdevel+bounces-50497-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 552C0ACC931
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 16:35:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F18DE3A550C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 14:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF467238C04;
	Tue,  3 Jun 2025 14:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mR8/ZzYv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37FFC1DB366;
	Tue,  3 Jun 2025 14:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748961324; cv=none; b=m+vquiKtwv+o8ve4L5mb6W/vdhSMlUuutrEyTDZonW/q1DGib4LQQYv9cSkCxMXSWOZq3Krp+UzXhN1maA0uxN5IDnJqopEK5GWtyV2ZAvYh2F+VvvmAWgUPUssgkfrEkOBX1Ai9oxIHVh/pL2WBLehFCpcEiGZeTfpXt4c4Ezg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748961324; c=relaxed/simple;
	bh=WvbV4MLj2hDHIwTfK5G9Z90cBJ9vXGQeg4nqcgvJL/k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Li9I9xlXYWCQ9OQjJhZGxRMkXUBrTHboulNMvi5vpgFxDa7z85O0XsFbTzBfNkGVuklCa4xa2Ri0NstB/cez3wLR+kv/Yai0UJLlGjduMW7q87tQjB1fiNAxJno0sslxVvCpcx4ztIW4j4Fm4mP0Vce+h4fyRvk5vRVhBYYJ1EE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mR8/ZzYv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1FA1C4CEED;
	Tue,  3 Jun 2025 14:35:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748961323;
	bh=WvbV4MLj2hDHIwTfK5G9Z90cBJ9vXGQeg4nqcgvJL/k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mR8/ZzYvRyec0atV+PrZd+TNHAHQ3rwW7Hq3OpV72rZLqCqqT5ydwbiNcEenBShn5
	 SVVg9eZX7LZIounPtL39Sk3sCILZ2qLTBpdSwmGP4gPMuonaXOAy32A5kRKmxSIJrK
	 10dX2wCrYTdKEBAz22g0VFGVOPfBV9VfCgNxELdeazJGlxNIxXthzEqFsQZPA6raoh
	 m34SPRxiJasUrn4ooF+ynljOhNFlnXCzu+ofVjYj8zX0XJnwbFS5Hx734u+OgXQQsQ
	 +uX6jSpWiwysxhTkknnjs1hd1jGNpUwWe/xB/BZbnjvnUaK8VxUChREzh8/iJzflYJ
	 uUMBhEka9IR6g==
Date: Tue, 3 Jun 2025 07:35:23 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Yafang Shao <laoar.shao@gmail.com>,
	Christian Brauner <brauner@kernel.org>, cem@kernel.org,
	linux-xfs@vger.kernel.org,
	Linux-Fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [QUESTION] xfs, iomap: Handle writeback errors to prevent silent
 data corruption
Message-ID: <20250603143523.GF8303@frogsfrogsfrogs>
References: <CALOAHbDm7-byF8DCg1JH5rb4Yi8FBtrsicojrPvYq8AND=e6hQ@mail.gmail.com>
 <20250529042550.GB8328@frogsfrogsfrogs>
 <aD03ca6bpbbvUb5X@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aD03ca6bpbbvUb5X@infradead.org>

On Sun, Jun 01, 2025 at 10:32:33PM -0700, Christoph Hellwig wrote:
> On Wed, May 28, 2025 at 09:25:50PM -0700, Darrick J. Wong wrote:
> > Option C: report all those write errors (direct and buffered) to a
> > daemon and let it figure out what it wants to do:
> 
> What value does the daemon add to the decision chain?

The decision chain itself is unchanged -- the events are added to a
queue (if kmalloc doesn't fail) for later distribution to userspace...

> Some form of out of band error reporting is good and extremely useful,
> but having it in the critical error handling path is not.

...and the error handling path moves on without waiting to see what
happens to the queued events.  Once the daemon picks up the event it
can decide what to do with it, but that's totally asynchronous from the
IO path.

--D

