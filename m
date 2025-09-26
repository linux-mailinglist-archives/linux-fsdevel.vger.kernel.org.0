Return-Path: <linux-fsdevel+bounces-62890-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 58CD7BA41EA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Sep 2025 16:22:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AAA21C057FA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Sep 2025 14:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16CA4225A23;
	Fri, 26 Sep 2025 14:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M8z27/7F"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B92922370A;
	Fri, 26 Sep 2025 14:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758896362; cv=none; b=nd8KRSFppRntKK2QIhNqUShfjyX/ekFch4lr0cRhHw3+ZG+W8xn/HHmJjQBfbfAfILs+4AHTz4PWvQG72+juHXtAKLZ5GMNReETkWbl4fay71weaetRQbt2l6xrwuKs4E+FofqZKQJcCFpAwf62XQDqTt3Sdv8HnbgIa9dhDs1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758896362; c=relaxed/simple;
	bh=XeTbymUH5OZzjpFDb3Jw5CzV+JA2yMMbfsINbt8ijnk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=icCnR3n63KUgzeCjuVHy+oKfv/1l5cbENDgq1s0/R5t/wvZzOv9w/1QONzo4N5ZjjwbKIR+w8uq8q+GhuQaKQEde8Ec+aodxxhr8Lghbl/6o8t5V83oPG7acPGzp7RBAzG0qfCh6I7rniPqPkjT5+RnykKZY/BOFiQZvH9IbZNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M8z27/7F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0BCCC113CF;
	Fri, 26 Sep 2025 14:19:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758896361;
	bh=XeTbymUH5OZzjpFDb3Jw5CzV+JA2yMMbfsINbt8ijnk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M8z27/7FjH1eoFd0j/ORU/UcDx/T5i8AtT29Wtce2ZSeR7r33+kkVQLknOoWo/1ZL
	 1x9q8/gNrcXkJosx9o+mOQll/M59PRaAETTSnvm9zGiA1pR7GrT4wLoGmolytJzvWB
	 aNGglqFIVOu/dhuewRmR9U1oZtdKkZLI/j+3ZIpR82p8HKJvCiOMrmmwtZlhKgOgJN
	 SSBBQ79F2lbJ7PX4fTbwbeFFq/czwsqii2ReSfZ/725F1w1NhC0hQVLTkI1lL9aWjx
	 6B4x/sUv435TDX06sjSt0jejUxKDo+uyDydxycIQDnx3IzCb1eQbc+p1Kl7dyBrQT9
	 Ey/zuQuxi+jUw==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL 11/12 for v6.18] writeback
Date: Fri, 26 Sep 2025 16:19:05 +0200
Message-ID: <20250926-vfs-writeback-dc8e63496609@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250926-vfs-618-e880cf3b910f@brauner>
References: <20250926-vfs-618-e880cf3b910f@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3665; i=brauner@kernel.org; h=from:subject:message-id; bh=XeTbymUH5OZzjpFDb3Jw5CzV+JA2yMMbfsINbt8ijnk=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRcW3Ax/KXv1gUmmRcX6fbOifqd0v2kYGbJVTeZ/yVci isLObe5dZSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAExk0j6Gv0JlKxOeHjJ1ktnD l+MuxcyifnGllNXrH0cfNrTu4dr9cALD/5g/5cHHtske2zG15/H64r6aL9rCNerHSiJVj1+Jlnm dzwEA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */
This contains work adressing lockups reported by users when a systemd
unit reading lots of files from a filesystem mounted with the lazytime
mount option exits.

With the lazytime mount option enabled we can be switching many dirty
inodes on cgroup exit to the parent cgroup. The numbers observed in
practice when systemd slice of a large cron job exits can easily reach
hundreds of thousands or millions.

The logic in inode_do_switch_wbs() which sorts the inode into
appropriate place in b_dirty list of the target wb however has linear
complexity in the number of dirty inodes thus overall time complexity of
switching all the inodes is quadratic leading to workers being pegged
for hours consuming 100% of the CPU and switching inodes to the parent wb.

Simple reproducer of the issue:

  FILES=10000
  # Filesystem mounted with lazytime mount option
  MNT=/mnt/
  echo "Creating files and switching timestamps"
  for (( j = 0; j < 50; j ++ )); do
      mkdir $MNT/dir$j
      for (( i = 0; i < $FILES; i++ )); do
          echo "foo" >$MNT/dir$j/file$i
      done
      touch -a -t 202501010000 $MNT/dir$j/file*
  done
  wait
  echo "Syncing and flushing"
  sync
  echo 3 >/proc/sys/vm/drop_caches

  echo "Reading all files from a cgroup"
  mkdir /sys/fs/cgroup/unified/mycg1 || exit
  echo $$ >/sys/fs/cgroup/unified/mycg1/cgroup.procs || exit
  for (( j = 0; j < 50; j ++ )); do
      cat /mnt/dir$j/file* >/dev/null &
  done
  wait
  echo "Switching wbs"
  # Now rmdir the cgroup after the script exits

This can be solved by:

* Avoiding contention on the wb->list_lock when switching inodes by
  running a single work item per wb and managing a queue of items
  switching to the wb.

* Allow rescheduling when switching inodes over to a different cgroup to
  avoid softlockups.

* Maintain b_dirty list ordering instead of sorting it.

/* Testing */

gcc (Debian 14.2.0-19) 14.2.0
Debian clang version 19.1.7 (3+b1)

No build failures or warnings were observed.

/* Conflicts */

Merge conflicts with mainline
=============================

No known conflicts.

Merge conflicts with other trees
================================

No known conflicts.

The following changes since commit 8f5ae30d69d7543eee0d70083daf4de8fe15d585:

  Linux 6.17-rc1 (2025-08-10 19:41:16 +0300)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.18-rc1.writeback

for you to fetch changes up to 9426414f0d42f824892ecd4dccfebf8987084a41:

  Merge patch series "writeback: Avoid lockups when switching inodes" (2025-09-19 13:11:06 +0200)

Please consider pulling these changes from the signed vfs-6.18-rc1.writeback tag.

Thanks!
Christian

----------------------------------------------------------------
vfs-6.18-rc1.writeback

----------------------------------------------------------------
Christian Brauner (1):
      Merge patch series "writeback: Avoid lockups when switching inodes"

Jan Kara (4):
      writeback: Avoid contention on wb->list_lock when switching inodes
      writeback: Avoid softlockup when switching many inodes
      writeback: Avoid excessively long inode switching times
      writeback: Add tracepoint to track pending inode switches

 fs/fs-writeback.c                | 133 +++++++++++++++++++++++++--------------
 include/linux/backing-dev-defs.h |   4 ++
 include/linux/writeback.h        |   2 +
 include/trace/events/writeback.h |  29 +++++++++
 mm/backing-dev.c                 |   5 ++
 5 files changed, 126 insertions(+), 47 deletions(-)

