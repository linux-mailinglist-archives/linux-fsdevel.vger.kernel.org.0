Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A85A4414830
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Sep 2021 13:52:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235839AbhIVLyK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Sep 2021 07:54:10 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:55080 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235802AbhIVLyH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Sep 2021 07:54:07 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 37CDD2221F;
        Wed, 22 Sep 2021 11:52:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1632311557; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Zpk/uaLL1JETo1I6rhDsb+6geCHM6hrjO4lnTz+Lo1Y=;
        b=BZ9Sid15cyrUE+mxZnJ0K57i0mNcqLnfYad81QAhMVuasHMzj/8fZmqxPB62D1TrVKchJA
        FA1TFsStwogydoBBV6oA9BmHjkEN4CZ+x9LIv4mYj66GlrfvfYamfHsF0lsVp6PKnJRVSZ
        Y1ozoRouTxR7OvQOBfVahKHVjCGdh/M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1632311557;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Zpk/uaLL1JETo1I6rhDsb+6geCHM6hrjO4lnTz+Lo1Y=;
        b=tG09QfNmpkzmiBCXncWo+vnEWYsrnWfYmGSfZkc3p6V+RG4SVsFSX4wJvaJLT2bCbP2qCm
        ANhN9Os1ny9JN0AA==
Received: from echidna.suse.de (ddiss.udp.ovpn2.nue.suse.de [10.163.47.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 0C3CEA3BAE;
        Wed, 22 Sep 2021 11:52:37 +0000 (UTC)
From:   David Disseldorp <ddiss@suse.de>
To:     linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     viro@zeniv.linux.org.uk, willy@infradead.org,
        David Disseldorp <ddiss@suse.de>
Subject: [PATCH 5/5] initramfs: add INITRAMFS_PRESERVE_MTIME Kconfig option
Date:   Wed, 22 Sep 2021 13:52:22 +0200
Message-Id: <20210922115222.8987-5-ddiss@suse.de>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210922115222.8987-1-ddiss@suse.de>
References: <20210922115222.8987-1-ddiss@suse.de>
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
index 55f9f7738ebb..a79b6ba4d76c 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1324,6 +1324,16 @@ config BOOT_CONFIG
 
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
index 7f809a1c8e89..205fd62be616 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -16,6 +16,8 @@
 #include <linux/namei.h>
 #include <linux/init_syscalls.h>
 
+#include "initramfs_mtime.h"
+
 static ssize_t __init xwrite(struct file *file, const char *p, size_t count,
 		loff_t *pos)
 {
@@ -115,46 +117,6 @@ static void __init free_hash(void)
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

