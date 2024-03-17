Return-Path: <linux-fsdevel+bounces-14649-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F30087DF49
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Mar 2024 19:43:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43C54B20C28
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Mar 2024 18:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7133320DF7;
	Sun, 17 Mar 2024 18:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uk6PM8Bw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E26BB208BA
	for <linux-fsdevel@vger.kernel.org>; Sun, 17 Mar 2024 18:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710700934; cv=none; b=HmwPbPJlKeLP2Px+cncsNcZuN2rOt0vF9dLIyGArVRQMzqG1XTXxerUdu3n7AnLbof4RUa345o87zldl5LL3Enhx7d6orbaAD0KD2oMeMNm1Vkg0lpPPxgLS7bTbOcEIXFt/5Z04P/8z9s9IAhzj+ioakaHpBFRLMC6AZ+wZCBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710700934; c=relaxed/simple;
	bh=T3DaO3DSvn6xXv7EWLnro9hxB3JbryatzpQe5w6MesE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=h+CQ3qWF1RT3/EhEzSc+2vCHzggKBf+Hw2Hfch1+llvQBRgEJ2q32XJSknIr/IAYtfAUuulmmySrlb14E01CNBfuQUBu5PsP/VHmnZxu1ZJm9y/itpc4b9s2oJGFc+8kAeqtkhviARjSa/y28oAEePJrtJw0PPN07xqP/x+D4bA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uk6PM8Bw; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3412f49bac7so603832f8f.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 17 Mar 2024 11:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710700931; x=1711305731; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bf53CISxu5XmpC1Cn7wz9xq0f1Pdbw7SeJFIk+TAN4M=;
        b=Uk6PM8BwA/JRD/cIGXqG/LvaNHRHoHqE2FRl5YXO058YsoKHCDB6FqeP8NvJfzN+6j
         ecHs+k1Sxwi4CZMyQbxAr3n2AhwAeFU+5X9BYkzEP54T2HEngjajIqdCZfL2LIH8pcFC
         GU61dHT4oLAhnHjWnfMQUa2uJ/iuXQCoYsmBCOjR9aXEUQnOjD7HW8S6J0xRF5KIslSc
         uwfMrxOR7AoSWrYMXU+4xHokJg6pQZ3zDsYbClTrX+dInnQI0og6QbBn805xpFUBXjxR
         8ICek7Lw0uj8GsJ4/Pth687DPNg/aC77oqLuPp8HgXpVmPVYHWj0TP6OqK1bV+VF2Ib6
         1CLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710700931; x=1711305731;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bf53CISxu5XmpC1Cn7wz9xq0f1Pdbw7SeJFIk+TAN4M=;
        b=UtLMc+VehVyj71TVk/J6TXh0c98AFVaP2B14sO1MQQ1RpU/Lp8m8hb6hfeYzwtPAK7
         VdZG3tT6vDMh9w4UCYZEx4TEdcAYk6f765WjYdFWXRBW1pN1EL0/0Dj0amdFI4XOd3zY
         PBs3I34fUWojO76Az7opnxLpID1fWSllLLFzJl7X4zoG2SFH7btejFXuzvKUXmpgxo50
         IS9uaSIlIJZSPDB+v0tUg9hXxABOz6HejiRtwL/ezzst6sOV+PBSHQgnASDA999llqmL
         OYmjmKDfCdlFFWAP2ZmQD9bGrF32FrOoklT2PSLSILUbEIvlENjTJVNsskxl5QU2CN4w
         qefg==
X-Forwarded-Encrypted: i=1; AJvYcCWYOGLkheoSCCH6B6k+sC24pnAv+E7vxeRsri0nsjlg56B9u+RpPKDB70ygwkqQKCNTJIGdHlf22Gmh2yDdTY52G39XUbrEMGcYKXI6Nw==
X-Gm-Message-State: AOJu0Yxms+Q2xOlAyM91gFiGpT3jbx2a8c0LAVFHA9Q6sXwdoLEapTIy
	qbITPa9UWKfRgdaKsu3XiexnrmFPWXl6tnk1J8UhylWZf8yiNvtZKXtO0TnS
X-Google-Smtp-Source: AGHT+IGrFcVqVFrdfwQ19CEIGENheUCwwtRSM+1qWaHn6JrSL3rUQwwdI59OU8PhGUNU8Y0hAUDOKg==
X-Received: by 2002:a05:6000:ad2:b0:33e:c7e2:2b64 with SMTP id di18-20020a0560000ad200b0033ec7e22b64mr4124571wrb.42.1710700931150;
        Sun, 17 Mar 2024 11:42:11 -0700 (PDT)
Received: from amir-ThinkPad-T480.lan (85-250-214-4.bb.netvision.net.il. [85.250.214.4])
        by smtp.gmail.com with ESMTPSA id bk28-20020a0560001d9c00b0033e22a7b3f8sm3070716wrb.75.2024.03.17.11.42.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Mar 2024 11:42:10 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Jan Kara <jack@suse.cz>,
	Jens Axboe <axboe@kernel.dk>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 07/10] fsnotify: lazy attach fsnotify_sb_info state to sb
