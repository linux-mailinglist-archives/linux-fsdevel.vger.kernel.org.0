Return-Path: <linux-fsdevel+bounces-30893-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ECF8B98F168
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Oct 2024 16:29:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D0F51F22BC7
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Oct 2024 14:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0740A19F409;
	Thu,  3 Oct 2024 14:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KPt8Y5LI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E551CFBC
	for <linux-fsdevel@vger.kernel.org>; Thu,  3 Oct 2024 14:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727965772; cv=none; b=cJD7TgmCovFiXE3YG7mGe/CAv3VadoBjatejS7tCmNdebIUfaRicHnmED05+aOfWtCizzxdJO1avNGf0zxA62GFodQfItAYooF8g4FFPhSF6+mbaa+PAOOQJ+2DS3FNJffc9BYv7dKWxEQFEH5AHyFXy6WrnIImwCCprjUOWlI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727965772; c=relaxed/simple;
	bh=Mqh4KIV3ovPHE7hojq51POqi6B6M+UHnBYRXjhCtGb4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=T78/EsAgjNXwjm10Je7sdvOmAggjOCVUMOCwbTD1QQuhghu8VVn3d9+hPCkBNgroqssg4vHKuHSDLvzyv/3tBW9sSabC8SAFmyOHoA4eK9UtfrIWlQjGNj17haciVXIzLRH6OPinRhBrxTyVOa7DbU8GAQPxjipqpWzcG3dkql4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KPt8Y5LI; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a93b2070e0cso117130266b.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 03 Oct 2024 07:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727965769; x=1728570569; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TC+QoO/p1oVDWlU0t0ZkS+zc6skR+gsLBk0Rjp8Am9U=;
        b=KPt8Y5LIpcVGHK7IpD/Jo/2FLe6GqFAcSNSb/MMCQmxOqdIY0NdiEo+LWFMzKWmHQ3
         5s9PJ66n82CFQ/ESbgjw6NCfslhJ+T4ZWghQJJ4lWmj+8A69RO7O3CqxCkexo3PhWtV9
         M+cjXrQlO7YKmsl3gfIFcQAsY/v0Vi9n/uevHtMo4oV6RYwNtgMjCVG/UeKiqjJQNFZh
         SWDCucw3a9WKWdARundzge6qnenzseDpXiUAgbMI0jJzz17sYNJYpoaTCEGjz85PhrpW
         3eQBGFKAZhbKmbQAD0+LIPG7EBDND1s3DT4qknw31rekZLjH9PcAGQ+MBsIDMvHNZ6tz
         wL5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727965769; x=1728570569;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TC+QoO/p1oVDWlU0t0ZkS+zc6skR+gsLBk0Rjp8Am9U=;
        b=jlqHbiVcv6ztMnTshmMRc44V0jiifotwCq8PKOTy8+GtnMLEScFO5/akfCofuijXgd
         Fdsv2wCs8UU+e8y1708fnvPa0fmRPXAb6p4F7kO8r2OyH2EJmeEtctekwuLmNSB92MMr
         wa1SDjTV3o2r0gZ+8/+xJzJBbWTomzBecnqzPKngUf15sFwQQSdRt8Fr72hK42lpPcyn
         d5fYIfuhNayfZuKmQeduw05aIzMxYKbTf4xZt4me577vw3NlcVbwBDlX1SGsYcxv+CGD
         P9HCX8BStBhKUzQP1XIqtgxevQ8MR2khN5EO5fu46orB2X3uw7m4KTNvYjZIgV1a6FJW
         aVaQ==
X-Forwarded-Encrypted: i=1; AJvYcCX5RmzmDht6z9JHUQO1TMIWgZNhwWyLVzzZb8wxBiYhCsjdhUULkB1mxC8+SftvNxXYmyt0IGa/BHhJsOe/@vger.kernel.org
X-Gm-Message-State: AOJu0YztuldHMuIGcj8o0wV9z8qwBpTlS237mipExZb3ItjVbHX+z6pF
	24O9LCJcYETtwzoQseI32UIlMS+I7yRm7QJ6eOtYySBNRfD8khmm2kMu7zlm
