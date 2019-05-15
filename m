Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF09E1EC02
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 May 2019 12:21:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726394AbfEOKVi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 May 2019 06:21:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:51722 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725939AbfEOKVi (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 May 2019 06:21:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8F1D6AE8B;
        Wed, 15 May 2019 10:21:36 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 6C0E81E3CA1; Wed, 15 May 2019 12:21:33 +0200 (CEST)
Date:   Wed, 15 May 2019 12:21:33 +0200
From:   Jan Kara <jack@suse.cz>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        syzbot <syzbot+10007d66ca02b08f0e60@syzkaller.appspotmail.com>,
        dvyukov@google.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        linux-block@vger.kernel.org
Subject: Re: INFO: task hung in __get_super
Message-ID: <20190515102133.GA16193@quack2.suse.cz>
References: <0000000000002cd22305879b22c4@google.com>
 <201905150102.x4F12b6o009249@www262.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="YiEDa0DAkWCtVeE4"
Content-Disposition: inline
In-Reply-To: <201905150102.x4F12b6o009249@www262.sakura.ne.jp>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--YiEDa0DAkWCtVeE4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed 15-05-19 10:02:37, Tetsuo Handa wrote:
> Since lo_ioctl() is calling sb_set_blocksize() immediately after udf_load_vrs()
> called sb_set_blocksize(), udf_tread() can't use expected i_blkbits settings...

Thanks for debugging this but this doesn't quiet make sense to me. See
below:

> [   48.685672][ T7322] fs/block_dev.c:135 bdev=0000000014fa0ec2 12 -> 9
> [   48.694675][ T7322] CPU: 4 PID: 7322 Comm: a.out Not tainted 5.1.0+ #196
> [   48.701321][ T7322] Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 04/13/2018
> [   48.710265][ T7322] Call Trace:
> [   48.710272][ T7322]  dump_stack+0xaa/0xd8
> [   48.715633][ T7322]  set_blocksize+0xff/0x140
> [   48.822094][ T7322]  sb_set_blocksize+0x27/0x70
> [   48.824843][ T7322]  udf_load_vrs+0x4b/0x500
> [   48.827322][ T7322]  udf_fill_super+0x32e/0x890
> [   48.830125][ T7322]  ? snprintf+0x66/0x90
> [   48.832572][ T7322]  mount_bdev+0x1c7/0x210
> [   48.835293][ T7322]  ? udf_load_vrs+0x500/0x500
> [   48.838009][ T7322]  udf_mount+0x34/0x40
> [   48.840504][ T7322]  legacy_get_tree+0x2d/0x80
> [   48.843192][ T7322]  vfs_get_tree+0x30/0x140
> [   48.845787][ T7322]  do_mount+0x830/0xc30
> [   48.848325][ T7322]  ? copy_mount_options+0x152/0x1c0
> [   48.851066][ T7322]  ksys_mount+0xab/0x120
> [   48.853627][ T7322]  __x64_sys_mount+0x26/0x30
> [   48.856168][ T7322]  do_syscall_64+0x7c/0x1a0
> [   48.858943][ T7322]  entry_SYSCALL_64_after_hwframe+0x44/0xa9

So this is normal - UDF sets block size it wants on the device during
mount. Now we have the block device exclusively open so nobody should be
changing it.

> [   48.978376][ T7332] fs/block_dev.c:135 bdev=0000000014fa0ec2 9 -> 12
> [   49.079394][ T7332] CPU: 6 PID: 7332 Comm: a.out Not tainted 5.1.0+ #196
> [   49.082769][ T7332] Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 04/13/2018
> [   49.089007][ T7332] Call Trace:
> [   49.091410][ T7332]  dump_stack+0xaa/0xd8
> [   49.094053][ T7332]  set_blocksize+0xff/0x140
> [   49.096734][ T7332]  lo_ioctl+0x570/0xc60
> [   49.099366][ T7332]  ? loop_queue_work+0xdb0/0xdb0
> [   49.102079][ T7332]  blkdev_ioctl+0xb69/0xc10
> [   49.104667][ T7332]  block_ioctl+0x56/0x70
> [   49.107267][ T7332]  ? blkdev_fallocate+0x230/0x230
> [   49.110035][ T7332]  do_vfs_ioctl+0xc1/0x7e0
> [   49.112728][ T7332]  ? tomoyo_file_ioctl+0x23/0x30
> [   49.115452][ T7332]  ksys_ioctl+0x94/0xb0
> [   49.118008][ T7332]  __x64_sys_ioctl+0x1e/0x30
> [   49.120686][ T7332]  do_syscall_64+0x7c/0x1a0
> [   49.123470][ T7332]  entry_SYSCALL_64_after_hwframe+0x44/0xa9

And this is strange. set_blocksize() is only called from loop_set_fd() but
that means that the loop device must already be in lo->lo_state ==
Lo_unbound. But loop device that is being used should never be in
Lo_unbound state... Except if... Oh, I see what the problem is:

UDF opens unbound loop device (through mount_bdev() ->
blkdev_get_by_path()). That succeeds as loop allows opens on unbound
devices so that ioctl can be run to set it up. UDF sets block size for the
block device. Someone else comes and calls LOOP_SET_FD for the device and
plop, block device block size changes under UDF's hands.

The question is how to fix this problem. The simplest fix I can see is that
we'd just refuse to do LOOP_SET_FD if someone has the block device
exclusively open as there are high chances such user will be unpleasantly
surprised by the device changing under him. OTOH this has some potential
for userspace visible regressions. But I guess it's worth a try. Something
like attached patch?

Let syzbot test the patch as well:

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git v5.1

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

--YiEDa0DAkWCtVeE4
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment; filename="0001-loop-Don-t-change-loop-device-under-exclusive-opener.patch"

From 0145358ae24581b7af36261caee0c6dbe22cce0c Mon Sep 17 00:00:00 2001
From: Jan Kara <jack@suse.cz>
Date: Wed, 15 May 2019 11:45:10 +0200
Subject: [PATCH] loop: Don't change loop device under exclusive opener

Loop module allows calling LOOP_SET_FD while there are other openers of
the loop device. Even exclusive ones. This can lead to weird
consequences such as kernel deadlocks like:

mount_bdev()				lo_ioctl()
  udf_fill_super()
    udf_load_vrs()
      sb_set_blocksize() - sets desired block size B
      udf_tread()
        sb_bread()
          __bread_gfp(bdev, block, B)
					  loop_set_fd()
					    set_blocksize()
            - now __getblk_slow() indefinitely loops because B != bdev
              block size

Fix the problem by disallowing LOOP_SET_FD ioctl when there are
exclusive openers of a loop device.

[Deliberately chosen not to CC stable as a user with priviledges to
trigger this race has other means of taking the system down and this
has a potential of breaking some weird userspace setup]

Reported-by: syzbot+10007d66ca02b08f0e60@syzkaller.appspotmail.com
Signed-off-by: Jan Kara <jack@suse.cz>
---
 drivers/block/loop.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 102d79575895..9dcf8bb60c4e 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -952,6 +952,9 @@ static int loop_set_fd(struct loop_device *lo, fmode_t mode,
 	error = -EBUSY;
 	if (lo->lo_state != Lo_unbound)
 		goto out_unlock;
+	/* Avoid changing loop device under an exclusive opener... */
+	if (!(mode & FMODE_EXCL) && bdev->bd_holders > 0)
+		goto out_unlock;
 
 	error = loop_validate_file(file, bdev);
 	if (error)
-- 
2.16.4


--YiEDa0DAkWCtVeE4--
