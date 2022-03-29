Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B43934EA8BA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Mar 2022 09:52:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233609AbiC2HvZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Mar 2022 03:51:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233591AbiC2HvL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Mar 2022 03:51:11 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98FD51E95DB
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Mar 2022 00:49:27 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id b19so23487448wrh.11
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Mar 2022 00:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7Xee4LQq4xG5i5yaYMFWrpevH6Upht1xrdhxPOrxCR0=;
        b=MLMefGBiaGnER1HtulwdRzbsoJ+EGnjNhuV3EUQTomnRTxQMOdmIqux73Hopa5jdks
         SLBGAKxz+1TFdhPJu1OIKdFG1h/Wo3I9tAfl/SB6Dhp8JEr8NSEwdOHF+lRfzrwnFUDK
         tJT/tVRyrAefOVIOqFRhgZFcMTmReUhpejlup5vzGNXmfMM5xFmYLepPBvvgmjVclTtu
         FcGBuLjGBznOjbGKlQWR80z+XgQlLRPyPmQOgdRI6OdL20+A2wX2HqCf+oG7oFlIi8l+
         MuK/bTRh77081Iz/Hd+KMuIwhQB/ezQUCPiZA8xedBxoPURVbBgzn1hFRlElC0yMWdK4
         2L1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7Xee4LQq4xG5i5yaYMFWrpevH6Upht1xrdhxPOrxCR0=;
        b=0mdKhvSKdbqDkAgqdzm6YeQ3EpyF/zjJQfVYicQD4fETd5GAL6eOpHesJGGSRlgQp8
         AZj26GQ6ovDsbidWEQvT2et2XJuAJeH3ed/blFcDvHCWprvQk6uGknVIA1NKJL/mUMv8
         Ly02L9G5ote1eIf4hLQg2/V0jHUCe85ypxEiPRJsmSFJWI4tDMvdYIkhg1v/zHXNy3FB
         44v2m24kYX9tStx8otSkJmlXsboq70IKlDwjV8GR9wU3eOD1wtoPQAx7fSgQTeFCNgu1
         C7gK1qNiwYJt0/JgeiyA4eMrj9ATeAk7Bs+oRBufeZAn2/o9ZcWLfRhfTlQJqlBa45yD
         J6og==
X-Gm-Message-State: AOAM5311ocVloxHmEiJAVVNUWNakbFEUYMs8aslX0TBnIrHBtSbvBoqK
        3ekgGb/e+vIIcwlzV88YexbD+yVuFBA=
X-Google-Smtp-Source: ABdhPJwlETquIhqVemuxVeDZi1gS9HUlSY85DYnlwhaYu2/XNZipgElMyaQu+BhGy8iZFjO9nyQ1xQ==
X-Received: by 2002:a05:6000:508:b0:1e4:a027:d147 with SMTP id a8-20020a056000050800b001e4a027d147mr29392796wrf.315.1648540166166;
        Tue, 29 Mar 2022 00:49:26 -0700 (PDT)
Received: from localhost.localdomain ([77.137.71.203])
        by smtp.gmail.com with ESMTPSA id k40-20020a05600c1ca800b0038c6c8b7fa8sm1534342wms.25.2022.03.29.00.49.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 00:49:25 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 12/16] fanotify: factor out helper fanotify_mark_update_flags()
Date:   Tue, 29 Mar 2022 10:49:00 +0300
Message-Id: <20220329074904.2980320-13-amir73il@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220329074904.2980320-1-amir73il@gmail.com>
References: <20220329074904.2980320-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Handle FAN_MARK_IGNORED_SURV_MODIFY flag change in a helper that
is called after updating the mark mask.

Move recalc of object mask inside fanotify_mark_add_to_mask() which
makes the code a bit simpler to follow.

Add also helper to translate fsnotify mark flags to user visible
fanotify mark flags.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/notify/fanotify/fanotify.h      | 10 ++++++++
 fs/notify/fanotify/fanotify_user.c | 39 +++++++++++++++++-------------
 fs/notify/fdinfo.c                 |  6 ++---
 3 files changed, 34 insertions(+), 21 deletions(-)

diff --git a/fs/notify/fanotify/fanotify.h b/fs/notify/fanotify/fanotify.h
index a3d5b751cac5..87142bc0131a 100644
--- a/fs/notify/fanotify/fanotify.h
+++ b/fs/notify/fanotify/fanotify.h
@@ -490,3 +490,13 @@ static inline unsigned int fanotify_event_hash_bucket(
 {
 	return event->hash & FANOTIFY_HTABLE_MASK;
 }
+
+static inline unsigned int fanotify_mark_user_flags(struct fsnotify_mark *mark)
+{
+	unsigned int mflags = 0;
+
+	if (mark->flags & FSNOTIFY_MARK_FLAG_IGNORED_SURV_MODIFY)
+		mflags |= FAN_MARK_IGNORED_SURV_MODIFY;
+
+	return mflags;
+}
diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index 0f0db1efa379..6e78ea12239c 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -1081,42 +1081,50 @@ static int fanotify_remove_inode_mark(struct fsnotify_group *group,
 				    flags, umask);
 }
 
