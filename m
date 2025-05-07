Return-Path: <linux-fsdevel+bounces-48328-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6B40AAD5E6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 May 2025 08:21:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAE2A3B91C8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 May 2025 06:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 049E0202F6D;
	Wed,  7 May 2025 06:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rqb2Fzbp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E26A51DE2DE
	for <linux-fsdevel@vger.kernel.org>; Wed,  7 May 2025 06:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746598890; cv=none; b=IWAflMG6VicUX+D0qv0Sv+hu+1lmDc0rsyit4LrllWh4RuwEhJk6Y0RPgg5yawrDrwQYyY6xHvwpi/HyDkDjVZepa84teqJeAqe4Y38cuEEaTvXujINxTXCUnubZKyn6PwsZwiipfSFiCdwpAXacVIwkQuMVnib+dsXQU/R9JOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746598890; c=relaxed/simple;
	bh=0hZQxzSSSoumFQk+MGhMqe+rIU12+QettwwHhg34OsA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mpmoA+Djs/QcI5abNKPeTkuxBJeF+l2uEcaXPNbK7YF0OHE4nOZ2e/e63hlBBxmIbiV+bgYEkGxw+4Izyh/mKiiv9aEXl+nAgP4zwJf6uUG3J6H9joiDjqhSgG6S6dN7A1UDY286+8bciNAM5gQcndDZ/RROpWaWBLEUQSL8uDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=rqb2Fzbp; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=1jI8xVPEaieICBAQy5mFs8K4/rLYqxIx0o7gMz9fF5o=; b=rqb2Fzbp3guv9ytwkMXP8pwY1n
	9BQbAJi4KZiCkzTkdsm5CRbtBTEzJG64gNB5ymfh8Dd3RYKOAz+HI3mlc2+/+XR70dYPTzTmbq9AE
	pEY0TnaxSl0l+PYTZMFPFgz8IXDJ7/bf00U1oQ0iuSfKUjfPt3fXK3CMmZqqMVLZG7wWpkkGJ1T3k
	Wstll5oKLtt2dCz/LHUPWP/Dqy2MR0TemL3wrz2QeFz5oUQMn/mAAm0eX5E/LgolRETDLYidM6Vk+
	zkvTKnlRP9bcnWDjcZydnfKxMosHYKKNBlJ+lgW5zdyBMbftjfrhdf2CP3atWaWt9TTlYeq1uxICz
	TKqcnDtw==;
Received: from 2a02-8389-2341-5b80-3ba7-83fe-7065-4f0b.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:3ba7:83fe:7065:4f0b] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCY9n-0000000EM92-2jaw;
	Wed, 07 May 2025 06:21:28 +0000
From: Christoph Hellwig <hch@lst.de>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org
Cc: jack@suse.cz,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH] fs: use writeback_iter directly in mpage_writepages
Date: Wed,  7 May 2025 08:21:24 +0200
Message-ID: <20250507062124.3933305-1-hch@lst.de>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Stop using write_cache_pages and use writeback_iter directly.  This
removes an indirect call per written folio and makes the code easier
to follow.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/mpage.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/fs/mpage.c b/fs/mpage.c
index ad7844de87c3..c5fd821fd30e 100644
--- a/fs/mpage.c
+++ b/fs/mpage.c
@@ -445,10 +445,9 @@ static void clean_buffers(struct folio *folio, unsigned first_unmapped)
 		try_to_free_buffers(folio);
 }
 
-static int __mpage_writepage(struct folio *folio, struct writeback_control *wbc,
-		      void *data)
+static int mpage_write_folio(struct writeback_control *wbc, struct folio *folio,
+		struct mpage_data *mpd)
 {
-	struct mpage_data *mpd = data;
 	struct bio *bio = mpd->bio;
 	struct address_space *mapping = folio->mapping;
 	struct inode *inode = mapping->host;
@@ -656,14 +655,16 @@ mpage_writepages(struct address_space *mapping,
 	struct mpage_data mpd = {
 		.get_block	= get_block,
 	};
+	struct folio *folio = NULL;
 	struct blk_plug plug;
-	int ret;
+	int error;
 
 	blk_start_plug(&plug);
-	ret = write_cache_pages(mapping, wbc, __mpage_writepage, &mpd);
+	while ((folio = writeback_iter(mapping, wbc, folio, &error)))
+		error = mpage_write_folio(wbc, folio, &mpd);
 	if (mpd.bio)
 		mpage_bio_submit_write(mpd.bio);
 	blk_finish_plug(&plug);
-	return ret;
+	return error;
 }
 EXPORT_SYMBOL(mpage_writepages);
-- 
2.47.2


