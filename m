Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C7502A6F0D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Nov 2020 21:42:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732314AbgKDUmf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Nov 2020 15:42:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732207AbgKDUmd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Nov 2020 15:42:33 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95C4EC0401C3
        for <linux-fsdevel@vger.kernel.org>; Wed,  4 Nov 2020 12:42:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=M4qshmF8EuAc2b6PT9kIoX64mldjJyTot7vJt+nRP0k=; b=lQwBbmSoM8Sg5wMDf1lIkmXriF
        hepWxVPDUt0VKg+vZmva5WB/5fDx3mNXEV/dvm+Z7bh8ySaCc4UpHqDWQAqSRfGTO7A6iQOnYTW5x
        Zv+p25yTVikF4h3r/Mz5jpoaSE1hc4sGCiD+83spCeUz4jYLPf33kIlOua6g3ATkMHZ0wIuyZ4odR
        FyJwu61SvDqBdVnYAptVYSe2zzPSfSO1Nwa11DqLKxfdEodue3BMl4o4Y0TRHM7hTL5b114+3so4U
        mgwxRqK5jLOjIxwekOs1D4V1yrDNLbv2ZVyF/Aup0iMixR0u/b4Hw0suIZ9VVJPVK/TvGw0K4TJBe
        N/y0aPEQ==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kaPbv-0006F3-2t; Wed, 04 Nov 2020 20:42:27 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     Christoph Hellwig <hch@lst.de>, kent.overstreet@gmail.com,
        Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v2 18/18] mm/filemap: Simplify generic_file_read_iter
Date:   Wed,  4 Nov 2020 20:42:19 +0000
Message-Id: <20201104204219.23810-19-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201104204219.23810-1-willy@infradead.org>
References: <20201104204219.23810-1-willy@infradead.org>
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
index d24c25345bae..e84845ec7cd4 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2538,7 +2538,7 @@ generic_file_read_iter(struct kiocb *iocb, struct iov_iter *iter)
 	ssize_t retval = 0;
 
 	if (!count)
-		goto out; /* skip atime */
+		return 0; /* skip atime */
 
 	if (iocb->ki_flags & IOCB_DIRECT) {
 		struct file *file = iocb->ki_filp;
@@ -2556,7 +2556,7 @@ generic_file_read_iter(struct kiocb *iocb, struct iov_iter *iter)
 						iocb->ki_pos,
 					        iocb->ki_pos + count - 1);
 			if (retval < 0)
-				goto out;
+				return retval;
 		}
 
 		file_accessed(file);
@@ -2579,12 +2579,10 @@ generic_file_read_iter(struct kiocb *iocb, struct iov_iter *iter)
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

