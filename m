Return-Path: <linux-fsdevel+bounces-31353-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 04F2099534C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2024 17:22:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7205B2883C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2024 15:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 077841E04AA;
	Tue,  8 Oct 2024 15:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lghjypnd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C9B1E00B9;
	Tue,  8 Oct 2024 15:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728400887; cv=none; b=O+Q0IKRxKmYhhavJty1GlVTqjkNKgYCNIEUCYxfK0BnLyIiiWIBkyv9nPyLD8edmGNzdxvzB0Kxhs7YkSDukxO+xwm5tS64DHtFaA+5Grcp6iEXulekyxo096Vy0yC4OuedVCB+lby+RTnhu9slR5JJ+rXIOM/k8q5cG1/ha5aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728400887; c=relaxed/simple;
	bh=+ZX3b6fCY2knnP8sQBd0OIDg/nPCYylQ+5J2FVHaZVc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MXvRAHp8L/6qwh38WDmST0pU6bfDhBWY1bHmC4cLbdM0vWFyv4Y0sO7WclKhfb9LnJKv0jNarlT/AZ/tmudLsLz0J7o3cmS7OrJhWRFnrPsox5LlynGJ7cAdBwnqq8VkVI8/BTNoRVGVkE+UGI7+lmlNxPqcG3Ei0g6wZlUpQIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lghjypnd; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a994cd82a3bso379656166b.2;
        Tue, 08 Oct 2024 08:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728400884; x=1729005684; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=grQc67CzF7uq3AE31l5+7PT63mf7qm7fLdVHTGt7Pys=;
        b=LghjypndZSiIGUp1aL/k0lulrPZIbtQc6xEkDp67ZdmSB2gJUzTf4QZ9MVkKlcBTM/
         pA9+8ipfjFNp/eGcNI1kvKdzHbQV5rjZo6HBh9vyNnulJ4lKYH6ErMKMKQfDIjMUZV5a
         1f0n53PtdX2qXbkSh36OF7T0QL879OqG5szL5Lgf4Yag9URKtvWAy0U2tK2l1mLDrMKN
         yWqm9SqzYv3VO0PVFdZHLEIrRl2E7XSoue/8iDZmsPHxsalhVyVt5foSjN28vd7ytLrJ
         eBUyPHsj4GQeC9OX0j06ttFQKqX4VFzg4gTHE81scoULos0kzY62xP02dmGJMmRWMeup
         bt3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728400884; x=1729005684;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=grQc67CzF7uq3AE31l5+7PT63mf7qm7fLdVHTGt7Pys=;
        b=f3juUCFXqNTisxhX/Z6ghMAmlI+FGKh5iW5X5AYj2oIiEPrNNYueqYUf6OZAOADUA9
         77iqiKQ0OP8znqkoR7qTkah5/YgyuglWq5y5u6iskFxVc0Uq+oTO9sIjEs+1+aj7j8Bz
         26z8sFEjvHVF64oyZGZXTeUTo7qNVsDVnb/KJ6UGlDp9eQc9KRoH8QvfUKVttNg9D14+
         HUYtKho3o0OaWAx90inDHiJkAoh4oHB7ps1e7WNtJGSCEFuAGeD1ALNHO7BDmpdq0cZk
         ofYqFfYYfQs+aWG1284SipFGrJCX6qj3and2c356FUixXXQHNJ1RaO2p67kSex+oHuTm
         QOQg==
X-Forwarded-Encrypted: i=1; AJvYcCWN94pc66+W6KfFlR34W/ItPbajBLL/f4j8Ao/yfrBwlcINzOPUmLNOnEDmHKQ0OXJfs1nSkxiIkysaBiLN@vger.kernel.org, AJvYcCXeBimG9P6mPgF1x+USDtFz4OFhRdEpMKj7G+vQ4KF2uagzRBcKFQKzOMeMsGcqedWZjsga+uOF6Iv4@vger.kernel.org
X-Gm-Message-State: AOJu0YyBO02BgSyQIo3oF1L6aBwjNzuTqJxG5SCwb5XmXBgVKNl75Dya
	svLmunUG169qHhQuoK5qaUu5bvQBIIPxR0yonPCSfjsB4W77fRw3
