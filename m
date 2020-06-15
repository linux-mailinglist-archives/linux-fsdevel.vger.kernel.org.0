Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C4781F972E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jun 2020 14:54:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730196AbgFOMyK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Jun 2020 08:54:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730151AbgFOMyD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Jun 2020 08:54:03 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77762C061A0E;
        Mon, 15 Jun 2020 05:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=1KCtMFMidg8j5+RRPMBUA9PGVNgNjBMGmtgBzIQsZfY=; b=JCvoHSqxmt540LvBpxy5/i0AgC
        M5CMLTfSo+Cpkw7sCpe83h19glLsPiDG6vlfhy2XBPlj/d5co9IPNPEdCyodNMAgfBVgjKXc4ZRcH
        2SgTRYjpmk1iSzgvC761SZNOTcp3bVHd0Jo2wPVsqbAp66RARz6YucSmAkZ9PnjR71hd5eWgsfWIq
        el7B0vs4ZcYM1QN/HEnGcVJaq4QaJ5AQkZC5kzGWEa5l+y+wCJaUmZUkWooXoYGvEj4PYyWaOBVwY
        wNt23Ap6iL1f9Fp5jL2Ji84XKGRjMaPrf9ZlI3HZPfTKOAPXiefyfZUpGTBbhOZkgk+4hM1IasBpK
        ki2l9n4A==;
Received: from 195-192-102-148.dyn.cablelink.at ([195.192.102.148] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jkocl-0000wy-0e; Mon, 15 Jun 2020 12:54:03 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     linux-kernel@vger.kernel.org
Cc:     "H. Peter Anvin" <hpa@zytor.com>, Song Liu <song@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-raid@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 16/16] fs: remove ksys_open
Date:   Mon, 15 Jun 2020 14:53:23 +0200
Message-Id: <20200615125323.930983-17-hch@lst.de>
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
index bde56097a7c27e..90910d6f4d51fe 100644
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

