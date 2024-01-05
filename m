Return-Path: <linux-fsdevel+bounces-7463-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 52236825374
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jan 2024 13:47:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1074B20E3E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jan 2024 12:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8A1E2D618;
	Fri,  5 Jan 2024 12:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vGJr7qtw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DBB12D602;
	Fri,  5 Jan 2024 12:47:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79FC5C433C7;
	Fri,  5 Jan 2024 12:47:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704458824;
	bh=f7aJUqAeO+62GIOemsYAtg4AYwU9wZ1B8RIVl2IX2Zg=;
	h=From:To:Cc:Subject:Date:From;
	b=vGJr7qtwsZz/T4P3Otx5SkXUs+x3QBKWPrH2yQuN2FcOLt8MuhVd+VMUXhKm5aoW7
	 nwNb+XcFNRHFJuNDTbHXSZx0rTfX686lnJS4WaAmnmwihfjF+K0qoTIEZ6Yj3yfi59
	 FwLfidcRjJkxUMw7Dqb/wZhzCUpiAATsS/dJWG4sRPf94N0ULNxIYyNsd+ueBUaOOH
	 Q4GcTrcz2bghhFhD0mYKZFevALT6lMIjFLVn3NgHGoNwn5rLJflSNmDFppxmeW6yF2
	 WpnFuO0CeiUZeFJ5/xOFMixaa9VJo9ClBHujYeWBjdCfBu+N2kHzwNEG1D9nrejVj5
	 4GFpz/cQGsyXQ==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] vfs mount api updates
Date: Fri,  5 Jan 2024 13:46:53 +0100
Message-ID: <20240105-vfs-mount-5e94596bd1d1@brauner>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8671; i=brauner@kernel.org; h=from:subject:message-id; bh=f7aJUqAeO+62GIOemsYAtg4AYwU9wZ1B8RIVl2IX2Zg=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRO/2Vzf7pJ7848R1n7K49Dl90w5NqxMDhEzvCKQ6f1/ EOBNQxBHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABNJqGD4H38+aPHxVPX0xQ9+ NEVu0v7jzHRMbtfs0BanqQvNdPbMk2JkmJl4N2Eh7yONPvNDX3KufXvCOeV/m9S8uv9uMUq7DvR +YwAA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */
This contains the work to retrieve detailed information about mounts via two
new system calls. This is hopefully the beginning of the end of the saga that
started with fsinfo() years ago. The LWN articles in [1] and [2] can serve as a
summary so we can avoid rehashing everything here.

At LSFMM in May 2022 we got into a room and agreed on what we want to do about
fsinfo(). Basically, split it into pieces. This is the first part of that
agreement. Specifically, it is concerned with retrieving information about
mounts. So this only concerns the mount information retrieval, not the mount
table change notification, or the extended filesystem specific mount option
work. That is separate work.

Currently mounts have a 32bit id. Mount ids are already in heavy use by
libmount and other low-level userspace but they can't be relied upon because
they're recycled very quickly. We agreed that mounts should carry a unique
64bit id by which they can be referenced directly. This is now implemented as
part of this work. The new 64bit mount id is exposed in statx() through the new
STATX_MNT_ID_UNIQUE flag. If the flag isn't raised the old mount id is
returned. If it is raised and the kernel supports the new 64bit mount id the
flag is raised in the result mask and the new 64bit mount id is returned. New
and old mount ids do not overlap so they cannot be conflated.

Two new system calls are introduced that operate on the 64bit mount id:
statmount() and listmount(). A summary of the api and usage can be found on LWN
as well (cf. [3]) but of course, I'll provide a summary here as well.

Both system calls rely on struct mnt_id_req. Which is the request struct used
to pass the 64bit mount id identifying the mount to operate on. It is
extensible to allow for the addition of new parameters and for future use in
other apis that make use of mount ids.

statmount() mimicks the semantics of statx() and exposes a set flags that
userspace may raise in mnt_id_req to request specific information to be
retrieved. A statmount() call returns a struct statmount filled in with
information about the requested mount. Supported requests are indicated by
raising the request flag passed in struct mnt_id_req in the @mask argument in
struct statmount. Currently we do support:

* STATMOUNT_SB_BASIC:
  Basic filesystem info.

* STATMOUNT_MNT_BASIC
  Mount information (mount id, parent mount id, mount attributes etc.).

* STATMOUNT_PROPAGATE_FROM
  Propagation from what mount in current namespace.

* STATMOUNT_MNT_ROOT
  Path of the root of the mount (e.g., mount --bind /bla /mnt returns /bla).

* STATMOUNT_MNT_POINT
  Path of the mount point (e.g., mount --bind /bla /mnt returns /mnt).

* STATMOUNT_FS_TYPE
  Name of the filesystem type as the magic number isn't enough due to submounts.

The string options STATMOUNT_MNT_{ROOT,POINT} and STATMOUNT_FS_TYPE are
appended to the end of the struct. Userspace can use the offsets in @fs_type,
@mnt_root, and @mnt_point to reference those strings easily.

The struct statmount reserves quite a bit of space currently for future
extensibility. This isn't really a problem and if this bothers us we can just
send a follow-up pull request during this cycle.

