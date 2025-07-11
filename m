Return-Path: <linux-fsdevel+bounces-54687-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48196B023AC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 20:32:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 939685C372A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 18:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36CD62F2C6C;
	Fri, 11 Jul 2025 18:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="Lam0I3IF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D99552EF2B8
	for <linux-fsdevel@vger.kernel.org>; Fri, 11 Jul 2025 18:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752258719; cv=none; b=RUjY6akdvFsZE2U+zq4qsLfbdAO0IVip2b/kEbne+Obvo73wMLuzWGK8NDStMxC1OZiDyFxde0aa7Ibt4SQLB7KQoFFVUdGJ50PHoA/1Dol5+6qKRA5n/zo68XRLUEnFqjWqvoxkfb3bKnT45YDKWnaSN8ZEIgiDzDK4IrtYh6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752258719; c=relaxed/simple;
	bh=RJr/jkwGVLg1rme7rTKbxELGz4mL5lvo08o6cwYH8tI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OjKtDzn6D5MmfywTfnZT3MualOUrjrnMeqzkmsQc8txZZOAzXBikiaceKfhDtv4+x+SIS4dkTHakTZm1IV9BO4fD903WumtiElPzW6Y2iSL2FZ6RrwSEmp2V+J8yOxQy2TTkQhIeebv5MO4lrhBA9JwdFUJMtgGpoIMverB0Kg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=Lam0I3IF; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56BHWDlT001441
	for <linux-fsdevel@vger.kernel.org>; Fri, 11 Jul 2025 11:31:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=yqW7Vfv5tUBKC6LWeP4tOXHbNFzfWurlUFdK1JaBB9U=; b=Lam0I3IF2b9A
	OblwIt5eFnQC4M+/e8zskYQqwGFMMRo9RD2s18XHPkGZhUxcSzqhbkInKAIxFXfP
	JuQT3lOX8w1iHOqxngjvowJ7mxIGN8e1XlpRQCdyRIhxMyr+L49vRU2yZ1Hj6BFd
	EAMSDBKy4ggOGHkw+u9PcN98W5MomlRceDkiPDhHzMKn7QfvbNRRzmqbDpR2swHt
	C14fbjULfGHcZUovOL6xWzV45o+cT7cJLaPBhA3EqUeAMEQUvRC3dHZDy05lkNJ2
	Z3xkUQLNLFU3mehNN00QYmvxCqTus3/zWurCPlEIriRTccdCwdHIXmO4p+6PSc+B
	51er5zesIw==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 47u16du5tu-19
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Fri, 11 Jul 2025 11:31:57 -0700 (PDT)
Received: from twshared38339.29.prn2.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1748.24; Fri, 11 Jul 2025 18:31:55 +0000
Received: by devvm18334.vll0.facebook.com (Postfix, from userid 202792)
	id 80C3B3210B6C0; Fri, 11 Jul 2025 11:31:45 -0700 (PDT)
From: Ibrahim Jirdeh <ibrahimjirdeh@meta.com>
To: <ibrahimjirdeh@meta.com>
CC: <jack@suse.cz>, <amir73il@gmail.com>, <josef@toxicpanda.com>,
        <lesha@meta.com>, <linux-fsdevel@vger.kernel.org>, <sargun@meta.com>
Subject: [PATCH v4 2/3] fanotify: allow pre-content events with fid info
Date: Fri, 11 Jul 2025 11:31:00 -0700
Message-ID: <20250711183101.4074140-3-ibrahimjirdeh@meta.com>
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
X-Proofpoint-GUID: gYONFXxFzAhRBVuKd3xyraM561iugj7D
X-Authority-Analysis: v=2.4 cv=OLMn3TaB c=1 sm=1 tr=0 ts=6871589d cx=c_pps a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17 a=Wb1JkmetP80A:10 a=pGLkceISAAAA:8 a=wZzuu5Q-1kWWKGx4qfkA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzExMDEzNyBTYWx0ZWRfX0yEOsuMhJTYn K9g5pdcpqxi3jSmOHcko03fV+hLNVtvy5PM1JqsRlrvZxQ6Fyyoo7AEkrMRefyMRYtIgQsL5L8p wnd8N6TthJjNZoBkc3f1DRShAnDRBj9WxRQt3VAIcpZTxo8jyj34eGV3fQbWUHBsDCCJpWe6JmV
 OBAY4x0dgrNBGve0AICb/lXbsQQDwoOcBp518SqPYYp6Ua4eGMgAzTE3c1NPY8NE7WdMnwkxX9d Ua4mUUZ4iEM0yeZ0noJol/V8H1wt/IY4eFOS1XPaeZr75RfG/wahGq5t3D4kJxzhXEhgu0Hnj9w dq7GA7fT3FqyUB41qeAgntjIqr6v3V3obvyE64YpbFe72KPZmJ49i84UatB7gCOgZpxzHTv9Y3x
 XLsHJ1WMa+0xEpiQe5S2X/USqh2YAyAblc79EAZIZt8NHajY9zxtInv4n6OqPT81dhqzfr9D
X-Proofpoint-ORIG-GUID: gYONFXxFzAhRBVuKd3xyraM561iugj7D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-11_05,2025-07-09_01,2025-03-28_01

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


