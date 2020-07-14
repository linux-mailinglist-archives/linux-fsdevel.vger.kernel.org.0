Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3812921FC69
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jul 2020 21:09:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731213AbgGNTI7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Jul 2020 15:08:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731036AbgGNTI5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Jul 2020 15:08:57 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E98D0C061755;
        Tue, 14 Jul 2020 12:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=sfIHTLE1JF+NmOWherz7KlGOZBlXciS7G8sTYUQJUQY=; b=sLOls4ywU2+T+2KTiNlRHczpS9
        C7/N7EV0Uo+tf4b9cAgQl9jAKCkMg/I/a+7Ch3wHVlA35CpozQ94cT3RLCmb7b+FpFONGjH9Do3aK
        dd/KvIAeNxNPXW2FujkNTBBuo/1GNZX8O3Mb9DQKdedZv+7zRMbIueKPHePI06F+/yMKezIXr1bCp
        /kraRPhQFrkkJQYzZ6NLA50YWvnvXHFA0BEd96YG3mI602kWCYLqO+T7Kpkt/IDngX7sZd9t8fs8E
        b3aJNvMmSYKNmFOSoP1DbqrfA/jTdPSle4ZLOZkZezIwH0pBeUb11rJ2G2f50XD3aodyn3tP5e5FG
        4mYFpyrQ==;
Received: from [2001:4bb8:188:5f50:f037:8cfe:627e:7028] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jvQIQ-0005pl-SQ; Tue, 14 Jul 2020 19:08:55 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     linux-kernel@vger.kernel.org
Cc:     "H. Peter Anvin" <hpa@zytor.com>, Song Liu <song@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-raid@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 05/23] md: replace the RAID_AUTORUN ioctl with a direct function call
Date:   Tue, 14 Jul 2020 21:04:09 +0200
Message-Id: <20200714190427.4332-6-hch@lst.de>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200714190427.4332-1-hch@lst.de>
References: <20200714190427.4332-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Instead of using a spcial RAID_AUTORUN ioctl that only exists for
non-modular builds and is only called from the early init code, just
call the actual function directly.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Acked-by: Song Liu <song@kernel.org>
---
 drivers/md/md-autodetect.c | 10 ++--------
 drivers/md/md.c            | 14 +-------------
 drivers/md/md.h            |  3 +++
 3 files changed, 6 insertions(+), 21 deletions(-)

diff --git a/drivers/md/md-autodetect.c b/drivers/md/md-autodetect.c
index fe806f7b9759a1..0eb746211ed53c 100644
--- a/drivers/md/md-autodetect.c
+++ b/drivers/md/md-autodetect.c
@@ -9,6 +9,7 @@
 #include <linux/raid/detect.h>
 #include <linux/raid/md_u.h>
 #include <linux/raid/md_p.h>
+#include "md.h"
 
 /*
  * When md (and any require personalities) are compiled into the kernel
@@ -285,8 +286,6 @@ __setup("md=", md_setup);
 
 static void __init autodetect_raid(void)
 {
-	int fd;
-
 	/*
 	 * Since we don't want to detect and use half a raid array, we need to
 	 * wait for the known devices to complete their probing
@@ -295,12 +294,7 @@ static void __init autodetect_raid(void)
 	printk(KERN_INFO "md: If you don't use raid, use raid=noautodetect\n");
 
 	wait_for_device_probe();
-
-	fd = ksys_open("/dev/md0", 0, 0);
-	if (fd >= 0) {
-		ksys_ioctl(fd, RAID_AUTORUN, raid_autopart);
-		ksys_close(fd);
-	}
+	md_autostart_arrays(raid_autopart);
 }
 
 void __init md_run_setup(void)
diff --git a/drivers/md/md.c b/drivers/md/md.c
index f567f536b529bd..6e9a48da474848 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -68,10 +68,6 @@
 #include "md-bitmap.h"
 #include "md-cluster.h"
 
-#ifndef MODULE
-static void autostart_arrays(int part);
-#endif
-
 /* pers_list is a list of registered personalities protected
  * by pers_lock.
  * pers_lock does extra service to protect accesses to
@@ -7421,7 +7417,6 @@ static inline bool md_ioctl_valid(unsigned int cmd)
 	case GET_DISK_INFO:
 	case HOT_ADD_DISK:
 	case HOT_REMOVE_DISK:
-	case RAID_AUTORUN:
 	case RAID_VERSION:
 	case RESTART_ARRAY_RW:
 	case RUN_ARRAY:
@@ -7467,13 +7462,6 @@ static int md_ioctl(struct block_device *bdev, fmode_t mode,
 	case RAID_VERSION:
 		err = get_version(argp);
 		goto out;
-
-#ifndef MODULE
-	case RAID_AUTORUN:
-		err = 0;
-		autostart_arrays(arg);
-		goto out;
-#endif
 	default:;
 	}
 
@@ -9721,7 +9709,7 @@ void md_autodetect_dev(dev_t dev)
 	}
 }
 
-static void autostart_arrays(int part)
+void md_autostart_arrays(int part)
 {
 	struct md_rdev *rdev;
 	struct detected_devices_node *node_detected_dev;
diff --git a/drivers/md/md.h b/drivers/md/md.h
index 612814d07d35ab..37315a3f28e97d 100644
--- a/drivers/md/md.h
+++ b/drivers/md/md.h
@@ -800,4 +800,7 @@ static inline void mddev_check_write_zeroes(struct mddev *mddev, struct bio *bio
 	    !bio->bi_disk->queue->limits.max_write_zeroes_sectors)
 		mddev->queue->limits.max_write_zeroes_sectors = 0;
 }
+
+void md_autostart_arrays(int part);
+
 #endif /* _MD_MD_H */
-- 
2.27.0

