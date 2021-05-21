Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63FAF38BC8D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 May 2021 04:42:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238682AbhEUCnr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 May 2021 22:43:47 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:54932 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231681AbhEUCnq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 May 2021 22:43:46 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 93E351F43D7A
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     amir73il@gmail.com
Cc:     Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com, "Darrick J . Wong" <djwong@kernel.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Dave Chinner <david@fromorbit.com>, jack@suse.com,
        dhowells@redhat.com, khazhy@google.com,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: [PATCH 07/11] fsnotify: Introduce helpers to send error_events
Date:   Thu, 20 May 2021 22:41:30 -0400
Message-Id: <20210521024134.1032503-8-krisman@collabora.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210521024134.1032503-1-krisman@collabora.com>
References: <20210521024134.1032503-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>

---
Changes since v2:
  - Use the inode argument (Amir)
---
 include/linux/fsnotify.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/include/linux/fsnotify.h b/include/linux/fsnotify.h
index f8acddcf54fb..458e4feb5fe1 100644
--- a/include/linux/fsnotify.h
+++ b/include/linux/fsnotify.h
@@ -317,4 +317,17 @@ static inline void fsnotify_change(struct dentry *dentry, unsigned int ia_valid)
 		fsnotify_dentry(dentry, mask);
 }
 
+static inline void fsnotify_error_event(struct super_block *sb, struct inode *inode,
+					int error)
+{
+	if (sb->s_fsnotify_marks) {
+		struct fs_error_report report = {
+			.error = error,
+			.inode = inode,
+		};
+		fsnotify(FS_ERROR, &report, FSNOTIFY_EVENT_ERROR, NULL, NULL,
+			 sb->s_root->d_inode, 0);
+	}
+}
+
 #endif	/* _LINUX_FS_NOTIFY_H */
-- 
2.31.0

