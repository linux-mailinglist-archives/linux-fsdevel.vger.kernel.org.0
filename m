Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCD41226939
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jul 2020 18:29:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732242AbgGTP7b (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Jul 2020 11:59:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732237AbgGTP73 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Jul 2020 11:59:29 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65B72C0619D2;
        Mon, 20 Jul 2020 08:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=jtHBIwmXUO+IpCLDUYA/xY56Y7TdHPfWXhl32/DtCRU=; b=gm1KlltQMD7HECwEh+VO80E1I+
        mOnCoM/Nj7OgwtcQT/16JZ7Dz96rQQ2ZQOHolMQv7HrZaTUekTj9Gjrd29pn/UjrfKL8nYBiTPIvY
        fJdQ2tgXcPZDQpwtFgyQGRjrVbH4Nsc5BSQCtlysT5aLpxjrsZVohxWpJeklyibp92S1Hm96gXFHK
        wqOSpmWSttT2UPAdwI9AubBHlUJvLm1diIxdlF/4BYa/rfuTFzIc81LAz4Yf6R6VYjgi8KD6vUA1B
        w18a0Cnt0Ac1CNC76yZo2GpPnzIevN7vs+vE4l1vjZsiWMBwKHVjcpXTFwQYGTDdJ6frRdHNREzBg
        WPu7TWRg==;
Received: from [2001:4bb8:105:4a81:db56:edb1:dbf2:5cc3] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jxYCK-0007ph-R0; Mon, 20 Jul 2020 15:59:25 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
Subject: [PATCH 12/24] fs: add a kern_utimes helper
Date:   Mon, 20 Jul 2020 17:58:50 +0200
Message-Id: <20200720155902.181712-13-hch@lst.de>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200720155902.181712-1-hch@lst.de>
References: <20200720155902.181712-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add a simple helper to set timestamps with a kernel space name and use it
in the early init code instead of relying on the implicit
set_fs(KERNEL_DS) there.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/utimes.c        | 19 ++++++++++++++-----
 include/linux/fs.h |  1 +
 init/initramfs.c   |  2 +-
 3 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/fs/utimes.c b/fs/utimes.c
index fd3cc42262241f..f4d7f9a73e115a 100644
--- a/fs/utimes.c
+++ b/fs/utimes.c
@@ -7,6 +7,7 @@
 #include <linux/uaccess.h>
 #include <linux/compat.h>
 #include <asm/unistd.h>
+#include "internal.h"
 
 static bool nsec_valid(long nsec)
 {
@@ -75,14 +76,15 @@ int vfs_utimes(const struct path *path, struct timespec64 *times)
 	return error;
 }
 
-static int do_utimes_path(int dfd, const char __user *filename,
+static int do_utimes_path(int dfd, struct filename *name,
 		struct timespec64 *times, int flags)
 {
 	struct path path;
 	int lookup_flags = 0, error;
 
+	error = -EINVAL;
 	if (flags & ~(AT_SYMLINK_NOFOLLOW | AT_EMPTY_PATH))
-		return -EINVAL;
+		goto out_putname;
 
 	if (!(flags & AT_SYMLINK_NOFOLLOW))
 		lookup_flags |= LOOKUP_FOLLOW;
@@ -90,7 +92,7 @@ static int do_utimes_path(int dfd, const char __user *filename,
 		lookup_flags |= LOOKUP_EMPTY;
 
 retry:
-	error = user_path_at(dfd, filename, lookup_flags, &path);
+	error = filename_lookup(dfd, name, lookup_flags, &path, NULL);
 	if (error)
 		return error;
 
@@ -100,10 +102,17 @@ static int do_utimes_path(int dfd, const char __user *filename,
 		lookup_flags |= LOOKUP_REVAL;
 		goto retry;
 	}
-
+out_putname:
+	if (!IS_ERR(name))
+		putname(name);
 	return error;
 }
 
+int __init kern_utimes(const char *filename, struct timespec64 *tv, int flags)
+{
+	return do_utimes_path(AT_FDCWD, getname_kernel(filename), tv, flags);
+}
+
 static int do_utimes_fd(int fd, struct timespec64 *times, int flags)
 {
 	struct fd f;
@@ -140,7 +149,7 @@ long do_utimes(int dfd, const char __user *filename, struct timespec64 *times,
 {
 	if (filename == NULL && dfd != AT_FDCWD)
 		return do_utimes_fd(dfd, times, flags);
-	return do_utimes_path(dfd, filename, times, flags);
+	return do_utimes_path(dfd, getname(filename), times, flags);
 }
 
 SYSCALL_DEFINE4(utimensat, int, dfd, const char __user *, filename,
diff --git a/include/linux/fs.h b/include/linux/fs.h
index ca034126cb0e4d..7472ff0b7062d9 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3676,5 +3676,6 @@ int kern_chroot(const char *filename);
 int __init kern_access(const char *filename, int mode);
 int __init kern_chown(const char *filename, uid_t user, gid_t group, int flag);
 int __init kern_chmod(const char *filename, umode_t mode);
+int __init kern_utimes(const char *filename, struct timespec64 *tv, int flags);
 
 #endif /* _LINUX_FS_H */
diff --git a/init/initramfs.c b/init/initramfs.c
index 2c2d4480d495e8..de850d4c6da200 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -110,7 +110,7 @@ static long __init do_utime(char *filename, time64_t mtime)
 	t[1].tv_sec = mtime;
 	t[1].tv_nsec = 0;
 
-	return do_utimes(AT_FDCWD, filename, t, AT_SYMLINK_NOFOLLOW);
+	return kern_utimes(filename, t, 0);
 }
 
 static __initdata LIST_HEAD(dir_list);
-- 
2.27.0

