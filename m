Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EBB821FC93
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jul 2020 21:10:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730413AbgGNTKT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Jul 2020 15:10:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731382AbgGNTJM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Jul 2020 15:09:12 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5662DC061794;
        Tue, 14 Jul 2020 12:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=eSteiKXBs+T9nikVDk78jTHAmqowdgqYyArs87G/ivQ=; b=FSklrbqGKiY9nUjN1ULO+eLOkk
        RQOL+jNMzBceXGRMhWh64A5RSh7EzmQo2Ooe5wVh09PGfT5RAKNQRmUys/aFuckpUeE2yJXPsQ6bX
        RpJEOjv0tjnwVY9k40hrkgc808d64yATdgHq5qKfFB5Kv/twy/EURF616LrQl7bBrGpKXrofMbYkr
        N72rgNrHkHnC5L4KmNLlvq0HMbtSPvyf7Z1eVvyMewBWFD39pxPDcatWRHCXHi2Dp2e555vFPGMwq
        uiyPYdq4/cU9dNpSpXIwQ1LMbdNYnLuAhgis1g+DH6+DDYqIUn0jU12sUdaxzMBj8S6cz7fQecEwI
        hpc6vWYA==;
Received: from [2001:4bb8:188:5f50:f037:8cfe:627e:7028] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jvQIg-0005sz-HL; Tue, 14 Jul 2020 19:09:10 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     linux-kernel@vger.kernel.org
Cc:     "H. Peter Anvin" <hpa@zytor.com>, Song Liu <song@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-raid@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 15/23] initramfs: remove the populate_initrd_image and clean_rootfs stubs
Date:   Tue, 14 Jul 2020 21:04:19 +0200
Message-Id: <20200714190427.4332-16-hch@lst.de>
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
2.27.0

