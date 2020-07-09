Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97F1E21A32C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jul 2020 17:18:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728014AbgGIPSW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Jul 2020 11:18:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727978AbgGIPSV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Jul 2020 11:18:21 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC7DFC08C5CE;
        Thu,  9 Jul 2020 08:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=LpqL9i2xKT/stdVPfY21iDNhXvNHas6++utf6Lf7se8=; b=eG810+znGFJ0jodsUY6aF07eBO
        AB3RD4sYAjgVhjGXyrR43g+H5/QjLPSvBpx/7uV3utulCdUNJhZDsnJy//bbpiAmif0QV8rQLXm54
        GSLSF70Yn8OV6cB+BjsdpAf5QR64eHxR6LqAOGSubLpEmS4wud4MWB80I5NEkHJ4QeK9NkINX5ftY
        4w/v47AyYXhmFvbtSEQ4GqSsbnQBiXt/RMQotRVVPfH7mPhKsBdRtgnJBi73ZlcEWLVCiQf92bBr9
        b4AzY+ZxlImGMB1OOzJ46L2MKU2TeJuqUmaw6++nSk+injzC/tZomsEJf5ju3OPrvj9JKghYOm2bj
        IvZKvV6A==;
Received: from [2001:4bb8:188:5f50:7053:304b:bf82:82cf] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jtYJX-0005K5-1L; Thu, 09 Jul 2020 15:18:19 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     linux-kernel@vger.kernel.org
Cc:     "H. Peter Anvin" <hpa@zytor.com>, Song Liu <song@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-raid@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 02/17] md: move the early init autodetect code to drivers/md/
Date:   Thu,  9 Jul 2020 17:17:59 +0200
Message-Id: <20200709151814.110422-3-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200709151814.110422-1-hch@lst.de>
References: <20200709151814.110422-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Just like the NFS and CIFS root code this better lives with the
driver it is tightly integrated with.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/md/Makefile                               |  3 +++
 init/do_mounts_md.c => drivers/md/md-autodetect.c | 15 +++++++++++++--
 include/linux/raid/detect.h                       |  8 ++++++++
 init/Makefile                                     |  1 -
 init/do_mounts.c                                  |  1 +
 init/do_mounts.h                                  | 10 ----------
 6 files changed, 25 insertions(+), 13 deletions(-)
 rename init/do_mounts_md.c => drivers/md/md-autodetect.c (96%)

diff --git a/drivers/md/Makefile b/drivers/md/Makefile
index 31840f95cd408b..6d3e234dc46a5d 100644
--- a/drivers/md/Makefile
+++ b/drivers/md/Makefile
@@ -43,6 +43,9 @@ obj-$(CONFIG_MD_FAULTY)		+= faulty.o
 obj-$(CONFIG_MD_CLUSTER)	+= md-cluster.o
 obj-$(CONFIG_BCACHE)		+= bcache/
 obj-$(CONFIG_BLK_DEV_MD)	+= md-mod.o
+ifeq ($(CONFIG_BLK_DEV_MD),y)
+obj-y				+= md-autodetect.o
+endif
 obj-$(CONFIG_BLK_DEV_DM)	+= dm-mod.o
 obj-$(CONFIG_BLK_DEV_DM_BUILTIN) += dm-builtin.o
 obj-$(CONFIG_DM_UNSTRIPED)	+= dm-unstripe.o
diff --git a/init/do_mounts_md.c b/drivers/md/md-autodetect.c
similarity index 96%
rename from init/do_mounts_md.c
rename to drivers/md/md-autodetect.c
index 359363e85ccd0b..fe806f7b9759a1 100644
--- a/init/do_mounts_md.c
+++ b/drivers/md/md-autodetect.c
@@ -1,10 +1,15 @@
 // SPDX-License-Identifier: GPL-2.0
+#include <linux/kernel.h>
+#include <linux/blkdev.h>
+#include <linux/init.h>
+#include <linux/syscalls.h>
+#include <linux/mount.h>
+#include <linux/major.h>
 #include <linux/delay.h>
+#include <linux/raid/detect.h>
 #include <linux/raid/md_u.h>
 #include <linux/raid/md_p.h>
 
-#include "do_mounts.h"
-
 /*
  * When md (and any require personalities) are compiled into the kernel
  * (not a module), arrays can be assembles are boot time using with AUTODETECT
@@ -114,6 +119,12 @@ static int __init md_setup(char *str)
 	return 1;
 }
 
+static inline int create_dev(char *name, dev_t dev)
+{
+	ksys_unlink(name);
+	return ksys_mknod(name, S_IFBLK|0600, new_encode_dev(dev));
+}
+
 static void __init md_setup_drive(void)
 {
 	int minor, i, ent, partitioned;
diff --git a/include/linux/raid/detect.h b/include/linux/raid/detect.h
index 37dd3f40cd316e..1f029a71c3ef05 100644
--- a/include/linux/raid/detect.h
+++ b/include/linux/raid/detect.h
@@ -1,3 +1,11 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 
 void md_autodetect_dev(dev_t dev);
+
+#ifdef CONFIG_BLK_DEV_MD
+void md_run_setup(void);
+#else
+static inline void md_run_setup(void)
+{
+}
+#endif
diff --git a/init/Makefile b/init/Makefile
index 57499b1ff4714d..6bc37f64b3617c 100644
--- a/init/Makefile
+++ b/init/Makefile
@@ -18,7 +18,6 @@ obj-y                          += init_task.o
 mounts-y			:= do_mounts.o
 mounts-$(CONFIG_BLK_DEV_RAM)	+= do_mounts_rd.o
 mounts-$(CONFIG_BLK_DEV_INITRD)	+= do_mounts_initrd.o
-mounts-$(CONFIG_BLK_DEV_MD)	+= do_mounts_md.o
 
 # dependencies on generated files need to be listed explicitly
 $(obj)/version.o: include/generated/compile.h
diff --git a/init/do_mounts.c b/init/do_mounts.c
index 29d326b6c29d2d..1a4dfa17fb2899 100644
--- a/init/do_mounts.c
+++ b/init/do_mounts.c
@@ -23,6 +23,7 @@
 #include <linux/nfs_fs.h>
 #include <linux/nfs_fs_sb.h>
 #include <linux/nfs_mount.h>
+#include <linux/raid/detect.h>
 #include <uapi/linux/mount.h>
 
 #include "do_mounts.h"
diff --git a/init/do_mounts.h b/init/do_mounts.h
index 7513d1c14d13fe..50d6c8941e15a1 100644
--- a/init/do_mounts.h
+++ b/init/do_mounts.h
@@ -41,13 +41,3 @@ bool __init initrd_load(void);
 static inline bool initrd_load(void) { return false; }
 
 #endif
-
-#ifdef CONFIG_BLK_DEV_MD
-
-void md_run_setup(void);
-
-#else
-
-static inline void md_run_setup(void) {}
-
-#endif
-- 
2.26.2

