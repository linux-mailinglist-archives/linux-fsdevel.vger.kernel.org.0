Return-Path: <linux-fsdevel+bounces-42486-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3C7DA42AA8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 19:07:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 562C23A82CD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 18:06:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE45026658A;
	Mon, 24 Feb 2025 18:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="e/JiBide"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 718EE265608
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Feb 2025 18:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740420336; cv=none; b=iCYo6iiExDupiNSp4nmGk4ljUA0nnGoND7KHdowKJibTkXdsb+sSu/UwhbEXB6Q/E/aZo3TiiovHSvjE/5PJ8ft/usJGzsRJJajfN9yrUBQtEctkevg3R+ZweP4LHhB2MBGLC5Qg7XxW9GEwkkWQrcYHNnTwgOTTrrUM5TzKtAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740420336; c=relaxed/simple;
	bh=aFN1D9DsZIKDWRf0fKPoQl80xDfsv31OlP1bEEDxzGM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eUby+H38qjZCGQa5TSaTiCXAPiBy4ksqJD0Uvi0tfgAFZxpiM/PAjv2hlLSjwo0/93YbrO0R1hPwpTGlOy68Xz/nOTNVAm0yv5mRlqJzdw0wJRlOlv1Tej6pcqor4SIe/iqLylOYL8CaIVKeT5RI4HO+xAVQYHvq5+TNXbQpFEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=e/JiBide; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=CU0/jsigZoGStt97taLiW/kmH6Lymi4XESfbgEuwDuA=; b=e/JiBide+57L6w2ZAULZwO23ct
	K/U/HfUDxx2qqxn739c/lTAtHvd7zXLv43dTQI+we/IkvvgGciP+tXaLznns0l7XFC/LoFXu/c0Wk
	cUmt/2GNbrnUNA6E5/YWhFPpvssg376BbTe38tGS3zJtTh+N294gjUy2SuzAzri9kJaSO0O0yVEHu
	gKBihTgysaTLeQzd0tmM4rz4OTerv1NM2rWT7XtkHaJF5GPBG0qZMrJtNQ6qnsgoh+xZqpj01WQIX
	XovYE7VEaVBRX61ssjYShpeP/A4imLmxJfZ5yhY3fYZH3qDw72aXyjlUgauq/zwHTvdOxefuwSN/b
	maVWQPaA==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tmcpg-000000082gG-3gB0;
	Mon, 24 Feb 2025 18:05:32 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Mike Marshall <hubcap@omnibond.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Martin Brandenburg <martin@omnibond.com>,
	devel@lists.orangefs.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 7/9] orangefs: Unify error & success paths in orangefs_writepages_work()
Date: Mon, 24 Feb 2025 18:05:25 +0000
Message-ID: <20250224180529.1916812-8-willy@infradead.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250224180529.1916812-1-willy@infradead.org>
References: <20250224180529.1916812-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Both arms of this conditional now have the same loop, so sink it out
of the conditional.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/orangefs/inode.c | 36 +++++++++++++-----------------------
 1 file changed, 13 insertions(+), 23 deletions(-)

diff --git a/fs/orangefs/inode.c b/fs/orangefs/inode.c
index 879d96c11b1c..927c2829976c 100644
--- a/fs/orangefs/inode.c
+++ b/fs/orangefs/inode.c
@@ -107,33 +107,23 @@ static int orangefs_writepages_work(struct orangefs_writepages *ow,
 	wr.gid = ow->gid;
 	ret = wait_for_direct_io(ORANGEFS_IO_WRITE, inode, &off, &iter, ow->len,
 	    0, &wr, NULL, NULL);
-	if (ret < 0) {
+	if (ret < 0)
 		mapping_set_error(ow->mapping, ret);
-		for (i = 0; i < ow->npages; i++) {
-			if (PagePrivate(ow->pages[i])) {
-				wrp = (struct orangefs_write_range *)
-				    page_private(ow->pages[i]);
-				ClearPagePrivate(ow->pages[i]);
-				put_page(ow->pages[i]);
-				kfree(wrp);
-			}
-			end_page_writeback(ow->pages[i]);
-			unlock_page(ow->pages[i]);
-		}
-	} else {
+	else
 		ret = 0;
-		for (i = 0; i < ow->npages; i++) {
-			if (PagePrivate(ow->pages[i])) {
-				wrp = (struct orangefs_write_range *)
-				    page_private(ow->pages[i]);
-				ClearPagePrivate(ow->pages[i]);
-				put_page(ow->pages[i]);
-				kfree(wrp);
-			}
-			end_page_writeback(ow->pages[i]);
-			unlock_page(ow->pages[i]);
+
+	for (i = 0; i < ow->npages; i++) {
+		if (PagePrivate(ow->pages[i])) {
+			wrp = (struct orangefs_write_range *)
+			    page_private(ow->pages[i]);
+			ClearPagePrivate(ow->pages[i]);
+			put_page(ow->pages[i]);
+			kfree(wrp);
 		}
+		end_page_writeback(ow->pages[i]);
+		unlock_page(ow->pages[i]);
 	}
+
 	return ret;
 }
 
-- 
2.47.2


