Return-Path: <linux-fsdevel+bounces-50984-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49736AD1976
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 10:00:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A9FB3AA4C8
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 07:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4859A2820AD;
	Mon,  9 Jun 2025 08:00:08 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A5E228151A
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Jun 2025 08:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749456007; cv=none; b=qhRjkXEmXXLn0bHigHemGREUuTdNATDb8i17TGSaLgUQRY6kakK9GBEkhOjkj1pG1lcX3zVW7QzKF5yHxaC4A3Hg6aPe/I189SX55l/ZZWpqedzQ90DCwoYwJ6kLjtwpBbczSwT8NxoZtxlVPBxkkCVIdw4JJCIzN2YqgaD9P1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749456007; c=relaxed/simple;
	bh=i/IHnyFaXyP66RZ6PnM+/wYICE/rMSw3+CGrwHMiDnI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X3VEbvxXoJWrhu6lgg3FioviOH7LZ6Vuf9oyj14spsyxeDqdDQsrwTQYNTGFmJvS1xw43M///t2zCo8xj+kyHsnD3pURD6tF8ivn5/ak2k7sPpLl/cx9lFnhN8jJM0L0lF7+p+sjPx++Fpuw7hmYKOLGrmqIWM8Y0FRNn+qEF1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1uOXQI-006HTU-Ae;
	Mon, 09 Jun 2025 08:00:02 +0000
From: NeilBrown <neil@brown.name>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org
Subject: [PATCH 0/8 preview] demonstrate proposed new locking strategy for directories
Date: Mon,  9 Jun 2025 17:34:05 +1000
Message-ID: <20250609075950.159417-1-neil@brown.name>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patches are still under development.  In particular some proper
documentation is needed.  They are sufficient to demonstrate my design.

They add an alternate mechanism for providing the locking that the VFS
needs for directory operations.  This includes:
 - only one operation per name at a time
 - no operations in a directory being removed
 - no concurrent cross-directory renames which might result in an
    ancestor loop

I had originally hoped to push the locking of i_rw_sem down into the
filesystems and have the new locking on top of that.  This turned out to
be impractical.  This series leave the i_rw_sem locking where it is,
introduces new locking that happens while the directory is locked, and
gives the filesystem the option of disabling (most of) the i_rw_sem
locking.  Once all filesystems are converted the i_rw_sem locking can be
removed.

Shared lock on i_rw_sem is still used for readdir and simple lookup, to
exclude it while rmdir is happening.

The problem with pushing i_rw_sem down is that I still want to use it to
exclude readdir while rmdir is happening.  Some readdir implementations
use the result to prime the dcache which means creating d_in_lookup()
dentries in the directory.  If we can do this while holding i_rw_sem,
then it is not safe to take i_rw_sem while holding a d_in_lookup()
dentry.  So i_rw_sem CANNOT be taken after a lookup has been performed -
it must be before, or never.

Another issue is that after taking i_rw_sem in rmdir() I need to wait
for any dentries that are still locked.  Waiting for the dentry lock
while holding i_rw_sem means we cannot take i_rw_sem after getting a
dentry lock.

So we take i_rw_sem for filesystems that still require it (initially
all) but still do the other locking which will be uncontended.  This
exercises the code to help ensure it is ready when we remove the
i_rw_sem requirement for any given filesystem.

The central feature is a per-dentry lock implemented with a couple of
d_flags and wait_var_event/wake_up_var.  A single thread can take 1,
sometimes 2, occasionally 3 locks on different dentries.

A second lock is needed for rename - we lock the two dentries in
address-order after confirming there is no hierarchical relationship.
It is also needed for silly-rename as part of unlink.  In this case the
plan is for the second dentry to always be a d_in_lookup dentry so the
lock is guaranteed to be uncontented.  I'm not sure I got that finished
yet.

The three-dentry case is a rename which results in a silly-rename of the
target.

For rmdir we introduce S_DYING so that marking a directory a S_DEAD is
two-stage.  We mark is S_DYING which will prevent more dentry locks
being taken, then we wait for the locks that were already taken, then
set S_DEAD.

For rename ...  maybe just read the patch.  I tried to explain it
thoroughly.

The goal is to perform create/remove/rename without any mutex/semaphore
held by the VFS.  This will allow concurrent operations in a directory
and prepare the way for async operation so that e.g.  io_uring could be
given a list of many names in a directory to unlink and it could unlink
them in parallel.  We probably need to make changes to the locking on
the inode being removed before this can be fully achieved - I haven't
explored that in detail yet.

Thanks,
NeilBrown



