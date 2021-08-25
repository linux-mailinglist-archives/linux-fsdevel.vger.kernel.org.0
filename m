Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17C7E3F77C0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Aug 2021 16:51:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240442AbhHYOwH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Aug 2021 10:52:07 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:43756 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240395AbhHYOwG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Aug 2021 10:52:06 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 0A4B6221AC;
        Wed, 25 Aug 2021 14:51:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1629903080; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=1rfeu5XqjPTLABqiy/j9mv/BEeYC8r3HQXxDWyjF7ME=;
        b=j6UE+xchwkOMrbRyWdTHaD0UOhHPnrS6pVnznBsZNZFeErWc7DP6zqG5o6Gc96fj/IJdXR
        LXuzfFMsFPvgt41dzFtebQg6f/sNqkpZuMnH5bGFrLFS1ZhX7jvlJFnLadNZK+0n3dA9CB
        F0WlMbhc8Q9SCQmd0YECDWb3L8DNEhQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1629903080;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=1rfeu5XqjPTLABqiy/j9mv/BEeYC8r3HQXxDWyjF7ME=;
        b=BgbUpcFALedeh92YIotcpcqb9dooaSEYtCfQoixbLfm9GeoLj+/YCPeQN12F3TL4rcYCAR
        w3it53yQKdbRQuDA==
Received: from quack2.suse.cz (unknown [10.100.224.230])
        by relay2.suse.de (Postfix) with ESMTP id E99E9A3B87;
        Wed, 25 Aug 2021 14:51:19 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 80B301F2BA4; Wed, 25 Aug 2021 16:51:18 +0200 (CEST)
Date:   Wed, 25 Aug 2021 16:51:18 +0200
From:   Jan Kara <jack@suse.cz>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: [GIT PULL] Hole punch vs page cache filling races fixes for 5.15-rc1
Message-ID: <20210825145118.GI14620@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

  Hello Linus,

  this is the last early pull request for the coming merge window. Could you
please pull from

git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git hole_punch_for_v5.15-rc1

to get patches that fix races leading to possible data corruption or stale
data exposure in multiple filesystems when hole punching races with
operations such as readahead. This is the series I was sending for the last
merge window but with your objection fixed - now filemap_fault() has been
modified to take invalidate_lock only when we need to create new page in
the page cache and / or bring it uptodate (see updated commit 730633f0b7f
"mm: Protect operations adding pages to page cache with invalidate_lock").

There are some conflicts of this series with changes in f2fs and folio
trees. The resolution is mostly obvious but I've pushed out suggested merge
(taken from Stephen Rothwell) to:

git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git hole_punch_fixes_merge

Top of the tree is 7882c55ef64a. The full shortlog is:

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

Randy Dunlap (1):
      filesystems/locking: fix Malformed table warning

The diffstat is

 Documentation/filesystems/locking.rst |  79 ++++++++++++------
 fs/ceph/addr.c                        |   9 ++-
 fs/ceph/file.c                        |   2 +
 fs/cifs/smb2ops.c                     |   2 +
 fs/ext2/ext2.h                        |  11 ---
 fs/ext2/file.c                        |   7 +-
 fs/ext2/inode.c                       |  12 +--
 fs/ext2/super.c                       |   3 -
 fs/ext4/ext4.h                        |  10 ---
 fs/ext4/extents.c                     |  25 +++---
 fs/ext4/file.c                        |  13 +--
 fs/ext4/inode.c                       |  47 ++++-------
 fs/ext4/ioctl.c                       |   4 +-
 fs/ext4/super.c                       |  13 ++-
 fs/ext4/truncate.h                    |   8 +-
 fs/f2fs/data.c                        |   8 +-
 fs/f2fs/f2fs.h                        |   1 -
 fs/f2fs/file.c                        |  62 +++++++--------
 fs/f2fs/super.c                       |   1 -
 fs/fuse/dax.c                         |  50 ++++++------
 fs/fuse/dir.c                         |  11 +--
 fs/fuse/file.c                        |  10 +--
 fs/fuse/fuse_i.h                      |   7 --
 fs/fuse/inode.c                       |   1 -
 fs/inode.c                            |   2 +
 fs/xfs/xfs_bmap_util.c                |  15 ++--
 fs/xfs/xfs_file.c                     |  13 +--
 fs/xfs/xfs_inode.c                    | 121 ++++++++++++++--------------
 fs/xfs/xfs_inode.h                    |   3 +-
 fs/xfs/xfs_super.c                    |   2 -
 fs/zonefs/super.c                     |  23 ++----
 fs/zonefs/zonefs.h                    |   7 +-
 include/linux/fs.h                    |  39 +++++++++
 mm/filemap.c                          | 145 ++++++++++++++++++++++++++++------
 mm/madvise.c                          |   2 +-
 mm/memory-failure.c                   |   2 +-
 mm/readahead.c                        |   2 +
 mm/rmap.c                             |  41 +++++-----
 mm/shmem.c                            |  20 ++---
 mm/truncate.c                         |   9 ++-
 40 files changed, 482 insertions(+), 360 deletions(-)

							Thanks
								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
