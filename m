Return-Path: <linux-fsdevel+bounces-40002-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ECB9DA1AA81
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2025 20:42:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2989188D28F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2025 19:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5DDC1C3BF6;
	Thu, 23 Jan 2025 19:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H+Dv7VX+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C6201ADC87
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jan 2025 19:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737661282; cv=none; b=B+CeFY0xu02iFTBf8P+x8EP18lleeI4SG2+ejS0wfyfu53iG/pTJxFJIFoJRJ7NcyZBI1IyJlNIKAZaFCK5FDMr33bKbOuM2UczmURvCwuErAFlwVCnfzpWZIVBfigTLs1XTurTRO8sQuY3mcybkzOX0b9QhNH7QTZYx/y9B2Y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737661282; c=relaxed/simple;
	bh=8Rex1jue2v4oXkNDV+SsESvmvUW9hToBize8zaIzoh0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V5lT+hCEjWmzTEaZgjosSvUaFNuRJ+nxsApEEENizcXexphKw11F/SjdEA7nRLr3AcYpw7vSJxKit6AiSsb10h6/IhElR1BAMNNnXFFS/F/JVmUSY6YtPgmgLKKySiK3Mu74beDo2V+1XxrULXx+KOmgviCUHGSWjUaM0x0LtKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H+Dv7VX+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737661279;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lVWBJyMVn3pq9QMtoCCB0cgOGlE9eZyl9LQ5JXqGeCA=;
	b=H+Dv7VX+n1NZ+FjjgbhyrSfFIPzGD11lJMvrGZ+TIuFe+dCt4gsD3pndJ3PEwsnGKe55YR
	YrH7p7I6kGP5fJg5glajGdmHhdPAI3jAjD8y9hLXWlN+FCuH1XfJcrqjolZ0Xah2HB0S2a
	w0F5m+TZyrIF3MOz9gwp8ir6mI+gnNk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-509-cCJ94YzgO5K4AzR7_AY9pw-1; Thu, 23 Jan 2025 14:41:18 -0500
X-MC-Unique: cCJ94YzgO5K4AzR7_AY9pw-1
X-Mimecast-MFC-AGG-ID: cCJ94YzgO5K4AzR7_AY9pw
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3862a49fbdaso581045f8f.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jan 2025 11:41:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737661277; x=1738266077;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lVWBJyMVn3pq9QMtoCCB0cgOGlE9eZyl9LQ5JXqGeCA=;
        b=iZc0WLcM1SKX+fdTd59gGkTRaiNaHIQplUh0YZwQKn1lBkZKsSrPj7yL7HGUAEdHqu
         fO24XGRYyW7aVlAQHDqvV19aFOWKF7xGWlaOz6HNxN/cBkGE4uEvCZayYFQ2ab1cfMA4
         NVrfodWWi5N16iPU3Blb/RaLjSigAOnzb0m7S8MvNYWYOfCLOzD2e/9WRlyhdWh0DRTt
         +3m0/0rlAFQ7O02MquRE7MM6O0UyYE7sU6qrr0QDHe1f+dH/M7U03e8hEVBdNn+uJSPT
         qEhjf4/G/uIIKOf9IiTXyDcs7j4J1MGkfQe6+66oENzq/c1STroNcp/wj8DkFW+5Pndr
         g6QQ==
X-Gm-Message-State: AOJu0YxBpHTBpc/Za/FjglKgkJDNDufJmXlMmoJQoWfn0ls7QTZJCmBb
	6py5oGDZOFKFjID2k3uwWm23QY+DaUlqTuRjdUotGKvUzBu/lyMKtIE0d7flZxXIvzHhZ7a10Wz
	dLCjvd55cGGmOyovW/ABmXG8CsSQnM13Y6C1DjUUSEee2OMZKdwQzogwJkVFsQC4kjE4I5IvyyG
	poBZdl/Ft8UT7gCCwJ4AFU7i1iHX1eZDWZLsZNcpgiigGwgg4fhA==
X-Gm-Gg: ASbGnct9gatdc+PguqtNDlOmY4Fut+B+l95P1Y6FYay8FsZyI6snZBYFOW1ld9qL2ZG
	tmzFTRPwqT57ZecUtFpivgTlZZi3NYJLJAGcTqUKmSrD6+kDCSnyhtLtu6qyE5QGqBLTnMg0BQM
	TzduxSIAFAM+e0JAAnOfa/8Ol3XUq5Gra8/TlFPnk6hx24nx0Zumu2tTcnHFTD2yxWkZJFuwzLF
	RIui0hhTQTqEsAxdX6miR+FdX1mZnS1GYZ8cvsCbUFM67/DqKTaxZd3BhluSQTrTGEYG7ctJkzm
	4JjktneUcsPOkubGSEczptSdpvd9av7dpJ61HGLnxd9oZA==
