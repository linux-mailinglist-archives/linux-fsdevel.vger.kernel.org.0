Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C550C1612F4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2020 14:16:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729030AbgBQNP1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Feb 2020 08:15:27 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39939 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729062AbgBQNP0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Feb 2020 08:15:26 -0500
Received: by mail-wr1-f68.google.com with SMTP id t3so19676958wru.7;
        Mon, 17 Feb 2020 05:15:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VlYgvIwOdhyhUz4lK253x8q9VozlyCJr3zdxshyY+mw=;
        b=MI1CsE3t508bvqGqsR/YJOYTgE4BHulTJmrTHvlwbfU557s/0tkF6F/priYIEdFP0k
         lrlWyoaiklt6lxareJN+oz+RKCbw6s50n6m8DJ/BCBA41YR1iGf77n5JREsF+qeJHptW
         xYG7u7L6NU4WLyWUzvNNlp1Xh55xmaS8wAn0h1kGpIj0MJOQnHc+vVgNjx8QlAOWb7Z3
         eRXi3ggkxZAXrwbFc3UElXjBO8wVYoXcOx9iIRCs51n2OjrLR0ejKNIGSuZbtAg5+f55
         Y5N4M3y36q6q159JOK8MmJ+hbjF/8qHckryW6rZg/+E84YfcnZv2NT/z49hqraDC2b7n
         eQ/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VlYgvIwOdhyhUz4lK253x8q9VozlyCJr3zdxshyY+mw=;
        b=XhdcBmqAtY0phDAjTvBB+d2lhnfFX4w446dvkNRYFgsUSw0nGS3vUt7ESVH8p4KuYS
         OF4X5cquaQR7CUjlg9mhb3i910JCb2qhXw8Mil49PG2HcsylWclJfpmYBi89v5bySEdL
         81piiOZc+3T9cxR6e//EICLcDQ4xWNsstVEMauAku9MulrC4YNolaFrFKsYCkEWhor1F
         +o5AhaGFBjbM9n4B1h9TxsSjsd4lBsnZT3XBogiJLStPgWuJFGtfWf2zOt04ZB6x2TLd
         TTiGzXykIx4NQ+N+0jtoxbdAQe0ptWKGhTwhxcBYaTRsMp0yXLQweeR/EuXmHHKJeC30
         SDeA==
X-Gm-Message-State: APjAAAVh4igHzg4ASRXHlY7gL9LtSZJAQLunDJrK5HyRofqL2guzyysK
        QbK0O044hAPjmiLcpO069Vs=
X-Google-Smtp-Source: APXvYqzmUIQoOqIgTBovSm/QkZx5mdkuDOVo9yqPteD/kS0Fn+nzk0DQFVV8CpvZnFE3r9ryAqFb2A==
X-Received: by 2002:adf:ca07:: with SMTP id o7mr21638636wrh.49.1581945323285;
        Mon, 17 Feb 2020 05:15:23 -0800 (PST)
Received: from amir-ThinkPad-T480.ctera.local (bzq-166-168-31-246.red.bezeqint.net. [31.168.166.246])
        by smtp.gmail.com with ESMTPSA id m21sm545745wmi.27.2020.02.17.05.15.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2020 05:15:22 -0800 (PST)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
