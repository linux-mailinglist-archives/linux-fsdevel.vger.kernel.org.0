Return-Path: <linux-fsdevel+bounces-5415-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 61C6280B64A
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Dec 2023 21:38:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2FF81F210F9
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Dec 2023 20:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85EC319BCB;
	Sat,  9 Dec 2023 20:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G+lVua74"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 029AE92
	for <linux-fsdevel@vger.kernel.org>; Sat,  9 Dec 2023 12:38:16 -0800 (PST)
Received: by mail-ot1-x341.google.com with SMTP id 46e09a7af769-6d9d84019c5so2227164a34.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 09 Dec 2023 12:38:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702154295; x=1702759095; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hql+NATyLG+YoIalQKLl4Q2dpty5BRFkVhbko/5htus=;
        b=G+lVua74GxVsOYqlobdIhN38LUG0gDZfMsRG1bXQPWnB57Y+sUyncAVZ9UwDwJvVhy
         qMbWRAwjEs5mTQOpsDsVp2hN9IuAmkx4vmZCiab9DyUzdW6UgrNKI4/Qs4SW4zncaPLr
         YG9nUnmVNh7bFbsdIkZDdTqn1xBRtrKndPiPbVlV1OovF5foOg32hzguzR2c0i2v99EH
         OYxElDcy8Fk+npbN4TEJocadkehUeEm0x7FjFmGE2xAMzCpa9EZHFmfTMh41oAXzCafB
         za/yH6GAHoT0fG5JaRBieSDQhYt036Gqt+dTunPjmSD0s/+/K4nSbDVs5ZiFgXMRpuI7
         ZrXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702154295; x=1702759095;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hql+NATyLG+YoIalQKLl4Q2dpty5BRFkVhbko/5htus=;
        b=RQXKNzjwEiiFpg2lDGmEJCzJnoIA2eu0jg7L0fL+v3pA4/swF/idtnxkywS8RyOzq7
         ttxEby8QA8SaVq7JRI0wcvrAbEsjjLFF2DZX8BrJrH4DK9aOmEFWCduhBMJobNoNKpFK
         v44mjKpLbDfx+Lch3/2T0w7M/a0DHfhjueDFLgv3DTRr9cGuVq1hBphaekrNg4vWomir
         wZxJMTpHq15T6FiHjNG/wdyuC64q9g+CJgfrXQaSmLV2US6YJFTIw+8+/Gli+OIRLHY0
         Me4fXLUX6WW3+pYwyftPzJ4zITsCyxq/LqeabMaQ9yFioTnQmiCBRh42hicN4Leo2pI6
         lXWA==
X-Gm-Message-State: AOJu0YwZhHeVIzkS94FLDRcIl2LCMNdlqXA5G6ciF/Pe039LDBtPgN31
	Sxz6ts4h7QpHLnUDlatHgIE=
X-Google-Smtp-Source: AGHT+IFh9YxnA8Mf15NUNVmrOHtfBjAtZP1UjKiWeouwJ1DROgmwrlXNrKknmbgcZgtvYvE8/jX4MA==
X-Received: by 2002:a05:6358:90c:b0:170:8f3b:b749 with SMTP id r12-20020a056358090c00b001708f3bb749mr2501921rwi.0.1702154295051;
        Sat, 09 Dec 2023 12:38:15 -0800 (PST)
Received: from localhost ([2409:8a3c:3647:2160:38b2:24ff:fe76:bb76])
        by smtp.gmail.com with ESMTPSA id l17-20020a17090aaa9100b0028593e9eaadsm5460306pjq.31.2023.12.09.12.38.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Dec 2023 12:38:14 -0800 (PST)
From: John Sanpe <sanpeqf@gmail.com>
To: linkinjeon@kernel.org,
	sj1557.seo@samsung.com,
	willy@infradead.org
