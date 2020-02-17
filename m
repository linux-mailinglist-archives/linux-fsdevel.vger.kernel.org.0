Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F0111612FA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2020 14:16:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729184AbgBQNP3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Feb 2020 08:15:29 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34320 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729018AbgBQNPW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Feb 2020 08:15:22 -0500
Received: by mail-wr1-f68.google.com with SMTP id n10so17740011wrm.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Feb 2020 05:15:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3GrSWkT/bnpfGwMb4aFnds0xBYXXx0zoUkU4vUi40U4=;
        b=XG8xYfruTiz7vBYZHTkkMaItl3EconcQ/uEUXCRkERsiYZLlYAhJbNFi2+K5Dg9oTW
         8jIkdheTBEAJ7O2I9cenKy4NBG90ETkwI88ywRZBo18bs50FKMr5n4AvyqEdEGCM/+RC
         5C2oMs8BmNh3MPLMjjSrRQ954pksiCOMsmHHdIStUi53PiDv/uPkF9EPASAqSCTAF30A
         7Q2Q7bJq4MYJV9PGt5Wrpxt/7nSyiv7FRIqNxltqiOQkg7OU5MT823dWSucz3BvjFH4q
         rl6mPU84x5gpYo9kFMnSsShhL+wyQFFtZVVCA1RZa9tH9elztDplcPeuKK1EYQxVCXb4
         dmyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3GrSWkT/bnpfGwMb4aFnds0xBYXXx0zoUkU4vUi40U4=;
        b=ZTfeFiC5qyyKzLP/NlOMnL0KArsP9I11vMTMy2NQSxCgwOIOHc4OorqlLiLCUcRfra
         cp1MyG0nsZMA0McdYx42jyXZCMVhH0nLKTUoaVXSMP+t+0LUbhUlUDCtPJY8kerAAaVU
         pLicXC1KKtoJN8rK3hIKoa/XtsGEIOIch36Zg6hdwiCHGduEzash6RlV/0iihYRL9Uhb
         fABUuFTWLsv1N8kFtHKl5/BqUkP7H8XSfpXisF/TJds0Co5TyFOZ7CSfq1Y3Iflhw5kq
         iay3W3vWyVmEvLDj1k3SXmPo9yBOa8OxCeTMYqGAx5P5m01L3Tb00kbKFax25GiK2fWs
         bPXg==
X-Gm-Message-State: APjAAAUiZzBSlom4HX8swoB+wnRrZEMC4T1kaJ9TztoXO5dKfMXtPpzM
        xa9iXFd0woeUOz3M2n2ROSU=
X-Google-Smtp-Source: APXvYqykZRyy/6u7w1sw/oOEVgc7rSa+la98X78ShyYpGDA0Lkun1UlDDItYRDFIkWZ+PXNzN1iq7w==
X-Received: by 2002:adf:ea85:: with SMTP id s5mr21798692wrm.75.1581945320842;
        Mon, 17 Feb 2020 05:15:20 -0800 (PST)
Received: from amir-ThinkPad-T480.ctera.local (bzq-166-168-31-246.red.bezeqint.net. [31.168.166.246])
        by smtp.gmail.com with ESMTPSA id m21sm545745wmi.27.2020.02.17.05.15.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2020 05:15:20 -0800 (PST)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 11/16] fanotify: prepare to encode both parent and child fid's
Date:   Mon, 17 Feb 2020 15:14:50 +0200
Message-Id: <20200217131455.31107-12-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200217131455.31107-1-amir73il@gmail.com>
References: <20200217131455.31107-1-amir73il@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

For some events, we are going to encode both child and parent fid's,
so we need to do a little refactoring of struct fanotify_event and fid
helper functions.

Move fsid member from struct fanotify_fid out to struct fanotify_event,
so we can store fsid once for two encoded fid's (we will only encode
parent if it is on the same filesystem).

This does not change the size of struct fanotify_event because struct
fanotify_fid is still bigger than struct path on 32bit arch and is the
same size as struct path (16 bytes) on 64bit arch.

