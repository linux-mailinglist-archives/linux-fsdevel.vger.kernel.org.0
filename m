Return-Path: <linux-fsdevel+bounces-61099-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CF0FB55367
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 17:28:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AB695859BD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 15:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FFAD22154F;
	Fri, 12 Sep 2025 15:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="loh649Mj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C37221DB0
	for <linux-fsdevel@vger.kernel.org>; Fri, 12 Sep 2025 15:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757690856; cv=none; b=aA6TW+BvM2AxtXP3vAYprAPH2nZW25TKkYrOov2GnVMFU/C8ZjPGiFF190WT3PJpmGB0G2qd3Ki9i4HLhoM7jTq8zpXHgbtkvpagyG6DCHHoISTByV9sSUQ2GugQjRK/J2WpgsEUp+IYiC9cOatn9N/REdbGMIey//nRJhKUCp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757690856; c=relaxed/simple;
	bh=IDX79HDL4EGNYPA7gq8OYoVmXTMrr1SHy58I3vqzc5w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rjtLMXXmhU3fkO7ZvHj5ych/3bBQiagXe66fBHnOo/KT1SYxBPo3GCTVA1cmG5KWxy+BuXMoEizVpPEyYnIrnU60LiarsKLIyGMvL4sPn+ha/lEzdp1IfagvIMW0k8MuIFpcgGha0qPk1ZHVCP9srhzEacF0ouKd5pnwBuBiI5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=loh649Mj; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7722f2f2aa4so2413734b3a.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Sep 2025 08:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757690855; x=1758295655; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R6iI6c97nNvMnmhDAC2q15k1wXIF9MfYotWBXA6wQ3Q=;
        b=loh649MjWy3NcR+i9x+jdNVAA/eDItl0Hvkrzvd3eSJVyXhwHPKCdmhFGr7gmxZvwD
         hosEG9HmQd7iz/voMxuuYgr067FI1nIg7jfAjtU+7pn9j272V24fsJkU8Ic+LPGEV9YM
         ksW1ZG9PZFSw9aGBZ8/jNkEPYxsqrQxog9i502spFbac1DuCJP4YIucSPVGBo2lZqArm
         4A3gYLe8SuFDg4Sr1pxXp9bymOClxTY0p/5Nxa25ghhwOJwFD2jwzwh4pdgDFkQ8ZJfE
         JR+Gzbga84BAGcySgO36p0b3eopzfseQgoBG6b+f5s2Q5+ur9WI3XWTvfWqrqFOy5IHy
         bIKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757690855; x=1758295655;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R6iI6c97nNvMnmhDAC2q15k1wXIF9MfYotWBXA6wQ3Q=;
        b=uJPxCD6EcXxDKGK6sKgEaHHQ5R+axohlJ4ltjblM8rq7GCruIM9tzNmJeHnorwsoK2
         em0G+hWh3T1it4AlzgmcPEFhe0P+J0lACf0RqygyrpA7NWqOXjFjLCi9Nmh7NYFNpDd7
         BB/aQ0m7gi2Hwh2CTmkguO4c287hD+PJ/Rj2rMoPxlnKxcpd7ttTEO5CQPGHPLNK+z8N
         UiROGBMcaxzaNXntZw8HCOZY4O9Sd9gFjpg0AOdv3/kzvjVBm5WmhwgMSbidPGUx9+kS
         sia+491SScHpX0EFi6Z3NeN1DskEX+EUaBF3YMXyppQz5C1RiYqb1waMAxNq/VoVBUqb
         8reg==
X-Forwarded-Encrypted: i=1; AJvYcCWslpbRRslqOI8O82dxJjuiSPEztFl3Pkjg8IdjdhdOVSJZZn4mLGlUkVhf5QCB1GUOXmCHJ7oledM71NOL@vger.kernel.org
X-Gm-Message-State: AOJu0YyxEV+xhl5pkAyBKX9NqTuRAmNYQd56oZIUbm4d7X1+NgTTjqvk
	ioYjsVL9zrv+jYJKtdkUM7I3Y1T5Urv8um+R0LoPKIR4KWOvob/I6etf
