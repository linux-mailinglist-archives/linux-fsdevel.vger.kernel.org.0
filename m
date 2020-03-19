Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5696718BAAD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Mar 2020 16:11:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727858AbgCSPLC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Mar 2020 11:11:02 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:47006 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727346AbgCSPLB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Mar 2020 11:11:01 -0400
Received: by mail-wr1-f66.google.com with SMTP id j17so48873wru.13
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Mar 2020 08:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CtHfAwfUEi7SnYcHveXEghZQlOsnr1jNNb/hFvoEbh0=;
        b=HOs3Ey06fjKdPDuoL2dj7SF6GZvfrOfConXGatZu0gUxi4amvdFAfebGCgQ9NnG5Yj
         ii8lReWLqk+KrxkuHvnDIEIyZIC9RhVy1tafJbnD1Zjql5o/LihpPlxGDG1btL9DGdr1
         d52TkwnOdVE7rAfAYAkYflVcywuH2Et5eGHgtwJBYNYGnEqpDuSO+67t2ZwFNLPW2nKy
         OqsNyyzZXj6siJVYq6cJwNzeLdElJXZJs28gnTHTYlXTWflGMSeopuSrATXfCNuvOgLu
         7LMDuY1h/GmWL/L2iaQjv5hQUQdniax+NsuL5lSs/qlHsBPPfbwt38XNV/uv6fFEvSsc
         llQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CtHfAwfUEi7SnYcHveXEghZQlOsnr1jNNb/hFvoEbh0=;
        b=LinGZG1CYl/9uibs/jTAhRQ9kMWqHe+SG/0Uxj6tVFqZznNgu23GC7IpoAHq/99lVk
         TMCT54ZRWt5hlNDNmaGVaw0MxdPhR0tg6SAbAu173nsEuQ7VuEEktF20AXAOId7CU0ML
         gYJ95dbHR5/hlaHCY99T6uR1XBdF4kI3MEaVWJpYdGh0e0po5eus8b/71DOj6OuqCvJL
         n32I2r++QBjQAx6OIOtTB9MQ7C8k47WFgzY0G5Sdzn06IhfrxJkRpCJ+41FtU2KDTZlm
         2p19CwuXxskoZe4SQ78nWNQWkUBsVv+TUnygrVm34udKyjVU0emuRPCA6eayAI12Cbx+
         LDQA==
X-Gm-Message-State: ANhLgQ0YZXLVI4ULs2ACMEUO04S2RBQIqsw5Pqv4Hx0COnxIjUF1n6d2
        F6eKtaAO1vAI1ThTHLXT9OI=
X-Google-Smtp-Source: ADFU+vtoJN5SOz98NJqfaijENWl26HxcF9pZ/8iHhxJ8ELrt2v54pdlzeUIPj7fTBYhA+q01LVCxXg==
X-Received: by 2002:a5d:56cd:: with SMTP id m13mr4757951wrw.236.1584630658863;
        Thu, 19 Mar 2020 08:10:58 -0700 (PDT)
Received: from localhost.localdomain ([141.226.9.174])
        by smtp.gmail.com with ESMTPSA id t193sm3716959wmt.14.2020.03.19.08.10.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2020 08:10:58 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 13/14] fanotify: record name info for FAN_DIR_MODIFY event
Date:   Thu, 19 Mar 2020 17:10:21 +0200
Message-Id: <20200319151022.31456-14-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200319151022.31456-1-amir73il@gmail.com>
References: <20200319151022.31456-1-amir73il@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

For FAN_DIR_MODIFY event, allocate a variable size event struct to store
the dir entry name along side the directory file handle.

At this point, name info reporting is not yet implemented, so trying to
set FAN_DIR_MODIFY in mark mask will return -EINVAL.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/notify/fanotify/fanotify.c      | 72 +++++++++++++++++++++++++++---
 fs/notify/fanotify/fanotify.h      | 30 ++++++++++++-
 fs/notify/fanotify/fanotify_user.c |  4 +-
 3 files changed, 96 insertions(+), 10 deletions(-)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index 75f288d5eeab..22e198ab2687 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -53,6 +53,23 @@ static bool fanotify_fid_event_equal(struct fanotify_fid_event *ffe1,
 		fanotify_fh_equal(&ffe1->object_fh, &ffe2->object_fh);
 }
 
