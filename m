Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4DC03A8CF6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jun 2021 01:56:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231354AbhFOX6N (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Jun 2021 19:58:13 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:39898 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbhFOX6M (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Jun 2021 19:58:12 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id A7E861F432D9
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     amir73il@gmail.com
Cc:     kernel@collabora.com, djwong@kernel.org, tytso@mit.edu,
        david@fromorbit.com, jack@suse.com, dhowells@redhat.com,
        khazhy@google.com, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>
Subject: [PATCH v2 01/14] fsnotify: Don't call insert hook for overflow events
Date:   Tue, 15 Jun 2021 19:55:43 -0400
Message-Id: <20210615235556.970928-2-krisman@collabora.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210615235556.970928-1-krisman@collabora.com>
References: <20210615235556.970928-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Overflow events are not mergeable, so they are not hashed_events.  But,
when failing inside fsnotify_add_event, for lack of space,
fsnotify_add_event() still calls the insert hook, which adds the
overflow event to the merge list.

Avoid calling the insert hook when adding an overflow event.

Fixes: 94e00d28a680 ("fsnotify: use hash table for faster events merge")
Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
---
 fs/notify/notification.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/notify/notification.c b/fs/notify/notification.c
index 32f45543b9c6..033294669e07 100644
--- a/fs/notify/notification.c
+++ b/fs/notify/notification.c
@@ -106,6 +106,11 @@ int fsnotify_add_event(struct fsnotify_group *group,
 			return ret;
 		}
 		event = group->overflow_event;
+		/*
+		 * Since overflow events are not mergeable, don't insert
+		 * them in the merge hash.
+		 */
+		insert = NULL;
 		goto queue;
 	}
 
-- 
2.31.0

