Return-Path: <linux-fsdevel+bounces-54583-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3A12B0114D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 04:37:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 110A95C031D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 02:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6664718DF6E;
	Fri, 11 Jul 2025 02:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="krgiJkZm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 165B910E9
	for <linux-fsdevel@vger.kernel.org>; Fri, 11 Jul 2025 02:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752201413; cv=none; b=eb+gf+ZNfuhN9CHGZKX48vo4cNIYczG8lp9F/npzRDvkN8YEs0dx8Y5H9kIy+alI3dbHXF39+KV73FR9WN7xaE8uBxOK8CnJYkWe+2cYFhgXzhmKCHdresnWP44PO18MvsjHsvHCsR6AIsByHStuIkNvm1C8zTY7Mn1ZySxOkXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752201413; c=relaxed/simple;
	bh=6vxxdEWNuCtZo1HGJf8cmz5Jh6VkSh2IzEI+SkF7sIo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D+wxI4aOYAQYwoE12GBOsxFMpGyeDR08U6Y5xB0OMPtWANtTUj8f5yqWjCUTbm4SAh+1XEiU16sAKNMh7fna76e6HEtQUetFRNlrIYuQMZCa13XpviAiJk5XkWX+XEFiAU4qMsHxg1E5P4rRWjs61XCpeBRdIpqpJIDzNvldQoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=krgiJkZm; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56ANO0d8029778
	for <linux-fsdevel@vger.kernel.org>; Thu, 10 Jul 2025 19:36:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=yokyKGwumsqFIhA7wRrh+TYRzjAAZbf40x3OMCszS44=; b=krgiJkZmqlsd
	2EMjlnmBT0hUfZ1DPJKnCkLc95OdC2ejM5UwJIQZZ2n8UzRKJqZlSWwUOXyp5rQu
	fssUIJJtAqvd3MbEKJ3thWUAWCbZWC4kt4SnZnMd41mCoO2kHDmxqsClAIbEz63c
	bfB1kzy8iGwpSWlJBgWIkpmgEMWqcYB6teTa/rnZcfYqX56oAGx5u7ExU/+8RLkG
	yTNFZ3QA2K5dv6AHo/lkCEiJ18zD+0Sr3I2AWBpCJGuWa9ayFXSkN/DwwJ9jDvDP
	wXprgti5P8iElGkgAC1N7Z0JAutKymyHmQ64aia2RXLAxBljyRmLj2llsw8lrFp/
	bnDntj/jbQ==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 47t81cyxme-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Thu, 10 Jul 2025 19:36:51 -0700 (PDT)
Received: from twshared7571.34.frc3.facebook.com (2620:10d:c0a8:1b::30) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1748.24; Fri, 11 Jul 2025 02:36:47 +0000
Received: by devvm18334.vll0.facebook.com (Postfix, from userid 202792)
	id 481EE3200EF56; Thu, 10 Jul 2025 19:36:44 -0700 (PDT)
From: Ibrahim Jirdeh <ibrahimjirdeh@meta.com>
To: <ibrahimjirdeh@meta.com>
CC: <jack@suse.cz>, <amir73il@gmail.com>, <josef@toxicpanda.com>,
        <lesha@meta.com>, <linux-fsdevel@vger.kernel.org>, <sargun@meta.com>
Subject: [PATCH v3 3/3] fanotify: introduce event response identifier
Date: Thu, 10 Jul 2025 19:36:04 -0700
Message-ID: <20250711023604.593885-4-ibrahimjirdeh@meta.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250711023604.593885-1-ibrahimjirdeh@meta.com>
References: <20250711023604.593885-1-ibrahimjirdeh@meta.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzExMDAxNyBTYWx0ZWRfX5kWiO1qliY7D alShTuC+zSk4RFD0ulyayTmgajawVnx7JbodtgmSWIcy8LvSb3gbUqormlBFBa6MpvBdvtxPXWy c+zGw0VRxoy+biwVEOo80rMYs3bx38AoTDL5r4bb56s6mVNOILnp07lhWuUBd1Ccpt4oYT4aF9g
 iVCTf+K7acKHsEoIxEcP4pXUvas87v/jjIvHEC2i5/RnZZ8HbHfTO7vwJ3vGJ9yyTji07n6iPHI 6oI6A0AM3N5D2rDKt7uOfcBl0GvEGfrulLVKOJNAKICki+qWAraLKdP4+TtVcRGmBHsRb/p8S/X bYjz4fRlcGA1+hqeWzD8s2ZJIg/ot17h0WO2NiTVCFal8bP4CLlahWxic4hsKprOnHqy5Ydc6vN
 G1W2rX5DreEzN6R93GAPKhpZabpL6PxXPEf/41k4i04r7qzBxWR7/EXx3Aiv8Lg1qbJajE98
