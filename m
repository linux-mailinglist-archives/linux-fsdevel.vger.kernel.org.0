Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B73661612ED
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2020 14:16:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729139AbgBQNPR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Feb 2020 08:15:17 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52519 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729125AbgBQNPR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Feb 2020 08:15:17 -0500
Received: by mail-wm1-f67.google.com with SMTP id p9so17108700wmc.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Feb 2020 05:15:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FrjWKs7Er54lWDwKu5pX+EDCsHByz98RF1MpRiqTebk=;
        b=qA4IWowtwl2jLWou4xMwEV+yb9H/TxGLCnzvNRdJK3JQcpf1Fl7LPWnaoMvk460o9/
         jXH36M8acBDuhOo4hxpGqDOIyk/kLD2VXgEMSyGWZ3WRJoEOdMpGNzWLgmirwujsLUYO
         eYEBDoBeLx7LF2fd0tEywhQBNAMPZmpgQkP5rFNIiIez9I/T9R0irgAWjoLguiUdfX5B
         v707zB+cE//ZbvPLJ1CFemenAEkZ8srDTTYoBwes59sj3LJ08PRIkzMqSpHFh5FP5zAe
         XJ9rHAIHaj4/hifdhpNaiVnFdt4KrfkEX/15Q79TeHzw/hi+xRUgZZZ6K8B+jQfRx9B1
         YAPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FrjWKs7Er54lWDwKu5pX+EDCsHByz98RF1MpRiqTebk=;
        b=B/Rjawm1SxUgEBzQtrZweLr79g/v5Tl0DghYM9ajDMxO2vRU3PzR2WJUnBUMVESi23
         xPh2h/Is4Sv+cCDB19LNNRazd8Yjjl7o+RhQTA6je5plJcVkk5Ji+DAQqJ/sPbmUS3kl
         Au7ZcSiOuNN37pdojnAA+fAZl89fojV8XskENs1XXoDsX9hLfcohzZt5KckMe1RYrtB4
         qItDle+dY33j934CA2xtckgt+6VHfk11VyJyHt/ulyZDQ7F8vVejpcg8FHAvbQXLgXVq
         8hhUoxK4v34LG+b1lZFYKKPrVx0krC40i/6XViUA2lgZ48s+jLWu5+vLtr/SQCzPX8mH
         3ifQ==
X-Gm-Message-State: APjAAAXo+NDOYn5TEkCxr0/Q+hoVEH9CMAACxaA1Yu51zGmClj5HNWSf
        0hYgIW8aAezQH8edN8mhLS5c6o+r
X-Google-Smtp-Source: APXvYqw0cZeYxrZGXo0U2aCRtMlHwLJacIImiocV43N1xQx4KJmGrJYLovHs7rNuEDYLCL+PaDd5PQ==
X-Received: by 2002:a1c:1f51:: with SMTP id f78mr22084484wmf.60.1581945315439;
        Mon, 17 Feb 2020 05:15:15 -0800 (PST)
Received: from amir-ThinkPad-T480.ctera.local (bzq-166-168-31-246.red.bezeqint.net. [31.168.166.246])
        by smtp.gmail.com with ESMTPSA id m21sm545745wmi.27.2020.02.17.05.15.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2020 05:15:14 -0800 (PST)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 07/16] fsnotify: replace inode pointer with tag
Date:   Mon, 17 Feb 2020 15:14:46 +0200
Message-Id: <20200217131455.31107-8-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200217131455.31107-1-amir73il@gmail.com>
References: <20200217131455.31107-1-amir73il@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The event inode field is used only for comparison in queue merges and
cannot be dereferenced after handle_event(), because it does not hold a
refcount on the inode.

Replace it with an abstract tag do to the same thing. We are going to
set this tag for values other than inode pointer in fanotify.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/notify/fanotify/fanotify.c        | 2 +-
 fs/notify/inotify/inotify_fsnotify.c | 2 +-
 include/linux/fsnotify_backend.h     | 8 +++-----
 3 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index 19ec7a4f4d50..98c3cbf29003 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -26,7 +26,7 @@ static bool should_merge(struct fsnotify_event *old_fsn,
 	old = FANOTIFY_E(old_fsn);
 	new = FANOTIFY_E(new_fsn);
 
-	if (old_fsn->inode != new_fsn->inode || old->pid != new->pid ||
+	if (old_fsn->tag != new_fsn->tag || old->pid != new->pid ||
 	    old->fh_type != new->fh_type || old->fh_len != new->fh_len)
 		return false;
 
diff --git a/fs/notify/inotify/inotify_fsnotify.c b/fs/notify/inotify/inotify_fsnotify.c
index 6bb98522bbfd..4f42ea7b7fdd 100644
--- a/fs/notify/inotify/inotify_fsnotify.c
+++ b/fs/notify/inotify/inotify_fsnotify.c
@@ -39,7 +39,7 @@ static bool event_compare(struct fsnotify_event *old_fsn,
 	if (old->mask & FS_IN_IGNORED)
 		return false;
 	if ((old->mask == new->mask) &&
-	    (old_fsn->inode == new_fsn->inode) &&
+	    (old_fsn->tag == new_fsn->tag) &&
 	    (old->name_len == new->name_len) &&
 	    (!old->name_len || !strcmp(old->name, new->name)))
 		return true;
diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
index bd3f6114a7a9..cd106b5c87a4 100644
--- a/include/linux/fsnotify_backend.h
+++ b/include/linux/fsnotify_backend.h
@@ -132,8 +132,7 @@ struct fsnotify_ops {
  */
 struct fsnotify_event {
 	struct list_head list;
-	/* inode may ONLY be dereferenced during handle_event(). */
-	struct inode *inode;	/* either the inode the event happened to or its parent */
+	unsigned long tag;	/* identifier for queue merges */
 };
 
 /*
@@ -542,11 +541,10 @@ extern void fsnotify_put_mark(struct fsnotify_mark *mark);
 extern void fsnotify_finish_user_wait(struct fsnotify_iter_info *iter_info);
 extern bool fsnotify_prepare_user_wait(struct fsnotify_iter_info *iter_info);
 
-static inline void fsnotify_init_event(struct fsnotify_event *event,
-				       struct inode *inode)
+static inline void fsnotify_init_event(struct fsnotify_event *event, void *tag)
 {
 	INIT_LIST_HEAD(&event->list);
-	event->inode = inode;
+	event->tag = (unsigned long)tag;
 }
 
 #else
-- 
2.17.1

