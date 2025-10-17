Return-Path: <linux-fsdevel+bounces-64408-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DF80DBE63C0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Oct 2025 05:46:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 30F914F6296
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Oct 2025 03:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 416A02F83B3;
	Fri, 17 Oct 2025 03:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="0RtBUzLx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7932F6576;
	Fri, 17 Oct 2025 03:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760672789; cv=none; b=cl8JwGAp6tyE/3DamouPtZA/Ruo33VdE5gDpVDRzurQEiMvAl+XGQH/JjJSJMmi/LU//rURhBaRD6x95IFeRDGblNK6KNZig2byfz3xfzY4jbl1kHtQ4/JdDydzizt0Jkun4waRpwZ/8ld5RbF603IwOY21C6koAAm1yfuI2+F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760672789; c=relaxed/simple;
	bh=0u/dSCrsViN6ArZ8gqjb4to9dJ+vQFi2RqEIQsl0l/4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a5sKz08C+upnCYumt2IyQe3x5Hsou7CX6YrEV6FnREL13gumZp6wkgb0OVSyPAMrPyy0sOF4WXCw07Sh5Jvo5clQNY1E/QVI3gqQmvZ7sZEOEXKu3XejoOlg5whbHuJzak/uHsRlvlW4Hut1Q/hpftG7ByLJvn649lLKLfdFJbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=0RtBUzLx; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=yJfEq/VEpkF6FLI8QH2hSLbs5ZovUQs0qM/ADHpSGWI=; b=0RtBUzLxdnI3gtpLUeBQxq2cU/
	BxgViSRS3igmIOobOZyMaAWvLEUVoK0js2nMlKWPqi+QJSzXG0PaHV2aaMhDmazemlJt7mSU5aKPh
	uUi3go0oIQYazH2g9FDcMElIwKw4IWkP60Q9ypAmls9sGk7lDmUOWDtXHoyBzObS2hRACsJ9mBUnE
	l4pxOzVUKltvvtKhUqAszLP47nBWulQSPMUqCNK0npeH2ix8v/6i9sG+qK3cEX0Tsi+EERcccB77K
	FIyPRBYKkuHAqskYlvRkjA9ei2QNsbeFPigy+NSaDRuHHqHYLEp5IDBi+kj/1GgEIJfailMowV0zT
	9fZc1wmA==;
Received: from 5-226-109-134.static.ip.netia.com.pl ([5.226.109.134] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v9bQ9-00000006TyS-01c2;
	Fri, 17 Oct 2025 03:46:25 +0000
From: Christoph Hellwig <hch@lst.de>
To: Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Carlos Maiolino <cem@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	willy@infradead.org,
	dlemoal@kernel.org,
	hans.holmberg@wdc.com,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	"Darrick J. Wong" <djwong@kernel.org>
Subject: [PATCH 1/3] writeback: cleanup writeback_chunk_size
Date: Fri, 17 Oct 2025 05:45:47 +0200
Message-ID: <20251017034611.651385-2-hch@lst.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251017034611.651385-1-hch@lst.de>
References: <20251017034611.651385-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Return the pages directly when calculated instead of first assigning
them back to a variable, and directly return for the data integrity /
tagged case instead of going through an else clause.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fs-writeback.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 2b35e80037fe..11fd08a0efb8 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -1893,16 +1893,12 @@ static long writeback_chunk_size(struct bdi_writeback *wb,
 	 *                   (maybe slowly) sync all tagged pages
 	 */
 	if (work->sync_mode == WB_SYNC_ALL || work->tagged_writepages)
-		pages = LONG_MAX;
-	else {
-		pages = min(wb->avg_write_bandwidth / 2,
-			    global_wb_domain.dirty_limit / DIRTY_SCOPE);
-		pages = min(pages, work->nr_pages);
-		pages = round_down(pages + MIN_WRITEBACK_PAGES,
-				   MIN_WRITEBACK_PAGES);
-	}
+		return LONG_MAX;
 
-	return pages;
+	pages = min(wb->avg_write_bandwidth / 2,
+		    global_wb_domain.dirty_limit / DIRTY_SCOPE);
+	pages = min(pages, work->nr_pages);
+	return round_down(pages + MIN_WRITEBACK_PAGES, MIN_WRITEBACK_PAGES);
 }
 
 /*
-- 
2.47.3


