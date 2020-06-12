Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 893DD1F760D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jun 2020 11:34:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726521AbgFLJeR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Jun 2020 05:34:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726451AbgFLJeN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Jun 2020 05:34:13 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2192FC08C5C1
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Jun 2020 02:34:13 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id q19so9421953eja.7
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Jun 2020 02:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=l/AE762kcZ5+fefPuuyQiLmzvis/P6HnGtNK2oQ0l8U=;
        b=IndJg/m+puS0yeD7uL7rGD3OfARsFUs6an3ce27kYWo/tryTUqTpd4qL0dPPLZ3/qX
         LhYc0wAslO+9JlwRdghDw2P/Mg1phHtOk3Y2kgQQcENPC0br5MwHHdyIB+ydFySKXXde
         gsNNzQKEETaeMuchW8x+A9G/oq5nERvrLqe6IK+FJubKjD2cfdRB0+TTINwlnTrT2wOg
         doxVUxL5JyzIllHbx3KKuxV3x7QQa4zGAscqBnA1moCFBsizTQ8nSbJN813C9kyQPlRQ
         EsaQCi+FQzWcFc+UqWZznTVkICs9qI3ViAneNN3g2g1ak6n5fCeoWTuHzvgyxijzlMZJ
         Iqvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=l/AE762kcZ5+fefPuuyQiLmzvis/P6HnGtNK2oQ0l8U=;
        b=GV5fNcLwdNehEgMSgStwqb9f7NIH7r1J7DgawmehjOo+mFcVH7OreA7vUweVyoYPgg
         9AKvKR7DdqTLFwkRyzQMJJ2YKfe3uJNMF8cglyxGLBMSVV/xeeMnVn5MwmIF6mQOfuOs
         4VeUUMYy0G0U0BPZgArjGn24Ts9vFfZIVSIt+98T0FiXGGEVi4l8uteXB9Jned+s1KJI
         55bOzsXMgqgofce3yXSsKGCA2PpAowP5oL1HebJIoO95glb0XQNzyDG3iPeYYvkOlWwK
         yRNRWfxNaLpbprXosKnpN7PDjP7g/RXbvBLZwn00A4bKAJJ9nwVG1v0hULi6m9u3gycl
         sCng==
X-Gm-Message-State: AOAM530st5k/lA9gxdblBEsH0Dn9+LV4Dxe59mj0bVjHsMqcExUwWUm2
        lexEzpLjMRGckdfljAeEIjQISDU1
X-Google-Smtp-Source: ABdhPJzQm5cbIEz/EWfh87a3h4U3uiD39uQMTo3Jj5/7PiHLdGyXG4XcbdP9PnccxAScvdl44NUs/w==
X-Received: by 2002:a17:906:68ca:: with SMTP id y10mr12196916ejr.322.1591954451789;
        Fri, 12 Jun 2020 02:34:11 -0700 (PDT)
Received: from localhost.localdomain ([5.102.204.95])
        by smtp.gmail.com with ESMTPSA id l2sm2876578edq.9.2020.06.12.02.34.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2020 02:34:11 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH 08/20] fanotify: break up fanotify_alloc_event()
Date:   Fri, 12 Jun 2020 12:33:31 +0300
Message-Id: <20200612093343.5669-9-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200612093343.5669-1-amir73il@gmail.com>
References: <20200612093343.5669-1-amir73il@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Break up fanotify_alloc_event() into helpers by event struct type.

Suggested-by: Jan Kara <jack@suse.cz>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/notify/fanotify/fanotify.c | 146 ++++++++++++++++++++--------------
 1 file changed, 85 insertions(+), 61 deletions(-)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index 921ff05e1877..c4ada3501014 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -344,6 +344,77 @@ static struct inode *fanotify_fid_inode(struct inode *to_tell, u32 event_mask,
 	return fsnotify_data_inode(data, data_type);
 }
 
