Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 538671EDFFC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jun 2020 10:45:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728140AbgFDIpN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Jun 2020 04:45:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727026AbgFDIpM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Jun 2020 04:45:12 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20E73C05BD1E;
        Thu,  4 Jun 2020 01:45:12 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id q24so900942pjd.1;
        Thu, 04 Jun 2020 01:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=guLDCrKfgZXr2CUB7wtfdzsZqMjoNL6/MaH81QBWwkU=;
        b=Sho0kogY3aiD9T4AnJflI+T8IHF5DPdOpbzHhHXLgO3HP/9HGBWYAqUQiYu6zFGtNk
         bFeM36p5aLuPB/pjLke2zCOF1ZGPeIlFf9crhbekHE7hf8GgKuxAEqCmyXKaPosMSQyx
         bAZaakC4s7L/OUwH3csRo8rU0dJlyQ46pD9qemiVtBiZCk2wYbofk6NbKMk7qOjMBoFZ
         ZbsXBnk19VPW6pjVQlJBKYjQepwKlv8IMOEzqLotBE3LHT+lSW1oyMmcg+2+Ltc/0yvK
         ZaZ6ScG3oQgN3hRsYwpfaRAEWJKMGZUHn1rdPVrV3daX2JPxqonm0Fgd1KfjvEnh3LYj
         FvLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=guLDCrKfgZXr2CUB7wtfdzsZqMjoNL6/MaH81QBWwkU=;
        b=pOf5SN1SbFvleAz13c6Czy9cVQ/l9IT73w1XfYcLjm8sljZepyNJqi4HKkqWeCD/32
         X4OkVDkbTeJGQKCjRng9UK8WYtgcsOjghzBV2acMs53MvzF0s+J5b+hnTRaLsBlzFYCe
         80mwa+eNP3zl+xxWxPoqFq/gfjq+VBoTYSRaB6HT+wmAqQDVnXz7wnsZ7/j+ZI3kc/ES
         ziEICSiWGikTHDDyIkOErE31jZxQFCUTJ+6/zKDfO2qo6xrlMZk6eioOh36OZ4KEuiKD
         R+og2l19Sj0IA1XSjsSEvbLqW1RV9bHPJPEVbMa+t9bPnvmLX3UixiE9ofWRAjjPx6O+
         SqUQ==
X-Gm-Message-State: AOAM531iqQRhrDDUQ1mNLOFmph9RIhHlWihdH/X78l2yTCJf6JkuuHJZ
        h1m/E9Ub7W+dCH+6q9VNNBk=
X-Google-Smtp-Source: ABdhPJwryDsPGUtTnfVSppltS744ryZSBfAtNDM8IYW8ZtEDDlistFhcVjOUGI71bkg8DciUg4+/gg==
X-Received: by 2002:a17:90a:2222:: with SMTP id c31mr4618065pje.200.1591260311547;
        Thu, 04 Jun 2020 01:45:11 -0700 (PDT)
Received: from dc803.flets-west.jp ([2404:7a87:83e0:f800:39b2:3392:bee8:f3be])
        by smtp.gmail.com with ESMTPSA id y6sm4770565pjw.15.2020.06.04.01.45.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2020 01:45:10 -0700 (PDT)
From:   Tetsuhiro Kohada <kohada.t2@gmail.com>
To:     kohada.t2@gmail.com
Cc:     kohada.tetsuhiro@dc.mitsubishielectric.co.jp,
        mori.takahiro@ab.mitsubishielectric.co.jp,
        motai.hirotaka@aj.mitsubishielectric.co.jp,
        Sungjong Seo <sj1557.seo@samsung.com>,
        Namjae Jeon <namjae.jeon@samsung.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] exfat: add error check when updating dir-entries
Date:   Thu,  4 Jun 2020 17:44:42 +0900
Message-Id: <20200604084445.19205-1-kohada.t2@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add error check when synchronously updating dir-entries.
Furthermore, add exfat_update_bhs(). It wait for write completion once
instead of sector by sector.

Suggested-by: Sungjong Seo <sj1557.seo@samsung.com>
Signed-off-by: Tetsuhiro Kohada <kohada.t2@gmail.com>
---
 fs/exfat/dir.c      | 15 +++++++++------
 fs/exfat/exfat_fs.h |  3 ++-
 fs/exfat/file.c     |  5 ++++-
 fs/exfat/inode.c    |  8 +++++---
 fs/exfat/misc.c     | 19 +++++++++++++++++++
 5 files changed, 39 insertions(+), 11 deletions(-)

diff --git a/fs/exfat/dir.c b/fs/exfat/dir.c
index de43534aa299..3eb8386fb5f2 100644
--- a/fs/exfat/dir.c
+++ b/fs/exfat/dir.c
@@ -602,16 +602,19 @@ void exfat_update_dir_chksum_with_entry_set(struct exfat_entry_set_cache *es)
 	es->modified = true;
 }
 
