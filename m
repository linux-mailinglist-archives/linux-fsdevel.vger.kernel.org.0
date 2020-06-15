Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 163C71F972B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jun 2020 14:54:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730183AbgFOMyG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Jun 2020 08:54:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730174AbgFOMyB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Jun 2020 08:54:01 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 328BDC061A0E;
        Mon, 15 Jun 2020 05:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=A27NnadNuuURtrOVcCToxHxc4WmXNjPcYjKSm7r2Lj4=; b=qDldmTPVN54waXJTZy3r7RjsuS
        ZgBBd2sVr6kjLK2n8wGfku54G4YbaUzHRpIKbctytGPmcA7OGDP7bVpYUxuR/o0JVmWOhVclfOTHG
        TEVgX5ttrLq6hS7b/hHa0JvgTbIwB2dnEG4GnKUdtpkwVWs2KAvuKFMME5lnzE2Ak1NoAPsjmMlGK
        i53/7hp56aSzEBxr7GrnsoE83HshG4Xbt3f9hTkuM+3GNHzqnxpzQtwvrCSvENd9P51mOKfB69hME
        FHlfzdeMjSWZPobHqQMQPdIEPjM/GrxkAo1orACziwLqDQ5bGgC25e6hXQBIuXzJiS74xA9WpZI/B
        Yg59S9JA==;
Received: from 195-192-102-148.dyn.cablelink.at ([195.192.102.148] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jkoci-0000wd-NH; Mon, 15 Jun 2020 12:54:01 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     linux-kernel@vger.kernel.org
Cc:     "H. Peter Anvin" <hpa@zytor.com>, Song Liu <song@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-raid@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 15/16] init: open code setting up stdin/stdout/stderr
Date:   Mon, 15 Jun 2020 14:53:22 +0200
Message-Id: <20200615125323.930983-16-hch@lst.de>
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
index 5215bd413b6eb1..bde56097a7c27e 100644
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

