Return-Path: <linux-fsdevel+bounces-46966-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 77CE9A96E90
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 16:29:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B6E97A8976
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 14:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ECB228F931;
	Tue, 22 Apr 2025 14:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="1oMF2C3I"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 985DE28A3F3;
	Tue, 22 Apr 2025 14:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745332030; cv=none; b=C+aSB0sh61QNqKw+Z/WcagLpyhqAr57cpXoG5BpvhVJsSkO4PHgU0Argb26ypJK5RgyD+7SgCFIae9w0WgfbESiuNXhdfp/40Sx2FtEaaSHIIltjZcjnWoq5aVpgPQoByAd80ZlBfcmMmRXrewbdUfgJVnzSWMJ+Uhho6W1mlmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745332030; c=relaxed/simple;
	bh=1qtKYH8yWYgkaHZu3mUrnOn76jZ95r2n/ei2sSEgV5M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MzkYozNaR5SbEkjQVImzywO/1zxdlc6ju6kDeMjVRjzvEaUao1fW3j1Xi6omQIr2f32m+mO5J0qVs8CSVpYOhvCrtsyJohft2rwEp/h2tJcwyVtnmNx0kR27MR369cNhEVJIL7pewBnBaHX6/IRR+ubknKN3Xo3MZcP5N2LrvuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=1oMF2C3I; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=PdhhC+cfUNt6h1a3IsqdqdgP0IU8q0/HicqZTt9PvIw=; b=1oMF2C3IG+MOL7PJ2SroQGRcni
	BLBaPP+cY+bq9PvKGkFHQYvu1CBftHZTipPBFXNgjiL4Xfa+jPMlH5udaCVSkZd1tvGZEaEqsOFdg
	v6vv3EQ6Ig336Z5lyIaKiE35iswloBNds8r/wLRM2wOYCHCg8KWFBz8sjcMpZMAqwwWe2br+K5FQQ
	I1FKvGjjriiqoAi4dK9NAlJ9NwPOXDJxZmA2fCu3hi1ivYTrsjX0E6J4zQZdFWJ11uBgUdrgTYT6y
	PNwyW3qIlMONp/lttqr3evG7YjY/p8I0rR9MLEpVy6RJgtAFbN/rzNRmk3Iufkdj2eTHd5j/TPOLA
	/PA6Jz3A==;
Received: from [2001:4bb8:2fc:38c3:78fb:84a5:c78c:68b6] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7EaZ-00000007ULT-1N3Z;
	Tue, 22 Apr 2025 14:27:08 +0000
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
Subject: [PATCH 09/17] dm-integrity: use bio_add_virt_nofail
Date: Tue, 22 Apr 2025 16:26:10 +0200
Message-ID: <20250422142628.1553523-10-hch@lst.de>
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

Convert the __bio_add_page(..., virt_to_page(), ...) pattern to the
bio_add_virt_nofail helper implementing it, and do the same for the
similar pattern using bio_add_page for adding the first segment after
a bio allocation as that can't fail either.

Signed-off-by: Christoph Hellwig <hch@lst.de>
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


