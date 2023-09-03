Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5EE0790AA7
	for <lists+linux-fsdevel@lfdr.de>; Sun,  3 Sep 2023 05:26:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235629AbjICD0K (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 2 Sep 2023 23:26:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235619AbjICD0J (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 2 Sep 2023 23:26:09 -0400
Received: from out-214.mta0.migadu.com (out-214.mta0.migadu.com [91.218.175.214])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CFBCCCA
        for <linux-fsdevel@vger.kernel.org>; Sat,  2 Sep 2023 20:26:01 -0700 (PDT)
Date:   Sat, 2 Sep 2023 23:25:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1693711559;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=7bXB5ZnPdf6GkewNvn+lr/+hACLmHfd238gm+OVDtwE=;
        b=GaBP04hsRN2PbEjkcRfVd3b+b1d6uR2zobU66BHcGqRyZmGzorUDHf1kYS9NWThzP5xJto
        3z6NYwFyR2nb6AwacIAvs0RjLACSRSjRZAUvpPsixU8YCbZS77s2hQ8TKBdN703z+Svq+7
        kiJZdZShNzmlzPhk6SMcd1u0THbx8bw=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-bcachefs@vger.kernel.org
Subject: [GIT PULL] bcachefs
Message-ID: <20230903032555.np6lu5mouv5tw4ff@moria.home.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

here's the bcachefs pull request, for 6.6. Hopefully everything
outstanding from the previous PR thread has been resolved; the block
layer prereqs are in now via Jens's tree and the dcache helper has a
reviewed-by from Christain.

Since the last 6.5 PR, it's now marked as EXPERIMENTAL; there's also
been a bunch of on disk forwards compatibility work.

Previous PR thread...
https://lore.kernel.org/all/20230626214656.hcp4puionmtoloat@moria.home.lan/

As before, the list of patches is just from the bcachefs-prereqs branch,
the diffstat is for the entire pull.

Test results are up here:
https://evilpiepirate.org/~testdashboard/ci?branch=bcachefs-for-upstream

Cheers,
Kent

----------------------------------------------------------------
The following changes since commit b97d64c722598ffed42ece814a2cb791336c6679:

  Merge tag '6.6-rc-smb3-client-fixes-part1' of git://git.samba.org/sfrench/cifs-2.6 (2023-08-30 21:01:40 -0700)

are available in the Git repository at:

  https://evilpiepirate.org/git/bcachefs.git bcachefs-for-upstream

for you to fetch changes up to df0bfb05a6b3817b1fb5ea4d80514681e86fe702:

  bcachefs: Fix snapshot_skiplist_good() (2023-09-02 15:09:04 -0400)

----------------------------------------------------------------
Brian Foster (1):
      locking: export contention tracepoints for bcachefs six locks

Christopher James Halse Rogers (1):
      stacktrace: Export stack_trace_save_tsk

Kent Overstreet (13):
      sched: Add task_struct->faults_disabled_mapping
      fs: factor out d_mark_tmpfile()
      lib/string_helpers: string_get_size() now returns characters wrote
      lib: Export errname
      locking/osq: Export osq_(lock|unlock)
      bcache: move closures to lib/
      MAINTAINERS: Add entry for closures
      closures: closure_wait_event()
      closures: closure_nr_remaining()
      closures: Add a missing include
      MAINTAINERS: Add entry for generic-radix-tree
      lib/generic-radix-tree.c: Don't overflow in peek()
      lib/generic-radix-tree.c: Add peek_prev()

 MAINTAINERS                                     |   23 +
 drivers/md/bcache/Kconfig                       |   10 +-
 drivers/md/bcache/Makefile                      |    4 +-
 drivers/md/bcache/bcache.h                      |    2 +-
 drivers/md/bcache/super.c                       |    1 -
 drivers/md/bcache/util.h                        |    3 +-
 fs/Kconfig                                      |    1 +
 fs/Makefile                                     |    1 +
 fs/bcachefs/Kconfig                             |   85 +
 fs/bcachefs/Makefile                            |   85 +
 fs/bcachefs/acl.c                               |  412 +++
 fs/bcachefs/acl.h                               |   58 +
 fs/bcachefs/alloc_background.c                  | 2157 +++++++++++++++
 fs/bcachefs/alloc_background.h                  |  257 ++
 fs/bcachefs/alloc_foreground.c                  | 1571 +++++++++++
 fs/bcachefs/alloc_foreground.h                  |  224 ++
 fs/bcachefs/alloc_types.h                       |  126 +
 fs/bcachefs/backpointers.c                      |  873 +++++++
 fs/bcachefs/backpointers.h                      |  131 +
 fs/bcachefs/bbpos.h                             |   48 +
 fs/bcachefs/bcachefs.h                          | 1146 ++++++++
 fs/bcachefs/bcachefs_format.h                   | 2368 +++++++++++++++++
 fs/bcachefs/bcachefs_ioctl.h                    |  368 +++
 fs/bcachefs/bkey.c                              | 1107 ++++++++
 fs/bcachefs/bkey.h                              |  782 ++++++
 fs/bcachefs/bkey_buf.h                          |   61 +
 fs/bcachefs/bkey_cmp.h                          |  129 +
 fs/bcachefs/bkey_methods.c                      |  456 ++++
 fs/bcachefs/bkey_methods.h                      |  188 ++
 fs/bcachefs/bkey_sort.c                         |  201 ++
 fs/bcachefs/bkey_sort.h                         |   44 +
 fs/bcachefs/bset.c                              | 1587 +++++++++++
 fs/bcachefs/bset.h                              |  541 ++++
 fs/bcachefs/btree_cache.c                       | 1213 +++++++++
 fs/bcachefs/btree_cache.h                       |  130 +
 fs/bcachefs/btree_gc.c                          | 2124 +++++++++++++++
 fs/bcachefs/btree_gc.h                          |  114 +
 fs/bcachefs/btree_io.c                          | 2245 ++++++++++++++++
 fs/bcachefs/btree_io.h                          |  228 ++
 fs/bcachefs/btree_iter.c                        | 3192 +++++++++++++++++++++++
 fs/bcachefs/btree_iter.h                        |  940 +++++++
 fs/bcachefs/btree_journal_iter.c                |  531 ++++
 fs/bcachefs/btree_journal_iter.h                |   57 +
 fs/bcachefs/btree_key_cache.c                   | 1074 ++++++++
 fs/bcachefs/btree_key_cache.h                   |   48 +
 fs/bcachefs/btree_locking.c                     |  791 ++++++
 fs/bcachefs/btree_locking.h                     |  423 +++
 fs/bcachefs/btree_trans_commit.c                | 1156 ++++++++
 fs/bcachefs/btree_types.h                       |  739 ++++++
 fs/bcachefs/btree_update.c                      |  898 +++++++
 fs/bcachefs/btree_update.h                      |  353 +++
 fs/bcachefs/btree_update_interior.c             | 2488 ++++++++++++++++++
 fs/bcachefs/btree_update_interior.h             |  337 +++
 fs/bcachefs/btree_write_buffer.c                |  375 +++
 fs/bcachefs/btree_write_buffer.h                |   14 +
 fs/bcachefs/btree_write_buffer_types.h          |   44 +
 fs/bcachefs/buckets.c                           | 2107 +++++++++++++++
 fs/bcachefs/buckets.h                           |  413 +++
 fs/bcachefs/buckets_types.h                     |   92 +
 fs/bcachefs/buckets_waiting_for_journal.c       |  166 ++
 fs/bcachefs/buckets_waiting_for_journal.h       |   15 +
 fs/bcachefs/buckets_waiting_for_journal_types.h |   23 +
 fs/bcachefs/chardev.c                           |  769 ++++++
 fs/bcachefs/chardev.h                           |   31 +
 fs/bcachefs/checksum.c                          |  753 ++++++
 fs/bcachefs/checksum.h                          |  211 ++
 fs/bcachefs/clock.c                             |  193 ++
 fs/bcachefs/clock.h                             |   38 +
 fs/bcachefs/clock_types.h                       |   37 +
 fs/bcachefs/compress.c                          |  714 +++++
 fs/bcachefs/compress.h                          |   55 +
 fs/bcachefs/counters.c                          |  107 +
 fs/bcachefs/counters.h                          |   17 +
 fs/bcachefs/darray.h                            |   87 +
 fs/bcachefs/data_update.c                       |  562 ++++
 fs/bcachefs/data_update.h                       |   43 +
 fs/bcachefs/debug.c                             |  957 +++++++
 fs/bcachefs/debug.h                             |   32 +
 fs/bcachefs/dirent.c                            |  590 +++++
 fs/bcachefs/dirent.h                            |   70 +
 fs/bcachefs/disk_groups.c                       |  556 ++++
 fs/bcachefs/disk_groups.h                       |  106 +
 fs/bcachefs/ec.c                                | 1972 ++++++++++++++
 fs/bcachefs/ec.h                                |  260 ++
 fs/bcachefs/ec_types.h                          |   41 +
 fs/bcachefs/errcode.c                           |   63 +
 fs/bcachefs/errcode.h                           |  252 ++
 fs/bcachefs/error.c                             |  294 +++
 fs/bcachefs/error.h                             |  206 ++
 fs/bcachefs/extent_update.c                     |  173 ++
 fs/bcachefs/extent_update.h                     |   12 +
 fs/bcachefs/extents.c                           | 1403 ++++++++++
 fs/bcachefs/extents.h                           |  757 ++++++
 fs/bcachefs/extents_types.h                     |   40 +
 fs/bcachefs/eytzinger.h                         |  281 ++
 fs/bcachefs/fifo.h                              |  127 +
 fs/bcachefs/fs-common.c                         |  501 ++++
 fs/bcachefs/fs-common.h                         |   43 +
 fs/bcachefs/fs-io-buffered.c                    | 1099 ++++++++
 fs/bcachefs/fs-io-buffered.h                    |   27 +
 fs/bcachefs/fs-io-direct.c                      |  679 +++++
 fs/bcachefs/fs-io-direct.h                      |   16 +
 fs/bcachefs/fs-io-pagecache.c                   |  788 ++++++
 fs/bcachefs/fs-io-pagecache.h                   |  176 ++
 fs/bcachefs/fs-io.c                             | 1250 +++++++++
 fs/bcachefs/fs-io.h                             |  184 ++
 fs/bcachefs/fs-ioctl.c                          |  559 ++++
 fs/bcachefs/fs-ioctl.h                          |   81 +
 fs/bcachefs/fs.c                                | 1961 ++++++++++++++
 fs/bcachefs/fs.h                                |  209 ++
 fs/bcachefs/fsck.c                              | 2483 ++++++++++++++++++
 fs/bcachefs/fsck.h                              |   14 +
 fs/bcachefs/inode.c                             | 1111 ++++++++
 fs/bcachefs/inode.h                             |  204 ++
 fs/bcachefs/io.c                                | 3051 ++++++++++++++++++++++
 fs/bcachefs/io.h                                |  202 ++
 fs/bcachefs/io_types.h                          |  165 ++
 fs/bcachefs/journal.c                           | 1438 ++++++++++
 fs/bcachefs/journal.h                           |  526 ++++
 fs/bcachefs/journal_io.c                        | 1888 ++++++++++++++
 fs/bcachefs/journal_io.h                        |   65 +
 fs/bcachefs/journal_reclaim.c                   |  874 +++++++
 fs/bcachefs/journal_reclaim.h                   |   86 +
 fs/bcachefs/journal_sb.c                        |  219 ++
 fs/bcachefs/journal_sb.h                        |   24 +
 fs/bcachefs/journal_seq_blacklist.c             |  322 +++
 fs/bcachefs/journal_seq_blacklist.h             |   22 +
 fs/bcachefs/journal_types.h                     |  345 +++
 fs/bcachefs/keylist.c                           |   52 +
 fs/bcachefs/keylist.h                           |   74 +
 fs/bcachefs/keylist_types.h                     |   16 +
 fs/bcachefs/lru.c                               |  162 ++
 fs/bcachefs/lru.h                               |   69 +
 fs/bcachefs/mean_and_variance.c                 |  159 ++
 fs/bcachefs/mean_and_variance.h                 |  198 ++
 fs/bcachefs/mean_and_variance_test.c            |  240 ++
 fs/bcachefs/migrate.c                           |  182 ++
 fs/bcachefs/migrate.h                           |    7 +
 fs/bcachefs/move.c                              | 1162 +++++++++
 fs/bcachefs/move.h                              |   95 +
 fs/bcachefs/move_types.h                        |   36 +
 fs/bcachefs/movinggc.c                          |  423 +++
 fs/bcachefs/movinggc.h                          |   12 +
 fs/bcachefs/nocow_locking.c                     |  123 +
 fs/bcachefs/nocow_locking.h                     |   49 +
 fs/bcachefs/nocow_locking_types.h               |   20 +
 fs/bcachefs/opts.c                              |  599 +++++
 fs/bcachefs/opts.h                              |  563 ++++
 fs/bcachefs/printbuf.c                          |  415 +++
 fs/bcachefs/printbuf.h                          |  284 ++
 fs/bcachefs/quota.c                             |  981 +++++++
 fs/bcachefs/quota.h                             |   74 +
 fs/bcachefs/quota_types.h                       |   43 +
 fs/bcachefs/rebalance.c                         |  368 +++
 fs/bcachefs/rebalance.h                         |   28 +
 fs/bcachefs/rebalance_types.h                   |   26 +
 fs/bcachefs/recovery.c                          | 1057 ++++++++
 fs/bcachefs/recovery.h                          |   33 +
 fs/bcachefs/recovery_types.h                    |   48 +
 fs/bcachefs/reflink.c                           |  399 +++
 fs/bcachefs/reflink.h                           |   81 +
 fs/bcachefs/replicas.c                          | 1059 ++++++++
 fs/bcachefs/replicas.h                          |   91 +
 fs/bcachefs/replicas_types.h                    |   27 +
 fs/bcachefs/sb-clean.c                          |  395 +++
 fs/bcachefs/sb-clean.h                          |   16 +
 fs/bcachefs/sb-members.c                        |  173 ++
 fs/bcachefs/sb-members.h                        |  176 ++
 fs/bcachefs/seqmutex.h                          |   48 +
 fs/bcachefs/siphash.c                           |  173 ++
 fs/bcachefs/siphash.h                           |   87 +
 fs/bcachefs/six.c                               |  914 +++++++
 fs/bcachefs/six.h                               |  388 +++
 fs/bcachefs/snapshot.c                          | 1687 ++++++++++++
 fs/bcachefs/snapshot.h                          |  272 ++
 fs/bcachefs/str_hash.h                          |  370 +++
 fs/bcachefs/subvolume.c                         |  451 ++++
 fs/bcachefs/subvolume.h                         |   35 +
 fs/bcachefs/subvolume_types.h                   |   31 +
 fs/bcachefs/super-io.c                          | 1265 +++++++++
 fs/bcachefs/super-io.h                          |  133 +
 fs/bcachefs/super.c                             | 2015 ++++++++++++++
 fs/bcachefs/super.h                             |   52 +
 fs/bcachefs/super_types.h                       |   52 +
 fs/bcachefs/sysfs.c                             | 1059 ++++++++
 fs/bcachefs/sysfs.h                             |   48 +
 fs/bcachefs/tests.c                             |  970 +++++++
 fs/bcachefs/tests.h                             |   15 +
 fs/bcachefs/trace.c                             |   16 +
 fs/bcachefs/trace.h                             | 1265 +++++++++
 fs/bcachefs/two_state_shared_lock.c             |    8 +
 fs/bcachefs/two_state_shared_lock.h             |   59 +
 fs/bcachefs/util.c                              | 1144 ++++++++
 fs/bcachefs/util.h                              |  852 ++++++
 fs/bcachefs/varint.c                            |  123 +
 fs/bcachefs/varint.h                            |   11 +
 fs/bcachefs/vstructs.h                          |   63 +
 fs/bcachefs/xattr.c                             |  649 +++++
 fs/bcachefs/xattr.h                             |   50 +
 fs/dcache.c                                     |   12 +-
 {drivers/md/bcache => include/linux}/closure.h  |   46 +-
 include/linux/dcache.h                          |    1 +
 include/linux/exportfs.h                        |    6 +
 include/linux/generic-radix-tree.h              |   68 +-
 include/linux/sched.h                           |    1 +
 include/linux/string_helpers.h                  |    4 +-
 init/init_task.c                                |    1 +
 kernel/locking/mutex.c                          |    3 +
 kernel/locking/osq_lock.c                       |    2 +
 kernel/stacktrace.c                             |    2 +
 lib/Kconfig                                     |    3 +
 lib/Kconfig.debug                               |    9 +
 lib/Makefile                                    |    2 +
 {drivers/md/bcache => lib}/closure.c            |   36 +-
 lib/errname.c                                   |    1 +
 lib/generic-radix-tree.c                        |   76 +-
 lib/string_helpers.c                            |   10 +-
 217 files changed, 94348 insertions(+), 56 deletions(-)
 create mode 100644 fs/bcachefs/Kconfig
 create mode 100644 fs/bcachefs/Makefile
 create mode 100644 fs/bcachefs/acl.c
 create mode 100644 fs/bcachefs/acl.h
 create mode 100644 fs/bcachefs/alloc_background.c
 create mode 100644 fs/bcachefs/alloc_background.h
 create mode 100644 fs/bcachefs/alloc_foreground.c
 create mode 100644 fs/bcachefs/alloc_foreground.h
 create mode 100644 fs/bcachefs/alloc_types.h
 create mode 100644 fs/bcachefs/backpointers.c
 create mode 100644 fs/bcachefs/backpointers.h
 create mode 100644 fs/bcachefs/bbpos.h
 create mode 100644 fs/bcachefs/bcachefs.h
 create mode 100644 fs/bcachefs/bcachefs_format.h
 create mode 100644 fs/bcachefs/bcachefs_ioctl.h
 create mode 100644 fs/bcachefs/bkey.c
 create mode 100644 fs/bcachefs/bkey.h
 create mode 100644 fs/bcachefs/bkey_buf.h
 create mode 100644 fs/bcachefs/bkey_cmp.h
 create mode 100644 fs/bcachefs/bkey_methods.c
 create mode 100644 fs/bcachefs/bkey_methods.h
 create mode 100644 fs/bcachefs/bkey_sort.c
 create mode 100644 fs/bcachefs/bkey_sort.h
 create mode 100644 fs/bcachefs/bset.c
 create mode 100644 fs/bcachefs/bset.h
 create mode 100644 fs/bcachefs/btree_cache.c
 create mode 100644 fs/bcachefs/btree_cache.h
 create mode 100644 fs/bcachefs/btree_gc.c
 create mode 100644 fs/bcachefs/btree_gc.h
 create mode 100644 fs/bcachefs/btree_io.c
 create mode 100644 fs/bcachefs/btree_io.h
 create mode 100644 fs/bcachefs/btree_iter.c
 create mode 100644 fs/bcachefs/btree_iter.h
 create mode 100644 fs/bcachefs/btree_journal_iter.c
 create mode 100644 fs/bcachefs/btree_journal_iter.h
 create mode 100644 fs/bcachefs/btree_key_cache.c
 create mode 100644 fs/bcachefs/btree_key_cache.h
 create mode 100644 fs/bcachefs/btree_locking.c
 create mode 100644 fs/bcachefs/btree_locking.h
 create mode 100644 fs/bcachefs/btree_trans_commit.c
 create mode 100644 fs/bcachefs/btree_types.h
 create mode 100644 fs/bcachefs/btree_update.c
 create mode 100644 fs/bcachefs/btree_update.h
 create mode 100644 fs/bcachefs/btree_update_interior.c
 create mode 100644 fs/bcachefs/btree_update_interior.h
 create mode 100644 fs/bcachefs/btree_write_buffer.c
 create mode 100644 fs/bcachefs/btree_write_buffer.h
 create mode 100644 fs/bcachefs/btree_write_buffer_types.h
 create mode 100644 fs/bcachefs/buckets.c
 create mode 100644 fs/bcachefs/buckets.h
 create mode 100644 fs/bcachefs/buckets_types.h
 create mode 100644 fs/bcachefs/buckets_waiting_for_journal.c
 create mode 100644 fs/bcachefs/buckets_waiting_for_journal.h
 create mode 100644 fs/bcachefs/buckets_waiting_for_journal_types.h
 create mode 100644 fs/bcachefs/chardev.c
 create mode 100644 fs/bcachefs/chardev.h
 create mode 100644 fs/bcachefs/checksum.c
 create mode 100644 fs/bcachefs/checksum.h
 create mode 100644 fs/bcachefs/clock.c
 create mode 100644 fs/bcachefs/clock.h
 create mode 100644 fs/bcachefs/clock_types.h
 create mode 100644 fs/bcachefs/compress.c
 create mode 100644 fs/bcachefs/compress.h
 create mode 100644 fs/bcachefs/counters.c
 create mode 100644 fs/bcachefs/counters.h
 create mode 100644 fs/bcachefs/darray.h
 create mode 100644 fs/bcachefs/data_update.c
 create mode 100644 fs/bcachefs/data_update.h
 create mode 100644 fs/bcachefs/debug.c
 create mode 100644 fs/bcachefs/debug.h
 create mode 100644 fs/bcachefs/dirent.c
 create mode 100644 fs/bcachefs/dirent.h
 create mode 100644 fs/bcachefs/disk_groups.c
 create mode 100644 fs/bcachefs/disk_groups.h
 create mode 100644 fs/bcachefs/ec.c
 create mode 100644 fs/bcachefs/ec.h
 create mode 100644 fs/bcachefs/ec_types.h
 create mode 100644 fs/bcachefs/errcode.c
 create mode 100644 fs/bcachefs/errcode.h
 create mode 100644 fs/bcachefs/error.c
 create mode 100644 fs/bcachefs/error.h
 create mode 100644 fs/bcachefs/extent_update.c
 create mode 100644 fs/bcachefs/extent_update.h
 create mode 100644 fs/bcachefs/extents.c
 create mode 100644 fs/bcachefs/extents.h
 create mode 100644 fs/bcachefs/extents_types.h
 create mode 100644 fs/bcachefs/eytzinger.h
 create mode 100644 fs/bcachefs/fifo.h
 create mode 100644 fs/bcachefs/fs-common.c
 create mode 100644 fs/bcachefs/fs-common.h
 create mode 100644 fs/bcachefs/fs-io-buffered.c
 create mode 100644 fs/bcachefs/fs-io-buffered.h
 create mode 100644 fs/bcachefs/fs-io-direct.c
 create mode 100644 fs/bcachefs/fs-io-direct.h
 create mode 100644 fs/bcachefs/fs-io-pagecache.c
 create mode 100644 fs/bcachefs/fs-io-pagecache.h
 create mode 100644 fs/bcachefs/fs-io.c
 create mode 100644 fs/bcachefs/fs-io.h
 create mode 100644 fs/bcachefs/fs-ioctl.c
 create mode 100644 fs/bcachefs/fs-ioctl.h
 create mode 100644 fs/bcachefs/fs.c
 create mode 100644 fs/bcachefs/fs.h
 create mode 100644 fs/bcachefs/fsck.c
 create mode 100644 fs/bcachefs/fsck.h
 create mode 100644 fs/bcachefs/inode.c
 create mode 100644 fs/bcachefs/inode.h
 create mode 100644 fs/bcachefs/io.c
 create mode 100644 fs/bcachefs/io.h
 create mode 100644 fs/bcachefs/io_types.h
 create mode 100644 fs/bcachefs/journal.c
 create mode 100644 fs/bcachefs/journal.h
 create mode 100644 fs/bcachefs/journal_io.c
 create mode 100644 fs/bcachefs/journal_io.h
 create mode 100644 fs/bcachefs/journal_reclaim.c
 create mode 100644 fs/bcachefs/journal_reclaim.h
 create mode 100644 fs/bcachefs/journal_sb.c
 create mode 100644 fs/bcachefs/journal_sb.h
 create mode 100644 fs/bcachefs/journal_seq_blacklist.c
 create mode 100644 fs/bcachefs/journal_seq_blacklist.h
 create mode 100644 fs/bcachefs/journal_types.h
 create mode 100644 fs/bcachefs/keylist.c
 create mode 100644 fs/bcachefs/keylist.h
 create mode 100644 fs/bcachefs/keylist_types.h
 create mode 100644 fs/bcachefs/lru.c
 create mode 100644 fs/bcachefs/lru.h
 create mode 100644 fs/bcachefs/mean_and_variance.c
 create mode 100644 fs/bcachefs/mean_and_variance.h
 create mode 100644 fs/bcachefs/mean_and_variance_test.c
 create mode 100644 fs/bcachefs/migrate.c
 create mode 100644 fs/bcachefs/migrate.h
 create mode 100644 fs/bcachefs/move.c
 create mode 100644 fs/bcachefs/move.h
 create mode 100644 fs/bcachefs/move_types.h
 create mode 100644 fs/bcachefs/movinggc.c
 create mode 100644 fs/bcachefs/movinggc.h
 create mode 100644 fs/bcachefs/nocow_locking.c
 create mode 100644 fs/bcachefs/nocow_locking.h
 create mode 100644 fs/bcachefs/nocow_locking_types.h
 create mode 100644 fs/bcachefs/opts.c
 create mode 100644 fs/bcachefs/opts.h
 create mode 100644 fs/bcachefs/printbuf.c
 create mode 100644 fs/bcachefs/printbuf.h
 create mode 100644 fs/bcachefs/quota.c
 create mode 100644 fs/bcachefs/quota.h
 create mode 100644 fs/bcachefs/quota_types.h
 create mode 100644 fs/bcachefs/rebalance.c
 create mode 100644 fs/bcachefs/rebalance.h
 create mode 100644 fs/bcachefs/rebalance_types.h
 create mode 100644 fs/bcachefs/recovery.c
 create mode 100644 fs/bcachefs/recovery.h
 create mode 100644 fs/bcachefs/recovery_types.h
 create mode 100644 fs/bcachefs/reflink.c
 create mode 100644 fs/bcachefs/reflink.h
 create mode 100644 fs/bcachefs/replicas.c
 create mode 100644 fs/bcachefs/replicas.h
 create mode 100644 fs/bcachefs/replicas_types.h
 create mode 100644 fs/bcachefs/sb-clean.c
 create mode 100644 fs/bcachefs/sb-clean.h
 create mode 100644 fs/bcachefs/sb-members.c
 create mode 100644 fs/bcachefs/sb-members.h
 create mode 100644 fs/bcachefs/seqmutex.h
 create mode 100644 fs/bcachefs/siphash.c
 create mode 100644 fs/bcachefs/siphash.h
 create mode 100644 fs/bcachefs/six.c
 create mode 100644 fs/bcachefs/six.h
 create mode 100644 fs/bcachefs/snapshot.c
 create mode 100644 fs/bcachefs/snapshot.h
 create mode 100644 fs/bcachefs/str_hash.h
 create mode 100644 fs/bcachefs/subvolume.c
 create mode 100644 fs/bcachefs/subvolume.h
 create mode 100644 fs/bcachefs/subvolume_types.h
 create mode 100644 fs/bcachefs/super-io.c
 create mode 100644 fs/bcachefs/super-io.h
 create mode 100644 fs/bcachefs/super.c
 create mode 100644 fs/bcachefs/super.h
 create mode 100644 fs/bcachefs/super_types.h
 create mode 100644 fs/bcachefs/sysfs.c
 create mode 100644 fs/bcachefs/sysfs.h
 create mode 100644 fs/bcachefs/tests.c
 create mode 100644 fs/bcachefs/tests.h
 create mode 100644 fs/bcachefs/trace.c
 create mode 100644 fs/bcachefs/trace.h
 create mode 100644 fs/bcachefs/two_state_shared_lock.c
 create mode 100644 fs/bcachefs/two_state_shared_lock.h
 create mode 100644 fs/bcachefs/util.c
 create mode 100644 fs/bcachefs/util.h
 create mode 100644 fs/bcachefs/varint.c
 create mode 100644 fs/bcachefs/varint.h
 create mode 100644 fs/bcachefs/vstructs.h
 create mode 100644 fs/bcachefs/xattr.c
 create mode 100644 fs/bcachefs/xattr.h
 rename {drivers/md/bcache => include/linux}/closure.h (93%)
 rename {drivers/md/bcache => lib}/closure.c (88%)
