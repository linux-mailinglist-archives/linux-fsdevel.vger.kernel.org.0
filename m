Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F4C93B7857
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Jun 2021 21:12:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235490AbhF2TO6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Jun 2021 15:14:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234228AbhF2TO6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Jun 2021 15:14:58 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 898D3C061760;
        Tue, 29 Jun 2021 12:12:30 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 3A2811F431AF
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     amir73il@gmail.com
Cc:     djwong@kernel.org, tytso@mit.edu, david@fromorbit.com,
        jack@suse.com, dhowells@redhat.com, khazhy@google.com,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com
Subject: [PATCH v3 06/15] fsnotify: Add helper to detect overflow_event
Date:   Tue, 29 Jun 2021 15:10:26 -0400
Message-Id: <20210629191035.681913-7-krisman@collabora.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210629191035.681913-1-krisman@collabora.com>
References: <20210629191035.681913-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Similarly to fanotify_is_perm_event and friends, provide a helper
predicate to say whether a mask is of an overflow event.

Suggested-by: Amir Goldstein <amir73il@gmail.com>
Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
---
 fs/notify/fanotify/fanotify.h    | 3 ++-
 include/linux/fsnotify_backend.h | 5 +++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/notify/fanotify/fanotify.h b/fs/notify/fanotify/fanotify.h
index fd125a949187..2e005b3a75f2 100644
--- a/fs/notify/fanotify/fanotify.h
+++ b/fs/notify/fanotify/fanotify.h
@@ -328,7 +328,8 @@ static inline struct path *fanotify_event_path(struct fanotify_event *event)
  */
 static inline bool fanotify_is_hashed_event(u32 mask)
 {
-	return !fanotify_is_perm_event(mask) && !(mask & FS_Q_OVERFLOW);
+	return !(fanotify_is_perm_event(mask) ||
+		 fsnotify_is_overflow_event(mask));
 }
 
 static inline unsigned int fanotify_event_hash_bucket(
diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
index c4473b467c28..f9e2c6cd0f7d 100644
--- a/include/linux/fsnotify_backend.h
+++ b/include/linux/fsnotify_backend.h
@@ -495,6 +495,11 @@ static inline void fsnotify_queue_overflow(struct fsnotify_group *group)
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
2.32.0

