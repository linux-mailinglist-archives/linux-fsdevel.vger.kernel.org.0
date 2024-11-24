Return-Path: <linux-fsdevel+bounces-35673-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A44519D7406
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Nov 2024 15:56:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F686B3044A
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Nov 2024 13:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B2C41DE4C6;
	Sun, 24 Nov 2024 13:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DO7JLWLD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8438A1DE2DA;
	Sun, 24 Nov 2024 13:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732455335; cv=none; b=NctgpX06Z0a4L0vVqy66VQv7TNbmb9lIvrd7wskZsapt9ZxLBX8Z3jGvc6BjvLIyQMGwjmGLxn0C9PS9W02rN5MQilfy9y+Y+C5mIKhewSfPnX45B4ifEhHZTU9eqg34kblxqFnPeRE3eifVD7Zam1BPvLMHDiZ8moo2Wune2f4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732455335; c=relaxed/simple;
	bh=DGpl4AVnslnSf2FRe9DPV0UfV/JCfTiIj/Nifd9Vqo0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UzTNMCpTZktY+mlxhDQBLypjZKvZVdg5Mb+KQQ21zjp16AQ9yaYTojfBKI7LcLZPgo5J8bIActgwxP42Ig/C/iFyytDeI9b5gRqkVjWDuoTf3yXqZ2/tNJX8aaQdmgx3WBNPXGBObHFCil6WQRb16/5GcL+WNw1q/JIHn0otNSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DO7JLWLD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DB3FC4CECC;
	Sun, 24 Nov 2024 13:35:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732455334;
	bh=DGpl4AVnslnSf2FRe9DPV0UfV/JCfTiIj/Nifd9Vqo0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DO7JLWLDJR39zsXJ8C5F1pYjeOWJm0UQJxA/ke68QpgZEEhQ5vyHPe4btY70SHtiK
	 CQ01a3BZjfwkVbq4Y8hxkuvLqf6xty38HS7SKiT35EYX20dVQ2SRmDXKtKned4XwOy
	 oirbeHrCW733fWIZAVlDgABFzUdBWlb5FTj3IR6PuvrRwOyO9gJs+352xa1YLgTsOc
	 eWMwxIARZhLuKRBKm/MiWuyDohAVjSW41R68Bom2nIR4sDKo2qTNAl5heou2t1iLKV
	 r8Uq++EpJpQA2ChrgzP8LPAgb3IAJU/uqoiBKjcQYi+ss6b06EB4/+05G+41HrH7cs
	 Ln0mr1HS59jAA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Amir Goldstein <amir73il@gmail.com>,
	Krishna Vivek Vitta <kvitta@microsoft.com>,
	Jan Kara <jack@suse.cz>,
	Sasha Levin <sashal@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 048/107] fanotify: allow reporting errors on failure to open fd
Date: Sun, 24 Nov 2024 08:29:08 -0500
Message-ID: <20241124133301.3341829-48-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124133301.3341829-1-sashal@kernel.org>
References: <20241124133301.3341829-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.1
Content-Transfer-Encoding: 8bit

From: Amir Goldstein <amir73il@gmail.com>

[ Upstream commit 522249f05c5551aec9ec0ba9b6438f1ec19c138d ]

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

For an overflow event, we report -EBADF to avoid confusing FAN_NOFD
with -EPERM.  Similarly for pidfd open errors we report either -ESRCH
or the open error instead of FAN_NOPIDFD and FAN_EPIDFD.

In any case, userspace will not know which file failed to
open, so add a debug print for further investigation.

Reported-by: Krishna Vivek Vitta <kvitta@microsoft.com>
Link: https://lore.kernel.org/linux-fsdevel/SI2P153MB07182F3424619EDDD1F393EED46D2@SI2P153MB0718.APCP153.PROD.OUTLOOK.COM/
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Jan Kara <jack@suse.cz>
Link: https://patch.msgid.link/20241003142922.111539-1-amir73il@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/notify/fanotify/fanotify_user.c | 85 +++++++++++++++++-------------
 include/linux/fanotify.h           |  1 +
 include/uapi/linux/fanotify.h      |  1 +
 3 files changed, 50 insertions(+), 37 deletions(-)

diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index 9644bc72e4573..8e2d43fc6f7c1 100644
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
@@ -663,7 +656,7 @@ static ssize_t copy_event_to_user(struct fsnotify_group *group,
 	unsigned int info_mode = FAN_GROUP_FLAG(group, FANOTIFY_INFO_MODES);
 	unsigned int pidfd_mode = info_mode & FAN_REPORT_PIDFD;
 	struct file *f = NULL, *pidfd_file = NULL;
-	int ret, pidfd = FAN_NOPIDFD, fd = FAN_NOFD;
+	int ret, pidfd = -ESRCH, fd = -EBADF;
 
 	pr_debug("%s: group=%p event=%p\n", __func__, group, event);
 
@@ -691,10 +684,39 @@ static ssize_t copy_event_to_user(struct fsnotify_group *group,
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
+			if (!FAN_GROUP_FLAG(group, FAN_REPORT_FD_ERROR)) {
+				/*
+				 * Historically, we've handled EOPENSTALE in a
+				 * special way and silently dropped such
+				 * events. Now we have to keep it to maintain
+				 * backward compatibility...
+				 */
+				if (fd == -EOPENSTALE)
+					fd = 0;
+				return fd;
+			}
+		}
 	}
-	metadata.fd = fd;
+	if (FAN_GROUP_FLAG(group, FAN_REPORT_FD_ERROR))
+		metadata.fd = fd;
+	else
+		metadata.fd = fd >= 0 ? fd : FAN_NOFD;
 
 	if (pidfd_mode) {
 		/*
@@ -709,18 +731,16 @@ static ssize_t copy_event_to_user(struct fsnotify_group *group,
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
-		if (metadata.pid == 0 ||
-		    !pid_has_task(event->pid, PIDTYPE_TGID)) {
-			pidfd = FAN_NOPIDFD;
-		} else {
+		if (metadata.pid && pid_has_task(event->pid, PIDTYPE_TGID))
 			pidfd = pidfd_prepare(event->pid, 0, &pidfd_file);
-			if (pidfd < 0)
-				pidfd = FAN_EPIDFD;
-		}
+
+		if (!FAN_GROUP_FLAG(group, FAN_REPORT_FD_ERROR) && pidfd < 0)
+			pidfd = pidfd == -ESRCH ? FAN_NOPIDFD : FAN_EPIDFD;
 	}
 
 	ret = -EFAULT;
@@ -737,9 +757,6 @@ static ssize_t copy_event_to_user(struct fsnotify_group *group,
 	buf += FAN_EVENT_METADATA_LEN;
 	count -= FAN_EVENT_METADATA_LEN;
 
-	if (fanotify_is_perm_event(event->mask))
-		FANOTIFY_PERM(event)->fd = fd;
-
 	if (info_mode) {
 		ret = copy_info_records_to_user(event, info, info_mode, pidfd,
 						buf, count);
@@ -753,15 +770,18 @@ static ssize_t copy_event_to_user(struct fsnotify_group *group,
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
@@ -828,15 +848,6 @@ static ssize_t fanotify_read(struct file *file, char __user *buf,
 		}
 
 		ret = copy_event_to_user(group, event, buf, count);
-		if (unlikely(ret == -EOPENSTALE)) {
-			/*
-			 * We cannot report events with stale fd so drop it.
-			 * Setting ret to 0 will continue the event loop and
-			 * do the right thing if there are no more events to
-			 * read (i.e. return bytes read, -EAGAIN or wait).
-			 */
-			ret = 0;
-		}
 
 		/*
 		 * Permission events get queued to wait for response.  Other
@@ -845,7 +856,7 @@ static ssize_t fanotify_read(struct file *file, char __user *buf,
 		if (!fanotify_is_perm_event(event->mask)) {
 			fsnotify_destroy_event(group, &event->fse);
 		} else {
-			if (ret <= 0) {
+			if (ret <= 0 || FANOTIFY_PERM(event)->fd < 0) {
 				spin_lock(&group->notification_lock);
 				finish_permission_event(group,
 					FANOTIFY_PERM(event), FAN_DENY, NULL);
@@ -1954,7 +1965,7 @@ static int __init fanotify_user_setup(void)
 				     FANOTIFY_DEFAULT_MAX_USER_MARKS);
 
 	BUILD_BUG_ON(FANOTIFY_INIT_FLAGS & FANOTIFY_INTERNAL_GROUP_FLAGS);
-	BUILD_BUG_ON(HWEIGHT32(FANOTIFY_INIT_FLAGS) != 12);
+	BUILD_BUG_ON(HWEIGHT32(FANOTIFY_INIT_FLAGS) != 13);
 	BUILD_BUG_ON(HWEIGHT32(FANOTIFY_MARK_FLAGS) != 11);
 
 	fanotify_mark_cache = KMEM_CACHE(fanotify_mark,
diff --git a/include/linux/fanotify.h b/include/linux/fanotify.h
index 4f1c4f6031180..89ff45bd6f01b 100644
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
index a37de58ca571a..34f221d3a1b95 100644
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
2.43.0


