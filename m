Return-Path: <linux-fsdevel+bounces-52498-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64C66AE3948
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 11:03:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 356A1174F2B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 09:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FA4A23315A;
	Mon, 23 Jun 2025 09:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AWsRtZxs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB471C3BFC;
	Mon, 23 Jun 2025 09:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750669300; cv=none; b=IDHOaDE+nhJgIGslGE7EV0BMfJaaahMeC31msSNIcFcZN2CHBUI68wUhWX7jv8Emr5HLx+NHIQJ+w/uUDoVbTOv/hcHWVDhCY1K82RAp6Os7vy5C5AgdfYZMPN9qF18bgK9ErQ4rFLMedNd+eOV8jGhP81qBKegdgASRVdQV/ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750669300; c=relaxed/simple;
	bh=m5VQXIuEiWnfUeyx6qPOXSs5V2XskYcjud51RziXKo0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jDhbu1cDveIHIy5jUrUUZgFckmv/yIyPDB0/IkPKNJ9HZyGRNZp6ovgdc92RBnxxDhJVE5kkp9P9pIqZ1ZavGKm9ugHrsrwX5z1m7a6yp/qO0HX8L8A+77vhPEYAuKBLmyCalEU62ICFA7hUHduMedxtLWe/Tjh5T1ns74/An7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AWsRtZxs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E2D6C4CEEA;
	Mon, 23 Jun 2025 09:01:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750669300;
	bh=m5VQXIuEiWnfUeyx6qPOXSs5V2XskYcjud51RziXKo0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=AWsRtZxs6A//Mic+PRIg83Ryb2vpa9HxwYJdSe6abTDFQqzufYOZCYirh7N2UnLGO
	 mDdCy91iJx7pXdxD0GypAXaWybTxSJv7B2WXqoGTJUA1/RQuTCUNWRPoImnJ0pNN6q
	 B6OUCpIxFT4510/33adlk261exNgp6QlZa7t5jlJmPjIxb+d3t5UMaemYDt2KdhHqm
	 NnxFt3DTe3/XvSe5OJSiJASw2PuAiga00oN7cfvfuL3bMAjZ0I1qrkk4OWeS+KlraB
	 iLgISz4aN47ZS7St0b7rx1OmnD/R3i4cvwZtCFw5Re5xkT2OYcnWDcbWFvDuPOYTzD
	 10Xvfni7387Ew==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 23 Jun 2025 11:01:24 +0200
Subject: [PATCH 2/9] fhandle: hoist copy_from_user() above
 get_path_from_fd()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250623-work-pidfs-fhandle-v1-2-75899d67555f@kernel.org>
References: <20250623-work-pidfs-fhandle-v1-0-75899d67555f@kernel.org>
In-Reply-To: <20250623-work-pidfs-fhandle-v1-0-75899d67555f@kernel.org>
To: Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, 
 Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-262a7
X-Developer-Signature: v=1; a=openpgp-sha256; l=2459; i=brauner@kernel.org;
 h=from:subject:message-id; bh=m5VQXIuEiWnfUeyx6qPOXSs5V2XskYcjud51RziXKo0=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWREir/etmTR3C+nTslyfsrv6u9eGSV5/f42/f3MZb17y
 9IWJXCZdJSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAExEUoThN6vrRc4sqXt7Zq6d
 9uVtOFN46mquzMUTtFVFj4oaWMx8epzhN7utU/R7k+ebVnxWkriUvnwSQ8yrmHm87Xs3al6bPbm
 BnQUA
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


