Return-Path: <linux-fsdevel+bounces-31354-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 905C4995359
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2024 17:25:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB275B28BC4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2024 15:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2E911E0DC0;
	Tue,  8 Oct 2024 15:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M8ol3jx9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7931E049E;
	Tue,  8 Oct 2024 15:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728400888; cv=none; b=sOkACajLMKce+IjdJ+aGtLktygHX3U6h5BOb7Vc0RVI3lFRB1SpYzP5HP/qn+tk0puLNBPIh05/gIRfLYSrEcyHz1LdgZJRCZX9Mur9GP0C/NhRpzlCUOhTdUSWPpXCF26+O/Nqwe9qwjm3X1PuDHuXp3KAB701lQWACGJJEDkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728400888; c=relaxed/simple;
	bh=+lTbmtwfyb7AjlOxLrcSHxwkErVrBDtzdezP2YLKOJA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nzyWjAM8K0ysVsWrVRBwTiYMT/vBmR3dAHTPvYG3BhS3PjMWdN8Ti86i8/QV5+b+o1qCH2Kr3T0gS117SK0jGBlORp/pJN8IjrCyjMOt6CJz7pMspmGEOSJBRcF8jmeSH75Fnag3hG1rL4sns5FVDcp8+fcV9e4mmvpjvA7Rwps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M8ol3jx9; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5c91a7141b8so232610a12.1;
        Tue, 08 Oct 2024 08:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728400885; x=1729005685; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7x/acSxCv7H+ppJ4OuFjM3Dd++gtKxDLriu5QQGsWoQ=;
        b=M8ol3jx9zOk2Z8Kk3Wz3OPckPXo5tddzGVPubrolkoIDkETwSepZh1WDEURWBuExiA
         ZDlWdo2IWjYZvK5uOurHW/zNLqCcAGpoWJTHOQTEcpeC5lRphBWYBuHvl7baMIAlQrm7
         za2A24HtJ/8STx1NDFiDD9fzEPpkZqSmbtwHoT4mpPZay7dR7EyeiAZ+kQBpw690rKlo
         zcWwjzPfvjUEb+CriKc2i/7vUfCVxywC7202nTxbKx5+iNxt3wNqEMsrjZdQfXACKJNs
         +3bfoqXFZrCme/gUsCGRdvKnHCFbxIRgGwz1PEh7Oiv8P6OQJHwGhTqf7zR8AZg8+8X8
         k6Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728400885; x=1729005685;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7x/acSxCv7H+ppJ4OuFjM3Dd++gtKxDLriu5QQGsWoQ=;
        b=saLicXRZfInUPdOwOMNIqBlSTqmePfNqvqrRZ4KmUdSbpBxY/EyjS2CyR0BjL+t2fS
         X/tbmgipfY0oPOzTDTZoNRyrGcUpqjBoEJoMp877H0b7f7sgZ4YxA620aKfX5EFXma8a
         FR4hnSh1OZgFkqUY5iUUhqeVzCEivB0zo22cn7qFOgqdigbuxx4aAg8io3dnPi4qK0yZ
         B0teQt8yAurIXMnORocMm693sMVNBkYgm4OCjWfsJXtyt+vLiLNlXWbevU85VQRWKK0b
         PvzkouseValc8dpp4KT8b1jJg2exd8xS12MweNMZhx9wzesIBMpvxmxGC0iGkGwZpj32
         5GVQ==
X-Forwarded-Encrypted: i=1; AJvYcCU9IVmhMnPzOjVR+rTv2nPGc1krR9ryZtGjoHoaaK9kRrb8kEGJ3avCT+WeR4qqoB9b19KI60bFtwM3@vger.kernel.org, AJvYcCXT1+vwEb1fsdK+RUnoygNXQwJ8ZyV+uJxGs7+Xf2rOTXMfLWUIz/IldsHSCGFGwN3it11bUPHdx7vVliAU@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7awRdYhmpHVe+tn0JEl576e/6nl0Ai9dWnSrUDnquJH72bETj
	BUccPlWQRtBcg8uA10T87uxCSVvI/UY4IouXG8+UlnGcF8VpdnSjYxdUufKr
X-Google-Smtp-Source: AGHT+IEKLxWVgobj8E72uSDt+XHtmNrE+X1Kl4tNw0NSo18GnMluZbKC1AjgMl/tBoXLvOko81/44A==
X-Received: by 2002:a17:907:3e8e:b0:a99:65c6:7f22 with SMTP id a640c23a62f3a-a9965c68657mr303983566b.11.1728400884292;
        Tue, 08 Oct 2024 08:21:24 -0700 (PDT)
Received: from amir-ThinkPad-T480.arnhem.chello.nl (92-109-99-123.cable.dynamic.v4.ziggo.nl. [92.109.99.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99384f8258sm487910466b.16.2024.10.08.08.21.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 08:21:23 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Aleksa Sarai <cyphar@cyphar.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	linux-fsdevel@vger.kernel.org,
	linux-nfs@vger.kernel.org
Subject: [PATCH v3 2/3] fs: name_to_handle_at() support for "explicit connectable" file handles
Date: Tue,  8 Oct 2024 17:21:17 +0200
Message-Id: <20241008152118.453724-3-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241008152118.453724-1-amir73il@gmail.com>
References: <20241008152118.453724-1-amir73il@gmail.com>
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
 fs/fhandle.c               | 48 ++++++++++++++++++++++++++++++++++----
 include/linux/exportfs.h   |  2 ++
 include/uapi/linux/fcntl.h |  1 +
 3 files changed, 46 insertions(+), 5 deletions(-)

diff --git a/fs/fhandle.c b/fs/fhandle.c
index c5792cf3c6e9..7b4c8945efcb 100644
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
@@ -67,8 +75,23 @@ static long do_sys_name_to_handle(const struct path *path,
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
+			handle->handle_type |= FILEID_IS_CONNECTABLE;
+			if (d_is_dir(path->dentry))
+				fh_flags |= FILEID_IS_DIR;
+		}
 		retval = 0;
+	}
 	/* copy the mount id */
 	if (unique_mntid) {
 		if (put_user(real_mount(path->mnt)->mnt_id_unique,
@@ -109,15 +132,30 @@ SYSCALL_DEFINE5(name_to_handle_at, int, dfd, const char __user *, name,
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
diff --git a/include/linux/exportfs.h b/include/linux/exportfs.h
index 76a3050b3593..230b0e1d669d 100644
--- a/include/linux/exportfs.h
+++ b/include/linux/exportfs.h
@@ -169,6 +169,8 @@ struct fid {
 #define FILEID_USER_FLAGS(type) ((type) & FILEID_USER_FLAGS_MASK)
 
 /* Flags supported in encoded handle_type that is exported to user */
+#define FILEID_IS_CONNECTABLE	0x10000
+#define FILEID_IS_DIR		0x40000
 #define FILEID_VALID_USER_FLAGS	(0)
 
 #define FILEID_USER_TYPE_IS_VALID(type) \
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


