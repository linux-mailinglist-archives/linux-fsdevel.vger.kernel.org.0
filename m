Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6EBB81093FF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2019 20:09:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbfKYTJK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Nov 2019 14:09:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:46732 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725823AbfKYTJK (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Nov 2019 14:09:10 -0500
Received: from localhost (c-67-169-218-210.hsd1.or.comcast.net [67.169.218.210])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 84FC12071E;
        Mon, 25 Nov 2019 19:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574708948;
        bh=tf1axfqXEdRY/GSmyEZH3oDNTjKvKlm98mhfFZbNYHk=;
        h=Date:From:To:Cc:Subject:From;
        b=J2ijnbMBCQbSlPJnQk34IRKwaRZVgYrKT0hZqMNt0ofNXpngQ8NawFe/iRU+9x/VI
         WA5y4sQu28T8fBq2ajuTQc/SEdNqOEk9frTjf17S+l531k2vlHie1fJ7KVLEtDJBeq
         RpOJs4yx1t7WZxYnUJmDCcE9gt6BEYaKc3sdHu7A=
Date:   Mon, 25 Nov 2019 11:09:07 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        david@fromorbit.com, linux-kernel@vger.kernel.org,
        sandeen@sandeen.net, hch@lst.de, agruenba@redhat.com,
        rpeterso@redhat.com, cluster-devel@redhat.com,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        Theodore Ts'o <tytso@mit.edu>
Subject: [GIT PULL] iomap: new code for 5.5
Message-ID: <20191125190907.GN6219@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

Please pull this series containing all the new iomap code for 5.5.  In
this release, we hoisted as much of XFS' writeback code into iomap as
was practicable, refactored the unshare file data function, added the
ability to perform buffered io copy on write, and tweaked various parts
of the directio implementation as needed to port ext4's directio code
(that will be a separate pull).

The branch merges cleanly against this morning's HEAD and survived a few
days' worth of xfstests.  The merge was completely straightforward, so
please let me know if you run into anything weird.  I think there'll be
a second pull request in a week with a few more small cleanups that have
trickled in.

--D

The following changes since commit 4f5cafb5cb8471e54afdc9054d973535614f7675:

  Linux 5.4-rc3 (2019-10-13 16:37:36 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/iomap-5.5-merge-11

for you to fetch changes up to 419e9c38aa075ed0cd3c13d47e15954b686bcdb6:

  iomap: Fix pipe page leakage during splicing (2019-11-22 08:36:02 -0800)

----------------------------------------------------------------
New code for 5.5:
- Make iomap_dio_rw callers explicitly tell us if they want us to wait
- Port the xfs writeback code to iomap to complete the buffered io
  library functions
- Refactor the unshare code to share common pieces
- Add support for performing copy on write with buffered writes
- Other minor fixes
- Fix unchecked return in iomap_bmap
- Fix a type casting bug in a ternary statement in iomap_dio_bio_actor
- Improve tracepoints for easier diagnostic ability
- Fix pipe page leakage in directio reads

----------------------------------------------------------------
Andreas Gruenbacher (1):
      iomap: Fix overflow in iomap_page_mkwrite

Christoph Hellwig (20):
      xfs: initialize iomap->flags in xfs_bmbt_to_iomap
      xfs: set IOMAP_F_NEW more carefully
      xfs: use a struct iomap in xfs_writepage_ctx
      xfs: refactor the ioend merging code
      xfs: turn io_append_trans into an io_private void pointer
      xfs: remove the fork fields in the writepage_ctx and ioend
      iomap: zero newly allocated mapped blocks
      iomap: lift common tracing code from xfs to iomap
      iomap: lift the xfs writeback code to iomap
      iomap: warn on inline maps in iomap_writepage_map
      iomap: move struct iomap_page out of iomap.h
      iomap: cleanup iomap_ioend_compare
      iomap: pass a struct page to iomap_finish_page_writeback
      iomap: better document the IOMAP_F_* flags
      iomap: remove the unused iomap argument to __iomap_write_end
      iomap: always use AOP_FLAG_NOFS in iomap_write_begin
      iomap: ignore non-shared or non-data blocks in xfs_file_dirty
      iomap: move the zeroing case out of iomap_read_page_sync
      iomap: use write_begin to read pages to unshare
      iomap: renumber IOMAP_HOLE to 0

Darrick J. Wong (3):
      iomap: enhance writeback error message
      iomap: iomap_bmap should check iomap_apply return value
      iomap: trace iomap_appply results

Dave Chinner (1):
      iomap: iomap that extends beyond EOF should be marked dirty

Goldwyn Rodrigues (1):
      iomap: use a srcmap for a read-modify-write I/O

Jan Kara (3):
      iomap: Allow forcing of waiting for running DIO in iomap_dio_rw()
      xfs: Use iomap_dio_rw to wait for unaligned direct IO
      iomap: Fix pipe page leakage during splicing

Jan Stancek (1):
      iomap: fix return value of iomap_dio_bio_actor on 32bit systems

Joseph Qi (1):
      fs/iomap: remove redundant check in iomap_dio_rw()

 fs/dax.c                 |  13 +-
 fs/ext2/inode.c          |   2 +-
 fs/ext4/inode.c          |   2 +-
 fs/gfs2/bmap.c           |   3 +-
 fs/gfs2/file.c           |   6 +-
 fs/iomap/Makefile        |  16 +-
 fs/iomap/apply.c         |  32 +-
 fs/iomap/buffered-io.c   | 756 +++++++++++++++++++++++++++++++++++++++++------
 fs/iomap/direct-io.c     |  24 +-
 fs/iomap/fiemap.c        |  10 +-
 fs/iomap/seek.c          |   4 +-
 fs/iomap/swapfile.c      |   3 +-
 fs/iomap/trace.c         |  12 +
 fs/iomap/trace.h         | 191 ++++++++++++
 fs/xfs/libxfs/xfs_bmap.c |  14 +-
 fs/xfs/libxfs/xfs_bmap.h |   3 +-
 fs/xfs/xfs_aops.c        | 754 ++++++++--------------------------------------
 fs/xfs/xfs_aops.h        |  17 --
 fs/xfs/xfs_file.c        |  13 +-
 fs/xfs/xfs_iomap.c       |  51 +++-
 fs/xfs/xfs_iomap.h       |   2 +-
 fs/xfs/xfs_pnfs.c        |   2 +-
 fs/xfs/xfs_reflink.c     |   2 +-
 fs/xfs/xfs_super.c       |  11 +-
 fs/xfs/xfs_trace.h       |  65 ----
 include/linux/iomap.h    | 129 +++++---
 26 files changed, 1215 insertions(+), 922 deletions(-)
 create mode 100644 fs/iomap/trace.c
 create mode 100644 fs/iomap/trace.h
