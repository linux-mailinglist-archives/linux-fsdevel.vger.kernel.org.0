Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5A982CBC7D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Dec 2020 13:10:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388591AbgLBMI6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Dec 2020 07:08:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388420AbgLBMIy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Dec 2020 07:08:54 -0500
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E1AAC08C5F2
        for <linux-fsdevel@vger.kernel.org>; Wed,  2 Dec 2020 04:07:26 -0800 (PST)
Received: by mail-ej1-x644.google.com with SMTP id x16so3806558ejj.7
        for <linux-fsdevel@vger.kernel.org>; Wed, 02 Dec 2020 04:07:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YQPwA+EPK2TqK1y02Hl1Va4w5gZayvzdWcX47Nivrn4=;
        b=WyPLaZlmv+qDCc4YDtjlbAfFw1K3azM2KWqwmRF476nFY5mjM7RycZprXicIUW6oEF
         AGbmC7OlOXz/Y5J7Q0HZ5nA/0hJBFmbo5Gxj5f6mE5uWC25+WFYRcrQ0QYm51jQ+u6kJ
         plxE093R9bcEOTpBeppFoNXGrAo9GBkcCyjtMyK+vvW9GwdV/1UQ2Y/lwFGuubtGXmTL
         q4p3shVUyP1tjIxFxFQFsgVYe3GVdlEILC+wgdnpSA3l65/67udW2fTYlG9nB3gYNzpx
         5IrVWT3wg4A3D9QERqu0ZvAwsfDvC01ey5zrO1CuuHyyqAszoMIVfLQ+4wXsmmM02LxQ
         8nPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YQPwA+EPK2TqK1y02Hl1Va4w5gZayvzdWcX47Nivrn4=;
        b=op1AaJi1V7hmIPgSecTVOomzxZHEdQRjY+W4t2aFebj9Zmygg/bEGzzilLVsEP0HXr
         b2JwmfYgDWtjqaWibCZqiYQhew83F4yMfGLKNJMce+eowl8Azj71NSZ9LMkUlRmudejd
         XezUwFedBd1eEc56KDKI/QMx6b7Q+b48hUu1DByk0iYLMRcgkowIqLHJO+RFfkjzxRGM
         7qsDDVbUnIkvgy0+lPMTLvv1yiCygqGvnEzfEH2iZkWv3bOaYcOtnA2X5gyMDpP1rEcH
         Jy6JULs0/kWUqdat0pX+EhzwUnmUbN9KAAsYAN29VvzUDBM81q1jyV18/OzpLfiV2cKH
         s7Gw==
X-Gm-Message-State: AOAM531fYmfHsQ6c78zXQoWCTc7eO9jngf3Ilw/wwIZW1oQyG+m+I8Jw
        nLqV2oZdvowLt3YwUziH4GHhDKvkeQY=
X-Google-Smtp-Source: ABdhPJxesR7ONnR6PIdenhcr9wd4E958z6zgIiox9qNPac+nHm18w2MMzTe67IF7fRzPAIgUyX+QVw==
X-Received: by 2002:a17:906:b1c8:: with SMTP id bv8mr2000208ejb.208.1606910845088;
        Wed, 02 Dec 2020 04:07:25 -0800 (PST)
Received: from localhost.localdomain ([31.210.181.203])
        by smtp.gmail.com with ESMTPSA id b7sm1058227ejj.85.2020.12.02.04.07.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 04:07:24 -0800 (PST)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH 6/7] fsnotify: optimize FS_MODIFY events with no ignored masks
Date:   Wed,  2 Dec 2020 14:07:12 +0200
Message-Id: <20201202120713.702387-7-amir73il@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201202120713.702387-1-amir73il@gmail.com>
References: <20201202120713.702387-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

fsnotify() treats FS_MODIFY events specially - it does not skip them
even if the FS_MODIFY event does not apear in the object's fsnotify
mask.  This is because send_to_group() checks if FS_MODIFY needs to
clear ignored mask of marks.

The common case is that an object does not have any mark with ignored
mask and in particular, that it does not have a mark with ignored mask
and without the FSNOTIFY_MARK_FLAG_IGNORED_SURV_MODIFY flag.

