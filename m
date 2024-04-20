Return-Path: <linux-fsdevel+bounces-17335-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AE6CA8AB8EF
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Apr 2024 04:52:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3CBBDB21C65
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Apr 2024 02:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3A9614F65;
	Sat, 20 Apr 2024 02:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OKYm/Al+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E992E13AEE
	for <linux-fsdevel@vger.kernel.org>; Sat, 20 Apr 2024 02:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713581456; cv=none; b=XsxlJMXguhf1JRC36qYabjxs7kQClgml0Rn+jyira47j6O429l2OqHnaeBrhgjW8pK02OiCVQI6nf+U0blPCnJOqWr4EJkhDVZ5YybO5ag+jVXas/bzOaFPeeF0gcWfUOQxZu1KR/A46dQ5duNXriCo+TQ89/fMTt01dXd+yew8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713581456; c=relaxed/simple;
	bh=dhMsOeZOEa/T0OHb4fPd3ZQCyJ7E97FVD7eKfaEcI4I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jRav+XPAGpAqNzqn8Oh8y7pFhSLv1TcdXhqY8QNX238ObhBy4NDtwH2CjybPDmqZlmLUIQfINyu9tUf9gax4z2mAhcPD6gJxqvji7AswoBfBe2dBDCm/5X0WyEsNkJqNclF4vGdfDliLMv7b08s03iNV75Si4R9FQUbXgSOn00w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=OKYm/Al+; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=FtvvbXv86623ovyWG3cSTC9dm4lYYmfgrBjy1npS59Q=; b=OKYm/Al+FwhYahzTOGgwhqD5Nc
	I7/4fwWzcvjgc4gR8MjmGgTN7Em91EXe+XXle6Wb7xYQQ8PakkUQkaczbbVMZJdEtv2kEyp3w0liZ
	m9AuySHX1XYgAmWu9iqTTjKKcNtzqSiakDEsBBAgbo8oL5D/2djPp2TP0KryuY7xBMfeRC4KW2/M0
	rG6igylk3pdL4du0dET5/zTKNrCw3Pwfr28VVpc9xasaxVBDPBmUTwvp9TJL+5hK/2qrtaR2ThtgO
	7Wsy8kX2FIiX8ZeVdm11TkkvcCbKRnRbl72ASEnKJYc1nrVFWq5UlOQgvPwAryKWU0er5yLmC0Wrb
	RYxpXWWA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ry0oW-000000095fJ-2VQl;
	Sat, 20 Apr 2024 02:50:52 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: linux-fsdevel@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	David Woodhouse <dwmw2@infradead.org>,
	Richard Weinberger <richard@nod.at>,
	linux-mtd@lists.infradead.org
Subject: [PATCH 14/30] jffs2: Remove calls to set/clear the folio error flag
Date: Sat, 20 Apr 2024 03:50:09 +0100
Message-ID: <20240420025029.2166544-15-willy@infradead.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240420025029.2166544-1-willy@infradead.org>
References: <20240420025029.2166544-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Nobody checks the error flag on jffs2 folios, so stop setting and
clearing it.  We can also remove the call to clear the uptodate
flag; it will already be clear.

Convert one of these into a call to mapping_set_error() which will
actually be checked by other parts of the kernel.

Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Richard Weinberger <richard@nod.at>
Cc: linux-mtd@lists.infradead.org
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/jffs2/file.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/fs/jffs2/file.c b/fs/jffs2/file.c
index 62ea76da7fdf..e12cb145147e 100644
--- a/fs/jffs2/file.c
+++ b/fs/jffs2/file.c
@@ -95,13 +95,8 @@ static int jffs2_do_readpage_nolock (struct inode *inode, struct page *pg)
 	ret = jffs2_read_inode_range(c, f, pg_buf, pg->index << PAGE_SHIFT,
 				     PAGE_SIZE);
 
-	if (ret) {
-		ClearPageUptodate(pg);
-		SetPageError(pg);
-	} else {
+	if (!ret)
 		SetPageUptodate(pg);
-		ClearPageError(pg);
-	}
 
 	flush_dcache_page(pg);
 	kunmap(pg);
@@ -304,10 +299,8 @@ static int jffs2_write_end(struct file *filp, struct address_space *mapping,
 
 	kunmap(pg);
 
-	if (ret) {
-		/* There was an error writing. */
-		SetPageError(pg);
-	}
+	if (ret)
+		mapping_set_error(mapping, ret);
 
 	/* Adjust writtenlen for the padding we did, so we don't confuse our caller */
 	writtenlen -= min(writtenlen, (start - aligned_start));
@@ -330,7 +323,6 @@ static int jffs2_write_end(struct file *filp, struct address_space *mapping,
 		   it gets reread */
 		jffs2_dbg(1, "%s(): Not all bytes written. Marking page !uptodate\n",
 			__func__);
-		SetPageError(pg);
 		ClearPageUptodate(pg);
 	}
 
-- 
2.43.0


