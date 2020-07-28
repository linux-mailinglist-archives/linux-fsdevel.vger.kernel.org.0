Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB7C3230FD6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jul 2020 18:37:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731863AbgG1Qfx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jul 2020 12:35:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731434AbgG1Qel (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jul 2020 12:34:41 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31C76C061794;
        Tue, 28 Jul 2020 09:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=qOFuV6UcA+MUgFmH1OSfTwLETH6sSsGzbfJt/+G2KZU=; b=NZA9HN+zyA0ARRuU99pyPbPvkR
        lSJbSBfjs7YoXCao8jifwfxvQUlq6NaiMd7+sCMT7epo0dpuSZ2niq18KtnOqHps7F7zNkpAivT4y
        Xlero3lM2O3mUi9UMQy62evEeH7Oq1edicWYy9sLKhO1vxO/zptPS5ALGm0IBu5oSXRkz79/hfx8f
        oOvonVHbfVbUMzzfn++i05SahkTgsdrtUpMJ5Zy6C4cp7/Y1A+CToUG6TiugYBQwHACQaZMLm6sRS
        o7tHtwRVCdiv8yXTxQVn3kEHD6KBbvN9YpSeIQHrnUYJhL+zkuDOvlST2q+loqcnypcIV1xEX9Yo4
        xaPLgjOA==;
Received: from [2001:4bb8:180:6102:fd04:50d8:4827:5508] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k0SYm-0006zK-KM; Tue, 28 Jul 2020 16:34:37 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
Subject: [PATCH 11/23] init: add an init_rmdir helper
Date:   Tue, 28 Jul 2020 18:34:04 +0200
Message-Id: <20200728163416.556521-12-hch@lst.de>
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

Add a simple helper to rmdir with a kernel space file name and switch
the early init code over to it.  Remove the now unused ksys_rmdir.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/init.c                     | 5 +++++
 include/linux/init_syscalls.h | 1 +
 include/linux/syscalls.h      | 7 -------
 init/initramfs.c              | 2 +-
 4 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/fs/init.c b/fs/init.c
index 507ffbb5d146d6..eabd9ed2b51092 100644
--- a/fs/init.c
+++ b/fs/init.c
@@ -42,3 +42,8 @@ int __init init_unlink(const char *pathname)
 {
 	return do_unlinkat(AT_FDCWD, getname_kernel(pathname));
 }
+
+int __init init_rmdir(const char *pathname)
+{
+	return do_rmdir(AT_FDCWD, getname_kernel(pathname));
+}
diff --git a/include/linux/init_syscalls.h b/include/linux/init_syscalls.h
index 00d597249549ee..abf3af563c0b3a 100644
--- a/include/linux/init_syscalls.h
+++ b/include/linux/init_syscalls.h
@@ -4,3 +4,4 @@ int __init init_mount(const char *dev_name, const char *dir_name,
 		const char *type_page, unsigned long flags, void *data_page);
 int __init init_umount(const char *name, int flags);
 int __init init_unlink(const char *pathname);
+int __init init_rmdir(const char *pathname);
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
diff --git a/init/initramfs.c b/init/initramfs.c
index 7e9db1cfa3c060..fb7210731d9e5d 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -300,7 +300,7 @@ static void __init clean_path(char *path, umode_t fmode)
 
 	if (!vfs_lstat(path, &st) && (st.mode ^ fmode) & S_IFMT) {
 		if (S_ISDIR(st.mode))
-			ksys_rmdir(path);
+			init_rmdir(path);
 		else
 			init_unlink(path);
 	}
-- 
2.27.0

