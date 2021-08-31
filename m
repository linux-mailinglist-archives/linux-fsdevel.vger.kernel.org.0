Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 231423FCBFC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Aug 2021 19:01:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240366AbhHaRCo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 31 Aug 2021 13:02:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:55910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238215AbhHaRCn (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 31 Aug 2021 13:02:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 37EE060FC3;
        Tue, 31 Aug 2021 17:01:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630429308;
        bh=wqILHNFsZnQ1YUeuBEg5b2/CPkm/zZ3cKjXYEtPPTGE=;
        h=Date:From:To:Cc:Subject:From;
        b=GYulEa18IW84f60wqT9n1+oCYVcnhUACoA9lxMi5Du8zB45gz6V5BIsRoGpy1Xv3E
         XFBkRHG3kNPeeuQkn94rGNaPSAMv8cqFuIklFmOtLKLjJoLBpVFhbJaWav0af9Hm9M
         AhiPNBptAYtFo6jqXtLlM7A7byxCABFsBEY2JJE1etxjl/sHO+b2Rg4BRr9nXcViho
         mg2V3G5Yp5WYJmRfQ1VtoEwqlWXpjtdkBSfdO/JnmeepcjR6mKENajm0+d0LYH0ane
         C+VdVbUELpudEMrToU1A2JdG2kMCZHStiH9EY05kVPGOQP+0kY4Tyj0+NdP/BzjoMt
         Z2JM6OFbSJvtw==
Date:   Tue, 31 Aug 2021 10:01:47 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        david@fromorbit.com, linux-kernel@vger.kernel.org,
        sandeen@sandeen.net, hch@lst.de, hsiangkao@linux.alibaba.com
Subject: [GIT PULL] iomap: new code for 5.15
Message-ID: <20210831170147.GB9959@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

Please pull this new iomap code for 5.15-rc1.  The most notable
externally visible change for this cycle is the addition of support for
reads to inline tail fragments of files, which was requested by the
erofs developers; and a correction for a kernel memory corruption bug if
the sysadmin tries to activate a swapfile with more pages than the
swapfile header suggests.  We also now report writeback completion
errors to the file mapping correctly, instead of munging all errors into
EIO.

Internally, the bulk of the changes are Christoph's patchset to reduce
the indirect function call count by a third to a half by converting
iomap iteration from a loop pattern to a generator/consumer pattern.
As an added bonus, fsdax no longer open-codes iomap apply loops.

The branch merges cleanly with upstream as of a few minutes ago and has
been soaking in for-next for a couple of weeks without complaints.
Please let me know if there are any problems.

--D

The following changes since commit c500bee1c5b2f1d59b1081ac879d73268ab0ff17:

  Linux 5.14-rc4 (2021-08-01 17:04:17 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/iomap-5.15-merge-4

for you to fetch changes up to 03b8df8d43ecc3c5724e6bfb80bc0b9ea2aa2612:

  iomap: standardize tracepoint formatting and storage (2021-08-26 09:18:53 -0700)

----------------------------------------------------------------
New code for 5.15:
 - Simplify the bio_end_page usage in the buffered IO code.
 - Support reading inline data at nonzero offsets for erofs.
 - Fix some typos and bad grammar.
 - Convert kmap_atomic usage in the inline data read path.
 - Add some extra inline data input checking.
 - Fix a memory corruption bug stemming from iomap_swapfile_activate
   trying to activate more pages than mm was expecting.
 - Pass errnos through the page writeback code so that writeback errors
   are reported correctly instead of being munged to EIO.
 - Replace iomap_apply with a open-coded iterator loops to reduce the
   number of indirect calls by a third to a half.
 - Refactor the fsdax code to use iomap iterators instead of the
   open-coded iomap_apply code that it had before.
 - Format file range iomap tracepoint data in hexadecimal and
   standardize the names used in the pretty-print string.

----------------------------------------------------------------
Andreas Gruenbacher (1):
      iomap: Fix some typos and bad grammar

Christoph Hellwig (30):
      iomap: simplify iomap_readpage_actor
      iomap: simplify iomap_add_to_ioend
      iomap: fix a trivial comment typo in trace.h
      iomap: remove the iomap arguments to ->page_{prepare,done}
      iomap: mark the iomap argument to iomap_sector const
      iomap: mark the iomap argument to iomap_inline_data const
      iomap: mark the iomap argument to iomap_inline_data_valid const
      fs: mark the iomap argument to __block_write_begin_int const
      fsdax: mark the iomap argument to dax_iomap_sector as const
      iomap: mark the iomap argument to iomap_read_inline_data const
      iomap: mark the iomap argument to iomap_read_page_sync const
      iomap: fix the iomap_readpage_actor return value for inline data
      iomap: add the new iomap_iter model
      iomap: switch readahead and readpage to use iomap_iter
      iomap: switch iomap_file_buffered_write to use iomap_iter
      iomap: switch iomap_file_unshare to use iomap_iter
      iomap: switch iomap_zero_range to use iomap_iter
      iomap: switch iomap_page_mkwrite to use iomap_iter
      iomap: switch __iomap_dio_rw to use iomap_iter
      iomap: switch iomap_fiemap to use iomap_iter
      iomap: switch iomap_bmap to use iomap_iter
      iomap: switch iomap_seek_hole to use iomap_iter
      iomap: switch iomap_seek_data to use iomap_iter
      iomap: switch iomap_swapfile_activate to use iomap_iter
      fsdax: switch dax_iomap_rw to use iomap_iter
      iomap: remove iomap_apply
      iomap: pass an iomap_iter to various buffered I/O helpers
      iomap: rework unshare flag
      fsdax: switch the fault handlers to use iomap_iter
      iomap: constify iomap_iter_srcmap

Darrick J. Wong (3):
      iomap: pass writeback errors to the mapping
      iomap: move loop control code to iter.c
      iomap: standardize tracepoint formatting and storage

Gao Xiang (1):
      iomap: support reading inline data from non-zero pos

Matthew Wilcox (Oracle) (3):
      iomap: Support inline data with block size < page size
      iomap: Use kmap_local_page instead of kmap_atomic
      iomap: Add another assertion to inline data handling

Shiyang Ruan (2):
      fsdax: factor out helpers to simplify the dax fault code
      fsdax: factor out a dax_fault_actor() helper

Xu Yu (1):
      mm/swap: consider max pages in iomap_swapfile_add_extent

 fs/btrfs/inode.c       |   5 +-
 fs/buffer.c            |   4 +-
 fs/dax.c               | 606 +++++++++++++++++++++++--------------------------
 fs/gfs2/bmap.c         |   5 +-
 fs/internal.h          |   4 +-
 fs/iomap/Makefile      |   2 +-
 fs/iomap/apply.c       |  99 --------
 fs/iomap/buffered-io.c | 508 ++++++++++++++++++++---------------------
 fs/iomap/direct-io.c   | 172 +++++++-------
 fs/iomap/fiemap.c      | 101 ++++-----
 fs/iomap/iter.c        |  80 +++++++
 fs/iomap/seek.c        |  98 ++++----
 fs/iomap/swapfile.c    |  44 ++--
 fs/iomap/trace.h       |  61 ++---
 include/linux/iomap.h  |  91 ++++++--
 15 files changed, 934 insertions(+), 946 deletions(-)
 delete mode 100644 fs/iomap/apply.c
 create mode 100644 fs/iomap/iter.c
