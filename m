Return-Path: <linux-fsdevel+bounces-46971-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27F8EA96ED0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 16:32:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1FC6440170
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 14:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B07A2900BF;
	Tue, 22 Apr 2025 14:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LYFoyvyQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3415D28A40A;
	Tue, 22 Apr 2025 14:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745332049; cv=none; b=fgKJR0JphzvRqgqXta1uzu6ExAbF4IWydiK9sG0Uf4gnLcGxr+RaEmmIK05D0nxQixzj4L53KGPJzhzdjTOssqrgnreKLukO71IJ1a3T+2pfge0GDymJjGLvX0yfwY81DQ5G0tEdi1ZYfUF5gybLTDsJKWnTvhNgY1jnchloe1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745332049; c=relaxed/simple;
	bh=3XYQqfZvhErzfZzOh5HvglXNvV5jd8MLlcZoSN9kmmM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AGM/6e7QDErUENmFC9DWYxXWpIJNe8qYWYaCZZnAzU5g04d1EGx9aNV8R7wPMl5b1CBNLtLdTHBEw6uQ2DSQ24/TJGFN766exVx7RJyqerxHaNWF9J68vtVYBl6bjOaVAi0K5nPLeLJFA6/hZ7aAzdERVepGINO5ThhHgaWpXHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=LYFoyvyQ; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=pb+eVhlltJ61uzBTPYrGgipQTGBXlGezi4syMnMm/S0=; b=LYFoyvyQY4buoEt3znIW0n2b2t
	1BuomrZFwixB+fnCIdr57BThTuUvtnFL69EFjPJkVSgPT8BGL89rkcuLN/MKGRijy9yIe55u0AE2/
	OGIP5H3J1zZY8JJvXs6e5ULpK5y90ZTALh0/gH1JOR7abd33n6VfyaA/tTAjIxvqymJNbgEwvammj
	KouvySPZhviLAVOjxPnsy/9j3Chx9LWVN0lhWDKmBjCEqClIKWxak9k4b8InAIf5nX8X5MXoXaAFF
	ylEPPORPXzvIv0qPIcbYFA40IHVnYsb+ubyxVo8DHCmUlXESbfHEfkk/oHxiaQtXnTxEivnr7JdKG
	u2IDsfag==;
Received: from [2001:4bb8:2fc:38c3:78fb:84a5:c78c:68b6] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7Eat-00000007UR5-05WX;
	Tue, 22 Apr 2025 14:27:27 +0000
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
Subject: [PATCH 14/17] hfsplus: use bdev_rw_virt in hfsplus_submit_bio
Date: Tue, 22 Apr 2025 16:26:15 +0200
Message-ID: <20250422142628.1553523-15-hch@lst.de>
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


