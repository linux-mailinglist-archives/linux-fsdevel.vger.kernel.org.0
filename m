Return-Path: <linux-fsdevel+bounces-54690-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E8FB2B023AE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 20:32:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6514A5C44D9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 18:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03F152F3644;
	Fri, 11 Jul 2025 18:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="d011DhtR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97CFD2E92D9
	for <linux-fsdevel@vger.kernel.org>; Fri, 11 Jul 2025 18:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752258720; cv=none; b=n94VKDFD4XjAH8U1XRBWVq5202m1E36OSPBSyAnbcX/dtvxLHRA0ikN5pXaCB0RDKvkjnOQmN6bEYTYhicBD+bEpfUvGfQXP+gn1oDqJJ6YrpIWaCNHvH3b3QiAtc004abxT1qDoAjOmpUQdkyJzw/mL3ouWzCGD//8V1CXd9Ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752258720; c=relaxed/simple;
	bh=7luvj32IXZRR1vclPNxdJXQuKZTORwUQ60iaf8SI8qk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XPY1GiQWxeHh2OqolRRjoqXz/0ABP2iWqJqjv5aIMLNPlAJY1DYWk8msGduO26Ecbrt7V0UpfD1HWuODi4P7zf615yfmLpAow7OxSxW9uxHf1X0dELWjfIanYedKCFOppLI02/vCp4dbior/avjoWwBG6RLtsfRtSupaSalZ/xQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=d011DhtR; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56BHWDlU001441
	for <linux-fsdevel@vger.kernel.org>; Fri, 11 Jul 2025 11:31:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=bfrMlYfIgluo2dswNU/gMayX15EPbZ4NZ0ka8w2n9Io=; b=d011DhtReTGt
	w2gxL9yJeRDhkWEkrlKLVpqW25bU5hRMRekyd/ICSL8pBcHyMXf0VVZgM08yuvxW
	aW/HC75lzK4VXsALpFUrUuRfq+lpi14P92KRVpWbo9sKQkmW6qQcn9ei2ECG4CwJ
	pF1MsFc1AtZ0KHcb+VilMHG9Qz+am/4Jr8mFpfJW1YPMzI3ypqxSAb3TWMdDu75A
	ZGkalBdal60sjK6Nu43GwdZLL3wnylP9yx9uS5RjoeAzGIL2GtltgtjcU5m4cdHQ
	RBkLdvO2DcqI85BcPgEoPaN5j0gVFRLUwthk6EDPAwAsECVhjNkiVY8rxQNSZxNI
	sb5WFcBRsg==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 47u16du5tu-20
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Fri, 11 Jul 2025 11:31:57 -0700 (PDT)
Received: from twshared24438.15.frc2.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1748.24; Fri, 11 Jul 2025 18:31:55 +0000
Received: by devvm18334.vll0.facebook.com (Postfix, from userid 202792)
	id 275C53210B6C5; Fri, 11 Jul 2025 11:31:46 -0700 (PDT)
From: Ibrahim Jirdeh <ibrahimjirdeh@meta.com>
To: <ibrahimjirdeh@meta.com>
CC: <jack@suse.cz>, <amir73il@gmail.com>, <josef@toxicpanda.com>,
        <lesha@meta.com>, <linux-fsdevel@vger.kernel.org>, <sargun@meta.com>
Subject: [PATCH v4 3/3] fanotify: introduce event response identifier
Date: Fri, 11 Jul 2025 11:31:01 -0700
Message-ID: <20250711183101.4074140-4-ibrahimjirdeh@meta.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250711183101.4074140-1-ibrahimjirdeh@meta.com>
References: <20250711183101.4074140-1-ibrahimjirdeh@meta.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: rRoC5HafMygdEijBc6CGM0tx-eEgyNsr
X-Authority-Analysis: v=2.4 cv=OLMn3TaB c=1 sm=1 tr=0 ts=6871589d cx=c_pps a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=VabnemYjAAAA:8 a=ChkzHjXy8z1_0ozgDZ8A:9 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzExMDEzNyBTYWx0ZWRfX6GiiJe+5sqda 8vCKrmyoJyTNdeCbsKIbyy62Xpv6JYIr0uNBpaInGDVPDdiaVi8uf65/UHf1QJekn5kaoL+OVfm aNhV118c5uAvgsLo3W320+n4LU+5VxlIjZZ7aNkV9PeT+daZBftxT33WavR3CU16KhZD353ft4T
 1ai2MGwqF87bVTq5xuiCKknVTj6rCyzf0Hkqj1qR+wfZvnpmhJY9NQemxSOYRdIjBEgvyRvRMEK ppUBi33zLGh/WmNL+ul3Xm+hcH0uj5buMcUQBwCZJOhGkiVwbk3WbmCoE8zv03HKg5EDSHZ98cL rVyQfNvItO6fMGe/Z6ZY/94oEimq5oq4J4WaEdTNMEHKjeapGE6cn6Oa9uSjNM1et/j3FiV6wd9
 Rgu/YME0/cpLaiTxZ99kNP55aADmQLPYx8qeN6U1//4zHCS2FhfQgyNFX/yMTSnli4cDcxl+
