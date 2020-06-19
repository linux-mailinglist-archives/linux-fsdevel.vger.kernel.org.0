Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F43D200431
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jun 2020 10:39:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731472AbgFSIjU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Jun 2020 04:39:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731178AbgFSIjL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Jun 2020 04:39:11 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7954EC06174E;
        Fri, 19 Jun 2020 01:39:09 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id k6so3661366pll.9;
        Fri, 19 Jun 2020 01:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=L28cv7twV2yh6p41RcWTWUh/uCTipz3Gzk18dy2mE4M=;
        b=R2nbBG260Wwzq714SM9NV+seeSIeBK/X5RJVXiCL46MohnSHqVl/Cx1e+WGc41dwtR
         1cEqnG5tVWA147BSR5mkccIujtq9yATbPghrJwe5vIs+detL3JLEP63VYyNkvbmw5QlE
         zwgA0i+Aw2DoT1zA0TyILUOrEzGheWG9bfLtlkJHW1LZjjFpObvYwDoB9VwcihqrwBWE
         nxuerHDOgCQ3vNoJ4EpSTvo1wOdc6uZvwgEs5Mj+CyrNM0JtyJ9F9dHfEcdjR2hN5dW9
         ZOBo7I35HSHcSU1XdZ8Qo+EjGhEoyNCDXT06/IgWQW8ZW7GsT5LMwki5we7g6s50tUAS
         yPTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L28cv7twV2yh6p41RcWTWUh/uCTipz3Gzk18dy2mE4M=;
        b=TVAGtQje6wXSYEqphMGYkUwI5szOijhXB+kagS3J6B2r02ZuR47sZviNg7MeMakpCm
         9/QCTIXgQmuZhlkOkR+4QOaiH1Rr96ZwzvXZlXuxyWZ7AeaZ+9GkZ0kEibPaoS5Ea+2a
         Su0aWsbbThX8fIvGiVuyO1QDiH5Wrz8MsCZzUDHCKbQV2OIrpZ7bSU4cM1zZ5j3zuYew
         zpbxPgAj5JnBBWTEcRWS7Y0gPpcrQq3kzYzxw//R84f/pNx9h94VVa+9UkOA498kv9Kf
         d/NDIpCW7RATy7GfggJPO787LhMwJlawHGmuGhaUDEu2j+uNVb0m3FbWmX1zvWqerG0n
         y17A==
X-Gm-Message-State: AOAM533xh1IwYeh5N9vTBfBIPJhlEKTJGJ7G4/clz0z0Yuz3pEbm5uwv
        S3ZmvhFLjh8okGN2xPWbubYcBmyDOvU=
X-Google-Smtp-Source: ABdhPJwNBHxrCRL/AvcB/ZLmdrcd5TBYTdnJFBTF6alBEmFMqQALp5xHzzf4ePSi1AKcit586SY6qQ==
X-Received: by 2002:a17:90b:430f:: with SMTP id ih15mr2412889pjb.61.1592555949042;
        Fri, 19 Jun 2020 01:39:09 -0700 (PDT)
Received: from dc803.localdomain (FL1-125-199-162-203.hyg.mesh.ad.jp. [125.199.162.203])
        by smtp.gmail.com with ESMTPSA id u24sm4437183pga.47.2020.06.19.01.39.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2020 01:39:08 -0700 (PDT)
From:   Tetsuhiro Kohada <kohada.t2@gmail.com>
To:     kohada.t2@gmail.com
Cc:     kohada.tetsuhiro@dc.mitsubishielectric.co.jp,
        mori.takahiro@ab.mitsubishielectric.co.jp,
        motai.hirotaka@aj.mitsubishielectric.co.jp,
        Sungjong Seo <sj1557.seo@samsung.com>,
        Namjae Jeon <namjae.jeon@samsung.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2 v4] exfat: add error check when updating dir-entries
Date:   Fri, 19 Jun 2020 17:38:55 +0900
Message-Id: <20200619083855.15789-2-kohada.t2@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200619083855.15789-1-kohada.t2@gmail.com>
References: <20200619083855.15789-1-kohada.t2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add error check when synchronously updating dir-entries.

Suggested-by: Sungjong Seo <sj1557.seo@samsung.com>
Signed-off-by: Tetsuhiro Kohada <kohada.t2@gmail.com>
---
Changes in v2:
 - Split into 'write multiple sectors at once'
   and 'add error check when updating dir-entries'
Changes in v3
 - Rebase to latest exfat-dev
Changes in v4
 - Based on 'exfat: write multiple sectors at once' v4

 fs/exfat/dir.c      | 3 ++-
 fs/exfat/exfat_fs.h | 2 +-
 fs/exfat/file.c     | 5 ++++-
 fs/exfat/inode.c    | 8 +++++---
 4 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/fs/exfat/dir.c b/fs/exfat/dir.c
index 7c2e29632634..2dc6fe695cb6 100644
--- a/fs/exfat/dir.c
+++ b/fs/exfat/dir.c
@@ -604,7 +604,7 @@ void exfat_update_dir_chksum_with_entry_set(struct exfat_entry_set_cache *es)
 	es->modified = true;
 }
 
-void exfat_free_dentry_set(struct exfat_entry_set_cache *es, int sync)
+int exfat_free_dentry_set(struct exfat_entry_set_cache *es, int sync)
 {
 	int i, err = 0;
 
@@ -617,6 +617,7 @@ void exfat_free_dentry_set(struct exfat_entry_set_cache *es, int sync)
 		else
 			brelse(es->bh[i]);
 	kfree(es);
+	return err;
 }
 
 static int exfat_walk_fat_chain(struct super_block *sb,
diff --git a/fs/exfat/exfat_fs.h b/fs/exfat/exfat_fs.h
index cbb00ee97183..da677c85314f 100644
--- a/fs/exfat/exfat_fs.h
+++ b/fs/exfat/exfat_fs.h
@@ -459,7 +459,7 @@ struct exfat_dentry *exfat_get_dentry_cached(struct exfat_entry_set_cache *es,
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
index cf9ca6c4d046..1e851f172e0c 100644
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

