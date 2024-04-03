Return-Path: <linux-fsdevel+bounces-15959-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B42E7896267
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 04:18:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7243C2811A1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 02:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1942E1BC58;
	Wed,  3 Apr 2024 02:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MCBsxqyk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF70F179A7;
	Wed,  3 Apr 2024 02:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712110701; cv=none; b=b/oB0ArdbiWeVQ2fwpI/E5fx6xImaBzO/Bo3lzMbe2SxQ8B20PQ3POoQB1gKc2+k5iMd8vAIrb0bP+KX7HW6jzX94S2JfKhQkc7DZo3b8qELOcNaH52gPpgUjNKuR6mUcj8PLef1tmaQnr14Ninj6WoItz9NGjLcrf0otj6LVdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712110701; c=relaxed/simple;
	bh=lkBrPdiDG3lp2n6FWZ73h/jutoiDvlefEPM4VuHIkaM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p43QbuZ4yPDCpwCd5hrLrAKz509EiBr3yJmSFtItXONAVYWHLx/b+mViQ3ZLrHtpF13lzToJtMXY9STHK3lyFcsegH2RsBDs8Zct73sqBKtCEyqqbMdSJcH9TlJ8micJstHal/iAHRiDbT9+XdMnte7/8lnt/Ofdl7rnc0bJvls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MCBsxqyk; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712110700; x=1743646700;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lkBrPdiDG3lp2n6FWZ73h/jutoiDvlefEPM4VuHIkaM=;
  b=MCBsxqykw3XFm+CaLshvM3EjrOszT9XH5AlD64jCV9ld9gVqXCFVFsMU
   p63hf0Tn4vk8ka/Fo64Bec/zCkrh3d0LpU3lIFK2qMToBD+0tcl+xXv+f
   yGfIJ8ofGAl7hoFiQQIX2FjA8y+0LNnRNLuTRz9sKHf8xbC0CfXguzxOn
   GY+P9/T8/8hY6ZrgCQf3fX71kKDDGa8wwjeZsmxoJfDhJwPpQ77H4Ifxd
   ZUwCTeRGng+E+pfVzvQzUez6jP0pNWJBQoLk3xQq+9aDq8VuJsrm4CiOd
   JqMRzgmeZcb8hn/nJ7hj95IYKFQtGp7bS/wXGfyJjDMxgoo8Z1xtTSkya
   g==;
X-CSE-ConnectionGUID: rjwF7fcqRMGhj6QIaz0dOQ==
X-CSE-MsgGUID: Xh++U9IZToebcIRFQTZcCQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="7164931"
X-IronPort-AV: E=Sophos;i="6.07,176,1708416000"; 
   d="scan'208";a="7164931"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 19:18:18 -0700
X-CSE-ConnectionGUID: AFaBwli9SJ2NPgauo18gkQ==
X-CSE-MsgGUID: 3aqSORQFSSCDCv/2vQidgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,176,1708416000"; 
   d="scan'208";a="55718007"
Received: from unknown (HELO vcostago-mobl3.intel.com) ([10.124.222.184])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 19:18:17 -0700
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: brauner@kernel.org,
	amir73il@gmail.com,
	hu1.chen@intel.com
Cc: miklos@szeredi.hu,
	malini.bhandaru@intel.com,
	tim.c.chen@intel.com,
	mikko.ylinen@intel.com,
	lizhen.you@intel.com,
	linux-unionfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>
Subject: [PATCH v1 2/3] fs: Optimize credentials reference count for backing file ops
Date: Tue,  2 Apr 2024 19:18:07 -0700
Message-ID: <20240403021808.309900-3-vinicius.gomes@intel.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240403021808.309900-1-vinicius.gomes@intel.com>
References: <20240403021808.309900-1-vinicius.gomes@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For backing file operations, users are expected to pass credentials
that will outlive the backing file common operations.

Use the specialized guard statements to override/revert the
credentials.

Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
---
 fs/backing-file.c | 27 +++++++--------------------
 1 file changed, 7 insertions(+), 20 deletions(-)

