Return-Path: <linux-fsdevel+bounces-9998-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 90EBB846E8C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 12:02:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B58DA1C2463D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 11:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5B7813D4F2;
	Fri,  2 Feb 2024 11:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VUBd4h1g"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 712FE79DB2;
	Fri,  2 Feb 2024 11:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706871704; cv=none; b=J/xP1fDrnEtvR4hmXUohID/7L9IvnMIREetUHqlhOJC8OCbzLaScJ4XbIlS8Z0zNeqvmgIdr3D8bttcI/dbRx53NRzPVm4HiQ7Bkg49dU4o4rVa6quyoCs8/yVCelef0796k8dmSU4kaOFCmocTWaogY5vIFwZY5unuV1ihN1D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706871704; c=relaxed/simple;
	bh=JpTsbx9gyOD4RFI4BcOrfqAvIDDOqduZidyXVQpyvwE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uPJgFqxHpWK7I6kRsu5JfzaDklRFIGcqTT/x1aGGKTuDuva4nmrv60epn3TcITVtDjpdh/s5sD4rzbSP/qotTpT1GdnFHHoCRwfL3iD9MGTea2rVZOEDw5dD3zifrRkSdZYPwtXghBRX5EMWuqjpWa2vJYk1zjt7MNLiwYyGGKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VUBd4h1g; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-339289fead2so1239882f8f.3;
        Fri, 02 Feb 2024 03:01:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706871700; x=1707476500; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ALlqqSr0fBOMR8kEQ4bpGzuKAtK0byxAHdPJlmLkDzc=;
        b=VUBd4h1gBsVFT+itozw5LWrxcKcnVOiVRuW85lTtiLeQ3vgJUQrAWuUTWCdaVTyjx6
         WN/lSD1iLU9u8FaLeNo8RlFaJ0tpQMqUAJWLRUyidLVZQ2tEiwX2/OgauiWwtKBOPaVJ
         wjg2NEhzLbURAYA+s6N9RHfLBMGcN5MziVoMLAs6Jrn3ELTAJjX+u/OBxRAX+Z9igmKT
         wmc/sYc2xXbu/yrELx8so2p/eY3n1f5LmiFPRF6rNEL56iC4qJ5PbtSoTSWLLMDN6E+C
         nV9/RkD2ght1hwvNLoW3lkr1DVNuAV7/Tkv2gv0XL/hS+1wko8oXFfr5YzCsysQXoy+v
         b9GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706871700; x=1707476500;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ALlqqSr0fBOMR8kEQ4bpGzuKAtK0byxAHdPJlmLkDzc=;
        b=pcP2jI9tr/BpMW8kAyDutoQ5r2GwoWwyE/+aMHN+pGLmpHSs5ezGWX/a4NQ8A6fYDb
         gB8JjAo69PZjfqVm1eyOcYeyDzw+DqP79NKjoNAuUGlr2621carkRwwAM8h5KE2oF0sG
         eUHN0RI/Yoppvs+BI2i9SXNy+VGfTtVuvBePudnil9pjqkwCbfMzRAUTWHTsQof4Drce
         TcxDJ5ljeGXlyBwdzjP9UJ1WsBWyYBg7bZpQJrh2M8msREDE+8WOt5kreEHf54dqJWQi
         Aswg4iTkhmrEerDQfh4+27bq+EFKq+vqciptTcLRtL305s2HBqI8hAjFJkHvIQyJIbhN
         T3tw==
X-Gm-Message-State: AOJu0Yw4YSz5OVDiG4N/jNHl077schLo1wuyjHTQeN0k25TfE3pRpw1L
	8J9FYVljj4SphkvALcjoSR81BAu24TOUIMU/SsqWqEMW9hZDvbkO
X-Google-Smtp-Source: AGHT+IFnFtDZnCLmSH/R+XGEvy7O+I4Ks5SkvOxiVFgEwZu7Noqul9awwI4ktzvKKs5UzpGh3akURQ==
X-Received: by 2002:a5d:6204:0:b0:33a:e72c:c252 with SMTP id y4-20020a5d6204000000b0033ae72cc252mr5606345wru.52.1706871700447;
        Fri, 02 Feb 2024 03:01:40 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWpddlydGCL6V47qHjIL5bXeY4tlOZkrRbky5iVOD8k+WJRwuYCZ5P4kmhU2THfk1Wkp1XX/0Pe43S79Zx1u9du9MtcmYaGDfVeXztugivinIUM+cQ5ooM55/M2+1Nop3PonaJGqj574QL1eqOBhBrNiKUiueZ7tGO8UmnmMUuuXw+jrILXsLvFqEtP5Jo/DNuvRV+nMcUmCOUb4tCVhnMaq6DBZyrnFrR0+qx3xoBZQId/D0sD5PIpM4kfMRCYJSg5mLDm4eUKt04Pkfx3