-void exfat_free_dentry_set(struct exfat_entry_set_cache *es, int sync)
+int exfat_free_dentry_set(struct exfat_entry_set_cache *es, int sync)
 {
-	int i;
+	int i, err = 0;
 
-	for (i = 0; i < es->num_bh; i++) {
-		if (es->modified)
-			exfat_update_bh(es->sb, es->bh[i], sync);
-		brelse(es->bh[i]);
+	if (es->modified) {
+		set_bit(EXFAT_SB_DIRTY, &EXFAT_SB(es->sb)->s_state);
+		err = exfat_update_bhs(es->bh, es->num_bh, sync);
 	}
+
+	for (i = 0; i < es->num_bh; i++)
+		err ? bforget(es->bh[i]):brelse(es->bh[i]);
 	kfree(es);
+	return err;
 }
 
 static int exfat_walk_fat_chain(struct super_block *sb,
diff --git a/fs/exfat/exfat_fs.h b/fs/exfat/exfat_fs.h
index 595f3117f492..f4fa0e833486 100644
--- a/fs/exfat/exfat_fs.h
+++ b/fs/exfat/exfat_fs.h
@@ -462,7 +462,7 @@ struct exfat_dentry *exfat_get_dentry_cached(struct exfat_entry_set_cache *es,
 		int num);
 struct exfat_entry_set_cache *exfat_get_dentry_set(struct super_block *sb,
 		struct exfat_chain *p_dir, int entry, unsigned int type);
-void exfat_free_dentry_set(struct exfat_entry_set_cache *es, int sync);
+int exfat_free_dentry_set(struct exfat_entry_set_cache *es, int sync);
 int exfat_count_dir_entries(struct super_block *sb, struct exfat_chain *p_dir);
 
 /* inode.c */
@@ -515,6 +515,7 @@ void exfat_set_entry_time(struct exfat_sb_info *sbi, struct timespec64 *ts,
 u16 exfat_calc_chksum16(void *data, int len, u16 chksum, int type);
 u32 exfat_calc_chksum32(void *data, int len, u32 chksum, int type);
 void exfat_update_bh(struct super_block *sb, struct buffer_head *bh, int sync);
+int exfat_update_bhs(struct buffer_head **bhs, int nr_bhs, int sync);
 void exfat_chain_set(struct exfat_chain *ec, unsigned int dir,
 		unsigned int size, unsigned char flags);
 void exfat_chain_dup(struct exfat_chain *dup, struct exfat_chain *ec);
diff --git a/fs/exfat/file.c b/fs/exfat/file.c
index fce03f318787..37c8f04c1f8a 100644
--- a/fs/exfat/file.c
+++ b/fs/exfat/file.c
@@ -153,6 +153,7 @@ int __exfat_truncate(struct inode *inode, loff_t new_size)
 		struct timespec64 ts;
 		struct exfat_dentry *ep, *ep2;
 		struct exfat_entry_set_cache *es;
+		int err;
 
 		es = exfat_get_dentry_set(sb, &(ei->dir), ei->entry,
 				ES_ALL_ENTRIES);
@@ -187,7 +188,9 @@ int __exfat_truncate(struct inode *inode, loff_t new_size)
 		}
 
 		exfat_update_dir_chksum_with_entry_set(es);
-		exfat_free_dentry_set(es, inode_needs_sync(inode));
+		err = exfat_free_dentry_set(es, inode_needs_sync(inode));
+		if (err)
+			return err;
 	}
 
 	/* cut off from the FAT chain */
diff --git a/fs/exfat/inode.c b/fs/exfat/inode.c
index ef7cf7a6d187..c0bfd1a586aa 100644
--- a/fs/exfat/inode.c
+++ b/fs/exfat/inode.c
@@ -77,8 +77,7 @@ static int __exfat_write_inode(struct inode *inode, int sync)
 	ep2->dentry.stream.size = ep2->dentry.stream.valid_size;
 
 	exfat_update_dir_chksum_with_entry_set(es);
-	exfat_free_dentry_set(es, sync);
-	return 0;
+	return exfat_free_dentry_set(es, sync);
 }
 
 int exfat_write_inode(struct inode *inode, struct writeback_control *wbc)
@@ -222,6 +221,7 @@ static int exfat_map_cluster(struct inode *inode, unsigned int clu_offset,
 		if (ei->dir.dir != DIR_DELETED && modified) {
 			struct exfat_dentry *ep;
 			struct exfat_entry_set_cache *es;
+			int err;
 
 			es = exfat_get_dentry_set(sb, &(ei->dir), ei->entry,
 				ES_ALL_ENTRIES);
@@ -240,7 +240,9 @@ static int exfat_map_cluster(struct inode *inode, unsigned int clu_offset,
 				ep->dentry.stream.valid_size;
 
 			exfat_update_dir_chksum_with_entry_set(es);
-			exfat_free_dentry_set(es, inode_needs_sync(inode));
+			err = exfat_free_dentry_set(es, inode_needs_sync(inode));
+			if (err)
+				return err;
 
 		} /* end of if != DIR_DELETED */
 
diff --git a/fs/exfat/misc.c b/fs/exfat/misc.c
index 17d41f3d3709..dc34968e99d3 100644
--- a/fs/exfat/misc.c
+++ b/fs/exfat/misc.c
@@ -173,6 +173,25 @@ void exfat_update_bh(struct super_block *sb, struct buffer_head *bh, int sync)
 		sync_dirty_buffer(bh);
 }
 
+int exfat_update_bhs(struct buffer_head **bhs, int nr_bhs, int sync)
+{
+	int i, err = 0;
+
+	for (i = 0; i < nr_bhs; i++) {
+		set_buffer_uptodate(bhs[i]);
+		mark_buffer_dirty(bhs[i]);
+		if (sync)
+			write_dirty_buffer(bhs[i], 0);
+	}
+
+	for (i = 0; i < nr_bhs && sync; i++) {
+		wait_on_buffer(bhs[i]);
+		if (!buffer_uptodate(bhs[i]))
+			err = -EIO;
+	}
+	return err;
+}
+
 void exfat_chain_set(struct exfat_chain *ec, unsigned int dir,
 		unsigned int size, unsigned char flags)
 {
-- 
2.25.1

