Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6209A21FC7E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jul 2020 21:09:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730472AbgGNTJi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Jul 2020 15:09:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730912AbgGNTJU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Jul 2020 15:09:20 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99CF3C08C5DB;
        Tue, 14 Jul 2020 12:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=iWkh8Btldl3XCc5aNwbc5cXedccmUtTPbYLxbSvDT4g=; b=s520x2cNbQFFcYmwajOIu+Y7OJ
        3a20jztlitplwxJBxD2ngsAElq9udqi3Yb5ZdnkQq7NL3Gqy3lqTxc7bIqC25FpBYcI8UYWnT9fnz
        maQQGRv3IbXvMHLQFt+OSXlNMOtJqxsNmFCvEF167nbp3Yyq124lAKKRHcyGIZOi/Md9ydMGExigP
        qwpHlbFWcw8t3wMhTy7QP2TLuWT8Mfa2iBSzE41iSqfztUYjFUxoyt6AbM6oU9W2ag1IGtOf+8nuV
        br+bFosd5T0SydXxxzU6Y9dcvJaVAWbbX5fL1bbO1M1muMaoZF8m3TI5L6/G78IcRz6z3irPB8obp
        IYsH6Cew==;
Received: from [2001:4bb8:188:5f50:f037:8cfe:627e:7028] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jvQIn-0005u4-3m; Tue, 14 Jul 2020 19:09:17 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     linux-kernel@vger.kernel.org
Cc:     "H. Peter Anvin" <hpa@zytor.com>, Song Liu <song@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-raid@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 20/23] fs: remove ksys_open
Date:   Tue, 14 Jul 2020 21:04:24 +0200
Message-Id: <20200714190427.4332-21-hch@lst.de>
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

Just open code it in the two callers.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/open.c                | 11 ++++++++---
 include/linux/syscalls.h | 11 -----------
 2 files changed, 8 insertions(+), 14 deletions(-)

diff --git a/fs/open.c b/fs/open.c
index 75166f071d280a..ab3671af8a9705 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -1208,7 +1208,9 @@ long do_sys_open(int dfd, const char __user *filename, int flags, umode_t mode)
 
 SYSCALL_DEFINE3(open, const char __user *, filename, int, flags, umode_t, mode)
 {
-	return ksys_open(filename, flags, mode);
+	if (force_o_largefile())
+		flags |= O_LARGEFILE;
+	return do_sys_open(AT_FDCWD, filename, flags, mode);
 }
 
 SYSCALL_DEFINE4(openat, int, dfd, const char __user *, filename, int, flags,
@@ -1270,9 +1272,12 @@ COMPAT_SYSCALL_DEFINE4(openat, int, dfd, const char __user *, filename, int, fla
  */
 SYSCALL_DEFINE2(creat, const char __user *, pathname, umode_t, mode)
 {
-	return ksys_open(pathname, O_CREAT | O_WRONLY | O_TRUNC, mode);
-}
+	int flags = O_CREAT | O_WRONLY | O_TRUNC;
 
+	if (force_o_largefile())
+		flags |= O_LARGEFILE;
+	return do_sys_open(AT_FDCWD, pathname, flags, mode);
+}
 #endif
 
 /*
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index a998651629c71b..363baaadf8e19a 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -1374,17 +1374,6 @@ static inline int ksys_close(unsigned int fd)
 	return __close_fd(current->files, fd);
 }
 
-extern long do_sys_open(int dfd, const char __user *filename, int flags,
-			umode_t mode);
-
-static inline long ksys_open(const char __user *filename, int flags,
-			     umode_t mode)
-{
-	if (force_o_largefile())
-		flags |= O_LARGEFILE;
-	return do_sys_open(AT_FDCWD, filename, flags, mode);
-}
-
 extern long do_sys_truncate(const char __user *pathname, loff_t length);
 
 static inline long ksys_truncate(const char __user *pathname, loff_t length)
-- 
2.27.0

