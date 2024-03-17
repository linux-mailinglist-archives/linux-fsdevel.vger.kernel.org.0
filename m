Return-Path: <linux-fsdevel+bounces-14652-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AFDC587DF4C
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Mar 2024 19:43:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DE91281976
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Mar 2024 18:43:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2E2E219FD;
	Sun, 17 Mar 2024 18:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NHLID42p"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3348E2110B
	for <linux-fsdevel@vger.kernel.org>; Sun, 17 Mar 2024 18:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710700938; cv=none; b=HmFMCAhuNmkhM1AmD6OyvT7ncXM0C13bsyG1yMSZRbybkPdRXu9k+o+4Fo4IEvUONnDeuFN2ohx4k3K3LBol5ZYYDQagJCtkuUlK9cnFht8y7B8eEFkj36d9jfO2nrvZ4A5BZI2t2yvWMhu5wU+BcPHgk2b54y39YiDISgK+Qb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710700938; c=relaxed/simple;
	bh=VJ2BNw27CkCb9GWvoLZpmaiZ8YB/66XfWfEvRdR/HEA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iD6mpmLg3R8i5UQ1xOKMIP5TRcgRMy5ra8fHQ53NH3loUkDiUFSMkcQptSw8Zvkx9ovga7eb2aCb9wFMgpwT/XF6lTcqHAtzhqHw5JopOqEuPiitmKGKeItk35qPNtXOUNvApcqvU4vVwDtZ9AWcJtP3ZFW0tD00Yc9EUyUIQNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NHLID42p; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-41409dc5becso6425035e9.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 17 Mar 2024 11:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710700934; x=1711305734; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p+WPyCDqkGCUpDinhRaf1HsSkD50R1iK+aBrEQk7WbQ=;
        b=NHLID42pHsWse+pQcao1CXPNtjY8dDCFQT9QCXiCWxCa/HctEKXZjau510qwNFfLsd
         e9LWlGtkKFmgbDVqSNUonqSrKTj3EM6OMRurh5HcqKqH9odkVkoDjfhazV2GRu2xuF9a
         txEbda1Ru7OIOXSwNJ9YZEHgMcnCiDpgtr10tWkA5llY4tOcAjVfT27LOW7Gq8vGmuFT
         4q1o+y6g2p+mNppAZdTxX0YsTfpyokyWKPKh6zvywzTmDLdkpPLEf0nWtsnoTiJHWD4x
         gUAvki73CbmN1ka1pyW1wG93BEAE3XTMW4LhtyB0ghvWp5c1yEGNuWjDl1yxp1TZly/t
         87yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710700934; x=1711305734;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p+WPyCDqkGCUpDinhRaf1HsSkD50R1iK+aBrEQk7WbQ=;
        b=RCAls9esWUjggp83d+ykjr9KgZWmeK8FcdLV1LxmN+MDsS8N0YDnl7ZFJdrhlIwcpy
         zXDXF7ZJ8b/fMbVGBdyUsSlh4dD/WITfAuEZ2Ekba+Ir/ckTo0Omwhx8mLaxTaK7fmut
         u4UVyNXYucmhmjIZyRiyjYSG/NNT4Es8qqI9ov5CYOpwam7xGzPYo6qvVdycvSqsNZHa
         qDbZL0MOtxAEkOJh3XqT93wvWTFzlnP+tGCS/aR93Fh7voR+QPl+JZWxSHdSXs1HzZG8
         9NBMnE3d8IIgzJNB6RFGb0nCkpbKUXhE0b7OVFfSxkDc3ENnpXzk90a21El3nqSNq+FV
         prFQ==
X-Forwarded-Encrypted: i=1; AJvYcCUKCqA1t7O/F66pOWXZKPY6RmZxFaOtP0QwjPi2umOkNVeOCWLET4Gq5szRDNTS40wn4JQKQCoUlpysps9UhKw6InloFkeRnqThE3n5UQ==
X-Gm-Message-State: AOJu0YycRhr4u2oAnSnIlLnikNaicEy5GRkwk8gddo/N8Fp3wpFleI8B
	C930BdgELgvcXMcdtYf3vi/h1d+BubrAb7mWzFNhWokvr48sp2ed
X-Google-Smtp-Source: AGHT+IEyk30R9Rux+ppOoh1tsnYot7wjrrnwRvoJl9UtosqLTfYl/aHu2PcR9dGkHNYD75eETS9fhQ==
X-Received: by 2002:a5d:6941:0:b0:33e:d4d1:1e58 with SMTP id r1-20020a5d6941000000b0033ed4d11e58mr4358615wrw.31.1710700934552;
        Sun, 17 Mar 2024 11:42:14 -0700 (PDT)
