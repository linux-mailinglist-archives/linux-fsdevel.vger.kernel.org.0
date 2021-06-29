Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 203933B784D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Jun 2021 21:12:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235463AbhF2TO0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Jun 2021 15:14:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234228AbhF2TOW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Jun 2021 15:14:22 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A517C061760;
        Tue, 29 Jun 2021 12:11:55 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id D22E71F431AF
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     amir73il@gmail.com
Cc:     djwong@kernel.org, tytso@mit.edu, david@fromorbit.com,
        jack@suse.com, dhowells@redhat.com, khazhy@google.com,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com
Subject: [PATCH v3 01/15] fsnotify: Don't insert unmergeable events in hashtable
Date:   Tue, 29 Jun 2021 15:10:21 -0400
Message-Id: <20210629191035.681913-2-krisman@collabora.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210629191035.681913-1-krisman@collabora.com>
References: <20210629191035.681913-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Some events, like the overflow event, are not mergeable, so they are not
hashed.  But, when failing inside fsnotify_add_event for lack of space,
fsnotify_add_event() still calls the insert hook, which adds the
overflow event to the merge list.  Add a check to prevent any kind of
unmergeable event to be inserted in the hashtable.

Fixes: 94e00d28a680 ("fsnotify: use hash table for faster events merge")
Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>

---
Changes since v2:
  - Do check for hashed events inside the insert hook (Amir)
---
 fs/notify/fanotify/fanotify.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index 057abd2cf887..310246f8d3f1 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -702,6 +702,9 @@ static void fanotify_insert_event(struct fsnotify_group *group,
 
 	assert_spin_locked(&group->notification_lock);
 
+	if (!fanotify_is_hashed_event(event->mask))
+		return;
+
 	pr_debug("%s: group=%p event=%p bucket=%u\n", __func__,
 		 group, event, bucket);
 
@@ -779,8 +782,7 @@ static int fanotify_handle_event(struct fsnotify_group *group, u32 mask,
 
 	fsn_event = &event->fse;
 	ret = fsnotify_add_event(group, fsn_event, fanotify_merge,
-				 fanotify_is_hashed_event(mask) ?
-				 fanotify_insert_event : NULL);
+				 fanotify_insert_event);
 	if (ret) {
 		/* Permission events shouldn't be merged */
 		BUG_ON(ret == 1 && mask & FANOTIFY_PERM_EVENTS);
-- 
2.32.0