X-Authority-Analysis: v=2.4 cv=ecA9f6EH c=1 sm=1 tr=0 ts=687078c3 cx=c_pps a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=VabnemYjAAAA:8 a=ChkzHjXy8z1_0ozgDZ8A:9 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-GUID: M40NeEZWLOVNbkhkYLedDZkCQxUjeLZG
X-Proofpoint-ORIG-GUID: M40NeEZWLOVNbkhkYLedDZkCQxUjeLZG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-11_01,2025-07-09_01,2025-03-28_01

This adds support for responding to events via response identifier. This
prevents races if there are multiple processes backing the same fanotify
group (eg. handover of fanotify group to new instance of a backing daemon=
).
It is also useful for reporting pre-dir-content events without an
event->fd:
https://lore.kernel.org/linux-fsdevel/2dx3pbcnv5w75fxb2ghqtsk6gzl6cuxmd2r=
inzwbq7xxfjf5z7@3nqidi3mno46/.

Rather than introducing a new event identifier field and extending
fanotify_event_metadata, we have opted to overload event->fd and restrict
this functionality to use-cases which are using file handle apis
(FAN_REPORT_FID).

In terms of how response ids are allocated, we use an idr for allocation
and restrict the id range to below -255 to ensure there is no overlap wit=
h
existing fd-as-identifier usage. We can also leverage the added idr for
more efficient lookup when handling response although that is not done
in this patch.

Suggested-by: Amir Goldstein <amir73il@gmail.com>
Link: https://lore.kernel.org/linux-fsdevel/CAOQ4uxheeLXdTLLWrixnTJcxVP+B=
V4ViXijbvERHPenzgDMUTA@mail.gmail.com/
Signed-off-by: Ibrahim Jirdeh <ibrahimjirdeh@meta.com>
---
 fs/notify/fanotify/fanotify.c       |  3 ++
 fs/notify/fanotify/fanotify.h       | 11 ++++-
 fs/notify/fanotify/fanotify_user.c  | 63 ++++++++++++++++++++---------
 include/linux/fanotify.h            |  1 +
 include/linux/fsnotify_backend.h    |  1 +
 include/uapi/linux/fanotify.h       | 11 ++++-
 tools/include/uapi/linux/fanotify.h | 11 ++++-
 7 files changed, 77 insertions(+), 24 deletions(-)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.=
