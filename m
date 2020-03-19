Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CBDF118BAAE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Mar 2020 16:11:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727860AbgCSPLD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Mar 2020 11:11:03 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45278 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727788AbgCSPLC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Mar 2020 11:11:02 -0400
Received: by mail-wr1-f68.google.com with SMTP id i9so3430993wrx.12
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Mar 2020 08:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=q0X/T/ayuQhURy/YnvF8QKmjOUhV9e//GkpfBUDO2lI=;
        b=UWsIpJBPZVRhKE3GJnj84KapVovoDcLto+cwNJn00SQART9/oiJjsF6eU0zd+O2tmC
         fM2Ayxvach4QWx0V5If/yM0Dpy61NQmLIfLuhiHnPnQVV6f2hyA4aCH8fAmvxoz00LcO
         kUY4ScA+gnzxI5dhrCHtO2qgCgdQLt6c8kYJau7ePBRaQfusxHuxJ8Ky66nV4OF6pR9y
         Wlf16ZgfpB6czywx8/L4SxaSKGo14+iM2oRdvsyjmF4/T0+T/BdJ7odtXinfU3CuUvZ/
         zeLW0Nm297kqFUCVHWROLMKuucAtk6YqU/uFPCWg6rBpwZX+RGrtEJGL/uOZH1HM2L8Z
         zCGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=q0X/T/ayuQhURy/YnvF8QKmjOUhV9e//GkpfBUDO2lI=;
        b=T/Q1ygGUovbIGTB7pg00FDGtx/bZ/SMBHMKJtzbzdBLYBqBX99iVDVFGAnDgENSy8N
         IMtUOeX3P1UAF14Ribm+1tSk3ZpFZYs+iI5acuOZleQj2FQNf1+KT9f1Eavi8eVVAa32
         KHi/H885YaaATK0Wr3/gdxVSNjBx8J66L+N1FSO9XFb+6VhSyBlO2RplUasctyQLkI+C
         VyvczJdE6uVaukT2zLrEOd1G9fT8FAYuk2qYJ8hghaffUNePfakIc4UTgECkwytNvOJJ
         YUccuE9J2Fj2kxP0H0KKeQw2DTqZ9WYXtBDzz56PnKIL1XODqKE0yszupt8O6dVgcncn
         Hz0w==
X-Gm-Message-State: ANhLgQ0ML47y/5Xx5jMzPXfJO+q1a8duUJYnw7+H7ohXLMbOaU+XWTPZ
        CL97y96EyKBXuL0Q+8h2T2E=
X-Google-Smtp-Source: ADFU+vuWjG9Qp3FPzufNExZ51XMThavFoyayRo2i3ipwomZhVCBwcs6DT39FNFIA44WfBBrRHEv2xw==
X-Received: by 2002:a5d:5388:: with SMTP id d8mr4685284wrv.270.1584630660388;
        Thu, 19 Mar 2020 08:11:00 -0700 (PDT)
Received: from localhost.localdomain ([141.226.9.174])
        by smtp.gmail.com with ESMTPSA id t193sm3716959wmt.14.2020.03.19.08.10.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2020 08:10:59 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 14/14] fanotify: report name info for FAN_DIR_MODIFY event
Date:   Thu, 19 Mar 2020 17:10:22 +0200
Message-Id: <20200319151022.31456-15-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200319151022.31456-1-amir73il@gmail.com>
References: <20200319151022.31456-1-amir73il@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Report event FAN_DIR_MODIFY with name in a variable length record similar
to how fid's are reported.  With name info reporting implemented, setting
FAN_DIR_MODIFY in mark mask is now allowed.

When events are reported with name, the reported fid identifies the
directory and the name follows the fid. The info record type for this
event info is FAN_EVENT_INFO_TYPE_DFID_NAME.

For now, all reported events have at most one info record which is
either FAN_EVENT_INFO_TYPE_FID or FAN_EVENT_INFO_TYPE_DFID_NAME (for
FAN_DIR_MODIFY).  Later on, events "on child" will report both records.

There are several ways that an application can use this information:

1. When watching a single directory, the name is always relative to
the watched directory, so application need to fstatat(2) the name
relative to the watched directory.

2. When watching a set of directories, the application could keep a map
of dirfd for all watched directories and hash the map by fid obtained
with name_to_handle_at(2).  When getting a name event, the fid in the
event info could be used to lookup the base dirfd in the map and then
call fstatat(2) with that dirfd.

3. When watching a filesystem (FAN_MARK_FILESYSTEM) or a large set of
directories, the application could use open_by_handle_at(2) with the fid
in event info to obtain dirfd for the directory where event happened and
call fstatat(2) with this dirfd.

