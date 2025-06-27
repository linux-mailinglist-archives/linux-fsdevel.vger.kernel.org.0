Return-Path: <linux-fsdevel+bounces-53148-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 210AEAEAFA1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Jun 2025 09:05:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD5924E19C2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Jun 2025 07:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8D082236FD;
	Fri, 27 Jun 2025 07:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="3qOp3dPM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C0421C166;
	Fri, 27 Jun 2025 07:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751007832; cv=none; b=VHz8H2OGxnflE9YA1AzE05MJwSKPYw+oDoSo2l3xQLh3DeGATO3cgEwkATHLrQRU0j7kSDBYfFBBDUu21YchSKVi6RgPmYWDxc9aAYyjScbDUyl/K5s9V+CYgBUHbhfZ9SfqrTQ+p7Blu2QzaHxnZM9DEDwoIj9izFEh+34NGJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751007832; c=relaxed/simple;
	bh=n4x910P374fpFpG35KhCrqbjXUk7CPc/Xg9clwWA8MQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AWnl81yoqTCxKf6vyefO4UYwAqkdAToNc4u5iJHZzmHdlTKAiQLU6kgALEo60eopzTRzVIrtqR7s+ei3BHHPym27bd4DcVaQS0FQOmZeC6w4b9ieEMSSEcY3dBKAqQPw2cms8fVg9IQZlCWW1qHdGANLl4aliQZENmrSEWy4OPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=3qOp3dPM; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=OAw8YgcJwO3v+iqDxMYOJMMdOxJan6bx7GqjXyh45cE=; b=3qOp3dPMYN3/I/TqjnFZ++/yjQ
	MCxbCvP8UH+08eDqkOAJ6n1tRa4F8K7AyNmLm7gfGc8TvYxfdm/YS5F3yGZlVt2PJUQzYUkMEJnGh
	oQgdDOzPxZKcN6irLSZQ8OIcDHhFgdFqcmfM8g8g7LYxqm1Z6SJnG3MBHXh9QG1dZ5zQBXWkF8GGz
	wFuFdCwFa60ZQ3a5i0DHfv/Mu30DsrZ4WHKJt8vdJQdCbiStCbAl8p/L/63snT3U8XJmp+hI5SqjR
	Bj2S59WPsHtcOCzXp8YawubIENvJMjQLibR8ce9YrTmifupbtl6LlYII/OuoY+cSYK2Q9rs2spYKJ
	6GjRJMkw==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uV37l-0000000DlxV-3UMq;
	Fri, 27 Jun 2025 07:03:50 +0000
From: Christoph Hellwig <hch@lst.de>
To: Christian Brauner <brauner@kernel.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Joanne Koong <joannelkoong@gmail.com>,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-block@vger.kernel.org,
	gfs2@lists.linux.dev
Subject: [PATCH 07/12] iomap: rename iomap_writepage_map to iomap_writeback_folio
Date: Fri, 27 Jun 2025 09:02:40 +0200
Message-ID: <20250627070328.975394-8-hch@lst.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250627070328.975394-1-hch@lst.de>
References: <20250627070328.975394-1-hch@lst.de>
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
---
 fs/iomap/buffered-io.c | 10 +++++-----
 fs/iomap/trace.h       |  2 +-
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 3e0ce6f42df5..c28eb6a6eee4 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1586,7 +1586,7 @@ static int iomap_writeback_range(struct iomap_writeback_ctx *wpc,
  * If the folio is entirely beyond i_size, return false.  If it straddles
  * i_size, adjust end_pos and zero all data beyond i_size.
  */
-static bool iomap_writepage_handle_eof(struct folio *folio, struct inode *inode,
+static bool iomap_writeback_handle_eof(struct folio *folio, struct inode *inode,
 		u64 *end_pos)
 {
 	u64 isize = i_size_read(inode);
@@ -1638,7 +1638,7 @@ static bool iomap_writepage_handle_eof(struct folio *folio, struct inode *inode,
 	return true;
 }
 
-static int iomap_writepage_map(struct iomap_writeback_ctx *wpc,
+static int iomap_writeback_folio(struct iomap_writeback_ctx *wpc,
 		struct folio *folio)
 {
 	struct iomap_folio_state *ifs = folio->private;
@@ -1654,9 +1654,9 @@ static int iomap_writepage_map(struct iomap_writeback_ctx *wpc,
 	WARN_ON_ONCE(folio_test_dirty(folio));
 	WARN_ON_ONCE(folio_test_writeback(folio));
 
-	trace_iomap_writepage(inode, pos, folio_size(folio));
+	trace_iomap_writeback_folio(inode, pos, folio_size(folio));
 
-	if (!iomap_writepage_handle_eof(folio, inode, &end_pos)) {
+	if (!iomap_writeback_handle_eof(folio, inode, &end_pos)) {
 		folio_unlock(folio);
 		return 0;
 	}
@@ -1741,7 +1741,7 @@ iomap_writepages(struct iomap_writeback_ctx *wpc)
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