Cc: linux-fsdevel@vger.kernel.org,
	Andy.Wu@sony.com,
	Wataru.Aoyama@sony.com,
	cpgs@samsung.com,
	John Sanpe <sanpeqf@gmail.com>
Subject: [PATCH] exfat/balloc: using ffs instead of internal logic
Date: Fri,  8 Dec 2023 07:47:01 +0800
Message-ID: <20231207234701.566133-1-sanpeqf@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replaced the internal table lookup algorithm with ffs of
the bitops library with better performance.

Use it to increase the single processing length of the
exfat_find_free_bitmap function, from single-byte search to long type.

Signed-off-by: John Sanpe <sanpeqf@gmail.com>
---
 fs/exfat/balloc.c   | 41 +++++++++++++++--------------------------
 fs/exfat/exfat_fs.h |  3 +--
 2 files changed, 16 insertions(+), 28 deletions(-)

diff --git a/fs/exfat/balloc.c b/fs/exfat/balloc.c
index 3e3e9e4cce2f..4bacbb0cf5da 100644
--- a/fs/exfat/balloc.c
+++ b/fs/exfat/balloc.c
@@ -14,29 +14,15 @@
 #if BITS_PER_LONG == 32
 #define __le_long __le32
 #define lel_to_cpu(A) le32_to_cpu(A)
+#define cpu_to_lel(A) cpu_to_le32(A)
 #elif BITS_PER_LONG == 64
 #define __le_long __le64
 #define lel_to_cpu(A) le64_to_cpu(A)
+#define cpu_to_lel(A) cpu_to_le64(A)
 #else
 #error "BITS_PER_LONG not 32 or 64"
 #endif
 
-static const unsigned char free_bit[] = {
-	0, 1, 0, 2, 0, 1, 0, 3, 0, 1, 0, 2, 0, 1, 0, 4, 0, 1, 0, 2,/*  0 ~  19*/
-	0, 1, 0, 3, 0, 1, 0, 2, 0, 1, 0, 5, 0, 1, 0, 2, 0, 1, 0, 3,/* 20 ~  39*/
-	0, 1, 0, 2, 0, 1, 0, 4, 0, 1, 0, 2, 0, 1, 0, 3, 0, 1, 0, 2,/* 40 ~  59*/
-	0, 1, 0, 6, 0, 1, 0, 2, 0, 1, 0, 3, 0, 1, 0, 2, 0, 1, 0, 4,/* 60 ~  79*/
-	0, 1, 0, 2, 0, 1, 0, 3, 0, 1, 0, 2, 0, 1, 0, 5, 0, 1, 0, 2,/* 80 ~  99*/
-	0, 1, 0, 3, 0, 1, 0, 2, 0, 1, 0, 4, 0, 1, 0, 2, 0, 1, 0, 3,/*100 ~ 119*/
-	0, 1, 0, 2, 0, 1, 0, 7, 0, 1, 0, 2, 0, 1, 0, 3, 0, 1, 0, 2,/*120 ~ 139*/
-	0, 1, 0, 4, 0, 1, 0, 2, 0, 1, 0, 3, 0, 1, 0, 2, 0, 1, 0, 5,/*140 ~ 159*/
-	0, 1, 0, 2, 0, 1, 0, 3, 0, 1, 0, 2, 0, 1, 0, 4, 0, 1, 0, 2,/*160 ~ 179*/
-	0, 1, 0, 3, 0, 1, 0, 2, 0, 1, 0, 6, 0, 1, 0, 2, 0, 1, 0, 3,/*180 ~ 199*/
-	0, 1, 0, 2, 0, 1, 0, 4, 0, 1, 0, 2, 0, 1, 0, 3, 0, 1, 0, 2,/*200 ~ 219*/
-	0, 1, 0, 5, 0, 1, 0, 2, 0, 1, 0, 3, 0, 1, 0, 2, 0, 1, 0, 4,/*220 ~ 239*/
-	0, 1, 0, 2, 0, 1, 0, 3, 0, 1, 0, 2, 0, 1, 0                /*240 ~ 254*/
-};
-
 /*
  *  Allocation Bitmap Management Functions
  */