listmount() is given a 64bit mount id via mnt_id_req just as statmount(). It
takes a buffer and a size to return an array of the 64bit ids of the child
mounts of the requested mount. Userspace can thus choose to either retrieve
child mounts for a mount in batches or iterate through the child mounts. For
most use-cases it will be sufficient to just leave space for a few child
mounts. But for big mount tables having an iterator is really helpful.
Iterating through a mount table works by setting @param in mnt_id_req to the
mount id of the last child mount retrieved in the previous listmount() call.

[1]: https://lwn.net/Articles/934469
[2]: https://lwn.net/Articles/829212
[3]: https://lwn.net/Articles/950569

/* Testing */
clang: Debian clang version 16.0.6 (19)
gcc: (Debian 13.2.0-7) 13.2.0

All patches are based on v6.7-rc1 and have been sitting in linux-next.
No build failures or warnings were observed.

/* Conflicts */

Merge conflicts with other trees
================================

[1] linux-next: manual merge of the security tree with the vfs-brauner tree
    https://lore.kernel.org/linux-next/20231120143106.3f8faedd@canb.auug.org.au

    Possible conflict in system call numbering depending on whether the LSM
    people do send a pull request including their new system calls.

[2] This will have a merge conflict with the vfs misc pull request.
    https://lore.kernel.org/r/20240105-vfs-misc-62acb84c5066@brauner

    The resolution is as follows:

    diff --cc tools/testing/selftests/Makefile
    index 27f9f679ed15,da2e1b0e4dd8..000000000000
    --- a/tools/testing/selftests/Makefile
    +++ b/tools/testing/selftests/Makefile
    @@@ -26,7 -26,7 +26,8 @@@ TARGETS += filesystem
      TARGETS += filesystems/binderfs
      TARGETS += filesystems/epoll
      TARGETS += filesystems/fat
     +TARGETS += filesystems/overlayfs
    + TARGETS += filesystems/statmount
      TARGETS += firmware
      TARGETS += fpu
      TARGETS += ftrace

The following changes since commit b85ea95d086471afb4ad062012a4d73cd328fa86:

  Linux 6.7-rc1 (2023-11-12 16:19:07 -0800)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.8.mount

for you to fetch changes up to 5bd3cf8cbc8a286308ef3f40656659d5abc89995:

  add selftest for statmount/listmount (2023-12-14 16:13:59 +0100)

Please consider pulling these changes from the signed vfs-6.8.mount tag.

Happy New Year!
Christian

----------------------------------------------------------------
vfs-6.8.mount

----------------------------------------------------------------
Christian Brauner (3):
      statmount: simplify numeric option retrieval
      statmount: simplify string option retrieval
      fs: keep struct mnt_id_req extensible

Miklos Szeredi (7):
      add unique mount ID
      mounts: keep list of mounts in an rbtree
      namespace: extract show_path() helper
      add statmount(2) syscall
      add listmount(2) syscall
      wire up syscalls for statmount/listmount
      add selftest for statmount/listmount

 arch/alpha/kernel/syscalls/syscall.tbl             |   2 +
 arch/arm/tools/syscall.tbl                         |   2 +
 arch/arm64/include/asm/unistd32.h                  |   4 +
 arch/m68k/kernel/syscalls/syscall.tbl              |   2 +
 arch/microblaze/kernel/syscalls/syscall.tbl        |   2 +
 arch/mips/kernel/syscalls/syscall_n32.tbl          |   2 +
 arch/mips/kernel/syscalls/syscall_n64.tbl          |   2 +
 arch/mips/kernel/syscalls/syscall_o32.tbl          |   2 +
 arch/parisc/kernel/syscalls/syscall.tbl            |   2 +
 arch/powerpc/kernel/syscalls/syscall.tbl           |   2 +
 arch/s390/kernel/syscalls/syscall.tbl              |   2 +
 arch/sh/kernel/syscalls/syscall.tbl                |   2 +
 arch/sparc/kernel/syscalls/syscall.tbl             |   2 +
 arch/x86/entry/syscalls/syscall_32.tbl             |   2 +
 arch/x86/entry/syscalls/syscall_64.tbl             |   2 +
 arch/xtensa/kernel/syscalls/syscall.tbl            |   2 +
 fs/internal.h                                      |   2 +
 fs/mount.h                                         |  27 +-
 fs/namespace.c                                     | 627 +++++++++++++++++----
 fs/pnode.c                                         |   2 +-
 fs/proc_namespace.c                                |  13 +-
 fs/stat.c                                          |   9 +-
 include/linux/mount.h                              |   5 +-
 include/linux/syscalls.h                           |   8 +
 include/uapi/asm-generic/unistd.h                  |   8 +-
 include/uapi/linux/mount.h                         |  70 +++
 include/uapi/linux/stat.h                          |   1 +
 tools/testing/selftests/Makefile                   |   1 +
 .../selftests/filesystems/statmount/.gitignore     |   2 +
 .../selftests/filesystems/statmount/Makefile       |   6 +
 .../filesystems/statmount/statmount_test.c         | 612 ++++++++++++++++++++
 31 files changed, 1298 insertions(+), 129 deletions(-)
 create mode 100644 tools/testing/selftests/filesystems/statmount/.gitignore
 create mode 100644 tools/testing/selftests/filesystems/statmount/Makefile
 create mode 100644 tools/testing/selftests/filesystems/statmount/statmount_test.c

