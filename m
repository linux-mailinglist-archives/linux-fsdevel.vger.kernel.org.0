Return-Path: <linux-fsdevel+bounces-40000-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D51CDA1AA7E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2025 20:41:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14BC116AA62
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2025 19:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2B031BEF7C;
	Thu, 23 Jan 2025 19:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AVNobR/S"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C881741D2
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jan 2025 19:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737661280; cv=none; b=mnOiaJd+BSC3gNqfwdFZxgMcjd4puclFuATrCeYAMJmDfguJnUx5QJf9NvRUyec+ZFQhA3lqrVOA+a0hrny+PiuQ+B6IQ8uvoGhkxIzqxHDtw8iz1uYGXa5OqIYfpPnzS+fh+6m/uO/cNrROIkuLt5nn6EBtjzW3EkTccTWiX1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737661280; c=relaxed/simple;
	bh=DfvdbrrQ9fbO0Hva6Zd1MCsmhJdquMFinSncN93w4Jo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MOh+GKUuBrOG7N4c2iOnW3tIAFqQk4zTWmPQJysq8cYEG+v9nJk6Az+I/WMmVvKaNPkd+PcYvs+341hRYL0b0Uo494WBZwVpa+Pok+778PIjMfbHL9XHN0Dd6BFAXYX00niQmM6MPLLjH3mSP1lHyUupqGygcEkffMhV/s5nEVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AVNobR/S; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737661277;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cNJzcboFi8tAjHl3U9gH4h1OKVqCPBFW2xXRLutD69U=;
	b=AVNobR/SGThoMV83HwYvzFsQy+htqbbyl+smhWoyk/S7zTfgVfkkY1ESkp+X9OMTVix5Kt
	UBgWxfV9b94agjOOoq1zA/wDqyISZnpahkwz/GgL3QKyVXsXZ/bpoZIFF02NPfmaI4djZV
	ycAbdj9PHkhyuYmfO3hPvyZ64CqvYtM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-214-Y3oRGPigMfiXyrobzl9O-g-1; Thu, 23 Jan 2025 14:41:15 -0500
X-MC-Unique: Y3oRGPigMfiXyrobzl9O-g-1
X-Mimecast-MFC-AGG-ID: Y3oRGPigMfiXyrobzl9O-g
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4362153dcd6so6511605e9.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jan 2025 11:41:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737661274; x=1738266074;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cNJzcboFi8tAjHl3U9gH4h1OKVqCPBFW2xXRLutD69U=;
        b=uxQE7MoK8nccLMBxct1mE74m0omN0BraVO4SUsl7b0nGI2e2GZL6Vr7ck/KbpHkyoU
         bM6sFWOJ6WV0pMByiyNuLHFMTtm9bmUcN7mQI/nwbokJgiNlrmJTWzUc52lqX5fwyNkg
         g7t/DkanE30P1zcm6a11NDJK4XvMQ6S/tiuv8IqCyZklAy1T2yJanetuNuIY7T9/6Hqr
         CjRgtrcw6JO7VvVs3auHT75WPdA9o/GZlyCt4NxrueHaB4YG6+S3wx4Z8ECSH3qUOaOY
         seBlsz10OzTaENtm0+FWBQ4HWjF9GyW7rst93G3JE5S86rhDqLZg8CvKf1C66GTXkL5d
         ZcOQ==
X-Gm-Message-State: AOJu0Yy4yecS2A17byfVwJSCRxpGbq43NNx9opP6f19QPwBOIoCERpSz
	ENMlEmLwRDgOOhA7vPtptQPyn+MD2JGwnfisWJtUBOKGedy2d2sRTOvH05gvD47/lRV1tQY0kw8
	aj056+V1euduXGcTqJ0K8NOXf8NWCcGiB3brSQxbUwRgUs2Qm7SvZP9A2gtlpZbhJWAd7vZjWOu
	2wPWLtSWyXbPebqMidYhueBGYT8pZiJIfnrAHhKF2uxk7hXtUa/A==
