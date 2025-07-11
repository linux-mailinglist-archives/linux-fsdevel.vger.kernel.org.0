Return-Path: <linux-fsdevel+bounces-54582-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 68D3FB0114C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 04:37:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB6715C0130
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 02:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D728B70814;
	Fri, 11 Jul 2025 02:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="MFdQ7dwa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B8ED18DF6E
	for <linux-fsdevel@vger.kernel.org>; Fri, 11 Jul 2025 02:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752201413; cv=none; b=C6d7bvWaILypkIkLhLFc+0jVW71YYAkHyuHL3Gmmqx5qO4EJJpqjL3pfgbI7PNTGHn97UYGSozPBOX8L/9nvLiRffBrmrSObxrgk79PfstwDfh6sKY5EAmlvzvjaU//5h/H4mbWttRNLBXs4dFfBIUx+FY/S14BgSA6Y8eLGUk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752201413; c=relaxed/simple;
	bh=RJr/jkwGVLg1rme7rTKbxELGz4mL5lvo08o6cwYH8tI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d2rdXU8nlQ0h83JLDxUOY+nFJp0FMIDs3cPWj76Wril1mpCZkK+44C/nZWUfAIqB9bQNBqFcxQvtiEfm1W1m83YsQBH51XnxjLml7wAq/gQJO2W5mAJaUDoj9bFAN/v2AK2o2tSMlIQm9Ss5oSpNBWgmAtflowTNoD00n2a3930=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=MFdQ7dwa; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56ANNkpK027945
	for <linux-fsdevel@vger.kernel.org>; Thu, 10 Jul 2025 19:36:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=yqW7Vfv5tUBKC6LWeP4tOXHbNFzfWurlUFdK1JaBB9U=; b=MFdQ7dwagHNw
	Mhrsrdt0oggTOTVi6JdXYdGS/YZsJNPYCmmya3CG12r95+6GgrQgx2XWBhjKuhvu
	xrYqxpXGO//6KYVATLxo+Fy+cje+OrUMmusmHc4NJMS92kl8njjhoutbf2c0qSnd
	oNShDmYvfLI3DzwH0h8FURflMG87V+TxIWN5VACRSWJk7tCu2kJdrAXcUXnXUDDQ
	l+uuFGw8m5CWatTTSr2jS1Ir4zNL6MZx8cBMTXnLeV5NXEGDBzkvIUdWwOm6Uamt
	qEJSOpmoaF4aLP9SC3eSBMF+5OezHNT4upYP40X7kaTTIrviMl2owgvC6u0OpcTZ
	wHYgNT99kg==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 47tbaqey4e-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Thu, 10 Jul 2025 19:36:50 -0700 (PDT)
Received: from twshared7571.34.frc3.facebook.com (2620:10d:c0a8:1b::8e35) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1748.24; Fri, 11 Jul 2025 02:36:47 +0000
Received: by devvm18334.vll0.facebook.com (Postfix, from userid 202792)
	id D525D3200EF52; Thu, 10 Jul 2025 19:36:42 -0700 (PDT)
From: Ibrahim Jirdeh <ibrahimjirdeh@meta.com>
To: <ibrahimjirdeh@meta.com>
CC: <jack@suse.cz>, <amir73il@gmail.com>, <josef@toxicpanda.com>,
        <lesha@meta.com>, <linux-fsdevel@vger.kernel.org>, <sargun@meta.com>
