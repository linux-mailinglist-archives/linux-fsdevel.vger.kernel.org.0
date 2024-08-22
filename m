Return-Path: <linux-fsdevel+bounces-26646-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BC6095AA57
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 03:31:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3E7B1F224FF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 01:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E81D17C231;
	Thu, 22 Aug 2024 01:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ia/gE4s3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B763A29A;
	Thu, 22 Aug 2024 01:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724289939; cv=none; b=aLKYopJKLNEFQVDZJOYPUROYZjjv957RgrN0yJz40Q4kJ3It72vIoHIf0twLsVFIxI/d+kBl9MMsssJm7WNPPqlWXov5nAUHjYXGRBx2RLAfUsultDOAW1Eavzx3ETtRnn2JSnjB2eqZQ2cPXrP8dY5G61+5J9A1WSIGy+NZNyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724289939; c=relaxed/simple;
	bh=MsVu+pOxAoknyxwy+NhCOShej6wda6wAIt+kVuEWO0w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oy1MMpnXqUJDE5XpEx0cUKwIA5VGjMXRN0Cd0gqEVlsj2hamdXJml4UfxztlcqHlovds5QCJvkhgJ5/FmSlcaoa1FnChjge/VYM5p9zOjoATOL0nmV4wX64iGTn5yJJ3Hx30sj7jKaoEGw00nOmd5lNRWPR2UoqJNZ4d5F6oEW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ia/gE4s3; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724289938; x=1755825938;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MsVu+pOxAoknyxwy+NhCOShej6wda6wAIt+kVuEWO0w=;
  b=ia/gE4s33ue+QvU9UE9ANvlkklCyChzUoMAgi960oaOSKPTdquGbHSfy
   RDtDvq3MpqgKHhuTliT+AFF/XzPUW8/rVjJn+kBUNrzdfhGBbpuRNVq/7
   A8QIhUNxBpa73M0roJb32xDlzusNH+z+QoAIGQ9FN4ptA2U63cWQ7iNvm
   wESU+2lu/VxCfYsaU5J1Alr08CKH7b+ooJLEJe/1xfikvuK8RZ0hoGxaL
   sqWtOktuQ2Y4o2sX474i0ObPLvIE84zI+sFsGX2y0+y+0i3xryWId6TOy
   534YmIpeeeXAo3ZfO3yBoP13/oEDetjDX5rcEo/hr78mEQU/5l2XUSgPd
   w==;
X-CSE-ConnectionGUID: ChUxfJcMSdGyTKwyqgHiXw==
X-CSE-MsgGUID: TSVCpE82SKmOCvzAL2Fprg==
X-IronPort-AV: E=McAfee;i="6700,10204,11171"; a="25574748"
X-IronPort-AV: E=Sophos;i="6.10,165,1719903600"; 
   d="scan'208";a="25574748"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2024 18:25:33 -0700
X-CSE-ConnectionGUID: oTQNyc6kRo2McHvALPjSUg==
X-CSE-MsgGUID: 6L66q1ejQ2SsWO15gAb/1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,165,1719903600"; 
   d="scan'208";a="61811041"
Received: from unknown (HELO vcostago-mobl3.jf.intel.com) ([10.241.225.92])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2024 18:25:32 -0700
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
Subject: [PATCH v2 07/16] fs/backing-file: Convert to cred_guard()
Date: Wed, 21 Aug 2024 18:25:14 -0700
Message-ID: <20240822012523.141846-8-vinicius.gomes@intel.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240822012523.141846-1-vinicius.gomes@intel.com>
References: <20240822012523.141846-1-vinicius.gomes@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the override_creds_light()/revert_creds_light() pairs of
operations to cred_guard().

For fs/backing-file.c, backing_file_open() and backing_tmpfile_open()
are not converted because they increase the usage counter of the
credentials in question.

Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
---
 fs/backing-file.c | 22 +++++-----------------
 1 file changed, 5 insertions(+), 17 deletions(-)

