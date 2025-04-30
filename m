Return-Path: <linux-fsdevel+bounces-47784-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B6A0CAA575B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Apr 2025 23:32:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A0BD7BEDD0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Apr 2025 21:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D8A32DA830;
	Wed, 30 Apr 2025 21:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hlKeK5R6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E7A32D1126;
	Wed, 30 Apr 2025 21:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746048180; cv=none; b=E8m5/4lOXdQG66R9y5fnc+o0qL1et9hy7warudr5QZxLPiLTQ4MsPAiGfGXs9dsmtCdZO2h4A797FYJGQpLYtR1xitTjXdRhbl+fIwuAwiokOrkVoVHu+JsD2O3M5/TJtOCJKlW1WekU2/npqaarRxudSv8+eOPEluB5GniuZxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746048180; c=relaxed/simple;
	bh=LWH2IeIHBETWvdlPK8EFEn8CgwqV7CCSowakSE/YpAI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qlVBD01XJzvvfugSAsDzDvpOahrwKDeANt+/4i8TC5jiZESOeeRVxAFdAZoNhhEYNiuUytPDaYVxPe+J4gJLiYWBf6d/66n+xZ9et47HU13YUKhb1gxADyrC5cMjZsrKoOcg+7IRtnb0rk8vKTtTF0YKciMJ5aVZGE5c8F9ffOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=hlKeK5R6; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=xUb6OpV1cKOqoxjJg2NB06rtM4y9TqsotfYyIOWBJdg=; b=hlKeK5R6xaQB9XX4joAbRt/N65
	9eyPL7ErrBQbr5/fz/5756ctrAAsSHMr2M5iYII8ppGKBLjVOcYcGUWI7WSTITAnt2zaUeFr/Vz86
	NzKU0l5Nl9fJVNzR3JaSHGxfL0VPOdpQURCLw0t3e/9PX2yLGqSIZstrknTKmaLY4whrcJ2SasH1b
	uAHvL/NHjPDh6o/PWdLZDF/gLZXGy2t42r+DCwh/KQ8BZpPyeIUtZp6KookUZ+r+/6PfDxymSUX2v
	+y+542I2F2PiPXU4Yd6qiU96mMLR1cGIsvG/r+PH2/z/sSYipsHZrTtixgHaHxps3WDpWbdcfUvSH
	lBSsUl5A==;
Received: from [206.0.71.65] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uAEtN-0000000E2kd-49Pf;
	Wed, 30 Apr 2025 21:22:58 +0000
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
Subject: [PATCH 19/19] hfsplus: use bdev_rw_virt in hfsplus_submit_bio
Date: Wed, 30 Apr 2025 16:21:49 -0500
Message-ID: <20250430212159.2865803-20-hch@lst.de>
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

Replace the code building a bio from a kernel direct map address and
submitting it synchronously with the bdev_rw_virt helper.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/hfsplus/wrapper.c | 46 +++++++++-----------------------------------
 1 file changed, 9 insertions(+), 37 deletions(-)

diff --git a/fs/hfsplus/wrapper.c b/fs/hfsplus/wrapper.c
index 74801911bc1c..30cf4fe78b3d 100644
--- a/fs/hfsplus/wrapper.c
+++ b/fs/hfsplus/wrapper.c
@@ -48,47 +48,19 @@ struct hfsplus_wd {
 int hfsplus_submit_bio(struct super_block *sb, sector_t sector,
 		       void *buf, void **data, blk_opf_t opf)
 {
-	const enum req_op op = opf & REQ_OP_MASK;
-	struct bio *bio;
-	int ret = 0;
-	u64 io_size;
-	loff_t start;
-	int offset;
+	u64 io_size = hfsplus_min_io_size(sb);
+	loff_t start = (loff_t)sector << HFSPLUS_SECTOR_SHIFT;
+	int offset = start & (io_size - 1);
+
+	if ((opf & REQ_OP_MASK) != REQ_OP_WRITE && data)
+		*data = (u8 *)buf + offset;
 
 	/*
-	 * Align sector to hardware sector size and find offset. We
-	 * assume that io_size is a power of two, which _should_
-	 * be true.
+	 * Align sector to hardware sector size and find offset. We assume that
+	 * io_size is a power of two, which _should_ be true.
 	 */
-	io_size = hfsplus_min_io_size(sb);
-	start = (loff_t)sector << HFSPLUS_SECTOR_SHIFT;
-	offset = start & (io_size - 1);
 	sector &= ~((io_size >> HFSPLUS_SECTOR_SHIFT) - 1);
-
-	bio = bio_alloc(sb->s_bdev, 1, opf, GFP_NOIO);
-	bio->bi_iter.bi_sector = sector;
-
-	if (op != REQ_OP_WRITE && data)
-		*data = (u8 *)buf + offset;
-
-	while (io_size > 0) {
-		unsigned int page_offset = offset_in_page(buf);
-		unsigned int len = min_t(unsigned int, PAGE_SIZE - page_offset,
-					 io_size);
-
-		ret = bio_add_page(bio, virt_to_page(buf), len, page_offset);
-		if (ret != len) {
-			ret = -EIO;
-			goto out;
-		}
-		io_size -= len;
-		buf = (u8 *)buf + len;
-	}
-
-	ret = submit_bio_wait(bio);
-out:
-	bio_put(bio);
-	return ret < 0 ? ret : 0;
+	return bdev_rw_virt(sb->s_bdev, sector, buf, io_size, opf);
 }
 
 static int hfsplus_read_mdb(void *bufptr, struct hfsplus_wd *wd)
-- 
2.47.2


