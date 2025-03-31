Return-Path: <linux-fsdevel+bounces-45376-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B1142A76C45
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Mar 2025 18:52:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5711116AF7E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Mar 2025 16:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A88CB214238;
	Mon, 31 Mar 2025 16:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ewn8tUYd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 423032E630
	for <linux-fsdevel@vger.kernel.org>; Mon, 31 Mar 2025 16:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743439959; cv=none; b=iHRjnabJAsGXxPAcirqI4KOhct/t1h+Of0zXC+YbHHXeim/06DB8+br77AhBBj+3nL/UdRmI867LgOpzUK9kFmUmJSBw9bFc3MB0Aid6Z3NhE3y75GFnCJvlKBYfVb+Y6DKbZKwl38XUZP0W2D0/rGcxBlEzuKWNtZltdcIBwNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743439959; c=relaxed/simple;
	bh=ZSE91hgepKx1Mqa4Pex3elzkshzN+UCRED58NRvKoW8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BBaxgiLgu6KtY+0P+jZRyBdsc7192qvjWA3LzMFzFexGVooAkctAsrpwezZV51IIYMWTVAfX+IKuZnaI/U62v8Iz29suKqfa42poHSXB2vNQfsynKvZiaWYUvO9GINTlhfw0ZykZMBy6haATcRPrKeUmvR+oSP/5efuJtMPB+f4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ewn8tUYd; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-391342fc0b5so3478641f8f.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 31 Mar 2025 09:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743439955; x=1744044755; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FyFoQFLyYESGO7e9eVQgmnQnleTBcNw02jIMyWYZUmk=;
        b=ewn8tUYdqHgxMrLSJxV6SzjeBAmo6NhGjN/GnK3SlaY8uCi9PVk/B+F0SiAQdtlaHv
         Y7weHli+iQKthCU3Xilr1XE+ir0ZfTCnSSOLubEGU8BHQGFQWxzOp/1O/DVGz/LVGgYX
         Iby7cRxYsvQ4kskBNmHVYB1pKgTzlpiTmAyWgZRNMP8Y0n32/orEHdvPVkCykq4j/VIQ
         AmJc3D1rE820qCVJM/ppqjSa7Do85lCHAJoXUHVTQsRj28fEw8k0f1Kto+vEvhr4qCpL
         b5Oknk0pNGTV1DICcXtfjMx3gm+Rgi00AXbKyimJIO5cPgQ5KiwUXeC4BQA1G2lUQguz
         YsHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743439955; x=1744044755;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FyFoQFLyYESGO7e9eVQgmnQnleTBcNw02jIMyWYZUmk=;
        b=hIXwwMbcdF68U37Rul2El+Jbn58LJ/WdhoWAWO+CCDE6flmmM7RJCISozERfOFURh5
         yLlIW5uY0tWYboszzsnadfsZvnVjU9xcCcJxYw1D+TvfdwsUKNw7M1oJtalxtk/kPPOO
         pNzs9gf8C/EXs6trzFN2IM2/11gqQh+4qFbx4FJn5Xln4U4e2L29j0wN96mZJTW02oId
         IyyoKtQ3lvtUiOHpDxDDUF+UnDTyIp+qyVOuK1LZi0HRffo/n0au0fxhvkihDOJNCrgj
         l4rn7WjZ7qwvUrcaTFGDkbK8erTvmcbAtl5WbNxrosOBxegMRVWdVZPYTFvwM/oioPcl
         kRBw==
X-Forwarded-Encrypted: i=1; AJvYcCUvnojMjqTiG89Ll+xSSeGsYJrsG+7ne11p3rQpdKqF18Tjmn9TipNIjs5cpDrfk7XgrdEJoA0AsAcaLwkv@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3PH0mX8pgWIi6U+cxvWAlfYcGuTAv0oHg5b++0jUkB6mCx4G6
	SHR9vwkeyQXKUQgd+FiIzoRfruAuzDC9R6cWIQtQxl2dotFdpZdN
