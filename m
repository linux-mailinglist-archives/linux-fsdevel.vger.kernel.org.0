Return-Path: <linux-fsdevel+bounces-39570-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EC00A15B00
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Jan 2025 03:06:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0799168EB6
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Jan 2025 02:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8436739FD9;
	Sat, 18 Jan 2025 02:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="L2wQRO+p"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3B7319BBA
	for <linux-fsdevel@vger.kernel.org>; Sat, 18 Jan 2025 02:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737165963; cv=none; b=hk7AKKd4Tjw2nV2XUb7Kuhx4L5+f7qTlfnyZssYBqAe4D1gGsUmTEHTGcePpAy5/EV5+jOF2ZtheJ/LOs/ttOyOXWlcKPAkFEEgvVnu/HwDgzj+6OA9hyumDrwiSLeWm9WgraK57+xOnMO6VbWvlFZxZg539MFRV7zi2of6UoHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737165963; c=relaxed/simple;
	bh=WduCwZ/YbUjFGMLhwABrwEb53vqfDg06rUjrCKtdkaY=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=AkruUbRZF3wQ8N+4sKQEtCcSoZs9cq9nGhL8YMaTX9h2g1N6C0Gx4AxtghharlzEkA24QfiRQ7OK1MpymW3xSJhBteRiA3QvI/6t1Efdnfzky40cd9ouFbjJMf+4UsCSsZGKt4H/xFa0W+V9oY1NALdcRAv1WFGm3EHY9UxCJbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=L2wQRO+p; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 17 Jan 2025 21:05:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1737165948;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=ontvz6SeaYGWwW02H4LE3AqoXc2tWOH62+q3svCfotU=;
	b=L2wQRO+pN7y6JZ18wEwlpUrHfhgAFLB60Q79T/Gu0qCY7GpTNWER+otFgaU1Nflpl72boF
	RzKLcO6K2/WtUQyK73/SB2RC4L6HQXDTmNR76bOiX00G8w4uX55Of4+RkJttYqGKgqlx/R
	gtZecuUT8pR1OkzQRw4jG99N07m/Pk0=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, lsf-pc@lists.linux-foundation.org
Subject: [LSF/MM/BPF TOPIC] bcachefs - how do we get to the next gen
 filesystem we all want - development process
Message-ID: <k4fzyl76mx3nu2em5rhzacdt4wjjvrkbn3hucermeoh7tserwf@zniyzz73lrb2>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Migadu-Flow: FLOW_OUT

First, a short update on develpment:

