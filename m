Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A87A1432AD6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Oct 2021 02:03:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234014AbhJSAFU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Oct 2021 20:05:20 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:40920 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbhJSAFT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Oct 2021 20:05:19 -0400
Received: from localhost (unknown [IPv6:2804:14c:124:8a08::1007])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: krisman)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 57C9B1F411B7;
        Tue, 19 Oct 2021 01:03:06 +0100 (BST)
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     jack@suse.com, amir73il@gmail.com
Cc:     djwong@kernel.org, tytso@mit.edu, david@fromorbit.com,
        dhowells@redhat.com, khazhy@google.com,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-api@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com
Subject: [PATCH v8 20/32] fanotify: Dynamically resize the FAN_FS_ERROR pool
Date:   Mon, 18 Oct 2021 21:00:03 -0300
Message-Id: <20211019000015.1666608-21-krisman@collabora.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211019000015.1666608-1-krisman@collabora.com>
References: <20211019000015.1666608-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Allow the FAN_FS_ERROR group mempool to grow up to an upper limit
dynamically, instead of starting already at the limit.  This doesn't
bother resizing on mark removal, but next time a mark is added, the slot
will be either reused or resized.  Also, if several marks are being
removed at once, most likely the group is going away anyway.

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
---
 fs/notify/fanotify/fanotify_user.c | 26 +++++++++++++++++++++-----
 include/linux/fsnotify_backend.h   |  1 +
 2 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index f77581c5b97f..a860c286e885 100644
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
@@ -1057,12 +1061,24 @@ static struct fsnotify_mark *fanotify_add_new_mark(struct fsnotify_group *group,
 
 static int fanotify_group_init_error_pool(struct fsnotify_group *group)
 {
-	if (mempool_initialized(&group->fanotify_data.error_events_pool))
-		return 0;
+	int ret;
+
+	if (group->fanotify_data.error_event_marks >=
+	    FANOTIFY_DEFAULT_MAX_FEE_POOL)
+		return -ENOMEM;
 
-	return mempool_init_kmalloc_pool(&group->fanotify_data.error_events_pool,
-					 FANOTIFY_DEFAULT_MAX_FEE_POOL,
-					 sizeof(struct fanotify_error_event));
+	if (!mempool_initialized(&group->fanotify_data.error_events_pool))
+		ret = mempool_init_kmalloc_pool(
+				&group->fanotify_data.error_events_pool,
+				 1, sizeof(struct fanotify_error_event));
+	else
+		ret = mempool_resize(&group->fanotify_data.error_events_pool,
+				     group->fanotify_data.error_event_marks + 1);
+
+	if (!ret)
+		group->fanotify_data.error_event_marks++;
+
+	return ret;
 }
 
 static int fanotify_add_mark(struct fsnotify_group *group,
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

