Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9439C46264B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Nov 2021 23:48:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235419AbhK2Wt5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Nov 2021 17:49:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234883AbhK2Wt3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Nov 2021 17:49:29 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4081EC06FD4F
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Nov 2021 12:15:54 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id o19-20020a1c7513000000b0033a93202467so13242494wmc.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Nov 2021 12:15:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Y9sw0fri4Kn/374BixEHV9CC9v5LPDx7+oz7QQ9DMNc=;
        b=IjvzbOB9YD9QHpjgVdan+7U03ovAWh9iO2WkgP/QAiqwFDb5zSYictMILh0Rpn/CDv
         wJwwLluyJUQkRRGX8zNS/UNncIDrt26lrOEQIOhno8iW2AHEHKNZYKA7ZpXoZDzFCSNf
         yP8oeaOZT/KoEc2Kpys+q0jBg3NpiXkznV70gh+TN71ywCv6YazZNXu5PB3U9Q71fO7c
         sl71hJvMJs4iCu9rpgt8n90pOOuXM0q/kAEny9Xk9vVfcscW+w8kPAH4byLWElGHsMHe
         xBv0noqMPa1BPWJ52gM8tvlwd+YNE+CJEGfKmdhUC4jzjniiGj81o8Qf1ggT5lPRtzTn
         BkQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Y9sw0fri4Kn/374BixEHV9CC9v5LPDx7+oz7QQ9DMNc=;
        b=KFhVrVH1cisbSCs2mO541rfbmX+dChcNyM5uNUllFV8VT5mYIMNlLWAaz/MTby2t2Z
         Yi4z9hujw7HdsK0u/9n9Z6XKW6xrIjWNSnsbKoJdtJqhTylvJ+qY/YNgvbFSrTLh2tmd
         Gux19pWg9gr9UIhxs3lRXpnieoY5PgjnJZsvAAMBvH9diviYzAYUqbDWYJBqWf1b9xbj
         e4vT7GtfwBKMEQy1/Q2bdYuOxm71NTfJZcizwfycJ3O/WxSll237+2zMtoIfIUtWsRjJ
         its95/U+veuE3Ewyv/iuoLkpsi6QEvSoSIzlv9HiNikHOeRHNa+QioUAKR0L3n+ogpK4
         Q3dQ==
X-Gm-Message-State: AOAM530CBoRDPfMPUa9pNwBQzBTbou93dGrYOf8NA5I2h+vZi0EeiiHd
        616+aWRQPAAEWonMdN17VdPpP401MyQ=
X-Google-Smtp-Source: ABdhPJzBNPyRmqsr3zhhnWVfPIrYGLUUi8Xh4nY7cREHWPSJwE125vVMH9vDuqyoWqOTE8bNFlSrTA==
X-Received: by 2002:a7b:c2a1:: with SMTP id c1mr256874wmk.112.1638216952873;
        Mon, 29 Nov 2021 12:15:52 -0800 (PST)
Received: from localhost.localdomain ([82.114.45.86])
        by smtp.gmail.com with ESMTPSA id m14sm19791830wrp.28.2021.11.29.12.15.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 12:15:52 -0800 (PST)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 11/11] fanotify: wire up FAN_RENAME event
Date:   Mon, 29 Nov 2021 22:15:37 +0200
Message-Id: <20211129201537.1932819-12-amir73il@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211129201537.1932819-1-amir73il@gmail.com>
References: <20211129201537.1932819-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

FAN_RENAME is the successor of FAN_MOVED_FROM and FAN_MOVED_TO
and can be used to get the old and new parent+name information in
a single event.

FAN_MOVED_FROM and FAN_MOVED_TO are still supported for backward
compatibility, but it makes little sense to use them together with
FAN_RENAME in the same group.

FAN_RENAME uses special info type records to report the old and
new parent+name, so reporting only old and new parent id is less
useful and was not implemented.
Therefore, FAN_REANAME requires a group with flag FAN_REPORT_NAME.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/notify/fanotify/fanotify.c      | 2 +-
 fs/notify/fanotify/fanotify_user.c | 8 ++++++++
 include/linux/fanotify.h           | 3 ++-
 3 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index f8cca428361e..e25c9fba6da5 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -934,7 +934,7 @@ static int fanotify_handle_event(struct fsnotify_group *group, u32 mask,
 	BUILD_BUG_ON(FAN_FS_ERROR != FS_ERROR);
 	BUILD_BUG_ON(FAN_RENAME != FS_RENAME);
 
-	BUILD_BUG_ON(HWEIGHT32(ALL_FANOTIFY_EVENT_BITS) != 20);
+	BUILD_BUG_ON(HWEIGHT32(ALL_FANOTIFY_EVENT_BITS) != 21);
 
 	mask = fanotify_group_event_mask(group, iter_info, &match_info,
 					 mask, data, data_type, dir);
diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index eb2a0251b318..73a3e939c921 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -1586,6 +1586,14 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
 	    (!fid_mode || mark_type == FAN_MARK_MOUNT))
 		goto fput_and_out;
 
+	/*
+	 * FAN_RENAME uses special info type records to report the old and
+	 * new parent+name.  Reporting only old and new parent id is less
+	 * useful and was not implemented.
+	 */
+	if (mask & FAN_RENAME && !(fid_mode & FAN_REPORT_NAME))
+		goto fput_and_out;
+
 	if (flags & FAN_MARK_FLUSH) {
 		ret = 0;
 		if (mark_type == FAN_MARK_MOUNT)
diff --git a/include/linux/fanotify.h b/include/linux/fanotify.h
index 376e050e6f38..3afdf339d53c 100644
--- a/include/linux/fanotify.h
+++ b/include/linux/fanotify.h
@@ -82,7 +82,8 @@ extern struct ctl_table fanotify_table[]; /* for sysctl */
  * Directory entry modification events - reported only to directory
  * where entry is modified and not to a watching parent.
  */
-#define FANOTIFY_DIRENT_EVENTS	(FAN_MOVE | FAN_CREATE | FAN_DELETE)
+#define FANOTIFY_DIRENT_EVENTS	(FAN_MOVE | FAN_CREATE | FAN_DELETE | \
+				 FAN_RENAME)
 
 /* Events that can be reported with event->fd */
 #define FANOTIFY_FD_EVENTS (FANOTIFY_PATH_EVENTS | FANOTIFY_PERM_EVENTS)
-- 
2.33.1

