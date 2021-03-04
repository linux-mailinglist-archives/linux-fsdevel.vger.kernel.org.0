Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1605132D121
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Mar 2021 11:51:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238997AbhCDKti (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Mar 2021 05:49:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238970AbhCDKtO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Mar 2021 05:49:14 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFAC9C061762
        for <linux-fsdevel@vger.kernel.org>; Thu,  4 Mar 2021 02:48:33 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id u187so7588667wmg.4
        for <linux-fsdevel@vger.kernel.org>; Thu, 04 Mar 2021 02:48:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RHdXsN1dDRguch5eNFV4tjCjETyCykOPLKwz0UC7oU4=;
        b=FKH5Ab0geeGI0DFid88+m1KptQWaetMiZKgNqdKYH60NrAEQ8UhAA5heebKEd2w/PI
         MAS+ZBIvEckbcvC1m7lXLe72gJRzxCokDgpFHTVCPm/nfvoY0jxtwhWtkvbpjy/qDMja
         qrIyiLp4fsTYarI8HaADSVyT957PT6U/xG3i49YthUo7YsJS6sq+5Vr8m3FALxCYuPNH
         U2CtHNMx+ET+lr71o5JxXFWcOpcZKe+ssVQWc4UeSldDF7r4Nb1Jdp9a1zowtB5o+lbx
         7G78eqvsdzMmzxPSrQ5TjiNIzr6da2++IAXH5+iOpoSeH5WsrTfNolcmd6XNdlewhhqQ
         zHZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RHdXsN1dDRguch5eNFV4tjCjETyCykOPLKwz0UC7oU4=;
        b=TURpie3b1OXBXPj1VkpHEqoXVF9HBEIi1qIT7G9Kk9x+iZTZ+ui9mveddqCeJbNbEf
         BNrUhKRMWd8pASMTKyUc91mmHxrglI6Od/Pc2SS/gBV7MWyr8vBPwgPMUVgTRCpszka1
         pm/wArAdNfaTq1j1z7Wt0U3z/0zBgZ3dMb4PoB1CqAEWVxLImPBkyBu2rSRxuzPPRnld
         awzXiBetjOrdOziuiXBmYAUdHl5iFUgwvuprGx6JWMY5mUyUA54h4FEqXFXX6cqcpABI
         vIAvtRGqpR2w7PBRcw04UESj8pu4BFLXAGm0RWuoGvJHHudBDgbQFPRaGwVDUaFf5GYr
         Y7hA==
X-Gm-Message-State: AOAM5317T1hg50kzsu2uiTgIFv1KXx/rUsaCf5R5dQimgSeRWyuF3QRV
        Db+dLDl6yaxX7YD0unHkUjY=
X-Google-Smtp-Source: ABdhPJy5mvC9yFjTVDyAeBFcMx9YK7SyHipW/lVhSe7X/GORJDc0l2Fk6XFBJIVsICGz6oCyMU8Qkw==
X-Received: by 2002:a1c:f708:: with SMTP id v8mr3221492wmh.25.1614854912538;
        Thu, 04 Mar 2021 02:48:32 -0800 (PST)
Received: from localhost.localdomain ([141.226.13.117])
        by smtp.gmail.com with ESMTPSA id d7sm6736635wrs.42.2021.03.04.02.48.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Mar 2021 02:48:32 -0800 (PST)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 3/5] fanotify: mix event info and pid into merge key hash
Date:   Thu,  4 Mar 2021 12:48:24 +0200
Message-Id: <20210304104826.3993892-4-amir73il@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210304104826.3993892-1-amir73il@gmail.com>
References: <20210304104826.3993892-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Improve the merge key hash by mixing more values relevant for merge.

For example, all FAN_CREATE name events in the same dir used to have the
same merge key based on the dir inode.  With this change the created
file name is mixed into the merge key.

The object id that was used as merge key is redundant to the event info
so it is no longer mixed into the hash.

Permission events are not hashed, so no need to hash their info.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/notify/fanotify/fanotify.c | 87 ++++++++++++++++++++++++-----------
 fs/notify/fanotify/fanotify.h |  5 ++
 2 files changed, 66 insertions(+), 26 deletions(-)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index 8a2bb6954e02..db30db61a815 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -14,6 +14,7 @@
 #include <linux/audit.h>
 #include <linux/sched/mm.h>
 #include <linux/statfs.h>
+#include <linux/stringhash.h>
 
 #include "fanotify.h"
 
@@ -22,12 +23,24 @@ static bool fanotify_path_equal(struct path *p1, struct path *p2)
 	return p1->mnt == p2->mnt && p1->dentry == p2->dentry;
 }
 
