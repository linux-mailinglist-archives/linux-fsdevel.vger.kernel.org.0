Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E49ED221EB2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jul 2020 10:42:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728109AbgGPIm4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Jul 2020 04:42:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728097AbgGPImy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Jul 2020 04:42:54 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 730E8C061755
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Jul 2020 01:42:54 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id f7so6176529wrw.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Jul 2020 01:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FjhxQsP4iRuo8yocbgE+QaUb6CJxRl5+WUn5Ln9Tepo=;
        b=arh52T5xxFUL6kuLdV14VTOkI4bm7XAhF7xbAFoL18EESJelP0Gnewg/i4J/fSCs7e
         dcLmU1GNDOiUSCvSfsKywexB3kY/Z560gJjmoiMAfLfJDiV4jY9LOoBp3Y7wCjr7pGeP
         1J6v2tPFXUogTPQHqOUadkW+8Bk12rroR3F/D2Nph/axp0ViyMAFmt4wgoLaTJxLIAsm
         vpREzYU1/r2MMFjmsGjBeLCwvG/rXMJc31Vph5hMhW856bLuJcgk+YEEugPispJfCbv1
         Y47PenwMKwkaMF9xNyvRCfReKhqhpzTukLl1n9kP0KrbiaIpjKayI1T+JW9+isBDp2Co
         t+Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FjhxQsP4iRuo8yocbgE+QaUb6CJxRl5+WUn5Ln9Tepo=;
        b=XGIVPsSqC6aAJj+XZ1GiN+kUkEnYAHDsiHFM894hJxPOYj+UQxltCP7zE3dbG8J7xD
         Mq+SALCms4xoZA3EqDXSSummbJ5VhhKyDacHC4i6qldfETi2EWFZsWccYkD+7MSXPUTs
         0Hp3r62m/AszZdGccqMkRYGb58XCc3hAmLtyx2wSWXgzch2HJMXTJcn7UNmvzUSVHgTx
         kRar9q2asnAgULsNSiN43gyd67EtLGg7PDjSQSrUuJgxbPc3zEUvy5704ZzQBy+l4f+o
         ngXQkSxqIGgP7rnCadNqUhXTRC/4+OiQ//0bD9hvdzfIeNqZWvrG428gqv+Hzc6hhHyg
         Ul4A==
X-Gm-Message-State: AOAM531WzL88RGOGgwe/kFG6io9kK1zqR8+7iqIS2EtRc8WASY2LvFpn
        BUxXMaeKX3K66k2EPrLzc7R9jktE
X-Google-Smtp-Source: ABdhPJzuwQQiN3LvxzMLTBZnYyndanWScCV263b63sceTXVWt3I6S/uKS41g+CawvitSyq6x3NBEpQ==
X-Received: by 2002:adf:ef8a:: with SMTP id d10mr3936098wro.126.1594888973241;
        Thu, 16 Jul 2020 01:42:53 -0700 (PDT)
Received: from localhost.localdomain ([141.226.183.23])
        by smtp.gmail.com with ESMTPSA id j75sm8509977wrj.22.2020.07.16.01.42.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 01:42:52 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH v5 12/22] inotify: report both events on parent and child with single callback
Date:   Thu, 16 Jul 2020 11:42:20 +0300
Message-Id: <20200716084230.30611-13-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200716084230.30611-1-amir73il@gmail.com>
References: <20200716084230.30611-1-amir73il@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

fsnotify usually calls inotify_handle_event() once for watching parent
to report event with child's name and once for watching child to report
event without child's name.

Do the same thing with a single callback instead of two callbacks when
marks iterator contains both inode and child entries.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/notify/inotify/inotify_fsnotify.c | 44 ++++++++++++++++++++++------
 1 file changed, 35 insertions(+), 9 deletions(-)

diff --git a/fs/notify/inotify/inotify_fsnotify.c b/fs/notify/inotify/inotify_fsnotify.c
index dfd455798a1b..a65cf8c9f600 100644
--- a/fs/notify/inotify/inotify_fsnotify.c
+++ b/fs/notify/inotify/inotify_fsnotify.c
@@ -55,13 +55,11 @@ static int inotify_merge(struct list_head *list,
 	return event_compare(last_event, event);
 }
 
-int inotify_handle_event(struct fsnotify_group *group, u32 mask,
-			 const void *data, int data_type, struct inode *dir,
-			 const struct qstr *file_name, u32 cookie,
-			 struct fsnotify_iter_info *iter_info)
+static int inotify_one_event(struct fsnotify_group *group, u32 mask,
+			     struct fsnotify_mark *inode_mark,
+			     const struct path *path,
+			     const struct qstr *file_name, u32 cookie)
 {
-	const struct path *path = fsnotify_data_path(data, data_type);
-	struct fsnotify_mark *inode_mark = fsnotify_iter_inode_mark(iter_info);
 	struct inotify_inode_mark *i_mark;
 	struct inotify_event_info *event;
 	struct fsnotify_event *fsn_event;
@@ -69,9 +67,6 @@ int inotify_handle_event(struct fsnotify_group *group, u32 mask,
 	int len = 0;
 	int alloc_len = sizeof(struct inotify_event_info);
 
-	if (WARN_ON(fsnotify_iter_vfsmount_mark(iter_info)))
-		return 0;
-
 	if ((inode_mark->mask & FS_EXCL_UNLINK) &&
 	    path && d_unlinked(path->dentry))
 		return 0;
@@ -135,6 +130,37 @@ int inotify_handle_event(struct fsnotify_group *group, u32 mask,
 	return 0;
 }
 
+int inotify_handle_event(struct fsnotify_group *group, u32 mask,
+			 const void *data, int data_type, struct inode *dir,
+			 const struct qstr *file_name, u32 cookie,
+			 struct fsnotify_iter_info *iter_info)
+{
+	const struct path *path = fsnotify_data_path(data, data_type);
+	struct fsnotify_mark *inode_mark = fsnotify_iter_inode_mark(iter_info);
+	struct fsnotify_mark *child_mark = fsnotify_iter_child_mark(iter_info);
+	int ret = 0;
+
+	if (WARN_ON(fsnotify_iter_vfsmount_mark(iter_info)))
+		return 0;
+
+	/*
+	 * Some events cannot be sent on both parent and child marks
+	 * (e.g. IN_CREATE).  Those events are always sent on inode_mark.
+	 * For events that are possible on both parent and child (e.g. IN_OPEN),
+	 * event is sent on inode_mark with name if the parent is watching and
+	 * is sent on child_mark without name if child is watching.
+	 * If both parent and child are watching, report the event with child's
+	 * name here and report another event without child's name below.
+	 */
+	if (inode_mark)
+		ret = inotify_one_event(group, mask, inode_mark, path,
+					file_name, cookie);
+	if (ret || !child_mark)
+		return ret;
+
+	return inotify_one_event(group, mask, child_mark, path, NULL, 0);
+}
+
 static void inotify_freeing_mark(struct fsnotify_mark *fsn_mark, struct fsnotify_group *group)
 {
 	inotify_ignored_and_remove_idr(fsn_mark, group);
-- 
2.17.1

