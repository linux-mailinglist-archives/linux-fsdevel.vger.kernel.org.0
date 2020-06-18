Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88FE91FDB86
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jun 2020 03:13:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728922AbgFRBMc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Jun 2020 21:12:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727111AbgFRBM3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Jun 2020 21:12:29 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04F4DC06174E;
        Wed, 17 Jun 2020 18:12:29 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id b201so2015367pfb.0;
        Wed, 17 Jun 2020 18:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=e9FOCSBqSJYzjtlQfMtvxrRXQjQq6WyBA8o/hvLoOy8=;
        b=hWeasNGf5UeBfBu0B7VFOylvzhKTVKa36Hij10+tbb1qblS9qxGuqA739dAZtQmXPl
         CFL1+uXbsPS2XCMah1Wei+yrso+Yt78IsdmwZyvZY68ZcVT1O8IPMJxiXDZKl1wvKa/2
         AB+JICg4bC4NelAarSZgjvD7QVsCf+6MIQ4PLHIq3U8lToVcj9GjkVLPfkM0fVA0cyJG
         tCPRyxcERUoqefspNnGYPUDoTlZEMnBaxbUNBXf4U1QlUlid8lmxlNa8+1owggnydsEr
         aE9SgHY+LMIssIhW5rqo5xywP4sHodrMcEDbixqytpMGpsIAV1AY7P78cCyiN+PbIuZj
         uwtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=e9FOCSBqSJYzjtlQfMtvxrRXQjQq6WyBA8o/hvLoOy8=;
        b=K4F5fsMSTagjXqcQjSFYqSCOZUJTizlEOz5GEoiI5a9GsOk3vxVGCiYNQy6PUCq7sD
         /bCHZPWmznnkDb6laU0Y6O4lH4Ag04UF/l89fqxGmYjPqKwQrwM9Ej0O2DEauO/FRBMK
         dtLMYf1+ZKdsdXsf9hEInAEne3oVMx3GVe2by1BG2lwhqiCUyvMtzjDFH+OTpHoqQSc4
         Bkqg9rzV/6AQIZiz4uLbvpe0SypG9wji/eehI/VUhI3Hp9uNl1OCOQp8LmxKZfy+JLT/
         3aJ8MSdL3BnoRjM2zF836U/wrfwG+VGIYwY86xd28rhdODi6IUu81wKNxXYpY4KzRXOk
         1u0w==
X-Gm-Message-State: AOAM533oY+B8lV/UVG4tn/ficR6Y0TBiTvU3HjGXGg9pGhDGYZwj8KFX
        LrMFTZHygj9A4035RRQwWso=
X-Google-Smtp-Source: ABdhPJztv7TY0qrdkLCitl4fWnLkzeDtTpNve6L6zUuUd8CG8Lblvje8JKrHM2IHpOA36Cwl0f/hSw==
X-Received: by 2002:aa7:9a92:: with SMTP id w18mr1299129pfi.261.1592442748524;
        Wed, 17 Jun 2020 18:12:28 -0700 (PDT)
Received: from dc803.localdomain (FL1-125-199-162-203.hyg.mesh.ad.jp. [125.199.162.203])
        by smtp.gmail.com with ESMTPSA id q10sm1022781pfk.86.2020.06.17.18.12.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 18:12:28 -0700 (PDT)
From:   Tetsuhiro Kohada <kohada.t2@gmail.com>
To:     kohada.t2@gmail.com
Cc:     kohada.tetsuhiro@dc.mitsubishielectric.co.jp,
        mori.takahiro@ab.mitsubishielectric.co.jp,
        motai.hirotaka@aj.mitsubishielectric.co.jp,
        Sungjong Seo <sj1557.seo@samsung.com>,
        Namjae Jeon <namjae.jeon@samsung.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2 v3] exfat: add error check when updating dir-entries
Date:   Thu, 18 Jun 2020 10:12:04 +0900
Message-Id: <20200618011205.1406-2-kohada.t2@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618011205.1406-1-kohada.t2@gmail.com>
References: <20200618011205.1406-1-kohada.t2@gmail.com>
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

 fs/exfat/dir.c      | 3 ++-
 fs/exfat/exfat_fs.h | 2 +-
 fs/exfat/file.c     | 5 ++++-
 fs/exfat/inode.c    | 8 +++++---
 4 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/fs/exfat/dir.c b/fs/exfat/dir.c
index a3364df6339c..89d216d5ac89 100644
--- a/fs/exfat/dir.c
+++ b/fs/exfat/dir.c
@@ -604,7 +604,7 @@ void exfat_update_dir_chksum_with_entry_set(struct exfat_entry_set_cache *es)
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

