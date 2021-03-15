Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 615FB33AA7D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Mar 2021 05:35:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbhCOEds (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Mar 2021 00:33:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbhCOEdd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Mar 2021 00:33:33 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2DA4C061574;
        Sun, 14 Mar 2021 21:33:32 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id y67so5797026pfb.2;
        Sun, 14 Mar 2021 21:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/HsZbT5lzvgBlZlcp2Dp1c0yXbo+T88tV6862N4/Jqk=;
        b=Wv6RVEmnRZlRi7RTPYrdnTPxIyYWMFQ2IXkodjBZqaPi+ssaMN3MKw54KjsQ/29VIY
         20GD5jcYJK0CaM0YZfhcEMp0R2ZzuxaTrpoDYdGhXaNDH0PtuX1UirV0addAqvFTDS8N
         ELgQtzyr2NTW6hpzT+dB7nuEDNAFye3ZU/rLfSZTFX1gwJDiPx7NAV7BIZHrdUepdrr1
         AS0dYSuBqRG20KPWdV15SYrGiCRBNtGgetO4vdK4EZrFtbuAOELVExfJT7BksA0hGMDR
         +gb1zwuo+JapB78EBRTn6RqsG8qEVfj5Ddqe227ZGKAYIXoB+s3LnfKg24dO3K/G1XwM
         vPug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/HsZbT5lzvgBlZlcp2Dp1c0yXbo+T88tV6862N4/Jqk=;
        b=H6NXgrA+amjC+jejW5TYExP/iKyMjjqOJYUDcOIKsNlCpR0A/UYmRLudyPYcsoUbSb
         j8QN+rcHze/kVxHcZY7OrpU/LX4UpDCtJCvbxjH5HSak0/RpxY0QBmAlq0xiEO7Am7E4
         ys5FiNJdwqnqXWiLV8TEtaiovMOIFawv0yycm8AovmX/GWBP0BscX5B+TWe/Q8QXo+89
         z+xqV5i6tOS1xdX6aKs9+mGrTMF23nji/fkD8HZe7mEloZ897tULDP/C1OUuVcr2fveT
         EWE750rv6wxbyk32QgFYOTr1mFAkE5M5LjPiB4a9cgRn3KiWf1mY1Um7gKiX/sKRu1+d
         o5XA==
X-Gm-Message-State: AOAM531tc7UtwodVjPwSrjqiAusef7Ru1m3rxlaxJDL4ZOMbX8794wKS
        KLbA1PsjEFnZ7O13wWCYxj4=
X-Google-Smtp-Source: ABdhPJwi8YGWPS0A9nyOa8Fi3V36gDSdc8qXHYzbQCViUfAL1Wve9KC98bEQ8ZBMBxZ1nBQFvUBBeQ==
X-Received: by 2002:a63:7c45:: with SMTP id l5mr21833978pgn.156.1615782812346;
        Sun, 14 Mar 2021 21:33:32 -0700 (PDT)
Received: from localhost.localdomain ([27.122.242.75])
        by smtp.gmail.com with ESMTPSA id z25sm11673511pfn.37.2021.03.14.21.33.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Mar 2021 21:33:32 -0700 (PDT)
From:   Hyeongseok Kim <hyeongseok@gmail.com>
To:     namjae.jeon@samsung.com, sj1557.seo@samsung.com
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Hyeongseok Kim <hyeongseok@gmail.com>
Subject: [PATCH] exfat: speed up iterate/lookup by fixing start point of traversing fat chain
Date:   Mon, 15 Mar 2021 13:33:16 +0900
Message-Id: <20210315043316.54508-1-hyeongseok@gmail.com>
X-Mailer: git-send-email 2.27.0.83.g0313f36
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When directory iterate and lookup is called, there is a buggy rewinding
of start point for traversing fat chain to the directory entry's first
cluster. This caused repeated fat chain traversing from the first entry
of the directory that would show worse performance if huge amounts of
files exist under single directory.
Fix not to rewind, make continue from currently referenced cluster and
dir entry.

Tested with 50,000 files under single directory / 256GB sdcard,
with command "time ls -l > /dev/null",
Before :     0m08.69s real     0m00.27s user     0m05.91s system
After  :     0m07.01s real     0m00.25s user     0m04.34s system

Signed-off-by: Hyeongseok Kim <hyeongseok@gmail.com>
---
 fs/exfat/dir.c | 42 +++++++++++++++++++++++++++++++++---------
 1 file changed, 33 insertions(+), 9 deletions(-)

diff --git a/fs/exfat/dir.c b/fs/exfat/dir.c
index e1d5536de948..59d12eaa0649 100644
--- a/fs/exfat/dir.c
+++ b/fs/exfat/dir.c
@@ -147,7 +147,7 @@ static int exfat_readdir(struct inode *inode, loff_t *cpos, struct exfat_dir_ent
 					0);
 
 			*uni_name.name = 0x0;
-			exfat_get_uniname_from_ext_entry(sb, &dir, dentry,
+			exfat_get_uniname_from_ext_entry(sb, &clu, i,
 				uni_name.name);
 			exfat_utf16_to_nls(sb, &uni_name,
 				dir_entry->namebuf.lfn,
@@ -911,10 +911,15 @@ enum {
 };
 
 /*
- * return values:
- *   >= 0	: return dir entiry position with the name in dir
- *   -ENOENT	: entry with the name does not exist
- *   -EIO	: I/O error
+ * @ei:         inode info of directory
+ * @p_dir:      input as directory structure in which we search name
+ *              if found, output as a cluster dir where the name exists
+ *              if not found, not changed from input
+ * @num_entries entry size of p_uniname
+ * @return:
+ *   >= 0:      dir entry position from output p_dir.dir
+ *   -ENOENT:   entry with the name does not exist
+ *   -EIO:      I/O error
  */
 int exfat_find_dir_entry(struct super_block *sb, struct exfat_inode_info *ei,
 		struct exfat_chain *p_dir, struct exfat_uni_name *p_uniname,
@@ -925,14 +930,16 @@ int exfat_find_dir_entry(struct super_block *sb, struct exfat_inode_info *ei,
 	int dentries_per_clu, num_empty = 0;
 	unsigned int entry_type;
 	unsigned short *uniname = NULL;
-	struct exfat_chain clu;
+	struct exfat_chain clu, tmp_clu;
 	struct exfat_hint *hint_stat = &ei->hint_stat;
 	struct exfat_hint_femp candi_empty;
 	struct exfat_sb_info *sbi = EXFAT_SB(sb);
+	int dentry_in_cluster = 0;
 
 	dentries_per_clu = sbi->dentries_per_clu;
 
 	exfat_chain_dup(&clu, p_dir);
+	exfat_chain_dup(&tmp_clu, p_dir);
 
 	if (hint_stat->eidx) {
 		clu.dir = hint_stat->clu;
@@ -1070,11 +1077,14 @@ int exfat_find_dir_entry(struct super_block *sb, struct exfat_inode_info *ei,
 		}
 
 		if (clu.flags == ALLOC_NO_FAT_CHAIN) {
-			if (--clu.size > 0)
+			if (--clu.size > 0) {
+				exfat_chain_dup(&tmp_clu, &clu);
 				clu.dir++;
+			}
 			else
 				clu.dir = EXFAT_EOF_CLUSTER;
 		} else {
+			exfat_chain_dup(&tmp_clu, &clu);
 			if (exfat_get_next_cluster(sb, &clu.dir))
 				return -EIO;
 		}
@@ -1101,6 +1111,16 @@ int exfat_find_dir_entry(struct super_block *sb, struct exfat_inode_info *ei,
 	return -ENOENT;
 
 found:
+	/*
+	 * if dentry_set would span to the next_cluster,
+	 * e.g. (dentries_per_clu - dentry_in_cluster < num_ext + 1)
+	 * "tmp_clu" is correct which is currently saved as previous cluster,
+	 * if doesn't span as below, "clu" is correct, so update for return.
+	 */
+	dentry_in_cluster = (dentry - num_ext) & (dentries_per_clu - 1);
+	if (dentries_per_clu - dentry_in_cluster >= num_ext + 1)
+		exfat_chain_dup(&tmp_clu, &clu);
+
 	/* next dentry we'll find is out of this cluster */
 	if (!((dentry + 1) & (dentries_per_clu - 1))) {
 		int ret = 0;
@@ -1118,13 +1138,17 @@ int exfat_find_dir_entry(struct super_block *sb, struct exfat_inode_info *ei,
 			/* just initialized hint_stat */
 			hint_stat->clu = p_dir->dir;
 			hint_stat->eidx = 0;
-			return (dentry - num_ext);
+
+			exfat_chain_dup(p_dir, &tmp_clu);
+			return dentry_in_cluster;
 		}
 	}
 
 	hint_stat->clu = clu.dir;
 	hint_stat->eidx = dentry + 1;
-	return dentry - num_ext;
+
+	exfat_chain_dup(p_dir, &tmp_clu);
+	return dentry_in_cluster;
 }
 
 int exfat_count_ext_entries(struct super_block *sb, struct exfat_chain *p_dir,
-- 
2.27.0.83.g0313f36

