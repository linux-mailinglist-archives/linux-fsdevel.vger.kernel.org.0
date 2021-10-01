Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD29641EECF
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Oct 2021 15:43:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353939AbhJANox (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 Oct 2021 09:44:53 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:47920 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353834AbhJANov (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 Oct 2021 09:44:51 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 29AFC20459;
        Fri,  1 Oct 2021 13:43:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1633095786; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wBSel4M0Z2Kwh7Vv/gxroZDfsM3cs68ntlBYsm1A2cQ=;
        b=EQQpHGMbiWYw6UUB9Q9k1ekidSlQzJVBR295sxF9W5sj0XsCEQIllJknx2d4bRBAsk7C0D
        kD1yCgPxYhJKjNKbfs+62YwSVb7j96yaxYY8EZNhrws4nOkRu9ZhHzW+12BkxsyhTsdZzG
        cSOPKp0teAyJq6VFdEKXHRsLTjg2dbQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1633095786;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wBSel4M0Z2Kwh7Vv/gxroZDfsM3cs68ntlBYsm1A2cQ=;
        b=PJ1pCuzEZBLO9WQlZTO4uC7j07L4RUMR8g3VfTPWUO1CMjCiKxlZIEZkmoGd91iwzPL7F3
        3gRkIFpWaJG3MoAg==
Received: from echidna.suse.de (unknown [10.163.47.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 0000CA3B81;
        Fri,  1 Oct 2021 13:43:05 +0000 (UTC)
From:   David Disseldorp <ddiss@suse.de>
To:     linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     viro@zeniv.linux.org.uk, willy@infradead.org,
        David Disseldorp <ddiss@suse.de>
Subject: [PATCH v3 5/5] initramfs: add INITRAMFS_PRESERVE_MTIME Kconfig option
Date:   Fri,  1 Oct 2021 15:42:56 +0200
Message-Id: <20211001134256.5581-6-ddiss@suse.de>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211001134256.5581-1-ddiss@suse.de>
References: <20211001134256.5581-1-ddiss@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

initramfs cpio mtime preservation, as implemented via
889d51a10712b6fd6175196626de2116858394f4, uses a linked list to defer
directory mtime processing until after all other items in the cpio
archive have been processed. This is done to ensure that parent
directory mtimes aren't overwritten via subsequent child creation.

This change adds a new INITRAMFS_PRESERVE_MTIME Kconfig option, which
can be used to disable on-by-default mtime retention and in turn
speed up initramfs extraction, particularly for cpio archives with large
directory counts.

For a cpio archive with ~1M directories, rough 20-run local benchmarks
demonstrated:
				mean extraction time (s)	std dev
INITRAMFS_PRESERVE_MTIME=y		3.789035		0.005474
INITRAMFS_PRESERVE_MTIME unset		3.111508		0.004132

Signed-off-by: David Disseldorp <ddiss@suse.de>
---
 init/Kconfig           | 10 +++++++++
 init/Makefile          |  3 +++
 init/initramfs.c       | 42 ++----------------------------------
 init/initramfs_mtime.c | 49 ++++++++++++++++++++++++++++++++++++++++++
 init/initramfs_mtime.h | 11 ++++++++++
 5 files changed, 75 insertions(+), 40 deletions(-)
 create mode 100644 init/initramfs_mtime.c
 create mode 100644 init/initramfs_mtime.h

diff --git a/init/Kconfig b/init/Kconfig
index 11f8a845f259..dc734d72a3c6 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1352,6 +1352,16 @@ config BOOT_CONFIG
 
 	  If unsure, say Y.
 
+config INITRAMFS_PRESERVE_MTIME
+	bool "Preserve cpio archive mtimes in initramfs"
+	default y
+	help
+	  Each entry in an initramfs cpio archive carries an mtime value. When
+	  enabled, extracted cpio items take this mtime, with directory mtime
+	  setting deferred until after creation of any child entries.
+
+	  If unsure, say Y.
+
 choice
 	prompt "Compiler optimization level"
 	default CC_OPTIMIZE_FOR_PERFORMANCE
diff --git a/init/Makefile b/init/Makefile
index 2846113677ee..d72bf80170ce 100644
--- a/init/Makefile
+++ b/init/Makefile
@@ -11,6 +11,9 @@ obj-y                          += noinitramfs.o
 else
 obj-$(CONFIG_BLK_DEV_INITRD)   += initramfs.o
 endif
+ifeq ($(CONFIG_INITRAMFS_PRESERVE_MTIME),y)
+obj-$(CONFIG_BLK_DEV_INITRD)   += initramfs_mtime.o
+endif
 obj-$(CONFIG_GENERIC_CALIBRATE_DELAY) += calibrate.o
 
 obj-y                          += init_task.o
diff --git a/init/initramfs.c b/init/initramfs.c
index c64f819ed120..aa0f63d9f570 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -17,6 +17,8 @@
 #include <linux/init_syscalls.h>
 #include <linux/umh.h>
 
+#include "initramfs_mtime.h"
+
 static ssize_t __init xwrite(struct file *file, const char *p, size_t count,
 		loff_t *pos)
 {
@@ -116,46 +118,6 @@ static void __init free_hash(void)
 	}
 }
 
-static long __init do_utime(char *filename, time64_t mtime)
-{
-	struct timespec64 t[2];
-
-	t[0].tv_sec = mtime;
-	t[0].tv_nsec = 0;
-	t[1].tv_sec = mtime;
-	t[1].tv_nsec = 0;
-	return init_utimes(filename, t);
-}
-
-static __initdata LIST_HEAD(dir_list);
-struct dir_entry {
-	struct list_head list;
-	char *name;
-	time64_t mtime;
-};
-
-static void __init dir_add(const char *name, time64_t mtime)
-{
-	struct dir_entry *de = kmalloc(sizeof(struct dir_entry), GFP_KERNEL);
-	if (!de)
-		panic_show_mem("can't allocate dir_entry buffer");
-	INIT_LIST_HEAD(&de->list);
-	de->name = kstrdup(name, GFP_KERNEL);
-	de->mtime = mtime;
-	list_add(&de->list, &dir_list);
-}
-
-static void __init dir_utime(void)
-{
-	struct dir_entry *de, *tmp;
-	list_for_each_entry_safe(de, tmp, &dir_list, list) {
-		list_del(&de->list);
-		do_utime(de->name, de->mtime);
-		kfree(de->name);
-		kfree(de);
-	}
-}
-
 static __initdata time64_t mtime;
 
 /* cpio header parsing */
diff --git a/init/initramfs_mtime.c b/init/initramfs_mtime.c
new file mode 100644
index 000000000000..0020deb21f76
--- /dev/null
+++ b/init/initramfs_mtime.c
@@ -0,0 +1,49 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#include <linux/init.h>
+#include <linux/types.h>
+#include <linux/syscalls.h>
+#include <linux/utime.h>
+#include <linux/file.h>
+#include <linux/init_syscalls.h>
+
+#include "initramfs_mtime.h"
+
+long __init do_utime(char *filename, time64_t mtime)
+{
+	struct timespec64 t[2];
+
+	t[0].tv_sec = mtime;
+	t[0].tv_nsec = 0;
+	t[1].tv_sec = mtime;
+	t[1].tv_nsec = 0;
+	return init_utimes(filename, t);
+}
+
+static __initdata LIST_HEAD(dir_list);
+struct dir_entry {
+	struct list_head list;
+	char *name;
+	time64_t mtime;
+};
+
+void __init dir_add(const char *name, time64_t mtime)
+{
+	struct dir_entry *de = kmalloc(sizeof(struct dir_entry), GFP_KERNEL);
+	if (!de)
+		panic("can't allocate dir_entry buffer");
+	INIT_LIST_HEAD(&de->list);
+	de->name = kstrdup(name, GFP_KERNEL);
+	de->mtime = mtime;
+	list_add(&de->list, &dir_list);
+}
+
+void __init dir_utime(void)
+{
+	struct dir_entry *de, *tmp;
+	list_for_each_entry_safe(de, tmp, &dir_list, list) {
+		list_del(&de->list);
+		do_utime(de->name, de->mtime);
+		kfree(de->name);
+		kfree(de);
+	}
+}
diff --git a/init/initramfs_mtime.h b/init/initramfs_mtime.h
new file mode 100644
index 000000000000..6d15c8b1171f
--- /dev/null
+++ b/init/initramfs_mtime.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifdef CONFIG_INITRAMFS_PRESERVE_MTIME
+long do_utime(char *filename, time64_t mtime) __init;
+void dir_add(const char *name, time64_t mtime) __init;
+void dir_utime(void) __init;
+#else
+static long __init do_utime(char *filename, time64_t mtime) { return 0; }
+static void __init dir_add(const char *name, time64_t mtime) {}
+static void __init dir_utime(void) {}
+#endif
-- 
2.31.1

