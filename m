Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C66F22E99F7
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Jan 2021 17:07:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728522AbhADQFr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Jan 2021 11:05:47 -0500
Received: from mx2.suse.de ([195.135.220.15]:59410 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728714AbhADQFk (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Jan 2021 11:05:40 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 833E6ACAF;
        Mon,  4 Jan 2021 16:04:58 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id B85D01E07FD; Mon,  4 Jan 2021 17:04:57 +0100 (CET)
Date:   Mon, 4 Jan 2021 17:04:57 +0100
From:   Jan Kara <jack@suse.cz>
To:     Shijie Luo <luoshijie1@huawei.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
        yangerkun@huawei.com, yi.zhang@huawei.com, linfeilong@huawei.com,
        jack@suse.cz
Subject: Re: [RFC PATCH RESEND] fs: fix a hungtask problem when
 freeze/unfreeze fs
Message-ID: <20210104160457.GG4018@quack2.suse.cz>
References: <20201226095641.17290-1-luoshijie1@huawei.com>
 <20201226155500.GB3579531@ZenIV.linux.org.uk>
 <870c4a20-ac5e-c755-fe8c-e1a192bffb29@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="sdtB3X0nJg68CQEu"
Content-Disposition: inline
In-Reply-To: <870c4a20-ac5e-c755-fe8c-e1a192bffb29@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--sdtB3X0nJg68CQEu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon 28-12-20 10:15:16, Shijie Luo wrote:
> 
> On 2020/12/26 23:55, Al Viro wrote:
> > On Sat, Dec 26, 2020 at 04:56:41AM -0500, Shijie Luo wrote:
> > 
> > > The root cause is that when offline/onlines disks, the filesystem can easily get into
> > > a error state and this makes it change to be read-only. Function freeze_super() will hold
> > > all sb_writers rwsems including rwsem of SB_FREEZE_WRITE when filesystem not read-only,
> > > but thaw_super_locked() cannot release these while the filesystem suddenly become read-only,
> > > because the logic will go to out.
> > > 
> > > freeze_super
> > >      hold sb_writers rwsems
> > >          sb->s_writers.frozen = SB_FREEZE_COMPLETE
> > >                                                   thaw_super_locked
> > >                                                       sb_rdonly
> > >                                                          sb->s_writers.frozen = SB_UNFROZEN;
> > >                                                              goto out // not release rwsems
> > > 
> > > And at this time, if we call mnt_want_write(), the process will be blocked.
> > > 
> > > This patch fixes this problem, when filesystem is read-only, just not to set sb_writers.frozen
> > > be SB_FREEZE_COMPLETE in freeze_super() and then release all rwsems in thaw_super_locked.
> > I really don't like that - you end up with a case when freeze_super() returns 0 *and*
> > consumes the reference it had been give.
> 
> Consuming the reference here because we won't "set frozen =
> SB_FREEZE_COMPLETE" in thaw_super_locked() now.
> 
> If don't do that, we never have a chance to consume it, thaw_super_locked()
> will directly return "-EINVAL". But I do
> 
> agree that it's not a good idea to return 0. How about returning "-EINVAL or
> -ENOTSUPP" ?
> 
> And, If we keep "frozen = SB_FREEZE_COMPLETE" in freeze_super() here, it
> will cause another problem, thaw_super_locked()
> 
> will always release rwsems in my logic, but freeze_super() won't acquire the
> rwsems when filesystem is read-only.

I was thinking about this for a while. I think the best solution would be
to track whether the fs was read only (and thus frozen without locking
percpu semaphores) at the time of freezing. I'm attaching that patch. Does
it fix your problem?

									Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

--sdtB3X0nJg68CQEu
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment; filename="0001-fs-fix-a-hungtask-problem-when-freeze-unfreeze-fs.patch"

From f9df0208f3c9cdc973bd6a7ff86282bf31893352 Mon Sep 17 00:00:00 2001
From: Jan Kara <jack@suse.cz>
Date: Mon, 4 Jan 2021 16:49:13 +0100
Subject: [PATCH] fs: fix a hungtask problem when freeze/unfreeze fs

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

Reported-by: Shijie Luo <luoshijie1@huawei.com>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/super.c         | 9 ++++++++-
 include/linux/fs.h | 4 +++-
 2 files changed, 11 insertions(+), 2 deletions(-)

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


--sdtB3X0nJg68CQEu--
