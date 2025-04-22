Return-Path: <linux-fsdevel+bounces-46969-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B164A96ECC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 16:32:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AABA31B63E9D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 14:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B056328FFF3;
	Tue, 22 Apr 2025 14:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="B1WIE+lD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A7A28A40A;
	Tue, 22 Apr 2025 14:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745332043; cv=none; b=lHKJiuu6WF2LNDhPlKuAs/ExLQzm14ncdaOPEqeYVKJ5UPgdAw7IrVCnH8z9fr4yi4G09HuIkCINkCOgUkw0N5CklRrsBkKxU2ZtBj88N7FFY843fCiB6Ad5U4tme1fACzl9C3f3iAReEcD5IOojkEUe108ANL2hWsgJx0l5tHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745332043; c=relaxed/simple;
	bh=gn7idHb+0IqPuKYe9Uu7dq1lW/OdMu5UcwpceqnIrFE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YV02a2fPIgl9YSL4eeZXQTKqteDDdW1zJR7I/WQqFpdVQi1kUXFf4GbyvhQ+1qULT97gV2slLeoLAt0OlR4+kWFdAGYl/SqU4tL/iqMjrCN1RXufDWwyWNpDsNWjfDZS3hZdladJWwNwwsIFjfak/l38ABeV3Akg8AIfpT0ePIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=B1WIE+lD; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=lzIrXtMTV8PFgmBgUZ/nD0uKCPWKsGbuyfHF3Ag4aNw=; b=B1WIE+lD7Rva9K98vTDDyJJY2W
	z7UlUVpbPIFpmiTf4kCt/CBGcuKxCfD8e2btayr5n6dQN1IMRQJbZLqeyU31sVODfRYYiDz00cQet
	JPTwHpl4V9UHzWKG6r09e6AByhZPjXzL0RWkzHAZlvD7G1l3LN8QI/Jeead24DkNRv0jRFR4vc+zK
	CbEl4JrXVDxmVYiEMagARVH3yN0kmEgLijwZYmP19EcbaFOLrbXdvp09nkYq9LNi22DpD8em5I2sW
	61mDp2hphjBJp6XKtaEQxQMsPA8et7wV+3aUeFDPinYcxu5wMXgKXWaJEB+XzSxpjYEiJDPYDVCtS
	ptP6JOCQ==;
Received: from [2001:4bb8:2fc:38c3:78fb:84a5:c78c:68b6] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7Eal-00000007UPn-1Ld1;
	Tue, 22 Apr 2025 14:27:20 +0000
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
Subject: [PATCH 12/17] xfs: simplify xfs_rw_bdev
Date: Tue, 22 Apr 2025 16:26:13 +0200
Message-ID: <20250422142628.1553523-13-hch@lst.de>
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

Delegate to bdev_rw_virt when operating on non-vmalloc memory and use
bio_add_vmalloc to insulate xfs from the details of adding vmalloc memory
to a bio.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/xfs/xfs_bio_io.c | 30 ++++++++++++------------------
 1 file changed, 12 insertions(+), 18 deletions(-)

diff --git a/fs/xfs/xfs_bio_io.c b/fs/xfs/xfs_bio_io.c
index fe21c76f75b8..98ad42b0271e 100644
--- a/fs/xfs/xfs_bio_io.c
+++ b/fs/xfs/xfs_bio_io.c
@@ -18,42 +18,36 @@ xfs_rw_bdev(
 	enum req_op		op)
 
 {
-	unsigned int		is_vmalloc = is_vmalloc_addr(data);
-	unsigned int		left = count;
+	unsigned int		done = 0, added;
 	int			error;
 	struct bio		*bio;
 
-	if (is_vmalloc && op == REQ_OP_WRITE)
-		flush_kernel_vmap_range(data, count);
+	op |= REQ_META | REQ_SYNC;
+	if (!is_vmalloc_addr(data))
+		return bdev_rw_virt(bdev, sector, data, count, op);
 
-	bio = bio_alloc(bdev, bio_max_vecs(left), op | REQ_META | REQ_SYNC,
-			GFP_KERNEL);
+	bio = bio_alloc(bdev, bio_max_vecs(count), op, GFP_KERNEL);
 	bio->bi_iter.bi_sector = sector;
 
 	do {
-		struct page	*page = kmem_to_page(data);
-		unsigned int	off = offset_in_page(data);
-		unsigned int	len = min_t(unsigned, left, PAGE_SIZE - off);
-
-		while (bio_add_page(bio, page, len, off) != len) {
+		added = bio_add_vmalloc(bio, data + done, count - done);
+		if (!added) {
 			struct bio	*prev = bio;
 
-			bio = bio_alloc(prev->bi_bdev, bio_max_vecs(left),
+			bio = bio_alloc(prev->bi_bdev,
+					bio_max_vecs(count - done),
 					prev->bi_opf, GFP_KERNEL);
 			bio->bi_iter.bi_sector = bio_end_sector(prev);
 			bio_chain(prev, bio);
-
 			submit_bio(prev);
 		}
-
-		data += len;
-		left -= len;
-	} while (left > 0);
+		done += added;
+	} while (done < count);
 
 	error = submit_bio_wait(bio);
 	bio_put(bio);
 
-	if (is_vmalloc && op == REQ_OP_READ)
+	if (op == REQ_OP_READ)
 		invalidate_kernel_vmap_range(data, count);
 	return error;
 }
-- 
2.47.2


