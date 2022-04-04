Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 738604F1223
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Apr 2022 11:36:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354472AbiDDJhp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Apr 2022 05:37:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354406AbiDDJhi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Apr 2022 05:37:38 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD2A130542
        for <linux-fsdevel@vger.kernel.org>; Mon,  4 Apr 2022 02:35:42 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 63F0F210EE;
        Mon,  4 Apr 2022 09:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1649064941; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hREKp7onaSm7yUcQf7oJo7xEDx2HbFqESAw93VqOv9U=;
        b=AHJZyYgNvgJN6TSIp7cNwphgsW8LW56kQvsKI+Gw6bcG3EhQh89zWwWZejxobFMsqrgeVd
        q8A7vwJRdSa/c7G6VlY/4EA+WH1zOwwIYx1zIyn3B+RGWvm7KO7H7bnU79ZRg2JLESlVUj
        7RiStOtQIY0WTH6LJife21GDaGmenSM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1649064941;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hREKp7onaSm7yUcQf7oJo7xEDx2HbFqESAw93VqOv9U=;
        b=1YWODpd3UflHEQdyioZSQYgqQGziVHyclItpxlDLlrRVOP9wiN5Wc/cRGNvMFNSOJ8RsGv
        C5LFGl7gclSmZIBw==
Received: from echidna.suse.de (unknown [10.163.47.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 374CBA3B92;
        Mon,  4 Apr 2022 09:35:41 +0000 (UTC)
From:   David Disseldorp <ddiss@suse.de>
To:     linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     viro@zeniv.linux.org.uk, willy@infradead.org,
        David Disseldorp <ddiss@suse.de>,
        Martin Wilck <mwilck@suse.com>
Subject: [PATCH v7 3/6] initramfs: add INITRAMFS_PRESERVE_MTIME Kconfig option
Date:   Mon,  4 Apr 2022 11:34:27 +0200
Message-Id: <20220404093429.27570-4-ddiss@suse.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220404093429.27570-1-ddiss@suse.de>
References: <20220404093429.27570-1-ddiss@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

initramfs cpio mtime preservation, as implemented in commit 889d51a10712
("initramfs: add option to preserve mtime from initramfs cpio images"),
uses a linked list to defer directory mtime processing until after all
other items in the cpio archive have been processed. This is done to
ensure that parent directory mtimes aren't overwritten via subsequent
child creation.

The lkml link below indicates that the mtime retention use case was for
embedded devices with applications running exclusively out of initramfs,
where the 32-bit mtime value provided a rough file version identifier.
Linux distributions which discard an extracted initramfs immediately
after the root filesystem has been mounted may want to avoid the
unnecessary overhead.

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

Link: https://lkml.org/lkml/2008/9/3/424
Signed-off-by: David Disseldorp <ddiss@suse.de>
Reviewed-by: Martin Wilck <mwilck@suse.com>
[ddiss: rebase atop dir_entry.name flexible array member and drop
 separate initramfs_mtime.h header]
---
 init/Kconfig     | 10 ++++++++++
 init/initramfs.c | 28 ++++++++++++++++------------
 2 files changed, 26 insertions(+), 12 deletions(-)

diff --git a/init/Kconfig b/init/Kconfig
index ddcbefe535e9..0fbaa07810a4 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1361,6 +1361,16 @@ config BOOT_CONFIG
 
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
index 656d2d71349f..b5bfed859fa9 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -116,15 +116,17 @@ static void __init free_hash(void)
 	}
 }
 
-static long __init do_utime(char *filename, time64_t mtime)
+#ifdef CONFIG_INITRAMFS_PRESERVE_MTIME
+static void __init do_utime(char *filename, time64_t mtime)
 {
-	struct timespec64 t[2];
+	struct timespec64 t[2] = { { .tv_sec = mtime }, { .tv_sec = mtime } };
+	init_utimes(filename, t);
+}
 
-	t[0].tv_sec = mtime;
-	t[0].tv_nsec = 0;
-	t[1].tv_sec = mtime;
-	t[1].tv_nsec = 0;
-	return init_utimes(filename, t);
+static void __init do_utime_path(const struct path *path, time64_t mtime)
+{
+	struct timespec64 t[2] = { { .tv_sec = mtime }, { .tv_sec = mtime } };
+	vfs_utimes(path, t);
 }
 
 static __initdata LIST_HEAD(dir_list);
@@ -157,6 +159,12 @@ static void __init dir_utime(void)
 		kfree(de);
 	}
 }
+#else
+static void __init do_utime(char *filename, time64_t mtime) {}
+static void __init do_utime_path(const struct path *path, time64_t mtime) {}
+static void __init dir_add(const char *name, time64_t mtime) {}
+static void __init dir_utime(void) {}
+#endif
 
 static __initdata time64_t mtime;
 
@@ -381,14 +389,10 @@ static int __init do_name(void)
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
-- 
2.34.1

