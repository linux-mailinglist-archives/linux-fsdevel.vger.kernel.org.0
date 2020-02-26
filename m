Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6CEBE17003F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2020 14:41:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727338AbgBZNlY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Feb 2020 08:41:24 -0500
Received: from relay.sw.ru ([185.231.240.75]:44734 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726992AbgBZNlY (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Feb 2020 08:41:24 -0500
Received: from dhcp-172-16-24-104.sw.ru ([172.16.24.104] helo=localhost.localdomain)
        by relay.sw.ru with esmtp (Exim 4.92.3)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1j6wvh-0006r8-Hg; Wed, 26 Feb 2020 16:40:49 +0300
Subject: [PATCH RFC 0/5] fs,
 ext4: Physical blocks placement hint for fallocate(0): fallocate2(). TP
 defrag.
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
To:     tytso@mit.edu, viro@zeniv.linux.org.uk, adilger.kernel@dilger.ca,
        snitzer@redhat.com, jack@suse.cz, ebiggers@google.com,
        riteshh@linux.ibm.com, krisman@collabora.com, surajjs@amazon.com,
        ktkhai@virtuozzo.com, dmonakhov@gmail.com,
        mbobrowski@mbobrowski.org, enwlinux@gmail.com, sblbir@amazon.com,
        khazhy@google.com, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Date:   Wed, 26 Feb 2020 16:40:49 +0300
Message-ID: <158272427715.281342.10873281294835953645.stgit@localhost.localdomain>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When discard granuality of a block device is bigger than filesystem block size,
fstrim does not effectively release device blocks. During the filesystem life,
some files become deleted, some remain alive, and this results in that many
device blocks are used incomletely (of course, the reason is not only in this,
but since this is not a problem of a filesystem, this is not a subject
of the patchset). This results in space lose for thin provisioning devices.

Say, a filesystem on a block device, which is provided by another filesystem
(say, distributed network filesystem). Semi-used blocks of the block device
result in bad performance and worse space usage of underlining filesystem.
Another example is ext4 with 4k block on loop on ext4 with 1m block. This
case also results in bad disk space usage.

Choosing a bigger block size is not a solution here, since small files become
taking much more disk space, than they used before, and the result excess
disk usage is the same.

The proposed solution is defragmentation of files based on block device
discard granuality knowledge. Files, which were not modified for a long time,
and read-only files, small files, etc, may be placed in the same block device
block together. I.e., compaction of some device blocks, which results
in releasing another device blocks.

The problem is current fallocate() does not allow to implement effective
way for such the defragmentation. The below describes the situation for ext4,
but this should touch all filesystems.

fallocate() goes thru standard blocks allocator, which try to behave very
good for life allocation cases: block placement and future file size
prediction, delayed blocks allocation, etc. But it almost impossible
to allocate blocks from specified place for our specific case. The only
ext4 block allocator option possible to use is that the allocator firstly
tries to allocate blocks from the same block group, that inode is related to.
But this is not enough for effective files compaction.

This patchset implements an extension of fallocate():

	fallocate2(int fd, int mode, loff_t offset, loff_t len,
		   unsigned long long physical)

The new argument is @physical offset from start of device, which is must
for block allocation. In case of [@physical, @physical + len] block range
is available for allocation, the syscall assigns the corresponding extent/
extents to inode. In case of the range or its part is occupied, the syscall
returns with error (maybe, smaller range will be allocated. The behavior
is the same as when fallocate() meets no space in the middle).

This interface allows to solve the formulated problem. Also, note, this
interface may allow to improve existing e4defrag algorithm: decrease
number of file extents more effective.

[1-2/5] are refactoring.
[3/5] adds fallocate2() body.
[4/5] prepares ext4_mb_discard_preallocations() for handling EXT4_MB_HINT_GOAL_ONLY
[5/5] adds fallocate2() support for ext4

Any comments are welcomed!

---

Kirill Tkhai (5):
      fs: Add new argument to file_operations::fallocate()
      fs: Add new argument to vfs_fallocate()
      fs: Add fallocate2() syscall
      ext4: Prepare ext4_mb_discard_preallocations() for handling EXT4_MB_HINT_GOAL_ONLY
      ext4: Add fallocate2() support


 arch/x86/entry/syscalls/syscall_32.tbl |    1 +
 arch/x86/entry/syscalls/syscall_64.tbl |    1 +
 arch/x86/ia32/sys_ia32.c               |   10 +++++++
 drivers/block/loop.c                   |    2 +
 drivers/nvme/target/io-cmd-file.c      |    4 +--
 drivers/staging/android/ashmem.c       |    2 +
 drivers/target/target_core_file.c      |    2 +
 fs/block_dev.c                         |    4 +--
 fs/btrfs/file.c                        |    4 ++-
 fs/ceph/file.c                         |    5 +++-
 fs/cifs/cifsfs.c                       |    7 +++--
 fs/cifs/smb2ops.c                      |    5 +++-
 fs/ext4/ext4.h                         |    5 +++-
 fs/ext4/extents.c                      |   35 ++++++++++++++++++++-----
 fs/ext4/inode.c                        |   14 ++++++++++
 fs/ext4/mballoc.c                      |   45 +++++++++++++++++++++++++-------
 fs/f2fs/file.c                         |    4 ++-
 fs/fat/file.c                          |    7 ++++-
 fs/fuse/file.c                         |    5 +++-
 fs/gfs2/file.c                         |    5 +++-
 fs/hugetlbfs/inode.c                   |    5 +++-
 fs/io_uring.c                          |    2 +
 fs/ioctl.c                             |    5 ++--
 fs/nfs/nfs4file.c                      |    6 ++++
 fs/nfsd/vfs.c                          |    2 +
 fs/ocfs2/file.c                        |    4 ++-
 fs/open.c                              |   21 +++++++++++----
 fs/overlayfs/file.c                    |    8 ++++--
 fs/xfs/xfs_file.c                      |    5 +++-
 include/linux/fs.h                     |    4 +--
 include/linux/syscalls.h               |    8 +++++-
 ipc/shm.c                              |    6 ++--
 mm/madvise.c                           |    2 +
 mm/shmem.c                             |    4 ++-
 34 files changed, 190 insertions(+), 59 deletions(-)

--
Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>

