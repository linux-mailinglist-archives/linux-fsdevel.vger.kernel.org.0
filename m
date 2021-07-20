Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3BF23CFED4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jul 2021 18:12:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229903AbhGTP2w (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Jul 2021 11:28:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240495AbhGTPUm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Jul 2021 11:20:42 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63E15C0613EE;
        Tue, 20 Jul 2021 09:00:09 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id D43781F4312B
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     jack@suse.com, amir73il@gmail.com
Cc:     djwong@kernel.org, tytso@mit.edu, david@fromorbit.com,
        dhowells@redhat.com, khazhy@google.com,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com
Subject: [PATCH v4 04/16] fsnotify: Reserve mark bits for backends
Date:   Tue, 20 Jul 2021 11:59:32 -0400
Message-Id: <20210720155944.1447086-5-krisman@collabora.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210720155944.1447086-1-krisman@collabora.com>
References: <20210720155944.1447086-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Split out the final bits of struct fsnotify_mark->flags for use by a
backend.

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
---
 include/linux/fsnotify_backend.h | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
index 1ce66748a2d2..9d5586445c65 100644
--- a/include/linux/fsnotify_backend.h
+++ b/include/linux/fsnotify_backend.h
@@ -363,6 +363,21 @@ struct fsnotify_mark_connector {
 	struct hlist_head list;
 };
 
+#define FSNOTIFY_MARK_FLAG(flag)	\
+static const unsigned int FSNOTIFY_MARK_FLAG_##flag = \
+	(1 << FSN_MARK_FL_BIT_##flag)
+
+enum fsnotify_mark_bits {
+	FSN_MARK_FL_BIT_IGNORED_SURV_MODIFY,
+	FSN_MARK_FL_BIT_ALIVE,
+	FSN_MARK_FL_BIT_ATTACHED,
+	FSN_MARK_PRIVATE_FLAGS,
+};
+
+FSNOTIFY_MARK_FLAG(IGNORED_SURV_MODIFY);
+FSNOTIFY_MARK_FLAG(ALIVE);
+FSNOTIFY_MARK_FLAG(ATTACHED);
+
 /*
  * A mark is simply an object attached to an in core inode which allows an
  * fsnotify listener to indicate they are either no longer interested in events
@@ -398,9 +413,7 @@ struct fsnotify_mark {
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

