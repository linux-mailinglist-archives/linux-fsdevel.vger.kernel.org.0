Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 805072123E8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Jul 2020 14:58:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729293AbgGBM6N (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Jul 2020 08:58:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729285AbgGBM6K (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Jul 2020 08:58:10 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38BF7C08C5DD
        for <linux-fsdevel@vger.kernel.org>; Thu,  2 Jul 2020 05:58:09 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id f7so25190149wrw.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Jul 2020 05:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vCk45qQHcw9Ee/5wdcgAo1co3kl5QLzRRRW8KEwv3lM=;
        b=ldchsISczMzxMM0lBG9gxmXL+uLUWqZiaMpjefBkaLc1Pw8BMc7sHBZnpvQcqYbmcG
         Orag0xErYMp7ISgIidwrtFBdjUutua1hSOgtHzFmMIIUGnHYHq2qBU+MHYfRUUzTTGrx
         bRYICWnZFQAbmv8CTb3k0UqBd+hBQe4zq0DRmp98o7ZAceitcLzzDbVu2xf2dIipsMZz
         0s6QLjz9nB8CJgvMUuACkIr5RYIskcgnyM0rNtWLzf17MnSzqs1jgmJSPqQgTHzqQqjD
         RxBkQqiw2/fwdygQGVceXhoTMO36pAk+l/3bgmqu6PSjSqjfqst3NOEny1WCFCpvi4sE
         VYmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vCk45qQHcw9Ee/5wdcgAo1co3kl5QLzRRRW8KEwv3lM=;
        b=nKzYkC7NPkNKMkxS6d7YUNbZYddL6mDeStrW9ajQbj4KN6k/cFDU06qCt3WBc9Y+eg
         6L/wovHanBch3nSapkOUYN0gOXMAAKcalWOTuXQCpM5NtJR7PcEAy06fItYX+qGhjiVA
         jZ8Jan1Oo1e0x7GY+fEvl+MmD2C7aHFIauKxXHQfkmShGL20OgUp4GXCnUfwzHq5MTMP
         +x3PQe4/E+MQ4BCfSme+J7RWl5Qsm0FjHyOzjmet4GBu0IW5K/WtrKP1/l8g9BjitcPa
         Rc2ycFdl7MHuXrN6B8usSz2H4Pbw3pRrqjr7NxtIaISWUKWh/wKZDmOCdwd/z3B+gyW/
         KwrQ==
X-Gm-Message-State: AOAM533EpPxWH1xn6i2S0Ncu/2oegcBDN2xBHK5TfLBdv5vHRSqn+dWS
        9/ZvmaUmB6EEUWLCFOWGvhA=
X-Google-Smtp-Source: ABdhPJwfdq0lfEPeo26E4uH7Zg6OmEXDQxmDg91gdKHwtj110jgRXaf/GLDnWndoxWgGZ3uiGrUvnw==
X-Received: by 2002:adf:fc90:: with SMTP id g16mr31207921wrr.42.1593694687943;
        Thu, 02 Jul 2020 05:58:07 -0700 (PDT)
Received: from localhost.localdomain ([141.226.183.23])
        by smtp.gmail.com with ESMTPSA id g16sm11847335wrh.91.2020.07.02.05.58.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2020 05:58:07 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v4 10/10] fanotify: report parent fid + child fid
Date:   Thu,  2 Jul 2020 15:57:44 +0300
Message-Id: <20200702125744.10535-11-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200702125744.10535-1-amir73il@gmail.com>
References: <20200702125744.10535-1-amir73il@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add support for FAN_REPORT_FID | FAN_REPORT_DIR_FID.
Internally, it is implemented as a private case of reporting both
parent and child fids and name, the parent and child fids are recorded
in a variable length fanotify_name_event, but there is no name.

It should be noted that directory modification events are recorded
in fixed size fanotify_fid_event when not reporting name, just like
with group flags FAN_REPORT_FID.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/notify/fanotify/fanotify.c      | 16 +++++++++++-----
 fs/notify/fanotify/fanotify_user.c | 15 ++++-----------
 2 files changed, 15 insertions(+), 16 deletions(-)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index 3e8e20c19d97..1122d7a8ba07 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -518,7 +518,7 @@ static struct fanotify_event *fanotify_alloc_event(struct fsnotify_group *group,
 		/*
 		 * With both flags FAN_REPORT_DIR_FID and FAN_REPORT_FID, we
 		 * report the child fid for events reported on a non-dir child
-		 * in addition to reporting the parent fid and child name.
+		 * in addition to reporting the parent fid and maybe child name.
 		 */
 		if ((fid_mode & FAN_REPORT_FID) &&
 		    (mask & FAN_EVENT_ON_CHILD) && !(mask & FAN_ONDIR))
@@ -535,11 +535,17 @@ static struct fanotify_event *fanotify_alloc_event(struct fsnotify_group *group,
 		 *
 		 * For event on non-directory that is reported to parent, we
 		 * record the fid of the parent and the name of the child.
+		 *
+		 * Even if not reporting name, we need a variable length
+		 * fanotify_name_event if reporting both parent and child fids.
 		 */
-		if ((fid_mode & FAN_REPORT_NAME) &&
-		    ((mask & ALL_FSNOTIFY_DIRENT_EVENTS) ||
-		     !(mask & FAN_ONDIR)))
+		if (!(fid_mode & FAN_REPORT_NAME)) {
+			name_event = !!child;
+			file_name = NULL;
+		} else if ((mask & ALL_FSNOTIFY_DIRENT_EVENTS) ||
+			   !(mask & FAN_ONDIR)) {
 			name_event = true;
+		}
 	}
 
 	/*
@@ -558,7 +564,7 @@ static struct fanotify_event *fanotify_alloc_event(struct fsnotify_group *group,
 
 	if (fanotify_is_perm_event(mask)) {
 		event = fanotify_alloc_perm_event(path, gfp);
-	} else if (name_event && file_name) {
+	} else if (name_event && (file_name || child)) {
 		event = fanotify_alloc_name_event(id, fsid, file_name, child,
 						  gfp);
 	} else if (fid_mode) {
diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index 577ad74f71ec..24426146f41e 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -370,7 +370,8 @@ static ssize_t copy_event_to_user(struct fsnotify_group *group,
 
 	/* Event info records order is: dir fid + name, child fid */
 	if (dfh) {
-		info_type = FAN_EVENT_INFO_TYPE_DFID_NAME;
+		info_type = dfh->name_len ? FAN_EVENT_INFO_TYPE_DFID_NAME :
+					    FAN_EVENT_INFO_TYPE_DFID;
 		ret = copy_info_to_user(fanotify_event_fsid(event), dfh,
 					info_type, fanotify_fh_name(dfh),
 					dfh->name_len, buf, count);
@@ -950,18 +951,10 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flags, unsigned int, event_f_flags)
 
 	/*
 	 * Child name is reported with parent fid so requires dir fid.
-	 * If reporting child name, we can report both child fid and dir fid.
+	 * We can report both child fid and dir fid with or without name.
 	 */
-	switch (fid_mode) {
-	case 0:
-	case FAN_REPORT_FID:
-	case FAN_REPORT_DIR_FID:
-	case FAN_REPORT_DFID_NAME:
-	case FAN_REPORT_DFID_NAME | FAN_REPORT_FID:
-		break;
-	default:
+	if ((fid_mode & FAN_REPORT_NAME) && !(fid_mode & FAN_REPORT_DIR_FID))
 		return -EINVAL;
-	}
 
 	user = get_current_user();
 	if (atomic_read(&user->fanotify_listeners) > FANOTIFY_DEFAULT_MAX_LISTENERS) {
-- 
2.17.1

