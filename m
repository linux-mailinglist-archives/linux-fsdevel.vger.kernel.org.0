Return-Path: <linux-fsdevel+bounces-54415-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D2B9AFF7E7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 06:21:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 408A11C443F1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 04:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EA0128152B;
	Thu, 10 Jul 2025 04:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="k/EPWKIc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 623982F3E
	for <linux-fsdevel@vger.kernel.org>; Thu, 10 Jul 2025 04:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752121269; cv=none; b=qiA1Gjpc9FEmE1IYORJ0S+No/M2jEgUdPS6cVyWaPOkP1+lzzw4iwOW9Z1pfWYHP54hXYLScb1Dx0VvxUoekPUaLtsVHvKWJaRgyqqz2C8VbSTNbDR/zLpCvGrXQRAqh0XUAqit1hSy6vKD87Wz2jz99CAIV5g1snHLFOYOWuIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752121269; c=relaxed/simple;
	bh=Q3n8RqMxzLFUxVoxhBx4CpKbNgJL3zWIaxg6TU0Nosk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qrn2QsG9u2ctme2GIF9mqeIRTnzf7DDQWI1KXHWbie1MPMWaz5RctcZ+ifcQsTaGa+Yd1cs2uDFavTuCiYBjSR8kw+oMFqa0l6XRED0FetFRZkavS6guaxs2hlEymJlfmSKC8ncqKTNBfdlXoRQED2QUQaS6YH3sgw0Nn2nQPr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=k/EPWKIc; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56A0oOjX030966
	for <linux-fsdevel@vger.kernel.org>; Wed, 9 Jul 2025 21:21:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=M7r6gErDpT73axi+dJbpPq/q2LNKs2bWseulhR/Auj0=; b=k/EPWKIcoslW
	mB2wioQrzpSs1HMrCsaEzf5lFU1kiOHYhmJEw1oJv2B4+c7Txj4So1kmn5PUMGtg
	KKGsL/BmqY6Z2DUenyVNAOZflK/Btm2GQT9MqGFg6f8bIc+nHPUOIV2D3hyq3K/m
	hxjWko4M6F+Z252P6nSw5yu0JXRLX7kQ7exyYUL62Hvs6MnpuqXLhaXfzoPbq3xS
	zUMyeFTBHaOtk/J1JyV40IqvDExOcRsHtTuaWD+pGMvpnboxdxSGv77pNnKXiGPm
	DSyW9Ph2wzRwxj1ZVhfXqnKxEjgCNJYC2xzGAI1HuoQr5e9Bucl38QJfihdGrhGx
	CH2rc+hMMA==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 47t14ksj5n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Wed, 09 Jul 2025 21:21:06 -0700 (PDT)
Received: from twshared26876.17.frc2.facebook.com (2620:10d:c0a8:1c::11) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1748.24; Thu, 10 Jul 2025 04:21:05 +0000
Received: by devvm18334.vll0.facebook.com (Postfix, from userid 202792)
	id B14F731E90F18; Wed,  9 Jul 2025 21:20:54 -0700 (PDT)
From: Ibrahim Jirdeh <ibrahimjirdeh@meta.com>
To: <ibrahimjirdeh@meta.com>
CC: <jack@suse.cz>, <amir73il@gmail.com>, <josef@toxicpanda.com>,
        <lesha@meta.com>, <linux-fsdevel@vger.kernel.org>, <sargun@meta.com>,
        ibrahimjirdeh <ibrahimjirdeh@fb.com>
Subject: [PATCH 3/3] [PATCH v2 3/3] fanotify: introduce event response identifier
Date: Wed, 9 Jul 2025 21:20:49 -0700
Message-ID: <20250710042049.3705747-4-ibrahimjirdeh@meta.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250710042049.3705747-1-ibrahimjirdeh@meta.com>
References: <20250710042049.3705747-1-ibrahimjirdeh@meta.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=VYn3PEp9 c=1 sm=1 tr=0 ts=686f3fb2 cx=c_pps a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=FOH2dFAWAAAA:8 a=VabnemYjAAAA:8 a=40JyL-diERjDRjb5LMMA:9
 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-ORIG-GUID: Id556Mmz91983A9IJFpaLQlgh_S-m6T3
