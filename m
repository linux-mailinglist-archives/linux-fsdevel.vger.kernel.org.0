Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 155FA22F454
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Jul 2020 18:08:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730923AbgG0QH4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Jul 2020 12:07:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730853AbgG0QH4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Jul 2020 12:07:56 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4415C061794;
        Mon, 27 Jul 2020 09:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=fCMVB9ixQ5Y99KMpA0i0BlFL8bplTsu2KNx7sFr/t4g=; b=JyBarzTMK2VwWNuEXkoGRhOicw
        v7ZQOkb8GxQWQwVvJESVo+jf1JBLvfEBIs86NEvTtiU+yqD4PgdlTs4/oMAZdy+1UTbMh/AniFeqw
        290E+7h1WNNGCfwek6YPWGRW1rxBenNkkAEbK5Nn9hlGhR2FvVxXyPnShk3K4Q44GorNdqUPo+2se
        d3hIhzK0mkxrz/Nu/hqbiC0X5rgCmqaaolPESOr1naKS37pkkNUPFiZsnq/a0dthVb0nd4xvYRNI/
        FNvUXWbODO6UGSy0RfooZ7qVxcSVaI/7h7lsnJg6sw4yy2SAQGSTwbyCozC2qHD4oyt0rhD7IGv72
        lQ8xeizw==;
Received: from [2001:4bb8:18c:2acc:aa45:8411:1fb3:30ec] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k05fM-0002mb-Ft; Mon, 27 Jul 2020 16:07:54 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     linux-kernel@vger.kernel.org
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 2/3] initramfs: pass a non-f_pos offset to xwrite
Date:   Mon, 27 Jul 2020 18:07:43 +0200
Message-Id: <20200727160744.329121-3-hch@lst.de>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200727160744.329121-1-hch@lst.de>
References: <20200727160744.329121-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Pass a offset with the same scope as the file instead of ->f_pos.

Fixes: b63c1cd1c339 ("initramfs: switch initramfs unpacking to struct file based APIs")
Reported-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 init/initramfs.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/init/initramfs.c b/init/initramfs.c
index 50ec7e3c5389aa..584bc8fe88e77c 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -13,13 +13,14 @@
 #include <linux/memblock.h>
 #include <linux/namei.h>
 
-static ssize_t __init xwrite(struct file *file, const char *p, size_t count)
+static ssize_t __init xwrite(struct file *file, const char *p, size_t count,
+		loff_t *pos)
 {
 	ssize_t out = 0;
 
 	/* sys_write only can write MAX_RW_COUNT aka 2G-4K bytes at most */
 	while (count) {
-		ssize_t rv = kernel_write(file, p, count, &file->f_pos);
+		ssize_t rv = kernel_write(file, p, count, pos);
 
 		if (rv < 0) {
 			if (rv == -EINTR || rv == -EAGAIN)
@@ -317,6 +318,7 @@ static int __init maybe_link(void)
 }
 
 static __initdata struct file *wfile;
+static __initdata loff_t wfile_pos;
 
 static int __init do_name(void)
 {
@@ -336,6 +338,7 @@ static int __init do_name(void)
 			wfile = filp_open(collected, openflags, mode);
 			if (IS_ERR(wfile))
 				return 0;
+			wfile_pos = 0;
 
 			vfs_fchown(wfile, uid, gid);
 			vfs_fchmod(wfile, mode);
@@ -365,7 +368,7 @@ static int __init do_copy(void)
 	if (byte_count >= body_len) {
 		struct timespec64 t[2] = { };
 
-		if (xwrite(wfile, victim, body_len) != body_len)
+		if (xwrite(wfile, victim, body_len, &wfile_pos) != body_len)
 			error("write error");
 
 		t[0].tv_sec = mtime;
@@ -377,7 +380,7 @@ static int __init do_copy(void)
 		state = SkipIt;
 		return 0;
 	} else {
-		if (xwrite(wfile, victim, byte_count) != byte_count)
+		if (xwrite(wfile, victim, byte_count, &wfile_pos) != byte_count)
 			error("write error");
 		body_len -= byte_count;
 		eat(byte_count);
@@ -580,6 +583,7 @@ static void __init populate_initrd_image(char *err)
 {
 	ssize_t written;
 	struct file *file;
+	loff_t pos = 0;
 
 	unpack_to_rootfs(__initramfs_start, __initramfs_size);
 
@@ -589,7 +593,8 @@ static void __init populate_initrd_image(char *err)
 	if (IS_ERR(file))
 		return;
 
-	written = xwrite(file, (char *)initrd_start, initrd_end - initrd_start);
+	written = xwrite(file, (char *)initrd_start, initrd_end - initrd_start,
+			&pos);
 	if (written != initrd_end - initrd_start)
 		pr_err("/initrd.image: incomplete write (%zd != %ld)\n",
 		       written, initrd_end - initrd_start);
-- 
2.27.0

