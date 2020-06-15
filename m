Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 714311F9741
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jun 2020 14:54:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730258AbgFOMyu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Jun 2020 08:54:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730147AbgFOMxy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Jun 2020 08:53:54 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4673CC05BD43;
        Mon, 15 Jun 2020 05:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=yk3OCOpM9ERuS6a7MWF8GpDAoj/9WQHMyiD2P3ZZBTM=; b=DORPIwZ4pxAzbWNekeX4NpVqD6
        5vreyh7ssVzIaBGUxUs1gWnQ77tIyIbRjU4bJj7tsABikZwKQdazCT61K4vaD7pc9HWKcX/oFvhIw
        N6jg0rDdNHrh483CrbV+/YSUkMJe0fEhSZnz33uausGMSKErc8yBF3lWiSR15D4avN0uXid+acj0P
        PjgteRwcXZytXz8HVCciPH9+cnEot3o/fRE0ImlApFNOLRKDfkeIrCT035sVajkuThuCN+wxoIIM+
        5TVXHg9ncXD5UzOqD/itkvzou3EXKU/p4+fSUEzAjeTtxECwX6XEmZqqb/w0ddneoIkqX0J9G5XZ7
        ighIujvA==;
Received: from 195-192-102-148.dyn.cablelink.at ([195.192.102.148] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jkocb-0000uh-Ps; Mon, 15 Jun 2020 12:53:54 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     linux-kernel@vger.kernel.org
Cc:     "H. Peter Anvin" <hpa@zytor.com>, Song Liu <song@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-raid@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 12/16] initramfs: remove the populate_initrd_image and clean_rootfs stubs
Date:   Mon, 15 Jun 2020 14:53:19 +0200
Message-Id: <20200615125323.930983-13-hch@lst.de>
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

If initrd support is not enable just print the warning directly instead
of hiding the fact that we just failed behind two stub functions.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 init/initramfs.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/init/initramfs.c b/init/initramfs.c
index 7a38012e1af742..d10404625c31f0 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -618,13 +618,7 @@ static void __init clean_rootfs(void)
 	ksys_close(fd);
 	kfree(buf);
 }
-#else
-static inline void clean_rootfs(void)
-{
-}
-#endif /* CONFIG_BLK_DEV_RAM */
 
-#ifdef CONFIG_BLK_DEV_RAM
 static void __init populate_initrd_image(char *err)
 {
 	ssize_t written;
@@ -644,11 +638,6 @@ static void __init populate_initrd_image(char *err)
 		       written, initrd_end - initrd_start);
 	ksys_close(fd);
 }
-#else
-static void __init populate_initrd_image(char *err)
-{
-	printk(KERN_EMERG "Initramfs unpacking failed: %s\n", err);
-}
 #endif /* CONFIG_BLK_DEV_RAM */
 
 static int __init populate_rootfs(void)
@@ -668,8 +657,12 @@ static int __init populate_rootfs(void)
 
 	err = unpack_to_rootfs((char *)initrd_start, initrd_end - initrd_start);
 	if (err) {
+#ifdef CONFIG_BLK_DEV_RAM
 		clean_rootfs();
 		populate_initrd_image(err);
+#else
+		printk(KERN_EMERG "Initramfs unpacking failed: %s\n", err);
+#endif
 	}
 
 done:
-- 
2.26.2

