Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B45AA28D270
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Oct 2020 18:41:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728026AbgJMQld (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Oct 2020 12:41:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:32962 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727351AbgJMQld (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Oct 2020 12:41:33 -0400
Received: from localhost (c-67-169-218-210.hsd1.or.comcast.net [67.169.218.210])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 43F3C252B7;
        Tue, 13 Oct 2020 16:41:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602607292;
        bh=0msVrQvAOZphZx72FStCi9QydHchqZLVK6UljUe25gk=;
        h=Date:From:To:Cc:Subject:From;
        b=N04fmgQIl+uJB1yw3//AgVPz27tiQSFbKU+cvYQ1G7u59nN0r4o/dgdi9+E0JarXY
         UKUBQovqWKo6mWHfJ8st0YMg4v5ad1UvNz9bPWG0XMy2Ih8Ze9IfuaMMwNmaVXDDNv
         veeb9sAOVzJj367gxjWUmRwm5huCHwL0Unozu3Ho=
Date:   Tue, 13 Oct 2020 09:41:31 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        david@fromorbit.com, linux-kernel@vger.kernel.org,
        sandeen@sandeen.net, hch@lst.de,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        Theodore Ts'o <tytso@mit.edu>, riteshh@linux.ibm.com,
        rgoldwyn@suse.de, agruenba@redhat.com, linux-btrfs@vger.kernel.org
Subject: [GIT PULL] iomap: new code for 5.10-rc1
Message-ID: <20201013164131.GB9832@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

Please pull these new changes to the iomap code for 5.10.  There's not a
lot of new stuff going on here -- a little bit of code refactoring to
make iomap workable with btrfs' fsync locking model, cleanups in
preparation for adding THP support for filesystems, and fixing a data
corruption issue for blocksize < pagesize filesystems.

The branch merges cleanly with your HEAD branch as of a few minutes ago.
Please let me know if there are any strange problems.  It's been a
pretty quiet cycle, so I don't anticipate any more iomap pulls other
than whatever new bug fixes show up.

--D

The following changes since commit f4d51dffc6c01a9e94650d95ce0104964f8ae822:

  Linux 5.9-rc4 (2020-09-06 17:11:40 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/iomap-5.10-merge-4

for you to fetch changes up to 1a31182edd0083bb9f26e582ed39f92f898c4d0a:

  iomap: Call inode_dio_end() before generic_write_sync() (2020-09-28 08:51:08 -0700)

----------------------------------------------------------------
New code for 5.10:
- Don't WARN_ON weird states that unprivileged users can create.
- Don't invalidate page cache when direct writes want to fall back to
  buffered.
- Fix some problems when readahead ios fail.
- Fix a problem where inline data pages weren't getting flushed during
  an unshare operation.
- Rework iomap to support arbitrarily many blocks per page in
  preparation to support THP for the page cache.
- Fix a bug in the blocksize < pagesize buffered io path where we could
  fail to initialize the many-blocks-per-page uptodate bitmap correctly
  when the backing page is actually up to date.  This could cause us to
  forget to write out dirty pages.
- Split out the generic_write_sync at the end of the directio write path
  so that btrfs can drop the inode lock before sync'ing the file.
- Call inode_dio_end before trying to sync the file after a O_DSYNC
  direct write (instead of afterwards) to match the behavior of the
  old directio code.

----------------------------------------------------------------
Andreas Gruenbacher (1):
      iomap: Fix direct I/O write consistency check

Christoph Hellwig (1):
      iomap: Allow filesystem to call iomap_dio_complete without i_rwsem

Goldwyn Rodrigues (1):
      iomap: Call inode_dio_end() before generic_write_sync()

Matthew Wilcox (Oracle) (12):
      iomap: Clear page error before beginning a write
      iomap: Mark read blocks uptodate in write_begin
      iomap: Fix misplaced page flushing
      fs: Introduce i_blocks_per_page
      iomap: Use kzalloc to allocate iomap_page
      iomap: Use bitmap ops to set uptodate bits
      iomap: Support arbitrarily many blocks per page
      iomap: Convert read_count to read_bytes_pending
      iomap: Convert write_count to write_bytes_pending
      iomap: Convert iomap_write_end types
      iomap: Change calling convention for zeroing
      iomap: Set all uptodate bits for an Uptodate page

Nikolay Borisov (1):
      iomap: Use round_down/round_up macros in __iomap_write_begin

Qian Cai (1):
      iomap: fix WARN_ON_ONCE() from unprivileged users

 fs/dax.c                |  13 ++--
 fs/iomap/buffered-io.c  | 194 ++++++++++++++++++++----------------------------
 fs/iomap/direct-io.c    |  49 +++++++++---
 fs/jfs/jfs_metapage.c   |   2 +-
 fs/xfs/xfs_aops.c       |   2 +-
 include/linux/dax.h     |   3 +-
 include/linux/iomap.h   |   5 ++
 include/linux/pagemap.h |  16 ++++
 8 files changed, 150 insertions(+), 134 deletions(-)
