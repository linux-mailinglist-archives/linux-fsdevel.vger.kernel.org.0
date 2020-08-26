Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4519D252D30
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Aug 2020 13:58:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729339AbgHZL6n (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Aug 2020 07:58:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729287AbgHZL6f (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Aug 2020 07:58:35 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 111A7C061574;
        Wed, 26 Aug 2020 04:58:35 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id g1so910097pgm.9;
        Wed, 26 Aug 2020 04:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XkV0eu70Fzsf9RgbgeX6UbAWPvRKdyuzeyLolz8qXds=;
        b=CY3QGPrW6/kY1oOCWJr1ZiM3rUTVjbW//+kEJi0PLMxpA7ndYs1nnaNmhYiVduMA9f
         YzS6rxwgUKmUycBUDRB0+PjHFB6LZhNKNP4RX81XyZq4asjIlXflzqXA0VsF6fxNGSkn
         B+kujFMxePqr22Sop1JREluN3PRC73WUOglq2XjUMXr2rI4txnrXFo0S6Uifd+WrFH1J
         JfwLfPnD9de0TtA3DkjuyYbwfLsdtgMPnwA1nWDeTcvIcyCBcbE8zx0QZRE/1kbY3Eu0
         Az+L+udZVoNrD7mVhbDoYBqcps9kPE0Ug57stiKnKIK5LWZx/wW65As74GfDoPTOSv5h
         jntw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XkV0eu70Fzsf9RgbgeX6UbAWPvRKdyuzeyLolz8qXds=;
        b=ngoT8DaF+0P3CQGrmnGj+ZoC9TDWFuq3wr58Ogu++ZatM80wroX1ialjwI/rj+I1of
         Ik805Xnx8133SehBx4QpFcADxTzJMEaEI0vL/dkLXsxFbKw6dfpcLggkLeLvCH75lsJd
         XgIs3qcLy6amMOvDywDeEz8+xv5y+e43JA7sTPcDNh265LCyXHjZIzdjIY1CG+j+LtuY
         aUGv2Xl26bce6dr7eW6Qzf6ejU7lNsNfjG0vz2C51dvGvqVhXuLJFpKFU/9vDsb1R5/u
         /Ne6ChJmXnfgwMgl0knFitZF23j+VJ1SpNTCIog1ZOUCVZl7GBZf8d4Wy87z+EkqzFbI
         WMtQ==
X-Gm-Message-State: AOAM531KhMLkyvd9K96yBFcxCoSH/wPqJ2oruPM37abEUEw4urSGPAeZ
        OQGIeY4CJhpeMOM5/YmP8tBHB8/LNCA=
X-Google-Smtp-Source: ABdhPJxm7MJd97YYJHoqEy3G0oyI5waNgyb4rQh278Za45FnWrbVlOHumRdiRQMjVjApqnZ03zfZgA==
X-Received: by 2002:aa7:96db:: with SMTP id h27mr11944738pfq.26.1598443114544;
        Wed, 26 Aug 2020 04:58:34 -0700 (PDT)
Received: from dc803.localdomain (FL1-111-169-205-196.hyg.mesh.ad.jp. [111.169.205.196])
        by smtp.gmail.com with ESMTPSA id v1sm1957904pjh.16.2020.08.26.04.58.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2020 04:58:34 -0700 (PDT)
From:   Tetsuhiro Kohada <kohada.t2@gmail.com>
To:     kohada.t2@gmail.com
Cc:     kohada.tetsuhiro@dc.mitsubishielectric.co.jp,
        mori.takahiro@ab.mitsubishielectric.co.jp,
        motai.hirotaka@aj.mitsubishielectric.co.jp,
        Namjae Jeon <namjae.jeon@samsung.com>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 5/5] exfat: write only modified part of dir-entry set
Date:   Wed, 26 Aug 2020 20:57:41 +0900
Message-Id: <20200826115742.21207-5-kohada.t2@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200826115742.21207-1-kohada.t2@gmail.com>
References: <20200826115742.21207-1-kohada.t2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Currently exfat_free_dentry_set() writes all of dir-entry set.
Change it to write only the modified part of dir-entry set.
And, Integrate exfat_free_dentry_set() and
exfat_update_dir_chksum_with_entry_set() as exfat_put_dentry_set().

Signed-off-by: Tetsuhiro Kohada <kohada.t2@gmail.com>
---
Changes in v2
 - Based on v2 'name-length' patches
Changes in v3:
 - Nothing
Changes in v4:
 - Into patch series '[PATCH v4] exfat: integrates dir-entry getting and validation'

 fs/exfat/dir.c      | 31 +++++++++++++++----------------
 fs/exfat/exfat_fs.h |  4 +---
 fs/exfat/file.c     |  3 +--
 fs/exfat/inode.c    |  6 ++----
 fs/exfat/namei.c    |  4 ++--
 5 files changed, 21 insertions(+), 27 deletions(-)

diff --git a/fs/exfat/dir.c b/fs/exfat/dir.c
index d4beea796708..78539d91d3c5 100644
--- a/fs/exfat/dir.c
+++ b/fs/exfat/dir.c
@@ -129,7 +129,7 @@ static int exfat_readdir(struct inode *inode, struct exfat_dir_entry *dir_entry)
 			dir_entry->size = le64_to_cpu(ES_STREAM(es).valid_size);
 
 			err = exfat_get_uniname_from_name_entries(es, &uni_name);
-			exfat_free_dentry_set(es, false);
+			exfat_put_dentry_set(es, 0, false);
 			if (err)
 				return err;
 
@@ -580,21 +580,21 @@ static int exfat_calc_entry_set_chksum(struct exfat_entry_set_cache *es, u16 *ch
 	return 0;
 }
 
-void exfat_update_dir_chksum_with_entry_set(struct exfat_entry_set_cache *es)
-{
-	u16 chksum;
-
-	exfat_calc_entry_set_chksum(es, &chksum);
-	ES_FILE(es).checksum = cpu_to_le16(chksum);
-	es->modified = true;
-}
-
-int exfat_free_dentry_set(struct exfat_entry_set_cache *es, int sync)
+int exfat_put_dentry_set(struct exfat_entry_set_cache *es, int modified, int sync)
 {
 	int i, err = 0;
 
-	if (es->modified)
-		err = exfat_update_bhs(es->bh, es->num_bh, sync);
+	if (modified) {
+		int off = es->start_off + (modified - 1) * DENTRY_SIZE;
+		int modified_bh = min(EXFAT_B_TO_BLK(off, es->sb) + 1, es->num_bh);
+		u16 chksum;
+
+		err = exfat_calc_entry_set_chksum(es, &chksum);
+		if (!err) {
+			ES_FILE(es).checksum = cpu_to_le16(chksum);
+			err = exfat_update_bhs(es->bh, modified_bh, sync);
+		}
+	}
 
 	for (i = 0; i < es->num_bh; i++)
 		if (err)
@@ -800,7 +800,6 @@ struct exfat_entry_set_cache *exfat_get_dentry_set(struct super_block *sb,
 	if (!es)
 		return NULL;
 	es->sb = sb;
-	es->modified = false;
 	es->num_entries = 1;
 
 	/* byte offset in cluster */
@@ -861,7 +860,7 @@ struct exfat_entry_set_cache *exfat_get_dentry_set(struct super_block *sb,
 	return es;
 
 free_es:
-	exfat_free_dentry_set(es, false);
+	exfat_put_dentry_set(es, 0, false);
 	return NULL;
 }
 
@@ -973,7 +972,7 @@ int exfat_find_dir_entry(struct super_block *sb, struct exfat_inode_info *ei,
 				!exfat_get_uniname_from_name_entries(es, &uni_name) &&
 				!exfat_uniname_ncmp(sb, p_uniname->name, uni_name.name, name_len);
 
-			exfat_free_dentry_set(es, false);
+			exfat_put_dentry_set(es, 0, false);
 
 			if (found) {
 				/* set the last used position as hint */
diff --git a/fs/exfat/exfat_fs.h b/fs/exfat/exfat_fs.h
index 7057e64b405d..3354512629ac 100644
--- a/fs/exfat/exfat_fs.h
+++ b/fs/exfat/exfat_fs.h
@@ -170,7 +170,6 @@ struct exfat_hint {
 
 struct exfat_entry_set_cache {
 	struct super_block *sb;
-	bool modified;
 	unsigned int start_off;
 	int num_bh;
 	struct buffer_head *bh[DIR_CACHE_SIZE];
@@ -454,7 +453,6 @@ int exfat_remove_entries(struct inode *inode, struct exfat_chain *p_dir,
 		int entry, int order, int num_entries);
 int exfat_update_dir_chksum(struct inode *inode, struct exfat_chain *p_dir,
 		int entry);
-void exfat_update_dir_chksum_with_entry_set(struct exfat_entry_set_cache *es);
 int exfat_calc_num_entries(struct exfat_uni_name *p_uniname);
 int exfat_find_dir_entry(struct super_block *sb, struct exfat_inode_info *ei,
 		struct exfat_chain *p_dir, struct exfat_uni_name *p_uniname,
@@ -469,7 +467,7 @@ struct exfat_dentry *exfat_get_validated_dentry(struct exfat_entry_set_cache *es
 		int num, unsigned int type);
 struct exfat_entry_set_cache *exfat_get_dentry_set(struct super_block *sb,
 		struct exfat_chain *p_dir, int entry, int max_entries);
-int exfat_free_dentry_set(struct exfat_entry_set_cache *es, int sync);
+int exfat_put_dentry_set(struct exfat_entry_set_cache *es, int modified, int sync);
 int exfat_count_dir_entries(struct super_block *sb, struct exfat_chain *p_dir);
 
 /* inode.c */
diff --git a/fs/exfat/file.c b/fs/exfat/file.c
index 504ffcaffacc..d2b727effb69 100644
--- a/fs/exfat/file.c
+++ b/fs/exfat/file.c
@@ -185,8 +185,7 @@ int __exfat_truncate(struct inode *inode, loff_t new_size)
 			ES_STREAM(es).start_clu = EXFAT_FREE_CLUSTER;
 		}
 
-		exfat_update_dir_chksum_with_entry_set(es);
-		err = exfat_free_dentry_set(es, inode_needs_sync(inode));
+		err = exfat_put_dentry_set(es, 2, inode_needs_sync(inode));
 		if (err)
 			return err;
 	}
diff --git a/fs/exfat/inode.c b/fs/exfat/inode.c
index 466f0bf07f75..d587c7e02b35 100644
--- a/fs/exfat/inode.c
+++ b/fs/exfat/inode.c
@@ -73,8 +73,7 @@ static int __exfat_write_inode(struct inode *inode, int sync)
 	ES_STREAM(es).valid_size = cpu_to_le64(on_disk_size);
 	ES_STREAM(es).size = ES_STREAM(es).valid_size;
 
-	exfat_update_dir_chksum_with_entry_set(es);
-	return exfat_free_dentry_set(es, sync);
+	return exfat_put_dentry_set(es, 2, sync);
 }
 
 int exfat_write_inode(struct inode *inode, struct writeback_control *wbc)
@@ -230,8 +229,7 @@ static int exfat_map_cluster(struct inode *inode, unsigned int clu_offset,
 			ES_STREAM(es).valid_size = cpu_to_le64(i_size_read(inode));
 			ES_STREAM(es).size = ES_STREAM(es).valid_size;
 
-			exfat_update_dir_chksum_with_entry_set(es);
-			err = exfat_free_dentry_set(es, inode_needs_sync(inode));
+			err = exfat_put_dentry_set(es, 2, inode_needs_sync(inode));
 			if (err)
 				return err;
 		} /* end of if != DIR_DELETED */
diff --git a/fs/exfat/namei.c b/fs/exfat/namei.c
index d2b9044d0b31..283650825115 100644
--- a/fs/exfat/namei.c
+++ b/fs/exfat/namei.c
@@ -677,7 +677,7 @@ static int exfat_find(struct inode *dir, struct qstr *qname,
 			exfat_fs_error(sb,
 				"non-zero size file starts with zero cluster (size : %llu, p_dir : %u, entry : 0x%08x)",
 				i_size_read(dir), ei->dir.dir, ei->entry);
-			exfat_free_dentry_set(es, false);
+			exfat_put_dentry_set(es, 0, false);
 			return -EIO;
 		}
 
@@ -696,7 +696,7 @@ static int exfat_find(struct inode *dir, struct qstr *qname,
 				ES_FILE(es).access_time,
 				ES_FILE(es).access_date,
 				0);
-		exfat_free_dentry_set(es, false);
+		exfat_put_dentry_set(es, 0, false);
 
 		if (info->type == TYPE_DIR) {
 			exfat_chain_set(&cdir, info->start_clu,
-- 
2.25.1

