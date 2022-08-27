Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDD445A3319
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Aug 2022 02:28:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345086AbiH0A2b (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Aug 2022 20:28:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344819AbiH0A2Z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Aug 2022 20:28:25 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 229A5EA89B
        for <linux-fsdevel@vger.kernel.org>; Fri, 26 Aug 2022 17:28:23 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 996821F9B1;
        Sat, 27 Aug 2022 00:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1661560101; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=t33ORWoHO9j2N1bQRIzbRy9gMspzXFAgr1xlTJIkfzY=;
        b=L7rhwN8Wfo08Bvuws+haw0L+rBmeoaEm7HkoS//X3Kl1R47pFI7vL0bbSJXsjCI/Hy2jCK
        uLObDQtnWSgSmu6Kk1Y74Ls6fd0MnER/gKyvMyAFTaXxhsrO+Mms30LyA8hFf7cZY2laa3
        Ev3em6wP70/6RQGAxN8sZQWoU3aTiOQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1661560101;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=t33ORWoHO9j2N1bQRIzbRy9gMspzXFAgr1xlTJIkfzY=;
        b=2Qm5eLROvZCSYkTeuXTFXHsB/+KSZ2q/Ha4JeHETO0dGs7/Ozgb778R93kYJm+9v70ruB6
        WPiz6o1FYM76JqBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 42293133A6;
        Sat, 27 Aug 2022 00:28:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 8Np7DiVlCWNQCgAAMHmgww
        (envelope-from <pvorel@suse.cz>); Sat, 27 Aug 2022 00:28:21 +0000
From:   Petr Vorel <pvorel@suse.cz>
To:     ltp@lists.linux.it
Cc:     Petr Vorel <pvorel@suse.cz>, Cyril Hrubis <chrubis@suse.cz>,
        Li Wang <liwang@redhat.com>, Martin Doucha <mdoucha@suse.cz>,
        Richard Palethorpe <rpalethorpe@suse.com>,
        Joerg Vehlow <joerg.vehlow@aox-tech.de>,
        automated-testing@lists.yoctoproject.org,
        Tim Bird <tim.bird@sony.com>, linux-fsdevel@vger.kernel.org
Subject: [PATCH 2/6] API: tst_device: Track minimal size per filesystem
Date:   Sat, 27 Aug 2022 02:28:11 +0200
Message-Id: <20220827002815.19116-3-pvorel@suse.cz>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220827002815.19116-1-pvorel@suse.cz>
References: <20220827002815.19116-1-pvorel@suse.cz>
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

Previously we required 256 MB for loop device size regardless used
filesystem due btrfs requirements. New defaults are based on used
filesystem:

* Btrfs: 110 MB
* SquashFS: 1 MB
* others: 16 MB

This helps embedded systems with lower resources.

NOTE: XFS has 300 MB requirement from xfsprogs 5.19, but it was
workarounded by environment variables by previous commit.

Tests required to change setup:
* fanotify05: .dev_min_size = 65
* preadv203: .dev_min_size = 230
* readahead02: .dev_min_size = 135
* squashfs01: .dev_fs_type = "squashfs" to be able to keep .dev_min_size = 1

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 include/old/old_device.h                      |  6 ++--
 include/tst_fs.h                              | 16 +++++++++
 lib/tst_device.c                              | 36 +++++++++++++++----
 lib/tst_fs_type.c                             | 28 +++++++++++++++
 lib/tst_test.c                                |  7 +++-
 testcases/kernel/fs/squashfs/squashfs01.c     |  1 +
 .../kernel/syscalls/fanotify/fanotify05.c     |  1 +
 testcases/kernel/syscalls/preadv2/preadv203.c |  1 +
 .../kernel/syscalls/readahead/readahead02.c   |  1 +
 testcases/lib/tst_device.c                    |  2 +-
 10 files changed, 88 insertions(+), 11 deletions(-)

diff --git a/include/old/old_device.h b/include/old/old_device.h
index a6e9fea86..f67cee2b9 100644
--- a/include/old/old_device.h
+++ b/include/old/old_device.h
@@ -43,13 +43,13 @@ const char *tst_dev_fs_type(void);
  * Returns path to the device or NULL if it cannot be created.
  * Call tst_release_device() when you're done.
  */
-const char *tst_acquire_device_(void (cleanup_fn)(void), unsigned int size);
+const char *tst_acquire_device_(void (cleanup_fn)(void), unsigned int size, long f_type);
 
-const char *tst_acquire_device__(unsigned int size);
+const char *tst_acquire_device__(unsigned int size, long f_type);
 
 static inline const char *tst_acquire_device(void (cleanup_fn)(void))
 {
-	return tst_acquire_device_(cleanup_fn, 0);
+	return tst_acquire_device_(cleanup_fn, 0, TST_ALL_FILESYSTEMS);
 }
 
 /*
diff --git a/include/tst_fs.h b/include/tst_fs.h
index a6f934b0f..ea2c6b527 100644
--- a/include/tst_fs.h
+++ b/include/tst_fs.h
@@ -5,6 +5,8 @@
 #ifndef TST_FS_H__
 #define TST_FS_H__
 
+#define TST_ALL_FILESYSTEMS	0
+
 /* man 2 statfs or kernel-source/include/uapi/linux/magic.h */
 #define TST_BTRFS_MAGIC    0x9123683E
 #define TST_NFS_MAGIC      0x6969
@@ -49,6 +51,15 @@ enum {
 #define OVL_WORK	OVL_BASE_MNTPOINT"/work"
 #define OVL_MNT		OVL_BASE_MNTPOINT"/ovl"
 
+/*
+ * Returns minimum requested for filesystem size.
+ * This size is enforced for all but tmpfs.
+ *
+ * @fs_type filesystem to be searched for, 0 is for the biggest size of all
+ * supported filesystems (used for .all_filesystems).
+ */
+unsigned int tst_min_fs_size(long f_type);
+
 /*
  * @path: path is the pathname of any file within the mounted file system
  * @mult: mult should be TST_KB, TST_MB or TST_GB
@@ -87,6 +98,11 @@ long tst_fs_type_(void (*cleanup)(void), const char *path);
  */
 const char *tst_fs_type_name(long f_type);
 
+/*
+ * Returns magic given filesystem name.
+ */
+long tst_fs_name_type(const char *fs);
+
 /*
  * Try to get maximum number of hard links to a regular file inside the @dir.
  *
diff --git a/lib/tst_device.c b/lib/tst_device.c
index c34cbe6d1..bb336abe4 100644
--- a/lib/tst_device.c
+++ b/lib/tst_device.c
@@ -36,6 +36,7 @@
 #include "lapi/syscalls.h"
 #include "test.h"
 #include "safe_macros.h"
+#include "tst_fs.h"
 
 #ifndef LOOP_CTL_GET_FREE
 # define LOOP_CTL_GET_FREE 0x4C82
@@ -44,12 +45,28 @@
 #define LOOP_CONTROL_FILE "/dev/loop-control"
 
 #define DEV_FILE "test_dev.img"
-#define DEV_SIZE_MB 256u
+#define DEV_SIZE_MB_DEFAULT 16u
+#define DEV_SIZE_MB_BTRFS 110u
+#define DEV_SIZE_MB_SQUASHFS 1u
 
 static char dev_path[1024];
 static int device_acquired;
 static unsigned long prev_dev_sec_write;
 
+unsigned int tst_min_fs_size(long f_type)
+{
+	switch (f_type) {
+	case 0:
+		return MAX(DEV_SIZE_MB_BTRFS, DEV_SIZE_MB_DEFAULT);
+	case TST_BTRFS_MAGIC:
+		return DEV_SIZE_MB_BTRFS;
+	case TST_SQUASHFS_MAGIC:
+		return DEV_SIZE_MB_SQUASHFS;
+	default:
+		return DEV_SIZE_MB_DEFAULT;
+	}
+}
+
 static const char *dev_variants[] = {
 	"/dev/loop%i",
 	"/dev/loop/%i",
@@ -279,7 +296,7 @@ int tst_dev_sync(int fd)
 
 const char *tst_acquire_loop_device(unsigned int size, const char *filename)
 {
-	unsigned int acq_dev_size = size ? size : DEV_SIZE_MB;
+	unsigned int acq_dev_size = size ?: tst_min_fs_size(0);
 
 	if (tst_prealloc_file(filename, 1024 * 1024, acq_dev_size)) {
 		tst_resm(TWARN | TERRNO, "Failed to create %s", filename);
@@ -295,13 +312,20 @@ const char *tst_acquire_loop_device(unsigned int size, const char *filename)
 	return dev_path;
 }
 
-const char *tst_acquire_device__(unsigned int size)
+const char *tst_acquire_device__(unsigned int size, long f_type)
 {
 	const char *dev;
 	unsigned int acq_dev_size;
 	uint64_t ltp_dev_size;
+	unsigned int min_size = tst_min_fs_size(f_type);
+
+	if (size && size < min_size) {
+		tst_brkm(TBROK, NULL, "Request device size %u smaller than min size: %u",
+				 size, min_size);
+		return NULL;
+	}
 
-	acq_dev_size = size ? size : DEV_SIZE_MB;
+	acq_dev_size = size ?: min_size;
 
 	dev = getenv("LTP_DEV");
 
@@ -325,7 +349,7 @@ const char *tst_acquire_device__(unsigned int size)
 	return dev;
 }
 
-const char *tst_acquire_device_(void (cleanup_fn)(void), unsigned int size)
+const char *tst_acquire_device_(void (cleanup_fn)(void), unsigned int size, long f_type)
 {
 	const char *device;
 
@@ -340,7 +364,7 @@ const char *tst_acquire_device_(void (cleanup_fn)(void), unsigned int size)
 		return NULL;
 	}
 
-	device = tst_acquire_device__(size);
+	device = tst_acquire_device__(size, f_type);
 
 	if (!device) {
 		tst_brkm(TBROK, cleanup_fn, "Failed to acquire device");
diff --git a/lib/tst_fs_type.c b/lib/tst_fs_type.c
index de4facef5..49db2fff7 100644
--- a/lib/tst_fs_type.c
+++ b/lib/tst_fs_type.c
@@ -43,6 +43,34 @@ long tst_fs_type_(void (*cleanup)(void), const char *path)
 	return sbuf.f_type;
 }
 
+long tst_fs_name_type(const char *fs)
+{
+	if (!strcmp(fs, "btrfs"))
+		return TST_BTRFS_MAGIC;
+	else if (!strcmp(fs, "exfat"))
+		return TST_EXFAT_MAGIC;
+	else if (!strcmp(fs, "ext2"))
+		return TST_EXT2_OLD_MAGIC;
+	else if (!strcmp(fs, "ext3") || !strcmp(fs, "ext4"))
+		return TST_EXT234_MAGIC;
+	else if (!strcmp(fs, "minix"))
+		return TST_MINIX3_MAGIC;
+	else if (!strcmp(fs, "msdos"))
+		return TST_VFAT_MAGIC;
+	else if (!strcmp(fs, "ntfs"))
+		return TST_NTFS_MAGIC;
+	else if (!strcmp(fs, "squashfs"))
+		return TST_SQUASHFS_MAGIC;
+	else if (!strcmp(fs, "tmpfs"))
+		return TST_TMPFS_MAGIC;
+	else if (!strcmp(fs, "vfat"))
+		return TST_VFAT_MAGIC;
+	else if (!strcmp(fs, "xfs"))
+		return TST_XFS_MAGIC;
+
+	return -1;
+}
+
 const char *tst_fs_type_name(long f_type)
 {
 	switch (f_type) {
diff --git a/lib/tst_test.c b/lib/tst_test.c
index 657348732..bfc40554f 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -1225,7 +1225,12 @@ static void do_setup(int argc, char *argv[])
 	}
 
 	if (tst_test->needs_device && !mntpoint_mounted) {
-		tdev.dev = tst_acquire_device_(NULL, tst_test->dev_min_size);
+		long f_type = tst_fs_name_type(tst_test->dev_fs_type ?: DEFAULT_FS_TYPE);
+
+		if (tst_test->all_filesystems)
+			f_type = TST_ALL_FILESYSTEMS;
+
+		tdev.dev = tst_acquire_device_(NULL, tst_test->dev_min_size, f_type);
 
 		if (!tdev.dev)
 			tst_brk(TCONF, "Failed to acquire device");
diff --git a/testcases/kernel/fs/squashfs/squashfs01.c b/testcases/kernel/fs/squashfs/squashfs01.c
index 502de419d..d7f91c129 100644
--- a/testcases/kernel/fs/squashfs/squashfs01.c
+++ b/testcases/kernel/fs/squashfs/squashfs01.c
@@ -104,6 +104,7 @@ static struct tst_test test = {
 	.needs_root = 1,
 	.needs_device = 1,
 	.dev_min_size = 1,
+	.dev_fs_type = "squashfs",
 	.needs_cmds = (const char *const []) {
 		"mksquashfs",
 		NULL
diff --git a/testcases/kernel/syscalls/fanotify/fanotify05.c b/testcases/kernel/syscalls/fanotify/fanotify05.c
index 04670cb1c..a4bc5ef54 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify05.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify05.c
@@ -215,6 +215,7 @@ static struct tst_test test = {
 	.needs_root = 1,
 	.mount_device = 1,
 	.mntpoint = MOUNT_PATH,
+	.dev_min_size = 65,
 };
 #else
 	TST_TEST_TCONF("system doesn't have required fanotify support");
diff --git a/testcases/kernel/syscalls/preadv2/preadv203.c b/testcases/kernel/syscalls/preadv2/preadv203.c
index 60dc4a882..8c08c86ea 100644
--- a/testcases/kernel/syscalls/preadv2/preadv203.c
+++ b/testcases/kernel/syscalls/preadv2/preadv203.c
@@ -280,4 +280,5 @@ static struct tst_test test = {
 	.all_filesystems = 1,
 	.max_runtime = 60,
 	.needs_root = 1,
+	.dev_min_size = 230,
 };
diff --git a/testcases/kernel/syscalls/readahead/readahead02.c b/testcases/kernel/syscalls/readahead/readahead02.c
index 4fa8cfaf8..07a5172fc 100644
--- a/testcases/kernel/syscalls/readahead/readahead02.c
+++ b/testcases/kernel/syscalls/readahead/readahead02.c
@@ -406,6 +406,7 @@ static struct tst_test test = {
 	},
 	.test = test_readahead,
 	.tcnt = ARRAY_SIZE(tcases),
+	.dev_min_size = 135,
 	.tags = (const struct tst_tag[]) {
 		{"linux-git", "b833a3660394"},
 		{"linux-git", "5b910bd615ba"},
diff --git a/testcases/lib/tst_device.c b/testcases/lib/tst_device.c
index d6b74a5ff..b76abf52b 100644
--- a/testcases/lib/tst_device.c
+++ b/testcases/lib/tst_device.c
@@ -43,7 +43,7 @@ static int acquire_device(int argc, char *argv[])
 	if (argc >= 4)
 		device = tst_acquire_loop_device(size, argv[3]);
 	else
-		device = tst_acquire_device__(size);
+		device = tst_acquire_device__(size, TST_ALL_FILESYSTEMS);
 
 	if (!device)
 		return 1;
-- 
2.37.2