Received: from amir-ThinkPad-T480.lan (85-250-214-4.bb.netvision.net.il. [85.250.214.4])
        by smtp.gmail.com with ESMTPSA id bk28-20020a0560001d9c00b0033e22a7b3f8sm3070716wrb.75.2024.03.17.11.42.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Mar 2024 11:42:14 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Jan Kara <jack@suse.cz>,
	Jens Axboe <axboe@kernel.dk>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 10/10] fsnotify: optimize the case of no permission event watchers
Date: Sun, 17 Mar 2024 20:41:54 +0200
Message-Id: <20240317184154.1200192-11-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240317184154.1200192-1-amir73il@gmail.com>
References: <20240317184154.1200192-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit e43de7f0862b ("fsnotify: optimize the case of no marks of any type")
optimized the case where there are no fsnotify watchers on any of the
filesystem's objects.

It is quite common for a system to have a single local filesystem and
it is quite common for the system to have some inotify watches on some
config files or directories, so the optimization of no marks at all is
often not in effect.

Permission event watchers, which require high priority group are more
rare, so optimizing the case of no marks og high priority groups can
improve performance for more systems, especially for performance
sensitive io workloads.

Count per-sb watched objects by high priority groups and use that the
optimize out the call to __fsnotify_parent() and fsnotify() in fsnotify
permission hooks.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/notify/fsnotify.c             |  3 +++
 fs/notify/mark.c                 | 30 +++++++++++++++++++++++++++---
 include/linux/fsnotify.h         | 19 ++++++++++++++++---
 include/linux/fsnotify_backend.h | 11 ++++++++---
 4 files changed, 54 insertions(+), 9 deletions(-)

diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
index fb3f36bc6ea9..2ae965ef37e8 100644
--- a/fs/notify/fsnotify.c
+++ b/fs/notify/fsnotify.c
@@ -100,6 +100,9 @@ void fsnotify_sb_delete(struct super_block *sb)
 	/* Wait for outstanding object references from connectors */
 	wait_var_event(fsnotify_sb_watched_objects(sb),
 		       !atomic_long_read(fsnotify_sb_watched_objects(sb)));
+	WARN_ON(fsnotify_sb_has_priority_watchers(sb, FSNOTIFY_PRIO_CONTENT));
+	WARN_ON(fsnotify_sb_has_priority_watchers(sb,
+						  FSNOTIFY_PRIO_PRE_CONTENT));
 	kfree(sbinfo);
 }
 
