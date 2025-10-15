Return-Path: <linux-fsdevel+bounces-64311-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40ED0BE07E0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Oct 2025 21:42:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 315645E025F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Oct 2025 19:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D483306B37;
	Wed, 15 Oct 2025 19:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vICoOeGk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC89B302CDE;
	Wed, 15 Oct 2025 19:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760556924; cv=none; b=dGGaAlO99Qw9bJHVUDAQtvi58i5Qsbb275CIBGO/dCHkN4A5gTMjIY8IYfV81KuWZBUQ1KYCxH2wJijXAVSSMtrh2/hc4tAq3Y8DWaLQnw/GH1K0pzh+h9ZvvgMahhcR2EM7OAO49w9SPrWzgO0zjhxzqhrWxb5L6MVLAkeAo+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760556924; c=relaxed/simple;
	bh=Ot5wjvwuWw4BR8OvFgKmOuP7sazLgEiE00mi5PvIdqM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fz1fvtGJuxqIrM0JSBH+AEhm3aqwkf9S24l5o2cKkOKpNHusOQgmhS13WrJwFKh6XbnpTP+1MisOqBb2Psa8CT8vSmWjb/xFjBQPIMMXiM/PkwkfdOdKKWPLwliWplryGlCpOWvnYoQJIF5ecBOkgYv5bpfZvskjCK1XE49BRXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vICoOeGk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B458C4CEF8;
	Wed, 15 Oct 2025 19:35:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760556924;
	bh=Ot5wjvwuWw4BR8OvFgKmOuP7sazLgEiE00mi5PvIdqM=;
	h=From:To:Cc:Subject:Date:From;
	b=vICoOeGkVnCMQFOwwdysPG1HSrxO3o6mjw2Q+TUX5DgI4F2lGpx1eXBYCtVvqjS42
	 2gaSwcfpb34xLxEAAgR+OlLNM6i8bKeZOG8vICOdOUHmflEnDN+Y5v2Sft0vZs6ShK
	 y5te77eXgXjIlXaPMgQSF+pmT7NCD7kgxhciV+SNg0al4oqQxdLEz7JtrQEKU41HSQ
	 6Zw34+rCwWv2RBcJ5JRtjyDW4pmtmeWSeADQNyzc5MQzVlArQwFbUva9oGdYyxaEFq
	 3FYoj9FKWX4t/Kshv5Qzb6mQvZSAUpQAW7/4D/DKQSJbMVmjNx6LR2rnqCWqJc+NS2
	 LmtPYHVpY/39Q==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] vfs fixes
Date: Wed, 15 Oct 2025 21:34:58 +0200
Message-ID: <20251014-vfs-fixes-1b72fbe7e505@brauner>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2891; i=brauner@kernel.org; h=from:subject:message-id; bh=Ot5wjvwuWw4BR8OvFgKmOuP7sazLgEiE00mi5PvIdqM=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS8/14wuU8o/PXqxAOtL45qHpq0JOxxh2WjbmDBrtSJ6 zbVpnxS6ihlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjIgbUM/71F814ev7s1zZLl P9f/B29uSEdkcGTmrlnw+FOl/99kYyWG/7F81vcnnJ00W9V4v3Hqxlv3EiyldhecWyPfWKGU93+ JGAMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */

This contains a few fixes for this cycle:

- Handle inode number mismatches in nsfs file handles.

- Update the comment to init_file().

- Add documentation link for EBADF in the rust file code.

- Skip read lock assertion for read-only filesystems when using dax.

- Don't leak disconnected dentries during umount.

- Fix new coredump input pattern validation.

- Handle ENOIOCTLCMD conversion in vfs_fileattr_{g,s}et() correctly.

- Remove redundant IOCB_DIO_CALLER_COMP clearing in overlayfs.

/* Testing */

gcc (Debian 14.2.0-19) 14.2.0
Debian clang version 19.1.7 (3)

No build failures or warnings were observed.

/* Conflicts */

Merge conflicts with mainline
=============================

No known conflicts.

Merge conflicts with other trees
================================

No known conflicts.

The following changes since commit fd94619c43360eb44d28bd3ef326a4f85c600a07:

  Merge tag 'zonefs-6.18-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/dlemoal/zonefs (2025-10-05 20:45:49 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.18-rc2.fixes

for you to fetch changes up to 7933a585d70ee496fa341b50b8b0a95b131867ff:

  ovl: remove redundant IOCB_DIO_CALLER_COMP clearing (2025-10-10 14:02:47 +0200)

Please consider pulling these changes from the signed vfs-6.18-rc2.fixes tag.

Thanks!
Christian

----------------------------------------------------------------
vfs-6.18-rc2.fixes

----------------------------------------------------------------
Andrey Albershteyn (2):
      Revert "fs: make vfs_fileattr_[get|set] return -EOPNOTSUPP"
      fs: return EOPNOTSUPP from file_setattr/file_getattr syscalls

Christian Brauner (2):
      coredump: fix core_pattern input validation
      Merge patch series "Fix to EOPNOTSUPP double conversion in ioctl_setflags()"

Deepanshu Kartikey (1):
      nsfs: handle inode number mismatches gracefully in file handles

Jan Kara (1):
      vfs: Don't leak disconnected dentries on umount

Seong-Gwang Heo (1):
      ovl: remove redundant IOCB_DIO_CALLER_COMP clearing

Tong Li (1):
      rust: file: add intra-doc link for 'EBADF'

Yuezhang Mo (1):
      dax: skip read lock assertion for read-only filesystems

Zhou Yuhang (1):
      fs: update comment in init_file()

 fs/coredump.c          |  2 +-
 fs/dax.c               |  2 +-
 fs/dcache.c            |  2 ++
 fs/exec.c              |  2 +-
 fs/file_attr.c         | 16 ++++++----------
 fs/file_table.c        |  2 +-
 fs/fuse/ioctl.c        |  4 ----
 fs/nsfs.c              |  4 +++-
 fs/overlayfs/copy_up.c |  2 +-
 fs/overlayfs/file.c    |  5 -----
 fs/overlayfs/inode.c   |  5 ++++-
 rust/kernel/fs/file.rs |  4 ++--
 12 files changed, 22 insertions(+), 28 deletions(-)

