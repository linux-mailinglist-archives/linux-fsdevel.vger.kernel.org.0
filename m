Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B5C023DEF2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Aug 2020 19:36:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730599AbgHFRf3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Aug 2020 13:35:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:57748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729339AbgHFRfX (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Aug 2020 13:35:23 -0400
Received: from localhost (c-67-169-218-210.hsd1.or.comcast.net [67.169.218.210])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D180823131;
        Thu,  6 Aug 2020 15:07:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596726464;
        bh=iNFLlgEhiYwp8ZRVI4J6gnGFP+JhjSTOqd0S/pIkyto=;
        h=Date:From:To:Cc:Subject:From;
        b=Y05pH6hS7jyZT5I8hGUXIH6dhp6PsUwz5DjbgHn90eVss5blosSYAtqvXLAZi0cru
         f/6d9Z2uXGUfy8Dt/nLbxnBREXGcOJF2eIAY58tqgMl8+/8KY3/bfqo+hawGgia2CQ
         XCtAqh4Tnn0mF+9oROVTrcDvkJ111VpXtBDsG5RA=
Date:   Thu, 6 Aug 2020 08:07:43 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        david@fromorbit.com, linux-kernel@vger.kernel.org,
        sandeen@sandeen.net, hch@lst.de,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        Theodore Ts'o <tytso@mit.edu>, riteshh@linux.ibm.com,
        rgoldwyn@suse.de, agruenba@redhat.com, linux-btrfs@vger.kernel.org
Subject: [GIT PULL v2] iomap: new code for 5.9-rc1
Message-ID: <20200806150743.GC6090@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

Please pull these new changes to the iomap code for 5.9.  The most
notable changes are:

1) iomap no longer invalidate the page cache when performing a direct
read, since doing so is unnecessary and the old directio code doesn't do
that either.

2) iomap embraced the use of returning ENOTBLK from a direct write to
trigger falling back to a buffered write since ext4 already did this and
btrfs wants it for their port.

3) iomap falls back to buffered writes if we're doing a direct write and
the page cache invalidation after the flush fails; this was necessary to
handle a corner case in the btrfs port.

4) Remove email virus scanner detritus that was accidentally included in
yesterday's pull request.  Clearly I need(ed) to update my git branch
checker scripts. :(

The branch merges cleanly with your HEAD branch as of a few minutes ago.
Please let me know if there are any strange problems.

--D

The following changes since commit dcb7fd82c75ee2d6e6f9d8cc71c52519ed52e258:

  Linux 5.8-rc4 (2020-07-05 16:20:22 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/iomap-5.9-merge-5

for you to fetch changes up to 60263d5889e6dc5987dc51b801be4955ff2e4aa7:

  iomap: fall back to buffered writes for invalidation failures (2020-08-05 09:24:16 -0700)

----------------------------------------------------------------
New code for 5.9:
- Make sure we call ->iomap_end with a failure code if ->iomap_begin
  failed in any way; some filesystems need to try to undo things.
- Don't invalidate the page cache during direct reads since we already
  sync'd the cache with disk.
- Make direct writes fall back to the page cache if the pre-write
  cache invalidation fails.  This avoids a cache coherency problem.
- Fix some idiotic virus scanner warning bs in the previous tag.

----------------------------------------------------------------
Andreas Gruenbacher (1):
      iomap: Make sure iomap_end is called after iomap_begin

Christoph Hellwig (2):
      xfs: use ENOTBLK for direct I/O to buffered I/O fallback
      iomap: fall back to buffered writes for invalidation failures

Dave Chinner (1):
      iomap: Only invalidate page cache pages on direct IO writes

 fs/ext4/file.c       |  2 ++
 fs/gfs2/file.c       |  3 ++-
 fs/iomap/apply.c     | 13 +++++++++----
 fs/iomap/direct-io.c | 37 +++++++++++++++++++++----------------
 fs/iomap/trace.h     |  1 +
 fs/xfs/xfs_file.c    |  8 ++++----
 fs/zonefs/super.c    |  7 +++++--
 7 files changed, 44 insertions(+), 27 deletions(-)
