Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCDF94FF30E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Apr 2022 11:11:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234307AbiDMJMS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Apr 2022 05:12:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233053AbiDMJMI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Apr 2022 05:12:08 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FE8D19281
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Apr 2022 02:09:46 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 123-20020a1c1981000000b0038b3616a71aso738293wmz.4
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Apr 2022 02:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vnnFavNEYKMelMf26drUVQFBja+hKNlJs4XMRp/MaJQ=;
        b=S3N7KR9lBdVsxIbMvq1ys48Efe+Az+fSKJL7UT62Bhndgcx4UhqJX7nfBnhwLKuaXb
         6wjL12V4+PVVlilevYFbUZNQev8r9IjOsWYgX7J9F8oHT7KhVr40H4tvLV5HcbR+05w9
         QfU8GYrBx52xJhwYv6LyyJetGFmbaMetND0E8oy/2aiBUyq18+SPJ5quHgbdySYCY/9E
         3aiQzPJ/trnwrMQ662vAuSa7HF6mBblM5dAOaCQSxJnNYP/KHcu2MbNPArd5ehkvgudK
         WoD8DEuvAAASQzXWMq4XFtZdoYSs6adg4lvBdj3HHAtsNZ+U8NjZa2Dp84m+mnRvjyeo
         Aq4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vnnFavNEYKMelMf26drUVQFBja+hKNlJs4XMRp/MaJQ=;
        b=B9e8gAwq6LZLpY2kORrbhZTAmUonpa5TlQfOc/AL7o2KCJ4/IoUXbsnjdyh+GpDX5/
         aXz5Z0qUTPMcb1ix7LQus0z7vf+onMgAUeFvy/G/oTyL1f+ja0CRG2i6FdMCKYuVadBY
         lgDq8JoWfAqW7qxAVa5L1Mow3uuFI49tjT7TZhRxkR5wtHnxLfAcb4/0YuTB/Oeznpej
         ks//DQmPZRR6xmYedRewgQZt0knsIGn1X22lmUo/WAxCFy2FxNWT/BZGHlUgl/McDYEg
         +qu/2PxSw7GJIWKfxCK0OfdNUto1db4DzhRJzm2tOkoB1yJnE/5hslxiXXDFPvdi4F5v
         54wg==
X-Gm-Message-State: AOAM531J5XrWoC1pER9V4W996O6mNiEtpOH+KM/IWsfRROqNOkQ05n/S
        AsvIj1cZb6aOr1eMp6CAJ1bCFyqPQMA=
X-Google-Smtp-Source: ABdhPJx4jZ2Dxb4ChtKDKfBjrUaa+Sjvg82Ez4UoviyWp/iFKYAMdx3rwnb4Hg5H4FKXyBbs8+RgOA==
X-Received: by 2002:a7b:c057:0:b0:37b:ebad:c9c8 with SMTP id u23-20020a7bc057000000b0037bebadc9c8mr7560486wmc.61.1649840985059;
        Wed, 13 Apr 2022 02:09:45 -0700 (PDT)
Received: from localhost.localdomain ([5.29.13.154])
        by smtp.gmail.com with ESMTPSA id bk1-20020a0560001d8100b002061d6bdfd0sm24050518wrb.63.2022.04.13.02.09.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 02:09:44 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <repnop@google.com>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 05/16] fsnotify: pass flags argument to fsnotify_alloc_group()
Date:   Wed, 13 Apr 2022 12:09:24 +0300
Message-Id: <20220413090935.3127107-6-amir73il@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220413090935.3127107-1-amir73il@gmail.com>
References: <20220413090935.3127107-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add flags argument to fsnotify_alloc_group(), define and use the flag
FSNOTIFY_GROUP_USER in inotify and fanotify instead of the helper
fsnotify_alloc_user_group() to indicate user allocation.

Although the flag FSNOTIFY_GROUP_USER is currently not used after group
allocation, we store the flags argument in the group struct for future
use of other group flags.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/nfsd/filecache.c                |  3 ++-
 fs/notify/dnotify/dnotify.c        |  2 +-
 fs/notify/fanotify/fanotify_user.c |  3 ++-
 fs/notify/group.c                  | 21 +++++++++------------
 fs/notify/inotify/inotify_user.c   |  3 ++-
 include/linux/fsnotify_backend.h   | 10 ++++++++--
 kernel/audit_fsnotify.c            |  3 ++-
 kernel/audit_tree.c                |  2 +-
 kernel/audit_watch.c               |  2 +-
 9 files changed, 28 insertions(+), 21 deletions(-)

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index c08882f5867b..79a5b052fcdf 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -673,7 +673,8 @@ nfsd_file_cache_init(void)
 		goto out_shrinker;
 	}
 
