Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3490853F22F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jun 2022 00:43:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234175AbiFFWnR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Jun 2022 18:43:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234653AbiFFWnM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Jun 2022 18:43:12 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F024D5AA50;
        Mon,  6 Jun 2022 15:43:10 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id q26so11301784wra.1;
        Mon, 06 Jun 2022 15:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=flhc2bjGgeU1Uh7kdSN+H9vnxcGUJoDaVIlrbma8sJY=;
        b=FehPZlCyPH3iov0pt6Y+UqdwfrEeqMNx/7t1PrbZzpoIhz5hpZIKuJjyyMB8x2R6U3
         BFd7aXoGss3eEbEFbH1xLjPQLgtmZ3XZR2Y0JO41aBKurHtoR2uVKcKADEV/7qqx6V5u
         FRNmCsoiRWoyw+bFcYeG69Yj9+FSt4JKJulYe+Q1SmoClshHxuYAbTheypd9t5X+dMfV
         9Ibzo0s+lhAxP/LfqefveNu4vq3+bKUPDRX0UhHXx+0Hjt0gEwtwnuKwDWA7vwfEyyd0
         w7GDsdbwgncfwYvAnNBx4I4HLUpispXCoo8F12AYvxMdNZWzfj35HZ6ZmX0cqI758tN3
         19xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=flhc2bjGgeU1Uh7kdSN+H9vnxcGUJoDaVIlrbma8sJY=;
        b=C8MJjaltf+VGUl3Sz7W+lnef1ZZEBYAIbatMDNbS5tP+2A2h8Lo5YC7Je41al1LFt7
         u363y/9ZnoSIMar34i4DsI+Lpv/Drn/LPmIm7tBHC91JPRKEK7cDpV9CO8D/xLxQ58qC
         qheB4Yt6NBrgd1VUjn+Rw+NHt4Zirrn2D9wkof36PkjPnY9UB+nv8mJTi7dAx4y8oj68
         qg7OL++1XUMAuFrUV1qcAH/76K8tAfaLEkmbhyykaK/q4+8Y+geNe1lkjrWbEiqOhW6S
         XTbS9BmowcdASRlehlJNpGBqkv/Pe94rJJXa+q+Ek0EubAEwlIeFjbmXOl+9sVd/BxL9
         iPTw==
X-Gm-Message-State: AOAM530MnHgOcVx14XzaQFGzSA1QBqIKcUSacutfd+j6Vh3RCOe8RzmC
        ZrpHKWTM5Z2WrSkFv5OxenZweosJ4BKSxBS3
X-Google-Smtp-Source: ABdhPJxw8rKEkOnEqEf9QyDV8rxF3iwMVuK2gu7RoUWJ+63pW17KuLuIn7CBcYfXviShFMyDFQR7rA==
X-Received: by 2002:a5d:6d0c:0:b0:216:2433:5317 with SMTP id e12-20020a5d6d0c000000b0021624335317mr14890810wrq.263.1654555389161;
        Mon, 06 Jun 2022 15:43:09 -0700 (PDT)
Received: from DESKTOP-URN0IMF.localdomain (cpc78047-stav21-2-0-cust145.17-3.cable.virginm.net. [80.195.223.146])
        by smtp.gmail.com with ESMTPSA id l14-20020adfe58e000000b002117ef160fbsm16060582wrm.21.2022.06.06.15.43.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jun 2022 15:43:08 -0700 (PDT)
From:   Oliver Ford <ojford@gmail.com>
To:     linux-fsdevel@vger.kernel.org, jack@suse.cz, amir73il@gmail.com
Cc:     linux-kernel@vger.kernel.org, ojford@gmail.com
Subject: [PATCH 1/1] fs: inotify: Add full paths option to inotify
Date:   Mon,  6 Jun 2022 23:42:41 +0100
Message-Id: <20220606224241.25254-2-ojford@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220606224241.25254-1-ojford@gmail.com>
References: <20220606224241.25254-1-ojford@gmail.com>
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

Adds a flag IN_FULL_PATHS which causes inotify
to return the full path instead of only a filename.

Includes a permissions check on IN_MOVE_SELF to prevent
exposing paths if the user does not have permission to view
the new path.