Date: Sun, 17 Mar 2024 20:41:51 +0200
Message-Id: <20240317184154.1200192-8-amir73il@gmail.com>
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

Define a container struct fsnotify_sb_info to hold per-sb state,
including the reference to sb marks connector.

Allocate the fsnotify_sb_info state before attaching connector to any
object on the sb and free it only when killing sb.

This state is going to be used for storing per priority watched objects
counters.

Suggested-by: Jan Kara <jack@suse.cz>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/notify/fsnotify.c             | 16 +++++++++++++---
 fs/notify/fsnotify.h             |  9 ++++++++-
 fs/notify/mark.c                 | 32 +++++++++++++++++++++++++++++++-
 include/linux/fs.h               |  8 ++++----
 include/linux/fsnotify_backend.h | 17 +++++++++++++++++
 5 files changed, 73 insertions(+), 9 deletions(-)

diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
index 503e7c75e777..fb3f36bc6ea9 100644
--- a/fs/notify/fsnotify.c
+++ b/fs/notify/fsnotify.c
@@ -89,11 +89,18 @@ static void fsnotify_unmount_inodes(struct super_block *sb)
 
 void fsnotify_sb_delete(struct super_block *sb)
 {
+	struct fsnotify_sb_info *sbinfo = fsnotify_sb_info(sb);
+
+	/* Were any marks ever added to any object on this sb? */
+	if (!sbinfo)
+		return;
+
 	fsnotify_unmount_inodes(sb);
 	fsnotify_clear_marks_by_sb(sb);
 	/* Wait for outstanding object references from connectors */
 	wait_var_event(fsnotify_sb_watched_objects(sb),
 		       !atomic_long_read(fsnotify_sb_watched_objects(sb)));
+	kfree(sbinfo);
 }
 
 /*
@@ -489,6 +496,7 @@ int fsnotify(__u32 mask, const void *data, int data_type, struct inode *dir,
 {
 	const struct path *path = fsnotify_data_path(data, data_type);
 	struct super_block *sb = fsnotify_data_sb(data, data_type);
+	struct fsnotify_sb_info *sbinfo = fsnotify_sb_info(sb);
 	struct fsnotify_iter_info iter_info = {};
 	struct mount *mnt = NULL;
 	struct inode *inode2 = NULL;
@@ -525,7 +533,7 @@ int fsnotify(__u32 mask, const void *data, int data_type, struct inode *dir,
 	 * SRCU because we have no references to any objects and do not
 	 * need SRCU to keep them "alive".
 	 */
