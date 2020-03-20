Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6360C18D68D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Mar 2020 19:07:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727177AbgCTSHz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Mar 2020 14:07:55 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44157 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726878AbgCTSHz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Mar 2020 14:07:55 -0400
Received: by mail-pf1-f193.google.com with SMTP id b72so3673575pfb.11
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Mar 2020 11:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8cYhw1x3X+9G66J6lbMzSNWTH95dWs9QxQXagZJVDkI=;
        b=XTvrkA0zw4NZeTUg3pRGwWcO8eTNUIZoU3c7RT3nbOK3rzpwhXH2jOWtx3VkQk4vM6
         qrktKN0nK6LU3+GPlJXia6wej6tGH4LdwFvuB1Pt45TYNBarEBdYZxg1nzICLzEfQaWQ
         Jt9Stn23XkWmmmR6qXe4ndaSxOjwduarnduZ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8cYhw1x3X+9G66J6lbMzSNWTH95dWs9QxQXagZJVDkI=;
        b=WQN1oJ5XU6j1iBY2uBCYWuMzS68FB2SqfwkbANX1mwI+vA+wAghHR+YUHN63IXEVTX
         /hEH9tpJbtFRzpM6kRpVyV+0LZ9hK17SGfX0PxAwdJT6n2/OKdMWqzEKHWqN1KCRDLJd
         vVyxpqdhQAwOiC3d43NawrR+QhBLJEyrYeA9YFAnlF2hdYWBEm9ZL+RtyN7mDmMEJ3mb
         3DdqnbD11WMIS6CwUIaW6HiQpqyEEGR8t+kQsmXBGzplXPq9xQF9JLDuai+hyF/O3NQp
         SFRA2ZoBdnUfzx/18P/8Qr5EWZVETvHDevI2bcnslr3oq6+udAXqWlCe6G/RBT0qcdWQ
         OGQQ==
X-Gm-Message-State: ANhLgQ15z5/GGenEBWod3lB9jTEZ4iIlRii85BMbp8UahS6WJ//SD5I4
        eSJ5kM1PNHe7H+r+NGNGQM5hpw==
X-Google-Smtp-Source: ADFU+vvJvJ6tsDQQpCc7np3SIbiYcaF2vndzvesHmJ1ZrWxXTMLR0GpWgue0+UlmtTQBsT3dbzL3hw==
X-Received: by 2002:aa7:8f36:: with SMTP id y22mr10894952pfr.162.1584727672286;
        Fri, 20 Mar 2020 11:07:52 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id c190sm5872717pga.35.2020.03.20.11.07.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2020 11:07:51 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Paolo Valente <paolo.valente@linaro.org>,
        Salman Qazi <sqazi@google.com>,
        Guenter Roeck <groeck@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] bdev: Reduce time holding bd_mutex in sync in blkdev_close()
Date:   Fri, 20 Mar 2020 11:07:16 -0700
Message-Id: <20200320110321.1.I9df0264e151a740be292ad3ee3825f31b5997776@changeid>
X-Mailer: git-send-email 2.25.1.696.g5e7596f4ac-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

While trying to "dd" to the block device for a USB stick, I
encountered a hung task warning (blocked for > 120 seconds).  I
managed to come up with an easy way to reproduce this on my system
(where /dev/sdb is the block device for my USB stick) with:

  while true; do dd if=/dev/zero of=/dev/sdb bs=4M; done

