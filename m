Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C447622DCC9
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 Jul 2020 09:15:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727064AbgGZHOY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 26 Jul 2020 03:14:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727047AbgGZHOW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 26 Jul 2020 03:14:22 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 269CBC0619D4;
        Sun, 26 Jul 2020 00:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=39AuOUL6zwjspkwl/PRDKjl79kcQGSOoP/IHahBwaUc=; b=tImblYUzqe06uYK9f034Ew2RMn
        SbV2QjqiyvEu0Fy/m3GN/c0W/VCCCcT9f4Xl4S6dGQ80RLzBENMjOZPrsIvOPB/Z36xuUUJf0Y+Sw
        aK+7LdoaWP2UOJbiEm86/pzjSKvbPSdQK5S6rPLGro3oeHEOpNQkQ88pYEZp1iUgnhzPlF1KvGLqg
        ubHRMJJuAnAULQU8I8MG20xkFiFa/WtOsuh9p3RhuSJDZEe4QOeIDYyLos+QCmODVuZaT+REZdjMr
        GmCG196EBdEmeUnA9GrqHWNbaaJ/pQTs359VKTLvfGzOQPtfzkp/Qtg7J/7jYD11PId6JD7sv6vLs
        6cwMOUow==;
Received: from [2001:4bb8:18c:2acc:5ff1:d0b0:8643:670e] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jzarR-0002SE-DT; Sun, 26 Jul 2020 07:14:19 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
Subject: [PATCH 09/21] init: add an init_unlink helper
Date:   Sun, 26 Jul 2020 09:13:44 +0200
Message-Id: <20200726071356.287160-10-hch@lst.de>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200726071356.287160-1-hch@lst.de>
References: <20200726071356.287160-1-hch@lst.de>
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
 fs/for_init.c                 | 5 +++++
 include/linux/init_syscalls.h | 1 +
 include/linux/syscalls.h      | 7 -------
 init/do_mounts.h              | 2 +-
 init/do_mounts_initrd.c       | 4 ++--
 init/do_mounts_rd.c           | 2 +-
 init/initramfs.c              | 3 ++-
 7 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/fs/for_init.c b/fs/for_init.c
index 7a039b6d107c92..32472206d64136 100644
--- a/fs/for_init.c
+++ b/fs/for_init.c
@@ -33,3 +33,8 @@ int __init init_umount(const char *name, int flags)
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
index 7b64390c075043..b062f8b028ce7c 100644
--- a/init/do_mounts_rd.c
+++ b/init/do_mounts_rd.c
@@ -271,7 +271,7 @@ int __init rd_load_image(char *from)
 	fput(out_file);
 out:
 	kfree(buf);
-	ksys_unlink("/dev/ram");
+	init_unlink("/dev/ram");
 	return res;
 }
 
diff --git a/init/initramfs.c b/init/initramfs.c
index 3823d15e5d2619..574ab3755203da 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -12,6 +12,7 @@
 #include <linux/file.h>
 #include <linux/memblock.h>
 #include <linux/namei.h>
+#include <linux/init_syscalls.h>
 
 static ssize_t __init xwrite(struct file *file, const char *p, size_t count)
 {
@@ -300,7 +301,7 @@ static void __init clean_path(char *path, umode_t fmode)
 		if (S_ISDIR(st.mode))
 			ksys_rmdir(path);
 		else
-			ksys_unlink(path);
+			init_unlink(path);
 	}
 }
 
-- 
2.27.0

