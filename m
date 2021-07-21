Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7934C3D08D1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jul 2021 08:22:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235101AbhGUFlf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Jul 2021 01:41:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234745AbhGUFix (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Jul 2021 01:38:53 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01C09C061766
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Jul 2021 23:19:29 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id gx2so1059133pjb.5
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Jul 2021 23:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=K50f2pQblnPllZPSuSx0j99p6GugE4ag9IrRIM4Wc54=;
        b=uVrciz/kA09liw7J35FTUicG4vv0sNIvylwHgLgND/NnvzjHhdlmNXyNBH9i0v75wa
         4kP6RM/9m0af/L5U/mVmgsSZb6U6GxGjuAiMtVmK6JHo1170bq/v2BykF2mF3p8iNdBF
         Psq8wIiMR2bi5vVjzJ8hJqV62g26T9KoeNaTTB5r37K4wU9++8ifgvliDUVqr9oxSi59
         T/RbWybXeg7Fv2fe8PS9mcgsFf3hdjrV3r6efMasg4XL4MWAD3OAmxJw8x/DiLwzMXv2
         0NZ9KUv1j87OwNJsIgL4Hynt6VXf/5b0wx5ywj2PYZVvwifsOBp+JhMdNXT2uEu/nZDr
         7nNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=K50f2pQblnPllZPSuSx0j99p6GugE4ag9IrRIM4Wc54=;
        b=WON6HDtpiLyRRYAQnoV7T4QWWNrBYUtfKvKvUphE2Vk06OSoY4GqennatmIIaYM6JH
         hrr54GVH54ZltZab8lncQ7Hdxbg8flD6u4hI9w0NKk6thBGwjDLoUSkLJ1Zc8da2OXQr
         oH3abkvotsk9mUMt+Ku1bNSP/YQicFXGN6eTAWBy/R5YUi1JcRKv4nWqH1FrhBQ/W2/f
         kI4g7UuXfaNoo2y1pSYSPjsK69SAE5lQVrwFN1yIrocBnJh2EViaB/sAfRxae4LKAlSp
         3QH97wkLlHVcB/wofH4SzAlF3l+hwwzXgtqFHn3+a4tmjweX6/evbOO4VadfZh7IXh9V
         gVOQ==
X-Gm-Message-State: AOAM5338UgzQZmgNuyV3fFVwY2Dejev8DYDnfPZAVY23Wn3l2NNnCV1o
        hZifDhQb0xq8gw2KOSYJdVW3jA==
X-Google-Smtp-Source: ABdhPJz6SV4GlvaP86f+V71qviTTcKiahLyezpCdRPxxo//FnZa9oj9Yq23AcIzDntX5oF4VqSstKQ==
X-Received: by 2002:a17:90a:530e:: with SMTP id x14mr34167363pjh.128.1626848368344;
        Tue, 20 Jul 2021 23:19:28 -0700 (PDT)
Received: from google.com ([2401:fa00:9:211:c03c:a42a:c97a:1b7d])
        by smtp.gmail.com with ESMTPSA id c14sm28373550pgv.86.2021.07.20.23.19.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 23:19:27 -0700 (PDT)
Date:   Wed, 21 Jul 2021 16:19:16 +1000
From:   Matthew Bobrowski <repnop@google.com>
To:     jack@suse.cz, amir73il@gmail.com, christian.brauner@ubuntu.com
Cc:     linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
Subject: [PATCH v3 5/5] fanotify: add pidfd support to the fanotify API
Message-ID: <02ba3581fee21c34bd986e093d9eb0b9897fa741.1626845288.git.repnop@google.com>
References: <cover.1626845287.git.repnop@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1626845287.git.repnop@google.com>
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

Currently, the usage of FAN_REPORT_TID is not permitted along with
FAN_REPORT_PIDFD as the pidfd API only supports the creation of pidfds
for thread-group leaders. Additionally, the FAN_REPORT_PIDFD is
limited to privileged processes only i.e. listeners that are running
with the CAP_SYS_ADMIN capability. Attempting to supply either of
these initialization flags with FAN_REPORT_PIDFD will result with
EINVAL being returned to the caller.

In the event of a pidfd creation error, there are two types of error
values that can be reported back to the listener. There is
FAN_NOPIDFD, which will be reported in cases where the process
responsible for generating the event has terminated prior to fanotify
being able to create pidfd for event->pid via pidfd_create(). The
there is FAN_EPIDFD, which will be reported if a more generic pidfd
creation error occurred when calling pidfd_create().

Signed-off-by: Matthew Bobrowski <repnop@google.com>
---

Changes since v2:

 * The FAN_REPORT_PIDFD flag value has been changed from 0x00001000 to
   0x00000080. This was so that future FID related initialization flags
   could be grouped nicely.

* Fixed pidfd clean up at out_close_fd label in
  copy_event_to_user(). Reversed the conditional and it now uses the
  close_fd() helper instead of put_unused_fd() as we also need to close the
  backing file, not just just mark the pidfd free in the fdtable.

* Shuffled around the WARN_ON_ONCE(FAN_REPORT_TID) within
  copy_event_to_user() so that it's inside the if (pidfd_mode) branch. It
  makes more sense to be as close to pidfd creation as possible.

* Fixed up the comment block within the if (pidfd_mode) branch.

 fs/notify/fanotify/fanotify_user.c | 88 ++++++++++++++++++++++++++++--
 include/linux/fanotify.h           |  3 +-
 include/uapi/linux/fanotify.h      | 13 +++++
 3 files changed, 98 insertions(+), 6 deletions(-)

diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index d19f70b2c24c..bcc375c258ce 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/fanotify.h>
 #include <linux/fcntl.h>
+#include <linux/fdtable.h>
 #include <linux/file.h>
 #include <linux/fs.h>
 #include <linux/anon_inodes.h>
@@ -106,6 +107,8 @@ struct kmem_cache *fanotify_perm_event_cachep __read_mostly;
 #define FANOTIFY_EVENT_ALIGN 4
 #define FANOTIFY_FID_INFO_HDR_LEN \
 	(sizeof(struct fanotify_event_info_fid) + sizeof(struct file_handle))
+#define FANOTIFY_PIDFD_INFO_HDR_LEN \
+	sizeof(struct fanotify_event_info_pidfd)
 
 static int fanotify_fid_info_len(int fh_len, int name_len)
 {
@@ -138,6 +141,9 @@ static int fanotify_event_info_len(unsigned int info_mode,
 		dot_len = 1;
 	}
 
+	if (info_mode & FAN_REPORT_PIDFD)
+		info_len += FANOTIFY_PIDFD_INFO_HDR_LEN;
+
 	if (fh_len)
 		info_len += fanotify_fid_info_len(fh_len, dot_len);
 
@@ -401,13 +407,34 @@ static int copy_fid_info_to_user(__kernel_fsid_t *fsid, struct fanotify_fh *fh,
 	return info_len;
 }
 
+static int copy_pidfd_info_to_user(int pidfd,
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
+	info.pidfd = pidfd;
+
+	if (copy_to_user(buf, &info, info_len))
+		return -EFAULT;
+
+	return info_len;
+}
+
 static int copy_info_records_to_user(struct fanotify_event *event,
 				     struct fanotify_info *info,
-				     unsigned int info_mode,
+				     unsigned int info_mode, int pidfd,
 				     char __user *buf, size_t count)
 {
 	int ret, total_bytes = 0, info_type = 0;
 	unsigned int fid_mode = info_mode & FANOTIFY_FID_BITS;
+	unsigned int pidfd_mode = info_mode & FAN_REPORT_PIDFD;
 
 	/*
 	 * Event info records order is as follows: dir fid + name, child fid.
@@ -478,6 +505,16 @@ static int copy_info_records_to_user(struct fanotify_event *event,
 		total_bytes += ret;
 	}
 
+	if (pidfd_mode) {
+		ret = copy_pidfd_info_to_user(pidfd, buf, count);
+		if (ret < 0)
+			return ret;
+
+		buf += ret;
+		count -= ret;
+		total_bytes += ret;
+	}
+
 	return total_bytes;
 }
 
@@ -489,8 +526,9 @@ static ssize_t copy_event_to_user(struct fsnotify_group *group,
 	struct path *path = fanotify_event_path(event);
 	struct fanotify_info *info = fanotify_event_info(event);
 	unsigned int info_mode = FAN_GROUP_FLAG(group, FANOTIFY_INFO_MODES);
+	unsigned int pidfd_mode = info_mode & FAN_REPORT_PIDFD;
 	struct file *f = NULL;
-	int ret, fd = FAN_NOFD;
+	int ret, pidfd = FAN_NOPIDFD, fd = FAN_NOFD;
 
 	pr_debug("%s: group=%p event=%p\n", __func__, group, event);
 
@@ -524,6 +562,34 @@ static ssize_t copy_event_to_user(struct fsnotify_group *group,
 	}
 	metadata.fd = fd;
 
+	if (pidfd_mode) {
+		/*
+		 * Complain if the FAN_REPORT_PIDFD and FAN_REPORT_TID mutual
+		 * exclusion is ever lifted. At the time of incoporating pidfd
+		 * support within fanotify, the pidfd API only supported the
+		 * creation of pidfds for thread-group leaders.
+		 */
+		WARN_ON_ONCE(FAN_GROUP_FLAG(group, FAN_REPORT_TID));
+
+		/*
+		 * The PIDTYPE_TGID check for an event->pid is performed
+		 * preemptively in attempt to catch those rare instances where
+		 * the process responsible for generating the event has
+		 * terminated prior to calling into pidfd_create() and acquiring
+		 * a valid pidfd. Report FAN_NOPIDFD to the listener in those
+		 * cases. All other pidfd creation errors are represented as
+		 * FAN_EPIDFD.
+		 */
+		if (metadata.pid == 0 ||
+		    !pid_has_task(event->pid, PIDTYPE_TGID)) {
+			pidfd = FAN_NOPIDFD;
+		} else {
+			pidfd = pidfd_create(event->pid, 0);
+			if (pidfd < 0)
+				pidfd = FAN_EPIDFD;
+		}
+	}
+
 	ret = -EFAULT;
 	/*
 	 * Sanity check copy size in case get_one_event() and
@@ -545,8 +611,8 @@ static ssize_t copy_event_to_user(struct fsnotify_group *group,
 		fd_install(fd, f);
 
 	if (info_mode) {
-		ret = copy_info_records_to_user(event, info, info_mode,
-						buf, count);
+		ret = copy_info_records_to_user(event, info, info_mode, pidfd,
+						buf, count);
 		if (ret < 0)
 			goto out_close_fd;
 	}
@@ -558,6 +624,10 @@ static ssize_t copy_event_to_user(struct fsnotify_group *group,
 		put_unused_fd(fd);
 		fput(f);
 	}
+
+	if (pidfd >= 0)
+		close_fd(pidfd);
+
 	return ret;
 }
 
@@ -1103,6 +1173,14 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flags, unsigned int, event_f_flags)
 #endif
 		return -EINVAL;
 
+	/*
+	 * A pidfd can only be returned for a thread-group leader; thus
+	 * FAN_REPORT_PIDFD and FAN_REPORT_TID need to remain mutually
+	 * exclusive.
+	 */
+	if ((flags & FAN_REPORT_PIDFD) && (flags & FAN_REPORT_TID))
+		return -EINVAL;
+
 	if (event_f_flags & ~FANOTIFY_INIT_ALL_EVENT_F_BITS)
 		return -EINVAL;
 
@@ -1504,7 +1582,7 @@ static int __init fanotify_user_setup(void)
 				     FANOTIFY_DEFAULT_MAX_USER_MARKS);
 
 	BUILD_BUG_ON(FANOTIFY_INIT_FLAGS & FANOTIFY_INTERNAL_GROUP_FLAGS);
-	BUILD_BUG_ON(HWEIGHT32(FANOTIFY_INIT_FLAGS) != 10);
+	BUILD_BUG_ON(HWEIGHT32(FANOTIFY_INIT_FLAGS) != 11);
 	BUILD_BUG_ON(HWEIGHT32(FANOTIFY_MARK_FLAGS) != 9);
 
 	fanotify_mark_cache = KMEM_CACHE(fsnotify_mark,
diff --git a/include/linux/fanotify.h b/include/linux/fanotify.h
index 10a7e26ddba6..eec3b7c40811 100644
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
index fbf9c5c7dd59..64553df9d735 100644
--- a/include/uapi/linux/fanotify.h
+++ b/include/uapi/linux/fanotify.h
@@ -51,6 +51,7 @@
 #define FAN_ENABLE_AUDIT	0x00000040
 
 /* Flags to determine fanotify event format */
+#define FAN_REPORT_PIDFD	0x00000080	/* Report pidfd for event->pid */
 #define FAN_REPORT_TID		0x00000100	/* event->pid is thread id */
 #define FAN_REPORT_FID		0x00000200	/* Report unique file id */
 #define FAN_REPORT_DIR_FID	0x00000400	/* Report unique directory id */
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
+ * It holds a pidfd for the pid that was responsible for generating an event.
+ */
+struct fanotify_event_info_pidfd {
+	struct fanotify_event_info_header hdr;
+	__s32 pidfd;
+};
+
 struct fanotify_response {
 	__s32 fd;
 	__u32 response;
@@ -160,6 +171,8 @@ struct fanotify_response {
 
 /* No fd set in event */
 #define FAN_NOFD	-1
+#define FAN_NOPIDFD	FAN_NOFD
+#define FAN_EPIDFD	-2
 
 /* Helper functions to deal with fanotify_event_metadata buffers */
 #define FAN_EVENT_METADATA_LEN (sizeof(struct fanotify_event_metadata))
-- 
2.32.0.432.gabb21c7263-goog

/M
