Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E72024CD3E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Aug 2020 07:23:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726231AbgHUFXW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Aug 2020 01:23:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725908AbgHUFXN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Aug 2020 01:23:13 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BACD6C061385;
        Thu, 20 Aug 2020 22:23:13 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id g33so467210pgb.4;
        Thu, 20 Aug 2020 22:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5C/xEsn8ROwYG318y3OpYIMxvDvQr+/Dli3OU0hpvww=;
        b=d/gjv3ZzTq8DbI0iXJHcPVtGOf8+YVCHVAfVYQS4DZsmxI0ZlH8yieRjXB80hNi+cz
         g8mwrZmQMy08ainGih/jZfjoxK24ag7rCRUDgCSKXMN9SXNlQalMMRijuwEcam7Dl4tV
         YZ3YFEAjIdzu48E3t8jIufaD1EAxO4I1rU+D5/ScENI0r8n8yffBCeXKLRaS/XQhJjwd
         q6nxvkXuBXE1ZBkfpwrqIPefCKvv0k6PTTSBfqnLlrMWUsHa2k52CyD60MfBRFQZUQnV
         VMh0r8m2LgTIAyC91G1ctQ+J45K9+5dWx90lNGZjiQ9PQqXGUYUAAg91lWZ1sXa7cQXE
         wCaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5C/xEsn8ROwYG318y3OpYIMxvDvQr+/Dli3OU0hpvww=;
        b=cMN1ugZQFVJHdro99QAIob/6hwZEWMV8wywYItxcCO6NS30qy9z8RmLcEu3Fig4G4o
         eCMyJFbnmnZbZj9fWHIKTIHRh+YIoKcr4xdVn82ijemSf4hUCljGmnGSIrA/MC5fnJFV
         bTZWjalWf3laKObeqfH8NFSxkX9DZnRTc1/q9bHnyTpVWhH3WLBtcr5jd3RXIJrNJ9Od
         a2wINXyu/ymKPHSz6i5MDpdGXInuC+Qb1U2Ygh8FodYLXQ4xWuyCPhibNbeJtx4abUsc
         og4+fxjOE7mKPsohgaRIj7a84ykUt4riErAQeKHtRAVsTKQtg306KzfhkMLPwcOJOonC
         pydg==
X-Gm-Message-State: AOAM533azlRjTps5r5ZQRtJ0N607wOr+7JBqbMYPHz3HgPY/ULMFPp+H
        gFNOI1pDamlvdIPATjm0ro0=
X-Google-Smtp-Source: ABdhPJzZ6GMFdlI+oMFk4dy9sOL/OlTfLf5H5LxrAfB+L4i3pw2WObgKb44h95DtkTfFvpWxK1tJlw==
X-Received: by 2002:a63:6c0a:: with SMTP id h10mr1148600pgc.11.1597987393220;
        Thu, 20 Aug 2020 22:23:13 -0700 (PDT)
Received: from dc803.localdomain (flh2-125-196-131-224.osk.mesh.ad.jp. [125.196.131.224])
        by smtp.gmail.com with ESMTPSA id t19sm925602pfc.5.2020.08.20.22.23.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2020 22:23:12 -0700 (PDT)
From:   Tetsuhiro Kohada <kohada.t2@gmail.com>
To:     kohada.t2@gmail.com
Cc:     kohada.tetsuhiro@dc.mitsubishielectric.co.jp,
        mori.takahiro@ab.mitsubishielectric.co.jp,
        motai.hirotaka@aj.mitsubishielectric.co.jp,
        Namjae Jeon <namjae.jeon@samsung.com>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] exfat: write only modified part of dir-entry set
Date:   Fri, 21 Aug 2020 14:22:55 +0900
Message-Id: <20200821052255.30626-2-kohada.t2@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200821052255.30626-1-kohada.t2@gmail.com>
References: <20200821052255.30626-1-kohada.t2@gmail.com>
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

** This patch depends on:
  '[PATCH v3] exfat: integrates dir-entry getting and validation'
  '[PATCH v2] exfat: add NameLength check when extracting name'
  '[PATCH v2] exfat: unify name extraction'

Signed-off-by: Tetsuhiro Kohada <kohada.t2@gmail.com>
---
Changes in v2
 - Based on v2 'name-length' patches

 fs/exfat/dir.c      | 31 +++++++++++++++----------------
 fs/exfat/exfat_fs.h |  4 +---
 fs/exfat/file.c     |  3 +--
 fs/exfat/inode.c    |  6 ++----
 fs/exfat/namei.c    |  4 ++--
 5 files changed, 21 insertions(+), 27 deletions(-)

diff --git a/fs/exfat/dir.c b/fs/exfat/dir.c
index 6f9de364a919..ad6fef854c30 100644
--- a/fs/exfat/dir.c
+++ b/fs/exfat/dir.c
@@ -129,7 +129,7 @@ static int exfat_readdir(struct inode *inode, struct exfat_dir_entry *dir_entry)
 			dir_entry->size = le64_to_cpu(es->de_stream->valid_size);
 
 			err = exfat_get_uniname_from_name_entries(es, &uni_name);