+static unsigned int fanotify_hash_path(const struct path *path)
+{
+	return hash_ptr(path->dentry, FANOTIFY_EVENT_HASH_BITS) ^
+		hash_ptr(path->mnt, FANOTIFY_EVENT_HASH_BITS);
+}
+
 static inline bool fanotify_fsid_equal(__kernel_fsid_t *fsid1,
 				       __kernel_fsid_t *fsid2)
 {
 	return fsid1->val[0] == fsid2->val[0] && fsid1->val[1] == fsid2->val[1];
 }
 
+static unsigned int fanotify_hash_fsid(__kernel_fsid_t *fsid)
+{
+	return hash_32(fsid->val[0], FANOTIFY_EVENT_HASH_BITS) ^
+		hash_32(fsid->val[1], FANOTIFY_EVENT_HASH_BITS);
+}
+
 static bool fanotify_fh_equal(struct fanotify_fh *fh1,
 			      struct fanotify_fh *fh2)
 {
@@ -38,6 +51,16 @@ static bool fanotify_fh_equal(struct fanotify_fh *fh1,
 		!memcmp(fanotify_fh_buf(fh1), fanotify_fh_buf(fh2), fh1->len);
 }
 
+static unsigned int fanotify_hash_fh(struct fanotify_fh *fh)
+{
+	long salt = (long)fh->type | (long)fh->len << 8;
+
+	/*
+	 * full_name_hash() works long by long, so it handles fh buf optimally.
+	 */
+	return full_name_hash((void *)salt, fanotify_fh_buf(fh), fh->len);
+}
+
 static bool fanotify_fid_event_equal(struct fanotify_fid_event *ffe1,
 				     struct fanotify_fid_event *ffe2)
 {
@@ -325,7 +348,8 @@ static int fanotify_encode_fh_len(struct inode *inode)
  * Return 0 on failure to encode.
  */
 static int fanotify_encode_fh(struct fanotify_fh *fh, struct inode *inode,
-			      unsigned int fh_len, gfp_t gfp)
+			      unsigned int fh_len, unsigned int *hash,
+			      gfp_t gfp)
 {
 	int dwords, type = 0;
 	char *ext_buf = NULL;
@@ -368,6 +392,9 @@ static int fanotify_encode_fh(struct fanotify_fh *fh, struct inode *inode,
 	fh->type = type;
 	fh->len = fh_len;
 
+	/* Mix fh into event merge key */
+	*hash ^= fanotify_hash_fh(fh);
+
 	return FANOTIFY_FH_HDR_LEN + fh_len;
 
 out_err:
@@ -421,6 +448,7 @@ static struct inode *fanotify_dfid_inode(u32 event_mask, const void *data,
 }
 
 static struct fanotify_event *fanotify_alloc_path_event(const struct path *path,
+							unsigned int *hash,
 							gfp_t gfp)
 {
 	struct fanotify_path_event *pevent;
@@ -431,6 +459,7 @@ static struct fanotify_event *fanotify_alloc_path_event(const struct path *path,
 
 	pevent->fae.type = FANOTIFY_EVENT_TYPE_PATH;
 	pevent->path = *path;
+	*hash ^= fanotify_hash_path(path);
 	path_get(path);
 
 	return &pevent->fae;
@@ -456,6 +485,7 @@ static struct fanotify_event *fanotify_alloc_perm_event(const struct path *path,
 
 static struct fanotify_event *fanotify_alloc_fid_event(struct inode *id,
 						       __kernel_fsid_t *fsid,
+						       unsigned int *hash,
 						       gfp_t gfp)
 {
 	struct fanotify_fid_event *ffe;
@@ -466,16 +496,18 @@ static struct fanotify_event *fanotify_alloc_fid_event(struct inode *id,
 
 	ffe->fae.type = FANOTIFY_EVENT_TYPE_FID;
 	ffe->fsid = *fsid;
+	*hash ^= fanotify_hash_fsid(fsid);
 	fanotify_encode_fh(&ffe->object_fh, id, fanotify_encode_fh_len(id),
-			   gfp);
+			   hash, gfp);
 
 	return &ffe->fae;
 }
 
 static struct fanotify_event *fanotify_alloc_name_event(struct inode *id,
 							__kernel_fsid_t *fsid,
-							const struct qstr *file_name,
+							const struct qstr *name,
 							struct inode *child,
+							unsigned int *hash,
 							gfp_t gfp)
 {
 	struct fanotify_name_event *fne;
@@ -488,24 +520,30 @@ static struct fanotify_event *fanotify_alloc_name_event(struct inode *id,
 	size = sizeof(*fne) + FANOTIFY_FH_HDR_LEN + dir_fh_len;
 	if (child_fh_len)
 		size += FANOTIFY_FH_HDR_LEN + child_fh_len;
-	if (file_name)
-		size += file_name->len + 1;
+	if (name)
+		size += name->len + 1;
 	fne = kmalloc(size, gfp);
 	if (!fne)
 		return NULL;
 
 	fne->fae.type = FANOTIFY_EVENT_TYPE_FID_NAME;
 	fne->fsid = *fsid;
+	*hash ^= fanotify_hash_fsid(fsid);
 	info = &fne->info;
 	fanotify_info_init(info);
 	dfh = fanotify_info_dir_fh(info);
-	info->dir_fh_totlen = fanotify_encode_fh(dfh, id, dir_fh_len, 0);
+	info->dir_fh_totlen = fanotify_encode_fh(dfh, id, dir_fh_len, hash, 0);
 	if (child_fh_len) {
 		ffh = fanotify_info_file_fh(info);
-		info->file_fh_totlen = fanotify_encode_fh(ffh, child, child_fh_len, 0);
+		info->file_fh_totlen = fanotify_encode_fh(ffh, child,
+							child_fh_len, hash, 0);
+	}
+	if (name) {
+		long salt = name->len;
+
+		fanotify_info_copy_name(info, name);
+		*hash ^= full_name_hash((void *)salt, name->name, name->len);
 	}
-	if (file_name)
-		fanotify_info_copy_name(info, file_name);
 
 	pr_debug("%s: ino=%lu size=%u dir_fh_len=%u child_fh_len=%u name_len=%u name='%.*s'\n",
 		 __func__, id->i_ino, size, dir_fh_len, child_fh_len,
@@ -530,6 +568,8 @@ static struct fanotify_event *fanotify_alloc_event(struct fsnotify_group *group,
 	struct inode *child = NULL;
 	bool name_event = false;
 	unsigned int hash = 0;
+	unsigned long ondir = (mask & FAN_ONDIR) ? 1UL : 0;
+	struct pid *pid;
 
 	if ((fid_mode & FAN_REPORT_DIR_FID) && dirid) {
 		/*
@@ -537,8 +577,7 @@ static struct fanotify_event *fanotify_alloc_event(struct fsnotify_group *group,
 		 * report the child fid for events reported on a non-dir child
 		 * in addition to reporting the parent fid and maybe child name.
 		 */
-		if ((fid_mode & FAN_REPORT_FID) &&
-		    id != dirid && !(mask & FAN_ONDIR))
+		if ((fid_mode & FAN_REPORT_FID) && id != dirid && !ondir)
 			child = id;
 
 		id = dirid;
@@ -559,8 +598,7 @@ static struct fanotify_event *fanotify_alloc_event(struct fsnotify_group *group,
 		if (!(fid_mode & FAN_REPORT_NAME)) {
 			name_event = !!child;
 			file_name = NULL;
-		} else if ((mask & ALL_FSNOTIFY_DIRENT_EVENTS) ||
-			   !(mask & FAN_ONDIR)) {
+		} else if ((mask & ALL_FSNOTIFY_DIRENT_EVENTS) || !ondir) {
 			name_event = true;
 		}
 	}
@@ -583,28 +621,25 @@ static struct fanotify_event *fanotify_alloc_event(struct fsnotify_group *group,
 		event = fanotify_alloc_perm_event(path, gfp);
 	} else if (name_event && (file_name || child)) {
 		event = fanotify_alloc_name_event(id, fsid, file_name, child,
-						  gfp);
+						  &hash, gfp);
 	} else if (fid_mode) {
-		event = fanotify_alloc_fid_event(id, fsid, gfp);
+		event = fanotify_alloc_fid_event(id, fsid, &hash, gfp);
 	} else {
-		event = fanotify_alloc_path_event(path, gfp);
+		event = fanotify_alloc_path_event(path, &hash, gfp);
 	}
 
 	if (!event)
 		goto out;
 
-	/*
-	 * Use the victim inode instead of the watching inode as the id for
-	 * event queue, so event reported on parent is merged with event
-	 * reported on child when both directory and child watches exist.
-	 * Hash object id for queue merge.
-	 */
-	hash = hash_ptr(id, FANOTIFY_EVENT_HASH_BITS);
-	fanotify_init_event(event, hash, mask);
 	if (FAN_GROUP_FLAG(group, FAN_REPORT_TID))
-		event->pid = get_pid(task_pid(current));
+		pid = get_pid(task_pid(current));
 	else
-		event->pid = get_pid(task_tgid(current));
+		pid = get_pid(task_tgid(current));
+
+	/* Mix event info, FAN_ONDIR flag and pid into event merge key */
+	hash ^= hash_long((unsigned long)pid | ondir, FANOTIFY_EVENT_HASH_BITS);
+	fanotify_init_event(event, hash, mask);
+	event->pid = pid;
 
 out:
 	set_active_memcg(old_memcg);
diff --git a/fs/notify/fanotify/fanotify.h b/fs/notify/fanotify/fanotify.h
index d531f0cfa46f..9871f76cd9c2 100644
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
-- 
2.30.0

