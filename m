Return-Path: <linux-fsdevel+bounces-48368-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0EFDAADE54
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 May 2025 14:08:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72E529A62F3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 May 2025 12:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFBED265CB2;
	Wed,  7 May 2025 12:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="h6i7yW1E"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E964825C6F0;
	Wed,  7 May 2025 12:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746619526; cv=none; b=XXMYe0n9C+BxgIY4jCGoPvY7Zqj8LZ6RSH4eLvCP6flPyIAoyzFfgo9R4GRQEcJSSWRgKiVheMXUszgx0mUJ2NpJpZKMokox0cFoSMIISbF473WiOQj+3bjQbNi0hjoBGNr1HEnuii7k5S4zzA2l9lyGSsQwTJOO7RmuMIO74n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746619526; c=relaxed/simple;
	bh=wiIb0dwSxihC2tC0+I4bW6s6w1Jdrr7wjX7VsYNgCCg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Oe2j2854ATY4twqcwitiemSpPllJYMM8W1xlRgeWsJ+Zn9fVAFn0SEm2cIbUuqHwKBD4GUpSvuQ3+AeV1o+l05w9iHXVNieMzn284v44IDnKIOtLk0X8jg7PCpW1/6plxZO7eKoKd0eE6bjIWXYrGxpeNufk5uiXAn+AXJaTa4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=h6i7yW1E; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=BXRwU4K0o1tFolX8zTbu/pD8mnktNKiqmpCuV5KLDco=; b=h6i7yW1EgJRDa7avDr+kGwHBrI
	TKTtXrMqfEu5/TermNB9JKuWPEl+C4YqCCiFSxEzmsudNw8gF1aYmeoVp7ZcVE9mV2OK7trtvNpwW
	xvEyCICSWZzgUX81x3hjWP+0ZlLHCVTzRjPCyJjkon6xuIT5ojpxsi1HV8eSzObhkGxaZfdIO8QBo
	UtU+Q3AgKBIQ472M4N/yoby3GKsVwmC9U8AHHbeBuWKcP//cakSoW/o5dxeLQhbit1a48Bw8ZVpTh
	/vdAnnXZkKS/wtcpTC8L1mzCTQqiHuR+Jrcb+bhvHcKR3R8WjFKcdBZd+1pDWXwi4THlVJ4Lx40HE
	BSyxwCoA==;
Received: from [2001:4bb8:2cc:5a47:1fe7:c9d0:5f76:7c02] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCdWe-0000000FJB9-0nQ5;
	Wed, 07 May 2025 12:05:24 +0000
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
Date: Wed,  7 May 2025 14:04:34 +0200
Message-ID: <20250507120451.4000627-11-hch@lst.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250507120451.4000627-1-hch@lst.de>
References: <20250507120451.4000627-1-hch@lst.de>
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


