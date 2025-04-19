Return-Path: <linux-fsdevel+bounces-46714-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2F8AA942BE
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Apr 2025 12:07:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 089EE8A4FDE
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Apr 2025 10:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EC2F1CCEE7;
	Sat, 19 Apr 2025 10:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VLJue/2e"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 174121A239B
	for <linux-fsdevel@vger.kernel.org>; Sat, 19 Apr 2025 10:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745057229; cv=none; b=V7gfdoKloFNFlSbICUtgYcW1LEoc1nR/u5e7EwOfu1ZlHFbPEWehRH6xSiVBkAc++kx2V+hpWFQ2RFx+tvfv3yPCFQSCeah82tCuNBoHAJYOKCUrJhSDttJC5ylaOHWXzA++80sEf10JuzDRKWysygYSyTDuLt/1WAGf+1D3ibw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745057229; c=relaxed/simple;
	bh=VNyZT9dqF5nsNJ1QbhJahEzHvjloPIdUZbv3v7muAZg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=n1d/5+xfQFxC0vbeAMe/+GfaCoPB71mAUVXmX2xsGG+Md1pu/T0scbnGdc3n0btwyNA7y/6US7rQg6Wr9zg9jzw06C7NI575e1PZ2CzpBbNofN4CVkuhOhMLLJLBAPv/Kawvagr/XCwDo3Ntw85TT0nvXEyVxXe2jkGuCJvn1Uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VLJue/2e; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ac2a81e41e3so455826366b.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 19 Apr 2025 03:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745057226; x=1745662026; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5t3oxZJtPTZrV6Q4+o+es58yZtyFt6AFjF1+fCggpP0=;
        b=VLJue/2eGs7KTKwHxLITuN1c329E5LVk0rt1QiAdPRy6dLSplwyaE5ceRJnrBIp9mW
         MvgbWTj/odKvozJHLlw5ObhJQhax2tG8RxwuU+gNspUXjsCDeJM/WbR92mV1Yr7k52iL
         yiOpTsYSnHZ2CYjTe/VWqSHD6CIIwn8Wf8rZfQGSzdYeQb5eoIyk4jNZd5E89Tpn40YU
         vw86OLm4DnXGA65DQqcadfTWMqU0ApmkdWJvzfTRUR8g2ppw39GbQZGGVNv/WyyeUrnI
         gAqu9NReMW5W6oABjrxSwIC26mhypsiGGqk04+ii10NMPhJyncIltqm94ie5ZhQQOijI
         L3vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745057226; x=1745662026;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5t3oxZJtPTZrV6Q4+o+es58yZtyFt6AFjF1+fCggpP0=;
        b=si18lTOgvL/EtlDR/ExIdJqwmncnRAYa9clVI+A9AQT7h3P5IbIbt3zDDtq38tBrh3
         FLWrDMMgyfiNkH4iYjrlLINL810NQTutYaxtBe+KP7ZvxNuAKX9aNeXUgORQc8Im/I3i
         +i4gj4mE0g657hHrcgHoGYjdAlFtKsY7CPvbholWBOEfEM62Of6ICaTb4OAoJZ8w5ob3
         KnjPaQ/Ah50TVQEyeAVJKQmyaNTtB3G9nK64uSZvPwsPWsQAn3rVl8pmLNJDvqF/Onk9
         82Ko/8mJs859ao/9WIGgx6kpQ+59ry6ZCm0pnqCSZ2dEibo7Zmn8S0NC/TErRHjjAa6/
         bUMg==
X-Forwarded-Encrypted: i=1; AJvYcCVPCUvcJ5tr1yskEU0UvCA/CKhAshx9n0FMnDIYubvUzLQ2gj8OmteiN9K2eve1C9hpZVR7eo+G2czxXyQA@vger.kernel.org
X-Gm-Message-State: AOJu0YxHXCY6I286h9cre+37V9pvDEDYDWwwR1fWLJYr/n9TMFjEDGc7
	+WTNlatpMfb1bD+ZvfL6yvMnm95PUmVpp9kzdZ48hjBhfGZT3C2f
X-Gm-Gg: ASbGnctu/Q7PDAwhm9OgSrkPyjl0NLZWWZn6kTcjnj6z70jKHoCB494sfUVy+T0seDi
	35HDYxHw7ks0wjUWdjZtO5gzgD7f3TgUz6D4g3GlbPLLkcELTd3hHV8trXKnOe7eWrB8tP5uid/
	0l1gHgJlJTh7PrUdx7AcIiK9COIPQiub8zYutqg2mGkDaPT0wnj3W9Aul8PSucqHaX6OYDYZ5Du
	MKAbkQW9JUukeL7TIpnQ5qH6GuF3gbae4giLdIZgS/SPqQ8ncWbJFxA4E8GRfEQjAqXxIpOYTXH
	JAJgQJLuPqcTNJk2Ptrn1uAwq/blk+CLP2PrZxGVddTEoeqcUkDtL4dbvWCKJ4Zn1FISxc+JmKx
	1gqLaUrrgL/sy2TTknnsZuqmsqMOArOOpcyGlGpmkOHMQZFDE