Set FS_MODIFY in object's fsnotify mask during fsnotify_recalc_mask()
if object has a mark with an ignored mask and without the
FSNOTIFY_MARK_FLAG_IGNORED_SURV_MODIFY flag and remove the special
treatment of FS_MODIFY in fsnotify(), so that FS_MODIFY events could
be optimized in the common case.

Call fsnotify_recalc_mask() from fanotify after adding or removing an
ignored mask from a mark without FSNOTIFY_MARK_FLAG_IGNORED_SURV_MODIFY
or when adding the FSNOTIFY_MARK_FLAG_IGNORED_SURV_MODIFY flag to a mark
with ignored mask (the flag cannot be removed by fanotify uapi).

Suggested-by: Jan Kara <jack@suse.cz>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/notify/fanotify/fanotify_user.c | 36 ++++++++++++++++++++----------
 fs/notify/fsnotify.c               |  8 ++++---
 fs/notify/mark.c                   |  2 +-
 include/linux/fsnotify_backend.h   | 15 +++++++++++++
 4 files changed, 45 insertions(+), 16 deletions(-)

diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index f9c74fa82038..80c36da037bb 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -720,17 +720,18 @@ static __u32 fanotify_mark_remove_from_mask(struct fsnotify_mark *fsn_mark,
 					    __u32 mask, unsigned int flags,
 					    __u32 umask, int *destroy)
 {
-	__u32 oldmask = 0;
+	__u32 oldmask, newmask;
 
 	/* umask bits cannot be removed by user */
 	mask &= ~umask;
 	spin_lock(&fsn_mark->lock);
+	oldmask = fsnotify_calc_mask(fsn_mark);
 	if (!(flags & FAN_MARK_IGNORED_MASK)) {
-		oldmask = fsn_mark->mask;
 		fsn_mark->mask &= ~mask;
 	} else {
 		fsn_mark->ignored_mask &= ~mask;
 	}
+	newmask = fsnotify_calc_mask(fsn_mark);
 	/*
 	 * We need to keep the mark around even if remaining mask cannot
 	 * result in any events (e.g. mask == FAN_ONDIR) to support incremenal
@@ -740,7 +741,7 @@ static __u32 fanotify_mark_remove_from_mask(struct fsnotify_mark *fsn_mark,
 	*destroy = !((fsn_mark->mask | fsn_mark->ignored_mask) & ~umask);
 	spin_unlock(&fsn_mark->lock);
 
-	return mask & oldmask;
+	return oldmask & ~newmask;
 }
 
 static int fanotify_remove_mark(struct fsnotify_group *group,
@@ -798,23 +799,34 @@ static int fanotify_remove_inode_mark(struct fsnotify_group *group,
 }
 
 static __u32 fanotify_mark_add_to_mask(struct fsnotify_mark *fsn_mark,
-				       __u32 mask,
-				       unsigned int flags)
+				       __u32 mask, unsigned int flags,
+				       __u32 *removed)
 {
-	__u32 oldmask = -1;
+	__u32 oldmask, newmask;
 
 	spin_lock(&fsn_mark->lock);
+	oldmask = fsnotify_calc_mask(fsn_mark);
 	if (!(flags & FAN_MARK_IGNORED_MASK)) {
-		oldmask = fsn_mark->mask;
 		fsn_mark->mask |= mask;
 	} else {
 		fsn_mark->ignored_mask |= mask;
-		if (flags & FAN_MARK_IGNORED_SURV_MODIFY)
+		/*
+		 * Setting FAN_MARK_IGNORED_SURV_MODIFY for the first time
+		 * can lead to the removal of the FS_MODIFY bit in calculated
+		 * mask if it was set because of an ignored mask that from now
+		 * on is going to survive FS_MODIFY.
+		 */
+		if ((flags & FAN_MARK_IGNORED_SURV_MODIFY) &&
+		    !(fsn_mark->flags & FSNOTIFY_MARK_FLAG_IGNORED_SURV_MODIFY)) {
 			fsn_mark->flags |= FSNOTIFY_MARK_FLAG_IGNORED_SURV_MODIFY;
+			if (!(fsn_mark->mask & FS_MODIFY))
+				*removed = FS_MODIFY;
+		}
 	}
