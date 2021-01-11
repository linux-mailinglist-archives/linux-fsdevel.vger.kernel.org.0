Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F1722F1954
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Jan 2021 16:16:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730863AbhAKPQA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Jan 2021 10:16:00 -0500
Received: from mx2.suse.de ([195.135.220.15]:33206 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728444AbhAKPP7 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Jan 2021 10:15:59 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 07C5BB7AC;
        Mon, 11 Jan 2021 15:15:18 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id C51201E081B; Mon, 11 Jan 2021 16:15:17 +0100 (CET)
Date:   Mon, 11 Jan 2021 16:15:17 +0100
From:   Jan Kara <jack@suse.cz>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        Theodore Ts'o <tytso@mit.edu>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 00/12] lazytime fix and cleanups
Message-ID: <20210111151517.GK18475@quack2.suse.cz>
References: <20210109075903.208222-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210109075903.208222-1-ebiggers@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi!

On Fri 08-01-21 23:58:51, Eric Biggers wrote:
> Hello,
> 
> Patch 1 fixes a bug in how __writeback_single_inode() handles lazytime
> expirations.  I originally reported this last year
> (https://lore.kernel.org/r/20200306004555.GB225345@gmail.com) because it
> causes the FS_IOC_REMOVE_ENCRYPTION_KEY ioctl to not work properly, as
> the bug causes inodes to remain dirty after a sync.
> 
> It also turns out that lazytime on XFS is partially broken because it
> doesn't actually write timestamps to disk after a sync() or after
> dirtytime_expire_interval.  This is fixed by the same fix.
> 
> This supersedes previously proposed fixes, including
> https://lore.kernel.org/r/20200307020043.60118-1-tytso@mit.edu and
> https://lore.kernel.org/r/20200325122825.1086872-3-hch@lst.de from last
> year (which had some issues and didn't fix the XFS bug), and v1 of this
> patchset which took a different approach
> (https://lore.kernel.org/r/20210105005452.92521-1-ebiggers@kernel.org).
> 
> Patches 2-12 then clean up various things related to lazytime and
> writeback, such as clarifying the semantics of ->dirty_inode() and the
> inode dirty flags, and improving comments.  Most of these patches could
> be applied independently if needed.
> 
> This patchset applies to v5.11-rc2.

The series look good to me. How do you plan to merge it (after resolving
Christoph's remarks)? I guess either Ted can take it through the ext4 tree
or I can take it through my tree...

								Honza

> 
> Changed since v1:
>   - Switched to the fix suggested by Jan Kara, and dropped the
>     patches which introduced ->lazytime_expired().
>   - Fixed bugs in the fat and ext4 patches.
>   - Added patch "fs: improve comments for writeback_single_inode()".
>   - Reordered the patches a bit.
>   - Added Reviewed-by's.
> 
> Eric Biggers (12):
>   fs: fix lazytime expiration handling in __writeback_single_inode()
>   fs: correctly document the inode dirty flags
>   fs: only specify I_DIRTY_TIME when needed in generic_update_time()
>   fat: only specify I_DIRTY_TIME when needed in fat_update_time()
>   fs: don't call ->dirty_inode for lazytime timestamp updates
>   fs: pass only I_DIRTY_INODE flags to ->dirty_inode
>   fs: clean up __mark_inode_dirty() a bit
>   fs: drop redundant check from __writeback_single_inode()
>   fs: improve comments for writeback_single_inode()
>   gfs2: don't worry about I_DIRTY_TIME in gfs2_fsync()
>   ext4: simplify i_state checks in __ext4_update_other_inode_time()
>   xfs: remove a stale comment from xfs_file_aio_write_checks()
> 
>  Documentation/filesystems/vfs.rst |   5 +-
>  fs/ext4/inode.c                   |  20 +----
>  fs/f2fs/super.c                   |   3 -
>  fs/fat/misc.c                     |  23 +++---
>  fs/fs-writeback.c                 | 132 +++++++++++++++++-------------
>  fs/gfs2/file.c                    |   4 +-
>  fs/gfs2/super.c                   |   2 -
>  fs/inode.c                        |  38 +++++----
>  fs/xfs/xfs_file.c                 |   6 --
>  include/linux/fs.h                |  18 ++--
>  10 files changed, 132 insertions(+), 119 deletions(-)
> 
> 
> base-commit: e71ba9452f0b5b2e8dc8aa5445198cd9214a6a62
> -- 
> 2.30.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
