Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2799C6E56A6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Apr 2023 03:41:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbjDRBlr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Apr 2023 21:41:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230316AbjDRBlS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Apr 2023 21:41:18 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FEDE6EB5
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Apr 2023 18:41:07 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id j6-20020a255506000000b00b8ef3da4acfso22707268ybb.8
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Apr 2023 18:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681782066; x=1684374066;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ma6LP7l9KdDYxD0yEhLpdRJpUgrAcoFlwvcgm95S2g0=;
        b=d51SS6WG6e8IhBQxgiwtwAX6W6u5b/p5f3qAWDcVPo2jEbJQRrKfqB7fD2WB7ABXfm
         f1QDkxS0AxwE1oa6FQ4jYY7ixPpnGwXCPx+AsK15KrITTIQeNrqN2cahcwamg4mHST/1
         dLSOe/MQEeIXaOymPStG/HcmyjMuppTVyWgNDT62/a0q/oG3tDfVWH7rMGNawaD0o+Tp
         Ni0kuHRqOhAOcNAtD4v/LtaKrjnY1QvynB5VRgotRKQA6MFysty3xo5ey1gq6oFLlnLv
         /nnda2RIAREqoKgyxD+dqXX80U30yBXf5e+3lSppGCBf17IWxLGBotULgIChHzE5mTEv
         issw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681782066; x=1684374066;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ma6LP7l9KdDYxD0yEhLpdRJpUgrAcoFlwvcgm95S2g0=;
        b=d6KJ6pNUHy1HNV5ayHXn1vU27eMdI1miJr2+hTsy1kiTySzoN+IAmuRP7JquREB0d5
         +iYI7LItToIbGUIAe/QEp9BfDts6w7lYdHAgp75M/ZR6eRHekvv/u5xvMOANrkVFEGOm
         q0AoBnGvYtIGGaihocGUBLP7NoKO3U+34xBXLjHe4in6w7NAAIRW/z1DlYruCBeiUJwT
         7g3B8v1hfiqjEDODUTaZn4o1gwuwJLZqJb5o1ty0alDX9o5DqZw264coYeClanOT5z2q
         v2v+lwJKYVpr5QZGUh+0GT6sQfMQ/hrWLN9J0wm/xQIA5iBj2XbFJ5cJ+tKG2uqC363s
         tizQ==
X-Gm-Message-State: AAQBX9e3TGEnn/J9gfPvcN81RJ6Hh+oXL5fE64eiRIDmWXE2EXfqVceB
        XEB7/dohtVE77AIlnnxL3kzMtfHc1RY=
X-Google-Smtp-Source: AKy350al/X5V7uOGTMzTFULq0yhZ2D34oueue8qfbReq7qB7OLV2hrBAIi9Rsio853MG4jn2Pq7Glue+WGc=
X-Received: from drosen.mtv.corp.google.com ([2620:15c:211:201:e67a:98b0:942d:86aa])
 (user=drosen job=sendgmr) by 2002:a25:aaad:0:b0:b8f:6a46:537d with SMTP id
 t42-20020a25aaad000000b00b8f6a46537dmr8996331ybi.6.1681782066667; Mon, 17 Apr
 2023 18:41:06 -0700 (PDT)
Date:   Mon, 17 Apr 2023 18:40:07 -0700
In-Reply-To: <20230418014037.2412394-1-drosen@google.com>
Mime-Version: 1.0
References: <20230418014037.2412394-1-drosen@google.com>
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
Message-ID: <20230418014037.2412394-8-drosen@google.com>
Subject: [RFC PATCH v3 07/37] fuse-bpf: Prepare for fuse-bpf patch
From:   Daniel Rosenberg <drosen@google.com>
To:     Miklos Szeredi <miklos@szeredi.hu>, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>
Cc:     Amir Goldstein <amir73il@gmail.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Joanne Koong <joannelkoong@gmail.com>,
        Mykola Lysenko <mykolal@fb.com>, kernel-team@android.com,
        Daniel Rosenberg <drosen@google.com>,
        Paul Lawrence <paullawrence@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
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
 fs/fuse/inode.c  | 44 ++++++++++++++++++++++----------------------
 3 files changed, 57 insertions(+), 52 deletions(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 35bc174f9ba2..55dd6e8b2e43 100644
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
index 9b7fc7d3c7f1..01ca8bb87b4f 100644
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
@@ -1324,4 +1332,31 @@ struct fuse_file *fuse_file_open(struct fuse_mount *fm, u64 nodeid,
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
index d66070af145d..a824ca100047 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -162,6 +162,28 @@ static ino_t fuse_squash_ino(u64 ino64)
 	return ino;
 }
 
+static void fuse_fill_attr_from_inode(struct fuse_attr *attr,
+				      const struct fuse_inode *fi)
+{
+	*attr = (struct fuse_attr){
+		.ino		= fi->inode.i_ino,
+		.size		= fi->inode.i_size,
+		.blocks		= fi->inode.i_blocks,
+		.atime		= fi->inode.i_atime.tv_sec,
+		.mtime		= fi->inode.i_mtime.tv_sec,
+		.ctime		= fi->inode.i_ctime.tv_sec,
+		.atimensec	= fi->inode.i_atime.tv_nsec,
+		.mtimensec	= fi->inode.i_mtime.tv_nsec,
+		.ctimensec	= fi->inode.i_ctime.tv_nsec,
+		.mode		= fi->inode.i_mode,
+		.nlink		= fi->inode.i_nlink,
+		.uid		= fi->inode.i_uid.val,
+		.gid		= fi->inode.i_gid.val,
+		.rdev		= fi->inode.i_rdev,
+		.blksize	= 1u << fi->inode.i_blkbits,
+	};
+}
+
 void fuse_change_attributes_common(struct inode *inode, struct fuse_attr *attr,
 				   u64 attr_valid, u32 cache_mask)
 {
@@ -1394,28 +1416,6 @@ void fuse_dev_free(struct fuse_dev *fud)
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
-- 
2.40.0.634.g4ca3ef3211-goog

