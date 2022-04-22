Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19AEA50B6C9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Apr 2022 14:05:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1447285AbiDVMIK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Apr 2022 08:08:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1447321AbiDVMHj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Apr 2022 08:07:39 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A529256778
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Apr 2022 05:03:41 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id u15so15896786ejf.11
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Apr 2022 05:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=R+LWM/p8WJgSPsSASRnlIjC1yHWAd61taxdqSyVV4fE=;
        b=Sgy7V0aUSYNARoNpdJ+j6tdie8uOOLVawk0eEQiUPWHXd0y8fqd8fgZtiAhhf3goZk
         DGNltTY/LuH+f5wKve6dDy2ZYhYAwfg4J5HON4ZnWU7C/+QDr78egJoecrjp5iibXJVa
         Yeuz6LPg2asVfIqa1snZwaH6N4LWGq19ShcP9n44zkkUvY5xi5rgrZLK9uaJMGDefCNp
         bBJM0ZjgrJTPUPiBlGo8MtmpJu2gUYeWNIbba8hKNYKQfhomJZnCNjTRNk+lfIcarsSs
         Zad+s/ezX441FETyKbYJGmN2FQD1D1QKNuctvyuKrq2IS0BTj9VbN8jyVSqACWIZ+REb
         mjww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R+LWM/p8WJgSPsSASRnlIjC1yHWAd61taxdqSyVV4fE=;
        b=WpsAKCodVtcNAGrZm8GSNacn16p7mvJWHLXYuainpbu4QBzaCF0y+1/76HQ+r7kLRR
         zP9bPyiv9k08OtagAKskkpyNiYzRytrstaXCP43zxxRtdCSmho+f2XozezWLrOmtMjPr
         OXsJ3wj/QutPDhmKxZbCafEiv2iIIQuMgk/EkdJgTW/1cjgpX4ps4aZKXrREkQNGQT98
         IrOmgdy8DBwGdyQzxJCU/+dnEJGmLYvU7lNExioisoTCv8zzagEB87PbF5T31DP1+hib
         a3WSzsKXLFq/pnIYUnmwfGVOjoQZVJRGuwjSM4I0f5INQNQ2YxGb654c4Q3D3l0pBqBI
         esFA==
X-Gm-Message-State: AOAM530Ytlu9Y2d1hRz8WO2RGmfPkMVil3SD9pOtMimReoeQDVQ2d5L9
        lrNzfKb8AnRT6fdgUQOE2oEW3IdVNys=
X-Google-Smtp-Source: ABdhPJzFVryYx4d7wz+fBlxTWBVDbZ99kyTORUBxzeXKdSbtwuJeSAXwgunt4em/h17UeKzuLwkoNw==
X-Received: by 2002:a17:906:dc93:b0:6e8:8d89:8099 with SMTP id cs19-20020a170906dc9300b006e88d898099mr3924579ejc.438.1650629020001;
        Fri, 22 Apr 2022 05:03:40 -0700 (PDT)
Received: from localhost.localdomain ([5.29.13.154])
        by smtp.gmail.com with ESMTPSA id x24-20020a1709064bd800b006ef606fe5c1sm697026ejv.43.2022.04.22.05.03.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 05:03:39 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <repnop@google.com>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v4 04/16] fsnotify: pass flags argument to fsnotify_alloc_group()
Date:   Fri, 22 Apr 2022 15:03:15 +0300
Message-Id: <20220422120327.3459282-5-amir73il@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220422120327.3459282-1-amir73il@gmail.com>
References: <20220422120327.3459282-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
 include/linux/fsnotify_backend.h   |  8 ++++++--
 kernel/audit_fsnotify.c            |  3 ++-
 kernel/audit_tree.c                |  2 +-
 kernel/audit_watch.c               |  2 +-
 9 files changed, 26 insertions(+), 21 deletions(-)

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index 2c1b027774d4..74ddb828fd75 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -678,7 +678,8 @@ nfsd_file_cache_init(void)
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
index 9b32b76a9c30..3649c99b3e45 100644
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
index d8907d32a05b..146890ecd93a 100644
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
index b1c72edd9784..f0bf557af009 100644
--- a/include/linux/fsnotify_backend.h
+++ b/include/linux/fsnotify_backend.h
@@ -210,6 +210,9 @@ struct fsnotify_group {
 	unsigned int priority;
 	bool shutdown;		/* group is being shut down, don't queue more events */
 
+#define FSNOTIFY_GROUP_USER	0x01 /* user allocated group */
+	int flags;
+
 	/* stores all fastpath marks assoc with this group so they can be cleaned on unregister */
 	struct mutex mark_mutex;	/* protect marks_list */
 	atomic_t user_waits;		/* Number of tasks waiting for user
@@ -543,8 +546,9 @@ static inline void fsnotify_update_flags(struct dentry *dentry)
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
index 02348b48447c..35fe149586c8 100644
--- a/kernel/audit_fsnotify.c
+++ b/kernel/audit_fsnotify.c
@@ -181,7 +181,8 @@ static const struct fsnotify_ops audit_mark_fsnotify_ops = {
 
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

