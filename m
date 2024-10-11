Return-Path: <linux-fsdevel+bounces-31674-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59F10999F88
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2024 11:00:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14673B22CAE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2024 09:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9762920C48D;
	Fri, 11 Oct 2024 09:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JXK0fKli"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E18D804;
	Fri, 11 Oct 2024 09:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728637233; cv=none; b=T9KeiJjSIqzU/Kfl8AyodjzIWIGJkNzfwjKfuUb9YzBbrM+TGEb2eOXMu5YchlcfnJcoAiRaPrugDXlBvA2xVUl9dES6lSdJ1D/2FWnteheEgjIUAzOJWTxO8e/26d3r5AnzaTkWjAi3Pv+z4RjnlkQiOK+0dmteN2L25CXv8AY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728637233; c=relaxed/simple;
	bh=JPQLgql+RewUOKYyXw1fBtRDmH8dVTiO78IMH0ukFnY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=t8iSC+YBxczgReuslzdi9TVlGRySrvS2ueYR7+IfIdiBfAe17RBaM2MhKmMwpY8g/w+o7bYVf8hAckKrN16+jmZbnmykqKM1Xem2zcgC5yt5TmbwD4i8f+/U5z4Gi8Bop62zrwVzp4Hk82N2PVrHLf4+qnVgrY/j6PhY5Z6k+ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JXK0fKli; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5399041167cso2869528e87.0;
        Fri, 11 Oct 2024 02:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728637229; x=1729242029; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bvq4+KTpN68zt7ADgZnnr5hR6veztOtGJTyaDh5q59g=;
        b=JXK0fKli7IFhg46bA5aRQMgvwBVNYMKqitquYISJzpKc3Vc8iJhR+aDWcoRdD2zaGH
         lSpnlcBm8xS9prIbVOKpEPCOcdTFsMzIBfiV3Kh4g2/Lp0p04SxUUIqSApuKbe/YfAP3
         1JHF0r1f6btuWMXGi2fB9abD7hSRBmGzaXoXSmMOAHDgfJ5EWrt7k4jgMswRYhj5kcRE
         +TjstsSmHZdciDhPHNwj+lxAF317xG/YePU0haYVml3HAUizmBJARCv0flDMKb8e2B7b
         WDLGBKc3WDlZUdwVVa/k3bqy5u9F4AH2JPRWt0QQeA+BIS8IR7UmVqhelPakKJ/R/I+z
         s/Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728637229; x=1729242029;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bvq4+KTpN68zt7ADgZnnr5hR6veztOtGJTyaDh5q59g=;
        b=RvoGdddA31MeGkK3f7iJd+Dk0I0Q4H6fmm8c/YLz48VoSi0ZQU5xab/AO4lhbfn5ym
         QYc+FEJ4Bus8nSyN0I8ZzVoK5k8IumUluK1DRAa+Me8Bf3FMwCitwmEMWT9vuULRQ6HE
         ataIKoQDfp8LNPCliktrOjPyBM8gztVYq6ABR7g+CWoHDgIA5zUL2MekUUAwMsGOQJ5Z
         5HAfxFmT/gIkTzRxQE6osemJhJK7cTOksMETnVxLAvFIrjE8Iaet3OISbU2ELO4o8+iL
         YZ08uyVk7vp3Rts8bhtcqyu1SukVN4yrwNFA2YQ7xA1yMyx0LIAdicbWJMO14qa/xfvY
         ConA==
X-Forwarded-Encrypted: i=1; AJvYcCWAEEpdSrzKB8qumA33ZjHan5+7bevvIOIOb5msiffcxStyopAkdvWDR6waZ+SwbJ7yHQ7MqpUgX9Qs@vger.kernel.org, AJvYcCX3dtr05n2id3xXZX5qFxlRpCs0nogp7coj5lvzTxgAHXmBGtHoGFk5xTCqB+ZvXlaC6oPMSZ6dNuQIWU16@vger.kernel.org
X-Gm-Message-State: AOJu0YxULuV6++6MrQDoT1z97wChk2z5oTIWWW4DzOsEOd0ug/bf38GM
	J7jE47ecobBiRv+6JyB3ugH4UEPkkLQd+dZRlT6tJ8ebbCLuJ63T
X-Google-Smtp-Source: AGHT+IFb2R3dYIF+F9C4oVm2uhHOlhQm3wdZG/PTMeOyXYEwMR+toxwpFxXCGgigyFtBrZ4kj5TQZw==
X-Received: by 2002:a05:6512:3196:b0:539:a353:279b with SMTP id 2adb3069b0e04-539da3b1ec8mr1339843e87.9.1728637228672;
        Fri, 11 Oct 2024 02:00:28 -0700 (PDT)
