Return-Path: <linux-fsdevel+bounces-46973-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0D08A96EE7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 16:33:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6085C1B65186
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 14:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0763B29114B;
	Tue, 22 Apr 2025 14:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tXxdT32q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E5128C5B5;
	Tue, 22 Apr 2025 14:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745332057; cv=none; b=u9QahfbZa7PwaB0JoW+PyQDmNBYSxr7xPENWrtQHlYDBTNwaDYRsnL1O+lAWM5UnqFtutKWtTZbiR1a6ab0uOvhMrJVss/qeidIcZquRp2LiNH5HGvQ7oqQtNGGgPra55BipeG8/+bfGOPjQZL2gN4FSHKt/2/qiev/3+vYjbPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745332057; c=relaxed/simple;
	bh=eo2NQkVO97Z/0yBFgfrywIc0luiIe5KOILc9ZoV3e8A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I6IntdwBU+hEYV+rPlFrUJwIGZyyNVF/ks06sfC2mLT4DJf7rbpTDh5YW7ImQSL+YOI/32pox5MNvcDaigMfPIURP93My9C9tnXRU+Ql1BcKVV/7UsaU75MLfQI2SZs0VOpeH/0f5XBFb2WCZMYQjnjK2mUivO6UCs3Fl6d3hqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=tXxdT32q; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=RUduWmpj93wFHeT8wG3+6yqZFaK8p5/oZJU6Qh/lF8o=; b=tXxdT32qeHxgrWUSOor4z8196d
	2yJ2ZqGF7EUJzgYkXTf7O8XQ/0y7/T535Qr9W+Q1+eKUnPTZOjhyvblwZfZQd5xaGQSbjxQh8HP12
	r8p/w+96fY9f5acqNiVk/iB+k9z9NdZGI/GiI6Q6zgvklXAbeY9enRUWUEYUX8kzjESDXQUqyeEEg
	PDxJCyANS0tKZU5ODTNbmGq/gyW0XhUSbj0UBNDJS6FVkar0/k4ph7HrLY3RQn9jJ90BPG5THJ7Zl
	i3A9aaUyV/b3RRRTo9rezGg3mYI5CRRda+1ZRr2aoKYP3RqMDavhwHbVdHhryDRjhVyTGFotYeQSp
	Z4f1bASA==;
Received: from [2001:4bb8:2fc:38c3:78fb:84a5:c78c:68b6] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7Eb0-00000007UT0-3doi;
	Tue, 22 Apr 2025 14:27:35 +0000
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
Subject: [PATCH 16/17] zonefs: use bdev_rw_virt in zonefs_read_super
Date: Tue, 22 Apr 2025 16:26:17 +0200
Message-ID: <20250422142628.1553523-17-hch@lst.de>
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

Switch zonefs_read_super to allocate the superblock buffer using kmalloc
which falls back to the page allocator for PAGE_SIZE allocation but
gives us a kernel virtual address and then use bdev_rw_virt to perform
the synchronous read into it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/zonefs/super.c | 34 ++++++++++++----------------------
 1 file changed, 12 insertions(+), 22 deletions(-)

diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
index faf1eb87895d..d165eb979f21 100644
--- a/fs/zonefs/super.c
+++ b/fs/zonefs/super.c
@@ -1111,28 +1111,19 @@ static int zonefs_read_super(struct super_block *sb)
 	struct zonefs_sb_info *sbi = ZONEFS_SB(sb);
 	struct zonefs_super *super;
 	u32 crc, stored_crc;
-	struct page *page;
-	struct bio_vec bio_vec;
-	struct bio bio;
 	int ret;
 
-	page = alloc_page(GFP_KERNEL);
-	if (!page)
+	super = kmalloc(PAGE_SIZE, GFP_KERNEL);
+	if (!super)
 		return -ENOMEM;
 
-	bio_init(&bio, sb->s_bdev, &bio_vec, 1, REQ_OP_READ);
-	bio.bi_iter.bi_sector = 0;
-	__bio_add_page(&bio, page, PAGE_SIZE, 0);
-
-	ret = submit_bio_wait(&bio);
+	ret = bdev_rw_virt(sb->s_bdev, 0, super, PAGE_SIZE, REQ_OP_READ);
 	if (ret)
-		goto free_page;
-
-	super = page_address(page);
+		goto free_super;
 
 	ret = -EINVAL;
 	if (le32_to_cpu(super->s_magic) != ZONEFS_MAGIC)
-		goto free_page;
+		goto free_super;
 
 	stored_crc = le32_to_cpu(super->s_crc);
 	super->s_crc = 0;
@@ -1140,14 +1131,14 @@ static int zonefs_read_super(struct super_block *sb)
 	if (crc != stored_crc) {
 		zonefs_err(sb, "Invalid checksum (Expected 0x%08x, got 0x%08x)",
 			   crc, stored_crc);
-		goto free_page;
+		goto free_super;
 	}
 
 	sbi->s_features = le64_to_cpu(super->s_features);
 	if (sbi->s_features & ~ZONEFS_F_DEFINED_FEATURES) {
 		zonefs_err(sb, "Unknown features set 0x%llx\n",
 			   sbi->s_features);
-		goto free_page;
+		goto free_super;
 	}
 
 	if (sbi->s_features & ZONEFS_F_UID) {
@@ -1155,7 +1146,7 @@ static int zonefs_read_super(struct super_block *sb)
 				       le32_to_cpu(super->s_uid));
 		if (!uid_valid(sbi->s_uid)) {
 			zonefs_err(sb, "Invalid UID feature\n");
-			goto free_page;
+			goto free_super;
 		}
 	}
 
@@ -1164,7 +1155,7 @@ static int zonefs_read_super(struct super_block *sb)
 				       le32_to_cpu(super->s_gid));
 		if (!gid_valid(sbi->s_gid)) {
 			zonefs_err(sb, "Invalid GID feature\n");
-			goto free_page;
+			goto free_super;
 		}
 	}
 
@@ -1173,15 +1164,14 @@ static int zonefs_read_super(struct super_block *sb)
 
 	if (memchr_inv(super->s_reserved, 0, sizeof(super->s_reserved))) {
 		zonefs_err(sb, "Reserved area is being used\n");
-		goto free_page;
+		goto free_super;
 	}
 
 	import_uuid(&sbi->s_uuid, super->s_uuid);
 	ret = 0;
 
-free_page:
-	__free_page(page);
-
+free_super:
+	kfree(super);
 	return ret;
 }
 
-- 
2.47.2