Subject: [PATCH v3 2/3] fanotify: allow pre-content events with fid info
Date: Thu, 10 Jul 2025 19:36:03 -0700
Message-ID: <20250711023604.593885-3-ibrahimjirdeh@meta.com>
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
X-Authority-Analysis: v=2.4 cv=JqfxrN4C c=1 sm=1 tr=0 ts=687078c2 cx=c_pps a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17 a=Wb1JkmetP80A:10 a=pGLkceISAAAA:8 a=wZzuu5Q-1kWWKGx4qfkA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzExMDAxNyBTYWx0ZWRfXz05OU79IIqrR dBBUTfrFIY9tQPY+jvWWp6TB86aCcqv9fnGw1Zekr70W6MNskg/5la0We5i1Ew52u3g2diesEap 9hZTA3tmQ/B8XQ+GqLeQ4x6IX9iAaAvUir97OPdRT/xBzJw4XXeKUzSU82TygIBi0YSD0CD3PRO
 xwJ2+oxgSs0y+TgcCfjfETyQ910Jvfm6X68pJbAiDV14xf1ui2DxSw3sQfd48CeoeqpumtOdc9I WdFLPI+pykimZMD/obi3LkXNL0iifkXCFfpvcNNd3ST60A8MVaj90gaL3pI7PUTKDMrntSawrCQ UMS0YbRvIC3Tts9GlrGzlZM4DHMiKK/3ITp0+bTd/gT6jAeU3oYcjlqJXTKYOQq+a4b5eHatPrL
 tNH5igIHQ5sM+tzw4rKksLFLYpE0TkXfZV/thmiHokr9O2mEACF5QTsBIAvUiA8R1evgFlko
X-Proofpoint-ORIG-GUID: iMFe4jvw2X2H3McZESGSqAQPReIV8-rh
X-Proofpoint-GUID: iMFe4jvw2X2H3McZESGSqAQPReIV8-rh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-11_01,2025-07-09_01,2025-03-28_01

From: Amir Goldstein <amir73il@gmail.com>

Until now, the high priority classes (FAN_CLASS_*CONTENT), which are
required for permission and pre-content events, were not allowed to
report events with fid info.

This is partly because the event->fd is used as a key for the the
permission response and partly because we needed to chose between
allocating a permission event of fid event struct.

Allow reporting fid info with pre-content class with some restrictions:
1. Only pre-content events are allowed with such groups
2. No event flags are allowed (i.e. FAN_EVENT_ON_CHILD)

The flag FAN_EVENT_ON_CHILD is anyway ignored on sb/mount marks and
on an non-dir inode mark.

On a directory inode mark, FAN_PRE_ACCESS makes no sense without
FAN_EVENT_ON_CHILD, so in this case, this flag is implied.

Add a convenience macro FAN_CLASS_PRE_CONTENT_FID to initialize a
group for pre-content events which reports fid info and dedicate
a new higher priority for those groups.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/notify/fanotify/fanotify_user.c | 70 +++++++++++++++++++++++-------
 include/linux/fsnotify_backend.h   |  1 +
 include/uapi/linux/fanotify.h      |  3 ++
 3 files changed, 59 insertions(+), 15 deletions(-)

diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fano=
tify_user.c
index b192ee068a7a..19d3f2d914fe 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -353,7 +353,7 @@ static int process_access_response(struct fsnotify_gr=
oup *group,
 		break;
 	case FAN_DENY:
 		/* Custom errno is supported only for pre-content groups */
-		if (errno && group->priority !=3D FSNOTIFY_PRIO_PRE_CONTENT)
+		if (errno && group->priority < FSNOTIFY_PRIO_PRE_CONTENT)
 			return -EINVAL;
=20
 		/*
@@ -1383,6 +1383,16 @@ static int fanotify_group_init_error_pool(struct f=
snotify_group *group)
 					 sizeof(struct fanotify_error_event));
 }
=20
+/* Check for forbidden events/flags combinations */
+static bool fanotify_mask_is_valid(__u64 mask)
+{
+	/* Pre-content events do not support event flags */
+	if (mask & FANOTIFY_PRE_CONTENT_EVENTS && mask & FAN_ONDIR)
+		return false;
+
+	return true;
+}
+
 static int fanotify_may_update_existing_mark(struct fsnotify_mark *fsn_m=
ark,
 					     __u32 mask, unsigned int fan_flags)
 {
@@ -1411,9 +1421,9 @@ static int fanotify_may_update_existing_mark(struct=
 fsnotify_mark *fsn_mark,
 	    fsn_mark->flags & FSNOTIFY_MARK_FLAG_IGNORED_SURV_MODIFY)
 		return -EEXIST;
=20
-	/* For now pre-content events are not generated for directories */
+	/* Check for forbidden event combinations after update */
 	mask |=3D fsn_mark->mask;
-	if (mask & FANOTIFY_PRE_CONTENT_EVENTS && mask & FAN_ONDIR)
+	if (!fanotify_mask_is_valid(mask))
 		return -EEXIST;
=20
 	return 0;
@@ -1564,7 +1574,13 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flags=
, unsigned int, event_f_flags)
 		return -EINVAL;
 	}
