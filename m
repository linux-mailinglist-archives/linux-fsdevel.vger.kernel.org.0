Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0516C1612F9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2020 14:16:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729180AbgBQNP2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Feb 2020 08:15:28 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40273 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729151AbgBQNPY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Feb 2020 08:15:24 -0500
Received: by mail-wm1-f67.google.com with SMTP id t14so18415650wmi.5
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Feb 2020 05:15:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=i8Cgn1/XkKY0izl8w6EPwd7OUxtAip/yA9F16G0Snms=;
        b=MwxnCj6ov0B+ItjCj9LoBUfNQInd5VAKCrIXJFsGa/bWJ+eMGEcc1FkNZz7sPG/YUG
         SdJA8AL5CWQiCLU5N2ln/fL2VNZ+kqYJ6Wj+eSI0Hx1l1xy0R3hqZXAbigDnepf4QC5a
         3NCWfqsOvSX8WVtaMyD+oQQLSyewvD1ELNZ1AsIZ6vLnGepHGFsyUTBbPqNJeXHOGgLh
         mF5wEt+6l6vkLaejSENiXM8AwB0XrF9quLtAGrhZHU2acX1r00sim0KA3s1TV3CRmQyP
         MaN9DEQScGxB0WKWEOImlxhh8YLJQKRFg8g652CzMLPChU25GV/ibXPn+tP0913PL0Hi
         BB1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=i8Cgn1/XkKY0izl8w6EPwd7OUxtAip/yA9F16G0Snms=;
        b=Xeqad0wNflYCT3iBM35D1vILjoavwM5SS87tUhjs16MZ5LYmOXMsCxfxykqEAHQT12
         LFFyoCcrmqVssdfjzXBkcv8bnus8FmrRW6GnXyTU0flO6gGQ7RJoYNb3rid+xfKVJTqn
         9tF5tz1G7cbaCOCtFtsH8X9VsTcacjxAmUNfyBXWuRonDWhJNqOo2Uzl8OAXoP+Hhg6+
         jGl3VJvgYUnyIx/8Ojwepjxwm7FhriusnRwniT1wcH98ZYsB0RpuCWgt2CN9YLO7/rYZ
         ykQvjZ6C+iy0CEihXz7LgomPO0dFnPqgjEjWNU0f8CsyhsUIVAy1mbJgAAFHphoCSaLj
         P4LA==
X-Gm-Message-State: APjAAAV5hTObC2oq8R5enDT1EssxtRAjs8d7N+WFKIv8C0gEOn0Bwt2Z
        K1QPDyNYcE7hWNEa9id//bA=
X-Google-Smtp-Source: APXvYqwdnHN4yETib+bLsqpqApD+4TEn0S3O99IeQMRhSbqjfN4A6SRPAnCeauGkuvv4XZ0D2KcTBA==
X-Received: by 2002:a7b:cb46:: with SMTP id v6mr23605791wmj.117.1581945322107;
        Mon, 17 Feb 2020 05:15:22 -0800 (PST)
Received: from amir-ThinkPad-T480.ctera.local (bzq-166-168-31-246.red.bezeqint.net. [31.168.166.246])
        by smtp.gmail.com with ESMTPSA id m21sm545745wmi.27.2020.02.17.05.15.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2020 05:15:21 -0800 (PST)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 12/16] fanotify: record name info for FAN_DIR_MODIFY event
Date:   Mon, 17 Feb 2020 15:14:51 +0200
Message-Id: <20200217131455.31107-13-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200217131455.31107-1-amir73il@gmail.com>
References: <20200217131455.31107-1-amir73il@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

For FAN_DIR_MODIFY event, allocate a larger event struct to store the
dir entry name along side the directory fid.

We are going to add support for reporting parent fid, name and child fid
for events reported on children.  FAN_DIR_MODIFY event does not record
nor report the child fid, but in order to stay consistent with events
"on child", we store the directory fid in struct fanotify_name_event and
not in the base struct fanotify_event as we do for other event types.

This wastes a few unused bytes (16) of memory per FAN_DIR_MODIFY event,
but keeps the code simpler and avoids creating a custom kmem_cache pool
just for FAN_DIR_MODIFY events.

