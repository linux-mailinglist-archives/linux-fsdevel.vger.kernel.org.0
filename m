Return-Path: <linux-fsdevel+bounces-48372-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B397AADE5B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 May 2025 14:08:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFF2E4C7CEA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 May 2025 12:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25936268699;
	Wed,  7 May 2025 12:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="20IMZSz8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CF4F25D8E0;
	Wed,  7 May 2025 12:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746619537; cv=none; b=lA+eYYEL+Yp+iOuq/NIf4zaARRMLYibTBNoNvDJMC9AV69Wcx80BpaaKrjcQM16eMhxwgFuhzjZNsOFj/ttpzDDejdo+LTC5L/q3oV43wpE88Gt7iXJAWR4xIRF3R+RoyxBoJR0o6U+MXTHwyIhOqC4Ue3OXNjnj4jVtUYNuzks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746619537; c=relaxed/simple;
	bh=5lgQUIVKZS1bhkPa0HTRepsAsshhPp5vEHdjwu0aw8o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V8EHZIm/RqBwV8xaaGUgVoreBnRC9LVZLyqqlMh4BkBGxVGp1Ov0yzaQfXj3p5x04FC3Fj4RU4sOZ2WqVEDS23qiSsqQudDgLQ+sQNDTTJQJBEl9PUUu7gchUvz4cWAkygQ5YXAQQJ6v+40d6MCCZqM9F5FrfoiHKBfDWAgCxdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=20IMZSz8; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=VYWlDD7JQZSt/MfnyqWB1425cqWR//FQWc4ibzoCt8Q=; b=20IMZSz8xCAxacXyio6GGtuMr6
	KzGqHatpT4+GC42DGIAywSVgSS8bZEZp/a0ozIfweILi8eWCIArh6wv48z9ZWi4yOmUaruvMEFVd5
	x7iEyqCza6+N4Z5G8TmPc6wPb8FJqiiPznRy1BrM3qNngK1jUTwR23I9WX9vBuQftcZQ1Xb3zQ3M6
	HB9SSS9hQfS/+Rcs9WE6Fk6yuNLGRbD8KybTum5H1d0T+iSydr6A5BHxPqjd4fRFM2ghh7XGED10l
	/nEYc+gOBLMR1Lzp9MOJ8IHtZ0CG32UWBE67Hyk29ogIpY0PB91scaJxPHCL/qC4sNTX6vARuErOt
	JPVKwCmQ==;
Received: from [2001:4bb8:2cc:5a47:1fe7:c9d0:5f76:7c02] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCdWp-0000000FJEe-1k3h;
	Wed, 07 May 2025 12:05:35 +0000
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
Date: Wed,  7 May 2025 14:04:38 +0200
Message-ID: <20250507120451.4000627-15-hch@lst.de>
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

Convert the __bio_add_page(..., virt_to_page(), ...) pattern to the
bio_add_virt_nofail helper implementing it, and do the same for the
similar pattern using bio_add_page for adding the first segment after
a bio allocation as that can't fail either.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Acked-by: Mikulas Patocka <mpatocka@redhat.com>
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


