Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2458E3437A9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Mar 2021 04:54:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbhCVDyK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 21 Mar 2021 23:54:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbhCVDxx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 21 Mar 2021 23:53:53 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3735C061574;
        Sun, 21 Mar 2021 20:53:52 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id gb6so7671254pjb.0;
        Sun, 21 Mar 2021 20:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tKxk+9eb2LGFDrzO/7ZeqqJu7fcuACwOGc2Gc2Xgf/8=;
        b=Ow5k3E6iPHAZbh9uHoSSofU/eMprWkTQkiFMxer2/+Ab5S8fCZJtYdqQM5vcJHkBx0
         CjZytXu75j4nNL9aizy6HcRUc9RK2GSG8L7OsQwvhW8Pmyh6N9m1W742trUo0ohHmkxT
         Svpue8aBm+5Aoa6hkDOI7FqqtCtnPc9FPNniFLtDGoGddhExGwbHjLa+5X4GUlrnrAWm
         6KjdNCaV/KnxyfRXL3oR/z4tMbNeEm0MQdK2Bs6YvPNRi3hZ8fuSbuwKJNNRIsObemeh
         BrTww5jTE19noJym6CXWqJUu9h1/+jQZEH+Ihv2lXjMMIEjg+Lvv9wPvlxSfVJnnn6oJ
         dD7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tKxk+9eb2LGFDrzO/7ZeqqJu7fcuACwOGc2Gc2Xgf/8=;
        b=miXmRQfwXiEQkALsscy6aJmKTZXg4b0cefJOcyiqMtvDacyXVcYO2JIoFp0KDtFBlJ
         HT25WlQYrH2BRsRK15HBw0NaFn+deMpn2ytiSZbrJMrL3iV/N8PowA+zCtDxljXvyOsR
         kgzE0x6Kd2SxhEOLC2k7tGissrQmOFDXcSgGfNccheBscRNPYYaKJK3CPAsOva5S7qF2
         N1ufl6pXBosf3gUty4YmKZ/licNYHoCRO0SSvhdr6AWU0asZgwAbILEw3i+++LR+26el
         ZpVBwF8QHmB0bKUh2qtsEybFfCkcXPCwqfm6+ozNKBYrYaSJ0MfKPyTF4eR1gUHS9Ba/
         51ug==
X-Gm-Message-State: AOAM530pE8ggyawKEO44i2+NdH8jCBDtINHCiLmMqou8rRytMIMLk91G
        m8W35J4g4iznkZsIcaPT0ak=
X-Google-Smtp-Source: ABdhPJyXNE7iXLyiFJsWlWHvXDqOBwRJ5F0wo3dNm/o7atNJWJdTxMj7kLUbS6duRcVqQ5h2LEjRNw==
X-Received: by 2002:a17:902:fe09:b029:e4:951e:2d2e with SMTP id g9-20020a170902fe09b02900e4951e2d2emr25687588plj.22.1616385232453;
        Sun, 21 Mar 2021 20:53:52 -0700 (PDT)
Received: from localhost.localdomain ([27.122.242.75])
        by smtp.gmail.com with ESMTPSA id f21sm11715222pjj.52.2021.03.21.20.53.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 21 Mar 2021 20:53:52 -0700 (PDT)
From:   Hyeongseok Kim <hyeongseok@gmail.com>
To:     namjae.jeon@samsung.com, sj1557.seo@samsung.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     Hyeongseok Kim <hyeongseok@gmail.com>
Subject: [PATCH v3] exfat: speed up iterate/lookup by fixing start point of traversing cluster chain
Date:   Mon, 22 Mar 2021 12:53:36 +0900
Message-Id: <20210322035336.81050-1-hyeongseok@gmail.com>
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
 fs/exfat/dir.c      | 19 +++++++++++++------
 fs/exfat/exfat_fs.h |  2 +-
 fs/exfat/namei.c    |  9 ++++++++-
 3 files changed, 22 insertions(+), 8 deletions(-)

