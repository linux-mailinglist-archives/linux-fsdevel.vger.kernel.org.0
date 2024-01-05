Return-Path: <linux-fsdevel+bounces-7464-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CDE9825375
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jan 2024 13:50:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4BBD1F225E6
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jan 2024 12:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CF3C2CCBB;
	Fri,  5 Jan 2024 12:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ytl6lCyO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 132752D043;
	Fri,  5 Jan 2024 12:50:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25172C433C9;
	Fri,  5 Jan 2024 12:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704459023;
	bh=2ulF6/TQ8iLxPsLSmKQRpRjw8sAPwVOnYVIRR+bqtTA=;
	h=From:To:Cc:Subject:Date:From;
	b=Ytl6lCyOXU/qx0+ryf3yS1qjXXGXt+l6CpO6zKfgLQyJXkdimDfzr7BGq1v6TdeLe
	 q/n8E4oweEJ6kq7FzafQcbDNyQMj8KChlXQ1ZHRYwaj/usbHNG9esJJfWu12DRJoJ9
	 zbIqnZ2IyoXAr+T/25QZ+K/LWbEDkePKp7BWhD/DxfBvvvFxgJLSsMtPCEudAhs+CD
	 lcCN/ER6Tna+wf+3f9MLpin+wyJ9M+O3blHkTDIAw9aK9R0VJvy8nlGucEf6+xLzgq
	 oYUOu+rxF9GaN8oto2LcOUIm1m7aa4r0G+h0FDjwysaCERpqUhDoekU3j293xnNpQG
	 3Dy7PAaOVQHCw==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] vfs rw updates
Date: Fri,  5 Jan 2024 13:49:30 +0100
Message-ID: <20240105-vfs-rw-9b5809292b57@brauner>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6289; i=brauner@kernel.org; h=from:subject:message-id; bh=2ulF6/TQ8iLxPsLSmKQRpRjw8sAPwVOnYVIRR+bqtTA=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRO/3Uj9cOVix8NpIsWqhTN9/4RMd26f6Jl7aqOz2llp 9TvTopv6ShlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZhIcAwjw9J7Z6c4P2+936+/ RmTtvFOdPUEvExKTT5zTEom763Z53wSG/45X0+Z5ZPUui5m37F140mbv6Q2e0gec/jlWstenT86 VZgIA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

Based on the discussions at Maintainer's Summit I've encouraged relevant people
to provide pulls if they feel comfortable doing so. So this contains a pull
from Amir for read-write backing file helpers for stacking filesystems such as
overlayfs.

/* Summary */
* Fanotify is currently in the process of introducing pre content events.
  Roughly, a new permission event will be added indicating that it is safe to
  write to the file being accessed. These events are used by hierarchical
  storage managers to e.g., fill the content of files on first access.

  During that work we noticed that our current permission checking is
  inconsistent in rw_verify_area() and remap_verify_area(). Especially in the
  splice code permission checking is done multiple times. For example, one time
  for the whole range and then again for partial ranges inside the iterator.

  In addition, we mostly do permission checking before we call
  file_start_write() except for a few places where we call it after. For
  pre-content events we need such permission checking to be done before
  file_start_write(). So this is a nice reason to clean this all up.

  After this series, all permission checking is done before file_start_write().

  As part of this cleanup we also massaged the splice code a bit. We got rid of
  a few helpers because we are alredy drowning in special read-write helpers.
  We also cleaned up the return types for splice helpers.

* Introduce generic read-write helpers for backing files. This lifts some
  overlayfs code to common code so it can be used by the FUSE passthrough work
  coming in over the next cycles. Make Amir and Miklos the maintainers for this
  new subsystem of the vfs.

/* Testing */
clang: Debian clang version 16.0.6 (19)
gcc: (Debian 13.2.0-7) 13.2.0

All patches are based on v6.7-rc1 and have been sitting in linux-next.
No build failures or warnings were observed.

/* Conflicts */
At the time of creating this PR no merge conflicts were reported from
linux-next and no merge conflicts showed up doing a test-merge with
current mainline.