Received: from amir-ThinkPad-T480.lan (46-117-242-41.bb.netvision.net.il. [46.117.242.41])
        by smtp.gmail.com with ESMTPSA id a13-20020a5d4d4d000000b0033b0924543asm1654180wru.108.2024.02.02.03.01.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 03:01:40 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Stefan Berger <stefanb@linux.ibm.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	linux-unionfs@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 2/2] fs: remove the inode argument to ->d_real() method
Date: Fri,  2 Feb 2024 13:01:32 +0200
Message-Id: <20240202110132.1584111-3-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240202110132.1584111-1-amir73il@gmail.com>
References: <20240202110132.1584111-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The only remaining user of ->d_real() method is d_real_inode(), which
passed NULL inode argument to get the real data dentry.

There are no longer any users that call ->d_real() with a non-NULL
inode argument for getting a detry from a specific underlying layer.

Remove the inode argument of the method and replace it with an integer
'type' argument, to allow callers to request the real metadata dentry
instead of the real data dentry.

All the current users of d_real_inode() (e.g. uprobe) continue to get
the real data inode.  Caller that need to get the real metadata inode
(e.g. IMA/EVM) can use d_inode(d_real(dentry, D_REAL_METADATA)).

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 Documentation/filesystems/locking.rst |  2 +-
 Documentation/filesystems/vfs.rst     | 16 ++++-----
 fs/overlayfs/super.c                  | 52 ++++++++++++---------------
 include/linux/dcache.h                | 18 ++++++----
 4 files changed, 41 insertions(+), 47 deletions(-)

diff --git a/Documentation/filesystems/locking.rst b/Documentation/filesystems/locking.rst
index d5bf4b6b7509..453039a2e49b 100644
--- a/Documentation/filesystems/locking.rst
+++ b/Documentation/filesystems/locking.rst
@@ -29,7 +29,7 @@ prototypes::
 	char *(*d_dname)((struct dentry *dentry, char *buffer, int buflen);
 	struct vfsmount *(*d_automount)(struct path *path);
 	int (*d_manage)(const struct path *, bool);
-	struct dentry *(*d_real)(struct dentry *, const struct inode *);
+	struct dentry *(*d_real)(struct dentry *, int type);
 
 locking rules:
 
diff --git a/Documentation/filesystems/vfs.rst b/Documentation/filesystems/vfs.rst
index eebcc0f9e2bc..2a39e718fdf8 100644
--- a/Documentation/filesystems/vfs.rst
+++ b/Documentation/filesystems/vfs.rst
@@ -1264,7 +1264,7 @@ defined:
 		char *(*d_dname)(struct dentry *, char *, int);
 		struct vfsmount *(*d_automount)(struct path *);
 		int (*d_manage)(const struct path *, bool);
-		struct dentry *(*d_real)(struct dentry *, const struct inode *);
+		struct dentry *(*d_real)(struct dentry *, int type);
 	};
 
 ``d_revalidate``
@@ -1419,16 +1419,14 @@ defined:
 	the dentry being transited from.
 
 ``d_real``
-	overlay/union type filesystems implement this method to return
-	one of the underlying dentries hidden by the overlay.  It is
-	used in two different modes:
+	overlay/union type filesystems implement this method to return one
+	of the underlying dentries of a regular file hidden by the overlay.
 
-	Called from file_dentry() it returns the real dentry matching
-	the inode argument.  The real dentry may be from a lower layer
-	already copied up, but still referenced from the file.  This
-	mode is selected with a non-NULL inode argument.
+	The 'type' argument takes the values D_REAL_DATA or D_REAL_METADATA
+	for returning the real underlying dentry that refers to the inode
+	hosting the file's data or metadata respectively.
 
-	With NULL inode the topmost real underlying dentry is returned.
+	For non-regular files, the 'dentry' argument is returned.
 
 Each dentry has a pointer to its parent dentry, as well as a hash list
 of child dentries.  Child dentries are basically like files in a
diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index 2eef6c70b2ae..938852a0a92b 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -28,41 +28,38 @@ MODULE_LICENSE("GPL");
 
 struct ovl_dir_cache;
 
