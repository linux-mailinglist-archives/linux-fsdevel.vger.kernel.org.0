Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB93B1F9733
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jun 2020 14:54:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730159AbgFOMx5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Jun 2020 08:53:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730151AbgFOMx4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Jun 2020 08:53:56 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D615C061A0E;
        Mon, 15 Jun 2020 05:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=ogU2QjMmUfc00cMm7n5j/q8ywPJW4zfZmQJ2F5BMFC4=; b=g8xeZiMfr/2sK4MBEpLIwVD3xl
        rn86acswc9xomjhhYebTwyndtNjFZqOl9VO6GCeYedbSxhi2jLRILTMuA/SogwA+HRpEQo2iiwshJ
        Orm46VauO34O3BMh9AhUP1OiHh7U4fJ04qD8BsbRQdOK3E+/0JUsl3miQFMutba/O9S3HkfzOXdC3
        Bg3k/7v4NKzRiuBgnWJrVbbz5kBpzwa2w8b5dieRq+4hqI/9y4BgJwc4bngcVk/okuWQkvKOvRgO6
        KmjhPAlQcmP3wepOMzCf++w8rb5TXQyNMF9RKIkyNgNL1jnKwTe2V5MrgDTQ8yALccyyEjFINFiZT
        HoQgqZbg==;
Received: from 195-192-102-148.dyn.cablelink.at ([195.192.102.148] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jkoce-0000vB-3w; Mon, 15 Jun 2020 12:53:56 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     linux-kernel@vger.kernel.org
Cc:     "H. Peter Anvin" <hpa@zytor.com>, Song Liu <song@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-raid@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 13/16] initramfs: simplify clean_rootfs
Date:   Mon, 15 Jun 2020 14:53:20 +0200
Message-Id: <20200615125323.930983-14-hch@lst.de>
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

Just use d_genocide instead of iterating through the root directory with
cumbersome userspace-like APIs.  This also ensures we actually remove files
that are not direct children of the root entry, which the old code failed
to do.

Fixes: df52092f3c97 ("fastboot: remove duplicate unpack_to_rootfs()")
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/readdir.c             | 11 ++--------
 include/linux/syscalls.h |  2 --
 init/initramfs.c         | 46 +++++-----------------------------------
 3 files changed, 7 insertions(+), 52 deletions(-)

diff --git a/fs/readdir.c b/fs/readdir.c
index a49f07c11cfbd0..19434b3c982cd3 100644
--- a/fs/readdir.c
+++ b/fs/readdir.c
@@ -348,8 +348,8 @@ static int filldir64(struct dir_context *ctx, const char *name, int namlen,
 	return -EFAULT;
 }
 
-int ksys_getdents64(unsigned int fd, struct linux_dirent64 __user *dirent,
-		    unsigned int count)
+SYSCALL_DEFINE3(getdents64, unsigned int, fd,
+		struct linux_dirent64 __user *, dirent, unsigned int, count)
 {
 	struct fd f;
 	struct getdents_callback64 buf = {
@@ -380,13 +380,6 @@ int ksys_getdents64(unsigned int fd, struct linux_dirent64 __user *dirent,
 	return error;
 }
 
-
-SYSCALL_DEFINE3(getdents64, unsigned int, fd,
-		struct linux_dirent64 __user *, dirent, unsigned int, count)
-{
-	return ksys_getdents64(fd, dirent, count);
-}
-
 #ifdef CONFIG_COMPAT
 struct compat_old_linux_dirent {
 	compat_ulong_t	d_ino;
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 6a078b2c442a4e..005463f5acc23d 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -1243,8 +1243,6 @@ ssize_t ksys_write(unsigned int fd, const char __user *buf, size_t count);
 int ksys_chdir(const char __user *filename);
 int ksys_fchmod(unsigned int fd, umode_t mode);
 int ksys_fchown(unsigned int fd, uid_t user, gid_t group);
-int ksys_getdents64(unsigned int fd, struct linux_dirent64 __user *dirent,
-		    unsigned int count);
 int ksys_ioctl(unsigned int fd, unsigned int cmd, unsigned long arg);
 ssize_t ksys_read(unsigned int fd, char __user *buf, size_t count);
 void ksys_sync(void);
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
2.26.2