+struct fanotify_event *fanotify_alloc_path_event(const struct path *path,
+						 gfp_t gfp)
+{
+	struct fanotify_path_event *pevent;
+
+	pevent = kmem_cache_alloc(fanotify_path_event_cachep, gfp);
+	if (!pevent)
+		return NULL;
+
+	pevent->fae.type = FANOTIFY_EVENT_TYPE_PATH;
+	pevent->path = *path;
+	path_get(path);
+
+	return &pevent->fae;
+}
+
+struct fanotify_event *fanotify_alloc_perm_event(const struct path *path,
+						 gfp_t gfp)
+{
+	struct fanotify_perm_event *pevent;
+
+	pevent = kmem_cache_alloc(fanotify_perm_event_cachep, gfp);
+	if (!pevent)
+		return NULL;
+
+	pevent->fae.type = FANOTIFY_EVENT_TYPE_PATH_PERM;
+	pevent->response = 0;
+	pevent->state = FAN_EVENT_INIT;
+	pevent->path = *path;
+	path_get(path);
+
+	return &pevent->fae;
+}
+
+struct fanotify_event *fanotify_alloc_fid_event(struct inode *id,
+						__kernel_fsid_t *fsid,
+						gfp_t gfp)
+{
+	struct fanotify_fid_event *ffe;
+
+	ffe = kmem_cache_alloc(fanotify_fid_event_cachep, gfp);
+	if (!ffe)
+		return NULL;
+
+	ffe->fae.type = FANOTIFY_EVENT_TYPE_FID;
+	ffe->fsid = *fsid;
+	fanotify_encode_fh(&ffe->object_fh, id, gfp);
+
+	return &ffe->fae;
+}
+
+struct fanotify_event *fanotify_alloc_name_event(struct inode *id,
+						 __kernel_fsid_t *fsid,
+						 const struct qstr *file_name,
+						 gfp_t gfp)
+{
+	struct fanotify_name_event *fne;
+
+	fne = kmalloc(sizeof(*fne) + file_name->len + 1, gfp);
+	if (!fne)
+		return NULL;
+
+	fne->fae.type = FANOTIFY_EVENT_TYPE_FID_NAME;
+	fne->fsid = *fsid;
+	fanotify_encode_fh(&fne->dir_fh, id, gfp);
+	fne->name_len = file_name->len;
+	strcpy(fne->name, file_name->name);
+
+	return &fne->fae;
+}
+
 static struct fanotify_event *fanotify_alloc_event(struct fsnotify_group *group,
 						struct inode *inode, u32 mask,
 						const void *data, int data_type,
@@ -351,8 +422,6 @@ static struct fanotify_event *fanotify_alloc_event(struct fsnotify_group *group,
 						__kernel_fsid_t *fsid)
 {
 	struct fanotify_event *event = NULL;
-	struct fanotify_fid_event *ffe = NULL;
-	struct fanotify_name_event *fne = NULL;
 	gfp_t gfp = GFP_KERNEL_ACCOUNT;
 	struct inode *id = fanotify_fid_inode(inode, mask, data, data_type);
 	const struct path *path = fsnotify_data_path(data, data_type);
@@ -372,55 +441,23 @@ static struct fanotify_event *fanotify_alloc_event(struct fsnotify_group *group,
 	memalloc_use_memcg(group->memcg);
 
 	if (fanotify_is_perm_event(mask)) {
-		struct fanotify_perm_event *pevent;
-
-		pevent = kmem_cache_alloc(fanotify_perm_event_cachep, gfp);
-		if (!pevent)
-			goto out;
-
-		event = &pevent->fae;
-		event->type = FANOTIFY_EVENT_TYPE_PATH_PERM;
-		pevent->response = 0;
-		pevent->state = FAN_EVENT_INIT;
-		goto init;
-	}
-
-	/*
-	 * For FAN_DIR_MODIFY event, we report the fid of the directory and
-	 * the name of the modified entry.
-	 * Allocate an fanotify_name_event struct and copy the name.
-	 */
-	if (mask & FAN_DIR_MODIFY && !(WARN_ON_ONCE(!file_name))) {
-		fne = kmalloc(sizeof(*fne) + file_name->len + 1, gfp);
-		if (!fne)
-			goto out;
-
-		event = &fne->fae;
-		event->type = FANOTIFY_EVENT_TYPE_FID_NAME;
-		fne->name_len = file_name->len;
-		strcpy(fne->name, file_name->name);
-		goto init;
-	}
-
-	if (FAN_GROUP_FLAG(group, FAN_REPORT_FID)) {
-		ffe = kmem_cache_alloc(fanotify_fid_event_cachep, gfp);
-		if (!ffe)
-			goto out;
-
-		event = &ffe->fae;
-		event->type = FANOTIFY_EVENT_TYPE_FID;
+		event = fanotify_alloc_perm_event(path, gfp);
+	} else if (mask & FAN_DIR_MODIFY && !(WARN_ON_ONCE(!file_name))) {
+		/*
+		 * For FAN_DIR_MODIFY event, we report the fid of the directory
+		 * and the name of the modified entry.
+		 * Allocate an fanotify_name_event struct and copy the name.
+		 */
+		event = fanotify_alloc_name_event(id, fsid, file_name, gfp);
+	} else if (FAN_GROUP_FLAG(group, FAN_REPORT_FID)) {
+		event = fanotify_alloc_fid_event(id, fsid, gfp);
 	} else {
-		struct fanotify_path_event *pevent;
-
-		pevent = kmem_cache_alloc(fanotify_path_event_cachep, gfp);
-		if (!pevent)
-			goto out;
-
-		event = &pevent->fae;
-		event->type = FANOTIFY_EVENT_TYPE_PATH;
+		event = fanotify_alloc_path_event(path, gfp);
 	}
 
-init:
+	if (!event)
+		goto out;
+
 	/*
 	 * Use the victim inode instead of the watching inode as the id for
 	 * event queue, so event reported on parent is merged with event
@@ -432,19 +469,6 @@ static struct fanotify_event *fanotify_alloc_event(struct fsnotify_group *group,
 	else
 		event->pid = get_pid(task_tgid(current));
 
-	if (fsid && fanotify_event_fsid(event))
-		*fanotify_event_fsid(event) = *fsid;
-
-	if (fanotify_event_object_fh(event))
-		fanotify_encode_fh(fanotify_event_object_fh(event), id, gfp);
-
-	if (fanotify_event_dir_fh(event))
-		fanotify_encode_fh(fanotify_event_dir_fh(event), id, gfp);
-
-	if (fanotify_event_has_path(event)) {
-		*fanotify_event_path(event) = *path;
-		path_get(path);
-	}
 out:
 	memalloc_unuse_memcg();
 	return event;
-- 
2.17.1

