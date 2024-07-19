Return-Path: <linux-fsdevel+bounces-24029-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 26368937BD8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jul 2024 19:51:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60CBC1C21737
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jul 2024 17:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2BB11474B7;
	Fri, 19 Jul 2024 17:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HfEhza6T"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64331459F9;
	Fri, 19 Jul 2024 17:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721411475; cv=none; b=D0daZSbcm0+UU1+Y8CyMC3Hdh/aKENuyguWJGBA61VyKVZKR1S8sHXxjGh3gLdQRqDIgEIl9MrlMH156RuIN68DaK8HAEv0BD3bZvN3fpFQTsv6qEvBUFyjOGqfy3rVAJ1gA4wzTgugC7dIP10brNb9weO4SUSFnNbxZPVn1fV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721411475; c=relaxed/simple;
	bh=Ih+1+iflwjA7GfUljQdgp4V0PyNkSIflg45bE0RmWTo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iXTD6BYUt1wybUphhf87Jsr3mu7ZSvEWYDBiRPM4bx06WH+nmuOrTadgffQ6bxn5Ndu6QlvZTcgd18lciusEYrW/GaezCE3HEHzr/cIvE6Ww3zgtMtGtpWRzNRkDOzUYv2b3jZYynCRcl3POExtd35snXgf1iqYncsbEu3QUpVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=HfEhza6T; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=TE2NR9PMMrrBqeqk/eXxMF6Rk4Xi7d2zHBTKL+xGqrQ=; b=HfEhza6TXVr4TtPQEM7USr4VYZ
	ySgTekkjh8OoRiKnx2IxZzNjn4lpVgOJGFazidaP2ZBmcUHSsSDpl39iJB2Ua4KMCaTGgklkOlkgw
	mpX2jvDq8ElVsXTCFqNzEsOSZF8li3/tP0tZGsuzFGBgnRkoGHD+OWcxoMw4UIJ3mfIsWvU+27H80
	5oRnmyuFz6Q+7kgnOslmj8EqxRm5/ISpaaRykUqIY3Xc1oWvWPCkMuU7iX7sypKNUKjTW+JsXCw7H
	UP4nykktfC+gjZgq9UWS+3idL0bPo93huch+B2KEkb5xYRb54ur4Xh0is4FxpZFwHvav8TgIldfkn
	cHxv00Kw==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sUrl9-00000003J4b-11Fo;
	Fri, 19 Jul 2024 17:51:11 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	gfs2@lists.linux.dev,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 1/4] gfs2: Add gfs2_aspace_writepages()
Date: Fri, 19 Jul 2024 18:51:01 +0100
Message-ID: <20240719175105.788253-2-willy@infradead.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240719175105.788253-1-willy@infradead.org>
References: <20240719175105.788253-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This saves one indirect function call per folio and gets us closer to
removing aops->writepage.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/gfs2/meta_io.c | 28 +++++++++++++++++++++++-----
 1 file changed, 23 insertions(+), 5 deletions(-)

diff --git a/fs/gfs2/meta_io.c b/fs/gfs2/meta_io.c
index 2b26e8d529aa..cfb204c9396c 100644
--- a/fs/gfs2/meta_io.c
+++ b/fs/gfs2/meta_io.c
@@ -30,9 +30,9 @@
 #include "util.h"
 #include "trace_gfs2.h"
 
-static int gfs2_aspace_writepage(struct page *page, struct writeback_control *wbc)
+static void gfs2_aspace_write_folio(struct folio *folio,
+		struct writeback_control *wbc)
 {
-	struct folio *folio = page_folio(page);
 	struct buffer_head *bh, *head;
 	int nr_underway = 0;
 	blk_opf_t write_flags = REQ_META | REQ_PRIO | wbc_to_write_flags(wbc);
@@ -66,8 +66,8 @@ static int gfs2_aspace_writepage(struct page *page, struct writeback_control *wb
 	} while ((bh = bh->b_this_page) != head);
 
 	/*
-	 * The page and its buffers are protected by PageWriteback(), so we can
-	 * drop the bh refcounts early.
+	 * The folio and its buffers are protected from truncation by
+	 * the writeback flag, so we can drop the bh refcounts early.
 	 */
 	BUG_ON(folio_test_writeback(folio));
 	folio_start_writeback(folio);
@@ -84,14 +84,31 @@ static int gfs2_aspace_writepage(struct page *page, struct writeback_control *wb
 
 	if (nr_underway == 0)
 		folio_end_writeback(folio);
+}
+
+static int gfs2_aspace_writepage(struct page *page, struct writeback_control *wbc)
+{
+	gfs2_aspace_write_folio(page_folio(page), wbc);
 
 	return 0;
 }
 
+static int gfs2_aspace_writepages(struct address_space *mapping,
+		struct writeback_control *wbc)
+{
+	struct folio *folio = NULL;
+	int error;
+
+	while ((folio = writeback_iter(mapping, wbc, folio, &error)))
+		gfs2_aspace_write_folio(folio, wbc);
+
+	return error;
+}
+
 const struct address_space_operations gfs2_meta_aops = {
 	.dirty_folio	= block_dirty_folio,
 	.invalidate_folio = block_invalidate_folio,
-	.writepage = gfs2_aspace_writepage,
+	.writepages = gfs2_aspace_writepages,
 	.release_folio = gfs2_release_folio,
 };
 
@@ -99,6 +116,7 @@ const struct address_space_operations gfs2_rgrp_aops = {
 	.dirty_folio	= block_dirty_folio,
 	.invalidate_folio = block_invalidate_folio,
 	.writepage = gfs2_aspace_writepage,
+	.writepages = gfs2_aspace_writepages,
 	.release_folio = gfs2_release_folio,
 };
 
-- 
2.43.0


