Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49F562ACBF8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Nov 2020 04:37:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731509AbgKJDh2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Nov 2020 22:37:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731487AbgKJDhZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Nov 2020 22:37:25 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB85FC0613CF
        for <linux-fsdevel@vger.kernel.org>; Mon,  9 Nov 2020 19:37:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=+fsPgy2FGEfkf8K6jz3MHNqzYd6pKUEDydUXAgxaiMA=; b=G9OWyaea+8mGMj/hOqRRvklnBn
        w+/EDAr+N6+Td+sq4O86hI3kBpt42QjzVggn10L6KXJP6wGASEf64Ikpv44rmMIPL13nWIsP/0otr
        mToyhct4Mbg8vVCbIf30nKYqf0pHQnx/q3ICUTy+Ly882Vzv0x9BMUwSEjL5w2U2+goVjrgarKTt9
        YztJCbLMaH3F2znTsMFw5rTQIJLBp4Jp96y+cMGI1j6nXWd57Q3dDW/tucabWwwBKQ/hVcBLAHyH0
        hRCOZ9QL7IGoGiaJZI/+cl0VRX4QwV5AdklwMhXkBzjtR6ed4jtcb/lYstYGZ9Z29XQHfK0AbOZNy
        Y3kL8/aQ==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kcKTC-00068t-Bv; Tue, 10 Nov 2020 03:37:22 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     Christoph Hellwig <hch@lst.de>, kent.overstreet@gmail.com,
        Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v3 18/18] mm/filemap: Simplify generic_file_read_iter
Date:   Tue, 10 Nov 2020 03:37:03 +0000
Message-Id: <20201110033703.23261-19-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201110033703.23261-1-willy@infradead.org>
References: <20201110033703.23261-1-willy@infradead.org>
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
index a080200a9fa0..a09621eb8940 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2540,7 +2540,7 @@ generic_file_read_iter(struct kiocb *iocb, struct iov_iter *iter)
 	ssize_t retval = 0;
 
 	if (!count)
-		goto out; /* skip atime */
+		return 0; /* skip atime */
 
 	if (iocb->ki_flags & IOCB_DIRECT) {
 		struct file *file = iocb->ki_filp;
@@ -2558,7 +2558,7 @@ generic_file_read_iter(struct kiocb *iocb, struct iov_iter *iter)
 						iocb->ki_pos,
 					        iocb->ki_pos + count - 1);
 			if (retval < 0)
-				goto out;
+				return retval;
 		}
 
 		file_accessed(file);
@@ -2581,12 +2581,10 @@ generic_file_read_iter(struct kiocb *iocb, struct iov_iter *iter)
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