-	nfsd_file_fsnotify_group = fsnotify_alloc_group(&nfsd_file_fsnotify_ops);
+	nfsd_file_fsnotify_group = fsnotify_alloc_group(&nfsd_file_fsnotify_ops,
+							0);
 	if (IS_ERR(nfsd_file_fsnotify_group)) {
 		pr_err("nfsd: unable to create fsnotify group: %ld\n",
 			PTR_ERR(nfsd_file_fsnotify_group));
diff --git a/fs/notify/dnotify/dnotify.c b/fs/notify/dnotify/dnotify.c
index 829dd4a61b66..e4779926edf4 100644
--- a/fs/notify/dnotify/dnotify.c
+++ b/fs/notify/dnotify/dnotify.c
@@ -401,7 +401,7 @@ static int __init dnotify_init(void)
 					  SLAB_PANIC|SLAB_ACCOUNT);
 	dnotify_mark_cache = KMEM_CACHE(dnotify_mark, SLAB_PANIC|SLAB_ACCOUNT);
 
-	dnotify_group = fsnotify_alloc_group(&dnotify_fsnotify_ops);
+	dnotify_group = fsnotify_alloc_group(&dnotify_fsnotify_ops, 0);
 	if (IS_ERR(dnotify_group))
 		panic("unable to allocate fsnotify group for dnotify\n");
 	dnotify_sysctl_init();
diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index 0f0db1efa379..bf72856da42e 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -1355,7 +1355,8 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flags, unsigned int, event_f_flags)
 		f_flags |= O_NONBLOCK;
 
 	/* fsnotify_alloc_group takes a ref.  Dropped in fanotify_release */
-	group = fsnotify_alloc_user_group(&fanotify_fsnotify_ops);
+	group = fsnotify_alloc_group(&fanotify_fsnotify_ops,
+				     FSNOTIFY_GROUP_USER);
 	if (IS_ERR(group)) {
 		return PTR_ERR(group);
 	}
