Return-Path: <linux-fsdevel+bounces-54266-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC86AAFCDCF
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jul 2025 16:37:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA8503A757C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jul 2025 14:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ACBC2E03EE;
	Tue,  8 Jul 2025 14:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S+5JoWoo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C53C92DCF69
	for <linux-fsdevel@vger.kernel.org>; Tue,  8 Jul 2025 14:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751985411; cv=none; b=Cdi54+IOelKYluYSyAqIj06FsF/9tTu6uiEUgBCC2SrS7Ijgk6QYPzZ0Ru09aijHWO/GQmW780+WgPglDc+OsiZSI9714EGRzh1rZvZ4m4uMMi6D8x/bpmdlEA/TPvXDZasVlxpfIpWE7CCDBv3FyXt++FlLZtOAPYOB+GezgqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751985411; c=relaxed/simple;
	bh=bsS3HPmJYVjTetkJVELE+6ta+HXZ1fkN/b76FccwPBM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=isAFtgPxGKq8hyUjnRP3DS8DF7SeEWbL4cu9OumftGFo6Z2u9SqYuZyBYFEFdyo6l7XzD32RlgARUS86mZc1WtzJcMwrrg90kH9ZjnFSo2IMsjx7GYjn85/FvSB2MjlZYwQV3rkh2AK0f0BR+4haXGYK445nHi+Arez/eRHwUPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S+5JoWoo; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-60780d74c8cso6875508a12.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 08 Jul 2025 07:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751985408; x=1752590208; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WHVgvqDx/iassdOkV8iptfaZAs4cjl5RgKKkty6LflM=;
        b=S+5JoWoo4VHEVfHed4ZHvGW1hyCTgmAWABiwR5UDNPj6Yy3JgW/Gutf1Qt9hrNngnq
         2+Tru3M3bRhnamosuf0eWPU65epRwGCNW3F1sPyIoJd95aK3/LqmCYuqZ6cWuawq/D38
         2i4l6rJ57jddUtA0u3UZowpoTLy0z6OTH410IQ8LArXkTe/z977gMJlUcQER/HCTGDNt
         eEnPoSeIU/80+BwZiDATVCpXR92fHQTWDz96H43LpzSVC8pT54cpO4NMRJ+5p5KRdWJe
         8lH0a49Ea6O+bncBrfDhnQ4+1UZG656YJ7EVsqKr/XyfFZNkRosEc1UVQmwB0W+XCt0T
         A8Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751985408; x=1752590208;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WHVgvqDx/iassdOkV8iptfaZAs4cjl5RgKKkty6LflM=;
        b=uad0tyIQINe6mW6F4p/X7bhJXP/dPtUt6e5yMHqxXF8S8l7w9C9F4jzaZZos7URYrk
         25qVaVz5ohVzg0OrUd7APu55nu9aJAdDfowk3kEOs3smpyf9/aWewFdK9d1Sd12a9ntB
         i7h/rbUEBseQZjG67lWU1eT9KMuSpwbZ4f/00+6nI3IWlsZz3FwCBJ411I9AH/IJUewO
         aWfl88ga2hdXE1J3lAJEMjzOcetgbV7CA9T0TleYJv6D3JEXgXiueHniqiKS0UV5MMlE
         1TC16AaeCgsPcpqprLbY8oX418H+YAgrTdVrDo0Ovye3Yd52GuN45Eq9y2u0VkFZsVvH
         W1KA==
X-Forwarded-Encrypted: i=1; AJvYcCXYdstfxwOd998SVq+5rIok7z8kPlDsoHmgvCcpUYvN71O7UhIqNMN9gPkq78AbTjT1qZUS/isAAoriP9z3@vger.kernel.org
X-Gm-Message-State: AOJu0YzDSl9tm1cIXvIqHKTIweSAz7KHTDTkzzAByoSrQV+daBejES85
	r3pmOsmFyckxv9AZfisq6ExLF0oc56p5lrdgnlJu2l2AS9u/wYwLYgLX63aPHxoy
