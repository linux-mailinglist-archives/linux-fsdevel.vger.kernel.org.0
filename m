Return-Path: <linux-fsdevel+bounces-16061-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1C5A89773D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 19:48:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C55A28E937
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 17:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7332315688D;
	Wed,  3 Apr 2024 17:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lnRKjm1r"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB99152175;
	Wed,  3 Apr 2024 17:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712165059; cv=none; b=flpH2jzR0oic9Ki8XW3PQR/Uzukc63MF4vjJlu+lF/LnAdcmzoQaqrfy7Iuyzw61tzBjzIOozoKHQyB+acT2Wdx86BqiIgxDeeLteE+3lj/73HI1DhMpt3uEJMGY9906l8Q4nj8NL8+2kP+Xan+TZcDlc4lRSlrDjNthnwXrUg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712165059; c=relaxed/simple;
	bh=2orlmU3+ddfZAx8MxU/h/dDPtWin+PllLR1kRvdFdF4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vn0+CjYdyGe35UqsVbNUUsiubFeKVTrppFptcZ9VTNyd0VlFhiLB43kkJKh6tX0H3Atcn0IoR2aXDJwvPOjt7IA32vV4TiGEiG+xKb8Cbn1M2mVffISgDNISyf5Xvu1utBrD5EvOns20gqkeyxcPu0q5JBQnLOpcdkFUBIrzUw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=lnRKjm1r; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=8F4T2283ehKXbosjyapVzSIDjXmVUuBE7uMEC2QD6mI=; b=lnRKjm1rnYPHl+KuzlczISLgLf
	ufclFtmCJA3gjmQ7BPMedt+YHuEA7irzgpl1Vdo/zDma73UTcidoQ5sP8dn4zXm1u9o8TRgaU498k
	EJPjFog0fTFY4DGMJXcNXRuGVDusQcV4m5kmbzE8GRhWnhxmzS8F150oAl6Y/7Jhi9f3c7fgmQDFg
	PuM0+0DiK64LI9HRXNtfGRWGsm1lqiZjWARpJmvp/Hy5PJiQ8QOvnqJd18TjsCTQ0FX4rEvdPc6Dk
	lBZ9cJRfngGwE6U6S0bt6e1NEmT0eX9kKkMTzIdW7e6wCLVYWL+ltoEesIGJoDd/u+WWJ2nEjAdcI
	xBiMBu3g==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rs4LE-0000000651h-2Ud3;
	Wed, 03 Apr 2024 17:24:04 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: linux-fsdevel@vger.kernel.org,
	Andreas Gruenbacher <agruenba@redhat.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	gfs2@lists.linux.dev
Subject: [PATCH 3/4] gfs2: Simplify gfs2_read_super
Date: Wed,  3 Apr 2024 18:23:50 +0100
Message-ID: <20240403172400.1449213-4-willy@infradead.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240403172400.1449213-1-willy@infradead.org>
References: <20240403172400.1449213-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use submit_bio_wait() instead of hand-rolling our own synchronous
wait.  Also allocate the BIO on the stack since we're not deep in
the call stack at this point.

There's no need to kmap the page, since it isn't allocated from HIGHMEM.
Turn the GFP_NOFS allocation into GFP_KERNEL; if the page allocator
enters reclaim, we cannot be called as the filesystem has not yet been
initialised and so has no pages to reclaim.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/gfs2/ops_fstype.c | 46 +++++++++++++-------------------------------
 1 file changed, 13 insertions(+), 33 deletions(-)

diff --git a/fs/gfs2/ops_fstype.c b/fs/gfs2/ops_fstype.c
index 572d58e86296..f98651229c8f 100644
--- a/fs/gfs2/ops_fstype.c
+++ b/fs/gfs2/ops_fstype.c
@@ -184,22 +184,10 @@ static int gfs2_check_sb(struct gfs2_sbd *sdp, int silent)
 	return 0;
 }
 
-static void end_bio_io_page(struct bio *bio)
-{
-	struct page *page = bio->bi_private;
-
-	if (!bio->bi_status)
-		SetPageUptodate(page);
-	else
-		pr_warn("error %d reading superblock\n", bio->bi_status);
-	unlock_page(page);
-}
-
-static void gfs2_sb_in(struct gfs2_sbd *sdp, const void *buf)
+static void gfs2_sb_in(struct gfs2_sbd *sdp, const struct gfs2_sb *str)
 {
 	struct gfs2_sb_host *sb = &sdp->sd_sb;
 	struct super_block *s = sdp->sd_vfs;
-	const struct gfs2_sb *str = buf;
 
 	sb->sb_magic = be32_to_cpu(str->sb_header.mh_magic);
 	sb->sb_type = be32_to_cpu(str->sb_header.mh_type);
@@ -239,34 +227,26 @@ static void gfs2_sb_in(struct gfs2_sbd *sdp, const void *buf)
 static int gfs2_read_super(struct gfs2_sbd *sdp, sector_t sector, int silent)
 {
 	struct super_block *sb = sdp->sd_vfs;
-	struct gfs2_sb *p;
 	struct page *page;
-	struct bio *bio;
+	struct bio_vec bvec;
+	struct bio bio;
+	int err;
 
-	page = alloc_page(GFP_NOFS);
+	page = alloc_page(GFP_KERNEL);
 	if (unlikely(!page))
 		return -ENOMEM;
 
-	ClearPageUptodate(page);
-	ClearPageDirty(page);
-	lock_page(page);
-
-	bio = bio_alloc(sb->s_bdev, 1, REQ_OP_READ | REQ_META, GFP_NOFS);
-	bio->bi_iter.bi_sector = sector * (sb->s_blocksize >> 9);
-	__bio_add_page(bio, page, PAGE_SIZE, 0);
+	bio_init(&bio, sb->s_bdev, &bvec, 1, REQ_OP_READ | REQ_META);
+	bio.bi_iter.bi_sector = sector * (sb->s_blocksize >> 9);
+	__bio_add_page(&bio, page, PAGE_SIZE, 0);
 
-	bio->bi_end_io = end_bio_io_page;
-	bio->bi_private = page;
-	submit_bio(bio);
-	wait_on_page_locked(page);
-	bio_put(bio);
-	if (!PageUptodate(page)) {
+	err = submit_bio_wait(&bio);
+	if (err) {
+		pr_warn("error %d reading superblock\n", err);
 		__free_page(page);
-		return -EIO;
+		return err;
 	}
-	p = kmap(page);
-	gfs2_sb_in(sdp, p);
-	kunmap(page);
+	gfs2_sb_in(sdp, page_address(page));
 	__free_page(page);
 	return gfs2_check_sb(sdp, silent);
 }
-- 
2.43.0


