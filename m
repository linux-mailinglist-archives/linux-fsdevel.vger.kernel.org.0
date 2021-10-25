Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1099343A412
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Oct 2021 22:09:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237113AbhJYUMK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Oct 2021 16:12:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237254AbhJYULt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Oct 2021 16:11:49 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91104C04A41D;
        Mon, 25 Oct 2021 12:30:23 -0700 (PDT)
Received: from localhost (unknown [IPv6:2804:14c:124:8a08::1002])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: krisman)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 09DAC1F433B0;
        Mon, 25 Oct 2021 20:30:21 +0100 (BST)
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     amir73il@gmail.com, jack@suse.com
Cc:     djwong@kernel.org, tytso@mit.edu, david@fromorbit.com,
        dhowells@redhat.com, khazhy@google.com,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-ext4@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com, Jan Kara <jack@suse.cz>
Subject: [PATCH v9 22/31] fanotify: Wrap object_fh inline space in a creator macro
Date:   Mon, 25 Oct 2021 16:27:37 -0300
Message-Id: <20211025192746.66445-23-krisman@collabora.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211025192746.66445-1-krisman@collabora.com>
References: <20211025192746.66445-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

fanotify_error_event would duplicate this sequence of declarations that
already exist elsewhere with a slight different size.  Create a helper
macro to avoid code duplication.

Suggested-by: Jan Kara <jack@suse.cz>
Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>

---
Changes since v8:
  - Drop comment (Amir)
  - Pass fanotify_fh object name to constructor (Jan)
---
 fs/notify/fanotify/fanotify.h | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/fs/notify/fanotify/fanotify.h b/fs/notify/fanotify/fanotify.h
index 2b032b79d5b0..3510d06654ed 100644
--- a/fs/notify/fanotify/fanotify.h
+++ b/fs/notify/fanotify/fanotify.h
@@ -171,12 +171,18 @@ static inline void fanotify_init_event(struct fanotify_event *event,
 	event->pid = NULL;
 }
 
+#define FANOTIFY_INLINE_FH(name, size)					\
+struct {								\
+	struct fanotify_fh (name);					\
+	/* Space for object_fh.buf[] - access with fanotify_fh_buf() */	\
+	unsigned char _inline_fh_buf[(size)];				\
+}
+
 struct fanotify_fid_event {
 	struct fanotify_event fae;
 	__kernel_fsid_t fsid;
-	struct fanotify_fh object_fh;
-	/* Reserve space in object_fh.buf[] - access with fanotify_fh_buf() */
-	unsigned char _inline_fh_buf[FANOTIFY_INLINE_FH_LEN];
+
+	FANOTIFY_INLINE_FH(object_fh, FANOTIFY_INLINE_FH_LEN);
 };
 
 static inline struct fanotify_fid_event *
-- 
2.33.0

