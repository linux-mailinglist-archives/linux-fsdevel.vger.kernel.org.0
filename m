Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4BC9118BAA5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Mar 2020 16:10:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727793AbgCSPKu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Mar 2020 11:10:50 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:34914 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727346AbgCSPKt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Mar 2020 11:10:49 -0400
Received: by mail-wm1-f65.google.com with SMTP id m3so2715919wmi.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Mar 2020 08:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Z4GNpwenHqxdfK7tI9HPRZfTZgRQd8dQU+fYl2hE01U=;
        b=MDB6HsD0pJmPsysjqQCjiRc+aQQSOvqYfZ9MJ8E/xRwgG4Upkk8ASWTu5ZhIrcE5z8
         Y/XiCEK/JYEwFdAczmLYyYp7dNGl7CxN2kukNkz36T+8NNhHLmGYVdCo8gEr4qd8hAbf
         hXfiaWaN3KIqvVPA0S2Hn4J+mJuXdJ0o98YorCazwxsB3emuHDItdEAyjOt7I9e/hQDe
         p5/2olRME7gDx/adIFbSlE8jeGmF7tlTO3xaRHGlHXrpcIIQ2qHs41MQOtlZkxkWuABe
         I8dxuMuAgDn1T1ZtdNv/LA8nJ16Qy1A+nKLJ4XCtgSiNjt8r0LX2kA8tDp0LGLD1kxAn
         otEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Z4GNpwenHqxdfK7tI9HPRZfTZgRQd8dQU+fYl2hE01U=;
        b=YOPgW3tF+l2AWQyljjB9xK5hWzILREhFW8yYiBF6EofIjVNFeMRVwFUg0o/9b7NyGV
         ua4EWkEYruqYPp2Pt6+NwBzJ7Jj9VMB+SIv2E06db+GOSJmqJujZb89CW7H2T/FlF9zW
         50rcEyJUdeqYI/SfMYgJXg5RDBwsE4xtTIW+CkMDCpcMZ2Eea0LZGLOtHEuX4FZDq46V
         XLH3A9sEMNQR41K1b6LVsygM1PdACSCngrCkGmb4tzTmnvQlWx1f2yeuMk5TWQT9AP72
         Ew7+2kO6Nggnq83Bc9e0bx/ya5xdmT5e5yTjgnrsX/QkYrZq26wbYAm8rxUanafgF7vi
         3UxA==
X-Gm-Message-State: ANhLgQ0DWIJKYD5Kxo6k3vetZxuX8cm8dv6yyfFFzlqkc1zpU+hSFs3Y
        yBe9ZqqCriTiOqjNgqcByaE=
X-Google-Smtp-Source: ADFU+vv8yXy0U6jzpl9UN3gszOPBVIpkK3zP/Y91eIb/7GYCuAO6Q5a1xTkpetf1JOXLMYGPNxHjVw==
X-Received: by 2002:a1c:23d5:: with SMTP id j204mr4463540wmj.59.1584630647113;
        Thu, 19 Mar 2020 08:10:47 -0700 (PDT)
Received: from localhost.localdomain ([141.226.9.174])
        by smtp.gmail.com with ESMTPSA id t193sm3716959wmt.14.2020.03.19.08.10.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2020 08:10:46 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 07/14] fsnotify: replace inode pointer with an object id
Date:   Thu, 19 Mar 2020 17:10:15 +0200
Message-Id: <20200319151022.31456-8-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200319151022.31456-1-amir73il@gmail.com>
References: <20200319151022.31456-1-amir73il@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The event inode field is used only for comparison in queue merges and
cannot be dereferenced after handle_event(), because it does not hold a
refcount on the inode.

