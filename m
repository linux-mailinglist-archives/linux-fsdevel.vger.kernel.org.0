Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 092F021FC9A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jul 2020 21:10:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731005AbgGNTKb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Jul 2020 15:10:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729796AbgGNTJG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Jul 2020 15:09:06 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E81BC061794;
        Tue, 14 Jul 2020 12:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=CYi/UJzBMYfyYmKTc4g8D1ThayCmlPtxZccx7dCXjVw=; b=LRPafBBubmO9VYAR1o4Bp5J8nw
        c/6YHqkIVMRMyMwLRIHONkfhtGKfcfs6OciJVtOCHup0EkLLoCfpeM3olN0xEWMtjSqTe8nKGISbO
        MSfmxvb5fSFlJ/dNn8D5i4cFY3Y5+Sy+xhBYtt65FMOlOfEgqQLB3oaFO0t7qGa1ie4sW/YAq3DKj
        b7FXdzHW5aJnU9pgsahJEstM2jXqMwWbB0oRh7wX7/fxMEg9rOtY4BUyiW9PhGDmxPC9I5dEqxS2b
        aLejwC9x0tKXmMBDjhSYduR6G+pSSbv4LxBhV/fBP2WbM99ECvrrntso2yiCpKJiovAh5GPkcghZC
        vZ8LJ1SA==;
Received: from [2001:4bb8:188:5f50:f037:8cfe:627e:7028] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jvQIa-0005rn-Sz; Tue, 14 Jul 2020 19:09:05 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     linux-kernel@vger.kernel.org
Cc:     "H. Peter Anvin" <hpa@zytor.com>, Song Liu <song@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-raid@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 11/23] initrd: remove the BLKFLSBUF call in handle_initrd
Date:   Tue, 14 Jul 2020 21:04:15 +0200
Message-Id: <20200714190427.4332-12-hch@lst.de>
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

BLKFLSBUF used to be overloaded for the ramdisk driver to free the whole
ramdisk, which was completely different behavior compared to all other
drivers.  But this magic overload got removed in commit ff26956875c2
("brd: remove support for BLKFLSBUF"), so this call is entirely
pointless now.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 init/do_mounts_initrd.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/init/do_mounts_initrd.c b/init/do_mounts_initrd.c
index d72beda824aa79..e4f88e9e1c0839 100644
--- a/init/do_mounts_initrd.c
+++ b/init/do_mounts_initrd.c
@@ -115,21 +115,12 @@ static void __init handle_initrd(void)
 	if (!error)
 		printk("okay\n");
 	else {
-		int fd = ksys_open("/dev/root.old", O_RDWR, 0);
 		if (error == -ENOENT)
 			printk("/initrd does not exist. Ignored.\n");
 		else
 			printk("failed\n");
 		printk(KERN_NOTICE "Unmounting old root\n");
 		ksys_umount("/old", MNT_DETACH);
-		printk(KERN_NOTICE "Trying to free ramdisk memory ... ");
-		if (fd < 0) {
-			error = fd;
-		} else {
-			error = ksys_ioctl(fd, BLKFLSBUF, 0);
-			ksys_close(fd);
-		}
-		printk(!error ? "okay\n" : "failed\n");
 	}
 }
 
-- 
2.27.0