diff --git a/fs/exfat/dir.c b/fs/exfat/dir.c
index 7efb1c6d4808..c4523648472a 100644
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
@@ -911,14 +911,19 @@ enum {
 };
 
 /*
- * return values:
- *   >= 0	: return dir entiry position with the name in dir
- *   -ENOENT	: entry with the name does not exist
- *   -EIO	: I/O error
+ * @ei:         inode info of parent directory
+ * @p_dir:      directory structure of parent directory
+ * @num_entries:entry size of p_uniname
+ * @hint_opt:   If p_uniname is found, filled with optimized dir/entry
+ *              for traversing cluster chain.
+ * @return:
+ *   >= 0:      file directory entry position where the name exists
+ *   -ENOENT:   entry with the name does not exist
+ *   -EIO:      I/O error
  */
 int exfat_find_dir_entry(struct super_block *sb, struct exfat_inode_info *ei,
 		struct exfat_chain *p_dir, struct exfat_uni_name *p_uniname,
-		int num_entries, unsigned int type)
+		int num_entries, unsigned int type, struct exfat_hint *hint_opt)
 {
 	int i, rewind = 0, dentry = 0, end_eidx = 0, num_ext = 0, len;
 	int order, step, name_len = 0;
@@ -995,6 +1000,8 @@ int exfat_find_dir_entry(struct super_block *sb, struct exfat_inode_info *ei,
 
 			if (entry_type == TYPE_FILE || entry_type == TYPE_DIR) {
 				step = DIRENT_STEP_FILE;
+				hint_opt->clu = clu.dir;
+				hint_opt->eidx = i;
 				if (type == TYPE_ALL || type == entry_type) {
 					num_ext = ep->dentry.file.num_ext;
 					step = DIRENT_STEP_STRM;
diff --git a/fs/exfat/exfat_fs.h b/fs/exfat/exfat_fs.h
index e77fe2f45cf2..1d6da61157c9 100644
--- a/fs/exfat/exfat_fs.h
+++ b/fs/exfat/exfat_fs.h
@@ -457,7 +457,7 @@ void exfat_update_dir_chksum_with_entry_set(struct exfat_entry_set_cache *es);
 int exfat_calc_num_entries(struct exfat_uni_name *p_uniname);
 int exfat_find_dir_entry(struct super_block *sb, struct exfat_inode_info *ei,
 		struct exfat_chain *p_dir, struct exfat_uni_name *p_uniname,
-		int num_entries, unsigned int type);
+		int num_entries, unsigned int type, struct exfat_hint *hint_opt);
 int exfat_alloc_new_dir(struct inode *inode, struct exfat_chain *clu);
 int exfat_find_location(struct super_block *sb, struct exfat_chain *p_dir,
 		int entry, sector_t *sector, int *offset);
diff --git a/fs/exfat/namei.c b/fs/exfat/namei.c
index 1f7b3dc66fcd..24b41103d1cc 100644
--- a/fs/exfat/namei.c
+++ b/fs/exfat/namei.c
@@ -596,6 +596,8 @@ static int exfat_find(struct inode *dir, struct qstr *qname,
 	struct exfat_inode_info *ei = EXFAT_I(dir);
 	struct exfat_dentry *ep, *ep2;
 	struct exfat_entry_set_cache *es;
+	/* for optimized dir & entry to prevent long traverse of cluster chain */
+	struct exfat_hint hint_opt;
 
 	if (qname->len == 0)
 		return -ENOENT;
@@ -619,7 +621,7 @@ static int exfat_find(struct inode *dir, struct qstr *qname,
 
 	/* search the file name for directories */
 	dentry = exfat_find_dir_entry(sb, ei, &cdir, &uni_name,
-			num_entries, TYPE_ALL);
+			num_entries, TYPE_ALL, &hint_opt);
 
 	if (dentry < 0)
 		return dentry; /* -error value */
@@ -628,6 +630,11 @@ static int exfat_find(struct inode *dir, struct qstr *qname,
 	info->entry = dentry;
 	info->num_subdirs = 0;
 
+	/* adjust cdir to the optimized value */
+	cdir.dir = hint_opt.clu;
+	if (cdir.flags & ALLOC_NO_FAT_CHAIN)
+		cdir.size -= dentry / sbi->dentries_per_clu;
+	dentry = hint_opt.eidx;
 	es = exfat_get_dentry_set(sb, &cdir, dentry, ES_2_ENTRIES);
 	if (!es)
 		return -EIO;
-- 
2.27.0.83.g0313f36

