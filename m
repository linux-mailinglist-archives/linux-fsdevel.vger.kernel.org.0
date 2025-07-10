Return-Path: <linux-fsdevel+bounces-54511-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97550B003C1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 15:38:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 016DB3A731A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 13:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB891267F5C;
	Thu, 10 Jul 2025 13:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="wEX3YJ21"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE4AD2594AA;
	Thu, 10 Jul 2025 13:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752154472; cv=none; b=gDU8QtKvE6aQS2du9PNiz9a0pAY3ofKPsnclLcDQwpPykU6he1QfFOqBfn53ST8vS28xBhzIkfK7S3wu8EVPCuBvq36NxgiKzShcI43a9u+xCH5uzrsgdLrBoLO1VKTMtLfiw7d+0lPzS3fUa3iZNntWFoCkQoxObz4YHJVsJBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752154472; c=relaxed/simple;
	bh=1vY2SI/EU/p6f/MN0wtIAZuLaV0B+OamC3qSI48hGig=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qqKui+Leke2zJoIqO19VDqVRwoP6eHr/gm0wOESlFFRS6gXVbBfHgE0Bi3ysCYFRz3RHHEuX6xBbTbHb7Ks3zq13iJhT55mkVJHKer/7aYmlX6xPTTNvJnpo0iGMkhSf5Qd8xcqR6Zdv8qqMex66Naikw23a86xNOUi/SFDzOks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=wEX3YJ21; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=UhQeJkl5VSLEiGmrOdor8cRhYH50EWQ136HJ5CG2AWE=; b=wEX3YJ21eih3kF6luzyYju7zx7
	INM7DQzg9lf7OU+/Dtun1zch0+nVDU70BAXBxE2jAPi1rYiBvOjuKtl0bDUGKNMM9Nckg9iIJhfUB
	A7LFPIraAuHjb9Aa41NAXSKtGihiB9hzzeejrPolshORcMt/VkOZORs6HhPb+/vrfeq0S0BOLVYu/
	DFEom8lRz80dyrQz0Gi4voUKvyExVi9wrL/MMcPCJCRDwWVNOhgdMFabEfWu9mkw6NbY4H6PE5jh7
	8KCQGlwYAxF9CSRpvLSc0EaThAe9fdfDJEkkeuo+lZ7tld9QWQx6egYBhc6gh9ISWvxIWRWDSI3Y/
	Pv8ZWdiA==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uZrPy-0000000Bwck-0dPy;
	Thu, 10 Jul 2025 13:34:30 +0000
From: Christoph Hellwig <hch@lst.de>
To: Christian Brauner <brauner@kernel.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Joanne Koong <joannelkoong@gmail.com>,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-block@vger.kernel.org,
	gfs2@lists.linux.dev
Subject: [PATCH 13/14] iomap: add read_folio_range() handler for buffered writes
Date: Thu, 10 Jul 2025 15:33:37 +0200
Message-ID: <20250710133343.399917-14-hch@lst.de>
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

Add a read_folio_range() handler for buffered writes that filesystems
may pass in if they wish to provide a custom handler for synchronously
reading in the contents of a folio.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
[hch: renamed to read_folio_range, pass less arguments]
Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
---
 Documentation/filesystems/iomap/operations.rst |  6 ++++++
 fs/iomap/buffered-io.c                         | 13 +++++++++----
 include/linux/iomap.h                          | 10 ++++++++++
 3 files changed, 25 insertions(+), 4 deletions(-)

diff --git a/Documentation/filesystems/iomap/operations.rst b/Documentation/filesystems/iomap/operations.rst
index a9b48ce4af92..067ed8e14ef3 100644
--- a/Documentation/filesystems/iomap/operations.rst
+++ b/Documentation/filesystems/iomap/operations.rst
@@ -68,6 +68,8 @@ The following address space operations can be wrapped easily:
      void (*put_folio)(struct inode *inode, loff_t pos, unsigned copied,
                        struct folio *folio);
      bool (*iomap_valid)(struct inode *inode, const struct iomap *iomap);
+     int (*read_folio_range)(const struct iomap_iter *iter,
+     			struct folio *folio, loff_t pos, size_t len);
  };
 
 iomap calls these functions:
@@ -123,6 +125,10 @@ iomap calls these functions:
     ``->iomap_valid``, then the iomap should considered stale and the
     validation failed.
 
+  - ``read_folio_range``: Called to synchronously read in the range that will
+    be written to. If this function is not provided, iomap will default to
+    submitting a bio read request.
+
 These ``struct kiocb`` flags are significant for buffered I/O with iomap:
 
  * ``IOCB_NOWAIT``: Turns on ``IOMAP_NOWAIT``.
diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 8a44f56a3a80..aed4fc30a849 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -671,7 +671,8 @@ static int iomap_read_folio_range(const struct iomap_iter *iter,
 	return submit_bio_wait(&bio);
 }
 
-static int __iomap_write_begin(const struct iomap_iter *iter, size_t len,
+static int __iomap_write_begin(const struct iomap_iter *iter,
+		const struct iomap_write_ops *write_ops, size_t len,
 		struct folio *folio)
 {
 	struct iomap_folio_state *ifs;
@@ -722,8 +723,12 @@ static int __iomap_write_begin(const struct iomap_iter *iter, size_t len,
 			if (iter->flags & IOMAP_NOWAIT)
 				return -EAGAIN;
 
-			status = iomap_read_folio_range(iter, folio,
-					block_start, plen);
+			if (write_ops && write_ops->read_folio_range)
+				status = write_ops->read_folio_range(iter,
+						folio, block_start, plen);
+			else
+				status = iomap_read_folio_range(iter,
+						folio, block_start, plen);
 			if (status)
 				return status;
 		}
@@ -839,7 +844,7 @@ static int iomap_write_begin(struct iomap_iter *iter,
 	else if (srcmap->flags & IOMAP_F_BUFFER_HEAD)
 		status = __block_write_begin_int(folio, pos, len, NULL, srcmap);
 	else
-		status = __iomap_write_begin(iter, len, folio);
+		status = __iomap_write_begin(iter, write_ops, len, folio);
 
 	if (unlikely(status))
 		goto out_unlock;
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 80f543cc4fe8..73dceabc21c8 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -166,6 +166,16 @@ struct iomap_write_ops {
 	 * locked by the iomap code.
 	 */
 	bool (*iomap_valid)(struct inode *inode, const struct iomap *iomap);
+
+	/*
+	 * Optional if the filesystem wishes to provide a custom handler for
+	 * reading in the contents of a folio, otherwise iomap will default to
+	 * submitting a bio read request.
+	 *
+	 * The read must be done synchronously.
+	 */
+	int (*read_folio_range)(const struct iomap_iter *iter,
+			struct folio *folio, loff_t pos, size_t len);
 };
 
 /*
-- 
2.47.2


