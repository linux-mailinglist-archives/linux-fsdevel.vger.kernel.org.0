Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBE6D221EBA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jul 2020 10:43:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728194AbgGPInF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Jul 2020 04:43:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727870AbgGPInE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Jul 2020 04:43:04 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1508CC08C5C0
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Jul 2020 01:43:04 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id q5so6138342wru.6
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Jul 2020 01:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vhDNObLrXWXob7tK3FGK11dk0qSJrpvMIDyeT/vJCcI=;
        b=GMqFLXpMta79hTvj2k6adCiOtAM9G510c9tTRzXV2xI6I9uS7b3tkPSHdL4RRP/hEK
         Nmh3wdjKE19PeP6VcjIdRFbQhBvVGh4r9fNBIYtMlZh2gAFcMMAiRnSztawJLCvtj+9E
         LW4gWXv6IZCpd6wJ6BFCHshLdzv7M3FxHP5iUV696hyMTpvw5s91vHgwXrYzmQa6zcdG
         lgeFdI23FG6qJPO5tS56P85rMqAaPtWYb0yCB5xJmQNq48Y3HmZJxcV7faDQiL2+i/IC
         JsePsv3C17VOczGp/iiTO4GzBwYqo1K4xq5Y/5iP82Qk5HpyejxBtikeJJVCU0gdWRNo
         rj2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vhDNObLrXWXob7tK3FGK11dk0qSJrpvMIDyeT/vJCcI=;
        b=qQgpduFXZSwbJ+DFWCKN3xbkhfGN286favUmO1/Q78WVrlToKDtDseeddvNNrNQ+IN
         72Btw11jCsCxa9L8tvhIKpq7ffzNxe3tzbPleStgfpq+sojX4FTXf8eoCNB7ng5Ukvwz
         9FxOscJQiUGDZFwb9YZzoqkBdNvb137rVR8mMkUBNbqUnV/u01J4wBY/w7yVtT5AgSFb
         exF0TG4g/AkMwfRJkgeh+eV43aEogtjhfHXAcpGVLE0W+9R7wsChK0YotpT1ptia7N/F
         9cD68mpMg0ZVJdyv4vhVLR7piptih3Js6BukaQWbGab+dAzBeOH+W6anl4nOcoae1A9x
         4ChA==
X-Gm-Message-State: AOAM532vX3ytC2jmD9HTD/txX/bu+d+SetldaMCcPD6JYLihigSpRxZ0
        tekK+nujdsgGzzqq1BmYs6O7iYaf
X-Google-Smtp-Source: ABdhPJzk6cen8OSBr+tI9FlOjPb8QVu6VY0AaRDJOEhbOmFL4/62AZzh/haOxXNuUbYjmhp+TMb0hQ==
X-Received: by 2002:a5d:400b:: with SMTP id n11mr3932255wrp.74.1594888982867;
        Thu, 16 Jul 2020 01:43:02 -0700 (PDT)
Received: from localhost.localdomain ([141.226.183.23])
        by smtp.gmail.com with ESMTPSA id j75sm8509977wrj.22.2020.07.16.01.43.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 01:43:02 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH v5 19/22] fanotify: report events with parent dir fid to sb/mount/non-dir marks
Date:   Thu, 16 Jul 2020 11:42:27 +0300
Message-Id: <20200716084230.30611-20-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200716084230.30611-1-amir73il@gmail.com>
References: <20200716084230.30611-1-amir73il@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In a group with flag FAN_REPORT_DIR_FID, when adding an inode mark with
FAN_EVENT_ON_CHILD, events on non-directory children are reported with
the fid of the parent.

When adding a filesystem or mount mark or mark on a non-dir inode, we
want to report events that are "possible on child" (e.g. open/close)
also with fid of the parent, as if the victim inode's parent is
interested in events "on child".

Some events, currently only FAN_MOVE_SELF, should be reported to a
sb/mount/non-dir mark with parent fid even though they are not
reported to a watching parent.

To get the desired behavior we set the flag FAN_EVENT_ON_CHILD on
all the sb/mount/non-dir mark masks in a group with FAN_REPORT_DIR_FID.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/notify/fanotify/fanotify.c      | 3 +--
 fs/notify/fanotify/fanotify_user.c | 7 +++++++
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index 4cbdb40e0d54..09331b0acaf2 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -272,8 +272,7 @@ static u32 fanotify_group_event_mask(struct fsnotify_group *group,
 		 */
 		if (event_mask & FS_EVENT_ON_CHILD &&
 		    type != FSNOTIFY_OBJ_TYPE_CHILD &&
-		    (type != FSNOTIFY_OBJ_TYPE_INODE ||
-		     !(mark->mask & FS_EVENT_ON_CHILD)))
+		    !(mark->mask & FS_EVENT_ON_CHILD))
 			continue;
 
 		marks_mask |= mark->mask;
diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index e494400711c9..7caa64d028ba 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -1220,6 +1220,13 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
 	if (mnt || !S_ISDIR(inode->i_mode)) {
 		mask &= ~FAN_EVENT_ON_CHILD;
 		umask = FAN_EVENT_ON_CHILD;
+		/*
+		 * If group needs to report parent fid, register for getting
+		 * events with parent/name info for non-directory.
+		 */
+		if ((fid_mode & FAN_REPORT_DIR_FID) &&
+		    (flags & FAN_MARK_ADD) && !ignored)
+			mask |= FAN_EVENT_ON_CHILD;
 	}
 
 	/* create/update an inode mark */
-- 
2.17.1