X-Gm-Gg: ASbGncssum+i6aau20iWzvJ/85u8yG1xhg/fvQ67HUlOQLvAxF0DAF625Malp3wPDT7
	XrYuqUjayARB5sF0iAhyXgMC1xv6/Nvo/+OKCj+MimQuLy75ZLCCM75j6AyuLkCWXD506uQRgrz
	oR7nu1oGu9RNcE5tmJ68xVejzVHy4SNH5s1zHNzjRV7c1NURZBMAB6QP3BkaYK60XQRbV1uRM/u
	ypdtl4J+FeSInxUSeHcR8v0liVgw8EfE9h7DMfcu5vFmWYK4x0I7vMk0E6W7mCFhEgM9H+bY15V
	FUgAjB9llZtHiVsxLqx013zIAj4R0vzEfGWxXt+DqLfj/1yKunxZI93UeHKlCzjfYirhA9vdtgW
	/bjccpRFpgD1PIVnyr/95uADhQSpA2JbhGjpM
X-Google-Smtp-Source: AGHT+IGPSgPoH9ZurstrFWAHFz86xMcMkRukFkaqYmLdzKBpPjC+ANyiwLlIoflWM+XwEc5MT8/WXA==
X-Received: by 2002:a05:6a00:13a8:b0:772:8694:1d5d with SMTP id d2e1a72fcca58-776121a7cf8mr3981797b3a.29.1757690854453;
        Fri, 12 Sep 2025 08:27:34 -0700 (PDT)
Received: from jicarita ([65.144.169.45])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7760944a9a9sm5436846b3a.78.2025.09.12.08.27.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 08:27:33 -0700 (PDT)
From: Thomas Bertschinger <tahbertschinger@gmail.com>
To: io-uring@vger.kernel.org,
	axboe@kernel.dk,
	linux-fsdevel@vger.kernel.org,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	linux-nfs@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	cem@kernel.org,
	chuck.lever@oracle.com,
	jlayton@kernel.org,
	amir73il@gmail.com
Cc: Thomas Bertschinger <tahbertschinger@gmail.com>
Subject: [PATCH v3 03/10] fhandle: helper for allocating, reading struct file_handle
Date: Fri, 12 Sep 2025 09:28:48 -0600
Message-ID: <20250912152855.689917-4-tahbertschinger@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250912152855.689917-1-tahbertschinger@gmail.com>
References: <20250912152855.689917-1-tahbertschinger@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Pull the code for allocating and copying a struct file_handle from
userspace into a helper function get_user_handle() just for this.

do_handle_open() is updated to call get_user_handle() prior to calling
handle_to_path(), and the latter now takes a kernel pointer as a
parameter instead of a __user pointer.

This new helper, as well as handle_to_path(), are also exposed in
fs/internal.h. In a subsequent commit, io_uring will use these helpers
to support open_by_handle_at(2) in io_uring.

Signed-off-by: Thomas Bertschinger <tahbertschinger@gmail.com>
Reviewed-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/fhandle.c  | 63 +++++++++++++++++++++++++++++----------------------
 fs/internal.h |  3 +++
 2 files changed, 39 insertions(+), 27 deletions(-)

diff --git a/fs/fhandle.c b/fs/fhandle.c
index 605ad8e7d93d..4ba23229758c 100644
--- a/fs/fhandle.c
+++ b/fs/fhandle.c
@@ -330,25 +330,44 @@ static inline int may_decode_fh(struct handle_to_path_ctx *ctx,
 	return 0;
 }
 
