Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B34D2185B4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jul 2020 13:12:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728770AbgGHLMU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Jul 2020 07:12:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728713AbgGHLMT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Jul 2020 07:12:19 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A28F1C08C5DC
        for <linux-fsdevel@vger.kernel.org>; Wed,  8 Jul 2020 04:12:18 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id r12so48404195wrj.13
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 Jul 2020 04:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=l/AE762kcZ5+fefPuuyQiLmzvis/P6HnGtNK2oQ0l8U=;
        b=CJlOsYR84u7tMj2e63uxelaeM4QqspEp21KoJCeQzpWHngqHW69x2/qz6GpeEJKdyW
         CfyCWTKXVLptWcVXZfvWdoZshzh2NAvVBISgkiLqnPGE32ywGD+vtDUhBl5gH34udAek
         mbWxE+WsVBxok4beN8Fj+woN02a4IYqF0W0x1fHD8z1DbiQPxANO0LHdbr/6AGIcHXxI
         U9dac2pdWtJSPI3dGqEPbTap6uPb8MyGJME9UkQ8NnO6rbyplv5qmMF/HU6sU8vc3Mop
         MtA+2k/espqFpLC1NXlnONnsSuC+tl2j57LCU50WG7bzzNGFxOfkF7uuHMwsFlO75Wl4
         8RDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=l/AE762kcZ5+fefPuuyQiLmzvis/P6HnGtNK2oQ0l8U=;
        b=Hqf/tT+z6+1eQCyiv7pU8XyVG8HQsoA8RLvj8EQGvJ8GlRnohuzbXwWqxyn1J9HsZr
         ErhCEkvFi2kz57BxMalTECKnxu0ugSUwLPHCdbC5NF7yFw8xDda4CjvFWoDK0nGbUN7+
         RYXFLp54aUvWEyCmLglFXhvGYiu+syOpUIoYweozJkcp1oCHTrB864sByEtFiQq5Znsi
         vWs89lANcZaYL/TY/jpAOf6kyPwvDo9kQ22qWbmSJtX7mtS+DCiYv3kcRTRFQZoz5gUE
         SiIUcTp+xcFnOjiQrirzxvjl5RYBym2c/vAW0LdQHvPyFVleJoHC9+hh8665hkgK9+or
         IFyA==
X-Gm-Message-State: AOAM533SsF/97udnC2kiYtEHmWlKr+PaRW0HskLJHY3FrBiKQbrsgzSS
        BUQ93hqj5s9nX0cUrxdwGJFyv8lK
X-Google-Smtp-Source: ABdhPJyaYCL9P5qL948KUvSppIyG5/Z2m6jkvGAiwpmG+cMuwbDi9wcpj3md41sGN35SxkwF8DKiNA==
X-Received: by 2002:a5d:6990:: with SMTP id g16mr49139732wru.131.1594206737429;
        Wed, 08 Jul 2020 04:12:17 -0700 (PDT)
Received: from localhost.localdomain ([141.226.183.23])
        by smtp.gmail.com with ESMTPSA id k126sm5980834wme.17.2020.07.08.04.12.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 04:12:16 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 08/20] fanotify: break up fanotify_alloc_event()
Date:   Wed,  8 Jul 2020 14:11:43 +0300
Message-Id: <20200708111156.24659-8-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200708111156.24659-1-amir73il@gmail.com>
References: <20200708111156.24659-1-amir73il@gmail.com>
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

