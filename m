Return-Path: <linux-fsdevel+bounces-48369-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 078D4AADE4A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 May 2025 14:08:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F7FF4C7403
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 May 2025 12:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F07025D20E;
	Wed,  7 May 2025 12:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jJnK5D3Z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C03F25C6F0;
	Wed,  7 May 2025 12:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746619529; cv=none; b=MRErsw4H7Ey3WQZoNUyyxF6QqHYx/v+JF9Q7TJL43rUuU+LrMHpVyBaVAJ+ic1lVvbZVeh7R8wp9YzvqCA6fKMXsyxJZ+mBkWb4qSFRH//VLsApvY8bWZdeod+l7VQ38wRzAwc0JCei+ue7UwmVwXzqV9J1nyySRz9ADJkYz/SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746619529; c=relaxed/simple;
	bh=puQn2LSxP4XQZfvAcW6UiojrQecIlZPg1akCxaospkY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uZK8JSZTYdHFfBX6YKFD+rZPjd3KCqb4ysIRaCTTcTNWLLs/Oa4h4wnTglPXfQqCAwgHDRdlNlQrT+2twmZPQMU/Aku7p58JN292PG+AKKhKmwYzLHZbI3XXgPOrWIYIhGUYNiFu4QBIlYZMHJG2QG9C/DgVlqvWgIufJURaTK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=jJnK5D3Z; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=UlkjimJPUo/ouW1UG1kEcSgybAGLe7xP5rAALqNBzSM=; b=jJnK5D3ZrgiZgk3FwVhIooT1nQ
	j7VGpjypyhyhKGP7nIpVq3mh1bU0DnNRwxqTK/K07VgtPRTf5M8lvD+cwNhNCO5rDqy2O2hJVpo5L
	cgzFEsN7eZlsS+D3NOFy/sJfNw+mCozubH1td+Afyl8BvK4PkFgVicqchBCTzo3lmuRWcmfaJTte0
	Hdsy5tx7OwkAP/A1VAPLAAzLW1ow0ebI75eKsjAc65Psbxr3mD+Qa7AM4af2mOnfsDkG/DxuhMSvC
	KPJDlmxRNk8/EcGJx2wSuHx4V0BaJMmXS5ux6diz4ZGPl/dJ4BTKwfjKCgHXKCppS0yePdw69571Z
	6E8/FVsg==;
Received: from [2001:4bb8:2cc:5a47:1fe7:c9d0:5f76:7c02] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCdWg-0000000FJBS-3LYx;
	Wed, 07 May 2025 12:05:27 +0000
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
Subject: [PATCH 11/19] zonefs: use bdev_rw_virt in zonefs_read_super
Date: Wed,  7 May 2025 14:04:35 +0200
Message-ID: <20250507120451.4000627-12-hch@lst.de>
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

Switch zonefs_read_super to allocate the superblock buffer using kmalloc
which falls back to the page allocator for PAGE_SIZE allocation but
gives us a kernel virtual address and then use bdev_rw_virt to perform
the synchronous read into it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Acked-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
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


