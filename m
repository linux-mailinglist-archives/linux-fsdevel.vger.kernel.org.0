Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B999133FFCE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Mar 2021 07:42:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbhCRGmK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Mar 2021 02:42:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbhCRGmE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Mar 2021 02:42:04 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13D90C06174A;
        Wed, 17 Mar 2021 23:42:04 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id j6-20020a17090adc86b02900cbfe6f2c96so2608110pjv.1;
        Wed, 17 Mar 2021 23:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wBF+Zrsy5RcLg99x0iad0jHCifJxhkyfdWdxdHS4z/4=;
        b=fNVo94/1zX5+mtczqJ6m7ToNrQjb8q1l1WyaeT2XjMzAr7FV+VYoWRFMGox7YINwSm
         e5KNgaEWYYn5Ws+aKAWO+gKlsEn0pq5nH2dhWOrd3xG4K0cXDD3nyZi58sPN65zZRw6S
         oY+nMXS3GR05/eGzqacVZ9eZzPkdj2IWWHHatwpqfi9AyKJtqCHIP2DnV4XwZMIZFqNx
         XEkhqDP0QnPAEO/o3+2h9Tl86CYmYj5VysJw6KpCpvEDVuVcTzq1PQ7eQ0D8pqeZ08MJ
         UFiBxjC/NlQXtY0gDYAH1YfME9P9NzbXpQ7WK47A8hDkIFXxTvOlv8nBYWGKuBKL8gw8
         yf2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wBF+Zrsy5RcLg99x0iad0jHCifJxhkyfdWdxdHS4z/4=;
        b=cYOgv7WVzVMqZL5/mc4IpFm61YygSPjvFdvwGgFLz71JBwEQEEu9Ucrx4JZqbVPJM8
         ujibK0Ws3KbVIAbqX7EGxFuEimEDKEXEx30aaBoqSyiZxN9rdE96nyqq/VsRwoMmaAzw
         Lm14jeNraG3Be+NcUzOotzNqEZAn5gJTGo+kAjNUDrhmwRsGapf/8uxXVdAVn9cOZfTO
         MeZcq5qlda4+BkqypBLbi0Pvj/E5CSYPJU/SHyCBt39Opjcr/DDcXYx6TqcztDt0zUPy
         TM8hdYs/Kw5sJMPRiHdOnIhbevXGEqar+yLtPhDyZ8kqU3YzrH6UPy2tAnRBuXrs31HY
         q5tw==
X-Gm-Message-State: AOAM532sP19hElQbMgne2MIFoGT0gJ1c7l4I8wYcj6iD/CTo2JwiCdAX
        M/E1ESQJoHi2KVlNLGlgMeU=
X-Google-Smtp-Source: ABdhPJzmH/BvDdX/Fory6feBgx7hqtfYkNkUXLvF6CU5eB9o6uW91oRzAriv9vzCKUqGdla92hOU+w==
X-Received: by 2002:a17:902:b781:b029:e4:545d:77 with SMTP id e1-20020a170902b781b02900e4545d0077mr8279074pls.59.1616049723669;
        Wed, 17 Mar 2021 23:42:03 -0700 (PDT)
Received: from localhost.localdomain ([27.122.242.75])
        by smtp.gmail.com with ESMTPSA id n16sm1124508pff.119.2021.03.17.23.42.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Mar 2021 23:42:03 -0700 (PDT)
From:   Hyeongseok Kim <hyeongseok@gmail.com>
To:     namjae.jeon@samsung.com, sj1557.seo@samsung.com
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Hyeongseok Kim <hyeongseok@gmail.com>
Subject: [PATCH v2] exfat: speed up iterate/lookup by fixing start point of traversing cluster chain
Date:   Thu, 18 Mar 2021 15:41:32 +0900
Message-Id: <20210318064132.78752-1-hyeongseok@gmail.com>
X-Mailer: git-send-email 2.27.0.83.g0313f36
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When directory iterate and lookup is called, there's a buggy rewinding
of start point for traversing cluster chain to the parent directory
entry's first cluster. This caused repeated cluster chain traversing
from the first entry of the parent directory that would show worse
performance if huge amounts of files exist under the parent directory.
Fix not to rewind, make continue from currently referenced cluster and
dir entry.

Tested with 50,000 files under single directory / 256GB sdcard,
with command "time ls -l > /dev/null",
Before :     0m08.69s real     0m00.27s user     0m05.91s system
After  :     0m07.01s real     0m00.25s user     0m04.34s system

Signed-off-by: Hyeongseok Kim <hyeongseok@gmail.com>
---
 fs/exfat/dir.c      | 39 ++++++++++++++++++++++++++++++++-------
 fs/exfat/exfat_fs.h |  2 +-
 fs/exfat/namei.c    |  6 ++++--
 3 files changed, 37 insertions(+), 10 deletions(-)

