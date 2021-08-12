Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92D103EAC84
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Aug 2021 23:40:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237554AbhHLVlJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Aug 2021 17:41:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237478AbhHLVlJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Aug 2021 17:41:09 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0D30C061756;
        Thu, 12 Aug 2021 14:40:43 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 640FD1F4443C
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     amir73il@gmail.com, jack@suse.com
Cc:     linux-api@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, khazhy@google.com,
        dhowells@redhat.com, david@fromorbit.com, tytso@mit.edu,
        djwong@kernel.org, repnop@google.com,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com
Subject: [PATCH v6 04/21] fsnotify: Reserve mark flag bits for backends
Date:   Thu, 12 Aug 2021 17:39:53 -0400
Message-Id: <20210812214010.3197279-5-krisman@collabora.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210812214010.3197279-1-krisman@collabora.com>
References: <20210812214010.3197279-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Split out the final bits of struct fsnotify_mark->flags for use by a
backend.

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>

Changes since v1:
  - turn consts into defines (jan)
---
 include/linux/fsnotify_backend.h | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
index 1ce66748a2d2..ae1bd9f06808 100644
--- a/include/linux/fsnotify_backend.h
+++ b/include/linux/fsnotify_backend.h
@@ -363,6 +363,20 @@ struct fsnotify_mark_connector {
 	struct hlist_head list;
 };
 
+enum fsnotify_mark_bits {
+	FSN_MARK_FL_BIT_IGNORED_SURV_MODIFY,
+	FSN_MARK_FL_BIT_ALIVE,
+	FSN_MARK_FL_BIT_ATTACHED,
+	FSN_MARK_PRIVATE_FLAGS,
+};
+
+#define FSNOTIFY_MARK_FLAG_IGNORED_SURV_MODIFY \
+	(1 << FSN_MARK_FL_BIT_IGNORED_SURV_MODIFY)
+#define FSNOTIFY_MARK_FLAG_ALIVE \
+	(1 << FSN_MARK_FL_BIT_ALIVE)
+#define FSNOTIFY_MARK_FLAG_ATTACHED \
+	(1 << FSN_MARK_FL_BIT_ATTACHED)
+
 /*
  * A mark is simply an object attached to an in core inode which allows an
  * fsnotify listener to indicate they are either no longer interested in events
@@ -398,9 +412,7 @@ struct fsnotify_mark {
 	struct fsnotify_mark_connector *connector;
 	/* Events types to ignore [mark->lock, group->mark_mutex] */
 	__u32 ignored_mask;
-#define FSNOTIFY_MARK_FLAG_IGNORED_SURV_MODIFY	0x01
-#define FSNOTIFY_MARK_FLAG_ALIVE		0x02
-#define FSNOTIFY_MARK_FLAG_ATTACHED		0x04
+	/* Upper bits [31:PRIVATE_FLAGS] are reserved for backend usage */
 	unsigned int flags;		/* flags [mark->lock] */
 };
 
-- 
2.32.0

