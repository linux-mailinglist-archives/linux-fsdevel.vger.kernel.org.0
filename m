Return-Path: <linux-fsdevel+bounces-29830-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE1DD97E786
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Sep 2024 10:28:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 239A61C2123E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Sep 2024 08:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48EDB193402;
	Mon, 23 Sep 2024 08:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F4TSzvdX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD891187FE4;
	Mon, 23 Sep 2024 08:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727080118; cv=none; b=F2vNl3XI8IfDmPr61tHeXuzxdAWU5tStq2j8zJzTirVqRFfm3ehr5KeGXfNDVlam0xQC2ozDE4RP3RFhnLRxiLWbBkEWw7rLTdtOCrYPoTgBwbTB1wKqqYSI7jwMdK5TvnGNDYIAh9S7B/URXLlF6NWXxUlvIp0m+xN283ZR8O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727080118; c=relaxed/simple;
	bh=c+Gukzr4Z/1ViTw4W/gdY/bE4RJtfYVVNS8THe4IDOg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DAZ2HUGFfsEbrCU1FzYPT6p9SIxHnREK0vgj6LcUVi7Lk0SMSsyEGeCMxDxQxsiQ0RCM37IOzzqGudUFJ1gfhvKLY50UPeDonjsivXQSWm4ziRpzIw1gV/ocdV5UOWHVY0fPD1dgGfjMCvEmvrMXeqco8vAefpiks14ugJIESiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F4TSzvdX; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a8d51a7d6f5so604286966b.2;
        Mon, 23 Sep 2024 01:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727080115; x=1727684915; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vR/PuiO1+k65ZDHst08ErBtN307APNiO6id8DTwIs4E=;
        b=F4TSzvdXtYOuirA2+oLnnoWdo18lAiNLCILBTIpFAWElLDOuEgmaiVRcFCSSnF1G72
         hPjQkERW5OZocTZwt04gem1BY2zbCfGsb0CkXBLpogjp2+o/Vct4+RqyPOw0XV/hPa3b
         nx36F7M/22piqFELOH5Uxkw20DDVOVPvkEMw3sy+bhtFkEIYS5bHyuyzczKbkiXfCrSQ
         L1lXDMwl1y4FCYUbnXn6BVdhBjhcqDFWIVMO6E/8DTfVOZerS8TDfLgcNJVlm2NhU7wb
         M8/W076417fxjPYYm2cIB1zK4SenZhIO/JSlygZb7tpyCT2tiTL45U4UTgVQ9IVjyqRG
         pdAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727080115; x=1727684915;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vR/PuiO1+k65ZDHst08ErBtN307APNiO6id8DTwIs4E=;
        b=mKAtExYZSS4QHuMAvnZkMhTOZMUrAMo2iUsDPbcMQqw/zSMxZYog63QvCmyXXtE8vw
         h9cSzuLU1CpUAuvthiR1BbtoZaWE51pbhNkeNXfz/Y692ez+H9OOwYia2vvmVGFIyeMS
         5AM5mJCv0xXR92t9AcdNuMX+pR7GaSSffaCt7krxp8+RKZlyu7Z2/rmoDDTDzvIcVRKd
         uZEx+0BKyuk+eDayLSk1/caYGwZFXAqfVRbp5qQLpplv6YTD1zFqA875z25O5zF5B6fb
         u9e9+CxZVsgt4nKGNqpK4/v7KquqDYiy/gaxOkOXcyqLyML+T3iZjdWWOdyh9zK5AX1u
         cUDg==
X-Forwarded-Encrypted: i=1; AJvYcCX0dLCaxoAg7tU4DL328cyScZb/vHr4CcIeLBb36VC2J8FwLr15GQIV4M2wYnL+/2LGcZwFVBH0EKdP@vger.kernel.org, AJvYcCXObTVABqF6G7ebQ6lGKbta/E4OjIj/4infw2cSaZAG1OJC1LLGSRqX9q8dkTEq2aH2FQTCjU/MV3c/XKYi@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4vbGNUMzun3OGL1EGGDVPDYkYNtFmlvl0L1EDA6iSHq4DkbVM
	u42SRvBllGM1mWGQSOojRgWc8ouyajnX+OiRRUZd4tqs8L6IcvcB
X-Google-Smtp-Source: AGHT+IEmrIMTkca85VRdNaerxJyHEiEPxLsovbxj8qE+dTa43Gz/hTL5356vMOdGSAWhnBOC61AtxA==
X-Received: by 2002:a17:906:cae1:b0:a8d:3f6a:99cb with SMTP id a640c23a62f3a-a90d51281d6mr1034746266b.47.1727080114863;
        Mon, 23 Sep 2024 01:28:34 -0700 (PDT)
