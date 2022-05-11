Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6749E523CFE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 May 2022 21:02:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346557AbiEKTC2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 May 2022 15:02:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346553AbiEKTCX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 May 2022 15:02:23 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4274F61296
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 May 2022 12:02:22 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id c190-20020a1c35c7000000b0038e37907b5bso3826062wma.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 May 2022 12:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xPWXtWtTAaY66WIi8GMyLdZgPqnMNt3IjjYmafpqWvE=;
        b=J7u6TGKIdq+x2KzdRBNPI/tNSZLd58xfSiioeFS3peCeCf9vPMZQ8vh48gRScZJ1RM
         l7OJVWtOL/xIlnptqNPu2WK2mLnQZbOp24vjFFMhcYPWIWCxQkMv/kzmV+UN0YAD1p26
         1Cuj3tVNZzMwALyYKA7P1qWzv9HbzV50l+7gzQ1q6Zj6S97yNGKIzrJZ20UM8BqaD3J+
         a0VQhPoxSOd4mDeCExuIX80USQFsyKY0xRmUF7z1He7AeiJ999lTH/96sJC9QaGpC+Uq
         nvNDR41SvfHjE/8LN3F0mHfvgLTxCM3zC1rgf+c0NtiDbgMHnc2fTFVUTIanaE6QJBXX
         ncXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xPWXtWtTAaY66WIi8GMyLdZgPqnMNt3IjjYmafpqWvE=;
        b=oxynvF+UBiPewWAWQ36esMc7spOY3P1b3Ewnl0a7tkwXCGdhqM+6QlXoq1qfr6bViO
         2xzwRpI7Nu6hiS01YBcm+TqEf1RKFjpzQHcrBCh1a38i8V2PqfH41rdIIh8n8gjAfwJg
         QARZRx22M9Y/0TpfflwZ+FnF5VeeIEtNpCnv7L6EyCvfXhwKAMnPX4SnjFwlPYpW/kUN
         q3YmEPIApW/heKkJCsLkE02PkwxfKpQsDlKnIPYvH3I2+g4TDujQEm/d01mVu7h+XLCE
         vHciJPId8InbDVI+0L22MdA+5tGEZEk0NQFBQD/2I5nf/n31Lv1yZ/eb587nLUgJijiQ
         XeAA==
X-Gm-Message-State: AOAM530sWy5y2q8lq2HZOvQL1NLleNrClb9Y6DPFQfAedISlf8/GZ8yQ
        XaCqPvsR8sgkpSAgcGP2omWmu2Gy4yE=
X-Google-Smtp-Source: ABdhPJz8e92wz+Hm/jWij7YdDxGVbvq9FYoabmTRiUcrBJcbP3GWzghb75NDbswF7N0YsraUvfJB+g==
X-Received: by 2002:a05:600c:4fd4:b0:394:8e96:6d3b with SMTP id o20-20020a05600c4fd400b003948e966d3bmr6295630wmq.180.1652295740796;
        Wed, 11 May 2022 12:02:20 -0700 (PDT)
Received: from amir-ThinkPad-T480.lan ([77.137.68.18])
        by smtp.gmail.com with ESMTPSA id t9-20020a7bc3c9000000b003942a244eebsm435527wmj.48.2022.05.11.12.02.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 12:02:19 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 2/2] fsnotify: consistent behavior for parent not watching children
Date:   Wed, 11 May 2022 22:02:13 +0300
Message-Id: <20220511190213.831646-3-amir73il@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220511190213.831646-1-amir73il@gmail.com>
References: <20220511190213.831646-1-amir73il@gmail.com>
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

The logic for handling events on child in groups that have a mark on
the parent inode, but without FS_EVENT_ON_CHILD flag in the mask is
duplicated in several places and inconsistent.

Move the logic into the preparation of mark type iterator, so that the
parent mark type will be excluded from all mark type iterations in that
case.

This results in several subtle changes of behavior, hopefully all
desired changes of behavior, for example:

- Group A has a mount mark with FS_MODIFY in mask
- Group A has a mark with ignore mask that does not survive FS_MODIFY
  and does not watch children on directory D.
