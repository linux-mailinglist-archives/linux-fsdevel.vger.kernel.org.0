Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19CF8ED730
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Nov 2019 02:46:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729005AbfKDBqS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 3 Nov 2019 20:46:18 -0500
Received: from outbound.smtp.vt.edu ([198.82.183.121]:35586 "EHLO
        omr2.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728957AbfKDBqR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 3 Nov 2019 20:46:17 -0500
Received: from mr2.cc.vt.edu (inbound.smtp.ipv6.vt.edu [IPv6:2607:b400:92:9:0:9d:8fcb:4116])
        by omr2.cc.vt.edu (8.14.4/8.14.4) with ESMTP id xA41kGxX009955
        for <linux-fsdevel@vger.kernel.org>; Sun, 3 Nov 2019 20:46:16 -0500
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
        by mr2.cc.vt.edu (8.14.7/8.14.7) with ESMTP id xA41kB1N008132
        for <linux-fsdevel@vger.kernel.org>; Sun, 3 Nov 2019 20:46:16 -0500
Received: by mail-qk1-f198.google.com with SMTP id q29so16276846qkn.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 03 Nov 2019 17:46:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=VeQf5dvUMCYTq4N/NiGyz5wF/1xSIPpK0MNsDI3O8wk=;
        b=nqK2h9jk99a3XBaig4zm8bnqHb342gDGJdqbJMCy5NdAeRRdFHMd8DJwafl5oTarKR
         6RCyIE7/3fHm+GLcUztUxob2KkibG6ByTa0SWqEZWKrTJP8dyyW0Ddx5ch7uRA2gZSth
         kHR7Q+Out4aoZjQd1uEZ/2SpHET6M+u9A22b++UrMwcn4t+JlpROronA3r/B5XggoE9C
         SKLlCb6gYDv13vs6v5/F3D4kxj+cpikkiwAma+vB52uV/Adpf0J3Z8mUIyw4COyzN95w
         5mcYh9lOdweb+mDvCm+1+mMp+y9aS1bUEEd9OKTyYjMtCWYu9Wx3h4BUIKJWj39tfvU/
         almQ==
X-Gm-Message-State: APjAAAUwI3UepW4YoyQIoPupqIgAtR5ZOnqdQ8OvCx0iIhS8KmK4lTjo
        shLzphJiKNmNLXouBdyWuNTEG6rAhuXtf7U1TEeRFh5Til2O/krcv3RYCuuj62yTMg8oenFwGd9
        fJbNGHfkMVbEKSJxzxEhr9aHsLIFsGdGVKTif
X-Received: by 2002:a05:620a:1437:: with SMTP id k23mr19166749qkj.15.1572831971157;
        Sun, 03 Nov 2019 17:46:11 -0800 (PST)
X-Google-Smtp-Source: APXvYqxUW2DfOBfynlFTwooIHrDSgK5vYZXoDcISYOZgDuGnrjCBbmSEAet8NVkOhW773qZ/4WylvA==
X-Received: by 2002:a05:620a:1437:: with SMTP id k23mr19166729qkj.15.1572831970803;
        Sun, 03 Nov 2019 17:46:10 -0800 (PST)
Received: from turing-police.lan ([2601:5c0:c001:c9e1::359])
        by smtp.gmail.com with ESMTPSA id d2sm8195354qkg.77.2019.11.03.17.46.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Nov 2019 17:46:09 -0800 (PST)
From:   Valdis Kletnieks <valdis.kletnieks@vt.edu>
X-Google-Original-From: Valdis Kletnieks <Valdis.Kletnieks@vt.edu>
To:     Valdis Kletnieks <Valdis.Kletnieks@vt.edu>
Cc:     Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 05/10] staging: exfat: Clean up return codes - FFS_ERROR
Date:   Sun,  3 Nov 2019 20:45:01 -0500
Message-Id: <20191104014510.102356-6-Valdis.Kletnieks@vt.edu>
X-Mailer: git-send-email 2.24.0.rc1
In-Reply-To: <20191104014510.102356-1-Valdis.Kletnieks@vt.edu>
References: <20191104014510.102356-1-Valdis.Kletnieks@vt.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Convert FFS_ERROR to -EINVAL

Signed-off-by: Valdis Kletnieks <Valdis.Kletnieks@vt.edu>
---
 drivers/staging/exfat/exfat.h       |  1 -
 drivers/staging/exfat/exfat_core.c  | 10 +++++-----
 drivers/staging/exfat/exfat_super.c | 20 ++++++++++----------
 3 files changed, 15 insertions(+), 16 deletions(-)

diff --git a/drivers/staging/exfat/exfat.h b/drivers/staging/exfat/exfat.h
index 7a817405c624..443fafe1d89d 100644
--- a/drivers/staging/exfat/exfat.h
+++ b/drivers/staging/exfat/exfat.h
@@ -216,7 +216,6 @@ static inline u16 get_row_index(u16 i)
 #define FFS_SEMAPHOREERR        6
 #define FFS_NOTOPENED           12
 #define FFS_MAXOPENED           13
-#define FFS_ERROR               19
 
 #define NUM_UPCASE              2918
 