X-Gm-Gg: ASbGnctTFf7AEr8UAb0EO1dj2QU2COIDDtTvaHwX2U7cS2Vg9N3YIfPcLTyG6BB/VxE
	5CwwExs8/bDglHm9nVfDmY3/35CBQKOp9N4qAW7vWlHF4meTPbfb1cim9993tD0kjnqr/Lk3nhA
	uisyEPXM/hf9kLG5yTctXtg0apasKbjDRcmrBUhZCdko2cVGJaOGWoZVVu1ScdwLc/X9gxC4/UH
	B3CyFXco18ousAYnXIr+ofrBVl4n1rw5y/TnjVX4MtSAafEqH2CD3L3fmJ+RRVqj9neXKpT4G6Y
	tlpanmx+ZGMJ7LhEaiCFnAXtDbU2/rLteWI0kuP3ZfNiXA==
X-Received: by 2002:a05:600c:5486:b0:436:51bb:7a52 with SMTP id 5b1f17b1804b1-438913c9c93mr260605335e9.7.1737661273924;
        Thu, 23 Jan 2025 11:41:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHLdoXm1SKIaw9/8givwSMtRJtQqPs51AUr5H2G/tZgOfq7K/GN6CRsG5PLb0gQxamJ8cbVjg==
X-Received: by 2002:a05:600c:5486:b0:436:51bb:7a52 with SMTP id 5b1f17b1804b1-438913c9c93mr260605015e9.7.1737661273452;
        Thu, 23 Jan 2025 11:41:13 -0800 (PST)
Received: from maszat.piliscsaba.szeredi.hu (91-82-183-41.pool.digikabel.hu. [91.82.183.41])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438bd507e46sm1687245e9.21.2025.01.23.11.41.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 11:41:12 -0800 (PST)
From: Miklos Szeredi <mszeredi@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Amir Goldstein <amir73il@gmail.com>,
	Karel Zak <kzak@redhat.com>,
	Lennart Poettering <lennart@poettering.net>,
	Ian Kent <raven@themaw.net>,
	Al Viro <viro@zeniv.linux.org.uk>,
	linux-security-module@vger.kernel.org,
	Paul Moore <paul@paul-moore.com>
Subject: [PATCH v4 2/4] fanotify: notify on mount attach and detach
Date: Thu, 23 Jan 2025 20:41:05 +0100
Message-ID: <20250123194108.1025273-3-mszeredi@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250123194108.1025273-1-mszeredi@redhat.com>
References: <20250123194108.1025273-1-mszeredi@redhat.com>
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
 fs/notify/fanotify/fanotify_user.c | 86 +++++++++++++++++++++++++-----
 fs/notify/fdinfo.c                 |  5 ++
 include/linux/fanotify.h           | 12 +++--
 include/uapi/linux/fanotify.h      | 10 ++++
 security/selinux/hooks.c           |  4 ++
 9 files changed, 166 insertions(+), 23 deletions(-)

diff --git a/fs/mount.h b/fs/mount.h
index 33311ad81042..9689e7bf4501 100644
--- a/fs/mount.h
+++ b/fs/mount.h
@@ -174,3 +174,5 @@ static inline struct mnt_namespace *to_mnt_ns(struct ns_common *ns)
 {
 	return container_of(ns, struct mnt_namespace, ns);
 }
