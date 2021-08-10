Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D28223E7BD4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Aug 2021 17:12:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242719AbhHJPMx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Aug 2021 11:12:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242704AbhHJPMv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Aug 2021 11:12:51 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 937B5C0613C1
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Aug 2021 08:12:28 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id k29so13979782wrd.7
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Aug 2021 08:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YEQ3pWZUnS//0e5IqiwBxlZdqIcHB6a0l5C6qRGJ94s=;
        b=lUk6S+2KePtxtYCjUEzMrdYFP5ksI7kew9X+w2GUoA1VR4/BDRWYrf90vQvxYnveNT
         z+vLPLkszhwsorpCF4szTSJJmr+thiAQgC6WzpCMenYxiwCr4UzWXJvvk7JzX+xmD3Fg
         v131ifwVbVBH+0cJQb06QvM8LmOjGQYlM+XDRxXu8ouow0MpKXhpoKAfL9sZMjQBHQgw
         gbMtLfZ0aZSVWKpxCdVa1rPBRQNhHf1UCDU+sxKj2ZwuRk5x87urcwOWt80dD5Ut1Vti
         T291lYU8T+sHYiPmfxYd6NrexMkbPSCHV4peCwleX8KC/f5msRJXWcoJb3IpojNgsMjb
         v38g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YEQ3pWZUnS//0e5IqiwBxlZdqIcHB6a0l5C6qRGJ94s=;
        b=PKSzdqE0if1FZjZQXB/HXhrMVnaoKBxQYuvgGAUZHZglVK3QHRTCNWBMcGBL891bjo
         yLxvg1onI8ZvTP4w+M/pe1tJKYDEdkMhNcJ4ahQe0tfk84TMwYGjf4TkcXeBFNRvMbk4
         pYr9Ef/kmCUTD6xc/odb664j6/GHwfWP5X/zHxmBXjUgh+lEWK0mWrQH5dfGKBqMjmdy
         lM6z6G403iadILNU9vZvl7WTMbu+sZ4AhtfspXrrq85vv0+SOwSi3DhYcniMeLjEV0XO
         DW51myS3YoOMzl7jvOTXMeTw1xho86pgAbAFFYhZ8va0aJ5OmPUfkPGPk4ScfIWWT2+h
         aDVQ==
X-Gm-Message-State: AOAM532BNY8LY6Ur9mA1zwnYHkaS2EiNS5eYVEx4AqODf2Yxk/TMRBt9
        gFgDHA5LOOA2lYgldd9jwdM=
X-Google-Smtp-Source: ABdhPJyhWQ3hWWSLeZ4srgmfLmP6fcB4GC1QyWz8HjSq0wbo5chxkfGyoegaWUU1uPSkeIujIqpTag==
X-Received: by 2002:adf:e8d0:: with SMTP id k16mr31976235wrn.195.1628608347231;
        Tue, 10 Aug 2021 08:12:27 -0700 (PDT)
Received: from localhost.localdomain ([141.226.248.20])
        by smtp.gmail.com with ESMTPSA id k12sm9568920wrd.75.2021.08.10.08.12.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Aug 2021 08:12:26 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 3/4] fsnotify: count all objects with attached connectors
Date:   Tue, 10 Aug 2021 18:12:19 +0300
Message-Id: <20210810151220.285179-4-amir73il@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210810151220.285179-1-amir73il@gmail.com>
References: <20210810151220.285179-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Rename s_fsnotify_inode_refs to s_fsnotify_connectors and count all
objects with attached connectors, not only inodes with attached
connectors.

This will be used to optimize fsnotify() calls on sb without any
type of marks.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/notify/fsnotify.c |  6 +++---
 fs/notify/fsnotify.h | 15 +++++++++++++++
 fs/notify/mark.c     | 24 +++++++++++++++++++++---
 include/linux/fs.h   |  4 ++--
 4 files changed, 41 insertions(+), 8 deletions(-)

diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
index 30d422b8c0fc..963e6ce75b96 100644
--- a/fs/notify/fsnotify.c
+++ b/fs/notify/fsnotify.c
@@ -87,15 +87,15 @@ static void fsnotify_unmount_inodes(struct super_block *sb)
 
 	if (iput_inode)
 		iput(iput_inode);
-	/* Wait for outstanding inode references from connectors */
-	wait_var_event(&sb->s_fsnotify_inode_refs,
-		       !atomic_long_read(&sb->s_fsnotify_inode_refs));
 }
 
 void fsnotify_sb_delete(struct super_block *sb)
 {
 	fsnotify_unmount_inodes(sb);
 	fsnotify_clear_marks_by_sb(sb);
+	/* Wait for outstanding object references from connectors */
+	wait_var_event(&sb->s_fsnotify_connectors,
+		       !atomic_long_read(&sb->s_fsnotify_connectors));
 }
 
 /*
diff --git a/fs/notify/fsnotify.h b/fs/notify/fsnotify.h
index ff2063ec6b0f..87d8a50ee803 100644
--- a/fs/notify/fsnotify.h
+++ b/fs/notify/fsnotify.h
@@ -27,6 +27,21 @@ static inline struct super_block *fsnotify_conn_sb(
 	return container_of(conn->obj, struct super_block, s_fsnotify_marks);
 }
 
+static inline struct super_block *fsnotify_connector_sb(
+				struct fsnotify_mark_connector *conn)
+{
+	switch (conn->type) {
+	case FSNOTIFY_OBJ_TYPE_INODE:
+		return fsnotify_conn_inode(conn)->i_sb;
+	case FSNOTIFY_OBJ_TYPE_VFSMOUNT:
+		return fsnotify_conn_mount(conn)->mnt.mnt_sb;
+	case FSNOTIFY_OBJ_TYPE_SB:
+		return fsnotify_conn_sb(conn);
+	default:
+		return NULL;
+	}
+}
+
 /* destroy all events sitting in this groups notification queue */
 extern void fsnotify_flush_notify(struct fsnotify_group *group);
 
diff --git a/fs/notify/mark.c b/fs/notify/mark.c
index 2d8c46e1167d..95006d1d29ab 100644
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
@@ -180,8 +180,24 @@ static void fsnotify_put_inode_ref(struct inode *inode)
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
+	struct super_block *sb = fsnotify_connector_sb(conn);
+
+	if (sb)
+		atomic_long_inc(&sb->s_fsnotify_connectors);
+}
+
+static void fsnotify_put_sb_connectors(struct fsnotify_mark_connector *conn)
+{
+	struct super_block *sb = fsnotify_connector_sb(conn);
+
+	if (sb && atomic_long_dec_and_test(&sb->s_fsnotify_connectors))
+		wake_up_var(&sb->s_fsnotify_connectors);
 }
 
 static void *fsnotify_detach_connector_from_object(
@@ -203,6 +219,7 @@ static void *fsnotify_detach_connector_from_object(
 		fsnotify_conn_sb(conn)->s_fsnotify_mask = 0;
 	}
 
+	fsnotify_put_sb_connectors(conn);
 	rcu_assign_pointer(*(conn->obj), NULL);
 	conn->obj = NULL;
 	conn->type = FSNOTIFY_OBJ_TYPE_DETACHED;
@@ -504,6 +521,7 @@ static int fsnotify_attach_connector_to_object(fsnotify_connp_t *connp,
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
2.32.0

