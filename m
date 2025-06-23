Return-Path: <linux-fsdevel+bounces-52641-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CEE63AE4DA7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 21:36:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71BDE1897AE9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 19:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E96029B8EA;
	Mon, 23 Jun 2025 19:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="KjvSrpbq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA0C719CC11
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Jun 2025 19:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750707401; cv=none; b=V+IPd60AnAC1UgDmDRNTxMpV+42YtIino/TrBoCQvuJj9NquVLkU1Pxhug24Eteg1FBbbbPwKwHYM1e+GmlkbQk/x0ldzy2hr1lbE58v+89bmwq8/roC7hqTohh/KZFfdgXsT3mUddhSkOL/NKa7MophuzqQu0xRmcXx2DJSmcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750707401; c=relaxed/simple;
	bh=kOCI0ZBm1BXyrIDy1tu8NbVhKvb1O+GyUvj2liCRBgQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RFprL20WT7s2BsRo/Sv4LNjl8ah9YjamuIym+adXMOf+HbHU2tcmDnp0wr3BDwUHjhBXBGQ6IGr3c/3kttPD1gPyjO6wYXwPL6vD8CY4JITCqa//xjSRLGiyNVHz/JV+h1/prr6C5FkmlbskFBim2KDDnraRrG+SQUcY4MmuaRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=KjvSrpbq; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.18.1.2/8.18.1.2) with ESMTP id 55NIg553013324
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Jun 2025 12:36:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2021-q4; bh=SjGFQONy/l3bUnTRSZ
	pEksu5BmhBkPkgRqQxXPYINbc=; b=KjvSrpbqmldoOZcyWL+StGbNUc9jqt7MXF
	iZ9uI0TnmSv+fZS0okeagKm8DM+okKcRxE4Am2BNtvIml0YpstxHQXyvytSov/4F
	lz2NjEkpMc0gNT9WoSgrZDbiPkRewN5vHtAnA3ly2YXWKKd/PoEmvLbkhRge2Rbt
	aBBkkqLoyuJOLMGSyZkupaAQDenHOyX9BTIhKYP9QDV+3b4CU6ove3dTGckQqGPF
	uJqoBimHfuQR54F+GYH35mUKnK1PyVAHylU7UWbbEPksYL/uK6GwHjZEa+8n/W0q
	oxDvzygkAadaBpGgu3Q8vBkbjnQVmbbnp26RKXPaHt/5ukQR6xFg==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by m0089730.ppops.net (PPS) with ESMTPS id 47f0a1dnxp-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Jun 2025 12:36:38 -0700 (PDT)
Received: from twshared57752.46.prn1.facebook.com (2620:10d:c0a8:1b::2d) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1748.24; Mon, 23 Jun 2025 19:36:37 +0000
Received: by devvm18334.vll0.facebook.com (Postfix, from userid 202792)
	id 75F0C30430343; Mon, 23 Jun 2025 12:36:34 -0700 (PDT)
From: Ibrahim Jirdeh <ibrahimjirdeh@meta.com>
To: <ibrahimjirdeh@meta.com>
CC: <jack@suse.cz>, <amir73il@gmail.com>, <josef@toxicpanda.com>,
        <lesha@meta.com>, <linux-fsdevel@vger.kernel.org>, <sargun@meta.com>
Subject: [PATCH] fanotify: introduce unique event identifier
Date: Mon, 23 Jun 2025 12:36:31 -0700
Message-ID: <20250623193631.2780278-1-ibrahimjirdeh@meta.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: O8DBQMw574DP60A7hgdyCYA5Oafs-iSo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIzMDEyNyBTYWx0ZWRfX+1ThwR9VOtw8 zJ4DXtU1b9hV6KdJFSyeScEMDtYdd+cq9iLXNXMBDN4mMbFbMG5JnXb025/j5A/PBnOskCJAAEI 96GHedWKib+Jx1XM6p+k6SaKwhmaObhN1jrHtq8jzGC2OkNh90f5AmFxcbIk0s51gV4vfb1/Dcu
 EcjbiiAtdl4L8paF1jsPGFKcZLoh1uxxQl1qvEWh2L8Iisp7N7Uvu2gIJkOik/q8zSlzrqSXHBp 1d8mDmL6x4wElRCZhWfwvkaxP33nOIHb9o7GF3JsvfnRlqrUD+zyozDPeywrmuHVemB5ALJef6p gBkXW/tb8dKmMBxvPOlKtAdst+pxWeDJB02KFBOuBh8XAngfo+4e4hUKRYNdIIAHHV7c6tVA0dM
 3r9cnuSns0obDJ4cefoSIJEEbKwU/VbdK3fUEWgLk4zanLkrRMK314HrxKLWdPFLPjzU8Nns