+	newmask = fsnotify_calc_mask(fsn_mark);
 	spin_unlock(&fsn_mark->lock);
 
-	return mask & ~oldmask;
+	return newmask & ~oldmask;
 }
 
 static struct fsnotify_mark *fanotify_add_new_mark(struct fsnotify_group *group,
@@ -849,7 +861,7 @@ static int fanotify_add_mark(struct fsnotify_group *group,
 			     __kernel_fsid_t *fsid)
 {
 	struct fsnotify_mark *fsn_mark;
-	__u32 added;
+	__u32 added, removed = 0;
 
 	mutex_lock(&group->mark_mutex);
 	fsn_mark = fsnotify_find_mark(connp, group);
@@ -860,8 +872,8 @@ static int fanotify_add_mark(struct fsnotify_group *group,
 			return PTR_ERR(fsn_mark);
 		}
 	}
-	added = fanotify_mark_add_to_mask(fsn_mark, mask, flags);
-	if (added & ~fsnotify_conn_mask(fsn_mark->connector))
+	added = fanotify_mark_add_to_mask(fsn_mark, mask, flags, &removed);
+	if (removed || (added & ~fsnotify_conn_mask(fsn_mark->connector)))
 		fsnotify_recalc_mask(fsn_mark->connector);
 	mutex_unlock(&group->mark_mutex);
 
diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
index bae3f306ed79..9a26207d1b5d 100644
--- a/fs/notify/fsnotify.c
+++ b/fs/notify/fsnotify.c
@@ -502,11 +502,13 @@ int fsnotify(__u32 mask, const void *data, int data_type, struct inode *dir,
 
 
 	/*
-	 * if this is a modify event we may need to clear the ignored masks
-	 * otherwise return if none of the marks care about this type of event.
+	 * If this is a modify event we may need to clear some ignored masks.
+	 * In that case, the object with ignored masks will have the FS_MODIFY
+	 * event in its mask.
+	 * Otherwise, return if none of the marks care about this type of event.
 	 */
 	test_mask = (mask & ALL_FSNOTIFY_EVENTS);
-	if (!(mask & FS_MODIFY) && !(test_mask & marks_mask))
+	if (!(test_mask & marks_mask))
 		return 0;
 
 	iter_info.srcu_idx = srcu_read_lock(&fsnotify_mark_srcu);
diff --git a/fs/notify/mark.c b/fs/notify/mark.c
index ffa682cb747b..662963fb510f 100644
--- a/fs/notify/mark.c
+++ b/fs/notify/mark.c
@@ -127,7 +127,7 @@ static void __fsnotify_recalc_mask(struct fsnotify_mark_connector *conn)
 		return;
 	hlist_for_each_entry(mark, &conn->list, obj_list) {
 		if (mark->flags & FSNOTIFY_MARK_FLAG_ATTACHED)
-			new_mask |= mark->mask;
+			new_mask |= fsnotify_calc_mask(mark);
 	}
 	*fsnotify_conn_mask_p(conn) = new_mask;
 }
diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
index 9d03f031a41b..046fcfb88492 100644
--- a/include/linux/fsnotify_backend.h
+++ b/include/linux/fsnotify_backend.h
@@ -516,6 +516,21 @@ extern void fsnotify_remove_queued_event(struct fsnotify_group *group,
 
 /* functions used to manipulate the marks attached to inodes */
 
+/* Get mask for calculating object interest taking ignored mask into account */
+static inline __u32 fsnotify_calc_mask(struct fsnotify_mark *mark)
+{
+	__u32 mask = mark->mask;
+
+	if (!mark->ignored_mask)
+		return mask;
+
+	/* Interest in FS_MODIFY may be needed for clearing ignored mask */
+	if (!(mark->flags & FSNOTIFY_MARK_FLAG_IGNORED_SURV_MODIFY))
+		mask |= FS_MODIFY;
+
+	return mask;
+}
+
 /* Get mask of events for a list of marks */
 extern __u32 fsnotify_conn_mask(struct fsnotify_mark_connector *conn);
 /* Calculate mask of events for a list of marks */
-- 
2.25.1

