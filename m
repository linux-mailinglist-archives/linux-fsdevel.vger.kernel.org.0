Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF77F432ADF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Oct 2021 02:03:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234055AbhJSAFk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Oct 2021 20:05:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233786AbhJSAFk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Oct 2021 20:05:40 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DFA8C06161C;
        Mon, 18 Oct 2021 17:03:28 -0700 (PDT)
Received: from localhost (unknown [IPv6:2804:14c:124:8a08::1007])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: krisman)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id B53AC1F4344D;
        Tue, 19 Oct 2021 01:03:26 +0100 (BST)
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     jack@suse.com, amir73il@gmail.com
Cc:     djwong@kernel.org, tytso@mit.edu, david@fromorbit.com,
        dhowells@redhat.com, khazhy@google.com,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-api@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com, Jan Kara <jack@suse.cz>
Subject: [PATCH v8 23/32] fanotify: Wrap object_fh inline space in a creator macro
Date:   Mon, 18 Oct 2021 21:00:06 -0300
Message-Id: <20211019000015.1666608-24-krisman@collabora.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211019000015.1666608-1-krisman@collabora.com>
References: <20211019000015.1666608-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

fanotify_error_event would duplicate this sequence of declarations that
already exist elsewhere with a slight different size.  Create a helper
macro to avoid code duplication.

Suggested-by: Jan Kara <jack@suse.cz>
Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>

---
Among the suggestions, I think this is simpler because it avoids
deep nesting the variable-sized attribute, which would have been hidden
inside fee->ffe->object_fh.buf.

It also avoids touching the allocators, which are nicely hidden inside
helper KMEM_CACHE() macros that hides several parameters.
---
 fs/notify/fanotify/fanotify.h | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/fs/notify/fanotify/fanotify.h b/fs/notify/fanotify/fanotify.h
index 2b032b79d5b0..a5e81d759f65 100644
--- a/fs/notify/fanotify/fanotify.h
+++ b/fs/notify/fanotify/fanotify.h
@@ -171,12 +171,19 @@ static inline void fanotify_init_event(struct fanotify_event *event,
 	event->pid = NULL;
 }
 
+#define FANOTIFY_INLINE_FH(size)					\
+struct {								\
+	struct fanotify_fh object_fh;					\
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
+	/* This must be the last element of the structure. */
+	FANOTIFY_INLINE_FH(FANOTIFY_INLINE_FH_LEN);
 };
 
 static inline struct fanotify_fid_event *
-- 
2.33.0

