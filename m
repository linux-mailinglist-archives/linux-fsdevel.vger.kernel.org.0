Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 656F21C5D4C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 May 2020 18:20:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730159AbgEEQU0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 May 2020 12:20:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730038AbgEEQUZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 May 2020 12:20:25 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A09ACC061A10
        for <linux-fsdevel@vger.kernel.org>; Tue,  5 May 2020 09:20:25 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id i10so3437028wrv.10
        for <linux-fsdevel@vger.kernel.org>; Tue, 05 May 2020 09:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xy9jUkHXrFfGeZ2UC9pdb1nAElg/MaivsUkcZH3nGAA=;
        b=ZyWQqhz0YBtSvRHaahVsWQlIYCo5l5bHP12PJP+XphLYXMes61KKPXmmaxtS4f0BJv
         WLD3/LReEO7KS8Tw5gMyuT6tyL5XXsIqciK9yxvT58Hjb75TcM8Tkp20szCAngGSSekH
         EFkQHu7JXaQ8iQ3hXwtpIirOpX94/jJN9hU8WJpisWGRYMEYzdNY3NPhDcJA4p8Q3dvw
         07Rx9eC06iHZ96oWKUlMNo4h+cNQViT5jjonUyclQ6WPAqKkYwh3FBcGgiE9GTkaSHo0
         9yfvGirgc09ltwMp9v/TXS9Kj1MVCLsukSFDz6qQWj2T+TlkmyBh9237H5EmaK522X99
         9fXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xy9jUkHXrFfGeZ2UC9pdb1nAElg/MaivsUkcZH3nGAA=;
        b=TX66P9prTSbyhgajsr6c3HbREJYgLRdiyAs8HSo/U6qiVX2SesH7CquG0ugVCqd6pJ
         /W/SamssMlQ4kgO49lfuNK9zUHV2yPFAa1w4gUjV5X4A1DhJwb1EwsT5Gz+jOC9FgVLL
         mx+ni+/9kTsuY/TdKtVoBLx1qtP//EN6K1uNsRU/q927NtxheXKmRsTNSnNbEj3UOggB
         Qpg5Rr2lLOVFkoSvX+bMdkQ9Y4TWrzDQc/w2QnN/bGGu2sp52WHXGb9sGipvbKX8JUYu
         enihvQeRGxUf2QIsIgkth40lv0LJAc+6j94FkoR5Kko7qiwaulwrNSAJDsVVEVEiNZ2L
         pJ8Q==
X-Gm-Message-State: AGi0Pua+rUnXFleKfPQ9kKp7az9BkiJrGNiCafm9ZKWKkkumQk41VZqX
        8q411lF/0fzkTgRV/vXSXY6yK++N
X-Google-Smtp-Source: APiQypJp6/PAcQoGOi4GBb9szHV+Ef+QTSLPwUy/CUf0h1b52MkVJbmsLluIaSb/D7Dxmo/h4hiDJA==
X-Received: by 2002:adf:f1c5:: with SMTP id z5mr4571582wro.100.1588695624364;
        Tue, 05 May 2020 09:20:24 -0700 (PDT)
Received: from localhost.localdomain ([141.226.12.123])
        by smtp.gmail.com with ESMTPSA id c128sm1612871wma.42.2020.05.05.09.20.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2020 09:20:23 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 2/7] fanotify: break up fanotify_alloc_event()
Date:   Tue,  5 May 2020 19:20:09 +0300
Message-Id: <20200505162014.10352-3-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200505162014.10352-1-amir73il@gmail.com>
References: <20200505162014.10352-1-amir73il@gmail.com>
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
index ce4677077118..f5c21949fdaa 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -341,6 +341,77 @@ static struct inode *fanotify_fid_inode(struct inode *to_tell, u32 event_mask,
 	return (struct inode *)fsnotify_data_inode(data, data_type);
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
@@ -348,8 +419,6 @@ static struct fanotify_event *fanotify_alloc_event(struct fsnotify_group *group,
 						__kernel_fsid_t *fsid)
 {
 	struct fanotify_event *event = NULL;
-	struct fanotify_fid_event *ffe = NULL;
-	struct fanotify_name_event *fne = NULL;
 	gfp_t gfp = GFP_KERNEL_ACCOUNT;
 	struct inode *id = fanotify_fid_inode(inode, mask, data, data_type);
 	const struct path *path = fsnotify_data_path(data, data_type);
@@ -369,55 +438,23 @@ static struct fanotify_event *fanotify_alloc_event(struct fsnotify_group *group,
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
@@ -429,19 +466,6 @@ static struct fanotify_event *fanotify_alloc_event(struct fsnotify_group *group,
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