-static struct dentry *ovl_d_real(struct dentry *dentry,
-				 const struct inode *inode)
+static struct dentry *ovl_d_real(struct dentry *dentry, int type)
 {
-	struct dentry *real = NULL, *lower;
+	struct dentry *upper, *lower;
 	int err;
 
-	/*
-	 * vfs is only expected to call d_real() with NULL from d_real_inode()
-	 * and with overlay inode from file_dentry() on an overlay file.
-	 *
-	 * TODO: remove @inode argument from d_real() API, remove code in this
-	 * function that deals with non-NULL @inode and remove d_real() call
-	 * from file_dentry().
-	 */
-	if (inode && d_inode(dentry) == inode)
-		return dentry;
-	else if (inode)
+	switch (type) {
+	case D_REAL_DATA:
+	case D_REAL_METADATA:
+		break;
+	default:
 		goto bug;
+	}
 
 	if (!d_is_reg(dentry)) {
 		/* d_real_inode() is only relevant for regular files */
 		return dentry;
 	}
 
-	real = ovl_dentry_upper(dentry);
-	if (real && (inode == d_inode(real)))
-		return real;
+	upper = ovl_dentry_upper(dentry);
+	if (upper && (type == D_REAL_METADATA ||
+		      ovl_has_upperdata(d_inode(dentry))))
+		return upper;
 
-	if (real && !inode && ovl_has_upperdata(d_inode(dentry)))
-		return real;
+	if (type == D_REAL_METADATA) {
+		lower = ovl_dentry_lower(dentry);
+		goto real_lower;
+	}
 
 	/*
-	 * Best effort lazy lookup of lowerdata for !inode case to return
+	 * Best effort lazy lookup of lowerdata for D_REAL_DATA case to return
 	 * the real lowerdata dentry.  The only current caller of d_real() with
-	 * NULL inode is d_real_inode() from trace_uprobe and this caller is
+	 * D_REAL_DATA is d_real_inode() from trace_uprobe and this caller is
 	 * likely going to be followed reading from the file, before placing
 	 * uprobes on offset within the file, so lowerdata should be available
 	 * when setting the uprobe.
@@ -73,18 +70,13 @@ static struct dentry *ovl_d_real(struct dentry *dentry,
 	lower = ovl_dentry_lowerdata(dentry);
 	if (!lower)
 		goto bug;
-	real = lower;
 
-	/* Handle recursion */
-	real = d_real(real, inode);
+real_lower:
+	/* Handle recursion into stacked lower fs */
+	return d_real(lower, type);
 
-	if (!inode || inode == d_inode(real))
-		return real;
 bug:
-	WARN(1, "%s(%pd4, %s:%lu): real dentry (%p/%lu) not found\n",
-	     __func__, dentry, inode ? inode->i_sb->s_id : "NULL",
-	     inode ? inode->i_ino : 0, real,
-	     real && d_inode(real) ? d_inode(real)->i_ino : 0);
+	WARN(1, "%s(%pd4, %d): real dentry not found\n", __func__, dentry, type);
 	return dentry;
 }
 
diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index 1666c387861f..019ad02f2b7e 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -139,7 +139,7 @@ struct dentry_operations {
 	char *(*d_dname)(struct dentry *, char *, int);
 	struct vfsmount *(*d_automount)(struct path *);
 	int (*d_manage)(const struct path *, bool);
-	struct dentry *(*d_real)(struct dentry *, const struct inode *);
+	struct dentry *(*d_real)(struct dentry *, int type);
 } ____cacheline_aligned;
 
 /*
@@ -543,27 +543,31 @@ static inline struct inode *d_backing_inode(const struct dentry *upper)
 	return inode;
 }
 
+enum d_real_type {
+	D_REAL_DATA,
+	D_REAL_METADATA,
+};
+
 /**
  * d_real - Return the real dentry
  * @dentry: the dentry to query
- * @inode: inode to select the dentry from multiple layers (can be NULL)
+ * @type: the type of real dentry (data or metadata)
  *
  * If dentry is on a union/overlay, then return the underlying, real dentry.
  * Otherwise return the dentry itself.
  *
  * See also: Documentation/filesystems/vfs.rst
  */
-static inline struct dentry *d_real(struct dentry *dentry,
-				    const struct inode *inode)
+static inline struct dentry *d_real(struct dentry *dentry, int type)
 {
 	if (unlikely(dentry->d_flags & DCACHE_OP_REAL))
-		return dentry->d_op->d_real(dentry, inode);
+		return dentry->d_op->d_real(dentry, type);
 	else
 		return dentry;
 }
 
 /**
- * d_real_inode - Return the real inode
+ * d_real_inode - Return the real inode hosting the data
  * @dentry: The dentry to query
  *
  * If dentry is on a union/overlay, then return the underlying, real inode.
@@ -572,7 +576,7 @@ static inline struct dentry *d_real(struct dentry *dentry,
 static inline struct inode *d_real_inode(const struct dentry *dentry)
 {
 	/* This usage of d_real() results in const dentry */
-	return d_backing_inode(d_real((struct dentry *) dentry, NULL));
+	return d_inode(d_real((struct dentry *) dentry, D_REAL_DATA));
 }
 
 struct name_snapshot {
-- 
2.34.1


