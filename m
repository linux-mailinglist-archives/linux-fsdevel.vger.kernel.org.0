Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1802C2123DD
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Jul 2020 14:58:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729246AbgGBM57 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Jul 2020 08:57:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729241AbgGBM55 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Jul 2020 08:57:57 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FD35C08C5DC
        for <linux-fsdevel@vger.kernel.org>; Thu,  2 Jul 2020 05:57:57 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id f7so25189207wrw.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Jul 2020 05:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Jyvj9uA1kmJLPgeGKmI2F71fNhX2ewPIbDn9JQ61e5Y=;
        b=vdBMbSHWjzPd8eITfBqO7BJO2dM7PQ+B5UBrrXpdbWc/VJANehOsUIVE76IKqjp8RH
         05f2AloK7qv34b9ohq0VdA+LOsaHdLT4hnNOX8jMBRuUOlT94B51+9I93FRNSVc29rwO
         5ejteRDKMFSxdCb8eCjeto8hylRmiIxg+dv9PyKLjOGugTulcT/PqPLDTE0GzTuvpNJB
         jZ8h2QWiqMbb/ycFZh3LXxGEh8FueuMDi1aNiccHgbonIWIQzFtXeVElPy16Lz3aWQVH
         uvn8uE6QN7dTwDhYHYpnXPMcgZZ4b89gQG+b2S1bLfFRG79vMa9ktk6v0LyodcGksUtw
         Kjag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Jyvj9uA1kmJLPgeGKmI2F71fNhX2ewPIbDn9JQ61e5Y=;
        b=uSr4L9aAZ3ZBBsFS/gJl8xcWQDpZvmXRaA5yn6Zn1fPzlN1ignoJv+W83UUAoCd/bl
         ZvyPksZGBcLT+rbszQJISvfX3lm8BurHvfVtQ0myT0f/Al/LPqUszPyBggeUPrmCnrUP
         7QJiKhv0mGoGdo6bXGgz6TD6ulgXmiuxG6ZeAT5uSavgsvPqhbYjvlFDowZUF1pXHJXW
         dHoINT7eX6Zd47Mt2qMK4D5SaHkLHGYexdRRg/jSi1zSOY6redU3odCwHs5yo+81/c6I
         tgk+LjBfdnYrEmtx41FpPrXdej/+wkynuqa7ZBDXSxkUWE6JZiVhL4JyU0IdEnHcFTjM
         nQlQ==
X-Gm-Message-State: AOAM530ax4+wW56bWoTrazgDnZdedJL4ZnQsRWdgPWVdJP3yEW+yBf4e
        X9HMpP507Ri9OWWNKWDq4Hc=
X-Google-Smtp-Source: ABdhPJwZheQpddnKAR4SEXrW05HuvhjXH4uMHMJGaYerLB+Q1hgsNF9JMmzKTjBeEqYe8Hb/pXkkDA==
X-Received: by 2002:adf:f209:: with SMTP id p9mr30024617wro.86.1593694676177;
        Thu, 02 Jul 2020 05:57:56 -0700 (PDT)
Received: from localhost.localdomain ([141.226.183.23])
        by smtp.gmail.com with ESMTPSA id g16sm11847335wrh.91.2020.07.02.05.57.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2020 05:57:55 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v4 01/10] inotify: report both events on parent and child with single callback
Date:   Thu,  2 Jul 2020 15:57:35 +0300
Message-Id: <20200702125744.10535-2-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200702125744.10535-1-amir73il@gmail.com>
References: <20200702125744.10535-1-amir73il@gmail.com>
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
 fs/notify/inotify/inotify_fsnotify.c | 37 +++++++++++++++++++++-------
 1 file changed, 28 insertions(+), 9 deletions(-)

diff --git a/fs/notify/inotify/inotify_fsnotify.c b/fs/notify/inotify/inotify_fsnotify.c
index dfd455798a1b..6fb8ae34edd1 100644
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
@@ -135,6 +130,30 @@ int inotify_handle_event(struct fsnotify_group *group, u32 mask,
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
+	/* If parent is watching, report the event with child's name */
+	if (inode_mark)
+		ret = inotify_one_event(group, mask, inode_mark, path,
+					file_name, cookie);
+	if (ret || !child_mark)
+		return ret;
+
+	/* If child is watching, report another event without child's name */
+	return inotify_one_event(group, mask, child_mark, path, NULL, 0);
+}
+
 static void inotify_freeing_mark(struct fsnotify_mark *fsn_mark, struct fsnotify_group *group)
 {
 	inotify_ignored_and_remove_idr(fsn_mark, group);
-- 
2.17.1

