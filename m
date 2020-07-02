Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D20DC2123EB
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Jul 2020 14:58:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729281AbgGBM6V (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Jul 2020 08:58:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729279AbgGBM6I (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Jul 2020 08:58:08 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC4ACC08C5C1
        for <linux-fsdevel@vger.kernel.org>; Thu,  2 Jul 2020 05:58:07 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id s10so28156952wrw.12
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Jul 2020 05:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=khL8hyqyx3E4QPcYcyO3mp4iNI8nasQzH6Opvr5yWZw=;
        b=WW4tsNOuDtRbTrwDCYhJAgQBX9X0lEzVCtBaava4zu12L9z+9YYceWbCjiajol2300
         jjp9vXaUc951dd/TQWfr/ZYdIsVYr1JzIhZe4yxRQwlCsG2LQdPi6kEpabb6baHo7hok
         5vFnHsIUMc6peNnaVVelon7Ko1RNKHxyzih8ojazbBJq6HSlx3bfGXPqALGsj1jmo0Rj
         Mh6dLIyJoTWyApS+gS50twjfyUW6iIGiJKMT3kSt6SmyQAUFk8XxNA4G/m6cOzvjORqs
         kYMEyIahGbYnl0qMQ2rZ05WtyQsXoTIFrnHkwpsUaNc5Rq1g4iUSxuULuAUe5YN4NrQj
         KpLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=khL8hyqyx3E4QPcYcyO3mp4iNI8nasQzH6Opvr5yWZw=;
        b=TANbUlmpylw/vKG1UtPIHxO5DEtby2DRAo66fhEn9I2w4qh93si3lu019K3ayEX49M
         wQ6PIcvtFSLrhVgWh0dHEn0O2J9bf9KYG+tQyTXBoJM5ea83/K8x2hamQwL7HiMMDxP7
         WJvDmTEBB9/CfvqxW3L0dGDGsBALNnt3FELUuBWHnlxDXJc/ZeO1ccB0Q4ExOY0s+2XE
         awSRZB2KUtAiOmibEGngv1zUrrghZhwvoee+7xUhnp1DTavaDPTcM+9tROeQn5/AjsiZ
         Rm1JZ2RXT/BZF2p5hscYsLuhFKpIWa5YEPzMbGUk6Ybe5pjHiTa2FooZwdE1AVeV9yZZ
         9R9g==
X-Gm-Message-State: AOAM532mly/z+9tKJfMjmoPHObEr3yjEzuTvWJKqIyo2keZE01t+5QpK
        C1WVwOGB+khefmc4zkjFG0Y=
X-Google-Smtp-Source: ABdhPJxBdV/7CVMo1Zn5NbsCQiLWZCsGivSfPlaBI778A1CcMsm+ebEeVO5/f4aba/ZCh/dKtcm97A==
X-Received: by 2002:adf:a507:: with SMTP id i7mr34373566wrb.0.1593694686715;
        Thu, 02 Jul 2020 05:58:06 -0700 (PDT)
Received: from localhost.localdomain ([141.226.183.23])
        by smtp.gmail.com with ESMTPSA id g16sm11847335wrh.91.2020.07.02.05.58.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2020 05:58:06 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v4 09/10] fanotify: report parent fid + name + child fid
Date:   Thu,  2 Jul 2020 15:57:43 +0300
Message-Id: <20200702125744.10535-10-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200702125744.10535-1-amir73il@gmail.com>
References: <20200702125744.10535-1-amir73il@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

For a group with fanotify_init() flag FAN_REPORT_DFID_NAME, the parent
fid and name are reported for events on non-directory objects with an
info record of type FAN_EVENT_INFO_TYPE_DFID_NAME.

If the group also has the init flag FAN_REPORT_FID, the child fid
is also reported with another info record that follows the first info
record. The second info record is the same info record that would have
been reported to a group with only FAN_REPORT_FID flag.

When the child fid needs to be recorded, the variable size struct
fanotify_name_event is preallocated with enough space to store the
child fh between the dir fh and the name.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/notify/fanotify/fanotify.c      | 33 ++++++++++++++++++++++++++++--
 fs/notify/fanotify/fanotify.h      |  2 ++
 fs/notify/fanotify/fanotify_user.c |  3 ++-
 3 files changed, 35 insertions(+), 3 deletions(-)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index b22ab6630eba..3e8e20c19d97 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -64,6 +64,16 @@ static bool fanotify_name_event_equal(struct fanotify_name_event *fne1,
 	    !fanotify_fh_equal(dfh1, dfh2))
 		return false;
 
+	/*
+	 * There could be a child fid before the name.
+	 * If only one dfh had a blob, we would have failed the name_offset
+	 * comparison above.
+	 */
+	if (fanotify_fh_blob_len(dfh1) &&
+	    memcmp(fanotify_fh_blob(dfh1), fanotify_fh_blob(dfh2),
+		   fanotify_fh_blob_len(dfh1)))
+		return false;
+
 	return !memcmp(fanotify_fh_name(dfh1), fanotify_fh_name(dfh2),
 		       dfh1->name_len);
 }