+
+struct mnt_namespace *mnt_ns_from_dentry(struct dentry *dentry);
diff --git a/fs/namespace.c b/fs/namespace.c
index eac057e56948..4d9072fd1263 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2101,16 +2101,24 @@ struct mnt_namespace *__lookup_next_mnt_ns(struct mnt_namespace *mntns, bool pre
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
index 24c7c5df4998..b1937f92f105 100644
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
@@ -303,7 +305,10 @@ static u32 fanotify_group_event_mask(struct fsnotify_group *group,
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
@@ -548,6 +553,20 @@ static struct fanotify_event *fanotify_alloc_path_event(const struct path *path,
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
 static struct fanotify_event *fanotify_alloc_perm_event(const struct path *path,
 							gfp_t gfp)
 {
@@ -715,6 +734,7 @@ static struct fanotify_event *fanotify_alloc_event(
 					      fid_mode);
 	struct inode *dirid = fanotify_dfid_inode(mask, data, data_type, dir);
 	const struct path *path = fsnotify_data_path(data, data_type);
+	u64 mnt_id = fsnotify_data_mnt_id(data, data_type);
 	struct mem_cgroup *old_memcg;
 	struct dentry *moved = NULL;
 	struct inode *child = NULL;
@@ -810,8 +830,12 @@ static struct fanotify_event *fanotify_alloc_event(
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
@@ -910,7 +934,7 @@ static int fanotify_handle_event(struct fsnotify_group *group, u32 mask,
 	BUILD_BUG_ON(FAN_FS_ERROR != FS_ERROR);
 	BUILD_BUG_ON(FAN_RENAME != FS_RENAME);
 
-	BUILD_BUG_ON(HWEIGHT32(ALL_FANOTIFY_EVENT_BITS) != 21);
+	BUILD_BUG_ON(HWEIGHT32(ALL_FANOTIFY_EVENT_BITS) != 23);
 
 	mask = fanotify_group_event_mask(group, iter_info, &match_mask,
 					 mask, data, data_type, dir);
@@ -1011,6 +1035,11 @@ static void fanotify_free_error_event(struct fsnotify_group *group,
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
@@ -1037,6 +1066,9 @@ static void fanotify_free_event(struct fsnotify_group *group,
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
index e5ab33cae6a7..f1a7cbedc9e3 100644
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
@@ -456,6 +469,11 @@ static inline bool fanotify_is_error_event(u32 mask)
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
index 2d85c71717d6..da97eb01e2fa 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -114,6 +114,7 @@ struct kmem_cache *fanotify_mark_cache __ro_after_init;
 struct kmem_cache *fanotify_fid_event_cachep __ro_after_init;
 struct kmem_cache *fanotify_path_event_cachep __ro_after_init;
 struct kmem_cache *fanotify_perm_event_cachep __ro_after_init;
+struct kmem_cache *fanotify_mnt_event_cachep __ro_after_init;
 
 #define FANOTIFY_EVENT_ALIGN 4
 #define FANOTIFY_FID_INFO_HDR_LEN \
@@ -122,6 +123,8 @@ struct kmem_cache *fanotify_perm_event_cachep __ro_after_init;
 	sizeof(struct fanotify_event_info_pidfd)
 #define FANOTIFY_ERROR_INFO_LEN \
 	(sizeof(struct fanotify_event_info_error))
+#define FANOTIFY_MNT_INFO_LEN \
+	(sizeof(struct fanotify_event_info_mnt))
 
 static int fanotify_fid_info_len(int fh_len, int name_len)
 {
@@ -183,6 +186,8 @@ static size_t fanotify_event_len(unsigned int info_mode,
 		fh_len = fanotify_event_object_fh_len(event);
 		event_len += fanotify_fid_info_len(fh_len, dot_len);
 	}
+	if (fanotify_is_mnt_event(event->mask))
+		event_len += FANOTIFY_MNT_INFO_LEN;
 
 	return event_len;
 }
@@ -380,6 +385,25 @@ static int process_access_response(struct fsnotify_group *group,
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
@@ -642,6 +666,14 @@ static int copy_info_records_to_user(struct fanotify_event *event,
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
 	return total_bytes;
 }
 
@@ -1446,6 +1478,14 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flags, unsigned int, event_f_flags)
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
 
@@ -1685,7 +1725,6 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
 			    int dfd, const char  __user *pathname)
 {
 	struct inode *inode = NULL;
-	struct vfsmount *mnt = NULL;
 	struct fsnotify_group *group;
 	struct path path;
 	struct fan_fsid __fsid, *fsid = NULL;
@@ -1718,6 +1757,9 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
 	case FAN_MARK_FILESYSTEM:
 		obj_type = FSNOTIFY_OBJ_TYPE_SB;
 		break;
+	case FAN_MARK_MNTNS:
+		obj_type = FSNOTIFY_OBJ_TYPE_MNTNS;
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -1765,6 +1807,19 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
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
@@ -1802,7 +1857,7 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
 	 * point.
 	 */
 	fid_mode = FAN_GROUP_FLAG(group, FANOTIFY_FID_BITS);
-	if (mask & ~(FANOTIFY_FD_EVENTS|FANOTIFY_EVENT_FLAGS) &&
+	if (mask & ~(FANOTIFY_FD_EVENTS|FANOTIFY_MOUNT_EVENTS|FANOTIFY_EVENT_FLAGS) &&
 	    (!fid_mode || mark_type == FAN_MARK_MOUNT))
 		return -EINVAL;
 
@@ -1848,17 +1903,21 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
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
@@ -1866,10 +1925,10 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
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
@@ -1878,7 +1937,7 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
 	}
 
 	/* Mask out FAN_EVENT_ON_CHILD flag for sb/mount/non-dir marks */
-	if (mnt || !S_ISDIR(inode->i_mode)) {
+	if (!inode || !S_ISDIR(inode->i_mode)) {
 		mask &= ~FAN_EVENT_ON_CHILD;
 		umask = FAN_EVENT_ON_CHILD;
 		/*
@@ -1952,7 +2011,7 @@ static int __init fanotify_user_setup(void)
 				     FANOTIFY_DEFAULT_MAX_USER_MARKS);
 
 	BUILD_BUG_ON(FANOTIFY_INIT_FLAGS & FANOTIFY_INTERNAL_GROUP_FLAGS);
-	BUILD_BUG_ON(HWEIGHT32(FANOTIFY_INIT_FLAGS) != 13);
+	BUILD_BUG_ON(HWEIGHT32(FANOTIFY_INIT_FLAGS) != 14);
 	BUILD_BUG_ON(HWEIGHT32(FANOTIFY_MARK_FLAGS) != 11);
 
 	fanotify_mark_cache = KMEM_CACHE(fanotify_mark,
@@ -1965,6 +2024,7 @@ static int __init fanotify_user_setup(void)
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
index 89ff45bd6f01..fc142be2542d 100644
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
@@ -99,10 +100,13 @@
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
 
 /* Events that require a permission response from user */
 #define FANOTIFY_PERM_EVENTS	(FAN_OPEN_PERM | FAN_ACCESS_PERM | \
diff --git a/include/uapi/linux/fanotify.h b/include/uapi/linux/fanotify.h
index 34f221d3a1b9..69340e483ae7 100644
--- a/include/uapi/linux/fanotify.h
+++ b/include/uapi/linux/fanotify.h
@@ -25,6 +25,8 @@
 #define FAN_OPEN_PERM		0x00010000	/* File open in perm check */
 #define FAN_ACCESS_PERM		0x00020000	/* File accessed in perm check */
 #define FAN_OPEN_EXEC_PERM	0x00040000	/* File open/exec in perm check */
+#define FAN_MNT_ATTACH		0x01000000	/* Mount was attached */
+#define FAN_MNT_DETACH		0x02000000	/* Mount was detached */
 
 #define FAN_EVENT_ON_CHILD	0x08000000	/* Interested in child events */
 
@@ -61,6 +63,7 @@
 #define FAN_REPORT_NAME		0x00000800	/* Report events with name */
 #define FAN_REPORT_TARGET_FID	0x00001000	/* Report dirent target id  */
 #define FAN_REPORT_FD_ERROR	0x00002000	/* event->fd can report error */
+#define FAN_REPORT_MNT		0x00004000	/* Report mount events */
 
 /* Convenience macro - FAN_REPORT_NAME requires FAN_REPORT_DIR_FID */
 #define FAN_REPORT_DFID_NAME	(FAN_REPORT_DIR_FID | FAN_REPORT_NAME)
@@ -91,6 +94,7 @@
 #define FAN_MARK_INODE		0x00000000
 #define FAN_MARK_MOUNT		0x00000010
 #define FAN_MARK_FILESYSTEM	0x00000100
+#define FAN_MARK_MNTNS		0x00000110
 
 /*
  * Convenience macro - FAN_MARK_IGNORE requires FAN_MARK_IGNORED_SURV_MODIFY
@@ -143,6 +147,7 @@ struct fanotify_event_metadata {
 #define FAN_EVENT_INFO_TYPE_DFID	3
 #define FAN_EVENT_INFO_TYPE_PIDFD	4
 #define FAN_EVENT_INFO_TYPE_ERROR	5
+#define FAN_EVENT_INFO_TYPE_MNT		6
 
 /* Special info types for FAN_RENAME */
 #define FAN_EVENT_INFO_TYPE_OLD_DFID_NAME	10
@@ -189,6 +194,11 @@ struct fanotify_event_info_error {
 	__u32 error_count;
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
index 171dd7fceac5..d2b3e60e2be9 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -3395,6 +3395,10 @@ static int selinux_path_notify(const struct path *path, u64 mask,
 	case FSNOTIFY_OBJ_TYPE_INODE:
 		perm = FILE__WATCH;
 		break;
+	case FSNOTIFY_OBJ_TYPE_MNTNS:
+		/* FIXME: Is this correct??? */
+		perm = FILE__WATCH;
+		break;
 	default:
 		return -EINVAL;
 	}
-- 
2.47.1