X-Received: by 2002:a05:6000:1863:b0:385:df2c:91aa with SMTP id ffacd0b85a97d-38bf565579fmr22252067f8f.7.1737661276671;
        Thu, 23 Jan 2025 11:41:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGCwYvNPnsOpcrz/YUWLahtCRlJYVF7u4D+kUx15s09iLwHMLIFq/9r+tNumdffqIr6q0gPGA==
X-Received: by 2002:a05:6000:1863:b0:385:df2c:91aa with SMTP id ffacd0b85a97d-38bf565579fmr22252032f8f.7.1737661276130;
        Thu, 23 Jan 2025 11:41:16 -0800 (PST)
Received: from maszat.piliscsaba.szeredi.hu (91-82-183-41.pool.digikabel.hu. [91.82.183.41])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438bd507e46sm1687245e9.21.2025.01.23.11.41.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 11:41:15 -0800 (PST)
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
Subject: [PATCH v4 4/4] vfs: add notifications for mount attribute change
Date: Thu, 23 Jan 2025 20:41:07 +0100
Message-ID: <20250123194108.1025273-5-mszeredi@redhat.com>
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

Notify when mount flags, propagation or idmap changes.

Just like attach and detach, no details are given in the notification, only
the mount ID.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/namespace.c                   | 27 +++++++++++++++++++++++++++
 fs/notify/fanotify/fanotify.c    |  2 +-
 fs/notify/fanotify/fanotify.h    |  2 +-
 fs/notify/fsnotify.c             |  2 +-
 include/linux/fanotify.h         |  2 +-
 include/linux/fsnotify.h         |  5 +++++
 include/linux/fsnotify_backend.h |  5 ++++-
 include/uapi/linux/fanotify.h    |  1 +
 8 files changed, 41 insertions(+), 5 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 948348a37f6c..9b9b13665dce 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2807,6 +2807,9 @@ static int do_change_type(struct path *path, int ms_flags)
 		change_mnt_propagation(m, type);
 	unlock_mount_hash();
 
+	for (m = mnt; m; m = (recurse ? next_mnt(m, mnt) : NULL))
+		fsnotify_mnt_change(m->mnt_ns, &m->mnt);
+
  out_unlock:
 	namespace_unlock();
 	return err;
@@ -3089,6 +3092,12 @@ static int do_reconfigure_mnt(struct path *path, unsigned int mnt_flags)
 	unlock_mount_hash();
 	up_read(&sb->s_umount);
 
+	if (!ret) {
+		down_read(&namespace_sem);
+		fsnotify_mnt_change(mnt->mnt_ns, &mnt->mnt);
+		up_read(&namespace_sem);
+	}
+
 	mnt_warn_timestamp_expiry(path, &mnt->mnt);
 
 	return ret;
@@ -3141,6 +3150,13 @@ static int do_remount(struct path *path, int ms_flags, int sb_flags,
 		up_write(&sb->s_umount);
 	}
 
+	if (!err) {
+		down_read(&namespace_sem);
+		fsnotify_mnt_change(mnt->mnt_ns, &mnt->mnt);
+		up_read(&namespace_sem);
+	}
+
+
 	mnt_warn_timestamp_expiry(path, &mnt->mnt);
 
 	put_fs_context(fc);
@@ -4708,6 +4724,8 @@ static int do_mount_setattr(struct path *path, struct mount_kattr *kattr)
 				return err;
 			}
 		}
+	} else {
+		down_read(&namespace_sem);
 	}
 
 	err = -EINVAL;
@@ -4743,10 +4761,19 @@ static int do_mount_setattr(struct path *path, struct mount_kattr *kattr)
 out:
 	unlock_mount_hash();
 
+	if (!err) {
+		struct mount *m;
+
+		for (m = mnt; m; m = kattr->recurse ? next_mnt(m, mnt) : NULL)
+			fsnotify_mnt_change(m->mnt_ns, &m->mnt);
+	}
+
 	if (kattr->propagation) {
 		if (err)
 			cleanup_group_ids(mnt, NULL);
 		namespace_unlock();
+	} else {
+		up_read(&namespace_sem);
 	}
 
 	return err;
diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index b1937f92f105..c7ddd145f3d8 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -934,7 +934,7 @@ static int fanotify_handle_event(struct fsnotify_group *group, u32 mask,
 	BUILD_BUG_ON(FAN_FS_ERROR != FS_ERROR);
 	BUILD_BUG_ON(FAN_RENAME != FS_RENAME);
 
-	BUILD_BUG_ON(HWEIGHT32(ALL_FANOTIFY_EVENT_BITS) != 23);
+	BUILD_BUG_ON(HWEIGHT32(ALL_FANOTIFY_EVENT_BITS) != 24);
 
 	mask = fanotify_group_event_mask(group, iter_info, &match_mask,
 					 mask, data, data_type, dir);
diff --git a/fs/notify/fanotify/fanotify.h b/fs/notify/fanotify/fanotify.h
index f1a7cbedc9e3..8d6289da06f1 100644
--- a/fs/notify/fanotify/fanotify.h
+++ b/fs/notify/fanotify/fanotify.h
@@ -471,7 +471,7 @@ static inline bool fanotify_is_error_event(u32 mask)
 
 static inline bool fanotify_is_mnt_event(u32 mask)
 {
-	return mask & (FAN_MNT_ATTACH | FAN_MNT_DETACH);
+	return mask & FANOTIFY_MOUNT_EVENTS;
 }
 
 static inline const struct path *fanotify_event_path(struct fanotify_event *event)
diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
index 2b2c3fd907c7..5872dd27172d 100644
--- a/fs/notify/fsnotify.c
+++ b/fs/notify/fsnotify.c
@@ -660,7 +660,7 @@ static __init int fsnotify_init(void)
 {
 	int ret;
 
-	BUILD_BUG_ON(HWEIGHT32(ALL_FSNOTIFY_BITS) != 25);
+	BUILD_BUG_ON(HWEIGHT32(ALL_FSNOTIFY_BITS) != 26);
 
 	ret = init_srcu_struct(&fsnotify_mark_srcu);
 	if (ret)
diff --git a/include/linux/fanotify.h b/include/linux/fanotify.h
index fc142be2542d..61e112d25303 100644
--- a/include/linux/fanotify.h
+++ b/include/linux/fanotify.h
@@ -100,7 +100,7 @@
 /* Events that can only be reported with data type FSNOTIFY_EVENT_ERROR */
 #define FANOTIFY_ERROR_EVENTS	(FAN_FS_ERROR)
 
-#define FANOTIFY_MOUNT_EVENTS	(FAN_MNT_ATTACH | FAN_MNT_DETACH)
+#define FANOTIFY_MOUNT_EVENTS	(FAN_MNT_ATTACH | FAN_MNT_DETACH | FAN_MNT_CHANGE)
 
 /* Events that user can request to be notified on */
 #define FANOTIFY_EVENTS		(FANOTIFY_PATH_EVENTS | \
diff --git a/include/linux/fsnotify.h b/include/linux/fsnotify.h
index ea998551dd0d..ba3e05c69aaa 100644
--- a/include/linux/fsnotify.h
+++ b/include/linux/fsnotify.h
@@ -483,4 +483,9 @@ static inline void fsnotify_mnt_move(struct mnt_namespace *ns, struct vfsmount *
 	fsnotify_mnt(FS_MNT_MOVE, ns, mnt);
 }
 
+static inline void fsnotify_mnt_change(struct mnt_namespace *ns, struct vfsmount *mnt)
+{
+	fsnotify_mnt(FS_MNT_CHANGE, ns, mnt);
+}
+
 #endif	/* _LINUX_FS_NOTIFY_H */
diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
index 6c3e3a4a7b10..54e01803e309 100644
--- a/include/linux/fsnotify_backend.h
+++ b/include/linux/fsnotify_backend.h
@@ -58,6 +58,8 @@
 
 #define FS_MNT_ATTACH		0x01000000	/* Mount was attached */
 #define FS_MNT_DETACH		0x02000000	/* Mount was detached */
+#define FS_MNT_CHANGE		0x04000000	/* Mount was changed */
+
 #define FS_MNT_MOVE		(FS_MNT_ATTACH | FS_MNT_DETACH)
 
 /*
@@ -106,7 +108,8 @@
 			     FS_EVENTS_POSS_ON_CHILD | \
 			     FS_DELETE_SELF | FS_MOVE_SELF | \
 			     FS_UNMOUNT | FS_Q_OVERFLOW | FS_IN_IGNORED | \
-			     FS_ERROR | FS_MNT_ATTACH | FS_MNT_DETACH)
+			     FS_ERROR | \
+			     FS_MNT_ATTACH | FS_MNT_DETACH | FS_MNT_CHANGE )
 
 /* Extra flags that may be reported with event or control handling of events */
 #define ALL_FSNOTIFY_FLAGS  (FS_ISDIR | FS_EVENT_ON_CHILD | FS_DN_MULTISHOT)
diff --git a/include/uapi/linux/fanotify.h b/include/uapi/linux/fanotify.h
index 69340e483ae7..256fc5755b45 100644
--- a/include/uapi/linux/fanotify.h
+++ b/include/uapi/linux/fanotify.h
@@ -27,6 +27,7 @@
 #define FAN_OPEN_EXEC_PERM	0x00040000	/* File open/exec in perm check */
 #define FAN_MNT_ATTACH		0x01000000	/* Mount was attached */
 #define FAN_MNT_DETACH		0x02000000	/* Mount was detached */
+#define FAN_MNT_CHANGE		0x04000000	/* Mount was changed */
 
 #define FAN_EVENT_ON_CHILD	0x08000000	/* Interested in child events */
 
-- 
2.47.1


