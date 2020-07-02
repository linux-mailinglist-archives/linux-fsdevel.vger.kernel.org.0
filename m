Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A9E92123E5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Jul 2020 14:58:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729278AbgGBM6I (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Jul 2020 08:58:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729261AbgGBM6F (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Jul 2020 08:58:05 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B255C08C5C1
        for <linux-fsdevel@vger.kernel.org>; Thu,  2 Jul 2020 05:58:05 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id 22so26666972wmg.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Jul 2020 05:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fJaD3P04dnDWrgiuiviPwUPpwYXWjcSrQDz/eR1OD+k=;
        b=K4EP7ln34gBc7IhzC+hE4wn+p4de9NVBN+9I2FJl2+xErqSS3qCcWN8I1EGekfabqa
         DxNeTonGBaXQTN/KlUyNzEdNFp8Qax2HVOSHTUqI+VkorlJIbFgu2XifaDfW0lJD+7fw
         YuzG5mu4u11bmvWNBJgLAW6oIdInY1gNY5crlZ/HLjfT6hd7Bwb7SDd1J0pBftT3MnkJ
         QWgubwkov9n/KiD6Gjf/Fz0IxETO5EtQqLGLRrNu5GmNeHYDOdLqnKT5QWZOIxPa82lN
         l9daHACTg2LcWQguTcQXjJE7UmO+zbsuG1jJyzQMTs6utV5mxS5ZVE9rZ3oqw/KUqHEW
         SuRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fJaD3P04dnDWrgiuiviPwUPpwYXWjcSrQDz/eR1OD+k=;
        b=jmqi13P36yJBFLQlNnWP8ZHMTcAlZ49wYQimDYkvazVqP6dI3y8Sp63HjTmghsSEwY
         ifmW43BnlxTCS8/rEsGYVuVbpNGybFFa6HvT6mKN6mkZup7Lw3ErncyA9I3Zw4Fqq4vX
         +lHHYjYjbQI+9IvoD15/O/fFnoQG84fdtWNAR+LZR62ud8xzfRyAYTDIy9eW9Y71xLQo
         7dWM+eqBtHk5I9HowM63ceVjaHhJdOisAoDDoDHuib1a+Ws82CXD6iWqqQPyJLxp8bwE
         x2Cjv1b31gxgt8TKHcPvf2jKg2+uMMTy9kY75DY6mN8yV/jcMQJq/90bMOdLdwsSNgMR
         NIzA==
X-Gm-Message-State: AOAM530Vb46ZK7U1Igakcne/07VmqM31QIqr3KQvKWV4gUEnw9cddU7B
        vTCDocHGdRFTE4OeojaEmHA=
X-Google-Smtp-Source: ABdhPJy7dEa+4KjvcUhATtpjVewpdNPbpq3TQK/4hT6/h21771rl6N6LUtmSa13P71O8oW5GV1aRzA==
X-Received: by 2002:a1c:790c:: with SMTP id l12mr30988509wme.50.1593694684030;
        Thu, 02 Jul 2020 05:58:04 -0700 (PDT)
Received: from localhost.localdomain ([141.226.183.23])
        by smtp.gmail.com with ESMTPSA id g16sm11847335wrh.91.2020.07.02.05.58.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2020 05:58:03 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v4 07/10] fanotify: report events with parent dir fid to sb/mount/non-dir marks
Date:   Thu,  2 Jul 2020 15:57:41 +0300
Message-Id: <20200702125744.10535-8-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200702125744.10535-1-amir73il@gmail.com>
References: <20200702125744.10535-1-amir73il@gmail.com>
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
index 23fb1bfb6945..c45d65fa8d1d 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -255,8 +255,7 @@ static u32 fanotify_group_event_mask(struct fsnotify_group *group,
 		 */
 		if (event_mask & FS_EVENT_ON_CHILD &&
 		    type != FSNOTIFY_OBJ_TYPE_CHILD &&
-		    (type != FSNOTIFY_OBJ_TYPE_INODE ||
-		     !(mark->mask & FS_EVENT_ON_CHILD)))
+		    !(mark->mask & FS_EVENT_ON_CHILD))
 			continue;
 
 		marks_mask |= mark->mask;
diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index fe2c25e26753..20bb1c52b1cd 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -1213,6 +1213,13 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
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