-static void fanotify_mark_add_ignored_mask(struct fsnotify_mark *fsn_mark,
-					   __u32 mask, unsigned int flags,
-					   __u32 *removed)
+static int fanotify_mark_update_flags(struct fsnotify_mark *fsn_mark,
+				      unsigned int flags, bool *recalc)
 {
-	fsn_mark->ignored_mask |= mask;
-
 	/*
 	 * Setting FAN_MARK_IGNORED_SURV_MODIFY for the first time may lead to
 	 * the removal of the FS_MODIFY bit in calculated mask if it was set
 	 * because of an ignored mask that is now going to survive FS_MODIFY.
 	 */
 	if ((flags & FAN_MARK_IGNORED_SURV_MODIFY) &&
+	    (flags & FAN_MARK_IGNORED_MASK) &&
 	    !(fsn_mark->flags & FSNOTIFY_MARK_FLAG_IGNORED_SURV_MODIFY)) {
 		fsn_mark->flags |= FSNOTIFY_MARK_FLAG_IGNORED_SURV_MODIFY;
 		if (!(fsn_mark->mask & FS_MODIFY))
-			*removed = FS_MODIFY;
+			*recalc = true;
 	}
+
+	return 0;
 }
 
-static __u32 fanotify_mark_add_to_mask(struct fsnotify_mark *fsn_mark,
-				       __u32 mask, unsigned int flags,
-				       __u32 *removed)
+static int fanotify_mark_add_to_mask(struct fsnotify_mark *fsn_mark,
+				     __u32 mask, unsigned int flags)
 {
-	__u32 oldmask, newmask;
+	__u32 oldmask;
+	bool recalc = false;
+	int ret;
 
 	spin_lock(&fsn_mark->lock);
 	oldmask = fsnotify_calc_mask(fsn_mark);
 	if (!(flags & FAN_MARK_IGNORED_MASK)) {
 		fsn_mark->mask |= mask;
 	} else {
-		fanotify_mark_add_ignored_mask(fsn_mark, mask, flags, removed);
+		fsn_mark->ignored_mask |= mask;
 	}
-	newmask = fsnotify_calc_mask(fsn_mark);
+
+	recalc = fsnotify_calc_mask(fsn_mark) & ~oldmask &
+		~fsnotify_conn_mask(fsn_mark->connector);
+
+	ret = fanotify_mark_update_flags(fsn_mark, flags, &recalc);
 	spin_unlock(&fsn_mark->lock);
 
-	return newmask & ~oldmask;
+	if (recalc)
+		fsnotify_recalc_mask(fsn_mark->connector);
+
+	return ret;
 }
 
 static struct fsnotify_mark *fanotify_add_new_mark(struct fsnotify_group *group,
@@ -1174,7 +1182,6 @@ static int fanotify_add_mark(struct fsnotify_group *group,
 			     __kernel_fsid_t *fsid)
 {
 	struct fsnotify_mark *fsn_mark;
-	__u32 added, removed = 0;
 	int ret = 0;
 
 	mutex_lock(&group->mark_mutex);
@@ -1197,9 +1204,7 @@ static int fanotify_add_mark(struct fsnotify_group *group,
 			goto out;
 	}
 
-	added = fanotify_mark_add_to_mask(fsn_mark, mask, flags, &removed);
-	if (removed || (added & ~fsnotify_conn_mask(fsn_mark->connector)))
-		fsnotify_recalc_mask(fsn_mark->connector);
+	ret = fanotify_mark_add_to_mask(fsn_mark, mask, flags);
 
 out:
 	mutex_unlock(&group->mark_mutex);
diff --git a/fs/notify/fdinfo.c b/fs/notify/fdinfo.c
index 754a546d647d..9f81adada3c8 100644
--- a/fs/notify/fdinfo.c
+++ b/fs/notify/fdinfo.c
@@ -14,6 +14,7 @@
 #include <linux/exportfs.h>
 
 #include "inotify/inotify.h"
+#include "fanotify/fanotify.h"
 #include "fdinfo.h"
 #include "fsnotify.h"
 
@@ -104,12 +105,9 @@ void inotify_show_fdinfo(struct seq_file *m, struct file *f)
 
 static void fanotify_fdinfo(struct seq_file *m, struct fsnotify_mark *mark)
 {
-	unsigned int mflags = 0;
+	unsigned int mflags = fanotify_mark_user_flags(mark);
 	struct inode *inode;
 
-	if (mark->flags & FSNOTIFY_MARK_FLAG_IGNORED_SURV_MODIFY)
-		mflags |= FAN_MARK_IGNORED_SURV_MODIFY;
-
 	if (mark->connector->type == FSNOTIFY_OBJ_TYPE_INODE) {
 		inode = igrab(fsnotify_conn_inode(mark->connector));
 		if (!inode)
-- 
2.25.1

