Return-Path: <linux-fsdevel+bounces-11655-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 223AE855AA1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Feb 2024 07:40:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9FA21F2D712
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Feb 2024 06:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3775111BD;
	Thu, 15 Feb 2024 06:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UwOda/+U"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A041BC43;
	Thu, 15 Feb 2024 06:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707979058; cv=none; b=Qo2HzhyxJjS/C2PBrKgqm9UY6Rqo0+70GUS7KcE850viLYnHijwyJtrjNWm2QFjldAqthyy+S5/D2mtNd2KYWCyLQET2GcAnAn5glUCm+xdz77r4b8xuK+AN623GKO3k3IiLOERMsHZdb9xf4Z88nAO3dnKPWj6K6nHZmo/7zag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707979058; c=relaxed/simple;
	bh=Res0BRtB7D7IhwdD11hr1SLaLO8wh9o+5oCaykenzqg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dMVwyEMNU8Y0eV54dfvjUaghWfS8StsU8TgohaviLuXeFCPh2CdfkJ2CMTUkWNt7zrKnHrgcMb43h7sCfa434zL5T8QOveoAd8tyCej8in4jwLe/tzU3CQiMQ8jjrEISwbGe+uYype52DSxnqU0HncmnrTxGPSK+JaKQutmnJoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=UwOda/+U; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=qyeWxkzxkEHhHoHK3zWehsRuRg4lFsIMJWfUKexFKxM=; b=UwOda/+UIz7ZD9dTkjlRkVaWv8
	BWyV6iZujMnIJ6XzWpZUfU3pVZyrYpLVeDr2j1dT98vNxZwx+F68FuPWm1GYmmmafxg61VsF198h/
	GbkpZ13apJgwrnyEzYelBVG/igddDpAHlkj8APo9yuiXnMkPfZ4maR/X4PE/jgT7bYI9d0aHNkN1B
	le6OpSRgWaeiaw8k3kzD6BlSuMVrfYjljZybQw88yGpIKXWXFTXNn6SbT5mdJXYoQuM4c9Gz76mIz
	zCqOzR+cEcZviPmZHWqEiM4Tp4RyhRbUK5E4Mm+ZI9VFSwjiHnW/eV/Refh3ZBgN7CVpr5CHh989H
	wQBZ/r6g==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1raVND-0000000F74L-3wZ0;
	Thu, 15 Feb 2024 06:37:32 +0000
From: Christoph Hellwig <hch@lst.de>
To: linux-mm@kvack.org
Cc: Matthew Wilcox <willy@infradead.org>,
	Jan Kara <jack@suse.com>,
	David Howells <dhowells@redhat.com>,
	Brian Foster <bfoster@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 14/14] writeback: Remove a use of write_cache_pages() from do_writepages()
Date: Thu, 15 Feb 2024 07:36:49 +0100
Message-Id: <20240215063649.2164017-15-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240215063649.2164017-1-hch@lst.de>
References: <20240215063649.2164017-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

Use the new writeback_iter() directly instead of indirecting
through a callback.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
[hch: ported to the while based iter style]
Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Brian Foster <bfoster@redhat.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 mm/page-writeback.c | 31 ++++++++++++++++++-------------
 1 file changed, 18 insertions(+), 13 deletions(-)

diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 3da4345f08a335..3e19b87049db17 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2577,15 +2577,25 @@ int write_cache_pages(struct address_space *mapping,
 }
 EXPORT_SYMBOL(write_cache_pages);
 
-static int writepage_cb(struct folio *folio, struct writeback_control *wbc,
-		void *data)
+static int writeback_use_writepage(struct address_space *mapping,
+		struct writeback_control *wbc)
 {
-	struct address_space *mapping = data;
-	int ret = mapping->a_ops->writepage(&folio->page, wbc);
+	struct folio *folio = NULL;
+	struct blk_plug plug;
+	int err;
 
-	if (ret < 0)
-		mapping_set_error(mapping, ret);
-	return ret;
+	blk_start_plug(&plug);
+	while ((folio = writeback_iter(mapping, wbc, folio, &err))) {
+		err = mapping->a_ops->writepage(&folio->page, wbc);
+		if (err == AOP_WRITEPAGE_ACTIVATE) {
+			folio_unlock(folio);
+			err = 0;
+		}
+		mapping_set_error(mapping, err);
+	}
+	blk_finish_plug(&plug);
+
+	return err;
 }
 
 int do_writepages(struct address_space *mapping, struct writeback_control *wbc)
@@ -2601,12 +2611,7 @@ int do_writepages(struct address_space *mapping, struct writeback_control *wbc)
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