diff --git a/fs/notify/group.c b/fs/notify/group.c
index b7d4d64f87c2..18446b7b0d49 100644
--- a/fs/notify/group.c
+++ b/fs/notify/group.c
@@ -112,7 +112,8 @@ void fsnotify_put_group(struct fsnotify_group *group)
 EXPORT_SYMBOL_GPL(fsnotify_put_group);
 
 static struct fsnotify_group *__fsnotify_alloc_group(
-				const struct fsnotify_ops *ops, gfp_t gfp)
+				const struct fsnotify_ops *ops,
+				int flags, gfp_t gfp)
 {
 	struct fsnotify_group *group;
 
@@ -133,6 +134,7 @@ static struct fsnotify_group *__fsnotify_alloc_group(
 	INIT_LIST_HEAD(&group->marks_list);
 
 	group->ops = ops;
+	group->flags = flags;
 
 	return group;
 }
@@ -140,20 +142,15 @@ static struct fsnotify_group *__fsnotify_alloc_group(
 /*
  * Create a new fsnotify_group and hold a reference for the group returned.
  */
-struct fsnotify_group *fsnotify_alloc_group(const struct fsnotify_ops *ops)
+struct fsnotify_group *fsnotify_alloc_group(const struct fsnotify_ops *ops,
+					    int flags)
 {
-	return __fsnotify_alloc_group(ops, GFP_KERNEL);
-}
-EXPORT_SYMBOL_GPL(fsnotify_alloc_group);
+	gfp_t gfp = (flags & FSNOTIFY_GROUP_USER) ? GFP_KERNEL_ACCOUNT :
+						    GFP_KERNEL;
 
-/*
- * Create a new fsnotify_group and hold a reference for the group returned.
- */
-struct fsnotify_group *fsnotify_alloc_user_group(const struct fsnotify_ops *ops)
-{
-	return __fsnotify_alloc_group(ops, GFP_KERNEL_ACCOUNT);
+	return __fsnotify_alloc_group(ops, flags, gfp);
 }
-EXPORT_SYMBOL_GPL(fsnotify_alloc_user_group);
+EXPORT_SYMBOL_GPL(fsnotify_alloc_group);
 
 int fsnotify_fasync(int fd, struct file *file, int on)
 {
diff --git a/fs/notify/inotify/inotify_user.c b/fs/notify/inotify/inotify_user.c
index 6fc0f598a7aa..65ff637cb4a3 100644
--- a/fs/notify/inotify/inotify_user.c
+++ b/fs/notify/inotify/inotify_user.c
@@ -656,7 +656,8 @@ static struct fsnotify_group *inotify_new_group(unsigned int max_events)
 	struct fsnotify_group *group;
 	struct inotify_event_info *oevent;
 
-	group = fsnotify_alloc_user_group(&inotify_fsnotify_ops);
+	group = fsnotify_alloc_group(&inotify_fsnotify_ops,
+				     FSNOTIFY_GROUP_USER);
 	if (IS_ERR(group))
 		return group;
 
diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
index 2ff686882303..2057ae4bf8e9 100644
--- a/include/linux/fsnotify_backend.h
+++ b/include/linux/fsnotify_backend.h
@@ -210,6 +210,11 @@ struct fsnotify_group {
 	unsigned int priority;
 	bool shutdown;		/* group is being shut down, don't queue more events */
 
+#define FSNOTIFY_GROUP_USER	0x01 /* user allocated group */
+#define FSNOTIFY_GROUP_FLAG(group, flag) \
+	((group)->flags & FSNOTIFY_GROUP_ ## flag)
+	int flags;
+
 	/* stores all fastpath marks assoc with this group so they can be cleaned on unregister */
 	struct mutex mark_mutex;	/* protect marks_list */
 	atomic_t user_waits;		/* Number of tasks waiting for user
@@ -544,8 +549,9 @@ static inline void fsnotify_update_flags(struct dentry *dentry)
 /* called from fsnotify listeners, such as fanotify or dnotify */
 
 /* create a new group */
-extern struct fsnotify_group *fsnotify_alloc_group(const struct fsnotify_ops *ops);
-extern struct fsnotify_group *fsnotify_alloc_user_group(const struct fsnotify_ops *ops);
+extern struct fsnotify_group *fsnotify_alloc_group(
+				const struct fsnotify_ops *ops,
+				int flags);
 /* get reference to a group */
 extern void fsnotify_get_group(struct fsnotify_group *group);
 /* drop reference on a group from fsnotify_alloc_group */
diff --git a/kernel/audit_fsnotify.c b/kernel/audit_fsnotify.c
index 3c35649bc7f5..95e8b75e7634 100644
--- a/kernel/audit_fsnotify.c
+++ b/kernel/audit_fsnotify.c
@@ -182,7 +182,8 @@ static const struct fsnotify_ops audit_mark_fsnotify_ops = {
 
 static int __init audit_fsnotify_init(void)
 {
-	audit_fsnotify_group = fsnotify_alloc_group(&audit_mark_fsnotify_ops);
+	audit_fsnotify_group = fsnotify_alloc_group(&audit_mark_fsnotify_ops,
+						    0);
 	if (IS_ERR(audit_fsnotify_group)) {
 		audit_fsnotify_group = NULL;
 		audit_panic("cannot create audit fsnotify group");
diff --git a/kernel/audit_tree.c b/kernel/audit_tree.c
index e7315d487163..b5c02f8573fe 100644
--- a/kernel/audit_tree.c
+++ b/kernel/audit_tree.c
@@ -1074,7 +1074,7 @@ static int __init audit_tree_init(void)
 
 	audit_tree_mark_cachep = KMEM_CACHE(audit_tree_mark, SLAB_PANIC);
 
-	audit_tree_group = fsnotify_alloc_group(&audit_tree_ops);
+	audit_tree_group = fsnotify_alloc_group(&audit_tree_ops, 0);
 	if (IS_ERR(audit_tree_group))
 		audit_panic("cannot initialize fsnotify group for rectree watches");
 
diff --git a/kernel/audit_watch.c b/kernel/audit_watch.c
index 713b256be944..4b0957aa2cd4 100644
--- a/kernel/audit_watch.c
+++ b/kernel/audit_watch.c
@@ -493,7 +493,7 @@ static const struct fsnotify_ops audit_watch_fsnotify_ops = {
 
 static int __init audit_watch_init(void)
 {
-	audit_watch_group = fsnotify_alloc_group(&audit_watch_fsnotify_ops);
+	audit_watch_group = fsnotify_alloc_group(&audit_watch_fsnotify_ops, 0);
 	if (IS_ERR(audit_watch_group)) {
 		audit_watch_group = NULL;
 		audit_panic("cannot create audit fsnotify group");
-- 
2.35.1

