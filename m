Return-Path: <linux-fsdevel+bounces-20364-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1F778D21F2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 May 2024 18:49:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4862F1F20FD3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 May 2024 16:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFB8C172BCE;
	Tue, 28 May 2024 16:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gdTXZ+oy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 889E117332C;
	Tue, 28 May 2024 16:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716914915; cv=none; b=GumrZuQMY0r4vjrmxyOVmzYamSknDncPDEOpWMenf+PTCPTu/NFlEiOsOW5EeEQBLPt7OKstdSVPJsMNvIBaSUiou9ekbjO4tnKnL+tOq3jkGhNc2qEsXeps8JEGhnvcmx/Ut56Y9Qrt25/aw3MrD6zNmoICNwCSj94CvMLfu5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716914915; c=relaxed/simple;
	bh=Dil7xzG+ttigVw3JOerhKg5KhObdBN2RvBBGIV6q2Qc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cHxwXlQDFVeNMsNKFZ7WnlVBvnKDhlZzQNhQDj2mmEGci0seNgwqQoewKYzVkKLqABfutgsQpKzvHIuvuw0fBjTFsB0EdkfC5xgLtBb9ma0bgRPMrZKySOk+tPA4bJYT8W+USWFPPymbIkpTkB6dCXX13zvuICsbVDzHKAsie1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=gdTXZ+oy; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=qY7bQ3bEFdsUe0XNsM+uQnYMcwBOs7nZbaHEVgrB6fE=; b=gdTXZ+oy++Hq5yYLrcC3UcQSzv
	c0S8TD47Vw+ylUM9IUjWhu7PAovNnw0nG7DR6I4J3hf9TwGvcHWWYC6x4/qoyMuPaWfCoKMqr+w1g
	mmuLcYynwLehc8SjXv4mOHafIVivroMrV/NPv+/QYAL2Lz/mdbPZ1QqlTa2SXOOWZRa/NCdGWQoeF
	NgnZyp/HKMdhuSdINow5/S9TCdvxfE9kSgat+TgwWiyD3sllFM6a2GlZ4cWTTqAccMOyMIpaa7XWy
	3yBSs+Bln25TVufrMdOZ3WSjNoagA6vJ4nKWgST7A/WvI++fxgnphG852wsFUoLfMOpUSSNZcggcK
	QR0F7pCA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sBzzz-00000008pjd-3xRQ;
	Tue, 28 May 2024 16:48:31 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Christoph Hellwig <hch@lst.de>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-fsdevel@vger.kernel.org,
	linux-ext4@vger.kernel.org
Subject: [PATCH 7/7] iomap: Return the folio from iomap_write_begin()
Date: Tue, 28 May 2024 17:48:28 +0100
Message-ID: <20240528164829.2105447-8-willy@infradead.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240528164829.2105447-1-willy@infradead.org>
References: <20240528164829.2105447-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use an ERR_PTR to return any error that may have occurred, otherwise
return the folio directly instead of returning it by reference.  This
mirrors changes which are going into the filemap ->write_begin callbacks.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/iomap/buffered-io.c | 35 ++++++++++++++++-------------------
 1 file changed, 16 insertions(+), 19 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index c5802a459334..f0c40ac425ce 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -764,27 +764,27 @@ static int iomap_write_begin_inline(const struct iomap_iter *iter,
 	return iomap_read_inline_data(iter, folio);
 }
 
-static int iomap_write_begin(struct iomap_iter *iter, loff_t pos,
-		size_t len, struct folio **foliop)
+static struct folio *iomap_write_begin(struct iomap_iter *iter, loff_t pos,
+		size_t len)
 {
 	const struct iomap_folio_ops *folio_ops = iter->iomap.folio_ops;
 	const struct iomap *srcmap = iomap_iter_srcmap(iter);
 	struct folio *folio;
-	int status = 0;
+	int status;
 
 	BUG_ON(pos + len > iter->iomap.offset + iter->iomap.length);
 	if (srcmap != &iter->iomap)
 		BUG_ON(pos + len > srcmap->offset + srcmap->length);
 
 	if (fatal_signal_pending(current))
-		return -EINTR;
+		return ERR_PTR(-EINTR);
 
 	if (!mapping_large_folio_support(iter->inode->i_mapping))
 		len = min_t(size_t, len, PAGE_SIZE - offset_in_page(pos));
 
 	folio = __iomap_get_folio(iter, pos, len);
 	if (IS_ERR(folio))
-		return PTR_ERR(folio);
+		return folio;
 
 	/*
 	 * Now we have a locked folio, before we do anything with it we need to
@@ -801,7 +801,6 @@ static int iomap_write_begin(struct iomap_iter *iter, loff_t pos,
 							 &iter->iomap);
 		if (!iomap_valid) {
 			iter->iomap.flags |= IOMAP_F_STALE;
-			status = 0;
 			goto out_unlock;
 		}
 	}
@@ -819,13 +818,12 @@ static int iomap_write_begin(struct iomap_iter *iter, loff_t pos,
 	if (unlikely(status))
 		goto out_unlock;
 
-	*foliop = folio;
-	return 0;
+	return folio;
 
 out_unlock:
 	__iomap_put_folio(iter, pos, 0, folio);
 
-	return status;
+	return ERR_PTR(status);
 }
 
 static bool __iomap_write_end(struct inode *inode, loff_t pos, size_t len,
@@ -940,9 +938,10 @@ static loff_t iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i)
 			break;
 		}
 
-		status = iomap_write_begin(iter, pos, bytes, &folio);
-		if (unlikely(status)) {
+		folio = iomap_write_begin(iter, pos, bytes);
+		if (IS_ERR(folio)) {
 			iomap_write_failed(iter->inode, pos, bytes);
+			status = PTR_ERR(folio);
 			break;
 		}
 		if (iter->iomap.flags & IOMAP_F_STALE)
@@ -1330,14 +1329,13 @@ static loff_t iomap_unshare_iter(struct iomap_iter *iter)
 
 	do {
 		struct folio *folio;
-		int status;
 		size_t offset;
 		size_t bytes = min_t(u64, SIZE_MAX, length);
 		bool ret;
 
-		status = iomap_write_begin(iter, pos, bytes, &folio);
-		if (unlikely(status))
-			return status;
+		folio = iomap_write_begin(iter, pos, bytes);
+		if (IS_ERR(folio))
+			return PTR_ERR(folio);
 		if (iomap->flags & IOMAP_F_STALE)
 			break;
 
@@ -1393,14 +1391,13 @@ static loff_t iomap_zero_iter(struct iomap_iter *iter, bool *did_zero)
 
 	do {
 		struct folio *folio;
-		int status;
 		size_t offset;
 		size_t bytes = min_t(u64, SIZE_MAX, length);
 		bool ret;
 
-		status = iomap_write_begin(iter, pos, bytes, &folio);
-		if (status)
-			return status;
+		folio = iomap_write_begin(iter, pos, bytes);
+		if (IS_ERR(folio))
+			return PTR_ERR(folio);
 		if (iter->iomap.flags & IOMAP_F_STALE)
 			break;
 
-- 
2.43.0


