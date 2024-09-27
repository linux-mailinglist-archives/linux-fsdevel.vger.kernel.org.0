Return-Path: <linux-fsdevel+bounces-30247-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 50C019885C2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Sep 2024 14:56:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C75901F221E3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Sep 2024 12:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C245418C929;
	Fri, 27 Sep 2024 12:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Th7OBBpJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 984C318CBE1
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Sep 2024 12:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727441807; cv=none; b=GO1FVuzrJ5jXS/88eS8GEweIjSaopDTmtcw+7EpZ6NgfbgU5i++kuuWV1RpiwMQ2GK0ftL7fKioDBfUWHRE7HaWH1Wl9PE8GZQREI3FzLqYwrvvMy/l7c08qhUfac3rw3WbFV5w5c/ZZ9yJ6YrhSZrd2P8hTmZ70FiHzM5AzMeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727441807; c=relaxed/simple;
	bh=saU1e1mYxEFFx4xx365CqvU8y5vpJ1gvXabKMyso/Ik=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ePRzLqicBxW+Y8Ux9D0hHshRbWyMisOuHQOTWfgI/cIiA2Qs+WusS3yzIerXuXlbAbLJVyFdWsUobiU0GKQxYRG0GaOEvN8nh3e4Wpw3zupc9kjcUFNJG0W+yiBkxLYt2ATgOFJIkjRiNdIMGDzYKbBOOH4pFuDuJAi+VnpuUmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Th7OBBpJ; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a83562f9be9so209244766b.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 Sep 2024 05:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727441804; x=1728046604; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jQsdYFTP/gMEWx3GsCDfM2jmhEay39Kjmrb4duiasZA=;
        b=Th7OBBpJYjF2g/FKWuSJjpKiL7hVZrOOtILZctgUOaurDdYMGi0Q0vPuHKoAXA4Lys
         jssLchf0LfRGeaABoa5I03wGeHaYPwhNRcQZP5sl3sJGgGYENhwyHIzliR2cQ/RXSAf1
         DqweuaPzVLahwIZP2+IrjOQsBCTHFfd3ATS4cFopj2VM+AKpXTyZDOn0I5EDv5Gv2rgy
         Y9hhj7ikR2ZbpBTVQjvLqnVkguczOX1/nlYMOWP0WUnSOtzO0F0YBLjZiGajtbX0q2fl
         Yku2irw/aRjLQnPvC029GnKJiVm4mgSItOZIaYYFWEd09vJclAJE3iXAX/WGcNwHv0Ka
         nbEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727441804; x=1728046604;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jQsdYFTP/gMEWx3GsCDfM2jmhEay39Kjmrb4duiasZA=;
        b=t0KeZPB9Af3svPyUEyCeMCevx5vqe8T51rcJKmPhyANbQ2nn9NkUuzZBx5GBE6ysg8
         QOenpPRYOu2H58W/OOCyu366/E1a1SY7oDjiVPLjhCf+xAsX+CPSz7XFfAGd6sEdDjYV
         Ii9IRYUYxlMEiDH4cKM382dIpUPK1k3Gr3oZtKeHi5FEOvOX004QhI6CaxNq8U73MN20
         3jndEoNwWUxgMw2qu6SB/UgXNziCg3LZMin4JfiIKelzIN7boBywHS/QoCjpFkd7/1uD
         vKStrgjvJZelQbHwaWxw/3mEZCS0OPMufLarW5vNDQkrOqkj2RylC9WAmj9q6CKqCK8b
         +heA==
X-Forwarded-Encrypted: i=1; AJvYcCWevGmSOjqNxz0TcZIPszjFBucV+35BvFuNmLTgaAX1fmXs53I5poPowybcVEdcsIHNeGCIH2AqXHgRCNMv@vger.kernel.org
X-Gm-Message-State: AOJu0YxSeCC3sAwKa1xM6UpA5GEWUr92guSVaVft51JQtlkqk8nmWz8t
	173XYYX6ysSUVopGcyL7Vyl3hXCICkgRh+JY49lE9FCwdyx027PJDet0X+j9
X-Google-Smtp-Source: AGHT+IHIIYe//XfRETp3MVg47hIF3ONPky6gUvsyIYjQf+rQ4ZtEL0Nc8ziGPkfJ8nV7QI/fXP950A==
X-Received: by 2002:a17:907:9812:b0:a8d:64af:dc2a with SMTP id a640c23a62f3a-a93c4923733mr245846066b.25.1727441803369;
        Fri, 27 Sep 2024 05:56:43 -0700 (PDT)