Replace it with an abstract id to do the same thing.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/notify/fanotify/fanotify.c        | 4 ++--
 fs/notify/inotify/inotify_fsnotify.c | 4 ++--
 fs/notify/inotify/inotify_user.c     | 2 +-
 include/linux/fsnotify_backend.h     | 7 +++----
 4 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index 19ec7a4f4d50..6a202aaf941f 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -26,7 +26,7 @@ static bool should_merge(struct fsnotify_event *old_fsn,
 	old = FANOTIFY_E(old_fsn);
 	new = FANOTIFY_E(new_fsn);
 
-	if (old_fsn->inode != new_fsn->inode || old->pid != new->pid ||
+	if (old_fsn->objectid != new_fsn->objectid || old->pid != new->pid ||
 	    old->fh_type != new->fh_type || old->fh_len != new->fh_len)
 		return false;
 
@@ -312,7 +312,7 @@ struct fanotify_event *fanotify_alloc_event(struct fsnotify_group *group,
 	if (!event)
 		goto out;
 init: __maybe_unused
-	fsnotify_init_event(&event->fse, inode);
+	fsnotify_init_event(&event->fse, (unsigned long)inode);
 	event->mask = mask;
 	if (FAN_GROUP_FLAG(group, FAN_REPORT_TID))
 		event->pid = get_pid(task_pid(current));
diff --git a/fs/notify/inotify/inotify_fsnotify.c b/fs/notify/inotify/inotify_fsnotify.c
index 6bb98522bbfd..2ebc89047153 100644
--- a/fs/notify/inotify/inotify_fsnotify.c
+++ b/fs/notify/inotify/inotify_fsnotify.c
@@ -39,7 +39,7 @@ static bool event_compare(struct fsnotify_event *old_fsn,
 	if (old->mask & FS_IN_IGNORED)
 		return false;
 	if ((old->mask == new->mask) &&
-	    (old_fsn->inode == new_fsn->inode) &&
+	    (old_fsn->objectid == new_fsn->objectid) &&
 	    (old->name_len == new->name_len) &&
 	    (!old->name_len || !strcmp(old->name, new->name)))
 		return true;
@@ -116,7 +116,7 @@ int inotify_handle_event(struct fsnotify_group *group,
 		mask &= ~IN_ISDIR;
 
 	fsn_event = &event->fse;
-	fsnotify_init_event(fsn_event, inode);
+	fsnotify_init_event(fsn_event, (unsigned long)inode);
 	event->mask = mask;
 	event->wd = i_mark->wd;
 	event->sync_cookie = cookie;
diff --git a/fs/notify/inotify/inotify_user.c b/fs/notify/inotify/inotify_user.c
index 107537a543fd..81ffc8629fc4 100644
--- a/fs/notify/inotify/inotify_user.c
+++ b/fs/notify/inotify/inotify_user.c
@@ -635,7 +635,7 @@ static struct fsnotify_group *inotify_new_group(unsigned int max_events)
 		return ERR_PTR(-ENOMEM);
 	}
 	group->overflow_event = &oevent->fse;
-	fsnotify_init_event(group->overflow_event, NULL);
+	fsnotify_init_event(group->overflow_event, 0);
 	oevent->mask = FS_Q_OVERFLOW;
 	oevent->wd = -1;
 	oevent->sync_cookie = 0;
diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
index ab0913619403..8ede512fca70 100644
--- a/include/linux/fsnotify_backend.h
+++ b/include/linux/fsnotify_backend.h
@@ -132,8 +132,7 @@ struct fsnotify_ops {
  */
 struct fsnotify_event {
 	struct list_head list;
-	/* inode may ONLY be dereferenced during handle_event(). */
-	struct inode *inode;	/* either the inode the event happened to or its parent */
+	unsigned long objectid;	/* identifier for queue merges */
 };
 
 /*
@@ -543,10 +542,10 @@ extern void fsnotify_finish_user_wait(struct fsnotify_iter_info *iter_info);
 extern bool fsnotify_prepare_user_wait(struct fsnotify_iter_info *iter_info);
 
 static inline void fsnotify_init_event(struct fsnotify_event *event,
-				       struct inode *inode)
+				       unsigned long objectid)
 {
 	INIT_LIST_HEAD(&event->list);
-	event->inode = inode;
+	event->objectid = objectid;
 }
 
 #else
-- 
2.17.1