@@ -195,32 +181,35 @@ unsigned int exfat_find_free_bitmap(struct super_block *sb, unsigned int clu)
 {
 	unsigned int i, map_i, map_b, ent_idx;
 	unsigned int clu_base, clu_free;
-	unsigned char k, clu_mask;
+	unsigned long clu_bits, clu_mask;
 	struct exfat_sb_info *sbi = EXFAT_SB(sb);
+	__le_long bitval;
 
 	WARN_ON(clu < EXFAT_FIRST_CLUSTER);
-	ent_idx = CLUSTER_TO_BITMAP_ENT(clu);
-	clu_base = BITMAP_ENT_TO_CLUSTER(ent_idx & ~(BITS_PER_BYTE_MASK));
+	ent_idx = ALIGN_DOWN(CLUSTER_TO_BITMAP_ENT(clu), BITS_PER_LONG);
+	clu_base = BITMAP_ENT_TO_CLUSTER(ent_idx);
 	clu_mask = IGNORED_BITS_REMAINED(clu, clu_base);
 
 	map_i = BITMAP_OFFSET_SECTOR_INDEX(sb, ent_idx);
 	map_b = BITMAP_OFFSET_BYTE_IN_SECTOR(sb, ent_idx);
 
 	for (i = EXFAT_FIRST_CLUSTER; i < sbi->num_clusters;
-	     i += BITS_PER_BYTE) {
-		k = *(sbi->vol_amap[map_i]->b_data + map_b);
+	     i += BITS_PER_LONG) {
+		bitval = *(__le_long *)(sbi->vol_amap[map_i]->b_data + map_b);
 		if (clu_mask > 0) {
-			k |= clu_mask;
+			bitval |= cpu_to_lel(clu_mask);
 			clu_mask = 0;
 		}
-		if (k < 0xFF) {
-			clu_free = clu_base + free_bit[k];
+		if (bitval != ULONG_MAX) {
+			clu_bits = lel_to_cpu(bitval);
+			clu_free = clu_base + ffz(clu_bits);
 			if (clu_free < sbi->num_clusters)
 				return clu_free;
 		}
-		clu_base += BITS_PER_BYTE;
+		clu_base += BITS_PER_LONG;
+		map_b += sizeof(long);
 
-		if (++map_b >= sb->s_blocksize ||
+		if (map_b >= sb->s_blocksize ||
 		    clu_base >= sbi->num_clusters) {
 			if (++map_i >= sbi->map_sectors) {
 				clu_base = EXFAT_FIRST_CLUSTER;
diff --git a/fs/exfat/exfat_fs.h b/fs/exfat/exfat_fs.h
index a7a2c35d74fb..8030780a199b 100644
--- a/fs/exfat/exfat_fs.h
+++ b/fs/exfat/exfat_fs.h
@@ -135,8 +135,7 @@ enum {
 #define BITMAP_OFFSET_BIT_IN_SECTOR(sb, ent) (ent & BITS_PER_SECTOR_MASK(sb))
 #define BITMAP_OFFSET_BYTE_IN_SECTOR(sb, ent) \
 	((ent / BITS_PER_BYTE) & ((sb)->s_blocksize - 1))
-#define BITS_PER_BYTE_MASK	0x7
-#define IGNORED_BITS_REMAINED(clu, clu_base) ((1 << ((clu) - (clu_base))) - 1)
+#define IGNORED_BITS_REMAINED(clu, clu_base) ((1UL << ((clu) - (clu_base))) - 1)
 
 #define ES_ENTRY_NUM(name_len)	(ES_IDX_LAST_FILENAME(name_len) + 1)
 /* 19 entries = 1 file entry + 1 stream entry + 17 filename entries */
-- 
2.43.0


