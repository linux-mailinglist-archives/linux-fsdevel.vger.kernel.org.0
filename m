Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 085D8221EBC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jul 2020 10:43:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728183AbgGPInL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Jul 2020 04:43:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727883AbgGPInI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Jul 2020 04:43:08 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F38FAC08C5CE
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Jul 2020 01:43:07 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id l2so10660478wmf.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Jul 2020 01:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yhHqDPQ8gq54q6YqOZYEa8VhIz78YcgAJGkNbv5c3ps=;
        b=SG7jEahsULDXup5dXHQe2M0SsJEyvUjwn3oUWDcdIUE1A/5KTKJMbh1RmBcXwNGeMW
         nug0PLCXQrHeFNSddxtoidSk7ZlDWwShFHuPcaatQcnGf3vfV8DZKyMtB1aRZzMVENm5
         2cIuEl4i+e3o1ST2SOu/TbJLdwi4PkDWYNRLcUml/VC2Tgvng4cx5bu9aKwYI+W1C+g8
         Patl4cmAl4I6avCOPVTqXVJdLky9ev5TtVA2NIU3Hkmko6ezCapAfcVzrn1UxEYnmHlM
         eOhAQQGP9hySkgQudZpbgMza0SMcHX+c3u8DIL3Lv1xTwjSOVrd6hdZ3vDt0a9GtcgN7
         d1rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yhHqDPQ8gq54q6YqOZYEa8VhIz78YcgAJGkNbv5c3ps=;
        b=BCIbsJIyAL8ia5i0VguO2SKv6YdbHpZgjZJ61R3u91lsdVIkF+EOeLbm/4xZV485vx
         PP4n/PsDOR62zuM3qpRlWltK8y2+tPiDIjxzdxY21JMc0VAszlvuxgjZWTNtNihnZeU1
         D39DYkZc8dUzQ8jsDej/mamnL0XddcfHCF6oZLMs1f4ALJq1PRP3vdrA2aIKQi6511Qs
         ErQZbroSpG2I6wxL28XHzkWi5qAD7dr85WjEl8Jb4Czd55s7umb0ZqEnIPh1/1Wj3xys
         wEmzlXSxDAPjPbOjyT9QKIfLCahVWcSlpmxhQ8HSJJC7OjWD4kL3kbh9Suge8bO3OUlu
         MNgQ==
X-Gm-Message-State: AOAM532dXKD3I7jPu6YJK7xG2tZza/RnP8scBSGGeu+JDoFExvW9n4hw
        O4Xv19Hb6Ic0E8c0JyBVtlk=
X-Google-Smtp-Source: ABdhPJyLpg1MBTuLrj3FRTvgJyW0DoxEcMwXiqPpgeSypY3HFavm+dztaJauqlw4DLj7MK24BPlU/w==
X-Received: by 2002:a1c:8117:: with SMTP id c23mr3153655wmd.157.1594888986672;
        Thu, 16 Jul 2020 01:43:06 -0700 (PDT)
Received: from localhost.localdomain ([141.226.183.23])
        by smtp.gmail.com with ESMTPSA id j75sm8509977wrj.22.2020.07.16.01.43.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 01:43:06 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH v5 22/22] fanotify: report parent fid + child fid
Date:   Thu, 16 Jul 2020 11:42:30 +0300
Message-Id: <20200716084230.30611-23-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200716084230.30611-1-amir73il@gmail.com>
References: <20200716084230.30611-1-amir73il@gmail.com>
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
index 1d8eb886fe08..8cb4fdeb567a 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -539,7 +539,7 @@ static struct fanotify_event *fanotify_alloc_event(struct fsnotify_group *group,
 		/*
 		 * With both flags FAN_REPORT_DIR_FID and FAN_REPORT_FID, we
 		 * report the child fid for events reported on a non-dir child
-		 * in addition to reporting the parent fid and child name.
+		 * in addition to reporting the parent fid and maybe child name.
 		 */
 		if ((fid_mode & FAN_REPORT_FID) &&
 		    (mask & FAN_EVENT_ON_CHILD) && !(mask & FAN_ONDIR))
@@ -556,11 +556,17 @@ static struct fanotify_event *fanotify_alloc_event(struct fsnotify_group *group,
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
@@ -579,7 +585,7 @@ static struct fanotify_event *fanotify_alloc_event(struct fsnotify_group *group,
 
 	if (fanotify_is_perm_event(mask)) {
 		event = fanotify_alloc_perm_event(path, gfp);
-	} else if (name_event && file_name) {
+	} else if (name_event && (file_name || child)) {
 		event = fanotify_alloc_name_event(id, fsid, file_name, child,
 						  gfp);
 	} else if (fid_mode) {
diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index be328d7ee283..559de311deca 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -371,7 +371,8 @@ static ssize_t copy_event_to_user(struct fsnotify_group *group,
 
 	/* Event info records order is: dir fid + name, child fid */
 	if (fanotify_event_dir_fh_len(event)) {
-		info_type = FAN_EVENT_INFO_TYPE_DFID_NAME;
+		info_type = info->name_len ? FAN_EVENT_INFO_TYPE_DFID_NAME :
+					     FAN_EVENT_INFO_TYPE_DFID;
 		ret = copy_info_to_user(fanotify_event_fsid(event),
 					fanotify_info_dir_fh(info),
 					info_type, fanotify_info_name(info),
@@ -957,18 +958,10 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flags, unsigned int, event_f_flags)
 
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

