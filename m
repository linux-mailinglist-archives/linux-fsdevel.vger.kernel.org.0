Return-Path: <linux-fsdevel+bounces-8861-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 334B583BCAD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 10:05:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB4571F2C062
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 09:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7480E45010;
	Thu, 25 Jan 2024 08:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MwDns8za"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DF0540BFD;
	Thu, 25 Jan 2024 08:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706173156; cv=none; b=KJa15u6R12f3H9pmq/ZEMA+rXvr9RSdK4MobgeVtbBJSJ7Lq8T6oZ8bqMqniGjiFYsiuEgMJ73SEZH5DxegF90vtrffjaus3B0nWTrRMUxYSjxv1XCFTLVdKJ4jdAAJVlesQBP06LLt+UMlOydofu1WWhsDxx7uuLb5dvVnXIeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706173156; c=relaxed/simple;
	bh=XRsw0HE4sdU9Bt6SzZHTxpFscYBRdEbUKuyq7+81pVQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cwTXFNdBRxhBXu2Xg0yofAIrQhvDp6rd79nFBzVNGjrJgu+1gjV6EVXndDpeu8m2FJsta6EYxc2e/h46+sG9S3zzvH91Ew9Z/+2KOX/d8ybsuDXuzKwW7aJbzeZogM7ygMF1XZX/8Ygm8ATMa232eFBZzOwy8BgeMGyHkZALAAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=MwDns8za; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=VteIp731KUh3YSK1JiCDa6aylLsuTXuUpMz7VQeOhBM=; b=MwDns8za7rOoyeeWAlr3o2HuQV
	6MsdXZx1OlD4vY4TVWPSxa5TjcHnxy09D2/JDj47wRd2wEL80LFuC5im3yK7CJXPj2jlucMoHhjYY
	5ZfQoIWEjbS3nQGUD167nRpjZ9IYSoNIanwVbuJcTe8tTJhTKK4ufectQpX4R6xdrpv7nl7S3sak0
	v3d1Nqpjk+YxJc8FB0tBthiV35NdcgzGgWajgKmp1mRJWvAQd5eTU+gEFmq7Eu6UAAF1itV8yLtxl
	6KqrehrsyNRLzDHyou0HEwBNknKvykRNrwdjpWOZZrcDO7qYmxX27CByg2snYSfEFCFJfxeKf9Tkb
	Pf5DB47w==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rSvZm-007Qa9-3D;
	Thu, 25 Jan 2024 08:59:11 +0000
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
	linux-kernel@vger.kernel.org
Subject: [PATCH 18/19] iomap: Convert iomap_writepages() to use for_each_writeback_folio()
Date: Thu, 25 Jan 2024 09:57:57 +0100
Message-Id: <20240125085758.2393327-19-hch@lst.de>
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

From: Matthew Wilcox <willy@infradead.org>

This removes one indirect function call per folio, and adds typesafety
by not casting through a void pointer.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/iomap/buffered-io.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 093c4515b22a53..58b3661f5eac9e 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1887,9 +1887,8 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
  * regular allocated space.
  */
 static int iomap_do_writepage(struct folio *folio,
-		struct writeback_control *wbc, void *data)
+		struct writeback_control *wbc, struct iomap_writepage_ctx *wpc)
 {
-	struct iomap_writepage_ctx *wpc = data;
 	struct inode *inode = folio->mapping->host;
 	u64 end_pos, isize;
 
@@ -1986,10 +1985,12 @@ iomap_writepages(struct address_space *mapping, struct writeback_control *wbc,
 		struct iomap_writepage_ctx *wpc,
 		const struct iomap_writeback_ops *ops)
 {
-	int			ret;
+	struct folio *folio;
+	int ret;
 
 	wpc->ops = ops;
-	ret = write_cache_pages(mapping, wbc, iomap_do_writepage, wpc);
+	for_each_writeback_folio(mapping, wbc, folio, ret)
+		ret = iomap_do_writepage(folio, wbc, wpc);
 	if (!wpc->ioend)
 		return ret;
 	return iomap_submit_ioend(wpc, wpc->ioend, ret);
-- 
2.39.2


