Return-Path: <linux-fsdevel+bounces-54414-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56F90AFF7E6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 06:21:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3744D480F14
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 04:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E621927F19F;
	Thu, 10 Jul 2025 04:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="btFz6HEr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6574B19E7D1
	for <linux-fsdevel@vger.kernel.org>; Thu, 10 Jul 2025 04:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752121269; cv=none; b=ZxsVWEfUrGblltrAfnbT3rA3nBaKQTk+Ccb6zWYbR+mx12Ki21tC5DjLt786EAgPcMluJHYrtynQlf9PhLW/kBv06ECNEXl//IsvOfOi+6b0YB+4gPUuFGZHseNArdORAis+7XNiRTyDFzhTOorTmMri/28gzRrzstmW1bhp/Uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752121269; c=relaxed/simple;
	bh=DeY0DFEUYqiccw8R2sDFAMbNk1DKH36geh8NTQ8bKYY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q6PntOAqFP7pTABkEbZFBHULzEGU/YwM/mtOg5wLiNCV5BjJHv6oZT6luIxRMI2h2PCpb/020FSDED4nDmW0SfTO2Goe2KDj4pydwXbllG2lT07xH4rIPqunBg2myVA3AZ0EHSvOxH9Dv48ZDFXRcXsN3Q0FB5PgcHWseRlJ+rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=btFz6HEr; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56A0o93C000616
	for <linux-fsdevel@vger.kernel.org>; Wed, 9 Jul 2025 21:21:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=Jobj9SBEmPckFPsfoGErsMMnOVliL4G/ImX8i3bXCag=; b=btFz6HErrz0o
	TLZty2DfY3pKkpVOS/rTTo/uXZpADIiSPnXqBYdn6axSjWCD83gCMl4VkAM+haUm
	rBu9BYDf8rYvrCvNV5/PC35ovshDb3BsmxjKERs/ghr4mpWikEdtPqw0CUKQzj+V
	UVCifwr4KXu60KQrnt0IndPIqjFCSRosma+ZSNxhH8jyKleudFXbk1CM8ze8Q/cx
	YZGapaa+jLIyfbHmlinYIQNMjSYLnFNwLp63ujjRzSgjgeE/t8ZaEkWcynLZ3JFI
	P3+NhJyMAnnGAugZwhKdaR2B3atrGLp902tsJFRO5hV7/Woki0uN73bS0tNtsBFG
	UKCr2WBI4w==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 47swg8uc1p-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Wed, 09 Jul 2025 21:21:06 -0700 (PDT)
Received: from twshared26876.17.frc2.facebook.com (2620:10d:c0a8:1b::2d) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1748.24; Thu, 10 Jul 2025 04:21:05 +0000
Received: by devvm18334.vll0.facebook.com (Postfix, from userid 202792)
	id 8B25331E90F0C; Wed,  9 Jul 2025 21:20:53 -0700 (PDT)
From: Ibrahim Jirdeh <ibrahimjirdeh@meta.com>
To: <ibrahimjirdeh@meta.com>
CC: <jack@suse.cz>, <amir73il@gmail.com>, <josef@toxicpanda.com>,
        <lesha@meta.com>, <linux-fsdevel@vger.kernel.org>, <sargun@meta.com>,
        ibrahimjirdeh <ibrahimjirdeh@fb.com>
Subject: [PATCH 1/3] [PATCH v2 1/3] fanotify: add support for a variable length permission event
Date: Wed, 9 Jul 2025 21:20:47 -0700
Message-ID: <20250710042049.3705747-2-ibrahimjirdeh@meta.com>
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
X-Proofpoint-GUID: bwmOGpdJ5AbtiBCK1tPBRffQXgLJ_Vt7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEwMDAzNCBTYWx0ZWRfX3ZltfDjfy2hM YHyZoCux0ufhEzS4bgqKeq5olFXy3wDqwqyUQTnTM0wdc0l/Y7TYMFpnxLoHDzxNRQF5P07fVFX SvLdHgxwB8ixDwUvVdJKY3oKEEXHVu7gCHKJdcYFFI3sIOvYPDr76jO9aaOFPSTiQNdS17UXCPO
 ipqCSIHueKY4/+RckNer+wZD50E2En+iSIaaRrNi76+sjOfm5UYX3NsjRbDvQyW2ILHxmBvxHQ4 ysiWJFyQBbBIqxJj5C9pn5ejjjBfARzxtiKXA4CsVl9QeRwit0Iu/P+GF8sbqqzrCkKQicFw3H/ rbp+KB4pGZNw3FeuhR0FBBL47JpE/oqKL7iaH1QWUcPGa3jWx9Oy6zyBCpPSQoGs5q6p4PR6pfr
 6TieB99Rgkd+DuG4Cnt8EHwsTYpV5TBxIu33G6LvUTUNk1IHkFbxgZ/B5wCh5Rh6dVi1A6fq
