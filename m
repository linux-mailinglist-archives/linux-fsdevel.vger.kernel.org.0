Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 955E323E7FC
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Aug 2020 09:31:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbgHGHbF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Aug 2020 03:31:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbgHGHbD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Aug 2020 03:31:03 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EAABC061574;
        Fri,  7 Aug 2020 00:31:03 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id p8so475118pgn.13;
        Fri, 07 Aug 2020 00:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=j/tKfHmwWJwQDecwrx5B4VWpoeSrl5octzTk1kI1X8w=;
        b=Q5ln+FwrJbzgmWB7dxJOrvPFLK5ormKbcGO0Kpu4B3O5zhe4qn0nDFJuUxhMHhwAf6
         f0ND5gd6uFjqagBaLF/pbN6Af2uDiqaQAebdAAMYhfGSBwJdE016oVfgJrtZhunUYcIE
         QHAIF8AVCI7aLJ0Mzp00kjB+dcE/Rj0oPcJnSrTsuHslaCJ6kJVI1NEINDn1LHi+d1Pu
         pCxWqK7mGAAjMV7DsLCfMLa72HqtFuRH0kz6xr2Eh419YaHhmwFu4tR/S0TSO7g03tUP
         q13ckARn6Z4gfwh0PXlLWK6n2dmVP2ktc+l6KVAG+Tq/AAGUecc4iYUubSekPIuTjKsI
         hEVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j/tKfHmwWJwQDecwrx5B4VWpoeSrl5octzTk1kI1X8w=;
        b=SfVWi3at+evKNDdhYv1yAmCd07UkE1+TxEKl+L91hVvmfaSzY9cl8tPewbAwkQNE8z
         wiANOvfwrsERq6cDdDrDf5tVMQHrJbPWvroylgFWt0uVWaVhSLdF/9gEIw/UJtVTnCD5
         x8sbz1roVA5kvzITb4haz77yVvVdSEMNMfSW5inPn5Y7LqaR+SITdi40APcjyIpvdDqx
         TRXSiWsUdGqbo50jWLUmkU6t9SJCOgreHZc3sn4qI64asFxZquJA9wHH1ParIDgWtq7J
         fdVa8bWTMndiE2YaTo8XOuZ7qRaISn8uCBKcW9Evjsve7eK4ZqYoat0IgdcZ4V8RHmFf
         P/Ow==
X-Gm-Message-State: AOAM531OvjlXM2cV4dbKWbVqyMMQZegI9rgEgt4oSokUjpwXU34DieIb
        ++Ed8vv3ZMLXDqWmgNZtwUs=
X-Google-Smtp-Source: ABdhPJw0C76RwpL3s+mPaz1mlZlTJW5bbh8d37QMSeSL/TrrOSe/lZd1EQdukEVjh7mtPsLw/jiMpQ==
X-Received: by 2002:a65:63ca:: with SMTP id n10mr10898129pgv.252.1596785462817;
        Fri, 07 Aug 2020 00:31:02 -0700 (PDT)
Received: from dc803.localdomain (FL1-218-42-16-224.hyg.mesh.ad.jp. [218.42.16.224])
        by smtp.gmail.com with ESMTPSA id y7sm10020079pjm.3.2020.08.07.00.31.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2020 00:31:02 -0700 (PDT)
From:   Tetsuhiro Kohada <kohada.t2@gmail.com>
To:     kohada.t2@gmail.com
Cc:     kohada.tetsuhiro@dc.mitsubishielectric.co.jp,
        mori.takahiro@ab.mitsubishielectric.co.jp,
        motai.hirotaka@aj.mitsubishielectric.co.jp,
        Namjae Jeon <namjae.jeon@samsung.com>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] exfat: write only modified part of dir-entry set
Date:   Fri,  7 Aug 2020 16:30:49 +0900
Message-Id: <20200807073049.24959-2-kohada.t2@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200807073049.24959-1-kohada.t2@gmail.com>
References: <20200807073049.24959-1-kohada.t2@gmail.com>
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
  '[PATCH] exfat: add NameLength check when extracting name'
  '[PATCH] exfat: unify name extraction'

Signed-off-by: Tetsuhiro Kohada <kohada.t2@gmail.com>
---
 fs/exfat/dir.c      | 33 ++++++++++++++++-----------------
 fs/exfat/exfat_fs.h |  4 +---
 fs/exfat/file.c     |  3 +--
 fs/exfat/inode.c    |  6 ++----
 fs/exfat/namei.c    |  4 ++--
 5 files changed, 22 insertions(+), 28 deletions(-)

diff --git a/fs/exfat/dir.c b/fs/exfat/dir.c
index 2e79ac464f5f..5071a05f1150 100644
--- a/fs/exfat/dir.c
+++ b/fs/exfat/dir.c
@@ -133,7 +133,7 @@ static int exfat_readdir(struct inode *inode, struct exfat_dir_entry *dir_entry)
 				dir_entry->namebuf.lfn,
 				dir_entry->namebuf.lfnbuf_len);
 
-			exfat_free_dentry_set(es, false);
+			exfat_put_dentry_set(es, 0, false);
 
 			ei->hint_bmap.off = dentry >> dentries_per_clu_bits;
 			ei->hint_bmap.clu = clu.dir;
@@ -579,21 +579,21 @@ static int exfat_calc_dir_chksum_with_entry_set(struct exfat_entry_set_cache *es
 	return 0;
 }
 
-void exfat_update_dir_chksum_with_entry_set(struct exfat_entry_set_cache *es)
-{
-	u16 chksum;
-
-	exfat_calc_dir_chksum_with_entry_set(es, &chksum);
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
+		err = exfat_calc_dir_chksum_with_entry_set(es, &chksum);
+		if (!err) {
+			es->de_file->checksum = cpu_to_le16(chksum);
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
@@ -857,7 +856,7 @@ struct exfat_entry_set_cache *exfat_get_dentry_set(struct super_block *sb,
 	return es;
 
 free_es:
-	exfat_free_dentry_set(es, false);
+	exfat_put_dentry_set(es, 0, false);
 	return NULL;
 }
 
@@ -962,7 +961,7 @@ int exfat_find_dir_entry(struct super_block *sb, struct exfat_inode_info *ei,
 			num_ext = es->de_file->num_ext;
 			name_hash = le16_to_cpu(es->de_stream->name_hash);
 			name_len = es->de_stream->name_len;
-			exfat_free_dentry_set(es, false);
+			exfat_put_dentry_set(es, 0, false);
 
 			if (p_uniname->name_hash != name_hash ||
 			    p_uniname->name_len != name_len)
@@ -973,7 +972,7 @@ int exfat_find_dir_entry(struct super_block *sb, struct exfat_inode_info *ei,
 				continue;
 
 			exfat_get_uniname_from_name_entries(es, &uni_name);
-			exfat_free_dentry_set(es, false);
+			exfat_put_dentry_set(es, 0, false);
 
 			if (!exfat_uniname_ncmp(sb,
 						p_uniname->name,
diff --git a/fs/exfat/exfat_fs.h b/fs/exfat/exfat_fs.h
index 62a4768a4f6e..6fac1cec3e7f 100644
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
index 04f6cc79ed43..e1f330169929 100644
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
index c59d523547ca..0f559785f7cb 100644
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

