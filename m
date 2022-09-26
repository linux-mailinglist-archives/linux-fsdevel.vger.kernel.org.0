Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D0B15EB574
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Sep 2022 01:19:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231265AbiIZXTf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Sep 2022 19:19:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231173AbiIZXSv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Sep 2022 19:18:51 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85F71A723E
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Sep 2022 16:18:48 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-3515a8a6e06so13194857b3.12
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Sep 2022 16:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=H7CaqqH/S1PI07TF9lAvEP/hY/HwjM9ZNiVQ+Vulqi4=;
        b=XCWtDGqDzgXGKd9AdPQ5jXAQDnBCZRTgmAxMkr7sTgl+UMJdQcZm7kGdW4dh+hAl8w
         GmxTnbQfDjEZLRP4rN261o8MpBunr+j/gL7L7T1nxPhgewL7K/9mLXN9atVqLJmKnvz4
         2xrxSqjHcs0MhQne8cMIj+4f7BQi4deL+x91r3ToIIuNRPQKJcakNuCE4b00u50q0cPz
         tEIAOnv30mlzV7ChfLz8cJ6bIYW9ndauuOn/x7q3+f2XmxPY1tBm/9uXe/cv1GwaQvIM
         gfCChnkoIyWiZHlnI//IfJhNkI0FPtuys8nJYJXbz0kAgIxH/UucdBIXc9V+ScyW49eD
         fajA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=H7CaqqH/S1PI07TF9lAvEP/hY/HwjM9ZNiVQ+Vulqi4=;
        b=QSBcVMsn9u9J9rnl93PJKSS6nBfmTfyEnehk7vbFTXYoNIE/pN/VDZ0hOr9CZggRyU
         WyTeeBTLbJf4TEwAVmNPRLLvgjBqhYmVPaDwyVsiZP/d5MU7RoeR7EjQzCeJKEPvK4wF
         EbGkUAbpBo0GSp5KcAG0UBNWEHsyVSJ72l9WaByWA8b+1fmZ0cIUHEb219uQFpfo0ZN2
         udBptIQLb7dq5ZRFiGFXohIwbqY2sUpY1e7FGwbjlCT5KB+hUSq0nk9bcn907vzEqNjJ
         EF++zUT8InGqXEox9i9td1ZE99gzsEH/TaAL8BdCoDv5DTEfrULCXvxalLDB21bEjoXO
         HMGg==
X-Gm-Message-State: ACrzQf3j6QujTWoCcKTGMSQUhzbQhJZDTsTbgED4si6wNAURqqEGkjlA
        FpQ4xv5eTjvWQTSGk74SvVtYm9wJq0M=
X-Google-Smtp-Source: AMsMyM6hk2fP0HQJwRc2Nsdf5gf57JQBJqdOywQqU/Agxcr0/47FcTPLY7DJ7MA2MXTdgYcm1rHbSXJbcZ8=
X-Received: from drosen.mtv.corp.google.com ([2620:15c:211:200:4643:a68e:2b7:f873])
 (user=drosen job=sendgmr) by 2002:a05:6902:709:b0:6af:270a:c1c6 with SMTP id
 k9-20020a056902070900b006af270ac1c6mr23204160ybt.447.1664234327864; Mon, 26
 Sep 2022 16:18:47 -0700 (PDT)
Date:   Mon, 26 Sep 2022 16:18:03 -0700
In-Reply-To: <20220926231822.994383-1-drosen@google.com>
Mime-Version: 1.0
References: <20220926231822.994383-1-drosen@google.com>
X-Mailer: git-send-email 2.37.3.998.g577e59143f-goog
Message-ID: <20220926231822.994383-8-drosen@google.com>
Subject: [PATCH 07/26] fuse-bpf: Prepare for fuse-bpf patch
From:   Daniel Rosenberg <drosen@google.com>
To:     Miklos Szeredi <miklos@szeredi.hu>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Daniel Rosenberg <drosen@google.com>,
        Paul Lawrence <paullawrence@google.com>,
        Alessio Balsini <balsini@google.com>,
        David Anderson <dvander@google.com>,
        Sandeep Patil <sspatil@google.com>,
        linux-fsdevel@vger.kernel.org, bpf@vger.kernel.org,
        kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This moves some functions and structs around to make the following patch
easier to read.

Signed-off-by: Daniel Rosenberg <drosen@google.com>
Signed-off-by: Paul Lawrence <paullawrence@google.com>
---
 fs/fuse/dir.c    | 30 ------------------------------
 fs/fuse/fuse_i.h | 35 +++++++++++++++++++++++++++++++++++
 fs/fuse/inode.c  | 46 +++++++++++++++++++++++-----------------------
 3 files changed, 58 insertions(+), 53 deletions(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index b585b04e815e..74e13af039f1 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -46,10 +46,6 @@ static inline u64 fuse_dentry_time(const struct dentry *entry)
 }
 
 #else
-union fuse_dentry {
-	u64 time;
-	struct rcu_head rcu;
-};
 
 static inline void __fuse_dentry_settime(struct dentry *dentry, u64 time)
 {
@@ -83,27 +79,6 @@ static void fuse_dentry_settime(struct dentry *dentry, u64 time)
 	__fuse_dentry_settime(dentry, time);
 }
 
