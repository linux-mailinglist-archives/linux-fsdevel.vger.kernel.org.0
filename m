Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EB8232A50D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Mar 2021 16:59:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442522AbhCBLqp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Mar 2021 06:46:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244061AbhCBFQD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Mar 2021 00:16:03 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE82BC06178A;
        Mon,  1 Mar 2021 21:05:45 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id i14so1117164pjz.4;
        Mon, 01 Mar 2021 21:05:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=D1anl8jn6mPu7AHlqJcg8Yu4vH6ItLHaH9fpY+yCyW0=;
        b=Y3100Ga6q7WjPAQDhXn46eptPJu6ADTpF6UDQ6tZvj8mmUX7xoBLxF2nhtM09Mglmf
         qqMKfHddE8wrUSeIPLx8oWwF+/F1nooz9OIds1JgE36yeZz+o0T8Wvd/EeQvnrNoM20K
         FGH4HF7aFMyrxtrp16VX6c0ZKiKVEgXrGSkFsUGGSp+2KAg/cCsdld3diLYs9G46Kthl
         VBpImFrjVj6A6rIUDcsO7qlODHyBBjPlUO7XbhC2ozDPEtwKqEfc+O5LjnAbnCdZX9/0
         P9/rA/ldt1cy9X5OANO8FsjVf4gMj8hwHl66cY+GGka2YjOGpKRI+rvbWj1o7Zq/6Z6H
         eWaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=D1anl8jn6mPu7AHlqJcg8Yu4vH6ItLHaH9fpY+yCyW0=;
        b=aci71U/iblb2Z/B9uJiyPgYm5vCmJIhXAKl6dtai6HJTTQDUmdmU8B4yltHO1sxee2
         I8HNSr9x+06VXcXn8LO2OJyC6DALo5ZsxpNHyhcnga82SFtQ8DB3cnlb3bTyYXw3HVNe
         Iq4qIrA/GV7/NxOp623+H5vwAFSKEzQDt0MvuCcXyGiZLBP3IYNhyjVv74s6tbDOA8XF
         Jkc5SSU4qPLYXjaxOuJyJby3piclIr0T/+AIlC7C5TGT+QGsafYHgTRqHl503gHgkTFS
         c40Fn0BtSRNk0m6X3dJcTq61DOCBfw4PCpmLLEMbcBTqXJuWa8YxFvcU3HQLtJLuQxpf
         /kuw==
X-Gm-Message-State: AOAM530vsXdtqhd+a80wvbtY8Z6kx4Rqxdg1pXyZzJcMjhYSFT3R4Pvv
        yOqhKDqM74WkrlQ0qsiWjT906MMyk7UrKLJK
X-Google-Smtp-Source: ABdhPJzDnpjYdXsHNmLiPZUE24aVYtgoMqXABN5pml1iFJtFT7fa1jLohpOKuRzHbAMSNc1YbdyorQ==
X-Received: by 2002:a17:902:e54e:b029:e1:2817:f900 with SMTP id n14-20020a170902e54eb02900e12817f900mr18771255plf.15.1614661545465;
        Mon, 01 Mar 2021 21:05:45 -0800 (PST)
Received: from localhost.localdomain ([27.122.242.75])
        by smtp.gmail.com with ESMTPSA id s16sm19759143pfs.39.2021.03.01.21.05.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Mar 2021 21:05:45 -0800 (PST)
From:   Hyeongseok Kim <hyeongseok@gmail.com>
To:     namjae.jeon@samsung.com, sj1557.seo@samsung.com
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Hyeongseok Kim <hyeongseok@gmail.com>
Subject: [PATCH v4 1/2] exfat: introduce bitmap_lock for cluster bitmap access
Date:   Tue,  2 Mar 2021 14:05:20 +0900
Message-Id: <20210302050521.6059-2-hyeongseok@gmail.com>
X-Mailer: git-send-email 2.27.0.83.g0313f36
In-Reply-To: <20210302050521.6059-1-hyeongseok@gmail.com>
References: <20210302050521.6059-1-hyeongseok@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

s_lock which is for protecting concurrent access of file operations is
too huge for cluster bitmap protection, so introduce a new bitmap_lock
to narrow the lock range if only need to access cluster bitmap.

Signed-off-by: Hyeongseok Kim <hyeongseok@gmail.com>
---
 fs/exfat/exfat_fs.h |  1 +
 fs/exfat/fatent.c   | 37 +++++++++++++++++++++++++++++--------
 fs/exfat/super.c    |  1 +
 3 files changed, 31 insertions(+), 8 deletions(-)

