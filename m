Return-Path: <linux-fsdevel+bounces-49296-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2614FABA3C2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 May 2025 21:28:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C8F43BB80A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 May 2025 19:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 015C8226CFF;
	Fri, 16 May 2025 19:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FUnMgC8o"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6F12253B5
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 May 2025 19:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747423692; cv=none; b=FTioMbCtKU2myWBNMTCl1Aq82DeuFJNXIMZ3S79fC3hj1rJBe2EIFZxBbvxohVbZcdPtrvi0wGT9yL0N0xVYsJnJzEyMvJ98uRKhW580/QVuossRvcstRczRAq5JrWYpHjroqtRW3jy7B0BCvoDUFgEK5fKXVtN+CuPmahlB0rE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747423692; c=relaxed/simple;
	bh=XjiI7BYRtu4gdhFa+LgEJGDjO7taVPS2hqQyYMvsAok=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YnnZ5dtoNlP0/qFfdmqilG0ZE+p8Posyma3UuvRI/raArZb3Fc/hZYH6CEP/yLOBUJeHzx3bGQ1too2dUWAhGl8rnTFuu5H4h8VkbCSlrcIU+zy+FPvXYDc/ly8KiP2t/zJLYNPh+tUNkE64V7DEU6iWH7dthFT4wOIp0pDfYT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FUnMgC8o; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ad1b94382b8so424220566b.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 May 2025 12:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747423689; x=1748028489; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uII9edu742QnNxDO9Z41jiimBwPbVwzdeTZKcD3NcT0=;
        b=FUnMgC8oGw7R7dn4+p7x2W9/1Fz+aJeJn7extZ7l4hY2Dr+qHZI5FaUZwho0GFUgAc
         Wbjq4lCOTf2wpYisbaNkjmKKBgVNOxLNXp0F6vfbKubYVi8L67rJGa8nD9olHmvByCZ2
         GYmVmkpD7AkVEXn/njvj0sRWTvNPrLTIyZSH9WK+myknHOyVmI8O/8prmLIKR07QGnnd
         6oWHwNOURAVwaRTMWSHxiwF6l2pGWN/NiF/GXbpJERRTqb6uqBm3BjD0+fotJt5AQHzT
         VLTw+Su8HEYV/SJAw8llJ5rFk1fBVxkWVlYco6MgVoSt6oLAUt/lkrSEOYHIgsqyGXD4
         874g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747423689; x=1748028489;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uII9edu742QnNxDO9Z41jiimBwPbVwzdeTZKcD3NcT0=;
        b=MolfsD6e6iEBIdex9zuUF0WDSK63NcqfMk6PG3cfMJjZo3+G95OX3/et0vHomfaWpZ
         MH7qLKQERLFey6yuWE/fU/IQpY4SKcuRnFcSTQKcEIth9Up3bzeUA5SUyGMLwOISkbLO
         624JSeNZH9x7EzMt4AwL+ZXW4k4D4qw5YV0xDt8g7aZ8RwFNUcJJ5UwsuBj9Ao+Qkwbv
         3qxPQ4Gr7fF7kLHLUC9tOY4P9WSvxg+iYUBlcHukg/SY03VugfoXv+BariAIgeMlwb69
         Fm1fekUfw5p20QGpgGbELCbas3I8n0IBW2+jSOs7EamuaxkobygdzHbw0s32ZuI2NWDQ
         V2MA==
X-Forwarded-Encrypted: i=1; AJvYcCXXRR4b6ldA4qTZrkoqIQxX+FpxcChZLMTJPP8glR3Te5U9D6JM6fiiG31YSXrxE/W5otx8ZaRCU9kvrW1m@vger.kernel.org
X-Gm-Message-State: AOJu0Yxc3B4vnteGNouGZo8m//9eMPNPb3VGdEw88EdLeHekWuvL8Xgw
	Anh2w1RPbSBm+UFq2pVz4kFsxiMF+pNjgxX01EZXUiFYYZ4KcxQkP9UW
