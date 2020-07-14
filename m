Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0694E21FC86
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jul 2020 21:10:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730961AbgGNTJ6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Jul 2020 15:09:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730645AbgGNTJR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Jul 2020 15:09:17 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63755C061755;
        Tue, 14 Jul 2020 12:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=nw4ihKopIpWaNCr5Y6kT67N/CHkCbR4jVRqwGCHV1nE=; b=qqNHbLIRKZphbu96z3Z01iyAkK
        xtTx8ZQii1DUdG8kyK0YYXOcSXjEnHVyoj7Eg/NsGa90/rTkYyIqaKxMy9hCL+PXtwf2AFP/483ZQ
        LXEKQjAVEYA2SaW+de6+iJgle93ITzhc7DEkp2thdlvRDrICNez2U37jqNDEir0sZsMc/7tPeII+X
        BptAF25wpWXl0usrmNOOIp8tAxLssJ7MjcTSe9n4D4o6lWIyuWqGXJDgzu6b+QpM18bdc2Np+rren
        DZ7IkznmGYnLePINciciU0aV5f9qZeXCE85GMjO6I3eoNXGl2P0cI3tzt93UxQA5sP6bUvlUN9ong
        9MiJpZ6g==;
Received: from [2001:4bb8:188:5f50:f037:8cfe:627e:7028] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jvQIk-0005td-N3; Tue, 14 Jul 2020 19:09:15 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     linux-kernel@vger.kernel.org
Cc:     "H. Peter Anvin" <hpa@zytor.com>, Song Liu <song@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-raid@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 18/23] init: open code setting up stdin/stdout/stderr
Date:   Tue, 14 Jul 2020 21:04:22 +0200
Message-Id: <20200714190427.4332-19-hch@lst.de>
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

Don't rely on the implicit set_fs(KERNEL_DS) for ksys_open to work, but
instead open a struct file for /dev/console and then install it as FD
0/1/2 manually.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 init/main.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/init/main.c b/init/main.c
index 0ead83e86b5aa2..db0621dfbb0468 100644
--- a/init/main.c
+++ b/init/main.c
@@ -1457,15 +1457,19 @@ static int __ref kernel_init(void *unused)
 	      "See Linux Documentation/admin-guide/init.rst for guidance.");
 }
 
+/* Open /dev/console, for stdin/stdout/stderr, this should never fail */
 void console_on_rootfs(void)
 {
-	/* Open the /dev/console as stdin, this should never fail */
-	if (ksys_open((const char __user *) "/dev/console", O_RDWR, 0) < 0)
-		pr_err("Warning: unable to open an initial console.\n");
+	struct file *file = filp_open("/dev/console", O_RDWR, 0);
 
-	/* create stdout/stderr */
-	(void) ksys_dup(0);
-	(void) ksys_dup(0);
+	if (IS_ERR(file)) {
+		pr_err("Warning: unable to open an initial console.\n");
+		return;
+	}
+	get_file_rcu_many(file, 2);
+	fd_install(get_unused_fd_flags(0), file);
+	fd_install(get_unused_fd_flags(0), file);
+	fd_install(get_unused_fd_flags(0), file);
 }
 
 static noinline void __init kernel_init_freeable(void)
-- 
2.27.0

