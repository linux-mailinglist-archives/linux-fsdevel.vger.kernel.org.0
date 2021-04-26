Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 707DB36B93D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Apr 2021 20:45:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239493AbhDZSnx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Apr 2021 14:43:53 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:47502 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239394AbhDZSne (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Apr 2021 14:43:34 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id D52811F422D6
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     amir73il@gmail.com, tytso@mit.edu, djwong@kernel.org
Cc:     david@fromorbit.com, jack@suse.com, dhowells@redhat.com,
        khazhy@google.com, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com
Subject: [PATCH RFC 08/15] fsnotify: Introduce helpers to send error_events
Date:   Mon, 26 Apr 2021 14:41:54 -0400
Message-Id: <20210426184201.4177978-9-krisman@collabora.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210426184201.4177978-1-krisman@collabora.com>
References: <20210426184201.4177978-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
---
 include/linux/fsnotify.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/include/linux/fsnotify.h b/include/linux/fsnotify.h
index f8acddcf54fb..b3ac1a9d0d4d 100644
--- a/include/linux/fsnotify.h
+++ b/include/linux/fsnotify.h
@@ -317,4 +317,19 @@ static inline void fsnotify_change(struct dentry *dentry, unsigned int ia_valid)
 		fsnotify_dentry(dentry, mask);
 }
 
+static inline void fsnotify_error_event(int error, struct inode *dir,
+					const char *function, int line,
+					void *fs_data, int fs_data_size)
+{
+	struct fs_error_report report = {
+		.error = error,
+		.line = line,
+		.function = function,
+		.fs_data_size = fs_data_size,
+		.fs_data = fs_data,
+	};
+
+	fsnotify(FS_ERROR, &report, FSNOTIFY_EVENT_ERROR, dir, NULL, NULL, 0);
+}
+
 #endif	/* _LINUX_FS_NOTIFY_H */
-- 
2.31.0

