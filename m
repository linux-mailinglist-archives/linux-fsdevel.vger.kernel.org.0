Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C053D78A3E6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Aug 2023 03:27:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbjH1B1H (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 27 Aug 2023 21:27:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbjH1B0k (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 27 Aug 2023 21:26:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBC34CA;
        Sun, 27 Aug 2023 18:26:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5AAC560D14;
        Mon, 28 Aug 2023 01:26:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B326FC433C7;
        Mon, 28 Aug 2023 01:26:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693185994;
        bh=GwVLq3OkJrbkUyp31uBASPopWfhS3izyPrOJi4XbiEY=;
        h=Date:From:To:Cc:Subject:From;
        b=YXBwHraKOp8FKvsRAACfZ6QmmRH7l+EE/fGkInKlhNcew5Tlpo22n2R6OopH/u1JS
         jAAU0dUANBzDwjhROi5WcamJMV0WxYK/vlzjQKYnqw54x2m8r5KEFApHqiShey29wG
         kLGRLrqekIA9mz/G8aTLSVtXiUcs45QplDMvuP0ne5EUiB4QkN9K19lZUuv0noikku
         YjNs16OIDNcOb4qpzoLgbsGVStF9LH/IQwh/f0kTMd5tLREQWsbYornz873OmUF+yq
         7fjS6iDkR4ksC6RvMbHn1XRAQKXsbuqc3YWMG1Co+SE2Y4RFFV++QgZlvBltkrzCDn
         BhJ0X9IHFBPEw==
Date:   Sun, 27 Aug 2023 18:26:34 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     david@fromorbit.com, djwong@kernel.org,
        torvalds@linux-foundation.org
Cc:     araherle@in.ibm.com, axboe@kernel.dk, bfoster@redhat.com,
        dchinner@redhat.com, hch@lst.de, kent.overstreet@linux.dev,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        ritesh.list@gmail.com, willy@infradead.org
Subject: [GIT PULL] iomap: new code for 6.6
Message-ID: <169318520367.1841050.6633820486162376921.stg-ugh@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

Please pull this branch with changes for iomap for 6.6-rc1.  We've got
some big changes for this release -- I'm very happy to be landing
willy's work to enable large folios for the page cache for general read
and write IOs when the fs can make contiguous space allocations, and
Ritesh's work to track sub-folio dirty state to eliminate the write
amplification problems inherent in using large folios.  As a bonus,
io_uring can now process write completions in the caller's context
instead of bouncing through a workqueue, which should reduce io latency
dramatically.  IOWs, XFS should see a nice performance bump for both IO
paths.

I did a test-merge with the main upstream branch as of a few minutes
ago, and didn't see any conflicts.  Please let me know if you encounter
any problems.

As for XFS -- as has been widely covered elsewhere, I have stepped down
from the maintainer role and welcome Chandan Babu as the new release
manager.  Please expect the XFS pull request for 6.6 to come from him in
a few days.  He and I haven't quite finished the gpg-and-korg git tree
transition process yet, so please excuse any bumps along the way.
Nearly all the patches are from me anyway, so he and I have both been
running QA on the 6.6 merge branch in parallel for the past few weeks.

--D

The following changes since commit 6eaae198076080886b9e7d57f4ae06fa782f90ef:

Linux 6.5-rc3 (2023-07-23 15:24:10 -0700)

are available in the Git repository at:

https://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/iomap-6.6-merge-3

for you to fetch changes up to 377698d4abe2cd118dd866d5ef19e2f1aa6b9758:

Merge tag 'xfs-async-dio.6-2023-08-01' of git://git.kernel.dk/linux into iomap-6.6-mergeA (2023-08-01 16:41:49 -0700)

----------------------------------------------------------------
New code for 6.6:

* Make large writes to the page cache fill sparse parts of the cache
with large folios, then use large memcpy calls for the large folio.
* Track the per-block dirty state of each large folio so that a
buffered write to a single byte on a large folio does not result in a
(potentially) multi-megabyte writeback IO.
* Allow some directio completions to be performed in the initiating
task's context instead of punting through a workqueue.  This will
reduce latency for some io_uring requests.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>

----------------------------------------------------------------
Darrick J. Wong (3):
Merge tag 'large-folio-writes' of git://git.infradead.org/users/willy/pagecache into iomap-6.6-merge
Merge tag 'iomap-per-block-dirty-tracking' of https://github.com/riteshharjani/linux into iomap-6.6-merge
Merge tag 'xfs-async-dio.6-2023-08-01' of git://git.kernel.dk/linux into iomap-6.6-mergeA

Jens Axboe (8):
iomap: cleanup up iomap_dio_bio_end_io()
iomap: use an unsigned type for IOMAP_DIO_* defines
iomap: treat a write through cache the same as FUA
iomap: only set iocb->private for polled bio
iomap: add IOMAP_DIO_INLINE_COMP
fs: add IOCB flags related to passing back dio completions
io_uring/rw: add write support for IOCB_DIO_CALLER_COMP
iomap: support IOCB_DIO_CALLER_COMP

Matthew Wilcox (Oracle) (10):
iov_iter: Map the page later in copy_page_from_iter_atomic()
iov_iter: Handle compound highmem pages in copy_page_from_iter_atomic()
iov_iter: Add copy_folio_from_iter_atomic()
iomap: Remove large folio handling in iomap_invalidate_folio()
doc: Correct the description of ->release_folio
iomap: Remove unnecessary test from iomap_release_folio()
filemap: Add fgf_t typedef
filemap: Allow __filemap_get_folio to allocate large folios
iomap: Create large folios in the buffered write path
iomap: Copy larger chunks from userspace

Ritesh Harjani (IBM) (8):
iomap: Rename iomap_page to iomap_folio_state and others
iomap: Drop ifs argument from iomap_set_range_uptodate()
iomap: Add some uptodate state handling helpers for ifs state bitmap
iomap: Fix possible overflow condition in iomap_write_delalloc_scan
iomap: Use iomap_punch_t typedef
iomap: Refactor iomap_write_delalloc_punch() function out
iomap: Allocate ifs in ->write_begin() early
iomap: Add per-block dirty state tracking to improve performance

Documentation/filesystems/locking.rst |  15 +-
fs/btrfs/file.c                       |   6 +-
fs/f2fs/compress.c                    |   2 +-
fs/f2fs/f2fs.h                        |   2 +-
fs/gfs2/aops.c                        |   2 +-
fs/gfs2/bmap.c                        |   2 +-
fs/iomap/buffered-io.c                | 469 +++++++++++++++++++++++-----------
fs/iomap/direct-io.c                  | 161 +++++++++---
fs/xfs/xfs_aops.c                     |   2 +-
fs/zonefs/file.c                      |   2 +-
include/linux/fs.h                    |  35 ++-
include/linux/iomap.h                 |   3 +-
include/linux/pagemap.h               |  82 +++++-
include/linux/uio.h                   |   9 +-
io_uring/rw.c                         |  27 +-
lib/iov_iter.c                        |  43 ++--
mm/filemap.c                          |  65 ++---
mm/folio-compat.c                     |   2 +-
mm/readahead.c                        |  13 -
19 files changed, 660 insertions(+), 282 deletions(-)