- Experimental should be coming off in ~6 months. This will mean
  stronger backwards compatibility guarantees (no more forced on disk
  format upgrades) and more backports. The main criteria for taking the
  experimental label off will be going a cycle without any critical bug
  reports, and making sure we have all the critical on disk format
  changes we want (i.e. things that'll be a hassle to fix later).

- Major developments:
  - Next merge window pull request pushes practical scalability limits
    to ~50 PB. With the recent changes to address backpointers fsck, we
    fsck'd a filesystem with 10 PB of data in an hour and a half.

  - Online self healing is now the default, and more and more codepaths
    are being converted so that we can fix errors at runtime that would
    otherwise require fsck to correct.

    The goal is that users should never have to explicitly run fsck -
    even in extreme disaster scenarios - and we're pretty far along.

  - Online fsck still has a ways to go, but the locking issues for the
    main check_allocations pass are nearly sorted so we're past the hard
    technical hurdles. This is a high priority item.

  - Scrub will be landing in the next few weeks, or sooner.

  - Stabilization: "user is not able to access filesystem" bugs reports
    have essentially stopped; fsck is looking quite robust. Overall
    stability going by bug reports and user feedback is shaping up
    quickly.

    We do have reports of outstanding data corruption (nix package
    builders are providing excellent torture testing), and some severe
    performance bugs to address; these are the highest priority
    outstanding items.

    There are good things to report on the performance front: one tidbit
    is that users are reporting that in situations where btrfs falls
    over without nocow mode (databases, bittorrent) bcachefs does fine,
    and "bcachefs doesn't need" nocow is now the common advice to new
    users.

Now that that's out of the way - my plan this year isn't to be talking
about code, but rather development process - and the need to get
organized.

First, we need to talk about the historical track record with filesystem
devolpment. Historically, most filesystem efforts have failed - and we
ought to see what lessons we can learn.

By my count, in the past few decades there have been 3 "next generation"
filesystems that advanced the state of the art and actually delivered on
their goals:
 - XFS
 - ZFS
 - and most recently, APFS

Pointedly, none of these came from the open source community. While I
would give ext3 half credit - it was a pragmatic approach that did
deliver on its goals - the ext4 codebase also showcases some of the
disadvantages of our "community based" approach.

This isn't an open vs. closed source thing, Microsoft also failed with
ntfs replacement; filesystems are hard. If there's a single overarching
diagnosis to be made, I would say the issue is organizational: doing a
filesystem right requires funding a team consistently for many years
with the right kind of long term focus.

The most successful efforts came from the big Unix vendors, when that
was still a thing, and now from Apple, who is known for being able to
organize and support engineering teams.

All this is to say that I'd like for us to be able to set some long term
priorities in the filesystem space, decide what we need to push for, and
figure out how to get it done. The Linux kernel world is not poorly
funded, but efforts don't get funded without a plan, and historically
our filesysystem devolpment has suffered from a short term "project
manager" type focus - a lot of effort being spent on individual highly
niche features for customers with deep pockets, while bread and butter
stuff gets neglected.

-----------------

Here's my list of things we actually do need:

Process, tooling:
-----------------

- Firstly, a filesystem is not just the code itself. It's the tooling,
  the test infrastructure, the time spent working with users who are
  digging in and finding out what works and what doesn't: it is
  _whatever it takes to get the job done_.

  I've often heard talk from engineers who think of tooling as something
  "other people work on", or corporate types who don't want to work with
  users because "that's unpaid user support": but we don't get this done
  without a community, and that includes the _user_ community, and
  developers who aren't kernel developers.

  We need to be leveraging all the resources we have, and we need to be
  bringing the right attitude if we want to deliver the best work we
  can.

  Some specific things that I see still lacking, within the bcachefs
  world and the filesystem world as a whole:

  - Our testing automation still needs to be better. I've built
    developer focused testing automation, but it still needs work and I
    could use help.

    - We badly need automated performance testing. I still see people at
      the bigcorps doing performance testing manually, and what
      automated performance testing their is lives in the basements of
      certain engineers. This needs to be a standard thing we're all
      using.

    - Code coverage analysis needs to be a standard thing we're all
      looking at - it should be something we can trivially glance at
      when we're doing code review.

      (If anyone wants to help with this one, there's some trivial
      makefile work that needs to happen and my test infrastructure has
      the rest implemented).

    - bcachefs still needs real methodical automated error injection
      testing (I know XFS has this, props to them); we won't be able to
      consider fsck rock solid until this is done.

Technical milestones:
---------------------

bcachefs has achieved nearly all of the critical technical milestones
I've laid out - or they're far enough along that we're past the "how
well will this work" uncertainty. But here's my criteria for any major
next gen filesystem:

- Check/repair:

  Contrary to what certain people have voiced about "filesystems that
  don't need fsck", fsck will _always_ be a critical component of any
  filesystem - shit happens, and we need to be able to recover, and
  check if the system is in a consistent state (else many bugs will go
  undiscovered).

  Data loss is flatly unacceptable in any filesystem suitable for real
  usage: I do not care what happened or how a filesystem was corrupted,
  if there is data still present it is our job to recover it and get the
  system back to a working state.

  Additionally, fsck is _the_ scalability limitation as systems continue
  to grow. Inherently so, as there are many global invariants/references
  to be checked.

  As mentioned, bcachefs is now well into the petabyte range, which
  should be good for a bit - for most users. Long term, we're going to
  need allocation groups so that we can efficiently shard the main fsck
  passes; allocation groups will get bcachefs into the exabyte range.

- Self healing, online fsck:

  Having the filesystem be offline for check/repair is also becoming a
  non-option, so anything that can be repaired at runtime must be - and
  we need to have mechanisms for getting the system up and running in RW
  mode and doing fsck online even when the filesystem is corrupt.

  (bcachefs has this covered, naturally).

- Scalability

  Besides just the size of the dataset itself, large systems with large
  numbers of drives and complex topologies need to be supported. These
  systems exist, and today the methods of managing those large number of
  drives are lacking; we can do better.

- Versioning, upgrade and downgrade flexibility and compatibility w.r.t.
  on disk format.

  A common complaint from users is being stuck on an old on disk format
  version, without even being aware, and being subject to bugs/issues
  which have been long since fixed.

  We need a better story for on disk format changes. bcachefs also has
  this one covered; while in the experimental phase we've been making
  extensive use of our ability to roll out new on disk format versions
  automatically and seamlessly _and still support downgrades_.

- Real database fundamentals.

  Filesystems are databases, and if we steal as much as possible of the
  programming model from the database world it becomes drastically
  easier to roll out features and improvements; our code becomes more
  flexible and compatibility becomes much easier.

What do people want, and how do we get organized?
-------------------------------------------------

This part will be dependent on participation, naturally. It's all up to
us, the engineers :)

I'm hoping to get more community involvement from developers this year.
I want to see this thing be as big a success as it deserves to be, and I
want users to have something they can depend on - peace of mind.

And I want this filesystem to be a place where people can bring their
best ideas and see them to fruition. There's still interesting research
to be done and interesting problems to be solved.

Let's see what we can make happen...