X-Authority-Analysis: v=2.4 cv=BuudwZX5 c=1 sm=1 tr=0 ts=6859acc6 cx=c_pps a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17 a=6IFa9wvqVegA:10 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=VabnemYjAAAA:8 a=fVmcN3OLhFusbdT4Y2cA:9 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-GUID: O8DBQMw574DP60A7hgdyCYA5Oafs-iSo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-23_06,2025-06-23_07,2025-03-28_01

This adds support for responding to events via a unique event
identifier. The main goal is to prevent races if there are multiple
processes backing the same fanotify group (eg. handover of fanotify
group to new instance of a backing daemon). A new event id field is
added to fanotify metadata which is unique per group, and this behavior
is guarded by FAN_ENABLE_EVENT_ID flag.

Some related discussion which this follows:
https://lore.kernel.org/all/CAOQ4uxhuPBWD=3DTYZw974NsKFno-iNYSkHPw6WTfG_6=
9ovS=3DnJA@mail.gmail.com/

Signed-off-by: Ibrahim Jirdeh <ibrahimjirdeh@meta.com>
---
 fs/notify/fanotify/fanotify.h       |  1 +
 fs/notify/fanotify/fanotify_user.c  | 37 +++++++++++++++++++++++------
 include/linux/fanotify.h            |  3 ++-
 include/linux/fsnotify_backend.h    |  1 +
 include/uapi/linux/fanotify.h       |  4 ++++
 tools/include/uapi/linux/fanotify.h |  4 ++++
 6 files changed, 42 insertions(+), 8 deletions(-)

