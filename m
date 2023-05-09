Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0291E6FCBE5
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 May 2023 18:57:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234547AbjEIQ5N (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 May 2023 12:57:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjEIQ5M (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 May 2023 12:57:12 -0400
Received: from out-7.mta1.migadu.com (out-7.mta1.migadu.com [95.215.58.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F450E71
        for <linux-fsdevel@vger.kernel.org>; Tue,  9 May 2023 09:57:10 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1683651428;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=bDdRmpQUHxUwEp25w0/2seMdc64/j9Z/b3eHGlchF3o=;
        b=TaJMh+ibDwZ76+zvUT6ManuBOa+4NfdawA4yfp4IwNuyxCJPeSx6kSLuIiLFU/AYzVahz9
        rf/FyP1YvsTQKuFFE19raB/1s/qyS2VrGGpC3H/gPky9ZkmWIlYgcxT9D00qxDwC7GRg6u
        6VvAb9zEEyDkJvg4QVh3+P/EcPdALq8=
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-mm@kvack.org,
        linux-bcachefs@vger.kernel.org
Cc:     Kent Overstreet <kent.overstreet@linux.dev>,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        boqun.feng@gmail.com, brauner@kernel.org, hch@infradead.org,
        colyli@suse.de, djwong@kernel.org, mingo@redhat.com, jack@suse.cz,
        axboe@kernel.dk, willy@infradead.org, ojeda@kernel.org,
        ming.lei@redhat.com, ndesaulniers@google.com, peterz@infradead.org,
        phillip@squashfs.org.uk, urezki@gmail.com, longman@redhat.com,
        will@kernel.org
Subject: [PATCH 00/32] bcachefs - a new COW filesystem
Date:   Tue,  9 May 2023 12:56:25 -0400
Message-Id: <20230509165657.1735798-1-kent.overstreet@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I'm submitting the bcachefs filesystem for review and inclusion.

Included in this patch series are all the non fs/bcachefs/ patches. The
entire tree, based on v6.3, may be found at:

  http://evilpiepirate.org/git/bcachefs.git bcachefs-for-upstream

----------------------------------------------------------------

bcachefs overview, status:

Features:
 - too many to list

Known bugs:
 - too many to list

Status:
 - Snapshots have been declared stable; one serious bug report
   outstanding to look into, most users report it working well.

   These are RW btrfs-style snapshots, but with far better scalability
   and no scalability issues with sparse snapshots due to key level
   versioning.

 - Erasure coding is getting really close; hope to have it ready for
   users to beat on it by this summer. This is a novel RAID/erasure
   coding design with no write hole, and no fragmentation of writes
   (e.g. RAIDZ).

 - Tons of scalabality work finished over the past year, users are
   running it on 100 TB filesystems without complaint, waiting for first
   1 PB user; next thing to address re: scalability is fsck/recovery
   memory usage.

 - Test infrastructure! Major project milestone, check out our test
   dashboard at
     https://evilpiepirate.org/~testdashboard/ci?branch=bcachefs

Other project notes:

irc::/irc.oftc.net/bcache is where most activity happens; I'm always
there, and most code review happens there - I find the conversational
format more productive.

------------------------------------------------

patches in this series:

Christopher James Halse Rogers (1):
  stacktrace: Export stack_trace_save_tsk

Daniel Hill (1):
  lib: add mean and variance module.

Dave Chinner (3):
  vfs: factor out inode hash head calculation
  hlist-bl: add hlist_bl_fake()
  vfs: inode cache conversion to hash-bl

Kent Overstreet (27):
  Compiler Attributes: add __flatten
  locking/lockdep: lock_class_is_held()
  locking/lockdep: lockdep_set_no_check_recursion()
  locking: SIX locks (shared/intent/exclusive)
  MAINTAINERS: Add entry for six locks
  sched: Add task_struct->faults_disabled_mapping
  mm: Bring back vmalloc_exec
  fs: factor out d_mark_tmpfile()
  block: Add some exports for bcachefs
  block: Allow bio_iov_iter_get_pages() with bio->bi_bdev unset
  block: Bring back zero_fill_bio_iter
  block: Rework bio_for_each_segment_all()
  block: Rework bio_for_each_folio_all()
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
  MAINTAINERS: Add entry for bcachefs

 MAINTAINERS                                   |  39 +
 block/bdev.c                                  |   2 +-
 block/bio.c                                   |  57 +-
 block/blk-core.c                              |   1 +
 block/blk-map.c                               |  38 +-
 block/blk.h                                   |   1 -
 block/bounce.c                                |  12 +-
 drivers/md/bcache/Kconfig                     |  10 +-
 drivers/md/bcache/Makefile                    |   4 +-
 drivers/md/bcache/bcache.h                    |   2 +-
 drivers/md/bcache/btree.c                     |   8 +-
 drivers/md/bcache/super.c                     |   1 -
 drivers/md/bcache/util.h                      |   3 +-
 drivers/md/dm-crypt.c                         |  10 +-
 drivers/md/raid1.c                            |   4 +-
 fs/btrfs/disk-io.c                            |   4 +-
 fs/btrfs/extent_io.c                          |  50 +-
 fs/btrfs/raid56.c                             |  14 +-
 fs/crypto/bio.c                               |   9 +-
 fs/dcache.c                                   |  12 +-
 fs/erofs/zdata.c                              |   4 +-
 fs/ext4/page-io.c                             |   8 +-
 fs/ext4/readpage.c                            |   4 +-
 fs/f2fs/data.c                                |  20 +-
 fs/gfs2/lops.c                                |  10 +-
 fs/gfs2/meta_io.c                             |   8 +-
 fs/inode.c                                    | 218 +++--
 fs/iomap/buffered-io.c                        |  14 +-
 fs/mpage.c                                    |   4 +-
 fs/squashfs/block.c                           |  48 +-
 fs/squashfs/lz4_wrapper.c                     |  17 +-
 fs/squashfs/lzo_wrapper.c                     |  17 +-
 fs/squashfs/xz_wrapper.c                      |  19 +-
 fs/squashfs/zlib_wrapper.c                    |  18 +-
 fs/squashfs/zstd_wrapper.c                    |  19 +-
 fs/super.c                                    |  40 +-
 fs/verity/verify.c                            |   9 +-
 include/linux/bio.h                           | 132 +--
 include/linux/blkdev.h                        |   1 +
 include/linux/bvec.h                          |  70 +-
 .../md/bcache => include/linux}/closure.h     |  46 +-
 include/linux/compiler_attributes.h           |   5 +
 include/linux/dcache.h                        |   1 +
 include/linux/fs.h                            |  10 +-
 include/linux/generic-radix-tree.h            |  68 +-
 include/linux/list_bl.h                       |  22 +
 include/linux/lockdep.h                       |  10 +
 include/linux/lockdep_types.h                 |   2 +-
 include/linux/mean_and_variance.h             | 219 +++++
 include/linux/sched.h                         |   1 +
 include/linux/six.h                           | 210 +++++
 include/linux/string_helpers.h                |   4 +-
 include/linux/uio.h                           |   2 +
 include/linux/vmalloc.h                       |   1 +
 init/init_task.c                              |   1 +
 kernel/Kconfig.locks                          |   3 +
 kernel/locking/Makefile                       |   1 +
 kernel/locking/lockdep.c                      |  46 ++
 kernel/locking/six.c                          | 779 ++++++++++++++++++
 kernel/module/main.c                          |   4 +-
 kernel/stacktrace.c                           |   2 +
 lib/Kconfig                                   |   3 +
 lib/Kconfig.debug                             |  18 +
 lib/Makefile                                  |   2 +
 {drivers/md/bcache => lib}/closure.c          |  36 +-
 lib/errname.c                                 |   1 +
 lib/generic-radix-tree.c                      |  76 +-
 lib/iov_iter.c                                |  53 +-
 lib/math/Kconfig                              |   3 +
 lib/math/Makefile                             |   2 +
 lib/math/mean_and_variance.c                  | 136 +++
 lib/math/mean_and_variance_test.c             | 155 ++++
 lib/string_helpers.c                          |   8 +-
 mm/nommu.c                                    |  18 +
 mm/vmalloc.c                                  |  21 +
 75 files changed, 2485 insertions(+), 445 deletions(-)
 rename {drivers/md/bcache => include/linux}/closure.h (93%)
 create mode 100644 include/linux/mean_and_variance.h
 create mode 100644 include/linux/six.h
 create mode 100644 kernel/locking/six.c
 rename {drivers/md/bcache => lib}/closure.c (88%)
 create mode 100644 lib/math/mean_and_variance.c
 create mode 100644 lib/math/mean_and_variance_test.c

-- 
2.40.1

