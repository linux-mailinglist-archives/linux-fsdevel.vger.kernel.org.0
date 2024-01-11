Return-Path: <linux-fsdevel+bounces-7786-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D4D2A82ABC5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jan 2024 11:17:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5C691C23A9F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jan 2024 10:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 561F912E67;
	Thu, 11 Jan 2024 10:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="TcqZHhxj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FFB7125DA
	for <linux-fsdevel@vger.kernel.org>; Thu, 11 Jan 2024 10:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=RvA3hJ1Q60vBxi593EG/eSYgOlDKvT1i8FSS//qLtV4=; b=TcqZHhxjvHs3BRqKyK38gtFjnG
	i1+ZkSB8cFQtJVGdJPSncKp2qseluQDVLPT2RGmSnAjpCQHAbIHw+TtqerjIjPzSa2JdfKK90QGlI
	3jans7UStm8YPDppajPzCu5E6qneWcRuYDHkFk/D2I9fxbQqZ2IxXFkLmbuKNM9d5JYVwgFH97FCi
	TzyemWy1y04WjxVD+goY+NV62Th6eCdnXmr0VzV7GoT2cMHFpCUvHKvQwJ0MV0WlBA16f5wJKL2eW
	338mK50lo5/JGjSqsWgGLHoTF7dFtOwVh1xj5yY987oo+fE2Zgef5gOUlYSbWYTo9cWNPW1O6S2en
	mYhsqjdw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rNs7k-00CA6N-1c;
	Thu, 11 Jan 2024 10:17:20 +0000
Date: Thu, 11 Jan 2024 10:17:20 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org
Subject: [git pull] rename fixes
Message-ID: <20240111101720.GW1674809@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>

The following changes since commit 4a0b33f771db2b82fdfad08b9f34def786162865:

  selinux: saner handling of policy reloads (2023-11-16 12:45:33 -0500)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-rename

for you to fetch changes up to a8b0026847b8c43445c921ad2c85521c92eb175f:

  rename(): avoid a deadlock in the case of parents having no common ancestor (2023-11-25 02:54:14 -0500)

Two trivial conflicts - in Documentation/filesystems/porting.rst and in
fs/overlayfs/copy_up.c.  The former is "append vs. append", the latter -
dput(temp) added by overlayfs tree inside an if () with condition slightly
massaged in this branch.

----------------------------------------------------------------
fix directory locking scheme on rename

broken in 6.5; we really can't lock two unrelated directories
without holding ->s_vfs_rename_mutex first and in case of
same-parent rename of a subdirectory 6.5 ends up doing just
that.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

----------------------------------------------------------------
Al Viro (5):
      udf_rename(): only access the child content on cross-directory rename
      ext4: don't access the source subdirectory content on same-directory rename
      rename(): fix the locking of subdirectories
      kill lock_two_inodes()
      rename(): avoid a deadlock in the case of parents having no common ancestor

Jan Kara (4):
      reiserfs: Avoid touching renamed directory if parent does not change
      ocfs2: Avoid touching renamed directory if parent does not change
      ext2: Avoid reading renamed directory if parent does not change
      f2fs: Avoid reading renamed directory if parent does not change

 Documentation/filesystems/directory-locking.rst | 349 +++++++++++++++++-------
 Documentation/filesystems/locking.rst           |   5 +-
 Documentation/filesystems/porting.rst           |  27 ++
 fs/cachefiles/namei.c                           |   2 +
 fs/ecryptfs/inode.c                             |   2 +
 fs/ext2/namei.c                                 |  11 +-
 fs/ext4/namei.c                                 |  21 +-
 fs/f2fs/namei.c                                 |  15 +-
 fs/inode.c                                      |  49 +---
 fs/internal.h                                   |   2 -
 fs/namei.c                                      |  87 ++++--
 fs/nfsd/vfs.c                                   |   4 +
 fs/ocfs2/namei.c                                |   8 +-
 fs/overlayfs/copy_up.c                          |   9 +-
 fs/overlayfs/dir.c                              |   4 +
 fs/overlayfs/super.c                            |   6 +-
 fs/overlayfs/util.c                             |   7 +-
 fs/reiserfs/namei.c                             |  54 ++--
 fs/smb/server/vfs.c                             |   5 +
 fs/udf/namei.c                                  |   7 +-
 20 files changed, 442 insertions(+), 232 deletions(-)