diff --git a/drivers/staging/exfat/exfat_core.c b/drivers/staging/exfat/exfat_core.c
index 2f6e9d724625..ffcad6867ecb 100644
--- a/drivers/staging/exfat/exfat_core.c
+++ b/drivers/staging/exfat/exfat_core.c
@@ -699,7 +699,7 @@ void sync_alloc_bitmap(struct super_block *sb)
 static s32 __load_upcase_table(struct super_block *sb, sector_t sector,
 			       u32 num_sectors, u32 utbl_checksum)
 {
-	int i, ret = FFS_ERROR;
+	int i, ret = -EINVAL;
 	u32 j;
 	struct fs_info_t *p_fs = &(EXFAT_SB(sb)->fs_info);
 	struct bd_info_t *p_bd = &(EXFAT_SB(sb)->bd_info);
@@ -774,7 +774,7 @@ static s32 __load_upcase_table(struct super_block *sb, sector_t sector,
 			brelse(tmp_bh);
 		return FFS_SUCCESS;
 	}
-	ret = FFS_ERROR;
+	ret = -EINVAL;
 error:
 	if (tmp_bh)
 		brelse(tmp_bh);
@@ -784,7 +784,7 @@ static s32 __load_upcase_table(struct super_block *sb, sector_t sector,
 
 static s32 __load_default_upcase_table(struct super_block *sb)
 {
-	int i, ret = FFS_ERROR;
+	int i, ret = -EINVAL;
 	u32 j;
 	struct fs_info_t *p_fs = &(EXFAT_SB(sb)->fs_info);
 
@@ -1906,7 +1906,7 @@ static s32 __write_partial_entries_in_entry_set(struct super_block *sb,
 	return FFS_SUCCESS;
 err_out:
 	pr_debug("%s failed\n", __func__);
-	return FFS_ERROR;
+	return -EINVAL;
 }
 
 /* write back all entries in entry set */
@@ -1931,7 +1931,7 @@ s32 write_partial_entries_in_entry_set(struct super_block *sb,
 
 	/* vaidity check */
 	if (ep + count  > ((struct dentry_t *)&es->__buf) + es->num_entries)
-		return FFS_ERROR;
+		return -EINVAL;
 
 	dir.dir = GET_CLUSTER_FROM_SECTOR(es->sector);
 	dir.flags = es->alloc_flag;
diff --git a/drivers/staging/exfat/exfat_super.c b/drivers/staging/exfat/exfat_super.c
index dd6530aef63a..daded767182a 100644
--- a/drivers/staging/exfat/exfat_super.c
+++ b/drivers/staging/exfat/exfat_super.c
@@ -498,7 +498,7 @@ static int ffsGetVolInfo(struct super_block *sb, struct vol_info_t *info)
 
 	/* check the validity of pointer parameters */
 	if (!info)
-		return FFS_ERROR;
+		return -EINVAL;
 
 	/* acquire the lock for file system critical section */
 	mutex_lock(&p_fs->v_mutex);
@@ -561,7 +561,7 @@ static int ffsLookupFile(struct inode *inode, char *path, struct file_id_t *fid)
 
 	/* check the validity of pointer parameters */
 	if (!fid || !path || (*path == '\0'))
-		return FFS_ERROR;
+		return -EINVAL;
 
 	/* acquire the lock for file system critical section */
 	mutex_lock(&p_fs->v_mutex);
@@ -654,7 +654,7 @@ static int ffsCreateFile(struct inode *inode, char *path, u8 mode,
 
 	/* check the validity of pointer parameters */
 	if (!fid || !path || (*path == '\0'))
-		return FFS_ERROR;
+		return -EINVAL;
 
 	/* acquire the lock for file system critical section */
 	mutex_lock(&p_fs->v_mutex);
@@ -703,7 +703,7 @@ static int ffsReadFile(struct inode *inode, struct file_id_t *fid, void *buffer,
 
 	/* check the validity of pointer parameters */
 	if (!buffer)
-		return FFS_ERROR;
+		return -EINVAL;
 
 	/* acquire the lock for file system critical section */
 	mutex_lock(&p_fs->v_mutex);
@@ -835,7 +835,7 @@ static int ffsWriteFile(struct inode *inode, struct file_id_t *fid,
 
 	/* check the validity of pointer parameters */
 	if (!buffer)
-		return FFS_ERROR;
+		return -EINVAL;
 
 	/* acquire the lock for file system critical section */
 	mutex_lock(&p_fs->v_mutex);
@@ -1241,7 +1241,7 @@ static int ffsMoveFile(struct inode *old_parent_inode, struct file_id_t *fid,
 
 	/* check the validity of pointer parameters */
 	if (!new_path || (*new_path == '\0'))
-		return FFS_ERROR;
+		return -EINVAL;
 
 	/* acquire the lock for file system critical section */
 	mutex_lock(&p_fs->v_mutex);
@@ -1464,7 +1464,7 @@ static int ffsSetAttr(struct inode *inode, u32 attr)
 		if (p_fs->dev_ejected)
 			ret = -EIO;
 		else
-			ret = FFS_ERROR;
+			ret = -EINVAL;
 
 		if (p_fs->vol_type == EXFAT)
 			release_entry_set(es);
@@ -1756,7 +1756,7 @@ static int ffsMapCluster(struct inode *inode, s32 clu_offset, u32 *clu)
 
 	/* check the validity of pointer parameters */
 	if (!clu)
-		return FFS_ERROR;
+		return -EINVAL;
 
 	/* acquire the lock for file system critical section */
 	mutex_lock(&p_fs->v_mutex);
@@ -1908,7 +1908,7 @@ static int ffsCreateDir(struct inode *inode, char *path, struct file_id_t *fid)
 
 	/* check the validity of pointer parameters */
 	if (!fid || !path || (*path == '\0'))
-		return FFS_ERROR;
+		return -EINVAL;
 
 	/* acquire the lock for file system critical section */
 	mutex_lock(&p_fs->v_mutex);
@@ -1954,7 +1954,7 @@ static int ffsReadDir(struct inode *inode, struct dir_entry_t *dir_entry)
 
 	/* check the validity of pointer parameters */
 	if (!dir_entry)
-		return FFS_ERROR;
+		return -EINVAL;
 
 	/* check if the given file ID is opened */
 	if (fid->type != TYPE_DIR)
-- 
2.24.0.rc1

