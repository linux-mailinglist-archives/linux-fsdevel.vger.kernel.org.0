Return-Path: <linux-fsdevel+bounces-43429-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B3551A56991
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Mar 2025 14:55:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EE56188E377
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Mar 2025 13:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F5BC21C195;
	Fri,  7 Mar 2025 13:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XZn6/qRR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FFC021ADC1
	for <linux-fsdevel@vger.kernel.org>; Fri,  7 Mar 2025 13:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741355660; cv=none; b=sVauuj80cwLJjltr86Rp12GrfTdZHoC2QJy1bcIkmescOi6VYvLeYRNnEx9tTEukPRZQTwQSKKCHJjn/OTfytGZkfkRO6ZX59URJWM+iUgPNJDNYit0YrMYi9s/uFrkZP/XKrwScw4PjTDneIOoHQS6lac7g3C2vwHr73eDbpaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741355660; c=relaxed/simple;
	bh=T4wen+mzP89COR4DINuYxPNM7XJrfp1stHwFRaAnBW8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G49ZYyboFJiT9ox7d0THz/C/E7rFaMyF1oc7ZHxvI/qbe7FlkEELXODZg9sSApzv+68PqcwOUtX7C/jWHh0LlZtOZfJDA+9Q+rQlOR3tyJsLb5T7brKabX1wIsSKoI8zjMzm/eEd05qkYav8HPy+2dmxtz+Rkvc9rmA9id9Ovz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=XZn6/qRR; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=/z5i0Mk9Cv2/sY4L3FZ7BIchCOXs9aYcNdg4XHBiico=; b=XZn6/qRRlZuA8W/65iLtP+DmJA
	0a6R3g2imvgF9NFcjTV1wjItQb+Gm+iOmA3lKwb4uzXzpnGk1s+xHDW1io4ZlfX02BHlNf6G97ThN
	u2X2fj2Fs/PyNipIEfklLIt1qS6Yvysi39dBIgGZs19uBqdkje0otPp8X6WgmP4CQcUcfk3S/55aI
	T69BjppGgpcnsa2I1E5z1bACCLuqc1dYu/JT0Ao97YkukJGpxyiE6WN8iCl0IVdAD/ikqUSAgUX6q
	JHN4JQhhgTuWrUFBmcQinFwhgbp7J+0zmTpBe8abLU2VrxruKpPU3fThzjwCY8FxIcJckOvoQy44X
	nq+E4ZlA==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tqY9Y-0000000CXGT-1pj8;
	Fri, 07 Mar 2025 13:54:16 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: linux-fsdevel@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-mm@kvack.org,
	intel-gfx@lists.freedesktop.org
Subject: [PATCH 07/11] writeback: Remove writeback_use_writepage()
Date: Fri,  7 Mar 2025 13:54:07 +0000
Message-ID: <20250307135414.2987755-8-willy@infradead.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250307135414.2987755-1-willy@infradead.org>
References: <20250307135414.2987755-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ->writepage operation is going away.  Remove this alternative to
calling ->writepages.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/page-writeback.c | 28 ++--------------------------
 1 file changed, 2 insertions(+), 26 deletions(-)

diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 18456ddd463b..3cf7ae45be58 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2621,27 +2621,6 @@ int write_cache_pages(struct address_space *mapping,
 }
 EXPORT_SYMBOL(write_cache_pages);
 
-static int writeback_use_writepage(struct address_space *mapping,
-		struct writeback_control *wbc)
-{
-	struct folio *folio = NULL;
-	struct blk_plug plug;
-	int err;
-
-	blk_start_plug(&plug);
-	while ((folio = writeback_iter(mapping, wbc, folio, &err))) {
-		err = mapping->a_ops->writepage(&folio->page, wbc);
-		if (err == AOP_WRITEPAGE_ACTIVATE) {
-			folio_unlock(folio);
-			err = 0;
-		}
-		mapping_set_error(mapping, err);
-	}
-	blk_finish_plug(&plug);
-
-	return err;
-}
-
 int do_writepages(struct address_space *mapping, struct writeback_control *wbc)
 {
 	int ret;
@@ -2652,14 +2631,11 @@ int do_writepages(struct address_space *mapping, struct writeback_control *wbc)
 	wb = inode_to_wb_wbc(mapping->host, wbc);
 	wb_bandwidth_estimate_start(wb);
 	while (1) {
-		if (mapping->a_ops->writepages) {
+		if (mapping->a_ops->writepages)
 			ret = mapping->a_ops->writepages(mapping, wbc);
-		} else if (mapping->a_ops->writepage) {
-			ret = writeback_use_writepage(mapping, wbc);
-		} else {
+		else
 			/* deal with chardevs and other special files */
 			ret = 0;
-		}
 		if (ret != -ENOMEM || wbc->sync_mode != WB_SYNC_ALL)
 			break;
 
-- 
2.47.2