X-Proofpoint-ORIG-GUID: rRoC5HafMygdEijBc6CGM0tx-eEgyNsr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-11_05,2025-07-09_01,2025-03-28_01

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

In terms of how response ids are allocated, we use an ida for allocation
and restrict the id range to below -255 to ensure there is no overlap wit=
h
existing fd-as-identifier usage.

Suggested-by: Amir Goldstein <amir73il@gmail.com>
Link: https://lore.kernel.org/linux-fsdevel/CAOQ4uxheeLXdTLLWrixnTJcxVP+B=
V4ViXijbvERHPenzgDMUTA@mail.gmail.com/
Signed-off-by: Ibrahim Jirdeh <ibrahimjirdeh@meta.com>
---
 fs/notify/fanotify/fanotify.c       |  4 ++
 fs/notify/fanotify/fanotify.h       | 11 ++++-
 fs/notify/fanotify/fanotify_user.c  | 63 ++++++++++++++++++++---------
 include/linux/fanotify.h            |  1 +
 include/linux/fsnotify_backend.h    |  1 +
 include/uapi/linux/fanotify.h       | 11 ++++-
 tools/include/uapi/linux/fanotify.h | 11 ++++-
 7 files changed, 78 insertions(+), 24 deletions(-)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.=
c
index 34acb7c16e8b..307532464226 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -1045,6 +1045,7 @@ static void fanotify_free_group_priv(struct fsnotif=
y_group *group)
 {
 	put_user_ns(group->user_ns);
 	kfree(group->fanotify_data.merge_hash);
+	ida_destroy(&group->response_ida);
 	if (group->fanotify_data.ucounts)
 		dec_ucount(group->fanotify_data.ucounts,
 			   UCOUNT_FANOTIFY_GROUPS);
@@ -1106,6 +1107,9 @@ static void fanotify_free_event(struct fsnotify_gro=
up *group,
=20
 	event =3D FANOTIFY_E(fsn_event);
 	put_pid(event->pid);
+	if (fanotify_is_perm_event(event->mask) &&
+	    FAN_GROUP_FLAG(group, FAN_REPORT_RESPONSE_ID))
+		ida_free(&group->response_ida, -FANOTIFY_PERM(event)->id);
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
index 19d3f2d914fe..99af23b257f9 100644
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
+		ret =3D ida_alloc_min(&group->response_ida, 256, GFP_KERNEL);
+		if (ret < 0)
+			return ret;
+		fd =3D -ret;
+	} else if (!FAN_GROUP_FLAG(group, FANOTIFY_UNPRIV) && path &&
+		   path->mnt && path->dentry) {
+		/*
+		 * For now, fid mode and no-permission-events class are required for
+		 * FANOTIFY_UNPRIV listener and fid mode does not report fd in
+		 * non-permission notification events. Keep this check anyway for
+		 * safety in case fid mode requirement is relaxed in the future to
+		 * allow unprivileged listener to get events with no fd and no fid.
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
@@ -1583,6 +1599,14 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flags=
, unsigned int, event_f_flags)
 	    (class | fid_mode) !=3D FAN_CLASS_PRE_CONTENT_FID)
 		return -EINVAL;
=20
+	/*
+	 * With group that reports fid info and allows pre-content events,
+	 * user may request to get a response id instead of event->fd.
+	 */
+	if ((flags & FAN_REPORT_RESPONSE_ID) &&
+	    (!fid_mode || class =3D=3D FAN_CLASS_NOTIF))
+		return -EINVAL;
+
 	/*
 	 * Child name is reported with parent fid so requires dir fid.
 	 * We can report both child fid and dir fid with or without name.
@@ -1660,6 +1684,7 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flags,=
 unsigned int, event_f_flags)
 		fd =3D -EINVAL;
 		goto out_destroy_group;
 	}
+	ida_init(&group->response_ida);
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
index 832d94d783d9..27299d5ca668 100644
--- a/include/linux/fsnotify_backend.h
+++ b/include/linux/fsnotify_backend.h
@@ -232,6 +232,7 @@ struct fsnotify_group {
 	unsigned int max_events;		/* maximum events allowed on the list */
 	enum fsnotify_group_prio priority;	/* priority for sending events */
 	bool shutdown;		/* group is being shut down, don't queue more events */
+	struct ida response_ida; /* used for response id allocation */
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


