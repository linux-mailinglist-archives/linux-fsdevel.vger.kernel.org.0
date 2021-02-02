Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5626D30C597
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Feb 2021 17:29:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236118AbhBBQ1M (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Feb 2021 11:27:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236264AbhBBQYL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Feb 2021 11:24:11 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19795C061A28
        for <linux-fsdevel@vger.kernel.org>; Tue,  2 Feb 2021 08:20:23 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id b9so11256722ejy.12
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 Feb 2021 08:20:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iWaZDgI8AzNvPDU3BYbPrZxBcqC2SCA46EkPcYsDOdw=;
        b=N9U6OIUnLKWMhv3k2CeI0sT9cNaWZ1Tr7AkWRpZjZMrq8IemE/ckN2rUT4MoCG8//4
         5evpwASJS1iLKTfv8ALsjZdqNBXIsr+7u6CoDHAq7d3X3k0KZWeNASZ5XPpS8TKjDIfZ
         XqI8Rsra2xLNwnifck//Y9ZKaFfaulJL6Wd7b5UcpSglggBy29zCCLHWNXyj/EfdYPuI
         +YtAdFKWQujx2fsYMUa2tGmjvaOoU4krNqt4Q5ROQH1NOrrRX1kcVOcyV9iHgpDlXUHu
         YuXObd6BOEIWHhTf4lnbrmIocOWtXT39zTl+Ofv6TX+F8zIXFBrJa8ZadxiWeMy4X8Rd
         AxUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iWaZDgI8AzNvPDU3BYbPrZxBcqC2SCA46EkPcYsDOdw=;
        b=OqY1hGZex1qZrVEu003NeOajta0SfTxMhCl1DVyq5iZ1sc2u3osy7NQawCC9+samRY
         44pWxRExz3JBkm3V1aZJ4xv83848MMjzwT7O11hIcKBy/CyPZwztGTEcHJolsLK3YMeD
         BaSN6xlINHLZg2peVcrYR6MPXwDbibMbVTOaK/7xDUKKySlcor55HfDDRxfCXbF82KEt
         rYGRKQMVbSTUHSKBAPSwyyt9KOGkpip081WGWYleJZngeDB4J+iWn+dB6WzE/FqiD+AA
         R5eUJxqdUfMyyf9hK6WW7vuh7Fxb3Z7El28rqSGuFbyYm7wGZxr/rZ3z62F7gW4CkRv0
         uORQ==
X-Gm-Message-State: AOAM531hjVVbDAAkEj7ycGsfbDhftj8CvqUQrUaxBKknw4g8rjcvmFLZ
        uhim5Jpa4SNHRVLHmRFdfrFrlpR1R0o=
X-Google-Smtp-Source: ABdhPJwjMVhHIA2cQCqGAXmVdwhoUIwYF9+BXNVU20WNZ34JMT7Axam10bc/iXJOLwd1wPp5ff2S5Q==
X-Received: by 2002:a17:906:1359:: with SMTP id x25mr9065455ejb.25.1612282821868;
        Tue, 02 Feb 2021 08:20:21 -0800 (PST)
Received: from localhost.localdomain ([31.210.181.203])
        by smtp.gmail.com with ESMTPSA id f3sm562450edt.24.2021.02.02.08.20.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Feb 2021 08:20:21 -0800 (PST)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH 6/7] fanotify: mix event info into merge key hash
Date:   Tue,  2 Feb 2021 18:20:09 +0200
Message-Id: <20210202162010.305971-7-amir73il@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210202162010.305971-1-amir73il@gmail.com>
References: <20210202162010.305971-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Improve the balance of hashed queue lists by mixing more event info
relevant for merge.

For example, all FAN_CREATE name events in the same dir used to have the
same merge key based on the dir inode.  With this change the created
file name is mixed into the merge key.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/notify/fanotify/fanotify.c | 33 +++++++++++++++++++++++++++------
 fs/notify/fanotify/fanotify.h | 20 +++++++++++++++++---
 2 files changed, 44 insertions(+), 9 deletions(-)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index 6d3807012851..b19fef1c6f64 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -14,6 +14,7 @@
 #include <linux/audit.h>
 #include <linux/sched/mm.h>
 #include <linux/statfs.h>
+#include <linux/stringhash.h>
 
 #include "fanotify.h"
 
@@ -443,6 +444,10 @@ static struct fanotify_event *fanotify_alloc_path_event(const struct path *path,
 	pevent->path = *path;
 	path_get(path);
 
+	/* Mix path info into event merge key */
+	pevent->fae.info_hash = hash_ptr(path->dentry, 32) ^
+				hash_ptr(path->mnt, 32);
+
 	return &pevent->fae;
 }
 
@@ -461,6 +466,9 @@ static struct fanotify_event *fanotify_alloc_perm_event(const struct path *path,
 	pevent->path = *path;
 	path_get(path);
 
+	/* Permission events are not merged */
+	pevent->fae.info_hash = 0;
+
 	return &pevent->fae;
 }
 