Received: from amir-ThinkPad-T480.arnhem.chello.nl (92-109-99-123.cable.dynamic.v4.ziggo.nl. [92.109.99.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99a7ec5697sm189606066b.22.2024.10.11.02.00.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 02:00:28 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Aleksa Sarai <cyphar@cyphar.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	linux-fsdevel@vger.kernel.org,
	linux-nfs@vger.kernel.org
Subject: [PATCH v4 1/3] fs: prepare for "explicit connectable" file handles
Date: Fri, 11 Oct 2024 11:00:21 +0200
Message-Id: <20241011090023.655623-2-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241011090023.655623-1-amir73il@gmail.com>
References: <20241011090023.655623-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We would like to use the high 16bit of the handle_type field to encode
file handle traits, such as "connectable".

In preparation for this change, make sure that filesystems do not return
a handle_type value with upper bits set and that the open_by_handle_at(2)
syscall rejects these handle types.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/exportfs/expfs.c      | 17 +++++++++++++++--
 fs/fhandle.c             |  7 +++++++
 include/linux/exportfs.h | 11 +++++++++++
 3 files changed, 33 insertions(+), 2 deletions(-)

diff --git a/fs/exportfs/expfs.c b/fs/exportfs/expfs.c
index 4f2dd4ab4486..0c899cfba578 100644
--- a/fs/exportfs/expfs.c
+++ b/fs/exportfs/expfs.c
@@ -382,14 +382,24 @@ int exportfs_encode_inode_fh(struct inode *inode, struct fid *fid,
 			     int *max_len, struct inode *parent, int flags)
 {
 	const struct export_operations *nop = inode->i_sb->s_export_op;
+	enum fid_type type;
 
 	if (!exportfs_can_encode_fh(nop, flags))
 		return -EOPNOTSUPP;
 
 	if (!nop && (flags & EXPORT_FH_FID))
-		return exportfs_encode_ino64_fid(inode, fid, max_len);
+		type = exportfs_encode_ino64_fid(inode, fid, max_len);
+	else
+		type = nop->encode_fh(inode, fid->raw, max_len, parent);
+
+	if (type > 0 && FILEID_USER_FLAGS(type)) {
+		pr_warn_once("%s: unexpected fh type value 0x%x from fstype %s.\n",
+			     __func__, type, inode->i_sb->s_type->name);
+		return -EINVAL;
+	}
+
+	return type;
 
-	return nop->encode_fh(inode, fid->raw, max_len, parent);
 }
 EXPORT_SYMBOL_GPL(exportfs_encode_inode_fh);
 
@@ -436,6 +446,9 @@ exportfs_decode_fh_raw(struct vfsmount *mnt, struct fid *fid, int fh_len,
 	char nbuf[NAME_MAX+1];
 	int err;
 
+	if (fileid_type < 0 || FILEID_USER_FLAGS(fileid_type))
+		return ERR_PTR(-EINVAL);
+
 	/*
 	 * Try to get any dentry for the given file handle from the filesystem.
 	 */
diff --git a/fs/fhandle.c b/fs/fhandle.c
index 82df28d45cd7..218511f38cbb 100644
--- a/fs/fhandle.c
+++ b/fs/fhandle.c
@@ -307,6 +307,11 @@ static int handle_to_path(int mountdirfd, struct file_handle __user *ufh,
 		retval = -EINVAL;
 		goto out_path;
 	}
+	if (f_handle.handle_type < 0 ||
+	    FILEID_USER_FLAGS(f_handle.handle_type) & ~FILEID_VALID_USER_FLAGS) {
+		retval = -EINVAL;
+		goto out_path;
+	}
 	handle = kmalloc(struct_size(handle, f_handle, f_handle.handle_bytes),
 			 GFP_KERNEL);
 	if (!handle) {
@@ -322,6 +327,8 @@ static int handle_to_path(int mountdirfd, struct file_handle __user *ufh,
 		goto out_handle;
 	}
 
+	/* Filesystem code should not be exposed to user flags */
+	handle->handle_type &= ~FILEID_USER_FLAGS_MASK;
 	retval = do_handle_to_path(handle, path, &ctx);
 
 out_handle:
diff --git a/include/linux/exportfs.h b/include/linux/exportfs.h
index 893a1d21dc1c..5e14d4500a75 100644
--- a/include/linux/exportfs.h
+++ b/include/linux/exportfs.h
@@ -160,6 +160,17 @@ struct fid {
 #define EXPORT_FH_FID		0x2 /* File handle may be non-decodeable */
 #define EXPORT_FH_DIR_ONLY	0x4 /* Only decode file handle for a directory */
 
+/*
+ * Filesystems use only lower 8 bits of file_handle type for fid_type.
+ * name_to_handle_at() uses upper 16 bits of type as user flags to be
+ * interpreted by open_by_handle_at().
+ */
+#define FILEID_USER_FLAGS_MASK	0xffff0000
+#define FILEID_USER_FLAGS(type) ((type) & FILEID_USER_FLAGS_MASK)
+
+/* Flags supported in encoded handle_type that is exported to user */
+#define FILEID_VALID_USER_FLAGS	(0)
+
 /**
  * struct export_operations - for nfsd to communicate with file systems
  * @encode_fh:      encode a file handle fragment from a dentry
-- 
2.34.1