diff --git a/fs/exfat/dir.c b/fs/exfat/dir.c
index e1d5536de948..63f08987a8fe 100644
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
@@ -911,14 +911,24 @@ enum {
 };
 
 /*
- * return values:
- *   >= 0	: return dir entiry position with the name in dir
- *   -ENOENT	: entry with the name does not exist
- *   -EIO	: I/O error
+ * @ei:         inode info of parent directory
+ * @p_dir:      directory structure of parent directory
+ * @num_entries entry size of p_uniname
+ * @de:         If p_uniname is found, filled with optimized dir/entry
+ *              for traversing cluster chain. Basically,
+ *              (p_dir.dir+return entry) and (de.dir.dir+de.entry) are
+ *              pointing the same physical directory entry, but if
+ *              caller needs to start to traverse cluster chain,
+ *              it's better option to choose the information in de.
+ *              Caller could only trust .dir and .entry field.
+ * @return:
+ *   >= 0:      file directory entry position where the name exists
+ *   -ENOENT:   entry with the name does not exist
+ *   -EIO:      I/O error
  */
 int exfat_find_dir_entry(struct super_block *sb, struct exfat_inode_info *ei,
 		struct exfat_chain *p_dir, struct exfat_uni_name *p_uniname,
-		int num_entries, unsigned int type)
+		int num_entries, unsigned int type, struct exfat_dir_entry *de)
 {
 	int i, rewind = 0, dentry = 0, end_eidx = 0, num_ext = 0, len;
 	int order, step, name_len = 0;
@@ -933,6 +943,7 @@ int exfat_find_dir_entry(struct super_block *sb, struct exfat_inode_info *ei,
 	dentries_per_clu = sbi->dentries_per_clu;
 
 	exfat_chain_dup(&clu, p_dir);
+	exfat_chain_dup(&de->dir, p_dir);
 
 	if (hint_stat->eidx) {
 		clu.dir = hint_stat->clu;
@@ -1070,11 +1081,14 @@ int exfat_find_dir_entry(struct super_block *sb, struct exfat_inode_info *ei,
 		}
 
 		if (clu.flags == ALLOC_NO_FAT_CHAIN) {
-			if (--clu.size > 0)
+			if (--clu.size > 0) {
+				exfat_chain_dup(&de->dir, &clu);
 				clu.dir++;
+			}
 			else
 				clu.dir = EXFAT_EOF_CLUSTER;
 		} else {
+			exfat_chain_dup(&de->dir, &clu);
 			if (exfat_get_next_cluster(sb, &clu.dir))
 				return -EIO;
 		}
@@ -1101,6 +1115,17 @@ int exfat_find_dir_entry(struct super_block *sb, struct exfat_inode_info *ei,
 	return -ENOENT;
 
 found:
+	/* set as dentry in cluster */
+	de->entry = (dentry - num_ext) & (dentries_per_clu - 1);
+	/*
+	 * if dentry_set spans to the next_cluster,
+	 * e.g. (de->entry + num_ext + 1 > dentries_per_clu)
+	 * current de->dir is correct which have previous cluster info,
+	 * but if it doesn't span as below, "clu" is correct, so update.
+	 */
+	if (de->entry + num_ext + 1 <= dentries_per_clu)
+		exfat_chain_dup(&de->dir, &clu);
+
 	/* next dentry we'll find is out of this cluster */
 	if (!((dentry + 1) & (dentries_per_clu - 1))) {
 		int ret = 0;
diff --git a/fs/exfat/exfat_fs.h b/fs/exfat/exfat_fs.h
index 169d0b602f5e..5a524febb79b 100644
--- a/fs/exfat/exfat_fs.h
+++ b/fs/exfat/exfat_fs.h
@@ -457,7 +457,7 @@ void exfat_update_dir_chksum_with_entry_set(struct exfat_entry_set_cache *es);
 int exfat_calc_num_entries(struct exfat_uni_name *p_uniname);
 int exfat_find_dir_entry(struct super_block *sb, struct exfat_inode_info *ei,
 		struct exfat_chain *p_dir, struct exfat_uni_name *p_uniname,
-		int num_entries, unsigned int type);
+		int num_entries, unsigned int type, struct exfat_dir_entry *de);
 int exfat_alloc_new_dir(struct inode *inode, struct exfat_chain *clu);
 int exfat_find_location(struct super_block *sb, struct exfat_chain *p_dir,
 		int entry, sector_t *sector, int *offset);
diff --git a/fs/exfat/namei.c b/fs/exfat/namei.c
index d9e8ec689c55..0c82c72d9662 100644
--- a/fs/exfat/namei.c
+++ b/fs/exfat/namei.c
@@ -596,6 +596,8 @@ static int exfat_find(struct inode *dir, struct qstr *qname,
 	struct exfat_inode_info *ei = EXFAT_I(dir);
 	struct exfat_dentry *ep, *ep2;
 	struct exfat_entry_set_cache *es;
+	/* for optimized dir & entry to prevent long traverse of cluster chain */
+	struct exfat_dir_entry de_opt;
 
 	if (qname->len == 0)
 		return -ENOENT;
@@ -619,7 +621,7 @@ static int exfat_find(struct inode *dir, struct qstr *qname,
 
 	/* search the file name for directories */
 	dentry = exfat_find_dir_entry(sb, ei, &cdir, &uni_name,
-			num_entries, TYPE_ALL);
+			num_entries, TYPE_ALL, &de_opt);
 
 	if (dentry < 0)
 		return dentry; /* -error value */
@@ -628,7 +630,7 @@ static int exfat_find(struct inode *dir, struct qstr *qname,
 	info->entry = dentry;
 	info->num_subdirs = 0;
 
-	es = exfat_get_dentry_set(sb, &cdir, dentry, ES_2_ENTRIES);
+	es = exfat_get_dentry_set(sb, &de_opt.dir, de_opt.entry, ES_2_ENTRIES);
 	if (!es)
 		return -EIO;
 	ep = exfat_get_dentry_cached(es, 0);
-- 
2.27.0.83.g0313f36

