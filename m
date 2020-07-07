Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CDC421758D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jul 2020 19:49:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728505AbgGGRt1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Jul 2020 13:49:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728440AbgGGRsQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Jul 2020 13:48:16 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8347C08C5DC;
        Tue,  7 Jul 2020 10:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=Hlt6C7VzRXUPvzt04ubxLGUKBtxCCqCnw0SDgIXm7hw=; b=FedC0yESTcWwLvcjowIvzYO5kq
        8Yla9CQhhoM/P0NsCRc27TI/uwOMB4Zu/E/moc4ndCkdSL7NkZRiZMhNHYrIC5HR0iFKw+/WysYlI
        yZKTU4iq0Np4TKJJZDx8/A0D8+hrnzF+IVbTcB7rw9YU/aVnsKslNf0hm1+6xDktO2bLaOsdc4xhk
        6keJC5+QACVIp2qX070sCpAyFI0oF6XVXLkh/QuNi0zDp6m+WrKDhNMqhg4NFP9GFON81Kjc3yvDI
        Si1EG5LTZeEpStd9gD/5Y2Oj0TeN8zngapPPA0yjHU2vsIEebH/UdlL3HVwENCxTE9DtEbr7R06Se
        FIxz2vBA==;
Received: from [2001:4bb8:18c:3b3b:a49f:8154:a2b7:8b6c] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jsrhS-0003Hj-Fn; Tue, 07 Jul 2020 17:48:10 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 06/23] fs: implement kernel_write using __kernel_write
Date:   Tue,  7 Jul 2020 19:47:44 +0200
Message-Id: <20200707174801.4162712-7-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200707174801.4162712-1-hch@lst.de>
References: <20200707174801.4162712-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Consolidate the two in-kernel write helpers to make upcoming changes
easier.  The only difference are the missing call to rw_verify_area
in kernel_write, and an access_ok check that doesn't make sense for
kernel buffers to start with.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/read_write.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/fs/read_write.c b/fs/read_write.c
index 8f9fc05990ae8b..5110cd1e6e2771 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -499,6 +499,7 @@ static ssize_t __vfs_write(struct file *file, const char __user *p,
 		return -EINVAL;
 }
 
+/* caller is responsible for file_start_write/file_end_write */
 ssize_t __kernel_write(struct file *file, const void *buf, size_t count, loff_t *pos)
 {
 	mm_segment_t old_fs;
@@ -528,16 +529,16 @@ ssize_t __kernel_write(struct file *file, const void *buf, size_t count, loff_t
 ssize_t kernel_write(struct file *file, const void *buf, size_t count,
 			    loff_t *pos)
 {
-	mm_segment_t old_fs;
-	ssize_t res;
+	ssize_t ret;
 
-	old_fs = get_fs();
-	set_fs(KERNEL_DS);
-	/* The cast to a user pointer is valid due to the set_fs() */
-	res = vfs_write(file, (__force const char __user *)buf, count, pos);
-	set_fs(old_fs);
+	ret = rw_verify_area(WRITE, file, pos, count);
+	if (ret)
+		return ret;
 
-	return res;
+	file_start_write(file);
+	ret =  __kernel_write(file, buf, count, pos);
+	file_end_write(file);
+	return ret;
 }
 EXPORT_SYMBOL(kernel_write);
 
-- 
2.26.2

