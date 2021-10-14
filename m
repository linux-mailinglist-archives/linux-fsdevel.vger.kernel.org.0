Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C05942E394
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Oct 2021 23:39:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233930AbhJNVlV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Oct 2021 17:41:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231596AbhJNVlV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Oct 2021 17:41:21 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0B44C061570;
        Thu, 14 Oct 2021 14:39:15 -0700 (PDT)
Received: from localhost (unknown [IPv6:2804:14c:124:8a08::1007])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: krisman)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 537351F44F8C;
        Thu, 14 Oct 2021 22:39:14 +0100 (BST)
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     jack@suse.com, amir73il@gmail.com
Cc:     djwong@kernel.org, tytso@mit.edu, dhowells@redhat.com,
        khazhy@google.com, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-api@vger.kernel.org,
        repnop@google.com, Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com
Subject: [PATCH v7 19/28] fanotify: Limit number of marks with FAN_FS_ERROR per group
Date:   Thu, 14 Oct 2021 18:36:37 -0300
Message-Id: <20211014213646.1139469-20-krisman@collabora.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211014213646.1139469-1-krisman@collabora.com>
References: <20211014213646.1139469-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Since FAN_FS_ERROR memory must be pre-allocated, limit a single group
from watching too many file systems at once.  The current scheme
guarantees 1 slot per filesystem, so limit the number of marks with
FAN_FS_ERROR per group.

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
---
 fs/notify/fanotify/fanotify_user.c | 10 ++++++++++
 include/linux/fsnotify_backend.h   |  1 +
 2 files changed, 11 insertions(+)

diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index f1cf863d6f9f..5324890500fc 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -959,6 +959,10 @@ static int fanotify_remove_mark(struct fsnotify_group *group,
 
 	removed = fanotify_mark_remove_from_mask(fsn_mark, mask, flags,
 						 umask, &destroy_mark);
+
+	if (removed & FAN_FS_ERROR)
+		group->fanotify_data.error_event_marks--;
+
 	if (removed & fsnotify_conn_mask(fsn_mark->connector))
 		fsnotify_recalc_mask(fsn_mark->connector);
 	if (destroy_mark)
@@ -1057,6 +1061,9 @@ static struct fsnotify_mark *fanotify_add_new_mark(struct fsnotify_group *group,
 
 static int fanotify_group_init_error_pool(struct fsnotify_group *group)
 {
+	if (group->fanotify_data.error_event_marks >= FANOTIFY_DEFAULT_FEE_POOL)
+		return -ENOMEM;
+
 	if (mempool_initialized(&group->fanotify_data.error_events_pool))
 		return 0;
 
@@ -1098,6 +1105,9 @@ static int fanotify_add_mark(struct fsnotify_group *group,
 	if (added & ~fsnotify_conn_mask(fsn_mark->connector))
 		fsnotify_recalc_mask(fsn_mark->connector);
 
+	if (!(flags & FAN_MARK_IGNORED_MASK) && (mask & FAN_FS_ERROR))
+		group->fanotify_data.error_event_marks++;
+
 out:
 	mutex_unlock(&group->mark_mutex);
 
diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
index 9941c06b8c8a..96e1d31394ce 100644
--- a/include/linux/fsnotify_backend.h
+++ b/include/linux/fsnotify_backend.h
@@ -247,6 +247,7 @@ struct fsnotify_group {
 			int f_flags; /* event_f_flags from fanotify_init() */
 			struct ucounts *ucounts;
 			mempool_t error_events_pool;
+			unsigned int error_event_marks;
 		} fanotify_data;
 #endif /* CONFIG_FANOTIFY */
 	};
-- 
2.33.0

