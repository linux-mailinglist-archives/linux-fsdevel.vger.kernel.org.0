Return-Path: <linux-fsdevel+bounces-15271-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C11288B6ED
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Mar 2024 02:34:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15793B22797
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Mar 2024 01:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CD854776E;
	Tue, 26 Mar 2024 01:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tzKWX3CA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BFE0208A5;
	Tue, 26 Mar 2024 01:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711416845; cv=none; b=VrzDizhOJryb3shG6s3C2JHjDKFhYxKGyH9+6m2jpZ6YigKPqc6jhwpbcwINpyyD4DSxT+zkGkHEVocoWflyH8r65/F42gU0jnyZ8IojIeNh50OTnjXClmOQ9Kg2EXCghjuPMvr6tFPqxikg7yFu7ECAjv7tKWIcja5dScA9jMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711416845; c=relaxed/simple;
	bh=Kld8ee53LGFCJ947l/6fXt+DcJKCtXX/9+TvSa7mnjQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=nagDUTd0gWHlsiFgSNxGMyssseNqCgYyaPEOB2aUI/SDvL1+K0Zd3FV00gfsSKrl56H1NW5plLpnzy8VFulqgnN5GOsJuotLKiuTrClWgp7oHQJkQdDgMkwgcsuaWMezdMEvII+L1uML0YNAQ3Ri1BRfwfDXccyXLGdfo8I6jZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tzKWX3CA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3BAFC433F1;
	Tue, 26 Mar 2024 01:34:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711416844;
	bh=Kld8ee53LGFCJ947l/6fXt+DcJKCtXX/9+TvSa7mnjQ=;
	h=Date:From:To:Cc:Subject:From;
	b=tzKWX3CAVp6lzR+NO9U/wVxg+j/9VDnYwxQauhl5F5BKOCxTnfQYWfltEcgB/WI11
	 61diXdiwjt0DBGdZBT3+HPPR5JXaTE3cJJ8UzRQWNOXMbx6Errnhz4MWVIj23Xz2/d
	 AuJU4jyjp+I6rMRZE07Ju2rpV9IxmZGPmDq1m91dHc3twH8pS/ZdVDDvZgVkXwGI8o
	 YbRZdx9MIVqAqM+5V/MlbiG2h2Z+vyecdVitHkBxQucbJEPwMEwLGnB6ESwUUrIk8+
	 ++ZRLg+Mz7kCVn0C+aE+cHZZmqqAppSa61Mda6zq33KURZxou8DEII2sLgcggnGFQM
	 AIj1PouNR37LA==
Date: Mon, 25 Mar 2024 19:34:01 -0600
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH][next] fs: Annotate struct file_handle with __counted_by()
 and use struct_size()
Message-ID: <ZgImCXTdGDTeBvSS@neat>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Prepare for the coming implementation by GCC and Clang of the __counted_by
attribute. Flexible array members annotated with __counted_by can have
their accesses bounds-checked at run-time via CONFIG_UBSAN_BOUNDS (for
array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
functions).

While there, use struct_size() helper, instead of the open-coded
version.

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 fs/fhandle.c       | 8 ++++----
 include/linux/fs.h | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/fhandle.c b/fs/fhandle.c
index 57a12614addf..53ed54711cd2 100644
--- a/fs/fhandle.c
+++ b/fs/fhandle.c
@@ -36,7 +36,7 @@ static long do_sys_name_to_handle(const struct path *path,
 	if (f_handle.handle_bytes > MAX_HANDLE_SZ)
 		return -EINVAL;
 
-	handle = kzalloc(sizeof(struct file_handle) + f_handle.handle_bytes,
+	handle = kzalloc(struct_size(handle, f_handle, f_handle.handle_bytes),
 			 GFP_KERNEL);
 	if (!handle)
 		return -ENOMEM;
@@ -71,7 +71,7 @@ static long do_sys_name_to_handle(const struct path *path,
 	/* copy the mount id */
 	if (put_user(real_mount(path->mnt)->mnt_id, mnt_id) ||
 	    copy_to_user(ufh, handle,
-			 sizeof(struct file_handle) + handle_bytes))
+			 struct_size(handle, f_handle, handle_bytes)))
 		retval = -EFAULT;
 	kfree(handle);
 	return retval;
@@ -192,7 +192,7 @@ static int handle_to_path(int mountdirfd, struct file_handle __user *ufh,
 		retval = -EINVAL;
 		goto out_err;
 	}
-	handle = kmalloc(sizeof(struct file_handle) + f_handle.handle_bytes,
+	handle = kmalloc(struct_size(handle, f_handle, f_handle.handle_bytes),
 			 GFP_KERNEL);
 	if (!handle) {
 		retval = -ENOMEM;
@@ -202,7 +202,7 @@ static int handle_to_path(int mountdirfd, struct file_handle __user *ufh,
 	*handle = f_handle;
 	if (copy_from_user(&handle->f_handle,
 			   &ufh->f_handle,
-			   f_handle.handle_bytes)) {
+			   struct_size(ufh, f_handle, f_handle.handle_bytes))) {
 		retval = -EFAULT;
 		goto out_handle;
 	}
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 034f0c918eea..1540e28d10d7 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1033,7 +1033,7 @@ struct file_handle {
 	__u32 handle_bytes;
 	int handle_type;
 	/* file identifier */
-	unsigned char f_handle[];
+	unsigned char f_handle[] __counted_by(handle_bytes);
 };
 
 static inline struct file *get_file(struct file *f)
-- 
2.34.1


