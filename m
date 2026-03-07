Return-Path: <linux-fsdevel+bounces-79688-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2IA9FJ0GrGkxjAEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79688-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sat, 07 Mar 2026 12:06:05 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 554BD22B587
	for <lists+linux-fsdevel@lfdr.de>; Sat, 07 Mar 2026 12:06:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E53B6301733A
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Mar 2026 11:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27C9C34887E;
	Sat,  7 Mar 2026 11:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IqTUkxck"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38DAC33D6CF
	for <linux-fsdevel@vger.kernel.org>; Sat,  7 Mar 2026 11:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772881557; cv=none; b=gzcKt9gjWjE3s+MVYUHKVj1EfNfNkgKUtPAJs2fr/JBNBpxjLiFOtj1Rw6nbwvvn5ZSfjahsFuZBMeiSHzKpE8grlCgOiMgQppZzyxd5kCKcqe1mr3FB/Q9N3vAKBXAUISPpxRRZPfygFqEZmvZVECu602ePhqz+7A23EHoERbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772881557; c=relaxed/simple;
	bh=kJYbYceYgAU5fN4hZWP+Tp4J2fmFVwfvDA/LoMgVrBM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JWD/LcEIjh4BNTuKJevSgHEb1HhwhLft4SpEyvh9CyJUe329NcsZ07IhTDVJyQm/xcLwY2ZThAkjv92DzCWudPilqmb6HAPsxzflj6y8nuhGcRHom9xPO+33oMQtspHgSJLWEdH4er9+tJLm0sHU3wB6lle/9rzI6pItjb4oLcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IqTUkxck; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b936331786dso1096211766b.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 07 Mar 2026 03:05:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772881553; x=1773486353; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8rzYiL3Bfvs8xCx0TPhHoc3pn1aIOv5vOHa0A+ie2Is=;
        b=IqTUkxck6359/X1TDEcWIxZSSqntyYR4ptKhboZYmTB0KJRumfted/FZko0Ymcuq7t
         I02RtAxeZJ16+ZbxTxKg1fiUFQIO7M+w90YMGTqP4r1uzUCTWkkrPxPQ1tg5AySBMPql
         Yr88+wJz0kz+1ic3+9//RPvab5M6ChrfuRujCO0R0rloStOdfKTxnh0+y55RSdP2HPsE
         ZkIZI5f8Q7lpWxWeImufS2vHisqGRW9EUxUubtkjSdg/oPtI69YpYjv+wja4Zyze+efH
         isOBIbJ2OKN2j6klHrMuuNTsrnbNtb34hihROhD+fQOL8yCatK2uezn91JGNXWFHqIoD
         Plsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772881554; x=1773486354;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8rzYiL3Bfvs8xCx0TPhHoc3pn1aIOv5vOHa0A+ie2Is=;
        b=FOFIWKvycg9DWP+LvhAvSM3QHl2bsM1x+RFcSTNafZGkUZx0mIpEjJb0AWjSp5ztsZ
         46JFJZkdZ2EvcneiEfphzEr+H5AKPQpO3NA6LChqNKMZUa9lAr2Z0W6MFa1+uzAxF2dy
         75+dqpDcYdsb7QXNzTYAsgrmPtZ8ZYitnQ8AlEefZSk/7zqYNaztZVRXV3Cq6LKM6Ikd
         2w80FWKhItz69nFCZZk22raC14ejnmlrKzfCDpvNuFCPSfTAsT8XQ/ko+oGzb+ahJbgV
         a1Apacw4E/GEyQSwd3KxaE3H2J+gN02OmVtlJeVYK85HLOhWYB88Y92EROalOwfjRGrS
         u7ag==
X-Forwarded-Encrypted: i=1; AJvYcCU9mSle1IMvlOtFFus7qK8kwUG0er16fSvomOgFWBfCMF5TbH/5n1c7iPwT6Trl7Attsn39S/UXnbevt9gH@vger.kernel.org
X-Gm-Message-State: AOJu0YwpFaXib2Pst09FD5tj4uaGyvPRPXzl5bmOVZPuSYV08xDCdgZl
	aLXXs0+F9tsFdvdqaRIpXrchB4Z5FzO9pw8HyD8BfvvHXyHP6pVKi7uxcx1GEaCG
X-Gm-Gg: ATEYQzzmawIJFR56Iym9ap0FxFHPwapS57koKLLwED5HwnaNby6Ce1FWASxKs2Dag+A
	ie+zTGLMktFUZnGCTJHEQmP3I5JMn4MzdEqo+t2WwEdOh5bFuJx8pekcbb0Gc+2TlrqfIwF94Ex
	v8Aj9c9EEZLuE5+oADyTxbkW1W7Tqoc/KPvpK8VF9Lz2UXpej0YZW0D4mdqioRH6LZwfxUZgNn4
	n9BAhBpLUWKHr/H0i4hm28OOjaE+ivUgjpNrCJpZxOeyPShlLi67QmmSliOtkW1UW5Cp2pjWJOK
	C7ZMImEpQLaRH3621vWZglBwwNq3cYAsbk8H4vngTW5oGNHsos4G3dKySEYYdldPwsYfcsqqdgR
	IDoImuizLLdn5so/47yuSBPiHhD9nPRiqD8iJMoHoetUvBegDau/RvMyzy2qkPadX/9wJfUWmTr
	9xFX7jwf0KCsaW9ebO8fSQG/9gSnvIUTLbMyBF1zvYWjg7tkchk/lKtZRc2gR0B4zix10yQXuaG
	BUisQrX2lSLw2ZaKez6zKWMAYUu
