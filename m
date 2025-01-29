Return-Path: <linux-fsdevel+bounces-40316-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E34E4A22269
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2025 17:58:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48663168596
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2025 16:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE3B11E0DB5;
	Wed, 29 Jan 2025 16:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vxk9nx1j"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7FCF1E0B7C
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jan 2025 16:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738169898; cv=none; b=Br430AEd5Vawr3buMkcka976+CHg+PQrHGjq3JPDe03kAb/YmFZZyTbnMaesdp5E/pVF+lvuOQHWsaq8sDqTImv4rYbs1ZbOnOhX0RuOJlHBTAEXX+a77okmwQt5uLI7kKbVHrbmGE9/WrCyo9rcJs/T2njUTJF+bO4x9xaU22E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738169898; c=relaxed/simple;
	bh=kuKUx+T9+doKDpYDRp/D8wBV87EIilhaPdoa7ZKUVVc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eYQcNJTxL+C1XIm0swpVGLlLltAz8jhvUKIvTPYxCC6Byz4ib+o6k6cG8A4kQszhBOThi/7SSjuY9Uz0KkAKIO/i833LLQk30bF7nNoOka3VzQCLhw7IXrj98JqtmW8ehlJ/s2+4h7rPevnlFvG5rR6BvD5dQ4Q2zdyOJAsQnMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Vxk9nx1j; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738169894;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h5dxPpSrpVipJu8MxehZUUEZQE1UDnRZ3zosoGcAwSU=;
	b=Vxk9nx1jgZB77QX8UsatvSy0sKaZGaoGnUf/2xUecWmk7GKL7Z8GQgZRv3TKcG7gefrg6T
	tC/mAh0M7c8JNSfTA9DVUT+J3YEgwpaTfT74cYpfJE3Wzui/kMF7GZNAYCsxMurI+QcwmG
	bHetHrGUH+t7qpR8EKWoRrnDbuKDefc=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-371-UelIH6tMOUOmAiLoMX296g-1; Wed, 29 Jan 2025 11:58:11 -0500
X-MC-Unique: UelIH6tMOUOmAiLoMX296g-1
X-Mimecast-MFC-AGG-ID: UelIH6tMOUOmAiLoMX296g
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-aa6b904a886so577154766b.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jan 2025 08:58:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738169889; x=1738774689;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h5dxPpSrpVipJu8MxehZUUEZQE1UDnRZ3zosoGcAwSU=;
        b=uMg2Y2ZP/l6t2eIiv5gW1TqGVJ/1VBeTgzRDQYjQmDuhfiHhLObzhCltk2NbwbTXSc
         KmhyRRUqKpYzfvIwHEei3rWat3HF67/4Ky6QkdhNceucrNzDlguTu8WsT6aC5DsRUKSf
         16f2hqA4j9/B8g5gjl9OCKJpTDFTh31mL8zYn9c4gE9JqF+jWInHFXapUxMCcxxvEwCq
         4qJM/llvzjsELTW8fxIpKSAWR0BQYpWsQy0Wv3rSdKiaJD0MeywJD2vBMe7gWFdBi6/u
         zrB0sHlvrS8SCJksB7oCixiHWy8yT8OoXVR0t5R/NGWXqNbam2JwZcr5Iu8sWVVz9otj
         VO2w==
X-Gm-Message-State: AOJu0Yw3ZhTrBuTFPsPOn4Sk8tKrftslQE/eCljvBYUXHrlVuIPIFuZO
	RHp0aJMYwURo55t5V6If4jxM11wMltRGvAwwsYaXjhJAHN8g6L3JZaH1SL1eljHZr7m36zr7N9E
	6gaMQ0rL/POEk/eh7KIR02IZYImvDMjy8HtLLbO4JSHELAqXXH/Pqvxt8Upo1aOooaJwfnqX/US
	wdwcddrIb5NObssbqI6unCdQEOAqNR9Gb6Pfa7d+c8dN8L04XWTw==