Received: from amir-ThinkPad-T480.arnhem.chello.nl (92-109-99-123.cable.dynamic.v4.ziggo.nl. [92.109.99.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90cbc7122esm512948866b.124.2024.09.23.01.28.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2024 01:28:34 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Aleksa Sarai <cyphar@cyphar.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	linux-fsdevel@vger.kernel.org,
	linux-nfs@vger.kernel.org
Subject: [PATCH v2 1/2] fs: name_to_handle_at() support for "explicit connectable" file handles
Date: Mon, 23 Sep 2024 10:28:28 +0200
Message-Id: <20240923082829.1910210-2-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240923082829.1910210-1-amir73il@gmail.com>
References: <20240923082829.1910210-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

nfsd encodes "connectable" file handles for the subtree_check feature,
which can be resolved to an open file with a connected path.
So far, userspace nfs server could not make use of this functionality.

Introduce a new flag AT_HANDLE_CONNECTABLE to name_to_handle_at(2).
When used, the encoded file handle is "explicitly connectable".

The "explicitly connectable" file handle sets bits in the high 16bit of
the handle_type field, so open_by_handle_at(2) will know that it needs
to open a file with a connected path.

old kernels will now recognize the handle_type with high bits set,
so "explicitly connectable" file handles cannot be decoded by
open_by_handle_at(2) on old kernels.

The flag AT_HANDLE_CONNECTABLE is not allowed together with either
AT_HANDLE_FID or AT_EMPTY_PATH.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/fhandle.c               | 53 ++++++++++++++++++++++++++++++++++----
 include/linux/exportfs.h   |  2 ++
 include/linux/fs.h         |  3 ++-
 include/uapi/linux/fcntl.h |  1 +
 4 files changed, 53 insertions(+), 6 deletions(-)

diff --git a/fs/fhandle.c b/fs/fhandle.c
index 8cb665629f4a..6c87f1764235 100644
--- a/fs/fhandle.c
+++ b/fs/fhandle.c
@@ -31,6 +31,14 @@ static long do_sys_name_to_handle(const struct path *path,
 	if (!exportfs_can_encode_fh(path->dentry->d_sb->s_export_op, fh_flags))
 		return -EOPNOTSUPP;
 
+	/*
+	 * A request to encode a connectable handle for a disconnected dentry
+	 * is unexpected since AT_EMPTY_PATH is not allowed.
+	 */
+	if (fh_flags & EXPORT_FH_CONNECTABLE &&
+	    WARN_ON(path->dentry->d_flags & DCACHE_DISCONNECTED))
+		return -EINVAL;
+
 	if (copy_from_user(&f_handle, ufh, sizeof(struct file_handle)))
 		return -EFAULT;
 
@@ -45,7 +53,7 @@ static long do_sys_name_to_handle(const struct path *path,
 	/* convert handle size to multiple of sizeof(u32) */
 	handle_dwords = f_handle.handle_bytes >> 2;
 
-	/* we ask for a non connectable maybe decodeable file handle */
+	/* Encode a possibly decodeable/connectable file handle */
 	retval = exportfs_encode_fh(path->dentry,
 				    (struct fid *)handle->f_handle,
 				    &handle_dwords, fh_flags);
@@ -54,6 +62,7 @@ static long do_sys_name_to_handle(const struct path *path,
 	handle_bytes = handle_dwords * sizeof(u32);
 	handle->handle_bytes = handle_bytes;
 	if ((handle->handle_bytes > f_handle.handle_bytes) ||
+	    WARN_ON_ONCE(retval > FILEID_INVALID) ||
 	    (retval == FILEID_INVALID) || (retval < 0)) {
 		/* As per old exportfs_encode_fh documentation
 		 * we could return ENOSPC to indicate overflow
@@ -67,8 +76,23 @@ static long do_sys_name_to_handle(const struct path *path,
 		 * non variable part of the file_handle
 		 */
 		handle_bytes = 0;
-	} else
+	} else {
+		/*
+		 * When asked to encode a connectable file handle, encode this
+		 * property in the file handle itself, so that we later know
+		 * how to decode it.
+		 * For sanity, also encode in the file handle if the encoded
+		 * object is a directory and verify this during decode, because
+		 * decoding directory file handles is quite different than
+		 * decoding connectable non-directory file handles.
+		 */
+		if (fh_flags & EXPORT_FH_CONNECTABLE) {
+			if (d_is_dir(path->dentry))
+				fh_flags |= EXPORT_FH_DIR_ONLY;
+			handle->handle_flags = fh_flags;
+		}
 		retval = 0;
+	}
 	/* copy the mount id */
 	if (unique_mntid) {
 		if (put_user(real_mount(path->mnt)->mnt_id_unique,
@@ -109,15 +133,30 @@ SYSCALL_DEFINE5(name_to_handle_at, int, dfd, const char __user *, name,
 {
 	struct path path;
 	int lookup_flags;
-	int fh_flags;
+	int fh_flags = 0;
 	int err;
 
 	if (flag & ~(AT_SYMLINK_FOLLOW | AT_EMPTY_PATH | AT_HANDLE_FID |
-		     AT_HANDLE_MNT_ID_UNIQUE))
+		     AT_HANDLE_MNT_ID_UNIQUE | AT_HANDLE_CONNECTABLE))
+		return -EINVAL;
+
+	/*
+	 * AT_HANDLE_FID means there is no intention to decode file handle
+	 * AT_HANDLE_CONNECTABLE means there is an intention to decode a
+	 * connected fd (with known path), so these flags are conflicting.
+	 * AT_EMPTY_PATH could be used along with a dfd that refers to a
+	 * disconnected non-directory, which cannot be used to encode a
+	 * connectable file handle, because its parent is unknown.
+	 */
+	if (flag & AT_HANDLE_CONNECTABLE &&
+	    flag & (AT_HANDLE_FID | AT_EMPTY_PATH))
 		return -EINVAL;
+	else if (flag & AT_HANDLE_FID)
+		fh_flags |= EXPORT_FH_FID;
+	else if (flag & AT_HANDLE_CONNECTABLE)
+		fh_flags |= EXPORT_FH_CONNECTABLE;
 
 	lookup_flags = (flag & AT_SYMLINK_FOLLOW) ? LOOKUP_FOLLOW : 0;
-	fh_flags = (flag & AT_HANDLE_FID) ? EXPORT_FH_FID : 0;
 	if (flag & AT_EMPTY_PATH)
 		lookup_flags |= LOOKUP_EMPTY;
 	err = user_path_at(dfd, name, lookup_flags, &path);
@@ -307,6 +346,10 @@ static int handle_to_path(int mountdirfd, struct file_handle __user *ufh,
 		retval = -EINVAL;
 		goto out_path;
 	}
+	if (f_handle.handle_flags) {
+		retval = -EINVAL;
+		goto out_path;
+	}
 	handle = kmalloc(struct_size(handle, f_handle, f_handle.handle_bytes),
 			 GFP_KERNEL);
 	if (!handle) {
diff --git a/include/linux/exportfs.h b/include/linux/exportfs.h
index 893a1d21dc1c..96b62e502f71 100644
--- a/include/linux/exportfs.h
+++ b/include/linux/exportfs.h
@@ -159,6 +159,8 @@ struct fid {
 #define EXPORT_FH_CONNECTABLE	0x1 /* Encode file handle with parent */
 #define EXPORT_FH_FID		0x2 /* File handle may be non-decodeable */
 #define EXPORT_FH_DIR_ONLY	0x4 /* Only decode file handle for a directory */
+/* Flags allowed in encoded handle_flags that is exported to user */
+#define EXPORT_FH_USER_FLAGS	(EXPORT_FH_CONNECTABLE | EXPORT_FH_DIR_ONLY)
 
 /**
  * struct export_operations - for nfsd to communicate with file systems
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 0df3e5f0dd2b..bcf8f750b309 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1071,7 +1071,8 @@ struct file {
 
 struct file_handle {
 	__u32 handle_bytes;
-	int handle_type;
+	int handle_type:16;
+	int handle_flags:16;
 	/* file identifier */
 	unsigned char f_handle[] __counted_by(handle_bytes);
 };
diff --git a/include/uapi/linux/fcntl.h b/include/uapi/linux/fcntl.h
index 87e2dec79fea..56ff2100e021 100644
--- a/include/uapi/linux/fcntl.h
+++ b/include/uapi/linux/fcntl.h
@@ -153,6 +153,7 @@
 					   object identity and may not be
 					   usable with open_by_handle_at(2). */
 #define AT_HANDLE_MNT_ID_UNIQUE	0x001	/* Return the u64 unique mount ID. */
+#define AT_HANDLE_CONNECTABLE	0x002	/* Request a connectable file handle */
 
 #if defined(__KERNEL__)
 #define AT_GETATTR_NOSEC	0x80000000
-- 
2.34.1