Signed-off-by: Oliver Ford <ojford@gmail.com>
---
 fs/notify/inotify/inotify_fsnotify.c | 55 ++++++++++++++++++++++------
 fs/notify/inotify/inotify_user.c     | 19 +++++++++-
 include/linux/inotify.h              |  2 +-
 include/uapi/linux/inotify.h         |  1 +
 4 files changed, 63 insertions(+), 14 deletions(-)

diff --git a/fs/notify/inotify/inotify_fsnotify.c b/fs/notify/inotify/inotify_fsnotify.c
index 49cfe2ae6d23..6334d1d6d5f5 100644
--- a/fs/notify/inotify/inotify_fsnotify.c
+++ b/fs/notify/inotify/inotify_fsnotify.c
@@ -64,12 +64,39 @@ int inotify_handle_inode_event(struct fsnotify_mark *inode_mark, u32 mask,
 	struct inotify_event_info *event;
 	struct fsnotify_event *fsn_event;
 	struct fsnotify_group *group = inode_mark->group;
+	struct dentry *en = NULL;
 	int ret;
 	int len = 0;
 	int alloc_len = sizeof(struct inotify_event_info);
 	struct mem_cgroup *old_memcg;
-
-	if (name) {
+	char *path_buf, *path_bufp = NULL;
+	bool found_full_path = false;
+
+	if (inode_mark->mask & IN_FULL_PATHS && inode) {
+		mask |= IN_FULL_PATHS;
+		en = d_find_any_alias(inode);
+		if (en)
+			found_full_path = true;
+		else if (dir)
+			en = d_find_any_alias(dir);
+
+		if (en) {
+			path_buf = kmalloc(PATH_MAX, GFP_KERNEL);
+			if (unlikely(!path_buf))
+				goto oom;
+
+			path_bufp = dentry_path_raw(en, path_buf, PATH_MAX);
+			len = strlen(path_bufp);
+			alloc_len += len + 1;
+
+			if (!found_full_path) {
+				*(path_bufp + len) = '/';
+				strcat(path_bufp + len + 1, name->name);
+				len += name->len + 1;
+				alloc_len += name->len + 1;
+			}
+		}
+	} else if (name) {
 		len = name->len;
 		alloc_len += len + 1;
 	}
@@ -89,14 +116,8 @@ int inotify_handle_inode_event(struct fsnotify_mark *inode_mark, u32 mask,
 	event = kmalloc(alloc_len, GFP_KERNEL_ACCOUNT | __GFP_RETRY_MAYFAIL);
 	set_active_memcg(old_memcg);
 
-	if (unlikely(!event)) {
-		/*
-		 * Treat lost event due to ENOMEM the same way as queue
-		 * overflow to let userspace know event was lost.
-		 */
-		fsnotify_queue_overflow(group);
-		return -ENOMEM;
-	}
+	if (unlikely(!event))
+		goto oom;
 
 	/*
 	 * We now report FS_ISDIR flag with MOVE_SELF and DELETE_SELF events
@@ -113,8 +134,13 @@ int inotify_handle_inode_event(struct fsnotify_mark *inode_mark, u32 mask,
 	event->wd = i_mark->wd;
 	event->sync_cookie = cookie;
 	event->name_len = len;
-	if (len)
+
+	if (path_bufp) {
+		strcpy(event->name, path_bufp);
+		kfree(path_buf);
+	} else if (len) {
 		strcpy(event->name, name->name);
+	}
 
 	ret = fsnotify_add_event(group, fsn_event, inotify_merge);
 	if (ret) {
@@ -126,6 +152,13 @@ int inotify_handle_inode_event(struct fsnotify_mark *inode_mark, u32 mask,
 		fsnotify_destroy_mark(inode_mark, group);
 
 	return 0;
+oom:
+	/*
+	 * Treat lost event due to ENOMEM the same way as queue
+	 * overflow to let userspace know event was lost.
+	 */
+	fsnotify_queue_overflow(group);
+	return -ENOMEM;
 }
 
 static void inotify_freeing_mark(struct fsnotify_mark *fsn_mark, struct fsnotify_group *group)
diff --git a/fs/notify/inotify/inotify_user.c b/fs/notify/inotify/inotify_user.c
index ed42a189faa2..2a0ad59250ce 100644
--- a/fs/notify/inotify/inotify_user.c
+++ b/fs/notify/inotify/inotify_user.c
@@ -57,6 +57,7 @@ struct kmem_cache *inotify_inode_mark_cachep __read_mostly;
 
 static long it_zero = 0;
 static long it_int_max = INT_MAX;
+static struct inotify_inode_mark *inotify_idr_find(struct fsnotify_group *, int);
 
 static struct ctl_table inotify_table[] = {
 	{
@@ -110,7 +111,7 @@ static inline __u32 inotify_arg_to_mask(struct inode *inode, u32 arg)
 		mask |= FS_EVENT_ON_CHILD;
 
 	/* mask off the flags used to open the fd */
-	mask |= (arg & INOTIFY_USER_MASK);
+	mask |= (arg & (INOTIFY_USER_MASK | IN_FULL_PATHS));
 
 	return mask;
 }
@@ -203,6 +204,8 @@ static ssize_t copy_event_to_user(struct fsnotify_group *group,
 {
 	struct inotify_event inotify_event;
 	struct inotify_event_info *event;
+	struct path event_path;
+	struct inotify_inode_mark *i_mark;
 	size_t event_size = sizeof(struct inotify_event);
 	size_t name_len;
 	size_t pad_name_len;
@@ -210,6 +213,18 @@ static ssize_t copy_event_to_user(struct fsnotify_group *group,
 	pr_debug("%s: group=%p event=%p\n", __func__, group, fsn_event);
 
 	event = INOTIFY_E(fsn_event);
+	/* ensure caller has access to view the full path */
+	if (event->mask & IN_FULL_PATHS && event->mask & IN_MOVE_SELF &&
+	    kern_path(event->name, 0, &event_path)) {
+		i_mark = inotify_idr_find(group, event->wd);
+		if (likely(i_mark)) {
+			fsnotify_destroy_mark(&i_mark->fsn_mark, group);
+			/* match ref taken by inotify_idr_find */
+			fsnotify_put_mark(&i_mark->fsn_mark);
+		}
+		return -EACCES;
+	}
+
 	name_len = event->name_len;
 	/*
 	 * round up name length so it is a multiple of event_size
@@ -860,7 +875,7 @@ static int __init inotify_user_setup(void)
 	BUILD_BUG_ON(IN_IGNORED != FS_IN_IGNORED);
 	BUILD_BUG_ON(IN_ISDIR != FS_ISDIR);
 
-	BUILD_BUG_ON(HWEIGHT32(ALL_INOTIFY_BITS) != 22);
+	BUILD_BUG_ON(HWEIGHT32(ALL_INOTIFY_BITS) != 23);
 
 	inotify_inode_mark_cachep = KMEM_CACHE(inotify_inode_mark,
 					       SLAB_PANIC|SLAB_ACCOUNT);
diff --git a/include/linux/inotify.h b/include/linux/inotify.h
index 8d20caa1b268..11db0541cff5 100644
--- a/include/linux/inotify.h
+++ b/include/linux/inotify.h
@@ -15,6 +15,6 @@
 			  IN_DELETE_SELF | IN_MOVE_SELF | IN_UNMOUNT | \
 			  IN_Q_OVERFLOW | IN_IGNORED | IN_ONLYDIR | \
 			  IN_DONT_FOLLOW | IN_EXCL_UNLINK | IN_MASK_ADD | \
-			  IN_MASK_CREATE | IN_ISDIR | IN_ONESHOT)
+			  IN_MASK_CREATE | IN_ISDIR | IN_ONESHOT | IN_FULL_PATHS)
 
 #endif	/* _LINUX_INOTIFY_H */
diff --git a/include/uapi/linux/inotify.h b/include/uapi/linux/inotify.h
index 884b4846b630..d95e05aa9bd6 100644
--- a/include/uapi/linux/inotify.h
+++ b/include/uapi/linux/inotify.h
@@ -50,6 +50,7 @@ struct inotify_event {
 #define IN_MOVE			(IN_MOVED_FROM | IN_MOVED_TO) /* moves */
 
 /* special flags */
+#define IN_FULL_PATHS		0x00800000	/* return the absolute path in the name */
 #define IN_ONLYDIR		0x01000000	/* only watch the path if it is a directory */
 #define IN_DONT_FOLLOW		0x02000000	/* don't follow a sym link */
 #define IN_EXCL_UNLINK		0x04000000	/* exclude events on unlinked objects */
-- 
2.35.1

