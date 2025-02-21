Return-Path: <linux-fsdevel+bounces-42307-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41636A40146
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2025 21:44:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87E008642DB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2025 20:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D64132185BE;
	Fri, 21 Feb 2025 20:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="o8iLkk1X"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF581FC102;
	Fri, 21 Feb 2025 20:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740170671; cv=none; b=WF2ZnFLrnj7/GnqQve9Yp0zP+Zr80zHUAPjvvKY4JlV6FXulyii2YvCnQjs3ZK/AUosK+Gtfmty+n8B+5uw4bGP4c3mMmTX0lF2F63WDBZFisceJKYF+rxfuP09dcOo5dmY0iQ/flJLCsSlm+5iBYZH1wbccA0edM2P/Fe1UxbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740170671; c=relaxed/simple;
	bh=3WzhuI624xpOJXcZxdsr9FFAe5pRi7L4IPpEUx+smd4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AWCxk7lHT5zWBQmarU7aVOVeYL019HzwxHhfvIMdqMxaHB4A7jJMU9MxKPhvcMoi1yEhCYsMEhx7CMsNj0m0ZWuFAtVV5RgAIv+R9FXzoxl+Iw1sbW7DAY+Igj+Odgj2kU54d60EMiydx/Zeg1TY1g0VQ4OygWcpXAQR+7MfNoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=o8iLkk1X; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=K9qhnDc2Rvx/j5nvRoK51AcgojRP3TGljQJUGHmFzvY=; b=o8iLkk1XpMicK5mGhosUOBLIZy
	fYhZacd6R3GmpG+HezwZbX/e9DzdSQO0Pe994rz1n7ocbvNdKxHQGrGQNez5k0DdrbkXGUCy9plIO
	DVp6LAdeFr414tP3kMRJtpqaz3iPYU52/22dQOq2GIGSVY4dhXF8ZKqkIu3s7XEHH2iRwnqGstX/h
	BusS/wLK0BW0x7O+hCqZCllFPZZvVp2+CZcoyHpv0tsgo/ifqyFiBwgAmeoJ42qgo1RQSZVLG/PWn
	hftd9q+fvut8QVlMvijixKCtsVzRZAmCpj6vd9HiJXlNee0pVKsCdrHVlwp5mEnHmPZlER71lIW9Q
	DDLpn3Ow==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tlZsp-0000000F41M-1Iy0;
	Fri, 21 Feb 2025 20:44:27 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	ceph-devel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	David Howells <dhowells@redhat.com>
Subject: [PATCH v3 10/9] fs: Remove page_mkwrite_check_truncate()
Date: Fri, 21 Feb 2025 20:44:19 +0000
Message-ID: <20250221204421.3590340-1-willy@infradead.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250217185119.430193-1-willy@infradead.org>
References: 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All callers of this function have now been converted to use
folio_mkwrite_check_truncate().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/pagemap.h | 28 ----------------------------
 1 file changed, 28 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 8c52a637d42b..798e2e39c6e2 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -1579,34 +1579,6 @@ static inline ssize_t folio_mkwrite_check_truncate(struct folio *folio,
 	return offset;
 }
 
-/**
- * page_mkwrite_check_truncate - check if page was truncated
- * @page: the page to check
- * @inode: the inode to check the page against
- *
- * Returns the number of bytes in the page up to EOF,
- * or -EFAULT if the page was truncated.
- */
-static inline int page_mkwrite_check_truncate(struct page *page,
-					      struct inode *inode)
-{
-	loff_t size = i_size_read(inode);
-	pgoff_t index = size >> PAGE_SHIFT;
-	int offset = offset_in_page(size);
-
-	if (page->mapping != inode->i_mapping)
-		return -EFAULT;
-
-	/* page is wholly inside EOF */
-	if (page->index < index)
-		return PAGE_SIZE;
-	/* page is wholly past EOF */
-	if (page->index > index || !offset)
-		return -EFAULT;
-	/* page is partially inside EOF */
-	return offset;
-}
-
 /**
  * i_blocks_per_folio - How many blocks fit in this folio.
  * @inode: The inode which contains the blocks.
-- 
2.47.2