With my reproduction here are the relevant bits from the hung task
detector:

 INFO: task udevd:294 blocked for more than 122 seconds.
 ...
 udevd           D    0   294      1 0x00400008
 Call trace:
  ...
  mutex_lock_nested+0x40/0x50
  __blkdev_get+0x7c/0x3d4
  blkdev_get+0x118/0x138
  blkdev_open+0x94/0xa8
  do_dentry_open+0x268/0x3a0
  vfs_open+0x34/0x40
  path_openat+0x39c/0xdf4
  do_filp_open+0x90/0x10c
  do_sys_open+0x150/0x3c8
  ...

 ...
 Showing all locks held in the system:
 ...
 1 lock held by dd/2798:
  #0: ffffff814ac1a3b8 (&bdev->bd_mutex){+.+.}, at: __blkdev_put+0x50/0x204
 ...
 dd              D    0  2798   2764 0x00400208
 Call trace:
  ...
  schedule+0x8c/0xbc
  io_schedule+0x1c/0x40
  wait_on_page_bit_common+0x238/0x338
  __lock_page+0x5c/0x68
  write_cache_pages+0x194/0x500
  generic_writepages+0x64/0xa4
  blkdev_writepages+0x24/0x30
  do_writepages+0x48/0xa8
  __filemap_fdatawrite_range+0xac/0xd8
  filemap_write_and_wait+0x30/0x84
  __blkdev_put+0x88/0x204
  blkdev_put+0xc4/0xe4
  blkdev_close+0x28/0x38
  __fput+0xe0/0x238
  ____fput+0x1c/0x28
  task_work_run+0xb0/0xe4
  do_notify_resume+0xfc0/0x14bc
  work_pending+0x8/0x14

The problem appears related to the fact that my USB disk is terribly
slow and that I have a lot of RAM in my system to cache things.
Specifically my writes seem to be happening at ~15 MB/s and I've got
~4 GB of RAM in my system that can be used for buffering.  To write 4
GB of buffer to disk thus takes ~4000 MB / ~15 MB/s = ~267 seconds.

The 267 second number is a problem because in __blkdev_put() we call
sync_blockdev() while holding the bd_mutex.  Any other callers who
want the bd_mutex will be blocked for the whole time.

The problem is made worse because I believe blkdev_put() specifically
tells other tasks (namely udev) to go try to access the device at right
around the same time we're going to hold the mutex for a long time.

Putting some traces around this (after disabling the hung task detector),
I could confirm:
 dd:    437.608600: __blkdev_put() right before sync_blockdev() for sdb
 udevd: 437.623901: blkdev_open() right before blkdev_get() for sdb
 dd:    661.468451: __blkdev_put() right after sync_blockdev() for sdb
 udevd: 663.820426: blkdev_open() right after blkdev_get() for sdb

A simple fix for this is to realize that sync_blockdev() works fine if
you're not holding the mutex.  Also, it's not the end of the world if
you sync a little early (though it can have performance impacts).
Thus we can make a guess that we're going to need to do the sync and
then do it without holding the mutex.  We still do one last sync with
the mutex but it should be much, much faster.

With this, my hung task warnings for my test case are gone.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
I didn't put a "Fixes" annotation here because, as far as I can tell,
this issue has been here "forever" unless someone knows of something
else that changed that made this possible to hit.  This could probably
get picked back to any stable tree that anyone is still maintaining.

 fs/block_dev.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index 69bf2fb6f7cd..e92c667c4031 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -1881,6 +1881,20 @@ static void __blkdev_put(struct block_device *bdev, fmode_t mode, int for_part)
 	struct block_device *victim = NULL;
 
 	mutex_lock_nested(&bdev->bd_mutex, for_part);
+	if (bdev->bd_openers == 1) {
+		/*
+		 * Sync early if it looks like we're the last one.  If someone
+		 * else opens the block device between now and the decrement
+		 * of bd_openers then we did a sync that we didn't need to,
+		 * but that's not the end of the world and we want to avoid
+		 * long (could be several minute) syncs while holding the
+		 * mutex.
+		 */
+		mutex_unlock(&bdev->bd_mutex);
+		sync_blockdev(bdev);
+		mutex_lock_nested(&bdev->bd_mutex, for_part);
+	}
+
 	if (for_part)
 		bdev->bd_part_count--;
 
-- 
2.25.1.696.g5e7596f4ac-goog

