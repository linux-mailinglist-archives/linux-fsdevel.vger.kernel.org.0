Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 569A333AA4E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Mar 2021 05:14:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229466AbhCOENd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Mar 2021 00:13:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbhCOENY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Mar 2021 00:13:24 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE84CC061574;
        Sun, 14 Mar 2021 21:13:23 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id lr1-20020a17090b4b81b02900ea0a3f38c1so1323384pjb.0;
        Sun, 14 Mar 2021 21:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+1w+xdSCd8Ke2WCXQw7fwupYKhFB/Db/6JOzUH5OA4M=;
        b=g+ctDWlh6zYMatSsVYn+os8JlCDg+zT1zIcreuYUCZZx2d7/r6UUzSAilDC++21TUW
         oVdjJAZNesCF9U+SSTaiF+lwQaT6/bpsm6RiqQi2y8w8gD6nPjiBKxbYOykx42rAdHRZ
         3gXu55Ola/y9c7OJL2B0LbaIC/0ocNsE8wKyKr8eBpyQAFzoyabbAMJ4Aqc3KeImg/8P
         dMusCYOf8lAr00J33lh+OaQTXjlCJG3aEMuHtS7xdNkUZBbGkrRsazgoQGkPgCGcd3HE
         f/PEnxBaLhUV1gAMBJodts2owGOPkZEcTn8LN7gOeq/SjZljbwi2MV22CYaYUzgCDri9
         2WKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+1w+xdSCd8Ke2WCXQw7fwupYKhFB/Db/6JOzUH5OA4M=;
        b=Qxffsawp+WqYGcyRby4+sD1B2SGtEV3C4KVnivSxrgd6GUYrsgVQx8BUhgtP6zqxA8
         Mq9P+dGcZmIhcl/Nob+Zhxeez46ex7q9Hv0BOMjpcJ8tQcoRiogqmy3E7XjQBrqh3OYP
         fO9sshTft0HVqWtcCBYQFNnrlA1nkrD9FCtlQvIOtgdwhDukaZ+S39d7HiLhorv6VjmF
         koQVIYIem7sPOx5aj6WKgvylOo9QR6nHVnExDO5G29dW7MuejT1z90QD19OwSRzYDCdl
         qHFNq51K+TBoa2H7DQSzNPd5w9B2IlztK2Uy/lo/yCPBqNyvDc2biUu6V6Y1dceAUR5n
         ihWA==
X-Gm-Message-State: AOAM532OyWQBqcwP6eSwiVh+D3qdRjztLvWVQboQsKvOaULAGDlCV6sA
        tLUrj8kYrgNpMlPs+IUtpSE=
X-Google-Smtp-Source: ABdhPJwCbBh0zjqMzS3xS3CIOrsaScPdecGECVx6lKttcjkbocirJLUPy3jMIVpU1yq/2PHWK4+hdw==
X-Received: by 2002:a17:902:e2d4:b029:e4:be01:1d9a with SMTP id l20-20020a170902e2d4b02900e4be011d9amr9651144plc.43.1615781603387;
        Sun, 14 Mar 2021 21:13:23 -0700 (PDT)
Received: from localhost.localdomain ([27.122.242.75])
        by smtp.gmail.com with ESMTPSA id z27sm10613900pff.111.2021.03.14.21.13.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Mar 2021 21:13:23 -0700 (PDT)
From:   Hyeongseok Kim <hyeongseok@gmail.com>
To:     namjae.jeon@samsung.com, sj1557.seo@samsung.com
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Hyeongseok Kim <hyeongseok@gmail.com>
Subject: [PATCH] exfat: improve write performance when dirsync enabled
Date:   Mon, 15 Mar 2021 13:12:55 +0900
Message-Id: <20210315041255.174167-1-hyeongseok@gmail.com>
X-Mailer: git-send-email 2.27.0.83.g0313f36
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Degradation of write speed caused by frequent disk access for cluster
bitmap update on every cluster allocation could be improved by
selective syncing bitmap buffer. Change to flush bitmap buffer only
for the directory related operations.

Signed-off-by: Hyeongseok Kim <hyeongseok@gmail.com>
---
 fs/exfat/balloc.c   | 4 ++--
 fs/exfat/dir.c      | 2 +-
 fs/exfat/exfat_fs.h | 4 ++--
 fs/exfat/fatent.c   | 4 ++--
 fs/exfat/inode.c    | 3 ++-
 fs/exfat/namei.c    | 2 +-
 6 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/fs/exfat/balloc.c b/fs/exfat/balloc.c
index 78bc87d5a11b..cc5cffc4a769 100644
--- a/fs/exfat/balloc.c
+++ b/fs/exfat/balloc.c
@@ -141,7 +141,7 @@ void exfat_free_bitmap(struct exfat_sb_info *sbi)
 	kfree(sbi->vol_amap);
 }
 
