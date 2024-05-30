Return-Path: <linux-fsdevel+bounces-20582-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D5468D53C3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 May 2024 22:24:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B52311F21470
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 May 2024 20:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28D4F17622B;
	Thu, 30 May 2024 20:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UN8piu+/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E25815AAD6
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 May 2024 20:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717100482; cv=none; b=k2w1Dri+1AL6uXOCdakLfTM+AahpaZHcR5HrzP7p8GsnFj5ydiLBP/mbkMcNWOWqo1QEywZ157axziOnf4al76r/nPgh4KdYAcgRnQLcZtUPsTmoLSGfj8oX0VNrRP5vhab5WZ8pgsyX05puWxkbdUL0OZu9BVJKLh9uEEqrKwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717100482; c=relaxed/simple;
	bh=0C1DPwDSzDhH/Zs3tMSuA2iTTHLlwV8LiA8J1dQIGtw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lcmIPi4/OHDD7tI/a4RuL36rMTjOmnixD0XDLlg1tKzcjNyVmJGiXjkZurcdoQLz1cRMgjsX0WFJCQAlq3TquoQmXn0iK+ULvrqaopOC7dUwI7iO9G66OvhspXQZYQ6Kqcwpg/ulOP7p7OPOArWz8Mp6gukIgIYy5Gu/xYYj7/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=UN8piu+/; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=T+7yTmvE0A2HSsaMeB1qy9Qcuwtb7tBxn6fPz6awa4M=; b=UN8piu+/FqOzNlvaftQJTOjAvS
	OYPsSV97020hqpf3mwq0Oyodq6bXikJXpOVtJQHmCmmLw+h4H1wmw6NtsyaxN+jT9C+L6/26M2TaU
	6gd1Sos5Fv9mR0l+At2WlnUT4DebreF6OkFAZYw3/qACIcM28DT/P3ngh9tK6iSJAPh+SykBV82P+
	V9CyZ0yULw/6iB2BdJf3pqBZVBColATVxNJRGYmQXGYD+Jp2ASR5hObkr1m5Z2c8t9+CV1ZjtYRrI
	UKFk/HQBF9+3I6JpABUf9CLGQGBgKeM2nkHFNvUgFSzbgHiB8JR7oxmPBZoEx/TRCT7HNRIsWga3T
	3U6WKghQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCmGz-0000000B8LO-3hDZ;
	Thu, 30 May 2024 20:21:17 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Christian Brauner <brauner@kernel.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-fsdevel@vger.kernel.org,
	David Woodhouse <dwmw2@infradead.org>,
	linux-mtd@lists.infradead.org,
	Zhihao Cheng <chengzhihao1@huawei.com>,
	Richard Weinberger <richard@nod.at>
Subject: [PATCH 08/16] jffs2: Remove calls to set/clear the folio error flag
Date: Thu, 30 May 2024 21:21:00 +0100
Message-ID: <20240530202110.2653630-9-willy@infradead.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240530202110.2653630-1-willy@infradead.org>
References: <20240530202110.2653630-1-willy@infradead.org>
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
Cc: linux-mtd@lists.infradead.org
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Tested-by: Zhihao Cheng <chengzhihao1@huawei.com>
Reviewed-by: Zhihao Cheng <chengzhihao1@huawei.com>
Acked-by: Richard Weinberger <richard@nod.at>
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


