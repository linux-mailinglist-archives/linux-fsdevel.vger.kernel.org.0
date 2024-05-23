Return-Path: <linux-fsdevel+bounces-20051-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B24F58CD318
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 May 2024 15:02:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CE4C28503E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 May 2024 13:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2AC11474BC;
	Thu, 23 May 2024 13:02:06 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C30F013B791
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 May 2024 13:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716469326; cv=none; b=YAS9A9OnefLR6qIh6TU/QqJ0Hvfz5B6gSCHr+E9SgL4VZ6JoCM2pvswPqQ8aBmQF0xUS9ZODj4F1eBljR9OYAsYbsQmpLSSP5zQeZ5JMtdc39/bSnrVxsQtd3aSknwc6iIEGksKfG2Dbj0/R4/5fhqqEyhOCl8MwvYAJqQCiurg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716469326; c=relaxed/simple;
	bh=i8H1qSAsnBu7b7Ct4eM9qM47WYokNByBg0K2/wEhAaE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=usEVCTwTBcwJ/c3cx+wrmbx6iFvk2A76YK/ts34DA3SZWOpFCZHNwj1UowPQe2+3xDl7cDteLMoQmXQNCi6cWESXYJ9CpUX+T8TgvyWrPJxiXdferFy4zOroxxCZS1osWATLH4wCNm6sQEF9bGe+/9OTS/Apck0XVinwfzg1pcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-354f5fb80d5so927768f8f.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 May 2024 06:02:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716469323; x=1717074123;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R80rwWlM5rPBBh6v2rjhFBj7t63ZYkmGc94rS5nwMjo=;
        b=d5mmg1wppFzwXNVII6a24ZsEskug2EkLTHFxXgs4XGOdqJ94J8CKsVoDYUYf122S9g
         NqGGBdQF+Cql0nIZCMQFlPHQ6rQVO0fj0WFOAN2zsKImaM7PvkIjUvb63uQIqH9UZeu6
         3iW9MjZ1TiNDxqdyyZFwq5oxsuEJTGkEQe8ftl+Ju3aVSUniUOdKvb6XzfH7/lkaZC9M
         DNpm308zfR/9DugLJjjiYRznkDTU7N1rH7RQ7ePTbi2Tbjk4nqWvHl+Kek+U2uCEbyqT
         VRg7gHsbKZJxaTnToVilm4UBESwUHdriKrSjqfASB+BiuKLPJY97L2b0OOqseEmZyuof
         ZnJA==
X-Gm-Message-State: AOJu0YzACt2b1wt7afsPsZAf8zxg/pJyLuP1eEInwVe7LPU700Ls0HBT
	HB/AOgPVuXXdM+sd8MFdSrRP/jGzLQUbG+wSAHlGRqI7g/y5Nc6u
X-Google-Smtp-Source: AGHT+IGnmuFv47HK1rFGPAtMKTzXX7JApH3z16PvG9YiWS2X3DkpMxAx37M8iAIcTz0a7b3qJuXmrA==
X-Received: by 2002:adf:f88e:0:b0:354:f753:e0e3 with SMTP id ffacd0b85a97d-354f753e2c6mr1694951f8f.19.1716469322369;
        Thu, 23 May 2024 06:02:02 -0700 (PDT)
Received: from nuc.fritz.box (p200300f6f709b700fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f709:b700:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-354f9ba7584sm1453207f8f.57.2024.05.23.06.02.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 06:02:01 -0700 (PDT)
From: Johannes Thumshirn <jth@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-fsdevel@vger.kernel.org,
	Matthew Wilcox <willy@infradead.org>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v2] zonefs: move super block reading from page to folio
Date: Thu, 23 May 2024 15:01:53 +0200
Message-ID: <20240523130153.27537-1-jth@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Move reading of the on-disk superblock from page to folios.

Cc: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/zonefs/super.c | 35 ++++++++++++++---------------------
 1 file changed, 14 insertions(+), 21 deletions(-)

diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
index faf1eb87895d..01a01cc3e0e4 100644
--- a/fs/zonefs/super.c
+++ b/fs/zonefs/super.c
@@ -1109,30 +1109,23 @@ static int zonefs_init_zgroups(struct super_block *sb)
 static int zonefs_read_super(struct super_block *sb)
 {
 	struct zonefs_sb_info *sbi = ZONEFS_SB(sb);
+	struct address_space *address_space = sb->s_bdev->bd_inode->i_mapping;
 	struct zonefs_super *super;
 	u32 crc, stored_crc;
-	struct page *page;
 	struct bio_vec bio_vec;
 	struct bio bio;
+	struct folio *folio;
 	int ret;
 
-	page = alloc_page(GFP_KERNEL);
-	if (!page)
-		return -ENOMEM;
-
-	bio_init(&bio, sb->s_bdev, &bio_vec, 1, REQ_OP_READ);
-	bio.bi_iter.bi_sector = 0;
-	__bio_add_page(&bio, page, PAGE_SIZE, 0);
-
-	ret = submit_bio_wait(&bio);
-	if (ret)
-		goto free_page;
+	folio = read_mapping_folio(address_space, 0, NULL);
+	if (IS_ERR(folio))
+		return -EINVAL;
 
-	super = page_address(page);
+	super = folio_address(folio);
 
 	ret = -EINVAL;
 	if (le32_to_cpu(super->s_magic) != ZONEFS_MAGIC)
-		goto free_page;
+		goto put_folio;
 
 	stored_crc = le32_to_cpu(super->s_crc);
 	super->s_crc = 0;
@@ -1140,14 +1133,14 @@ static int zonefs_read_super(struct super_block *sb)
 	if (crc != stored_crc) {
 		zonefs_err(sb, "Invalid checksum (Expected 0x%08x, got 0x%08x)",
 			   crc, stored_crc);
-		goto free_page;
+		goto put_folio;
 	}
 
 	sbi->s_features = le64_to_cpu(super->s_features);
 	if (sbi->s_features & ~ZONEFS_F_DEFINED_FEATURES) {
 		zonefs_err(sb, "Unknown features set 0x%llx\n",
 			   sbi->s_features);
-		goto free_page;
+		goto put_folio;
 	}
 
 	if (sbi->s_features & ZONEFS_F_UID) {
@@ -1155,7 +1148,7 @@ static int zonefs_read_super(struct super_block *sb)
 				       le32_to_cpu(super->s_uid));
 		if (!uid_valid(sbi->s_uid)) {
 			zonefs_err(sb, "Invalid UID feature\n");
-			goto free_page;
+			goto put_folio;
 		}
 	}
 
@@ -1164,7 +1157,7 @@ static int zonefs_read_super(struct super_block *sb)
 				       le32_to_cpu(super->s_gid));
 		if (!gid_valid(sbi->s_gid)) {
 			zonefs_err(sb, "Invalid GID feature\n");
-			goto free_page;
+			goto put_folio;
 		}
 	}
 
@@ -1173,14 +1166,14 @@ static int zonefs_read_super(struct super_block *sb)
 
 	if (memchr_inv(super->s_reserved, 0, sizeof(super->s_reserved))) {
 		zonefs_err(sb, "Reserved area is being used\n");
-		goto free_page;
+		goto put_folio;
 	}
 
 	import_uuid(&sbi->s_uuid, super->s_uuid);
 	ret = 0;
 
-free_page:
-	__free_page(page);
+put_folio:
+	folio_put(folio);
 
 	return ret;
 }
-- 
2.43.0


