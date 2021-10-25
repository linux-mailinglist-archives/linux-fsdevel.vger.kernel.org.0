Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6CEF43A0A9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Oct 2021 21:33:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235980AbhJYTcw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Oct 2021 15:32:52 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:58232 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235958AbhJYTar (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Oct 2021 15:30:47 -0400
Received: from localhost (unknown [IPv6:2804:14c:124:8a08::1002])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: krisman)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id A27451F430E8;
        Mon, 25 Oct 2021 20:28:22 +0100 (BST)
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     amir73il@gmail.com, jack@suse.com
Cc:     djwong@kernel.org, tytso@mit.edu, david@fromorbit.com,
        dhowells@redhat.com, khazhy@google.com,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-ext4@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com, Jan Kara <jack@suse.cz>
Subject: [PATCH v9 04/31] fsnotify: Don't insert unmergeable events in hashtable
Date:   Mon, 25 Oct 2021 16:27:19 -0300
Message-Id: <20211025192746.66445-5-krisman@collabora.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211025192746.66445-1-krisman@collabora.com>
References: <20211025192746.66445-1-krisman@collabora.com>
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
Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Reviewed-by: Jan Kara <jack@suse.cz>
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
2.33.0

