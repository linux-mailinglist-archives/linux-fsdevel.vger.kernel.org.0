Return-Path: <linux-fsdevel+bounces-54506-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFDA5B003A0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 15:36:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AA4C5A15EB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 13:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBCD62638B2;
	Thu, 10 Jul 2025 13:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="owh28+OD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E490025B1C5;
	Thu, 10 Jul 2025 13:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752154454; cv=none; b=jCJRXpnVZiRmm2nMl7l3lbxbMhmPFjvUyRuE3xRY7umYzWJlDLMnsh0KJWdpbYUPooVd5NU6TZRziVbj9hXCL0dpJoEJfYm8Tov1JY8JGypjnDYyT8cEOACFaA11S7/qYcGOOu4Xh/igBQy7WRJf66I6ObLxt/o1YYD17HDlNnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752154454; c=relaxed/simple;
	bh=7S3B2/4KWoZHD8HTN1JALiddly6nrD7q2GW9rOeiJJc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OlMWFICpa6o31yWOMU6DWVqGg2rZhAt851PPpGkdjXgTrd/jEQzXh01KJQNSRIb/D7XYLKcYSSiVN90Ax2SmNgRILz0NiL5/2Eu+xVq8ssZl/MxUMnNZLcqwjVmz9au25zQvvuWsolTyFHMV2voaeWHCbfKvhRD3hF4qKHd42YA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=owh28+OD; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=SeAMUROYpL1lsmQY1Z34ZNP8F6xYO71IbBZS2I1oYFw=; b=owh28+ODKT2HFdAT1nAy/uL9hZ
	AzvgpWrlNYYZ4RuzTZTfpD1wnMi+FYsJFcrzDeyc3HKv8LexYJ5SDvy+0iE71oUT7lFgRuc5UBAJD
	7G+ya0NIP8m3UsYhci4hKjK9rsGjR6umGzkHChQZYwRoQj1hOcQE4LlU8iGI9z0KKjH5c/z3jQZhS
	Z9OvRCehEY0n90fHMTCfJ1KB1P0ZfDKK2usOBhKYmeMcTVfQ/1L5mrc6VcYNYYGmSy3mkrGkF1ZDY
	/c7inXqSibLLq5UQX0GwnPDFrkemWiw0Tl1IBZUGlqM74KnXMP1cMXjBQaXgAEJyMtTDRe6+WB35g
	TGoMGGQw==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uZrPf-0000000BwVz-32lh;
	Thu, 10 Jul 2025 13:34:12 +0000
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
Date: Thu, 10 Jul 2025 15:33:32 +0200
Message-ID: <20250710133343.399917-9-hch@lst.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250710133343.399917-1-hch@lst.de>
References: <20250710133343.399917-1-hch@lst.de>
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
Reviewed-by: Joanne Koong <joannelkoong@gmail.com>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/iomap/buffered-io.c | 10 +++++-----
 fs/iomap/trace.h       |  2 +-
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index cea56df04d7b..e6e4c2d1b399 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1582,7 +1582,7 @@ static int iomap_writeback_range(struct iomap_writepage_ctx *wpc,
  * If the folio is entirely beyond i_size, return false.  If it straddles
  * i_size, adjust end_pos and zero all data beyond i_size.
  */
-static bool iomap_writepage_handle_eof(struct folio *folio, struct inode *inode,
+static bool iomap_writeback_handle_eof(struct folio *folio, struct inode *inode,
 		u64 *end_pos)
 {
 	u64 isize = i_size_read(inode);
@@ -1634,7 +1634,7 @@ static bool iomap_writepage_handle_eof(struct folio *folio, struct inode *inode,
 	return true;
 }
 
-static int iomap_writepage_map(struct iomap_writepage_ctx *wpc,
+static int iomap_writeback_folio(struct iomap_writepage_ctx *wpc,
 		struct folio *folio)
 {
 	struct iomap_folio_state *ifs = folio->private;
@@ -1650,9 +1650,9 @@ static int iomap_writepage_map(struct iomap_writepage_ctx *wpc,
 	WARN_ON_ONCE(folio_test_dirty(folio));
 	WARN_ON_ONCE(folio_test_writeback(folio));
 
-	trace_iomap_writepage(inode, pos, folio_size(folio));
+	trace_iomap_writeback_folio(inode, pos, folio_size(folio));
 
-	if (!iomap_writepage_handle_eof(folio, inode, &end_pos)) {
+	if (!iomap_writeback_handle_eof(folio, inode, &end_pos)) {
 		folio_unlock(folio);
 		return 0;
 	}
@@ -1737,7 +1737,7 @@ iomap_writepages(struct iomap_writepage_ctx *wpc)
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


