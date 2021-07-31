Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 429D83DC846
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Jul 2021 23:37:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231718AbhGaVhs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 31 Jul 2021 17:37:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:36234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230350AbhGaVhs (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 31 Jul 2021 17:37:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2B4E860F36;
        Sat, 31 Jul 2021 21:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627767461;
        bh=Yd5XUjuiBpfqxyAPMe2PIfadrpz9l3nlrb8X0WLM248=;
        h=Date:From:To:Cc:Subject:From;
        b=j7O1JBSCtALt0j83k76J13KXmjbeYHnWIz3PdhECRxtepy2iobBVxqMLwNE3vbjVz
         jxZo27sgAxjJZp1QWwUO53ttLCnf7mRCIxAPPnSGJdUu2+5EZH/ldbalD0RYbW1ZQO
         hm5WYSruR+hI+EEYU/yX9urWM0xBjSvIMFaA+W1O6EQZ5/y26K4z2AHnCctQtT52E0
         NQGpN+sAGQP9TossUVXDg8zS1CmGfJmztVoMwhqIaB16cYg53lBtP/a6oEIN3vvZra
         6n+LO1obT9tdAQ1bpXmpExy62XStc5CI5YVWY+SW1/13X44eSeWm2B+PgMtuhFLViM
         64C2086r7S5NA==
Date:   Sat, 31 Jul 2021 14:37:40 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        david@fromorbit.com, linux-kernel@vger.kernel.org,
        sandeen@sandeen.net, hch@lst.de
Subject: [GIT PULL] xfs: bug fixes for 5.14-rc4
Message-ID: <20210731213740.GN3601443@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

Please pull this branch containing a bunch of bug fixes in XFS.  Dave
and I have been busy the last couple of weeks to find and fix as many
log recovery bugs as we can find; here are the results so far.  Go
fstests -g recoveryloop! ;)

The branch merges cleanly against upstream as of a few minutes ago.
Please let me know if anything else strange happens during the merge
process.

--D

The following changes since commit b102a46ce16fd5550aed882c3c5b95f50da7992c:

  xfs: detect misaligned rtinherit directory extent size hints (2021-07-15 09:58:42 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-5.14-fixes-2

for you to fetch changes up to 81a448d7b0668ae39c08e6f34a54cc7eafb844f1:

  xfs: prevent spoofing of rtbitmap blocks when recovering buffers (2021-07-29 09:27:29 -0700)

----------------------------------------------------------------
Fixes for 5.14-rc4:
 * Fix a number of coordination bugs relating to cache flushes for
   metadata writeback, cache flushes for multi-buffer log writes, and
   FUA writes for single-buffer log writes.
 * Fix a bug with incorrect replay of attr3 blocks.
 * Fix unnecessary stalls when flushing logs to disk.
 * Fix spoofing problems when recovering realtime bitmap blocks.

----------------------------------------------------------------
Darrick J. Wong (1):
      xfs: prevent spoofing of rtbitmap blocks when recovering buffers

Dave Chinner (11):
      xfs: flush data dev on external log write
      xfs: external logs need to flush data device
      xfs: fold __xlog_state_release_iclog into xlog_state_release_iclog
      xfs: fix ordering violation between cache flushes and tail updates
      xfs: factor out forced iclog flushes
      xfs: log forces imply data device cache flushes
      xfs: avoid unnecessary waits in xfs_log_force_lsn()
      xfs: logging the on disk inode LSN can make it go backwards
      xfs: Enforce attr3 buffer recovery order
      xfs: need to see iclog flags in tracing
      xfs: limit iclog tail updates

 fs/xfs/libxfs/xfs_log_format.h  |  11 +-
 fs/xfs/xfs_buf_item_recover.c   |  15 ++-
 fs/xfs/xfs_inode_item_recover.c |  39 +++++--
 fs/xfs/xfs_log.c                | 251 ++++++++++++++++++++++++++--------------
 fs/xfs/xfs_log_cil.c            |  13 ++-
 fs/xfs/xfs_log_priv.h           |  16 ++-
 fs/xfs/xfs_trace.h              |   5 +-
 7 files changed, 244 insertions(+), 106 deletions(-)