-	if (!sb->s_fsnotify_marks &&
+	if ((!sbinfo || !sbinfo->sb_marks) &&
 	    (!mnt || !mnt->mnt_fsnotify_marks) &&
 	    (!inode || !inode->i_fsnotify_marks) &&
 	    (!inode2 || !inode2->i_fsnotify_marks))
@@ -552,8 +560,10 @@ int fsnotify(__u32 mask, const void *data, int data_type, struct inode *dir,
 
 	iter_info.srcu_idx = srcu_read_lock(&fsnotify_mark_srcu);
 
-	iter_info.marks[FSNOTIFY_ITER_TYPE_SB] =
-		fsnotify_first_mark(&sb->s_fsnotify_marks);
+	if (sbinfo) {
+		iter_info.marks[FSNOTIFY_ITER_TYPE_SB] =
+			fsnotify_first_mark(&sbinfo->sb_marks);
+	}
 	if (mnt) {
 		iter_info.marks[FSNOTIFY_ITER_TYPE_VFSMOUNT] =
 			fsnotify_first_mark(&mnt->mnt_fsnotify_marks);
diff --git a/fs/notify/fsnotify.h b/fs/notify/fsnotify.h
index 8b73ad45cc71..378f9ec6d64b 100644
--- a/fs/notify/fsnotify.h
+++ b/fs/notify/fsnotify.h
@@ -53,6 +53,13 @@ static inline struct super_block *fsnotify_connector_sb(
 	return fsnotify_object_sb(conn->obj, conn->type);
 }
 
+static inline fsnotify_connp_t *fsnotify_sb_marks(struct super_block *sb)
+{
+	struct fsnotify_sb_info *sbinfo = fsnotify_sb_info(sb);
+
+	return sbinfo ? &sbinfo->sb_marks : NULL;
+}
+
 /* destroy all events sitting in this groups notification queue */
 extern void fsnotify_flush_notify(struct fsnotify_group *group);
 
@@ -78,7 +85,7 @@ static inline void fsnotify_clear_marks_by_mount(struct vfsmount *mnt)
 /* run the list of all marks associated with sb and destroy them */
 static inline void fsnotify_clear_marks_by_sb(struct super_block *sb)
 {
-	fsnotify_destroy_marks(&sb->s_fsnotify_marks);
+	fsnotify_destroy_marks(fsnotify_sb_marks(sb));
 }
 
 /*
diff --git a/fs/notify/mark.c b/fs/notify/mark.c
index 0b703f9e6344..db053e0e218d 100644
--- a/fs/notify/mark.c
+++ b/fs/notify/mark.c
@@ -105,7 +105,7 @@ static fsnotify_connp_t *fsnotify_object_connp(void *obj, int obj_type)
 	case FSNOTIFY_OBJ_TYPE_VFSMOUNT:
 		return &real_mount(obj)->mnt_fsnotify_marks;
 	case FSNOTIFY_OBJ_TYPE_SB:
-		return &((struct super_block *)obj)->s_fsnotify_marks;
+		return fsnotify_sb_marks(obj);
 	default:
 		return NULL;
 	}
@@ -568,6 +568,26 @@ int fsnotify_compare_groups(struct fsnotify_group *a, struct fsnotify_group *b)
 	return -1;
 }
 
+static int fsnotify_attach_info_to_sb(struct super_block *sb)
+{
+	struct fsnotify_sb_info *sbinfo;
+
+	/* sb info is freed on fsnotify_sb_delete() */
+	sbinfo = kzalloc(sizeof(*sbinfo), GFP_KERNEL);
+	if (!sbinfo)
+		return -ENOMEM;
+
+	/*
+	 * cmpxchg() provides the barrier so that callers of fsnotify_sb_info()
+	 * will observe an initialized structure
+	 */
+	if (cmpxchg(&sb->s_fsnotify_info, NULL, sbinfo)) {
+		/* Someone else created sbinfo for us */
+		kfree(sbinfo);
+	}
+	return 0;
+}
+
 static int fsnotify_attach_connector_to_object(fsnotify_connp_t *connp,
 					       void *obj, unsigned int obj_type)
 {
@@ -639,6 +659,16 @@ static int fsnotify_add_mark_list(struct fsnotify_mark *mark, void *obj,
 	if (WARN_ON(!fsnotify_valid_obj_type(obj_type)))
 		return -EINVAL;
 
+	/*
+	 * Attach the sb info before attaching a connector to any object on sb.
+	 * The sb info will remain attached as long as sb lives.
+	 */
+	if (!fsnotify_sb_info(sb)) {
+		err = fsnotify_attach_info_to_sb(sb);
+		if (err)
+			return err;
+	}
+
 	connp = fsnotify_object_connp(obj, obj_type);
 restart:
 	spin_lock(&mark->lock);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 00fc429b0af0..7f40b592f711 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -73,6 +73,8 @@ struct fscrypt_inode_info;
 struct fscrypt_operations;
 struct fsverity_info;
 struct fsverity_operations;
+struct fsnotify_mark_connector;
+struct fsnotify_sb_info;
 struct fs_context;
 struct fs_parameter_spec;
 struct fileattr;
@@ -620,8 +622,6 @@ is_uncached_acl(struct posix_acl *acl)
 #define IOP_XATTR	0x0008
 #define IOP_DEFAULT_READLINK	0x0010
 
-struct fsnotify_mark_connector;
-
 /*
  * Keep mostly read-only and often accessed (especially for
  * the RCU path lookup and 'stat' data) fields at the beginning
@@ -1249,7 +1249,7 @@ struct super_block {
 
 	/*
 	 * Keep s_fs_info, s_time_gran, s_fsnotify_mask, and
-	 * s_fsnotify_marks together for cache efficiency. They are frequently
+	 * s_fsnotify_info together for cache efficiency. They are frequently
 	 * accessed and rarely modified.
 	 */
 	void			*s_fs_info;	/* Filesystem private info */
@@ -1261,7 +1261,7 @@ struct super_block {
 	time64_t		   s_time_max;
 #ifdef CONFIG_FSNOTIFY
 	__u32			s_fsnotify_mask;
-	struct fsnotify_mark_connector __rcu	*s_fsnotify_marks;
+	struct fsnotify_sb_info	*s_fsnotify_info;
 #endif
 
 	/*
diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
index 83004d9e07a3..c9f2b2f6b493 100644
--- a/include/linux/fsnotify_backend.h
+++ b/include/linux/fsnotify_backend.h
@@ -477,6 +477,23 @@ struct fsnotify_mark_connector {
 	struct hlist_head list;
 };
 
+/*
+ * Container for per-sb fsnotify state (sb marks and more).
+ * Attached lazily on first marked object on the sb and freed when killing sb.
+ */
+struct fsnotify_sb_info {
+	struct fsnotify_mark_connector __rcu *sb_marks;
+};
+
+static inline struct fsnotify_sb_info *fsnotify_sb_info(struct super_block *sb)
+{
+#ifdef CONFIG_FSNOTIFY
+	return READ_ONCE(sb->s_fsnotify_info);
+#else
+	return NULL;
+#endif
+}
+
 static inline atomic_long_t *fsnotify_sb_watched_objects(struct super_block *sb)
 {
 	return &sb->s_fsnotify_connectors;
-- 
2.34.1


