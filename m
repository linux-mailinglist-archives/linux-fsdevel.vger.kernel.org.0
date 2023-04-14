Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BE176E2A12
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Apr 2023 20:29:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbjDNS30 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Apr 2023 14:29:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230058AbjDNS3X (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Apr 2023 14:29:23 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 160756599;
        Fri, 14 Apr 2023 11:29:21 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id gw13so10850824wmb.3;
        Fri, 14 Apr 2023 11:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681496959; x=1684088959;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a+p7Uw+Qm4I2wt1N74TTe9CZnfSUEkbYH3EWT74BKaY=;
        b=ZHcZ16+n1x9HUWg0sjPjWIRYFAm8pAWyAuY5eYXNGAWtteHtok0TFeCx5ZXPA/ohPX
         RnFa8A9zMBZNDW9dz+6MvHRnXUC3RnYYFW+Zn15HmzChVRLGZJk5r8x8zNp/03gDIlZZ
         MTCU98A0/hX2eSFkkpZlaTgDCs3+RWo2XTBP4akYQlAcxgtKdK1Jba7ENjpl7LLwRPQp
         nXfD+pSLsEpOcqBYjM33Q+/buBLkLN4GU+tZjAOGRd86pYrWlygYin0AnJsxAecRkJlD
         IgaI7e7DzwRWrvPjVJdZF3+kFtSg5DNriC2ZNCxdME9BbW7OKTJtEnkhdCOcDZYfcu6A
         MWXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681496959; x=1684088959;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a+p7Uw+Qm4I2wt1N74TTe9CZnfSUEkbYH3EWT74BKaY=;
        b=dK8/c9DSF3SRTLpdC7hQrjRCuUkjP6v9PrP831/yGer7ux6eIJj0TkSWASOynOtNqN
         2mYu5Y8N2qJJjRsdVnXndM3HuEqifyZUbqqkXNzXDvY24Iocx1nlZQFGxmNAJ8T5O/LL
         Fr9F8XcyIIaILycpLJ7mLojvUhsLiikpEVqr4e3tkgQaDwIg806C8tFvbMejZkHkPskT
         DZrOKHaLSh1yQGO+KreNYJAec1seohtglqhsKc00G1cxyaUWPYzrHOb4zHAiPxNYlzx1
         vj55vgBuVW2ZRGP8M0xxb+JISGacMF4dbt6LvI5PpcDcbkzHuhNRvgsiPsUGXDM/0pF/
         njVA==
X-Gm-Message-State: AAQBX9fzAg4eaiLOmpDi9Ugc5dFmNSvJqv7YpV9UcikuPNIfHYoIrUsf
        RXMCEeTbT8prbP9vqeTYgbI=
X-Google-Smtp-Source: AKy350aujLbSmINLxotLlHhEplyFSjUgYPN4MU8xoCCltylhKjTp01uMaq97lLOsMpp8T8dsDEnarQ==
X-Received: by 2002:a7b:c405:0:b0:3f1:4971:5cd0 with SMTP id k5-20020a7bc405000000b003f149715cd0mr1561842wmi.21.1681496959076;
        Fri, 14 Apr 2023 11:29:19 -0700 (PDT)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
        by smtp.gmail.com with ESMTPSA id m9-20020a05600c160900b003f0b1c4f229sm1780487wmn.28.2023.04.14.11.29.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 11:29:18 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <repnop@google.com>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
Subject: [RFC][PATCH 2/2] fanotify: report mntid info record with FAN_UNMOUNT events
Date:   Fri, 14 Apr 2023 21:29:03 +0300
Message-Id: <20230414182903.1852019-3-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230414182903.1852019-1-amir73il@gmail.com>
References: <20230414182903.1852019-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Report mntid in an info record of type FAN_EVENT_INFO_TYPE_MNTID
with FAN_UNMOUNT event in addition to the fid info record.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/notify/fanotify/fanotify.c      | 37 +++++++++++++++++++------
 fs/notify/fanotify/fanotify.h      | 20 +++++++++++++-
 fs/notify/fanotify/fanotify_user.c | 44 +++++++++++++++++++++++++++---
 include/uapi/linux/fanotify.h      | 10 +++++++
 4 files changed, 97 insertions(+), 14 deletions(-)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index 384d2b2e55e7..c204259be6cc 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -17,6 +17,7 @@
 #include <linux/stringhash.h>
 
 #include "fanotify.h"
+#include "../../mount.h" /* for mnt_id */
 
 static bool fanotify_path_equal(const struct path *p1, const struct path *p2)
 {
@@ -41,6 +42,11 @@ static unsigned int fanotify_hash_fsid(__kernel_fsid_t *fsid)
 		hash_32(fsid->val[1], FANOTIFY_EVENT_HASH_BITS);
 }
 
+static unsigned int fanotify_hash_mntid(int mntid)
+{
+	return hash_32(mntid, FANOTIFY_EVENT_HASH_BITS);
+}
+
 static bool fanotify_fh_equal(struct fanotify_fh *fh1,
 			      struct fanotify_fh *fh2)
 {
@@ -133,6 +139,12 @@ static bool fanotify_error_event_equal(struct fanotify_error_event *fee1,
 	return true;
 }
 
+/*
+ * FAN_RENAME and FAN_UNMOUNT are reported with special info record types,
+ * so we cannot merge them with other events.
+ */
+#define FANOTIFY_NO_MERGE_EVENTS (FAN_RENAME | FAN_UNMOUNT)
+
 static bool fanotify_should_merge(struct fanotify_event *old,
 				  struct fanotify_event *new)
 {
@@ -153,11 +165,8 @@ static bool fanotify_should_merge(struct fanotify_event *old,
 	if ((old->mask & FS_ISDIR) != (new->mask & FS_ISDIR))
 		return false;
 
-	/*
-	 * FAN_RENAME event is reported with special info record types,
-	 * so we cannot merge it with other events.
-	 */
-	if ((old->mask & FAN_RENAME) != (new->mask & FAN_RENAME))
+	if ((old->mask & FANOTIFY_NO_MERGE_EVENTS) ||
+	    (new->mask & FANOTIFY_NO_MERGE_EVENTS))
 		return false;
 
 	switch (old->type) {
@@ -593,9 +602,11 @@ static struct fanotify_event *fanotify_alloc_perm_event(const struct path *path,
 
 static struct fanotify_event *fanotify_alloc_fid_event(struct inode *id,
 						       __kernel_fsid_t *fsid,
+						       struct mount *mnt,
 						       unsigned int *hash,
 						       gfp_t gfp)
 {
+	unsigned int fh_len = fanotify_encode_fh_len(id);
 	struct fanotify_fid_event *ffe;
 
 	ffe = kmem_cache_alloc(fanotify_fid_event_cachep, gfp);
@@ -605,8 +616,14 @@ static struct fanotify_event *fanotify_alloc_fid_event(struct inode *id,
 	ffe->fae.type = FANOTIFY_EVENT_TYPE_FID;
 	ffe->fsid = *fsid;
 	*hash ^= fanotify_hash_fsid(fsid);
-	fanotify_encode_fh(&ffe->object_fh, id, fanotify_encode_fh_len(id),
-			   hash, gfp);
+	fanotify_encode_fh(&ffe->object_fh, id, fh_len, hash, gfp);
+	/* Record fid event with fsid, mntid and empty fh */
+	if (mnt && !WARN_ON_ONCE(fh_len)) {
+		ffe->mnt_id = mnt->mnt_id;
+		ffe->object_fh.flags = FANOTIFY_FH_FLAG_MNT_ID;
+		if (hash)
+			*hash ^= fanotify_hash_mntid(mnt->mnt_id);
+	}
 
 	return &ffe->fae;
 }
@@ -737,6 +754,7 @@ static struct fanotify_event *fanotify_alloc_event(
 					      fid_mode);
 	struct inode *dirid = fanotify_dfid_inode(mask, data, data_type, dir);
 	const struct path *path = fsnotify_data_path(data, data_type);
+	struct mount *mnt = NULL;
 	struct mem_cgroup *old_memcg;
 	struct dentry *moved = NULL;
 	struct inode *child = NULL;
@@ -746,7 +764,8 @@ static struct fanotify_event *fanotify_alloc_event(
 	struct pid *pid;
 
 	if (mask & FAN_UNMOUNT && !WARN_ON_ONCE(!path || !fid_mode)) {
-		/* Record fid event with fsid and empty fh */
+		/* Record fid event with fsid, mntid and empty fh */
+		mnt = real_mount(path->mnt);
 		id = NULL;
 	} else if ((fid_mode & FAN_REPORT_DIR_FID) && dirid) {
 		/*
@@ -834,7 +853,7 @@ static struct fanotify_event *fanotify_alloc_event(
 		event = fanotify_alloc_name_event(dirid, fsid, file_name, child,
 						  moved, &hash, gfp);
 	} else if (fid_mode) {
-		event = fanotify_alloc_fid_event(id, fsid, &hash, gfp);
+		event = fanotify_alloc_fid_event(id, fsid, mnt, &hash, gfp);
 	} else {
 		event = fanotify_alloc_path_event(path, &hash, gfp);
 	}
diff --git a/fs/notify/fanotify/fanotify.h b/fs/notify/fanotify/fanotify.h
index f98dcf5b7a19..3d8391a77031 100644
--- a/fs/notify/fanotify/fanotify.h
+++ b/fs/notify/fanotify/fanotify.h
@@ -33,6 +33,7 @@ struct fanotify_fh {
 	u8 type;
 	u8 len;
 #define FANOTIFY_FH_FLAG_EXT_BUF 1
+#define FANOTIFY_FH_FLAG_MNT_ID  2
 	u8 flags;
 	u8 pad;
 	unsigned char buf[];
@@ -279,7 +280,10 @@ static inline void fanotify_init_event(struct fanotify_event *event,
 struct {								\
 	struct fanotify_fh (name);					\
 	/* Space for object_fh.buf[] - access with fanotify_fh_buf() */	\
-	unsigned char _inline_fh_buf[(size)];				\
+	union {								\
+		unsigned char _inline_fh_buf[(size)];			\
+		int mnt_id;	/* For FAN_UNMOUNT */			\
+	};								\
 }
 
 struct fanotify_fid_event {
@@ -335,6 +339,20 @@ static inline __kernel_fsid_t *fanotify_event_fsid(struct fanotify_event *event)
 		return NULL;
 }
 
+static inline int fanotify_event_mntid(struct fanotify_event *event)
+{
+	struct fanotify_fh *fh = NULL;
+
+	if (event->mask & FAN_UNMOUNT &&
+	    event->type == FANOTIFY_EVENT_TYPE_FID)
+		fh = &FANOTIFY_FE(event)->object_fh;
+
+	if (fh && !fh->len && fh->flags == FANOTIFY_FH_FLAG_MNT_ID)
+		return FANOTIFY_FE(event)->mnt_id;
+
+	return 0;
+}
+
 static inline struct fanotify_fh *fanotify_event_object_fh(
 						struct fanotify_event *event)
 {
diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index 0b3de6218c56..db3b79b8e901 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -120,7 +120,9 @@ struct kmem_cache *fanotify_perm_event_cachep __read_mostly;
 #define FANOTIFY_EVENT_ALIGN 4
 #define FANOTIFY_FID_INFO_HDR_LEN \
 	(sizeof(struct fanotify_event_info_fid) + sizeof(struct file_handle))
-#define FANOTIFY_PIDFD_INFO_HDR_LEN \
+#define FANOTIFY_MNTID_INFO_LEN \
+	sizeof(struct fanotify_event_info_mntid)
+#define FANOTIFY_PIDFD_INFO_LEN \
 	sizeof(struct fanotify_event_info_pidfd)
 #define FANOTIFY_ERROR_INFO_LEN \
 	(sizeof(struct fanotify_event_info_error))
@@ -178,8 +180,11 @@ static size_t fanotify_event_len(unsigned int info_mode,
 		dot_len = 1;
 	}
 
+	if (fanotify_event_mntid(event))
+		event_len += FANOTIFY_MNTID_INFO_LEN;
+
 	if (info_mode & FAN_REPORT_PIDFD)
-		event_len += FANOTIFY_PIDFD_INFO_HDR_LEN;
+		event_len += FANOTIFY_PIDFD_INFO_LEN;
 
 	if (fanotify_event_has_object_fh(event)) {
 		fh_len = fanotify_event_object_fh_len(event);
@@ -515,7 +520,7 @@ static int copy_pidfd_info_to_user(int pidfd,
 				   size_t count)
 {
 	struct fanotify_event_info_pidfd info = { };
-	size_t info_len = FANOTIFY_PIDFD_INFO_HDR_LEN;
+	size_t info_len = FANOTIFY_PIDFD_INFO_LEN;
 
 	if (WARN_ON_ONCE(info_len > count))
 		return -EFAULT;
@@ -530,6 +535,26 @@ static int copy_pidfd_info_to_user(int pidfd,
 	return info_len;
 }
 
+static int copy_mntid_info_to_user(int mntid,
+				   char __user *buf,
+				   size_t count)
+{
+	struct fanotify_event_info_mntid info = { };
+	size_t info_len = FANOTIFY_MNTID_INFO_LEN;
+
+	if (WARN_ON_ONCE(info_len > count))
+		return -EFAULT;
+
+	info.hdr.info_type = FAN_EVENT_INFO_TYPE_MNTID;
+	info.hdr.len = info_len;
+	info.mnt_id = mntid;
+
+	if (copy_to_user(buf, &info, info_len))
+		return -EFAULT;
+
+	return info_len;
+}
+
 static int copy_info_records_to_user(struct fanotify_event *event,
 				     struct fanotify_info *info,
 				     unsigned int info_mode, int pidfd,
@@ -538,6 +563,7 @@ static int copy_info_records_to_user(struct fanotify_event *event,
 	int ret, total_bytes = 0, info_type = 0;
 	unsigned int fid_mode = info_mode & FANOTIFY_FID_BITS;
 	unsigned int pidfd_mode = info_mode & FAN_REPORT_PIDFD;
+	int mntid = fanotify_event_mntid(event);
 
 	/*
 	 * Event info records order is as follows:
@@ -632,6 +658,16 @@ static int copy_info_records_to_user(struct fanotify_event *event,
 		total_bytes += ret;
 	}
 
+	if (mntid) {
+		ret = copy_mntid_info_to_user(mntid, buf, count);
+		if (ret < 0)
+			return ret;
+
+		buf += ret;
+		count -= ret;
+		total_bytes += ret;
+	}
+
 	if (pidfd_mode) {
 		ret = copy_pidfd_info_to_user(pidfd, buf, count);
 		if (ret < 0)
@@ -1770,7 +1806,7 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
 	 * inotify sends unsoliciled IN_UNMOUNT per marked inode on sb shutdown.
 	 * FAN_UNMOUNT event is about unmount of a mount, not about sb shutdown,
 	 * so allow setting it only in mount mark mask.
-	 * FAN_UNMOUNT requires FAN_REPORT_FID to report fsid with empty fh.
+	 * FAN_UNMOUNT requires FAN_REPORT_FID to report fsid and mntid.
 	 */
 	if (mask & FAN_UNMOUNT &&
 	    (!(fid_mode & FAN_REPORT_FID) || mark_type != FAN_MARK_MOUNT))
diff --git a/include/uapi/linux/fanotify.h b/include/uapi/linux/fanotify.h
index 70f2d43e8ba4..886efbd877ba 100644
--- a/include/uapi/linux/fanotify.h
+++ b/include/uapi/linux/fanotify.h
@@ -144,6 +144,7 @@ struct fanotify_event_metadata {
 #define FAN_EVENT_INFO_TYPE_DFID	3
 #define FAN_EVENT_INFO_TYPE_PIDFD	4
 #define FAN_EVENT_INFO_TYPE_ERROR	5
+#define FAN_EVENT_INFO_TYPE_MNTID	6
 
 /* Special info types for FAN_RENAME */
 #define FAN_EVENT_INFO_TYPE_OLD_DFID_NAME	10
@@ -184,6 +185,15 @@ struct fanotify_fhandle {
 	__u64 fh_ino;
 };
 
+/*
+ * This structure is used for info records of type FAN_EVENT_INFO_TYPE_MNTID.
+ */
+struct fanotify_event_info_mntid {
+	struct fanotify_event_info_header hdr;
+	/* matches mount_id from name_to_handle_at(2) */
+	__s32 mnt_id;
+};
+
 /*
  * This structure is used for info records of type FAN_EVENT_INFO_TYPE_PIDFD.
  * It holds a pidfd for the pid that was responsible for generating an event.
-- 
2.34.1

