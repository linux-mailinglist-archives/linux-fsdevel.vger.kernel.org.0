Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DAD022F453
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Jul 2020 18:08:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730712AbgG0QHy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Jul 2020 12:07:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726662AbgG0QHy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Jul 2020 12:07:54 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9DABC061794;
        Mon, 27 Jul 2020 09:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=z3qU3m6tsKDZPbT2vc9pt7LQranlA01CezSpjXDJxnM=; b=Ith/WrXv+lA5OkKjwFbOVJtWCg
        KhBjLIajyMpuKApHvBx5qTZNwGuRkbmFmWmQkHHDJrXY78/ky2fPxKBYNSVLjQgH+byriRENBU24o
        mdk0yUfSoIIgrr+uy31pGcP56rACOr5VSh4jrJyBb+Lc7rrPNQgQKE2M03tKiLZMR8LDIf5cqxqXp
        9GxLRmwgcXtGYGqP6rElsSzdleZZaU6fuOUyyNDhuhn4upG2PWYmJEuABzTuihwS09QJXI3OwB8dz
        8T+l5YLssd4OjjVdkvLvvriWSyQ0DVUkPSDMncIWv7F1BQKj57kKqMdY+SVBTaXQEzoZ1RShs8JN4
        USWRWe8Q==;
Received: from [2001:4bb8:18c:2acc:aa45:8411:1fb3:30ec] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k05fK-0002mU-2r; Mon, 27 Jul 2020 16:07:51 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     linux-kernel@vger.kernel.org
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH 1/3] initramfs: remove clean_rootfs
Date:   Mon, 27 Jul 2020 18:07:42 +0200
Message-Id: <20200727160744.329121-2-hch@lst.de>
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

There is no point in trying to clean up after unpacking the initramfs
failed, as it should never get past the magic number check.  In addition
d_genocide is actually the wrong thing to do here, it should have been
simple_recursive_remove().

Fixes: 38d014f6d446 ("initramfs: simplify clean_rootfs")
Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 init/initramfs.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/init/initramfs.c b/init/initramfs.c
index 3823d15e5d2619..50ec7e3c5389aa 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -576,16 +576,6 @@ static inline bool kexec_free_initrd(void)
 #endif /* CONFIG_KEXEC_CORE */
 
 #ifdef CONFIG_BLK_DEV_RAM
-static void __init clean_rootfs(void)
-{
-	struct path path;
-
-	if (kern_path("/", 0, &path))
-		return;
-	d_genocide(path.dentry);
-	path_put(&path);
-}
-
 static void __init populate_initrd_image(char *err)
 {
 	ssize_t written;
@@ -625,7 +615,6 @@ static int __init populate_rootfs(void)
 	err = unpack_to_rootfs((char *)initrd_start, initrd_end - initrd_start);
 	if (err) {
 #ifdef CONFIG_BLK_DEV_RAM
-		clean_rootfs();
 		populate_initrd_image(err);
 #else
 		printk(KERN_EMERG "Initramfs unpacking failed: %s\n", err);
-- 
2.27.0

