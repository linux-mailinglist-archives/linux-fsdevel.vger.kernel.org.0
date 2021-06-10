Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 001633A2161
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jun 2021 02:23:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230295AbhFJAZM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Jun 2021 20:25:12 -0400
Received: from mail-pg1-f182.google.com ([209.85.215.182]:36841 "EHLO
        mail-pg1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230311AbhFJAZL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Jun 2021 20:25:11 -0400
Received: by mail-pg1-f182.google.com with SMTP id 27so21135943pgy.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 09 Jun 2021 17:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dQV0RshnCGuZFF1ju0rMy6wWcbhvjjllbbcntmxCvmA=;
        b=j6wsWqxlq5N18r/mbXLovVR/AD0HNBe0UJa7EKAXFWuCHOpCUGf9BKQ9gok0wuAilS
         l/sRMFe1+y1WqQGFpF0Oqm9w+azRR717C3TMWzBq5K87+yLom5TvrgDHO6qIwp67HrB/
         T6x/zDjw9MpxznNPCcWBBTtdjJ1KR9HEPyyIjfLn/PDkself979G6/PLZk9DA0YTvvG6
         VQJ/nhSLu/JeoyLjbJla86Drz0m/tk407pVwJICzWGJDcZU7ks1shNkCT3hvOavFZ7lJ
         T/23IupHIylFNyeJpQEV76NfHt/oJdsAE6BNLrI6l/xGxzMpO/dskxRf04y0VZcZwAak
         kJUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dQV0RshnCGuZFF1ju0rMy6wWcbhvjjllbbcntmxCvmA=;
        b=pIx9+62QE6WX/lSG5fcQkP/GfpwntdPZa9RN65+E7exjo5mYhfALygLm+NWlrt+Hc1
         AxJsmesBsVtBFL5PnUN18pRXu9uYMDqHMVZsdNDmYgSCi5Zoj3n56xBavMm3dNiv5skj
         02KvGZMtX9VtE7B8Pvx/LbT0IKmbwguCTAVhNhV9ViQwbMM4gR+T6LRG4DOG+iHX43a8
         shTgQqyM8C6Nsoz+BPqPSasUlY6CS64o+Y7yJX2rY39pSPR0VMj8g34KywxNrv9a9t1A
         +dDZKNPMRUYJoeRHRy5ptA8zecbe4yL7r+s/wNftmLbsen5eXhFSm3IwhjmQwtHdPw7p
         mKgg==
X-Gm-Message-State: AOAM5304An22c9T2Ginm4YjHsG1XxacoiuL9Z2Z9CMFHE1DF+FpL2bnw
        N9vLZMpUY9Ynx0cTd5vQHi/arppjH/tvmQ==
X-Google-Smtp-Source: ABdhPJwv8UgK+b2ELG/hJpgB0Vl7+gahkMqy8PigIsZzxdswzNAGzo7pMesAEJWHedcPLM2vvOQksA==
X-Received: by 2002:a63:4814:: with SMTP id v20mr2288295pga.8.1623284523016;
        Wed, 09 Jun 2021 17:22:03 -0700 (PDT)
Received: from google.com ([2401:fa00:9:211:6512:d64a:3615:dcbf])
        by smtp.gmail.com with ESMTPSA id h8sm768542pgr.43.2021.06.09.17.22.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jun 2021 17:22:02 -0700 (PDT)
Date:   Thu, 10 Jun 2021 10:21:50 +1000
From:   Matthew Bobrowski <repnop@google.com>
To:     jack@suse.cz, amir73il@gmail.com, christian.brauner@ubuntu.com
Cc:     linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
Subject: [PATCH v2 5/5] fanotify: add pidfd support to the fanotify API
Message-ID: <7f9d3b7815e72bfee92945cab51992f9db6533dd.1623282854.git.repnop@google.com>
References: <cover.1623282854.git.repnop@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1623282854.git.repnop@google.com>
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
these initialisation flags with FAN_REPORT_PIDFD will result with
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

Changes since v1:

* Explicit checks added to copy_event_to_user() for unprivileged
  listeners via FANOTIFY_UNPRIV. Only processes running with the
  CAP_SYS_ADMIN capability can receive pidfds for events.

* The pidfd creation via pidfd_create() has been taken out from
  copy_pidfd_info_to_user() and put into copy_event_to_user() so that
  proper clean up of the installed file descriptor can take place in
  the event that we error out during one of the info copying routines.

* Before pidfd creation is done via pidfd_create(), we perform an
  explicit check using pid_has_task() to make sure that the process
  responsible for generating the event in the first place hasn't been
  terminated. If it has, we supply the FAN_NOPIDFD error to the
  listener which explicitly indicates this was the case. All other
  pidfd creation errors are represented by FAN_EPIDFD.

* An additional check has been implemented before calling into
  pidfd_create() to see whether pid_vnr() had returned 0 for
  event->pid. In such cases, we also return FAN_NOPIDFD within the
  pidfd info record as returning metadata->pid = 0 with a valid pidfd
  doesn't make much sense and could lead to possible security problem.

 fs/notify/fanotify/fanotify_user.c | 98 ++++++++++++++++++++++++++++--
 include/linux/fanotify.h           |  3 +-
 include/uapi/linux/fanotify.h      | 13 ++++
 3 files changed, 107 insertions(+), 7 deletions(-)

diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index 85d6eea8d45d..1ce66bcfd9b5 100644
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
@@ -138,6 +140,9 @@ static int fanotify_event_info_len(unsigned int info_mode,
 		dot_len = 1;
 	}
 
+	if (info_mode & FAN_REPORT_PIDFD)
+		info_len += FANOTIFY_PIDFD_INFO_HDR_LEN;
+
 	if (fh_len)
 		info_len += fanotify_fid_info_len(fh_len, dot_len);
 
@@ -401,13 +406,34 @@ static int copy_fid_info_to_user(__kernel_fsid_t *fsid, struct fanotify_fh *fh,
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
@@ -478,6 +504,16 @@ static int copy_info_records_to_user(struct fanotify_event *event,
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
 
@@ -489,8 +525,9 @@ static ssize_t copy_event_to_user(struct fsnotify_group *group,
 	struct path *path = fanotify_event_path(event);
 	struct fanotify_info *info = fanotify_event_info(event);
 	unsigned int info_mode = FAN_GROUP_FLAG(group, FANOTIFY_INFO_MODES);
+	unsigned int pidfd_mode = info_mode & FAN_REPORT_PIDFD;
 	struct file *f = NULL;
-	int ret, fd = FAN_NOFD;
+	int ret, pidfd = 0, fd = FAN_NOFD;
 
 	pr_debug("%s: group=%p event=%p\n", __func__, group, event);
 
@@ -524,6 +561,34 @@ static ssize_t copy_event_to_user(struct fsnotify_group *group,
 	}
 	metadata.fd = fd;
 
+	/*
+	 * Currently, reporting a pidfd to an unprivileged listener is not
+	 * supported. The FANOTIFY_UNPRIV flag is to be kept here so that a
+	 * pidfd is not accidentally leaked to an unprivileged listener.
+	 */
+	if (pidfd_mode && !FAN_GROUP_FLAG(group, FANOTIFY_UNPRIV)) {
+		/*
+		 * The PIDTYPE_TGID check for an event->pid is performed
+		 * preemptively in attempt to catch those rare instances
+		 * where the process responsible for generating the event has
+		 * terminated prior to calling into pidfd_create() and
+		 * acquiring a valid pidfd. Report FAN_NOPIDFD to the listener
+		 * in those cases.
+		 */
+		if (metadata.pid == 0 ||
+		    !pid_has_task(event->pid, PIDTYPE_TGID)) {
+			pidfd = FAN_NOPIDFD;
+		} else {
+			pidfd = pidfd_create(event->pid, 0);
+			if (pidfd < 0)
+				/*
+				 * All other pidfd creation errors are reported
+				 * as FAN_EPIDFD to the listener.
+				 */
+				pidfd = FAN_EPIDFD;
+		}
+	}
+
 	ret = -EFAULT;
 	/*
 	 * Sanity check copy size in case get_one_event() and
@@ -545,10 +610,19 @@ static ssize_t copy_event_to_user(struct fsnotify_group *group,
 		fd_install(fd, f);
 
 	if (info_mode) {
-		ret = copy_info_records_to_user(event, info, info_mode,
-						buf, count);
+		/*
+		 * Complain if the FAN_REPORT_PIDFD and FAN_REPORT_TID mutual
+		 * exclusion is ever lifted. At the time of incorporating pidfd
+		 * support within fanotify, the pidfd API only supported the
+		 * creation of pidfds for thread-group leaders.
+		 */
+		WARN_ON_ONCE(pidfd_mode &&
+			     FAN_GROUP_FLAG(group, FAN_REPORT_TID));
+
+		ret = copy_info_records_to_user(event, info, info_mode, pidfd,
+				                buf, count);
 		if (ret < 0)
-			return ret;
+			goto out_close_fd;
 	}
 
 	return metadata.event_len;
@@ -558,6 +632,10 @@ static ssize_t copy_event_to_user(struct fsnotify_group *group,
 		put_unused_fd(fd);
 		fput(f);
 	}
+
+	if (pidfd < 0)
+		put_unused_fd(pidfd);
+
 	return ret;
 }
 
@@ -1103,6 +1181,14 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flags, unsigned int, event_f_flags)
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
 
@@ -1504,7 +1590,7 @@ static int __init fanotify_user_setup(void)
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
index fbf9c5c7dd59..5cb3e2369b96 100644
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
2.30.2

/M
