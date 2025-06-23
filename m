Return-Path: <linux-fsdevel+bounces-52640-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EECBAE4D94
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 21:26:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A18DA17D7B7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 19:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BA08288511;
	Mon, 23 Jun 2025 19:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="SKyZ5f0O"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 646461E1DFE
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Jun 2025 19:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750706766; cv=none; b=B5R25so6UenElCK57J5ivmN1/wZMSrtX/VnhgL4ovXBVd7Hc5ou+Cd9feJjfz0jjH88+XNo0ypgmS/+pDVk1G/hSx5GLnS5Rvm9bKwqSODoeNR5+G1r45lb+Fz1QA6RBUCc+yzNJfSVxzbJq0hqoGtoYl7RcXUJtLraFytct0kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750706766; c=relaxed/simple;
	bh=NGxSX2oVjnsFdeWy6TaZyC75n5zsevN88ZfvbRTFUsk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AhjRLM5e5NR6H40axK8f49v3qQRBix+1jDEduffZMjyYWuYFrJVI5jE/27DFNZoG2TiwJgRThL5TY4PGyOe7qred3ld1TiP0l2AkTE5VuOT2DMx55ogQhDXt46j+EfE1RM9G1wsqpdrGtPdywx71Yecdz/uDcYwg2yewLgxGs6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=SKyZ5f0O; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55NIgHw8018422
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Jun 2025 12:26:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2021-q4; bh=cOV+BjWMhrEAIn0wEC
	WmA7JLVbswTFWJItOZuQitLCQ=; b=SKyZ5f0OJasZh3AQv/G7iiJkbwWx2hOsWt
	/Sw0DMQQvnxYu3vnOWQR2+qG4IuB1t1B3MtQhYH8iSt9ZMt7fZpGyg00Ob8I5jLR
	UKY6D6oOJ4j5lQ0wTqae5f5ytcZgDIgrWMeCZvATPphTQixeUjwVRKP2LxTL8oVG
	Uu9DqI0qTlUj8Sf5gxT0Q0zS17kcpcmIzx0hfDRBH7U4An9+FSUn2w8oKZIU2QLP
	AO9VIUR/2zBckNs62+D4f9M4Xu5cjXwhqaMgSVnUhf+OUnAlN1MhKavDOrP4yiz8
	vdnGl5pF+XVXVOtX4Ko7T7zM2FeatuchCXkm5J3j4jeYtl1GLAcw==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 47dtk9dgwe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Jun 2025 12:26:02 -0700 (PDT)
Received: from twshared41381.33.frc3.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1748.24; Mon, 23 Jun 2025 19:26:01 +0000
Received: by devvm18334.vll0.facebook.com (Postfix, from userid 202792)
	id 9F01B3042D66D; Mon, 23 Jun 2025 12:25:53 -0700 (PDT)
From: Ibrahim Jirdeh <ibrahimjirdeh@meta.com>
To: <ibrahimjirdeh@meta.com>
CC: <jack@suse.cz>, <amir73il@gmail.com>, <josef@toxicpanda.com>,
        <lesha@meta.com>, <linux-fsdevel@vger.kernel.org>, <sargun@meta.com>
Subject: [PATCH] fanotify: support custom default close response
Date: Mon, 23 Jun 2025 12:25:03 -0700
Message-ID: <20250623192503.2673076-1-ibrahimjirdeh@meta.com>
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
X-Proofpoint-ORIG-GUID: 9jPL0gexhDuQ2qjHg_ObJfZyubCYaCaE
X-Proofpoint-GUID: 9jPL0gexhDuQ2qjHg_ObJfZyubCYaCaE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIzMDEyNSBTYWx0ZWRfXy1oroPdAocS+ N5JqEmLoNKhVYS6jTvyTgWjjnaG/aCAlCz02uY6d7k3CHqe45JIVilO4BmJJOf4Sn0V3+Bub+Mj CjDBex/sdNrhGS+Sf/RO3Fw8wrvvy2rcE+Fp2V+nZOrcyyZxUfdY8oTH00AcoxIw5dJl7yyD2wB
 Ur5txz0jEIE0GjwcvI4nSoXScesALzFelgGV5MieX6AC72h6W0eKfTVyVgGGPh2oEUgFKWVUdim kuROo15yT6FZqMMFNVij5+iPxSB6FhOMgIvI4iSmXerLvynjOM3U0X1+IGWzYbQ3maiEHU+2SPx ZQTjstwC+OYDPnR7zXRK2yNri7S4OIsdWnnp3WTGSoJmEUcP+k/Fm6YHC8ukACwIR8ZoYSHvr9p
 6pig2YUXdvNjKCUzbQe3QUv0DIBEEQGoK13eeEIBcpdmaWYx5zc0eCvvo61S/iNUZ7jRcijl
X-Authority-Analysis: v=2.4 cv=SZn3duRu c=1 sm=1 tr=0 ts=6859aa4a cx=c_pps a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17 a=6IFa9wvqVegA:10 a=VwQbUJbxAAAA:8 a=VabnemYjAAAA:8 a=YXAqVDN9DIMgxYJhoIMA:9 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-23_06,2025-06-23_07,2025-03-28_01

Currently the default response for pending events is FAN_ALLOW.
This makes default close response configurable. The main goal
of these changes would be to provide better handling for pending
events for lazy file loading use cases which may back fanotify
events by a long-lived daemon. For earlier discussion see:
https://lore.kernel.org/linux-fsdevel/6za2mngeqslmqjg3icoubz37hbbxi6bi44c=
anfsg2aajgkialt@c3ujlrjzkppr/
This implements the first approach outlined there of providing
configuration for response on group close. This is supported by
writing a response with
.fd =3D FAN_NOFD
.response =3D FAN_DENY | FAN_DEFAULT
which modifies the group property default_response

