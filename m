Return-Path: <linux-fsdevel+bounces-48377-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D2B43AADEA3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 May 2025 14:12:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 040FC1C42493
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 May 2025 12:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C42F326B2AF;
	Wed,  7 May 2025 12:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Md+lDeR4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 825F525DD1A;
	Wed,  7 May 2025 12:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746619561; cv=none; b=MK76PSwBWgTPgCEvexzupELUjdCl1ueNnBV+Kt2n6PYVE9pe9Q2s+NFvWNavm5nWtoDfVA+sCZQPq2vsDvbEBjlJZOiYr+eW4mXSpj8SQMW0RhhPWHBHJ+vZ9DwlAxu+Li50+L97zR1BP1kQaZqHOmDZgch5WE1AMiiiTiTTMsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746619561; c=relaxed/simple;
	bh=7Vy1vXp3UD4WC/K1zP8VHRNL6aaArf53i6fxMS75Fvk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=De670SlvIjxix6wzYDKr896rLMxRONw9Io4dWTjBtPTiMTdp1XOho/9AoSZjGVSvoPHPMbcj0XpdioTp7efx8aX6g01Hbd/T/XTeydSI7R7uzqWLCwTu3TlrsVqfYBMa9MhibvRe2BzvTy2jkNM5vlj4i46PpRHTb+J1WT1hcfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Md+lDeR4; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=YWu64MiH1xJ8Soy90rvBxXVDUOBJw/UkUXDflWz2xrE=; b=Md+lDeR4RhQeoz8Ar8OyK0uOUy
	dlrskJ5+7jMhT3bE6KmKEdTd+l+oQqneaSzz9qb+LMYSk04fElfJ57T805xE2vNvGLKJ4tSFNJ7g+
	VMM1jN9TqjAAezffgtlYa6c072m6gGQqQvF/V2KJW1MRE4XgiB3SFq4TntisWw0stbnBq6bjc0H+X
	VxKJwqqh94l0DM8F4ybBA0+HRg02z0AwV2iQli8MGturPZI0rnJgbAieW6IBNiOESImf2mkJueVD5
	V/M1ndzx1YCGZUY0djiBc5hv80YAS95B58iR0W7ullWMGjrbjvm+zI+isi+4eRiTGXoPyhwKYWC6A
	31FbstRw==;
Received: from [2001:4bb8:2cc:5a47:1fe7:c9d0:5f76:7c02] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCdX8-0000000FJMt-0foy;
	Wed, 07 May 2025 12:05:54 +0000
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
Date: Wed,  7 May 2025 14:04:43 +0200
Message-ID: <20250507120451.4000627-20-hch@lst.de>
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

Replace the code building a bio from a kernel direct map address and
submitting it synchronously with the bdev_rw_virt helper.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Acked-by: Yangtao Li <frank.li@vivo.com>
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