X-Received: by 2002:a17:906:6a06:b0:b8f:d13:def5 with SMTP id a640c23a62f3a-b942dbcd2b4mr257303966b.9.1772881553234;
        Sat, 07 Mar 2026 03:05:53 -0800 (PST)
Received: from localhost (2001-1c00-570d-ee00-7ad4-b88c-4d95-6756.cable.dynamic.v6.ziggo.nl. [2001:1c00:570d:ee00:7ad4:b88c:4d95:6756])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b942ef8c61bsm133607266b.25.2026.03.07.03.05.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Mar 2026 03:05:52 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>,
	Lennart Poettering <lennart@poettering.net>,
	Tejun Heo <tj@kernel.org>,
	"T . J . Mercier" <tjmercier@google.com>,
	linux-fsdevel@vger.kernel.org
Subject: [RFC][PATCH 1/5] fanotify: add support for watching the namespaces tree
Date: Sat,  7 Mar 2026 12:05:46 +0100
Message-ID: <20260307110550.373762-2-amir73il@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260307110550.373762-1-amir73il@gmail.com>
References: <20260307110550.373762-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 554BD22B587
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-79688-lists,linux-fsdevel=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[amir73il@gmail.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	NEURAL_HAM(-0.00)[-0.995];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

Introduce FAN_MARK_USERNS type to mark a user namespace object
from nsfs path.

Support two events FAN_CREATE and FAN_DELETE to report creation
and tear down of namespaces owned by the marked userns.

Introduce FAN_REPORT_NSID to report the self and owner nsid of
the created or torn down namespace.

At this time, an fanotify group initialized with flags
FAN_REPORT_MNT|FAN_REPORT_NSID, may add marks on both userns
and mntns objects to mix mount and namespace events, but the same
group cannot also request filesystem events with file handles
(e.g. FAN_REPORT_FID).

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/notify/fanotify/fanotify.c      | 32 ++++++++++++++
 fs/notify/fanotify/fanotify.h      | 19 ++++++++
 fs/notify/fanotify/fanotify_user.c | 71 +++++++++++++++++++++++++-----
 fs/notify/fdinfo.c                 |  9 +++-
 fs/notify/fsnotify.c               | 28 +++++++++++-
 fs/notify/fsnotify.h               |  7 +++
 fs/notify/mark.c                   |  7 +++
 fs/nsfs.c                          | 21 +++++++++
 include/linux/fanotify.h           | 14 ++++--
 include/linux/fsnotify_backend.h   | 22 +++++++++
 include/linux/proc_fs.h            |  2 +
 include/linux/user_namespace.h     |  6 +++
 include/uapi/linux/fanotify.h      |  9 ++++
 kernel/nscommon.c                  | 46 +++++++++++++++++++
 14 files changed, 276 insertions(+), 17 deletions(-)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index bfe884d624e7b..3818b4d53dcad 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -168,6 +168,8 @@ static bool fanotify_should_merge(struct fanotify_event *old,
 						  FANOTIFY_EE(new));
 	case FANOTIFY_EVENT_TYPE_MNT:
 		return false;
+	case FANOTIFY_EVENT_TYPE_NS:
+		return false;
 	default:
 		WARN_ON_ONCE(1);
 	}
