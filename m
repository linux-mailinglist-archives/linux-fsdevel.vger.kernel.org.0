Return-Path: <linux-fsdevel+bounces-8868-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C0D783BE6A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 11:14:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D1D91C25C47
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 10:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C9671CA85;
	Thu, 25 Jan 2024 10:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ajxfyOET"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D9611C69C;
	Thu, 25 Jan 2024 10:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706177644; cv=none; b=lhYNxcdkbv8A6+hPX67U2dAAz5xvDEIVQGJq/1ceTTPCtPRqOoKef+1YJyXzplsAX8vqFg08HFVO9Wd4vbGV7k4e1+mex/ct+DOd6sJSDojkvKRBYaepoHVwRu6oT+GTY+yEkPweqFNh+nSx0b52+VY7FjIlAqPMgIGd1RgEhzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706177644; c=relaxed/simple;
	bh=+OD+Y9qeGpGJEUc0s54y7cQYJlRGrb+Q2kLR40odFVI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WHfrSvq5yY+bZA074wr4LdZ814gLRu4tUmQd1hb+FIljCy64STIt2HaSN0waY18EIWP8lKnO1PCNCcuaxn84tRAC5ERVNmjDtfM9GMcQfnTtCx0U2RbV+eXzIicBraiMnjj3SaHr/Efz1HIeunwh5RHM8qhTa6KnBs6Ng6LTYdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ajxfyOET; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD8D5C433F1;
	Thu, 25 Jan 2024 10:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706177644;
	bh=+OD+Y9qeGpGJEUc0s54y7cQYJlRGrb+Q2kLR40odFVI=;
	h=From:To:Cc:Subject:Date:From;
	b=ajxfyOETqVzrowxjjRnuK8KL2h3lcNvjj3/VzT7wMbO6Ap5eWSoRFh9Zghx4Wagm5
	 +sSqfd/W2OoJ6KTsJCTfZ+cr4ScD9S9MmzHrWMwlmLlKg1bhmrqZz9Vgg61nTqxWgV
	 puDKgO13yVqc4QWrQF8VuhspbeiMmNAP7MauMPLEdGTobK/cJ+E50uGwRnQdHJ2/QR
	 GlLKuDLVeQ5i7r/iZ5kULut/zQPtc1Rd1Wcc/TSfxidy0SBn/x2E2PXRWqRC5eQL5S
	 7gjIrDMbDDOUzUdLGeM7tUthxYs4SYqJ9ij3ijamOUGC7iK0gfuJbOgj2fJ8wgcxeK
	 Cv/d3TrMmOXCA==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] netfs fixes
Date: Thu, 25 Jan 2024 11:13:00 +0100
Message-ID: <20240124-vfs-netfs-fixes-b7ac507f03e9@brauner>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3517; i=brauner@kernel.org; h=from:subject:message-id; bh=iVRj0BiLZKkz/NsZLWhuBLtuTOgDCW7uMZ8GNH6nmz4=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRuMnFZfyxpLkvc6rkL+36rX1L7JSI4+c6zvLmCJhOv+ Xl8sv/L2lHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjAR4SOMDEs/HNpemlbQ/vjF x3NGvK8j10ZrGAlnrH6qYmIXfvADiyHDP8OK8jMnjjmH7vcPC5vDt/NO777XV+vuRVy5nvY84Kn 1YzYA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */
This contains various fixes for the netfs work merged earlier this cycle:

afs
===
* afs: Fix locking imbalance in afs_proc_addr_prefs_show()
* afs: Remove afs_dynroot_d_revalidate() which is redundant
* afs: Fix error handling during lookup
* afs: Hide sillyrenames from userspace
  This fixes a race between silly-rename files being created/removed and
  userspace iterating over directory entries.
* Don't use unnecessary folio_*() functions.

cifs
====
* Don't use unnecessary folio_*() functions.

cachefiles
==========
* erofs: Fix Null dereference when cachefiles are not doing ondemand-mode
* Update mailing list.

netfs library
=============
* Add Jeff Layton as reviewer.
* Update mailing list.
* Fix a error checking in netfs_perform_write().
* fscache: Check error before dereferencing
* Don't use unnecessary folio_*() functions.

/* Testing */
clang: Debian clang version 16.0.6 (19)
gcc: (Debian 13.2.0-7) 13.2.0

All patches are based on v6.8-rc1 and have been sitting in linux-next.
No build failures or warnings were observed.

/* Conflicts */
At the time of creating this PR no merge conflicts were reported from
linux-next and no merge conflicts showed up doing a test-merge with
current mainline.

The following changes since commit 6613476e225e090cc9aad49be7fa504e290dd33d:

  Linux 6.8-rc1 (2024-01-21 14:11:32 -0800)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.8-rc2.netfs

for you to fetch changes up to f13d8f28fe9fb0a4d0a6c21fb3c1577d0eda4ed8:

  Merge branch 'netfs-fixes' of ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs (2024-01-23 16:00:39 +0100)

Please consider pulling these changes from the signed vfs-6.8-rc2.netfs tag.

Thanks!
Christian

----------------------------------------------------------------
vfs-6.8-rc2.netfs

----------------------------------------------------------------
Christian Brauner (1):
      Merge branch 'netfs-fixes' of ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs

Dan Carpenter (2):
      netfs, fscache: Prevent Oops in fscache_put_cache()
      netfs: Fix a NULL vs IS_ERR() check in netfs_perform_write()

David Howells (10):
      netfs, cachefiles: Change mailing list
      netfs: Add Jeff Layton as reviewer
      netfs: Don't use certain unnecessary folio_*() functions
      afs: Don't use certain unnecessary folio_*() functions
      cifs: Don't use certain unnecessary folio_*() functions
      cachefiles, erofs: Fix NULL deref in when cachefiles is not doing ondemand-mode
      afs: Hide silly-rename files from userspace
      afs: Fix error handling with lookup via FS.InlineBulkStatus
      afs: Remove afs_dynroot_d_revalidate() as it is redundant
      afs: Fix missing/incorrect unlocking of RCU read lock

 MAINTAINERS                |  5 +++--
 fs/afs/dir.c               | 30 ++++++++++++++++++++++--------
 fs/afs/dynroot.c           |  9 ---------
 fs/afs/proc.c              |  5 +++--
 fs/cachefiles/ondemand.c   |  3 +++
 fs/netfs/buffered_read.c   | 12 ++++++------
 fs/netfs/buffered_write.c  | 15 ++++++++-------
 fs/netfs/fscache_cache.c   |  3 ++-
 fs/netfs/io.c              |  2 +-
 fs/netfs/misc.c            |  2 +-
 fs/smb/client/file.c       | 10 +++++-----
 include/trace/events/afs.h | 25 +++++++++++++++++++++++++
 12 files changed, 79 insertions(+), 42 deletions(-)