X-Google-Smtp-Source: AGHT+IHwCx50DG7ryiy4Oy8FRDwqRQzFJ0DQsF5VtKG0wMleduCrSyzmO2feywuuPTC+VTbczzO09A==
X-Received: by 2002:a17:907:6d17:b0:a86:a30f:4aef with SMTP id a640c23a62f3a-a98f82342e6mr644343166b.22.1727965768176;
        Thu, 03 Oct 2024 07:29:28 -0700 (PDT)
Received: from amir-ThinkPad-T480.arnhem.chello.nl (92-109-99-123.cable.dynamic.v4.ziggo.nl. [92.109.99.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99103b3778sm91880066b.113.2024.10.03.07.29.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 07:29:25 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Jan Kara <jack@suse.cz>
Cc: Krishna Vivek Vitta <kvitta@microsoft.com>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2] fanotify: allow reporting errors on failure to open fd
Date: Thu,  3 Oct 2024 16:29:22 +0200
Message-Id: <20241003142922.111539-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When working in "fd mode", fanotify_read() needs to open an fd
from a dentry to report event->fd to userspace.

Opening an fd from dentry can fail for several reasons.
For example, when tasks are gone and we try to open their
/proc files or we try to open a WRONLY file like in sysfs
or when trying to open a file that was deleted on the
remote network server.

Add a new flag FAN_REPORT_FD_ERROR for fanotify_init().
For a group with FAN_REPORT_FD_ERROR, we will send the
event with the error instead of the open fd, otherwise
userspace may not get the error at all.

The FAN_REPORT_FD_ERROR flag is not allowed for groups in "fid mode"
which do not use open fd's as the object identifier.

For ean overflow event, we report -EBADF to avoid confusing FAN_NOFD
with -EPERM.  Similarly for pidfd open errors we report either -ESRCH
or the open error instead of FAN_NOPIDFD and FAN_EPIDFD.

In any case, userspace will not know which file failed to
open, so add a debug print for further investigation.

Reported-by: Krishna Vivek Vitta <kvitta@microsoft.com>
Closes: https://lore.kernel.org/linux-fsdevel/SI2P153MB07182F3424619EDDD1F393EED46D2@SI2P153MB0718.APCP153.PROD.OUTLOOK.COM/
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
Jan,

This is my proposal for a slightly better UAPI for error reporting,
taking into account your review comments on v1 [1].

I have written some basic LTP tests for the simple cases [2], but
not yet for actual open errors.

I tested the open error manually using an enhanced fanotify_example [3]
and the reproducer of the 9p open unlinked file issue [4]:

$ ./fanotify_example /vtmp/
Press enter key to terminate.
Listening for events.
FAN_OPEN_PERM: File /vtmp/config.lock
FAN_CLOSE_WRITE: fd open failed: No such file or directory

And the debug print in kmsg:
[ 1836.619957] fanotify: create_fd(/config.lock) failed err=-2

fanotify_read() can still return an error with FAN_REPORT_FD_ERROR,
but not for a failure to open an fd.

Thanks,
Amir.

Changes since v1:
- Change pr_warn() => pr_debug()
- Restrict FAN_REPORT_FD_ERROR to group in fd mode
- Report fd error also for pidfd errors
- Report -EBAFD instead of FAN_NOFD in overflow event

[1] https://lore.kernel.org/linux-fsdevel/20240927125624.2198202-1-amir73il@gmail.com/
[2] https://github.com/amir73il/ltp/commits/fan_fd_error
[3] https://github.com/amir73il/fsnotify-utils/blob/fan_report_fd_error/src/test/fanotify_example.c
[4] https://lore.kernel.org/linux-fsdevel/CAOQ4uxgRnzB0E2ESeqgZBHW++zyRj8-VmvB38Vxm5OXgr=EM9g@mail.gmail.com/

 fs/notify/fanotify/fanotify_user.c | 83 +++++++++++++++++++++---------
 include/linux/fanotify.h           |  1 +
 include/uapi/linux/fanotify.h      |  1 +
 3 files changed, 62 insertions(+), 23 deletions(-)

diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index 9644bc72e457..37a0dd8ae883 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -266,13 +266,6 @@ static int create_fd(struct fsnotify_group *group, const struct path *path,
 			       group->fanotify_data.f_flags | __FMODE_NONOTIFY,
 			       current_cred());
 	if (IS_ERR(new_file)) {
-		/*
-		 * we still send an event even if we can't open the file.  this
-		 * can happen when say tasks are gone and we try to open their
-		 * /proc files or we try to open a WRONLY file like in sysfs
-		 * we just send the errno to userspace since there isn't much
-		 * else we can do.
-		 */
 		put_unused_fd(client_fd);
 		client_fd = PTR_ERR(new_file);
 	} else {
@@ -653,6 +646,19 @@ static int copy_info_records_to_user(struct fanotify_event *event,
 	return total_bytes;
 }
 
+/* Determine with value to report in event->fd */
+static int event_fd_error(struct fsnotify_group *group, int fd, int nofd)
+{
+	/* An unprivileged user should never get an open fd or specific error */
+	if (FAN_GROUP_FLAG(group, FANOTIFY_UNPRIV))
+		return nofd;
+
+	if (fd >= 0 || FAN_GROUP_FLAG(group, FAN_REPORT_FD_ERROR))
+		return fd;
+
+	return nofd;
+}
+
 static ssize_t copy_event_to_user(struct fsnotify_group *group,
 				  struct fanotify_event *event,
 				  char __user *buf, size_t count)
@@ -691,8 +697,32 @@ static ssize_t copy_event_to_user(struct fsnotify_group *group,
 	if (!FAN_GROUP_FLAG(group, FANOTIFY_UNPRIV) &&
 	    path && path->mnt && path->dentry) {
 		fd = create_fd(group, path, &f);
-		if (fd < 0)
-			return fd;
+		/*
+		 * Opening an fd from dentry can fail for several reasons.
+		 * For example, when tasks are gone and we try to open their
+		 * /proc files or we try to open a WRONLY file like in sysfs
+		 * or when trying to open a file that was deleted on the
+		 * remote network server.
+		 *
+		 * For a group with FAN_REPORT_FD_ERROR, we will send the
+		 * event with the error instead of the open fd, otherwise
+		 * Userspace may not get the error at all.
+		 * In any case, userspace will not know which file failed to
+		 * open, so add a debug print for further investigation.
+		 */
+		if (fd < 0) {
+			pr_debug("fanotify: create_fd(%pd2) failed err=%d\n",
+				 path->dentry, fd);
+			if (!FAN_GROUP_FLAG(group, FAN_REPORT_FD_ERROR))
+				return fd;
+		}
+	} else {
+		/*
+		 * For a group with FAN_REPORT_FD_ERROR, report an event with
+		 * no file, such as an overflow event with -BADF instead of
+		 * FAN_NOFD, because FAN_NOFD collides with -EPERM.
+		 */
+		fd = event_fd_error(group, -EBADF, FAN_NOFD);
 	}
 	metadata.fd = fd;
 
@@ -709,17 +739,17 @@ static ssize_t copy_event_to_user(struct fsnotify_group *group,
 		 * The PIDTYPE_TGID check for an event->pid is performed
 		 * preemptively in an attempt to catch out cases where the event
 		 * listener reads events after the event generating process has
-		 * already terminated. Report FAN_NOPIDFD to the event listener
-		 * in those cases, with all other pidfd creation errors being
-		 * reported as FAN_EPIDFD.
+		 * already terminated.  Depending on flag FAN_REPORT_FD_ERROR,
+		 * report either -ESRCH or FAN_NOPIDFD to the event listener in
+		 * those cases with all other pidfd creation errors reported as
+		 * the error code itself or as FAN_EPIDFD.
 		 */
 		if (metadata.pid == 0 ||
 		    !pid_has_task(event->pid, PIDTYPE_TGID)) {
-			pidfd = FAN_NOPIDFD;
+			pidfd = event_fd_error(group, -ESRCH, FAN_NOPIDFD);
 		} else {
 			pidfd = pidfd_prepare(event->pid, 0, &pidfd_file);
-			if (pidfd < 0)
-				pidfd = FAN_EPIDFD;
+			pidfd = event_fd_error(group, pidfd, FAN_NOPIDFD);
 		}
 	}
 
@@ -737,9 +767,6 @@ static ssize_t copy_event_to_user(struct fsnotify_group *group,
 	buf += FAN_EVENT_METADATA_LEN;
 	count -= FAN_EVENT_METADATA_LEN;
 
-	if (fanotify_is_perm_event(event->mask))
-		FANOTIFY_PERM(event)->fd = fd;
-
 	if (info_mode) {
 		ret = copy_info_records_to_user(event, info, info_mode, pidfd,
 						buf, count);
@@ -753,15 +780,18 @@ static ssize_t copy_event_to_user(struct fsnotify_group *group,
 	if (pidfd_file)
 		fd_install(pidfd, pidfd_file);
 
+	if (fanotify_is_perm_event(event->mask))
+		FANOTIFY_PERM(event)->fd = fd;
+
 	return metadata.event_len;
 
 out_close_fd:
-	if (fd != FAN_NOFD) {
+	if (f) {
 		put_unused_fd(fd);
 		fput(f);
 	}
 
-	if (pidfd >= 0) {
+	if (pidfd_file) {
 		put_unused_fd(pidfd);
 		fput(pidfd_file);
 	}
@@ -845,7 +875,7 @@ static ssize_t fanotify_read(struct file *file, char __user *buf,
 		if (!fanotify_is_perm_event(event->mask)) {
 			fsnotify_destroy_event(group, &event->fse);
 		} else {
-			if (ret <= 0) {
+			if (ret <= 0 || FANOTIFY_PERM(event)->fd < 0) {
 				spin_lock(&group->notification_lock);
 				finish_permission_event(group,
 					FANOTIFY_PERM(event), FAN_DENY, NULL);
@@ -1453,7 +1483,14 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flags, unsigned int, event_f_flags)
 		return -EINVAL;
 	}
 
-	if (fid_mode && class != FAN_CLASS_NOTIF)
+	/*
+	 * Legacy fanotify mode reports open fd's in event->fd.
+	 * With fid mode, open fd's are not reported and event->fd is FAN_NOFD.
+	 * High priority classes require reporting open fd's.
+	 * FAN_REPORT_FD_ERROR is only allowed when reporting open fd's.
+	 */
+	if (fid_mode &&
+	    (class != FAN_CLASS_NOTIF || flags & FAN_REPORT_FD_ERROR))
 		return -EINVAL;
 
 	/*
@@ -1954,7 +1991,7 @@ static int __init fanotify_user_setup(void)
 				     FANOTIFY_DEFAULT_MAX_USER_MARKS);
 
 	BUILD_BUG_ON(FANOTIFY_INIT_FLAGS & FANOTIFY_INTERNAL_GROUP_FLAGS);
-	BUILD_BUG_ON(HWEIGHT32(FANOTIFY_INIT_FLAGS) != 12);
+	BUILD_BUG_ON(HWEIGHT32(FANOTIFY_INIT_FLAGS) != 13);
 	BUILD_BUG_ON(HWEIGHT32(FANOTIFY_MARK_FLAGS) != 11);
 
 	fanotify_mark_cache = KMEM_CACHE(fanotify_mark,
diff --git a/include/linux/fanotify.h b/include/linux/fanotify.h
index 4f1c4f603118..89ff45bd6f01 100644
--- a/include/linux/fanotify.h
+++ b/include/linux/fanotify.h
@@ -36,6 +36,7 @@
 #define FANOTIFY_ADMIN_INIT_FLAGS	(FANOTIFY_PERM_CLASSES | \
 					 FAN_REPORT_TID | \
 					 FAN_REPORT_PIDFD | \
+					 FAN_REPORT_FD_ERROR | \
 					 FAN_UNLIMITED_QUEUE | \
 					 FAN_UNLIMITED_MARKS)
 
diff --git a/include/uapi/linux/fanotify.h b/include/uapi/linux/fanotify.h
index a37de58ca571..34f221d3a1b9 100644
--- a/include/uapi/linux/fanotify.h
+++ b/include/uapi/linux/fanotify.h
@@ -60,6 +60,7 @@
 #define FAN_REPORT_DIR_FID	0x00000400	/* Report unique directory id */
 #define FAN_REPORT_NAME		0x00000800	/* Report events with name */
 #define FAN_REPORT_TARGET_FID	0x00001000	/* Report dirent target id  */
+#define FAN_REPORT_FD_ERROR	0x00002000	/* event->fd can report error */
 
 /* Convenience macro - FAN_REPORT_NAME requires FAN_REPORT_DIR_FID */
 #define FAN_REPORT_DFID_NAME	(FAN_REPORT_DIR_FID | FAN_REPORT_NAME)
-- 
2.34.1


