Return-Path: <linux-fsdevel+bounces-68011-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA321C507CC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Nov 2025 05:10:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8038189A065
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Nov 2025 04:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 621BF2D23AD;
	Wed, 12 Nov 2025 04:09:59 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F550242D9B
	for <linux-fsdevel@vger.kernel.org>; Wed, 12 Nov 2025 04:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762920599; cv=none; b=ly4ADPEsBPVNZ+WH2Utjfq/XqWrfermQuqGHbcVx1rnapjQOJU20HdlojROgPw7wc8TK06sm6E9VNt7e896kqzYZIkladtyJ/Vra+kCVrFDEA1HQ9CTJ+MZGjI2JdsAMFS1Bt3HogDqiW799EUs7Y0TeK0I8CUJX3QW+ULQoWpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762920599; c=relaxed/simple;
	bh=iR4yKNOQ0tNli7apwCT6L6NjWO7yBdNViSU1bQ5BHIk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hpDw8rNthJ3382ETdXPqR8sJdlkVuPNd03f6UPeoWFK/Gt41sA0qxIAlkkMcBoJ1P89b+kuDftUUag/s7ZtocVOSeF6JwSkiKIuXyhNUHxkAZuJTVykdJ6xtD5Hr+N+iIBF0aL0nf+t+5Z3+gdM++wwvD5+xlAtyVL1iLLM/n+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-78af3fe5b17so310235b3a.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Nov 2025 20:09:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762920596; x=1763525396;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UKXBiT+vNywghQ1BR9yMMfLIqvXoHFk/oO2JFDTh8D8=;
        b=WEFIwITcVhOjCHeV7Vu7KN3Bm0DvSpXMe8dp/BFY3qD7Z1K6iYYSO1TIRgDZ6o+k0U
         J5jHEBUmpBKJCPTvacdWWx7MTPODv14EylObwGiKMP1EoVYK2g3XDoC2IQvtI/UoadZO
         OaLNweMNa3iBZmCXM5AADZ2//D8i27otW10MGo2YqrIv6Jje/JBOg8nRfTrPlYwXv0Sv
         a3OVdwfNwfJNjsASlXsfNicZRUe+6azx1+wFBsOlYn2v2H4cNkmNhZScSmymsLe5QH+b
         bnUl30gVReJ3dxCQffSM6KObT4rEwj3l/ZjWIXtZxE5Mg5UcOekwhr+1/T30/PBpWnnv
         HQKw==
X-Gm-Message-State: AOJu0Ywb8u+QlMBgM8rHZpXt/tMaw7OAb18KxTPMCBPzSfqNt2VsULKu
	RveHB4Zqf9Xlw6A85JmxGm2GE6W46j8Sy6SWfBjEKDabbzCIWmnjnI2DhcaQYw==
X-Gm-Gg: ASbGncsnKPEQLAqCzSOpsXvfx6h8VARSguAL14olZ7LxKLR1IyMUwT9HVS4PasgIcTq
	EZVK4oY3YWouX/epX3Ho7/iLOvTYXCWUoZ/xaJ90qke22l1dncD+TTeidw23EobjOKAJ3AvP70N
	vkuZOceX4rq7laeGQMjzHnvIEyJfF+TtAL0/oFRzdxG8DIbq4XXbJoXkSipzK4jWua1V76HaPvk
	UV02EvK0QgwraZK2C+rA/gM6LzoPLn62lhpN1GFeHVq+NDFBmJihiEKwnQLeKqjNJjUcxOgks9V
	z8j5W6VRTGGM7yMqkkOmPtdmeGBKDuKj1HqCprWoifKpWDEPg+vyI59n7tNisQ5tRrZcF+Hkn3F
	1YkpAfm3/oY2FpKlDsVJL49XFVKlGvPQaPhYM7Il+mSG35iSpPyJfxyF/2wWtL3ZAQ1Q6CXfRVm
	no6IJ15yt1UeZyzZc=
X-Google-Smtp-Source: AGHT+IH3I5IfDasBumKvlm491FimtmrK24MidEOq1U1INIrPmDqCYmSr/QLIcnzl+jK6euL/ANmqhQ==
X-Received: by 2002:a05:6a20:9190:b0:33e:779e:fa7f with SMTP id adf61e73a8af0-35909096666mr2145136637.1.1762920596051;
        Tue, 11 Nov 2025 20:09:56 -0800 (PST)
