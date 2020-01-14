Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7AFFA13AD56
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2020 16:17:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729144AbgANPRJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Jan 2020 10:17:09 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51376 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbgANPRI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Jan 2020 10:17:08 -0500
Received: by mail-wm1-f66.google.com with SMTP id d73so14219609wmd.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jan 2020 07:17:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xI6UsR2HtRTdQ7AnXLxpbvVM2BEy5RIvfWcGKDAXsbE=;
        b=W523Srz16ex4m6WIhfstZPV19MkeksaQB5qOxmHSV4QsdDSIQt4QDWFM/vk/Jm4PrM
         KMn8zkEwXyrgiU9+zh9yhiG9i0cIjZTqgzbFupQkfjEoxgyGUh8yJWWdQ12kXJYxJf9F
         EjRW4VoO72BAPFnUDYft8WuPq5Nw7BzCd05eBewwZZ9ecfTEnm+Ro1Nu0H6nBuSJymmc
         9/26mOremHDvOAb0sOFLwHC0Lpz1hdB320JBs1ZF4NSyMNZQAP4han2+ok8F/TIdw1sS
         LKLa9+D/jN8PgK2njaT0BXPI/WEpfdt+dIfu3GkjrsQBPwevsblqaMcQdUWZi5YJRHAH
         cROw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xI6UsR2HtRTdQ7AnXLxpbvVM2BEy5RIvfWcGKDAXsbE=;
        b=UlI0QahTuiiv04O81FI1k2w9bwSWqlQBtc4oj3U9395bRhLaF5GEz/th8jlBLBLQJB
         rqZ4uRWqik3fTmI+QUMeoefunRqJe2TZIgbCE2MTMjnoYGnGrVTX21lYQGor0h1+YSKi
         LhNdYQdyv3zV7CJZEFBcAcsitxtIbf75nT3yUbCAZyKpwApgobQNeVMtVgC6DCjuKBRx
         4TnjXpHkUyJMMMpSnqUV1bGAS4NWWsWldTFREQB9vit6964XKF+m7D6YkksPI6neubJ4
         194LPHIXZ5hkuDG+o8U38I2fzrDbxXazREE1DxxrF0p5ejT/HegNpXTShzOWPnwcHyBz
         SKLA==
X-Gm-Message-State: APjAAAU5D97Ghul2PLIQkr8k49f25nuXLOOFrTekr/7PED0maVBMEAtD
        SINcuEdMRwQGrsHBjlesvaw=
X-Google-Smtp-Source: APXvYqzyYuoSBBDDH/N77dbBgE8qME+Q5+2FnJEEwR5QsscwzTOvl9BVsVjALoxy8pKuM5qDf3dqjg==
X-Received: by 2002:a1c:a745:: with SMTP id q66mr26617844wme.167.1579015026484;
        Tue, 14 Jan 2020 07:17:06 -0800 (PST)
Received: from amir-ThinkPad-T480.ctera.local (bzq-166-168-31-246.red.bezeqint.net. [31.168.166.246])
        by smtp.gmail.com with ESMTPSA id s19sm18276993wmj.33.2020.01.14.07.17.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2020 07:17:06 -0800 (PST)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH 4/6] fsnotify: replace inode pointer with tag
Date:   Tue, 14 Jan 2020 17:16:53 +0200
Message-Id: <20200114151655.29473-5-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200114151655.29473-1-amir73il@gmail.com>
References: <20200114151655.29473-1-amir73il@gmail.com>
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
index b4cd90afece1..34454390e4b6 100644
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
index d510223d302c..cbaaec234fcd 100644
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
index 77edd866926f..caf8bbc1be08 100644
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
@@ -499,11 +498,10 @@ extern void fsnotify_put_mark(struct fsnotify_mark *mark);
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

