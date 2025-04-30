Return-Path: <linux-fsdevel+bounces-47779-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26468AA5731
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Apr 2025 23:30:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31741A01EB6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Apr 2025 21:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD3A32D999A;
	Wed, 30 Apr 2025 21:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="g5CNy8co"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A08482D113C;
	Wed, 30 Apr 2025 21:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746048164; cv=none; b=ihK5VbV6n/a/yqqdbB+Y6p8OVi9ZLGHFa1TopK1RvpcrYbnHypgwKW/YPUwbpDyyzai2CCg1YSLJn2DDU1phefu2wIr7b0Hi88NE0VJJYaKOHsJ5g9rZhgXGYq1uh6mFyRA1jakHp2vqGUkLTARkd0WOMJ9Ysa4tn5/8jI4NemM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746048164; c=relaxed/simple;
	bh=FXG+2y5bQ1rQOtKfMSmRnkF0ZijmjwSO0CErR4Kongc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tipWVnzNg2iA/boWhqJgMHw4spD9H17z6gBh5+mPWXVRWe5EenSx/+ILKbs04qPRnCQfl0uPU0IS1czz0Rt4eGpbo54nSPnWRNUiRcdhF0WJsdAAcTNBflc/A0bwF2RyEDrsRnbiFLCNkpEuf7LVQdpJsJrmLKhTJRsU4X2TVbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=g5CNy8co; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=07wgIKRHEvblml6CuFdXwRGvEIls4LekE5NjZesY+Yk=; b=g5CNy8coJBZ8bTwCOzWtK30nz0
	Px2usCKz4eoihxbnGhpSyl07VhAPyg3cA8c65jxwuX/hqgSLXU2a8DfmNYn95zVYnTgoYTIttgAyR
	nwNTyj5Ah/zP6h455700aFDrT2vAOnFWtcX0mta0gVYtdkyTwBgCe+tpealsZDzYQcx+RoI9bP1Kv
	/Yn3GpUnu22AlNZSyPXj+7P/+lNNzHxmksoXCcT9rF8qF6ix0a6zxaE7G9TZdJa/qBsz8Y/jZsTP5
	r8QaYOvI4oCIPUDgqQuRjh5V+4rOnzZAiwcq59RfKZw+FgDz8DdS2GNnBoElzyqYp3oawe/b+qFGe
	GSyQzctg==;
Received: from [206.0.71.65] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uAEt7-0000000E2f9-29r0;
	Wed, 30 Apr 2025 21:22:42 +0000
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
	linux-pm@vger.kernel.org,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 14/19] dm-integrity: use bio_add_virt_nofail
Date: Wed, 30 Apr 2025 16:21:44 -0500
Message-ID: <20250430212159.2865803-15-hch@lst.de>
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

Convert the __bio_add_page(..., virt_to_page(), ...) pattern to the
bio_add_virt_nofail helper implementing it, and do the same for the
similar pattern using bio_add_page for adding the first segment after
a bio allocation as that can't fail either.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 drivers/md/dm-integrity.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/md/dm-integrity.c b/drivers/md/dm-integrity.c
index 2a283feb3319..9dca9dbabfaa 100644
--- a/drivers/md/dm-integrity.c
+++ b/drivers/md/dm-integrity.c
@@ -2557,14 +2557,8 @@ static void dm_integrity_inline_recheck(struct work_struct *w)
 		char *mem;
 
 		outgoing_bio = bio_alloc_bioset(ic->dev->bdev, 1, REQ_OP_READ, GFP_NOIO, &ic->recheck_bios);
-
-		r = bio_add_page(outgoing_bio, virt_to_page(outgoing_data), ic->sectors_per_block << SECTOR_SHIFT, 0);
-		if (unlikely(r != (ic->sectors_per_block << SECTOR_SHIFT))) {
-			bio_put(outgoing_bio);
-			bio->bi_status = BLK_STS_RESOURCE;
-			bio_endio(bio);
-			return;
-		}
+		bio_add_virt_nofail(outgoing_bio, outgoing_data,
+				ic->sectors_per_block << SECTOR_SHIFT);
 
 		bip = bio_integrity_alloc(outgoing_bio, GFP_NOIO, 1);
 		if (IS_ERR(bip)) {
@@ -3211,7 +3205,8 @@ static void integrity_recalc_inline(struct work_struct *w)
 
 	bio = bio_alloc_bioset(ic->dev->bdev, 1, REQ_OP_READ, GFP_NOIO, &ic->recalc_bios);
 	bio->bi_iter.bi_sector = ic->start + SB_SECTORS + range.logical_sector;
-	__bio_add_page(bio, virt_to_page(recalc_buffer), range.n_sectors << SECTOR_SHIFT, offset_in_page(recalc_buffer));
+	bio_add_virt_nofail(bio, recalc_buffer,
+			range.n_sectors << SECTOR_SHIFT);
 	r = submit_bio_wait(bio);
 	bio_put(bio);
 	if (unlikely(r)) {
@@ -3228,7 +3223,8 @@ static void integrity_recalc_inline(struct work_struct *w)
 
 	bio = bio_alloc_bioset(ic->dev->bdev, 1, REQ_OP_WRITE, GFP_NOIO, &ic->recalc_bios);
 	bio->bi_iter.bi_sector = ic->start + SB_SECTORS + range.logical_sector;
-	__bio_add_page(bio, virt_to_page(recalc_buffer), range.n_sectors << SECTOR_SHIFT, offset_in_page(recalc_buffer));
+	bio_add_virt_nofail(bio, recalc_buffer,
+			range.n_sectors << SECTOR_SHIFT);
 
 	bip = bio_integrity_alloc(bio, GFP_NOIO, 1);
 	if (unlikely(IS_ERR(bip))) {
-- 
2.47.2