@@ -317,6 +319,9 @@ static u32 fanotify_group_event_mask(struct fsnotify_group *group,
 	if (FAN_GROUP_FLAG(group, FAN_REPORT_MNT)) {
 		if (data_type != FSNOTIFY_EVENT_MNT)
 			return 0;
+	} else if (FAN_GROUP_FLAG(group, FAN_REPORT_NSID)) {
+		if (data_type != FSNOTIFY_EVENT_NS)
+			return 0;
 	} else if (!fid_mode) {
 		/* Do we have path to open a file descriptor? */
 		if (!path)
@@ -582,6 +587,22 @@ static struct fanotify_event *fanotify_alloc_mnt_event(u64 mnt_id, gfp_t gfp)
 	return &pevent->fae;
 }
 
+static struct fanotify_event *fanotify_alloc_ns_event(const struct fsnotify_ns *ns_data,
+						      gfp_t gfp)
+{
+	struct fanotify_ns_event *pevent;
+
+	pevent = kmem_cache_alloc(fanotify_ns_event_cachep, gfp);
+	if (!pevent)
+		return NULL;
+
+	pevent->fae.type = FANOTIFY_EVENT_TYPE_NS;
+	pevent->self_nsid = ns_data->self_nsid;
+	pevent->owner_nsid = ns_data->owner_nsid;
+
+	return &pevent->fae;
+}
+
 static struct fanotify_event *fanotify_alloc_perm_event(const void *data,
 							int data_type,
 							gfp_t gfp)
@@ -755,6 +776,7 @@ static struct fanotify_event *fanotify_alloc_event(
 	struct inode *id = fanotify_fid_inode(mask, data, data_type, dir,
 					      fid_mode);
 	struct inode *dirid = fanotify_dfid_inode(mask, data, data_type, dir);
+	const struct fsnotify_ns *ns_data = fsnotify_data_ns(data, data_type);
 	const struct path *path = fsnotify_data_path(data, data_type);
 	u64 mnt_id = fsnotify_data_mnt_id(data, data_type);
 	struct mem_cgroup *old_memcg;
@@ -856,6 +878,8 @@ static struct fanotify_event *fanotify_alloc_event(
 		event = fanotify_alloc_path_event(path, &hash, gfp);
 	} else if (mnt_id) {
 		event = fanotify_alloc_mnt_event(mnt_id, gfp);
+	} else if (ns_data) {
+		event = fanotify_alloc_ns_event(ns_data, gfp);
 	} else {
 		WARN_ON_ONCE(1);
 	}
@@ -1064,6 +1088,11 @@ static void fanotify_free_mnt_event(struct fanotify_event *event)
 	kmem_cache_free(fanotify_mnt_event_cachep, FANOTIFY_ME(event));
 }
 
+static void fanotify_free_ns_event(struct fanotify_event *event)
+{
+	kmem_cache_free(fanotify_ns_event_cachep, FANOTIFY_NSE(event));
+}
+
 static void fanotify_free_event(struct fsnotify_group *group,
 				struct fsnotify_event *fsn_event)
 {
@@ -1093,6 +1122,9 @@ static void fanotify_free_event(struct fsnotify_group *group,
 	case FANOTIFY_EVENT_TYPE_MNT:
 		fanotify_free_mnt_event(event);
 		break;
+	case FANOTIFY_EVENT_TYPE_NS:
+		fanotify_free_ns_event(event);
+		break;
 	default:
 		WARN_ON_ONCE(1);
 	}
diff --git a/fs/notify/fanotify/fanotify.h b/fs/notify/fanotify/fanotify.h
index 39e60218df7ce..2eaac302ccac0 100644
--- a/fs/notify/fanotify/fanotify.h
+++ b/fs/notify/fanotify/fanotify.h
@@ -10,6 +10,7 @@ extern struct kmem_cache *fanotify_fid_event_cachep;
 extern struct kmem_cache *fanotify_path_event_cachep;
 extern struct kmem_cache *fanotify_perm_event_cachep;
 extern struct kmem_cache *fanotify_mnt_event_cachep;
+extern struct kmem_cache *fanotify_ns_event_cachep;
 
 /* Possible states of the permission event */
 enum {
@@ -245,6 +246,7 @@ enum fanotify_event_type {
 	FANOTIFY_EVENT_TYPE_OVERFLOW, /* struct fanotify_event */
 	FANOTIFY_EVENT_TYPE_FS_ERROR, /* struct fanotify_error_event */
 	FANOTIFY_EVENT_TYPE_MNT,
+	FANOTIFY_EVENT_TYPE_NS,
 	__FANOTIFY_EVENT_TYPE_NUM
 };
 
@@ -415,6 +417,12 @@ struct fanotify_mnt_event {
 	u64 mnt_id;
 };
 
+struct fanotify_ns_event {
+	struct fanotify_event fae;
+	u64 self_nsid;
+	u64 owner_nsid;
+};
+
 static inline struct fanotify_path_event *
 FANOTIFY_PE(struct fanotify_event *event)
 {
@@ -427,6 +435,12 @@ FANOTIFY_ME(struct fanotify_event *event)
 	return container_of(event, struct fanotify_mnt_event, fae);
 }
 
+static inline struct fanotify_ns_event *
+FANOTIFY_NSE(struct fanotify_event *event)
+{
+	return container_of(event, struct fanotify_ns_event, fae);
+}
+
 /*
  * Structure for permission fanotify events. It gets allocated and freed in
  * fanotify_handle_event() since we wait there for user response. When the
@@ -485,6 +499,11 @@ static inline bool fanotify_is_mnt_event(u32 mask)
 	return mask & (FAN_MNT_ATTACH | FAN_MNT_DETACH);
 }
 
+static inline bool fanotify_is_ns_event(const struct fanotify_event *event)
+{
+	return event->type == FANOTIFY_EVENT_TYPE_NS;
+}
+
 static inline const struct path *fanotify_event_path(struct fanotify_event *event)
 {
 	if (event->type == FANOTIFY_EVENT_TYPE_PATH)
diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index ae904451dfc09..126069101669a 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -19,6 +19,7 @@
 #include <linux/memcontrol.h>
 #include <linux/statfs.h>
 #include <linux/exportfs.h>
+#include <linux/proc_fs.h>
 
 #include <asm/ioctls.h>
 
@@ -208,6 +209,7 @@ struct kmem_cache *fanotify_fid_event_cachep __ro_after_init;
 struct kmem_cache *fanotify_path_event_cachep __ro_after_init;
 struct kmem_cache *fanotify_perm_event_cachep __ro_after_init;
 struct kmem_cache *fanotify_mnt_event_cachep __ro_after_init;
+struct kmem_cache *fanotify_ns_event_cachep __ro_after_init;
 
 #define FANOTIFY_EVENT_ALIGN 4
 #define FANOTIFY_FID_INFO_HDR_LEN \
@@ -220,6 +222,8 @@ struct kmem_cache *fanotify_mnt_event_cachep __ro_after_init;
 	(sizeof(struct fanotify_event_info_range))
 #define FANOTIFY_MNT_INFO_LEN \
 	(sizeof(struct fanotify_event_info_mnt))
+#define FANOTIFY_NS_INFO_LEN \
+	(sizeof(struct fanotify_event_info_ns))
 
 static int fanotify_fid_info_len(int fh_len, int name_len)
 {
@@ -277,6 +281,8 @@ static size_t fanotify_event_len(unsigned int info_mode,
 	}
 	if (fanotify_is_mnt_event(event->mask))
 		event_len += FANOTIFY_MNT_INFO_LEN;
+	if (fanotify_is_ns_event(event))
+		event_len += FANOTIFY_NS_INFO_LEN;
 
 	if (info_mode & FAN_REPORT_PIDFD)
 		event_len += FANOTIFY_PIDFD_INFO_LEN;
@@ -523,6 +529,26 @@ static size_t copy_mnt_info_to_user(struct fanotify_event *event,
 	return info.hdr.len;
 }
 
+static size_t copy_ns_info_to_user(struct fanotify_event *event,
+				   char __user *buf, int count)
+{
+	struct fanotify_event_info_ns info = { };
+
+	info.hdr.info_type = FAN_EVENT_INFO_TYPE_NS;
+	info.hdr.len = sizeof(info);
+
+	if (WARN_ON(count < info.hdr.len))
+		return -EFAULT;
+
+	info.self_nsid  = FANOTIFY_NSE(event)->self_nsid;
+	info.owner_nsid = FANOTIFY_NSE(event)->owner_nsid;
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
@@ -827,6 +853,15 @@ static int copy_info_records_to_user(struct fanotify_event *event,
 		total_bytes += ret;
 	}
 
+	if (fanotify_is_ns_event(event)) {
+		ret = copy_ns_info_to_user(event, buf, count);
+		if (ret < 0)
+			return ret;
+		buf += ret;
+		count -= ret;
+		total_bytes += ret;
+	}
+
 	return total_bytes;
 }
 
@@ -1604,11 +1639,11 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flags, unsigned int, event_f_flags)
 	/*
 	 * An unprivileged user can setup an fanotify group with limited
 	 * functionality - an unprivileged group is limited to notification
-	 * events with file handles or mount ids and it cannot use unlimited
+	 * events with file handles or mount/ns ids and it cannot use unlimited
 	 * queue/marks.
 	 */
 	if (((flags & FANOTIFY_ADMIN_INIT_FLAGS) ||
-	     !(flags & (FANOTIFY_FID_BITS | FAN_REPORT_MNT))) &&
+	     !(flags & (FANOTIFY_FID_BITS | FAN_REPORT_MNT | FAN_REPORT_NSID))) &&
 	    !capable(CAP_SYS_ADMIN))
 		return -EPERM;
 
@@ -1636,8 +1671,8 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flags, unsigned int, event_f_flags)
 	if ((flags & FAN_REPORT_PIDFD) && (flags & FAN_REPORT_TID))
 		return -EINVAL;
 
-	/* Don't allow mixing mnt events with inode events for now */
-	if (flags & FAN_REPORT_MNT) {
+	/* Don't allow mixing mnt/ns events with inode events for now */
+	if (flags & (FAN_REPORT_MNT | FAN_REPORT_NSID)) {
 		if (class != FAN_CLASS_NOTIF)
 			return -EINVAL;
 		if (flags & (FANOTIFY_FID_BITS | FAN_REPORT_FD_ERROR))
@@ -1913,6 +1948,9 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
 	case FAN_MARK_MNTNS:
 		obj_type = FSNOTIFY_OBJ_TYPE_MNTNS;
 		break;
+	case FAN_MARK_USERNS:
+		obj_type = FSNOTIFY_OBJ_TYPE_USERNS;
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -1960,16 +1998,22 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
 		return -EINVAL;
 	group = fd_file(f)->private_data;
 
-	/* Only report mount events on mnt namespace */
-	if (FAN_GROUP_FLAG(group, FAN_REPORT_MNT)) {
+	/* Only report mount events on mnt namespace mark */
+	if (mark_type == FAN_MARK_MNTNS) {
 		if (mask & ~FANOTIFY_MOUNT_EVENTS)
 			return -EINVAL;
-		if (mark_type != FAN_MARK_MNTNS)
+		if (!FAN_GROUP_FLAG(group, FAN_REPORT_MNT))
 			return -EINVAL;
 	} else {
 		if (mask & FANOTIFY_MOUNT_EVENTS)
 			return -EINVAL;
-		if (mark_type == FAN_MARK_MNTNS)
+	}
+
+	/* Only report namespace events on user namespace mark */
+	if (mark_type == FAN_MARK_USERNS) {
+		if (mask & ~FANOTIFY_NS_EVENTS)
+			return -EINVAL;
+		if (!FAN_GROUP_FLAG(group, FAN_REPORT_NSID))
 			return -EINVAL;
 	}
 
@@ -2087,6 +2131,12 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
 			goto path_put_and_out;
 		user_ns = mntns->user_ns;
 		obj = mntns;
+	} else if (obj_type == FSNOTIFY_OBJ_TYPE_USERNS) {
+		ret = -EINVAL;
+		user_ns = userns_from_dentry(path.dentry);
+		if (!user_ns)
+			goto path_put_and_out;
+		obj = user_ns;
 	}
 
 	ret = -EPERM;
@@ -2190,8 +2240,8 @@ static int __init fanotify_user_setup(void)
 				     FANOTIFY_DEFAULT_MAX_USER_MARKS);
 
 	BUILD_BUG_ON(FANOTIFY_INIT_FLAGS & FANOTIFY_INTERNAL_GROUP_FLAGS);
-	BUILD_BUG_ON(HWEIGHT32(FANOTIFY_INIT_FLAGS) != 14);
-	BUILD_BUG_ON(HWEIGHT32(FANOTIFY_MARK_FLAGS) != 11);
+	BUILD_BUG_ON(HWEIGHT32(FANOTIFY_INIT_FLAGS) != 15);
+	BUILD_BUG_ON(HWEIGHT32(FANOTIFY_MARK_FLAGS) != 12);
 
 	fanotify_mark_cache = KMEM_CACHE(fanotify_mark,
 					 SLAB_PANIC|SLAB_ACCOUNT);
@@ -2204,6 +2254,7 @@ static int __init fanotify_user_setup(void)
 			KMEM_CACHE(fanotify_perm_event, SLAB_PANIC);
 	}
 	fanotify_mnt_event_cachep = KMEM_CACHE(fanotify_mnt_event, SLAB_PANIC);
+	fanotify_ns_event_cachep = KMEM_CACHE(fanotify_ns_event, SLAB_PANIC);
 
 	fanotify_max_queued_events = FANOTIFY_DEFAULT_MAX_EVENTS;
 	init_user_ns.ucount_max[UCOUNT_FANOTIFY_GROUPS] =
diff --git a/fs/notify/fdinfo.c b/fs/notify/fdinfo.c
index 9cc7eb8636437..946cffaf16e18 100644
--- a/fs/notify/fdinfo.c
+++ b/fs/notify/fdinfo.c
@@ -130,8 +130,13 @@ static void fanotify_fdinfo(struct seq_file *m, struct fsnotify_mark *mark)
 	} else if (mark->connector->type == FSNOTIFY_OBJ_TYPE_MNTNS) {
 		struct mnt_namespace *mnt_ns = fsnotify_conn_mntns(mark->connector);
 
-		seq_printf(m, "fanotify mnt_ns:%u mflags:%x mask:%x ignored_mask:%x\n",
-			   mnt_ns->ns.inum, mflags, mark->mask, mark->ignore_mask);
+		seq_printf(m, "fanotify mnt_ns_id:%llu mflags:%x mask:%x ignored_mask:%x\n",
+			   mnt_ns->ns.ns_id, mflags, mark->mask, mark->ignore_mask);
+	} else if (mark->connector->type == FSNOTIFY_OBJ_TYPE_USERNS) {
+		struct user_namespace *userns = fsnotify_conn_userns(mark->connector);
+
+		seq_printf(m, "fanotify user_ns_id:%llu mflags:%x mask:%x ignored_mask:%x\n",
+			   userns->ns.ns_id, mflags, mark->mask, mark->ignore_mask);
 	}
 }
 
diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
index 9995de1710e59..638136c0d6cb9 100644
--- a/fs/notify/fsnotify.c
+++ b/fs/notify/fsnotify.c
@@ -495,6 +495,7 @@ int fsnotify(__u32 mask, const void *data, int data_type, struct inode *dir,
 	const struct path *path = fsnotify_data_path(data, data_type);
 	struct super_block *sb = fsnotify_data_sb(data, data_type);
 	const struct fsnotify_mnt *mnt_data = fsnotify_data_mnt(data, data_type);
+	const struct fsnotify_ns *ns_data = fsnotify_data_ns(data, data_type);
 	struct fsnotify_sb_info *sbinfo = sb ? fsnotify_sb_info(sb) : NULL;
 	struct fsnotify_iter_info iter_info = {};
 	struct mount *mnt = NULL;
@@ -536,7 +537,8 @@ int fsnotify(__u32 mask, const void *data, int data_type, struct inode *dir,
 	    (!mnt || !mnt->mnt_fsnotify_marks) &&
 	    (!inode || !inode->i_fsnotify_marks) &&
 	    (!inode2 || !inode2->i_fsnotify_marks) &&
-	    (!mnt_data || !mnt_data->ns->n_fsnotify_marks))
+	    (!mnt_data || !mnt_data->ns->n_fsnotify_marks) &&
+	    (!ns_data || !ns_data->userns->n_fsnotify_marks))
 		return 0;
 
 	if (sb)