X-Gm-Gg: ASbGncsrFbW/Z8sNbNP1qVmMP6lMwMHcWZN45Tcj9fKpPFKM3t4p6jP5cULZ5n5Mtpv
	y5HxPtav5mxiAzXFveOgFAL+maKRAUmiQ/+6tYMZMRVHhtasxrKKImUpH60jDmLv6hRibyG8APW
	AeKcS42xGtwbQluJ+fs32k5ePbPWFy6qvtmT6g0XXXZErgTbtwmDSlqVYB3wWxTdq4+SMSzwajG
	LdhvBJAArQWIgcYWOB1EI98zdsRMLB5GWtS5yUxoKSqEikWeJxleVZ6C2e1Jp0wjFgADht1p4IT
	4C83Ncf6Eqrh7u3zo4rJPhs0HQxDeRqUCB4K9QYqd5fgSgUM4E9ldmdx
X-Received: by 2002:a17:906:f58c:b0:aaf:86a2:651f with SMTP id a640c23a62f3a-ab6cfdbd07emr357889866b.38.1738169888564;
        Wed, 29 Jan 2025 08:58:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEEiuMLhxLtelwpu3IGhkeCD0GskF2ESgUibiql0ctURynMJfSQpQRAwzYlLDwHhm24G+TDKA==
X-Received: by 2002:a17:906:f58c:b0:aaf:86a2:651f with SMTP id a640c23a62f3a-ab6cfdbd07emr357886266b.38.1738169888039;
        Wed, 29 Jan 2025 08:58:08 -0800 (PST)
