Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28CA22A14D3
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Oct 2020 10:30:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbgJaJao (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 31 Oct 2020 05:30:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726424AbgJaJan (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 31 Oct 2020 05:30:43 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 196C5C0613D5
        for <linux-fsdevel@vger.kernel.org>; Sat, 31 Oct 2020 02:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=RqDbAgPgOvB5taFEIjSsWqsN4HVXXWmvRa4haI7RAX8=; b=stLdkSElJhmp/NOrYLuOswpaFS
        vWKFOJTu0qPiEwqjxbmSwqe2Y1bunTE+cJi/2vMuql6PsHL7PfrvZNdM13wVSozXIQ2BaAWQ2ZuLk
        p+iNUn1h3MG5yZww9C660AnIbBBLO2vQbR43OIHXwwFqczRkMaOFW/JDJcy4ApeIGorKHLTAaTjJi
        O+m3fWZ28aOEncW2VPTmxBYeYHor8+xCyZ1PuyPR8BIXRJPJXhLVhdfcR/H1Q+Jk4FzGuZ/0xOCcy
        xsbqSWzPe2WjBhNkd2Mx7oZUYDBl+EgWQQ1e4SAC2fwlG0GKFqmpv38EJNjsYFHlYQwPseG5aAHUG
        ib/JAB0A==;
Received: from 089144193201.atnat0002.highway.a1.net ([89.144.193.201] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kYnDc-0000Mr-Mf; Sat, 31 Oct 2020 09:30:41 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Kent Overstreet <kent.overstreet@gmail.com>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 13/13] mm: simplify generic_file_read_iter
Date:   Sat, 31 Oct 2020 10:00:04 +0100
Message-Id: <20201031090004.452516-14-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201031090004.452516-1-hch@lst.de>
References: <20201031090004.452516-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Avoid the pointless goto out just for returning retval.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 mm/filemap.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 743d764f3eab1c..b45f0bafdbaebf 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2531,7 +2531,7 @@ generic_file_read_iter(struct kiocb *iocb, struct iov_iter *iter)
 	ssize_t retval = 0;
 
 	if (!count)
-		goto out; /* skip atime */
+		return 0; /* skip atime */
 
 	if (iocb->ki_flags & IOCB_DIRECT) {
 		struct file *file = iocb->ki_filp;
@@ -2549,7 +2549,7 @@ generic_file_read_iter(struct kiocb *iocb, struct iov_iter *iter)
 						iocb->ki_pos,
 					        iocb->ki_pos + count - 1);
 			if (retval < 0)
-				goto out;
+				return retval;
 		}
 
 		file_accessed(file);
@@ -2572,12 +2572,10 @@ generic_file_read_iter(struct kiocb *iocb, struct iov_iter *iter)
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