-int exfat_set_bitmap(struct inode *inode, unsigned int clu)
+int exfat_set_bitmap(struct inode *inode, unsigned int clu, bool sync)
 {
 	int i, b;
 	unsigned int ent_idx;
@@ -154,7 +154,7 @@ int exfat_set_bitmap(struct inode *inode, unsigned int clu)
 	b = BITMAP_OFFSET_BIT_IN_SECTOR(sb, ent_idx);
 
 	set_bit_le(b, sbi->vol_amap[i]->b_data);
-	exfat_update_bh(sbi->vol_amap[i], IS_DIRSYNC(inode));
+	exfat_update_bh(sbi->vol_amap[i], sync);
 	return 0;
 }
 
diff --git a/fs/exfat/dir.c b/fs/exfat/dir.c
index e1d5536de948..7efb1c6d4808 100644
--- a/fs/exfat/dir.c
+++ b/fs/exfat/dir.c
@@ -320,7 +320,7 @@ int exfat_alloc_new_dir(struct inode *inode, struct exfat_chain *clu)
 
 	exfat_chain_set(clu, EXFAT_EOF_CLUSTER, 0, ALLOC_NO_FAT_CHAIN);
 
-	ret = exfat_alloc_cluster(inode, 1, clu);
+	ret = exfat_alloc_cluster(inode, 1, clu, IS_DIRSYNC(inode));
 	if (ret)
 		return ret;
 
diff --git a/fs/exfat/exfat_fs.h b/fs/exfat/exfat_fs.h
index 169d0b602f5e..e77fe2f45cf2 100644
--- a/fs/exfat/exfat_fs.h
+++ b/fs/exfat/exfat_fs.h
@@ -389,7 +389,7 @@ int exfat_clear_volume_dirty(struct super_block *sb);
 #define exfat_get_next_cluster(sb, pclu) exfat_ent_get(sb, *(pclu), pclu)
 
 int exfat_alloc_cluster(struct inode *inode, unsigned int num_alloc,
-		struct exfat_chain *p_chain);
+		struct exfat_chain *p_chain, bool sync_bmap);
 int exfat_free_cluster(struct inode *inode, struct exfat_chain *p_chain);
 int exfat_ent_get(struct super_block *sb, unsigned int loc,
 		unsigned int *content);
@@ -408,7 +408,7 @@ int exfat_count_num_clusters(struct super_block *sb,
 /* balloc.c */
 int exfat_load_bitmap(struct super_block *sb);
 void exfat_free_bitmap(struct exfat_sb_info *sbi);
-int exfat_set_bitmap(struct inode *inode, unsigned int clu);
+int exfat_set_bitmap(struct inode *inode, unsigned int clu, bool sync);
 void exfat_clear_bitmap(struct inode *inode, unsigned int clu, bool sync);
 unsigned int exfat_find_free_bitmap(struct super_block *sb, unsigned int clu);
 int exfat_count_used_clusters(struct super_block *sb, unsigned int *ret_count);
diff --git a/fs/exfat/fatent.c b/fs/exfat/fatent.c
index fd6c7fd12762..e949e563443c 100644
--- a/fs/exfat/fatent.c
+++ b/fs/exfat/fatent.c
@@ -320,7 +320,7 @@ int exfat_zeroed_cluster(struct inode *dir, unsigned int clu)
 }
 
 int exfat_alloc_cluster(struct inode *inode, unsigned int num_alloc,
-		struct exfat_chain *p_chain)
+		struct exfat_chain *p_chain, bool sync_bmap)
 {
 	int ret = -ENOSPC;
 	unsigned int num_clusters = 0, total_cnt;
@@ -388,7 +388,7 @@ int exfat_alloc_cluster(struct inode *inode, unsigned int num_alloc,
 		}
 
 		/* update allocation bitmap */
-		if (exfat_set_bitmap(inode, new_clu)) {
+		if (exfat_set_bitmap(inode, new_clu, sync_bmap)) {
 			ret = -EIO;
 			goto free_cluster;
 		}
diff --git a/fs/exfat/inode.c b/fs/exfat/inode.c
index 730373e0965a..1803ef3220fd 100644
--- a/fs/exfat/inode.c
+++ b/fs/exfat/inode.c
@@ -179,7 +179,8 @@ static int exfat_map_cluster(struct inode *inode, unsigned int clu_offset,
 			return -EIO;
 		}
 
-		ret = exfat_alloc_cluster(inode, num_to_be_allocated, &new_clu);
+		ret = exfat_alloc_cluster(inode, num_to_be_allocated, &new_clu,
+				inode_needs_sync(inode));
 		if (ret)
 			return ret;
 
diff --git a/fs/exfat/namei.c b/fs/exfat/namei.c
index d9e8ec689c55..1f7b3dc66fcd 100644
--- a/fs/exfat/namei.c
+++ b/fs/exfat/namei.c
@@ -340,7 +340,7 @@ static int exfat_find_empty_entry(struct inode *inode,
 		exfat_chain_set(&clu, last_clu + 1, 0, p_dir->flags);
 
 		/* allocate a cluster */
-		ret = exfat_alloc_cluster(inode, 1, &clu);
+		ret = exfat_alloc_cluster(inode, 1, &clu, IS_DIRSYNC(inode));
 		if (ret)
 			return ret;
 
-- 
2.27.0.83.g0313f36

