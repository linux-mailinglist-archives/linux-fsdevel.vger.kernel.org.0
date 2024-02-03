Return-Path: <linux-fsdevel+bounces-10128-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 12D6984843A
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Feb 2024 08:13:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 452F31C2447A
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Feb 2024 07:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 642204F8A5;
	Sat,  3 Feb 2024 07:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QH+FHNxv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D75F4F891;
	Sat,  3 Feb 2024 07:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706944343; cv=none; b=puDXNA3+xV8ZvPYj4orvSYi42v9fTSq4+vHBGocaYgXsfZYAQwDMNCWufmmwkehBYtZt3W1ih9IvC642hu44dTg32b9k+508lGFbUIPnF13017cuHzSCJ/2esn07dCLinX/OWgz2UyvrVPFWQKzxXgvncrJ4K4cLwY0DGaX2JNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706944343; c=relaxed/simple;
	bh=d7uAWRyCrrlyj0Ej5Or/Ih/519cz8DKV1v+etTcSbsg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lvIuULEv79ULms6iagWoZD6YS+K4ca8FBEl20XBsVy3/V5kCLcDCnkfZZIN1nqBh6Wo5qd0HJT4MRtk2fOmqLa5Lj2o9hGgfOF0BXP9Usf3SnKxr6f6SoO8X2pB27d5C5dO9pRn1BiAlVIFFDqQFhTshfak4kzivCgDVUdRZ0z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=QH+FHNxv; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=GhmEmGUPN5iqiwr7bHV2cU1PJLEobcTODedxESHF4Gc=; b=QH+FHNxvkAB6h4KM2iyT9Hyvsg
	AfE8Wt9IRK/c15fUAWzpoE0OtkarSrAESliln8xwuU91uqBJnw3VO1ZVOQoYwX84FrKLJob4M3jMF
	oRjd2HOh1Yp7g+s/i/D020aM/XNuc5Ou1E5OqSB+BoPXYnmXsysVl04sBQn+hyb0r/W9HefFlUQas
	cX5zi8ABK7rKKEQCa4O6ZDOWajvyMxkBX+pdPcVSoLre58AnwYKNwkfkYrngCfhD9mRSaR7RQeW3j
	+ZFwoC5ArTW4txv7BDS1lqNVD7QtwiapVkQzDgkl/LFVurH1ZDwJQeCF5Z4DWpsunH5mT9eRUoK2y
	SAl/WSOA==;
Received: from [89.144.222.32] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rWACJ-0000000Fk2d-1AV7;
	Sat, 03 Feb 2024 07:12:20 +0000
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
Subject: [PATCH 04/13] writeback: only update ->writeback_index for range_cyclic writeback
Date: Sat,  3 Feb 2024 08:11:38 +0100
Message-Id: <20240203071147.862076-5-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240203071147.862076-1-hch@lst.de>
References: <20240203071147.862076-1-hch@lst.de>
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
index ee9eb347890cd3..c7c494526bc650 100644
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