X-Gm-Gg: ASbGncuGNqzjQdiQ+a/ygFxWjc+Kwoh1hzzCDGnP7iaALBLAnNYlNa1/ed80rAMMUcq
	tFMrCnzi52t7j/OaDGIGGo4UL4ZqTFrd3X2eNxnPsOKwgtp13QAR1zYBXxvVO6+rndTA1/97eIX
	i+lNgO7mGkK4va8ZZlDgrfdKMtHN8Lu9Gp6MLH13siqTHWNYi1AOaJq9j+GTHK5Lt6wCDCccBdT
	JA66i+HNmI/T+mTp5P+YH8nT2oJr40rxbHTU/K2XOjC4AfaKDbzdUTLNixq0B1I0338q0SyGbl7
	rPx1dclhT4FeEEpQvw1cRijS2AEduE2wG/GeVMNmlH0DrOBaJKYnozNxFA3oc5NyxTyYnt3g686
	anurLvU1PanCtgBmVdLfKHLTlRLYROy0fK3bqqjYGXlCY6G1f9cUcs4b+O7jiKeo=
X-Google-Smtp-Source: AGHT+IHe1Y5rCbaNHtvpz5mmVVebiZf55TO+37u+e4BdQb95jAZ/zb9QlT3jQ7MQuzPplrP4J499Og==
X-Received: by 2002:a05:6402:1e90:b0:607:2d8a:9b3e with SMTP id 4fb4d7f45d1cf-60fd64e3f4amr12690312a12.2.1751985407564;
        Tue, 08 Jul 2025 07:36:47 -0700 (PDT)
Received: from amir-ThinkPad-T480.ctera.local (92-109-99-123.cable.dynamic.v4.ziggo.nl. [92.109.99.123])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-60fca696574sm7393068a12.28.2025.07.08.07.36.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 07:36:47 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 2/2] fsnotify: optimize FMODE_NONOTIFY_PERM for the common cases
Date: Tue,  8 Jul 2025 16:36:41 +0200
Message-ID: <20250708143641.418603-3-amir73il@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250708143641.418603-1-amir73il@gmail.com>
References: <20250708143641.418603-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The most unlikely watched permission event is FAN_ACCESS_PERM, because
at the time that it was introduced there were no evictable ignore mark,
so subscribing to FAN_ACCESS_PERM would have incured a very high
overhead.

Yet, when we set the fmode to FMODE_NOTIFY_HSM(), we never skip trying
to send FAN_ACCESS_PERM, which is almost always a waste of cycles.

We got to this logic because of bundling open permisson events and access
permission events in the same category and because FAN_OPEN_PERM is a
commonly used event.

By open coding fsnotify_open_perm() in fsnotify_open_perm_and_set_mode(),
we no longer need to regard FAN_OPEN*_PERM when calculating fmode.

This leaves the case of having pre-content events and not having access
permission events in the object masks a more likely case than the other
way around.

Rework the fmode macros and code so that their meaning now refers only
to hooks on an already open file:

- FMODE_NOTIFY_NONE()		skip all events
- FMODE_NOTIFY_ACCESS_PERM()	send all access permission events
- FMODE_NOTIFY_HSM()		send pre-conent permission events

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/notify/fsnotify.c     | 75 ++++++++++++++++++++++++----------------
 include/linux/fs.h       | 12 +++----
 include/linux/fsnotify.h | 27 ++-------------
 3 files changed, 53 insertions(+), 61 deletions(-)

diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
index de7e7425428b..079b868552c2 100644
--- a/fs/notify/fsnotify.c
+++ b/fs/notify/fsnotify.c
@@ -199,8 +199,8 @@ static bool fsnotify_event_needs_parent(struct inode *inode, __u32 mnt_mask,
 }
 
 /* Are there any inode/mount/sb objects that watch for these events? */
