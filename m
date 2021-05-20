Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66A35389B33
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 May 2021 04:12:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230192AbhETCN0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 May 2021 22:13:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbhETCNZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 May 2021 22:13:25 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D90EC061574
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 May 2021 19:12:04 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id g24so8292918pji.4
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 May 2021 19:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/EJ3ybbLlAvMvWqdwXpWSsfLx1rBXU1AWGDgNjqNsOk=;
        b=QOjopBLTUwLRLrmkpJM+s7jmyB+aCIkh7l2eKqdX6CPrVde2L58ODG8wR+xOPLL20q
         YHs0gHj0ZZM43nylrARXM1mVlsNX/ghmrUZ0wR4OMsEVTHq0ZUerdFKxyT//7GXHYU0H
         hCeU5xoPAjWOvmy/Ft62VRU4BDHWZpzDIXcMZLbKYXApgW7aZJu1E1hTdCDvlZSrORmu
         Emj0zvGaErKh/bQzFew+BjQ/fM2FRqRdGydqxM3RkD9SGTxcSYhxBlvZJaOoHe6mhsyp
         74pLqjzQPcZNGQw2/nCD4bkSv7aR6oNUlLxxInvXZj1S4zNXGQwtpaBqwuhtzC3vZPvt
         tsOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/EJ3ybbLlAvMvWqdwXpWSsfLx1rBXU1AWGDgNjqNsOk=;
        b=K0VN1B2ABReteh5/rHQVU2vp9r/+NoBVQt9acj/SkPVNZ96URhskfFaPYxnwH6wXjs
         n0y5itw6pyY2nIVJw/NKoYz11cnCAyzmJdTzlysw6KM09NRFGehha7idqpbsgUMeokLB
         Xe9PsVqKoNj0Pguqj9x11U3iipvUOyaW+opNUBHtjjRrzyrllK7JQ9RiAIWQzyqX4rpI
         211eMQDpQe/9Abtt6BENfDX1vPxe9rcAJfE3ExEdTd7O8KMPNn+ThfOCKbjB7vFQENQJ
         W55ukjb0xVBpCvan7cVs2R5ePPp21fVfs5bSqBHpHZ5ByPLi7EIXmDxjhF+V4gu3YK29
         5rRw==
X-Gm-Message-State: AOAM532Xjy6Tuis4i9tLoGYhK1wAIZhLCfa4J0CLqVQ/qHl8b/TbDZIs
        K1DwVSEDKu07F63OZ54f2hr4Tg==
X-Google-Smtp-Source: ABdhPJxjVNryradT4ii4K5A3cSGwr6iUtKWnQmLopPmLVMYzZ0ZjAlw7x0U15uanQN8UQKvoCL7uew==
X-Received: by 2002:a17:90a:f987:: with SMTP id cq7mr2587575pjb.30.1621476723415;
        Wed, 19 May 2021 19:12:03 -0700 (PDT)
Received: from google.com ([2401:fa00:9:211:c035:b02d:975d:1161])
        by smtp.gmail.com with ESMTPSA id d17sm525196pfq.28.2021.05.19.19.12.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 19:12:03 -0700 (PDT)
Date:   Thu, 20 May 2021 12:11:51 +1000
From:   Matthew Bobrowski <repnop@google.com>
To:     jack@suse.cz, amir73il@gmail.com, christian.brauner@ubuntu.com
Cc:     linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
Subject: [PATCH 5/5] fanotify: Add pidfd info record support to the fanotify
 API
Message-ID: <48d18055deb4617d97c695a08dca77eb573097e9.1621473846.git.repnop@google.com>
References: <cover.1621473846.git.repnop@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1621473846.git.repnop@google.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Introduce a new flag FAN_REPORT_PIDFD for fanotify_init(2) which
allows userspace applications to control whether a pidfd info record
containing a pidfd is to be returned with each event.

If FAN_REPORT_PIDFD is enabled for a notification group, an additional
struct fanotify_event_info_pidfd object will be supplied alongside the
generic struct fanotify_event_metadata within a single event. This
functionality is analogous to that of FAN_REPORT_FID in terms of how
the event structure is supplied to the userspace application. Usage of
FAN_REPORT_PIDFD with FAN_REPORT_FID/FAN_REPORT_DFID_NAME is
permitted, and in this case a struct fanotify_event_info_pidfd object
will follow any struct fanotify_event_info_fid object.

Usage of FAN_REPORT_TID is not permitted with FAN_REPORT_PIDFD as the
pidfd API only supports the creation of pidfds for thread-group
leaders. Attempting to do so will result with a -EINVAL being returned
when calling fanotify_init(2).

If pidfd creation fails via pidfd_create(), the pidfd field within
struct fanotify_event_info_pidfd is set to FAN_NOPIDFD.