Subject: [PATCH v2 13/16] fanotify: report name info for FAN_DIR_MODIFY event
Date:   Mon, 17 Feb 2020 15:14:52 +0200
Message-Id: <20200217131455.31107-14-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200217131455.31107-1-amir73il@gmail.com>
References: <20200217131455.31107-1-amir73il@gmail.com>
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
 fs/notify/fanotify/fanotify_user.c | 120 ++++++++++++++++++++++-------
 include/linux/fanotify.h           |   3 +-
 include/uapi/linux/fanotify.h      |   1 +
 4 files changed, 98 insertions(+), 28 deletions(-)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index fc75dc53a218..b651c18d3a93 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -478,7 +478,7 @@ static int fanotify_handle_event(struct fsnotify_group *group,
 	BUILD_BUG_ON(FAN_OPEN_EXEC != FS_OPEN_EXEC);
 	BUILD_BUG_ON(FAN_OPEN_EXEC_PERM != FS_OPEN_EXEC_PERM);
 
-	BUILD_BUG_ON(HWEIGHT32(ALL_FANOTIFY_EVENT_BITS) != 19);
+	BUILD_BUG_ON(HWEIGHT32(ALL_FANOTIFY_EVENT_BITS) != 20);
 
 	mask = fanotify_group_event_mask(group, iter_info, mask, data,
 					 data_type);
diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index 284f3548bb79..a1bafc21ebbb 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -51,20 +51,32 @@ struct kmem_cache *fanotify_name_event_cachep __read_mostly;
 struct kmem_cache *fanotify_perm_event_cachep __read_mostly;
 
 #define FANOTIFY_EVENT_ALIGN 4
+#define FANOTIFY_INFO_HDR_LEN \
+	(sizeof(struct fanotify_event_info_fid) + sizeof(struct file_handle))
 
-static int fanotify_fid_info_len(struct fanotify_fid_hdr *fh)
+static int fanotify_fid_info_len(int fh_len, int name_len)
 {
-	return roundup(sizeof(struct fanotify_event_info_fid) +
-		       sizeof(struct file_handle) + fh->len,
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
-	if (!fanotify_event_has_fid(event))
-		return 0;
+	int info_len = 0;
+
+	if (fanotify_event_has_fid(event))
+		info_len += fanotify_fid_info_len(event->fh.len, 0);
+
+	if (fanotify_event_has_dfid_name(event)) {
+		info_len += fanotify_fid_info_len(event->dfh.len,
+					fanotify_event_name_len(event));
+	}
 
-	return fanotify_fid_info_len(&event->fh);
+	return info_len;
 }
 
 /*
@@ -210,23 +222,34 @@ static int process_access_response(struct fsnotify_group *group,
 	return -ENOENT;
 }
 
-static int copy_fid_to_user(__kernel_fsid_t *fsid, struct fanotify_fid_hdr *fh,
-			    struct fanotify_fid *fid, char __user *buf)
+static int copy_info_to_user(__kernel_fsid_t *fsid, struct fanotify_fid_hdr *fh,
+			     struct fanotify_fid *fid, const struct qstr *name,
+			     char __user *buf, size_t count)
 {
 	struct fanotify_event_info_fid info = { };
 	struct file_handle handle = { };
-	unsigned char bounce[FANOTIFY_INLINE_FH_LEN], *data;
+	unsigned char bounce[max(FANOTIFY_INLINE_FH_LEN, DNAME_INLINE_LEN)];
+	const unsigned char *data;
 	size_t fh_len = fh->len;
-	size_t len = fanotify_fid_info_len(fh);
+	size_t name_len = name ? name->len : 0;
+	size_t info_len = fanotify_fid_info_len(fh_len, name_len);
+	size_t len = info_len;
+
+	pr_debug("%s: fh_len=%lu name_len=%lu, info_len=%lu, count=%lu\n",
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
+	 * Copy event info fid header followed by vaiable sized file handle
+	 * and optionally followed by vaiable sized filename.
+	 */
+	info.hdr.info_type = name_len ? FAN_EVENT_INFO_TYPE_DFID_NAME :
+					FAN_EVENT_INFO_TYPE_FID;
 	info.hdr.len = len;
 	info.fsid = *fsid;
 	if (copy_to_user(buf, &info, sizeof(info)))
@@ -234,6 +257,9 @@ static int copy_fid_to_user(__kernel_fsid_t *fsid, struct fanotify_fid_hdr *fh,
 
 	buf += sizeof(info);
 	len -= sizeof(info);
+	if (WARN_ON_ONCE(len < sizeof(handle)))
+		return -EFAULT;
+
 	handle.handle_type = fh->type;
 	handle.handle_bytes = fh_len;
 	if (copy_to_user(buf, &handle, sizeof(handle)))
@@ -241,9 +267,12 @@ static int copy_fid_to_user(__kernel_fsid_t *fsid, struct fanotify_fid_hdr *fh,
 
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
 	data = fanotify_fid_fh(fid, fh_len);
 	if (fh_len <= FANOTIFY_INLINE_FH_LEN) {
@@ -253,14 +282,33 @@ static int copy_fid_to_user(__kernel_fsid_t *fsid, struct fanotify_fid_hdr *fh,
 	if (copy_to_user(buf, data, fh_len))
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
+		data = name->name;
+		if (name_len <= DNAME_INLINE_LEN) {
+			memcpy(bounce, data, name_len);
+			data = bounce;
+		}
+		if (copy_to_user(buf, data, name_len))
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
@@ -282,12 +330,12 @@ static ssize_t copy_event_to_user(struct fsnotify_group *group,
 	metadata.mask = event->mask & FANOTIFY_OUTGOING_EVENTS;
 	metadata.pid = pid_vnr(event->pid);
 
-	if (fanotify_event_has_path(event)) {
+	if (FAN_GROUP_FLAG(group, FAN_REPORT_FID)) {
+		metadata.event_len += fanotify_event_info_len(event);
+	} else if (fanotify_event_has_path(event)) {
 		fd = create_fd(group, event, &f);
 		if (fd < 0)
 			return fd;
-	} else if (fanotify_event_has_fid(event)) {
-		metadata.event_len += fanotify_event_info_len(event);
 	}
 	metadata.fd = fd;
 
@@ -302,16 +350,36 @@ static ssize_t copy_event_to_user(struct fsnotify_group *group,
 	if (copy_to_user(buf, &metadata, FAN_EVENT_METADATA_LEN))
 		goto out_close_fd;
 
+	buf += FAN_EVENT_METADATA_LEN;
+	count -= FAN_EVENT_METADATA_LEN;
+
 	if (fanotify_is_perm_event(event->mask))
 		FANOTIFY_PE(fsn_event)->fd = fd;
 
-	if (fanotify_event_has_path(event)) {
+	if (f)
 		fd_install(fd, f);
-	} else if (fanotify_event_has_fid(event)) {
-		ret = copy_fid_to_user(&event->fsid, &event->fh, &event->fid,
-				       buf + FAN_EVENT_METADATA_LEN);
+
+	/* Event info records order is: dir fid + name, child fid */
+	if (fanotify_event_has_dfid_name(event)) {
+		struct fanotify_name_event *fne = FANOTIFY_NE(fsn_event);
+
+		ret = copy_info_to_user(&event->fsid, &event->dfh, &fne->dfid,
+					&fne->name, buf, count);
 		if (ret < 0)
 			return ret;
+
+		buf += ret;
+		count -= ret;
+	}
+
+	if (fanotify_event_has_fid(event)) {
+		ret = copy_info_to_user(&event->fsid, &event->fh, &event->fid,
+					NULL, buf, count);
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

