Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB404456AD6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Nov 2021 08:17:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233775AbhKSHU4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Nov 2021 02:20:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233725AbhKSHUz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Nov 2021 02:20:55 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AC9BC061574
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Nov 2021 23:17:54 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id y196so7557349wmc.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Nov 2021 23:17:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4OQYxFBCXONbiG6AxXy9dYO5XcrX6u9dgMZf1tvq0b0=;
        b=gJm/UfinY+s+jqANvGQowSjy5dCenFyyNlentFy/WfP6+HoMQVqPC/B+ghnnkVrsd6
         b7LpTbXW8haoMWstt8N4hMzqSRWEXWRLALpzA0Iuip2I6bjKKF3ut+La8TSYY3y4xn/E
         Xa29/KEm6peK+zhXkHL0zoCXhl2y4KZppbrofDNefR5vfYR+AxRIuPeJO8nhTj5Wl6Or
         rsGamH2H1VhD4DwGEBCfEacgi4fktWKHymrMsLeW+uGYzGkz+WRG62X2je6zcs9DKa04
         7jMi9nVobvEzxasxNeJatAqDGaox6qBtBbYTc7CCEgil/fXEmXSs+UX8+10zIXfmseX9
         qL4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4OQYxFBCXONbiG6AxXy9dYO5XcrX6u9dgMZf1tvq0b0=;
        b=1y/EedQ4FfmHb83HLBqptMxWZfpbmf0frmorXGkoULzQ+0S1ZseaAYwMNVF8ZoHLHi
         zQsVR3eIgWOepPTGODwgF8hmHMoqDg4DlekHzB+tSlCATTAQxMTmK5UmB56DKk7w1wGE
         yi85BQlmn7eHzY8IoA8OMd7k+b0VUDuBUw4GvAwThU+jQWCoQDbhakAoBVB1p9RqgDD4
         RdiSKGvztmRFohmmPcddq0IId2ccdUg0NMgDfcZPSoGdze/hMsyVUXt0Hf6kWA11Gd/o
         elyjSd7QQUwHU8t3EAv9/ndcOIVcC3DnyWBRVaJWs2oxrymnp+i9/23pMsBJGPDZC0Yz
         1d1g==
X-Gm-Message-State: AOAM532zrmPEGzc9exWn0+BqXXlY8Sa/sXfQ6HuK6K5XLFDTDezoolYn
        y4qjmvDXB08B8zpkzNgIxtk=
X-Google-Smtp-Source: ABdhPJwGCsTs4LgBRKTo/Engp0KP7hlXObsNKGR5MHa+FxRX/We8xEpHxu13u8Ch443BnNAvlAuIGg==
X-Received: by 2002:a05:600c:4108:: with SMTP id j8mr4140098wmi.139.1637306272878;
        Thu, 18 Nov 2021 23:17:52 -0800 (PST)
Received: from localhost.localdomain ([82.114.45.86])
        by smtp.gmail.com with ESMTPSA id l22sm1905913wmp.34.2021.11.18.23.17.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 23:17:52 -0800 (PST)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 7/9] fanotify: record either old name new name or both for FAN_RENAME
Date:   Fri, 19 Nov 2021 09:17:36 +0200
Message-Id: <20211119071738.1348957-8-amir73il@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211119071738.1348957-1-amir73il@gmail.com>
References: <20211119071738.1348957-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We do not want to report the dirfid+name of a directory whose
inode/sb are not watched, because watcher may not have permissions
to see the directory content.

