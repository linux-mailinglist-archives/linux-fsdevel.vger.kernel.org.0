Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94CB13B87A6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Jun 2021 19:25:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232222AbhF3R2A (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Jun 2021 13:28:00 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:38560 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbhF3R17 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Jun 2021 13:27:59 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id DF4E52254C;
        Wed, 30 Jun 2021 17:25:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1625073929; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=C1YIgpL/tDUhwq3pgDMz/ifot805yPRD7EEhS5ZunUk=;
        b=rfZU3MUHo3URExgDb3ba/jn5p2rsSOiANfvwwmUqepILVtgN/KfLrstAI27TQXy0Tmw3g3
        waCX09dQIpSpTLrbfdwgKlOuBlXFN9BmqEkg8L6WAvvylRracUbVaxz2cpL2sLD7bIrA8F
        GUX9wa5VM2DHFtiPWsrBLbnPl27N35s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1625073929;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=C1YIgpL/tDUhwq3pgDMz/ifot805yPRD7EEhS5ZunUk=;
        b=+uddE/YFjDO/hHEI+g1baUNTGsPaBAgjuTDO4zls/hLqH9AJjLv/IBxubhbAZFMcvr6klp
        HbDPXAjbe9NqmpDA==
Received: from quack2.suse.cz (unknown [10.100.224.230])
        by relay2.suse.de (Postfix) with ESMTP id D13EDA3B85;
        Wed, 30 Jun 2021 17:25:29 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id B409C1F2CC3; Wed, 30 Jun 2021 19:25:29 +0200 (CEST)
Date:   Wed, 30 Jun 2021 19:25:29 +0200
From:   Jan Kara <jack@suse.cz>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org,
        "Darrick J. Wong" <djwong@kernel.org>
Subject: [GIT PULL] Hole puch vs page cache filling races fixes for 5.14-rc1
Message-ID: <20210630172529.GB13951@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

  Hello Linus,

  could you please pull from

git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git hole_punch_for_v5.14-rc1

to get patches that fix races leading to possible data corruption or stale
data exposure in multiple filesystems when hole punching races with
operations such as readahead.

Top of the tree is e996ae6bdbd1. The full shortlog is:

Jan Kara (13):
      mm: Fix comments mentioning i_mutex
      documentation: Sync file_operations members with reality
      mm: Protect operations adding pages to page cache with invalidate_lock
      mm: Add functions to lock invalidate_lock for two mappings
      ext4: Convert to use mapping->invalidate_lock
      ext2: Convert to using invalidate_lock
      xfs: Convert to use invalidate_lock
      xfs: Convert double locking of MMAPLOCK to use VFS helpers
      zonefs: Convert to using invalidate_lock
      f2fs: Convert to using invalidate_lock
      fuse: Convert to using invalidate_lock
      ceph: Fix race between hole punch and page fault
      cifs: Fix race between hole punch and page fault

Pavel Reichl (1):
      xfs: Refactor xfs_isilocked()

The diffstat is

 Documentation/filesystems/locking.rst |  77 +++++++++++++++-------
 fs/ceph/addr.c                        |   9 ++-
 fs/ceph/file.c                        |   2 +
 fs/cifs/smb2ops.c                     |   2 +
 fs/ext2/ext2.h                        |  11 ----
 fs/ext2/file.c                        |   7 +-
 fs/ext2/inode.c                       |  12 ++--
 fs/ext2/super.c                       |   3 -
 fs/ext4/ext4.h                        |  10 ---
 fs/ext4/extents.c                     |  25 +++----
 fs/ext4/file.c                        |  13 ++--
 fs/ext4/inode.c                       |  47 +++++--------
 fs/ext4/ioctl.c                       |   4 +-
 fs/ext4/super.c                       |  13 ++--
 fs/ext4/truncate.h                    |   8 ++-
 fs/f2fs/data.c                        |   4 +-
 fs/f2fs/f2fs.h                        |   1 -
 fs/f2fs/file.c                        |  62 +++++++++--------
 fs/f2fs/super.c                       |   1 -
 fs/fuse/dax.c                         |  50 +++++++-------
 fs/fuse/dir.c                         |  11 ++--
 fs/fuse/file.c                        |  10 +--
 fs/fuse/fuse_i.h                      |   7 --
 fs/fuse/inode.c                       |   1 -
 fs/inode.c                            |   2 +
 fs/xfs/xfs_bmap_util.c                |  15 +++--
 fs/xfs/xfs_file.c                     |  13 ++--
 fs/xfs/xfs_inode.c                    | 121 ++++++++++++++++++----------------
 fs/xfs/xfs_inode.h                    |   3 +-
 fs/xfs/xfs_super.c                    |   2 -
 fs/zonefs/super.c                     |  23 ++-----
 fs/zonefs/zonefs.h                    |   7 +-
 include/linux/fs.h                    |  39 +++++++++++
 mm/filemap.c                          | 113 ++++++++++++++++++++++++++-----
 mm/madvise.c                          |   2 +-
 mm/memory-failure.c                   |   2 +-
 mm/readahead.c                        |   2 +
 mm/rmap.c                             |  41 ++++++------
 mm/shmem.c                            |  20 +++---
 mm/truncate.c                         |   9 +--
 40 files changed, 453 insertions(+), 351 deletions(-)

							Thanks
								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
