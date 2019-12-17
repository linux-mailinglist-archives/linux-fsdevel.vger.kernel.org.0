Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CEB9B1239CB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2019 23:21:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727386AbfLQWUQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Dec 2019 17:20:16 -0500
Received: from mout.kundenserver.de ([217.72.192.75]:58879 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725812AbfLQWRi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Dec 2019 17:17:38 -0500
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MQvL7-1iMdCi0pIl-00Nzc1; Tue, 17 Dec 2019 23:17:27 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Jens Axboe <axboe@kernel.dk>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
        y2038@lists.linaro.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        linux-doc@vger.kernel.org, corbet@lwn.net, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v2 09/27] compat_ioctl: block: add blkdev_compat_ptr_ioctl
Date:   Tue, 17 Dec 2019 23:16:50 +0100
Message-Id: <20191217221708.3730997-10-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20191217221708.3730997-1-arnd@arndb.de>
References: <20191217221708.3730997-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:mmtIkLxrwk7IQXXnRkJ8B+2FIyyyAbad/kCKhLBtclkyPF95FPH
 voKZ435khGb/rtE1AmYopeqLW2Enb6KjMU3aHMym/CCIeJ/134i1nElJvTyehEziysCaITM
 SGbQa8uXWK/Gqpwle4RlSqWWAEeHhE5oGw3U/w5L4R9Gyz1IQ2GtGKJ+dZ+hCIQ41q9oCmS
 PrBKnTbrQ5fXsSHRxWF0g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:OkErmRAfum4=:bs5oIeyGgjC4U4aWDbZOh/
 DKd6onqIBwE2F0QpDgEetsTHqsV3372e0VrgDPYOum5LGyL+OEpI7a6ZuXY9jRiPihpaADr9T
 Ompi+2P4wiwfsZB77EX0NaNyyQ3d56ZiAiwwnLIhCLKlQ5FcCdYsIcVHg8IVxcKGbsf7WO3HP
 yS3YOdMtZO54LDweou2QG+Gww28abxwoFWLKKJT+p21mTw+ed/lStSFmes+A4f/PZ8kV8e5mi
 t4CLRzsQnWIznOyIq/ACNZ0kowqowqANtKXMTlIPWJD8GFj/VP3xHhx4xIlFxoGV9D8VDGWsH
 k+H6YDRNpvOGm4tc+9hqGTp8tWHdOD0XrxYq3MPpZOfTbCTlreslmPLaaGZt2gzGZCQNIcjCb
 U3QsQLRZwxaM00qJ68lUE2OlgcF7GehYglqWw0GKSVz5O/BlJA3t2RLJ6WWU1GsqKAk3P65Xf
 XGdWsPJzhcMWQLKUDTk7DlJr89QMsW1hJBIKo+gZGval4+f9aS/2h/FdqRd2m2xj9lArCuFZW
 a8R6Jfno0WOYH7FOvtR/c5ZI/nRrk4qK+McQBCuN/Q8F7cquTJNK10Sx1GaXRLmuA976QnXUz
 TBNZog8h2P+hz/RwrUI+ZDuPwOkbtQ3kD3qoPl9WoczeSVg4mTxXfCTuSjC4nlnVsIl/QY+Kp
 6mRU6liGwyZ/RzBwhFt1f0Twtiiktxc0CDwZKi5SjUZAk96OS5OkeAvMkPBFIND/q7H1gAar7
 a6CEbahPDVLIuBSAnCHjXF5/z47fABYF9GMYjz7K36x+ubwf/8zsAJ3tCd7oFQYz8NjQi7Trj
 ns48wnfWSfwgS5/nU/H0tE/3dADWFoNlPT3nMY/eeAgj3xNboPaUo65ErYe/I4V7im3Bu2IbB
 Ynnhxam78HYgbnMQvjPQ==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

A lot of block drivers need only a trivial .compat_ioctl callback.

Add a helper function that can be set as the callback pointer
to only convert the argument using the compat_ptr() conversion
and otherwise assume all input and output data is compatible,
or handled using in_compat_syscall() checks.

This mirrors the compat_ptr_ioctl() helper function used in
character devices.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 block/ioctl.c          | 21 +++++++++++++++++++++
 include/linux/blkdev.h |  7 +++++++
 2 files changed, 28 insertions(+)

diff --git a/block/ioctl.c b/block/ioctl.c
index 5de98b97af2a..e728331d1a5b 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/capability.h>
+#include <linux/compat.h>
 #include <linux/blkdev.h>
 #include <linux/export.h>
 #include <linux/gfp.h>
@@ -285,6 +286,26 @@ int __blkdev_driver_ioctl(struct block_device *bdev, fmode_t mode,
  */
 EXPORT_SYMBOL_GPL(__blkdev_driver_ioctl);
 
+#ifdef CONFIG_COMPAT
+/*
+ * This is the equivalent of compat_ptr_ioctl(), to be used by block
+ * drivers that implement only commands that are completely compatible
+ * between 32-bit and 64-bit user space
+ */
+int blkdev_compat_ptr_ioctl(struct block_device *bdev, fmode_t mode,
+			unsigned cmd, unsigned long arg)
+{
+	struct gendisk *disk = bdev->bd_disk;
+
+	if (disk->fops->ioctl)
+		return disk->fops->ioctl(bdev, mode, cmd,
+					 (unsigned long)compat_ptr(arg));
+
+	return -ENOIOCTLCMD;
+}
+EXPORT_SYMBOL(blkdev_compat_ptr_ioctl);
+#endif
+
 static int blkdev_pr_register(struct block_device *bdev,
 		struct pr_registration __user *arg)
 {
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 47eb22a3b7f9..3e0408618da7 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1711,6 +1711,13 @@ struct block_device_operations {
 	const struct pr_ops *pr_ops;
 };
 
+#ifdef CONFIG_COMPAT
+extern int blkdev_compat_ptr_ioctl(struct block_device *, fmode_t,
+				      unsigned int, unsigned long);
+#else
+#define blkdev_compat_ptr_ioctl NULL
+#endif
+
 extern int __blkdev_driver_ioctl(struct block_device *, fmode_t, unsigned int,
 				 unsigned long);
 extern int bdev_read_page(struct block_device *, sector_t, struct page *);
-- 
2.20.0

