Return-Path: <linux-fsdevel+bounces-47775-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FA19AA5716
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Apr 2025 23:29:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45C18A00A0F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Apr 2025 21:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F0C72D8DB7;
	Wed, 30 Apr 2025 21:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="srkXYIKL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B802D1116;
	Wed, 30 Apr 2025 21:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746048152; cv=none; b=goqotgAF5ViHzXW3IjXgwBtuKZ0JbfQVVPq2h0fG1mzaWsgEtYjI+mWEDFEAFAjuWPxnuVv8tsEy4tAmqdTEM8Um1x0IYYEncu6h7ZZmA18CW0SgclDpKqikw1tNEh9EorjYTlFGFodUIpdz9aKlWUs1t2/b6UknSn8COKqMJFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746048152; c=relaxed/simple;
	bh=wiIb0dwSxihC2tC0+I4bW6s6w1Jdrr7wjX7VsYNgCCg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UCdxNH+I47es7XrciwGaIxq4WwE60xOJxgwIFrPj+/M6/OssDcQzUspdX1EpmD2/GlCKco4JjkUW8QdjK/uPs59aQoXOkU6V5K0aGVbz2G5KjPRZPU3VazBAvKNyPCjACD5JWtdqeQbybHi1Wza/E4Jix66MDGaag34Y2lTBhUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=srkXYIKL; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=BXRwU4K0o1tFolX8zTbu/pD8mnktNKiqmpCuV5KLDco=; b=srkXYIKLE6gXpqnM5GFYVYMYNW
	0Cbx1bdz23hPnCHM1OAOdB79kp+Nc6IfjWtARYYAkZSOvRL8e0ZIvP5ML6pcvpI9KdAMmgUn9fTKN
	x1yTyQz4iEmmOEPv/1u3ckw0ll/Z6vBouGlXAqArHMlBLJULWIEH4UcuLtku88I1lTSrPOq58Vx+q
	eCwzJwEI7GGd+9r1Ts1QNj8o5CURhduofr/KLSfAIiO+rDcA/b/XFYwd76zkly53uUoY+9wJqDd+K
	y1+yhEhAzb/gJc79vM/Pah3FAopn6H0wRth4it12PTTbqCMKXpJ+IQrfQkJvwm/kF/LjRZ93tmLQm
	BreujAoQ==;
Received: from [206.0.71.65] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uAEsv-0000000E2bq-1sKC;
	Wed, 30 Apr 2025 21:22:29 +0000
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
	slava@dubeyko.com,
	glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com,
	linux-bcache@vger.kernel.org,
	dm-devel@lists.linux.dev,
	linux-btrfs@vger.kernel.org,
	gfs2@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH 10/19] gfs2: use bdev_rw_virt in gfs2_read_super
Date: Wed, 30 Apr 2025 16:21:40 -0500
Message-ID: <20250430212159.2865803-11-hch@lst.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250430212159.2865803-1-hch@lst.de>
References: <20250430212159.2865803-1-hch@lst.de>
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
Reviewed-by: Andreas Gruenbacher <agruenba@redhat.com>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
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


