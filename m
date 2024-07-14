Return-Path: <linux-fsdevel+bounces-23648-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E5DC930C2F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jul 2024 01:35:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18FE02814B7
	for <lists+linux-fsdevel@lfdr.de>; Sun, 14 Jul 2024 23:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 661CE14036F;
	Sun, 14 Jul 2024 23:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Nhnwb4Ty"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D6713B5B7
	for <linux-fsdevel@vger.kernel.org>; Sun, 14 Jul 2024 23:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721000127; cv=none; b=fxIHyr7B4mddCRpYJl2vY6J+FLfrQugdkLN36Ori3GLiPVIEOLxZhkhQqR8KVEz575z0bHf07paxxSkDZlFmr33UqMRgOFy3f1r1tzJ2E5vmAi1P/MDs0MGNJM4guBLTkXiAegYGMbeIfb4syNmywiPCk4thq4af3r8hmpBvwZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721000127; c=relaxed/simple;
	bh=A8ExdULMTTEa/hIL0jxZHs1/eGFW6CgkIL183rgw7SU=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=q61DpwBbOCnnccft8qBzZ1kJXwLITeXeq48YXQSskIRn5W9Nd7aP1AdLKecPdiZuH0LVDLk3cGOPhCOelUHJgSoe+oyNWGS7KBpsNfdWpUYHYMvBnhr9A8o8tkUx0uXNx5OxpGiiKSgsKSIURQYULlB0nR9pimvy0Qahy9xBYhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Nhnwb4Ty; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: linux-fsdevel@vger.kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1721000122;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=/deZcosMIiR4fSksbjwDZ5A1olvy8pXsietjMa6AtJs=;
	b=Nhnwb4TyIcK6QZOf+zCWrH3gLbo1WcXLbr5I7NU7DBuAajSBH3ZMxHNB/oFOtEEgSnFvMA
	LZ8/0rmdrDNGtUsl97MMYHD3UYcrdddc2lvt9bNQ86nFKn4lJY0RDjLZKZJzl7Gmb/ZBNL
	Ph9sn9P7MmPLlMdyiOKCWHxWUSKMgRw=
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: fstests@vger.kernel.org
X-Envelope-To: linux-btrfs@vger.kernel.org
X-Envelope-To: linux-xfs@vger.kernel.org
X-Envelope-To: linux-ext4@vger.kernel.org
Date: Sun, 14 Jul 2024 19:35:18 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	fstests@vger.kernel.org, linux-btrfs@vger.kernel.org, linux-xfs@vger.kernel.org, 
	linux-ext4@vger.kernel.org
Subject: Shared test cluster for filesystem testing
Message-ID: <o55vku65ruvtvst7ch4jalpiq4f5lbn3glmrlh7bwif6xh6hla@eajwg43srxoj>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Migadu-Flow: FLOW_OUT

Those who know me have oft heard me complain about the state of testing
automation and infrastructure, in filesystem land and the wider kernel.
In short - it sucks.

For some years I've been working, off and on, on my own system off and
on, and I think I've got it to the point where I can start making it
available to the wider filesystem community, and I hope it will be of
some use to people.

Here's my philosophy and requirements:

- Tests should be done with results up in a dashboard _as quickly as
  possible_

Nothing's worse than having to wait hours, overnight, or days for test
results - by which time you've context switched onto something else. I
want full test results in 10 minutes.

- Every commit gets tested, and the results are available in a git log
  view.

Manual bisection is a timesuck, and every commit should be tested
anyways. I want to be able able to churn out code in nice clean simple
commits, push it all out to the CI, and when one of them is broken, be
able to see at a glance which one it is.

- Simple and extensible, and able to do any kernel testing that can be
  done in a VM.

kdevops is right out - all the stateful ansible crap is not what I'm
after. Simple and declarative tests that specify how the kernel, qemu
etc. should be configured.

- Available to all developers and maintainers

Maintainers shouldn't be looking at patches that haven't been tested.
Everyone doing filesystem development needs access to this
system, on whatever branches they're working on.

IOW: big cluster of machines watching git branches and uploading results
to a dashboard, with sharding at subtest granularity so we can get
results back _quick_.

I've got 8 80 core arm machines for this so far. We _will_ need more
machines than this, and I'll need funding to pay for those machines, but
this is enough to get started.

A shared cluster of dedicated machines with full sharding means that us
individual developers can get results back _quick_. The CI tests each
branch, newest to oldest, and since we're not all going to be pushing at
the same time, or need the lockdep/kasan variants right away (those run
at a lower priority) - we can all get the results we need (most recent
commit, basic tests) pretty much immediately.

I've got fstests tests wrappers for bcachefs, btrfs, ext2, ext4, f2fs,
jfs, nfs, nilfs2 and xfs so far, with lockdep, kasan and ubsan variants
for all of those.

The tests the CI runs are easy to run locally, for reproducability -
ktest was first written for local, interactive use. I suggest you try
it, it's slick [0]:

Send me an email with your ssh pubkey and the username you want, and
I'll give you an account - this is how you'll configure your config file
that specifies which tests to run and which branches to test.

And please send me patches to ktest adding tests for more filesystems
and subsystems. This isn't intended to be filesystem specific - the goal
here is one single _quick_ dashboard for anything that can be tested in
a VM.

Results dashboard:
https://evilpiepirate.org/~testdashboard/ci

Results for Linus's tree:
https://evilpiepirate.org/~testdashboard/ci?branch=master

[0] Ktest: https://evilpiepirate.org/git/ktest.git/

