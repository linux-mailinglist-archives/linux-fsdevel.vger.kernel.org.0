Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C79C143A0DD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Oct 2021 21:34:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235668AbhJYTgA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Oct 2021 15:36:00 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:58606 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235120AbhJYTc3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Oct 2021 15:32:29 -0400
Received: from localhost (unknown [IPv6:2804:14c:124:8a08::1002])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: krisman)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 0E0771F433AC;
        Mon, 25 Oct 2021 20:28:52 +0100 (BST)
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     amir73il@gmail.com, jack@suse.com
Cc:     djwong@kernel.org, tytso@mit.edu, david@fromorbit.com,
        dhowells@redhat.com, khazhy@google.com,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-ext4@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com, Jan Kara <jack@suse.cz>
Subject: [PATCH v9 08/31] fsnotify: Add helper to detect overflow_event
Date:   Mon, 25 Oct 2021 16:27:23 -0300
Message-Id: <20211025192746.66445-9-krisman@collabora.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211025192746.66445-1-krisman@collabora.com>
References: <20211025192746.66445-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Similarly to fanotify_is_perm_event and friends, provide a helper
predicate to say whether a mask is of an overflow event.

Suggested-by: Amir Goldstein <amir73il@gmail.com>
Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
---
 fs/notify/fanotify/fanotify.h    | 3 ++-
 include/linux/fsnotify_backend.h | 5 +++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/notify/fanotify/fanotify.h b/fs/notify/fanotify/fanotify.h
index 4a5e555dc3d2..c42cf8fd7d79 100644
--- a/fs/notify/fanotify/fanotify.h
+++ b/fs/notify/fanotify/fanotify.h
@@ -315,7 +315,8 @@ static inline struct path *fanotify_event_path(struct fanotify_event *event)
  */
 static inline bool fanotify_is_hashed_event(u32 mask)
 {
-	return !fanotify_is_perm_event(mask) && !(mask & FS_Q_OVERFLOW);
+	return !(fanotify_is_perm_event(mask) ||
+		 fsnotify_is_overflow_event(mask));
 }
 
 static inline unsigned int fanotify_event_hash_bucket(
diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
index a2db821e8a8f..749bc85e1d1c 100644
--- a/include/linux/fsnotify_backend.h
+++ b/include/linux/fsnotify_backend.h
@@ -510,6 +510,11 @@ static inline void fsnotify_queue_overflow(struct fsnotify_group *group)
 	fsnotify_add_event(group, group->overflow_event, NULL, NULL);
 }
 
+static inline bool fsnotify_is_overflow_event(u32 mask)
+{
+	return mask & FS_Q_OVERFLOW;
+}
+
 static inline bool fsnotify_notify_queue_is_empty(struct fsnotify_group *group)
 {
 	assert_spin_locked(&group->notification_lock);
-- 
2.33.0

