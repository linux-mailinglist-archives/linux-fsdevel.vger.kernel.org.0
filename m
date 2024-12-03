Return-Path: <linux-fsdevel+bounces-36385-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1334D9E2E00
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Dec 2024 22:22:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF7961610FA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Dec 2024 21:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD50320A5C8;
	Tue,  3 Dec 2024 21:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=venev.name header.i=@venev.name header.b="L9I59bjh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from a1-bg02.venev.name (a1-bg02.venev.name [213.240.239.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A050204F89;
	Tue,  3 Dec 2024 21:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.240.239.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733260885; cv=none; b=rUIhrXEsJFH8dtTEYZlmbh93qZYuh/W9sWjw9/5Ndl+Q13TdnJF06GdBxRXS099tL3okOQ0uqYXd+S5vk3chKyzjvpE+EUi8nAUFIUJWsOpGtie+z5H/1hSpsjqs0JZuTa8suG76ykwJ6S7WXSeDHLW166YwBgYfMWigmCtUeSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733260885; c=relaxed/simple;
	bh=kTLMKEkMHsNkJ1dNvZM2CqRxYRI12AdCF29gHHsyoQM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DDIq+Xej7uy6ZDcCTr5z5+fwyrTe9AC7JeS11quU0nuem5wGr5Jrz5obAwjLW2QYILrn21sI2od3EZGmd6asLPve/wUCxGKGYQxsH3RK+7A7QYncvHVoSRe/wvDSLpBdca5+9sfPEHtIICDLtaC1XirKL24CU6cPFSBaS+ehc+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=venev.name; spf=pass smtp.mailfrom=venev.name; dkim=pass (4096-bit key) header.d=venev.name header.i=@venev.name header.b=L9I59bjh; arc=none smtp.client-ip=213.240.239.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=venev.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=venev.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=venev.name;
	s=default; h=Content-Transfer-Encoding:Message-ID:Date:Subject:To:From:
	Content-Type:Reply-To:Sender; bh=YibmFRXSsQ6h1u9JRjweqc/uxZpoOBFSIk8GiWn4mDI=
	; b=L9I59bjh8i1CbxXdOXdHpoMdNxcV1l1hrkvm8zzuwAGES29h4OtKYlGZNwatLdbElZB1zG0OY
	RtcO2aOdL/yKD2smTFMfGy4yI463bCYNmOKnAr0U/8b/qd5wJ4ljFbru+BUSAEGP8AEcD7bAFBjKU
	sOEwsXFF2RXexV0hVprSoCmCiObB/71od6NfrlA0lkQUigZx7V/uu3GtT4lRN0xYkshM5dN81GVxy
	80NAWTHnzPIbDLkiT1hLxMfVRJSGh8SyZNqzUS+F/N3FdA8RrLW8Md0V0UmuUYuQIDue38TsvYOGU
	sHTh2TYws8zj1Id/e080UAKFWXpOZI4sF41SD4A2OAzji7IhWORVZtID8/H1m+UOXCCnZ4JhAAhxv
	IQD6dZEiOJZYWOtACwAXmAhYScsRq30KuXxNUOTrh2ufdIbjrwx5p8WMx0n7iNGUwuhsmJUrwgw+5
	a1RPKAYOB5XYNPtLPStDBTB66QsIJwfk7NkwNtlXdr1wvTsok1EsYc5IfHHii4lc6Fp/eDpc338l3
	MfLsTqbpPJZwC152CsdJTSjUlT0hmx4et+GZ0ZtP2RqnzOsQ+LuzLjnYvECMwqC1DJ7VOUrsdfKxK
	O1U5ThH07HXH3eSfNJlCeBGpPINC/scTz/uPmN4SnEhS4GYiwgMuu72hUvDgKy2yYV9AfXs=;
Received: from a1-bg02.venev.name ([213.240.239.49] helo=pmx1.venev.name)
	by a1-bg02.venev.name with esmtps
	id 1tIZu6-0000000103f-1si5
	(TLS1.3:TLS_AES_256_GCM_SHA384:256)
	(envelope-from <hristo@venev.name>);
	Tue, 03 Dec 2024 20:53:54 +0000
Received: from venev.name ([213.240.239.49])
	by pmx1.venev.name with ESMTPSA
	id j69LKeBvT2fXowMAT9YxdQ
	(envelope-from <hristo@venev.name>); Tue, 03 Dec 2024 20:53:54 +0000
From: Hristo Venev <hristo@venev.name>
To: linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	Hristo Venev <hristo@venev.name>
Subject: [PATCH] initramfs: Protect the built-in initramfs from the external one
Date: Tue,  3 Dec 2024 22:52:48 +0200
Message-ID: <20241203205318.238364-1-hristo@venev.name>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In a typical Secure Boot setup the kernel image is signed, but the
initramfs provided by the bootloader is not. This reduces the usefulness
of Secure Boot because an attacker can overwrite the initramfs without
detection.

With this change, when a built-in initramfs is used, the kernel can be
configured to extract the initramfs provided by the bootloader into a
subdirectory, ensuring it cannot overwrite the built-in one.

Userspace can implement a verification scheme. One simple approach is
to embed all executables in the built-in initramfs and use the external
one for the (signed) kernel modules necessary for the system to boot.

