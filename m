Return-Path: <linux-fsdevel+bounces-46970-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4402EA96EC6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 16:32:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 128B0179F57
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 14:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B9B7290098;
	Tue, 22 Apr 2025 14:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eETaKMtV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5775B28A40A;
	Tue, 22 Apr 2025 14:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745332045; cv=none; b=ZhhpgQoZvxMISqYVNOhFxEpVQbqwI2HnA2SivJxwbUAESwdl6v+r5kuYLcMgxpXChdmsmFyVWJqz6P7+LBoAw/BVF0vOGWWSvIQW2XKy9Y6Y8UTmQrQ1s/Oa4CBh0alz3HPO/sUmdKCwDMvq248Wy3uTFqu75hIF0tqybBLtrB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745332045; c=relaxed/simple;
	bh=wJTE0dvydwK+dt3pDY6cCapdVq5mRPLE9upeo2Sx+Z8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R7vd6xDNXzn+Qua1GG3bcLZkFm1pJHUNAMzPbjoxHr/5k6eFRLT4zBuUrsf68XD0kI/b6+02ReD/UxMIoo8t2qT8GoJ/JcaL+RIbUE23kOZjfKTSY81+/ASASVWRaLGF1wVwadh8TiHv1CxTX2X7m5Vk+60I71FU7RBGq+LlWRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=eETaKMtV; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=Y1C4dOQmznXbJ7Tku+Q5IYCQeCnqhEguyGAl6ItLHxY=; b=eETaKMtVabErxWMo18kjJkoT9X
	x4kf523/Et++pWnQKZGNM26ya6g3KNIF/cy7izjD4R6nuNMv8RYlOcrwZr1bHEVdUI6a/8uUUEKMR
	O7105g82WH+TEikb0RTWjLOl0HGJwrYKNcsbSwt9igBIFEOpOgqdkwOvD/2j6dofU+CvyaY+u0ctt
	K3yIr597tCGqnZsg0f2nz8zxCngmpZUCRDXlk6zU3tdpSYJZur7x2WehIqwhR3fOrXbDI/7k4bzb2
	QjwIhD/MfpU3BrL4Yj+/wUOedOjRFWef7S8b4aCU5RWz00L8RkMeTFuhAdsYjnetci7ZcnKoLnStO
	fEMxjwnw==;
Received: from [2001:4bb8:2fc:38c3:78fb:84a5:c78c:68b6] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7Eap-00000007UQb-0vIA;
	Tue, 22 Apr 2025 14:27:23 +0000
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
Subject: [PATCH 13/17] btrfs: use bdev_rw_virt in scrub_one_super
Date: Tue, 22 Apr 2025 16:26:14 +0200
Message-ID: <20250422142628.1553523-14-hch@lst.de>
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

Replace the code building a bio from a kernel direct map address and
submitting it synchronously with the bdev_rw_virt helper.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/scrub.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 2c5edcee9450..7bdb2bc0a212 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -2770,17 +2770,11 @@ static int scrub_one_super(struct scrub_ctx *sctx, struct btrfs_device *dev,
 			   struct page *page, u64 physical, u64 generation)
 {
 	struct btrfs_fs_info *fs_info = sctx->fs_info;
-	struct bio_vec bvec;
-	struct bio bio;
 	struct btrfs_super_block *sb = page_address(page);
 	int ret;
 
-	bio_init(&bio, dev->bdev, &bvec, 1, REQ_OP_READ);
-	bio.bi_iter.bi_sector = physical >> SECTOR_SHIFT;
-	__bio_add_page(&bio, page, BTRFS_SUPER_INFO_SIZE, 0);
-	ret = submit_bio_wait(&bio);
-	bio_uninit(&bio);
-
+	ret = bdev_rw_virt(dev->bdev, physical >> SECTOR_SHIFT, sb,
+			BTRFS_SUPER_INFO_SIZE, REQ_OP_READ);
 	if (ret < 0)
 		return ret;
 	ret = btrfs_check_super_csum(fs_info, sb);
-- 
2.47.2