The FAN_MOVED_FROM/TO flags are used internally to indicate to
fanotify_alloc_event() if we need to record only the old parent+name,
only the new parent+name or both.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/notify/fanotify/fanotify.c | 57 ++++++++++++++++++++++++++++++-----
 1 file changed, 50 insertions(+), 7 deletions(-)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index 018b32a57702..c0a3fb1dd066 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -290,6 +290,7 @@ static u32 fanotify_group_event_mask(struct fsnotify_group *group,
 	__u32 marks_mask = 0, marks_ignored_mask = 0;
 	__u32 test_mask, user_mask = FANOTIFY_OUTGOING_EVENTS |
 				     FANOTIFY_EVENT_FLAGS;
+	__u32 moved_mask = 0;
 	const struct path *path = fsnotify_data_path(data, data_type);
 	unsigned int fid_mode = FAN_GROUP_FLAG(group, FANOTIFY_FID_BITS);
 	struct fsnotify_mark *mark;
@@ -327,17 +328,44 @@ static u32 fanotify_group_event_mask(struct fsnotify_group *group,
 			continue;
 
 		/*
-		 * If the event is on a child and this mark is on a parent not
-		 * watching children, don't send it!
+		 * In the special case of FAN_RENAME event, inode mark is the
+		 * mark on the old dir and parent mark is the mark on the new
+		 * dir.  We do not want to report the dirfid+name of a directory
+		 * whose inode/sb are not watched.  The FAN_MOVE flags
+		 * are used internally to indicate if we need to report only
+		 * the old parent+name, only the new parent+name or both.
 		 */
-		if (type == FSNOTIFY_OBJ_TYPE_PARENT &&
-		    !(mark->mask & FS_EVENT_ON_CHILD))
+		if (event_mask & FAN_RENAME) {
+			/* Old dir sb are watched - report old info */
+			if (type != FSNOTIFY_OBJ_TYPE_PARENT &&
+			    (mark->mask & FAN_RENAME))
+				moved_mask |= FAN_MOVED_FROM;
+			/* New dir sb are watched - report new info */
+			if (type != FSNOTIFY_OBJ_TYPE_INODE &&
+			    (mark->mask & FAN_RENAME))
+				moved_mask |= FAN_MOVED_TO;
+		} else if (type == FSNOTIFY_OBJ_TYPE_PARENT &&
+			   !(mark->mask & FS_EVENT_ON_CHILD)) {
+			/*
+			 * If the event is on a child and this mark is on
+			 * a parent not watching children, don't send it!
+			 */
 			continue;
+		}
 
 		marks_mask |= mark->mask;
 	}
 
 	test_mask = event_mask & marks_mask & ~marks_ignored_mask;
+	/*
+	 * Add the internal FAN_MOVE flags to FAN_RENAME event.
+	 * They will not be reported to user along with FAN_RENAME.
+	 */
+	if (test_mask & FAN_RENAME) {
+		if (WARN_ON_ONCE(test_mask & FAN_MOVE))
+			return 0;
+		test_mask |= moved_mask;
+	}
 
 	/*
 	 * For dirent modification events (create/delete/move) that do not carry
@@ -753,13 +781,28 @@ static struct fanotify_event *fanotify_alloc_event(struct fsnotify_group *group,
 		}
 
 		/*
-		 * In the special case of FAN_RENAME event, we record both
-		 * old and new parent+name.
+		 * In the special case of FAN_RENAME event, the FAN_MOVE flags
+		 * are only used internally to indicate if we need to report
+		 * only the old parent+name, only the new parent+name or both.
 		 * 'dirid' and 'file_name' are the old parent+name and
 		 * 'moved' has the new parent+name.
 		 */
 		if (mask & FAN_RENAME) {
-			moved = fsnotify_data_dentry(data, data_type);
+			/* Either old and/or new info must be reported */
+			if (WARN_ON_ONCE(!(mask & FAN_MOVE)))
+				return NULL;
+
+			if (!(mask & FAN_MOVED_FROM)) {
+				/* Do not report old parent+name */
+				dirid = NULL;
+				file_name = NULL;
+			}
+			if (mask & FAN_MOVED_TO) {
+				/* Report new parent+name */
+				moved = fsnotify_data_dentry(data, data_type);
+			}
+			/* Clear internal flags */
+			mask &= ~FAN_MOVE;
 			name_event = true;
 		}
 	}
-- 
2.33.1