X-Authority-Analysis: v=2.4 cv=bddrUPPB c=1 sm=1 tr=0 ts=686f3fb2 cx=c_pps a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17 a=Wb1JkmetP80A:10 a=FOH2dFAWAAAA:8 a=pGLkceISAAAA:8 a=lPxGRcK3HGJCSv4Oa_kA:9
X-Proofpoint-ORIG-GUID: bwmOGpdJ5AbtiBCK1tPBRffQXgLJ_Vt7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-09_05,2025-07-09_01,2025-03-28_01

From: ibrahimjirdeh <ibrahimjirdeh@fb.com>

Summary:
From Amir Goldstein <amir73il@gmail.com>

In preparation for pre-content events that report fid info + name,
we need a new event type that is both variable length and can be
put on a user response wait list.

Create an event type FANOTIFY_EVENT_TYPE_FID_NAME_PERM with is a
combination of the variable length fanotify_name_event prefixed
with a fix length fanotify_perm_event and they share the common
fanotify_event memeber.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/notify/fanotify/fanotify.c | 76 +++++++++++++++++++++++++++--------
 fs/notify/fanotify/fanotify.h | 19 ++++++---
 2 files changed, 74 insertions(+), 21 deletions(-)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.=
c
index 3083643b864b..34acb7c16e8b 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -454,7 +454,13 @@ static int fanotify_encode_fh(struct fanotify_fh *fh=
, struct inode *inode,
 	dwords =3D fh_len >> 2;
 	type =3D exportfs_encode_fid(inode, buf, &dwords);
 	err =3D -EINVAL;
-	if (type <=3D 0 || type =3D=3D FILEID_INVALID || fh_len !=3D dwords << =
2)
+	/*
+	 * Unlike file_handle, type and len of struct fanotify_fh are u8.
+	 * Traditionally, filesystem return handle_type < 0xff, but there
+	 * is no enforecement for that in vfs.
+	 */
+	BUILD_BUG_ON(MAX_HANDLE_SZ > 0xff || FILEID_INVALID > 0xff);
+	if (type <=3D 0 || type >=3D FILEID_INVALID || fh_len !=3D dwords << 2)
 		goto out_err;
=20
 	fh->type =3D type;
@@ -576,20 +582,13 @@ static struct fanotify_event *fanotify_alloc_mnt_ev=
ent(u64 mnt_id, gfp_t gfp)
 	return &pevent->fae;
 }
