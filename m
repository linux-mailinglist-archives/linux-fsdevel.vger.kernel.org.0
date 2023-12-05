Return-Path: <linux-fsdevel+bounces-4831-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80AA580489B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Dec 2023 05:34:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 396AA281426
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Dec 2023 04:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2D8CD270
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Dec 2023 04:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YWq+Tmx3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-xb42.google.com (mail-yb1-xb42.google.com [IPv6:2607:f8b0:4864:20::b42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75BABCD
	for <linux-fsdevel@vger.kernel.org>; Mon,  4 Dec 2023 20:33:47 -0800 (PST)
Received: by mail-yb1-xb42.google.com with SMTP id 3f1490d57ef6-d9beb865a40so3503145276.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 04 Dec 2023 20:33:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701750826; x=1702355626; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DJtdSreiAtIcFaXKLX9IWOb1pLA32xkZaMGgk1uW1+s=;
        b=YWq+Tmx3DPmW3VnZa3lFpJeCQiXy8oIsDkW3nUmOuT2HwdeBDgMc2mVfqIAhjkpcEk
         joVFozNvtzIPEhm3EwF5PAHRcj+23XTfk3IVB67ySGwCFVcgG51+PcBYGUinBzF7FwmN
         arFXvXmCe4UJ0w69vCMW8B309AsgHturuXCANQCAb7TasMDB9OxSdBNFbIKQGJzleCyl
         eF0zRrIaWXl7Kk9sveLjzPa5j0nR5q/41I5ySqoBPsGFPSIErmGoCO2v5NKuK4G8b//F
         LGRJaaoV3J1pO5z5aMjybv8cCtGZio5E3do7alJTXSPGoBB5/PwuFqRkY7MSZ7aXKW/v
         aVjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701750826; x=1702355626;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DJtdSreiAtIcFaXKLX9IWOb1pLA32xkZaMGgk1uW1+s=;
        b=btO81BzmQGnThGTTiYp81jL6AvUasMSZJS6axXV3xnEMwVDuY80s7zvKovIhr0a+iO
         64sqadfDvGwD6+ymBGGm7yBgsN4GHYA2ifLgrADpXGPtZEsVqwUA6g2htQm5tN2nniUo
         lXWliPCzFNTFAy8cs+pLqf95q1rVzmSRjrgVQ4pjvnchLMX1AqN0lsGosYQqqfqVa+5/
         JbExz7Musk3iRWpuIZ/97J2sGp44OW8tkiMWeV004Z6YDDZJNXs4IKkBlW9wCUYHV/3s
         /A6A3cKxgGZfhMoUFSSrtZx6iFICiBvcIaK1xSXAs2uPTxP5slxnYbCKXI7FQWDHpklc
         2efg==
X-Gm-Message-State: AOJu0YwWNHJFAUlMbdzCaFNgw2IWpn+YPzcIeQ36WHt6tM3KzgzWo037
	VRvApwfpoWaibgSxkWVA884=
X-Google-Smtp-Source: AGHT+IFtw6UsQGq2/HATf3v9fWMApI9DsRaKISYIakF5cAv+wPHA0yp0IQZhjO8SKKXWAqRHpsLyfg==
X-Received: by 2002:a25:cb0a:0:b0:db7:dacf:3fc2 with SMTP id b10-20020a25cb0a000000b00db7dacf3fc2mr3891914ybg.111.1701750826514;
        Mon, 04 Dec 2023 20:33:46 -0800 (PST)
Received: from localhost ([2409:8a3c:3647:2160:38b2:24ff:fe76:bb76])
        by smtp.gmail.com with ESMTPSA id y9-20020a170902b48900b001c61df93afdsm9228950plr.59.2023.12.04.20.33.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 20:33:46 -0800 (PST)
From: John Sanpe <sanpeqf@gmail.com>
To: linkinjeon@kernel.org,
	sj1557.seo@samsung.com,
	willy@infradead.org
Cc: linux-fsdevel@vger.kernel.org,
	Andy.Wu@sony.com,
	Wataru.Aoyama@sony.com,
	cpgs@samsung.com,
	John Sanpe <sanpeqf@gmail.com>
Subject: [PATCH v2] exfat/balloc: using hweight instead of internal logic
Date: Tue,  5 Dec 2023 12:33:05 +0800
Message-ID: <20231205043305.1557624-1-sanpeqf@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the internal table lookup algorithm with the hweight
library, which has instruction set acceleration capabilities.

Use it to increase the length of a single calculation of
the exfat_find_free_bitmap function to the long type.

Signed-off-by: John Sanpe <sanpeqf@gmail.com>
---
 fs/exfat/balloc.c   | 47 +++++++++++++++++++--------------------------
 fs/exfat/exfat_fs.h |  1 +
 2 files changed, 21 insertions(+), 27 deletions(-)

diff --git a/fs/exfat/balloc.c b/fs/exfat/balloc.c
index e918decb3735..a7b3a234ba9b 100644
--- a/fs/exfat/balloc.c
+++ b/fs/exfat/balloc.c
@@ -5,11 +5,20 @@
 
 #include <linux/blkdev.h>
 #include <linux/slab.h>
+#include <linux/bitmap.h>
 #include <linux/buffer_head.h>
 
 #include "exfat_raw.h"
 #include "exfat_fs.h"
 
+#if BITS_PER_LONG == 32
+# define lel_to_cpu(A) le32_to_cpu(A)
+#elif BITS_PER_LONG == 64
+# define lel_to_cpu(A) le64_to_cpu(A)
+#else
+# error "BITS_PER_LONG not 32 or 64"
+#endif
+
 static const unsigned char free_bit[] = {
 	0, 1, 0, 2, 0, 1, 0, 3, 0, 1, 0, 2, 0, 1, 0, 4, 0, 1, 0, 2,/*  0 ~  19*/
 	0, 1, 0, 3, 0, 1, 0, 2, 0, 1, 0, 5, 0, 1, 0, 2, 0, 1, 0, 3,/* 20 ~  39*/
@@ -26,22 +35,6 @@ static const unsigned char free_bit[] = {
 	0, 1, 0, 2, 0, 1, 0, 3, 0, 1, 0, 2, 0, 1, 0                /*240 ~ 254*/
 };
 
-static const unsigned char used_bit[] = {
-	0, 1, 1, 2, 1, 2, 2, 3, 1, 2, 2, 3, 2, 3, 3, 4, 1, 2, 2, 3,/*  0 ~  19*/
-	2, 3, 3, 4, 2, 3, 3, 4, 3, 4, 4, 5, 1, 2, 2, 3, 2, 3, 3, 4,/* 20 ~  39*/
-	2, 3, 3, 4, 3, 4, 4, 5, 2, 3, 3, 4, 3, 4, 4, 5, 3, 4, 4, 5,/* 40 ~  59*/
-	4, 5, 5, 6, 1, 2, 2, 3, 2, 3, 3, 4, 2, 3, 3, 4, 3, 4, 4, 5,/* 60 ~  79*/
-	2, 3, 3, 4, 3, 4, 4, 5, 3, 4, 4, 5, 4, 5, 5, 6, 2, 3, 3, 4,/* 80 ~  99*/
-	3, 4, 4, 5, 3, 4, 4, 5, 4, 5, 5, 6, 3, 4, 4, 5, 4, 5, 5, 6,/*100 ~ 119*/
-	4, 5, 5, 6, 5, 6, 6, 7, 1, 2, 2, 3, 2, 3, 3, 4, 2, 3, 3, 4,/*120 ~ 139*/
-	3, 4, 4, 5, 2, 3, 3, 4, 3, 4, 4, 5, 3, 4, 4, 5, 4, 5, 5, 6,/*140 ~ 159*/
-	2, 3, 3, 4, 3, 4, 4, 5, 3, 4, 4, 5, 4, 5, 5, 6, 3, 4, 4, 5,/*160 ~ 179*/
-	4, 5, 5, 6, 4, 5, 5, 6, 5, 6, 6, 7, 2, 3, 3, 4, 3, 4, 4, 5,/*180 ~ 199*/
-	3, 4, 4, 5, 4, 5, 5, 6, 3, 4, 4, 5, 4, 5, 5, 6, 4, 5, 5, 6,/*200 ~ 219*/
-	5, 6, 6, 7, 3, 4, 4, 5, 4, 5, 5, 6, 4, 5, 5, 6, 5, 6, 6, 7,/*220 ~ 239*/
-	4, 5, 5, 6, 5, 6, 6, 7, 5, 6, 6, 7, 6, 7, 7, 8             /*240 ~ 255*/
-};
-
 /*
  *  Allocation Bitmap Management Functions
  */
@@ -244,25 +237,25 @@ int exfat_count_used_clusters(struct super_block *sb, unsigned int *ret_count)
 	unsigned int count = 0;
 	unsigned int i, map_i = 0, map_b = 0;
 	unsigned int total_clus = EXFAT_DATA_CLUSTER_COUNT(sbi);
-	unsigned int last_mask = total_clus & BITS_PER_BYTE_MASK;
-	unsigned char clu_bits;
-	const unsigned char last_bit_mask[] = {0, 0b00000001, 0b00000011,
-		0b00000111, 0b00001111, 0b00011111, 0b00111111, 0b01111111};
+	unsigned int last_mask = total_clus & BITS_PER_LONG_MASK;
+	unsigned long *bitmap, clu_bits;
 
 	total_clus &= ~last_mask;
-	for (i = 0; i < total_clus; i += BITS_PER_BYTE) {
-		clu_bits = *(sbi->vol_amap[map_i]->b_data + map_b);
-		count += used_bit[clu_bits];
-		if (++map_b >= (unsigned int)sb->s_blocksize) {
+	for (i = 0; i < total_clus; i += BITS_PER_LONG) {
+		bitmap = (void *)(sbi->vol_amap[map_i]->b_data + map_b);
+		clu_bits = lel_to_cpu(*bitmap);
+		count += hweight_long(clu_bits);
+		map_b += sizeof(long);
+		if (map_b >= (unsigned int)sb->s_blocksize) {
 			map_i++;
 			map_b = 0;
 		}
 	}
 
 	if (last_mask) {
-		clu_bits = *(sbi->vol_amap[map_i]->b_data + map_b);
-		clu_bits &= last_bit_mask[last_mask];
-		count += used_bit[clu_bits];
+		bitmap = (void *)(sbi->vol_amap[map_i]->b_data + map_b);
+		clu_bits = lel_to_cpu(*bitmap) & BITMAP_LAST_WORD_MASK(last_mask);
+		count += hweight_long(clu_bits);
 	}
 
 	*ret_count = count;
diff --git a/fs/exfat/exfat_fs.h b/fs/exfat/exfat_fs.h
index a7a2c35d74fb..1cb3bf1851c8 100644
--- a/fs/exfat/exfat_fs.h
+++ b/fs/exfat/exfat_fs.h
@@ -136,6 +136,7 @@ enum {
 #define BITMAP_OFFSET_BYTE_IN_SECTOR(sb, ent) \
 	((ent / BITS_PER_BYTE) & ((sb)->s_blocksize - 1))
 #define BITS_PER_BYTE_MASK	0x7
+#define BITS_PER_LONG_MASK	(BITS_PER_LONG - 1)
 #define IGNORED_BITS_REMAINED(clu, clu_base) ((1 << ((clu) - (clu_base))) - 1)
 
 #define ES_ENTRY_NUM(name_len)	(ES_IDX_LAST_FILENAME(name_len) + 1)
-- 
2.43.0


