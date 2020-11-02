Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69A032A333A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Nov 2020 19:43:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbgKBSng (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Nov 2020 13:43:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726512AbgKBSne (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Nov 2020 13:43:34 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DA5FC0617A6
        for <linux-fsdevel@vger.kernel.org>; Mon,  2 Nov 2020 10:43:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=yGyAJgqIZQghEE7oZN0iVtA30eQFmzuryM2GY/sRLrw=; b=hzZgkNvB2NLMB2hjkr63NI85rq
        6Wyh3yajoMs5mWxCOEx2ZXWUsmWlGpWSwJIWzJ7pBIXp3YLddBe7c4NGDdcCluTQ1hQtMycoW33Lo
        mmUx1XfJnruzkutworpYU8T6FTnevOCz7vWvOM4JU97YYLScdlsWWwHqayMS/hhfkEYhGq8y1uX8J
        aS4CA+6E1YiKbZDCD29bHo0ohcbqXyx5Lh3yf9FVgzUrOE1dsFkEC/ki2ll9N1pk+BEUUGP35crQl
        piv4IY6qlf/lYa7Rnr8rBBsRkFgu6LIR2jMoSP0jnAx4TMQEyZK4Y50726gKhtNB1eXvQckl0Zj+S
        sAt0LXvw==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kZenj-0006rN-Vk; Mon, 02 Nov 2020 18:43:32 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     Christoph Hellwig <hch@lst.de>, kent.overstreet@gmail.com,
        Matthew Wilcox <willy@infradead.org>
Subject: [PATCH 17/17] mm: simplify generic_file_read_iter
Date:   Mon,  2 Nov 2020 18:43:12 +0000
Message-Id: <20201102184312.25926-18-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201102184312.25926-1-willy@infradead.org>
References: <20201102184312.25926-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Christoph Hellwig <hch@lst.de>

Avoid the pointless goto out just for returning retval.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/filemap.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 92bb308029c3..4676ce15a9a5 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2549,7 +2549,7 @@ generic_file_read_iter(struct kiocb *iocb, struct iov_iter *iter)
 	ssize_t retval = 0;
 
 	if (!count)
-		goto out; /* skip atime */
+		return 0; /* skip atime */
 
 	if (iocb->ki_flags & IOCB_DIRECT) {
 		struct file *file = iocb->ki_filp;
@@ -2567,7 +2567,7 @@ generic_file_read_iter(struct kiocb *iocb, struct iov_iter *iter)
 						iocb->ki_pos,
 					        iocb->ki_pos + count - 1);
 			if (retval < 0)
-				goto out;
+				return retval;
 		}
 
 		file_accessed(file);
@@ -2590,12 +2590,10 @@ generic_file_read_iter(struct kiocb *iocb, struct iov_iter *iter)
 		 */
 		if (retval < 0 || !count || iocb->ki_pos >= size ||
 		    IS_DAX(inode))
-			goto out;
+			return retval;
 	}
 
-	retval = filemap_read(iocb, iter, retval);
-out:
-	return retval;
+	return filemap_read(iocb, iter, retval);
 }
 EXPORT_SYMBOL(generic_file_read_iter);
 
-- 
2.28.0

