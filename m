Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3008348B6D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Mar 2021 09:23:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbhCYIWh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Mar 2021 04:22:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbhCYIWP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Mar 2021 04:22:15 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87580C06175F;
        Thu, 25 Mar 2021 01:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=+rMCIoW7pA9LHheP4AD2vUH1j8gzDA0578xBrBuuLkU=; b=0pFdJY9A4UdALQUlD9PmA0KXgM
        WVCQAe5hvjOzQw+9nEmscHTvFKGvdGoyY2wykYvjlAfrByYQqvhp7ZkDM/eqXWYwRpI0+4+Wr02Hh
        7dWCo16BSmG9Na9l1ApMPwaU/MpyD1wtTuF6HmK42DKSVkQIJ83KKvBirBowGbsynrMCKiacwgxWg
        aVx+MVz1WMUvXoJpdQwpmna3IGO1MRI1XXoAtu5zGCftq7gAbzjyUZJJ+faZjzbVt1BHA2p5f/i5S
        wsf2ImXlxUTGyNEjh2bsV4CCoQh/FEXaFc6DKwsoiyMUNc7MAF1nAZPkKuhddI83WAOrBHH9W6O9y
        AUaerolg==;
Received: from [2001:4bb8:191:f692:9658:56e2:eade:cbfa] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lPLFu-004X66-Oe; Thu, 25 Mar 2021 08:22:15 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>
Subject: [PATCH] fs: split receive_fd_replace from __receive_fd
Date:   Thu, 25 Mar 2021 09:22:09 +0100
Message-Id: <20210325082209.1067987-2-hch@lst.de>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210325082209.1067987-1-hch@lst.de>
References: <20210325082209.1067987-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

receive_fd_replace shares almost no code with the general case, so split
it out.  Also remove the "Bump the sock usage counts" comment from
both copies, as that is now what __receive_sock actually does.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/file.c            | 39 +++++++++++++++++++--------------------
 include/linux/file.h | 11 ++++-------
 2 files changed, 23 insertions(+), 27 deletions(-)

diff --git a/fs/file.c b/fs/file.c
index f3a4bac2cbe915..d8ccb95a7f4138 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -1068,8 +1068,6 @@ int replace_fd(unsigned fd, struct file *file, unsigned flags)
 
 /**
  * __receive_fd() - Install received file into file descriptor table
- *
- * @fd: fd to install into (if negative, a new fd will be allocated)
  * @file: struct file that was received from another process
  * @ufd: __user pointer to write new fd number to
  * @o_flags: the O_* flags to apply to the new fd entry
@@ -1083,7 +1081,7 @@ int replace_fd(unsigned fd, struct file *file, unsigned flags)
  *
  * Returns newly install fd or -ve on error.
  */
-int __receive_fd(int fd, struct file *file, int __user *ufd, unsigned int o_flags)
+int __receive_fd(struct file *file, int __user *ufd, unsigned int o_flags)
 {
 	int new_fd;
 	int error;
@@ -1092,32 +1090,33 @@ int __receive_fd(int fd, struct file *file, int __user *ufd, unsigned int o_flag
 	if (error)
 		return error;
 
-	if (fd < 0) {
-		new_fd = get_unused_fd_flags(o_flags);
-		if (new_fd < 0)
-			return new_fd;
-	} else {
-		new_fd = fd;
-	}
+	new_fd = get_unused_fd_flags(o_flags);
+	if (new_fd < 0)
+		return new_fd;
 
 	if (ufd) {
 		error = put_user(new_fd, ufd);
 		if (error) {
-			if (fd < 0)
-				put_unused_fd(new_fd);
+			put_unused_fd(new_fd);
 			return error;
 		}
 	}
 
-	if (fd < 0) {
-		fd_install(new_fd, get_file(file));
-	} else {
-		error = replace_fd(new_fd, file, o_flags);
-		if (error)
-			return error;
-	}
+	fd_install(new_fd, get_file(file));
+	__receive_sock(file);
+	return new_fd;
+}
 
-	/* Bump the sock usage counts, if any. */
+int receive_fd_replace(int new_fd, struct file *file, unsigned int o_flags)
+{
+	int error;
+
+	error = security_file_receive(file);
+	if (error)
+		return error;
+	error = replace_fd(new_fd, file, o_flags);
+	if (error)
+		return error;
 	__receive_sock(file);
 	return new_fd;
 }
diff --git a/include/linux/file.h b/include/linux/file.h
index 225982792fa20e..2de2e4613d7bc3 100644
--- a/include/linux/file.h
+++ b/include/linux/file.h
@@ -92,23 +92,20 @@ extern void put_unused_fd(unsigned int fd);
 
 extern void fd_install(unsigned int fd, struct file *file);
 
-extern int __receive_fd(int fd, struct file *file, int __user *ufd,
+extern int __receive_fd(struct file *file, int __user *ufd,
 			unsigned int o_flags);
 static inline int receive_fd_user(struct file *file, int __user *ufd,
 				  unsigned int o_flags)
 {
 	if (ufd == NULL)
 		return -EFAULT;
-	return __receive_fd(-1, file, ufd, o_flags);
+	return __receive_fd(file, ufd, o_flags);
 }
 static inline int receive_fd(struct file *file, unsigned int o_flags)
 {
-	return __receive_fd(-1, file, NULL, o_flags);
-}
-static inline int receive_fd_replace(int fd, struct file *file, unsigned int o_flags)
-{
-	return __receive_fd(fd, file, NULL, o_flags);
+	return __receive_fd(file, NULL, o_flags);
 }
+int receive_fd_replace(int new_fd, struct file *file, unsigned int o_flags);
 
 extern void flush_delayed_fput(void);
 extern void __fput_sync(struct file *);
-- 
2.30.1