Signed-off-by: Matthew Bobrowski <repnop@google.com>
---
 fs/notify/fanotify/fanotify_user.c | 65 +++++++++++++++++++++++++++---
 include/linux/fanotify.h           |  3 +-
 include/uapi/linux/fanotify.h      | 12 ++++++
 3 files changed, 74 insertions(+), 6 deletions(-)

diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index 1e15f3222eb2..bba61988f4a0 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -106,6 +106,8 @@ struct kmem_cache *fanotify_perm_event_cachep __read_mostly;
 #define FANOTIFY_EVENT_ALIGN 4
 #define FANOTIFY_FID_INFO_HDR_LEN \
 	(sizeof(struct fanotify_event_info_fid) + sizeof(struct file_handle))
+#define FANOTIFY_PIDFD_INFO_HDR_LEN \
+	sizeof(struct fanotify_event_info_pidfd)
 
 static int fanotify_fid_info_len(int fh_len, int name_len)
 {
@@ -141,6 +143,9 @@ static int fanotify_event_info_len(unsigned int info_mode,
 	if (fh_len)
 		info_len += fanotify_fid_info_len(fh_len, dot_len);
 
+	if (info_mode & FAN_REPORT_PIDFD)
+		info_len += FANOTIFY_PIDFD_INFO_HDR_LEN;
+
 	return info_len;
 }
 
@@ -401,6 +406,29 @@ static int copy_fid_info_to_user(__kernel_fsid_t *fsid,
 	return info_len;
 }
 
+static int copy_pidfd_info_to_user(struct pid *pid,
+				   char __user *buf,
+				   size_t count)
+{
+	struct fanotify_event_info_pidfd info = { };
+	size_t info_len = FANOTIFY_PIDFD_INFO_HDR_LEN;
+
+	if (WARN_ON_ONCE(info_len > count))
+		return -EFAULT;
+
+	info.hdr.info_type = FAN_EVENT_INFO_TYPE_PIDFD;
+	info.hdr.len = info_len;
+
+	info.pidfd = pidfd_create(pid, 0);
+	if (info.pidfd < 0)
+		info.pidfd = FAN_NOPIDFD;
+
+	if (copy_to_user(buf, &info, info_len))
+		return -EFAULT;
+
+	return info_len;
+}
+
 static int copy_info_to_user(struct fanotify_event *event,
 			     struct fanotify_info *info,
 			     unsigned int info_mode,
@@ -408,9 +436,12 @@ static int copy_info_to_user(struct fanotify_event *event,
 {
 	int ret, info_type = 0;
 	unsigned int fid_mode = info_mode & FANOTIFY_FID_BITS;
+	unsigned int pidfd_mode = info_mode & FAN_REPORT_PIDFD;
 
 	/*
 	 * Event info records order is as follows: dir fid + name, child fid.
+	 * If FAN_REPORT_PIDFD has been specified, then a pidfd info record
+	 * will follow the fid info records.
 	 */
 	if (fanotify_event_dir_fh_len(event)) {
 		info_type = info->name_len ? FAN_EVENT_INFO_TYPE_DFID_NAME :
@@ -465,10 +496,18 @@ static int copy_info_to_user(struct fanotify_event *event,
 		}
 
 		ret = copy_fid_info_to_user(fanotify_event_fsid(event),
-					    fanotify_event_object_fh(event),
-					    info_type, dot, dot_len,
-					    buf, count);
-	}
+					    fanotify_event_object_fh(event),
+					    info_type, dot, dot_len,
+					    buf, count);
+		if (ret < 0)
+			return ret;
+
+		buf += ret;
+		count -= ret;
+	}
+
+	if (pidfd_mode)
+		return copy_pidfd_info_to_user(event->pid, buf, count);
 
 	return ret;
 }
@@ -530,6 +569,15 @@ static ssize_t copy_event_to_user(struct fsnotify_group *group,
 		fd_install(fd, f);
 
 	if (info_mode) {
+		/*
+		 * Complain if FAN_REPORT_PIDFD and FAN_REPORT_TID mutual
+		 * exclusion is ever lifted. At the time of implementing
+		 * FAN_REPORT_PIDFD, the pidfd API only supported the creation
+		 * of pidfds on thread-group leaders.
+		 */
+		WARN_ON_ONCE((info_mode & FAN_REPORT_PIDFD) &&
+			     FAN_GROUP_FLAG(group, FAN_REPORT_TID));
+
 		ret = copy_info_to_user(event, info, info_mode, buf, count);
 		if (ret < 0)
 			return ret;
@@ -1079,6 +1127,13 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flags, unsigned int, event_f_flags)
 #endif
 		return -EINVAL;
 
+	/*
+	 * A pidfd can only be returned for a thread-group leader; thus
+	 * FAN_REPORT_TID and FAN_REPORT_PIDFD need to be mutually exclusive.
+	 */
+	if ((flags & FAN_REPORT_PIDFD) && (flags & FAN_REPORT_TID))
+		return -EINVAL;
+
 	if (event_f_flags & ~FANOTIFY_INIT_ALL_EVENT_F_BITS)
 		return -EINVAL;
 
@@ -1477,7 +1532,7 @@ static int __init fanotify_user_setup(void)
 	max_marks = clamp(max_marks, FANOTIFY_OLD_DEFAULT_MAX_MARKS,
 				     FANOTIFY_DEFAULT_MAX_USER_MARKS);
 
-	BUILD_BUG_ON(HWEIGHT32(FANOTIFY_INIT_FLAGS) != 10);
+	BUILD_BUG_ON(HWEIGHT32(FANOTIFY_INIT_FLAGS) != 11);
 	BUILD_BUG_ON(HWEIGHT32(FANOTIFY_MARK_FLAGS) != 9);
 
 	fanotify_mark_cache = KMEM_CACHE(fsnotify_mark,
diff --git a/include/linux/fanotify.h b/include/linux/fanotify.h
index f76c7635efc8..bb2898240e5a 100644
--- a/include/linux/fanotify.h
+++ b/include/linux/fanotify.h
@@ -27,7 +27,7 @@ extern struct ctl_table fanotify_table[]; /* for sysctl */
 
 #define FANOTIFY_FID_BITS	(FAN_REPORT_FID | FAN_REPORT_DFID_NAME)
 
-#define FANOTIFY_INFO_MODES	(FANOTIFY_FID_BITS)
+#define FANOTIFY_INFO_MODES	(FANOTIFY_FID_BITS | FAN_REPORT_PIDFD)
 
 /*
  * fanotify_init() flags that require CAP_SYS_ADMIN.
@@ -37,6 +37,7 @@ extern struct ctl_table fanotify_table[]; /* for sysctl */
  */
 #define FANOTIFY_ADMIN_INIT_FLAGS	(FANOTIFY_PERM_CLASSES | \
 					 FAN_REPORT_TID | \
+					 FAN_REPORT_PIDFD | \
 					 FAN_UNLIMITED_QUEUE | \
 					 FAN_UNLIMITED_MARKS)
 
diff --git a/include/uapi/linux/fanotify.h b/include/uapi/linux/fanotify.h
index fbf9c5c7dd59..36c3bddcf690 100644
--- a/include/uapi/linux/fanotify.h
+++ b/include/uapi/linux/fanotify.h
@@ -55,6 +55,7 @@
 #define FAN_REPORT_FID		0x00000200	/* Report unique file id */
 #define FAN_REPORT_DIR_FID	0x00000400	/* Report unique directory id */
 #define FAN_REPORT_NAME		0x00000800	/* Report events with name */
+#define FAN_REPORT_PIDFD	0x00001000	/* Report pidfd for event->pid */
 
 /* Convenience macro - FAN_REPORT_NAME requires FAN_REPORT_DIR_FID */
 #define FAN_REPORT_DFID_NAME	(FAN_REPORT_DIR_FID | FAN_REPORT_NAME)
@@ -123,6 +124,7 @@ struct fanotify_event_metadata {
 #define FAN_EVENT_INFO_TYPE_FID		1
 #define FAN_EVENT_INFO_TYPE_DFID_NAME	2
 #define FAN_EVENT_INFO_TYPE_DFID	3
+#define FAN_EVENT_INFO_TYPE_PIDFD	4
 
 /* Variable length info record following event metadata */
 struct fanotify_event_info_header {
@@ -148,6 +150,15 @@ struct fanotify_event_info_fid {
 	unsigned char handle[0];
 };
 
+/*
+ * This structure is used for info records of type FAN_EVENT_INFO_TYPE_PIDFD.
+ * It holds a pidfd for the pid responsible for generating an event.
+ */
+struct fanotify_event_info_pidfd {
+	struct fanotify_event_info_header hdr;
+	__s32 pidfd;
+};
+
 struct fanotify_response {
 	__s32 fd;
 	__u32 response;
@@ -160,6 +171,7 @@ struct fanotify_response {
 
 /* No fd set in event */
 #define FAN_NOFD	-1
+#define FAN_NOPIDFD	FAN_NOFD
 
 /* Helper functions to deal with fanotify_event_metadata buffers */
 #define FAN_EVENT_METADATA_LEN (sizeof(struct fanotify_event_metadata))
-- 
2.31.1.751.gd2f1c929bd-goog

/M