Group fh_len and fh_type as struct fanotify_fid_hdr.
Pass struct fanotify_fid and struct fanotify_fid_hdr to helpers
fanotify_encode_fid() and copy_fid_to_user() instead of passing the
containing fanotify_event struct.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/notify/fanotify/fanotify.c      | 48 +++++++++++++------------
 fs/notify/fanotify/fanotify.h      | 58 ++++++++++++++++--------------
 fs/notify/fanotify/fanotify_user.c | 35 ++++++++++--------
 3 files changed, 78 insertions(+), 63 deletions(-)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index 1f60823931b7..3bc28f08aad1 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -27,7 +27,7 @@ static bool should_merge(struct fsnotify_event *old_fsn,
 	new = FANOTIFY_E(new_fsn);
 
 	if (old_fsn->tag != new_fsn->tag || old->pid != new->pid ||
-	    old->fh_type != new->fh_type || old->fh_len != new->fh_len)
+	    old->fh.type != new->fh.type || old->fh.len != new->fh.len)
 		return false;
 
 	if (fanotify_event_has_path(old)) {
@@ -43,7 +43,8 @@ static bool should_merge(struct fsnotify_event *old_fsn,
 		 * unlink pair or rmdir+create pair of events.
 		 */
 		return (old->mask & FS_ISDIR) == (new->mask & FS_ISDIR) &&
-			fanotify_fid_equal(&old->fid, &new->fid, old->fh_len);
+			fanotify_fsid_equal(&old->fsid, &new->fsid) &&
+			fanotify_fid_equal(&old->fid, &new->fid, old->fh.len);
 	}
 
 	/* Do not merge events if we failed to encode fid */
@@ -213,18 +214,18 @@ static u32 fanotify_group_event_mask(struct fsnotify_group *group,
 	return test_mask & user_mask;
 }
 
-static int fanotify_encode_fid(struct fanotify_event *event,
-			       struct inode *inode, gfp_t gfp,
-			       __kernel_fsid_t *fsid)
+static struct fanotify_fid_hdr fanotify_encode_fid(struct fanotify_fid *fid,
+						   struct inode *inode,
+						   gfp_t gfp)
 {
-	struct fanotify_fid *fid = &event->fid;
+	struct fanotify_fid_hdr fh = { };
 	int dwords, bytes = 0;
-	int err, type;
+	int err;
 
 	fid->ext_fh = NULL;
 	dwords = 0;
 	err = -ENOENT;
-	type = exportfs_encode_inode_fh(inode, NULL, &dwords, NULL);
+	fh.type = exportfs_encode_inode_fh(inode, NULL, &dwords, NULL);
 	if (!dwords)
 		goto out_err;
 
@@ -237,26 +238,25 @@ static int fanotify_encode_fid(struct fanotify_event *event,
 			goto out_err;
 	}
 
-	type = exportfs_encode_inode_fh(inode, fanotify_fid_fh(fid, bytes),
-					&dwords, NULL);
+	fh.type = exportfs_encode_inode_fh(inode, fanotify_fid_fh(fid, bytes),
+					   &dwords, NULL);
 	err = -EINVAL;
-	if (!type || type == FILEID_INVALID || bytes != dwords << 2)
+	if (!fh.type || fh.type == FILEID_INVALID || bytes != dwords << 2)
 		goto out_err;
 
-	fid->fsid = *fsid;
-	event->fh_len = bytes;
+	fh.len = bytes;
 
-	return type;
+	return fh;
 
 out_err:
-	pr_warn_ratelimited("fanotify: failed to encode fid (fsid=%x.%x, "
-			    "type=%d, bytes=%d, err=%i)\n",
-			    fsid->val[0], fsid->val[1], type, bytes, err);
+	pr_warn_ratelimited("fanotify: failed to encode fid (type=%d, len=%d, err=%i)\n",
+			    fh.type, bytes, err);
 	kfree(fid->ext_fh);
 	fid->ext_fh = NULL;
-	event->fh_len = 0;
+	fh.type = FILEID_INVALID;
+	fh.len = 0;
 
-	return FILEID_INVALID;
+	return fh;
 }
 
 /*
@@ -327,16 +327,18 @@ init: __maybe_unused
 		event->pid = get_pid(task_pid(current));
 	else
 		event->pid = get_pid(task_tgid(current));
-	event->fh_len = 0;
+	event->fh.len = 0;
+	if (fsid)
+		event->fsid = *fsid;
 	if (id && FAN_GROUP_FLAG(group, FAN_REPORT_FID)) {
 		/* Report the event without a file identifier on encode error */
 		event->fh_type = fanotify_encode_fid(event, id, gfp, fsid);
 	} else if (path) {
-		event->fh_type = FILEID_ROOT;
+		event->fh.type = FILEID_ROOT;
 		event->path = *path;
 		path_get(path);
 	} else {
-		event->fh_type = FILEID_INVALID;
+		event->fh.type = FILEID_INVALID;
 		event->path.mnt = NULL;
 		event->path.dentry = NULL;
 	}
@@ -485,7 +487,7 @@ static void fanotify_free_event(struct fsnotify_event *fsn_event)
 	event = FANOTIFY_E(fsn_event);
 	if (fanotify_event_has_path(event))
 		path_put(&event->path);