+static bool fanotify_name_event_equal(struct fanotify_name_event *fne1,
+				      struct fanotify_name_event *fne2)
+{
+	/*
+	 * Do not merge name events without dir fh.
+	 * FAN_DIR_MODIFY does not encode object fh, so it may be empty.
+	 */
+	if (!fne1->dir_fh.len)
+		return false;
+
+	if (fne1->name_len != fne2->name_len ||
+	    !fanotify_fh_equal(&fne1->dir_fh, &fne2->dir_fh))
+		return false;
+
+	return !memcmp(fne1->name, fne2->name, fne1->name_len);
+}
+
 static bool should_merge(struct fsnotify_event *old_fsn,
 			 struct fsnotify_event *new_fsn)
 {
@@ -84,6 +101,9 @@ static bool should_merge(struct fsnotify_event *old_fsn,
 
 		return fanotify_fid_event_equal(FANOTIFY_FE(old),
 						FANOTIFY_FE(new));
+	case FANOTIFY_EVENT_TYPE_FID_NAME:
+		return fanotify_name_event_equal(FANOTIFY_NE(old),
+						 FANOTIFY_NE(new));
 	default:
 		WARN_ON_ONCE(1);
 	}
@@ -320,17 +340,21 @@ static struct inode *fanotify_fid_inode(struct inode *to_tell, u32 event_mask,
 struct fanotify_event *fanotify_alloc_event(struct fsnotify_group *group,
 					    struct inode *inode, u32 mask,
 					    const void *data, int data_type,
+					    const struct qstr *file_name,
 					    __kernel_fsid_t *fsid)
 {
 	struct fanotify_event *event = NULL;
 	struct fanotify_fid_event *ffe = NULL;
+	struct fanotify_name_event *fne = NULL;
 	gfp_t gfp = GFP_KERNEL_ACCOUNT;
 	struct inode *id = fanotify_fid_inode(inode, mask, data, data_type);
 	const struct path *path = fsnotify_data_path(data, data_type);
+	struct inode *dir = NULL;
 
 	/* Make sure we can easily cast between inherited structs */
 	BUILD_BUG_ON(offsetof(struct fanotify_event, fse) != 0);
 	BUILD_BUG_ON(offsetof(struct fanotify_fid_event, fae) != 0);
+	BUILD_BUG_ON(offsetof(struct fanotify_name_event, fae) != 0);
 	BUILD_BUG_ON(offsetof(struct fanotify_path_event, fae) != 0);
 	BUILD_BUG_ON(offsetof(struct fanotify_perm_event, fae) != 0);
 
@@ -362,6 +386,24 @@ struct fanotify_event *fanotify_alloc_event(struct fsnotify_group *group,
 		goto init;
 	}
 
+	/*
+	 * For FAN_DIR_MODIFY event, we report the fid of the directory and
+	 * the name of the modified entry.
+	 * Allocate an fanotify_name_event struct and copy the name.
+	 */
+	if (mask & FAN_DIR_MODIFY && !(WARN_ON_ONCE(!file_name))) {
+		dir = inode;
+		fne = kmalloc(sizeof(*fne) + file_name->len + 1, gfp);
+		if (!fne)
+			goto out;
+
+		event = &fne->fae;
+		event->type = FANOTIFY_EVENT_TYPE_FID_NAME;
+		fne->name_len = file_name->len;
+		strcpy(fne->name, file_name->name);
+		goto init;
+	}
+
 	if (FAN_GROUP_FLAG(group, FAN_REPORT_FID)) {
 		ffe = kmem_cache_alloc(fanotify_fid_event_cachep, gfp);
 		if (!ffe)
@@ -377,7 +419,7 @@ struct fanotify_event *fanotify_alloc_event(struct fsnotify_group *group,
 		event->type = FANOTIFY_EVENT_TYPE_PATH;
 	}
 
-init: __maybe_unused
+init:
 	/*
 	 * Use the victim inode instead of the watching inode as the id for
 	 * event queue, so event reported on parent is merged with event
@@ -390,11 +432,19 @@ init: __maybe_unused
 	else
 		event->pid = get_pid(task_tgid(current));
 	if (fanotify_event_has_fid(event)) {
-		ffe->object_fh.len = 0;
+		struct fanotify_fh *obj_fh = fanotify_event_object_fh(event);
+
 		if (fsid)
-			ffe->fsid = *fsid;
-		if (id)
-			fanotify_encode_fh(&ffe->object_fh, id, gfp);
+			*fanotify_event_fsid(event) = *fsid;
+		if (fne && dir) {
+			/* The reported name is relative to 'dir' */
+			fanotify_encode_fh(&fne->dir_fh, dir, gfp);
+		} else if (obj_fh) {
+			if (id)
+				fanotify_encode_fh(obj_fh, id, gfp);
+			else
+				obj_fh->len = 0;
+		}
 	} else if (fanotify_event_has_path(event)) {
 		struct path *p = fanotify_event_path(event);
 
@@ -503,7 +553,7 @@ static int fanotify_handle_event(struct fsnotify_group *group,
 	}
 
 	event = fanotify_alloc_event(group, inode, mask, data, data_type,
-				     &fsid);
+				     file_name, &fsid);
 	ret = -ENOMEM;
 	if (unlikely(!event)) {
 		/*
@@ -563,6 +613,13 @@ static void fanotify_free_fid_event(struct fanotify_fid_event *ffe)
 	kmem_cache_free(fanotify_fid_event_cachep, ffe);
 }
 
+static void fanotify_free_name_event(struct fanotify_name_event *fne)
+{
+	if (fanotify_fh_has_ext_buf(&fne->dir_fh))
+		kfree(fanotify_fh_ext_buf(&fne->dir_fh));
+	kfree(fne);
+}
+
 static void fanotify_free_event(struct fsnotify_event *fsn_event)
 {
 	struct fanotify_event *event;
@@ -579,6 +636,9 @@ static void fanotify_free_event(struct fsnotify_event *fsn_event)
 	case FANOTIFY_EVENT_TYPE_FID:
 		fanotify_free_fid_event(FANOTIFY_FE(event));
 		break;
+	case FANOTIFY_EVENT_TYPE_FID_NAME:
+		fanotify_free_name_event(FANOTIFY_NE(event));
+		break;
 	default:
 		WARN_ON_ONCE(1);
 	}
diff --git a/fs/notify/fanotify/fanotify.h b/fs/notify/fanotify/fanotify.h
index 1bc73a65d9d2..6648f01f900f 100644
--- a/fs/notify/fanotify/fanotify.h
+++ b/fs/notify/fanotify/fanotify.h
@@ -59,7 +59,8 @@ static inline void *fanotify_fh_buf(struct fanotify_fh *fh)
  * be freed and which concrete struct it may be cast to.
  */
 enum fanotify_event_type {
-	FANOTIFY_EVENT_TYPE_FID,
+	FANOTIFY_EVENT_TYPE_FID, /* fixed length */
+	FANOTIFY_EVENT_TYPE_FID_NAME, /* variable length */
 	FANOTIFY_EVENT_TYPE_PATH,
 	FANOTIFY_EVENT_TYPE_PATH_PERM,
 };
@@ -79,15 +80,28 @@ struct fanotify_fid_event {
 
 #define FANOTIFY_FE(event) ((struct fanotify_fid_event *)(event))
 
+struct fanotify_name_event {
+	struct fanotify_event fae;
+	__kernel_fsid_t fsid;
+	struct fanotify_fh dir_fh;
+	u8 name_len;
+	char name[0];
+};
+
+#define FANOTIFY_NE(event) ((struct fanotify_name_event *)(event))
+
 static inline bool fanotify_event_has_fid(struct fanotify_event *event)
 {
-	return event->type == FANOTIFY_EVENT_TYPE_FID;
+	return event->type == FANOTIFY_EVENT_TYPE_FID ||
+		event->type == FANOTIFY_EVENT_TYPE_FID_NAME;
 }
 
 static inline __kernel_fsid_t *fanotify_event_fsid(struct fanotify_event *event)
 {
 	if (event->type == FANOTIFY_EVENT_TYPE_FID)
 		return &FANOTIFY_FE(event)->fsid;
+	else if (event->type == FANOTIFY_EVENT_TYPE_FID_NAME)
+		return &FANOTIFY_NE(event)->fsid;
 	else
 		return NULL;
 }
@@ -108,6 +122,17 @@ static inline int fanotify_event_object_fh_len(struct fanotify_event *event)
 	return fh ? fh->len : 0;
 }
 
+static inline bool fanotify_event_has_name(struct fanotify_event *event)
+{
+	return event->type == FANOTIFY_EVENT_TYPE_FID_NAME;
+}
+
+static inline int fanotify_event_name_len(struct fanotify_event *event)
+{
+	return fanotify_event_has_name(event) ?
+		FANOTIFY_NE(event)->name_len : 0;
+}
+
 struct fanotify_path_event {
 	struct fanotify_event fae;
 	struct path path;
@@ -166,4 +191,5 @@ static inline struct path *fanotify_event_path(struct fanotify_event *event)
 struct fanotify_event *fanotify_alloc_event(struct fsnotify_group *group,
 					    struct inode *inode, u32 mask,
 					    const void *data, int data_type,
+					    const struct qstr *file_name,
 					    __kernel_fsid_t *fsid);
diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index aaa62bd2b80e..2eff2cfa88ce 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -212,7 +212,7 @@ static int copy_fid_to_user(__kernel_fsid_t *fsid, struct fanotify_fh *fh,
 	struct fanotify_event_info_fid info = { };
 	struct file_handle handle = { };
 	unsigned char bounce[FANOTIFY_INLINE_FH_LEN], *fh_buf;
-	size_t fh_len = fh->len;
+	size_t fh_len = fh ? fh->len : 0;
 	size_t len = fanotify_fid_info_len(fh_len);
 
 	if (!len)
@@ -829,7 +829,7 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flags, unsigned int, event_f_flags)
 	group->memcg = get_mem_cgroup_from_mm(current->mm);
 
 	oevent = fanotify_alloc_event(group, NULL, FS_Q_OVERFLOW, NULL,
-				      FSNOTIFY_EVENT_NONE, NULL);
+				      FSNOTIFY_EVENT_NONE, NULL, NULL);
 	if (unlikely(!oevent)) {
 		fd = -ENOMEM;
 		goto out_destroy_group;
-- 
2.17.1

