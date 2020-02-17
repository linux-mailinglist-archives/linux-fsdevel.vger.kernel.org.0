Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2906C160B95
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2020 08:29:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbgBQH3r (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Feb 2020 02:29:47 -0500
Received: from mx04.melco.co.jp ([192.218.140.144]:57118 "EHLO
        mx04.melco.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726289AbgBQH3r (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Feb 2020 02:29:47 -0500
Received: from mr04.melco.co.jp (mr04 [133.141.98.166])
        by mx04.melco.co.jp (Postfix) with ESMTP id 3E9243A2BEF;
        Mon, 17 Feb 2020 16:29:45 +0900 (JST)
Received: from mr04.melco.co.jp (unknown [127.0.0.1])
        by mr04.imss (Postfix) with ESMTP id 48LbGd1BwZzRk5N;
        Mon, 17 Feb 2020 16:29:45 +0900 (JST)
Received: from mf04_second.melco.co.jp (unknown [192.168.20.184])
        by mr04.melco.co.jp (Postfix) with ESMTP id 48LbGd0tffzRk4d;
        Mon, 17 Feb 2020 16:29:45 +0900 (JST)
Received: from mf04.melco.co.jp (unknown [133.141.98.184])
        by mf04_second.melco.co.jp (Postfix) with ESMTP id 48LbGd0sHqzRkBH;
        Mon, 17 Feb 2020 16:29:45 +0900 (JST)
Received: from tux532.tad.melco.co.jp (unknown [133.141.243.226])
        by mf04.melco.co.jp (Postfix) with ESMTP id 48LbGd0PvgzRk9J;
        Mon, 17 Feb 2020 16:29:45 +0900 (JST)
Received:  from tux532.tad.melco.co.jp
        by tux532.tad.melco.co.jp (unknown) with ESMTP id 01H7TidH027723;
        Mon, 17 Feb 2020 16:29:44 +0900
Received: from tux390.tad.melco.co.jp (tux390.tad.melco.co.jp [127.0.0.1])
        by postfix.imss70 (Postfix) with ESMTP id B298217E075;
        Mon, 17 Feb 2020 16:29:44 +0900 (JST)
Received: from tux554.tad.melco.co.jp (tux100.tad.melco.co.jp [10.168.7.223])
        by tux390.tad.melco.co.jp (Postfix) with ESMTP id 9BBC317E073;
        Mon, 17 Feb 2020 16:29:44 +0900 (JST)
Received: from tux554.tad.melco.co.jp
        by tux554.tad.melco.co.jp (unknown) with ESMTP id 01H7Th9I002105;
        Mon, 17 Feb 2020 16:29:44 +0900
From:   Tetsuhiro Kohada <Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp>
To:     Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp
Cc:     Mori.Takahiro@ab.MitsubishiElectric.co.jp,
        motai.hirotaka@aj.mitsubishielectric.co.jp,
        Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] staging: exfat: dedicate count_entries() to sub-dir counting.
Date:   Mon, 17 Feb 2020 16:29:41 +0900
Message-Id: <20200217072941.34116-2-Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200217072941.34116-1-Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp>
References: <20200217072941.34116-1-Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

count_entries() function is only used to count sub-dirs.
Clarify the role and rename to count_dir_entries().

Signed-off-by: Tetsuhiro Kohada <Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp>
---
Changes in v3:
- Rebase to staging-next.

Changes in v2:
- Rebase to linux-next-next-20200213.

 drivers/staging/exfat/exfat.h       | 2 +-
 drivers/staging/exfat/exfat_core.c  | 8 ++------
 drivers/staging/exfat/exfat_super.c | 4 ++--
 3 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/exfat/exfat.h b/drivers/staging/exfat/exfat.h
index ca9d3b5a3076..c4ef6c2de329 100644
--- a/drivers/staging/exfat/exfat.h
+++ b/drivers/staging/exfat/exfat.h
@@ -683,7 +683,7 @@ struct entry_set_cache_t *get_entry_set_in_dir(struct super_block *sb,
 					       u32 type,
 					       struct dentry_t **file_ep);
 void release_entry_set(struct entry_set_cache_t *es);
-s32 count_entries(struct super_block *sb, struct chain_t *p_dir, u32 type);
+s32 count_dir_entries(struct super_block *sb, struct chain_t *p_dir);
 void update_dir_checksum(struct super_block *sb, struct chain_t *p_dir,
 			 s32 entry);
 void update_dir_checksum_with_entry_set(struct super_block *sb,
diff --git a/drivers/staging/exfat/exfat_core.c b/drivers/staging/exfat/exfat_core.c
index 94a10c5984ac..7308e50c0aaf 100644
--- a/drivers/staging/exfat/exfat_core.c
+++ b/drivers/staging/exfat/exfat_core.c
@@ -1850,7 +1850,7 @@ s32 exfat_count_ext_entries(struct super_block *sb, struct chain_t *p_dir,
 	return count;
 }
 
-s32 count_entries(struct super_block *sb, struct chain_t *p_dir, u32 type)
+s32 count_dir_entries(struct super_block *sb, struct chain_t *p_dir)
 {
 	int i, count = 0;
 	s32 dentries_per_clu;
@@ -1881,11 +1881,7 @@ s32 count_entries(struct super_block *sb, struct chain_t *p_dir, u32 type)
 
 			if (entry_type == TYPE_UNUSED)
 				return count;
-			if (!(type & TYPE_CRITICAL_PRI) &&
-			    !(type & TYPE_BENIGN_PRI))
-				continue;
-
-			if ((type == TYPE_ALL) || (type == entry_type))
+			if (entry_type == TYPE_DIR)
 				count++;
 		}
 
diff --git a/drivers/staging/exfat/exfat_super.c b/drivers/staging/exfat/exfat_super.c
index f31f771a3dc0..b398114c2604 100644
--- a/drivers/staging/exfat/exfat_super.c
+++ b/drivers/staging/exfat/exfat_super.c
@@ -1468,7 +1468,7 @@ static int ffsReadStat(struct inode *inode, struct dir_entry_t *info)
 						p_fs->cluster_size_bits;
 			}
 
-			count = count_entries(sb, &dir, TYPE_DIR);
+			count = count_dir_entries(sb, &dir);
 			if (count < 0) {
 				ret = count; /* propagate error upward */
 				goto out;
@@ -1535,7 +1535,7 @@ static int ffsReadStat(struct inode *inode, struct dir_entry_t *info)
 			info->Size = (u64)count_num_clusters(sb, &dir) <<
 					p_fs->cluster_size_bits;
 
-		count = count_entries(sb, &dir, TYPE_DIR);
+		count = count_dir_entries(sb, &dir);
 		if (count < 0) {
 			ret = count; /* propagate error upward */
 			goto out;
-- 
2.25.0

