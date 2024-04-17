Return-Path: <linux-fsdevel+bounces-17152-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4682E8A86F2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Apr 2024 17:05:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA8C21F22998
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Apr 2024 15:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAF4D147C8D;
	Wed, 17 Apr 2024 15:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GiVaYEtb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D455513DDC1
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Apr 2024 15:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713366263; cv=none; b=UGokBuJkDCmgCu9H6l8Mffc5s9WImMAFZsk+yOokngunX5IjzVsTXakasqARgBRT6KAAgurF8wog/libx1OpUOXAQ1XaVJ0Pv8DSWPkGxyuOy68rxgX2KscdpbkLwEZU+5mpGOCJBdYM3GL6RACPdOAZ4x8iyCqaxHlrFu+Mc9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713366263; c=relaxed/simple;
	bh=epxjwHL76sIhbrKLnddXkjY0VrSqyQ6u4j31e1vRqIs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GQgIc8gof4dRyR47JlYjbdeG37xxRdYSmrX0Ks5b0E6gMCQvzMZG7gVhgdESm9sxx/i/Tpi3lQILIydiNaCbgVBUfQVoHa/LQRxInW/vWi02d5VWstCW9mNbViTUGILMNB1mUr8KGX6Q347uDK9WqFbz9WCBkcA+kjW8J0oN3pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=GiVaYEtb; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=ftRNeaJEfx49awHZ0g/zGxDTKwmCFs9ciDpk78+/9xM=; b=GiVaYEtblVSFwa12A231A1pbog
	bPh2WVb3bf3k1FAwJI5w/EXdXv1MJk9ExJFBETpibHZb6QKhwQHr+0aXrWiiIA2wl0mc7l2Pfli6j
	Sjk0EUrT+cl3iVpYze8kCQMwHtNbr64hgkkZOklH+rqAjY+0nOnCNTabur7FJj0sROldE8adiyTld
	Q5R4q1aqZmgl+MGpq4oOC/Fu++cB6/TMuEazzG1vheMr4Vk9elpB5qcUBD8MHBEsYlmzg8zpzx9Jh
	QDPatkjil+9fQVGY3LT7WcDVwFstbTLNRLlAeHgJVbjOYgNu/HE5vPhQqcY0ysW1C0Cg1SCePwyp6
	q1Dnn4VA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rx6pe-000000039sX-07yF;
	Wed, 17 Apr 2024 15:04:18 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Jan Kara <jack@suse.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 1/7] udf: Convert udf_symlink_filler() to use a folio
Date: Wed, 17 Apr 2024 16:04:07 +0100
Message-ID: <20240417150416.752929-2-willy@infradead.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240417150416.752929-1-willy@infradead.org>
References: <20240417150416.752929-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove the conversion to struct page and use folio APIs throughout.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/udf/symlink.c | 22 ++++++----------------
 1 file changed, 6 insertions(+), 16 deletions(-)

diff --git a/fs/udf/symlink.c b/fs/udf/symlink.c
index f7eaf7b14594..0105e7e2ba3d 100644
--- a/fs/udf/symlink.c
+++ b/fs/udf/symlink.c
@@ -99,18 +99,17 @@ static int udf_pc_to_char(struct super_block *sb, unsigned char *from,
 
 static int udf_symlink_filler(struct file *file, struct folio *folio)
 {
-	struct page *page = &folio->page;
-	struct inode *inode = page->mapping->host;
+	struct inode *inode = folio->mapping->host;
 	struct buffer_head *bh = NULL;
 	unsigned char *symlink;
 	int err = 0;
-	unsigned char *p = page_address(page);
+	unsigned char *p = folio_address(folio);
 	struct udf_inode_info *iinfo = UDF_I(inode);
 
 	/* We don't support symlinks longer than one block */
 	if (inode->i_size > inode->i_sb->s_blocksize) {
 		err = -ENAMETOOLONG;
-		goto out_unlock;
+		goto out;
 	}
 
 	if (iinfo->i_alloc_type == ICBTAG_FLAG_AD_IN_ICB) {
@@ -120,24 +119,15 @@ static int udf_symlink_filler(struct file *file, struct folio *folio)
 		if (!bh) {
 			if (!err)
 				err = -EFSCORRUPTED;
-			goto out_err;
+			goto out;
 		}
 		symlink = bh->b_data;
 	}
 
 	err = udf_pc_to_char(inode->i_sb, symlink, inode->i_size, p, PAGE_SIZE);
 	brelse(bh);
-	if (err)
-		goto out_err;
-
-	SetPageUptodate(page);
-	unlock_page(page);
-	return 0;
-
-out_err:
-	SetPageError(page);
-out_unlock:
-	unlock_page(page);
+out:
+	folio_end_read(folio, err == 0);
 	return err;
 }
 
-- 
2.43.0