=20
-	if (fid_mode && class !=3D FAN_CLASS_NOTIF)
+	/*
+	 * Async events support any fid report mode.
+	 * Permission events do not support any fid report mode.
+	 * Pre-content events support only FAN_REPORT_DFID_NAME_TARGET mode.
+	 */
+	if (fid_mode && class !=3D FAN_CLASS_NOTIF &&
+	    (class | fid_mode) !=3D FAN_CLASS_PRE_CONTENT_FID)
 		return -EINVAL;
=20
 	/*
@@ -1633,7 +1649,12 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flags=
, unsigned int, event_f_flags)
 		group->priority =3D FSNOTIFY_PRIO_CONTENT;
 		break;
 	case FAN_CLASS_PRE_CONTENT:
-		group->priority =3D FSNOTIFY_PRIO_PRE_CONTENT;
+		/*
+		 * FAN_CLASS_PRE_CONTENT_FID is exclusively for pre-content
+		 * events, so it gets a higher priority.
+		 */
+		group->priority =3D fid_mode ? FSNOTIFY_PRIO_PRE_CONTENT_FID :
+					     FSNOTIFY_PRIO_PRE_CONTENT;
 		break;
 	default:
 		fd =3D -EINVAL;
@@ -1750,6 +1771,9 @@ static int fanotify_events_supported(struct fsnotif=
y_group *group,
 				 (mask & FAN_RENAME) ||
 				 (flags & FAN_MARK_IGNORE);
=20
+	if (!fanotify_mask_is_valid(mask))
+		return -EINVAL;
+
 	/*
 	 * Filesystems need to opt-into pre-content evnets (a.k.a HSM)
 	 * and they are only supported on regular files and directories.
@@ -1911,13 +1935,27 @@ static int do_fanotify_mark(int fanotify_fd, unsi=
gned int flags, __u64 mask,
 	/*
 	 * Permission events are not allowed for FAN_CLASS_NOTIF.
 	 * Pre-content permission events are not allowed for FAN_CLASS_CONTENT.
+	 * Only pre-content events are allowed for FAN_CLASS_PRE_CONTENT_FID.
 	 */
-	if (mask & FANOTIFY_PERM_EVENTS &&
-	    group->priority =3D=3D FSNOTIFY_PRIO_NORMAL)
-		return -EINVAL;
-	else if (mask & FANOTIFY_PRE_CONTENT_EVENTS &&
-		 group->priority =3D=3D FSNOTIFY_PRIO_CONTENT)
+	fid_mode =3D FAN_GROUP_FLAG(group, FANOTIFY_FID_BITS);
+	switch (group->priority) {
+	case FSNOTIFY_PRIO_NORMAL:
+		if (mask & FANOTIFY_PERM_EVENTS)
+			return -EINVAL;
+		break;
+	case FSNOTIFY_PRIO_CONTENT:
+		if (mask & FANOTIFY_PRE_CONTENT_EVENTS)
+			return -EINVAL;
+		break;
+	case FSNOTIFY_PRIO_PRE_CONTENT:
+		break;
+	case FSNOTIFY_PRIO_PRE_CONTENT_FID:
+		if (mask & ~FANOTIFY_PRE_CONTENT_EVENTS)
+			return -EINVAL;
+		break;
+	default:
 		return -EINVAL;
+	}
=20
 	if (mask & FAN_FS_ERROR &&
 	    mark_type !=3D FAN_MARK_FILESYSTEM)
@@ -1938,7 +1976,6 @@ static int do_fanotify_mark(int fanotify_fd, unsign=
ed int flags, __u64 mask,
 	 * carry enough information (i.e. path) to be filtered by mount
 	 * point.
 	 */
-	fid_mode =3D FAN_GROUP_FLAG(group, FANOTIFY_FID_BITS);
 	if (mask & ~(FANOTIFY_FD_EVENTS|FANOTIFY_MOUNT_EVENTS|FANOTIFY_EVENT_FL=
AGS) &&
 	    (!fid_mode || mark_type =3D=3D FAN_MARK_MOUNT))
 		return -EINVAL;
@@ -1951,10 +1988,6 @@ static int do_fanotify_mark(int fanotify_fd, unsig=
ned int flags, __u64 mask,
 	if (mask & FAN_RENAME && !(fid_mode & FAN_REPORT_NAME))
 		return -EINVAL;
=20
-	/* Pre-content events are not currently generated for directories. */
-	if (mask & FANOTIFY_PRE_CONTENT_EVENTS && mask & FAN_ONDIR)
-		return -EINVAL;
-
 	if (mark_cmd =3D=3D FAN_MARK_FLUSH) {
 		fsnotify_clear_marks_by_group(group, obj_type);
 		return 0;
@@ -2041,6 +2074,13 @@ static int do_fanotify_mark(int fanotify_fd, unsig=
ned int flags, __u64 mask,
 		if ((fid_mode & FAN_REPORT_DIR_FID) &&
 		    (flags & FAN_MARK_ADD) && !ignore)
 			mask |=3D FAN_EVENT_ON_CHILD;
+	} else if (fid_mode && (mask & FANOTIFY_PRE_CONTENT_EVENTS)) {
+		/*
+		 * Pre-content events on directory inode mask implies that
+		 * we are watching access to children.
+		 */
+		mask |=3D FAN_EVENT_ON_CHILD;
+		umask =3D FAN_EVENT_ON_CHILD;
 	}
=20
 	/* create/update an inode mark */
diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_ba=
ckend.h
index d4034ddaf392..832d94d783d9 100644
--- a/include/linux/fsnotify_backend.h
+++ b/include/linux/fsnotify_backend.h
@@ -201,6 +201,7 @@ enum fsnotify_group_prio {
 	FSNOTIFY_PRIO_NORMAL =3D 0,	/* normal notifiers, no permissions */
 	FSNOTIFY_PRIO_CONTENT,		/* fanotify permission events */
 	FSNOTIFY_PRIO_PRE_CONTENT,	/* fanotify pre-content events */
+	FSNOTIFY_PRIO_PRE_CONTENT_FID,	/* fanotify pre-content events with fid =
*/
 	__FSNOTIFY_PRIO_NUM
 };
=20
diff --git a/include/uapi/linux/fanotify.h b/include/uapi/linux/fanotify.=
h
index e710967c7c26..28074ab3e794 100644
--- a/include/uapi/linux/fanotify.h
+++ b/include/uapi/linux/fanotify.h
@@ -73,6 +73,9 @@
 /* Convenience macro - FAN_REPORT_TARGET_FID requires all other FID flag=
s */
 #define FAN_REPORT_DFID_NAME_TARGET (FAN_REPORT_DFID_NAME | \
 				     FAN_REPORT_FID | FAN_REPORT_TARGET_FID)
+/* Convenience macro - FAN_CLASS_PRE_CONTENT requires all or no FID flag=
s */
+#define FAN_CLASS_PRE_CONTENT_FID   (FAN_CLASS_PRE_CONTENT | \
+				     FAN_REPORT_DFID_NAME_TARGET)
=20
 /* Deprecated - do not use this in programs and do not add new flags her=
e! */
 #define FAN_ALL_INIT_FLAGS	(FAN_CLOEXEC | FAN_NONBLOCK | \
--=20
2.47.1


