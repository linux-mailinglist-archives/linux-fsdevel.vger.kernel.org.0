Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AFFF56A203
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Jul 2022 14:33:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235519AbiGGMcp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Jul 2022 08:32:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235514AbiGGMco (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Jul 2022 08:32:44 -0400
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E99011AF05;
        Thu,  7 Jul 2022 05:32:42 -0700 (PDT)
Received: by mail-pf1-f170.google.com with SMTP id b9so3046952pfp.10;
        Thu, 07 Jul 2022 05:32:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DfATGYwCmyMFnyO+58XP90DTmpkbLHag6MGE/8UHnfY=;
        b=YkoEEecKa3m/9J8pn2K1O0cGkHGu6iTHHYv5TWNSnDTBGGDv0Qn6lwq3Aj0YjCzXsj
         yJsgz05oshUWVZjxkrNPhRBUWy91a29epzoMD83Fjo6fH8kgM+kOrF10FSHXz64Luaiz
         3zqoFJkxOE/p2Cj/ZRMzKpeh9Rcg5qmB7qQXV+UcBd2ji/nYRKGzD0XsOZOC3ohnxVGU
         T0SHcPClk8Y3jBsUi8xQF5owpCWw3Orr7uC5p38yo7pCsmvTnhz9FAwza82WFcR1URYP
         Bbz6MN5W+T6nnZ9xJ814b+ThKZaSxfLCbRNgNhoxTJIVlTHkfB/iC7J7jTANLtSYTMho
         /bjQ==
X-Gm-Message-State: AJIora8aJ2O9MfDnBntwK7cnhWc1X15pp+oPU/e7lglZtCiw7/YZzaWm
        Bcesfp7tmC5NkmbdeIMAY5w=
X-Google-Smtp-Source: AGRyM1uP/JEiZgZrEeylNesutm/ZWDJo6MdLZUifEHcq0xUl6fkoSEw5Ry2IVLe14BTXEh4ghDO2pQ==
X-Received: by 2002:a17:90a:404a:b0:1ea:e936:b69 with SMTP id k10-20020a17090a404a00b001eae9360b69mr4842717pjg.133.1657197162426;
        Thu, 07 Jul 2022 05:32:42 -0700 (PDT)
Received: from localhost.localdomain ([211.49.23.9])
        by smtp.gmail.com with ESMTPSA id u13-20020a63454d000000b0040d2224ae04sm25825227pgk.76.2022.07.07.05.32.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 05:32:41 -0700 (PDT)
From:   Namjae Jeon <linkinjeon@kernel.org>
To:     viro@zeniv.linux.org.uk
Cc:     linux-cifs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        smfrench@gmail.com, hyc.lee@gmail.com, senozhatsky@chromium.org,
        Namjae Jeon <linkinjeon@kernel.org>
Subject: [PATCH v6 2/3] fs: introduce lock_rename_child() helper
Date:   Thu,  7 Jul 2022 21:32:04 +0900
Message-Id: <20220707123205.6902-3-linkinjeon@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220707123205.6902-1-linkinjeon@kernel.org>
References: <20220707123205.6902-1-linkinjeon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

Pass the dentry of a source file and the dentry of a destination directory
to lock parent inodes for rename. As soon as this function returns,
->d_parent of the source file dentry is stable and inodes are properly
locked for calling vfs-rename. This helper is needed for ksmbd server.
rename request of SMB protocol has to rename an opened file, no matter
which directory it's in.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
---
 fs/namei.c            | 46 ++++++++++++++++++++++++++++++++-----------
 include/linux/namei.h |  1 +
 2 files changed, 36 insertions(+), 11 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 1f28d3f463c3..c22bdef164ca 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -2998,20 +2998,10 @@ static inline int may_create(struct user_namespace *mnt_userns,
 	return inode_permission(mnt_userns, dir, MAY_WRITE | MAY_EXEC);
 }
 
-/*
- * p1 and p2 should be directories on the same fs.
- */
-struct dentry *lock_rename(struct dentry *p1, struct dentry *p2)
+static struct dentry *lock_two_directories(struct dentry *p1, struct dentry *p2)
 {
 	struct dentry *p;
 
-	if (p1 == p2) {
-		inode_lock_nested(p1->d_inode, I_MUTEX_PARENT);
-		return NULL;
-	}
-
-	mutex_lock(&p1->d_sb->s_vfs_rename_mutex);
-
 	p = d_ancestor(p2, p1);
 	if (p) {
 		inode_lock_nested(p2->d_inode, I_MUTEX_PARENT);
@@ -3030,8 +3020,42 @@ struct dentry *lock_rename(struct dentry *p1, struct dentry *p2)
 	inode_lock_nested(p2->d_inode, I_MUTEX_PARENT2);
 	return NULL;
 }
+
+/*
+ * p1 and p2 should be directories on the same fs.
+ */
+struct dentry *lock_rename(struct dentry *p1, struct dentry *p2)
+{
+	if (p1 == p2) {
+		inode_lock_nested(p1->d_inode, I_MUTEX_PARENT);
+		return NULL;
+	}
+
+	mutex_lock(&p1->d_sb->s_vfs_rename_mutex);
+	return lock_two_directories(p1, p2);
+}
 EXPORT_SYMBOL(lock_rename);
 
+struct dentry *lock_rename_child(struct dentry *c1, struct dentry *p2)
+{
+	if (READ_ONCE(c1->d_parent) == p2) {
+		inode_lock_nested(p2->d_inode, I_MUTEX_PARENT);
+		if (likely(c1->d_parent == p2))
+			return NULL;
+
+		inode_unlock(p2->d_inode);
+	}
+
+	mutex_lock(&c1->d_sb->s_vfs_rename_mutex);
+	if (likely(c1->d_parent != p2))
+		return lock_two_directories(c1->d_parent, p2);
+
+	inode_lock_nested(p2->d_inode, I_MUTEX_PARENT);
+	mutex_unlock(&c1->d_sb->s_vfs_rename_mutex);
+	return NULL;
+}
+EXPORT_SYMBOL(lock_rename_child);
+
 void unlock_rename(struct dentry *p1, struct dentry *p2)
 {
 	inode_unlock(p1->d_inode);
diff --git a/include/linux/namei.h b/include/linux/namei.h
index 40c693525f79..7868732cce24 100644
--- a/include/linux/namei.h
+++ b/include/linux/namei.h
@@ -83,6 +83,7 @@ extern int follow_down(struct path *);
 extern int follow_up(struct path *);
 
 extern struct dentry *lock_rename(struct dentry *, struct dentry *);
+extern struct dentry *lock_rename_child(struct dentry *, struct dentry *);
 extern void unlock_rename(struct dentry *, struct dentry *);
 
 extern int __must_check nd_jump_link(struct path *path);
-- 
2.34.1

