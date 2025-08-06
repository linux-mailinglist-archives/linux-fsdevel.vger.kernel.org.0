Return-Path: <linux-fsdevel+bounces-56921-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B83AB1CEFB
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Aug 2025 00:06:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBC363ABD2F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Aug 2025 22:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99A9923AB9F;
	Wed,  6 Aug 2025 22:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="p5iTyVuI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073E722E3F0
	for <linux-fsdevel@vger.kernel.org>; Wed,  6 Aug 2025 22:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754517985; cv=none; b=XlsPYhchUUdiAr0tUhdUE9JzbxFygJRMFasVr0PkZtP1fZYfbmGy/6jcyrPxnd6oThmANPlgFiZaXDQyfP+CDyHVgJCP/K+LT+ByeOBYIzxG+0uWocWqtRO2ZNfPHHfY0wocfmYwP/tv16kfpURgI2X5g14883YggOGpcu2N4/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754517985; c=relaxed/simple;
	bh=foi1MQ6XQZujIY1EOlibO0VDp7oVqmgu+swNHRfYwkc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ycw5IWs8YUU70BYtr1L5psPB1BGukn8GPQb2NeKVYSJfAy6UAHJivg3ajRAgciYh1/BOTaECa/rlyuzU0NjEh7H/PcJVPnzNpdAJm5CbzavrKXOzwKj6wp1KpTKj95B3EyoYA9fR1mbt9kHmD2emoNDmWNwMeZimWeVrcbcMRmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=p5iTyVuI; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 576LJMi9024893
	for <linux-fsdevel@vger.kernel.org>; Wed, 6 Aug 2025 15:06:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=liux/uh568oHnYTatIxOQn8LI9KeRhu0rQT2uDbqbCs=; b=p5iTyVuIx+Zp
	M6SOEAyS71Qh9jaShDdDK6k3ujVYK2y3/mZzOS3L72/8zzd4EVobIKyxun/pH7Y9
	wWtsSsNS84Xw0r8mhhL/MQI4W/zz0rz3w2PQ7OtoP41hS+vC53U8pScO2KgZNmb1
	zfMWe3KOqVkbqExzUvZEykr8slxTWnjuwoE+rJcPzg2m4MLiD0OBLen89tvwzBeI
	1FdbTpCC8ITBTrB0RwTYzH9GJ/xNG+fEssy40efPE9YqP969h8+uDZbUOKAWAu1q
	ZXyWKekObikSdKbyLGBScuZqaXB0YLkXA1sqp5kKV0U8Z0pA37nVagTlTtuqaEev
	gTDyM/Kp2Q==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 48bpwf3swr-14
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Wed, 06 Aug 2025 15:06:22 -0700 (PDT)
Received: from twshared57752.46.prn1.facebook.com (2620:10d:c0a8:1b::8e35) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.17; Wed, 6 Aug 2025 22:06:07 +0000
Received: by devvm18334.vll0.facebook.com (Postfix, from userid 202792)
	id C69F7353A7660; Wed,  6 Aug 2025 15:06:02 -0700 (PDT)
From: Ibrahim Jirdeh <ibrahimjirdeh@meta.com>
To: <ibrahimjirdeh@meta.com>
CC: <jack@suse.cz>, <amir73il@gmail.com>, <josef@toxicpanda.com>,
        <lesha@meta.com>, <linux-fsdevel@vger.kernel.org>, <sargun@meta.com>
Subject: [PATCH 2/2] fanotify: introduce restartable permission events
Date: Wed, 6 Aug 2025 15:05:16 -0700
Message-ID: <20250806220516.953114-3-ibrahimjirdeh@meta.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250806220516.953114-1-ibrahimjirdeh@meta.com>
References: <20250806220516.953114-1-ibrahimjirdeh@meta.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=BsqdwZX5 c=1 sm=1 tr=0 ts=6893d1de cx=c_pps a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=VabnemYjAAAA:8 a=pGLkceISAAAA:8 a=W99NPW3ffVUa-epB7NEA:9 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-GUID: l4JrAQIuNvA54-iIeugAiJ8780sBQQaE
X-Proofpoint-ORIG-GUID: l4JrAQIuNvA54-iIeugAiJ8780sBQQaE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA2MDE0NyBTYWx0ZWRfX7Wjdus6Jjb5H yCp7y6llxBYghIZqp3sMrgjNzISNIF6IORVcoopB/B+HNwlzKqrBN80WvygU/GD+SIsKK2fOOjD Sxs3iO4+gnmvSCZ34kR0+VQKoZpqZmWQ3r6XHmBTTJ1kmLMIltll8s62vGnq7FomfAfrwanI7lM
 y4kO9z7Tx/C1UFzqGoBvVdIEgm5b+4ZnkNl+/wZraBs+tcFkkRw6pWl3GJFf9psPnqDPjioF/pt weI8pwzTdNg+LPh7ovkADxqRFujwoGzyXJx2usBsGdkATMO7AtrQQdCEdvsYvo8XIo3DMQhzF3r c/M8DnF21s+q6glBUEF/uZl6j13bNFKcTUXwZ9G7GmjCxt1rYnzC4eJyDbWSgnMjnt7aWU0ZfTD
 gXtDHHf0fHM/GvlqYwmavvafcXolQzGjUHXkqOujFcgLfKrYfhb01vT2oztUysSzsIubvqbq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-06_05,2025-08-06_01,2025-03-28_01

