Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35E2C1F3595
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jun 2020 09:54:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727023AbgFIHyQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Jun 2020 03:54:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726404AbgFIHyP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Jun 2020 03:54:15 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8175C05BD43;
        Tue,  9 Jun 2020 00:54:11 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id 23so8828301pfw.10;
        Tue, 09 Jun 2020 00:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ll44CFo3GjO/tzqh0xWX54XeAv4u4O/td7WM1gcEvQ0=;
        b=oTYqPAhxteUqW28m+vJjUdPsmncw3YFmQyn+ohOJX6c18ikDA32xwKus+VJ53RoahK
         PTRpr6cWYomcan9lR6yO6VWw3jnrVpd0pFz8EtE2TzPIEU2DV+dQ8ixAyn/m9eH/zFbL
         0RXO+Lk82qD3bFuuyPA+TOKj7ObQFOrXTTWCIik0cLJPw5xzcM5yO4452JyP4bSHa4Bb
         aWO8iZk8wPaZZ1utH6uUMWYBJlQ77ouNW+Ey9fGhW5ThyACjmtKmYtxRFWa+5ktcZz3G
         j5QumgVYXaBnQGMvkBLqUESti97SSjiik6LyEclHOWsnOR9q64LKIBdJu1FzDjowuSXc
         HrgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ll44CFo3GjO/tzqh0xWX54XeAv4u4O/td7WM1gcEvQ0=;
        b=Q4CKaJzVbHpJQ5palTKFegxPzKSDfnsH9AzmeBWour+1pazcA/sFaaiw+NHIpfrlIs
         DwFtpSSbJ6OMkMffL88WFS5nPhCadQnxeYrACsNUfcTgyxfReRQ4VM17uVXDbZMv+9rs
         /Sq0xZtNJykcVW9VUag4JaNgCmtvdzMV9fDS0sdhDTI0bSfs5v2Oiu/YI7M2pkSiBDmj
         Yfp0k2b4ynPbC/S7cqLK+xTcJGW1qVZZkRut+W0DPTqAfSzWyK5ivlj7/abVuw4pENnP
         Un6tBfDfgGUB3xXnpqtipO1bkVA9MLNqPHen19RRDfZwA/eepnIEnm0HXl6p4Jws3+9o
         a8ew==
X-Gm-Message-State: AOAM531lv4GYLQSKA2D45EH8wr44QM4LPHs1N1agOvffazuqq6bj05qY
        O1bV6rjn2t8dsqk5HVu5lB0=
X-Google-Smtp-Source: ABdhPJwvvpv5IO++XmtsOJ1bTOdz3/jS9WtAVbKM5dgPlkb4S4o4lyOd5A9PepqrVZagTSJ1GfnuWQ==
X-Received: by 2002:a65:66d5:: with SMTP id c21mr22631908pgw.155.1591689251332;
        Tue, 09 Jun 2020 00:54:11 -0700 (PDT)
Received: from dc803.flets-west.jp ([2404:7a87:83e0:f800:99b4:eb52:d0bf:231c])
        by smtp.gmail.com with ESMTPSA id x4sm4769929pfx.87.2020.06.09.00.54.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2020 00:54:10 -0700 (PDT)
From:   Tetsuhiro Kohada <kohada.t2@gmail.com>
To:     kohada.t2@gmail.com
Cc:     kohada.tetsuhiro@dc.mitsubishielectric.co.jp,
        mori.takahiro@ab.mitsubishielectric.co.jp,
        motai.hirotaka@aj.mitsubishielectric.co.jp,
        Namjae Jeon <linkinjeon@kernel.org>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        Namjae Jeon <namjae.jeon@samsung.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] exfat: add error check when updating dir-entries
Date:   Tue,  9 Jun 2020 16:53:28 +0900
Message-Id: <20200609075329.13313-2-kohada.t2@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200609075329.13313-1-kohada.t2@gmail.com>
References: <20200609075329.13313-1-kohada.t2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add error check when synchronously updating dir-entries.

Suggested-by: Namjae Jeon <linkinjeon@kernel.org>
Suggested-by: Sungjong Seo <sj1557.seo@samsung.com>
Signed-off-by: Tetsuhiro Kohada <kohada.t2@gmail.com>
---
Changes in v2:
 - Split into 'write multiple sectors at once'
   and 'add error check when updating dir-entries'

 fs/exfat/dir.c      | 3 ++-
 fs/exfat/exfat_fs.h | 2 +-
 fs/exfat/file.c     | 5 ++++-
 fs/exfat/inode.c    | 8 +++++---
 4 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/fs/exfat/dir.c b/fs/exfat/dir.c
index 495884ccb352..3eb8386fb5f2 100644
--- a/fs/exfat/dir.c
+++ b/fs/exfat/dir.c
@@ -602,7 +602,7 @@ void exfat_update_dir_chksum_with_entry_set(struct exfat_entry_set_cache *es)
 	es->modified = true;
 }
 
-void exfat_free_dentry_set(struct exfat_entry_set_cache *es, int sync)
+int exfat_free_dentry_set(struct exfat_entry_set_cache *es, int sync)
 {
 	int i, err = 0;
 
@@ -614,6 +614,7 @@ void exfat_free_dentry_set(struct exfat_entry_set_cache *es, int sync)
 	for (i = 0; i < es->num_bh; i++)
 		err ? bforget(es->bh[i]):brelse(es->bh[i]);
 	kfree(es);
+	return err;
 }
 
 static int exfat_walk_fat_chain(struct super_block *sb,
diff --git a/fs/exfat/exfat_fs.h b/fs/exfat/exfat_fs.h
index 935954da2e54..f4fa0e833486 100644
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
 
-- 
2.25.1

