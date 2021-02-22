Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C67D321684
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Feb 2021 13:26:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230416AbhBVMZ0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Feb 2021 07:25:26 -0500
Received: from mx2.suse.de ([195.135.220.15]:40570 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230475AbhBVMYB (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Feb 2021 07:24:01 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C30F2AD5C;
        Mon, 22 Feb 2021 12:23:15 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 80A5C1E14ED; Mon, 22 Feb 2021 13:23:15 +0100 (CET)
Date:   Mon, 22 Feb 2021 13:23:15 +0100
From:   Jan Kara <jack@suse.cz>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [GIT PULL] writeback: Cleanup lazytime handling
Message-ID: <20210222122315.GE19630@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello Linus,

  could you please pull from

git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git lazytime_for_v5.12-rc1

to get cleanups of the lazytime handling in the writeback code making rules
for calling ->dirty_inode() filesystem handlers saner.

Top of the tree is ed296c6c05b0. The full shortlog is:

Eric Biggers (10):
      fs: correctly document the inode dirty flags
      fs: only specify I_DIRTY_TIME when needed in generic_update_time()
      fat: only specify I_DIRTY_TIME when needed in fat_update_time()
      fs: don't call ->dirty_inode for lazytime timestamp updates
      fs: pass only I_DIRTY_INODE flags to ->dirty_inode
      fs: clean up __mark_inode_dirty() a bit
      fs: drop redundant check from __writeback_single_inode()
      fs: improve comments for writeback_single_inode()
      gfs2: don't worry about I_DIRTY_TIME in gfs2_fsync()
      ext4: simplify i_state checks in __ext4_update_other_inode_time()

The diffstat is

 Documentation/filesystems/vfs.rst |   5 +-
 fs/ext4/inode.c                   |  20 +------
 fs/f2fs/super.c                   |   3 -
 fs/fat/misc.c                     |  23 ++++----
 fs/fs-writeback.c                 | 116 ++++++++++++++++++++++----------------
 fs/gfs2/file.c                    |   4 +-
 fs/gfs2/super.c                   |   2 -
 fs/inode.c                        |  38 +++++++------
 include/linux/fs.h                |  33 +++++++++--
 9 files changed, 137 insertions(+), 107 deletions(-)

							Thanks
								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