- Group B has a mark with FS_MODIFY in mask that does watch children
  on directory D.
- FS_MODIFY event on file D/foo should not clear the ignore mask of
  group A, but before this change it does

And if group A ignore mask was set to survive FS_MODIFY:
- FS_MODIFY event on file D/foo should be reported to group A on account
  of the mount mark, but before this change it is wrongly ignored

Fixes: 2f02fd3fa13e ("fanotify: fix ignore mask logic for events on child and on dir")
Reported-by: Jan Kara <jack@suse.com>
Link: https://lore.kernel.org/linux-fsdevel/20220314113337.j7slrb5srxukztje@quack3.lan/
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/notify/fanotify/fanotify.c | 10 +---------
 fs/notify/fsnotify.c          | 34 +++++++++++++++++++---------------
 2 files changed, 20 insertions(+), 24 deletions(-)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index 263d303d8f8f..4f897e109547 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -320,7 +320,7 @@ static u32 fanotify_group_event_mask(struct fsnotify_group *group,
 	}
 
 	fsnotify_foreach_iter_mark_type(iter_info, mark, type) {
-		/* Apply ignore mask regardless of ISDIR and ON_CHILD flags */
+		/* Apply ignore mask regardless of mark's ISDIR flag */
 		marks_ignored_mask |= mark->ignored_mask;
 
 		/*
@@ -330,14 +330,6 @@ static u32 fanotify_group_event_mask(struct fsnotify_group *group,
 		if (event_mask & FS_ISDIR && !(mark->mask & FS_ISDIR))
 			continue;
 
-		/*
-		 * If the event is on a child and this mark is on a parent not
-		 * watching children, don't send it!
-		 */
-		if (type == FSNOTIFY_ITER_TYPE_PARENT &&
-		    !(mark->mask & FS_EVENT_ON_CHILD))
-			continue;
-
 		marks_mask |= mark->mask;
 
 		/* Record the mark types of this group that matched the event */
diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
index c5bb2405ead3..2c9a13c31ac9 100644
--- a/fs/notify/fsnotify.c
+++ b/fs/notify/fsnotify.c
@@ -290,22 +290,15 @@ static int fsnotify_handle_event(struct fsnotify_group *group, __u32 mask,
 	}
 
 	if (parent_mark) {
-		/*
-		 * parent_mark indicates that the parent inode is watching
-		 * children and interested in this event, which is an event
-		 * possible on child. But is *this mark* watching children and
-		 * interested in this event?
-		 */
-		if (parent_mark->mask & FS_EVENT_ON_CHILD) {
-			ret = fsnotify_handle_inode_event(group, parent_mark, mask,
-							  data, data_type, dir, name, 0);
-			if (ret)
-				return ret;
-		}
-		if (!inode_mark)
-			return 0;
+		ret = fsnotify_handle_inode_event(group, parent_mark, mask,
+						  data, data_type, dir, name, 0);
+		if (ret)
+			return ret;
 	}
 
+	if (!inode_mark)
+		return 0;
+
 	if (mask & FS_EVENT_ON_CHILD) {
 		/*
 		 * Some events can be sent on both parent dir and child marks
@@ -422,8 +415,19 @@ static bool fsnotify_iter_select_report_types(
 	iter_info->report_mask = 0;
 	fsnotify_foreach_iter_type(type) {
 		mark = iter_info->marks[type];
-		if (mark && mark->group == iter_info->current_group)
+		if (mark && mark->group == iter_info->current_group) {
+			/*
+			 * FSNOTIFY_ITER_TYPE_PARENT indicates that this inode
+			 * is watching children and interested in this event,
+			 * which is an event possible on child.
+			 * But is *this mark* watching children?
+			 */
+			if (type == FSNOTIFY_ITER_TYPE_PARENT &&
+			    !(mark->mask & FS_EVENT_ON_CHILD))
+				continue;
+
 			fsnotify_iter_set_report_type(iter_info, type);
+		}
 	}
 
 	return true;
-- 
2.25.1

