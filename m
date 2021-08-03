Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 958FE3DF44B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Aug 2021 20:04:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238634AbhHCSER (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Aug 2021 14:04:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238624AbhHCSEQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Aug 2021 14:04:16 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ACF0C061757
        for <linux-fsdevel@vger.kernel.org>; Tue,  3 Aug 2021 11:04:04 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id b13so15376183wrs.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Aug 2021 11:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4GqhhvIv2GMHlPXgTIr4wx/CDKhM0RPHwwCAsHPU1So=;
        b=aXEnIKydC1M2eUtIbzWMV5fTDrSlQBxIWhYSnBMNMyPSPkiNFh2WdP7DavDCodTGT4
         izAXuSXzIN/AO9apJMo+PQ2KQ18TMGgbHOmeFItleqo4ndVvgEcv/lP/OkV5nuZHSKBY
         JuR79kZip+fdtdGqTgKQFq8CEkQnBNLgccGwDaFe0x7frKPf/enMV5r4Znqf2cjjtrGX
         A8XZsPEU2aAVp40nD2k64kIpP1Dq9xPDNVxd8cEjjw3D81UOfZlZJbEcnyLpWtwkxKQ2
         mmW04YpMexQYie9jo8yJeG7nzjiwc+m3jAHjj+hFOb1shORq1LH7vTulbHx7wPtTgz5X
         20sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4GqhhvIv2GMHlPXgTIr4wx/CDKhM0RPHwwCAsHPU1So=;
        b=gqkI4KjA1WzkYiz47Dc1aXxgTYXYB0qr/P4LVL4X/J9zdFylayNbkmfN2V54cOE44U
         ZUgUzeMxGxxL9ymovu1HbbM8mwSnd8syV+X6X0IULyYpzAbqqDCaVPUzNaXuQm30bGYQ
         VqPQWt9boRuc/2RqJNviHMklsC3HVVYEIrQqxyeoSS6tJc3vKCvBhRH6UrgYaGgDxj/7
         0aL0SWGF/6PVR14IwmGhbm1K3M5DOlH8aaWniUqTpm+xt0jw4jmPB/dbxJ7Kbf0F4Ds0
         eoxPdwytIfPEZqg2OR7DV2K2HGpF3VXJc9IZYeRgbNuwClcXW5GpNaE4ZxCgEFq+6rNm
         rjig==
X-Gm-Message-State: AOAM530d/1TzZW/80wPYBUdjyqdnh+Vp/2ZlkyL3Utcysu1exiLz7Ncm
        fMDtm0dFgL4bjm5Dd5C2pv8=
X-Google-Smtp-Source: ABdhPJw48vqVkTqtNb2No5lEFdG2hMqCX6FzY2NZw/lYolqPoogmezzWClojjOXaMqITKC179rbUUw==
X-Received: by 2002:a5d:4207:: with SMTP id n7mr24358387wrq.326.1628013842954;
        Tue, 03 Aug 2021 11:04:02 -0700 (PDT)
Received: from localhost.localdomain ([185.110.110.213])
        by smtp.gmail.com with ESMTPSA id b14sm15515555wrm.43.2021.08.03.11.04.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 11:04:02 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 3/4] fsnotify: count all objects with attached connectors
Date:   Tue,  3 Aug 2021 21:03:43 +0300
Message-Id: <20210803180344.2398374-4-amir73il@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210803180344.2398374-1-amir73il@gmail.com>
References: <20210803180344.2398374-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Rename s_fsnotify_inode_refs to s_fsnotify_conectors and count all
objects with attached connectors, not only inodes with attached
connectors.

This will be used to optimize fsnotify() calls on sb without any
type of marks.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/notify/fsnotify.c |  6 +++---
 fs/notify/mark.c     | 45 +++++++++++++++++++++++++++++++++++++++++---
 include/linux/fs.h   |  4 ++--
 3 files changed, 47 insertions(+), 8 deletions(-)

diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
index 30d422b8c0fc..a5de7f32c493 100644
--- a/fs/notify/fsnotify.c
+++ b/fs/notify/fsnotify.c
@@ -87,9 +87,9 @@ static void fsnotify_unmount_inodes(struct super_block *sb)
 
 	if (iput_inode)
 		iput(iput_inode);
-	/* Wait for outstanding inode references from connectors */
-	wait_var_event(&sb->s_fsnotify_inode_refs,
-		       !atomic_long_read(&sb->s_fsnotify_inode_refs));
+	/* Wait for outstanding object references from connectors */
+	wait_var_event(&sb->s_fsnotify_connectors,
+		       !atomic_long_read(&sb->s_fsnotify_connectors));
 }
 
 void fsnotify_sb_delete(struct super_block *sb)
