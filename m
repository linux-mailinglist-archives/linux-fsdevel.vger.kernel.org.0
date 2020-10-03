Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2FC02820A1
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Oct 2020 04:55:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725868AbgJCCzl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Oct 2020 22:55:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725816AbgJCCzi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Oct 2020 22:55:38 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F191C0613E3
        for <linux-fsdevel@vger.kernel.org>; Fri,  2 Oct 2020 19:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=UPLu3z3tcWeTMHI5YRDdpEs/flB4+K0MdUAuopHPBLc=; b=ExLNB5SI1+Tf7fT8uQl0XeY7Pl
        WXP9GOrvyBtVmFEnpHuhFAQjlk3kmN5DfewTf13X+E8mZ51IWiHRoYrRHSUx0quU6ktp88bsBFiTp
        /ns82reOMuO9Z1BUbMhk9yqlCFTzH8fGtR5U3NiPq1mQV3oUTnklumya31Zy6C3FKIzlRvS4G4cES
        UBQvPJbsqgk3yi+XQ7Sx3UUiZMABZsYtzFWBUFdVGxFSSmCQsk/77YyTVAI1AA/6j2zdmc2QnBmud
        B9pa5iQ7lK2wYf2UrpS/yNhrrGt9Y3CoZsBeHsaoV8vkQp8Jayll6+yZRduU5wViz68Y8ax/vQVwd
        929N9tKA==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kOXhv-0005Ud-Vy; Sat, 03 Oct 2020 02:55:36 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org
Subject: [PATCH 02/13] fs: Allow a NULL pos pointer to __kernel_read
Date:   Sat,  3 Oct 2020 03:55:23 +0100
Message-Id: <20201003025534.21045-3-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201003025534.21045-1-willy@infradead.org>
References: <20201003025534.21045-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Match the behaviour of new_sync_read() and __kernel_write().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/read_write.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/read_write.c b/fs/read_write.c
index 7ee07f76fafc..cf420e57541f 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -449,11 +449,12 @@ ssize_t __kernel_read(struct file *file, void *buf, size_t count, loff_t *pos)
 		return warn_unsupported(file, "read");
 
 	init_sync_kiocb(&kiocb, file);
-	kiocb.ki_pos = *pos;
+	kiocb.ki_pos = pos ? *pos : 0;
 	iov_iter_kvec(&iter, READ, &iov, 1, iov.iov_len);
 	ret = file->f_op->read_iter(&kiocb, &iter);
 	if (ret > 0) {
-		*pos = kiocb.ki_pos;
+		if (pos)
+			*pos = kiocb.ki_pos;
 		fsnotify_access(file);
 		add_rchar(current, ret);
 	}
-- 
2.28.0

