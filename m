Return-Path: <linux-fsdevel+bounces-8851-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E0D7E83BC8D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 10:01:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 202E31C26B7E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 09:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 167021CAB9;
	Thu, 25 Jan 2024 08:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NYMtHn25"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20BE61CA91;
	Thu, 25 Jan 2024 08:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706173119; cv=none; b=L3UFc25kRvfSytquSTjOKXwKeLY+cypQfUr7jFa62dCYtLQzsctO/o3JYCD6Gb8fMz6rL5ABf+sLfCoZKVZxzxva/gjyVUIa2eQJJGI5cj7WbMYhPk+HIyXT7x2NKMQbapOSowLTPRsQaF6ww9/34bwdw7vONJiURZ9vqffPpz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706173119; c=relaxed/simple;
	bh=NYqeEiR8kqeMcVg/6ado7ykZ5p6BzBD8+UwgtMcm5MU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ru/YZOwAGA/YB65R0A9r2ujm3elELEce2xOyzMnkYYilv80CL+C48/yjDTUhS9Nj1P8tfDyjRpquQE7yDaphB2cf+MINVpOqYZzJhDBdYD7oJ2A9aldDnzYZMuTRq5YHmN8lkqGTOCWRZcLb6Qi451e2iekItYHWmgqIu2sS8vA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=NYMtHn25; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=iMNdeEcqkHffoQV1X3XMHDmnGgKthKHMo1jJFViVMos=; b=NYMtHn25QyrrlxJcgdmcd5wXPv
	Fs4iTu7Y92y79RyHoSjqnlwmQ9qOeHg2R71DOkpgcyJhscAmH6I4dNw4srUwkykfySn/hDJUXF9Mg
	xE1KHnNO/4TDKC1BnAC9r/zqcHfUmFdxMYmeWpb6mOQR7ikjQnudqE5vJzum+sNrz7WREHDLNDbt8
	aOCRcmIL3e0neCp4yrhGF9cF/98FYoaUTHSoa9ags1lcADvlSMN2TLch/Y/7NVitDRie7WYJvj4ps
	0BORVBVnBJbJe3aJ/25+/xzXccPHir5JNNB1eIiE4OgrV4nMlCA8nj6yVyW4d0PWkGM78le+KiEiS
	8mHMHEEA==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rSvZ6-007QHR-2Y;
	Thu, 25 Jan 2024 08:58:29 +0000
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
Subject: [PATCH 07/19] writeback: Factor writeback_get_batch() out of write_cache_pages()
Date: Thu, 25 Jan 2024 09:57:46 +0100
Message-Id: <20240125085758.2393327-8-hch@lst.de>
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

This simple helper will be the basis of the writeback iterator.
To make this work, we need to remember the current index
and end positions in writeback_control.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
[hch: heavily rebased, add helpers to get the tag and end index,
      don't keep the end index in struct writeback_control]
Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jan Kara <jack@suse.cz>
Acked-by: Dave Chinner <dchinner@redhat.com>
---
 include/linux/writeback.h |  1 +
 mm/page-writeback.c       | 49 +++++++++++++++++++++++++--------------
 2 files changed, 32 insertions(+), 18 deletions(-)

diff --git a/include/linux/writeback.h b/include/linux/writeback.h
index 7d60a68fa4ea47..a091817a5dba55 100644
--- a/include/linux/writeback.h
+++ b/include/linux/writeback.h
@@ -81,6 +81,7 @@ struct writeback_control {
 
 	/* internal fields used by the ->writepages implementation: */
 	struct folio_batch fbatch;
+	pgoff_t index;
 	int err;
 
 #ifdef CONFIG_CGROUP_WRITEBACK
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index fcd90a176d806c..426d929741e46e 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2383,6 +2383,29 @@ static void writeback_finish(struct address_space *mapping,
 	}
 }
 
+static xa_mark_t wbc_to_tag(struct writeback_control *wbc)
+{
+	if (wbc->sync_mode == WB_SYNC_ALL || wbc->tagged_writepages)
+		return PAGECACHE_TAG_TOWRITE;
+	return PAGECACHE_TAG_DIRTY;
+}
+
+static pgoff_t wbc_end(struct writeback_control *wbc)
+{
+	if (wbc->range_cyclic)
+		return -1;
+	return wbc->range_end >> PAGE_SHIFT;
+}
+
+static void writeback_get_batch(struct address_space *mapping,
+		struct writeback_control *wbc)
+{
+	folio_batch_release(&wbc->fbatch);
+	cond_resched();
+	filemap_get_folios_tag(mapping, &wbc->index, wbc_end(wbc),
+			wbc_to_tag(wbc), &wbc->fbatch);
+}
+
 /**
  * write_cache_pages - walk the list of dirty pages of the given address space and write all of them.
  * @mapping: address space structure to write
@@ -2419,38 +2442,30 @@ int write_cache_pages(struct address_space *mapping,
 		      void *data)
 {
 	int error;
-	int nr_folios;
-	pgoff_t index;
 	pgoff_t end;		/* Inclusive */
-	xa_mark_t tag;
 
 	if (wbc->range_cyclic) {
-		index = mapping->writeback_index; /* prev offset */
+		wbc->index = mapping->writeback_index; /* prev offset */
 		end = -1;
 	} else {
-		index = wbc->range_start >> PAGE_SHIFT;
+		wbc->index = wbc->range_start >> PAGE_SHIFT;
 		end = wbc->range_end >> PAGE_SHIFT;
 	}
-	if (wbc->sync_mode == WB_SYNC_ALL || wbc->tagged_writepages) {
-		tag_pages_for_writeback(mapping, index, end);
-		tag = PAGECACHE_TAG_TOWRITE;
-	} else {
-		tag = PAGECACHE_TAG_DIRTY;
-	}
+	if (wbc->sync_mode == WB_SYNC_ALL || wbc->tagged_writepages)
+		tag_pages_for_writeback(mapping, wbc->index, end);
 
 	folio_batch_init(&wbc->fbatch);
 	wbc->err = 0;
 
-	while (index <= end) {
+	while (wbc->index <= end) {
 		int i;
 
-		nr_folios = filemap_get_folios_tag(mapping, &index, end,
-				tag, &wbc->fbatch);
+		writeback_get_batch(mapping, wbc);
 
-		if (nr_folios == 0)
+		if (wbc->fbatch.nr == 0)
 			break;
 
-		for (i = 0; i < nr_folios; i++) {
+		for (i = 0; i < wbc->fbatch.nr; i++) {
 			struct folio *folio = wbc->fbatch.folios[i];
 			unsigned long nr;
 
@@ -2525,8 +2540,6 @@ int write_cache_pages(struct address_space *mapping,
 				return error;
 			}
 		}
-		folio_batch_release(&wbc->fbatch);
-		cond_resched();
 	}
 
 	writeback_finish(mapping, wbc, 0);
-- 
2.39.2


