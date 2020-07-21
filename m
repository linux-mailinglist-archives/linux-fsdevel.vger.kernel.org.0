Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2026C228554
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jul 2020 18:28:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730434AbgGUQ2p (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Jul 2020 12:28:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730023AbgGUQ2o (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Jul 2020 12:28:44 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D612FC061794;
        Tue, 21 Jul 2020 09:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=w/DmEogXiyqajJfLcQS1TdV2YOB0+mS/JLoJhSrCM5A=; b=aJsEdUgLHEmvVZ6YIa0TPIyz8+
        kUnpMtPsfMBiEGHicBoyqUmScR46eQ3HjqMHKidZ2p6Qkq6gvwqYF5DPQlbqy2gnm+BjuuxJwtygq
        xOdCDBYEtO6Aoe3Rd7YVfZF3WacFLLxDRshEAtePG+LOWRqetwkdISNr6ozZP1WEXKlMdDMSupy7O
        rMZG7f6nouXDHFrahV2KjZTD+24+81dJ+swATUJCirxc2ZnH1pzM40qqwvzCvkbnm0U1cFC55/PUd
        bLToBXF67/faXXOj3D2MYouHWtT/MlnfYCqh2DR+EsBqpLn3YfhmFdV2WB0+84ZU7FFyEMJNRlnTr
        XLbHbn4g==;
Received: from [2001:4bb8:18c:2acc:5b1c:6483:bd6d:e406] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jxv8B-0007UI-K6; Tue, 21 Jul 2020 16:28:40 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
Subject: [PATCH 13/24] init: add an init_unlink helper
Date:   Tue, 21 Jul 2020 18:28:07 +0200
Message-Id: <20200721162818.197315-14-hch@lst.de>
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

Add a simple helper to unlink with a kernel space file name and switch
the early init code over to it.  Remove the now unused ksys_unlink.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/syscalls.h | 7 -------
 init/do_mounts.h         | 3 ++-
 init/do_mounts_initrd.c  | 4 ++--
 init/do_mounts_rd.c      | 2 +-
 init/fs.c                | 6 ++++++
 init/initramfs.c         | 3 ++-
 6 files changed, 13 insertions(+), 12 deletions(-)

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
index ce4f95fff6bc16..d2f1f335b5b5b9 100644
--- a/init/do_mounts.h
+++ b/init/do_mounts.h
@@ -11,6 +11,7 @@
 
 int __init init_mount(const char *dev_name, const char *dir_name,
 		const char *type_page, unsigned long flags, void *data_page);
+int __init init_unlink(const char *pathname);
 
 void  mount_block_root(char *name, int flags);
 void  mount_root(void);
@@ -19,7 +20,7 @@ extern int root_mountflags;
 
 static inline __init int create_dev(char *name, dev_t dev)
 {
-	ksys_unlink(name);
+	init_unlink(name);
 	return ksys_mknod(name, S_IFBLK|0600, new_encode_dev(dev));
 }
 
diff --git a/init/do_mounts_initrd.c b/init/do_mounts_initrd.c
index 63a3eebd36e76b..dd4680c8ac762e 100644
--- a/init/do_mounts_initrd.c
+++ b/init/do_mounts_initrd.c
@@ -141,11 +141,11 @@ bool __init initrd_load(void)
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
 
diff --git a/init/fs.c b/init/fs.c
index 73423f5461f934..1bdb5dc5ec12ba 100644
--- a/init/fs.c
+++ b/init/fs.c
@@ -3,6 +3,7 @@
 #include <linux/mount.h>
 #include <linux/namei.h>
 #include <linux/fs.h>
+#include <../fs/internal.h>
 #include "do_mounts.h"
 
 int __init init_mount(const char *dev_name, const char *dir_name,
@@ -18,3 +19,8 @@ int __init init_mount(const char *dev_name, const char *dir_name,
 	path_put(&path);
 	return ret;
 }
+
+int __init init_unlink(const char *pathname)
+{
+	return do_unlinkat(AT_FDCWD, getname_kernel(pathname));
+}
diff --git a/init/initramfs.c b/init/initramfs.c
index 6135b55286fc35..664be397c6b41e 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -12,6 +12,7 @@
 #include <linux/file.h>
 #include <linux/memblock.h>
 #include <linux/namei.h>
+#include "do_mounts.h"
 
 static ssize_t __init xwrite(struct file *file, const char *p, size_t count)
 {
@@ -307,7 +308,7 @@ static void __init clean_path(char *path, umode_t fmode)
 		if (S_ISDIR(st.mode))
 			ksys_rmdir(path);
 		else
-			ksys_unlink(path);
+			init_unlink(path);
 	}
 }
 
-- 
2.27.0

