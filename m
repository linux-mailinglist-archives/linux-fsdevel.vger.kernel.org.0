Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96E70788920
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Aug 2023 15:56:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245313AbjHYNza (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Aug 2023 09:55:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245293AbjHYNy5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Aug 2023 09:54:57 -0400
Received: from out-242.mta1.migadu.com (out-242.mta1.migadu.com [95.215.58.242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 704552139
        for <linux-fsdevel@vger.kernel.org>; Fri, 25 Aug 2023 06:54:53 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1692971691;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Tk2hf/ZsTIcu3ZelMcVU1L9gdHG1BIE6+k0PUkf3KOw=;
        b=uBcPYj+KePQLzK49m3TJoZ63Y8UYXvuGXKh/n3l6WJhsswjd7fki+qH9rfO1d4Ug+ZVsQ9
        lMMssXOvXKvFl3htZmbseqXbjusga8retQQQvlmfZ3u1SC4cy0Lfpdarfx6uPXt3VqFa7M
        TnDSmLpV98dTb6gRRR2P2i+KA8l5+u4=
From:   Hao Xu <hao.xu@linux.dev>
To:     io-uring@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Cc:     Dominique Martinet <asmadeus@codewreck.org>,
        Pavel Begunkov <asml.silence@gmail.com>,
        Christian Brauner <brauner@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Stefan Roesch <shr@fb.com>, Clay Harris <bugs@claycon.org>,
        Dave Chinner <david@fromorbit.com>,
        "Darrick J . Wong" <djwong@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-cachefs@redhat.com,
        ecryptfs@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-unionfs@vger.kernel.org, bpf@vger.kernel.org,
        netdev@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-btrfs@vger.kernel.org, codalist@coda.cs.cmu.edu,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-mm@kvack.org, linux-nilfs@vger.kernel.org,
        devel@lists.orangefs.org, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org, linux-mtd@lists.infradead.org,
        Wanpeng Li <wanpengli@tencent.com>
Subject: [PATCH RFC v5 00/29] io_uring getdents
Date:   Fri, 25 Aug 2023 21:54:02 +0800
Message-Id: <20230825135431.1317785-1-hao.xu@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Hao Xu <howeyxu@tencent.com>

This series introduce getdents64 to io_uring, the code logic is similar
with the snychronized version's. It first try nowait issue, and offload
it to io-wq threads if the first try fails.

Patch1 and Patch2 are some preparation
Patch3 supports nowait for xfs getdents code
Patch4-11 are vfs change, include adding helpers and trylock for locks
Patch12-29 supports nowait for involved xfs journal stuff
note, Patch24 and 27 are actually two questions, might be removed later.
an xfs test may come later.

Tests I've done:
a liburing test case for functional test:
https://github.com/HowHsu/liburing/commit/39dc9a8e19c06a8cebf8c2301b85320eb45c061e?diff=unified

xfstests:
    test/generic: 1 fails and 171 not run
    test/xfs: 72 fails and 156 not run
run the code before without this patchset, same result.
I'll try to make the environment more right to run more tests here.


Tested it with a liburing performance test:
https://github.com/HowHsu/liburing/blob/getdents/test/getdents2.c

The test is controlled by the below script[2] which runs getdents2.t 100
times and calulate the avg.
The result show that io_uring version is about 2.6% faster:

note:
[1] the number of getdents call/request in io_uring and normal sync version
are made sure to be same beforehand.

[2] run_getdents.py

```python3

import subprocess

N = 100
sum = 0.0
args = ["/data/home/howeyxu/tmpdir", "sync"]

for i in range(N):
    output = subprocess.check_output(["./liburing/test/getdents2.t"] + args)
    sum += float(output)

average = sum / N
print("Average of sync:", average)

sum = 0.0
args = ["/data/home/howeyxu/tmpdir", "iouring"]

for i in range(N):
    output = subprocess.check_output(["./liburing/test/getdents2.t"] + args)
    sum += float(output)

average = sum / N
print("Average of iouring:", average)

```

v4->v5:
 - move atime update to the beginning of getdents operation
 - trylock for i_rwsem
 - nowait semantics for involved xfs journal stuff

v3->v4:
 - add Dave's xfs nowait code and fix a deadlock problem, with some code
   style tweak.
 - disable fixed file to avoid a race problem for now
 - add a test program.

v2->v3:
 - removed the kernfs patches
 - add f_pos_lock logic
 - remove the "reduce last EOF getdents try" optimization since
   Dominique reports that doesn't make difference
 - remove the rewind logic, I think the right way is to introduce lseek
   to io_uring not to patch this logic to getdents.
 - add Singed-off-by of Stefan Roesch for patch 1 since checkpatch
   complained that Co-developed-by someone should be accompanied with
   Signed-off-by same person, I can remove them if Stefan thinks that's
   not proper.


Dominique Martinet (1):
  fs: split off vfs_getdents function of getdents64 syscall

Hao Xu (28):
  xfs: rename XBF_TRYLOCK to XBF_NOWAIT
  xfs: add NOWAIT semantics for readdir
  vfs: add nowait flag for struct dir_context
  vfs: add a vfs helper for io_uring file pos lock
  vfs: add file_pos_unlock() for io_uring usage
  vfs: add a nowait parameter for touch_atime()
  vfs: add nowait parameter for file_accessed()
  vfs: move file_accessed() to the beginning of iterate_dir()
  vfs: add S_NOWAIT for nowait time update
  vfs: trylock inode->i_rwsem in iterate_dir() to support nowait
  xfs: enforce GFP_NOIO implicitly during nowait time update
  xfs: make xfs_trans_alloc() support nowait semantics
  xfs: support nowait for xfs_log_reserve()
  xfs: don't wait for free space in xlog_grant_head_check() in nowait
    case
  xfs: add nowait parameter for xfs_inode_item_init()
  xfs: make xfs_trans_ijoin() error out -EAGAIN
  xfs: set XBF_NOWAIT for xfs_buf_read_map if necessary
  xfs: support nowait memory allocation in _xfs_buf_alloc()
  xfs: distinguish error type of memory allocation failure for nowait
    case
  xfs: return -EAGAIN when bulk memory allocation fails in nowait case
  xfs: comment page allocation for nowait case in xfs_buf_find_insert()
  xfs: don't print warn info for -EAGAIN error in  xfs_buf_get_map()
  xfs: support nowait for xfs_buf_read_map()
  xfs: support nowait for xfs_buf_item_init()
  xfs: return -EAGAIN when nowait meets sync in transaction commit
  xfs: add a comment for xlog_kvmalloc()
  xfs: support nowait semantics for xc_ctx_lock in xlog_cil_commit()
  io_uring: add support for getdents

 arch/s390/hypfs/inode.c         |  2 +-
 block/fops.c                    |  2 +-
 fs/btrfs/file.c                 |  2 +-
 fs/btrfs/inode.c                |  2 +-
 fs/cachefiles/namei.c           |  2 +-
 fs/coda/dir.c                   |  4 +--
 fs/ecryptfs/file.c              |  4 +--
 fs/ext2/file.c                  |  4 +--
 fs/ext4/file.c                  |  6 ++--
 fs/f2fs/file.c                  |  4 +--
 fs/file.c                       | 13 +++++++
 fs/fuse/dax.c                   |  2 +-
 fs/fuse/file.c                  |  4 +--
 fs/gfs2/file.c                  |  2 +-
 fs/hugetlbfs/inode.c            |  2 +-
 fs/inode.c                      | 10 +++---
 fs/internal.h                   |  8 +++++
 fs/namei.c                      |  4 +--
 fs/nfsd/vfs.c                   |  2 +-
 fs/nilfs2/file.c                |  2 +-
 fs/orangefs/file.c              |  2 +-
 fs/orangefs/inode.c             |  2 +-
 fs/overlayfs/file.c             |  2 +-
 fs/overlayfs/inode.c            |  2 +-
 fs/pipe.c                       |  2 +-
 fs/ramfs/file-nommu.c           |  2 +-
 fs/readdir.c                    | 61 +++++++++++++++++++++++++--------
 fs/smb/client/cifsfs.c          |  2 +-
 fs/splice.c                     |  2 +-
 fs/stat.c                       |  2 +-
 fs/ubifs/file.c                 |  2 +-
 fs/udf/file.c                   |  2 +-
 fs/xfs/libxfs/xfs_alloc.c       |  2 +-
 fs/xfs/libxfs/xfs_attr_remote.c |  2 +-
 fs/xfs/libxfs/xfs_btree.c       |  2 +-
 fs/xfs/libxfs/xfs_da_btree.c    | 16 +++++++++
 fs/xfs/libxfs/xfs_da_btree.h    |  1 +
 fs/xfs/libxfs/xfs_dir2_block.c  |  7 ++--
 fs/xfs/libxfs/xfs_dir2_priv.h   |  2 +-
 fs/xfs/libxfs/xfs_shared.h      |  2 ++
 fs/xfs/libxfs/xfs_trans_inode.c | 12 +++++--
 fs/xfs/scrub/dir.c              |  2 +-
 fs/xfs/scrub/readdir.c          |  2 +-
 fs/xfs/scrub/repair.c           |  2 +-
 fs/xfs/xfs_buf.c                | 43 +++++++++++++++++------
 fs/xfs/xfs_buf.h                |  4 +--
 fs/xfs/xfs_buf_item.c           |  9 +++--
 fs/xfs/xfs_buf_item.h           |  2 +-
 fs/xfs/xfs_buf_item_recover.c   |  2 +-
 fs/xfs/xfs_dir2_readdir.c       | 49 ++++++++++++++++++++------
 fs/xfs/xfs_dquot.c              |  2 +-
 fs/xfs/xfs_file.c               |  6 ++--
 fs/xfs/xfs_inode.c              | 27 +++++++++++++++
 fs/xfs/xfs_inode.h              | 17 +++++----
 fs/xfs/xfs_inode_item.c         | 12 ++++---
 fs/xfs/xfs_inode_item.h         |  3 +-
 fs/xfs/xfs_iops.c               | 31 ++++++++++++++---
 fs/xfs/xfs_log.c                | 33 ++++++++++++------
 fs/xfs/xfs_log.h                |  5 +--
 fs/xfs/xfs_log_cil.c            | 17 +++++++--
 fs/xfs/xfs_log_priv.h           |  4 +--
 fs/xfs/xfs_trans.c              | 44 ++++++++++++++++++++----
 fs/xfs/xfs_trans.h              |  2 +-
 fs/xfs/xfs_trans_buf.c          | 18 ++++++++--
 fs/zonefs/file.c                |  4 +--
 include/linux/file.h            |  7 ++++
 include/linux/fs.h              | 16 +++++++--
 include/uapi/linux/io_uring.h   |  1 +
 io_uring/fs.c                   | 53 ++++++++++++++++++++++++++++
 io_uring/fs.h                   |  3 ++
 io_uring/opdef.c                |  8 +++++
 kernel/bpf/inode.c              |  4 +--
 mm/filemap.c                    |  8 ++---
 mm/shmem.c                      |  6 ++--
 net/unix/af_unix.c              |  4 +--
 75 files changed, 499 insertions(+), 161 deletions(-)

-- 
2.25.1