At this point, name info reporting is not yet implemented, so trying to
set FAN_DIR_MODIFY in mark mask will return -EINVAL.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/notify/fanotify/fanotify.c      | 87 +++++++++++++++++++++++++++---
 fs/notify/fanotify/fanotify.h      | 65 +++++++++++++++++++++-
 fs/notify/fanotify/fanotify_user.c |  5 +-
 3 files changed, 149 insertions(+), 8 deletions(-)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index 3bc28f08aad1..fc75dc53a218 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -33,7 +33,22 @@ static bool should_merge(struct fsnotify_event *old_fsn,
 	if (fanotify_event_has_path(old)) {
 		return old->path.mnt == new->path.mnt &&
 			old->path.dentry == new->path.dentry;
-	} else if (fanotify_event_has_fid(old)) {
+	}
+
+	if (!fanotify_fsid_equal(&old->fsid, &new->fsid))
+		return false;
+
+	if (fanotify_event_has_dfid_name(old)) {
+		if (!fanotify_dfid_name_equal(FANOTIFY_NE(old_fsn),
+					      FANOTIFY_NE(new_fsn)))
+			return false;
+
+		/* FAN_DIR_MODIFY does not encode the "child" fid */
+		if (!fanotify_event_has_fid(old))
+			return true;
+	}
+
+	if (fanotify_event_has_fid(old)) {
 		/*
 		 * We want to merge many dirent events in the same dir (i.e.
 		 * creates/unlinks/renames), but we do not want to merge dirent
@@ -43,7 +58,6 @@ static bool should_merge(struct fsnotify_event *old_fsn,
 		 * unlink pair or rmdir+create pair of events.
 		 */
 		return (old->mask & FS_ISDIR) == (new->mask & FS_ISDIR) &&
-			fanotify_fsid_equal(&old->fsid, &new->fsid) &&
 			fanotify_fid_equal(&old->fid, &new->fid, old->fh.len);
 	}
 
@@ -279,13 +293,16 @@ static struct inode *fanotify_fid_inode(struct inode *to_tell, u32 event_mask,
 struct fanotify_event *fanotify_alloc_event(struct fsnotify_group *group,
 					    struct inode *inode, u32 mask,
 					    const void *data, int data_type,
+					    const struct qstr *file_name,
 					    __kernel_fsid_t *fsid)
 {
 	struct fanotify_event *event = NULL;
+	struct fanotify_name_event *fne = NULL;
 	gfp_t gfp = GFP_KERNEL_ACCOUNT;
 	struct inode *id = fanotify_fid_inode(inode, mask, data, data_type);
 	const struct path *path = fsnotify_data_path(data, data_type);
 	struct dentry *dentry = fsnotify_data_dentry(data, data_type);
+	struct inode *dir = NULL;
 
 	/*
 	 * For queues with unlimited length lost events are not expected and
@@ -310,12 +327,56 @@ struct fanotify_event *fanotify_alloc_event(struct fsnotify_group *group,
 		event = &pevent->fae;
 		pevent->response = 0;
 		pevent->state = FAN_EVENT_INIT;
+		/*
+		 * Make sure that fanotify_event_has_fid() and
+		 * fanotify_event_has_name() are false for permission events.
+		 */
+		id = NULL;
+		event->dfh.type = FILEID_ROOT;
+		goto init;
+	}
+
+	/*
+	 * For FAN_DIR_MODIFY event, we report the fid of the directory and
+	 * the name of the modified entry.
+	 * Allocate an fanotify_name_event struct and copy the name.
+	 */
+	if (mask & FAN_DIR_MODIFY && !(WARN_ON_ONCE(!file_name))) {
+		char *name = NULL;
+
+		/*
+		 * Make sure that fanotify_event_has_name() is true and that
+		 * fanotify_event_has_fid() is false for FAN_DIR_MODIFY events.
+		 */
+		id = NULL;
+		dir = inode;
+		if (file_name->len + 1 > FANOTIFY_INLINE_NAME_LEN) {
+			name = kmalloc(file_name->len + 1, gfp);
+			if (!name)
+				goto out;
+		}
+
+		fne = kmem_cache_alloc(fanotify_name_event_cachep, gfp);
+		if (!fne)
+			goto out;
+
+		event = &fne->fae;
+		if (!name)
+			name = fne->inline_name;
+		strcpy(name, file_name->name);
+		fne->name.name = name;
+		fne->name.len = file_name->len;
+		event->fh.type = FILEID_INVALID;
+		event->dfh.type = FILEID_INVALID;
 		goto init;
 	}
+
 	event = kmem_cache_alloc(fanotify_event_cachep, gfp);
 	if (!event)
 		goto out;
-init: __maybe_unused
+
+	event->dfh.type = FILEID_ROOT;
+init:
 	/*
 	 * Use the dentry instead of inode as tag for event queue, so event
 	 * reported on parent is merged with event reported on child when both
@@ -328,11 +389,16 @@ init: __maybe_unused
 	else
 		event->pid = get_pid(task_tgid(current));
 	event->fh.len = 0;
+	event->dfh.len = 0;
 	if (fsid)
 		event->fsid = *fsid;
-	if (id && FAN_GROUP_FLAG(group, FAN_REPORT_FID)) {
+	if (FAN_GROUP_FLAG(group, FAN_REPORT_FID)) {
 		/* Report the event without a file identifier on encode error */
-		event->fh_type = fanotify_encode_fid(event, id, gfp, fsid);
+		if (id)
+			event->fh = fanotify_encode_fid(&event->fid, id, gfp);
+		/* The reported name is relative to 'dir' */
+		if (fne)
+			event->dfh = fanotify_encode_fid(&fne->dfid, dir, gfp);
 	} else if (path) {
 		event->fh.type = FILEID_ROOT;
 		event->path = *path;
@@ -439,7 +505,7 @@ static int fanotify_handle_event(struct fsnotify_group *group,
 	}
 
 	event = fanotify_alloc_event(group, inode, mask, data, data_type,
-				     &fsid);
+				     file_name, &fsid);
 	ret = -ENOMEM;
 	if (unlikely(!event)) {
 		/*
@@ -494,6 +560,15 @@ static void fanotify_free_event(struct fsnotify_event *fsn_event)
 		kmem_cache_free(fanotify_perm_event_cachep,
 				FANOTIFY_PE(fsn_event));
 		return;
+	} else if (fanotify_event_has_dfid_name(event)) {
+		struct fanotify_name_event *fne = FANOTIFY_NE(fsn_event);
+
+		if (fanotify_fid_has_ext_fh(&event->dfh))
+			kfree(fne->dfid.ext_fh);
+		if (fanotify_event_has_ext_name(fne))
+			kfree(fne->name.name);
+		kmem_cache_free(fanotify_name_event_cachep, fne);
+		return;
 	}
 	kmem_cache_free(fanotify_event_cachep, event);
 }
diff --git a/fs/notify/fanotify/fanotify.h b/fs/notify/fanotify/fanotify.h
index 4fee002235b6..e4a67a2d77b8 100644
--- a/fs/notify/fanotify/fanotify.h
+++ b/fs/notify/fanotify/fanotify.h
@@ -6,6 +6,7 @@
 
 extern struct kmem_cache *fanotify_mark_cache;
 extern struct kmem_cache *fanotify_event_cachep;
+extern struct kmem_cache *fanotify_name_event_cachep;
 extern struct kmem_cache *fanotify_perm_event_cachep;
 
 /* Possible states of the permission event */
@@ -84,9 +85,10 @@ struct fanotify_event {
 	 * on 64bit arch and to use fh.type as an indication of whether path
 	 * or fid are used in the union:
 	 * FILEID_ROOT (0) for path, > 0 for fid, FILEID_INVALID for neither.
+	 * Non zero dfh.type indicates embedded in an fanotify_name_event.
 	 */
 	struct fanotify_fid_hdr fh;
-	u16 pad;
+	struct fanotify_fid_hdr dfh;
 	__kernel_fsid_t fsid;
 	union {
 		/*
@@ -114,6 +116,66 @@ static inline bool fanotify_event_has_fid(struct fanotify_event *event)
 	return fanotify_fid_has_fh(&event->fh);
 }
 
+/*
+ * Structure for fanotify events with name info.
+ * DNAME_INLINE_LEN is good enough for dentry name, so it's good enough for us.
+ * It also happens to bring the size of this struct to 128 bytes on 64bit arch.
+ */
+#define FANOTIFY_INLINE_NAME_LEN DNAME_INLINE_LEN
+
+struct fanotify_name_event {
+	struct fanotify_event fae;
+	struct fanotify_fid  dfid;
+	struct qstr name;
+	unsigned char inline_name[FANOTIFY_INLINE_NAME_LEN];
+};
+
+static inline struct fanotify_name_event *
+FANOTIFY_NE(struct fsnotify_event *fse)
+{
+	return container_of(fse, struct fanotify_name_event, fae.fse);
+}
+
+static inline bool fanotify_event_has_dfid_name(struct fanotify_event *event)
+{
+	return event->dfh.type != FILEID_ROOT;
+}
+
+static inline unsigned int fanotify_event_name_len(struct fanotify_event *event)
+{
+	return event->dfh.type != FILEID_ROOT ?
+		FANOTIFY_NE(&event->fse)->name.len : 0;
+}
+
+static inline bool fanotify_event_has_ext_name(struct fanotify_name_event *fne)
+{
+	return fne->name.len + 1 > FANOTIFY_INLINE_NAME_LEN;
+}
+
+static inline bool fanotify_dfid_name_equal(struct fanotify_name_event *fne1,
+					    struct fanotify_name_event *fne2)
+{
+	struct qstr *name1 = &fne1->name;
+	struct qstr *name2 = &fne2->name;
+	struct fanotify_fid_hdr *dfh1 = &fne1->fae.dfh;
+	struct fanotify_fid_hdr *dfh2 = &fne2->fae.dfh;
+
+	if (dfh1->type != dfh2->type || dfh1->len != dfh2->len ||
+	    name1->len != name2->len)
+		return false;
+
+	/* Could be pointing to same external_name */
+	if (name1->len && name1->name != name2->name &&
+	    strcmp(name1->name, name2->name))
+		return false;
+
+	/* No dfid means that encoding failed */
+	if (!dfh1->len)
+		return true;
+
+	return fanotify_fid_equal(&fne1->dfid, &fne2->dfid, dfh1->len);
+}
+
 /*
  * Structure for permission fanotify events. It gets allocated and freed in
  * fanotify_handle_event() since we wait there for user response. When the
@@ -148,4 +210,5 @@ static inline struct fanotify_event *FANOTIFY_E(struct fsnotify_event *fse)
 struct fanotify_event *fanotify_alloc_event(struct fsnotify_group *group,
 					    struct inode *inode, u32 mask,
 					    const void *data, int data_type,
+					    const struct qstr *file_name,
 					    __kernel_fsid_t *fsid);
diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index beb9f0661a7c..284f3548bb79 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -47,6 +47,7 @@ extern const struct fsnotify_ops fanotify_fsnotify_ops;
 
 struct kmem_cache *fanotify_mark_cache __read_mostly;
 struct kmem_cache *fanotify_event_cachep __read_mostly;
+struct kmem_cache *fanotify_name_event_cachep __read_mostly;
 struct kmem_cache *fanotify_perm_event_cachep __read_mostly;
 
 #define FANOTIFY_EVENT_ALIGN 4
@@ -831,7 +832,7 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flags, unsigned int, event_f_flags)
 	group->memcg = get_mem_cgroup_from_mm(current->mm);
 
 	oevent = fanotify_alloc_event(group, NULL, FS_Q_OVERFLOW, NULL,
-				      FSNOTIFY_EVENT_NONE, NULL);
+				      FSNOTIFY_EVENT_NONE, NULL, NULL);
 	if (unlikely(!oevent)) {
 		fd = -ENOMEM;
 		goto out_destroy_group;
@@ -1147,6 +1148,8 @@ static int __init fanotify_user_setup(void)
 	fanotify_mark_cache = KMEM_CACHE(fsnotify_mark,
 					 SLAB_PANIC|SLAB_ACCOUNT);
 	fanotify_event_cachep = KMEM_CACHE(fanotify_event, SLAB_PANIC);
+	fanotify_name_event_cachep = KMEM_CACHE(fanotify_name_event,
+						SLAB_PANIC);
 	if (IS_ENABLED(CONFIG_FANOTIFY_ACCESS_PERMISSIONS)) {
 		fanotify_perm_event_cachep =
 			KMEM_CACHE(fanotify_perm_event, SLAB_PANIC);
-- 
2.17.1

