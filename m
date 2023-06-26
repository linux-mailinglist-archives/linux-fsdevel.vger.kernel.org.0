Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1504273ED0E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jun 2023 23:47:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229488AbjFZVrM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Jun 2023 17:47:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjFZVrJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Jun 2023 17:47:09 -0400
Received: from out-22.mta0.migadu.com (out-22.mta0.migadu.com [IPv6:2001:41d0:1004:224b::16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E120E7F
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Jun 2023 14:47:03 -0700 (PDT)
Date:   Mon, 26 Jun 2023 17:46:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1687816021;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=MAxfXKg0PKApyLQ7TYziVVZjJ+tU0/gL5iIKrOdMGOM=;
        b=tilhBJRBcGOybWv/j7SvKHe4S75uaiPjgXn5N5udC5gdOaZbvwIzNHo3iLlt0yITEBgknG
        GJqfoStrXa5DW1HexTt73wvecxzAPuYZvqqLz4LHXN/8L9d8RGdZQnLm+3cBs+r9WTLljX
        x89F/JGXZoQYA1kVNgfJcGqzrpdKQAA=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-bcachefs@vger.kernel.org
Subject: [GIT PULL] bcachefs
Message-ID: <20230626214656.hcp4puionmtoloat@moria.home.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

Here it is, the bcachefs pull request. For brevity the list of patches
below is only the initial part of the series, the non-bcachefs prep
patches and the first bcachefs patch, but the diffstat is for the entire
series.

Six locks has all the changes you suggested, text size went down
significantly. If you'd still like this to see more review from the
locking people, I'm not against them living in fs/bcachefs/ as an
interim; perhaps Dave could move them back to kernel/locking when he
starts using them or when locking people have had time to look at them -
I'm just hoping for this to not block the merge.

Recently some people have expressed concerns about "not wanting a repeat
of ntfs3" - from what I understand the issue there was just severe
buggyness, so perhaps showing the bcachefs automated test results will
help with that:

  https://evilpiepirate.org/~testdashboard/ci

The main bcachefs branch runs fstests and my own test suite in several
varations, including lockdep+kasan, preempt, and gcov (we're at 82% line
coverage); I'm not currently seeing any lockdep or kasan splats (or
panics/oopses, for that matter).

(Worth noting the bug causing the most test failures by a wide margin is
actually an io_uring bug that causes random umount failures in shutdown
tests. Would be great to get that looked at, it doesn't just affect
bcachefs).

Regarding feature status - most features are considered stable and ready
for use, snapshots and erasure coding are both nearly there. But a
filesystem on this scale is a massive project, adequately conveying the
status of every feature would take at least a page or two.

We may want to mark it as EXPERIMENTAL for a few releases, I haven't
done that as yet. (I wouldn't consider single device without snapshots
to be experimental, but - given that the number of users and bug reports
is about to shoot up, perhaps I should...).

Cheers,
Kent

---------

The following changes since commit 6995e2de6891c724bfeb2db33d7b87775f913ad1:

  Linux 6.4 (2023-06-25 16:29:58 -0700)

are available in the Git repository at:

  https://evilpiepirate.org/git/bcachefs.git bcachefs-for-upstream

for you to fetch changes up to 66012992c01af99f07ac696a8c9563ba291c1e7f

  bcachefs: fsck needs BTREE_UPDATE_INTERNAL_SNAPSHOT_NODE

----------------------------------------------------------------
Christopher James Halse Rogers (1):
      stacktrace: Export stack_trace_save_tsk

Daniel Hill (1):
      lib: add mean and variance module.

Kent Overstreet (26):
      Compiler Attributes: add __flatten
      locking/lockdep: lock_class_is_held()
      locking/lockdep: lockdep_set_no_check_recursion()
      locking: SIX locks (shared/intent/exclusive)
      MAINTAINERS: Add entry for six locks
      sched: Add task_struct->faults_disabled_mapping
      fs: factor out d_mark_tmpfile()
      block: Add some exports for bcachefs
      block: Allow bio_iov_iter_get_pages() with bio->bi_bdev unset
      block: Bring back zero_fill_bio_iter
      block: Don't block on s_umount from __invalidate_super()
      bcache: move closures to lib/
      MAINTAINERS: Add entry for closures
      closures: closure_wait_event()
      closures: closure_nr_remaining()
      closures: Add a missing include
      iov_iter: copy_folio_from_iter_atomic()
      MAINTAINERS: Add entry for generic-radix-tree
      lib/generic-radix-tree.c: Don't overflow in peek()
      lib/generic-radix-tree.c: Add a missing include
      lib/generic-radix-tree.c: Add peek_prev()
      lib/string_helpers: string_get_size() now returns characters wrote
      lib: Export errname
      mean_and_variance: Assorted fixes/cleanups
      MAINTAINERS: Add entry for bcachefs
      bcachefs: Initial commit

 MAINTAINERS                                     |   39 +
 block/bdev.c                                    |    2 +-
 block/bio.c                                     |   18 +-
 block/blk-core.c                                |    1 +
 block/blk.h                                     |    1 -
 drivers/md/bcache/Kconfig                       |   10 +-
 drivers/md/bcache/Makefile                      |    4 +-
 drivers/md/bcache/bcache.h                      |    2 +-
 drivers/md/bcache/super.c                       |    1 -
 drivers/md/bcache/util.h                        |    3 +-
 fs/Kconfig                                      |    1 +
 fs/Makefile                                     |    1 +
 fs/bcachefs/Kconfig                             |   75 +
 fs/bcachefs/Makefile                            |   74 +
 fs/bcachefs/acl.c                               |  414 +++
 fs/bcachefs/acl.h                               |   58 +
 fs/bcachefs/alloc_background.c                  | 2212 +++++++++++++
 fs/bcachefs/alloc_background.h                  |  251 ++
 fs/bcachefs/alloc_foreground.c                  | 1534 +++++++++
 fs/bcachefs/alloc_foreground.h                  |  224 ++
 fs/bcachefs/alloc_types.h                       |  122 +
 fs/bcachefs/backpointers.c                      |  884 +++++
 fs/bcachefs/backpointers.h                      |  131 +
 fs/bcachefs/bbpos.h                             |   48 +
 fs/bcachefs/bcachefs.h                          | 1139 +++++++
 fs/bcachefs/bcachefs_format.h                   | 2219 +++++++++++++
 fs/bcachefs/bcachefs_ioctl.h                    |  368 +++
 fs/bcachefs/bkey.c                              | 1063 ++++++
 fs/bcachefs/bkey.h                              |  774 +++++
 fs/bcachefs/bkey_buf.h                          |   61 +
 fs/bcachefs/bkey_cmp.h                          |  129 +
 fs/bcachefs/bkey_methods.c                      |  520 +++
 fs/bcachefs/bkey_methods.h                      |  169 +
 fs/bcachefs/bkey_sort.c                         |  201 ++
 fs/bcachefs/bkey_sort.h                         |   44 +
 fs/bcachefs/bset.c                              | 1588 +++++++++
 fs/bcachefs/bset.h                              |  541 ++++
 fs/bcachefs/btree_cache.c                       | 1213 +++++++
 fs/bcachefs/btree_cache.h                       |  106 +
 fs/bcachefs/btree_gc.c                          | 2130 ++++++++++++
 fs/bcachefs/btree_gc.h                          |  112 +
 fs/bcachefs/btree_io.c                          | 2261 +++++++++++++
 fs/bcachefs/btree_io.h                          |  228 ++
 fs/bcachefs/btree_iter.c                        | 3214 ++++++++++++++++++
 fs/bcachefs/btree_iter.h                        |  916 ++++++
 fs/bcachefs/btree_key_cache.c                   | 1075 ++++++
 fs/bcachefs/btree_key_cache.h                   |   48 +
 fs/bcachefs/btree_locking.c                     |  804 +++++
 fs/bcachefs/btree_locking.h                     |  424 +++
 fs/bcachefs/btree_types.h                       |  731 +++++
 fs/bcachefs/btree_update.h                      |  358 ++
 fs/bcachefs/btree_update_interior.c             | 2476 ++++++++++++++
 fs/bcachefs/btree_update_interior.h             |  327 ++
 fs/bcachefs/btree_update_leaf.c                 | 2050 ++++++++++++
 fs/bcachefs/btree_write_buffer.c                |  343 ++
 fs/bcachefs/btree_write_buffer.h                |   14 +
 fs/bcachefs/btree_write_buffer_types.h          |   44 +
 fs/bcachefs/buckets.c                           | 2200 +++++++++++++
 fs/bcachefs/buckets.h                           |  370 +++
 fs/bcachefs/buckets_types.h                     |   92 +
 fs/bcachefs/buckets_waiting_for_journal.c       |  166 +
 fs/bcachefs/buckets_waiting_for_journal.h       |   15 +
 fs/bcachefs/buckets_waiting_for_journal_types.h |   23 +
 fs/bcachefs/chardev.c                           |  769 +++++
 fs/bcachefs/chardev.h                           |   31 +
 fs/bcachefs/checksum.c                          |  712 ++++
 fs/bcachefs/checksum.h                          |  215 ++
 fs/bcachefs/clock.c                             |  193 ++
 fs/bcachefs/clock.h                             |   38 +
 fs/bcachefs/clock_types.h                       |   37 +
 fs/bcachefs/compress.c                          |  638 ++++
 fs/bcachefs/compress.h                          |   18 +
 fs/bcachefs/counters.c                          |  107 +
 fs/bcachefs/counters.h                          |   17 +
 fs/bcachefs/darray.h                            |   87 +
 fs/bcachefs/data_update.c                       |  565 ++++
 fs/bcachefs/data_update.h                       |   43 +
 fs/bcachefs/debug.c                             |  957 ++++++
 fs/bcachefs/debug.h                             |   32 +
 fs/bcachefs/dirent.c                            |  564 ++++
 fs/bcachefs/dirent.h                            |   68 +
 fs/bcachefs/disk_groups.c                       |  548 ++++
 fs/bcachefs/disk_groups.h                       |  101 +
 fs/bcachefs/ec.c                                | 1957 +++++++++++
 fs/bcachefs/ec.h                                |  261 ++
 fs/bcachefs/ec_types.h                          |   41 +
 fs/bcachefs/errcode.c                           |   63 +
 fs/bcachefs/errcode.h                           |  243 ++
 fs/bcachefs/error.c                             |  297 ++
 fs/bcachefs/error.h                             |  213 ++
 fs/bcachefs/extent_update.c                     |  173 +
 fs/bcachefs/extent_update.h                     |   12 +
 fs/bcachefs/extents.c                           | 1384 ++++++++
 fs/bcachefs/extents.h                           |  755 +++++
 fs/bcachefs/extents_types.h                     |   40 +
 fs/bcachefs/eytzinger.h                         |  281 ++
 fs/bcachefs/fifo.h                              |  127 +
 fs/bcachefs/fs-common.c                         |  501 +++
 fs/bcachefs/fs-common.h                         |   43 +
 fs/bcachefs/fs-io.c                             | 3948 +++++++++++++++++++++++
 fs/bcachefs/fs-io.h                             |   54 +
 fs/bcachefs/fs-ioctl.c                          |  556 ++++
 fs/bcachefs/fs-ioctl.h                          |   81 +
 fs/bcachefs/fs.c                                | 1943 +++++++++++
 fs/bcachefs/fs.h                                |  206 ++
 fs/bcachefs/fsck.c                              | 2494 ++++++++++++++
 fs/bcachefs/fsck.h                              |    8 +
 fs/bcachefs/inode.c                             |  868 +++++
 fs/bcachefs/inode.h                             |  192 ++
 fs/bcachefs/io.c                                | 3056 ++++++++++++++++++
 fs/bcachefs/io.h                                |  202 ++
 fs/bcachefs/io_types.h                          |  165 +
 fs/bcachefs/journal.c                           | 1453 +++++++++
 fs/bcachefs/journal.h                           |  520 +++
 fs/bcachefs/journal_io.c                        | 1868 +++++++++++
 fs/bcachefs/journal_io.h                        |   64 +
 fs/bcachefs/journal_reclaim.c                   |  863 +++++
 fs/bcachefs/journal_reclaim.h                   |   86 +
 fs/bcachefs/journal_sb.c                        |  219 ++
 fs/bcachefs/journal_sb.h                        |   24 +
 fs/bcachefs/journal_seq_blacklist.c             |  322 ++
 fs/bcachefs/journal_seq_blacklist.h             |   22 +
 fs/bcachefs/journal_types.h                     |  358 ++
 fs/bcachefs/keylist.c                           |   52 +
 fs/bcachefs/keylist.h                           |   74 +
 fs/bcachefs/keylist_types.h                     |   16 +
 fs/bcachefs/lru.c                               |  178 +
 fs/bcachefs/lru.h                               |   63 +
 fs/bcachefs/migrate.c                           |  182 ++
 fs/bcachefs/migrate.h                           |    7 +
 fs/bcachefs/move.c                              | 1162 +++++++
 fs/bcachefs/move.h                              |   96 +
 fs/bcachefs/move_types.h                        |   36 +
 fs/bcachefs/movinggc.c                          |  420 +++
 fs/bcachefs/movinggc.h                          |   12 +
 fs/bcachefs/nocow_locking.c                     |  123 +
 fs/bcachefs/nocow_locking.h                     |   49 +
 fs/bcachefs/nocow_locking_types.h               |   20 +
 fs/bcachefs/opts.c                              |  555 ++++
 fs/bcachefs/opts.h                              |  543 ++++
 fs/bcachefs/printbuf.c                          |  415 +++
 fs/bcachefs/printbuf.h                          |  284 ++
 fs/bcachefs/quota.c                             |  980 ++++++
 fs/bcachefs/quota.h                             |   72 +
 fs/bcachefs/quota_types.h                       |   43 +
 fs/bcachefs/rebalance.c                         |  363 +++
 fs/bcachefs/rebalance.h                         |   28 +
 fs/bcachefs/rebalance_types.h                   |   26 +
 fs/bcachefs/recovery.c                          | 1648 ++++++++++
 fs/bcachefs/recovery.h                          |   58 +
 fs/bcachefs/reflink.c                           |  388 +++
 fs/bcachefs/reflink.h                           |   79 +
 fs/bcachefs/replicas.c                          | 1056 ++++++
 fs/bcachefs/replicas.h                          |   91 +
 fs/bcachefs/replicas_types.h                    |   27 +
 fs/bcachefs/seqmutex.h                          |   48 +
 fs/bcachefs/siphash.c                           |  173 +
 fs/bcachefs/siphash.h                           |   87 +
 fs/bcachefs/str_hash.h                          |  370 +++
 fs/bcachefs/subvolume.c                         | 1505 +++++++++
 fs/bcachefs/subvolume.h                         |  167 +
 fs/bcachefs/subvolume_types.h                   |   22 +
 fs/bcachefs/super-io.c                          | 1597 +++++++++
 fs/bcachefs/super-io.h                          |  126 +
 fs/bcachefs/super.c                             | 1993 ++++++++++++
 fs/bcachefs/super.h                             |  266 ++
 fs/bcachefs/super_types.h                       |   51 +
 fs/bcachefs/sysfs.c                             | 1064 ++++++
 fs/bcachefs/sysfs.h                             |   48 +
 fs/bcachefs/tests.c                             |  939 ++++++
 fs/bcachefs/tests.h                             |   15 +
 fs/bcachefs/trace.c                             |   16 +
 fs/bcachefs/trace.h                             | 1247 +++++++
 fs/bcachefs/two_state_shared_lock.c             |    8 +
 fs/bcachefs/two_state_shared_lock.h             |   59 +
 fs/bcachefs/util.c                              | 1137 +++++++
 fs/bcachefs/util.h                              |  842 +++++
 fs/bcachefs/varint.c                            |  121 +
 fs/bcachefs/varint.h                            |   11 +
 fs/bcachefs/vstructs.h                          |   63 +
 fs/bcachefs/xattr.c                             |  648 ++++
 fs/bcachefs/xattr.h                             |   51 +
 fs/dcache.c                                     |   12 +-
 fs/super.c                                      |   40 +-
 include/linux/bio.h                             |    7 +-
 include/linux/blkdev.h                          |    1 +
 {drivers/md/bcache => include/linux}/closure.h  |   46 +-
 include/linux/compiler_attributes.h             |    5 +
 include/linux/dcache.h                          |    1 +
 include/linux/exportfs.h                        |    6 +
 include/linux/fs.h                              |    1 +
 include/linux/generic-radix-tree.h              |   68 +-
 include/linux/lockdep.h                         |   10 +
 include/linux/lockdep_types.h                   |    2 +-
 include/linux/mean_and_variance.h               |  198 ++
 include/linux/sched.h                           |    1 +
 include/linux/six.h                             |  388 +++
 include/linux/string_helpers.h                  |    4 +-
 include/linux/uio.h                             |    2 +
 init/init_task.c                                |    1 +
 kernel/Kconfig.locks                            |    3 +
 kernel/locking/Makefile                         |    1 +
 kernel/locking/lockdep.c                        |   46 +
 kernel/locking/six.c                            |  893 +++++
 kernel/stacktrace.c                             |    2 +
 lib/Kconfig                                     |    3 +
 lib/Kconfig.debug                               |   18 +
 lib/Makefile                                    |    2 +
 {drivers/md/bcache => lib}/closure.c            |   36 +-
 lib/errname.c                                   |    1 +
 lib/generic-radix-tree.c                        |   76 +-
 lib/iov_iter.c                                  |   53 +-
 lib/math/Kconfig                                |    3 +
 lib/math/Makefile                               |    2 +
 lib/math/mean_and_variance.c                    |  158 +
 lib/math/mean_and_variance_test.c               |  239 ++
 lib/string_helpers.c                            |    8 +-
 217 files changed, 92440 insertions(+), 86 deletions(-)
