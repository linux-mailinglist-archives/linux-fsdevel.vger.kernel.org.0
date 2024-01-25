Return-Path: <linux-fsdevel+bounces-8857-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72BFC83BCA1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 10:03:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72A94B28A85
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 09:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3B7A2C1A5;
	Thu, 25 Jan 2024 08:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CWZJKe+f"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C56E4249FC;
	Thu, 25 Jan 2024 08:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706173146; cv=none; b=az6LDCnUoMwMfaTS+IfXOpDXEzU65pdeW9upHQ0ALq66momyERki/KNyb/IZ1qA9X7tU7z7+E8K6oZsVosCj1vY/US6pXjKUa71ULW10qFQmNIm6co4LxG3Y0hz82HeTR3I0Wpr8oC0hkQL+UTc9BHYzxWnqSf7BMf6ToShJRMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706173146; c=relaxed/simple;
	bh=lB2E+6R5IO7pKfcouPsok3CwSSwirvnxKBWT1WaO7kA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RDxrI3HFeS3/t0x8aWbJdR/UFlmb4h8br/Kr3QocAVjdm6rMSVBCWn8kMK9GeUmVAYmR97W5JO1g8PTSekulM6AqsL38hZIhMISkHfPoPlwzn/7x4vCzEW183rN2YuQOMLEv/Bx2GsXNTJV2swcf8LKPJrM8TSV9Ol31yM27i+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=CWZJKe+f; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=hycX01++9KfrQWd9zJFSZD7mlFdT083LhSglCnbjIfA=; b=CWZJKe+fYMpoyNJTzLY6dZJyZA
	QYOX3JkYnjQSNZqRqWnV5LQJ5dcHTdNCtbSFBLQVS8uFpIHzJkuyQOnqlCRSH9/Eik0Bxh7kCd5tC
	Ophi8cnF1+hC+jcY4nHJOrBS7Qg+ajDD1z3M4DNxObV8/o2aB9ULuQQYqrNeBPF8ytfbSumetEYcw
	dhxh/yWN1eZFv6zTFaNHQ9tpiHLZN82AuIZh7cXSqcXBA3i6psFH+Rp7ifIufSFmF8k5C2ygBq3gs
	Na1eRG+Erd+ijYZb6gNByZXQaa+TTVlviqmjmiGIUDafwuHIG2zLEXmLPlciRMF1l1+yptTWAiy10
	5WmAk/pw==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rSvZa-007QUh-2Y;
	Thu, 25 Jan 2024 08:58:59 +0000
From: Christoph Hellwig <hch@lst.de>
To: linux-mm@kvack.org
Cc: Matthew Wilcox <willy@infradead.org>,
	Jan Kara <jack@suse.com>,
	David Howells <dhowells@redhat.com>,
	Brian Foster <bfoster@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jan Kara <jack@suse.cz>,
	Dave Chinner <dchinner@redhat.com>
Subject: [PATCH 15/19] writeback: Add for_each_writeback_folio()
Date: Thu, 25 Jan 2024 09:57:54 +0100
Message-Id: <20240125085758.2393327-16-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240125085758.2393327-1-hch@lst.de>
References: <20240125085758.2393327-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

Wrap up the iterator with a nice bit of syntactic sugar.  Now the
caller doesn't need to know about wbc->err and can just return error,
not knowing that the iterator took care of storing errors correctly.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jan Kara <jack@suse.cz>
Acked-by: Dave Chinner <dchinner@redhat.com>
---
 include/linux/writeback.h | 10 ++++++++++
 mm/page-writeback.c       |  8 +++-----
 2 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/include/linux/writeback.h b/include/linux/writeback.h
index a091817a5dba55..2416da933440e2 100644
--- a/include/linux/writeback.h
+++ b/include/linux/writeback.h
@@ -367,6 +367,16 @@ int balance_dirty_pages_ratelimited_flags(struct address_space *mapping,
 
 bool wb_over_bg_thresh(struct bdi_writeback *wb);
 
+struct folio *writeback_iter_init(struct address_space *mapping,
+		struct writeback_control *wbc);
+struct folio *writeback_iter_next(struct address_space *mapping,
+		struct writeback_control *wbc, struct folio *folio, int error);
+
+#define for_each_writeback_folio(mapping, wbc, folio, error)		\
+	for (folio = writeback_iter_init(mapping, wbc);			\
+	     folio || ((error = wbc->err), false);			\
+	     folio = writeback_iter_next(mapping, wbc, folio, error))
+
 typedef int (*writepage_t)(struct folio *folio, struct writeback_control *wbc,
 				void *data);
 
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index d5815237fbec29..aca0f43021a20c 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2458,7 +2458,7 @@ static struct folio *writeback_get_folio(struct address_space *mapping,
 	return folio;
 }
 
-static struct folio *writeback_iter_init(struct address_space *mapping,
+struct folio *writeback_iter_init(struct address_space *mapping,
 		struct writeback_control *wbc)
 {
 	if (wbc->range_cyclic)
@@ -2474,7 +2474,7 @@ static struct folio *writeback_iter_init(struct address_space *mapping,
 	return writeback_get_folio(mapping, wbc);
 }
 
-static struct folio *writeback_iter_next(struct address_space *mapping,
+struct folio *writeback_iter_next(struct address_space *mapping,
 		struct writeback_control *wbc, struct folio *folio, int error)
 {
 	unsigned long nr = folio_nr_pages(folio);
@@ -2552,9 +2552,7 @@ int write_cache_pages(struct address_space *mapping,
 	struct folio *folio;
 	int error;
 
-	for (folio = writeback_iter_init(mapping, wbc);
-	     folio;
-	     folio = writeback_iter_next(mapping, wbc, folio, error))
+	for_each_writeback_folio(mapping, wbc, folio, error)
 		error = writepage(folio, wbc, data);
 
 	return wbc->err;
-- 
2.39.2