@@ -549,6 +551,8 @@ int fsnotify(__u32 mask, const void *data, int data_type, struct inode *dir,
 		marks_mask |= READ_ONCE(inode2->i_fsnotify_mask);
 	if (mnt_data)
 		marks_mask |= READ_ONCE(mnt_data->ns->n_fsnotify_mask);
+	if (ns_data)
+		marks_mask |= READ_ONCE(ns_data->userns->n_fsnotify_mask);
 
 	/*
 	 * If this is a modify event we may need to clear some ignore masks.
@@ -582,6 +586,10 @@ int fsnotify(__u32 mask, const void *data, int data_type, struct inode *dir,
 		iter_info.marks[FSNOTIFY_ITER_TYPE_MNTNS] =
 			fsnotify_first_mark(&mnt_data->ns->n_fsnotify_marks);
 	}
+	if (ns_data) {
+		iter_info.marks[FSNOTIFY_ITER_TYPE_USERNS] =
+			fsnotify_first_mark(&ns_data->userns->n_fsnotify_marks);
+	}
 
 	/*
 	 * We need to merge inode/vfsmount/sb mark lists so that e.g. inode mark
@@ -711,6 +719,24 @@ void fsnotify_mnt(__u32 mask, struct mnt_namespace *ns, struct vfsmount *mnt)
 	fsnotify(mask, &data, FSNOTIFY_EVENT_MNT, NULL, NULL, NULL, 0);
 }
 
+void fsnotify_ns(__u32 mask, struct user_namespace *userns,
+		 u64 self_nsid, u64 owner_nsid)
+{
+	struct fsnotify_ns data = {
+		.userns = userns,
+		.self_nsid = self_nsid,
+		.owner_nsid = owner_nsid,
+	};
+
+	if (WARN_ON_ONCE(!userns))
+		return;
+
+	if (!READ_ONCE(userns->n_fsnotify_marks))
+		return;
+
+	fsnotify(mask, &data, FSNOTIFY_EVENT_NS, NULL, NULL, NULL, 0);
+}
+
 static __init int fsnotify_init(void)
 {
 	int ret;
diff --git a/fs/notify/fsnotify.h b/fs/notify/fsnotify.h
index 58c7bb25e5718..f58c69de7f067 100644
--- a/fs/notify/fsnotify.h
+++ b/fs/notify/fsnotify.h
@@ -6,6 +6,7 @@
 #include <linux/fsnotify.h>
 #include <linux/srcu.h>
 #include <linux/types.h>
+#include <linux/user_namespace.h>
 
 #include "../mount.h"
 
@@ -39,6 +40,12 @@ static inline struct mnt_namespace *fsnotify_conn_mntns(
 	return conn->obj;
 }
 
+static inline struct user_namespace *fsnotify_conn_userns(
+				struct fsnotify_mark_connector *conn)
+{
+	return conn->obj;
+}
+
 static inline struct super_block *fsnotify_object_sb(void *obj,
 			enum fsnotify_obj_type obj_type)
 {
diff --git a/fs/notify/mark.c b/fs/notify/mark.c
index c2ed5b11b0fe6..4086b37637cbe 100644
--- a/fs/notify/mark.c
+++ b/fs/notify/mark.c
@@ -74,6 +74,7 @@
 #include <linux/atomic.h>
 
 #include <linux/fsnotify_backend.h>
+#include <linux/user_namespace.h>
 #include "fsnotify.h"
 
 #define FSNOTIFY_REAPER_DELAY	(1)	/* 1 jiffy */
@@ -110,6 +111,8 @@ static fsnotify_connp_t *fsnotify_object_connp(void *obj,
 		return fsnotify_sb_marks(obj);
 	case FSNOTIFY_OBJ_TYPE_MNTNS:
 		return &((struct mnt_namespace *)obj)->n_fsnotify_marks;
+	case FSNOTIFY_OBJ_TYPE_USERNS:
+		return &((struct user_namespace *)obj)->n_fsnotify_marks;
 	default:
 		return NULL;
 	}
@@ -125,6 +128,8 @@ static __u32 *fsnotify_conn_mask_p(struct fsnotify_mark_connector *conn)
 		return &fsnotify_conn_sb(conn)->s_fsnotify_mask;
 	else if (conn->type == FSNOTIFY_OBJ_TYPE_MNTNS)
 		return &fsnotify_conn_mntns(conn)->n_fsnotify_mask;
+	else if (conn->type == FSNOTIFY_OBJ_TYPE_USERNS)
+		return &fsnotify_conn_userns(conn)->n_fsnotify_mask;
 	return NULL;
 }
 
