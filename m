Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29B0830086E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Jan 2021 17:18:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729491AbhAVQRL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Jan 2021 11:17:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729557AbhAVQQv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Jan 2021 11:16:51 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD7E7C06174A;
        Fri, 22 Jan 2021 08:15:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=mw1PgASVvzvnZ/mdEiLUwI2zgqaIpbnSB3KmajCDg3c=; b=i3zZ+JVUpCCuZmhey68sNtPI4U
        JEkV2uJnFz2GWqvhJO/N+xXQKgtnQjcDjfyHj+ydGEek+ErXFpCB+dcV5/DvSAxf+mniFU3ZooQbR
        tn4iJ/9a+28/PuPUUC+mCXtkC7D6mMLJWIioeWEt5ZVaFROroOFlR1IEYyEWZ7sBgQLKTQzTyJ0No
        oA5UtG8QVbg0KXAnxImKNaS+Tc00OfgNGxW0RQFlb8EQNoU1HnZjCt1P2Gq/r1nruklb7n4H+f20e
        dpEX6nhT3FyZF5mMLsOoL7dV1S0YVYoJrr/5c95A0cjlfhdfhWCNWg+ZY26rgMPac1Xd6peFb6185
        wD1LWSOw==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l2z4F-000wlr-Ri; Fri, 22 Jan 2021 16:14:04 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        Kent Overstreet <kent.overstreet@gmail.com>
Subject: [PATCH v5 18/18] mm/filemap: Simplify generic_file_read_iter
Date:   Fri, 22 Jan 2021 16:01:40 +0000
Message-Id: <20210122160140.223228-19-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210122160140.223228-1-willy@infradead.org>
References: <20210122160140.223228-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Christoph Hellwig <hch@lst.de>

Avoid the pointless goto out just for returning retval.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Kent Overstreet <kent.overstreet@gmail.com>
---
 mm/filemap.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index ef910eca9e1a2..f5903494cf173 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2555,7 +2555,7 @@ generic_file_read_iter(struct kiocb *iocb, struct iov_iter *iter)
 	ssize_t retval = 0;
 
 	if (!count)
-		goto out; /* skip atime */
+		return 0; /* skip atime */
 
 	if (iocb->ki_flags & IOCB_DIRECT) {
 		struct file *file = iocb->ki_filp;
@@ -2573,7 +2573,7 @@ generic_file_read_iter(struct kiocb *iocb, struct iov_iter *iter)
 						iocb->ki_pos,
 					        iocb->ki_pos + count - 1);
 			if (retval < 0)
-				goto out;
+				return retval;
 		}
 
 		file_accessed(file);
@@ -2597,12 +2597,10 @@ generic_file_read_iter(struct kiocb *iocb, struct iov_iter *iter)
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
2.29.2

