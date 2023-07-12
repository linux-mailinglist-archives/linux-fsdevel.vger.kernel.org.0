Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E90DB751247
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jul 2023 23:12:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232673AbjGLVLo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Jul 2023 17:11:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232588AbjGLVLj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Jul 2023 17:11:39 -0400
Received: from out-18.mta1.migadu.com (out-18.mta1.migadu.com [IPv6:2001:41d0:203:375::12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16E2F1FD6
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Jul 2023 14:11:33 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1689196288;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=u9jA0zpqdPJBbT5wB3LqkWWTOFZva2WMc7PqpBsNmzQ=;
        b=tSLj/iB1E2XayW0N3mOTONapZTzp/4UfRR0E5j3/6A3V2t4u7ivSoQSbHNb+svKCKD4FCe
        I8rMoF/S3ae3TCwK/RkwpG8Vqd7x2yTIOckqVCWwGAg+uIL1WvDnBVcA85Ni7O7x8SlDqQ
        yn6dVoHYjl4guXv28aEzEkCOvrpjdYc=
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Kent Overstreet <kent.overstreet@linux.dev>
Subject: [PATCH 00/20] bcachefs prereqs patch series
Date:   Wed, 12 Jul 2023 17:10:55 -0400
Message-Id: <20230712211115.2174650-1-kent.overstreet@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Here's the latest iteration of the bcachefs prereqs patch series, now
hoping to go in for 6.6.

https://lore.kernel.org/linux-bcachefs/20230712195719.y4msidsr7suu55gl@moria.home.lan/T/

This is now slimmed down as much has I can. I've droped the lockdep
patches, at the cost of dropping lockdep support for btree node locks.
Six locks and mean_and_variance are now in fs/bcachefs/. My
copy_folio_from_iter_atomic() patch has been dropped in favor of the
iov_iter patch from Matthew, which he said he'd likely send for -rc4, so
will already be in by the time of the actual bcachefs pull request.

Christopher James Halse Rogers (1):
  stacktrace: Export stack_trace_save_tsk

Kent Overstreet (18):
  sched: Add task_struct->faults_disabled_mapping
  fs: factor out d_mark_tmpfile()
  block: Add some exports for bcachefs
  block: Allow bio_iov_iter_get_pages() with bio->bi_bdev unset
  block: Bring back zero_fill_bio_iter
  block: Don't block on s_umount from __invalidate_super()
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
  lib/generic-radix-tree.c: Add a missing include
  lib/generic-radix-tree.c: Add peek_prev()

Matthew Wilcox (Oracle) (1):
  iov_iter: Handle compound highmem pages in
    copy_page_from_iter_atomic()

 MAINTAINERS                                   | 15 ++++
 block/bdev.c                                  |  2 +-
 block/bio.c                                   | 18 +++--
 block/blk-core.c                              |  1 +
 block/blk.h                                   |  1 -
 drivers/md/bcache/Kconfig                     | 10 +--
 drivers/md/bcache/Makefile                    |  4 +-
 drivers/md/bcache/bcache.h                    |  2 +-
 drivers/md/bcache/super.c                     |  1 -
 drivers/md/bcache/util.h                      |  3 +-
 fs/dcache.c                                   | 12 ++-
 fs/super.c                                    | 40 +++++++---
 include/linux/bio.h                           |  7 +-
 include/linux/blkdev.h                        |  1 +
 .../md/bcache => include/linux}/closure.h     | 46 ++++++++---
 include/linux/dcache.h                        |  1 +
 include/linux/fs.h                            |  1 +
 include/linux/generic-radix-tree.h            | 68 ++++++++++++++++-
 include/linux/sched.h                         |  1 +
 include/linux/string_helpers.h                |  4 +-
 init/init_task.c                              |  1 +
 kernel/locking/osq_lock.c                     |  2 +
 kernel/stacktrace.c                           |  2 +
 lib/Kconfig                                   |  3 +
 lib/Kconfig.debug                             |  9 +++
 lib/Makefile                                  |  2 +
 {drivers/md/bcache => lib}/closure.c          | 36 +++++----
 lib/errname.c                                 |  1 +
 lib/generic-radix-tree.c                      | 76 ++++++++++++++++++-
 lib/iov_iter.c                                | 43 +++++++----
 lib/string_helpers.c                          | 10 ++-
 31 files changed, 333 insertions(+), 90 deletions(-)
 rename {drivers/md/bcache => include/linux}/closure.h (93%)
 rename {drivers/md/bcache => lib}/closure.c (88%)

-- 
2.40.1