X-Proofpoint-GUID: Id556Mmz91983A9IJFpaLQlgh_S-m6T3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEwMDAzNCBTYWx0ZWRfX0UmvZG9M/3m7 JUnOmdFkk4ckkWNAq3FNDjrD2GIIqQ2IFZ9AEhIMEdakJd8sOFVL9EDdjpxcoxufcRs/x1Mu7c1 RzAIIpRceWFDddb1o1gNOAOlRtdO8LWXD0SSeAoi5p+00QM0vodWZNLaaUp2zcni2bj0+TnTZmb
 887uIIyVIRS8VrTBDPykpW9AToi65QP2ko58uWbHYpBv3m9v7zTyLevpJF92LQepa3ZqGO7Qd7P PTkfMBfWLIwVM6SKq+1kV+naNFiLExgvAhztDG1/owa6dQdmlT+PTAl8ETIP0b5pXVb7sdA/W2j 1WDcH4p8FyG1iE/fSBmtzjsLCufVyGk6DkNkWbXjG/WzaLW05rVkMar06Ef6+mKdIWQev7OJ7m6
 hD8xRj6iUWDrwO7VcH8O2QmO9TCYH+1nXb083d9qsNJ4K4CHHr0CrixPwnvc1QPTREra7tJO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-09_05,2025-07-09_01,2025-03-28_01

From: ibrahimjirdeh <ibrahimjirdeh@fb.com>

