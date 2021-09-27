Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 693D2419910
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Sep 2021 18:38:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235600AbhI0Qjy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Sep 2021 12:39:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235552AbhI0Qju (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Sep 2021 12:39:50 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70849C061770;
        Mon, 27 Sep 2021 09:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=w925P6ItKF9rs87b7yDYFnpWVAY11Rt3apCJxCqDXyQ=; b=cVEW7XBpskdyaWzz+3jArNQHmi
        MCLY9v/lIcIf8sRDGyAUOeWqh09vvpDVz22dy18XdoiLOZb/9DB7gYQWutszDRR2tjc1kB1Qd9IOB
        213dMl+WuE1pk6C5XAOLsBx630fDe/Ah5y/ox5jAPktbMNfnjNvPHEnZg6m572Jehqdrp/PB5UFnz
        MsexloYyFxxXBHHAUUpev5Gz6PgmyOJOg3mvE+2dkxpGHnHie0orcgNohdscTYLMuoGfWc8iDtGVo
        iR5a3yl8AQPlGlS0qKTAtu+W+Q9uiyR2kmAhuxuh/sLVY9BWKk/zgJcBY2fCThOewse9ktYeNPGCd
        hEoM03fg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mUtdn-003OSv-8t; Mon, 27 Sep 2021 16:38:07 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     tj@kernel.org, gregkh@linuxfoundation.org,
        akpm@linux-foundation.org, minchan@kernel.org, jeyu@kernel.org,
        shuah@kernel.org
Cc:     bvanassche@acm.org, dan.j.williams@intel.com, joe@perches.com,
        tglx@linutronix.de, mcgrof@kernel.org, keescook@chromium.org,
        rostedt@goodmis.org, linux-spdx@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v8 12/12] zram: use ATTRIBUTE_GROUPS to fix sysfs deadlock module removal
Date:   Mon, 27 Sep 2021 09:38:05 -0700
Message-Id: <20210927163805.808907-13-mcgrof@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210927163805.808907-1-mcgrof@kernel.org>
References: <20210927163805.808907-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The ATTRIBUTE_GROUPS is typically used to avoid boiler plate
code which is used in many drivers. Embracing ATTRIBUTE_GROUPS was
long due on the zram driver, however a recent fix for sysfs allows
users of ATTRIBUTE_GROUPS to also associate a module to the group
attribute.

In zram's case this also means it allows us to fix a race which triggers
a deadlock on the zram driver. This deadlock happens when a sysfs attribute
use a lock also used on module removal. This happens when for instance a
sysfs file on a driver is used, then at the same time we have module
removal call trigger. The module removal call code holds a lock, and then
the sysfs file entry waits for the same lock. While holding the lock the
module removal tries to remove the sysfs entries, but these cannot be
removed yet as one is waiting for a lock. This won't complete as the lock
is already held. Likewise module removal cannot complete, and so we
deadlock.

Sysfs fixes this when the group attributes have a module associated to
it, sysfs will *try* to get a refcount to the module when a shared
lock is used, prior to mucking with a sysfs attribute. If this fails we
just give up right away.

This deadlock was first reported with the zram driver, a sketch of how
this can happen follows:

CPU A                              CPU B
                                   whatever_store()
module_unload
  mutex_lock(foo)
                                   mutex_lock(foo)
   del_gendisk(zram->disk);
     device_del()
       device_remove_groups()

In this situation whatever_store() is waiting for the mutex foo to
become unlocked, but that won't happen until module removal is complete.
But module removal won't complete until the sysfs file being poked
completes which is waiting for a lock already held.

This issue can be reproduced easily on the zram driver as follows:

Loop 1 on one terminal:

while true;
	do modprobe zram;
	modprobe -r zram;
done

Loop 2 on a second terminal:
while true; do
	echo 1024 >  /sys/block/zram0/disksize;
	echo 1 > /sys/block/zram0/reset;
done

Without this patch we end up in a deadlock, and the following
stack trace is produced which hints to us what the issue was:

