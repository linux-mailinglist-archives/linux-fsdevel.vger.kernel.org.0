Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E676228563
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jul 2020 18:29:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730471AbgGUQ2y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Jul 2020 12:28:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730436AbgGUQ2q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Jul 2020 12:28:46 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FDC0C061794;
        Tue, 21 Jul 2020 09:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=9uDvpsjxPknxmuHeavNUO3LRrao1Q/bL/SVSrfJyE/4=; b=vgAHUYuDcIS/PmGkZhKg0rR5cy
        y0FZOlTKkxGwIbbBGQi2+llCO8nLcR/voz1Q7vXh+yGCWrFN1zdfYH0aBc8YWudwjxPz+gPTYuZ6c
        0QuOnIbAe4uK8u8VE7nAeg16IhQ5mcVWszcfnuK1t0psiiVK1BZnh3fRR4rwqgzZgF+9RD9Pmfsww
        MxHjfkcm0xfBFd4xqdjtmpl6UaQZzec7mo3vIomXMF4vR7OSnyGQI82jI3T5LpyXsedu7zI1ES9BX
        Lfk9eJQyvqC6pONxVnja7pVMI7BEmjNHKoFKSdUlNNaIgGW8o/bUzwvoTwVx01G2ks/fLbiU+/mKv
        NLpSIzrA==;
Received: from [2001:4bb8:18c:2acc:5b1c:6483:bd6d:e406] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jxv8D-0007Ul-6s; Tue, 21 Jul 2020 16:28:42 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
Subject: [PATCH 14/24] init: add an init_rmdir helper
Date:   Tue, 21 Jul 2020 18:28:08 +0200
Message-Id: <20200721162818.197315-15-hch@lst.de>
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

Add a simple helper to rmdir with a kernel space file name and switch
the early init code over to it.  Remove the now unused ksys_rmdir.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/syscalls.h | 7 -------
 init/do_mounts.h         | 1 +
 init/fs.c                | 5 +++++
 init/initramfs.c         | 2 +-
 4 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 26f9738e5ab861..a7b14258d245e2 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -1273,13 +1273,6 @@ int compat_ksys_ipc(u32 call, int first, int second,
  * The following kernel syscall equivalents are just wrappers to fs-internal
  * functions. Therefore, provide stubs to be inlined at the callsites.
  */
-long do_rmdir(int dfd, struct filename *name);
-
-static inline long ksys_rmdir(const char __user *pathname)
-{
-	return do_rmdir(AT_FDCWD, getname(pathname));
-}
-
 extern long do_mkdirat(int dfd, const char __user *pathname, umode_t mode);
 
 static inline long ksys_mkdir(const char __user *pathname, umode_t mode)
diff --git a/init/do_mounts.h b/init/do_mounts.h
index d2f1f335b5b5b9..58605396d358d7 100644
--- a/init/do_mounts.h
+++ b/init/do_mounts.h
@@ -12,6 +12,7 @@
 int __init init_mount(const char *dev_name, const char *dir_name,
 		const char *type_page, unsigned long flags, void *data_page);
 int __init init_unlink(const char *pathname);
+int __init init_rmdir(const char *pathname);
 
 void  mount_block_root(char *name, int flags);
 void  mount_root(void);
diff --git a/init/fs.c b/init/fs.c
index 1bdb5dc5ec12ba..b69b2f949b6132 100644
--- a/init/fs.c
+++ b/init/fs.c
@@ -24,3 +24,8 @@ int __init init_unlink(const char *pathname)
 {
 	return do_unlinkat(AT_FDCWD, getname_kernel(pathname));
 }
+
+int __init init_rmdir(const char *pathname)
+{
+	return do_rmdir(AT_FDCWD, getname_kernel(pathname));
+}
diff --git a/init/initramfs.c b/init/initramfs.c
index 664be397c6b41e..41491149fb1f29 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -306,7 +306,7 @@ static void __init clean_path(char *path, umode_t fmode)
 
 	if (!vfs_lstat(path, &st) && (st.mode ^ fmode) & S_IFMT) {
 		if (S_ISDIR(st.mode))
-			ksys_rmdir(path);
+			init_rmdir(path);
 		else
 			init_unlink(path);
 	}
-- 
2.27.0

