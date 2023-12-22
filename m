Return-Path: <linux-fsdevel+bounces-6797-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFD9F81CBCE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Dec 2023 16:11:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADCE8281E76
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Dec 2023 15:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21B6A2D60E;
	Fri, 22 Dec 2023 15:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JaAkdqZm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B8B12CCD9;
	Fri, 22 Dec 2023 15:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=dVreMySeIHkVOAtpz+bbvTB1WjeCUE+T6e0OUt9+4gE=; b=JaAkdqZmOduEeNKqFX4Ku2J7NE
	ZUlndRMyXJVHVpS3YBp+6lZQe4Hb/Oea/LNWPgl4QZ3Yd8ECfM3p5l6Uct6A8zEfAoOe+Z0jwyHJ7
	0fm91BwTHShgOIQMcILm75blc7XQRH49G/JVXgOxWXo0dVFsqXpRBaEdyrPs0quk5x729W9gXmb98
	e255UWRmLzkFgEPdttgBQuUTeEySgAg3MR6Ea+qCXmLfCd4NzBC6vD2F7y56dqROKEg04RYOnnN0N
	lEHwOMZeqBxD5fPkSLKirvNRdxdMaUp/A77YEni/edJFRZ5TA6D0gHH4uUlkwB64Jons6MuMIPqUz
	RJn1Yl1w==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rGh8u-006BUd-1I;
	Fri, 22 Dec 2023 15:08:52 +0000
From: Christoph Hellwig <hch@lst.de>
To: linux-mm@kvack.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Jan Kara <jack@suse.com>,
	David Howells <dhowells@redhat.com>,
	Brian Foster <bfoster@redhat.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jan Kara <jack@suse.cz>,
	Dave Chinner <dchinner@redhat.com>
Subject: [PATCH 10/17] pagevec: Add ability to iterate a queue
Date: Fri, 22 Dec 2023 16:08:20 +0100
Message-Id: <20231222150827.1329938-11-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231222150827.1329938-1-hch@lst.de>
References: <20231222150827.1329938-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

Add a loop counter inside the folio_batch to let us iterate from 0-nr
instead of decrementing nr and treating the batch as a stack.  It would
generate some very weird and suboptimal I/O patterns for page writeback
to iterate over the batch as a stack.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jan Kara <jack@suse.cz>
Acked-by: Dave Chinner <dchinner@redhat.com>
---
 include/linux/pagevec.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/include/linux/pagevec.h b/include/linux/pagevec.h
index 87cc678adc850b..fcc06c300a72c3 100644
--- a/include/linux/pagevec.h
+++ b/include/linux/pagevec.h
@@ -27,6 +27,7 @@ struct folio;
  */
 struct folio_batch {
 	unsigned char nr;
+	unsigned char i;
 	bool percpu_pvec_drained;
 	struct folio *folios[PAGEVEC_SIZE];
 };
@@ -40,12 +41,14 @@ struct folio_batch {
 static inline void folio_batch_init(struct folio_batch *fbatch)
 {
 	fbatch->nr = 0;
+	fbatch->i = 0;
 	fbatch->percpu_pvec_drained = false;
 }
 
 static inline void folio_batch_reinit(struct folio_batch *fbatch)
 {
 	fbatch->nr = 0;
+	fbatch->i = 0;
 }
 
 static inline unsigned int folio_batch_count(struct folio_batch *fbatch)
@@ -75,6 +78,21 @@ static inline unsigned folio_batch_add(struct folio_batch *fbatch,
 	return folio_batch_space(fbatch);
 }
 
+/**
+ * folio_batch_next - Return the next folio to process.
+ * @fbatch: The folio batch being processed.
+ *
+ * Use this function to implement a queue of folios.
+ *
+ * Return: The next folio in the queue, or NULL if the queue is empty.
+ */
+static inline struct folio *folio_batch_next(struct folio_batch *fbatch)
+{
+	if (fbatch->i == fbatch->nr)
+		return NULL;
+	return fbatch->folios[fbatch->i++];
+}
+
 void __folio_batch_release(struct folio_batch *pvec);
 
 static inline void folio_batch_release(struct folio_batch *fbatch)
-- 
2.39.2


