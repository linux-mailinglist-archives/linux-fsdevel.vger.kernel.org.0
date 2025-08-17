Return-Path: <linux-fsdevel+bounces-58088-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ED2FB292F4
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Aug 2025 14:23:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D46BD1B20640
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Aug 2025 12:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE0C62376F2;
	Sun, 17 Aug 2025 12:23:13 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EE833176FD
	for <linux-fsdevel@vger.kernel.org>; Sun, 17 Aug 2025 12:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755433393; cv=none; b=lebnotJ3bHR3j4QcWgzle2vRipNQdjWGwYBvTNVe+ezeSF0Qudsi18xMmRUjWDe93C8LJPEDrBxoQZ1jx1tsupY0ZwdfUXi5G5YmDYy+pCGBycPGU1ZjrRy5EGvwaY4v/90WkV7wc6TJLXWlB3UU0YcCy4B0AqmuU+Cvl1T/CvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755433393; c=relaxed/simple;
	bh=lI31emYWMJrFhn0+pt5aagOfFiilGbOMAAivpxjXzHA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hSTrlrrCWRt00E9N4LrmpL9PVghs+prauqbXjodqP7uREkpz1htYcsuLxzczvJLibyHCzJfRdxsQzOzlwq3cQrgCAh0XNLzAD8jdu3eyoGtS+Ik/tCge0dj2TxSROFRa/d63m5UGgOTdqt7ve/hBwcQnfmgmriVmHc4jK+Exwm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-76e44537dccso1186001b3a.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 17 Aug 2025 05:23:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755433391; x=1756038191;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E4CWb3JVKkmUL1eQGGvqLdRhFt5o1zQQTwuKWWTSptE=;
        b=HvVMk95WQRFHLWtzVOsbNxsiMUnhpRNaxA4JHtGVsDlty1sU5fUflO/nEGQRSiq/7C
         ysD+g9xDRf3rZRB8eCA32I7uI4nsCPJFcvWSADrtX4LNsj60zPcNqwyVS+dFk8bWAnUk
         BcvlNQxaA6M2sxvuGsskkmb1InDakRzYJrOySYPJ1gyugWLEW+VL+KsFWK1Nb0j3hqH1
         TAObLU2l72Dmx28s667BtNK1yRUeS8ivkM3jwvacQ2IC/raIiejRS3QTN1l+EXPxN57r
         sBBi4v/9DHhKunLd8ugdtYYgA/Yl0osYYha6jW+x1KoWb8YOTUUR6NcmoZl/9kdMpZg1
         Gn7A==
X-Gm-Message-State: AOJu0YxlxCiT4VoFTG3lDrVgaaOLjuStRFFrNxMjWcs5FTXs3YHc4OYj
	XMLHlsIVmW/3ylukLac9LxdRPlD7CvYYdiLUD9XFug4xKoJv+02ODmj4
X-Gm-Gg: ASbGncvz7KRJNqRbFB+6vwGB1V68ZriFCeVTMMGWC/S7C3xJaXeShvnENKt50SEAdJp
	O2WYxa0LG2v3Wi/QEbe3LU+wJAM1rhCQ0FxViFKtE1gSOow0XDwKMqxKcF77G6yyaM+sXwtWWva
	ZZfEfdNGVls7JMW8hVjNHH1fGcxKV/ZwPSTWwougWjZgkyOF5mcMvZK6i64UNYMuV2Me32PmDFB
	lRkhW1+5TlQyI8ZaJc38UwSSrra29GHNKSOToQSEvtbk0LrDz6Kzh3xMHSsTWKlMRfa7tMWum40
	imlZUpRmsvJDbdN7LQz5v/JoWrD2T0sGDUc4wiPFhpzYEbi2rhEs4DCUbPdjKYoeSDsGmbnCiAG
	8ilMpdVOXgyY9oBaXFb52s3PaEtQizsxWfYGGmw==
