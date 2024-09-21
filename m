Return-Path: <linux-fsdevel+bounces-29791-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3440E97DF84
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 Sep 2024 01:03:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CA831C20B56
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Sep 2024 23:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DD8A3BB25;
	Sat, 21 Sep 2024 23:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rurPnkPF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21DC329406
	for <linux-fsdevel@vger.kernel.org>; Sat, 21 Sep 2024 23:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726959783; cv=none; b=Ic4Xx1tfLPReuFmnAL0RsKQa73lNAxmMG9Q3rg+Vojq4cA+Z/qzLKp1DIWsl1oLQve8lXTTQDtNdvhohNDWtful0Hxx/oZl9mtOtiEwVVQWXTyLtqNBjZxYPk6kRqpv+idBqIYm1iS0NsAFccc0kbKbSzbqxHMUiaXYXu0fousk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726959783; c=relaxed/simple;
	bh=xOHb1+cDcoaugQo2SmeYNgv9ywf2IOExG0eNy6thMD8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=kV9tRz0Nyoaxt87gyBiXc8mtPgqr92+8Rq0FS6fLeeTyVJBjWkUsCaCXoCG+IFM5vg4UN6saaxBDm6ND6hLAQ0l4fR/yFWvZqOPKC6uaIDy0vYH+gcWBThjvydOBQc2BZ6ybKkRC+SCKaqOZeNvemXo7Kn41APlr8izGNrIeaB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rurPnkPF; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sat, 21 Sep 2024 19:02:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1726959778;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=UT7Rox1ZPcS4JOm3wspSy1yWoABHikamMD3mgcBRds4=;
	b=rurPnkPFzQS/5u+BGUPfHRLx54bRJU/72H5iagG+xH0tXRAL1bHxTUCi1q6LsucE/SBAcC
	cKT7sBtQro0O4UDwj7jhh+B/LlybMg93SvfRVAjNGrhOq+RXIDeWuOq/CPjArhny37ZzFQ
	YB0mfWXfKDLkH6LSmixT0vHo4umlzbY=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-xfs@vger.kernel.org
Cc: "Darrick J. Wong" <djwong@kernel.org>, 
	Thomas Bertschinger <tahbertschinger@gmail.com>
Subject: [bcachefs] self healing design doc
Message-ID: <h63p6m5snken2ps7lvnmxmgnjrkzeegprjdweghw4styticya5@obigqaasdwyc>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Migadu-Flow: FLOW_OUT

So, I'm sketching out self healing for bcachefs - that is, repairing
errors automatically, instead of requiring the user to run fsck
manually.

This can be divided up into two different categories, or strategies:

 - Repairing errors/damage as they are noticed in normal operation: i.e.
   follow a backpointer to an extent, notice that there is no extent,
   and then simply delete the backpointer and continue

 - Flagging in the superblock that either there's an unfixed error, or
   that a fsck pass is required, and then running it automatically
   either on next mount or scheduling it for some later time

The first is going to be a big focus in the future, as on larger
filesystems we _really_ want to avoid running full fsck passes unless
absolutely required.

For now though, getting the second mode implemented is higher priority;
we need that so that users aren't having to jump through hoops in order
to get their filesystem working if their root filesystem encounters
corruption - i.e. this is needed before we can take the EXPERIMENTAL
label off.

(I recently had to dig out my nixos recovery usb stick to recovery from
the bug where online fsck was deleting inodes that were unlinked but
still in use - whoops, don't want normal users to have to do that).

Background, things we already have:

- Recovery passes are enumerated, with stable identifiers. This is used
  for upgrades and downgrades: upgrades and downgrades may specify
  recovery passes to run and errors to silently fix, and those are
  listed in the superblock until complete - in case of an interrupted
  upgrade/downgrade.

- fsck errors are also enumerated. This is currently used by the
  superblock 'errors' section, which lists counts and date of last error
  of every error the filesystem has ever seen. This section is purely
  informational (it's highly useful in bug reports) - it doesn't (yet?)
  have fields for whether a given error type has unfixed errors.

Todo items:

- Convert 'bch2_fs_inconsistent()' calls to fsck_err() calls.

  bch2_fs_inconsistent() just goes emergency read-only (or panics, or
  does nothing, according to options). fsck_err() logs the error (by
  type) in the superblock, and returns true/false/error if we should fix
  the error, just continue, or shut down.

  One of the goals here is that any time there's a serious error that
  causes us to go ERO/offline or needs repair, it should be logged in
  the superblock.

  I'm also hoping to get an opt-in telemetry tool written to upload
  superblocks once a week (a bit like debian popcon); since many users
  don't report bugs if they can work around them, this will give us some
  valuable info on how buggy or not buggy bcachefs is in the wild, and
  where to hunt for bugs.

- Add a field to BCH_SB_ERRS() in sb-errors_format.h for which recovery
  pass(es?) are required to fix each error.

New superblock fields for self healing:

The existing sb_ext.recovery_passes_required field that is used for
upgrades/downgrades probably isn't what we want here - some errors need
to be fixed right away, for others we just want to schedule fsck for at
some point in the future.

Q: What determines which errors need to be fixed right away, and should
this get a bit in the superblock? Or is it static per-error-type?

Not sure on this one yet.

Q: In the superblock, should we be listing
 A: unfixed errors, or
 B: recovery passes we need to run (immediately or when scheduled), or
 C: perhaps both

I think we'll be going with option A, which means we can just add a bit
or two to the sb_errors superblock section - this works provided the
sb_err -> recovery passing mapping is static, and I believe the sb_err
enum is fine grained enough that it is.

Once I've added the 'recovery passes to repair' field to BCH_SB_ERRS()
I'll have a better feeling on this.

Thoughts? Corner cases?

