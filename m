Return-Path: <linux-fsdevel+bounces-24269-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A389993C840
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jul 2024 20:20:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A54CC1C217D5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jul 2024 18:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C944C3AC0F;
	Thu, 25 Jul 2024 18:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="fXYbX5AG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2CA4210FB
	for <linux-fsdevel@vger.kernel.org>; Thu, 25 Jul 2024 18:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721931610; cv=none; b=C3ZCmf/rlh62+61DuN/nMc3/+xTcVREhRwIJy0+DVsOiRclMmG1CQtPALyBEbfHlTNB6tF51bFSTLS+r7ww2BdjSdvK0BnshSFTB30jzBjLr/yjpuaxr6FvNQwMnYXNUc3Sa6LiHEbDbkH6qc6NZqFavYBQ06z9ovcf1lPFO6Pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721931610; c=relaxed/simple;
	bh=cvmt9CUFxnJqv+g71TV+PJxoVCsc6QSwoCbYSWpnLso=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=itPZkWjYnz+lv+X1iiVqVn0PauNrYs82tb9uoZGxyMAlyvBR5dnPRpfyqp/W2qcMDndZHUdFMkOXVOzT5n2WJN4jwj3Sz7Y9YbkN8cnt7n+N+9TLTDmf15+WZtCJ+vD02u0dGScm7lAfCo1dD9vjjf4cl2vg9m4tEsgEOaTuZek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=fXYbX5AG; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-447e1eb0117so6105701cf.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 Jul 2024 11:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1721931607; x=1722536407; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NegxmTyyNJaofiUGlr7NnyeZp7kMSUr0JaDHxYkqFn8=;
        b=fXYbX5AG6VRZGpIKMbw41ZLr0GkRtRhOpIwE5g6oTgEHIV0Ec5XMVMtMreCxUtM3Jo
         MNNZ4/YEApZwO9tPRvBRZBtCaeFJzKnSb9mmwsEHuTxSFeSDJ38bma/atbx+jbTNbQ1Z
         a4QhnSoydZ/4MKRQnv8QKN1WNmYxZt2EpsNr3NPBm9svO3e8Mu6XweCzvLTNQtYqh71o
         /4Ze8N/HMuV/Qy0BlOIe86Do998f+cKZoMDph/KqLhK3psyO07JZ9zlt/+UJbfBCIcIh
         ez1yAjeLxaw7eXD8cExWUsaWCYXFnXCc4Z1wj5jiz0bAuYpVrJ3IpE41FVPS34/QFmkK
         2Tog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721931607; x=1722536407;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NegxmTyyNJaofiUGlr7NnyeZp7kMSUr0JaDHxYkqFn8=;
        b=ePqScSfaN0GXehvCLytzjiqTDuePwfzXDLlLbcizKr+kh1Yvpm3qlHI6yywixFExTr
         id5fdY6j5Qpb8Qmtq4VnPEF4oD+RMLP1wrP7MqUpaVXJPJJ3rK5eMFGU1OytUYlYditW
         O7QzMIn+SrB84c0pCm90XrQ6RVfB3RkDOKfEb+2wniEacd+oKwmHr5f80gB2iGDYlv3H
         vH2mjZEPMCIInS5bbLkLsKP0kVIupFdmELAnRDqKUmawl4gqzOaZAe2U+1wDBNtxWnur
         Q4Aul3r5GsisMP24VZAkK/lHRWV2J0rnhTWWT0L3k53LuKIpj9Q+z7qTLsboCf99XJVd
         LZiQ==
X-Forwarded-Encrypted: i=1; AJvYcCW9/81a6Q8oSxMg6/Mxc4E4dFiSl6rPAzdWArssnrCrlivzFePVos+5HMvtIW9mI14DBwVljo6C/AWes79BH0k1arbhYoUjspsoYLqQGA==
X-Gm-Message-State: AOJu0Yz0pJI3vjkqAuaU2X5ppw/AS1m6ENdRJInlw1g1KdmDiAu8gkqf
	45uxIKEeZnGaRkRatPNW+Sljw2eBUFbl+T4gY7Ar86DAi9YwixQj3d7rcXtpsdA=
X-Google-Smtp-Source: AGHT+IG+qFu+xHZjvF4GRjRqCzPXkPm/TDWqBObxw/C0v3WX7HXpS8f/KobFZCtDD2Zh09sbPZJrrQ==
X-Received: by 2002:a05:6214:2267:b0:6b5:44e4:eb3f with SMTP id 6a1803df08f44-6bb40878e9cmr34635086d6.47.1721931607353;
        Thu, 25 Jul 2024 11:20:07 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb3facabbcsm9508226d6.117.2024.07.25.11.20.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 11:20:06 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org,
	jack@suse.cz,
	amir73il@gmail.com,
	brauner@kernel.org
Subject: [PATCH 02/10] fsnotify: introduce pre-content permission event
Date: Thu, 25 Jul 2024 14:19:39 -0400
Message-ID: <a6010470b2d11f186cba89b9521940716fa66f3b.1721931241.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1721931241.git.josef@toxicpanda.com>
References: <cover.1721931241.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Amir Goldstein <amir73il@gmail.com>

The new FS_PRE_ACCESS permission event is similar to FS_ACCESS_PERM,
but it meant for a different use case of filling file content before
access to a file range, so it has slightly different semantics.

Generate FS_PRE_ACCESS/FS_ACCESS_PERM as two seperate events, same as
we did for FS_OPEN_PERM/FS_OPEN_EXEC_PERM.

FS_PRE_MODIFY is a new permission event, with similar semantics as
FS_PRE_ACCESS, which is called before a file is modified.