Summary:
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
 fs/notify/fanotify/fanotify.c       |   3 +
 fs/notify/fanotify/fanotify.h       |   5 +-
 fs/notify/fanotify/fanotify_user.c  | 129 ++++++++++++++++++----------
 include/linux/fanotify.h            |   3 +-
 include/linux/fsnotify_backend.h    |   1 +
 include/uapi/linux/fanotify.h       |  11 ++-
 tools/include/uapi/linux/fanotify.h |  11 ++-
 7 files changed, 110 insertions(+), 53 deletions(-)

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
index f6d25fcf8692..8d62321237d6 100644
--- a/fs/notify/fanotify/fanotify.h
+++ b/fs/notify/fanotify/fanotify.h
@@ -444,7 +444,10 @@ struct fanotify_perm_event {
 	size_t count;
 	u32 response;			/* userspace answer to the event */
 	unsigned short state;		/* state of the event */
-	int fd;		/* fd we passed to userspace for this event */
+	union {
+		__s32 fd;			/* fd we passed to userspace for this event */
+		__s32 id;			/* FAN_REPORT_RESPONSE_ID */
+	};
 	union {
 		struct fanotify_response_info_header hdr;
 		struct fanotify_response_info_audit_rule audit_rule;
diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fano=
tify_user.c
index 19d3f2d914fe..b033f86e0db3 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -330,14 +330,16 @@ static int process_access_response(struct fsnotify_=
group *group,
 				   size_t info_len)
 {
 	struct fanotify_perm_event *event;
-	int fd =3D response_struct->fd;
+	int id =3D FAN_GROUP_FLAG(group, FAN_REPORT_RESPONSE_ID) ?
+			 response_struct->id :
+			 response_struct->fd;
 	u32 response =3D response_struct->response;
 	int errno =3D fanotify_get_response_errno(response);
 	int ret =3D info_len;
 	struct fanotify_response_info_audit_rule friar;
=20
-	pr_debug("%s: group=3D%p fd=3D%d response=3D%x errno=3D%d buf=3D%p size=
=3D%zu\n",
-		 __func__, group, fd, response, errno, info, info_len);
+	pr_debug("%s: group=3D%p id=3D%d response=3D%x errno=3D%d buf=3D%p size=
=3D%zu\n",
+		 __func__, group, id, response, errno, info, info_len);
 	/*
 	 * make sure the response is valid, if invalid we do nothing and either
 	 * userspace can send a valid response or we will clean it up after the
@@ -385,19 +387,24 @@ static int process_access_response(struct fsnotify_=
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
+	if (FAN_GROUP_FLAG(group, FAN_REPORT_RESPONSE_ID) && id >=3D -255)
+		return -EINVAL;
=20
-	if (fd < 0)
+	if (!FAN_GROUP_FLAG(group, FAN_REPORT_RESPONSE_ID) && id < 0)
 		return -EINVAL;
=20
 	spin_lock(&group->notification_lock);
 	list_for_each_entry(event, &group->fanotify_data.access_list,
 			    fae.fse.list) {
-		if (event->fd !=3D fd)
+		int other_id =3D FAN_GROUP_FLAG(group, FAN_REPORT_RESPONSE_ID) ?
+				       event->id :
+				       event->fd;
+		if (other_id !=3D id)
 			continue;
=20
 		list_del_init(&event->fae.fse.list);
@@ -765,48 +772,58 @@ static ssize_t copy_event_to_user(struct fsnotify_g=
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
-		fd =3D create_fd(group, path, &f);
+	if (FAN_GROUP_FLAG(group, FAN_REPORT_RESPONSE_ID)) {
+		ret =3D idr_alloc_cyclic(&group->response_idr, event, 256, INT_MAX,
+				       GFP_NOWAIT);
+		if (ret < 0)
+			return ret;
+		metadata.id =3D -ret;
+	} else {
 		/*
-		 * Opening an fd from dentry can fail for several reasons.
-		 * For example, when tasks are gone and we try to open their
-		 * /proc files or we try to open a WRONLY file like in sysfs
-		 * or when trying to open a file that was deleted on the
-		 * remote network server.
-		 *
-		 * For a group with FAN_REPORT_FD_ERROR, we will send the
-		 * event with the error instead of the open fd, otherwise
-		 * Userspace may not get the error at all.
-		 * In any case, userspace will not know which file failed to
-		 * open, so add a debug print for further investigation.
+		 * For now, fid mode is required for an unprivileged listener and
+		 * fid mode does not report fd in events.  Keep this check anyway
+		 * for safety in case fid mode requirement is relaxed in the future
+		 * to allow unprivileged listener to get events with no fd and no fid.
 		 */
-		if (fd < 0) {
-			pr_debug("fanotify: create_fd(%pd2) failed err=3D%d\n",
-				 path->dentry, fd);
-			if (!FAN_GROUP_FLAG(group, FAN_REPORT_FD_ERROR)) {
-				/*
-				 * Historically, we've handled EOPENSTALE in a
-				 * special way and silently dropped such
-				 * events. Now we have to keep it to maintain
-				 * backward compatibility...
-				 */
-				if (fd =3D=3D -EOPENSTALE)
-					fd =3D 0;
-				return fd;
+		if (!FAN_GROUP_FLAG(group, FANOTIFY_UNPRIV) && path &&
+		    path->mnt && path->dentry) {
+			fd =3D create_fd(group, path, &f);
+			/*
+			 * Opening an fd from dentry can fail for several reasons.
+			 * For example, when tasks are gone and we try to open their
+			 * /proc files or we try to open a WRONLY file like in sysfs
+			 * or when trying to open a file that was deleted on the
+			 * remote network server.
+			 *
+			 * For a group with FAN_REPORT_FD_ERROR, we will send the
+			 * event with the error instead of the open fd, otherwise
+			 * Userspace may not get the error at all.
+			 * In any case, userspace will not know which file failed to
+			 * open, so add a debug print for further investigation.
+			 */
+			if (fd < 0) {
+				pr_debug(
+					"fanotify: create_fd(%pd2) failed err=3D%d\n",
+					path->dentry, fd);
+				if (!FAN_GROUP_FLAG(group,
+						    FAN_REPORT_FD_ERROR)) {
+					/*
+					 * Historically, we've handled EOPENSTALE in a
+					 * special way and silently dropped such
+					 * events. Now we have to keep it to maintain
+					 * backward compatibility...
+					 */
+					if (fd =3D=3D -EOPENSTALE)
+						fd =3D 0;
+					return fd;
+				}
 			}
 		}
+		if (FAN_GROUP_FLAG(group, FAN_REPORT_FD_ERROR))
+			metadata.fd =3D fd;
+		else
+			metadata.fd =3D fd >=3D 0 ? fd : FAN_NOFD;
 	}
-	if (FAN_GROUP_FLAG(group, FAN_REPORT_FD_ERROR))
-		metadata.fd =3D fd;
-	else
-		metadata.fd =3D fd >=3D 0 ? fd : FAN_NOFD;
=20
 	if (pidfd_mode) {
 		/*
@@ -858,8 +875,12 @@ static ssize_t copy_event_to_user(struct fsnotify_gr=
oup *group,
 	if (pidfd_file)
 		fd_install(pidfd, pidfd_file);
=20
-	if (fanotify_is_perm_event(event->mask))
-		FANOTIFY_PERM(event)->fd =3D fd;
+	if (fanotify_is_perm_event(event->mask)) {
+		if (FAN_GROUP_FLAG(group, FAN_REPORT_RESPONSE_ID))
+			FANOTIFY_PERM(event)->id =3D metadata.id;
+		else
+			FANOTIFY_PERM(event)->fd =3D fd;
+	}
=20
 	return metadata.event_len;
=20
@@ -944,7 +965,11 @@ static ssize_t fanotify_read(struct file *file, char=
 __user *buf,
 		if (!fanotify_is_perm_event(event->mask)) {
 			fsnotify_destroy_event(group, &event->fse);
 		} else {
-			if (ret <=3D 0 || FANOTIFY_PERM(event)->fd < 0) {
+			if (ret <=3D 0 ||
+			    ((FAN_GROUP_FLAG(group, FAN_REPORT_RESPONSE_ID) &&
+			      FANOTIFY_PERM(event)->id >=3D -255) ||
+			     (!FAN_GROUP_FLAG(group, FAN_REPORT_RESPONSE_ID) &&
+			      FANOTIFY_PERM(event)->fd < 0))) {
 				spin_lock(&group->notification_lock);
 				finish_permission_event(group,
 					FANOTIFY_PERM(event), FAN_DENY, NULL);
@@ -1584,6 +1609,15 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flags=
, unsigned int, event_f_flags)
 		return -EINVAL;
=20
 	/*
+     * With group that reports fid info and allows only pre-content even=
ts,
+     * user may request to get a response id instead of event->fd.
+     * FAN_REPORT_FD_ERROR does not make sense in this case.
+     */
+	if ((flags & FAN_REPORT_RESPONSE_ID) &&
+	    (!fid_mode || class =3D=3D FAN_CLASS_NOTIF))
+		return -EINVAL;
+
+	/*
 	 * Child name is reported with parent fid so requires dir fid.
 	 * We can report both child fid and dir fid with or without name.
 	 */
@@ -1660,6 +1694,7 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flags,=
 unsigned int, event_f_flags)
 		fd =3D -EINVAL;
 		goto out_destroy_group;
 	}
+	idr_init(&group->response_idr);
=20
 	BUILD_BUG_ON(!(FANOTIFY_ADMIN_INIT_FLAGS & FAN_UNLIMITED_QUEUE));
 	if (flags & FAN_UNLIMITED_QUEUE) {
@@ -2145,7 +2180,7 @@ static int __init fanotify_user_setup(void)
 				     FANOTIFY_DEFAULT_MAX_USER_MARKS);
=20
 	BUILD_BUG_ON(FANOTIFY_INIT_FLAGS & FANOTIFY_INTERNAL_GROUP_FLAGS);
-	BUILD_BUG_ON(HWEIGHT32(FANOTIFY_INIT_FLAGS) !=3D 14);
+	BUILD_BUG_ON(HWEIGHT32(FANOTIFY_INIT_FLAGS) !=3D 15);
 	BUILD_BUG_ON(HWEIGHT32(FANOTIFY_MARK_FLAGS) !=3D 11);
=20
 	fanotify_mark_cache =3D KMEM_CACHE(fanotify_mark,
diff --git a/include/linux/fanotify.h b/include/linux/fanotify.h
index 879cff5eccd4..4463fcfd16bb 100644
--- a/include/linux/fanotify.h
+++ b/include/linux/fanotify.h
@@ -38,7 +38,8 @@
 					 FAN_REPORT_PIDFD | \
 					 FAN_REPORT_FD_ERROR | \
 					 FAN_UNLIMITED_QUEUE | \
-					 FAN_UNLIMITED_MARKS)
+					 FAN_UNLIMITED_MARKS | \
+					 FAN_REPORT_RESPONSE_ID)
=20
 /*
  * fanotify_init() flags that are allowed for user without CAP_SYS_ADMIN=
.
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
index 3201d8d6c51a..04bbbfb5f7f3 100644
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
@@ -143,7 +144,10 @@ struct fanotify_event_metadata {
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
@@ -227,7 +231,10 @@ struct fanotify_event_info_mnt {
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
index 3201d8d6c51a..04bbbfb5f7f3 100644
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
@@ -143,7 +144,10 @@ struct fanotify_event_metadata {
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
@@ -227,7 +231,10 @@ struct fanotify_event_info_mnt {
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