X-Gm-Gg: ASbGncuMptonSSKv3bUctWPqOSQW/7PdIjV2d8xursRZlsgLtjRwae6F/mNs5ZYNUTN
	nH8+V3XVfxJo9lu/XBnf5WE/M1da3L4G4o6jjmP1ZzkGhdpSxhs3j0hCpm3bQKIOf0o88NdaNn4
	GvhN+JNFTMXr+NWrE3nZK2+d1gNE73hMa7b1NEAaobLvsTmuYenJvB2pi57Iqi+tERJVgxxIDAw
	UQDVSaVAfcd+iHla6yI54u3FhEEdAVytGLhvrssSWSuKzspFD9gBU/tbclF/F9SGderUbU5z0Rc
	OODkbV8/nn58rQlnD5hrUE45Ej5Th9NjECBkHqmlPff1bSBw0yCnZTR+dSwQrwEC7Slcf5WsN57
	QSEgYZMkT44LT2cGTzc/pkaw4yyhf+7D/UhWkl/A+/A==
X-Google-Smtp-Source: AGHT+IGiePIEVtLQxGNwn11vconAeg8lyK7+IV++Mpvfs5Ta1QoNAIS7L6lbJJyyCMyLKP1oTu5z7Q==
X-Received: by 2002:a05:6000:188c:b0:391:3f4f:a172 with SMTP id ffacd0b85a97d-39c1211dd9bmr6903429f8f.49.1743439955176;
        Mon, 31 Mar 2025 09:52:35 -0700 (PDT)
Received: from amir-ThinkPad-T480.arnhem.chello.nl (92-109-99-123.cable.dynamic.v4.ziggo.nl. [92.109.99.123])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d82efe389sm169072855e9.19.2025.03.31.09.52.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Mar 2025 09:52:34 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Jan Kara <jack@suse.cz>
Cc: Josef Bacik <josef@toxicpanda.com>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH] fanotify: report FAN_PRE_MODIFY event before write to file range
Date: Mon, 31 Mar 2025 18:52:31 +0200
Message-Id: <20250331165231.1466680-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In addition to FAN_PRE_ACCESS event before any access to a file range,
also report the FAN_PRE_MODIFY event in case of a write access.

This will allow userspace to subscribe only to pre-write access
notifications and to respond with error codes associated with write
operations using the FAN_DENY_ERRNO macro.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---

Jan,

I was looking on th list for the reason we decided to drop FAN_PRE_MODIFY
from the pre-content patch set and I couldn't find it. It may have been
related to complications ot page fault hooks that are not not relevant?

I did find the decision to generate FAN_PRE_ACCESS on both read()/write(),
so maybe we thought there was no clear value for the FAN_PRE_MODIFY event?

In any case, I realized that we allowed returning custom errors with
FAN_DENY_ERRNO(ENOSPC), but that chosing the right error does require
knowing whether the call was read() or write().

Becaue mmap() cannot return write() errors like ENOSPC, I decided not
to generate FAN_PRE_MODIFY for writably-shared maps, but maybe we should
consider this.

This patch implement FAN_PRE_{ACCESS,MODIFY} as a combined event.
This is not like the way that we generate the permission events
FAN_OPEN_PERM and FAN_OPEN_EXEC_PERM as separate events.

I do not remember why we chose the seprate events in the case above.
I do remember why we chose separate events for FAN_ACCESS_PERM and
FAN_PRE_ACCESS - because they do not have the same info.

Anyway, this way makes more sense to me for FAN_PRE_{ACCESS,MODIFY}.

LTP test pushed to branch fan_hsm.

WDYT?

Amir.

P.S. #1: if you accept this, we may consider sending to stable 6.14 to
make FAN_PRE_MODIFY part of the initial version of the API.

