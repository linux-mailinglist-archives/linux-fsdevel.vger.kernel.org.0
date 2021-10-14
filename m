Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7020C42E38F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Oct 2021 23:39:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233305AbhJNVlP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Oct 2021 17:41:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233624AbhJNVlO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Oct 2021 17:41:14 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78D8FC061570;
        Thu, 14 Oct 2021 14:39:09 -0700 (PDT)
Received: from localhost (unknown [IPv6:2804:14c:124:8a08::1007])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: krisman)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id A5EC31F44F83;
        Thu, 14 Oct 2021 22:39:07 +0100 (BST)
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     jack@suse.com, amir73il@gmail.com
Cc:     djwong@kernel.org, tytso@mit.edu, dhowells@redhat.com,
        khazhy@google.com, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-api@vger.kernel.org,
        repnop@google.com, Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com
Subject: [PATCH v7 18/28] fanotify: Pre-allocate pool of error events
Date:   Thu, 14 Oct 2021 18:36:36 -0300
Message-Id: <20211014213646.1139469-19-krisman@collabora.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211014213646.1139469-1-krisman@collabora.com>
References: <20211014213646.1139469-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Error reporting needs to be done in an atomic context.  This patch
introduces a group-wide mempool of error events, shared by all
marks in this group.

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
---
 fs/notify/fanotify/fanotify.c      |  3 +++
 fs/notify/fanotify/fanotify.h      | 11 +++++++++++
 fs/notify/fanotify/fanotify_user.c | 26 +++++++++++++++++++++++++-
 include/linux/fsnotify_backend.h   |  2 ++
 4 files changed, 41 insertions(+), 1 deletion(-)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index 8f152445d75c..01d68dfc74aa 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -819,6 +819,9 @@ static void fanotify_free_group_priv(struct fsnotify_group *group)
 	if (group->fanotify_data.ucounts)
 		dec_ucount(group->fanotify_data.ucounts,
 			   UCOUNT_FANOTIFY_GROUPS);
+
+	if (mempool_initialized(&group->fanotify_data.error_events_pool))
+		mempool_exit(&group->fanotify_data.error_events_pool);
 }
 
 static void fanotify_free_path_event(struct fanotify_event *event)
diff --git a/fs/notify/fanotify/fanotify.h b/fs/notify/fanotify/fanotify.h
index c42cf8fd7d79..a577e87fac2b 100644
--- a/fs/notify/fanotify/fanotify.h
+++ b/fs/notify/fanotify/fanotify.h
@@ -141,6 +141,7 @@ enum fanotify_event_type {
 	FANOTIFY_EVENT_TYPE_PATH,
 	FANOTIFY_EVENT_TYPE_PATH_PERM,
 	FANOTIFY_EVENT_TYPE_OVERFLOW, /* struct fanotify_event */
+	FANOTIFY_EVENT_TYPE_FS_ERROR, /* struct fanotify_error_event */
 	__FANOTIFY_EVENT_TYPE_NUM
 };
 
@@ -196,6 +197,16 @@ FANOTIFY_NE(struct fanotify_event *event)
 	return container_of(event, struct fanotify_name_event, fae);
 }
 
+struct fanotify_error_event {
+	struct fanotify_event fae;
+};
+
+static inline struct fanotify_error_event *
+FANOTIFY_EE(struct fanotify_event *event)
+{
+	return container_of(event, struct fanotify_error_event, fae);
+}
+
 static inline __kernel_fsid_t *fanotify_event_fsid(struct fanotify_event *event)
 {
 	if (event->type == FANOTIFY_EVENT_TYPE_FID)
diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index 66ee3c2805c7..f1cf863d6f9f 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -30,6 +30,7 @@
 #define FANOTIFY_DEFAULT_MAX_EVENTS	16384
 #define FANOTIFY_OLD_DEFAULT_MAX_MARKS	8192
 #define FANOTIFY_DEFAULT_MAX_GROUPS	128
+#define FANOTIFY_DEFAULT_FEE_POOL	32
 
 /*
  * Legacy fanotify marks limits (8192) is per group and we introduced a tunable
@@ -1054,6 +1055,15 @@ static struct fsnotify_mark *fanotify_add_new_mark(struct fsnotify_group *group,
 	return ERR_PTR(ret);
 }
 
+static int fanotify_group_init_error_pool(struct fsnotify_group *group)
+{
+	if (mempool_initialized(&group->fanotify_data.error_events_pool))
+		return 0;
+
+	return mempool_init_kmalloc_pool(&group->fanotify_data.error_events_pool,
+					 FANOTIFY_DEFAULT_FEE_POOL,
+					 sizeof(struct fanotify_error_event));
+}
 
 static int fanotify_add_mark(struct fsnotify_group *group,
 			     fsnotify_connp_t *connp, unsigned int type,
@@ -1062,6 +1072,7 @@ static int fanotify_add_mark(struct fsnotify_group *group,
 {
 	struct fsnotify_mark *fsn_mark;
 	__u32 added;
+	int ret = 0;
 
 	mutex_lock(&group->mark_mutex);
 	fsn_mark = fsnotify_find_mark(connp, group);
@@ -1072,13 +1083,26 @@ static int fanotify_add_mark(struct fsnotify_group *group,
 			return PTR_ERR(fsn_mark);
 		}
 	}
+
+	/*
+	 * Error events are pre-allocated per group, only if strictly
+	 * needed (i.e. FAN_FS_ERROR was requested).
+	 */
+	if (!(flags & FAN_MARK_IGNORED_MASK) && (mask & FAN_FS_ERROR)) {
+		ret = fanotify_group_init_error_pool(group);
+		if (ret)
+			goto out;
+	}
+
 	added = fanotify_mark_add_to_mask(fsn_mark, mask, flags);
 	if (added & ~fsnotify_conn_mask(fsn_mark->connector))
 		fsnotify_recalc_mask(fsn_mark->connector);
+
+out:
 	mutex_unlock(&group->mark_mutex);
 
 	fsnotify_put_mark(fsn_mark);
-	return 0;
+	return ret;
 }
 
 static int fanotify_add_vfsmount_mark(struct fsnotify_group *group,
diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
index a378a314e309..9941c06b8c8a 100644
--- a/include/linux/fsnotify_backend.h
+++ b/include/linux/fsnotify_backend.h
@@ -19,6 +19,7 @@
 #include <linux/atomic.h>
 #include <linux/user_namespace.h>
 #include <linux/refcount.h>
+#include <linux/mempool.h>
 
 /*
  * IN_* from inotfy.h lines up EXACTLY with FS_*, this is so we can easily
@@ -245,6 +246,7 @@ struct fsnotify_group {
 			int flags;           /* flags from fanotify_init() */
 			int f_flags; /* event_f_flags from fanotify_init() */
 			struct ucounts *ucounts;
+			mempool_t error_events_pool;
 		} fanotify_data;
 #endif /* CONFIG_FANOTIFY */
 	};
-- 
2.33.0

