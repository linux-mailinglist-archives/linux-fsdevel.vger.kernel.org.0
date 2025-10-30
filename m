Return-Path: <linux-fsdevel+bounces-66532-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CA3A0C22AFB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Oct 2025 00:19:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 52BC64E11D7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Oct 2025 23:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CD1830F95A;
	Thu, 30 Oct 2025 23:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="MjkRN0eU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47265260587
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Oct 2025 23:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761866331; cv=none; b=sKklyns6hyT7CyCNzO0TF/RK6HOgXSD/ZP4s36go+LHS2ftX9iHjtkzaR4ODOqeR6XJumeWzxaJnqd3bfWQZdG+RmALFRLLDNUnY4io9cdA5SWYyOpcxBufqbd9rQkk3Ic8AbiK7pWgv/nrC9YeZ42yTqVS4LF7QrAHM2tNxIeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761866331; c=relaxed/simple;
	bh=uyIXTX283OC1kScJiq1BmNvAstOmpxdr5HCMuNHi0fQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uh+26xgvEcb2R0WA+YfgUzu6lkTlyynDQuVyqYqhyj19UCj2MT1d3oLcD3qyaqY0ltBAyN3eqHceYT29iEQ3FyBZjcL8SL+f97uIa/rT0wnz74PyzEvTjNGtKT7J+vthvmUGJKeEHK6p7nUHIOeU/CM9J3NtHzNdeVs7luTPGuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=MjkRN0eU; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2951a817541so5628095ad.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Oct 2025 16:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1761866329; x=1762471129; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qCbSBxSr0lLm7sBF21gLzNw2k4fWMvq9RhDFJxnnKCU=;
        b=MjkRN0eUQYCY+pow13wzfHTyaRtLTZMsgpaIePm6uu+qnhlXj3rR535w+YrIxQ28h7
         TLI5cmdgr/ZDpm14ymS20tSuC2us1e0xaVwtFBCYnm2wanpXzlgo/OFSvPN4teLcf/YE
         /of6Mz40YLKckhLZ6V1NxZvGPGN5ttbCAeYsIGHIArq10p+wOOcOJGa9oTeeT4daqwyt
         G2Qhg7IzpEOUwQzT0V+09gZkgduXmCV+IJtrC/hkwYITTCbvwysP79wJFSbNg8Y2Rnh3
         fSFG8tN9e/wjgtIKjQDlK6Y4HzBOyQ8yMLQmL3Cn660PUQx7xKStnYKvtvqDpNB7oC37
         /waQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761866329; x=1762471129;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qCbSBxSr0lLm7sBF21gLzNw2k4fWMvq9RhDFJxnnKCU=;
        b=h+Fjk04JVi4EVVJ6bmm6XfOH/TDGKmpWnfNoYiBSUYH0KPZJzn5p5dmPAkIJ34KP41
         HrkGkXKLam0hLGlQXo9WHNFIPLLprOwDmebr6eOWBICRlkoIAFJ0OcJeVs+EPA4Qe+W3
         Xjo1vF9C/X7cZI+LXAKaY3dT77btLicQmBFw+QJV0kL61MSZwp+i8CcLjsnWATJh9LTJ
         h5HA6oocaghx/ifw82YbK5VCz+G0D9BuGiIR8p/lrLsqxJnKbP3t01Dw0KiJD3nept5L
         kPUP7HGYtGfFVeksDn5LXeQYtSPQqjNgY5LhD4KaDUg8IbI6Qu4DRBwlKpnSWfZEbQJK
         MIvQ==
X-Forwarded-Encrypted: i=1; AJvYcCXfsx0TM8miWAZuorbymLbDFGaM6JuNsw8QEcs91x5yIGvIMxVWZolJH8cfv4sG6lsJkqmN319baMJcYJHz@vger.kernel.org
X-Gm-Message-State: AOJu0Yxvku/bq+li0uBQq93r+OAVsqA5ceIAUKxFeyci3JRvvz7h91fq
	QjxIykbz80MgxM+0zJSvvz1WseO/t3i3iyqD+fWUjGUg6dM/rBx5W2aU3/Oejt+d1CM=
X-Gm-Gg: ASbGncvfaHMq/iiNWeKTZ3QX+h/BmgMzLm5a44DYLAU0qvExZDg0CbBUe/QLY5DxBMu
	vmg+8ztsVUmPxIjVe0rmfcEd2w0ELEaablbKXLNLej6YGo7WOBcnpiLRJfYwKOWW4LhwCHyXNaf
	OWcINS7sL+Lft5POGOnh8tK2FPwn5tTRPmmoiiyU4GQnQ2hpbj4mKJCeEQY6mCAiNJHyDk1hIG0
	lclNbdc3Zz4xE5HL9Xz5NZjAuZEkGXwGlefSQSl7q7fihPa/p/Pka4P5ZEZKM3TeEH3w06V1CdN
	GDBrJowhX6mszpWmrvXTQ+bwg6lZknHQuLD3ftuFBvOYXyx8fMj2S5zSU0gLZEGyAkGhaGu5+Rt
	n56dXU1uj+TtxJbyTCx+oK5gO5V8Nta0XCzFiysZ+7JpfxPOcKH0rx2/MgGt+wfoy5ftP4xx+fR
	CzUv4ifGJeQZzY3jOHNZRmeJuN6nvXi2ArcvPHPibT/7p8iWOIEA0=
