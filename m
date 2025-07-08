Return-Path: <linux-fsdevel+bounces-54255-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E5CAAFCC95
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jul 2025 15:52:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A8BE1AA81C2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jul 2025 13:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7A292E06C3;
	Tue,  8 Jul 2025 13:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="1L1/J6VV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE7E42E0402;
	Tue,  8 Jul 2025 13:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751982722; cv=none; b=aST9BuM1Ly0xVNT0GnwvG/+e7o1GCYX8SKeloePl7mTNPLFRXffdzde4MjRpWuZp/0PZl87/TJguLPyaUzIovb9A3FOYzumuIqsgpavomyG9Gv+Dgdi2gqpm30OPdcARrW6sp6gqyAsOqLcrU5VUOP4AsUhpvAsLhdZRcuQ+1zQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751982722; c=relaxed/simple;
	bh=kLT1Z8jXmVx/4oIaqLxsxW3I5OQlj9D2JZrWFNTE/nU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p/bnMJqYq/Zq8cl+Hj+KsJVv6ZKJxNvM/UuBUfz/xySTQQesYDI4rD/93PUMmq033KRD/pdzWMX7mx5sk7dJ63BKFdVi/6Pgt1PcjCApMDq/p5MqUhsr0NlKzefFd2ym9n9YYr7+kmCvN01rgwk6LMl13k7ZgNhWHC7CTyY7fpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=1L1/J6VV; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=gaippAPm7/fCZ5WnUoXeLFREZCtaZdi8YPl8KpP0yNQ=; b=1L1/J6VVmroSCMZcHgRSfBhfrY
	W45ZWubeoj4GzCGEktiqGMEHxNYZBbbDr/2u+ATfthGXdzUND4QOET3l+kQrGO56h6ZwLz+zRKE6Y
	PJXnODx7/iXC6DOq1WgPgVMObnj4DQnRnL5X6QQU+PdGdFqXguJFqXxiSvZT8/gimBNB/5ddrnnc4
	lYdhGGrgrR70qCS8/spI6FbZc5Il6qMeuq+UA5ZK0EyqRMmkfwshz6wNdIbYPgpi8D64CXopn/FT3
	aFP9g64wwyK4v5fB0EFyQzKl0I1NR9vGmr3qItbMbahWIva8elYivsxb8bPQTQ0qffWUr9SGSDek3
	lFqjtnqQ==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uZ8jn-00000005USn-3ZfU;
	Tue, 08 Jul 2025 13:52:00 +0000
From: Christoph Hellwig <hch@lst.de>
To: Christian Brauner <brauner@kernel.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Joanne Koong <joannelkoong@gmail.com>,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-block@vger.kernel.org,
	gfs2@lists.linux.dev,
	Brian Foster <bfoster@redhat.com>
Subject: [PATCH 08/14] iomap: rename iomap_writepage_map to iomap_writeback_folio
Date: Tue,  8 Jul 2025 15:51:14 +0200
Message-ID: <20250708135132.3347932-9-hch@lst.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250708135132.3347932-1-hch@lst.de>
References: <20250708135132.3347932-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

->writepage is gone, and our naming wasn't always that great to start
with.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Brian Foster <bfoster@redhat.com>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/iomap/buffered-io.c | 10 +++++-----
 fs/iomap/trace.h       |  2 +-
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 6c29c5043309..c1075f3027ac 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1581,7 +1581,7 @@ static int iomap_writeback_range(struct iomap_writepage_ctx *wpc,
  * If the folio is entirely beyond i_size, return false.  If it straddles
  * i_size, adjust end_pos and zero all data beyond i_size.
  */
-static bool iomap_writepage_handle_eof(struct folio *folio, struct inode *inode,
+static bool iomap_writeback_handle_eof(struct folio *folio, struct inode *inode,
 		u64 *end_pos)
 {
 	u64 isize = i_size_read(inode);
@@ -1633,7 +1633,7 @@ static bool iomap_writepage_handle_eof(struct folio *folio, struct inode *inode,
 	return true;
 }
 
-static int iomap_writepage_map(struct iomap_writepage_ctx *wpc,
+static int iomap_writeback_folio(struct iomap_writepage_ctx *wpc,
 		struct folio *folio)
 {
 	struct iomap_folio_state *ifs = folio->private;
@@ -1649,9 +1649,9 @@ static int iomap_writepage_map(struct iomap_writepage_ctx *wpc,
 	WARN_ON_ONCE(folio_test_dirty(folio));
 	WARN_ON_ONCE(folio_test_writeback(folio));
 
-	trace_iomap_writepage(inode, pos, folio_size(folio));
+	trace_iomap_writeback_folio(inode, pos, folio_size(folio));
 
-	if (!iomap_writepage_handle_eof(folio, inode, &end_pos)) {
+	if (!iomap_writeback_handle_eof(folio, inode, &end_pos)) {
 		folio_unlock(folio);
 		return 0;
 	}
@@ -1736,7 +1736,7 @@ iomap_writepages(struct iomap_writepage_ctx *wpc)
 		return -EIO;
 
 	while ((folio = writeback_iter(mapping, wpc->wbc, folio, &error)))
-		error = iomap_writepage_map(wpc, folio);
+		error = iomap_writeback_folio(wpc, folio);
 
 	/*
 	 * If @error is non-zero, it means that we have a situation where some
diff --git a/fs/iomap/trace.h b/fs/iomap/trace.h
index aaea02c9560a..6ad66e6ba653 100644
--- a/fs/iomap/trace.h
+++ b/fs/iomap/trace.h
@@ -79,7 +79,7 @@ DECLARE_EVENT_CLASS(iomap_range_class,
 DEFINE_EVENT(iomap_range_class, name,	\
 	TP_PROTO(struct inode *inode, loff_t off, u64 len),\
 	TP_ARGS(inode, off, len))
-DEFINE_RANGE_EVENT(iomap_writepage);
+DEFINE_RANGE_EVENT(iomap_writeback_folio);
 DEFINE_RANGE_EVENT(iomap_release_folio);
 DEFINE_RANGE_EVENT(iomap_invalidate_folio);
 DEFINE_RANGE_EVENT(iomap_dio_invalidate_fail);
-- 
2.47.2


