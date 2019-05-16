Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C7BD20634
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 May 2019 13:59:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728358AbfEPLsX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 May 2019 07:48:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:39348 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727505AbfEPLsW (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 May 2019 07:48:22 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 31D10ACAA;
        Thu, 16 May 2019 11:48:19 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 364101E3ED6; Thu, 16 May 2019 13:48:17 +0200 (CEST)
Date:   Thu, 16 May 2019 13:48:17 +0200
From:   Jan Kara <jack@suse.cz>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        syzbot <syzbot+10007d66ca02b08f0e60@syzkaller.appspotmail.com>,
        dvyukov@google.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        linux-block@vger.kernel.org
Subject: Re: INFO: task hung in __get_super
Message-ID: <20190516114817.GD13274@quack2.suse.cz>
References: <0000000000002cd22305879b22c4@google.com>
 <201905150102.x4F12b6o009249@www262.sakura.ne.jp>
 <20190515102133.GA16193@quack2.suse.cz>
 <024bba2a-4d2f-1861-bfd9-819511bdf6eb@i-love.sakura.ne.jp>
 <20190515130730.GA9526@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="/04w6evG8XlLl3ft"
Content-Disposition: inline
In-Reply-To: <20190515130730.GA9526@quack2.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--/04w6evG8XlLl3ft
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed 15-05-19 15:07:30, Jan Kara wrote:
> On Wed 15-05-19 20:32:27, Tetsuo Handa wrote:
> > On 2019/05/15 19:21, Jan Kara wrote:
> > > The question is how to fix this problem. The simplest fix I can see is that
> > > we'd just refuse to do LOOP_SET_FD if someone has the block device
> > > exclusively open as there are high chances such user will be unpleasantly
> > > surprised by the device changing under him. OTOH this has some potential
> > > for userspace visible regressions. But I guess it's worth a try. Something
> > > like attached patch?
> > 
> > (1) If I understand correctly, FMODE_EXCL is set at blkdev_open() only if
> > O_EXCL is specified.
> 
> Yes.
> 
> > How can we detect if O_EXCL was not used, for the reproducer (
> > https://syzkaller.appspot.com/text?tag=ReproC&x=135385a8a00000 ) is not
> > using O_EXCL ?
> 
> mount_bdev() is using O_EXCL and that's what matters.
> 
> > (2) There seems to be no serialization. What guarantees that mount_bdev()
> >     does not start due to preempted after the check added by this patch?
> 
> That's a good question. lo_ctl_mutex actually synchronizes most of this
> (taken in both loop_set_fd() and lo_open()) but you're right that there's
> still a small race window where loop_set_fd() need not see bdev->bd_holders
> elevated while blkdev_get() will succeed. So I need to think a bit more
> about proper synchronization of this.

OK, so non-racy fix was a bit more involved and I've ended up just
upgrading the file reference to an exclusive one in loop_set_fd() instead
of trying to hand-craft some locking solution. The result is attached and
it passes blktests.

Let syzbot also test it:

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git v5.1

									Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

--/04w6evG8XlLl3ft
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment; filename="0001-loop-Don-t-change-loop-device-under-exclusive-opener.patch"

From e7a35f48a902b42894eba8cc4201ca745bfd5dfe Mon Sep 17 00:00:00 2001
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
 drivers/block/loop.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 102d79575895..f11b7dc16e9d 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -945,9 +945,20 @@ static int loop_set_fd(struct loop_device *lo, fmode_t mode,
 	if (!file)
 		goto out;
 
+	/*
+	 * If we don't hold exclusive handle for the device, upgrade to it
+	 * here to avoid changing device under exclusive owner.
+	 */
+	if (!(mode & FMODE_EXCL)) {
+		bdgrab(bdev);
+		error = blkdev_get(bdev, mode | FMODE_EXCL, loop_set_fd);
+		if (error)
+			goto out_putf;
+	}
+
 	error = mutex_lock_killable(&loop_ctl_mutex);
 	if (error)
-		goto out_putf;
+		goto out_bdev;
 
 	error = -EBUSY;
 	if (lo->lo_state != Lo_unbound)
@@ -1012,10 +1023,15 @@ static int loop_set_fd(struct loop_device *lo, fmode_t mode,
 	mutex_unlock(&loop_ctl_mutex);
 	if (partscan)
 		loop_reread_partitions(lo, bdev);
+	if (!(mode & FMODE_EXCL))
+		blkdev_put(bdev, mode | FMODE_EXCL);
 	return 0;
 
 out_unlock:
 	mutex_unlock(&loop_ctl_mutex);
+out_bdev:
+	if (!(mode & FMODE_EXCL))
+		blkdev_put(bdev, mode | FMODE_EXCL);
 out_putf:
 	fput(file);
 out:
-- 
2.16.4


--/04w6evG8XlLl3ft--
