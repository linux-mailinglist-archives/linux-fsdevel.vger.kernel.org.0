Return-Path: <linux-fsdevel+bounces-56920-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BDCF3B1CEFA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Aug 2025 00:06:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8D1A175E36
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Aug 2025 22:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01910233D85;
	Wed,  6 Aug 2025 22:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="EKgjcQKR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB2A01A5B8B
	for <linux-fsdevel@vger.kernel.org>; Wed,  6 Aug 2025 22:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754517983; cv=none; b=eN/GoGIw6oj6ljVnicmlc7/i3DAUcLNeJe5iAiPxa+zqhQky039xUicH0cYMBI8hW328NfgefCi7ni93JtbxZ29s5kAcrLIRKbKcZXfqhELq2EtHCa+/Xa52bo/0Dnoi2Mupmr3CvkKuYDfSEnFRhCP1j0vXMB6woD2KY6mQuMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754517983; c=relaxed/simple;
	bh=yCrwNfvKxy3gGVnNnSTKIPvAJjI+r8wm6H5SY2hikLY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JdQT3AXcfgsbdfoF2jFyFYgkMKSmVHoP+JTsZ3QL4PEgo6FaDuDBd9WCMQ6P11xKo43UrJYmNbqLIFfHiGjOyeUdJnT12PlW8kBn14iNchyjcM59axcNwgRaH/ScfAXoAX+q8uLTvCU4rK4y2pBztY9F+WL4q65+Rvu6OyuQJVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=EKgjcQKR; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 576LJMi7024893
	for <linux-fsdevel@vger.kernel.org>; Wed, 6 Aug 2025 15:06:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=HiqwOoKmZGCKWJCsaUiH0SeMIVVG3bWTVGKMeJ2wlwE=; b=EKgjcQKRA2QY
	4OZ90YLPyUWuoMlJFMveW89O7eIf1gh/dpzBBgMQ90sa/3RgmNSOwE1JiUH4rUKy
	Iy0ZuSxdoxiymj7nIfMwJLP4PfS/brBasLTIHXd2zIsGEVwyy4+Exh9td7M9Py/e
	UwLU5YHQPllu1mop+1O5v+kiZP+HYwhF2FNtPHe9WwHY3ZMye0bNrA2Wry8REg9i
	W6j7+6v4L1o960xBP7LgoynEqRQQm9hs6Rl5W2nq5eXbZ5QfiF//VS9Gw2aN9M2D
	KJEZGRnV24lpjv8dVa1oWtDGimv5LgTG+76CO2KNmaYeN7huZ5fxbcuL+BxIBE4g
	/4yhlCCieQ==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 48bpwf3swr-12
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Wed, 06 Aug 2025 15:06:20 -0700 (PDT)
Received: from twshared7571.34.frc3.facebook.com (2620:10d:c0a8:1c::11) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.17; Wed, 6 Aug 2025 22:06:01 +0000
Received: by devvm18334.vll0.facebook.com (Postfix, from userid 202792)
	id 729E2353A7623; Wed,  6 Aug 2025 15:05:57 -0700 (PDT)
From: Ibrahim Jirdeh <ibrahimjirdeh@meta.com>
To: <ibrahimjirdeh@meta.com>
CC: <jack@suse.cz>, <amir73il@gmail.com>, <josef@toxicpanda.com>,
        <lesha@meta.com>, <linux-fsdevel@vger.kernel.org>, <sargun@meta.com>
Subject: [PATCH 1/2] fanotify: create helper for clearing pending events
Date: Wed, 6 Aug 2025 15:05:15 -0700
Message-ID: <20250806220516.953114-2-ibrahimjirdeh@meta.com>
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
X-Authority-Analysis: v=2.4 cv=BsqdwZX5 c=1 sm=1 tr=0 ts=6893d1dc cx=c_pps a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=VabnemYjAAAA:8 a=nBXDJwaNQ4YLTjHGAyEA:9 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-GUID: 0V45YPZ5WOFNnj0Z_ldV2BYn0wsB_g-2
X-Proofpoint-ORIG-GUID: 0V45YPZ5WOFNnj0Z_ldV2BYn0wsB_g-2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA2MDE0NyBTYWx0ZWRfX7NDaPbQ8zabl /EBOmTiVWPjYVEgjM1noQ05soZqUOBfSK4xnXqBKbGS0HlpgJ5F8w6xdOnJ0a513WFAwjPqc0Zf Tl8+bAyDSZQIzgpPzr3waMO+S2HIgHiBcUM0JzxzJoUw9S5cpWzeLfu424bDHSUjMYr+jgSE4JF
 A8o4+fhmp22o/isuYVIw1CgtdB4ozmtg3GkMfddtssWhA2LaWC0fBKRGL1ztG9NuYGbQRPvAMJ2 +xE0pmI4GW8RWjOvbHAiO0t5Rh2wz0hSWN1X6Rgf01h+gC9sj+fb1PYSMeuLoO2yw5wad+eTXf8 zRgRsRtwD5frWT7nmDQqHsPk7/4S/0S21f9RmgAR5DLumXvBj/bYz1i1RJZ8uyW8tsvo8Z3Sucl
 1t/ZduwNEgLxuETF62Pa+qa6xMnNn91Q99PeoMnAaOxt4iO+ZeUKpRygrcZWkf6e+ruslsC4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-06_05,2025-08-06_01,2025-03-28_01

This adds logic in order to support restarting pending permission
events. In terms of implementation, we reinsert events into
notification queue so they can be reprocessed on subsequent read
ops (an alternative is restarting fsnotify call [1]).
Restart will be triggered upon queue fd release.

