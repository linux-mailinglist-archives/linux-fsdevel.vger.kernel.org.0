Return-Path: <linux-fsdevel+bounces-11646-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40E13855A8F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Feb 2024 07:38:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E8151C27D5E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Feb 2024 06:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02B71171A9;
	Thu, 15 Feb 2024 06:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sXSaoAWJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C049BA38;
	Thu, 15 Feb 2024 06:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707979034; cv=none; b=dyvMA/ahBMfrAkEp07QUNfePWdmEmvcmNNmJLL7s6/LEhBgbsNoPa2cjmwcwYpzh4niZzPDGQsaprxvfP8EKSToRYZ6U8fYbpdMmRx5zJl1nBh5uwOWamwVYbNL8UvVC4n6FUh0f24yZ2LO8MZ5c0tJt8ph0Th3HP5YEauctCPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707979034; c=relaxed/simple;
	bh=0t+BNK//TlQC312uPoVSqk22h8y76t6xsf+wae5fZIk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=k8mFMTe30DrvgFnSjUimPDqsE4ifGcjRZ1CnnPQJFz+n42XgKeZ3XYih2Wj0ub+UAn4jdwK5Nwyn2Oe3mWIq79Fb0S5Ma01NpwZtrhepyJ6MhGqtQjO+msAPK5Grv/XdfASu0qfTEyU4ZO19bbvstAeXEH3wncDv2ppFpjxNFNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=sXSaoAWJ; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=xKyzTXAMH1rh/hkISGxP5mL+5GL5qSZuP787X1EFqpI=; b=sXSaoAWJwPtvCVhZUDGt68K5Xk
	wRIacKs9X39sZS58OFVm/UZYlROkXnmTbM1YNk8+SNUaK8La9ctbfp61ePeYGQ4xOywRTPhzEsn3E
	QOEogTeYSOLM2YlGSXafPgjRrqpYy1/vCrYCup3YcBSmzeXuanP8YMP6anKDq7NQYvmMhiCBYYSEW
	iElzGVrVXeGUPT9hSGDaqvyhUepWjdiOeTnsUIJKQbByIG104tuJblnE1kpbkn/xmZQfmtCnBH2is
	l5/ebDiH2HyDNeJE+MDVA/saWA/vYU1YE6Mrlthjh2h0sKnT5r93af1RB9mp34gRBHhpIREexyz0a
	r1K7JMIg==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1raVMt-0000000F6s3-0QQO;
	Thu, 15 Feb 2024 06:37:11 +0000
From: Christoph Hellwig <hch@lst.de>
To: linux-mm@kvack.org
Cc: Matthew Wilcox <willy@infradead.org>,
	Jan Kara <jack@suse.com>,
	David Howells <dhowells@redhat.com>,
	Brian Foster <bfoster@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jan Kara <jack@suse.cz>,
	Dave Chinner <dchinner@redhat.com>
Subject: [PATCH 05/14] writeback: only update ->writeback_index for range_cyclic writeback
Date: Thu, 15 Feb 2024 07:36:40 +0100
Message-Id: <20240215063649.2164017-6-hch@lst.de>
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

mapping->writeback_index is only [1] used as the starting point for
range_cyclic writeback, so there is no point in updating it for other
types of writeback.

[1] except for btrfs_defrag_file which does really odd things with
mapping->writeback_index.  But btrfs doesn't use write_cache_pages at
all, so this isn't relevant here.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Brian Foster <bfoster@redhat.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Acked-by: Dave Chinner <dchinner@redhat.com>
---
 mm/page-writeback.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index abbee369405a83..f02014007b57cc 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2403,7 +2403,6 @@ int write_cache_pages(struct address_space *mapping,
 	pgoff_t index;
 	pgoff_t end;		/* Inclusive */
 	pgoff_t done_index;
-	int range_whole = 0;
 	xa_mark_t tag;
 
 	folio_batch_init(&fbatch);
@@ -2413,8 +2412,6 @@ int write_cache_pages(struct address_space *mapping,
 	} else {
 		index = wbc->range_start >> PAGE_SHIFT;
 		end = wbc->range_end >> PAGE_SHIFT;
-		if (wbc->range_start == 0 && wbc->range_end == LLONG_MAX)
-			range_whole = 1;
 	}
 	if (wbc->sync_mode == WB_SYNC_ALL || wbc->tagged_writepages) {
 		tag_pages_for_writeback(mapping, index, end);
@@ -2518,14 +2515,21 @@ int write_cache_pages(struct address_space *mapping,
 	}
 
 	/*
-	 * If we hit the last page and there is more work to be done: wrap
-	 * back the index back to the start of the file for the next
-	 * time we are called.
+	 * For range cyclic writeback we need to remember where we stopped so
+	 * that we can continue there next time we are called.  If  we hit the
+	 * last page and there is more work to be done, wrap back to the start
+	 * of the file.
+	 *
+	 * For non-cyclic writeback we always start looking up at the beginning
+	 * of the file if we are called again, which can only happen due to
+	 * -ENOMEM from the file system.
 	 */
-	if (wbc->range_cyclic && !done)
-		done_index = 0;
-	if (wbc->range_cyclic || (range_whole && wbc->nr_to_write > 0))
-		mapping->writeback_index = done_index;
+	if (wbc->range_cyclic) {
+		if (done)
+			mapping->writeback_index = done_index;
+		else
+			mapping->writeback_index = 0;
+	}
 
 	return ret;
 }
-- 
2.39.2


