Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BB642078B6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jun 2020 18:15:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404971AbgFXQPP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Jun 2020 12:15:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404800AbgFXQOG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Jun 2020 12:14:06 -0400
Received: from casper.infradead.org (unknown [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9867C061573;
        Wed, 24 Jun 2020 09:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=Hlt6C7VzRXUPvzt04ubxLGUKBtxCCqCnw0SDgIXm7hw=; b=WFlQK8lROlq2wopy0YNuA4PurY
        T0La8mdHkssAiMiFwrvbcko8YkFtDBrabnQEmr9F5Yk7RFKipkL7CrRypqv3tav+L1chAZbGheAxz
        4fxFtgdkmemzU2qnSv3htDLZn56HxForOZfiOkDIrUCuEPwf2+tyREjf20+GZ5x3P+JLpGrterVlQ
        CG/NQ/tCGzRDoF7SxTM2pcd9onk5riS1Dy7ma9WITzOt6as9RxPS+LWJk+ORBsn8qbKxN3kCu+cd3
        sSfwwR5mTlp8wrKC8j7Drm49Isnr85P1IGLuIYqt5/Mp0HsWXk9D9F7bsaKJg7zvAhCqXKaiTncc8
        yUoxs6IA==;
Received: from [2001:4bb8:180:a3:5c7c:8955:539d:955b] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jo81w-0005yG-JE; Wed, 24 Jun 2020 16:13:44 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ian Kent <raven@themaw.net>,
        David Howells <dhowells@redhat.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        netfilter-devel@vger.kernel.org
Subject: [PATCH 06/14] fs: implement kernel_write using __kernel_write
Date:   Wed, 24 Jun 2020 18:13:27 +0200
Message-Id: <20200624161335.1810359-7-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200624161335.1810359-1-hch@lst.de>
References: <20200624161335.1810359-1-hch@lst.de>
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