[1] https://lore.kernel.org/linux-fsdevel/2ogjwnem7o3jwukzoq2ywnxha5ljiqn=
jnr4o4b5xvdvwpbyeac@v4i7jygvk7fj/2-0001-fanotify-Add-support-for-resendin=
g-unanswered-permis.patch

Suggested-by: Jan Kara <jack@suse.cz>
Link: https://lore.kernel.org/linux-fsdevel/sx5g7pmkchjqucfbzi77xh7wx4wua=
5nteqi5bsa2hfqgxua2a2@v7x6ja3gsirn/
Signed-off-by: Ibrahim Jirdeh <ibrahimjirdeh@meta.com>
---
 fs/notify/fanotify/fanotify.c      |  4 +--
 fs/notify/fanotify/fanotify.h      |  6 ++++
 fs/notify/fanotify/fanotify_user.c | 57 ++++++++++++++++++++++++------
 3 files changed, 55 insertions(+), 12 deletions(-)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.=
c
index bfe884d624e7..6f5f43a3e6bd 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -179,7 +179,7 @@ static bool fanotify_should_merge(struct fanotify_eve=
nt *old,
 #define FANOTIFY_MAX_MERGE_EVENTS 128
=20
 /* and the list better be locked by something too! */
-static int fanotify_merge(struct fsnotify_group *group,
+int fanotify_merge(struct fsnotify_group *group,
 			  struct fsnotify_event *event)
 {
 	struct fanotify_event *old, *new =3D FANOTIFY_E(event);
@@ -904,7 +904,7 @@ static __kernel_fsid_t fanotify_get_fsid(struct fsnot=
ify_iter_info *iter_info)
 /*
  * Add an event to hash table for faster merge.
  */
-static void fanotify_insert_event(struct fsnotify_group *group,
+void fanotify_insert_event(struct fsnotify_group *group,
 				  struct fsnotify_event *fsn_event)
 {
 	struct fanotify_event *event =3D FANOTIFY_E(fsn_event);
diff --git a/fs/notify/fanotify/fanotify.h b/fs/notify/fanotify/fanotify.=
h
index b78308975082..c0dffbc3370d 100644
--- a/fs/notify/fanotify/fanotify.h
+++ b/fs/notify/fanotify/fanotify.h
@@ -550,3 +550,9 @@ static inline u32 fanotify_get_response_errno(int res=
)
 {
 	return (res >> FAN_ERRNO_SHIFT) & FAN_ERRNO_MASK;
 }
+
+extern void fanotify_insert_event(struct fsnotify_group *group,
+	struct fsnotify_event *fsn_event);
+
+extern int fanotify_merge(struct fsnotify_group *group,
+	struct fsnotify_event *event);
diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fano=
tify_user.c
index b192ee068a7a..01d273d35936 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -1000,6 +1000,51 @@ static ssize_t fanotify_write(struct file *file, c=
onst char __user *buf, size_t
 	return count;
 }
=20
+static void clear_queue(struct file *file, bool restart_events)
+{
+	struct fsnotify_group *group =3D file->private_data;
+	struct fsnotify_event *fsn_event;
+	int insert_ret;
+
+	/*
+	 * Clear all pending permission events from the access_list. If
+	 * restart is requested, move them back into the notification queue
+	 * for reprocessing, otherwise simulate a reply from userspace.
+	 */
+	spin_lock(&group->notification_lock);
+	while (!list_empty(&group->fanotify_data.access_list)) {
+		struct fanotify_perm_event *event;
+
+		event =3D list_first_entry(&group->fanotify_data.access_list,
+					 struct fanotify_perm_event,
+					 fae.fse.list);
+		list_del_init(&event->fae.fse.list);
+
+		if (restart_events) {
+			// requeue the event
+			spin_unlock(&group->notification_lock);
+			fsn_event =3D &event->fae.fse;
+
+			insert_ret =3D fsnotify_insert_event(
+				group, fsn_event, fanotify_merge,
+				fanotify_insert_event);
+			if (insert_ret) {
+				/*
+				 * insertion for permission events can fail if group itself
+				 * is being shutdown. In this case, simply reply ALLOW for
+				 * the event.
+				 */
+				spin_lock(&group->notification_lock);
+				finish_permission_event(group, event, FAN_ALLOW, NULL);
+			}
+		} else {
+			finish_permission_event(group, event, FAN_ALLOW, NULL);
+		}
+		spin_lock(&group->notification_lock);
+	}
+	spin_unlock(&group->notification_lock);
+}
+
 static int fanotify_release(struct inode *ignored, struct file *file)
 {
 	struct fsnotify_group *group =3D file->private_data;
@@ -1016,22 +1061,14 @@ static int fanotify_release(struct inode *ignored=
, struct file *file)
 	 * Process all permission events on access_list and notification queue
 	 * and simulate reply from userspace.
 	 */
-	spin_lock(&group->notification_lock);
-	while (!list_empty(&group->fanotify_data.access_list)) {
-		struct fanotify_perm_event *event;
-
-		event =3D list_first_entry(&group->fanotify_data.access_list,
-				struct fanotify_perm_event, fae.fse.list);
-		list_del_init(&event->fae.fse.list);
-		finish_permission_event(group, event, FAN_ALLOW, NULL);
-		spin_lock(&group->notification_lock);
-	}
+	clear_queue(file, false);
=20
 	/*
 	 * Destroy all non-permission events. For permission events just
 	 * dequeue them and set the response. They will be freed once the
 	 * response is consumed and fanotify_get_response() returns.
 	 */
+	spin_lock(&group->notification_lock);
 	while ((fsn_event =3D fsnotify_remove_first_event(group))) {
 		struct fanotify_event *event =3D FANOTIFY_E(fsn_event);
=20
--=20
2.47.3


