Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1318010D4ED
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Nov 2019 12:33:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbfK2LdQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Nov 2019 06:33:16 -0500
Received: from mx2.suse.de ([195.135.220.15]:40166 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726360AbfK2LdQ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Nov 2019 06:33:16 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 68875AF38;
        Fri, 29 Nov 2019 11:33:14 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 232F81E0B6A; Fri, 29 Nov 2019 12:33:14 +0100 (CET)
Date:   Fri, 29 Nov 2019 12:33:14 +0100
From:   Jan Kara <jack@suse.cz>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: [GIT PULL] ext2, quota, reiserfs cleanups and fixes
Message-ID: <20191129113314.GC1121@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

  Hello Linus,

  could you please pull from

git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git for_v5.5-rc1

The pull contains:
  * Refactoring of quota on/off kernel internal interfaces (mostly for
    ubifs quota support as ubifs does not want to have inodes holding quota
    information)
  * A few other small quota fixes and cleanups
  * Various small ext2 fixes and cleanups
  * Reiserfs xattr fix and one cleanup

Top of the tree is 545886fead7a. The full shortlog is:

Chengguang Xu (15):
      quota: avoid increasing DQST_LOOKUPS when iterating over dirty/inuse list
      quota: code cleanup for hash bits calculation
      quota: check quota type in early stage
      quota: minor code cleanup for v1_format_ops
      ext2: adjust block num when retry allocation
      ext2: add missing brelse in ext2_new_blocks()
      ext2: return error when fail to allocating memory in ioctl
      ext2: don't set *count in the case of failure in ext2_try_to_allocate()
      ext2: check err when partial != NULL
      ext2: introduce new helper ext2_group_last_block_no()
      ext2: code cleanup by calling ext2_group_last_block_no()
      ext2: skip unnecessary operations in ext2_try_to_allocate()
      ext2: code cleanup for ext2_try_to_allocate()
      ext2: fix improper function comment
      ext2: code cleanup for descriptor_loc()

Dmitry Monakhov (2):
      quota: fix livelock in dquot_writeback_dquots
      quota: Check that quota is not dirty before release

Jan Kara (9):
      quota: Factor out setup of quota inode
      quota: Simplify dquot_resume()
      quota: Rename vfs_load_quota_inode() to dquot_load_quota_inode()
      fs: Use dquot_load_quota_inode() from filesystems
      quota: Drop dquot_enable()
      quota: Make dquot_disable() work without quota inodes
      quota: Handle quotas without quota inodes in dquot_get_state()
      Pull series refactoring quota enabling and disabling code.
      ext2: Simplify initialization in ext2_try_to_allocate()

Jeff Mahoney (1):
      reiserfs: fix extended attributes on the root directory

Konstantin Khlebnikov (1):
      fs/quota: handle overflows of sysctl fs.quota.* and report as unsigned long

Nikitas Angelinas (1):
      reiserfs: replace open-coded atomic_dec_and_mutex_lock()

The diffstat is

 fs/ext2/balloc.c         |  75 +++++-------
 fs/ext2/ext2.h           |  12 ++
 fs/ext2/inode.c          |   7 +-
 fs/ext2/ioctl.c          |   5 +-
 fs/ext2/super.c          |  13 +--
 fs/ext4/super.c          |   2 +-
 fs/f2fs/super.c          |   2 +-
 fs/ocfs2/quota_global.c  |   2 +-
 fs/ocfs2/super.c         |   4 +-
 fs/quota/dquot.c         | 289 +++++++++++++++++++++++------------------------
 fs/quota/quota.c         |   7 +-
 fs/quota/quota_v1.c      |   1 -
 fs/reiserfs/file.c       |  10 +-
 fs/reiserfs/inode.c      |  12 +-
 fs/reiserfs/namei.c      |   7 +-
 fs/reiserfs/reiserfs.h   |   2 +
 fs/reiserfs/super.c      |   2 +
 fs/reiserfs/xattr.c      |  19 ++--
 fs/reiserfs/xattr_acl.c  |   4 +-
 include/linux/quota.h    |   2 +-
 include/linux/quotaops.h |  14 ++-
 21 files changed, 248 insertions(+), 243 deletions(-)

							Thanks
								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