Signed-off-by: Ibrahim Jirdeh <ibrahimjirdeh@meta.com>
---
 fs/notify/fanotify/fanotify_user.c  | 14 ++++++++++++--
 include/linux/fanotify.h            |  2 +-
 include/linux/fsnotify_backend.h    |  1 +
 include/uapi/linux/fanotify.h       |  1 +
 tools/include/uapi/linux/fanotify.h |  1 +
 5 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fano=
tify_user.c
index b192ee068a7a..02669abff4a5 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -378,6 +378,13 @@ static int process_access_response(struct fsnotify_g=
roup *group,
 		return -EINVAL;
 	}
=20
+	if (response & FAN_DEFAULT) {
+		if (fd !=3D FAN_NOFD)
+			return -EINVAL;
+		group->default_response =3D response & FANOTIFY_RESPONSE_ACCESS;
+		return 0;
+	}
+
 	if ((response & FAN_AUDIT) && !FAN_GROUP_FLAG(group, FAN_ENABLE_AUDIT))
 		return -EINVAL;
=20
@@ -1023,7 +1030,8 @@ static int fanotify_release(struct inode *ignored, =
struct file *file)
 		event =3D list_first_entry(&group->fanotify_data.access_list,
 				struct fanotify_perm_event, fae.fse.list);
 		list_del_init(&event->fae.fse.list);
-		finish_permission_event(group, event, FAN_ALLOW, NULL);
+		finish_permission_event(group, event,
+				group->default_response, NULL);
 		spin_lock(&group->notification_lock);
 	}
=20
@@ -1040,7 +1048,7 @@ static int fanotify_release(struct inode *ignored, =
struct file *file)
 			fsnotify_destroy_event(group, fsn_event);
 		} else {
 			finish_permission_event(group, FANOTIFY_PERM(event),
-						FAN_ALLOW, NULL);
+						group->default_response, NULL);
 		}
 		spin_lock(&group->notification_lock);
 	}
@@ -1640,6 +1648,8 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flags,=
 unsigned int, event_f_flags)
 		goto out_destroy_group;
 	}
=20
+	group->default_response =3D FAN_ALLOW;
+
 	BUILD_BUG_ON(!(FANOTIFY_ADMIN_INIT_FLAGS & FAN_UNLIMITED_QUEUE));
 	if (flags & FAN_UNLIMITED_QUEUE) {
 		group->max_events =3D UINT_MAX;
diff --git a/include/linux/fanotify.h b/include/linux/fanotify.h
index 879cff5eccd4..182fc574b848 100644
--- a/include/linux/fanotify.h
+++ b/include/linux/fanotify.h
@@ -134,7 +134,7 @@
=20
 /* These masks check for invalid bits in permission responses. */
 #define FANOTIFY_RESPONSE_ACCESS (FAN_ALLOW | FAN_DENY)
-#define FANOTIFY_RESPONSE_FLAGS (FAN_AUDIT | FAN_INFO)
+#define FANOTIFY_RESPONSE_FLAGS (FAN_AUDIT | FAN_INFO | FAN_DEFAULT)
 #define FANOTIFY_RESPONSE_VALID_MASK \
 	(FANOTIFY_RESPONSE_ACCESS | FANOTIFY_RESPONSE_FLAGS | \
 	 (FAN_ERRNO_MASK << FAN_ERRNO_SHIFT))
diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_ba=
ckend.h
index d4034ddaf392..9683396acda6 100644
--- a/include/linux/fsnotify_backend.h
+++ b/include/linux/fsnotify_backend.h
@@ -231,6 +231,7 @@ struct fsnotify_group {
 	unsigned int max_events;		/* maximum events allowed on the list */
 	enum fsnotify_group_prio priority;	/* priority for sending events */
 	bool shutdown;		/* group is being shut down, don't queue more events */
+	unsigned int default_response; /* default response sent on group close =
*/
=20
 #define FSNOTIFY_GROUP_USER	0x01 /* user allocated group */
 #define FSNOTIFY_GROUP_DUPS	0x02 /* allow multiple marks per object */
diff --git a/include/uapi/linux/fanotify.h b/include/uapi/linux/fanotify.=
h
index e710967c7c26..7badde273a66 100644
--- a/include/uapi/linux/fanotify.h
+++ b/include/uapi/linux/fanotify.h
@@ -254,6 +254,7 @@ struct fanotify_response_info_audit_rule {
=20
 #define FAN_AUDIT	0x10	/* Bitmask to create audit record for result */
 #define FAN_INFO	0x20	/* Bitmask to indicate additional information */
+#define FAN_DEFAULT	0x30	/* Bitmask to set default response on close */
=20
 /* No fd set in event */
 #define FAN_NOFD	-1
diff --git a/tools/include/uapi/linux/fanotify.h b/tools/include/uapi/lin=
ux/fanotify.h
index e710967c7c26..7badde273a66 100644
--- a/tools/include/uapi/linux/fanotify.h
+++ b/tools/include/uapi/linux/fanotify.h
@@ -254,6 +254,7 @@ struct fanotify_response_info_audit_rule {
=20
 #define FAN_AUDIT	0x10	/* Bitmask to create audit record for result */
 #define FAN_INFO	0x20	/* Bitmask to indicate additional information */
+#define FAN_DEFAULT	0x30	/* Bitmask to set default response on close */
=20
 /* No fd set in event */
 #define FAN_NOFD	-1
--=20
2.47.1