The following changes since commit b85ea95d086471afb4ad062012a4d73cd328fa86:

  Linux 6.7-rc1 (2023-11-12 16:19:07 -0800)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.8.rw

for you to fetch changes up to c39e2ae3943d4ee278af4e1b1dcfd5946da1089b:

  fs: fix __sb_write_started() kerneldoc formatting (2023-12-28 11:40:40 +0100)

Please consider pulling these changes from the signed vfs-6.8.rw tag.

Happy New Year!
Christian

----------------------------------------------------------------
vfs-6.8.rw

----------------------------------------------------------------
Amir Goldstein (29):
      scsi: target: core: add missing file_{start,end}_write()
      ovl: add permission hooks outside of do_splice_direct()
      splice: remove permission hook from do_splice_direct()
      splice: move permission hook out of splice_direct_to_actor()
      splice: move permission hook out of splice_file_to_pipe()
      splice: remove permission hook from iter_file_splice_write()
      remap_range: move permission hooks out of do_clone_file_range()
      remap_range: move file_start_write() to after permission hook
      btrfs: move file_start_write() to after permission hook
      coda: change locking order in coda_file_write_iter()
      fs: move file_start_write() into vfs_iter_write()
      fs: move permission hook out of do_iter_write()
      fs: move permission hook out of do_iter_read()
      fs: move kiocb_start_write() into vfs_iocb_iter_write()
      fs: create __sb_write_started() helper
      fs: create file_write_started() helper
      fs: create {sb,file}_write_not_started() helpers
      fs: fork splice_file_range() from do_splice_direct()
      fs: move file_start_write() into direct_splice_actor()
      fs: use do_splice_direct() for nfsd/ksmbd server-side-copy
      splice: return type ssize_t from all helpers
      fs: use splice_copy_file_range() inline helper
      fsnotify: split fsnotify_perm() into two hooks
      fsnotify: assert that file_start_write() is not held in permission hooks
      fsnotify: optionally pass access range in file permission hooks
      fs: prepare for stackable filesystems backing file helpers
      fs: factor out backing_file_{read,write}_iter() helpers
      fs: factor out backing_file_splice_{read,write}() helpers
      fs: factor out backing_file_mmap() helper

Christian Brauner (1):
      Merge tag 'ovl-vfs-6.8' of ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/overlayfs/vfs

Vegard Nossum (1):
      fs: fix __sb_write_started() kerneldoc formatting

 MAINTAINERS                  |   9 ++
 drivers/block/loop.c         |   2 -
 fs/Kconfig                   |   4 +
 fs/Makefile                  |   1 +
 fs/backing-file.c            | 336 +++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/ioctl.c             |  12 +-
 fs/cachefiles/io.c           |   5 +-
 fs/ceph/file.c               |  13 +-
 fs/coda/file.c               |   2 -
 fs/fuse/file.c               |   5 +-
 fs/internal.h                |   8 +-
 fs/nfs/nfs4file.c            |   5 +-
 fs/nfsd/vfs.c                |   7 +-
 fs/open.c                    |  42 +-----
 fs/overlayfs/Kconfig         |   1 +
 fs/overlayfs/copy_up.c       |  30 +++-
 fs/overlayfs/file.c          | 247 +++++--------------------------
 fs/overlayfs/overlayfs.h     |   8 +-
 fs/overlayfs/super.c         |  11 +-
 fs/read_write.c              | 235 ++++++++++++++++--------------
 fs/readdir.c                 |   4 +
 fs/remap_range.c             |  45 +++---
 fs/smb/client/cifsfs.c       |   5 +-
 fs/splice.c                  | 243 +++++++++++++++++++------------
 include/linux/backing-file.h |  42 ++++++
 include/linux/fs.h           |  71 +++++++--
 include/linux/fsnotify.h     |  50 +++++--
 include/linux/splice.h       |  51 ++++---
 io_uring/splice.c            |   4 +-
 security/security.c          |  10 +-
 30 files changed, 941 insertions(+), 567 deletions(-)
 create mode 100644 fs/backing-file.c
 create mode 100644 include/linux/backing-file.h