X-Google-Smtp-Source: AGHT+IFOKYPbVSF+lG+T+4Fxj4LOR/cylr/UFz8h1SnuwH97l4C9+1KS0KZpy4DRS91erjSkkIcErg==
X-Received: by 2002:a17:907:2da5:b0:ac3:8626:615 with SMTP id a640c23a62f3a-acb74df2c05mr521462866b.49.1745057225809;
        Sat, 19 Apr 2025 03:07:05 -0700 (PDT)
Received: from amir-ThinkPad-T480.arnhem.chello.nl (92-109-99-123.cable.dynamic.v4.ziggo.nl. [92.109.99.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acb6ec507c9sm245894866b.69.2025.04.19.03.07.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Apr 2025 03:07:05 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Jan Kara <jack@suse.cz>
Cc: Miklos Szeredi <miklos@szeredi.hu>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 2/2] fanotify: support watching filesystems and mounts inside userns
Date: Sat, 19 Apr 2025 12:06:57 +0200
Message-Id: <20250419100657.2654744-3-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250419100657.2654744-1-amir73il@gmail.com>
References: <20250419100657.2654744-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

An unprivileged user is allowed to create an fanotify group and add
inode marks, but not filesystem, mntns and mount marks.

Add limited support for setting up filesystem, mntns and mount marks by
an unprivileged user under the following conditions:

1.   User has CAP_SYS_ADMIN in the user ns where the group was created
2.a. User has CAP_SYS_ADMIN in the user ns where the filesystem was
     mounted (implies FS_USERNS_MOUNT)
  OR (in case setting up a mntns or mount mark)
2.b. User has CAP_SYS_ADMIN in the user ns associated with the mntns

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/notify/fanotify/fanotify.c      |  1 +
 fs/notify/fanotify/fanotify_user.c | 36 +++++++++++++++++++++---------
 include/linux/fanotify.h           |  5 ++---
 include/linux/fsnotify_backend.h   |  1 +
 4 files changed, 30 insertions(+), 13 deletions(-)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index 6d386080faf2..060d9bee34bd 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -1009,6 +1009,7 @@ static int fanotify_handle_event(struct fsnotify_group *group, u32 mask,
 
 static void fanotify_free_group_priv(struct fsnotify_group *group)
 {
+	put_user_ns(group->user_ns);
 	kfree(group->fanotify_data.merge_hash);
 	if (group->fanotify_data.ucounts)
 		dec_ucount(group->fanotify_data.ucounts,
diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index 471c57832357..b4255b661bda 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -1499,6 +1499,7 @@ static struct hlist_head *fanotify_alloc_merge_hash(void)
 /* fanotify syscalls */
 SYSCALL_DEFINE2(fanotify_init, unsigned int, flags, unsigned int, event_f_flags)
 {
+	struct user_namespace *user_ns = current_user_ns();
 	struct fsnotify_group *group;
 	int f_flags, fd;
 	unsigned int fid_mode = flags & FANOTIFY_FID_BITS;
@@ -1513,10 +1514,11 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flags, unsigned int, event_f_flags)
 		/*
 		 * An unprivileged user can setup an fanotify group with
 		 * limited functionality - an unprivileged group is limited to
-		 * notification events with file handles and it cannot use
-		 * unlimited queue/marks.
+		 * notification events with file handles or mount ids and it
+		 * cannot use unlimited queue/marks.
 		 */
-		if ((flags & FANOTIFY_ADMIN_INIT_FLAGS) || !fid_mode)
+		if ((flags & FANOTIFY_ADMIN_INIT_FLAGS) ||
+		    !(flags & (FANOTIFY_FID_BITS | FAN_REPORT_MNT)))
 			return -EPERM;
 
 		/*
@@ -1595,8 +1597,7 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flags, unsigned int, event_f_flags)
 	}
 
 	/* Enforce groups limits per user in all containing user ns */
-	group->fanotify_data.ucounts = inc_ucount(current_user_ns(),
-						  current_euid(),
+	group->fanotify_data.ucounts = inc_ucount(user_ns, current_euid(),
 						  UCOUNT_FANOTIFY_GROUPS);
 	if (!group->fanotify_data.ucounts) {
 		fd = -EMFILE;
@@ -1605,6 +1606,7 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flags, unsigned int, event_f_flags)
 
 	group->fanotify_data.flags = flags | internal_flags;
 	group->memcg = get_mem_cgroup_from_mm(current->mm);
+	group->user_ns = get_user_ns(user_ns);
 
 	group->fanotify_data.merge_hash = fanotify_alloc_merge_hash();
 	if (!group->fanotify_data.merge_hash) {
@@ -1804,6 +1806,7 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
 	struct fsnotify_group *group;
 	struct path path;
 	struct fan_fsid __fsid, *fsid = NULL;
+	struct user_namespace *user_ns = NULL;
 	u32 valid_mask = FANOTIFY_EVENTS | FANOTIFY_EVENT_FLAGS;
 	unsigned int mark_type = flags & FANOTIFY_MARK_TYPE_BITS;
 	unsigned int mark_cmd = flags & FANOTIFY_MARK_CMD_BITS;
@@ -1897,12 +1900,10 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
 	}
 
 	/*
-	 * An unprivileged user is not allowed to setup mount nor filesystem
-	 * marks.  This also includes setting up such marks by a group that
-	 * was initialized by an unprivileged user.
+	 * A user is allowed to setup sb/mount/mntns marks only if it is
+	 * capable in the user ns where the group was created.
 	 */
-	if ((!capable(CAP_SYS_ADMIN) ||
-	     FAN_GROUP_FLAG(group, FANOTIFY_UNPRIV)) &&
+	if (!ns_capable(group->user_ns, CAP_SYS_ADMIN) &&
 	    mark_type != FAN_MARK_INODE)
 		return -EPERM;
 
@@ -1987,12 +1988,27 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
 		obj = inode;
 	} else if (obj_type == FSNOTIFY_OBJ_TYPE_VFSMOUNT) {
 		obj = path.mnt;
+		user_ns = real_mount(obj)->mnt_ns->user_ns;
 	} else if (obj_type == FSNOTIFY_OBJ_TYPE_SB) {
 		obj = path.mnt->mnt_sb;
+		user_ns = path.mnt->mnt_sb->s_user_ns;
 	} else if (obj_type == FSNOTIFY_OBJ_TYPE_MNTNS) {
 		obj = mnt_ns_from_dentry(path.dentry);
+		user_ns = ((struct mnt_namespace *)obj)->user_ns;
 	}
 
+	/*
+	 * In addition to being capable in the user ns where group was created,
+	 * the user also needs to be capable in the user ns associated with
+	 * the marked filesystem (for FS_USERNS_MOUNT filesystems) or in the
+	 * user ns associated with the mntns (when marking a mount or mntns).
+	 * This is aligned with the required permissions to open_by_handle_at()
+	 * a directory fid provided with the events.
+	 */
+	ret = -EPERM;
+	if (user_ns && !ns_capable(user_ns, CAP_SYS_ADMIN))
+		goto path_put_and_out;
+
 	ret = -EINVAL;
 	if (!obj)
 		goto path_put_and_out;
diff --git a/include/linux/fanotify.h b/include/linux/fanotify.h
index 3c817dc6292e..879cff5eccd4 100644
--- a/include/linux/fanotify.h
+++ b/include/linux/fanotify.h
@@ -38,8 +38,7 @@
 					 FAN_REPORT_PIDFD | \
 					 FAN_REPORT_FD_ERROR | \
 					 FAN_UNLIMITED_QUEUE | \
-					 FAN_UNLIMITED_MARKS | \
-					 FAN_REPORT_MNT)
+					 FAN_UNLIMITED_MARKS)
 
 /*
  * fanotify_init() flags that are allowed for user without CAP_SYS_ADMIN.
@@ -48,7 +47,7 @@
  * so one of the flags for reporting file handles is required.
  */
 #define FANOTIFY_USER_INIT_FLAGS	(FAN_CLASS_NOTIF | \
-					 FANOTIFY_FID_BITS | \
+					 FANOTIFY_FID_BITS | FAN_REPORT_MNT | \
 					 FAN_CLOEXEC | FAN_NONBLOCK)
 
 #define FANOTIFY_INIT_FLAGS	(FANOTIFY_ADMIN_INIT_FLAGS | \
diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
index fc27b53c58c2..d4034ddaf392 100644
--- a/include/linux/fsnotify_backend.h
+++ b/include/linux/fsnotify_backend.h
@@ -250,6 +250,7 @@ struct fsnotify_group {
 						 * full */
 
 	struct mem_cgroup *memcg;	/* memcg to charge allocations */
+	struct user_namespace *user_ns;	/* user ns where group was created */
 
 	/* groups can define private fields here or use the void *private */
 	union {
-- 
2.34.1


