Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2FFA21A33B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jul 2020 17:18:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728246AbgGIPSs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Jul 2020 11:18:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728215AbgGIPSo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Jul 2020 11:18:44 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4454C08C5CE;
        Thu,  9 Jul 2020 08:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=0VBsc/2pETwqgb7YcshndvphI/887af+KZS1l+DRoHs=; b=uxP8xOwV9SXrZkgLKnINWJ0wqD
        mZhDGHdxtMdLO4aaS0Tiu7hkMgdseNQGuDKypU+sSB7bt12jyJwizYg37X2Bdq57bby6ZUXHzovq7
        aA9jJ8V1zCBh8bwVmNizlfF6nbvBAjvk6WFoRWLWoLNpa6VHHgLBIHNRv6sfcmEDJKfZejMgVyB58
        99h+luuKzCqKlxWFd115TfAva+Y1rYGOmLH8gf19BEiaWNpQ5AuFMlquWv4xdFKQgOiaCITE55rFi
        Rh6WLCyXyMHw9B84m1jvbOWrB+JLhlenPY2pKnUnYWJpsmx3QB05BIrW+AhwQzFxcMZ/BjGJuHVXS
        KGmhia6g==;
Received: from [2001:4bb8:188:5f50:7053:304b:bf82:82cf] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jtYJu-0005OC-BC; Thu, 09 Jul 2020 15:18:42 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     linux-kernel@vger.kernel.org
Cc:     "H. Peter Anvin" <hpa@zytor.com>, Song Liu <song@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-raid@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 16/17] init: open code setting up stdin/stdout/stderr
Date:   Thu,  9 Jul 2020 17:18:13 +0200
Message-Id: <20200709151814.110422-17-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200709151814.110422-1-hch@lst.de>
References: <20200709151814.110422-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Don't rely on the implicit set_fs(KERNEL_DS) for ksys_open to work, but
instead open a struct file for /dev/console and then install it as FD
0/1/2 manually.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/file.c                |  7 +------
 include/linux/syscalls.h |  1 -
 init/main.c              | 16 ++++++++++------
 3 files changed, 11 insertions(+), 13 deletions(-)

diff --git a/fs/file.c b/fs/file.c
index abb8b7081d7a44..85b7993165dd2f 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -985,7 +985,7 @@ SYSCALL_DEFINE2(dup2, unsigned int, oldfd, unsigned int, newfd)
 	return ksys_dup3(oldfd, newfd, 0);
 }
 
-int ksys_dup(unsigned int fildes)
+SYSCALL_DEFINE1(dup, unsigned int, fildes)
 {
 	int ret = -EBADF;
 	struct file *file = fget_raw(fildes);
@@ -1000,11 +1000,6 @@ int ksys_dup(unsigned int fildes)
 	return ret;
 }
 
-SYSCALL_DEFINE1(dup, unsigned int, fildes)
-{
-	return ksys_dup(fildes);
-}
-
 int f_dupfd(unsigned int from, struct file *file, unsigned flags)
 {
 	int err;
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index e8810d75efa9b0..59af62090ac400 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -1237,7 +1237,6 @@ asmlinkage long sys_ni_syscall(void);
  */
 
 int ksys_umount(char __user *name, int flags);
-int ksys_dup(unsigned int fildes);
 int ksys_chroot(const char __user *filename);
 ssize_t ksys_write(unsigned int fd, const char __user *buf, size_t count);
 int ksys_chdir(const char __user *filename);
diff --git a/init/main.c b/init/main.c
index 0ead83e86b5aa2..db0621dfbb0468 100644
--- a/init/main.c
+++ b/init/main.c
@@ -1457,15 +1457,19 @@ static int __ref kernel_init(void *unused)
 	      "See Linux Documentation/admin-guide/init.rst for guidance.");
 }
 
+/* Open /dev/console, for stdin/stdout/stderr, this should never fail */
 void console_on_rootfs(void)
 {
-	/* Open the /dev/console as stdin, this should never fail */
-	if (ksys_open((const char __user *) "/dev/console", O_RDWR, 0) < 0)
-		pr_err("Warning: unable to open an initial console.\n");
+	struct file *file = filp_open("/dev/console", O_RDWR, 0);
 
-	/* create stdout/stderr */
-	(void) ksys_dup(0);
-	(void) ksys_dup(0);
+	if (IS_ERR(file)) {
+		pr_err("Warning: unable to open an initial console.\n");
+		return;
+	}
+	get_file_rcu_many(file, 2);
+	fd_install(get_unused_fd_flags(0), file);
+	fd_install(get_unused_fd_flags(0), file);
+	fd_install(get_unused_fd_flags(0), file);
 }
 
 static noinline void __init kernel_init_freeable(void)
-- 
2.26.2