-static inline bool fsnotify_object_watched(struct inode *inode, __u32 mnt_mask,
-					   __u32 mask)
+static inline __u32 fsnotify_object_watched(struct inode *inode, __u32 mnt_mask,
+					    __u32 mask)
 {
 	__u32 marks_mask = READ_ONCE(inode->i_fsnotify_mask) | mnt_mask |
 			   READ_ONCE(inode->i_sb->s_fsnotify_mask);
@@ -665,7 +665,7 @@ int fsnotify_open_perm_and_set_mode(struct file *file)
 {
 	struct dentry *dentry = file->f_path.dentry, *parent;
 	struct super_block *sb = dentry->d_sb;
-	__u32 mnt_mask, p_mask;
+	__u32 mnt_mask, p_mask = 0;
 
 	/* Is it a file opened by fanotify? */
 	if (FMODE_FSNOTIFY_NONE(file->f_mode))
@@ -683,45 +683,60 @@ int fsnotify_open_perm_and_set_mode(struct file *file)
 	}
 
 	/*
-	 * If there are permission event watchers but no pre-content event
-	 * watchers, set FMODE_NONOTIFY | FMODE_NONOTIFY_PERM to indicate that.
+	 * OK, there are some permission event watchers. Check if anybody is
+	 * watching for permission events on *this* file.
 	 */
-	if ((!d_is_dir(dentry) && !d_is_reg(dentry)) ||
-	    likely(!fsnotify_sb_has_priority_watchers(sb,
-						FSNOTIFY_PRIO_PRE_CONTENT))) {
-		file_set_fsnotify_mode(file, FMODE_NONOTIFY |
-				       FMODE_NONOTIFY_PERM);
-		goto open_perm;
+	mnt_mask = READ_ONCE(real_mount(file->f_path.mnt)->mnt_fsnotify_mask);
+	p_mask = fsnotify_object_watched(d_inode(dentry), mnt_mask,
+					 ALL_FSNOTIFY_PERM_EVENTS);
+	if (dentry->d_flags & DCACHE_FSNOTIFY_PARENT_WATCHED) {
+		parent = dget_parent(dentry);
+		p_mask |= fsnotify_inode_watches_children(d_inode(parent));
+		dput(parent);
 	}
 
 	/*
-	 * OK, there are some pre-content watchers. Check if anybody is
-	 * watching for pre-content events on *this* file.
+	 * Legacy FAN_ACCESS_PERM events have very high performance overhead,
+	 * so unlikely to be used in the wild. If they are used there will be
+	 * no optimizations at all.
 	 */
-	mnt_mask = READ_ONCE(real_mount(file->f_path.mnt)->mnt_fsnotify_mask);
-	if (unlikely(fsnotify_object_watched(d_inode(dentry), mnt_mask,
-				     FSNOTIFY_PRE_CONTENT_EVENTS))) {
-		/* Enable pre-content events */
+	if (unlikely(p_mask & FS_ACCESS_PERM)) {
+		/* Enable all permission and pre-content events */
 		file_set_fsnotify_mode(file, 0);
 		goto open_perm;
 	}
 
-	/* Is parent watching for pre-content events on this file? */
-	if (dentry->d_flags & DCACHE_FSNOTIFY_PARENT_WATCHED) {
-		parent = dget_parent(dentry);
-		p_mask = fsnotify_inode_watches_children(d_inode(parent));
-		dput(parent);
-		if (p_mask & FSNOTIFY_PRE_CONTENT_EVENTS) {
-			/* Enable pre-content events */
-			file_set_fsnotify_mode(file, 0);
-			goto open_perm;
-		}
+	/*
+	 * Pre-content events are only supported on regular files.
+	 * If there are pre-content event watchers and no permission access
+	 * watchers, set FMODE_NONOTIFY | FMODE_NONOTIFY_PERM to indicate that.
+	 * That is the common case with HSM service.
+	 */
+	if (d_is_reg(dentry) && (p_mask & FSNOTIFY_PRE_CONTENT_EVENTS)) {
+		file_set_fsnotify_mode(file, FMODE_NONOTIFY |
+					     FMODE_NONOTIFY_PERM);
+		goto open_perm;
 	}
-	/* Nobody watching for pre-content events from this file */
-	file_set_fsnotify_mode(file, FMODE_NONOTIFY | FMODE_NONOTIFY_PERM);
+
+	/* Nobody watching permission and pre-content events on this file */
+	file_set_fsnotify_mode(file, FMODE_NONOTIFY_PERM);
 
 open_perm:
-	return fsnotify_open_perm(file);
+	/*
+	 * Send open perm events depending on object masks and regardless of
+	 * FMODE_NONOTIFY_PERM.
+	 */
+	if (file->f_flags & __FMODE_EXEC && p_mask & FS_OPEN_EXEC_PERM) {
+		int ret = fsnotify_path(&file->f_path, FS_OPEN_EXEC_PERM);
+
+		if (ret)
+			return ret;
+	}
+
+	if (p_mask & FS_OPEN_PERM)
+		return fsnotify_path(&file->f_path, FS_OPEN_PERM);
+
+	return 0;
 }
 #endif
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 3b074fe4c8a9..81a6463bfd76 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -200,12 +200,12 @@ typedef int (dio_iodone_t)(struct kiocb *iocb, loff_t offset,
 
 /*
  * The two FMODE_NONOTIFY* define which fsnotify events should not be generated
- * for a file. These are the possible values of (f->f_mode &
- * FMODE_FSNOTIFY_MASK) and their meaning:
+ * for an open file. These are the possible values of
+ * (f->f_mode & FMODE_FSNOTIFY_MASK) and their meaning:
  *
  * FMODE_NONOTIFY - suppress all (incl. non-permission) events.
  * FMODE_NONOTIFY_PERM - suppress permission (incl. pre-content) events.
- * FMODE_NONOTIFY | FMODE_NONOTIFY_PERM - suppress only pre-content events.
+ * FMODE_NONOTIFY | FMODE_NONOTIFY_PERM - suppress only FAN_ACCESS_PERM.
  */
 #define FMODE_FSNOTIFY_MASK \
 	(FMODE_NONOTIFY | FMODE_NONOTIFY_PERM)
@@ -213,13 +213,13 @@ typedef int (dio_iodone_t)(struct kiocb *iocb, loff_t offset,
 #define FMODE_FSNOTIFY_NONE(mode) \
 	((mode & FMODE_FSNOTIFY_MASK) == FMODE_NONOTIFY)
 #ifdef CONFIG_FANOTIFY_ACCESS_PERMISSIONS
-#define FMODE_FSNOTIFY_PERM(mode) \
+#define FMODE_FSNOTIFY_HSM(mode) \
 	((mode & FMODE_FSNOTIFY_MASK) == 0 || \
 	 (mode & FMODE_FSNOTIFY_MASK) == (FMODE_NONOTIFY | FMODE_NONOTIFY_PERM))
-#define FMODE_FSNOTIFY_HSM(mode) \
+#define FMODE_FSNOTIFY_ACCESS_PERM(mode) \
 	((mode & FMODE_FSNOTIFY_MASK) == 0)
 #else
-#define FMODE_FSNOTIFY_PERM(mode)	0
+#define FMODE_FSNOTIFY_ACCESS_PERM(mode) 0
 #define FMODE_FSNOTIFY_HSM(mode)	0
 #endif
 
diff --git a/include/linux/fsnotify.h b/include/linux/fsnotify.h
index 8c1fa617d375..28a9cb13fbfa 100644
--- a/include/linux/fsnotify.h
+++ b/include/linux/fsnotify.h
@@ -147,9 +147,6 @@ static inline int fsnotify_file_area_perm(struct file *file, int perm_mask,
 	if (!(perm_mask & (MAY_READ | MAY_WRITE | MAY_ACCESS)))
 		return 0;
 
-	if (likely(!FMODE_FSNOTIFY_PERM(file->f_mode)))
-		return 0;
-
 	/*
 	 * read()/write() and other types of access generate pre-content events.
 	 */
@@ -160,7 +157,8 @@ static inline int fsnotify_file_area_perm(struct file *file, int perm_mask,
 			return ret;
 	}
 
-	if (!(perm_mask & MAY_READ))
+	if (!(perm_mask & MAY_READ) ||
+	    likely(!FMODE_FSNOTIFY_ACCESS_PERM(file->f_mode)))
 		return 0;
 
 	/*
@@ -208,22 +206,6 @@ static inline int fsnotify_file_perm(struct file *file, int perm_mask)
 	return fsnotify_file_area_perm(file, perm_mask, NULL, 0);
 }
 
-/*
- * fsnotify_open_perm - permission hook before file open
- */
-static inline int fsnotify_open_perm(struct file *file)
-{
-	int ret;
-
-	if (file->f_flags & __FMODE_EXEC) {
-		ret = fsnotify_path(&file->f_path, FS_OPEN_EXEC_PERM);
-		if (ret)
-			return ret;
-	}
-
-	return fsnotify_path(&file->f_path, FS_OPEN_PERM);
-}
-
 #else
 static inline int fsnotify_open_perm_and_set_mode(struct file *file)
 {
@@ -251,11 +233,6 @@ static inline int fsnotify_file_perm(struct file *file, int perm_mask)
 {
 	return 0;
 }
-
-static inline int fsnotify_open_perm(struct file *file)
-{
-	return 0;
-}
 #endif
 
 /*
-- 
2.43.0