P.S. #2: I am going to look now at FAN_PRE_ACCESS events on directories
that we left out, because we may want to include it in initial API if
it turns out to be simple.


 fs/notify/fanotify/fanotify.c    |  3 ++-
 fs/notify/fsnotify.c             | 12 ++++++++----
 include/linux/fanotify.h         |  2 +-
 include/linux/fsnotify.h         | 10 ++++++----
 include/linux/fsnotify_backend.h |  8 +++++---
 include/uapi/linux/fanotify.h    |  2 ++
 6 files changed, 24 insertions(+), 13 deletions(-)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index 6d386080faf2..6c877b3646ec 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -950,8 +950,9 @@ static int fanotify_handle_event(struct fsnotify_group *group, u32 mask,
 	BUILD_BUG_ON(FAN_FS_ERROR != FS_ERROR);
 	BUILD_BUG_ON(FAN_RENAME != FS_RENAME);
 	BUILD_BUG_ON(FAN_PRE_ACCESS != FS_PRE_ACCESS);
+	BUILD_BUG_ON(FAN_PRE_MODIFY != FS_PRE_MODIFY);
 
-	BUILD_BUG_ON(HWEIGHT32(ALL_FANOTIFY_EVENT_BITS) != 24);
+	BUILD_BUG_ON(HWEIGHT32(ALL_FANOTIFY_EVENT_BITS) != 25);
 
 	mask = fanotify_group_event_mask(group, iter_info, &match_mask,
 					 mask, data, data_type, dir);
diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
index e2b4f17a48bb..7b364f965650 100644
--- a/fs/notify/fsnotify.c
+++ b/fs/notify/fsnotify.c
@@ -210,19 +210,23 @@ static inline bool fsnotify_object_watched(struct inode *inode, __u32 mnt_mask,
 
 /* Report pre-content event with optional range info */
 int fsnotify_pre_content(const struct path *path, const loff_t *ppos,
-			 size_t count)
+			 size_t count, bool write)
 {
+	__u32 mask = FS_PRE_ACCESS;
 	struct file_range range;
 
+	if (write)
+		mask |= FS_PRE_MODIFY;
+
 	/* Report page aligned range only when pos is known */
 	if (!ppos)
-		return fsnotify_path(path, FS_PRE_ACCESS);
+		return fsnotify_path(path, mask);
 
 	range.path = path;
 	range.pos = PAGE_ALIGN_DOWN(*ppos);
 	range.count = PAGE_ALIGN(*ppos + count) - range.pos;
 
-	return fsnotify_parent(path->dentry, FS_PRE_ACCESS, &range,
+	return fsnotify_parent(path->dentry, mask, &range,
 			       FSNOTIFY_EVENT_FILE_RANGE);
 }
 
@@ -745,7 +749,7 @@ static __init int fsnotify_init(void)
 {
 	int ret;
 
-	BUILD_BUG_ON(HWEIGHT32(ALL_FSNOTIFY_BITS) != 26);
+	BUILD_BUG_ON(HWEIGHT32(ALL_FSNOTIFY_BITS) != 27);
 
 	ret = init_srcu_struct(&fsnotify_mark_srcu);
 	if (ret)
diff --git a/include/linux/fanotify.h b/include/linux/fanotify.h
index 3c817dc6292e..85def9de2ef4 100644
--- a/include/linux/fanotify.h
+++ b/include/linux/fanotify.h
@@ -94,7 +94,7 @@
 #define FANOTIFY_CONTENT_PERM_EVENTS (FAN_OPEN_PERM | FAN_OPEN_EXEC_PERM | \
 				      FAN_ACCESS_PERM)
 /* Pre-content events can be used to fill file content */
-#define FANOTIFY_PRE_CONTENT_EVENTS  (FAN_PRE_ACCESS)
+#define FANOTIFY_PRE_CONTENT_EVENTS  (FAN_PRE_ACCESS | FAN_PRE_MODIFY)
 
 /* Events that require a permission response from user */
 #define FANOTIFY_PERM_EVENTS	(FANOTIFY_CONTENT_PERM_EVENTS | \
diff --git a/include/linux/fsnotify.h b/include/linux/fsnotify.h
index 454d8e466958..9beea32c8980 100644
--- a/include/linux/fsnotify.h
+++ b/include/linux/fsnotify.h
@@ -144,7 +144,7 @@ static inline int fsnotify_file_area_perm(struct file *file, int perm_mask,
 	 */
 	lockdep_assert_once(file_write_not_started(file));
 
-	if (!(perm_mask & (MAY_READ | MAY_WRITE | MAY_ACCESS)))
+	if (!(perm_mask & (MAY_READ | MAY_WRITE)))
 		return 0;
 
 	if (likely(!FMODE_FSNOTIFY_PERM(file->f_mode)))
@@ -154,7 +154,8 @@ static inline int fsnotify_file_area_perm(struct file *file, int perm_mask,
 	 * read()/write() and other types of access generate pre-content events.
 	 */
 	if (unlikely(FMODE_FSNOTIFY_HSM(file->f_mode))) {
-		int ret = fsnotify_pre_content(&file->f_path, ppos, count);
+		int ret = fsnotify_pre_content(&file->f_path, ppos, count,
+					       perm_mask & MAY_WRITE);
 
 		if (ret)
 			return ret;
@@ -182,7 +183,8 @@ static inline int fsnotify_mmap_perm(struct file *file, int prot,
 	if (!file || likely(!FMODE_FSNOTIFY_HSM(file->f_mode)))
 		return 0;
 
-	return fsnotify_pre_content(&file->f_path, &off, len);
+	/* XXX: should we report pre-modify for writably shared maps */
+	return fsnotify_pre_content(&file->f_path, &off, len, false);
 }
 
 /*
@@ -197,7 +199,7 @@ static inline int fsnotify_truncate_perm(const struct path *path, loff_t length)
 					       FSNOTIFY_PRIO_PRE_CONTENT))
 		return 0;
 
-	return fsnotify_pre_content(path, &length, 0);
+	return fsnotify_pre_content(path, &length, 0, true);
 }
 
 /*
diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
index 6cd8d1d28b8b..396943093373 100644
--- a/include/linux/fsnotify_backend.h
+++ b/include/linux/fsnotify_backend.h
@@ -58,6 +58,7 @@
 /* #define FS_DIR_MODIFY	0x00080000 */	/* Deprecated (reserved) */
 
 #define FS_PRE_ACCESS		0x00100000	/* Pre-content access hook */
+#define FS_PRE_MODIFY		0x00200000	/* Pre-content modify hook */
 
 #define FS_MNT_ATTACH		0x01000000	/* Mount was attached */
 #define FS_MNT_DETACH		0x02000000	/* Mount was detached */
@@ -91,7 +92,7 @@
 #define FSNOTIFY_CONTENT_PERM_EVENTS (FS_OPEN_PERM | FS_OPEN_EXEC_PERM | \
 				      FS_ACCESS_PERM)
 /* Pre-content events can be used to fill file content */
-#define FSNOTIFY_PRE_CONTENT_EVENTS  (FS_PRE_ACCESS)
+#define FSNOTIFY_PRE_CONTENT_EVENTS  (FS_PRE_ACCESS | FS_PRE_MODIFY)
 
 #define ALL_FSNOTIFY_PERM_EVENTS (FSNOTIFY_CONTENT_PERM_EVENTS | \
 				  FSNOTIFY_PRE_CONTENT_EVENTS)
@@ -932,12 +933,13 @@ static inline void fsnotify_init_event(struct fsnotify_event *event)
 	INIT_LIST_HEAD(&event->list);
 }
 int fsnotify_pre_content(const struct path *path, const loff_t *ppos,
-			 size_t count);
+			 size_t count, bool write);
 
 #else
 
 static inline int fsnotify_pre_content(const struct path *path,
-				       const loff_t *ppos, size_t count)
+				       const loff_t *ppos, size_t count,
+				       bool write)
 {
 	return 0;
 }
diff --git a/include/uapi/linux/fanotify.h b/include/uapi/linux/fanotify.h
index e710967c7c26..a9728a550daa 100644
--- a/include/uapi/linux/fanotify.h
+++ b/include/uapi/linux/fanotify.h
@@ -28,6 +28,8 @@
 /* #define FAN_DIR_MODIFY	0x00080000 */	/* Deprecated (reserved) */
 
 #define FAN_PRE_ACCESS		0x00100000	/* Pre-content access hook */
+#define FAN_PRE_MODIFY		0x00200000	/* Pre-content modify hook */
+
 #define FAN_MNT_ATTACH		0x01000000	/* Mount was attached */
 #define FAN_MNT_DETACH		0x02000000	/* Mount was detached */
 
-- 
2.34.1