c
index 34acb7c16e8b..d9aebd359199 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -1106,6 +1106,9 @@ static void fanotify_free_event(struct fsnotify_gro=
up *group,
=20
 	event =3D FANOTIFY_E(fsn_event);
 	put_pid(event->pid);
+	if (fanotify_is_perm_event(event->mask) &&
+	    FAN_GROUP_FLAG(group, FAN_REPORT_RESPONSE_ID))
+		idr_remove(&group->response_idr, -FANOTIFY_PERM(event)->id);
 	switch (event->type) {
 	case FANOTIFY_EVENT_TYPE_PATH:
 		fanotify_free_path_event(event);
diff --git a/fs/notify/fanotify/fanotify.h b/fs/notify/fanotify/fanotify.=
h
index f6d25fcf8692..b6a414f44acc 100644
--- a/fs/notify/fanotify/fanotify.h
+++ b/fs/notify/fanotify/fanotify.h
@@ -444,7 +444,7 @@ struct fanotify_perm_event {
 	size_t count;
 	u32 response;			/* userspace answer to the event */
 	unsigned short state;		/* state of the event */
-	int fd;		/* fd we passed to userspace for this event */
+	int id;		/* id we passed to userspace for this event */
 	union {
 		struct fanotify_response_info_header hdr;
 		struct fanotify_response_info_audit_rule audit_rule;
@@ -559,3 +559,12 @@ static inline u32 fanotify_get_response_errno(int re=
s)
 {
 	return (res >> FAN_ERRNO_SHIFT) & FAN_ERRNO_MASK;
 }
+
+static inline bool fanotify_is_valid_response_id(struct fsnotify_group *=
group,
+						 int id)
+{
+	if (FAN_GROUP_FLAG(group, FAN_REPORT_RESPONSE_ID))
+		return id < -255;
+
+	return id >=3D 0;
+}
diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fano=
tify_user.c
index 19d3f2d914fe..2e14db38d298 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -330,14 +330,19 @@ static int process_access_response(struct fsnotify_=
group *group,
 				   size_t info_len)
 {
 	struct fanotify_perm_event *event;
-	int fd =3D response_struct->fd;
+	int id =3D response_struct->id;
 	u32 response =3D response_struct->response;
 	int errno =3D fanotify_get_response_errno(response);
 	int ret =3D info_len;
 	struct fanotify_response_info_audit_rule friar;
=20
-	pr_debug("%s: group=3D%p fd=3D%d response=3D%x errno=3D%d buf=3D%p size=
=3D%zu\n",
-		 __func__, group, fd, response, errno, info, info_len);
+	BUILD_BUG_ON(sizeof(response_struct->id) !=3D
+		     sizeof(response_struct->fd));
+	BUILD_BUG_ON(offsetof(struct fanotify_response, id) !=3D
+		     offsetof(struct fanotify_response, fd));
+
+	pr_debug("%s: group=3D%p id=3D%d response=3D%x errno=3D%d buf=3D%p size=
=3D%zu\n",
+		 __func__, group, id, response, errno, info, info_len);
 	/*
 	 * make sure the response is valid, if invalid we do nothing and either
 	 * userspace can send a valid response or we will clean it up after the
@@ -385,19 +390,18 @@ static int process_access_response(struct fsnotify_=
group *group,
 		ret =3D process_access_response_info(info, info_len, &friar);
 		if (ret < 0)
 			return ret;
-		if (fd =3D=3D FAN_NOFD)
+		if (id =3D=3D FAN_NOFD)
 			return ret;
 	} else {
 		ret =3D 0;
 	}
-
-	if (fd < 0)
+	if (!fanotify_is_valid_response_id(group, id))
 		return -EINVAL;
=20
 	spin_lock(&group->notification_lock);
 	list_for_each_entry(event, &group->fanotify_data.access_list,
 			    fae.fse.list) {
-		if (event->fd !=3D fd)
+		if (event->id !=3D id)
 			continue;
=20
 		list_del_init(&event->fae.fse.list);
@@ -765,14 +769,20 @@ static ssize_t copy_event_to_user(struct fsnotify_g=
roup *group,
 	    task_tgid(current) !=3D event->pid)
 		metadata.pid =3D 0;
=20
-	/*
-	 * For now, fid mode is required for an unprivileged listener and
-	 * fid mode does not report fd in events.  Keep this check anyway
-	 * for safety in case fid mode requirement is relaxed in the future
-	 * to allow unprivileged listener to get events with no fd and no fid.
-	 */
-	if (!FAN_GROUP_FLAG(group, FANOTIFY_UNPRIV) &&
-	    path && path->mnt && path->dentry) {
+	if (FAN_GROUP_FLAG(group, FAN_REPORT_RESPONSE_ID)) {
+		ret =3D idr_alloc_cyclic(&group->response_idr, event, 256,
+				       INT_MAX, GFP_NOWAIT);
+		if (ret < 0)
+			return ret;
+		fd =3D -ret;
+	} else if (!FAN_GROUP_FLAG(group, FANOTIFY_UNPRIV) && path &&
+		   path->mnt && path->dentry) {
+		/*
+		 * For now, fid mode is required for an unprivileged listener and
+		 * fid mode does not report fd in events.  Keep this check anyway
+		 * for safety in case fid mode requirement is relaxed in the future
+		 * to allow unprivileged listener to get events with no fd and no fid.
+		 */
 		fd =3D create_fd(group, path, &f);
 		/*
 		 * Opening an fd from dentry can fail for several reasons.
@@ -803,7 +813,11 @@ static ssize_t copy_event_to_user(struct fsnotify_gr=
oup *group,
 			}
 		}
 	}
-	if (FAN_GROUP_FLAG(group, FAN_REPORT_FD_ERROR))
+
+	BUILD_BUG_ON(sizeof(metadata.id) !=3D sizeof(metadata.fd));
+	BUILD_BUG_ON(offsetof(struct fanotify_event_metadata, id) !=3D
+		     offsetof(struct fanotify_event_metadata, fd));
+	if (FAN_GROUP_FLAG(group, FAN_REPORT_FD_ERROR | FAN_REPORT_RESPONSE_ID)=
)
 		metadata.fd =3D fd;
 	else
 		metadata.fd =3D fd >=3D 0 ? fd : FAN_NOFD;
@@ -859,7 +873,7 @@ static ssize_t copy_event_to_user(struct fsnotify_gro=
up *group,
 		fd_install(pidfd, pidfd_file);
=20
 	if (fanotify_is_perm_event(event->mask))
-		FANOTIFY_PERM(event)->fd =3D fd;
+		FANOTIFY_PERM(event)->id =3D fd;
=20
 	return metadata.event_len;
=20
@@ -944,7 +958,9 @@ static ssize_t fanotify_read(struct file *file, char =
__user *buf,
 		if (!fanotify_is_perm_event(event->mask)) {
 			fsnotify_destroy_event(group, &event->fse);
 		} else {
-			if (ret <=3D 0 || FANOTIFY_PERM(event)->fd < 0) {
+			if (ret <=3D 0 ||
+			    !fanotify_is_valid_response_id(
+				    group, FANOTIFY_PERM(event)->id)) {
 				spin_lock(&group->notification_lock);
 				finish_permission_event(group,
 					FANOTIFY_PERM(event), FAN_DENY, NULL);
@@ -1584,6 +1600,14 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flags=
, unsigned int, event_f_flags)
 		return -EINVAL;
=20
 	/*
+     * With group that reports fid info and allows pre-content events,
+     * user may request to get a response id instead of event->fd.
+     */
+	if ((flags & FAN_REPORT_RESPONSE_ID) &&
+	    (!fid_mode || class =3D=3D FAN_CLASS_NOTIF))
+		return -EINVAL;
+
+	/*
 	 * Child name is reported with parent fid so requires dir fid.
 	 * We can report both child fid and dir fid with or without name.
 	 */
@@ -1660,6 +1684,7 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flags,=
 unsigned int, event_f_flags)
 		fd =3D -EINVAL;
 		goto out_destroy_group;
 	}
+	idr_init(&group->response_idr);
=20
 	BUILD_BUG_ON(!(FANOTIFY_ADMIN_INIT_FLAGS & FAN_UNLIMITED_QUEUE));
 	if (flags & FAN_UNLIMITED_QUEUE) {
@@ -2145,7 +2170,7 @@ static int __init fanotify_user_setup(void)
 				     FANOTIFY_DEFAULT_MAX_USER_MARKS);
=20
 	BUILD_BUG_ON(FANOTIFY_INIT_FLAGS & FANOTIFY_INTERNAL_GROUP_FLAGS);
-	BUILD_BUG_ON(HWEIGHT32(FANOTIFY_INIT_FLAGS) !=3D 14);
+	BUILD_BUG_ON(HWEIGHT32(FANOTIFY_INIT_FLAGS) !=3D 15);
 	BUILD_BUG_ON(HWEIGHT32(FANOTIFY_MARK_FLAGS) !=3D 11);
=20
 	fanotify_mark_cache =3D KMEM_CACHE(fanotify_mark,
diff --git a/include/linux/fanotify.h b/include/linux/fanotify.h
index 879cff5eccd4..85fce0a15005 100644
--- a/include/linux/fanotify.h
+++ b/include/linux/fanotify.h
@@ -37,6 +37,7 @@
 					 FAN_REPORT_TID | \
 					 FAN_REPORT_PIDFD | \
 					 FAN_REPORT_FD_ERROR | \
+					 FAN_REPORT_RESPONSE_ID | \
 					 FAN_UNLIMITED_QUEUE | \
 					 FAN_UNLIMITED_MARKS)
=20
diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_ba=
ckend.h
index 832d94d783d9..83c82331866b 100644
--- a/include/linux/fsnotify_backend.h
+++ b/include/linux/fsnotify_backend.h
@@ -232,6 +232,7 @@ struct fsnotify_group {
 	unsigned int max_events;		/* maximum events allowed on the list */
 	enum fsnotify_group_prio priority;	/* priority for sending events */
 	bool shutdown;		/* group is being shut down, don't queue more events */
+	struct idr response_idr; /* used for response id allocation */
=20
 #define FSNOTIFY_GROUP_USER	0x01 /* user allocated group */
 #define FSNOTIFY_GROUP_DUPS	0x02 /* allow multiple marks per object */
diff --git a/include/uapi/linux/fanotify.h b/include/uapi/linux/fanotify.=
h
index 28074ab3e794..e705dda14dfc 100644
--- a/include/uapi/linux/fanotify.h
+++ b/include/uapi/linux/fanotify.h
@@ -67,6 +67,7 @@
 #define FAN_REPORT_TARGET_FID	0x00001000	/* Report dirent target id  */
 #define FAN_REPORT_FD_ERROR	0x00002000	/* event->fd can report error */
 #define FAN_REPORT_MNT		0x00004000	/* Report mount events */
+#define FAN_REPORT_RESPONSE_ID		0x00008000 /* event->fd is a response id=
 */
=20
 /* Convenience macro - FAN_REPORT_NAME requires FAN_REPORT_DIR_FID */
 #define FAN_REPORT_DFID_NAME	(FAN_REPORT_DIR_FID | FAN_REPORT_NAME)
@@ -144,7 +145,10 @@ struct fanotify_event_metadata {
 	__u8 reserved;
 	__u16 metadata_len;
 	__aligned_u64 mask;
-	__s32 fd;
+	union {
+		__s32 fd;
+		__s32 id; /* FAN_REPORT_RESPONSE_ID */
+	};
 	__s32 pid;
 };
=20
@@ -228,7 +232,10 @@ struct fanotify_event_info_mnt {
 #define FAN_RESPONSE_INFO_AUDIT_RULE	1
=20
 struct fanotify_response {
-	__s32 fd;
+	union {
+		__s32 fd;
+		__s32 id; /* FAN_REPORT_RESPONSE_ID */
+	};
 	__u32 response;
 };
=20
diff --git a/tools/include/uapi/linux/fanotify.h b/tools/include/uapi/lin=
ux/fanotify.h
index e710967c7c26..6a3ada7c4abf 100644
--- a/tools/include/uapi/linux/fanotify.h
+++ b/tools/include/uapi/linux/fanotify.h
@@ -67,6 +67,7 @@
 #define FAN_REPORT_TARGET_FID	0x00001000	/* Report dirent target id  */
 #define FAN_REPORT_FD_ERROR	0x00002000	/* event->fd can report error */
 #define FAN_REPORT_MNT		0x00004000	/* Report mount events */
+#define FAN_REPORT_RESPONSE_ID		0x00008000 /* event->fd is a response id=
 */
=20
 /* Convenience macro - FAN_REPORT_NAME requires FAN_REPORT_DIR_FID */
 #define FAN_REPORT_DFID_NAME	(FAN_REPORT_DIR_FID | FAN_REPORT_NAME)
@@ -141,7 +142,10 @@ struct fanotify_event_metadata {
 	__u8 reserved;
 	__u16 metadata_len;
 	__aligned_u64 mask;
-	__s32 fd;
+	union {
+		__s32 fd;
+		__s32 id; /* FAN_REPORT_RESPONSE_ID */
+	};
 	__s32 pid;
 };
=20
@@ -225,7 +229,10 @@ struct fanotify_event_info_mnt {
 #define FAN_RESPONSE_INFO_AUDIT_RULE	1
=20
 struct fanotify_response {
-	__s32 fd;
+	union {
+		__s32 fd;
+		__s32 id; /* FAN_REPORT_RESPONSE_ID */
+	};
 	__u32 response;
 };
=20
--=20
2.47.1