This add support for restarting permission events. The main goal of
the change is to provide better handling for pending events for lazy
file loading use cases which may back fanotify events by a long-lived
daemon. For prior discussion of approaches see [1][2].

In terms of implementation, we add a new control-fd/queue-fd api.
Control fd returned by fanotify_init keeps fanotify group alive and
supports operations like fanotify_mark as well as a new ioctl
FAN_IOC_OPEN_QUEUE_FD to issue user a queue fd. Queue fd is used
for reading events and writing back responses. Upon release of
queue fd, pending permission events are reinserted back into
notification queue for reprocessing.

Control-fd/queue-fd api is guarded by FAN_RESTARTABLE_EVENTS flag.
In addition FAN_RESTARTABLE_EVENTS can only be used in conjunction
with FAN_CLASS_CONTENT or FAN_CLASS_PRE_CONTENT, and only permission
events can added to the mark mask if a group initialize with
FAN_RESTARTABLE_EVENTS.

[1] https://lore.kernel.org/linux-fsdevel/6za2mngeqslmqjg3icoubz37hbbxi6b=
i44canfsg2aajgkialt@c3ujlrjzkppr
[2] https://lore.kernel.org/linux-fsdevel/20250623192503.2673076-1-ibrahi=
mjirdeh@meta.com

Suggested-by: Amir Goldstein <amir73il@gmail.com>
Link: https://lore.kernel.org/linux-fsdevel/CAOQ4uxhN6ok6BCBGbxeUt9ULq6g=3D=
qL6=3D_2_QGi8MqTHv5ZN7Vg@mail.gmail.com
Signed-off-by: Ibrahim Jirdeh <ibrahimjirdeh@meta.com>
---
 fs/notify/fanotify/fanotify.h       |   4 +
 fs/notify/fanotify/fanotify_user.c  | 111 ++++++++++++++++++++++++++--
 fs/notify/group.c                   |   2 +
 include/linux/fanotify.h            |   1 +
 include/linux/fsnotify_backend.h    |   2 +
 include/uapi/linux/fanotify.h       |   6 ++
 tools/include/uapi/linux/fanotify.h |   6 ++
 7 files changed, 125 insertions(+), 7 deletions(-)

diff --git a/fs/notify/fanotify/fanotify.h b/fs/notify/fanotify/fanotify.=
h
index c0dffbc3370d..5cf25e7ad2d8 100644
--- a/fs/notify/fanotify/fanotify.h
+++ b/fs/notify/fanotify/fanotify.h
@@ -556,3 +556,7 @@ extern void fanotify_insert_event(struct fsnotify_gro=
up *group,
=20
 extern int fanotify_merge(struct fsnotify_group *group,
 	struct fsnotify_event *event);
+
+extern const struct file_operations fanotify_fops;
+extern const struct file_operations fanotify_control_fops;
+extern const struct file_operations fanotify_queue_fops;
diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fano=
tify_user.c
index 01d273d35936..8d5266be78a2 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -1011,6 +1011,7 @@ static void clear_queue(struct file *file, bool res=
tart_events)
 	 * restart is requested, move them back into the notification queue
 	 * for reprocessing, otherwise simulate a reply from userspace.
 	 */
+	mutex_lock(&group->queue_mutex);
 	spin_lock(&group->notification_lock);
 	while (!list_empty(&group->fanotify_data.access_list)) {
 		struct fanotify_perm_event *event;
@@ -1043,8 +1044,17 @@ static void clear_queue(struct file *file, bool re=
start_events)
 		spin_lock(&group->notification_lock);
 	}
 	spin_unlock(&group->notification_lock);
+	group->queue_opened =3D false;
+	mutex_unlock(&group->queue_mutex);
 }