@@ -469,6 +477,7 @@ static struct fanotify_event *fanotify_alloc_fid_event(struct inode *id,
 						       gfp_t gfp)
 {
 	struct fanotify_fid_event *ffe;
+	struct fanotify_fh *fh;
 
 	ffe = kmem_cache_alloc(fanotify_fid_event_cachep, gfp);
 	if (!ffe)
@@ -476,8 +485,11 @@ static struct fanotify_event *fanotify_alloc_fid_event(struct inode *id,
 
 	ffe->fae.type = FANOTIFY_EVENT_TYPE_FID;
 	ffe->fsid = *fsid;
-	fanotify_encode_fh(&ffe->object_fh, id, fanotify_encode_fh_len(id),
-			   gfp);
+	fh = &ffe->object_fh;
+	fanotify_encode_fh(fh, id, fanotify_encode_fh_len(id), gfp);
+
+	/* Mix fsid+fid info into event merge key */
+	ffe->fae.info_hash = full_name_hash(ffe->fskey, fanotify_fh_buf(fh), fh->len);
 
 	return &ffe->fae;
 }
@@ -517,6 +529,9 @@ static struct fanotify_event *fanotify_alloc_name_event(struct inode *id,
 	if (file_name)
 		fanotify_info_copy_name(info, file_name);
 
+	/* Mix fsid+dfid+name+fid info into event merge key */
+	fne->fae.info_hash = full_name_hash(fne->fskey, info->buf, fanotify_info_len(info));
+
 	pr_debug("%s: ino=%lu size=%u dir_fh_len=%u child_fh_len=%u name_len=%u name='%.*s'\n",
 		 __func__, id->i_ino, size, dir_fh_len, child_fh_len,
 		 info->name_len, info->name_len, fanotify_info_name(info));
@@ -539,6 +554,8 @@ static struct fanotify_event *fanotify_alloc_event(struct fsnotify_group *group,
 	struct mem_cgroup *old_memcg;
 	struct inode *child = NULL;
 	bool name_event = false;
+	unsigned int hash = 0;
+	struct pid *pid;
 
 	if ((fid_mode & FAN_REPORT_DIR_FID) && dirid) {
 		/*
@@ -606,13 +623,17 @@ static struct fanotify_event *fanotify_alloc_event(struct fsnotify_group *group,
 	 * Use the victim inode instead of the watching inode as the id for
 	 * event queue, so event reported on parent is merged with event
 	 * reported on child when both directory and child watches exist.
-	 * Reduce object id to 32bit hash for hashed queue merge.
+	 * Reduce object id and event info to 32bit hash for hashed queue merge.
 	 */
-	fanotify_init_event(event, hash_ptr(id, 32), mask);
+	hash = event->info_hash ^ hash_ptr(id, 32);
 	if (FAN_GROUP_FLAG(group, FAN_REPORT_TID))
-		event->pid = get_pid(task_pid(current));
+		pid = get_pid(task_pid(current));
 	else
-		event->pid = get_pid(task_tgid(current));
+		pid = get_pid(task_tgid(current));
+	/* Mix pid info into event merge key */
+	hash ^= hash_ptr(pid, 32);
+	fanotify_init_event(event, hash, mask);
+	event->pid = pid;
 
 out:
 	set_active_memcg(old_memcg);
diff --git a/fs/notify/fanotify/fanotify.h b/fs/notify/fanotify/fanotify.h
index 2e856372ffc8..522fb1a68b30 100644
--- a/fs/notify/fanotify/fanotify.h
+++ b/fs/notify/fanotify/fanotify.h
@@ -115,6 +115,11 @@ static inline void fanotify_info_init(struct fanotify_info *info)
 	info->name_len = 0;
 }
 
+static inline unsigned int fanotify_info_len(struct fanotify_info *info)
+{
+	return info->dir_fh_totlen + info->file_fh_totlen + info->name_len;
+}
+
 static inline void fanotify_info_copy_name(struct fanotify_info *info,
 					   const struct qstr *name)
 {
@@ -138,7 +143,10 @@ enum fanotify_event_type {
 };
 
 struct fanotify_event {
-	struct fsnotify_event fse;
+	union {
+		struct fsnotify_event fse;
+		unsigned int info_hash;
+	};
 	u32 mask;
 	enum fanotify_event_type type;
 	struct pid *pid;
@@ -154,7 +162,10 @@ static inline void fanotify_init_event(struct fanotify_event *event,
 
 struct fanotify_fid_event {
 	struct fanotify_event fae;
-	__kernel_fsid_t fsid;
+	union {
+		__kernel_fsid_t fsid;
+		void *fskey;	/* 64 or 32 bits of fsid used for salt */
+	};
 	struct fanotify_fh object_fh;
 	/* Reserve space in object_fh.buf[] - access with fanotify_fh_buf() */
 	unsigned char _inline_fh_buf[FANOTIFY_INLINE_FH_LEN];
@@ -168,7 +179,10 @@ FANOTIFY_FE(struct fanotify_event *event)
 
 struct fanotify_name_event {
 	struct fanotify_event fae;
-	__kernel_fsid_t fsid;
+	union {
+		__kernel_fsid_t fsid;
+		void *fskey;	/* 64 or 32 bits of fsid used for salt */
+	};
 	struct fanotify_info info;
 };
 
-- 
2.25.1

