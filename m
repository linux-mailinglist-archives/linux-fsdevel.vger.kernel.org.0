Return-Path: <linux-fsdevel+bounces-8856-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30BB883BC9D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 10:03:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDA4C28E7A2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 09:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04DF921115;
	Thu, 25 Jan 2024 08:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZQE+aY4V"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E2020326;
	Thu, 25 Jan 2024 08:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706173138; cv=none; b=mV6hgbXzgzmZW3tAaXIQXOX5krHp2FnZC+hQjczkuogknu4YIb77SkxTLlDdCPD9Z9C8anPn1fN8v+XF0c6kN+Vt+V8ejHl+9qOH9rGv4wBrRT52hCRbERqQTdH8BD0d9BdUnD6/PvAa3/73OmMFB8sQZivc5jll/s94PRuyevE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706173138; c=relaxed/simple;
	bh=rqmkNkur90/csdlia69cxFCuh1yRr4idby4RxAaq2oM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WlKA9brgKmFxUoalxm2fE8RGJAmOo7EQBZNA0PRE232/zQrYZ43ApDxacu8yiAf5JOVmcOVAa6798lhMlQG1VbrutWbtPmiQc7DQF55l1PS4hXDtRh/2a/oavkvt44IXGcYKfsrG706foMyQ2xnKPvygM8JiC9FK7BqZyco07bE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ZQE+aY4V; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=ukNtwPf12oSRUA3UJBplrrlZ3BMhuvUNPapQ7zi0Hu0=; b=ZQE+aY4VeQqULr6kd1ufkmZyCm
	g9XFXD48FdWm/3mGFDF270b4JWx4OZ1Vd/zauFYola5nkSWISmgToauOt+vPrpv0elJ11E7fycDW+
	uOi2DFdCMSO/ZX0oeqLzF1JI8vL3pIexWD13RQ4jUekhoCKohpXznMGe5Uyou0O9KuF8gj5CUJEOF
	o7nEL9nQYx8FhnMMg3ZBtuM0yJyPDXOrqiutn+GUZRX+HAT/TooxYxn9uecwIuNBUADX/fGtI9kYl
	EMbhh8TGKk2tqfPi8Nb9f4CirptF/P969fIdg3CJ31Oh3webS++wJM9TVQQJOU/AFldl7RgCJIO+4
	/gpbjwIA==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rSvZU-007QRY-1i;
	Thu, 25 Jan 2024 08:58:53 +0000
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
Subject: [PATCH 13/19] writeback: Move the folio_prepare_writeback loop out of write_cache_pages()
Date: Thu, 25 Jan 2024 09:57:52 +0100
Message-Id: <20240125085758.2393327-14-hch@lst.de>
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

Move the loop for should-we-write-this-folio to writeback_get_folio.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
[hch: folded the loop into the existing helper instead of a separate one
      as suggested by Jan Kara]
Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jan Kara <jack@suse.cz>
Acked-by: Dave Chinner <dchinner@redhat.com>
---
 mm/page-writeback.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index ae9f659e6796ac..d170dab07402ce 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2434,6 +2434,7 @@ static struct folio *writeback_get_folio(struct address_space *mapping,
 {
 	struct folio *folio;
 
+retry:
 	folio = folio_batch_next(&wbc->fbatch);
 	if (!folio) {
 		folio_batch_release(&wbc->fbatch);
@@ -2441,8 +2442,17 @@ static struct folio *writeback_get_folio(struct address_space *mapping,
 		filemap_get_folios_tag(mapping, &wbc->index, wbc_end(wbc),
 				wbc_to_tag(wbc), &wbc->fbatch);
 		folio = folio_batch_next(&wbc->fbatch);
+		if (!folio)
+			return NULL;
 	}
 
+	folio_lock(folio);
+	if (unlikely(!folio_prepare_writeback(mapping, wbc, folio))) {
+		folio_unlock(folio);
+		goto retry;
+	}
+
+	trace_wbc_writepage(wbc, inode_to_bdi(mapping->host));
 	return folio;
 }
 
@@ -2505,14 +2515,6 @@ int write_cache_pages(struct address_space *mapping,
 	     folio = writeback_get_folio(mapping, wbc)) {
 		unsigned long nr;
 
-		folio_lock(folio);
-		if (!folio_prepare_writeback(mapping, wbc, folio)) {
-			folio_unlock(folio);
-			continue;
-		}
-
-		trace_wbc_writepage(wbc, inode_to_bdi(mapping->host));
-
 		error = writepage(folio, wbc, data);
 		nr = folio_nr_pages(folio);
 		wbc->nr_to_write -= nr;
-- 
2.39.2


