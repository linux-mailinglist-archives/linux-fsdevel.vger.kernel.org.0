Return-Path: <linux-fsdevel+bounces-5115-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 28611808353
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 09:39:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B632EB21BA1
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 08:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42072328CB
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 08:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lA4Os0kf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74B64137;
	Wed,  6 Dec 2023 23:27:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=4AZ8QVVR/u3P7kc1HPNb0EAo5eAavI4T0bksv6UR5ec=; b=lA4Os0kf0iweQmWskFlPHZL65U
	S93sxUQidLzPQh3w7/Dqn3Z6XLZN17E8GYRGbd1ZQaRX3D3RXXJRPGxZ6oEugErFPiLML39LjTCTn
	DkAJkzzjxuJHtOLWFYx8h9xxLGXPS8pcDdRmumX84k+nJ1vKqxATRyCD9aUxUaCZAl8oi6zOp4B/H
	NCfghijGZFZCrVagRPFGtk7NzRq744C+MvfLdzivNR3P1lvUkOzDcGehdM9goCjcP4lh8QVqYBNDU
	fduNTIUcSZC/uLJqVLK/CworSUiAj8lSNRVJWS1SrKPh8z2iMDaDoGnKlMhop8DHRJ5UOpQko3kvy
	jBG4PIVA==;
Received: from [2001:4bb8:191:e7ca:4bf6:cea4:9bbf:8b02] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rB8nB-00C4zA-2c;
	Thu, 07 Dec 2023 07:27:30 +0000
From: Christoph Hellwig <hch@lst.de>
To: Christian Brauner <brauner@kernel.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Chandan Babu R <chandan.babu@oracle.com>,
	Zhang Yi <yi.zhang@huaweicloud.com>,
	Ritesh Harjani <ritesh.list@gmail.com>,
	Jens Axboe <axboe@kernel.dk>,
	Andreas Gruenbacher <agruenba@redhat.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	Johannes Thumshirn <jth@kernel.org>,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org,
	gfs2@lists.linux.dev
Subject: [PATCH 05/14] iomap: factor out a iomap_writepage_handle_eof helper
Date: Thu,  7 Dec 2023 08:27:01 +0100
Message-Id: <20231207072710.176093-6-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231207072710.176093-1-hch@lst.de>
References: <20231207072710.176093-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Most of iomap_do_writepage is dedidcated to handling a folio crossing or
beyond i_size.  Split this is into a separate helper and update the
commens to deal with folios instead of pages and make them more readable.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/iomap/buffered-io.c | 128 ++++++++++++++++++++---------------------
 1 file changed, 62 insertions(+), 66 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index ef99418f5a7a73..c011647239f84e 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1768,6 +1768,64 @@ iomap_add_to_ioend(struct inode *inode, loff_t pos, struct folio *folio,
 	wbc_account_cgroup_owner(wbc, &folio->page, len);
 }
 