Received: from maszat.piliscsaba.szeredi.hu (91-82-183-41.pool.digikabel.hu. [91.82.183.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab675e653c6sm1002813366b.64.2025.01.29.08.58.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2025 08:58:07 -0800 (PST)
From: Miklos Szeredi <mszeredi@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Amir Goldstein <amir73il@gmail.com>,
	Karel Zak <kzak@redhat.com>,
	Lennart Poettering <lennart@poettering.net>,
	Ian Kent <raven@themaw.net>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Paul Moore <paul@paul-moore.com>,
	selinux@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	selinux-refpolicy@vger.kernel.org
Subject: [PATCH v5 2/3] fanotify: notify on mount attach and detach
Date: Wed, 29 Jan 2025 17:58:00 +0100
Message-ID: <20250129165803.72138-3-mszeredi@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250129165803.72138-1-mszeredi@redhat.com>
References: <20250129165803.72138-1-mszeredi@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add notifications for attaching and detaching mounts.  The following new
event masks are added:

  FAN_MNT_ATTACH  - Mount was attached
  FAN_MNT_DETACH  - Mount was detached

If a mount is moved, then the event is reported with (FAN_MNT_ATTACH |
FAN_MNT_DETACH).

These events add an info record of type FAN_EVENT_INFO_TYPE_MNT containing
these fields identifying the affected mounts:

  __u64 mnt_id    - the ID of the mount (see statmount(2))

FAN_REPORT_MNT must be supplied to fanotify_init() to receive these events
and no other type of event can be received with this report type.

Marks are added with FAN_MARK_MNTNS, which records the mount namespace from
an nsfs file (e.g. /proc/self/ns/mnt).

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/mount.h                         |  2 +
 fs/namespace.c                     | 14 +++--
 fs/notify/fanotify/fanotify.c      | 38 +++++++++++--
 fs/notify/fanotify/fanotify.h      | 18 +++++++
 fs/notify/fanotify/fanotify_user.c | 87 +++++++++++++++++++++++++-----
 fs/notify/fdinfo.c                 |  5 ++
 include/linux/fanotify.h           | 12 +++--
 include/uapi/linux/fanotify.h      | 10 ++++
 security/selinux/hooks.c           |  4 ++
 9 files changed, 167 insertions(+), 23 deletions(-)

diff --git a/fs/mount.h b/fs/mount.h
index 82aa3bad7cf5..5324a931b403 100644
--- a/fs/mount.h
+++ b/fs/mount.h
@@ -181,3 +181,5 @@ static inline struct mnt_namespace *to_mnt_ns(struct ns_common *ns)
 {
 	return container_of(ns, struct mnt_namespace, ns);
 }
+
+struct mnt_namespace *mnt_ns_from_dentry(struct dentry *dentry);
diff --git a/fs/namespace.c b/fs/namespace.c
index 4013fbac354a..d8d70da56e7b 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2145,16 +2145,24 @@ struct mnt_namespace *get_sequential_mnt_ns(struct mnt_namespace *mntns, bool pr
 	}
 }
 
+struct mnt_namespace *mnt_ns_from_dentry(struct dentry *dentry)
+{
+	if (!is_mnt_ns_file(dentry))
+		return NULL;
+
+	return to_mnt_ns(get_proc_ns(dentry->d_inode));
+}
+
 static bool mnt_ns_loop(struct dentry *dentry)
 {
 	/* Could bind mounting the mount namespace inode cause a
 	 * mount namespace loop?
 	 */
-	struct mnt_namespace *mnt_ns;
-	if (!is_mnt_ns_file(dentry))
+	struct mnt_namespace *mnt_ns = mnt_ns_from_dentry(dentry);
+
+	if (!mnt_ns)
 		return false;
 
-	mnt_ns = to_mnt_ns(get_proc_ns(dentry->d_inode));
 	return current->nsproxy->mnt_ns->seq >= mnt_ns->seq;
 }
 
diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index 95646f7c46ca..6d386080faf2 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -166,6 +166,8 @@ static bool fanotify_should_merge(struct fanotify_event *old,
 	case FANOTIFY_EVENT_TYPE_FS_ERROR:
 		return fanotify_error_event_equal(FANOTIFY_EE(old),
 						  FANOTIFY_EE(new));
+	case FANOTIFY_EVENT_TYPE_MNT:
+		return false;
 	default:
 		WARN_ON_ONCE(1);
 	}
@@ -312,7 +314,10 @@ static u32 fanotify_group_event_mask(struct fsnotify_group *group,
 	pr_debug("%s: report_mask=%x mask=%x data=%p data_type=%d\n",
 		 __func__, iter_info->report_mask, event_mask, data, data_type);
 
-	if (!fid_mode) {
+	if (FAN_GROUP_FLAG(group, FAN_REPORT_MNT)) {
+		if (data_type != FSNOTIFY_EVENT_MNT)
+			return 0;
+	} else if (!fid_mode) {
 		/* Do we have path to open a file descriptor? */
 		if (!path)
 			return 0;
@@ -557,6 +562,20 @@ static struct fanotify_event *fanotify_alloc_path_event(const struct path *path,
 	return &pevent->fae;
 }
 
+static struct fanotify_event *fanotify_alloc_mnt_event(u64 mnt_id, gfp_t gfp)
+{
+	struct fanotify_mnt_event *pevent;
+
+	pevent = kmem_cache_alloc(fanotify_mnt_event_cachep, gfp);
+	if (!pevent)
+		return NULL;
+
+	pevent->fae.type = FANOTIFY_EVENT_TYPE_MNT;
+	pevent->mnt_id = mnt_id;
+
+	return &pevent->fae;
+}
+
 static struct fanotify_event *fanotify_alloc_perm_event(const void *data,
 							int data_type,
 							gfp_t gfp)
@@ -731,6 +750,7 @@ static struct fanotify_event *fanotify_alloc_event(
 					      fid_mode);
 	struct inode *dirid = fanotify_dfid_inode(mask, data, data_type, dir);
 	const struct path *path = fsnotify_data_path(data, data_type);
+	u64 mnt_id = fsnotify_data_mnt_id(data, data_type);
 	struct mem_cgroup *old_memcg;
 	struct dentry *moved = NULL;
 	struct inode *child = NULL;
@@ -826,8 +846,12 @@ static struct fanotify_event *fanotify_alloc_event(
 						  moved, &hash, gfp);
 	} else if (fid_mode) {
 		event = fanotify_alloc_fid_event(id, fsid, &hash, gfp);
-	} else {
+	} else if (path) {
 		event = fanotify_alloc_path_event(path, &hash, gfp);
+	} else if (mnt_id) {
+		event = fanotify_alloc_mnt_event(mnt_id, gfp);
+	} else {
+		WARN_ON_ONCE(1);
 	}
 
 	if (!event)
@@ -927,7 +951,7 @@ static int fanotify_handle_event(struct fsnotify_group *group, u32 mask,
 	BUILD_BUG_ON(FAN_RENAME != FS_RENAME);
 	BUILD_BUG_ON(FAN_PRE_ACCESS != FS_PRE_ACCESS);
 
-	BUILD_BUG_ON(HWEIGHT32(ALL_FANOTIFY_EVENT_BITS) != 22);
+	BUILD_BUG_ON(HWEIGHT32(ALL_FANOTIFY_EVENT_BITS) != 24);
 
 	mask = fanotify_group_event_mask(group, iter_info, &match_mask,
 					 mask, data, data_type, dir);
@@ -1028,6 +1052,11 @@ static void fanotify_free_error_event(struct fsnotify_group *group,
 	mempool_free(fee, &group->fanotify_data.error_events_pool);
 }
 
+static void fanotify_free_mnt_event(struct fanotify_event *event)
+{
+	kmem_cache_free(fanotify_mnt_event_cachep, FANOTIFY_ME(event));
+}
+
 static void fanotify_free_event(struct fsnotify_group *group,
 				struct fsnotify_event *fsn_event)
 {
@@ -1054,6 +1083,9 @@ static void fanotify_free_event(struct fsnotify_group *group,
 	case FANOTIFY_EVENT_TYPE_FS_ERROR:
 		fanotify_free_error_event(group, event);
 		break;
+	case FANOTIFY_EVENT_TYPE_MNT:
+		fanotify_free_mnt_event(event);
+		break;
 	default:
 		WARN_ON_ONCE(1);
 	}
diff --git a/fs/notify/fanotify/fanotify.h b/fs/notify/fanotify/fanotify.h
index c12cbc270539..b44e70e44be6 100644
--- a/fs/notify/fanotify/fanotify.h
+++ b/fs/notify/fanotify/fanotify.h
@@ -9,6 +9,7 @@ extern struct kmem_cache *fanotify_mark_cache;
 extern struct kmem_cache *fanotify_fid_event_cachep;
 extern struct kmem_cache *fanotify_path_event_cachep;
 extern struct kmem_cache *fanotify_perm_event_cachep;
+extern struct kmem_cache *fanotify_mnt_event_cachep;
 
 /* Possible states of the permission event */
 enum {
@@ -244,6 +245,7 @@ enum fanotify_event_type {
 	FANOTIFY_EVENT_TYPE_PATH_PERM,
 	FANOTIFY_EVENT_TYPE_OVERFLOW, /* struct fanotify_event */
 	FANOTIFY_EVENT_TYPE_FS_ERROR, /* struct fanotify_error_event */
+	FANOTIFY_EVENT_TYPE_MNT,
 	__FANOTIFY_EVENT_TYPE_NUM
 };
 
@@ -409,12 +411,23 @@ struct fanotify_path_event {
 	struct path path;
 };
 
+struct fanotify_mnt_event {
+	struct fanotify_event fae;
+	u64 mnt_id;
+};
+
 static inline struct fanotify_path_event *
 FANOTIFY_PE(struct fanotify_event *event)
 {
 	return container_of(event, struct fanotify_path_event, fae);
 }
 
+static inline struct fanotify_mnt_event *
+FANOTIFY_ME(struct fanotify_event *event)
+{
+	return container_of(event, struct fanotify_mnt_event, fae);
+}
+
 /*
  * Structure for permission fanotify events. It gets allocated and freed in
  * fanotify_handle_event() since we wait there for user response. When the
@@ -466,6 +479,11 @@ static inline bool fanotify_is_error_event(u32 mask)
 	return mask & FAN_FS_ERROR;
 }
 
+static inline bool fanotify_is_mnt_event(u32 mask)
+{
+	return mask & (FAN_MNT_ATTACH | FAN_MNT_DETACH);
+}
+
 static inline const struct path *fanotify_event_path(struct fanotify_event *event)
 {
 	if (event->type == FANOTIFY_EVENT_TYPE_PATH)
diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index 6ff94e312232..d0fe7d7880a6 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -113,6 +113,7 @@ struct kmem_cache *fanotify_mark_cache __ro_after_init;
 struct kmem_cache *fanotify_fid_event_cachep __ro_after_init;
 struct kmem_cache *fanotify_path_event_cachep __ro_after_init;
 struct kmem_cache *fanotify_perm_event_cachep __ro_after_init;
+struct kmem_cache *fanotify_mnt_event_cachep __ro_after_init;
 
 #define FANOTIFY_EVENT_ALIGN 4
 #define FANOTIFY_FID_INFO_HDR_LEN \
@@ -123,6 +124,8 @@ struct kmem_cache *fanotify_perm_event_cachep __ro_after_init;
 	(sizeof(struct fanotify_event_info_error))
 #define FANOTIFY_RANGE_INFO_LEN \
 	(sizeof(struct fanotify_event_info_range))
+#define FANOTIFY_MNT_INFO_LEN \
+	(sizeof(struct fanotify_event_info_mnt))
 
 static int fanotify_fid_info_len(int fh_len, int name_len)
 {
@@ -178,6 +181,8 @@ static size_t fanotify_event_len(unsigned int info_mode,
 		fh_len = fanotify_event_object_fh_len(event);
 		event_len += fanotify_fid_info_len(fh_len, dot_len);
 	}
+	if (fanotify_is_mnt_event(event->mask))
+		event_len += FANOTIFY_MNT_INFO_LEN;
 
 	if (info_mode & FAN_REPORT_PIDFD)
 		event_len += FANOTIFY_PIDFD_INFO_LEN;
@@ -405,6 +410,25 @@ static int process_access_response(struct fsnotify_group *group,
 	return -ENOENT;
 }
 
+static size_t copy_mnt_info_to_user(struct fanotify_event *event,
+				    char __user *buf, int count)
+{
+	struct fanotify_event_info_mnt info = { };
+
+	info.hdr.info_type = FAN_EVENT_INFO_TYPE_MNT;
+	info.hdr.len = FANOTIFY_MNT_INFO_LEN;
+
+	if (WARN_ON(count < info.hdr.len))
+		return -EFAULT;
+
+	info.mnt_id = FANOTIFY_ME(event)->mnt_id;
+
+	if (copy_to_user(buf, &info, sizeof(info)))
+		return -EFAULT;
+
+	return info.hdr.len;
+}
+
 static size_t copy_error_info_to_user(struct fanotify_event *event,
 				      char __user *buf, int count)
 {
@@ -700,6 +724,15 @@ static int copy_info_records_to_user(struct fanotify_event *event,
 		total_bytes += ret;
 	}
 
+	if (fanotify_is_mnt_event(event->mask)) {
+		ret = copy_mnt_info_to_user(event, buf, count);
+		if (ret < 0)
+			return ret;
+		buf += ret;
+		count -= ret;
+		total_bytes += ret;
+	}
+
 	return total_bytes;
 }
 
@@ -1508,6 +1541,14 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flags, unsigned int, event_f_flags)
 	if ((flags & FAN_REPORT_PIDFD) && (flags & FAN_REPORT_TID))
 		return -EINVAL;
 
+	/* Don't allow mixing mnt events with inode events for now */
+	if (flags & FAN_REPORT_MNT) {
+		if (class != FAN_CLASS_NOTIF)
+			return -EINVAL;
+		if (flags & (FANOTIFY_FID_BITS | FAN_REPORT_FD_ERROR))
+			return -EINVAL;
+	}
+
 	if (event_f_flags & ~FANOTIFY_INIT_ALL_EVENT_F_BITS)
 		return -EINVAL;
 
@@ -1767,7 +1808,6 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
 			    int dfd, const char  __user *pathname)
 {
 	struct inode *inode = NULL;
-	struct vfsmount *mnt = NULL;
 	struct fsnotify_group *group;
 	struct path path;
 	struct fan_fsid __fsid, *fsid = NULL;
@@ -1800,6 +1840,9 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
 	case FAN_MARK_FILESYSTEM:
 		obj_type = FSNOTIFY_OBJ_TYPE_SB;
 		break;
+	case FAN_MARK_MNTNS:
+		obj_type = FSNOTIFY_OBJ_TYPE_MNTNS;
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -1847,6 +1890,19 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
 		return -EINVAL;
 	group = fd_file(f)->private_data;
 
+	/* Only report mount events on mnt namespace */
+	if (FAN_GROUP_FLAG(group, FAN_REPORT_MNT)) {
+		if (mask & ~FANOTIFY_MOUNT_EVENTS)
+			return -EINVAL;
+		if (mark_type != FAN_MARK_MNTNS)
+			return -EINVAL;
+	} else {
+		if (mask & FANOTIFY_MOUNT_EVENTS)
+			return -EINVAL;
+		if (mark_type == FAN_MARK_MNTNS)
+			return -EINVAL;
+	}
+
 	/*
 	 * An unprivileged user is not allowed to setup mount nor filesystem
 	 * marks.  This also includes setting up such marks by a group that
@@ -1888,7 +1944,7 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
 	 * point.
 	 */
 	fid_mode = FAN_GROUP_FLAG(group, FANOTIFY_FID_BITS);
-	if (mask & ~(FANOTIFY_FD_EVENTS|FANOTIFY_EVENT_FLAGS) &&
+	if (mask & ~(FANOTIFY_FD_EVENTS|FANOTIFY_MOUNT_EVENTS|FANOTIFY_EVENT_FLAGS) &&
 	    (!fid_mode || mark_type == FAN_MARK_MOUNT))
 		return -EINVAL;
 
@@ -1938,17 +1994,21 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
 	}
 
 	/* inode held in place by reference to path; group by fget on fd */
-	if (mark_type == FAN_MARK_INODE) {
+	if (obj_type == FSNOTIFY_OBJ_TYPE_INODE) {
 		inode = path.dentry->d_inode;
 		obj = inode;
-	} else {
-		mnt = path.mnt;
-		if (mark_type == FAN_MARK_MOUNT)
-			obj = mnt;
-		else
-			obj = mnt->mnt_sb;
+	} else if (obj_type == FSNOTIFY_OBJ_TYPE_VFSMOUNT) {
+		obj = path.mnt;
+	} else if (obj_type == FSNOTIFY_OBJ_TYPE_SB) {
+		obj = path.mnt->mnt_sb;
+	} else if (obj_type == FSNOTIFY_OBJ_TYPE_MNTNS) {
+		obj = mnt_ns_from_dentry(path.dentry);
 	}
 
+	ret = -EINVAL;
+	if (!obj)
+		goto path_put_and_out;
+
 	/*
 	 * If some other task has this inode open for write we should not add
 	 * an ignore mask, unless that ignore mask is supposed to survive
@@ -1956,10 +2016,10 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
 	 */
 	if (mark_cmd == FAN_MARK_ADD && (flags & FANOTIFY_MARK_IGNORE_BITS) &&
 	    !(flags & FAN_MARK_IGNORED_SURV_MODIFY)) {
-		ret = mnt ? -EINVAL : -EISDIR;
+		ret = !inode ? -EINVAL : -EISDIR;
 		/* FAN_MARK_IGNORE requires SURV_MODIFY for sb/mount/dir marks */
 		if (ignore == FAN_MARK_IGNORE &&
-		    (mnt || S_ISDIR(inode->i_mode)))
+		    (!inode || S_ISDIR(inode->i_mode)))
 			goto path_put_and_out;
 
 		ret = 0;
@@ -1968,7 +2028,7 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
 	}
 
 	/* Mask out FAN_EVENT_ON_CHILD flag for sb/mount/non-dir marks */
-	if (mnt || !S_ISDIR(inode->i_mode)) {
+	if (!inode || !S_ISDIR(inode->i_mode)) {
 		mask &= ~FAN_EVENT_ON_CHILD;
 		umask = FAN_EVENT_ON_CHILD;
 		/*
@@ -2042,7 +2102,7 @@ static int __init fanotify_user_setup(void)
 				     FANOTIFY_DEFAULT_MAX_USER_MARKS);
 
 	BUILD_BUG_ON(FANOTIFY_INIT_FLAGS & FANOTIFY_INTERNAL_GROUP_FLAGS);
-	BUILD_BUG_ON(HWEIGHT32(FANOTIFY_INIT_FLAGS) != 13);
+	BUILD_BUG_ON(HWEIGHT32(FANOTIFY_INIT_FLAGS) != 14);
 	BUILD_BUG_ON(HWEIGHT32(FANOTIFY_MARK_FLAGS) != 11);
 
 	fanotify_mark_cache = KMEM_CACHE(fanotify_mark,
@@ -2055,6 +2115,7 @@ static int __init fanotify_user_setup(void)
 		fanotify_perm_event_cachep =
 			KMEM_CACHE(fanotify_perm_event, SLAB_PANIC);
 	}
+	fanotify_mnt_event_cachep = KMEM_CACHE(fanotify_mnt_event, SLAB_PANIC);
 
 	fanotify_max_queued_events = FANOTIFY_DEFAULT_MAX_EVENTS;
 	init_user_ns.ucount_max[UCOUNT_FANOTIFY_GROUPS] =
diff --git a/fs/notify/fdinfo.c b/fs/notify/fdinfo.c
index e933f9c65d90..1161eabf11ee 100644
--- a/fs/notify/fdinfo.c
+++ b/fs/notify/fdinfo.c
@@ -121,6 +121,11 @@ static void fanotify_fdinfo(struct seq_file *m, struct fsnotify_mark *mark)
 
 		seq_printf(m, "fanotify sdev:%x mflags:%x mask:%x ignored_mask:%x\n",
 			   sb->s_dev, mflags, mark->mask, mark->ignore_mask);
+	} else if (mark->connector->type == FSNOTIFY_OBJ_TYPE_MNTNS) {
+		struct mnt_namespace *mnt_ns = fsnotify_conn_mntns(mark->connector);
+
+		seq_printf(m, "fanotify mnt_ns:%u mflags:%x mask:%x ignored_mask:%x\n",
+			   mnt_ns->ns.inum, mflags, mark->mask, mark->ignore_mask);
 	}
 }
 
diff --git a/include/linux/fanotify.h b/include/linux/fanotify.h
index 78f660ebc318..3c817dc6292e 100644
--- a/include/linux/fanotify.h
+++ b/include/linux/fanotify.h
@@ -25,7 +25,7 @@
 
 #define FANOTIFY_FID_BITS	(FAN_REPORT_DFID_NAME_TARGET)
 
-#define FANOTIFY_INFO_MODES	(FANOTIFY_FID_BITS | FAN_REPORT_PIDFD)
+#define FANOTIFY_INFO_MODES	(FANOTIFY_FID_BITS | FAN_REPORT_PIDFD | FAN_REPORT_MNT)
 
 /*
  * fanotify_init() flags that require CAP_SYS_ADMIN.
@@ -38,7 +38,8 @@
 					 FAN_REPORT_PIDFD | \
 					 FAN_REPORT_FD_ERROR | \
 					 FAN_UNLIMITED_QUEUE | \
-					 FAN_UNLIMITED_MARKS)
+					 FAN_UNLIMITED_MARKS | \
+					 FAN_REPORT_MNT)
 
 /*
  * fanotify_init() flags that are allowed for user without CAP_SYS_ADMIN.
@@ -58,7 +59,7 @@
 #define FANOTIFY_INTERNAL_GROUP_FLAGS	(FANOTIFY_UNPRIV)
 
 #define FANOTIFY_MARK_TYPE_BITS	(FAN_MARK_INODE | FAN_MARK_MOUNT | \
-				 FAN_MARK_FILESYSTEM)
+				 FAN_MARK_FILESYSTEM | FAN_MARK_MNTNS)
 
 #define FANOTIFY_MARK_CMD_BITS	(FAN_MARK_ADD | FAN_MARK_REMOVE | \
 				 FAN_MARK_FLUSH)
@@ -109,10 +110,13 @@
 /* Events that can only be reported with data type FSNOTIFY_EVENT_ERROR */
 #define FANOTIFY_ERROR_EVENTS	(FAN_FS_ERROR)
 
+#define FANOTIFY_MOUNT_EVENTS	(FAN_MNT_ATTACH | FAN_MNT_DETACH)
+
 /* Events that user can request to be notified on */
 #define FANOTIFY_EVENTS		(FANOTIFY_PATH_EVENTS | \
 				 FANOTIFY_INODE_EVENTS | \
-				 FANOTIFY_ERROR_EVENTS)
+				 FANOTIFY_ERROR_EVENTS | \
+				 FANOTIFY_MOUNT_EVENTS)
 
 /* Extra flags that may be reported with event or control handling of events */
 #define FANOTIFY_EVENT_FLAGS	(FAN_EVENT_ON_CHILD | FAN_ONDIR)
diff --git a/include/uapi/linux/fanotify.h b/include/uapi/linux/fanotify.h
index bd8167979707..e710967c7c26 100644
--- a/include/uapi/linux/fanotify.h
+++ b/include/uapi/linux/fanotify.h
@@ -28,6 +28,8 @@
 /* #define FAN_DIR_MODIFY	0x00080000 */	/* Deprecated (reserved) */
 
 #define FAN_PRE_ACCESS		0x00100000	/* Pre-content access hook */
+#define FAN_MNT_ATTACH		0x01000000	/* Mount was attached */
+#define FAN_MNT_DETACH		0x02000000	/* Mount was detached */
 
 #define FAN_EVENT_ON_CHILD	0x08000000	/* Interested in child events */
 
@@ -64,6 +66,7 @@
 #define FAN_REPORT_NAME		0x00000800	/* Report events with name */
 #define FAN_REPORT_TARGET_FID	0x00001000	/* Report dirent target id  */
 #define FAN_REPORT_FD_ERROR	0x00002000	/* event->fd can report error */
+#define FAN_REPORT_MNT		0x00004000	/* Report mount events */
 
 /* Convenience macro - FAN_REPORT_NAME requires FAN_REPORT_DIR_FID */
 #define FAN_REPORT_DFID_NAME	(FAN_REPORT_DIR_FID | FAN_REPORT_NAME)
@@ -94,6 +97,7 @@
 #define FAN_MARK_INODE		0x00000000
 #define FAN_MARK_MOUNT		0x00000010
 #define FAN_MARK_FILESYSTEM	0x00000100
+#define FAN_MARK_MNTNS		0x00000110
 
 /*
  * Convenience macro - FAN_MARK_IGNORE requires FAN_MARK_IGNORED_SURV_MODIFY
@@ -147,6 +151,7 @@ struct fanotify_event_metadata {
 #define FAN_EVENT_INFO_TYPE_PIDFD	4
 #define FAN_EVENT_INFO_TYPE_ERROR	5
 #define FAN_EVENT_INFO_TYPE_RANGE	6
+#define FAN_EVENT_INFO_TYPE_MNT		7
 
 /* Special info types for FAN_RENAME */
 #define FAN_EVENT_INFO_TYPE_OLD_DFID_NAME	10
@@ -200,6 +205,11 @@ struct fanotify_event_info_range {
 	__u64 count;
 };
 
+struct fanotify_event_info_mnt {
+	struct fanotify_event_info_header hdr;
+	__u64 mnt_id;
+};
+
 /*
  * User space may need to record additional information about its decision.
  * The extra information type records what kind of information is included.
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 7b867dfec88b..06d073eab53c 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -3395,6 +3395,10 @@ static int selinux_path_notify(const struct path *path, u64 mask,
 	case FSNOTIFY_OBJ_TYPE_INODE:
 		perm = FILE__WATCH;
 		break;
+	case FSNOTIFY_OBJ_TYPE_MNTNS:
+		/* Maybe introduce FILE__WATCH_MOUNTNS? */
+		perm = FILE__WATCH_MOUNT;
+		break;
 	default:
 		return -EINVAL;
 	}
-- 
2.48.1


