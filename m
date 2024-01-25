Return-Path: <linux-fsdevel+bounces-8859-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A82C183BCA7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 10:04:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA6541C284D4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 09:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4DBD35F0C;
	Thu, 25 Jan 2024 08:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="b9+nO3yw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0368B2D627;
	Thu, 25 Jan 2024 08:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706173149; cv=none; b=aXRLQD8ZPbDyRVJ3eq4/8Fn+cs4VUSWr27L3BoTHmj9E4T+XlJo829xkG8Ql+Y6Z7+wDqVTj6Sd04MNks0z5lSI9pHC2UxFYVMN+mjuAAsAjTHznXhBXwbJXFZdsAzbjgZJ6f7IgJlqmUOrIKut0sa0ixnTxfZRT0WTylY8916Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706173149; c=relaxed/simple;
	bh=RCsrh61Img5C5QwcYCSsKxUdRMm5ls9erOIy+p4nwnk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Rk64uLJjss6pd9KzMCuIhdCDrXJyZ3Bv3YRi6e+06tophj80a/jswuUGqbTas/wW05j2D/LnZRdEBWU7657QBVrXq8KjOWGF2YkULQq3Esf0ya/gMu1dZmF0f9CGeF6PMA16TPCVgOyO6oznyZjWZ+I9rDGisnw6z3DE6YI/iks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=b9+nO3yw; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=jmxBhEwvvP0SHYr6G/94FmB0blh/Svg4tA2Bb0QCX2c=; b=b9+nO3ywJHkLbo7Hj/APqwblnx
	0Jd3qWrW11823FTn4RkUzafKOu7wPN4qXVWb3Y3abZVmd6IeXCyA/8h25NwJ06dR7W4WRb0TiGxgS
	XRSu+AWHyptJe9dauajhaWAA7KsaMgHO5l9+fuWnqXd836VjWfYGn7T8rlHhDYiTUCCkjK7cBPpc1
	YguvS1IP6xeXvIaJiu8J8kF5tdyVBGE4IcyAC3h8JRFPuKt3k5hsvByqL8Pqf64BAMQy8cd2Rfb0b
	wNkEzo0iawP2oJl4sK/Ea1XshNHk9nHAXQGTHXcSoqAs1Zmi24m5dyKVCgIG0/f8uPIA29xjnRI8R
	Fq8sz5/A==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rSvZe-007QWD-0t;
	Thu, 25 Jan 2024 08:59:03 +0000
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
Subject: [PATCH 16/19] writeback: Remove a use of write_cache_pages() from do_writepages()
Date: Thu, 25 Jan 2024 09:57:55 +0100
Message-Id: <20240125085758.2393327-17-hch@lst.de>
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

Use the new for_each_writeback_folio() directly instead of indirecting
through a callback.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jan Kara <jack@suse.cz>
Acked-by: Dave Chinner <dchinner@redhat.com>
---
 mm/page-writeback.c | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index aca0f43021a20c..81034d5d72e1f4 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2559,13 +2559,21 @@ int write_cache_pages(struct address_space *mapping,
 }
 EXPORT_SYMBOL(write_cache_pages);
 
-static int writepage_cb(struct folio *folio, struct writeback_control *wbc,
-		void *data)
+static int writeback_use_writepage(struct address_space *mapping,
+		struct writeback_control *wbc)
 {
-	struct address_space *mapping = data;
-	int ret = mapping->a_ops->writepage(&folio->page, wbc);
-	mapping_set_error(mapping, ret);
-	return ret;
+	struct blk_plug plug;
+	struct folio *folio;
+	int err;
+
+	blk_start_plug(&plug);
+	for_each_writeback_folio(mapping, wbc, folio, err) {
+		err = mapping->a_ops->writepage(&folio->page, wbc);
+		mapping_set_error(mapping, err);
+	}
+	blk_finish_plug(&plug);
+
+	return err;
 }
 
 int do_writepages(struct address_space *mapping, struct writeback_control *wbc)
@@ -2581,12 +2589,7 @@ int do_writepages(struct address_space *mapping, struct writeback_control *wbc)
 		if (mapping->a_ops->writepages) {
 			ret = mapping->a_ops->writepages(mapping, wbc);
 		} else if (mapping->a_ops->writepage) {
-			struct blk_plug plug;
-
-			blk_start_plug(&plug);
-			ret = write_cache_pages(mapping, wbc, writepage_cb,
-						mapping);
-			blk_finish_plug(&plug);
+			ret = writeback_use_writepage(mapping, wbc);
 		} else {
 			/* deal with chardevs and other special files */
 			ret = 0;
-- 
2.39.2


