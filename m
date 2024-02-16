Return-Path: <linux-fsdevel+bounces-11818-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9BD0857590
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Feb 2024 06:18:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E2771F24AE2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Feb 2024 05:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC1DC17BDD;
	Fri, 16 Feb 2024 05:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e5n6K1NH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D5AF14A9F;
	Fri, 16 Feb 2024 05:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708060623; cv=none; b=oK2lzbgoEp63ZASrEe1eSQ6Co41v3l3Vhe8To5932j1zc6lfsS23qpUEQO+TL+0ft2qv4asaBiPi8dqk/U+7ry87EIp2M5y1efHE6npFgAfhUrb19VYI4j5Cbc5xL0YXpqju3mxXGeUx80zW63B/7ErI7dFwraS28jEDBCD9mDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708060623; c=relaxed/simple;
	bh=MaswYxz/q3Dw9RFo7bv6BMCxnVmoIlC4gCgWtYO+cJI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QZWvC/6h7HdauVK1oHL70jHuLdTzWcC6n3lBWuYpnscvPcRQMj+eNgVShdQvrRNIWOETWhtyyWOd75TMi5+nXYZCOUymFl+FwOb/ryhOzRy+/Zjs5pS8BsZ9RVdhjzt5rgVm5B8vE7I5iS+whTj3jbNByPUltJC6X8fHFFSZhLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e5n6K1NH; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708060621; x=1739596621;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MaswYxz/q3Dw9RFo7bv6BMCxnVmoIlC4gCgWtYO+cJI=;
  b=e5n6K1NHN8gr7Hdn/s8zz7SxVBoV2iC1fM44bF5s3WM+0INhp7RHBBqN
   KASgi/iuhordvlyScNXhSyxNjAOoSaPgVVGH1y2JrBLXB7vAeqXMxea4c
   JNSN83eykQN0Pejc2JhjEG1N3/ndcGUUTckhwEmdhkiNqxC2zC2W53TIy
   eqTM/acbxAWcRsQXmIRR6VmlstL+uAkgazWTieY/yHoIv3vj9s53Ksdj6
   ptptz4uji4eTFOQQ/TZTEKV5PVg90td6xB52mo+TVGErxQEE/wWBbMub+
   DefSaswW+wRk6xTcFW2BAdDltG0OyhQ7Bye+Bsw/t7iHY+IYWCFIl88jV
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10985"; a="5149353"
X-IronPort-AV: E=Sophos;i="6.06,163,1705392000"; 
   d="scan'208";a="5149353"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2024 21:16:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,163,1705392000"; 
   d="scan'208";a="4063894"
Received: from lvngo-mobl1.amr.corp.intel.com (HELO vcostago-mobl3.intel.com) ([10.125.17.186])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2024 21:16:57 -0800
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
Subject: [RFC v3 4/5] fs: Optimize credentials reference count for backing file ops
Date: Thu, 15 Feb 2024 21:16:39 -0800
Message-ID: <20240216051640.197378-5-vinicius.gomes@intel.com>
X-Mailer: git-send-email 2.43.1
In-Reply-To: <20240216051640.197378-1-vinicius.gomes@intel.com>
References: <20240216051640.197378-1-vinicius.gomes@intel.com>
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
index a681f38d84d8..2cd015f49382 100644
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
+	guard(cred)(ctx->cred);
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
+	guard(cred)(ctx->cred);
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
+	guard(cred)(ctx->cred);
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
+	guard(cred)(ctx->cred);
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
+	guard(cred)(ctx->cred);
 	ret = call_mmap(vma->vm_file, vma);
-	revert_creds(old_cred);
 
 	if (ctx->accessed)
 		ctx->accessed(ctx->user_file);
-- 
2.43.1