X-Google-Smtp-Source: AGHT+IGgUKc9WzezD4bhxLvFCoDisy+FqNXbelxYfJP/mdBs0c1SC4FT9ghIMzFvRZgC/rFceDBA0g==
X-Received: by 2002:a05:6a00:8c6:b0:76b:f16b:b186 with SMTP id d2e1a72fcca58-76e448182b4mr9304505b3a.17.1755433391319;
        Sun, 17 Aug 2025 05:23:11 -0700 (PDT)
Received: from localhost.localdomain ([1.227.206.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e45289544sm5110129b3a.27.2025.08.17.05.23.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Aug 2025 05:23:10 -0700 (PDT)
From: Namjae Jeon <linkinjeon@kernel.org>
To: sj1557.seo@samsung.com,
	Yuezhang.Mo@sony.com
Cc: linux-fsdevel@vger.kernel.org,
	Namjae Jeon <linkinjeon@kernel.org>
Subject: [v2 PATCH] exfat: optimize allocation bitmap loading time
Date: Sun, 17 Aug 2025 21:22:39 +0900
Message-Id: <20250817122239.5699-1-linkinjeon@kernel.org>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Loading the allocation bitmap is very slow if user set the small cluster
size on large partition.

For optimizing it, This patch uses sb_breadahead() read the allocation
bitmap. It will improve the mount time.

The following is the result of about 4TB partition(2KB cluster size)
on my target.

without patch:
real 0m41.746s
user 0m0.011s
sys 0m0.000s

with patch:
real 0m2.525s
user 0m0.008s
sys 0m0.008s

Reviewed-by: Sungjong Seo <sj1557.seo@samsung.com>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
---
 v2:
   - use optimal readahead size using ->ra_pages or ->io_pages.
 fs/exfat/balloc.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/fs/exfat/balloc.c b/fs/exfat/balloc.c
index cc01556c9d9b..260bfaa1e19b 100644
--- a/fs/exfat/balloc.c
+++ b/fs/exfat/balloc.c
@@ -7,6 +7,7 @@
 #include <linux/slab.h>
 #include <linux/bitmap.h>
 #include <linux/buffer_head.h>
+#include <linux/backing-dev.h>
 
 #include "exfat_raw.h"
 #include "exfat_fs.h"
@@ -30,9 +31,11 @@ static int exfat_allocate_bitmap(struct super_block *sb,
 		struct exfat_dentry *ep)
 {
 	struct exfat_sb_info *sbi = EXFAT_SB(sb);
+	struct blk_plug plug;
 	long long map_size;
-	unsigned int i, need_map_size;
+	unsigned int i, j, need_map_size;
 	sector_t sector;
+	unsigned int max_ra_count;
 
 	sbi->map_clu = le32_to_cpu(ep->dentry.bitmap.start_clu);
 	map_size = le64_to_cpu(ep->dentry.bitmap.size);
@@ -56,7 +59,17 @@ static int exfat_allocate_bitmap(struct super_block *sb,
 		return -ENOMEM;
 
 	sector = exfat_cluster_to_sector(sbi, sbi->map_clu);
+	max_ra_count = min(sb->s_bdi->ra_pages, sb->s_bdi->io_pages) <<
+		(PAGE_SHIFT - sb->s_blocksize_bits);
 	for (i = 0; i < sbi->map_sectors; i++) {
+		/* Trigger the next readahead in advance. */
+		if (0 == (i % max_ra_count)) {
+			blk_start_plug(&plug);
+			for (j = i; j < min(max_ra_count, sbi->map_sectors - i) + i; j++)
+				sb_breadahead(sb, sector + j);
+			blk_finish_plug(&plug);
+		}
+
 		sbi->vol_amap[i] = sb_bread(sb, sector + i);
 		if (!sbi->vol_amap[i]) {
 			/* release all buffers and free vol_amap */
-- 
2.25.1


