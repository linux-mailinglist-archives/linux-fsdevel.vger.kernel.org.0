Return-Path: <linux-fsdevel+bounces-11651-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0344D855A99
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Feb 2024 07:39:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 281BC1C2A444
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Feb 2024 06:39:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4BFE1B963;
	Thu, 15 Feb 2024 06:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oocpZKdd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A3CFD53F;
	Thu, 15 Feb 2024 06:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707979046; cv=none; b=pCIe9vAvWMNGLtw05CKvC8YBdErt5bF1IaZOF2SqqcjliMqwUv8iY0dfbNLasnVljckQg8xF1JOv2+rjEZJ8ForHlAboEoY0OKqO3edTy5F60FJdh8eaUJQIkBDlKfBMkM3EUeewhBWbk0boECpzxN/RDHZa2TVS8DHaf1dl2kY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707979046; c=relaxed/simple;
	bh=8YXecWRICYuMcNttDcOnWW490EjFn6keh2I4C8IPcyw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YSlVgrlJg/y+tb8EPZCemB6V+MeBjAXCp7MmLOm1q2YIxA/Jo6Gbn2NZrPFAUCQlsqB0GQuEgIqcOOiy5Pc36Ivo3y1izqHgbip5i4eP6qlo68cUxBH6W0yk57n0FJRze7Hu8HutDF+6jacZ7JwvblCgW7BsgMgxHhJdsqjO/A0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=oocpZKdd; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=M5Qvp5zNKGHXjXReg58hQjrWh/GgxzXP5maEkxrO/YI=; b=oocpZKddbVY6RivLE2iFbVbswr
	+U/BXlpxFleRHdXUV6ZMR2h0ZR8BOy5nKcJJJ/GUEaAExDlL9pX5lAZXTSltOaS9OTTnJDvTzQcQv
	eL1jmtI9M2tdt2PMmW371ExOcZVdcEKOWF1jU1tTp+uIg57k2D50vxNDLOWMnvi1qZxUQArDazn3j
	FituwDoNFLW7LSflofvpYgyI9EICnaZCJIC8q4Z2M5xgJUStQXHSMa8GMpchZls5wuGh++UqPRyMm
	pRCmsqHqfq9HrJ5bKPZnZ1XJoD4MvnwuyYa2HZbnR1PaeCY3pQwDmE40RCjh6kW3u2J3T1zTDC95D
	nTwbtk9g==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1raVN4-0000000F6yZ-2rwu;
	Thu, 15 Feb 2024 06:37:23 +0000
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
Subject: [PATCH 10/14] pagevec: Add ability to iterate a queue
Date: Thu, 15 Feb 2024 07:36:45 +0100
Message-Id: <20240215063649.2164017-11-hch@lst.de>
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

Add a loop counter inside the folio_batch to let us iterate from 0-nr
instead of decrementing nr and treating the batch as a stack.  It would
generate some very weird and suboptimal I/O patterns for page writeback
to iterate over the batch as a stack.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Brian Foster <bfoster@redhat.com>
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