@@ -356,6 +361,8 @@ static void *fsnotify_detach_connector_from_object(
 		fsnotify_conn_sb(conn)->s_fsnotify_mask = 0;
 	} else if (conn->type == FSNOTIFY_OBJ_TYPE_MNTNS) {
 		fsnotify_conn_mntns(conn)->n_fsnotify_mask = 0;
+	} else if (conn->type == FSNOTIFY_OBJ_TYPE_USERNS) {
+		fsnotify_conn_userns(conn)->n_fsnotify_mask = 0;
 	}
 
 	rcu_assign_pointer(*connp, NULL);
diff --git a/fs/nsfs.c b/fs/nsfs.c
index c215878d55e87..ace17de243f45 100644
--- a/fs/nsfs.c
+++ b/fs/nsfs.c
@@ -387,6 +387,27 @@ bool proc_ns_file(const struct file *file)
 	return file->f_op == &ns_file_operations;
 }
 
+/**
+ * userns_from_dentry() - Return the user_namespace referenced by an nsfs dentry.
+ * @dentry: dentry of an open nsfs file
+ *
+ * Returns the user_namespace if @dentry is an nsfs file for a user namespace,
+ * NULL otherwise.  The caller is responsible for ensuring the returned pointer
+ * remains valid (e.g. by holding a reference to the dentry).
+ */
+struct user_namespace *userns_from_dentry(struct dentry *dentry)
+{
+	struct inode *inode = d_inode(dentry);
+	struct ns_common *ns;
+
+	if (!inode || inode->i_sb->s_magic != NSFS_MAGIC)
+		return NULL;
+	ns = get_proc_ns(inode);
+	if (!ns || ns->ns_type != CLONE_NEWUSER)
+		return NULL;
+	return to_user_ns(ns);
+}
+
 /**
  * ns_match() - Returns true if current namespace matches dev/ino provided.
  * @ns: current namespace
diff --git a/include/linux/fanotify.h b/include/linux/fanotify.h
index 879cff5eccd4e..279082ae40fe2 100644
--- a/include/linux/fanotify.h
+++ b/include/linux/fanotify.h
@@ -25,7 +25,8 @@
 
 #define FANOTIFY_FID_BITS	(FAN_REPORT_DFID_NAME_TARGET)
 
-#define FANOTIFY_INFO_MODES	(FANOTIFY_FID_BITS | FAN_REPORT_PIDFD | FAN_REPORT_MNT)
+#define FANOTIFY_INFO_MODES	(FANOTIFY_FID_BITS | FAN_REPORT_PIDFD | FAN_REPORT_MNT | \
+				 FAN_REPORT_NSID)
 
 /*
  * fanotify_init() flags that require CAP_SYS_ADMIN.
@@ -47,8 +48,9 @@
  * so one of the flags for reporting file handles is required.
  */
 #define FANOTIFY_USER_INIT_FLAGS	(FAN_CLASS_NOTIF | \
-					 FANOTIFY_FID_BITS | FAN_REPORT_MNT | \
-					 FAN_CLOEXEC | FAN_NONBLOCK)
+				 FANOTIFY_FID_BITS | FAN_REPORT_MNT | \
+				 FAN_REPORT_NSID | \
+				 FAN_CLOEXEC | FAN_NONBLOCK)
 
 #define FANOTIFY_INIT_FLAGS	(FANOTIFY_ADMIN_INIT_FLAGS | \
 				 FANOTIFY_USER_INIT_FLAGS)
@@ -58,7 +60,8 @@
 #define FANOTIFY_INTERNAL_GROUP_FLAGS	(FANOTIFY_UNPRIV)
 
 #define FANOTIFY_MARK_TYPE_BITS	(FAN_MARK_INODE | FAN_MARK_MOUNT | \
