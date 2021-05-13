Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FA7A37FB37
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 May 2021 18:07:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235006AbhEMQIq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 May 2021 12:08:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235002AbhEMQIp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 May 2021 12:08:45 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0FFBC061574;
        Thu, 13 May 2021 09:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=qE75pAUGQVDDCijtyhQQzwQRQrPrtPIyFgbLTPxgxEM=; b=jNrgIeLb/4RcpygXlGApYPgOWs
        w5ipkSvQBQlD2dTCL8+dTS19yLiTuOZzFo1gLSMl3PGbYtEu8pS66aD3V4oSt5B2iy5hwJ5UBfq2L
        EwmTTdSpM373PPiHe8yzd2Mcez8/tnKTQHfQ+TgdtSmT7zfiecm5JKmf82wc+4/xPBEKTRDl7V21J
        zS70VzJ9d1lRe/eeWS/JqzcDIzK64Gw/LNsO8rcB/7L9+7RXd5XPPbl+IaAq6x2pIz0LFIp97yEFW
        yDhQmThQcDado/hzRYoDyGs9xLY2gb+G7PQpOgDDmgHtHfjDOiZN9WZ3JjhgWWcyJ7Gn3s0QeOjKt
        nfYdyN/Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lhDrQ-009ZFz-TC; Thu, 13 May 2021 16:06:58 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-kernel@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-abi@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Alexey Dobriyan <adobriyan@gmail.com>
Subject: [PATCH] sysctl: Limit the size of I/Os to PAGE_SIZE
Date:   Thu, 13 May 2021 17:06:48 +0100
Message-Id: <20210513160649.2280429-1-willy@infradead.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We currently allow a read or a write that is up to KMALLOC_MAX_SIZE.
This has caused problems when cat decides to do a 64kB read and
so we allocate a 64kB buffer for the sysctl handler to store into.
The immediate problem was fixed by switching to kvmalloc(), but it's
ridiculous to allocate so much memory to read what is likely to be a
few bytes.

sysfs limits reads and writes to PAGE_SIZE, and I feel we should do the
same for sysctl.  The largest sysctl anyone's been able to come up with
is 433 bytes for /proc/sys/dev/cdrom/info

This will allow simplifying the BPF sysctl code later, but I'll leave
that for someone who understands it better.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/proc/proc_sysctl.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index dea0f5ee540c..a97a8a4ff270 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -562,11 +562,14 @@ static ssize_t proc_sys_call_handler(struct kiocb *iocb, struct iov_iter *iter,
 	if (!table->proc_handler)
 		goto out;
 
-	/* don't even try if the size is too large */
+	/* reads may return short values; large writes must fail now */
+	if (count >= PAGE_SIZE) {
+		if (write)
+			goto out;
+		count = PAGE_SIZE;
+	}
 	error = -ENOMEM;
-	if (count >= KMALLOC_MAX_SIZE)
-		goto out;
-	kbuf = kvzalloc(count + 1, GFP_KERNEL);
+	kbuf = kmalloc(PAGE_SIZE, GFP_KERNEL);
 	if (!kbuf)
 		goto out;
 
@@ -582,12 +585,12 @@ static ssize_t proc_sys_call_handler(struct kiocb *iocb, struct iov_iter *iter,
 	if (error)
 		goto out_free_buf;
 
-	/* careful: calling conventions are nasty here */
 	error = table->proc_handler(table, write, kbuf, &count, &iocb->ki_pos);
 	if (error)
 		goto out_free_buf;
 
 	if (!write) {
+		/* Give BPF the chance to override a read result here? */
 		error = -EFAULT;
 		if (copy_to_iter(kbuf, count, iter) < count)
 			goto out_free_buf;
@@ -595,7 +598,7 @@ static ssize_t proc_sys_call_handler(struct kiocb *iocb, struct iov_iter *iter,
 
 	error = count;
 out_free_buf:
-	kvfree(kbuf);
+	kfree(kbuf);
 out:
 	sysctl_head_finish(head);
 
-- 
2.30.2

