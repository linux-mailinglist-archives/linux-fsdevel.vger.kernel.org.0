Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67B8A230FA0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jul 2020 18:37:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731678AbgG1Qem (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jul 2020 12:34:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731666AbgG1Qek (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jul 2020 12:34:40 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B101EC061794;
        Tue, 28 Jul 2020 09:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=IUFyWOr1uWBbel/eWYV/g0TmVBBiWg6O6Fyk4wJnUuQ=; b=Fj13MTenvt6CKtadyVnmNekYBR
        NkCFJ2zlHNF+svCPUy6LspPnQiPyI2zn+ZzZUGxe8Wj7LKMyC2OZdXvqJtdsGqIh2HP5V/QVD2YKm
        T0azjJpOEveVF48QNaFhKm/+PRjQjSxuEafkdw+A+VIGIfbThzuivroz1Na786SudhudaX8qSccyZ
        sTDk8ZAzoZ5aAh27KEqHpUQLqLxzVOW08nJpnsmnJedJypgWdLuzGFS45K6S4fFQ7t6MQyy2N1J+t
        u3dw0183FTqQqTFTGMDWJpUKcI2DcYapwvLflS02nGIW/0w8gkLTMmKkzYphUEcfgNWaOZ2uvXTpN
        0n8B0PTg==;
Received: from [2001:4bb8:180:6102:fd04:50d8:4827:5508] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k0SYk-0006yz-NF; Tue, 28 Jul 2020 16:34:35 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
Subject: [PATCH 10/23] init: add an init_unlink helper
Date:   Tue, 28 Jul 2020 18:34:03 +0200
Message-Id: <20200728163416.556521-11-hch@lst.de>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200728163416.556521-1-hch@lst.de>
References: <20200728163416.556521-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add a simple helper to unlink with a kernel space file name and switch
the early init code over to it.  Remove the now unused ksys_unlink.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/init.c                     | 5 +++++
 include/linux/init_syscalls.h | 1 +
 include/linux/syscalls.h      | 7 -------
 init/do_mounts.h              | 2 +-
 init/do_mounts_initrd.c       | 4 ++--
 init/do_mounts_rd.c           | 2 +-
 init/initramfs.c              | 3 ++-
 7 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/fs/init.c b/fs/init.c
index 9c8e31fdb048c8..507ffbb5d146d6 100644
--- a/fs/init.c
+++ b/fs/init.c
@@ -37,3 +37,8 @@ int __init init_umount(const char *name, int flags)
 		return ret;
 	return path_umount(&path, flags);
 }
+
+int __init init_unlink(const char *pathname)
+{
+	return do_unlinkat(AT_FDCWD, getname_kernel(pathname));
+}
diff --git a/include/linux/init_syscalls.h b/include/linux/init_syscalls.h
index a5a2e7f1991691..00d597249549ee 100644
--- a/include/linux/init_syscalls.h
+++ b/include/linux/init_syscalls.h
@@ -3,3 +3,4 @@
 int __init init_mount(const char *dev_name, const char *dir_name,
 		const char *type_page, unsigned long flags, void *data_page);
 int __init init_umount(const char *name, int flags);
+int __init init_unlink(const char *pathname);
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 1a4f5d8ee7044b..26f9738e5ab861 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -1273,13 +1273,6 @@ int compat_ksys_ipc(u32 call, int first, int second,
  * The following kernel syscall equivalents are just wrappers to fs-internal
  * functions. Therefore, provide stubs to be inlined at the callsites.
  */
-extern long do_unlinkat(int dfd, struct filename *name);
-
-static inline long ksys_unlink(const char __user *pathname)
-{
-	return do_unlinkat(AT_FDCWD, getname(pathname));
-}
-
 long do_rmdir(int dfd, struct filename *name);
 
 static inline long ksys_rmdir(const char __user *pathname)
diff --git a/init/do_mounts.h b/init/do_mounts.h
index 20e7fec8cb499e..104d8431725aeb 100644
--- a/init/do_mounts.h
+++ b/init/do_mounts.h
@@ -16,7 +16,7 @@ extern int root_mountflags;
 
 static inline __init int create_dev(char *name, dev_t dev)
 {
-	ksys_unlink(name);
+	init_unlink(name);
 	return ksys_mknod(name, S_IFBLK|0600, new_encode_dev(dev));
 }
 
diff --git a/init/do_mounts_initrd.c b/init/do_mounts_initrd.c
index 6b020a06990251..8b44dd017842a8 100644
--- a/init/do_mounts_initrd.c
+++ b/init/do_mounts_initrd.c
@@ -137,11 +137,11 @@ bool __init initrd_load(void)
 		 * mounted in the normal path.
 		 */
 		if (rd_load_image("/initrd.image") && ROOT_DEV != Root_RAM0) {
-			ksys_unlink("/initrd.image");
+			init_unlink("/initrd.image");
 			handle_initrd();
 			return true;
 		}
 	}
-	ksys_unlink("/initrd.image");
+	init_unlink("/initrd.image");
 	return false;
 }
diff --git a/init/do_mounts_rd.c b/init/do_mounts_rd.c
index d4255c10432a8b..ac021ae6e6fa78 100644
--- a/init/do_mounts_rd.c
+++ b/init/do_mounts_rd.c
@@ -272,7 +272,7 @@ int __init rd_load_image(char *from)
 	fput(out_file);
 out:
 	kfree(buf);
-	ksys_unlink("/dev/ram");
+	init_unlink("/dev/ram");
 	return res;
 }
 
diff --git a/init/initramfs.c b/init/initramfs.c
index 584bc8fe88e77c..7e9db1cfa3c060 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -12,6 +12,7 @@
 #include <linux/file.h>
 #include <linux/memblock.h>
 #include <linux/namei.h>
+#include <linux/init_syscalls.h>
 
 static ssize_t __init xwrite(struct file *file, const char *p, size_t count,
 		loff_t *pos)
@@ -301,7 +302,7 @@ static void __init clean_path(char *path, umode_t fmode)
 		if (S_ISDIR(st.mode))
 			ksys_rmdir(path);
 		else
-			ksys_unlink(path);
+			init_unlink(path);
 	}
 }
 
-- 
2.27.0

