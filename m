Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCD6532D120
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Mar 2021 11:51:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238995AbhCDKth (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Mar 2021 05:49:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238969AbhCDKtN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Mar 2021 05:49:13 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 979F8C061761
        for <linux-fsdevel@vger.kernel.org>; Thu,  4 Mar 2021 02:48:32 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id l22so7606279wme.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 04 Mar 2021 02:48:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KY4v/lAiRDKaTAU1cBNP603O0UGzbr8hqEENSNgZaPE=;
        b=DufkW1dIBLRSXC0X4Lz+CBquNNMQEq391KkCmKxG4hvzO5Oc5vIdLIRQDrLjx+QO/j
         qxCeZL/1U8ikHspOaGl1bpYA5M4fgjiOBHbPnf5NYuez0lejQ3j2RioF2JSsTllS9+x7
         ScGLSvasZBju2oAx39CcwKhIkk0OFmURdFUiEbWTU500heYChbGTUWMCGfRxlqxEJbEE
         GPD5prBDG5QOFyY/Xw/YOI52V0Im1hhqTrfArGP5RWCPzndWA62edNSLJx56W/4rVCiJ
         W+GvIeMGjvkV9Ez0brvzofTttBwgUO//mGwvMjfTV6giFE7xPmmXYPuoJ43O6nOuPlQB
         HznQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KY4v/lAiRDKaTAU1cBNP603O0UGzbr8hqEENSNgZaPE=;
        b=lUvlIKrANgb3jPuRPlyAn3SfSwVgXxqNShD9M/bnatjUZnYe9v+GGnsHQu1k6Hfn58
         Qhg/IUQkUGnmaiErNi5QM5aqqeHYj2+ond8QGNQ/M/Gnp02yKyrGYr/GlkZiGOfskBni
         6kIFBD6lePbN41VLI2T8aF7ab3AUqVihDjynpy5MxUomuaDbzNuYd83JzQ7AbA7Q+sRX
         OpJugv9Dv167Hyu1PI45dzby+WtaGGxijXy2AgVQ5bCLYrkp0rO3BzlabZ+y2cQDaArJ
         fxYRhT5qj6b1UbNDXSwvJ4auuw3r/X3h0xQO+cg3HBBhfqkVlE3zZRg80NzHKbiEtuOt
         bOpQ==
X-Gm-Message-State: AOAM531eXUlazQHmRENqKcVvLEROk3HFER4/ZTcKS3uE7ovTjJMJr9k1
        R99h9W0pRON/c5YlDFXeDLo=
X-Google-Smtp-Source: ABdhPJzUZancA5cSy+DWzKB8ept91fiUDlbWSKUqNcbQ+ZvCNIdPTPGiVpDzcUPNmtw+TBF10C1rxw==
X-Received: by 2002:a1c:6309:: with SMTP id x9mr3299181wmb.62.1614854911384;
        Thu, 04 Mar 2021 02:48:31 -0800 (PST)
Received: from localhost.localdomain ([141.226.13.117])
        by smtp.gmail.com with ESMTPSA id d7sm6736635wrs.42.2021.03.04.02.48.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Mar 2021 02:48:31 -0800 (PST)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 2/5] fanotify: reduce event objectid to 29-bit hash
Date:   Thu,  4 Mar 2021 12:48:23 +0200
Message-Id: <20210304104826.3993892-3-amir73il@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210304104826.3993892-1-amir73il@gmail.com>
References: <20210304104826.3993892-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

objectid is only used by fanotify backend and it is just an optimization
for event merge before comparing all fields in event.

Move the objectid member from common struct fsnotify_event into struct
fanotify_event and reduce it to 29-bit hash to cram it together with the
3-bit event type.

Events of different types are never merged, so the combination of event
type and hash form a 32-bit key for fast compare of events.

This reduces the size of events by one pointer and paves the way for
adding hashed queue support for fanotify.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/notify/fanotify/fanotify.c        | 25 ++++++++++++-------------
 fs/notify/fanotify/fanotify.h        | 16 +++++++++++++---
 fs/notify/inotify/inotify_fsnotify.c |  2 +-
 fs/notify/inotify/inotify_user.c     |  2 +-
 include/linux/fsnotify_backend.h     |  5 +----
 5 files changed, 28 insertions(+), 22 deletions(-)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index 1192c9953620..8a2bb6954e02 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -88,16 +88,12 @@ static bool fanotify_name_event_equal(struct fanotify_name_event *fne1,
 	return fanotify_info_equal(info1, info2);
 }
 