-	else if (fanotify_event_has_ext_fh(event))
+	else if (fanotify_fid_has_ext_fh(&event->fh))
 		kfree(event->fid.ext_fh);
 	put_pid(event->pid);
 	if (fanotify_is_perm_event(event->mask)) {
diff --git a/fs/notify/fanotify/fanotify.h b/fs/notify/fanotify/fanotify.h
index 68b30504284c..4fee002235b6 100644
--- a/fs/notify/fanotify/fanotify.h
+++ b/fs/notify/fanotify/fanotify.h
@@ -18,10 +18,10 @@ enum {
 
 /*
  * 3 dwords are sufficient for most local fs (64bit ino, 32bit generation).
- * For 32bit arch, fid increases the size of fanotify_event by 12 bytes and
- * fh_* fields increase the size of fanotify_event by another 4 bytes.
- * For 64bit arch, fid increases the size of fanotify_fid by 8 bytes and
- * fh_* fields are packed in a hole after mask.
+ * For 32bit arch, fsid and fid increase the size of fanotify_event by 12 bytes
+ * and fh.* fields increase the size of fanotify_event by another 4 bytes.
+ * For 64bit arch, fanotify_fid is the same size as struct path, fsid increases
+ * fanotify_event by 8 bytes and fh.* fields are packed in a hole after mask.
  */
 #if BITS_PER_LONG == 32
 #define FANOTIFY_INLINE_FH_LEN	(3 << 2)
@@ -29,28 +29,46 @@ enum {
 #define FANOTIFY_INLINE_FH_LEN	(4 << 2)
 #endif
 
+struct fanotify_fid_hdr {
+	u8 type;
+	u8 len;
+};
+
 struct fanotify_fid {
-	__kernel_fsid_t fsid;
 	union {
 		unsigned char fh[FANOTIFY_INLINE_FH_LEN];
 		unsigned char *ext_fh;
 	};
 };
 
+static inline bool fanotify_fid_has_fh(struct fanotify_fid_hdr *fh)
+{
+	return fh->type != FILEID_ROOT && fh->type != FILEID_INVALID;
+}
+
+static inline bool fanotify_fid_has_ext_fh(struct fanotify_fid_hdr *fh)
+{
+	return fanotify_fid_has_fh(fh) && fh->len > FANOTIFY_INLINE_FH_LEN;
+}
+
 static inline void *fanotify_fid_fh(struct fanotify_fid *fid,
 				    unsigned int fh_len)
 {
 	return fh_len <= FANOTIFY_INLINE_FH_LEN ? fid->fh : fid->ext_fh;
 }
 
+static inline bool fanotify_fsid_equal(__kernel_fsid_t *fsid1,
+				       __kernel_fsid_t *fsid2)
+{
+	return fsid1->val[0] == fsid1->val[0] && fsid2->val[1] == fsid2->val[1];
+}
+
 static inline bool fanotify_fid_equal(struct fanotify_fid *fid1,
 				      struct fanotify_fid *fid2,
 				      unsigned int fh_len)
 {
-	return fid1->fsid.val[0] == fid2->fsid.val[0] &&
-		fid1->fsid.val[1] == fid2->fsid.val[1] &&
-		!memcmp(fanotify_fid_fh(fid1, fh_len),
-			fanotify_fid_fh(fid2, fh_len), fh_len);
+	return !memcmp(fanotify_fid_fh(fid1, fh_len),
+		       fanotify_fid_fh(fid2, fh_len), fh_len);
 }
 
 /*
@@ -63,13 +81,13 @@ struct fanotify_event {
 	u32 mask;
 	/*
 	 * Those fields are outside fanotify_fid to pack fanotify_event nicely
-	 * on 64bit arch and to use fh_type as an indication of whether path
+	 * on 64bit arch and to use fh.type as an indication of whether path
 	 * or fid are used in the union:
 	 * FILEID_ROOT (0) for path, > 0 for fid, FILEID_INVALID for neither.
 	 */
-	u8 fh_type;
-	u8 fh_len;
+	struct fanotify_fid_hdr fh;
 	u16 pad;
+	__kernel_fsid_t fsid;
 	union {
 		/*
 		 * We hold ref to this path so it may be dereferenced at any
@@ -88,24 +106,12 @@ struct fanotify_event {
 
 static inline bool fanotify_event_has_path(struct fanotify_event *event)
 {
-	return event->fh_type == FILEID_ROOT;
+	return event->fh.type == FILEID_ROOT;
 }
 
 static inline bool fanotify_event_has_fid(struct fanotify_event *event)
 {
-	return event->fh_type != FILEID_ROOT &&
-		event->fh_type != FILEID_INVALID;
-}
-
-static inline bool fanotify_event_has_ext_fh(struct fanotify_event *event)
-{
-	return fanotify_event_has_fid(event) &&
-		event->fh_len > FANOTIFY_INLINE_FH_LEN;
-}
-
-static inline void *fanotify_event_fh(struct fanotify_event *event)
-{
-	return fanotify_fid_fh(&event->fid, event->fh_len);
+	return fanotify_fid_has_fh(&event->fh);
 }
 
 /*
diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index 0aa362b88550..beb9f0661a7c 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -51,14 +51,19 @@ struct kmem_cache *fanotify_perm_event_cachep __read_mostly;
 
 #define FANOTIFY_EVENT_ALIGN 4
 
+static int fanotify_fid_info_len(struct fanotify_fid_hdr *fh)
+{
+	return roundup(sizeof(struct fanotify_event_info_fid) +
+		       sizeof(struct file_handle) + fh->len,
+		       FANOTIFY_EVENT_ALIGN);
+}
+
 static int fanotify_event_info_len(struct fanotify_event *event)
 {
 	if (!fanotify_event_has_fid(event))
 		return 0;
 
-	return roundup(sizeof(struct fanotify_event_info_fid) +
-		       sizeof(struct file_handle) + event->fh_len,
-		       FANOTIFY_EVENT_ALIGN);
+	return fanotify_fid_info_len(&event->fh);
 }
 
 /*
@@ -204,13 +209,14 @@ static int process_access_response(struct fsnotify_group *group,
 	return -ENOENT;
 }
 
-static int copy_fid_to_user(struct fanotify_event *event, char __user *buf)
+static int copy_fid_to_user(__kernel_fsid_t *fsid, struct fanotify_fid_hdr *fh,
+			    struct fanotify_fid *fid, char __user *buf)
 {
 	struct fanotify_event_info_fid info = { };
 	struct file_handle handle = { };
-	unsigned char bounce[FANOTIFY_INLINE_FH_LEN], *fh;
-	size_t fh_len = event->fh_len;
-	size_t len = fanotify_event_info_len(event);
+	unsigned char bounce[FANOTIFY_INLINE_FH_LEN], *data;
+	size_t fh_len = fh->len;
+	size_t len = fanotify_fid_info_len(fh);
 
 	if (!len)
 		return 0;
@@ -221,13 +227,13 @@ static int copy_fid_to_user(struct fanotify_event *event, char __user *buf)
 	/* Copy event info fid header followed by vaiable sized file handle */
 	info.hdr.info_type = FAN_EVENT_INFO_TYPE_FID;
 	info.hdr.len = len;
-	info.fsid = event->fid.fsid;
+	info.fsid = *fsid;
 	if (copy_to_user(buf, &info, sizeof(info)))
 		return -EFAULT;
 
 	buf += sizeof(info);
 	len -= sizeof(info);
-	handle.handle_type = event->fh_type;
+	handle.handle_type = fh->type;
 	handle.handle_bytes = fh_len;
 	if (copy_to_user(buf, &handle, sizeof(handle)))
 		return -EFAULT;
@@ -238,12 +244,12 @@ static int copy_fid_to_user(struct fanotify_event *event, char __user *buf)
 	 * For an inline fh, copy through stack to exclude the copy from
 	 * usercopy hardening protections.
 	 */
-	fh = fanotify_event_fh(event);
+	data = fanotify_fid_fh(fid, fh_len);
 	if (fh_len <= FANOTIFY_INLINE_FH_LEN) {
-		memcpy(bounce, fh, fh_len);
-		fh = bounce;
+		memcpy(bounce, data, fh_len);
+		data = bounce;
 	}
-	if (copy_to_user(buf, fh, fh_len))
+	if (copy_to_user(buf, data, fh_len))
 		return -EFAULT;
 
 	/* Pad with 0's */
@@ -301,7 +307,8 @@ static ssize_t copy_event_to_user(struct fsnotify_group *group,
 	if (fanotify_event_has_path(event)) {
 		fd_install(fd, f);
 	} else if (fanotify_event_has_fid(event)) {
-		ret = copy_fid_to_user(event, buf + FAN_EVENT_METADATA_LEN);
+		ret = copy_fid_to_user(&event->fsid, &event->fh, &event->fid,
+				       buf + FAN_EVENT_METADATA_LEN);
 		if (ret < 0)
 			return ret;
 	}
-- 
2.17.1