INFO: task bash:888 blocked for more than 120 seconds.
      Tainted: G            E 5.12.0-rc1-next-20210304+ #4
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:bash            state:D stack:    0 pid:  888 ppid: 887 flags:<etc>
Call Trace:
 __schedule+0x2e4/0x900
 schedule+0x46/0xb0
 schedule_preempt_disabled+0xa/0x10
 __mutex_lock.constprop.0+0x2c3/0x490
 ? _kstrtoull+0x35/0xd0
 reset_store+0x6c/0x160 [zram]
 kernfs_fop_write_iter+0x124/0x1b0
 new_sync_write+0x11c/0x1b0
 vfs_write+0x1c2/0x260
 ksys_write+0x5f/0xe0
 do_syscall_64+0x33/0x80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f34f2c3df33
RSP: 002b:00007ffe751df6e8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007f34f2c3df33
RDX: 0000000000000002 RSI: 0000561ccb06ec10 RDI: 0000000000000001
RBP: 0000561ccb06ec10 R08: 000000000000000a R09: 0000000000000001
R10: 0000561ccb157590 R11: 0000000000000246 R12: 0000000000000002
R13: 00007f34f2d0e6a0 R14: 0000000000000002 R15: 00007f34f2d0e8a0
INFO: task modprobe:1104 can't die for more than 120 seconds.
task:modprobe        state:D stack:    0 pid: 1104 ppid: 916 flags:<etc>
Call Trace:
 __schedule+0x2e4/0x900
 schedule+0x46/0xb0
 __kernfs_remove.part.0+0x228/0x2b0
 ? finish_wait+0x80/0x80
 kernfs_remove_by_name_ns+0x50/0x90
 remove_files+0x2b/0x60
 sysfs_remove_group+0x38/0x80
 sysfs_remove_groups+0x29/0x40
 device_remove_attrs+0x4a/0x80
 device_del+0x183/0x3e0
 ? mutex_lock+0xe/0x30
 del_gendisk+0x27a/0x2d0
 zram_remove+0x8a/0xb0 [zram]
 ? hot_remove_store+0xf0/0xf0 [zram]
 zram_remove_cb+0xd/0x10 [zram]
 idr_for_each+0x5e/0xd0
 destroy_devices+0x39/0x6f [zram]
 __do_sys_delete_module+0x190/0x2a0
 do_syscall_64+0x33/0x80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f32adf727d7
RSP: 002b:00007ffc08bb38a8 EFLAGS: 00000206 ORIG_RAX: 00000000000000b0
RAX: ffffffffffffffda RBX: 000055eea23cbb10 RCX: 00007f32adf727d7
RDX: 0000000000000000 RSI: 0000000000000800 RDI: 000055eea23cbb78
RBP: 000055eea23cbb10 R08: 0000000000000000 R09: 0000000000000000
R10: 00007f32adfe5ac0 R11: 0000000000000206 R12: 000055eea23cbb78
R13: 0000000000000000 R14: 0000000000000000 R15: 000055eea23cbc20

[0] https://lkml.kernel.org/r/20210401235925.GR4332@42.do-not-panic.com

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 drivers/block/zram/zram_drv.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index b26abcb955cc..60a55ae8cd91 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1902,14 +1902,7 @@ static struct attribute *zram_disk_attrs[] = {
 	NULL,
 };
 
-static const struct attribute_group zram_disk_attr_group = {
-	.attrs = zram_disk_attrs,
-};
-
-static const struct attribute_group *zram_disk_attr_groups[] = {
-	&zram_disk_attr_group,
-	NULL,
-};
+ATTRIBUTE_GROUPS(zram_disk);
 
 /*
  * Allocate and initialize new zram device. the function returns
@@ -1981,7 +1974,7 @@ static int zram_add(void)
 		blk_queue_max_write_zeroes_sectors(zram->disk->queue, UINT_MAX);
 
 	blk_queue_flag_set(QUEUE_FLAG_STABLE_WRITES, zram->disk->queue);
-	device_add_disk(NULL, zram->disk, zram_disk_attr_groups);
+	device_add_disk(NULL, zram->disk, zram_disk_groups);
 
 	strlcpy(zram->compressor, default_compressor, sizeof(zram->compressor));
 
-- 
2.30.2