-/*
- * FUSE caches dentries and attributes with separate timeout.  The
- * time in jiffies until the dentry/attributes are valid is stored in
- * dentry->d_fsdata and fuse_inode->i_time respectively.
- */
-
-/*
- * Calculate the time in jiffies until a dentry/attributes are valid
- */
-static u64 time_to_jiffies(u64 sec, u32 nsec)
-{
-	if (sec || nsec) {
-		struct timespec64 ts = {
-			sec,
-			min_t(u32, nsec, NSEC_PER_SEC - 1)
-		};
-
-		return get_jiffies_64() + timespec64_to_jiffies(&ts);
-	} else
-		return 0;
-}
 
 /*
  * Set dentry and possibly attribute timeouts from the lookup/mk*
@@ -115,11 +90,6 @@ void fuse_change_entry_timeout(struct dentry *entry, struct fuse_entry_out *o)
 		time_to_jiffies(o->entry_valid, o->entry_valid_nsec));
 }
 
-static u64 attr_timeout(struct fuse_attr_out *o)
-{
-	return time_to_jiffies(o->attr_valid, o->attr_valid_nsec);
-}
-
 u64 entry_attr_timeout(struct fuse_entry_out *o)
 {
 	return time_to_jiffies(o->attr_valid, o->attr_valid_nsec);
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 488b460e046f..054b96c3e061 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -63,6 +63,14 @@ struct fuse_forget_link {
 	struct fuse_forget_link *next;
 };
 
+/** FUSE specific dentry data */
+#if BITS_PER_LONG < 64
+union fuse_dentry {
+	u64 time;
+	struct rcu_head rcu;
+};
+#endif
+
 /** FUSE inode */
 struct fuse_inode {
 	/** Inode data */
@@ -1316,4 +1324,31 @@ struct fuse_file *fuse_file_open(struct fuse_mount *fm, u64 nodeid,
 void fuse_file_release(struct inode *inode, struct fuse_file *ff,
 		       unsigned int open_flags, fl_owner_t id, bool isdir);
 
+/*
+ * FUSE caches dentries and attributes with separate timeout.  The
+ * time in jiffies until the dentry/attributes are valid is stored in
+ * dentry->d_fsdata and fuse_inode->i_time respectively.
+ */
+
+/*
+ * Calculate the time in jiffies until a dentry/attributes are valid
+ */
+static inline u64 time_to_jiffies(u64 sec, u32 nsec)
+{
+	if (sec || nsec) {
+		struct timespec64 ts = {
+			sec,
+			min_t(u32, nsec, NSEC_PER_SEC - 1)
+		};
+
+		return get_jiffies_64() + timespec64_to_jiffies(&ts);
+	} else
+		return 0;
+}
+
+static inline u64 attr_timeout(struct fuse_attr_out *o)
+{
+	return time_to_jiffies(o->attr_valid, o->attr_valid_nsec);
+}
+
 #endif /* _FS_FUSE_I_H */
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 6b3beda16c1b..036a14e917e1 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -162,6 +162,28 @@ static ino_t fuse_squash_ino(u64 ino64)
 	return ino;
 }
 
+static void fuse_fill_attr_from_inode(struct fuse_attr *attr,
+				      const struct inode *inode)
+{
+	*attr = (struct fuse_attr){
+		.ino		= inode->i_ino,
+		.size		= inode->i_size,
+		.blocks		= inode->i_blocks,
+		.atime		= inode->i_atime.tv_sec,
+		.mtime		= inode->i_mtime.tv_sec,
+		.ctime		= inode->i_ctime.tv_sec,
+		.atimensec	= inode->i_atime.tv_nsec,
+		.mtimensec	= inode->i_mtime.tv_nsec,
+		.ctimensec	= inode->i_ctime.tv_nsec,
+		.mode		= inode->i_mode,
+		.nlink		= inode->i_nlink,
+		.uid		= inode->i_uid.val,
+		.gid		= inode->i_gid.val,
+		.rdev		= inode->i_rdev,
+		.blksize	= 1u << inode->i_blkbits,
+	};
+}
+
 void fuse_change_attributes_common(struct inode *inode, struct fuse_attr *attr,
 				   u64 attr_valid, u32 cache_mask)
 {
@@ -1386,28 +1408,6 @@ void fuse_dev_free(struct fuse_dev *fud)
 }
 EXPORT_SYMBOL_GPL(fuse_dev_free);
 
-static void fuse_fill_attr_from_inode(struct fuse_attr *attr,
-				      const struct fuse_inode *fi)
-{
-	*attr = (struct fuse_attr){
-		.ino		= fi->inode.i_ino,
-		.size		= fi->inode.i_size,
-		.blocks		= fi->inode.i_blocks,
-		.atime		= fi->inode.i_atime.tv_sec,
-		.mtime		= fi->inode.i_mtime.tv_sec,
-		.ctime		= fi->inode.i_ctime.tv_sec,
-		.atimensec	= fi->inode.i_atime.tv_nsec,
-		.mtimensec	= fi->inode.i_mtime.tv_nsec,
-		.ctimensec	= fi->inode.i_ctime.tv_nsec,
-		.mode		= fi->inode.i_mode,
-		.nlink		= fi->inode.i_nlink,
-		.uid		= fi->inode.i_uid.val,
-		.gid		= fi->inode.i_gid.val,
-		.rdev		= fi->inode.i_rdev,
-		.blksize	= 1u << fi->inode.i_blkbits,
-	};
-}
-
 static void fuse_sb_defaults(struct super_block *sb)
 {
 	sb->s_magic = FUSE_SUPER_MAGIC;
@@ -1451,7 +1451,7 @@ static int fuse_fill_super_submount(struct super_block *sb,
 	if (parent_sb->s_subtype && !sb->s_subtype)
 		return -ENOMEM;
 
-	fuse_fill_attr_from_inode(&root_attr, parent_fi);
+	fuse_fill_attr_from_inode(&root_attr, &parent_fi->inode);
 	root = fuse_iget(sb, parent_fi->nodeid, 0, &root_attr, 0, 0);
 	/*
 	 * This inode is just a duplicate, so it is not looked up and
-- 
2.37.3.998.g577e59143f-goog

