Return-Path: <linux-fsdevel+bounces-11653-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4143855A9D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Feb 2024 07:40:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6F531C2A804
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Feb 2024 06:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E7111BDDC;
	Thu, 15 Feb 2024 06:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IE6GYCQF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0454D53F;
	Thu, 15 Feb 2024 06:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707979051; cv=none; b=jHz1wNxUbuG+u1zEueyUmabqvYAsdzdWqtmLT2qd3zLKHBDLufxy+Ra9QpB1MjEZVH5L+3SwDs7n4vWPJrtQlxvdYJ5WhejKrb3qwhupr3fwR1SXODXIOWpx9vzBamhVq8otQ+CXyhUH/8XF5HDHgL/uy2VDF82slv+v2afTPig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707979051; c=relaxed/simple;
	bh=dgRYHU8iCb2WQ2DB6EoGsmva8mLKYz2OoB6UGRBNFgo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EftaCzEQjeIIxXoyJCYCTlXo8N17OVyP7wF/zW7FJ7BuarpfDW4vWV/J/o7NpcYyuRlqPczEveigrzbAUUtAup4j5gTWrnHowP9JOUKt55+vXzuDwQvLkcxLcBiIMoL7yN5MJnC1noSlZHCzegDJTCJYjVgC5E/i755x7dWOrTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=IE6GYCQF; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=dpEY7SmyA34rLmNMjZVpGv1HVhFTICw5Hhe2kQSv81M=; b=IE6GYCQF3eV3lxuP59icZOXmbS
	+ZieiZz134xt6WwJJzwEPn739abiFT+QYhRmHkAw32tujHIHQHYaTqWK18UROqd9WFjuRrPe7e2tx
	gpFYSFBSmWjzvOzbpp4+OvsrWEKz3fKWswV/Zrm4Asux3Z2NCPWYpQ7gOdOlLV0EHf56ssi9QFmsK
	q7iPT2U8FwRCMtBDr7GcdQx219YFW7DS0GggsGgV2i/XgHXQnLt55fDdUF0bbhStSOweF6LucJ4bh
	eNFNVP2TLPuzZqh7+r2s7SHtmBzkiSMfVkTncMGSxRQLPZJFmcRiKLXjcQQLItfXLoMJfU/8tkReR
	qNWH7rHA==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1raVN9-0000000F71D-1Lq2;
	Thu, 15 Feb 2024 06:37:27 +0000
From: Christoph Hellwig <hch@lst.de>
To: linux-mm@kvack.org
Cc: Matthew Wilcox <willy@infradead.org>,
	Jan Kara <jack@suse.com>,
	David Howells <dhowells@redhat.com>,
	Brian Foster <bfoster@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jan Kara <jack@suse.cz>,
	Dave Chinner <dchinner@redhat.com>
Subject: [PATCH 12/14] writeback: Move the folio_prepare_writeback loop out of write_cache_pages()
Date: Thu, 15 Feb 2024 07:36:47 +0100
Message-Id: <20240215063649.2164017-13-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240215063649.2164017-1-hch@lst.de>
References: <20240215063649.2164017-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

Move the loop for should-we-write-this-folio to writeback_get_folio.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
[hch: folded the loop into the existing helper instead of a separate one
      as suggested by Jan Kara]
Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Brian Foster <bfoster@redhat.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Acked-by: Dave Chinner <dchinner@redhat.com>
---
 mm/page-writeback.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 3cbe4a7daa357c..fc421402f81881 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2411,6 +2411,7 @@ static struct folio *writeback_get_folio(struct address_space *mapping,
 {
 	struct folio *folio;
 
+retry:
 	folio = folio_batch_next(&wbc->fbatch);
 	if (!folio) {
 		folio_batch_release(&wbc->fbatch);
@@ -2418,8 +2419,17 @@ static struct folio *writeback_get_folio(struct address_space *mapping,
 		filemap_get_folios_tag(mapping, &wbc->index, wbc_end(wbc),
 				wbc_to_tag(wbc), &wbc->fbatch);
 		folio = folio_batch_next(&wbc->fbatch);
+		if (!folio)
+			return NULL;
+	}
+
+	folio_lock(folio);
+	if (unlikely(!folio_prepare_writeback(mapping, wbc, folio))) {
+		folio_unlock(folio);
+		goto retry;
 	}
 
+	trace_wbc_writepage(wbc, inode_to_bdi(mapping->host));
 	return folio;
 }
 
@@ -2480,14 +2490,6 @@ int write_cache_pages(struct address_space *mapping,
 		if (!folio)
 			break;
 
-		folio_lock(folio);
-		if (!folio_prepare_writeback(mapping, wbc, folio)) {
-			folio_unlock(folio);
-			continue;
-		}
-
-		trace_wbc_writepage(wbc, inode_to_bdi(mapping->host));
-
 		error = writepage(folio, wbc, data);
 		wbc->nr_to_write -= folio_nr_pages(folio);
 
-- 
2.39.2


