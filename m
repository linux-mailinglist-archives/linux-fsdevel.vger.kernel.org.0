Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E76BD3E0562
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Aug 2021 18:07:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232540AbhHDQHc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Aug 2021 12:07:32 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:42018 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232614AbhHDQH3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Aug 2021 12:07:29 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 15DF81F4366A
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     jack@suse.com, amir73il@gmail.com
Cc:     djwong@kernel.org, tytso@mit.edu, david@fromorbit.com,
        dhowells@redhat.com, khazhy@google.com,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-api@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com
Subject: [PATCH v5 12/23] fanotify: Expose helper to estimate file handle encoding length
Date:   Wed,  4 Aug 2021 12:06:01 -0400
Message-Id: <20210804160612.3575505-13-krisman@collabora.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210804160612.3575505-1-krisman@collabora.com>
References: <20210804160612.3575505-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Superblock marks needs this when pre-allocating error events.

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
---
 fs/notify/fanotify/fanotify.c | 18 ------------------
 fs/notify/fanotify/fanotify.h | 18 ++++++++++++++++++
 2 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index 538d114f439f..a015822e29d8 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -334,24 +334,6 @@ static u32 fanotify_group_event_mask(struct fsnotify_group *group,
 	return test_mask & user_mask;
 }
 
-/*
- * Check size needed to encode fanotify_fh.
- *
- * Return size of encoded fh without fanotify_fh header.
- * Return 0 on failure to encode.
- */
-static int fanotify_encode_fh_len(struct inode *inode)
-{
-	int dwords = 0;
-
-	if (!inode)
-		return 0;
-
-	exportfs_encode_inode_fh(inode, NULL, &dwords, NULL);
-
-	return dwords << 2;
-}
-
 /*
  * Encode fanotify_fh.
  *
diff --git a/fs/notify/fanotify/fanotify.h b/fs/notify/fanotify/fanotify.h
index d4a562c2619f..8061040f0348 100644
--- a/fs/notify/fanotify/fanotify.h
+++ b/fs/notify/fanotify/fanotify.h
@@ -348,3 +348,21 @@ static inline unsigned int fanotify_event_hash_bucket(
 {
 	return event->hash & FANOTIFY_HTABLE_MASK;
 }
+
+/*
+ * Check size needed to encode fanotify_fh.
+ *
+ * Return size of encoded fh without fanotify_fh header.
+ * Return 0 on failure to encode.
+ */
+static inline int fanotify_encode_fh_len(struct inode *inode)
+{
+	int dwords = 0;
+
+	if (!inode)
+		return 0;
+
+	exportfs_encode_inode_fh(inode, NULL, &dwords, NULL);
+
+	return dwords << 2;
+}
-- 
2.32.0