Received: from amir-ThinkPad-T480.arnhem.chello.nl (92-109-99-123.cable.dynamic.v4.ziggo.nl. [92.109.99.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c27c7237sm132001266b.81.2024.09.27.05.56.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2024 05:56:43 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Jan Kara <jack@suse.cz>
Cc: Krishna Vivek Vitta <kvitta@microsoft.com>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH] fanotify: allow reporting errors on failure to open fd
Date: Fri, 27 Sep 2024 14:56:24 +0200
Message-Id: <20240927125624.2198202-1-amir73il@gmail.com>
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

In any case, userspace will not know which file failed to
open, so leave a warning in ksmg for further investigation.

Reported-by: Krishna Vivek Vitta <kvitta@microsoft.com>
Closes: https://lore.kernel.org/linux-fsdevel/SI2P153MB07182F3424619EDDD1F393EED46D2@SI2P153MB0718.APCP153.PROD.OUTLOOK.COM/
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---

Jan,

This is my proposal for a slightly better UAPI for error reporting.
I have a vague memory that we discussed this before and that you preferred
to report errno in an extra info field (?), but I have a strong repulsion
from this altenative, which seems like way over design for the case.

Here is what it looks like with an enhanced fanotify_example [1]
and the reproducer of the 9p open unlinked file issue [2]:

$ ./fanotify_example /vtmp/
Press enter key to terminate.
Listening for events.
FAN_OPEN_PERM: File /vtmp/config.lock
FAN_CLOSE_WRITE: fd open failed: No such file or directory

And the warning in kmsg:
[ 1836.619957] fanotify: create_fd(/config.lock) failed err=-2

fanotify_read() can still return an error with FAN_REPORT_FD_ERROR,
but not for a failure to open an fd.

WDYT?

Thanks,
Amir.

[1] https://github.com/amir73il/fsnotify-utils/blob/fan_report_fd_error/src/test/fanotify_example.c
[2] https://lore.kernel.org/linux-fsdevel/CAOQ4uxgRnzB0E2ESeqgZBHW++zyRj8-VmvB38Vxm5OXgr=EM9g@mail.gmail.com/

 fs/notify/fanotify/fanotify_user.c | 42 ++++++++++++++++++------------
 include/linux/fanotify.h           |  1 +
 include/uapi/linux/fanotify.h      |  1 +
 3 files changed, 28 insertions(+), 16 deletions(-)

diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index 13454e5fd3fb..80917814981c 100644
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
@@ -691,8 +684,25 @@ static ssize_t copy_event_to_user(struct fsnotify_group *group,
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
+		 * open, so leave a warning in ksmg for further investigation.
+		 */
+		if (fd < 0) {
+			pr_warn_ratelimited("fanotify: create_fd(%pd2) failed err=%d\n",
+					    path->dentry, fd);
+			if (!FAN_GROUP_FLAG(group, FAN_REPORT_FD_ERROR))
+				return fd;
+		}
 	}
 	metadata.fd = fd;
 
@@ -737,9 +747,6 @@ static ssize_t copy_event_to_user(struct fsnotify_group *group,
 	buf += FAN_EVENT_METADATA_LEN;
 	count -= FAN_EVENT_METADATA_LEN;
 
-	if (fanotify_is_perm_event(event->mask))
-		FANOTIFY_PERM(event)->fd = fd;
-
 	if (info_mode) {
 		ret = copy_info_records_to_user(event, info, info_mode, pidfd,
 						buf, count);
@@ -753,15 +760,18 @@ static ssize_t copy_event_to_user(struct fsnotify_group *group,
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
@@ -845,7 +855,7 @@ static ssize_t fanotify_read(struct file *file, char __user *buf,
 		if (!fanotify_is_perm_event(event->mask)) {
 			fsnotify_destroy_event(group, &event->fse);
 		} else {
-			if (ret <= 0) {
+			if (ret <= 0 || FANOTIFY_PERM(event)->fd < 0) {
 				spin_lock(&group->notification_lock);
 				finish_permission_event(group,
 					FANOTIFY_PERM(event), FAN_DENY, NULL);
@@ -1954,7 +1964,7 @@ static int __init fanotify_user_setup(void)
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


