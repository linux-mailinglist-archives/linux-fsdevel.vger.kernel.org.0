Return-Path: <linux-fsdevel+bounces-8853-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B36383BC94
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 10:02:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1569EB27DC8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 09:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6642C1D530;
	Thu, 25 Jan 2024 08:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fJTltGtB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A43A1CD3F;
	Thu, 25 Jan 2024 08:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706173131; cv=none; b=Q1WoSbDxtf75HBFQd8sEoOvHts5EblzAPyZaQ5DepbGZ7GAFlW/Mdn89AwE72RRPb+PG3GQ0iY9SiFdoa3lW+5KJjJH+4cEl2jtmcKRWrGfsEiqVOVxIEWtPCkP7jd9K1RtPq/5nmlGSzPpQnDNInDNnBzZtAaaSHLHNkQV0H7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706173131; c=relaxed/simple;
	bh=fTLYVjDIeoVCfke4N2sWaubK5MF1WA6AHuRJJL/gcbk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EFB0+Ny1P2IgLKf5acTWRIKERftrHF4laOqwE2XPfoMZ5by8RoOcoUpVcWgTZRaKbzeMwQCqcr791SfByUlHXoc9h7HWeXLf7dIUmNCkF4TgENsMhSvv0pHl14kd1hK5URP241zwceWmAvvmtSgneqlZLiQWQ+L2+i0SHY/upIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=fJTltGtB; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=dVreMySeIHkVOAtpz+bbvTB1WjeCUE+T6e0OUt9+4gE=; b=fJTltGtBkzo7VMXaXfEGU0S2qs
	Y3TXmX4Qw3Kb87AMBLFpKxAN9cRUSTRyhiiLisdvt3e15LemYDbHh8CX9oVaTrWkT5WcI5gqltSre
	gtXc3Rz3jEWxdX3UHPaeOS3Hb7hZHyiBx9CArSuas0VLj+Ee0BTXrEiRRZLHn1rJ0hvNfPCacQIwi
	4w22mSTaXwIpKlSsPKZRSg8yGpeIFN3eeGaHzY2sIVQdKILOhUE8l7UQQW7gIheMp4DibuLjTg2lA
	lkMK3uinulqtVqUk1ihMf4BxEx5sAZjWCGzuhRZUixA07JrSrTkRKRTb4na0D7Pg3JVqopLmucgfQ
	J05KCISQ==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rSvZJ-007QNR-2E;
	Thu, 25 Jan 2024 08:58:42 +0000
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
Subject: [PATCH 10/19] pagevec: Add ability to iterate a queue
Date: Thu, 25 Jan 2024 09:57:49 +0100
Message-Id: <20240125085758.2393327-11-hch@lst.de>
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


