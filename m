Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1DC63B785F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Jun 2021 21:13:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235507AbhF2TPM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Jun 2021 15:15:12 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:34926 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235504AbhF2TPM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Jun 2021 15:15:12 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id ADA1D1F431AF
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     amir73il@gmail.com
Cc:     djwong@kernel.org, tytso@mit.edu, david@fromorbit.com,
        jack@suse.com, dhowells@redhat.com, khazhy@google.com,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com
Subject: [PATCH v3 09/15] fsnotify: Always run the merge hook
Date:   Tue, 29 Jun 2021 15:10:29 -0400
Message-Id: <20210629191035.681913-10-krisman@collabora.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210629191035.681913-1-krisman@collabora.com>
References: <20210629191035.681913-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

FS_FAN_ERROR must be able to merge events even in the short window after
they've been unqueued but prior to being read.  Move the list_empty
check into the merge hooks, such that merge() is always invoked if
existing.

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
---
 fs/notify/fanotify/fanotify.c        | 3 ++-
 fs/notify/inotify/inotify_fsnotify.c | 3 +++
 fs/notify/notification.c             | 2 +-
 3 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index aba06b84da91..769703ef2b9a 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -168,7 +168,8 @@ static int fanotify_merge(struct fsnotify_group *group,
 	 * the event structure we have created in fanotify_handle_event() is the
 	 * one we should check for permission response.
 	 */
-	if (fanotify_is_perm_event(new->mask))
+	if (list_empty(&group->notification_list) ||
+	    fanotify_is_perm_event(new->mask))
 		return 0;
 
 	hlist_for_each_entry(old, hlist, merge_list) {
diff --git a/fs/notify/inotify/inotify_fsnotify.c b/fs/notify/inotify/inotify_fsnotify.c
index a003a64ff8ee..2f357b4933c2 100644
--- a/fs/notify/inotify/inotify_fsnotify.c
+++ b/fs/notify/inotify/inotify_fsnotify.c
@@ -52,6 +52,9 @@ static int inotify_merge(struct fsnotify_group *group,
 	struct list_head *list = &group->notification_list;
 	struct fsnotify_event *last_event;
 
+	if (list_empty(list))
+		return 0;
+
 	last_event = list_entry(list->prev, struct fsnotify_event, list);
 	return event_compare(last_event, event);
 }
diff --git a/fs/notify/notification.c b/fs/notify/notification.c
index 0d9ba592d725..1d06e0728a24 100644
--- a/fs/notify/notification.c
+++ b/fs/notify/notification.c
@@ -111,7 +111,7 @@ int fsnotify_add_event(struct fsnotify_group *group,
 		goto queue;
 	}
 
-	if (!list_empty(list) && merge) {
+	if (merge) {
 		ret = merge(group, event);
 		if (ret) {
 			spin_unlock(&group->notification_lock);
-- 
2.32.0