-static bool fanotify_should_merge(struct fsnotify_event *old_fsn,
-				  struct fsnotify_event *new_fsn)
+static bool fanotify_should_merge(struct fanotify_event *old,
+				  struct fanotify_event *new)
 {
-	struct fanotify_event *old, *new;
+	pr_debug("%s: old=%p new=%p\n", __func__, old, new);
 
-	pr_debug("%s: old=%p new=%p\n", __func__, old_fsn, new_fsn);
-	old = FANOTIFY_E(old_fsn);
-	new = FANOTIFY_E(new_fsn);
-
-	if (old_fsn->objectid != new_fsn->objectid ||
+	if (old->hash != new->hash ||
 	    old->type != new->type || old->pid != new->pid)
 		return false;
 
@@ -133,10 +129,9 @@ static bool fanotify_should_merge(struct fsnotify_event *old_fsn,
 static int fanotify_merge(struct list_head *list, struct fsnotify_event *event)
 {
 	struct fsnotify_event *test_event;
-	struct fanotify_event *new;
+	struct fanotify_event *old, *new = FANOTIFY_E(event);
 
 	pr_debug("%s: list=%p event=%p\n", __func__, list, event);
-	new = FANOTIFY_E(event);
 
 	/*
 	 * Don't merge a permission event with any other event so that we know
@@ -147,8 +142,9 @@ static int fanotify_merge(struct list_head *list, struct fsnotify_event *event)
 		return 0;
 
 	list_for_each_entry_reverse(test_event, list, list) {
-		if (fanotify_should_merge(test_event, event)) {
-			FANOTIFY_E(test_event)->mask |= new->mask;
+		old = FANOTIFY_E(test_event);
+		if (fanotify_should_merge(old, new)) {
+			old->mask |= new->mask;
 			return 1;
 		}
 	}
@@ -533,6 +529,7 @@ static struct fanotify_event *fanotify_alloc_event(struct fsnotify_group *group,
 	struct mem_cgroup *old_memcg;
 	struct inode *child = NULL;
 	bool name_event = false;
+	unsigned int hash = 0;
 
 	if ((fid_mode & FAN_REPORT_DIR_FID) && dirid) {
 		/*
@@ -600,8 +597,10 @@ static struct fanotify_event *fanotify_alloc_event(struct fsnotify_group *group,
 	 * Use the victim inode instead of the watching inode as the id for
 	 * event queue, so event reported on parent is merged with event
 	 * reported on child when both directory and child watches exist.
+	 * Hash object id for queue merge.
 	 */
-	fanotify_init_event(event, (unsigned long)id, mask);
+	hash = hash_ptr(id, FANOTIFY_EVENT_HASH_BITS);
+	fanotify_init_event(event, hash, mask);
 	if (FAN_GROUP_FLAG(group, FAN_REPORT_TID))
 		event->pid = get_pid(task_pid(current));
 	else
diff --git a/fs/notify/fanotify/fanotify.h b/fs/notify/fanotify/fanotify.h
index 896c819a1786..d531f0cfa46f 100644
--- a/fs/notify/fanotify/fanotify.h
+++ b/fs/notify/fanotify/fanotify.h
@@ -135,19 +135,29 @@ enum fanotify_event_type {
 	FANOTIFY_EVENT_TYPE_PATH,
 	FANOTIFY_EVENT_TYPE_PATH_PERM,
 	FANOTIFY_EVENT_TYPE_OVERFLOW, /* struct fanotify_event */
+	__FANOTIFY_EVENT_TYPE_NUM
 };
 
+#define FANOTIFY_EVENT_TYPE_BITS \
+	(ilog2(__FANOTIFY_EVENT_TYPE_NUM - 1) + 1)
+#define FANOTIFY_EVENT_HASH_BITS \
+	(32 - FANOTIFY_EVENT_TYPE_BITS)
+
 struct fanotify_event {
 	struct fsnotify_event fse;
 	u32 mask;
-	enum fanotify_event_type type;
+	struct {
+		unsigned int type : FANOTIFY_EVENT_TYPE_BITS;
+		unsigned int hash : FANOTIFY_EVENT_HASH_BITS;
+	};
 	struct pid *pid;
 };
 
 static inline void fanotify_init_event(struct fanotify_event *event,
-				       unsigned long id, u32 mask)
+				       unsigned int hash, u32 mask)
 {
-	fsnotify_init_event(&event->fse, id);
+	fsnotify_init_event(&event->fse);
+	event->hash = hash;
 	event->mask = mask;
 	event->pid = NULL;
 }
diff --git a/fs/notify/inotify/inotify_fsnotify.c b/fs/notify/inotify/inotify_fsnotify.c
index 1901d799909b..0533bacbd584 100644
--- a/fs/notify/inotify/inotify_fsnotify.c
+++ b/fs/notify/inotify/inotify_fsnotify.c
@@ -107,7 +107,7 @@ int inotify_handle_inode_event(struct fsnotify_mark *inode_mark, u32 mask,
 		mask &= ~IN_ISDIR;
 
 	fsn_event = &event->fse;
-	fsnotify_init_event(fsn_event, 0);
+	fsnotify_init_event(fsn_event);
 	event->mask = mask;
 	event->wd = i_mark->wd;
 	event->sync_cookie = cookie;
diff --git a/fs/notify/inotify/inotify_user.c b/fs/notify/inotify/inotify_user.c
index a6c95bd64618..98f61b31745a 100644
--- a/fs/notify/inotify/inotify_user.c
+++ b/fs/notify/inotify/inotify_user.c
@@ -641,7 +641,7 @@ static struct fsnotify_group *inotify_new_group(unsigned int max_events)
 		return ERR_PTR(-ENOMEM);
 	}
 	group->overflow_event = &oevent->fse;
-	fsnotify_init_event(group->overflow_event, 0);
+	fsnotify_init_event(group->overflow_event);
 	oevent->mask = FS_Q_OVERFLOW;
 	oevent->wd = -1;
 	oevent->sync_cookie = 0;
diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
index 7eb979bfc141..fc98f9f88d12 100644
--- a/include/linux/fsnotify_backend.h
+++ b/include/linux/fsnotify_backend.h
@@ -167,7 +167,6 @@ struct fsnotify_ops {
  */
 struct fsnotify_event {
 	struct list_head list;
-	unsigned long objectid;	/* identifier for queue merges */
 };
 
 /*
@@ -582,11 +581,9 @@ extern void fsnotify_put_mark(struct fsnotify_mark *mark);
 extern void fsnotify_finish_user_wait(struct fsnotify_iter_info *iter_info);
 extern bool fsnotify_prepare_user_wait(struct fsnotify_iter_info *iter_info);
 
-static inline void fsnotify_init_event(struct fsnotify_event *event,
-				       unsigned long objectid)
+static inline void fsnotify_init_event(struct fsnotify_event *event)
 {
 	INIT_LIST_HEAD(&event->list);
-	event->objectid = objectid;
 }
 
 #else
-- 
2.30.0

