Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D454828209D
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Oct 2020 04:55:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725826AbgJCCzi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Oct 2020 22:55:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725801AbgJCCzi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Oct 2020 22:55:38 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30D27C0613E2
        for <linux-fsdevel@vger.kernel.org>; Fri,  2 Oct 2020 19:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=jc9OXlaFsjPeSvzqJe3w6n4xCDxczwCuy/rH67ouAzg=; b=uyVm+i6aZu8iG0Y1b9dxk3HXOQ
        d7zj0LYRgh4zkBu5zRazXXAk4OyMYiROTIxbYQUz0HzLXQjZ4lc/lIQHGOm2XNO0W3zBlifW/cGEQ
        O3AQLcNH13bTCSgZYyYpHg5Oqe07jP1EvnaT7vcwKUHV+ongr+opuMcIvKWTLwlQmioi4bV8RczAy
        fwWzqc5VrtSb8mVThF/whNo7my0teeyx7wk+0MaQrDjnTDgxuwATtVNuBXL08Y80xVq/KT3/cNBvg
        U6d9x/k1Dyykl2K/B/9ttsw9FIDUmJPU2ILXBnYZek5YENH78MMDP2jrhaCG/SOdozB8SAUJFzbNU
        e2a6RQ+Q==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kOXhv-0005UY-RE; Sat, 03 Oct 2020 02:55:35 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org
Subject: [PATCH 01/13] fs: Allow a NULL pos pointer to __kernel_write
Date:   Sat,  3 Oct 2020 03:55:22 +0100
Message-Id: <20201003025534.21045-2-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201003025534.21045-1-willy@infradead.org>
References: <20201003025534.21045-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Linus prefers that callers be allowed to pass in a NULL pointer for ppos
like new_sync_write().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/read_write.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/read_write.c b/fs/read_write.c
index d835b5c86fae..7ee07f76fafc 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -544,11 +544,12 @@ ssize_t __kernel_write(struct file *file, const void *buf, size_t count, loff_t
 		return warn_unsupported(file, "write");
 
 	init_sync_kiocb(&kiocb, file);
-	kiocb.ki_pos = *pos;
+	kiocb.ki_pos = pos ? *pos : 0;
 	iov_iter_kvec(&iter, WRITE, &iov, 1, iov.iov_len);
 	ret = file->f_op->write_iter(&kiocb, &iter);
 	if (ret > 0) {
-		*pos = kiocb.ki_pos;
+		if (pos)
+			*pos = kiocb.ki_pos;
 		fsnotify_modify(file);
 		add_wchar(current, ret);
 	}
-- 
2.28.0