@@ -454,13 +464,19 @@ struct fanotify_event *fanotify_alloc_fid_event(struct inode *id,
 struct fanotify_event *fanotify_alloc_name_event(struct inode *id,
 						 __kernel_fsid_t *fsid,
 						 const struct qstr *file_name,
-						 gfp_t gfp)
+						 struct inode *child, gfp_t gfp)
 {
 	struct fanotify_name_event *fne;
 	struct fanotify_fh *dfh;
 	unsigned int prealloc_fh_len = fanotify_encode_fh_len(id);
+	unsigned int child_fh_len = fanotify_encode_fh_len(child);
 	unsigned int size;
 
+	if (WARN_ON_ONCE(prealloc_fh_len % FANOTIFY_FH_HDR_LEN))
+		child_fh_len = 0;
+	else if (child_fh_len)
+		prealloc_fh_len += FANOTIFY_FH_HDR_LEN + child_fh_len;
+
 	size = sizeof(*fne) - FANOTIFY_INLINE_FH_LEN + prealloc_fh_len;
 	if (file_name)
 		size += file_name->len + 1;
@@ -472,6 +488,8 @@ struct fanotify_event *fanotify_alloc_name_event(struct inode *id,
 	fne->fsid = *fsid;
 	dfh = &fne->dir_fh;
 	fanotify_encode_fh(dfh, id, prealloc_fh_len, 0);
+	if (child_fh_len)
+		fanotify_encode_fh(fanotify_fh_blob(dfh), child, child_fh_len, 0);
 	if (file_name)
 		fanotify_fh_copy_name(dfh, file_name);
 
@@ -493,9 +511,19 @@ static struct fanotify_event *fanotify_alloc_event(struct fsnotify_group *group,
 	struct inode *id = fanotify_fid_inode(mask, data, data_type, dir);
 	const struct path *path = fsnotify_data_path(data, data_type);
 	unsigned int fid_mode = FAN_GROUP_FLAG(group, FANOTIFY_FID_BITS);
+	struct inode *child = NULL;
 	bool name_event = false;
 
 	if ((fid_mode & FAN_REPORT_DIR_FID) && dir) {
+		/*
+		 * With both flags FAN_REPORT_DIR_FID and FAN_REPORT_FID, we
+		 * report the child fid for events reported on a non-dir child
+		 * in addition to reporting the parent fid and child name.
+		 */
+		if ((fid_mode & FAN_REPORT_FID) &&
+		    (mask & FAN_EVENT_ON_CHILD) && !(mask & FAN_ONDIR))
+			child = id;
+
 		id = fanotify_dfid_inode(mask, data, data_type, dir);
 
 		/*
@@ -531,7 +559,8 @@ static struct fanotify_event *fanotify_alloc_event(struct fsnotify_group *group,
 	if (fanotify_is_perm_event(mask)) {
 		event = fanotify_alloc_perm_event(path, gfp);
 	} else if (name_event && file_name) {
-		event = fanotify_alloc_name_event(id, fsid, file_name, gfp);
+		event = fanotify_alloc_name_event(id, fsid, file_name, child,
+						  gfp);
 	} else if (fid_mode) {
 		event = fanotify_alloc_fid_event(id, fsid, gfp);
 	} else {
diff --git a/fs/notify/fanotify/fanotify.h b/fs/notify/fanotify/fanotify.h
index 7cbdac4be42f..f1aaa9fa5ca8 100644
--- a/fs/notify/fanotify/fanotify.h
+++ b/fs/notify/fanotify/fanotify.h
@@ -171,6 +171,8 @@ static inline struct fanotify_fh *fanotify_event_object_fh(
 {
 	if (event->type == FANOTIFY_EVENT_TYPE_FID)
 		return &FANOTIFY_FE(event)->object_fh;
+	else if (event->type == FANOTIFY_EVENT_TYPE_FID_NAME)
+		return fanotify_fh_blob(&FANOTIFY_NE(event)->dir_fh);
 	else
 		return NULL;
 }
diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index 27116cfead66..577ad74f71ec 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -949,14 +949,15 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flags, unsigned int, event_f_flags)
 		return -EINVAL;
 
 	/*
-	 * Reporting either object fid or dir fid.
 	 * Child name is reported with parent fid so requires dir fid.
+	 * If reporting child name, we can report both child fid and dir fid.
 	 */
 	switch (fid_mode) {
 	case 0:
 	case FAN_REPORT_FID:
 	case FAN_REPORT_DIR_FID:
 	case FAN_REPORT_DFID_NAME:
+	case FAN_REPORT_DFID_NAME | FAN_REPORT_FID:
 		break;
 	default:
 		return -EINVAL;
-- 
2.17.1