-			exfat_free_dentry_set(es, false);
+			exfat_put_dentry_set(es, 0, false);
 			if (err)
 				return err;
 
@@ -581,21 +581,21 @@ static int exfat_calc_entry_set_chksum(struct exfat_entry_set_cache *es, u16 *ch
 	return 0;
 }
 
-void exfat_update_dir_chksum_with_entry_set(struct exfat_entry_set_cache *es)
-{
-	u16 chksum;
-
-	exfat_calc_entry_set_chksum(es, &chksum);
-	es->de_file->checksum = cpu_to_le16(chksum);
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
+			es->de_file->checksum = cpu_to_le16(chksum);
+			err = exfat_update_bhs(es->bh, modified_bh, sync);
+		}
+	}
 
 	for (i = 0; i < es->num_bh; i++)
 		if (err)
@@ -802,7 +802,6 @@ struct exfat_entry_set_cache *exfat_get_dentry_set(struct super_block *sb,
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
index 489881bf9bde..4dc5ce857d1f 100644
--- a/fs/exfat/exfat_fs.h
+++ b/fs/exfat/exfat_fs.h
@@ -170,7 +170,6 @@ struct exfat_hint {
 
 struct exfat_entry_set_cache {
 	struct super_block *sb;
-	bool modified;
 	unsigned int start_off;
 	int num_bh;
 	struct buffer_head *bh[DIR_CACHE_SIZE];
@@ -452,7 +451,6 @@ int exfat_remove_entries(struct inode *inode, struct exfat_chain *p_dir,
 		int entry, int order, int num_entries);
 int exfat_update_dir_chksum(struct inode *inode, struct exfat_chain *p_dir,
 		int entry);
-void exfat_update_dir_chksum_with_entry_set(struct exfat_entry_set_cache *es);
 int exfat_calc_num_entries(struct exfat_uni_name *p_uniname);
 int exfat_find_dir_entry(struct super_block *sb, struct exfat_inode_info *ei,
 		struct exfat_chain *p_dir, struct exfat_uni_name *p_uniname,
@@ -467,7 +465,7 @@ struct exfat_dentry *exfat_get_validated_dentry(struct exfat_entry_set_cache *es
 		int num, unsigned int type);
 struct exfat_entry_set_cache *exfat_get_dentry_set(struct super_block *sb,
 		struct exfat_chain *p_dir, int entry, int max_entries);
-int exfat_free_dentry_set(struct exfat_entry_set_cache *es, int sync);
+int exfat_put_dentry_set(struct exfat_entry_set_cache *es, int modified, int sync);
 int exfat_count_dir_entries(struct super_block *sb, struct exfat_chain *p_dir);
 
 /* inode.c */
diff --git a/fs/exfat/file.c b/fs/exfat/file.c
index e0fd4b807bed..8c6a11cccdf2 100644
--- a/fs/exfat/file.c
+++ b/fs/exfat/file.c
@@ -185,8 +185,7 @@ int __exfat_truncate(struct inode *inode, loff_t new_size)
 			es->de_stream->start_clu = EXFAT_FREE_CLUSTER;
 		}
 
-		exfat_update_dir_chksum_with_entry_set(es);
-		err = exfat_free_dentry_set(es, inode_needs_sync(inode));
+		err = exfat_put_dentry_set(es, 2, inode_needs_sync(inode));
 		if (err)
 			return err;
 	}
diff --git a/fs/exfat/inode.c b/fs/exfat/inode.c
index 358457c82270..894321b561e6 100644
--- a/fs/exfat/inode.c
+++ b/fs/exfat/inode.c
@@ -73,8 +73,7 @@ static int __exfat_write_inode(struct inode *inode, int sync)
 	es->de_stream->valid_size = cpu_to_le64(on_disk_size);
 	es->de_stream->size = es->de_stream->valid_size;
 
-	exfat_update_dir_chksum_with_entry_set(es);
-	return exfat_free_dentry_set(es, sync);
+	return exfat_put_dentry_set(es, 2, sync);
 }
 
 int exfat_write_inode(struct inode *inode, struct writeback_control *wbc)
@@ -230,8 +229,7 @@ static int exfat_map_cluster(struct inode *inode, unsigned int clu_offset,
 			es->de_stream->valid_size = cpu_to_le64(i_size_read(inode));
 			es->de_stream->size = es->de_stream->valid_size;
 
-			exfat_update_dir_chksum_with_entry_set(es);
-			err = exfat_free_dentry_set(es, inode_needs_sync(inode));
+			err = exfat_put_dentry_set(es, 2, inode_needs_sync(inode));
 			if (err)
 				return err;
 		} /* end of if != DIR_DELETED */
diff --git a/fs/exfat/namei.c b/fs/exfat/namei.c
index c190e56be3a5..e5466fe3c51f 100644
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
 				es->de_file->access_time,
 				es->de_file->access_date,
 				0);
-		exfat_free_dentry_set(es, false);
+		exfat_put_dentry_set(es, 0, false);
 
 		if (info->type == TYPE_DIR) {
 			exfat_chain_set(&cdir, info->start_clu,
-- 
2.25.1

