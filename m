Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EF23522F6B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 May 2022 11:29:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238140AbiEKJ32 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 May 2022 05:29:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237571AbiEKJ3Y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 May 2022 05:29:24 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C736E6B48
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 May 2022 02:29:23 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id m1so2078602wrb.8
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 May 2022 02:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eZL4bpovN5u00RFM2GRKRfmoFXR/HydxY9rwS+Pl3rc=;
        b=Yh3hKCrDY4tltiLG0l3qC4Xh//f4NUOyPHLXZJfiIOs25mwatgbst3GfniyFaxYk/e
         XZnYN0M9LE4mZ/RI6/pEfUw/r46Z/evEmxJ+S8FE1NEZo5fwSNb5Uon20txDc7+Vte+V
         2zIc2EZ5uPDnili0PTCdRNQlmoobXc1BtFGzNs7DpJr1vTCfE6GY4FbE2lWfcrfUlnsR
         exIgAUMAz5qyCahoGNAeR28XDtNCG1EQuKpFwdh2GciYu1JAWR1plpritPPaPHx21CDO
         rcLkpbW21Poy+gUh/bdDPaqIaFM4fPlvMUcAUjCBtWhauS4goViUlZ2R0mpmZ6rU54+z
         nq1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eZL4bpovN5u00RFM2GRKRfmoFXR/HydxY9rwS+Pl3rc=;
        b=UTUFbeWX3PLNLbjOOSYQ69rjOjQuBKKUifVEfL5GCd/n8HqB+HwhEGt8+mi6ql+ouk
         suAvx+etFiMEhtzRhXWucYeIPvq01PitQLwPjV5RbfOUEkd3lVBPdZktjuoKnQ+XnM1U
         tzRtRIHk7OtnS84UlwAHB8dks43EHTvjjv134G7WTz1/wWJTB5pDfsbu0AACPKS75OiY
         puPTlmmkZr5n5GlWxxgwAQ+8NLLylW6I2ecpc9byLJLJDumpbN0toJjxI7hvYD/QZa83
         qSHVKoLaiR6lzLG5DvaQpWaGclJzchJnrJy1/TkEaIrKM8FQKiHsFbaqle9j93Sy7bnM
         Sh3g==
X-Gm-Message-State: AOAM5312wjRJNuS69EWUiZBlgqaKGY/5ujuAkPMt1ETjkt90Gy8/90Dl
        LvHmVXgz+SyQ5x9rVDRB/YpKAAnDlAw=
X-Google-Smtp-Source: ABdhPJx4JL5YREPbsnJUhOtSspTSmOfxtSwR/7bw7IWSmLnBhLQCm8vJo16tBaDHvcDqxN6oSxJicA==
X-Received: by 2002:a5d:5281:0:b0:20c:d5be:331c with SMTP id c1-20020a5d5281000000b0020cd5be331cmr6146117wrv.9.1652261361969;
        Wed, 11 May 2022 02:29:21 -0700 (PDT)
Received: from amir-ThinkPad-T480.lan ([5.29.18.175])
        by smtp.gmail.com with ESMTPSA id f13-20020a7bc8cd000000b0039429bfebebsm2036676wml.3.2022.05.11.02.29.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 02:29:21 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 2/2] fsnotify: consistent behavior for parent not watching children
Date:   Wed, 11 May 2022 12:29:14 +0300
Message-Id: <20220511092914.731897-3-amir73il@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220511092914.731897-1-amir73il@gmail.com>
References: <20220511092914.731897-1-amir73il@gmail.com>
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
 fs/notify/fanotify/fanotify.c | 10 +--------
 fs/notify/fsnotify.c          | 40 ++++++++++++++++++++++-------------
 2 files changed, 26 insertions(+), 24 deletions(-)

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
index 00f11ef4c0ed..985cc56f4c7d 100644
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
@@ -393,6 +386,23 @@ static struct fsnotify_mark *fsnotify_next_mark(struct fsnotify_mark *mark)
 	return hlist_entry_safe(node, struct fsnotify_mark, obj_list);
 }
 
+static void fsnotify_iter_set_report_mark_type(
+		struct fsnotify_iter_info *iter_info, int iter_type)
+{
+	struct fsnotify_mark *mark = iter_info->marks[iter_type];
+
+	/*
+	 * FSNOTIFY_ITER_TYPE_PARENT indicates that this inode is watching
+	 * children and interested in this event, which is an event
+	 * possible on child. But is *this mark* watching children?
+	 */
+	if (iter_type == FSNOTIFY_ITER_TYPE_PARENT &&
+	    !(mark->mask & FS_EVENT_ON_CHILD))
+		return;
+
+	fsnotify_iter_set_report_type(iter_info, iter_type);
+}
+
 /*
  * iter_info is a multi head priority queue of marks.
  * Pick a subset of marks from queue heads, all with the same group
@@ -423,7 +433,7 @@ static bool fsnotify_iter_select_report_types(
 	fsnotify_foreach_iter_type(type) {
 		mark = iter_info->marks[type];
 		if (mark && mark->group == iter_info->current_group)
-			fsnotify_iter_set_report_type(iter_info, type);
+			fsnotify_iter_set_report_mark_type(iter_info, type);
 	}
 
 	return true;
-- 
2.25.1