=20
+static int fanotify_queue_release(struct inode *ignored, struct file *fi=
le)
+{
+	clear_queue(file, true);
+	return 0;
+}
+
+
 static int fanotify_release(struct inode *ignored, struct file *file)
 {
 	struct fsnotify_group *group =3D file->private_data;
@@ -1092,6 +1102,47 @@ static int fanotify_release(struct inode *ignored,=
 struct file *file)
 	return 0;
 }
=20
+static int fanotify_open_queue_fd(struct file *file)
+{
+	struct fsnotify_group *group =3D file->private_data;
+	int f_flags, fd;
+	struct file *queue_file;
+
+	if (!FAN_GROUP_FLAG(group, FAN_RESTARTABLE_EVENTS))
+		return -EINVAL;
+
+	mutex_lock(&group->queue_mutex);
+	if (group->queue_opened) {
+		fd =3D -EEXIST;
+		goto out_unlock;
+	}
+
+	f_flags =3D O_RDWR;
+	if (group->fanotify_data.flags & FAN_CLOEXEC)
+		f_flags |=3D O_CLOEXEC;
+	if (group->fanotify_data.flags & FAN_NONBLOCK)
+		f_flags |=3D O_NONBLOCK;
+
+	fd =3D get_unused_fd_flags(f_flags);
+	if (fd < 0)
+		goto out_unlock;
+
+	queue_file =3D anon_inode_getfile_fmode("[fanotify]",
+					      &fanotify_queue_fops, group,
+					      f_flags, FMODE_NONOTIFY);
+	if (IS_ERR(queue_file)) {
+		put_unused_fd(fd);
+		fd =3D PTR_ERR(queue_file);
+		goto out_unlock;
+	}
+	fd_install(fd, queue_file);
+	group->queue_opened =3D true;
+
+out_unlock:
+	mutex_unlock(&group->queue_mutex);
+	return fd;
+}
+
 static long fanotify_ioctl(struct file *file, unsigned int cmd, unsigned=
 long arg)
 {
 	struct fsnotify_group *group;
@@ -1112,12 +1163,15 @@ static long fanotify_ioctl(struct file *file, uns=
igned int cmd, unsigned long ar
 		spin_unlock(&group->notification_lock);
 		ret =3D put_user(send_len, (int __user *) p);
 		break;
+	case FAN_IOC_OPEN_QUEUE_FD:
+		ret =3D fanotify_open_queue_fd(file);
+		break;
 	}
=20
 	return ret;
 }
=20
-static const struct file_operations fanotify_fops =3D {
+const struct file_operations fanotify_fops =3D {
 	.show_fdinfo	=3D fanotify_show_fdinfo,
 	.poll		=3D fanotify_poll,
 	.read		=3D fanotify_read,
@@ -1129,6 +1183,30 @@ static const struct file_operations fanotify_fops =
=3D {
 	.llseek		=3D noop_llseek,
 };
=20
+const struct file_operations fanotify_control_fops =3D {
+	.show_fdinfo	=3D fanotify_show_fdinfo,
+	.poll		=3D NULL,
+	.read		=3D NULL,
+	.write		=3D NULL,
+	.fasync		=3D NULL,
+	.release	=3D fanotify_release,
+	.unlocked_ioctl	=3D fanotify_ioctl,
+	.compat_ioctl	=3D compat_ptr_ioctl,
+	.llseek		=3D noop_llseek,
+};
+
+const struct file_operations fanotify_queue_fops =3D {
+	.show_fdinfo	=3D fanotify_show_fdinfo,
+	.poll		=3D fanotify_poll,
+	.read		=3D fanotify_read,
+	.write		=3D fanotify_write,
+	.fasync		=3D NULL,
+	.release	=3D fanotify_queue_release,
+	.unlocked_ioctl	=3D NULL,
+	.compat_ioctl	=3D compat_ptr_ioctl,
+	.llseek		=3D noop_llseek,
+};
+
 static int fanotify_find_path(int dfd, const char __user *filename,
 			      struct path *path, unsigned int flags, __u64 mask,
 			      unsigned int obj_type)
@@ -1541,6 +1619,7 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flags,=
 unsigned int, event_f_flags)
 	int f_flags, fd;
 	unsigned int fid_mode =3D flags & FANOTIFY_FID_BITS;
 	unsigned int class =3D flags & FANOTIFY_CLASS_BITS;
+	unsigned int restartable_events =3D flags & FAN_RESTARTABLE_EVENTS;
 	unsigned int internal_flags =3D 0;
 	struct file *file;
=20
@@ -1620,10 +1699,17 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flag=
s, unsigned int, event_f_flags)
 	    (!(fid_mode & FAN_REPORT_NAME) || !(fid_mode & FAN_REPORT_FID)))
 		return -EINVAL;
