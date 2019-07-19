Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6AB916E8A9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jul 2019 18:22:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728880AbfGSQWW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Jul 2019 12:22:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:37354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728051AbfGSQWW (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Jul 2019 12:22:22 -0400
Received: from localhost (c-67-169-218-210.hsd1.or.comcast.net [67.169.218.210])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9490A21872;
        Fri, 19 Jul 2019 16:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563553341;
        bh=ToqDnWrzKDf8scCUPMiKsBcInlWhLezxA4/NkXNmy6k=;
        h=Date:From:To:Cc:Subject:From;
        b=pSwIfwW4L2MkuF9bTjuPLeJp21+1X1lYJC+rcDxzPI+Kl7EYPVdxjoweiKGglut88
         xj6kksnmPTgsmGuOMlMV8pvCbPDHG23LAgCfrRVAAgm8qOdwpxAtN22uxL6DaCXoGA
         9eHaj4KDy2pN1mtZMW+VulcK8aRKauP2ZYbuet2g=
Date:   Fri, 19 Jul 2019 09:22:21 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        david@fromorbit.com, linux-kernel@vger.kernel.org,
        sandeen@sandeen.net, hch@lst.de, agruenba@redhat.com,
        rpeterso@redhat.com, cluster-devel@redhat.com
Subject: [GIT PULL] iomap: cleanups for 5.3 (part 2)
Message-ID: <20190719162221.GF7093@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

As promised, here's the second part of the iomap merge for 5.3, in which
we break up iomap.c into smaller files grouped by functional area so
that it'll be easier in the long run to maintain cohesiveness of code
units and to review incoming patches.  There are no functional changes
and fs/iomap.c split cleanly.

Note that this refactoring series has been lurking in for-next during
the merge window, but I rebased the series a couple of days ago to pick
up all the fs/iomap.c changes that came in earlier in the merge window
from other trees, and now you don't have to pick up the pieces of a
somewhat messy merge collision. :)

The branch merges cleanly against this morning's HEAD (3bfe1fc46794) and
survived an overnight run of xfstests.  The merge was completely
straightforward, so please let me know if you run into anything weird.

The only weirdness I've seen so far is that the new kernel header
compile test (CONFIG_KERNEL_HEADER_TEST) tries to test-compile iomap.h
even when CONFIG_BLOCK=n and fails, but that combination wouldn't work
even in regular kernel code because iomap is a support library for
filesystems that use block devices.  Masahiro Yamada sent a patch
earlier today to disable the header compile test for now while he
reconsiders its strategy.

--D

The following changes since commit fec88ab0af9706b2201e5daf377c5031c62d11f7:

  Merge tag 'for-linus-hmm' of git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma (2019-07-14 19:42:11 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/iomap-5.3-merge-4

for you to fetch changes up to 5d907307adc14cd5148b07629c2b4535acd06062:

  iomap: move internal declarations into fs/iomap/ (2019-07-17 07:21:02 -0700)

----------------------------------------------------------------
Also new for 5.3:
- Regroup the fs/iomap.c code by major functional area so that we can
  start development for 5.4 from a more stable base.

----------------------------------------------------------------
Darrick J. Wong (8):
      iomap: start moving code to fs/iomap/
      iomap: move the swapfile code into a separate file
      iomap: move the file mapping reporting code into a separate file
      iomap: move the SEEK_HOLE code into a separate file
      iomap: move the direct IO code into a separate file
      iomap: move the buffered IO code into a separate file
      iomap: move the main iteration code into a separate file
      iomap: move internal declarations into fs/iomap/

 MAINTAINERS            |    1 +
 fs/Makefile            |    2 +-
 fs/dax.c               |    1 -
 fs/internal.h          |   10 -
 fs/iomap.c             | 2205 ------------------------------------------------
 fs/iomap/Makefile      |   15 +
 fs/iomap/apply.c       |   74 ++
 fs/iomap/buffered-io.c | 1073 +++++++++++++++++++++++
 fs/iomap/direct-io.c   |  562 ++++++++++++
 fs/iomap/fiemap.c      |  144 ++++
 fs/iomap/seek.c        |  212 +++++
 fs/iomap/swapfile.c    |  178 ++++
 include/linux/iomap.h  |   17 +
 13 files changed, 2277 insertions(+), 2217 deletions(-)
 delete mode 100644 fs/iomap.c
 create mode 100644 fs/iomap/Makefile
 create mode 100644 fs/iomap/apply.c
 create mode 100644 fs/iomap/buffered-io.c
 create mode 100644 fs/iomap/direct-io.c
 create mode 100644 fs/iomap/fiemap.c
 create mode 100644 fs/iomap/seek.c
 create mode 100644 fs/iomap/swapfile.c