The last option scales better for a large number of watched directories.
The first two options may be available in the future also for non
privileged fanotify watchers, because open_by_handle_at(2) requires
the CAP_DAC_READ_SEARCH capability.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/notify/fanotify/fanotify.c      |   2 +-
 fs/notify/fanotify/fanotify_user.c | 109 +++++++++++++++++++++++------
 include/linux/fanotify.h           |   3 +-
 include/uapi/linux/fanotify.h      |   1 +
 4 files changed, 90 insertions(+), 25 deletions(-)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index 22e198ab2687..c07b1891a720 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -526,7 +526,7 @@ static int fanotify_handle_event(struct fsnotify_group *group,
 	BUILD_BUG_ON(FAN_OPEN_EXEC != FS_OPEN_EXEC);
 	BUILD_BUG_ON(FAN_OPEN_EXEC_PERM != FS_OPEN_EXEC_PERM);
 
-	BUILD_BUG_ON(HWEIGHT32(ALL_FANOTIFY_EVENT_BITS) != 19);
+	BUILD_BUG_ON(HWEIGHT32(ALL_FANOTIFY_EVENT_BITS) != 20);
 
 	mask = fanotify_group_event_mask(group, iter_info, mask, data,
 					 data_type);
diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index 2eff2cfa88ce..95256baeb808 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -51,22 +51,35 @@ struct kmem_cache *fanotify_path_event_cachep __read_mostly;
 struct kmem_cache *fanotify_perm_event_cachep __read_mostly;
 
 #define FANOTIFY_EVENT_ALIGN 4
+#define FANOTIFY_INFO_HDR_LEN \
+	(sizeof(struct fanotify_event_info_fid) + sizeof(struct file_handle))
 
-static int fanotify_fid_info_len(int fh_len)
+static int fanotify_fid_info_len(int fh_len, int name_len)
 {
-	return roundup(sizeof(struct fanotify_event_info_fid) +
-		       sizeof(struct file_handle) + fh_len,
-		       FANOTIFY_EVENT_ALIGN);
+	int info_len = fh_len;
+
+	if (name_len)
+		info_len += name_len + 1;
+
+	return roundup(FANOTIFY_INFO_HDR_LEN + info_len, FANOTIFY_EVENT_ALIGN);
 }
 
 static int fanotify_event_info_len(struct fanotify_event *event)
 {
+	int info_len = 0;
 	int fh_len = fanotify_event_object_fh_len(event);
 
-	if (!fh_len)
-		return 0;
+	if (fh_len)
+		info_len += fanotify_fid_info_len(fh_len, 0);
 
-	return fanotify_fid_info_len(fh_len);
+	if (fanotify_event_name_len(event)) {
+		struct fanotify_name_event *fne = FANOTIFY_NE(event);
+
+		info_len += fanotify_fid_info_len(fne->dir_fh.len,
+						  fne->name_len);
+	}
+
+	return info_len;
 }
 
 /*
@@ -206,23 +219,32 @@ static int process_access_response(struct fsnotify_group *group,
 	return -ENOENT;
 }
 
-static int copy_fid_to_user(__kernel_fsid_t *fsid, struct fanotify_fh *fh,
-			    char __user *buf)
+static int copy_info_to_user(__kernel_fsid_t *fsid, struct fanotify_fh *fh,
+			     const char *name, size_t name_len,
+			     char __user *buf, size_t count)
 {
 	struct fanotify_event_info_fid info = { };
 	struct file_handle handle = { };
 	unsigned char bounce[FANOTIFY_INLINE_FH_LEN], *fh_buf;
 	size_t fh_len = fh ? fh->len : 0;
-	size_t len = fanotify_fid_info_len(fh_len);
+	size_t info_len = fanotify_fid_info_len(fh_len, name_len);
+	size_t len = info_len;
+
+	pr_debug("%s: fh_len=%zu name_len=%zu, info_len=%zu, count=%zu\n",
+		 __func__, fh_len, name_len, info_len, count);
 
-	if (!len)
+	if (!fh_len || (name && !name_len))
 		return 0;
 
-	if (WARN_ON_ONCE(len < sizeof(info) + sizeof(handle) + fh_len))
+	if (WARN_ON_ONCE(len < sizeof(info) || len > count))
 		return -EFAULT;
 
-	/* Copy event info fid header followed by vaiable sized file handle */
-	info.hdr.info_type = FAN_EVENT_INFO_TYPE_FID;
+	/*
+	 * Copy event info fid header followed by variable sized file handle
+	 * and optionally followed by variable sized filename.
+	 */
+	info.hdr.info_type = name_len ? FAN_EVENT_INFO_TYPE_DFID_NAME :
+					FAN_EVENT_INFO_TYPE_FID;
 	info.hdr.len = len;
 	info.fsid = *fsid;
 	if (copy_to_user(buf, &info, sizeof(info)))
@@ -230,6 +252,9 @@ static int copy_fid_to_user(__kernel_fsid_t *fsid, struct fanotify_fh *fh,
 
 	buf += sizeof(info);
 	len -= sizeof(info);
+	if (WARN_ON_ONCE(len < sizeof(handle)))
+		return -EFAULT;
+
 	handle.handle_type = fh->type;
 	handle.handle_bytes = fh_len;
 	if (copy_to_user(buf, &handle, sizeof(handle)))
@@ -237,9 +262,12 @@ static int copy_fid_to_user(__kernel_fsid_t *fsid, struct fanotify_fh *fh,
 
 	buf += sizeof(handle);
 	len -= sizeof(handle);
+	if (WARN_ON_ONCE(len < fh_len))
+		return -EFAULT;
+
 	/*
-	 * For an inline fh, copy through stack to exclude the copy from
-	 * usercopy hardening protections.
+	 * For an inline fh and inline file name, copy through stack to exclude
+	 * the copy from usercopy hardening protections.
 	 */
 	fh_buf = fanotify_fh_buf(fh);
 	if (fh_len <= FANOTIFY_INLINE_FH_LEN) {
@@ -249,14 +277,28 @@ static int copy_fid_to_user(__kernel_fsid_t *fsid, struct fanotify_fh *fh,
 	if (copy_to_user(buf, fh_buf, fh_len))
 		return -EFAULT;
 
-	/* Pad with 0's */
 	buf += fh_len;
 	len -= fh_len;
+
+	if (name_len) {
+		/* Copy the filename with terminating null */
+		name_len++;
+		if (WARN_ON_ONCE(len < name_len))
+			return -EFAULT;
+
+		if (copy_to_user(buf, name, name_len))
+			return -EFAULT;
+
+		buf += name_len;
+		len -= name_len;
+	}
+
+	/* Pad with 0's */
 	WARN_ON_ONCE(len < 0 || len >= FANOTIFY_EVENT_ALIGN);
 	if (len > 0 && clear_user(buf, len))
 		return -EFAULT;
 
-	return 0;
+	return info_len;
 }
 
 static ssize_t copy_event_to_user(struct fsnotify_group *group,
@@ -298,17 +340,38 @@ static ssize_t copy_event_to_user(struct fsnotify_group *group,
 	if (copy_to_user(buf, &metadata, FAN_EVENT_METADATA_LEN))
 		goto out_close_fd;
 
+	buf += FAN_EVENT_METADATA_LEN;
+	count -= FAN_EVENT_METADATA_LEN;
+
 	if (fanotify_is_perm_event(event->mask))
 		FANOTIFY_PERM(fsn_event)->fd = fd;
 
-	if (f) {
+	if (f)
 		fd_install(fd, f);
-	} else if (fanotify_event_has_fid(event)) {
-		ret = copy_fid_to_user(fanotify_event_fsid(event),
-				       fanotify_event_object_fh(event),
-				       buf + FAN_EVENT_METADATA_LEN);
+
+	/* Event info records order is: dir fid + name, child fid */
+	if (fanotify_event_name_len(event)) {
+		struct fanotify_name_event *fne = FANOTIFY_NE(event);
+
+		ret = copy_info_to_user(fanotify_event_fsid(event),
+					&fne->dir_fh, fne->name, fne->name_len,
+					buf, count);
 		if (ret < 0)
 			return ret;
+
+		buf += ret;
+		count -= ret;
+	}
+
+	if (fanotify_event_object_fh_len(event)) {
+		ret = copy_info_to_user(fanotify_event_fsid(event),
+					fanotify_event_object_fh(event),
+					NULL, 0, buf, count);
+		if (ret < 0)
+			return ret;
+
+		buf += ret;
+		count -= ret;
 	}
 
 	return metadata.event_len;
diff --git a/include/linux/fanotify.h b/include/linux/fanotify.h
index b79fa9bb7359..3049a6c06d9e 100644
--- a/include/linux/fanotify.h
+++ b/include/linux/fanotify.h
@@ -47,7 +47,8 @@
  * Directory entry modification events - reported only to directory
  * where entry is modified and not to a watching parent.
  */
-#define FANOTIFY_DIRENT_EVENTS	(FAN_MOVE | FAN_CREATE | FAN_DELETE)
+#define FANOTIFY_DIRENT_EVENTS	(FAN_MOVE | FAN_CREATE | FAN_DELETE | \
+				 FAN_DIR_MODIFY)
 
 /* Events that can only be reported with data type FSNOTIFY_EVENT_INODE */
 #define FANOTIFY_INODE_EVENTS	(FANOTIFY_DIRENT_EVENTS | \
diff --git a/include/uapi/linux/fanotify.h b/include/uapi/linux/fanotify.h
index 615fa2c87179..2b56e194b858 100644
--- a/include/uapi/linux/fanotify.h
+++ b/include/uapi/linux/fanotify.h
@@ -117,6 +117,7 @@ struct fanotify_event_metadata {
 };
 
 #define FAN_EVENT_INFO_TYPE_FID		1
+#define FAN_EVENT_INFO_TYPE_DFID_NAME	2
 
 /* Variable length info record following event metadata */
 struct fanotify_event_info_header {
-- 
2.17.1

