Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FC0521A340
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jul 2020 17:19:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728189AbgGIPSm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Jul 2020 11:18:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728150AbgGIPSh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Jul 2020 11:18:37 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61F46C08C5CE;
        Thu,  9 Jul 2020 08:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=yk3OCOpM9ERuS6a7MWF8GpDAoj/9WQHMyiD2P3ZZBTM=; b=og8x68gWYuZpircwpKYt9bfwDe
        mkjQJ2RAgcwJ/9PBxcGh5jTT0DoJUbWYyKMBsDac9EWcJ8x8o5yS9iFyUC3u23A4YDfiDbcJrm2yH
        /xSGnkYdB6Swp6t0pfja1VH8jv3pZ7tPRSnrgvPphg7h4MSv2P2sCUlMEmaPCHGwnpBCxXdXDu8ny
        5tYhcEWAKiSKYAve1UkWmET8tGnrA7sS5YLR8paj39lxIXA1Q0+om+jddH6SVm4KI/q5n7lk3VEWU
        EDocAbMuPIGp6F9XPaMPmsQfH2yi2RIXmaTprwQlI01IV/yeVLYTDYT0eZlKnbDzm0JbFoTpnN+HK
        2F35+7RQ==;
Received: from [2001:4bb8:188:5f50:7053:304b:bf82:82cf] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jtYJn-0005N0-B7; Thu, 09 Jul 2020 15:18:35 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     linux-kernel@vger.kernel.org
Cc:     "H. Peter Anvin" <hpa@zytor.com>, Song Liu <song@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-raid@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 13/17] initramfs: remove the populate_initrd_image and clean_rootfs stubs
Date:   Thu,  9 Jul 2020 17:18:10 +0200
Message-Id: <20200709151814.110422-14-hch@lst.de>
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