X-Gm-Gg: ASbGncvhDpF6TIEg+5bLwXulGYGvP1u8n0XlFarS53BekNYtk1pJgRaHp5sNM9lOMk2
	l3kd2TMtDlSHa1/eMl3VkHUa4HUwVvbJDZifCypqkkHBqan3Y6O8Dfp5JPZUAAIznkI2iSwLiOP
	EuZVdPW4/pvWSVd0Ezmkmq4pNpQfir93/EBWeduWUfSPlctRILdWayyPTdMEzi0hAARrV1w5/qm
	s6XJaQHFgugB4NpvVPd+aYnSgrKiuKlgsWrw3yOyDSOvG/DSavC805/v8N78YBxq8bFqq6BHx1d
	MsH2pJuQjDZJDiso3QIwL2H+UYJ8bimr3iqwDYVX6YDhtPJ91dcREPQ51QKPH6UawtvLatUtTjp
	AytUMrtlqmU4iqcNkFY3DLU8GdqPc5rxDWUYg1Wb683WqtC6U
X-Google-Smtp-Source: AGHT+IEEiEVfBus/Tqa7xx4s5qdL3PUCJCqqudlr4/bcsye/iyaynoDw/22FWX4CI7UsmKMIuE8TZQ==
X-Received: by 2002:a17:906:4ad8:b0:ad5:43eb:d927 with SMTP id a640c23a62f3a-ad543ebe186mr176559866b.23.1747423688273;
        Fri, 16 May 2025 12:28:08 -0700 (PDT)
Received: from amir-ThinkPad-T480.arnhem.chello.nl (92-109-99-123.cable.dynamic.v4.ziggo.nl. [92.109.99.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad52d4466e2sm201075066b.93.2025.05.16.12.28.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 May 2025 12:28:07 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Jan Kara <jack@suse.cz>
Cc: Miklos Szeredi <miklos@szeredi.hu>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 2/2] fanotify: support watching filesystems and mounts inside userns
Date: Fri, 16 May 2025 21:28:03 +0200
Message-Id: <20250516192803.838659-3-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250516192803.838659-1-amir73il@gmail.com>
References: <20250516192803.838659-1-amir73il@gmail.com>
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
2.a. User has CAP_SYS_ADMIN in the user ns where the sb was created
  OR (in case setting up a mntns mark)
2.b. User has CAP_SYS_ADMIN in the user ns associated with the mntns

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/notify/fanotify/fanotify.c      |  1 +
 fs/notify/fanotify/fanotify_user.c | 39 +++++++++++++++++++++---------
 include/linux/fanotify.h           |  5 ++--
 include/linux/fsnotify_backend.h   |  1 +
 4 files changed, 31 insertions(+), 15 deletions(-)

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
index 471c57832357..b192ee068a7a 100644
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
@@ -1804,6 +1806,8 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
 	struct fsnotify_group *group;
 	struct path path;
 	struct fan_fsid __fsid, *fsid = NULL;
+	struct user_namespace *user_ns = NULL;
+	struct mnt_namespace *mntns;
 	u32 valid_mask = FANOTIFY_EVENTS | FANOTIFY_EVENT_FLAGS;
 	unsigned int mark_type = flags & FANOTIFY_MARK_TYPE_BITS;
 	unsigned int mark_cmd = flags & FANOTIFY_MARK_CMD_BITS;
@@ -1897,12 +1901,10 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
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
 
@@ -1981,18 +1983,31 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
 		fsid = &__fsid;
 	}
 
-	/* inode held in place by reference to path; group by fget on fd */
+	/*
+	 * In addition to being capable in the user ns where group was created,
+	 * the user also needs to be capable in the user ns associated with
+	 * the filesystem or in the user ns associated with the mntns
+	 * (when marking mntns).
+	 */
 	if (obj_type == FSNOTIFY_OBJ_TYPE_INODE) {
 		inode = path.dentry->d_inode;
 		obj = inode;
 	} else if (obj_type == FSNOTIFY_OBJ_TYPE_VFSMOUNT) {
+		user_ns = path.mnt->mnt_sb->s_user_ns;
 		obj = path.mnt;
 	} else if (obj_type == FSNOTIFY_OBJ_TYPE_SB) {
+		user_ns = path.mnt->mnt_sb->s_user_ns;
 		obj = path.mnt->mnt_sb;
 	} else if (obj_type == FSNOTIFY_OBJ_TYPE_MNTNS) {
-		obj = mnt_ns_from_dentry(path.dentry);
+		mntns = mnt_ns_from_dentry(path.dentry);
+		user_ns = mntns->user_ns;
+		obj = mntns;
 	}
 
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