Signed-off-by: Hristo Venev <hristo@venev.name>
---
 init/initramfs.c | 38 +++++++++++++++++++++++++++++++++++++-
 usr/Kconfig      | 26 ++++++++++++++++++++++++++
 2 files changed, 63 insertions(+), 1 deletion(-)

diff --git a/init/initramfs.c b/init/initramfs.c
index b2f7583bb1f5c..97eec8a6db07b 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -5,6 +5,7 @@
 #include <linux/slab.h>
 #include <linux/types.h>
 #include <linux/fcntl.h>
+#include <linux/fs_struct.h>
 #include <linux/delay.h>
 #include <linux/string.h>
 #include <linux/dirent.h>
@@ -355,6 +356,7 @@ static int __init maybe_link(void)
 
 static __initdata struct file *wfile;
 static __initdata loff_t wfile_pos;
+static bool skip_special __initdata;
 
 static int __init do_name(void)
 {
@@ -399,7 +401,7 @@ static int __init do_name(void)
 		dir_add(collected, mtime);
 	} else if (S_ISBLK(mode) || S_ISCHR(mode) ||
 		   S_ISFIFO(mode) || S_ISSOCK(mode)) {
-		if (maybe_link() == 0) {
+		if (!skip_special && maybe_link() == 0) {
 			init_mknod(collected, mode, rdev);
 			init_chown(collected, uid, gid, 0);
 			init_chmod(collected, mode);
@@ -705,6 +707,11 @@ static void __init populate_initrd_image(char *err)
 
 static void __init do_populate_rootfs(void *unused, async_cookie_t cookie)
 {
+#ifdef CONFIG_INITRAMFS_EXTERNAL_IS_SUBDIR
+	int r;
+	struct path orig_root, sub_root;
+#endif
+
 	/* Load the built in initramfs */
 	char *err = unpack_to_rootfs(__initramfs_start, __initramfs_size);
 	if (err)
@@ -718,6 +725,28 @@ static void __init do_populate_rootfs(void *unused, async_cookie_t cookie)
 	else
 		printk(KERN_INFO "Unpacking initramfs...\n");
 
+#ifdef CONFIG_INITRAMFS_EXTERNAL_IS_SUBDIR
+	/*
+	 * Switch the root so that the external initramfs is extracted there.
+	 * Use chroot so that paths under absolute symlinks resolve properly.
+	 */
+	get_fs_root(current->fs, &orig_root);
+
+	/*
+	 * Don't allow the creation of device nodes. Otherwise duplicate entries
+	 * may result in writes to devices.
+	 */
+	skip_special = true;
+
+	r = init_chdir(CONFIG_INITRAMFS_EXTERNAL_PATH);
+	if (r < 0)
+		panic_show_mem("Failed to open switch to external initramfs directory (%s): %d",
+			       CONFIG_INITRAMFS_EXTERNAL_PATH, r);
+	get_fs_pwd(current->fs, &sub_root);
+	set_fs_root(current->fs, &sub_root);
+	path_put(&sub_root);
+#endif
+
 	err = unpack_to_rootfs((char *)initrd_start, initrd_end - initrd_start);
 	if (err) {
 #ifdef CONFIG_BLK_DEV_RAM
@@ -727,6 +756,13 @@ static void __init do_populate_rootfs(void *unused, async_cookie_t cookie)
 #endif
 	}
 
+#ifdef CONFIG_INITRAMFS_EXTERNAL_IS_SUBDIR
+	/* Restore the original root now that the external initramfs is extracted. */
+	set_fs_root(current->fs, &orig_root);
+	set_fs_pwd(current->fs, &orig_root);
+	path_put(&orig_root);
+#endif
+
 done:
 	security_initramfs_populated();
 
diff --git a/usr/Kconfig b/usr/Kconfig
index 9279a2893ab0e..b781db0603903 100644
--- a/usr/Kconfig
+++ b/usr/Kconfig
@@ -32,6 +32,32 @@ config INITRAMFS_FORCE
 	  and is useful if you cannot or don't want to change the image
 	  your bootloader passes to the kernel.
 
+config INITRAMFS_EXTERNAL_PATH
+	string "External initramfs extraction path"
+	default "/"
+	depends on INITRAMFS_SOURCE!=""
+	depends on !INITRAMFS_FORCE
+	help
+	  This option causes the kernel to extract the initramfs image(s)
+	  provided by the bootloader into a subdirectory under the root
+	  directory. The subdirectory must exist in the built-in initramfs.
+
+	  This enables the built-in initramfs to check the integrity of the
+	  external one.
+
+	  If this option is used, any special nodes (device/fifo/socket) in the
+	  external initramfs are ignored. Symlinks, including ones pointing
+	  outside the subdirectory, are allowed.
+
+	  If your built-in initramfs is not capable of dealing with this, leave
+	  this option set to "/".
+
+config INITRAMFS_EXTERNAL_IS_SUBDIR
+	bool
+	default y
+	depends on INITRAMFS_EXTERNAL_PATH!=""
+	depends on INITRAMFS_EXTERNAL_PATH!="/"
+
 config INITRAMFS_ROOT_UID
 	int "User ID to map to 0 (user root)"
 	depends on INITRAMFS_SOURCE!=""
-- 
2.47.1


