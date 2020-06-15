Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DF1C1F9738
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jun 2020 14:54:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730213AbgFOMyW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Jun 2020 08:54:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730165AbgFOMx7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Jun 2020 08:53:59 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE3BDC061A0E;
        Mon, 15 Jun 2020 05:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=w36WFTF/YYDj+vMMm5K/rSmIM+0T4bCCxz1vwgNGFpA=; b=W+HJGLEFJ+lhk60iQ5Bzln2Y0z
        4E4rSTrm4G+fl4WB3kG6VKhq7JRX1NOxJ4VDudQcbfuWr6MiK8UHjnLd5rDua/GpVNvJk9tPxn93r
        vgDrlTV//pm4B2rsiiFdzeim5d38Bp9wr42ouCpN2TC+J0exS0D+NKzAMZkNPjh9utXIG2jfIM7V3
        nZBhK9WSrv39wMXP9rsnw6F9ir6S/8XGWUf3c9HqQ9suZsJOhlu6rldb8fTilzIwrIoWJ4pZgE/Ki
        tFnXFUau0lpagcsbA18pZKgoAB/kP7rytdHoXz/50+NGRqVVoA9KyvyHEz5XlNLmQPBl9LPhdc08n
        glFWbDpg==;
Received: from 195-192-102-148.dyn.cablelink.at ([195.192.102.148] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jkocg-0000vw-DE; Mon, 15 Jun 2020 12:53:58 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     linux-kernel@vger.kernel.org
Cc:     "H. Peter Anvin" <hpa@zytor.com>, Song Liu <song@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-raid@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 14/16] initramfs: switch initramfs unpacking to struct file based APIs
Date:   Mon, 15 Jun 2020 14:53:21 +0200
Message-Id: <20200615125323.930983-15-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200615125323.930983-1-hch@lst.de>
References: <20200615125323.930983-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

There is no good reason to mess with file descriptors from in-kernel
code, switch the initramfs unpacking to struct file based write
instead.  As we don't have nice helper for chmod or chown on a struct
file or struct path use the pathname based ones instead there.  This
causes additional (cached) lookups, but keeps the code much simpler.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/open.c                |  7 +------
 include/linux/syscalls.h |  1 -
 init/initramfs.c         | 42 ++++++++++++++++++++--------------------
 3 files changed, 22 insertions(+), 28 deletions(-)

diff --git a/fs/open.c b/fs/open.c
index 6cd48a61cda3b9..6348173532e663 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -602,7 +602,7 @@ static int chmod_common(const struct path *path, umode_t mode)
 	return error;
 }
 
-int ksys_fchmod(unsigned int fd, umode_t mode)
+SYSCALL_DEFINE2(fchmod, unsigned int, fd, umode_t, mode)
 {
 	struct fd f = fdget(fd);
 	int err = -EBADF;
@@ -615,11 +615,6 @@ int ksys_fchmod(unsigned int fd, umode_t mode)
 	return err;
 }
 
-SYSCALL_DEFINE2(fchmod, unsigned int, fd, umode_t, mode)
-{
-	return ksys_fchmod(fd, mode);
-}
-
 int do_fchmodat(int dfd, const char __user *filename, umode_t mode)
 {
 	struct path path;
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 005463f5acc23d..5215bd413b6eb1 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -1241,7 +1241,6 @@ int ksys_dup(unsigned int fildes);
 int ksys_chroot(const char __user *filename);
 ssize_t ksys_write(unsigned int fd, const char __user *buf, size_t count);
 int ksys_chdir(const char __user *filename);
-int ksys_fchmod(unsigned int fd, umode_t mode);
 int ksys_fchown(unsigned int fd, uid_t user, gid_t group);
 int ksys_ioctl(unsigned int fd, unsigned int cmd, unsigned long arg);
 ssize_t ksys_read(unsigned int fd, char __user *buf, size_t count);
diff --git a/init/initramfs.c b/init/initramfs.c
index d42ec8329cd840..2d2f433ac7f01b 100644
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
+			ksys_chown(collected, uid, gid);
+			ksys_chmod(collected, mode);
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
2.26.2

