Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33746228592
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jul 2020 18:30:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730630AbgGUQ34 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Jul 2020 12:29:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730406AbgGUQ2l (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Jul 2020 12:28:41 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06646C061794;
        Tue, 21 Jul 2020 09:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=FwUgcI/aJTCiAPeGMUcitua+NYPcU9BQfr/VbJVK/P8=; b=Pv8FLyKdMY/Nei43B5H6l1PVkL
        e5vlTZHBuEM6XDRSMFEjU2wqgo3rUOIdqnxGgaQuQ2rUh1qjhiiZP2WyNmKMXazzcs19p92gP0O/h
        hoTC1xBkNfd50uS95P4SdIaYVzG7z3XKUXmiIBvd+n6W9iXLL8xYwF3d36S+4E+A38zw5zQtIyN/p
        TbjXL7tqnKthIioRAik/OoYV/kNTppTAi2hROCKCOJ5VGymWT+LKWip3Th6ALEnZjA1bON+qS252q
        A0JG89rdeMg0NCykB6Srvc3P2xU265ZMiGSawAsXRTiyloG3G+/JDAVFz1ugl0AY7cObmnO1pc0cS
        AaboryBQ==;
Received: from [2001:4bb8:18c:2acc:5b1c:6483:bd6d:e406] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jxv89-0007Tt-Tk; Tue, 21 Jul 2020 16:28:38 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
Subject: [PATCH 12/24] init: add an init_mount helper
Date:   Tue, 21 Jul 2020 18:28:06 +0200
Message-Id: <20200721162818.197315-13-hch@lst.de>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200721162818.197315-1-hch@lst.de>
References: <20200721162818.197315-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Like do_mount, but takes a kernel pointer for the destination path.
Switch over the mounts in the init code and devtmpfs to it, which
just happen to work due to the implicit set_fs(KERNEL_DS) during early
init right now.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 init/Makefile           |  2 +-
 init/do_mounts.c        |  8 ++++----
 init/do_mounts.h        |  3 +++
 init/do_mounts_initrd.c |  6 +++---
 init/fs.c               | 20 ++++++++++++++++++++
 5 files changed, 31 insertions(+), 8 deletions(-)
 create mode 100644 init/fs.c

diff --git a/init/Makefile b/init/Makefile
index 6bc37f64b3617c..7d4b57d3cf7eac 100644
--- a/init/Makefile
+++ b/init/Makefile
@@ -5,7 +5,7 @@
 
 ccflags-y := -fno-function-sections -fno-data-sections
 
-obj-y                          := main.o version.o mounts.o
+obj-y                          := main.o version.o fs.o mounts.o
 ifneq ($(CONFIG_BLK_DEV_INITRD),y)
 obj-y                          += noinitramfs.o
 else
diff --git a/init/do_mounts.c b/init/do_mounts.c
index 4f4ceb35805503..4812e21d149cab 100644
--- a/init/do_mounts.c
+++ b/init/do_mounts.c
@@ -395,16 +395,16 @@ static int __init do_mount_root(const char *name, const char *fs,
 	int ret;
 
 	if (data) {
-		/* do_mount() requires a full page as fifth argument */
+		/* init_mount() requires a full page as fifth argument */
 		p = alloc_page(GFP_KERNEL);
 		if (!p)
 			return -ENOMEM;
 		data_page = page_address(p);
-		/* zero-pad. do_mount() will make sure it's terminated */
+		/* zero-pad. init_mount() will make sure it's terminated */
 		strncpy(data_page, data, PAGE_SIZE);
 	}
 
-	ret = do_mount(name, "/root", fs, flags, data_page);
+	ret = init_mount(name, "/root", fs, flags, data_page);
 	if (ret)
 		goto out;
 
@@ -628,7 +628,7 @@ void __init prepare_namespace(void)
 	mount_root();
 out:
 	devtmpfs_mount();
-	do_mount(".", "/", NULL, MS_MOVE, NULL);
+	init_mount(".", "/", NULL, MS_MOVE, NULL);
 	ksys_chroot(".");
 }
 
diff --git a/init/do_mounts.h b/init/do_mounts.h
index 15d256658a3093..ce4f95fff6bc16 100644
--- a/init/do_mounts.h
+++ b/init/do_mounts.h
@@ -9,6 +9,9 @@
 #include <linux/major.h>
 #include <linux/root_dev.h>
 
+int __init init_mount(const char *dev_name, const char *dir_name,
+		const char *type_page, unsigned long flags, void *data_page);
+
 void  mount_block_root(char *name, int flags);
 void  mount_root(void);
 void prepare_namespace(void);
diff --git a/init/do_mounts_initrd.c b/init/do_mounts_initrd.c
index 3fabbc82513506..63a3eebd36e76b 100644
--- a/init/do_mounts_initrd.c
+++ b/init/do_mounts_initrd.c
@@ -63,7 +63,7 @@ static int __init init_linuxrc(struct subprocess_info *info, struct cred *new)
 	console_on_rootfs();
 	/* move initrd over / and chdir/chroot in initrd root */
 	ksys_chdir("/root");
-	do_mount(".", "/", NULL, MS_MOVE, NULL);
+	init_mount(".", "/", NULL, MS_MOVE, NULL);
 	ksys_chroot(".");
 	ksys_setsid();
 	return 0;
@@ -100,7 +100,7 @@ static void __init handle_initrd(void)
 	current->flags &= ~PF_FREEZER_SKIP;
 
 	/* move initrd to rootfs' /old */
-	do_mount("..", ".", NULL, MS_MOVE, NULL);
+	init_mount("..", ".", NULL, MS_MOVE, NULL);
 	/* switch root and cwd back to / of rootfs */
 	ksys_chroot("..");
 
@@ -114,7 +114,7 @@ static void __init handle_initrd(void)
 	mount_root();
 
 	printk(KERN_NOTICE "Trying to move old root to /initrd ... ");
-	error = do_mount("/old", "/root/initrd", NULL, MS_MOVE, NULL);
+	error = init_mount("/old", "/root/initrd", NULL, MS_MOVE, NULL);
 	if (!error)
 		printk("okay\n");
 	else {
diff --git a/init/fs.c b/init/fs.c
new file mode 100644
index 00000000000000..73423f5461f934
--- /dev/null
+++ b/init/fs.c
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/init.h>
+#include <linux/mount.h>
+#include <linux/namei.h>
+#include <linux/fs.h>
+#include "do_mounts.h"
+
+int __init init_mount(const char *dev_name, const char *dir_name,
+		const char *type_page, unsigned long flags, void *data_page)
+{
+	struct path path;
+	int ret;
+
+	ret = kern_path(dir_name, LOOKUP_FOLLOW, &path);
+	if (ret)
+		return ret;
+	ret = path_mount(dev_name, &path, type_page, flags, data_page);
+	path_put(&path);
+	return ret;
+}
-- 
2.27.0

