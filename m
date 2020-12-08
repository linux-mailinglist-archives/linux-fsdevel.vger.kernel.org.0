Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84DAA2D1EF7
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Dec 2020 01:32:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727330AbgLHAcO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Dec 2020 19:32:14 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:56578 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725853AbgLHAcO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Dec 2020 19:32:14 -0500
Received: from localhost (unknown [IPv6:2804:14c:132:242d::1001])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: krisman)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id BC57A1F44CFF;
        Tue,  8 Dec 2020 00:31:31 +0000 (GMT)
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     dhowells@redhat.com
Cc:     viro@zeniv.linux.org.uk, tytso@mit.edu, khazhy@google.com,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, kernel@collabora.com,
        Miklos Szeredi <mszeredi@redhat.com>,
        Gabriel Krisman Bertazi <krisman@collabora.com>
Subject: [PATCH 1/8] watch_queue: Make watch_sizeof() check record size
Date:   Mon,  7 Dec 2020 21:31:10 -0300
Message-Id: <20201208003117.342047-2-krisman@collabora.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201208003117.342047-1-krisman@collabora.com>
References: <20201208003117.342047-1-krisman@collabora.com>
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
2.29.2

