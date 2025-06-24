Return-Path: <linux-fsdevel+bounces-52697-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15C40AE5F4B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 10:31:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A6CA4A76ED
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 08:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EB6A25A2CC;
	Tue, 24 Jun 2025 08:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c8NNI4fY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB7B619D88F;
	Tue, 24 Jun 2025 08:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750753779; cv=none; b=gghyyB6GVkdx+NFwFoJIP/qwJOiOqoGbBsjEFn2ZqboxgqJse/nlCayQqEPqsvobY6h/FwL2jYiePTU9p/WW6zn8LhWxcfW7QX4DU6u3v8eUeu8dIH3J9zxQ/N13F4vUD+2r1wnDPhuMdzEGviYRBqf9eRlwfQRSRE0/kOlqRtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750753779; c=relaxed/simple;
	bh=m5VQXIuEiWnfUeyx6qPOXSs5V2XskYcjud51RziXKo0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UNG8Qr4Zxb5AEfhI2IVppIKo73fT2l2u+6W5URngoxmsnKD6pthgvSTvfi2J4ZxzrlnDtY9A/IWVXC+Y9/bsS3roMGWSPytSfVZxEQ5T1Jxa3e7YCaoDGpX1QevRod1MxbTVGYBKRNbKUWyiC9zpDiHehmQYvYEpxXvssut5Es4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c8NNI4fY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9EA8C4CEEF;
	Tue, 24 Jun 2025 08:29:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750753775;
	bh=m5VQXIuEiWnfUeyx6qPOXSs5V2XskYcjud51RziXKo0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=c8NNI4fYmk5gyQRi2hVYJ4++S9mcXdfHSljrBV7wrdOHgN6fWXWZNG89fkINrteQ/
	 bLzdrTMKUDfEGdHiMEtkXfGs/+4ijuUUVoRy+hEjaDifESxSqYswc12v64tdHoTmNp
	 2V1lWEIuDDFHU0VF2ZerAPbUWYcVmK7cEZfjFyOicNlaXDVlRuT9NglNxcxlxLsjtO
	 7TMijcHX75G+HYud6HqUssEGAJRvHG8bCZc/j4lnooMG7XXEEsLQhAJx/6bKUpsxMx
	 GMyvafvylxW2UjloQegoQ5+WZhHGCdsphI2mivqJB7y8lNSOUaNHQvEeUBFpVN3hvf
	 OSNRUiAnBJG6A==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 24 Jun 2025 10:29:05 +0200
Subject: [PATCH v2 02/11] fhandle: hoist copy_from_user() above
 get_path_from_fd()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250624-work-pidfs-fhandle-v2-2-d02a04858fe3@kernel.org>
References: <20250624-work-pidfs-fhandle-v2-0-d02a04858fe3@kernel.org>
In-Reply-To: <20250624-work-pidfs-fhandle-v2-0-d02a04858fe3@kernel.org>
To: Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, 
 Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-262a7
X-Developer-Signature: v=1; a=openpgp-sha256; l=2459; i=brauner@kernel.org;
 h=from:subject:message-id; bh=m5VQXIuEiWnfUeyx6qPOXSs5V2XskYcjud51RziXKo0=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWREJb7oPm6q4X/w6+TTy0RP3vpypTKiiEu41OIdQ7QqE
 +fJ7ZNjO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACayZDIjw59Vokv5dq71rN+2
 dEkJx7egSxUs657O2n+MxcBj4aekpbYM/4xt33yIvCF+T/zOObuV3GZcCnlRU41Ut6e7s5hEy3w
 5zggA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

In follow-up patches we need access to @file_handle->handle_type
before we start caring about get_path_from_fd().

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/fhandle.c | 35 ++++++++++++++---------------------
 1 file changed, 14 insertions(+), 21 deletions(-)

diff --git a/fs/fhandle.c b/fs/fhandle.c
index 66ff60591d17..73f56f8e7d5d 100644
--- a/fs/fhandle.c
+++ b/fs/fhandle.c
@@ -323,13 +323,24 @@ static int handle_to_path(int mountdirfd, struct file_handle __user *ufh,
 {
 	int retval = 0;
 	struct file_handle f_handle;
-	struct file_handle *handle = NULL;
+	struct file_handle *handle __free(kfree) = NULL;
 	struct handle_to_path_ctx ctx = {};
 	const struct export_operations *eops;
 
+	if (copy_from_user(&f_handle, ufh, sizeof(struct file_handle)))
+		return -EFAULT;
+
+	if ((f_handle.handle_bytes > MAX_HANDLE_SZ) ||
+	    (f_handle.handle_bytes == 0))
+		return -EINVAL;
+
+	if (f_handle.handle_type < 0 ||
+	    FILEID_USER_FLAGS(f_handle.handle_type) & ~FILEID_VALID_USER_FLAGS)
+		return -EINVAL;
+
 	retval = get_path_from_fd(mountdirfd, &ctx.root);
 	if (retval)
-		goto out_err;
+		return retval;
 
 	eops = ctx.root.mnt->mnt_sb->s_export_op;
 	if (eops && eops->permission)
@@ -339,21 +350,6 @@ static int handle_to_path(int mountdirfd, struct file_handle __user *ufh,
 	if (retval)
 		goto out_path;
 
-	if (copy_from_user(&f_handle, ufh, sizeof(struct file_handle))) {
-		retval = -EFAULT;
-		goto out_path;
-	}
-	if ((f_handle.handle_bytes > MAX_HANDLE_SZ) ||
-	    (f_handle.handle_bytes == 0)) {
-		retval = -EINVAL;
-		goto out_path;
-	}
-	if (f_handle.handle_type < 0 ||
-	    FILEID_USER_FLAGS(f_handle.handle_type) & ~FILEID_VALID_USER_FLAGS) {
-		retval = -EINVAL;
-		goto out_path;
-	}
-
 	handle = kmalloc(struct_size(handle, f_handle, f_handle.handle_bytes),
 			 GFP_KERNEL);
 	if (!handle) {
@@ -366,7 +362,7 @@ static int handle_to_path(int mountdirfd, struct file_handle __user *ufh,
 			   &ufh->f_handle,
 			   f_handle.handle_bytes)) {
 		retval = -EFAULT;
-		goto out_handle;
+		goto out_path;
 	}
 
 	/*
@@ -384,11 +380,8 @@ static int handle_to_path(int mountdirfd, struct file_handle __user *ufh,
 	handle->handle_type &= ~FILEID_USER_FLAGS_MASK;
 	retval = do_handle_to_path(handle, path, &ctx);
 
-out_handle:
-	kfree(handle);
 out_path:
 	path_put(&ctx.root);
-out_err:
 	return retval;
 }
 

-- 
2.47.2


