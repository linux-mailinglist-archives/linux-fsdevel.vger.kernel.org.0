Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A386F473871
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Dec 2021 00:27:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242198AbhLMX1s (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Dec 2021 18:27:48 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:38946 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242066AbhLMX1r (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Dec 2021 18:27:47 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 99CAD212BA;
        Mon, 13 Dec 2021 23:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1639438066; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DIt9ginl48PKy64MiddiDG2EUGisGKDxe5coRfLRgmI=;
        b=SMyP/SyKubOAb4vUXmne+gcyt0TG+od6KHHyosDPTmhie3QebkzYa+O05JmJzsbP6WXJp+
        4hFXupCDOfof2XYc+IOmGy7C308mIxnuYynKrqIL/lP3fAcFKlLeCXYWz0ES6v3T6pNdiD
        BzWUJQJtMFG0pyJep3U7GIBDuptjh/c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1639438066;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DIt9ginl48PKy64MiddiDG2EUGisGKDxe5coRfLRgmI=;
        b=oa4mZS9aWZHqi7QbCRYVwplbAobGEaaxKJBLBPGRCyR8AGPb6R8OQW5HQ7Q59AH2ipmVsz
        WJ/v4WCS9jO/XKDg==
Received: from echidna.suse.de (unknown [10.163.47.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 6F0C5A3B87;
        Mon, 13 Dec 2021 23:27:46 +0000 (UTC)
From:   David Disseldorp <ddiss@suse.de>
To:     linux-fsdevel@vger.kernel.org
Cc:     Martin Wilck <mwilck@suse.com>, viro@zeniv.linux.org.uk,
        willy@infradead.org, David Disseldorp <ddiss@suse.de>
Subject: [PATCH v5 2/5] initramfs: add INITRAMFS_PRESERVE_MTIME Kconfig option
Date:   Tue, 14 Dec 2021 00:20:05 +0100
Message-Id: <20211213232007.26851-3-ddiss@suse.de>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211213232007.26851-1-ddiss@suse.de>
References: <20211213232007.26851-1-ddiss@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

initramfs cpio mtime preservation, as implemented in commit 889d51a10712
("initramfs: add option to preserve mtime from initramfs cpio images"),
uses a linked list to defer directory mtime processing until after all
other items in the cpio archive have been processed. This is done to
ensure that parent directory mtimes aren't overwritten via subsequent
child creation. Contrary to the 889d51a10712 commit message, the mtime
preservation behaviour is unconditional.

This change adds a new INITRAMFS_PRESERVE_MTIME Kconfig option, which
can be used to disable on-by-default mtime retention and in turn
speed up initramfs extraction, particularly for cpio archives with large
directory counts.

Benchmarks with a one million directory cpio archive extracted 20 times
demonstrated:
				mean extraction time (s)	std dev
INITRAMFS_PRESERVE_MTIME=y		3.808			 0.006
INITRAMFS_PRESERVE_MTIME unset		3.056			 0.004

The above extraction times were measured using ftrace
(initcall_finish - initcall_start) values for populate_rootfs() with
initramfs_async disabled.

Signed-off-by: David Disseldorp <ddiss@suse.de>
Reviewed-by: Martin Wilck <mwilck@suse.com>
---
 init/Kconfig           | 10 +++++++++
 init/initramfs.c       | 48 +++-------------------------------------
 init/initramfs_mtime.h | 50 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 63 insertions(+), 45 deletions(-)
 create mode 100644 init/initramfs_mtime.h

diff --git a/init/Kconfig b/init/Kconfig
index 4b7bac10c72d..a98f63d3c366 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1357,6 +1357,16 @@ config BOOT_CONFIG
 
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
diff --git a/init/initramfs.c b/init/initramfs.c
index 2f79b3ec0b40..5b4ca8ecadb5 100644
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
@@ -379,14 +341,10 @@ static int __init do_name(void)
 static int __init do_copy(void)
 {
 	if (byte_count >= body_len) {
-		struct timespec64 t[2] = { };
 		if (xwrite(wfile, victim, body_len, &wfile_pos) != body_len)
 			error("write error");
 
-		t[0].tv_sec = mtime;
-		t[1].tv_sec = mtime;
-		vfs_utimes(&wfile->f_path, t);
-
+		do_utime_path(&wfile->f_path, mtime);
 		fput(wfile);
 		eat(body_len);
 		state = SkipIt;
diff --git a/init/initramfs_mtime.h b/init/initramfs_mtime.h
new file mode 100644
index 000000000000..fbd8757b34a9
--- /dev/null
+++ b/init/initramfs_mtime.h
@@ -0,0 +1,50 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifdef CONFIG_INITRAMFS_PRESERVE_MTIME
+static void __init do_utime(char *filename, time64_t mtime)
+{
+	struct timespec64 t[2] = { { .tv_sec = mtime }, { .tv_sec = mtime } };
+	init_utimes(filename, t);
+}
+
+static void __init do_utime_path(const struct path *path, time64_t mtime)
+{
+	struct timespec64 t[2] = { { .tv_sec = mtime }, { .tv_sec = mtime } };
+	vfs_utimes(path, t);
+}
+
+static __initdata LIST_HEAD(dir_list);
+struct dir_entry {
+	struct list_head list;
+	char *name;
+	time64_t mtime;
+};
+
+static void __init dir_add(const char *name, time64_t mtime)
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
+static void __init dir_utime(void)
+{
+	struct dir_entry *de, *tmp;
+
+	list_for_each_entry_safe(de, tmp, &dir_list, list) {
+		list_del(&de->list);
+		do_utime(de->name, de->mtime);
+		kfree(de->name);
+		kfree(de);
+	}
+}
+#else
+static void __init do_utime(char *filename, time64_t mtime) {}
+static void __init do_utime_path(const struct path *path, time64_t mtime) {}
+static void __init dir_add(const char *name, time64_t mtime) {}
+static void __init dir_utime(void) {}
+#endif
-- 
2.31.1