Received: from localhost.localdomain ([1.227.206.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b0c9632e22sm17344213b3a.8.2025.11.11.20.09.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 20:09:55 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Namjae Jeon <linkinjeon@kernel.org>,
	syzbot+5216036fc59c43d1ee02@syzkaller.appspotmail.com,
	Sungjong Seo <sj1557.seo@samsung.com>,
	Yuezhang Mo <Yuezhang.Mo@sony.com>
Subject: [PATCH] exfat: validate the cluster bitmap bits of directory
Date: Wed, 12 Nov 2025 13:09:32 +0900
Message-Id: <20251112040932.7312-1-linkinjeon@kernel.org>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Syzbot created this issue by testing an image that did not have the root
cluster bitmap bit marked. After accessing a file through the root
directory via exfat_lookup, when creating a file again with mkdir,
the root cluster bit can be allocated for direcotry, which can cause
the root cluster to be zeroed out and the same entry can be allocated
in the same cluster. This patch improved this issue by adding
exfat_test_bitmap to validate the cluster bits of the root directory
and directory. And the first cluster bit of the root directory should
never be unset except when storage is corrupted. This bit is set to
allow operations after mount.

Reported-by: syzbot+5216036fc59c43d1ee02@syzkaller.appspotmail.com
Tested-by: syzbot+5216036fc59c43d1ee02@syzkaller.appspotmail.com
Reviewed-by: Sungjong Seo <sj1557.seo@samsung.com>
Reviewed-by: Yuezhang Mo <Yuezhang.Mo@sony.com>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
---
 fs/exfat/balloc.c   | 28 ++++++++++++++++++++++++----
 fs/exfat/dir.c      |  5 +++++
 fs/exfat/exfat_fs.h |  5 +++--
 fs/exfat/fatent.c   |  6 +++---
 fs/exfat/super.c    | 11 +++++++++++
 5 files changed, 46 insertions(+), 9 deletions(-)

diff --git a/fs/exfat/balloc.c b/fs/exfat/balloc.c
index 2d2d510f2372..b387bf7df65e 100644
--- a/fs/exfat/balloc.c
+++ b/fs/exfat/balloc.c
@@ -183,11 +183,10 @@ void exfat_free_bitmap(struct exfat_sb_info *sbi)
 	kvfree(sbi->vol_amap);
 }
 
-int exfat_set_bitmap(struct inode *inode, unsigned int clu, bool sync)
+int exfat_set_bitmap(struct super_block *sb, unsigned int clu, bool sync)
 {
 	int i, b;
 	unsigned int ent_idx;
-	struct super_block *sb = inode->i_sb;
 	struct exfat_sb_info *sbi = EXFAT_SB(sb);
 
 	if (!is_valid_cluster(sbi, clu))
@@ -202,11 +201,10 @@ int exfat_set_bitmap(struct inode *inode, unsigned int clu, bool sync)
 	return 0;
 }
 
-int exfat_clear_bitmap(struct inode *inode, unsigned int clu, bool sync)
+int exfat_clear_bitmap(struct super_block *sb, unsigned int clu, bool sync)
 {
 	int i, b;
 	unsigned int ent_idx;
-	struct super_block *sb = inode->i_sb;
 	struct exfat_sb_info *sbi = EXFAT_SB(sb);
 
 	if (!is_valid_cluster(sbi, clu))
@@ -226,6 +224,28 @@ int exfat_clear_bitmap(struct inode *inode, unsigned int clu, bool sync)
 	return 0;
 }
 
+bool exfat_test_bitmap(struct super_block *sb, unsigned int clu)
+{
+	int i, b;
+	unsigned int ent_idx;
+	struct exfat_sb_info *sbi = EXFAT_SB(sb);
+
+	if (!sbi->vol_amap)
+		return true;
+
+	if (!is_valid_cluster(sbi, clu))
+		return false;
+
+	ent_idx = CLUSTER_TO_BITMAP_ENT(clu);
+	i = BITMAP_OFFSET_SECTOR_INDEX(sb, ent_idx);
+	b = BITMAP_OFFSET_BIT_IN_SECTOR(sb, ent_idx);
+
+	if (!test_bit_le(b, sbi->vol_amap[i]->b_data))
+		return false;
+
+	return true;
+}
+
 /*
  * If the value of "clu" is 0, it means cluster 2 which is the first cluster of
  * the cluster heap.
diff --git a/fs/exfat/dir.c b/fs/exfat/dir.c
index 7229146fe2bf..3045a58e124a 100644
--- a/fs/exfat/dir.c
+++ b/fs/exfat/dir.c
@@ -604,6 +604,11 @@ static int exfat_find_location(struct super_block *sb, struct exfat_chain *p_dir
 	if (ret)
 		return ret;
 
+	if (!exfat_test_bitmap(sb, clu)) {
+		exfat_err(sb, "failed to test cluster bit(%u)", clu);
+		return -EIO;
+	}
+
 	/* byte offset in cluster */
 	off = EXFAT_CLU_OFFSET(off, sbi);
 
diff --git a/fs/exfat/exfat_fs.h b/fs/exfat/exfat_fs.h
index 38210fb6901c..176fef62574c 100644
--- a/fs/exfat/exfat_fs.h
+++ b/fs/exfat/exfat_fs.h
@@ -452,8 +452,9 @@ int exfat_count_num_clusters(struct super_block *sb,
 /* balloc.c */
 int exfat_load_bitmap(struct super_block *sb);
 void exfat_free_bitmap(struct exfat_sb_info *sbi);
-int exfat_set_bitmap(struct inode *inode, unsigned int clu, bool sync);
-int exfat_clear_bitmap(struct inode *inode, unsigned int clu, bool sync);
+int exfat_set_bitmap(struct super_block *sb, unsigned int clu, bool sync);
+int exfat_clear_bitmap(struct super_block *sb, unsigned int clu, bool sync);
+bool exfat_test_bitmap(struct super_block *sb, unsigned int clu);
 unsigned int exfat_find_free_bitmap(struct super_block *sb, unsigned int clu);
 int exfat_count_used_clusters(struct super_block *sb, unsigned int *ret_count);
 int exfat_trim_fs(struct inode *inode, struct fstrim_range *range);
diff --git a/fs/exfat/fatent.c b/fs/exfat/fatent.c
index 825083634ba2..c9c5f2e3a05e 100644
--- a/fs/exfat/fatent.c
+++ b/fs/exfat/fatent.c
@@ -205,7 +205,7 @@ static int __exfat_free_cluster(struct inode *inode, struct exfat_chain *p_chain
 				cur_cmap_i = next_cmap_i;
 			}
 
-			err = exfat_clear_bitmap(inode, clu, (sync && IS_DIRSYNC(inode)));
+			err = exfat_clear_bitmap(sb, clu, (sync && IS_DIRSYNC(inode)));
 			if (err)
 				break;
 			clu++;
@@ -233,7 +233,7 @@ static int __exfat_free_cluster(struct inode *inode, struct exfat_chain *p_chain
 				cur_cmap_i = next_cmap_i;
 			}
 
-			if (exfat_clear_bitmap(inode, clu, (sync && IS_DIRSYNC(inode))))
+			if (exfat_clear_bitmap(sb, clu, (sync && IS_DIRSYNC(inode))))
 				break;
 
 			if (sbi->options.discard) {
@@ -409,7 +409,7 @@ int exfat_alloc_cluster(struct inode *inode, unsigned int num_alloc,
 		}
 
 		/* update allocation bitmap */
-		if (exfat_set_bitmap(inode, new_clu, sync_bmap)) {
+		if (exfat_set_bitmap(sb, new_clu, sync_bmap)) {
 			ret = -EIO;
 			goto free_cluster;
 		}
diff --git a/fs/exfat/super.c b/fs/exfat/super.c
index 7f9592856bf7..e440ab6b5562 100644
--- a/fs/exfat/super.c
+++ b/fs/exfat/super.c
@@ -626,6 +626,17 @@ static int __exfat_fill_super(struct super_block *sb,
 		goto free_bh;
 	}
 
+	if (!exfat_test_bitmap(sb, sbi->root_dir)) {
+		exfat_warn(sb, "failed to test first cluster bit of root dir(%u)",
+			   sbi->root_dir);
+		/*
+		 * The first cluster bit of the root directory should never
+		 * be unset except when storage is corrupted. This bit is
+		 * set to allow operations after mount.
+		 */
+		exfat_set_bitmap(sb, sbi->root_dir, false);
+	}
+
 	ret = exfat_count_used_clusters(sb, &sbi->used_clusters);
 	if (ret) {
 		exfat_err(sb, "failed to scan clusters");
-- 
2.25.1


