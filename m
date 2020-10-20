Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D93A72942CE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Oct 2020 21:15:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438035AbgJTTPw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Oct 2020 15:15:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438033AbgJTTPw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Oct 2020 15:15:52 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91576C0613CE;
        Tue, 20 Oct 2020 12:15:51 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 4722E1F44C34
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     dhowells@redhat.com
Cc:     viro@zeniv.linux.org.uk, tytso@mit.edu, khazhy@google.com,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, kernel@collabora.com,
        Miklos Szeredi <mszeredi@redhat.com>,
        Gabriel Krisman Bertazi <krisman@collabora.com>
Subject: [PATCH RFC 1/7] watch_queue: Make watch_sizeof() check record size
Date:   Tue, 20 Oct 2020 15:15:37 -0400
Message-Id: <20201020191543.601784-2-krisman@collabora.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201020191543.601784-1-krisman@collabora.com>
References: <20201020191543.601784-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: David Howells <dhowells@redhat.com>

Make watch_sizeof() give a build error if the size of the struct won't fit
into the size field in the header.

Reported-by: Miklos Szeredi <mszeredi@redhat.com>
Signed-off-by: David Howells <dhowells@redhat.com>
[Rebase to 5.10]
Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
---
 include/linux/watch_queue.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/linux/watch_queue.h b/include/linux/watch_queue.h
index c994d1b2cdba..f1086d12cd03 100644
--- a/include/linux/watch_queue.h
+++ b/include/linux/watch_queue.h
@@ -120,7 +120,12 @@ static inline void remove_watch_list(struct watch_list *wlist, u64 id)
  * watch_sizeof - Calculate the information part of the size of a watch record,
  * given the structure size.
  */
-#define watch_sizeof(STRUCT) (sizeof(STRUCT) << WATCH_INFO_LENGTH__SHIFT)
+#define watch_sizeof(STRUCT) \
+	({								\
+		size_t max = WATCH_INFO_LENGTH >> WATCH_INFO_LENGTH__SHIFT; \
+		BUILD_BUG_ON(sizeof(STRUCT) > max);			\
+		sizeof(STRUCT) << WATCH_INFO_LENGTH__SHIFT;		\
+	})
 
 #else
 static inline int watch_queue_init(struct pipe_inode_info *pipe)
-- 
2.28.0