X-Google-Smtp-Source: AGHT+IGCGfP0IWbXjpKpFiO2EIcl6d55MTKqgA8ReFs8GKHUG4igFi9rEAY/xEAVF+O7aUhdVIl2Ew==
X-Received: by 2002:a17:902:fc45:b0:295:73f:90db with SMTP id d9443c01a7336-2951a524b7bmr20673395ad.41.1761866329403;
        Thu, 30 Oct 2025 16:18:49 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-58-136.pa.nsw.optusnet.com.au. [49.181.58.136])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2952699cd48sm982535ad.83.2025.10.30.16.18.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 16:18:48 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.98.2)
	(envelope-from <david@fromorbit.com>)
	id 1vEbuo-00000004Ia1-0Gmg;
	Fri, 31 Oct 2025 10:18:46 +1100
Date: Fri, 31 Oct 2025 10:18:46 +1100
From: Dave Chinner <david@fromorbit.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Carlos Maiolino <cem@kernel.org>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-raid@vger.kernel.org,
	linux-block@vger.kernel.org
Subject: Re: fall back from direct to buffered I/O when stable writes are
 required
Message-ID: <aQPyVtkvTg4W1nyz@dread.disaster.area>
References: <20251029071537.1127397-1-hch@lst.de>
 <aQNJ4iQ8vOiBQEW2@dread.disaster.area>
 <20251030143324.GA31550@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251030143324.GA31550@lst.de>

On Thu, Oct 30, 2025 at 03:33:24PM +0100, Christoph Hellwig wrote:
> On Thu, Oct 30, 2025 at 10:20:02PM +1100, Dave Chinner wrote:
> > > use cases, so I'm not exactly happy about.
> > 
> > How many applications actually have this problem? I've not heard of
> > anyone encoutnering such RAID corruption problems on production
> > XFS filesystems -ever-, so it cannot be a common thing.
> 
> The most common application to hit this is probably the most common
> use of O_DIRECT: qemu.  Look up for btrfs errors with PI, caused by
> the interaction of checksumming.  Btrfs finally fixed this a short
> while ago, and there are reports for other applications a swell.

I'm not asking about btrfs - I'm asking about actual, real world
problems reported in production XFS environments.

> For RAID you probably won't see too many reports, as with RAID the
> problem will only show up as silent corruption long after a rebuild
> rebuild happened that made use of the racy data.

Yet we are not hearing about this, either. Nobody is reporting that
their data is being found to be corrupt days/weeks/months/years down
the track.

This is important, because software RAID5 is pretty much the -only-
common usage of BLK_FEAT_STABLE_WRITES that users are exposed to.
This patch set is effectively disallowing direct IO for anyone
using software RAID5.

That is simply not an acceptible outcome here.

> With checksums
> it is much easier to reproduce and trivially shown by various xfstests.

Such as? 

> With increasing storage capacities checksums are becoming more and
> more important, and I'm trying to get Linux in general and XFS
> specifically to use them well.

So when XFS implements checksums and that implementation is
incompatible with Direct IO, then we can talk about disabling Direct
IO on XFS when that feature is enabled. But right now, that feature
does not exist, and ....

> Right now I don't think anyone is
> using PI with XFS or any Linux file system given the amount of work
> I had to put in to make it work well, and how often I see regressions
> with it.

.... as you say, "nobody is using PI with XFS".

So patchset is a "fix" for a problem that no-one is actually having
right now.

> > Forcing a performance regression on users, then telling them "you
> > need to work around the performance regression" is a pretty horrible
> > thing to do in the first place.
> 
> I disagree.  Not corruption user data for applications that use the
> interface correctly per all documentation is a prime priority.

Modifying an IO buffer whilst a DIO is in flight on that buffer has
-always- been an application bug.  It is a vector for torn writes
that don't get detected until the next read. It is a vector for
in-memory data corruption of read buffers.

Indeed, it does not matter if the underlying storage asserts
BLK_FEAT_STABLE_WRITES or not, modifying DIO buffers that are under
IO will (eventually) result in data corruption.  Hence, by your
logic, we should disable Direct IO for everyone.

That's just .... insane.

Remember: O_DIRECT means the application takes full responsibility
for ensuring IO concurrency semantics are correctly implemented.
Modifying IO buffers whilst the IO buffer is being read from or
written to by the hardware has always been an IO concurrency bug in
the application.

The behaviour being talked about here is, and always has been, an
application IO concurrency bug, regardless of PI, stable writes,
etc. Such an application bug existing is *not a valid reason for the
kernel or filesystem to disable Direct IO*.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