diff --git a/fs/notify/mark.c b/fs/notify/mark.c
index 2d8c46e1167d..622bcbface4f 100644
--- a/fs/notify/mark.c
+++ b/fs/notify/mark.c
@@ -172,7 +172,7 @@ static void fsnotify_connector_destroy_workfn(struct work_struct *work)
 static void fsnotify_get_inode_ref(struct inode *inode)
 {
 	ihold(inode);
-	atomic_long_inc(&inode->i_sb->s_fsnotify_inode_refs);
+	atomic_long_inc(&inode->i_sb->s_fsnotify_connectors);
 }
 
 static void fsnotify_put_inode_ref(struct inode *inode)
@@ -180,8 +180,45 @@ static void fsnotify_put_inode_ref(struct inode *inode)
 	struct super_block *sb = inode->i_sb;
 
 	iput(inode);
-	if (atomic_long_dec_and_test(&sb->s_fsnotify_inode_refs))
-		wake_up_var(&sb->s_fsnotify_inode_refs);
+	if (atomic_long_dec_and_test(&sb->s_fsnotify_connectors))
+		wake_up_var(&sb->s_fsnotify_connectors);
+}
+
+static void fsnotify_get_sb_connectors(struct fsnotify_mark_connector *conn)
+{
+	struct super_block *sb;
+
+	if (conn->type == FSNOTIFY_OBJ_TYPE_DETACHED)
+		return;
+
+	if (conn->type == FSNOTIFY_OBJ_TYPE_INODE)
+		sb = fsnotify_conn_inode(conn)->i_sb;
+	else if (conn->type == FSNOTIFY_OBJ_TYPE_VFSMOUNT)
+		sb = fsnotify_conn_mount(conn)->mnt.mnt_sb;
+	else if (conn->type == FSNOTIFY_OBJ_TYPE_SB)
+		sb = fsnotify_conn_sb(conn);
+
+	atomic_long_inc(&sb->s_fsnotify_connectors);
+}
+
+static void fsnotify_put_sb_connectors(struct fsnotify_mark_connector *conn)
+{
+	struct super_block *sb;
+
+	if (conn->type == FSNOTIFY_OBJ_TYPE_DETACHED)
+		return;
+
+	if (conn->type == FSNOTIFY_OBJ_TYPE_INODE)
+		sb = fsnotify_conn_inode(conn)->i_sb;
+	else if (conn->type == FSNOTIFY_OBJ_TYPE_VFSMOUNT)
+		sb = fsnotify_conn_mount(conn)->mnt.mnt_sb;
+	else if (conn->type == FSNOTIFY_OBJ_TYPE_SB)
+		sb = fsnotify_conn_sb(conn);
+	else
+		return;
+
+	if (atomic_long_dec_and_test(&sb->s_fsnotify_connectors))
+		wake_up_var(&sb->s_fsnotify_connectors);
 }
 
 static void *fsnotify_detach_connector_from_object(
@@ -203,6 +240,7 @@ static void *fsnotify_detach_connector_from_object(
 		fsnotify_conn_sb(conn)->s_fsnotify_mask = 0;
 	}
 
+	fsnotify_put_sb_connectors(conn);
 	rcu_assign_pointer(*(conn->obj), NULL);
 	conn->obj = NULL;
 	conn->type = FSNOTIFY_OBJ_TYPE_DETACHED;
@@ -504,6 +542,7 @@ static int fsnotify_attach_connector_to_object(fsnotify_connp_t *connp,
 		inode = fsnotify_conn_inode(conn);
 		fsnotify_get_inode_ref(inode);
 	}
+	fsnotify_get_sb_connectors(conn);
 
 	/*
 	 * cmpxchg() provides the barrier so that readers of *connp can see
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 640574294216..d48d2018dfa4 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1507,8 +1507,8 @@ struct super_block {
 	/* Number of inodes with nlink == 0 but still referenced */
 	atomic_long_t s_remove_count;
 
-	/* Pending fsnotify inode refs */
-	atomic_long_t s_fsnotify_inode_refs;
+	/* Number of inode/mount/sb objects that are being watched */
+	atomic_long_t s_fsnotify_connectors;
 
 	/* Being remounted read-only */
 	int s_readonly_remount;
-- 
2.25.1