diff --git a/fs/backing-file.c b/fs/backing-file.c
index 740185198db3..9610d5166736 100644
--- a/fs/backing-file.c
+++ b/fs/backing-file.c
@@ -140,7 +140,6 @@ ssize_t backing_file_read_iter(struct file *file, struct iov_iter *iter,
 			       struct backing_file_ctx *ctx)
 {
 	struct backing_aio *aio = NULL;
-	const struct cred *old_cred;
 	ssize_t ret;
 
 	if (WARN_ON_ONCE(!(file->f_mode & FMODE_BACKING)))
@@ -153,7 +152,7 @@ ssize_t backing_file_read_iter(struct file *file, struct iov_iter *iter,
 	    !(file->f_mode & FMODE_CAN_ODIRECT))
 		return -EINVAL;
 
-	old_cred = override_creds(ctx->cred);
+	cred_guard(ctx->cred);
 	if (is_sync_kiocb(iocb)) {
 		rwf_t rwf = iocb_to_rw_flags(flags);
 
@@ -174,8 +173,6 @@ ssize_t backing_file_read_iter(struct file *file, struct iov_iter *iter,
 			backing_aio_cleanup(aio, ret);
 	}
 out:
-	revert_creds(old_cred);
-
 	if (ctx->accessed)
 		ctx->accessed(ctx->user_file);
 
@@ -187,7 +184,6 @@ ssize_t backing_file_write_iter(struct file *file, struct iov_iter *iter,
 				struct kiocb *iocb, int flags,
 				struct backing_file_ctx *ctx)
 {
-	const struct cred *old_cred;
 	ssize_t ret;
 
 	if (WARN_ON_ONCE(!(file->f_mode & FMODE_BACKING)))
@@ -210,7 +206,7 @@ ssize_t backing_file_write_iter(struct file *file, struct iov_iter *iter,
 	 */
 	flags &= ~IOCB_DIO_CALLER_COMP;
 
-	old_cred = override_creds(ctx->cred);
+	cred_guard(ctx->cred);
 	if (is_sync_kiocb(iocb)) {
 		rwf_t rwf = iocb_to_rw_flags(flags);
 
@@ -222,12 +218,12 @@ ssize_t backing_file_write_iter(struct file *file, struct iov_iter *iter,
 
 		ret = backing_aio_init_wq(iocb);
 		if (ret)
-			goto out;
+			return ret;
 
 		ret = -ENOMEM;
 		aio = kmem_cache_zalloc(backing_aio_cachep, GFP_KERNEL);
 		if (!aio)
-			goto out;
+			return ret;
 
 		aio->orig_iocb = iocb;
 		aio->end_write = ctx->end_write;
@@ -240,9 +236,6 @@ ssize_t backing_file_write_iter(struct file *file, struct iov_iter *iter,
 		if (ret != -EIOCBQUEUED)
 			backing_aio_cleanup(aio, ret);
 	}
-out:
-	revert_creds(old_cred);
-
 	return ret;
 }
 EXPORT_SYMBOL_GPL(backing_file_write_iter);
@@ -252,15 +245,13 @@ ssize_t backing_file_splice_read(struct file *in, loff_t *ppos,
 				 unsigned int flags,
 				 struct backing_file_ctx *ctx)
 {
-	const struct cred *old_cred;
 	ssize_t ret;
 
 	if (WARN_ON_ONCE(!(in->f_mode & FMODE_BACKING)))
 		return -EIO;
 
-	old_cred = override_creds(ctx->cred);
+	cred_guard(ctx->cred);
 	ret = vfs_splice_read(in, ppos, pipe, len, flags);
-	revert_creds(old_cred);
 
 	if (ctx->accessed)
 		ctx->accessed(ctx->user_file);
@@ -274,7 +265,6 @@ ssize_t backing_file_splice_write(struct pipe_inode_info *pipe,
 				  unsigned int flags,
 				  struct backing_file_ctx *ctx)
 {
-	const struct cred *old_cred;
 	ssize_t ret;
 
 	if (WARN_ON_ONCE(!(out->f_mode & FMODE_BACKING)))
@@ -284,11 +274,10 @@ ssize_t backing_file_splice_write(struct pipe_inode_info *pipe,
 	if (ret)
 		return ret;
 
-	old_cred = override_creds(ctx->cred);
+	cred_guard(ctx->cred);
 	file_start_write(out);
 	ret = iter_file_splice_write(pipe, out, ppos, len, flags);
 	file_end_write(out);
-	revert_creds(old_cred);
 
 	if (ctx->end_write)
 		ctx->end_write(ctx->user_file);
@@ -300,7 +289,6 @@ EXPORT_SYMBOL_GPL(backing_file_splice_write);
 int backing_file_mmap(struct file *file, struct vm_area_struct *vma,
 		      struct backing_file_ctx *ctx)
 {
-	const struct cred *old_cred;
 	int ret;
 
 	if (WARN_ON_ONCE(!(file->f_mode & FMODE_BACKING)) ||
@@ -312,9 +300,8 @@ int backing_file_mmap(struct file *file, struct vm_area_struct *vma,
 
 	vma_set_file(vma, file);
 
-	old_cred = override_creds(ctx->cred);
+	cred_guard(ctx->cred);
 	ret = call_mmap(vma->vm_file, vma);
-	revert_creds(old_cred);
 
 	if (ctx->accessed)
 		ctx->accessed(ctx->user_file);
-- 
2.44.0


