Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10C4232A511
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Mar 2021 16:59:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442775AbhCBLqy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Mar 2021 06:46:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381338AbhCBFVN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Mar 2021 00:21:13 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AFC2C06178A;
        Mon,  1 Mar 2021 21:20:32 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id b21so13109765pgk.7;
        Mon, 01 Mar 2021 21:20:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KsTquK6HBVR6gWCGt6Eda/Orp7nGuXw2ak/HYVfr530=;
        b=mLlFmfHeXvQ/VkA/Wfw2tspq7RS/aGONP8mHoC22l1G0FNA+Si3IPaUoQ1AdtVnXfP
         XBulWzzgQmGRAJ/+5IcRN16LHpZy4sZQlFwL+/kgjVvJxSQY/drXOMJDwHKjwxb1GLJF
         a7AgHDM7FOBvZNHGJ5gMZ1Jyom0V31mwvSlxBIjxillR/aS17zTkW6EUoaLUXkQrnpx9
         HtJpPa3Dijh/Lclb8Sz6JtZNRsGppymd+r/vhxHOEP+y6fRFuRETfLcyzsQgu0XkbXmp
         abGSD+IqFG7DNonD16cUcKW0hECL4lJ9TvE70wqjsbS5f7zZk8odUgNDjL1/RPHZAm6M
         iGag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KsTquK6HBVR6gWCGt6Eda/Orp7nGuXw2ak/HYVfr530=;
        b=Vq+xYtf0JQTVKYQ3sHeJ8TjZoBHktX2od5UAFiB0WeckyoS7XMy/SljWFYRWrdwWvi
         mskrHhs4SDx7O00FSRZUfBL+t9/nbtoUkv5c4VC4Yxi6NLP7EUc8JbdusTqGkvILH3CP
         OTHQO1nCZgMg2HZfP6qDNTCGXveUCGKpBjsZZyGipwaUtIN5O05yd8feRkmKQXcup3/0
         pwA1eHU8zLkVdC4LZI2HW4vQjoYRmuN4oIGpC79IH7LPEFZXRvO6GdtyrMfGF8nA32yR
         V1V3DViR9olYBWPu58oHPyQYQY40G2CMpdmVgZ4BqJQttp8uOrOWAqEbvLrcM7cqnPDj
         ofTw==
X-Gm-Message-State: AOAM530ctiMO7eT9nnU6I0/jfj87QuhIj4p3OwabHy6tamWVVfyxLumS
        kg7d6HTFqcfSn3qe2w6UmclHKxTiuASG6Y0K
X-Google-Smtp-Source: ABdhPJxxmn/B65WAfgRf/VRTzB8BCiZPhr+/H/PiDfKC6ie9BUW3FKKNJsJ900xOeHByhwOwTH1o/g==
X-Received: by 2002:a62:800d:0:b029:1ee:2fc7:b9ee with SMTP id j13-20020a62800d0000b02901ee2fc7b9eemr1808233pfd.34.1614662431914;
        Mon, 01 Mar 2021 21:20:31 -0800 (PST)
Received: from localhost.localdomain ([27.122.242.75])
        by smtp.gmail.com with ESMTPSA id i13sm18784100pfe.46.2021.03.01.21.20.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Mar 2021 21:20:31 -0800 (PST)
From:   Hyeongseok Kim <hyeongseok@gmail.com>
To:     namjae.jeon@samsung.com, sj1557.seo@samsung.com
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hyeongseok Kim <hyeongseok@gmail.com>
Subject: [PATCH v2] exfat: fix erroneous discard when clear cluster bit
Date:   Tue,  2 Mar 2021 14:20:20 +0900
Message-Id: <20210302052020.63598-1-hyeongseok@gmail.com>
X-Mailer: git-send-email 2.27.0.83.g0313f36
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

If mounted with discard option, exFAT issues discard command when clear
cluster bit to remove file. But the input parameter of cluster-to-sector
calculation is abnormally added by reserved cluster size which is 2,
leading to discard unrelated sectors included in target+2 cluster.
With fixing this, remove the wrong comments in set/clear/find bitmap
functions.

Fixes: 1e49a94cf707 ("exfat: add bitmap operations")
Signed-off-by: Hyeongseok Kim <hyeongseok@gmail.com>
Acked-by: Sungjong Seo <sj1557.seo@samsung.com>
---
 fs/exfat/balloc.c | 15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

diff --git a/fs/exfat/balloc.c b/fs/exfat/balloc.c
index 761c79c3a4ba..54f1bcbddb26 100644
--- a/fs/exfat/balloc.c
+++ b/fs/exfat/balloc.c
@@ -141,10 +141,6 @@ void exfat_free_bitmap(struct exfat_sb_info *sbi)
 	kfree(sbi->vol_amap);
 }
 
-/*
- * If the value of "clu" is 0, it means cluster 2 which is the first cluster of
- * the cluster heap.
- */
 int exfat_set_bitmap(struct inode *inode, unsigned int clu)
 {
 	int i, b;
@@ -162,10 +158,6 @@ int exfat_set_bitmap(struct inode *inode, unsigned int clu)
 	return 0;
 }
 
-/*
- * If the value of "clu" is 0, it means cluster 2 which is the first cluster of
- * the cluster heap.
- */
 void exfat_clear_bitmap(struct inode *inode, unsigned int clu, bool sync)
 {
 	int i, b;
@@ -186,8 +178,7 @@ void exfat_clear_bitmap(struct inode *inode, unsigned int clu, bool sync)
 		int ret_discard;
 
 		ret_discard = sb_issue_discard(sb,
-			exfat_cluster_to_sector(sbi, clu +
-						EXFAT_RESERVED_CLUSTERS),
+			exfat_cluster_to_sector(sbi, clu),
 			(1 << sbi->sect_per_clus_bits), GFP_NOFS, 0);
 
 		if (ret_discard == -EOPNOTSUPP) {
@@ -197,10 +188,6 @@ void exfat_clear_bitmap(struct inode *inode, unsigned int clu, bool sync)
 	}
 }
 
-/*
- * If the value of "clu" is 0, it means cluster 2 which is the first cluster of
- * the cluster heap.
- */
 unsigned int exfat_find_free_bitmap(struct super_block *sb, unsigned int clu)
 {
 	unsigned int i, map_i, map_b, ent_idx;
-- 
2.27.0.83.g0313f36

