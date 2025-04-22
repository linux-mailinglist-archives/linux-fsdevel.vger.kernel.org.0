Return-Path: <linux-fsdevel+bounces-46972-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18ACFA96EC8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 16:32:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B89A40198E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 14:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B6BE290BC4;
	Tue, 22 Apr 2025 14:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="boRDBZtU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BBF828C5BA;
	Tue, 22 Apr 2025 14:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745332053; cv=none; b=Hiy0FKPyhbp2fH6Pr6lTpiJGee3+8xjAjGxaD/wvWLp63XPZkaQl+45i69jPlwtV6Rp+qL275NCQ2jvGBUStAQSaUwSKP9T/aN5I0s8bpi0ucLz9gijFD6PhW4AmvSd+3krE7otkYbP2Je9jf8CX4croCXIHxijcQza+5V9LDsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745332053; c=relaxed/simple;
	bh=96vZ/qJKDfO8QbvIuzhStZg/PaVrX1+P2eR4XXNYLJI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cb380CgtTACaSpxUd+X+zzL/Cm+7fd2dzGRHyL6m2UTPY2TVD2nQMyTm64LBKlfStNdon4JRU+7o5yrzjzub8LavBC6o5aphtdMS2gaTVbfyRKkbt3vD7bhLORheReJ/A77tpG/KXnK7peb0h/FCUvA4eZIN7YNT8hQToNS2DOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=boRDBZtU; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=WeVdH/1xXzoRtRtWj7TsatzTh+wgtOGv3T025DMUZX8=; b=boRDBZtUXJZECT+HnlpmWLDV+G
	wq4AamgmDXTUPLxqwNccl0kZ71b6H6t4H2kx17Z/fDZmdV7vBiuiB7m7qnKy9uI5MZV5ydUsTEUts
	IF9eBrs5bKLYoRddiCfe+/KZSBOGWHuiD5codXintNTors7zo5XcxQplcMJq/OEJ/NcAIdzj5qjQC
	uGWcVZ9HNs5CSgs9fdi4Xx1a8xa63NYUQb7ANiOi3rZUIntmW7KSj+BRbXvaI6rlgh4BRHXG0zwPN
	ykQOKSghzCmXqvnVAbhbCHv3r0E4ChYVMDp5GdPieGeeAvuR8U5SokGaXjWGkuxZQzXs/wJWbn+UN
	cnyt/CUQ==;
Received: from [2001:4bb8:2fc:38c3:78fb:84a5:c78c:68b6] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7Eax-00000007USM-0PXW;
	Tue, 22 Apr 2025 14:27:31 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	"Md. Haris Iqbal" <haris.iqbal@ionos.com>,
	Jack Wang <jinpu.wang@ionos.com>,
	Coly Li <colyli@kernel.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	Andreas Gruenbacher <agruenba@redhat.com>,
	Carlos Maiolino <cem@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	Johannes Thumshirn <jth@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	linux-bcache@vger.kernel.org,
	dm-devel@lists.linux.dev,
	linux-btrfs@vger.kernel.org,
	gfs2@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH 15/17] gfs2: use bdev_rw_virt in gfs2_read_super
Date: Tue, 22 Apr 2025 16:26:16 +0200
Message-ID: <20250422142628.1553523-16-hch@lst.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250422142628.1553523-1-hch@lst.de>
References: <20250422142628.1553523-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Switch gfs2_read_super to allocate the superblock buffer using kmalloc
which falls back to the page allocator for PAGE_SIZE allocation but
gives us a kernel virtual address and then use bdev_rw_virt to perform
the synchronous read into it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/gfs2/ops_fstype.c | 24 +++++++++---------------
 1 file changed, 9 insertions(+), 15 deletions(-)

diff --git a/fs/gfs2/ops_fstype.c b/fs/gfs2/ops_fstype.c
index e83d293c3614..7c1014ba7ac7 100644
--- a/fs/gfs2/ops_fstype.c
+++ b/fs/gfs2/ops_fstype.c
@@ -226,28 +226,22 @@ static void gfs2_sb_in(struct gfs2_sbd *sdp, const struct gfs2_sb *str)
 
 static int gfs2_read_super(struct gfs2_sbd *sdp, sector_t sector, int silent)
 {
-	struct super_block *sb = sdp->sd_vfs;
-	struct page *page;
-	struct bio_vec bvec;
-	struct bio bio;
+	struct gfs2_sb *sb;
 	int err;
 
-	page = alloc_page(GFP_KERNEL);
-	if (unlikely(!page))
+	sb = kmalloc(PAGE_SIZE, GFP_KERNEL);
+	if (unlikely(!sb))
 		return -ENOMEM;
-
-	bio_init(&bio, sb->s_bdev, &bvec, 1, REQ_OP_READ | REQ_META);
-	bio.bi_iter.bi_sector = sector * (sb->s_blocksize >> 9);
-	__bio_add_page(&bio, page, PAGE_SIZE, 0);
-
-	err = submit_bio_wait(&bio);
+	err = bdev_rw_virt(sdp->sd_vfs->s_bdev,
+			sector * (sdp->sd_vfs->s_blocksize >> 9), sb, PAGE_SIZE,
+			REQ_OP_READ | REQ_META);
 	if (err) {
 		pr_warn("error %d reading superblock\n", err);
-		__free_page(page);
+		kfree(sb);
 		return err;
 	}
-	gfs2_sb_in(sdp, page_address(page));
-	__free_page(page);
+	gfs2_sb_in(sdp, sb);
+	kfree(sb);
 	return gfs2_check_sb(sdp, silent);
 }
 
-- 
2.47.2