=20
-	f_flags =3D O_RDWR;
+	/*
+	 * FAN_RESTARTABLE_EVENTS requires FAN_CLASS_CONTENT or
+	 * FAN_CLASS_PRE_CONTENT
+	 */
+	if (restartable_events && class =3D=3D FAN_CLASS_NOTIF)
+		return -EINVAL;
+
+	f_flags =3D restartable_events ? O_RDONLY : O_RDWR;
 	if (flags & FAN_CLOEXEC)
 		f_flags |=3D O_CLOEXEC;
-	if (flags & FAN_NONBLOCK)
+	if (!restartable_events && (flags & FAN_NONBLOCK))
 		f_flags |=3D O_NONBLOCK;
=20
 	/* fsnotify_alloc_group takes a ref.  Dropped in fanotify_release */
@@ -1694,8 +1780,10 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flags=
, unsigned int, event_f_flags)
 	if (fd < 0)
 		goto out_destroy_group;
=20
-	file =3D anon_inode_getfile_fmode("[fanotify]", &fanotify_fops, group,
-					f_flags, FMODE_NONOTIFY);
+	file =3D anon_inode_getfile_fmode("[fanotify]",
+					(restartable_events ? &fanotify_control_fops :
+					&fanotify_fops),
+					group, f_flags, FMODE_NONOTIFY);
 	if (IS_ERR(file)) {
 		put_unused_fd(fd);
 		fd =3D PTR_ERR(file);
@@ -1920,7 +2008,8 @@ static int do_fanotify_mark(int fanotify_fd, unsign=
ed int flags, __u64 mask,
 		return -EBADF;
=20
 	/* verify that this is indeed an fanotify instance */
-	if (unlikely(fd_file(f)->f_op !=3D &fanotify_fops))
+	if (unlikely(fd_file(f)->f_op !=3D &fanotify_fops &&
+		fd_file(f)->f_op !=3D &fanotify_control_fops))
 		return -EINVAL;
 	group =3D fd_file(f)->private_data;
=20
@@ -1937,6 +2026,14 @@ static int do_fanotify_mark(int fanotify_fd, unsig=
ned int flags, __u64 mask,
 			return -EINVAL;
 	}
=20
+	/*
+	 * With FAN_RESTARTABLE_EVENTS, a user is only allowed to setup
+	 * permission events
+	 */
+	if (FAN_GROUP_FLAG(group, FAN_RESTARTABLE_EVENTS) &&
+		!fanotify_is_perm_event(mask))
+		return -EINVAL;
+
 	/*
 	 * A user is allowed to setup sb/mount/mntns marks only if it is
 	 * capable in the user ns where the group was created.
@@ -2142,7 +2239,7 @@ static int __init fanotify_user_setup(void)
 				     FANOTIFY_DEFAULT_MAX_USER_MARKS);
=20
 	BUILD_BUG_ON(FANOTIFY_INIT_FLAGS & FANOTIFY_INTERNAL_GROUP_FLAGS);
-	BUILD_BUG_ON(HWEIGHT32(FANOTIFY_INIT_FLAGS) !=3D 14);
+	BUILD_BUG_ON(HWEIGHT32(FANOTIFY_INIT_FLAGS) !=3D 15);
 	BUILD_BUG_ON(HWEIGHT32(FANOTIFY_MARK_FLAGS) !=3D 11);
=20
 	fanotify_mark_cache =3D KMEM_CACHE(fanotify_mark,
diff --git a/fs/notify/group.c b/fs/notify/group.c
index 18446b7b0d49..949a8023a7e4 100644
--- a/fs/notify/group.c
+++ b/fs/notify/group.c
@@ -25,6 +25,7 @@ static void fsnotify_final_destroy_group(struct fsnotif=
y_group *group)
 		group->ops->free_group_priv(group);
=20
 	mem_cgroup_put(group->memcg);
+	mutex_destroy(&group->queue_mutex);
 	mutex_destroy(&group->mark_mutex);
=20
 	kfree(group);
@@ -130,6 +131,7 @@ static struct fsnotify_group *__fsnotify_alloc_group(
 	init_waitqueue_head(&group->notification_waitq);
 	group->max_events =3D UINT_MAX;
=20
+	mutex_init(&group->queue_mutex);
 	mutex_init(&group->mark_mutex);
 	INIT_LIST_HEAD(&group->marks_list);
=20
diff --git a/include/linux/fanotify.h b/include/linux/fanotify.h
index 879cff5eccd4..38854a1d6485 100644
--- a/include/linux/fanotify.h
+++ b/include/linux/fanotify.h
@@ -37,6 +37,7 @@
 					 FAN_REPORT_TID | \
 					 FAN_REPORT_PIDFD | \
 					 FAN_REPORT_FD_ERROR | \
+					 FAN_RESTARTABLE_EVENTS | \
 					 FAN_UNLIMITED_QUEUE | \
 					 FAN_UNLIMITED_MARKS)
=20
diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_ba=
ckend.h
index d4034ddaf392..1203124dc9e8 100644
--- a/include/linux/fsnotify_backend.h
+++ b/include/linux/fsnotify_backend.h
@@ -231,6 +231,8 @@ struct fsnotify_group {
 	unsigned int max_events;		/* maximum events allowed on the list */
 	enum fsnotify_group_prio priority;	/* priority for sending events */
 	bool shutdown;		/* group is being shut down, don't queue more events */
+	bool queue_opened; /* whether or not a queue fd has been issued */
+	struct mutex queue_mutex; /* protects event queue during open / release=
 */
=20
 #define FSNOTIFY_GROUP_USER	0x01 /* user allocated group */
 #define FSNOTIFY_GROUP_DUPS	0x02 /* allow multiple marks per object */
diff --git a/include/uapi/linux/fanotify.h b/include/uapi/linux/fanotify.=
h
index e710967c7c26..008097628279 100644
--- a/include/uapi/linux/fanotify.h
+++ b/include/uapi/linux/fanotify.h
@@ -67,6 +67,7 @@
 #define FAN_REPORT_TARGET_FID	0x00001000	/* Report dirent target id  */
 #define FAN_REPORT_FD_ERROR	0x00002000	/* event->fd can report error */
 #define FAN_REPORT_MNT		0x00004000	/* Report mount events */
+#define FAN_RESTARTABLE_EVENTS		0x00008000 /* enable control-fd/queue-ap=
i */
=20
 /* Convenience macro - FAN_REPORT_NAME requires FAN_REPORT_DIR_FID */
 #define FAN_REPORT_DFID_NAME	(FAN_REPORT_DIR_FID | FAN_REPORT_NAME)
@@ -271,4 +272,9 @@ struct fanotify_response_info_audit_rule {
 				(long)(meta)->event_len >=3D (long)FAN_EVENT_METADATA_LEN && \
 				(long)(meta)->event_len <=3D (long)(len))
=20
+/* fanotify ioctls */
+
+/* Issue a queue fd used in control-fd api to read and respond to events=
 */
+#define FAN_IOC_OPEN_QUEUE_FD	_IO('F', 0xF0)
+
 #endif /* _UAPI_LINUX_FANOTIFY_H */
diff --git a/tools/include/uapi/linux/fanotify.h b/tools/include/uapi/lin=
ux/fanotify.h
index e710967c7c26..008097628279 100644
--- a/tools/include/uapi/linux/fanotify.h
+++ b/tools/include/uapi/linux/fanotify.h
@@ -67,6 +67,7 @@
 #define FAN_REPORT_TARGET_FID	0x00001000	/* Report dirent target id  */
 #define FAN_REPORT_FD_ERROR	0x00002000	/* event->fd can report error */
 #define FAN_REPORT_MNT		0x00004000	/* Report mount events */
+#define FAN_RESTARTABLE_EVENTS		0x00008000 /* enable control-fd/queue-ap=
i */
=20
 /* Convenience macro - FAN_REPORT_NAME requires FAN_REPORT_DIR_FID */
 #define FAN_REPORT_DFID_NAME	(FAN_REPORT_DIR_FID | FAN_REPORT_NAME)
@@ -271,4 +272,9 @@ struct fanotify_response_info_audit_rule {
 				(long)(meta)->event_len >=3D (long)FAN_EVENT_METADATA_LEN && \
 				(long)(meta)->event_len <=3D (long)(len))
=20
+/* fanotify ioctls */
+
+/* Issue a queue fd used in control-fd api to read and respond to events=
 */
+#define FAN_IOC_OPEN_QUEUE_FD	_IO('F', 0xF0)
+
 #endif /* _UAPI_LINUX_FANOTIFY_H */
--=20
2.47.3


