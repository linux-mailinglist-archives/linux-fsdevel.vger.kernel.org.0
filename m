Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3356221A33E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jul 2020 17:19:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728238AbgGIPSs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Jul 2020 11:18:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728150AbgGIPSq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Jul 2020 11:18:46 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7895DC08C5CE;
        Thu,  9 Jul 2020 08:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=4Q7oU7KSFv868hQYqAShdiN8TCW220JDegTgqB1k4fw=; b=QY/BbB98LE4pY80pN791XLF+RN
        hH5jVErzdhj6itDy95ltl1BO8lZl5RfE8tV2avcehalV3AcuDjbaS9xqk3eGfxO/xVpMLqqfVZvQS
        S4r6vn5DpVX9GuNC/tnmnrmk6nrKtHb0rKIYjvs5Mh/9w6GzYy7ZnybXTjMSbrm1f2Ilj2sOLa1GP
        mfU5p5+cvs1nJDGRKZ7h2tZpsG5w9aoeRE2rnLN05HHJGL47eD/TOL8Ljjc7Xxmjj1f8RFxkVzRN7
        jEAUyiybJOaY9Sg7n4NrA3sejGm3rBz+Wa5QLxixtG6YTJedZul9dHo3pEcCN8XZ8B0PEyxC52I1y
        0HxyQT1w==;
Received: from [2001:4bb8:188:5f50:7053:304b:bf82:82cf] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jtYJw-0005Ot-Ig; Thu, 09 Jul 2020 15:18:45 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     linux-kernel@vger.kernel.org
Cc:     "H. Peter Anvin" <hpa@zytor.com>, Song Liu <song@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-raid@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 17/17] fs: remove ksys_open
Date:   Thu,  9 Jul 2020 17:18:14 +0200
Message-Id: <20200709151814.110422-18-hch@lst.de>
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

Just open code it in the two callers.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/open.c                | 11 ++++++++---
 include/linux/syscalls.h | 11 -----------
 2 files changed, 8 insertions(+), 14 deletions(-)

diff --git a/fs/open.c b/fs/open.c
index 6348173532e663..4375a5a8e726ea 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -1193,7 +1193,9 @@ long do_sys_open(int dfd, const char __user *filename, int flags, umode_t mode)
 
 SYSCALL_DEFINE3(open, const char __user *, filename, int, flags, umode_t, mode)
 {
-	return ksys_open(filename, flags, mode);
+	if (force_o_largefile())
+		flags |= O_LARGEFILE;
+	return do_sys_open(AT_FDCWD, filename, flags, mode);
 }
 
 SYSCALL_DEFINE4(openat, int, dfd, const char __user *, filename, int, flags,
@@ -1255,9 +1257,12 @@ COMPAT_SYSCALL_DEFINE4(openat, int, dfd, const char __user *, filename, int, fla
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
index 59af62090ac400..39ff738997a172 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -1372,17 +1372,6 @@ static inline int ksys_close(unsigned int fd)
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
2.26.2

