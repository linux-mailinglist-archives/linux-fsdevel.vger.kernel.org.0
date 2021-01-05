Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 960F12EAC37
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Jan 2021 14:47:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726961AbhAENqq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Jan 2021 08:46:46 -0500
Received: from mx2.suse.de ([195.135.220.15]:43748 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725919AbhAENqq (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Jan 2021 08:46:46 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 525BCADD6;
        Tue,  5 Jan 2021 13:46:04 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 11A711E07FD; Tue,  5 Jan 2021 14:46:04 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     Al Viro <viro@ZenIV.linux.org.uk>
Cc:     <linux-fsdevel@vger.kernel.org>,
        Shijie Luo <luoshijie1@huawei.com>, Jan Kara <jack@suse.cz>
Subject: [PATCH] fs: fix a hungtask problem when freeze/unfreeze fs
Date:   Tue,  5 Jan 2021 14:46:00 +0100
Message-Id: <20210105134600.24022-1-jack@suse.cz>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We found the following deadlock when running xfstests generic/390 with ext4
filesystem, and simutaneously offlining/onlining the disk we tested. It will
cause a deadlock whose call trace is like this:

fsstress        D    0 11672  11625 0x00000080
Call Trace:
 ? __schedule+0x2fc/0x930
 ? filename_parentat+0x10b/0x1a0
 schedule+0x28/0x70
 rwsem_down_read_failed+0x102/0x1c0
 ? __percpu_down_read+0x93/0xb0
 __percpu_down_read+0x93/0xb0
 __sb_start_write+0x5f/0x70
 mnt_want_write+0x20/0x50
 do_renameat2+0x1f3/0x550
 __x64_sys_rename+0x1c/0x20
 do_syscall_64+0x5b/0x1b0
 entry_SYSCALL_64_after_hwframe+0x65/0xca

The root cause is that when ext4 hits IO error due to disk being
offline, it will switch itself into read-only state. When it is frozen
at that moment, following thaw_super() call will not unlock percpu
freeze semaphores (as the fs is read-only) causing the deadlock.

Fix the problem by tracking whether the superblock was read-only at the
time we were freezing it.

Reported-and-tested-by: Shijie Luo <luoshijie1@huawei.com>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/super.c         | 9 ++++++++-
 include/linux/fs.h | 4 +++-
 2 files changed, 11 insertions(+), 2 deletions(-)

Al, can you pick up this patch please? Thanks!

diff --git a/fs/super.c b/fs/super.c
index 2c6cdea2ab2d..c35a2938ee99 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -1674,10 +1674,12 @@ int freeze_super(struct super_block *sb)
 	if (sb_rdonly(sb)) {
 		/* Nothing to do really... */
 		sb->s_writers.frozen = SB_FREEZE_COMPLETE;
+		sb->s_writers.frozen_ro = 1;
 		up_write(&sb->s_umount);
 		return 0;
 	}
 
+	sb->s_writers.frozen_ro = 0;
 	sb->s_writers.frozen = SB_FREEZE_WRITE;
 	/* Release s_umount to preserve sb_start_write -> s_umount ordering */
 	up_write(&sb->s_umount);
@@ -1733,7 +1735,12 @@ static int thaw_super_locked(struct super_block *sb)
 		return -EINVAL;
 	}
 
-	if (sb_rdonly(sb)) {
+	/*
+	 * Was the fs frozen in read-only state? Note that we cannot just check
+	 * sb_rdonly(sb) as the filesystem might have switched to read-only
+	 * state due to internal errors or so.
+	 */
+	if (sb->s_writers.frozen_ro) {
 		sb->s_writers.frozen = SB_UNFROZEN;
 		goto out;
 	}
diff --git a/include/linux/fs.h b/include/linux/fs.h
index ad4cf1bae586..346ab981128f 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1406,7 +1406,9 @@ enum {
 #define SB_FREEZE_LEVELS (SB_FREEZE_COMPLETE - 1)
 
 struct sb_writers {
-	int				frozen;		/* Is sb frozen? */
+	unsigned short			frozen;		/* Is sb frozen? */
+	unsigned short			frozen_ro;	/* Was sb read-only
+							 * when frozen? */
 	wait_queue_head_t		wait_unfrozen;	/* wait for thaw */
 	struct percpu_rw_semaphore	rw_sem[SB_FREEZE_LEVELS];
 };
-- 
2.26.2

