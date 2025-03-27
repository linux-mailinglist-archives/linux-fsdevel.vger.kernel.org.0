Return-Path: <linux-fsdevel+bounces-45174-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F372EA7406B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Mar 2025 22:46:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C164B3ABA19
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Mar 2025 21:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 698B11DDA3D;
	Thu, 27 Mar 2025 21:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PbrjDgJ4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A42AF8462;
	Thu, 27 Mar 2025 21:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743112006; cv=none; b=ow7SO+T/Kk7cWB87dtzNQtY7XcNf7Hc0V/pxL5Fj5/TRTNnG6FYMmTWxMwrqTMQxHAJbbL+zwcEftedbkqI1/czCh+2O/EOy2YiV0LTUOyAt6LqrfBzLcCdyXINTKBr5J4kgxCIie3vWqWsAV+NTJkxojlfMZx+gx3aSz/nci3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743112006; c=relaxed/simple;
	bh=044NMnypJBKDHzV54PkNfkWM1PAfOVt5sNmhyUdaFz8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JaNkzehRHK+8F1f4WcLOb4rM2SHWrEUa/WeggmBc5f4nvouESylVw0FZaXHGBhjBK0RMoYyC+spuibiRqFOxK2QxFNzq6jwbyoxytyEg2XM6sjnoIOuSG+ciS1FJw//6+ev0xypFpm5mNyGzCbkdE/oWoBrQkx3vAoeVD2K4/FU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PbrjDgJ4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D4EFC4CEDD;
	Thu, 27 Mar 2025 21:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743112006;
	bh=044NMnypJBKDHzV54PkNfkWM1PAfOVt5sNmhyUdaFz8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PbrjDgJ4+NfAozJ7lqUyl/lBGtxzqX4FdqXvsbkLlWVlzKiNBfvv149fKViJAbrER
	 5CtC9il1MqDLyz8I+p1kXiPFoz/CM9Nhcz/IX3D4UQSkykxPycZSr9Pi7jpc660yUL
	 V6UyTrNzKm1mzyTeNkpZsi+y7JCsoe1BvdEWYlTU5niHpJ1/r4mogyHZJZvWD+VuUV
	 xO8+ZystdjlkOMfDt9ox3odkNMIpmJ+5CdmMH7QpGTbv0AJ4aho7RMV+6L/Cl+c2WA
	 TZV0g/0RPt5SvtM/IdTaZxRlNVhyJSy48fNnsreUpmVUtNBrTvwejGc7HOZfnXi5jU
	 zhyBn2nGlwvyg==
Date: Thu, 27 Mar 2025 14:46:44 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Dave Chinner <david@fromorbit.com>
Cc: lsf-pc@lists.linux-foundation.org, patches@lists.linux.dev,
	fstests@vger.kernel.org, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	oliver.sang@intel.com, hannes@cmpxchg.org, willy@infradead.org,
	jack@suse.cz, apopple@nvidia.com, brauner@kernel.org, hare@suse.de,
	oe-lkp@lists.linux.dev, lkp@intel.com, john.g.garry@oracle.com,
	p.raghav@samsung.com, da.gomez@samsung.com, dave@stgolabs.net,
	riel@surriel.com, krisman@suse.de, boris@bur.io,
	jackmanb@google.com, gost.dev@samsung.com
Subject: Re: [LSF/MM/BPF Topic] synthetic mm testing like page migration
Message-ID: <Z-XHRAgL0u2qO7LH@bombadil.infradead.org>
References: <Z-ROpGYBo37-q9Hb@bombadil.infradead.org>
 <Z-Rni3UhAF4RB7AY@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z-Rni3UhAF4RB7AY@dread.disaster.area>

On Thu, Mar 27, 2025 at 07:46:03AM +1100, Dave Chinner wrote:
> On Wed, Mar 26, 2025 at 11:59:48AM -0700, Luis Chamberlain wrote:
> > I'd like to propose this as a a BoF for MM.
> > 
> > We can find issues if we test them, but some bugs are hard to reproduce,
> > specially some mm bugs. How far are we willing to add knobs to help with
> > synthetic tests which which may not apply to numa for instance? An
> > example is the recent patch I just posted to force testing page
> > migration [0]. We can only run that test if we have a numa system, and a
> > lot of testing today runs on guests without numa. Would we be willing
> > to add a fake numa node to help with synthetic tests like page
> > migration?
> 
> Boot your test VMs with fake-numa=4, and now you have a 4 node
> system being tested even though it's not a real, physical numa
> machine.  I've been doing this for the best part of 15 years now
> with a couple of my larger test VMs explicitly to test NUMA
> interactions.

Suuuuweet! Given your long term use of it, we'll just make it a default
for all kdevops libvirt testing now!

> One of the eventual goals of check-parallel is to have all these
> things environmental variables like memory load, compaction, cpu
> hotplug, etc to be changing in the background whilst the tests
> running so that we can exercise all the filesystem functionality
> under changing MM and environmental conditions without having to
> code that into individual tests....

Indeed, I have high hopes for check-parallel.

  Luis