X-Google-Smtp-Source: AGHT+IFrMFei7vlVnSpHXwkbxz941y+0jDVcyeIXKAJX1eby0p30pjVJDpQMf25yGfOMw3hic+pBrw==
X-Received: by 2002:a17:907:7216:b0:a99:4113:e645 with SMTP id a640c23a62f3a-a994113e677mr989121266b.55.1728400883355;
        Tue, 08 Oct 2024 08:21:23 -0700 (PDT)
Received: from amir-ThinkPad-T480.arnhem.chello.nl (92-109-99-123.cable.dynamic.v4.ziggo.nl. [92.109.99.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99384f8258sm487910466b.16.2024.10.08.08.21.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 08:21:22 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Aleksa Sarai <cyphar@cyphar.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	linux-fsdevel@vger.kernel.org,
	linux-nfs@vger.kernel.org
Subject: [PATCH v3 1/3] fs: prepare for "explicit connectable" file handles
Date: Tue,  8 Oct 2024 17:21:16 +0200
Message-Id: <20241008152118.453724-2-amir73il@gmail.com>
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

We would like to use the high 16bit of the handle_type field to encode
file handle traits, such as "connectable".

In preparation for this change, make sure that filesystems do not return
a handle_type value with upper bits set and that the open_by_handle_at(2)
syscall rejects these handle types.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/exportfs/expfs.c      | 14 ++++++++++++--
 fs/fhandle.c             |  6 ++++++
 include/linux/exportfs.h | 14 ++++++++++++++
 3 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/fs/exportfs/expfs.c b/fs/exportfs/expfs.c
index 4f2dd4ab4486..c8eb660fdde4 100644
--- a/fs/exportfs/expfs.c
+++ b/fs/exportfs/expfs.c
@@ -382,14 +382,21 @@ int exportfs_encode_inode_fh(struct inode *inode, struct fid *fid,
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
+	if (WARN_ON_ONCE(FILEID_USER_FLAGS(type)))
+		return -EINVAL;
+
+	return type;
 
-	return nop->encode_fh(inode, fid->raw, max_len, parent);
 }
 EXPORT_SYMBOL_GPL(exportfs_encode_inode_fh);
 
@@ -436,6 +443,9 @@ exportfs_decode_fh_raw(struct vfsmount *mnt, struct fid *fid, int fh_len,
 	char nbuf[NAME_MAX+1];
 	int err;
 
+	if (WARN_ON_ONCE(FILEID_USER_FLAGS(fileid_type)))
+		return -EINVAL;
+
 	/*
 	 * Try to get any dentry for the given file handle from the filesystem.
 	 */
diff --git a/fs/fhandle.c b/fs/fhandle.c
index 82df28d45cd7..c5792cf3c6e9 100644
--- a/fs/fhandle.c
+++ b/fs/fhandle.c
@@ -307,6 +307,10 @@ static int handle_to_path(int mountdirfd, struct file_handle __user *ufh,
 		retval = -EINVAL;
 		goto out_path;
 	}
+	if (!FILEID_USER_TYPE_IS_VALID(f_handle.handle_type)) {
+		retval = -EINVAL;
+		goto out_path;
+	}
 	handle = kmalloc(struct_size(handle, f_handle, f_handle.handle_bytes),
 			 GFP_KERNEL);
 	if (!handle) {
@@ -322,6 +326,8 @@ static int handle_to_path(int mountdirfd, struct file_handle __user *ufh,
 		goto out_handle;
 	}
 
+	/* Filesystem code should not be exposed to user flags */
+	handle->handle_type &= ~FILEID_USER_FLAGS_MASK;
 	retval = do_handle_to_path(handle, path, &ctx);
 
 out_handle:
diff --git a/include/linux/exportfs.h b/include/linux/exportfs.h
index 893a1d21dc1c..76a3050b3593 100644
--- a/include/linux/exportfs.h
+++ b/include/linux/exportfs.h
@@ -160,6 +160,20 @@ struct fid {
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
+#define FILEID_USER_TYPE_IS_VALID(type) \
+	(!(FILEID_USER_FLAGS(type) & ~FILEID_VALID_USER_FLAGS))
+
 /**
  * struct export_operations - for nfsd to communicate with file systems
  * @encode_fh:      encode a file handle fragment from a dentry
-- 
2.34.1


