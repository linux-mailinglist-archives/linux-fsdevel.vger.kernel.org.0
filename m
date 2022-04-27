Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5980B510ED4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Apr 2022 04:33:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357200AbiD0CgY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Apr 2022 22:36:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357196AbiD0CgX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Apr 2022 22:36:23 -0400
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DA6265D08;
        Tue, 26 Apr 2022 19:33:14 -0700 (PDT)
Received: by mail-pj1-f49.google.com with SMTP id r9so261092pjo.5;
        Tue, 26 Apr 2022 19:33:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1W2RKO987hXL9y5yznf2QhQLVbTnMF3nzUrepuDGKL8=;
        b=mBkEZ2og8l6zbr8RQ3bkN/I1wSBj/WU7LF87tjkNsVZlpkvLk3vd45SzYg20Dqyl65
         GgyyrLpfRXkt16rrifcVHZ7QqreuI1lOYquOrgiBtyqc/XxohTt8yLcpFJaDzHi7ZQvJ
         2owNep+EjZhE0Pv2BWrgxSyHbjCrLV9zQ+ZbSwIlAmH+V8ZpRXoUZ9SZo0fTs4409DO8
         eLw8Nrf82OL6O4KGBS2ZAemhnIRW+PQxpPhi/DTMSYYJ+372wj6VH9Ll0mUTyM4fXbvE
         HUZHVrZ6Pl9ODq51uNXdo1n5FzCSNwxwpLJyR5OaSEWwUgZWtOUjI7xlztMb+ZlzBcfw
         l/+A==
X-Gm-Message-State: AOAM530fF3o+ylJNI+gTJ59of+t1mQQyckUGQXlXvPICo5ae2fhOvYdR
        fFbuLDRfVufAuR7WFaMkpiGO1QXS4EA=
X-Google-Smtp-Source: ABdhPJzQiW5sn12iBxVD1Mqps+q31XGc4E22Ly9+CV/gqjhsk3y6umNH7QRHHh7WPRa2+TvdjXGo+A==
X-Received: by 2002:a17:90a:d0c1:b0:1d2:c00a:8656 with SMTP id y1-20020a17090ad0c100b001d2c00a8656mr30417109pjw.235.1651026793399;
        Tue, 26 Apr 2022 19:33:13 -0700 (PDT)
Received: from localhost.localdomain ([211.49.23.9])
        by smtp.gmail.com with ESMTPSA id t1-20020a628101000000b0050d47199857sm7338564pfd.73.2022.04.26.19.33.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 19:33:12 -0700 (PDT)
From:   Namjae Jeon <linkinjeon@kernel.org>
To:     linux-cifs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     smfrench@gmail.com, hyc.lee@gmail.com, senozhatsky@chromium.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Namjae Jeon <linkinjeon@kernel.org>
Subject: [PATCH 2/3] fs: introduce lock_rename_child() helper
Date:   Wed, 27 Apr 2022 11:32:44 +0900
Message-Id: <20220427023245.7327-2-linkinjeon@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220427023245.7327-1-linkinjeon@kernel.org>
References: <20220427023245.7327-1-linkinjeon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
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
index 3f1829b3ab5b..516b8d147744 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -2954,20 +2954,10 @@ static inline int may_create(struct user_namespace *mnt_userns,
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
@@ -2986,8 +2976,42 @@ struct dentry *lock_rename(struct dentry *p1, struct dentry *p2)
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
index 4858c3cdf7c6..e6949d4ba188 100644
--- a/include/linux/namei.h
+++ b/include/linux/namei.h
@@ -77,6 +77,7 @@ extern int follow_down(struct path *);
 extern int follow_up(struct path *);
 
 extern struct dentry *lock_rename(struct dentry *, struct dentry *);
+extern struct dentry *lock_rename_child(struct dentry *, struct dentry *);
 extern void unlock_rename(struct dentry *, struct dentry *);
 
 extern int __must_check nd_jump_link(struct path *path);
-- 
2.25.1