diff --git a/fs/backing-file.c b/fs/backing-file.c
index bc19e8e28e58..29fe207a2032 100644
--- a/fs/backing-file.c
+++ b/fs/backing-file.c
@@ -163,7 +163,6 @@ ssize_t backing_file_read_iter(struct file *file, struct iov_iter *iter,
 			       struct backing_file_ctx *ctx)
 {
 	struct backing_aio *aio = NULL;
-	const struct cred *old_cred;
 	ssize_t ret;
 
 	if (WARN_ON_ONCE(!(file->f_mode & FMODE_BACKING)))
@@ -176,7 +175,7 @@ ssize_t backing_file_read_iter(struct file *file, struct iov_iter *iter,
 	    !(file->f_mode & FMODE_CAN_ODIRECT))
 		return -EINVAL;
 
-	old_cred = override_creds_light(ctx->cred);
+	cred_guard(ctx->cred);
 	if (is_sync_kiocb(iocb)) {
 		rwf_t rwf = iocb_to_rw_flags(flags);
 
@@ -197,8 +196,6 @@ ssize_t backing_file_read_iter(struct file *file, struct iov_iter *iter,
 			backing_aio_cleanup(aio, ret);
 	}
 out:
-	revert_creds_light(old_cred);
-
 	if (ctx->accessed)
 		ctx->accessed(ctx->user_file);
 
@@ -210,7 +207,6 @@ ssize_t backing_file_write_iter(struct file *file, struct iov_iter *iter,
 				struct kiocb *iocb, int flags,
 				struct backing_file_ctx *ctx)
 {
-	const struct cred *old_cred;
 	ssize_t ret;
 
 	if (WARN_ON_ONCE(!(file->f_mode & FMODE_BACKING)))
@@ -233,7 +229,7 @@ ssize_t backing_file_write_iter(struct file *file, struct iov_iter *iter,
 	 */
 	flags &= ~IOCB_DIO_CALLER_COMP;
 
-	old_cred = override_creds_light(ctx->cred);
+	cred_guard(ctx->cred);
 	if (is_sync_kiocb(iocb)) {
 		rwf_t rwf = iocb_to_rw_flags(flags);
 
@@ -264,7 +260,6 @@ ssize_t backing_file_write_iter(struct file *file, struct iov_iter *iter,
 			backing_aio_cleanup(aio, ret);
 	}
 out:
-	revert_creds_light(old_cred);
 
 	return ret;
 }
@@ -275,15 +270,13 @@ ssize_t backing_file_splice_read(struct file *in, loff_t *ppos,
 				 unsigned int flags,
 				 struct backing_file_ctx *ctx)
 {
-	const struct cred *old_cred;
 	ssize_t ret;
 
 	if (WARN_ON_ONCE(!(in->f_mode & FMODE_BACKING)))
 		return -EIO;
 
-	old_cred = override_creds_light(ctx->cred);
+	cred_guard(ctx->cred);
 	ret = vfs_splice_read(in, ppos, pipe, len, flags);
-	revert_creds_light(old_cred);
 
 	if (ctx->accessed)
 		ctx->accessed(ctx->user_file);
@@ -297,7 +290,6 @@ ssize_t backing_file_splice_write(struct pipe_inode_info *pipe,
 				  unsigned int flags,
 				  struct backing_file_ctx *ctx)
 {
-	const struct cred *old_cred;
 	ssize_t ret;
 
 	if (WARN_ON_ONCE(!(out->f_mode & FMODE_BACKING)))
@@ -306,12 +298,10 @@ ssize_t backing_file_splice_write(struct pipe_inode_info *pipe,
 	ret = file_remove_privs(ctx->user_file);
 	if (ret)
 		return ret;
-
-	old_cred = override_creds_light(ctx->cred);
+	cred_guard(ctx->cred);
 	file_start_write(out);
 	ret = iter_file_splice_write(pipe, out, ppos, len, flags);
 	file_end_write(out);
-	revert_creds_light(old_cred);
 
 	if (ctx->end_write)
 		ctx->end_write(ctx->user_file);
@@ -323,7 +313,6 @@ EXPORT_SYMBOL_GPL(backing_file_splice_write);
 int backing_file_mmap(struct file *file, struct vm_area_struct *vma,
 		      struct backing_file_ctx *ctx)
 {
-	const struct cred *old_cred;
 	int ret;
 
 	if (WARN_ON_ONCE(!(file->f_mode & FMODE_BACKING)) ||
@@ -335,9 +324,8 @@ int backing_file_mmap(struct file *file, struct vm_area_struct *vma,
 
 	vma_set_file(vma, file);
 
-	old_cred = override_creds_light(ctx->cred);
+	cred_guard(ctx->cred);
 	ret = call_mmap(vma->vm_file, vma);
-	revert_creds_light(old_cred);
 
 	if (ctx->accessed)
 		ctx->accessed(ctx->user_file);
-- 
2.46.0