+/*
+ * Check interaction of the folio with the file end.
+ *
+ * If the folio is entirely beyond i_size, return false.  If it straddles
+ * i_size, adjust end_pos and zero all data beyond i_size.
+ */
+static bool iomap_writepage_handle_eof(struct folio *folio, struct inode *inode,
+		u64 *end_pos)
+{
+	u64 isize = i_size_read(inode);
+
+	if (*end_pos > isize) {
+		size_t poff = offset_in_folio(folio, isize);
+		pgoff_t end_index = isize >> PAGE_SHIFT;
+
+		/*
+		 * If the folio is entirely ouside of i_size, skip it.
+		 *
+		 * This can happen due to a truncate operation that is in
+		 * progress and in that case truncate will finish it off once
+		 * we've dropped the folio lock.
+		 *
+		 * Note that the pgoff_t used for end_index is an unsigned long.
+		 * If the given offset is greater than 16TB on a 32-bit system,
+		 * then if we checked if the folio is fully outside i_size with
+		 * "if (folio->index >= end_index + 1)", "end_index + 1" would
+		 * overflow and evaluate to 0.  Hence this folio would be
+		 * redirtied and written out repeatedly, which would result in
+		 * an infinite loop; the user program performing this operation
+		 * would hang.  Instead, we can detect this situation by
+		 * checking if the folio is totally beyond i_size or if its
+		 * offset is just equal to the EOF.
+		 */
+		if (folio->index > end_index ||
+		    (folio->index == end_index && poff == 0))
+			return false;
+
+		/*
+		 * The folio straddles i_size.
+		 *
+		 * It must be zeroed out on each and every writepage invocation
+		 * because it may be mmapped:
+		 *
+		 *    A file is mapped in multiples of the page size.  For a
+		 *    file that is not a multiple of the page size, the
+		 *    remaining memory is zeroed when mapped, and writes to that
+		 *    region are not written out to the file.
+		 *
+		 * Also adjust the writeback range to skip all blocks entirely
+		 * beyond i_size.
+		 */
+		folio_zero_segment(folio, poff, folio_size(folio));
+		*end_pos = isize;
+	}
+
+	return true;
+}
+
 /*
  * We implement an immediate ioend submission policy here to avoid needing to
  * chain multiple ioends and hence nest mempool allocations which can violate
@@ -1908,78 +1966,16 @@ static int iomap_do_writepage(struct folio *folio,
 {
 	struct iomap_writepage_ctx *wpc = data;
 	struct inode *inode = folio->mapping->host;
-	u64 end_pos, isize;
+	u64 end_pos = folio_pos(folio) + folio_size(folio);
 
 	trace_iomap_writepage(inode, folio_pos(folio), folio_size(folio));
 
-	/*
-	 * Is this folio beyond the end of the file?
-	 *
-	 * The folio index is less than the end_index, adjust the end_pos
-	 * to the highest offset that this folio should represent.
-	 * -----------------------------------------------------
-	 * |			file mapping	       | <EOF> |
-	 * -----------------------------------------------------
-	 * | Page ... | Page N-2 | Page N-1 |  Page N  |       |
-	 * ^--------------------------------^----------|--------
-	 * |     desired writeback range    |      see else    |
-	 * ---------------------------------^------------------|
-	 */
-	isize = i_size_read(inode);
-	end_pos = folio_pos(folio) + folio_size(folio);
-	if (end_pos > isize) {
-		/*
-		 * Check whether the page to write out is beyond or straddles
-		 * i_size or not.
-		 * -------------------------------------------------------
-		 * |		file mapping		        | <EOF>  |
-		 * -------------------------------------------------------
-		 * | Page ... | Page N-2 | Page N-1 |  Page N   | Beyond |
-		 * ^--------------------------------^-----------|---------
-		 * |				    |      Straddles     |
-		 * ---------------------------------^-----------|--------|
-		 */
-		size_t poff = offset_in_folio(folio, isize);
-		pgoff_t end_index = isize >> PAGE_SHIFT;
-
-		/*
-		 * Skip the page if it's fully outside i_size, e.g.
-		 * due to a truncate operation that's in progress.  We've
-		 * cleaned this page and truncate will finish things off for
-		 * us.
-		 *
-		 * Note that the end_index is unsigned long.  If the given
-		 * offset is greater than 16TB on a 32-bit system then if we
-		 * checked if the page is fully outside i_size with
-		 * "if (page->index >= end_index + 1)", "end_index + 1" would
-		 * overflow and evaluate to 0.  Hence this page would be
-		 * redirtied and written out repeatedly, which would result in
-		 * an infinite loop; the user program performing this operation
-		 * would hang.  Instead, we can detect this situation by
-		 * checking if the page is totally beyond i_size or if its
-		 * offset is just equal to the EOF.
-		 */
-		if (folio->index > end_index ||
-		    (folio->index == end_index && poff == 0))
-			goto unlock;
-
-		/*
-		 * The page straddles i_size.  It must be zeroed out on each
-		 * and every writepage invocation because it may be mmapped.
-		 * "A file is mapped in multiples of the page size.  For a file
-		 * that is not a multiple of the page size, the remaining
-		 * memory is zeroed when mapped, and writes to that region are
-		 * not written out to the file."
-		 */
-		folio_zero_segment(folio, poff, folio_size(folio));
-		end_pos = isize;
+	if (!iomap_writepage_handle_eof(folio, inode, &end_pos)) {
+		folio_unlock(folio);
+		return 0;
 	}
 
 	return iomap_writepage_map(wpc, wbc, inode, folio, end_pos);
-
-unlock:
-	folio_unlock(folio);
-	return 0;
 }
 
 int
-- 
2.39.2


