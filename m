Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 095B221FC73
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jul 2020 21:09:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731070AbgGNTJU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Jul 2020 15:09:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731397AbgGNTJO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Jul 2020 15:09:14 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14DDDC061755;
        Tue, 14 Jul 2020 12:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=zaaTEYKxdpzataPQEGD26ZI2dzQ/rRh0sFs216QOmWE=; b=EN1XvUxd5QUNsERfxTuhINNT1Z
        sdW0MttcR/ss08QVfDay/gGs+EugDl3Cd6IrLSZcPtFYcxQljBI3f6IXwWBmeOFuUvZnXTvLXINk9
        cqyL6gleD0EX+26OAtMBLUXCfhUAi5hLti1VO+EsAjbl91jBpaEXgaMmlSnULu2kabXnyjWXeLIGa
        P3XFjtTjMZYYCVUdQV2yLaN3C2LK7LtbV4N0hJhmvZ1IJ6906EaPANAux+ThkZaxVzLqvDubAE3/j
        mhKzhLEp6jjFd8dBCzuygsEAzRequOPqdvF7hHYyKhxOlTQcEV9U/VsI17OuHADfkWXjR3725VbpC
        iT4tpb+w==;
Received: from [2001:4bb8:188:5f50:f037:8cfe:627e:7028] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jvQIh-0005tA-Ql; Tue, 14 Jul 2020 19:09:12 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     linux-kernel@vger.kernel.org
Cc:     "H. Peter Anvin" <hpa@zytor.com>, Song Liu <song@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-raid@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 16/23] initramfs: simplify clean_rootfs
Date:   Tue, 14 Jul 2020 21:04:20 +0200
Message-Id: <20200714190427.4332-17-hch@lst.de>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200714190427.4332-1-hch@lst.de>
References: <20200714190427.4332-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Just use d_genocide instead of iterating through the root directory with
cumbersome userspace-like APIs.  This also ensures we actually remove files
that are not direct children of the root entry, which the old code failed
to do.

Fixes: df52092f3c97 ("fastboot: remove duplicate unpack_to_rootfs()")
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 init/initramfs.c | 46 +++++-----------------------------------------
 1 file changed, 5 insertions(+), 41 deletions(-)

diff --git a/init/initramfs.c b/init/initramfs.c
index d10404625c31f0..d42ec8329cd840 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -11,6 +11,7 @@
 #include <linux/utime.h>
 #include <linux/file.h>
 #include <linux/memblock.h>
+#include <linux/namei.h>
 
 static ssize_t __init xwrite(int fd, const char *p, size_t count)
 {
@@ -572,51 +573,14 @@ static inline bool kexec_free_initrd(void)
 #endif /* CONFIG_KEXEC_CORE */
 
 #ifdef CONFIG_BLK_DEV_RAM
-#define BUF_SIZE 1024
 static void __init clean_rootfs(void)
 {
-	int fd;
-	void *buf;
-	struct linux_dirent64 *dirp;
-	int num;
+	struct path path;
 
-	fd = ksys_open("/", O_RDONLY, 0);
-	WARN_ON(fd < 0);
-	if (fd < 0)
-		return;
-	buf = kzalloc(BUF_SIZE, GFP_KERNEL);
-	WARN_ON(!buf);
-	if (!buf) {
-		ksys_close(fd);
+	if (kern_path("/", 0, &path))
 		return;
-	}
-
-	dirp = buf;
-	num = ksys_getdents64(fd, dirp, BUF_SIZE);
-	while (num > 0) {
-		while (num > 0) {
-			struct kstat st;
-			int ret;
-
-			ret = vfs_lstat(dirp->d_name, &st);
-			WARN_ON_ONCE(ret);
-			if (!ret) {
-				if (S_ISDIR(st.mode))
-					ksys_rmdir(dirp->d_name);
-				else
-					ksys_unlink(dirp->d_name);
-			}
-
-			num -= dirp->d_reclen;
-			dirp = (void *)dirp + dirp->d_reclen;
-		}
-		dirp = buf;
-		memset(buf, 0, BUF_SIZE);
-		num = ksys_getdents64(fd, dirp, BUF_SIZE);
-	}
-
-	ksys_close(fd);
-	kfree(buf);
+	d_genocide(path.dentry);
+	path_put(&path);
 }
 
 static void __init populate_initrd_image(char *err)
-- 
2.27.0