diff --git a/fs/exfat/exfat_fs.h b/fs/exfat/exfat_fs.h
index 764bc645241e..1ce422d7e9ae 100644
--- a/fs/exfat/exfat_fs.h
+++ b/fs/exfat/exfat_fs.h
@@ -238,6 +238,7 @@ struct exfat_sb_info {
 	unsigned int used_clusters; /* number of used clusters */
 
 	struct mutex s_lock; /* superblock lock */
+	struct mutex bitmap_lock; /* bitmap lock */
 	struct exfat_mount_options options;
 	struct nls_table *nls_io; /* Charset used for input and display */
 	struct ratelimit_state ratelimit;
diff --git a/fs/exfat/fatent.c b/fs/exfat/fatent.c
index 7b2e8af17193..fd6c7fd12762 100644
--- a/fs/exfat/fatent.c
+++ b/fs/exfat/fatent.c
@@ -151,13 +151,14 @@ int exfat_chain_cont_cluster(struct super_block *sb, unsigned int chain,
 	return 0;
 }
 
-int exfat_free_cluster(struct inode *inode, struct exfat_chain *p_chain)
+/* This function must be called with bitmap_lock held */
+static int __exfat_free_cluster(struct inode *inode, struct exfat_chain *p_chain)
 {
-	unsigned int num_clusters = 0;
-	unsigned int clu;
 	struct super_block *sb = inode->i_sb;
 	struct exfat_sb_info *sbi = EXFAT_SB(sb);
 	int cur_cmap_i, next_cmap_i;
+	unsigned int num_clusters = 0;
+	unsigned int clu;
 
 	/* invalid cluster number */
 	if (p_chain->dir == EXFAT_FREE_CLUSTER ||
@@ -230,6 +231,17 @@ int exfat_free_cluster(struct inode *inode, struct exfat_chain *p_chain)
 	return 0;
 }
 
+int exfat_free_cluster(struct inode *inode, struct exfat_chain *p_chain)
+{
+	int ret = 0;
+
+	mutex_lock(&EXFAT_SB(inode->i_sb)->bitmap_lock);
+	ret = __exfat_free_cluster(inode, p_chain);
+	mutex_unlock(&EXFAT_SB(inode->i_sb)->bitmap_lock);
+
+	return ret;
+}
+
 int exfat_find_last_cluster(struct super_block *sb, struct exfat_chain *p_chain,
 		unsigned int *ret_clu)
 {
@@ -328,6 +340,8 @@ int exfat_alloc_cluster(struct inode *inode, unsigned int num_alloc,
 	if (num_alloc > total_cnt - sbi->used_clusters)
 		return -ENOSPC;
 
+	mutex_lock(&sbi->bitmap_lock);
+
 	hint_clu = p_chain->dir;
 	/* find new cluster */
 	if (hint_clu == EXFAT_EOF_CLUSTER) {
@@ -338,8 +352,10 @@ int exfat_alloc_cluster(struct inode *inode, unsigned int num_alloc,
 		}
 
 		hint_clu = exfat_find_free_bitmap(sb, sbi->clu_srch_ptr);
-		if (hint_clu == EXFAT_EOF_CLUSTER)
-			return -ENOSPC;
+		if (hint_clu == EXFAT_EOF_CLUSTER) {
+			ret = -ENOSPC;
+			goto unlock;
+		}
 	}
 
 	/* check cluster validation */
@@ -349,8 +365,10 @@ int exfat_alloc_cluster(struct inode *inode, unsigned int num_alloc,
 		hint_clu = EXFAT_FIRST_CLUSTER;
 		if (p_chain->flags == ALLOC_NO_FAT_CHAIN) {
 			if (exfat_chain_cont_cluster(sb, p_chain->dir,
-					num_clusters))
-				return -EIO;
+					num_clusters)) {
+				ret = -EIO;
+				goto unlock;
+			}
 			p_chain->flags = ALLOC_FAT_CHAIN;
 		}
 	}
@@ -400,6 +418,7 @@ int exfat_alloc_cluster(struct inode *inode, unsigned int num_alloc,
 			sbi->used_clusters += num_clusters;
 
 			p_chain->size += num_clusters;
+			mutex_unlock(&sbi->bitmap_lock);
 			return 0;
 		}
 
@@ -419,7 +438,9 @@ int exfat_alloc_cluster(struct inode *inode, unsigned int num_alloc,
 	}
 free_cluster:
 	if (num_clusters)
-		exfat_free_cluster(inode, p_chain);
+		__exfat_free_cluster(inode, p_chain);
+unlock:
+	mutex_unlock(&sbi->bitmap_lock);
 	return ret;
 }
 
diff --git a/fs/exfat/super.c b/fs/exfat/super.c
index c6d8d2e53486..d38d17a77e76 100644
--- a/fs/exfat/super.c
+++ b/fs/exfat/super.c
@@ -752,6 +752,7 @@ static int exfat_init_fs_context(struct fs_context *fc)
 		return -ENOMEM;
 
 	mutex_init(&sbi->s_lock);
+	mutex_init(&sbi->bitmap_lock);
 	ratelimit_state_init(&sbi->ratelimit, DEFAULT_RATELIMIT_INTERVAL,
 			DEFAULT_RATELIMIT_BURST);
 
-- 
2.27.0.83.g0313f36