diff --git a/fs/notify/fanotify/fanotify.h b/fs/notify/fanotify/fanotify.=
h
index b78308975082..383c28c3f977 100644
--- a/fs/notify/fanotify/fanotify.h
+++ b/fs/notify/fanotify/fanotify.h
@@ -442,6 +442,7 @@ struct fanotify_perm_event {
 	u32 response;			/* userspace answer to the event */
 	unsigned short state;		/* state of the event */
 	int fd;		/* fd we passed to userspace for this event */
+	u64 event_id;		/* unique event identifier for this event */
 	union {
 		struct fanotify_response_info_header hdr;
 		struct fanotify_response_info_audit_rule audit_rule;
diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fano=
tify_user.c
index 02669abff4a5..c523c6283f1b 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -331,13 +331,15 @@ static int process_access_response(struct fsnotify_=
group *group,
 {
 	struct fanotify_perm_event *event;
 	int fd =3D response_struct->fd;
+	u64 event_id =3D response_struct->event_id;
 	u32 response =3D response_struct->response;
 	int errno =3D fanotify_get_response_errno(response);
 	int ret =3D info_len;
 	struct fanotify_response_info_audit_rule friar;
=20
-	pr_debug("%s: group=3D%p fd=3D%d response=3D%x errno=3D%d buf=3D%p size=
=3D%zu\n",
-		 __func__, group, fd, response, errno, info, info_len);
+	pr_debug(
+		"%s: group=3D%p fd=3D%d event_id=3D%lld response=3D%x errno=3D%d buf=3D=
%p size=3D%zu\n",
+		__func__, group, fd, event_id, response, errno, info, info_len);
 	/*
 	 * make sure the response is valid, if invalid we do nothing and either
 	 * userspace can send a valid response or we will clean it up after the
@@ -398,13 +400,18 @@ static int process_access_response(struct fsnotify_=
group *group,
 		ret =3D 0;
 	}
=20
-	if (fd < 0)
+	u64 id =3D FAN_GROUP_FLAG(group, FAN_ENABLE_EVENT_ID) ? event_id : fd;
+
+	if (id < 0)
 		return -EINVAL;
=20
 	spin_lock(&group->notification_lock);
 	list_for_each_entry(event, &group->fanotify_data.access_list,
 			    fae.fse.list) {
-		if (event->fd !=3D fd)
+		u64 other_id =3D FAN_GROUP_FLAG(group, FAN_ENABLE_EVENT_ID) ?
+				       event->event_id :
+				       event->fd;
+		if (other_id !=3D id)
 			continue;
=20
 		list_del_init(&event->fae.fse.list);
@@ -815,6 +822,15 @@ static ssize_t copy_event_to_user(struct fsnotify_gr=
oup *group,
 	else
 		metadata.fd =3D fd >=3D 0 ? fd : FAN_NOFD;
=20
+	/*
+	 * Populate unique event id for group with FAN_ENABLE_EVENT_ID.
+	 */
+	if (FAN_GROUP_FLAG(group, FAN_ENABLE_EVENT_ID))
+		metadata.event_id =3D
+			(u64)atomic64_inc_return(&group->event_id_counter);
+	else
+		metadata.event_id =3D -1;
+
 	if (pidfd_mode) {
 		/*
 		 * Complain if the FAN_REPORT_PIDFD and FAN_REPORT_TID mutual
@@ -865,8 +881,10 @@ static ssize_t copy_event_to_user(struct fsnotify_gr=
oup *group,
 	if (pidfd_file)
 		fd_install(pidfd, pidfd_file);
=20
-	if (fanotify_is_perm_event(event->mask))
+	if (fanotify_is_perm_event(event->mask)) {
 		FANOTIFY_PERM(event)->fd =3D fd;
+		FANOTIFY_PERM(event)->event_id =3D metadata.event_id;
+	}
=20
 	return metadata.event_len;
=20
@@ -951,7 +969,11 @@ static ssize_t fanotify_read(struct file *file, char=
 __user *buf,
 		if (!fanotify_is_perm_event(event->mask)) {
 			fsnotify_destroy_event(group, &event->fse);
 		} else {
-			if (ret <=3D 0 || FANOTIFY_PERM(event)->fd < 0) {
+			u64 event_id =3D
+				FAN_GROUP_FLAG(group, FAN_ENABLE_EVENT_ID) ?
+					FANOTIFY_PERM(event)->fd :
+					FANOTIFY_PERM(event)->event_id;
+			if (ret <=3D 0 || event_id < 0) {
 				spin_lock(&group->notification_lock);
 				finish_permission_event(group,
 					FANOTIFY_PERM(event), FAN_DENY, NULL);
@@ -1649,6 +1671,7 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flags,=
 unsigned int, event_f_flags)
 	}
=20
 	group->default_response =3D FAN_ALLOW;
+	atomic64_set(&group->event_id_counter, 0);
=20
 	BUILD_BUG_ON(!(FANOTIFY_ADMIN_INIT_FLAGS & FAN_UNLIMITED_QUEUE));
 	if (flags & FAN_UNLIMITED_QUEUE) {
@@ -2115,7 +2138,7 @@ static int __init fanotify_user_setup(void)
 				     FANOTIFY_DEFAULT_MAX_USER_MARKS);
=20
 	BUILD_BUG_ON(FANOTIFY_INIT_FLAGS & FANOTIFY_INTERNAL_GROUP_FLAGS);
-	BUILD_BUG_ON(HWEIGHT32(FANOTIFY_INIT_FLAGS) !=3D 14);
+	BUILD_BUG_ON(HWEIGHT32(FANOTIFY_INIT_FLAGS) !=3D 15);
 	BUILD_BUG_ON(HWEIGHT32(FANOTIFY_MARK_FLAGS) !=3D 11);
=20
 	fanotify_mark_cache =3D KMEM_CACHE(fanotify_mark,
diff --git a/include/linux/fanotify.h b/include/linux/fanotify.h
index 182fc574b848..08bdb7aac070 100644
--- a/include/linux/fanotify.h
+++ b/include/linux/fanotify.h
@@ -38,7 +38,8 @@
 					 FAN_REPORT_PIDFD | \
 					 FAN_REPORT_FD_ERROR | \
 					 FAN_UNLIMITED_QUEUE | \
-					 FAN_UNLIMITED_MARKS)
+					 FAN_UNLIMITED_MARKS | \
+					 FAN_ENABLE_EVENT_ID)
=20
 /*
  * fanotify_init() flags that are allowed for user without CAP_SYS_ADMIN=
.
diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_ba=
ckend.h
index 9683396acda6..58584a4e500a 100644
--- a/include/linux/fsnotify_backend.h
+++ b/include/linux/fsnotify_backend.h
@@ -232,6 +232,7 @@ struct fsnotify_group {
 	enum fsnotify_group_prio priority;	/* priority for sending events */
 	bool shutdown;		/* group is being shut down, don't queue more events */
 	unsigned int default_response; /* default response sent on group close =
*/
+	atomic64_t event_id_counter; /* counter to generate unique event ids */
=20
 #define FSNOTIFY_GROUP_USER	0x01 /* user allocated group */
 #define FSNOTIFY_GROUP_DUPS	0x02 /* allow multiple marks per object */
diff --git a/include/uapi/linux/fanotify.h b/include/uapi/linux/fanotify.=
h
index 7badde273a66..e9fb8827fe1b 100644
--- a/include/uapi/linux/fanotify.h
+++ b/include/uapi/linux/fanotify.h
@@ -67,6 +67,8 @@
 #define FAN_REPORT_TARGET_FID	0x00001000	/* Report dirent target id  */
 #define FAN_REPORT_FD_ERROR	0x00002000	/* event->fd can report error */
 #define FAN_REPORT_MNT		0x00004000	/* Report mount events */
+/* Flag to populate and respond using unique event id */
+#define FAN_ENABLE_EVENT_ID		0x00008000
=20
 /* Convenience macro - FAN_REPORT_NAME requires FAN_REPORT_DIR_FID */
 #define FAN_REPORT_DFID_NAME	(FAN_REPORT_DIR_FID | FAN_REPORT_NAME)
@@ -143,6 +145,7 @@ struct fanotify_event_metadata {
 	__aligned_u64 mask;
 	__s32 fd;
 	__s32 pid;
+	__u64 event_id;
 };
=20
 #define FAN_EVENT_INFO_TYPE_FID		1
@@ -226,6 +229,7 @@ struct fanotify_event_info_mnt {
=20
 struct fanotify_response {
 	__s32 fd;
+	__u64 event_id;
 	__u32 response;
 };
=20
diff --git a/tools/include/uapi/linux/fanotify.h b/tools/include/uapi/lin=
ux/fanotify.h
index 7badde273a66..e9fb8827fe1b 100644
--- a/tools/include/uapi/linux/fanotify.h
+++ b/tools/include/uapi/linux/fanotify.h
@@ -67,6 +67,8 @@
 #define FAN_REPORT_TARGET_FID	0x00001000	/* Report dirent target id  */
 #define FAN_REPORT_FD_ERROR	0x00002000	/* event->fd can report error */
 #define FAN_REPORT_MNT		0x00004000	/* Report mount events */
+/* Flag to populate and respond using unique event id */
+#define FAN_ENABLE_EVENT_ID		0x00008000
=20
 /* Convenience macro - FAN_REPORT_NAME requires FAN_REPORT_DIR_FID */
 #define FAN_REPORT_DFID_NAME	(FAN_REPORT_DIR_FID | FAN_REPORT_NAME)
@@ -143,6 +145,7 @@ struct fanotify_event_metadata {
 	__aligned_u64 mask;
 	__s32 fd;
 	__s32 pid;
+	__u64 event_id;
 };
=20
 #define FAN_EVENT_INFO_TYPE_FID		1
@@ -226,6 +229,7 @@ struct fanotify_event_info_mnt {
=20
 struct fanotify_response {
 	__s32 fd;
+	__u64 event_id;
 	__u32 response;
 };
=20
--=20
2.47.1