diff --git a/fs/notify/mark.c b/fs/notify/mark.c
index db053e0e218d..80b7eea1d6d6 100644
--- a/fs/notify/mark.c
+++ b/fs/notify/mark.c
@@ -160,13 +160,36 @@ static void fsnotify_put_inode_ref(struct inode *inode)
 static void fsnotify_update_sb_watchers(struct super_block *sb,
 					struct fsnotify_mark_connector *conn)
 {
+	struct fsnotify_sb_info *sbinfo = fsnotify_sb_info(sb);
 	bool is_watched = conn->flags & FSNOTIFY_CONN_FLAG_IS_WATCHED;
-	bool has_marks = conn->obj && !hlist_empty(&conn->list);
+	struct fsnotify_mark *first_mark = NULL;
+	unsigned int highest_prio = 0;
 
-	if (has_marks && !is_watched) {
+	if (conn->obj)
+		first_mark = hlist_entry_safe(conn->list.first,
+					      struct fsnotify_mark, obj_list);
+	if (first_mark)
+		highest_prio = first_mark->group->priority;
+	if (WARN_ON(highest_prio >= __FSNOTIFY_PRIO_NUM))
+		highest_prio = 0;
+
+	/*
+	 * If the highest priority of group watching this object is prio,
+	 * then watched object has a reference on counters [0..prio].
+	 * Update priority >= 1 watched objects counters.
+	 */
+	for (unsigned int p = conn->prio + 1; p <= highest_prio; p++)
+		atomic_long_inc(&sbinfo->watched_objects[p]);
+	for (unsigned int p = conn->prio; p > highest_prio; p--)
+		atomic_long_dec(&sbinfo->watched_objects[p]);
+	conn->prio = highest_prio;
+
+	/* Update priority >= 0 (a.k.a total) watched objects counter */
+	BUILD_BUG_ON(FSNOTIFY_PRIO_NORMAL != 0);
+	if (first_mark && !is_watched) {
 		conn->flags |= FSNOTIFY_CONN_FLAG_IS_WATCHED;
 		fsnotify_get_sb_watched_objects(sb);
-	} else if (!has_marks && is_watched) {
+	} else if (!first_mark && is_watched) {
 		conn->flags &= ~FSNOTIFY_CONN_FLAG_IS_WATCHED;
 		fsnotify_put_sb_watched_objects(sb);
 	}
@@ -599,6 +622,7 @@ static int fsnotify_attach_connector_to_object(fsnotify_connp_t *connp,
 	spin_lock_init(&conn->lock);
 	INIT_HLIST_HEAD(&conn->list);
 	conn->flags = 0;
+	conn->prio = 0;
 	conn->type = obj_type;
 	conn->obj = obj;
 
diff --git a/include/linux/fsnotify.h b/include/linux/fsnotify.h
index 48dc65702415..4da80e92f804 100644
--- a/include/linux/fsnotify.h
+++ b/include/linux/fsnotify.h
@@ -17,8 +17,9 @@
 #include <linux/slab.h>
 #include <linux/bug.h>
 
-/* Are there any inode/mount/sb objects that are being watched at all? */
-static inline bool fsnotify_sb_has_watchers(struct super_block *sb)
+/* Are there any inode/mount/sb objects watched with priority prio or above? */
+static inline bool fsnotify_sb_has_priority_watchers(struct super_block *sb,
+						     int prio)
 {
 	struct fsnotify_sb_info *sbinfo = fsnotify_sb_info(sb);
 
@@ -26,7 +27,13 @@ static inline bool fsnotify_sb_has_watchers(struct super_block *sb)
 	if (!sbinfo)
 		return false;
 
-	return atomic_long_read(&sbinfo->watched_objects);
+	return atomic_long_read(&sbinfo->watched_objects[prio]);
+}
+
+/* Are there any inode/mount/sb objects that are being watched at all? */
+static inline bool fsnotify_sb_has_watchers(struct super_block *sb)
+{
+	return fsnotify_sb_has_priority_watchers(sb, 0);
 }
 
 /*
@@ -109,6 +116,12 @@ static inline int fsnotify_file(struct file *file, __u32 mask)
 		return 0;
 
 	path = &file->f_path;
+	/* Permission events require group prio >= FSNOTIFY_PRIO_CONTENT */
+	if (mask & ALL_FSNOTIFY_PERM_EVENTS &&
+	    !fsnotify_sb_has_priority_watchers(path->dentry->d_sb,
+					       FSNOTIFY_PRIO_CONTENT))
+		return 0;
+
 	return fsnotify_parent(path->dentry, mask, path, FSNOTIFY_EVENT_PATH);
 }
 
diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
index fc38587d8564..7f1ab8264e41 100644
--- a/include/linux/fsnotify_backend.h
+++ b/include/linux/fsnotify_backend.h
@@ -468,7 +468,8 @@ FSNOTIFY_ITER_FUNCS(sb, SB)
  */
 struct fsnotify_mark_connector {
 	spinlock_t lock;
-	unsigned short type;	/* Type of object [lock] */
+	unsigned char type;	/* Type of object [lock] */
+	unsigned char prio;	/* Highest priority group */
 #define FSNOTIFY_CONN_FLAG_IS_WATCHED	0x01
 #define FSNOTIFY_CONN_FLAG_HAS_IREF	0x02
 	unsigned short flags;	/* flags [lock] */
@@ -490,8 +491,12 @@ struct fsnotify_sb_info {
 	/*
 	 * Number of inode/mount/sb objects that are being watched in this sb.
 	 * Note that inodes objects are currently double-accounted.
+	 *
+	 * The value in watched_objects[prio] is the number of objects that are
+	 * watched by groups of priority >= prio, so watched_objects[0] is the
+	 * total number of watched objects in this sb.
 	 */
-	atomic_long_t watched_objects;
+	atomic_long_t watched_objects[__FSNOTIFY_PRIO_NUM];
 };
 
 static inline struct fsnotify_sb_info *fsnotify_sb_info(struct super_block *sb)
@@ -505,7 +510,7 @@ static inline struct fsnotify_sb_info *fsnotify_sb_info(struct super_block *sb)
 
 static inline atomic_long_t *fsnotify_sb_watched_objects(struct super_block *sb)
 {
-	return &fsnotify_sb_info(sb)->watched_objects;
+	return &fsnotify_sb_info(sb)->watched_objects[0];
 }
 
 /*
-- 
2.34.1


