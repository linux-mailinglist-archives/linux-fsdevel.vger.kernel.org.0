Return-Path: <linux-fsdevel+bounces-17348-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C58688AB901
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Apr 2024 04:52:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B4871F21D4C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Apr 2024 02:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D9541C292;
	Sat, 20 Apr 2024 02:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TczbW4PL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B520175B1;
	Sat, 20 Apr 2024 02:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713581464; cv=none; b=OhD3UozBUE/wScosGpTSo1Y5GJm/TqjHF/hurJc5xVYKwOQ4JXgmvAhIHctZOs7ZBBn9yNRkLt8RK/Wp+xWSmph6e3GfOuFRRAtJkNlV4j8Tj+CpVoC1hB6t0oZq5Cc0dtCobWgpwdgup6l8TKOuX9xAKFKfH7Qa5DCdgf4LUZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713581464; c=relaxed/simple;
	bh=toMdXVVbMSmwIquWLakJqRRQoi2rF0RQdjBZap1Oh2Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jfT/BrIlBHnvxYfIQzmeRs7aEALB+j/hbDAt1hJ7lDhlaBkyW9oC1VWkKco5TduhRnm/4eH9NE1J6gsmcO6UJHC2JoO+pck9xObYdS7v5xSn5MExQWtOu4VjE8mtRbdhFHigA2cGB6NikEJtioLY3HCdoPZNn6pRFOGdNz5Kz9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=TczbW4PL; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=Y3koETGNEc6+Xt3EmtpJdafmmHLWcDXIyu/5s+XhzTg=; b=TczbW4PLKKu+hylU0BwlAV2amo
	DwhH/JX8X+r4zu2oNK2mgKDLCxQLGrEPgoo5ApbGCMs319jP1LuqkkMBV3iOSvWCmFe9itRCGM/dB
	oFIzqCunQnJN9G+ZDApOZ+sEhRpZUrDL1AzO9zpP+y1Gpxltxp2bq2GMCMt+TJltAk6x5Cy5vQXM3
	KA6xmfhFqE/hcYI3lCOamj5xfRPiaygn+U+kBtMwbSYbMuPFb6ZclfUZOhcQPf49yGl1aaP+U4B91
	GM50G7bZkjwPZ243iqg4v6dptSECi4E3Rsq9wb/nlpjNnaerErPzw7QLX4Tu8hj2B4IXaGAKPPr0P
	JKBM8B6w==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ry0oe-000000095gm-46Ed;
	Sat, 20 Apr 2024 02:51:01 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: linux-fsdevel@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Christian Brauner <brauner@kernel.org>,
	"Darrick J . Wong" <djwong@kernel.org>,
	linux-xfs@vger.kernel.org
Subject: [PATCH 27/30] iomap: Remove calls to set and clear folio error flag
Date: Sat, 20 Apr 2024 03:50:22 +0100
Message-ID: <20240420025029.2166544-28-willy@infradead.org>
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

The folio error flag is not checked anywhere, so we can remove the calls
to set and clear it.

Cc: Christian Brauner <brauner@kernel.org>
Cc: Darrick J. Wong <djwong@kernel.org>
Cc: linux-xfs@vger.kernel.org
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/iomap/buffered-io.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 4e8e41c8b3c0..41352601f939 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -306,8 +306,6 @@ static void iomap_finish_folio_read(struct folio *folio, size_t off,
 		spin_unlock_irqrestore(&ifs->state_lock, flags);
 	}
 
-	if (error)
-		folio_set_error(folio);
 	if (finished)
 		folio_end_read(folio, uptodate);
 }
@@ -460,9 +458,6 @@ int iomap_read_folio(struct folio *folio, const struct iomap_ops *ops)
 	while ((ret = iomap_iter(&iter, ops)) > 0)
 		iter.processed = iomap_readpage_iter(&iter, &ctx, 0);
 
-	if (ret < 0)
-		folio_set_error(folio);
-
 	if (ctx.bio) {
 		submit_bio(ctx.bio);
 		WARN_ON_ONCE(!ctx.cur_folio_in_bio);
@@ -697,7 +692,6 @@ static int __iomap_write_begin(const struct iomap_iter *iter, loff_t pos,
 
 	if (folio_test_uptodate(folio))
 		return 0;
-	folio_clear_error(folio);
 
 	do {
 		iomap_adjust_read_range(iter->inode, folio, &block_start,
@@ -1528,8 +1522,6 @@ iomap_finish_ioend(struct iomap_ioend *ioend, int error)
 
 	/* walk all folios in bio, ending page IO on them */
 	bio_for_each_folio_all(fi, bio) {
-		if (error)
-			folio_set_error(fi.folio);
 		iomap_finish_folio_write(inode, fi.folio, fi.length);
 		folio_count++;
 	}
-- 
2.43.0