-				 FAN_MARK_FILESYSTEM | FAN_MARK_MNTNS)
+				 FAN_MARK_FILESYSTEM | FAN_MARK_MNTNS | \
+				 FAN_MARK_USERNS)
 
 #define FANOTIFY_MARK_CMD_BITS	(FAN_MARK_ADD | FAN_MARK_REMOVE | \
 				 FAN_MARK_FLUSH)
@@ -111,6 +114,9 @@
 
 #define FANOTIFY_MOUNT_EVENTS	(FAN_MNT_ATTACH | FAN_MNT_DETACH)
 
+/* Events that can be reported with data type FSNOTIFY_EVENT_NS */
+#define FANOTIFY_NS_EVENTS	(FAN_CREATE | FAN_DELETE)
+
 /* Events that user can request to be notified on */
 #define FANOTIFY_EVENTS		(FANOTIFY_PATH_EVENTS | \
 				 FANOTIFY_INODE_EVENTS | \
diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
index 95985400d3d8e..2145d2f4262db 100644
--- a/include/linux/fsnotify_backend.h
+++ b/include/linux/fsnotify_backend.h
@@ -310,6 +310,7 @@ enum fsnotify_data_type {
 	FSNOTIFY_EVENT_INODE,
 	FSNOTIFY_EVENT_DENTRY,
 	FSNOTIFY_EVENT_MNT,
+	FSNOTIFY_EVENT_NS,
 	FSNOTIFY_EVENT_ERROR,
 };
 
@@ -335,6 +336,12 @@ struct fsnotify_mnt {
 	u64 mnt_id;
 };
 
