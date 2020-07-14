Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DF7521FC8B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jul 2020 21:10:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731459AbgGNTKH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Jul 2020 15:10:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730401AbgGNTJP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Jul 2020 15:09:15 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63D69C061794;
        Tue, 14 Jul 2020 12:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=jWc5o2RdjucAIi3/T7+zxNpwZ6KLbDlRf4nu6wa1ugQ=; b=KALxoYKxNsjqo0u//l3uQkKfpX
        uJ6hdNmdag2I3vHT1YoYv38zm5D2fH/Hhj2gD+aHSTarlVuQT566pnxNOAx/ys/N+/J3cUuEyiHBJ
        voYltUsZHkX9TlwtfpOj00VD9y9awKJqFg2MUX9bpaJBI/6hoBzQSiy0UxjZ0DBdimoqmVl6FyO+R
        /0ttiSCthd8wWs6kIiohDuWoOSXrB6m+fvqjmLZeoCEbWMIFJcvTE7eBalUhF3vja5NcJD07JTdYI
        T0UmkNgKzJLb7nMWUAHU5+nbh+7CaPjraV3W6CS2TksuN6pXU8MnfdMI8nvG0824Xw9AWpOu1SGIT
        I5DjX3Ng==;
Received: from [2001:4bb8:188:5f50:f037:8cfe:627e:7028] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jvQIj-0005tI-BB; Tue, 14 Jul 2020 19:09:13 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     linux-kernel@vger.kernel.org
Cc:     "H. Peter Anvin" <hpa@zytor.com>, Song Liu <song@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-raid@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 17/23] initramfs: switch initramfs unpacking to struct file based APIs
Date:   Tue, 14 Jul 2020 21:04:21 +0200
Message-Id: <20200714190427.4332-18-hch@lst.de>
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

There is no good reason to mess with file descriptors from in-kernel
code, switch the initramfs unpacking to struct file based write
instead.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 init/initramfs.c | 42 +++++++++++++++++++++---------------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/init/initramfs.c b/init/initramfs.c
index d42ec8329cd840..c335920e5ecc2d 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -13,13 +13,13 @@
 #include <linux/memblock.h>
 #include <linux/namei.h>
 
-static ssize_t __init xwrite(int fd, const char *p, size_t count)
+static ssize_t __init xwrite(struct file *file, const char *p, size_t count)
 {
 	ssize_t out = 0;
 
 	/* sys_write only can write MAX_RW_COUNT aka 2G-4K bytes at most */
 	while (count) {
-		ssize_t rv = ksys_write(fd, p, count);
+		ssize_t rv = kernel_write(file, p, count, &file->f_pos);
 
 		if (rv < 0) {
 			if (rv == -EINTR || rv == -EAGAIN)
@@ -317,7 +317,7 @@ static int __init maybe_link(void)
 	return 0;
 }
 
-static __initdata int wfd;
+static __initdata struct file *wfile;
 
 static int __init do_name(void)
 {
@@ -334,16 +334,16 @@ static int __init do_name(void)
 			int openflags = O_WRONLY|O_CREAT;
 			if (ml != 1)
 				openflags |= O_TRUNC;
-			wfd = ksys_open(collected, openflags, mode);
-
-			if (wfd >= 0) {
-				ksys_fchown(wfd, uid, gid);
-				ksys_fchmod(wfd, mode);
-				if (body_len)
-					ksys_ftruncate(wfd, body_len);
-				vcollected = kstrdup(collected, GFP_KERNEL);
-				state = CopyFile;
-			}
+			wfile = filp_open(collected, openflags, mode);
+			if (IS_ERR(wfile))
+				return 0;
+
+			vfs_fchown(wfile, uid, gid);
+			vfs_fchmod(wfile, mode);
+			if (body_len)
+				vfs_truncate(&wfile->f_path, body_len);
+			vcollected = kstrdup(collected, GFP_KERNEL);
+			state = CopyFile;
 		}
 	} else if (S_ISDIR(mode)) {
 		ksys_mkdir(collected, mode);
@@ -365,16 +365,16 @@ static int __init do_name(void)
 static int __init do_copy(void)
 {
 	if (byte_count >= body_len) {
-		if (xwrite(wfd, victim, body_len) != body_len)
+		if (xwrite(wfile, victim, body_len) != body_len)
 			error("write error");
-		ksys_close(wfd);
+		fput(wfile);
 		do_utime(vcollected, mtime);
 		kfree(vcollected);
 		eat(body_len);
 		state = SkipIt;
 		return 0;
 	} else {
-		if (xwrite(wfd, victim, byte_count) != byte_count)
+		if (xwrite(wfile, victim, byte_count) != byte_count)
 			error("write error");
 		body_len -= byte_count;
 		eat(byte_count);
@@ -586,21 +586,21 @@ static void __init clean_rootfs(void)
 static void __init populate_initrd_image(char *err)
 {
 	ssize_t written;
-	int fd;
+	struct file *file;
 
 	unpack_to_rootfs(__initramfs_start, __initramfs_size);
 
 	printk(KERN_INFO "rootfs image is not initramfs (%s); looks like an initrd\n",
 			err);
-	fd = ksys_open("/initrd.image", O_WRONLY | O_CREAT, 0700);
-	if (fd < 0)
+	file = filp_open("/initrd.image", O_WRONLY | O_CREAT, 0700);
+	if (IS_ERR(file))
 		return;
 
-	written = xwrite(fd, (char *)initrd_start, initrd_end - initrd_start);
+	written = xwrite(file, (char *)initrd_start, initrd_end - initrd_start);
 	if (written != initrd_end - initrd_start)
 		pr_err("/initrd.image: incomplete write (%zd != %ld)\n",
 		       written, initrd_end - initrd_start);
-	ksys_close(fd);
+	fput(file);
 }
 #endif /* CONFIG_BLK_DEV_RAM */
 
-- 
2.27.0