=20
-static struct fanotify_event *fanotify_alloc_perm_event(const void *data=
,
-							int data_type,
-							gfp_t gfp)
+static void fanotify_init_perm_event(struct fanotify_perm_event *pevent,
+				     const void *data, int data_type)
 {
 	const struct path *path =3D fsnotify_data_path(data, data_type);
 	const struct file_range *range =3D
 			    fsnotify_data_file_range(data, data_type);
-	struct fanotify_perm_event *pevent;
-
-	pevent =3D kmem_cache_alloc(fanotify_perm_event_cachep, gfp);
-	if (!pevent)
-		return NULL;
=20
-	pevent->fae.type =3D FANOTIFY_EVENT_TYPE_PATH_PERM;
 	pevent->response =3D 0;
 	pevent->hdr.type =3D FAN_RESPONSE_INFO_NONE;
 	pevent->hdr.pad =3D 0;
@@ -600,6 +599,20 @@ static struct fanotify_event *fanotify_alloc_perm_ev=
ent(const void *data,
 	pevent->ppos =3D range ? &range->pos : NULL;
 	pevent->count =3D range ? range->count : 0;
 	path_get(path);
+}
+
+static struct fanotify_event *fanotify_alloc_perm_event(const void *data=
,
+							int data_type,
+							gfp_t gfp)
+{
+	struct fanotify_perm_event *pevent;
+
+	pevent =3D kmem_cache_alloc(fanotify_perm_event_cachep, gfp);
+	if (!pevent)
+		return NULL;
+
+	pevent->fae.type =3D FANOTIFY_EVENT_TYPE_PATH_PERM;
+	fanotify_init_perm_event(pevent, data, data_type);
=20
 	return &pevent->fae;
 }
@@ -630,11 +643,12 @@ static struct fanotify_event *fanotify_alloc_name_e=
vent(struct inode *dir,
 							struct inode *child,
 							struct dentry *moved,
 							unsigned int *hash,
-							gfp_t gfp)
+							gfp_t gfp, bool perm)
 {
 	struct fanotify_name_event *fne;
 	struct fanotify_info *info;
 	struct fanotify_fh *dfh, *ffh;
+	struct fanotify_perm_event *pevent;
 	struct inode *dir2 =3D moved ? d_inode(moved->d_parent) : NULL;
 	const struct qstr *name2 =3D moved ? &moved->d_name : NULL;
 	unsigned int dir_fh_len =3D fanotify_encode_fh_len(dir);
@@ -652,11 +666,26 @@ static struct fanotify_event *fanotify_alloc_name_e=
vent(struct inode *dir,
 		size +=3D FANOTIFY_FH_HDR_LEN + dir2_fh_len;
 	if (child_fh_len)
 		size +=3D FANOTIFY_FH_HDR_LEN + child_fh_len;
+	if (perm) {
+		BUILD_BUG_ON(offsetof(struct fanotify_perm_event, fae) +
+			     sizeof(struct fanotify_event) !=3D sizeof(*pevent));
+		size +=3D offsetof(struct fanotify_perm_event, fae);
+	}
 	fne =3D kmalloc(size, gfp);
 	if (!fne)
 		return NULL;
=20
-	fne->fae.type =3D FANOTIFY_EVENT_TYPE_FID_NAME;
+	/*
+	 * fanotify_name_event follows fanotify_perm_event and they share the
+	 * fae member.
+	 */
+	if (perm) {
+		pevent =3D (void *)fne;
+		fne =3D FANOTIFY_NE(&pevent->fae);
+		fne->fae.type =3D FANOTIFY_EVENT_TYPE_FID_NAME_PERM;
+	} else {
+		fne->fae.type =3D FANOTIFY_EVENT_TYPE_FID_NAME;
+	}
 	fne->fsid =3D *fsid;
 	*hash ^=3D fanotify_hash_fsid(fsid);
 	info =3D &fne->info;
@@ -751,6 +780,7 @@ static struct fanotify_event *fanotify_alloc_event(
 	struct inode *dirid =3D fanotify_dfid_inode(mask, data, data_type, dir)=
;
 	const struct path *path =3D fsnotify_data_path(data, data_type);
 	u64 mnt_id =3D fsnotify_data_mnt_id(data, data_type);
+	bool perm =3D fanotify_is_perm_event(mask);
 	struct mem_cgroup *old_memcg;
 	struct dentry *moved =3D NULL;
 	struct inode *child =3D NULL;
@@ -836,14 +866,18 @@ static struct fanotify_event *fanotify_alloc_event(
 	/* Whoever is interested in the event, pays for the allocation. */
 	old_memcg =3D set_active_memcg(group->memcg);
=20
-	if (fanotify_is_perm_event(mask)) {
+	if (name_event && (file_name || moved || child || perm)) {
+		event =3D fanotify_alloc_name_event(dirid, fsid, file_name, child,
+						  moved, &hash, gfp, perm);
+		if (event && perm) {
+			fanotify_init_perm_event(FANOTIFY_PERM(event),
+						 data, data_type);
+		}
+	} else if (perm) {
 		event =3D fanotify_alloc_perm_event(data, data_type, gfp);
 	} else if (fanotify_is_error_event(mask)) {
 		event =3D fanotify_alloc_error_event(group, fsid, data,
 						   data_type, &hash);
-	} else if (name_event && (file_name || moved || child)) {
-		event =3D fanotify_alloc_name_event(dirid, fsid, file_name, child,
-						  moved, &hash, gfp);
 	} else if (fid_mode) {
 		event =3D fanotify_alloc_fid_event(id, fsid, &hash, gfp);
 	} else if (path) {
@@ -1031,6 +1065,13 @@ static void fanotify_free_perm_event(struct fanoti=
fy_event *event)
 	kmem_cache_free(fanotify_perm_event_cachep, FANOTIFY_PERM(event));
 }
=20
+static void fanotify_free_name_perm_event(struct fanotify_event *event)
+{
+	path_put(fanotify_event_path(event));
+	/* Variable length perm event */
+	kfree(FANOTIFY_PERM(event));
+}
+
 static void fanotify_free_fid_event(struct fanotify_event *event)
 {
 	struct fanotify_fid_event *ffe =3D FANOTIFY_FE(event);
@@ -1078,6 +1119,9 @@ static void fanotify_free_event(struct fsnotify_gro=
up *group,
 	case FANOTIFY_EVENT_TYPE_FID_NAME:
 		fanotify_free_name_event(event);
 		break;
+	case FANOTIFY_EVENT_TYPE_FID_NAME_PERM:
+		fanotify_free_name_perm_event(event);
+		break;
 	case FANOTIFY_EVENT_TYPE_OVERFLOW:
 		kfree(event);
 		break;
diff --git a/fs/notify/fanotify/fanotify.h b/fs/notify/fanotify/fanotify.=
h
index b78308975082..f6d25fcf8692 100644
--- a/fs/notify/fanotify/fanotify.h
+++ b/fs/notify/fanotify/fanotify.h
@@ -240,6 +240,7 @@ static inline void fanotify_info_copy_name2(struct fa=
notify_info *info,
 enum fanotify_event_type {
 	FANOTIFY_EVENT_TYPE_FID, /* fixed length */
 	FANOTIFY_EVENT_TYPE_FID_NAME, /* variable length */
+	FANOTIFY_EVENT_TYPE_FID_NAME_PERM, /* variable length perm event */
 	FANOTIFY_EVENT_TYPE_PATH,
 	FANOTIFY_EVENT_TYPE_PATH_PERM,
 	FANOTIFY_EVENT_TYPE_OVERFLOW, /* struct fanotify_event */
@@ -326,7 +327,8 @@ static inline __kernel_fsid_t *fanotify_event_fsid(st=
ruct fanotify_event *event)
 {
 	if (event->type =3D=3D FANOTIFY_EVENT_TYPE_FID)
 		return &FANOTIFY_FE(event)->fsid;
-	else if (event->type =3D=3D FANOTIFY_EVENT_TYPE_FID_NAME)
+	else if (event->type =3D=3D FANOTIFY_EVENT_TYPE_FID_NAME ||
+		 event->type =3D=3D FANOTIFY_EVENT_TYPE_FID_NAME_PERM)
 		return &FANOTIFY_NE(event)->fsid;
 	else if (event->type =3D=3D FANOTIFY_EVENT_TYPE_FS_ERROR)
 		return &FANOTIFY_EE(event)->fsid;
@@ -339,7 +341,8 @@ static inline struct fanotify_fh *fanotify_event_obje=
ct_fh(
 {
 	if (event->type =3D=3D FANOTIFY_EVENT_TYPE_FID)
 		return &FANOTIFY_FE(event)->object_fh;
-	else if (event->type =3D=3D FANOTIFY_EVENT_TYPE_FID_NAME)
+	else if (event->type =3D=3D FANOTIFY_EVENT_TYPE_FID_NAME ||
+		 event->type =3D=3D FANOTIFY_EVENT_TYPE_FID_NAME_PERM)
 		return fanotify_info_file_fh(&FANOTIFY_NE(event)->info);
 	else if (event->type =3D=3D FANOTIFY_EVENT_TYPE_FS_ERROR)
 		return &FANOTIFY_EE(event)->object_fh;
@@ -350,7 +353,8 @@ static inline struct fanotify_fh *fanotify_event_obje=
ct_fh(
 static inline struct fanotify_info *fanotify_event_info(
 						struct fanotify_event *event)
 {
-	if (event->type =3D=3D FANOTIFY_EVENT_TYPE_FID_NAME)
+	if (event->type =3D=3D FANOTIFY_EVENT_TYPE_FID_NAME ||
+	    event->type =3D=3D FANOTIFY_EVENT_TYPE_FID_NAME_PERM)
 		return &FANOTIFY_NE(event)->info;
 	else
 		return NULL;
@@ -435,7 +439,6 @@ FANOTIFY_ME(struct fanotify_event *event)
  * user response.
  */
 struct fanotify_perm_event {
-	struct fanotify_event fae;
 	struct path path;
 	const loff_t *ppos;		/* optional file range info */
 	size_t count;
@@ -446,6 +449,11 @@ struct fanotify_perm_event {
 		struct fanotify_response_info_header hdr;
 		struct fanotify_response_info_audit_rule audit_rule;
 	};
+	/*
+	 * Overlaps with fanotify_name_event::fae when type is
+	 * FANOTIFY_EVENT_TYPE_FID_NAME_PERM - Keep at the end!
+	 */
+	struct fanotify_event fae;
 };
=20
 static inline struct fanotify_perm_event *
@@ -487,7 +495,8 @@ static inline const struct path *fanotify_event_path(=
struct fanotify_event *even
 {
 	if (event->type =3D=3D FANOTIFY_EVENT_TYPE_PATH)
 		return &FANOTIFY_PE(event)->path;
-	else if (event->type =3D=3D FANOTIFY_EVENT_TYPE_PATH_PERM)
+	else if (event->type =3D=3D FANOTIFY_EVENT_TYPE_PATH_PERM ||
+		 event->type =3D=3D FANOTIFY_EVENT_TYPE_FID_NAME_PERM)
 		return &FANOTIFY_PERM(event)->path;
 	else
 		return NULL;
--=20
2.47.1