+struct fsnotify_ns {
+	const struct user_namespace *userns;
+	u64 self_nsid;
+	u64 owner_nsid;
+};
+
 static inline struct inode *fsnotify_data_inode(const void *data, int data_type)
 {
 	switch (data_type) {
@@ -411,6 +418,17 @@ static inline const struct fsnotify_mnt *fsnotify_data_mnt(const void *data,
 	}
 }
 
+static inline const struct fsnotify_ns *fsnotify_data_ns(const void *data,
+							 int data_type)
+{
+	switch (data_type) {
+	case FSNOTIFY_EVENT_NS:
+		return data;
+	default:
+		return NULL;
+	}
+}
+
 static inline u64 fsnotify_data_mnt_id(const void *data, int data_type)
 {
 	const struct fsnotify_mnt *mnt_data = fsnotify_data_mnt(data, data_type);
@@ -456,6 +474,7 @@ enum fsnotify_iter_type {
 	FSNOTIFY_ITER_TYPE_PARENT,
 	FSNOTIFY_ITER_TYPE_INODE2,
 	FSNOTIFY_ITER_TYPE_MNTNS,
+	FSNOTIFY_ITER_TYPE_USERNS,
 	FSNOTIFY_ITER_TYPE_COUNT
 };
 
@@ -466,6 +485,7 @@ enum fsnotify_obj_type {
 	FSNOTIFY_OBJ_TYPE_VFSMOUNT,
 	FSNOTIFY_OBJ_TYPE_SB,
 	FSNOTIFY_OBJ_TYPE_MNTNS,
+	FSNOTIFY_OBJ_TYPE_USERNS,
 	FSNOTIFY_OBJ_TYPE_COUNT,
 	FSNOTIFY_OBJ_TYPE_DETACHED = FSNOTIFY_OBJ_TYPE_COUNT
 };
@@ -657,6 +677,8 @@ extern void __fsnotify_mntns_delete(struct mnt_namespace *mntns);
 extern void fsnotify_sb_free(struct super_block *sb);
 extern u32 fsnotify_get_cookie(void);
 extern void fsnotify_mnt(__u32 mask, struct mnt_namespace *ns, struct vfsmount *mnt);
+extern void fsnotify_ns(__u32 mask, struct user_namespace *userns,
+			u64 self_nsid, u64 owner_nsid);
 
 static inline __u32 fsnotify_parent_needed_mask(__u32 mask)
 {
diff --git a/include/linux/proc_fs.h b/include/linux/proc_fs.h
index 19d1c5e5f3350..3b7d2bc88ae6c 100644
--- a/include/linux/proc_fs.h
+++ b/include/linux/proc_fs.h
@@ -248,4 +248,6 @@ static inline struct pid_namespace *proc_pid_ns(struct super_block *sb)
 
 bool proc_ns_file(const struct file *file);
 
+struct user_namespace *userns_from_dentry(struct dentry *dentry);
+
 #endif /* _LINUX_PROC_FS_H */
diff --git a/include/linux/user_namespace.h b/include/linux/user_namespace.h
index 9c3be157397e0..7ff8420495308 100644
--- a/include/linux/user_namespace.h
+++ b/include/linux/user_namespace.h
@@ -13,6 +13,8 @@
 #include <linux/sysctl.h>
 #include <linux/err.h>
 
+struct fsnotify_mark_connector;
+
 #define UID_GID_MAP_MAX_BASE_EXTENTS 5
 #define UID_GID_MAP_MAX_EXTENTS 340
 
@@ -86,6 +88,10 @@ struct user_namespace {
 	/* parent_could_setfcap: true if the creator if this ns had CAP_SETFCAP
 	 * in its effective capability set at the child ns creation time. */
 	bool			parent_could_setfcap;
+#ifdef CONFIG_FSNOTIFY
+	__u32 n_fsnotify_mask;
+	struct fsnotify_mark_connector __rcu *n_fsnotify_marks;
+#endif
 
 #ifdef CONFIG_KEYS
 	/* List of joinable keyrings in this namespace.  Modification access of
diff --git a/include/uapi/linux/fanotify.h b/include/uapi/linux/fanotify.h
index e710967c7c263..6b4f470ee7e01 100644
--- a/include/uapi/linux/fanotify.h
+++ b/include/uapi/linux/fanotify.h
@@ -67,6 +67,7 @@
 #define FAN_REPORT_TARGET_FID	0x00001000	/* Report dirent target id  */
 #define FAN_REPORT_FD_ERROR	0x00002000	/* event->fd can report error */
 #define FAN_REPORT_MNT		0x00004000	/* Report mount events */
+#define FAN_REPORT_NSID		0x00008000	/* Report namespace events */
 
 /* Convenience macro - FAN_REPORT_NAME requires FAN_REPORT_DIR_FID */
 #define FAN_REPORT_DFID_NAME	(FAN_REPORT_DIR_FID | FAN_REPORT_NAME)
@@ -98,6 +99,7 @@
 #define FAN_MARK_MOUNT		0x00000010
 #define FAN_MARK_FILESYSTEM	0x00000100
 #define FAN_MARK_MNTNS		0x00000110
+#define FAN_MARK_USERNS		0x00001000
 
 /*
  * Convenience macro - FAN_MARK_IGNORE requires FAN_MARK_IGNORED_SURV_MODIFY
@@ -152,6 +154,7 @@ struct fanotify_event_metadata {
 #define FAN_EVENT_INFO_TYPE_ERROR	5
 #define FAN_EVENT_INFO_TYPE_RANGE	6
 #define FAN_EVENT_INFO_TYPE_MNT		7
+#define FAN_EVENT_INFO_TYPE_NS		8
 
 /* Special info types for FAN_RENAME */
 #define FAN_EVENT_INFO_TYPE_OLD_DFID_NAME	10
@@ -210,6 +213,12 @@ struct fanotify_event_info_mnt {
 	__u64 mnt_id;
 };
 
+struct fanotify_event_info_ns {
+	struct fanotify_event_info_header hdr;
+	__u64 self_nsid;	/* ns_id of the namespace */
+	__u64 owner_nsid;	/* ns_id of its owning user namespace */
+};
+
 /*
  * User space may need to record additional information about its decision.
  * The extra information type records what kind of information is included.
diff --git a/kernel/nscommon.c b/kernel/nscommon.c
index 3166c1fd844af..a6fdacb394ea7 100644
--- a/kernel/nscommon.c
+++ b/kernel/nscommon.c
@@ -6,6 +6,7 @@
 #include <linux/proc_ns.h>
 #include <linux/user_namespace.h>
 #include <linux/vfsdebug.h>
+#include <linux/fsnotify_backend.h>
 
 #ifdef CONFIG_DEBUG_VFS
 static void ns_debug(struct ns_common *ns, const struct proc_ns_operations *ops)
@@ -111,6 +112,43 @@ struct ns_common *__must_check ns_owner(struct ns_common *ns)
 	return to_ns_common(owner);
 }
 
+/*
+ * Return the owning user_namespace of @ns, including init_user_ns.
+ * Unlike ns_owner(), which returns NULL for namespaces owned by
+ * init_user_ns (to serve as a propagation terminator), this gives us
+ * the real owner for notification routing.
+ */
+static struct user_namespace *ns_direct_owner(struct ns_common *ns)
+{
+	if (unlikely(!ns->ops || !ns->ops->owner))
+		return NULL;
+	return ns->ops->owner(ns);
+}
+
+static void ns_common_notify(__u32 mask, struct ns_common *ns)
+{
+	struct user_namespace *owner_userns;
+
+	if (!IS_ENABLED(CONFIG_FSNOTIFY))
+		return;
+
+	owner_userns = ns_direct_owner(ns);
+	if (!owner_userns)
+		return;
+
+#ifdef CONFIG_FSNOTIFY
+	/*
+	 * READ_ONCE macro expansion does not understand that this code
+	 * is not reachable without CONFIG_FSNOTIFY.
+	 */
+	if (!READ_ONCE(owner_userns->n_fsnotify_marks))
+		return;
+#endif
+
+	fsnotify_ns(mask, owner_userns, ns->ns_id,
+		    to_ns_common(owner_userns)->ns_id);
+}
+
 /*
  * The active reference count works by having each namespace that gets
  * created take a single active reference on its owning user namespace.
@@ -172,6 +210,8 @@ void __ns_ref_active_put(struct ns_common *ns)
 		return;
 	}
 
+	ns_common_notify(FS_DELETE, ns);
+
 	VFS_WARN_ON_ONCE(is_ns_init_id(ns));
 	VFS_WARN_ON_ONCE(!__ns_ref_read(ns));
 
@@ -184,6 +224,8 @@ void __ns_ref_active_put(struct ns_common *ns)
 			VFS_WARN_ON_ONCE(__ns_ref_active_read(ns) < 0);
 			return;
 		}
+
+		ns_common_notify(FS_DELETE, ns);
 	}
 }
 
@@ -293,6 +335,8 @@ void __ns_ref_active_get(struct ns_common *ns)
 	if (likely(prev))
 		return;
 
+	ns_common_notify(FS_CREATE, ns);
+
 	/*
 	 * We did resurrect it. Walk the ownership hierarchy upwards
 	 * until we found an owning user namespace that is active.
@@ -307,6 +351,8 @@ void __ns_ref_active_get(struct ns_common *ns)
 		VFS_WARN_ON_ONCE(prev < 0);
 		if (likely(prev))
 			return;
+
+		ns_common_notify(FS_CREATE, ns);
 	}
 }
 
-- 
2.53.0