-static int handle_to_path(int mountdirfd, struct file_handle __user *ufh,
-		   struct path *path, unsigned int o_flags)
+struct file_handle *get_user_handle(struct file_handle __user *ufh)
 {
-	int retval = 0;
 	struct file_handle f_handle;
-	struct file_handle *handle __free(kfree) = NULL;
-	struct handle_to_path_ctx ctx = {};
-	const struct export_operations *eops;
+	struct file_handle *handle;
 
 	if (copy_from_user(&f_handle, ufh, sizeof(struct file_handle)))
-		return -EFAULT;
+		return ERR_PTR(-EFAULT);
 
 	if ((f_handle.handle_bytes > MAX_HANDLE_SZ) ||
 	    (f_handle.handle_bytes == 0))
-		return -EINVAL;
+		return ERR_PTR(-EINVAL);
 
 	if (f_handle.handle_type < 0 ||
 	    FILEID_USER_FLAGS(f_handle.handle_type) & ~FILEID_VALID_USER_FLAGS)
-		return -EINVAL;
+		return ERR_PTR(-EINVAL);
+
+	handle = kmalloc(struct_size(handle, f_handle, f_handle.handle_bytes),
+			 GFP_KERNEL);
+	if (!handle)
+		return ERR_PTR(-ENOMEM);
+
+	/* copy the full handle */
+	*handle = f_handle;
+	if (copy_from_user(&handle->f_handle,
+			   &ufh->f_handle,
+			   f_handle.handle_bytes)) {
+		return ERR_PTR(-EFAULT);
+	}
+
+	return handle;
+}
+
+int handle_to_path(int mountdirfd, struct file_handle *handle,
+		   struct path *path, unsigned int o_flags)
+{
+	int retval = 0;
+	struct handle_to_path_ctx ctx = {};
+	const struct export_operations *eops;
 
 	retval = get_path_anchor(mountdirfd, &ctx.root);
 	if (retval)
@@ -362,31 +381,16 @@ static int handle_to_path(int mountdirfd, struct file_handle __user *ufh,
 	if (retval)
 		goto out_path;
 
-	handle = kmalloc(struct_size(handle, f_handle, f_handle.handle_bytes),
-			 GFP_KERNEL);
-	if (!handle) {
-		retval = -ENOMEM;
-		goto out_path;
-	}
-	/* copy the full handle */
-	*handle = f_handle;
-	if (copy_from_user(&handle->f_handle,
-			   &ufh->f_handle,
-			   f_handle.handle_bytes)) {
-		retval = -EFAULT;
-		goto out_path;
-	}
-
 	/*
 	 * If handle was encoded with AT_HANDLE_CONNECTABLE, verify that we
 	 * are decoding an fd with connected path, which is accessible from
 	 * the mount fd path.
 	 */
-	if (f_handle.handle_type & FILEID_IS_CONNECTABLE) {
+	if (handle->handle_type & FILEID_IS_CONNECTABLE) {
 		ctx.fh_flags |= EXPORT_FH_CONNECTABLE;
 		ctx.flags |= HANDLE_CHECK_SUBTREE;
 	}
-	if (f_handle.handle_type & FILEID_IS_DIR)
+	if (handle->handle_type & FILEID_IS_DIR)
 		ctx.fh_flags |= EXPORT_FH_DIR_ONLY;
 	/* Filesystem code should not be exposed to user flags */
 	handle->handle_type &= ~FILEID_USER_FLAGS_MASK;
@@ -400,12 +404,17 @@ static int handle_to_path(int mountdirfd, struct file_handle __user *ufh,
 static long do_handle_open(int mountdirfd, struct file_handle __user *ufh,
 			   int open_flag)
 {
+	struct file_handle *handle __free(kfree) = NULL;
 	long retval = 0;
 	struct path path __free(path_put) = {};
 	struct file *file;
 	const struct export_operations *eops;
 
-	retval = handle_to_path(mountdirfd, ufh, &path, open_flag);
+	handle = get_user_handle(ufh);
+	if (IS_ERR(handle))
+		return PTR_ERR(handle);
+
+	retval = handle_to_path(mountdirfd, handle, &path, open_flag);
 	if (retval)
 		return retval;
 
diff --git a/fs/internal.h b/fs/internal.h
index c972f8ade52d..ab80f83ded47 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -363,4 +363,7 @@ void pidfs_get_root(struct path *path);
 long do_sys_name_to_handle_at(int dfd, const char __user *name,
 			      struct file_handle __user *handle,
 			      void __user *mnt_id, int flag, int lookup_flags);
+struct file_handle *get_user_handle(struct file_handle __user *ufh);
+int handle_to_path(int mountdirfd, struct file_handle *handle,
+		   struct path *path, unsigned int o_flags);
 #endif /* CONFIG_FHANDLE */
-- 
2.51.0


