Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA24A1C5D53
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 May 2020 18:20:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730326AbgEEQUf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 May 2020 12:20:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730038AbgEEQUe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 May 2020 12:20:34 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFBFFC061A0F;
        Tue,  5 May 2020 09:20:33 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id s8so3437848wrt.9;
        Tue, 05 May 2020 09:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yY+bhdyqnSifK57VkgUaPiCviPA6iwmvsO4o134EEgY=;
        b=q3tPb65jrzPiiIZbzkr4Euc4VQeZgXUQahl8mWUCu0+ehoR4bgBIcRGTqiED3bOHAq
         h/wF/DwkciN3e02ugWRf1nT40NLTlrW4To6qZBwR30RYADHBpA4Cmp724RI2i+olMQFu
         1+JOa3toBut+vY1QwASjGgnRxwBIyGQZdi8Ir6yrOif6OAmA2gRgt89ue1AveMKHow2n
         AqKrjvDn2V3Qare7XGd9tlO+timzPzE0pskXDUNzvaeLVjxQulxKDXEKoYeL6fuELqeA
         UvBA3WYlSpx618RXATwCmH/s5i1Wy/NEQ4/vw69pHbHgKGKw7gJm4fzcr7y/jREfz/+/
         2cWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yY+bhdyqnSifK57VkgUaPiCviPA6iwmvsO4o134EEgY=;
        b=o//Xml67migyVr+FvkWohD48sqA3NjAkk3AbuchjXg0++MO4ns/gigtK1HS6XrOO4f
         NeSpJNZUkrQffQFITvI9VuvK+62EbJXnTx2EDeVWyrkOAhdXQ0bcaCNN14eP28HZhGIE
         Ogkbp/ph7d1Nq2mxYsMJ7ZVJNmtI9PczowUgCpiTsKYG+T+Xl2M6A+0L+fzx9L2YoDbI
         xZ87JVe5boNExCSp6upcjniIWjoRAv6/9ssLHtxkYF5LUcxIDbdr0VEQsWYpsjBeruqm
         mTjQiGMzYBWx3al2dT1nYxvTbQsY/EhC6AHFtz3/HYoubx/LW461/soiWcnEUDJQ+DNC
         +2Sw==
X-Gm-Message-State: AGi0PuZaYv6bgXeetpa3dT6FpYjolmOSQKTUlw8S94WxD4uotbJVt472
        g+nST2G6e1g6EF8FAN7/HPQ=
X-Google-Smtp-Source: APiQypKgEhgof7rSvYj3ILm/nrUjR72kkGB2LTvsUxaoRw3h7amXLD9kV0taO7xWOhMk55qpv/O3gg==
X-Received: by 2002:a5d:614b:: with SMTP id y11mr4904778wrt.77.1588695632481;
        Tue, 05 May 2020 09:20:32 -0700 (PDT)
Received: from localhost.localdomain ([141.226.12.123])
        by smtp.gmail.com with ESMTPSA id c128sm1612871wma.42.2020.05.05.09.20.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2020 09:20:31 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
Subject: [PATCH v3 7/7] fanotify: report events "on child" with name info to sb/mount marks
Date:   Tue,  5 May 2020 19:20:14 +0300
Message-Id: <20200505162014.10352-8-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200505162014.10352-1-amir73il@gmail.com>
References: <20200505162014.10352-1-amir73il@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

With fanotify_init() flags FAN_REPORT_FID_NAME, when adding an inode
mark with FS_EVENT_ON_CHILD, events are reported with fid of the parent
and the name of the child entry.

When adding a filesystem or mount mark, report events that are "possible
on child" (e.g. open/close) in two flavors, one with just the child fid
and one also with the parent fid and the child entry name, as if all
directories are interested in events "on child".

The flag FAN_EVENT_ON_CHILD was always ignored for sb/mount mark, so we
can safely ignore the value of the flag passed by the user and set the
flag in sb/mount mark mask depending on the FAN_REPORT_NAME group flag.

Cc: <linux-api@vger.kernel.org>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/notify/fanotify/fanotify.c      |  7 +++++--
 fs/notify/fanotify/fanotify_user.c | 16 ++++++++++++++--
 2 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index e91a8cc1b83c..ec42c721850c 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -244,10 +244,13 @@ static u32 fanotify_group_event_mask(struct fsnotify_group *group,
 		/*
 		 * If the event is for a child and this mark doesn't care about
 		 * events on a child, don't send it!
+		 * An event "on child" without name info is not intended for a
+		 * mount/sb mark.
 		 */
 		if (event_mask & FS_EVENT_ON_CHILD &&
-		    (type != FSNOTIFY_OBJ_TYPE_INODE ||
-		     !(mark->mask & FS_EVENT_ON_CHILD)))
+		    (!(mark->mask & FS_EVENT_ON_CHILD) ||
+		     (type != FSNOTIFY_OBJ_TYPE_INODE &&
+		      !FAN_GROUP_FLAG(group, FAN_REPORT_NAME))))
 			continue;
 
 		marks_mask |= mark->mask;
diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index 36c1327b32f4..89c0554da90e 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -1150,8 +1150,20 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
 		inode = path.dentry->d_inode;
 	} else {
 		mnt = path.mnt;
-		/* Mask out FAN_EVENT_ON_CHILD flag for sb/mount marks */
-		mask &= ~FAN_EVENT_ON_CHILD;
+		/*
+		 * So far, flag FAN_EVENT_ON_CHILD was ignored for sb/mount
+		 * marks.  Reporting events "on child" with name info for
+		 * sb/mount marks is now implemented, so explicitly mask out
+		 * the flag for backward compatibility with existing programs
+		 * that do not request events with name info.
+		 * On sb/mount mark events with FAN_REPORT_NAME, events are
+		 * reported as if all directories are interested in events
+		 * "on child".
+		 */
+		if (FAN_GROUP_FLAG(group, FAN_REPORT_NAME))
+			mask |= FAN_EVENT_ON_CHILD;
+		else
+			mask &= ~FAN_EVENT_ON_CHILD;
 	}
 
 	/* create/update an inode mark */
-- 
2.17.1

