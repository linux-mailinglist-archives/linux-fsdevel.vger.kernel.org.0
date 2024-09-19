Return-Path: <linux-fsdevel+bounces-29712-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B18E197CABB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Sep 2024 16:06:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7237E28510D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Sep 2024 14:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DDC819FA72;
	Thu, 19 Sep 2024 14:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OQjJk0Ko"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD2328EA;
	Thu, 19 Sep 2024 14:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726754782; cv=none; b=fyHxbB/m0tjDEeu21FTWo3RA4pUUuCN3W22OV2/xPUJ6T9THZ5KSCCgBWCj06fuaNH500Uu30eZDxatRusG31JdAdMB4VJqajTuZD/gXvT6oN9/J76dL4pS0CPlRSAeToGToZwgtL0E9GFzf04JZsZkorGTMNI4kIno4V+RsBcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726754782; c=relaxed/simple;
	bh=O1jhhcUj3IsFFBDDWs8RNVQYM7nR++KsRPrT3QXUJw0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OpcjdTB+t3ZJYxE8YDIVA/RzHTzxJCvjNCW6xBGP3YfwjI2PDzqS2b3UYUxWk64PEakSe3ASrELo5BYmLtS3FuKHA8yq8m0Q2kT9shqcEU2KXM+oov3owinENwjoOZXJUwwx5kBxKk549gq6Ykr2++6sUqtrd6DuLFFCCP4Z+rU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OQjJk0Ko; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a8d43657255so131945366b.0;
        Thu, 19 Sep 2024 07:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726754779; x=1727359579; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7zFM/SDc601a7c6eWxDpcFbMja292FpzqrursS83914=;
        b=OQjJk0Ko0o1uMDttmebiBLDg+eTlDI8YhLQlYuah95DPjsWW0+Ytc9xoezZT6eKtU1
         3wp9rdekLBKHCSedLNl4gTKeeSUjfSNEvZqqe7usjowM5CpW/Y99Z8HI1fKPJlTVmt9p
         bdHNfTweT3FT2OQmFBXtZQF2VGH95lSvJQ2RVGAJQIYOZoxXwdwCLaYObe+7gezURL1p
         TYUgDkAcH94Nh0n9PNmRuzSOSGE019BHryrigZ9BL+54Js49bJ3qJ0ck77X9cOy+naQF
         zt9GJXOaEk9OmJ70ZMHN6mxWlbY37U1qdjKZf8Zs+9/rGfMBMj5yIy2DhGV4doiw9S+5
         GGZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726754779; x=1727359579;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7zFM/SDc601a7c6eWxDpcFbMja292FpzqrursS83914=;
        b=aWgyqtJBGb+w2YwF9D+WcHGxfodSAG47ADFbSHcAgmEubQlq9+8Zl5FbEwxdSUgSnU
         zFqpJylNJCjF7N3vT+hHXdP0vuUMLkHsG245tuD+Xsguo2dZDC9zZgpaVk8sNnd8SP0O
         PZJRrHLArBudhytzqmd6XwWYMmFZWHkbh/JnuNNQldqXIl7hhdtT3B7MPd+IwGQ6A5BI
         NKV8hsOPrllbRUy9y99vuND6SrBD1bLcVSzXRCxNPMB0+GuSaMTaXKefod2IEPaVdevS
         VYlFosobRflkhKy0bJ8B0vgJbgXah5dP+OLYT9QQickHPqi7gJFjvp0YzCJFrrql5pVN
         6VEQ==
X-Forwarded-Encrypted: i=1; AJvYcCWSPAISv0C4eU+9s9iPiw4+CyWUFb1ZGRR9V8MyKRGK5JziXwA8quMUZgt4gWRMdSGiHXWRGasCpB6MkJ5p@vger.kernel.org, AJvYcCXaxSoFYxlGNEaBb5tdOzyXcXbUkWXQfPAb8VZuhmf84SYsOc424+VXWDURw1m9ppad1zFhONZIxFBa@vger.kernel.org
X-Gm-Message-State: AOJu0YwaFaxt0c+pk4Ps2STf0skdwCWSp+FbvgF037528Bri7/YNgigL
	AjGcnns9wlP9RI7Mn0FvHZCEMGd+reUP6O8TLf4Orfe3FdKngsFo
X-Google-Smtp-Source: AGHT+IFVW65/x6M/ish4sB3Dy3c2EojrWo1KSmpOdSGAEDTyvANj7b4B+L5C22FNpF1Cti7jToZ5bQ==
X-Received: by 2002:a17:907:7fa3:b0:a87:31c:c6c4 with SMTP id a640c23a62f3a-a9047ca725amr2221913166b.24.1726754778255;
        Thu, 19 Sep 2024 07:06:18 -0700 (PDT)
Received: from amir-ThinkPad-T480.arnhem.chello.nl (92-109-99-123.cable.dynamic.v4.ziggo.nl. [92.109.99.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9061330c1fsm719503266b.206.2024.09.19.07.06.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Sep 2024 07:06:17 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Aleksa Sarai <cyphar@cyphar.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	linux-fsdevel@vger.kernel.org,
	linux-nfs@vger.kernel.org
Subject: [RFC PATCH 1/2] fs: name_to_handle_at() support for connectable file handles
Date: Thu, 19 Sep 2024 16:06:10 +0200
Message-Id: <20240919140611.1771651-2-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240919140611.1771651-1-amir73il@gmail.com>
References: <20240919140611.1771651-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

nfsd encodes "connectable" file handles for the subtree_check feature.
So far, userspace nfs server could not make use of this functionality.

Introduce a new flag AT_HANDLE_CONNECTABLE to name_to_handle_at(2).
When used, the encoded file handle is "connectable".

Note that decoding a "connectable" file handle with open_by_handle_at(2)
is not guarandteed to return a "connected" fd (i.e. fd with known path).
A new opt-in API would be needed to guarantee a "connected" fd.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/fhandle.c               | 24 ++++++++++++++++++++----
 include/uapi/linux/fcntl.h |  1 +
 2 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/fs/fhandle.c b/fs/fhandle.c
index 8cb665629f4a..956d9b25d4f7 100644
--- a/fs/fhandle.c
+++ b/fs/fhandle.c
@@ -31,6 +31,11 @@ static long do_sys_name_to_handle(const struct path *path,
 	if (!exportfs_can_encode_fh(path->dentry->d_sb->s_export_op, fh_flags))
 		return -EOPNOTSUPP;
 
+	/* Do not encode a connectable handle for a disconnected dentry */
+	if (fh_flags & EXPORT_FH_CONNECTABLE &&
+	    path->dentry->d_flags & DCACHE_DISCONNECTED)
+		return -EACCES;
+
 	if (copy_from_user(&f_handle, ufh, sizeof(struct file_handle)))
 		return -EFAULT;
 
@@ -45,7 +50,7 @@ static long do_sys_name_to_handle(const struct path *path,
 	/* convert handle size to multiple of sizeof(u32) */
 	handle_dwords = f_handle.handle_bytes >> 2;
 
-	/* we ask for a non connectable maybe decodeable file handle */
+	/* Encode a possibly decodeable/connectable file handle */
 	retval = exportfs_encode_fh(path->dentry,
 				    (struct fid *)handle->f_handle,
 				    &handle_dwords, fh_flags);
@@ -109,15 +114,26 @@ SYSCALL_DEFINE5(name_to_handle_at, int, dfd, const char __user *, name,
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
+	 */
+	if (flag & AT_HANDLE_CONNECTABLE && flag & AT_HANDLE_FID)
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