FS_ACCESS_PERM is reported also on blockdev and pipes, but the new
pre-content events are only reported for regular files and dirs.

The pre-content events are meant to be used by hierarchical storage
managers that want to fill the content of files on first access.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/notify/fsnotify.c             |  2 +-
 include/linux/fsnotify.h         | 27 ++++++++++++++++++++++++---
 include/linux/fsnotify_backend.h | 13 +++++++++++--
 security/selinux/hooks.c         |  3 ++-
 4 files changed, 38 insertions(+), 7 deletions(-)

diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
index 272c8a1dab3c..1ca4a8da7f29 100644
--- a/fs/notify/fsnotify.c
+++ b/fs/notify/fsnotify.c
@@ -621,7 +621,7 @@ static __init int fsnotify_init(void)
 {
 	int ret;
 
-	BUILD_BUG_ON(HWEIGHT32(ALL_FSNOTIFY_BITS) != 23);
+	BUILD_BUG_ON(HWEIGHT32(ALL_FSNOTIFY_BITS) != 25);
 
 	ret = init_srcu_struct(&fsnotify_mark_srcu);
 	if (ret)
diff --git a/include/linux/fsnotify.h b/include/linux/fsnotify.h
index 278620e063ab..028ce807805a 100644
--- a/include/linux/fsnotify.h
+++ b/include/linux/fsnotify.h
@@ -133,12 +133,13 @@ static inline int fsnotify_file(struct file *file, __u32 mask)
 
 #ifdef CONFIG_FANOTIFY_ACCESS_PERMISSIONS
 /*
- * fsnotify_file_area_perm - permission hook before access to file range
+ * fsnotify_file_area_perm - permission hook before access/modify of file range
  */
 static inline int fsnotify_file_area_perm(struct file *file, int perm_mask,
 					  const loff_t *ppos, size_t count)
 {
-	__u32 fsnotify_mask = FS_ACCESS_PERM;
+	struct inode *inode = file_inode(file);
+	__u32 fsnotify_mask;
 
 	/*
 	 * filesystem may be modified in the context of permission events
@@ -147,7 +148,27 @@ static inline int fsnotify_file_area_perm(struct file *file, int perm_mask,
 	 */
 	lockdep_assert_once(file_write_not_started(file));
 
-	if (!(perm_mask & MAY_READ))
+	/*
+	 * Generate FS_PRE_ACCESS/FS_ACCESS_PERM as two seperate events.
+	 */
+	if (perm_mask & MAY_READ) {
+		int ret = fsnotify_file(file, FS_ACCESS_PERM);
+
+		if (ret)
+			return ret;
+	}
+
+	/*
+	 * Pre-content events are only reported for regular files and dirs.
+	 */
+	if (!S_ISDIR(inode->i_mode) && !S_ISREG(inode->i_mode))
+		return 0;
+
+	if (perm_mask & MAY_WRITE)
+		fsnotify_mask = FS_PRE_MODIFY;
+	else if (perm_mask & MAY_READ)
+		fsnotify_mask = FS_PRE_ACCESS;
+	else
 		return 0;
 
 	return fsnotify_file(file, fsnotify_mask);
diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
index 8be029bc50b1..21e72b837ec5 100644
--- a/include/linux/fsnotify_backend.h
+++ b/include/linux/fsnotify_backend.h
@@ -56,6 +56,9 @@
 #define FS_ACCESS_PERM		0x00020000	/* access event in a permissions hook */
 #define FS_OPEN_EXEC_PERM	0x00040000	/* open/exec event in a permission hook */
 
+#define FS_PRE_ACCESS		0x00100000	/* Pre-content access hook */
+#define FS_PRE_MODIFY		0x00200000	/* Pre-content modify hook */
+
 /*
  * Set on inode mark that cares about things that happen to its children.
  * Always set for dnotify and inotify.
@@ -77,8 +80,14 @@
  */
 #define ALL_FSNOTIFY_DIRENT_EVENTS (FS_CREATE | FS_DELETE | FS_MOVE | FS_RENAME)
 
-#define ALL_FSNOTIFY_PERM_EVENTS (FS_OPEN_PERM | FS_ACCESS_PERM | \
-				  FS_OPEN_EXEC_PERM)
+/* Content events can be used to inspect file content */
+#define FSNOTIFY_CONTENT_PERM_EVENTS (FS_OPEN_PERM | FS_OPEN_EXEC_PERM | \
+				      FS_ACCESS_PERM)
+/* Pre-content events can be used to fill file content */
+#define FSNOTIFY_PRE_CONTENT_EVENTS  (FS_PRE_ACCESS | FS_PRE_MODIFY)
+
+#define ALL_FSNOTIFY_PERM_EVENTS (FSNOTIFY_CONTENT_PERM_EVENTS | \
+				  FSNOTIFY_PRE_CONTENT_EVENTS)
 
 /*
  * This is a list of all events that may get sent to a parent that is watching
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 55c78c318ccd..2997edf3e7cd 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -3406,7 +3406,8 @@ static int selinux_path_notify(const struct path *path, u64 mask,
 		perm |= FILE__WATCH_WITH_PERM;
 
 	/* watches on read-like events need the file:watch_reads permission */
-	if (mask & (FS_ACCESS | FS_ACCESS_PERM | FS_CLOSE_NOWRITE))
+	if (mask & (FS_ACCESS | FS_ACCESS_PERM | FS_PRE_ACCESS |
+		    FS_CLOSE_NOWRITE))
 		perm |= FILE__WATCH_READS;
 
 	return path_has_perm(current_cred(), path, perm);
-- 
2.43.0


