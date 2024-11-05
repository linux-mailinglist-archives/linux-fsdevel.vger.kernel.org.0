Return-Path: <linux-fsdevel+bounces-33695-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 901DB9BD5F4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Nov 2024 20:36:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 550B3280F57
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Nov 2024 19:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DFEC21265C;
	Tue,  5 Nov 2024 19:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z6JItqWB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C6A820E02C;
	Tue,  5 Nov 2024 19:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730835341; cv=none; b=dyk/VDn5s/fgQJBoc9AeAIb7bgbcodTmy91EZ2zBPJ19H5GtF1+PZBosV99DwyhcQwg0v3hIIhyIMHNREODuh5L3eIOv7S5V/K5TH2aPNVmvtE+V6UyNsIoezVjzeyPh0FyFN/IiAGwyF8FPL2txoIQNR5ZAOOZno5KfNmaua/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730835341; c=relaxed/simple;
	bh=Nv/kEc4CVTqwYdLKuLpdo5expB9qETdFqCz08KbSXzQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qXYWkMPqgtdzG+EuewCUGUtLuKwhwej65Szx2tneeHXEJfIkeJumSgld4OuNMNhYfzzz9s54P6BOkMH02fFKVMVFStUA1kf4R4AODoeSvL4IkuWvXIkCl2CsqoSiEmFXRNZzVRS1jjiHieBa/TxESo71nAXKnDgTUJC+cMSVEwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z6JItqWB; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730835340; x=1762371340;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Nv/kEc4CVTqwYdLKuLpdo5expB9qETdFqCz08KbSXzQ=;
  b=Z6JItqWBnKGoraJz7TKkZugnOTQS4y0j4rv2ZcUCzNYBjwsgFiIJPt/5
   RG8xLlHdLGY6RhepSYsibFgeSORNhA4YXHzTCuXiDGC9unfaB9TLyXeKZ
   3FlEKy3gPK5wo/IEdufkGMGydjg2+vq0NVonVmgguTb4P2STLY/N1k8On
   1a/l95/zPKn9mSEH5q5VBBLxf3xc9Daw1KVbY7a34LnxJiqBCYOxpjTtk
   OBELStMRs9SVBznexaV1QkhupUNFlesaJPEGMyZbntTie2aiM+Av/MLnx
   bcU8e60EkCPcGzgHM64OYtaOdKzwO2ZmN4ytkpC8QWtJlOsTgURa4yET7
   g==;
X-CSE-ConnectionGUID: MCEvghJzQvWWR+4Rj/wg6Q==
X-CSE-MsgGUID: Y91/mFDvQxi8TojUnEq7xw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="34297819"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="34297819"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2024 11:35:36 -0800
X-CSE-ConnectionGUID: LfvPeTFeSlO6kKFIngGpXA==
X-CSE-MsgGUID: BhsClcRnQY2kpNqQPs2AnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,261,1725346800"; 
   d="scan'208";a="114939399"
Received: from ehanks-mobl1.amr.corp.intel.com (HELO vcostago-mobl3.intel.com) ([10.124.221.238])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2024 11:35:35 -0800
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: brauner@kernel.org,
	amir73il@gmail.com,
	hu1.chen@intel.com
Cc: miklos@szeredi.hu,
	malini.bhandaru@intel.com,
	tim.c.chen@intel.com,
	mikko.ylinen@intel.com,
	linux-unionfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>
Subject: [PATCH overlayfs-next v3 2/4] fs/backing-file: Convert to revert/override_creds_light()
Date: Tue,  5 Nov 2024 11:35:12 -0800
Message-ID: <20241105193514.828616-3-vinicius.gomes@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241105193514.828616-1-vinicius.gomes@intel.com>
References: <20241105193514.828616-1-vinicius.gomes@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As the credentials used by backing-file are long lived in relation to
the critical section (override_creds() -> revert_creds()) we can
replace them by their lighter alternatives.

Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
---
 fs/backing-file.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/fs/backing-file.c b/fs/backing-file.c
index a38737592ec7..526ddb4d6f76 100644
--- a/fs/backing-file.c
+++ b/fs/backing-file.c
@@ -176,7 +176,7 @@ ssize_t backing_file_read_iter(struct file *file, struct iov_iter *iter,
 	    !(file->f_mode & FMODE_CAN_ODIRECT))
 		return -EINVAL;
 
-	old_cred = override_creds(ctx->cred);
+	old_cred = override_creds_light(ctx->cred);
 	if (is_sync_kiocb(iocb)) {
 		rwf_t rwf = iocb_to_rw_flags(flags);
 
@@ -197,7 +197,7 @@ ssize_t backing_file_read_iter(struct file *file, struct iov_iter *iter,
 			backing_aio_cleanup(aio, ret);
 	}
 out:
-	revert_creds(old_cred);
+	revert_creds_light(old_cred);
 
 	if (ctx->accessed)
 		ctx->accessed(iocb->ki_filp);
@@ -233,7 +233,7 @@ ssize_t backing_file_write_iter(struct file *file, struct iov_iter *iter,
 	 */
 	flags &= ~IOCB_DIO_CALLER_COMP;
 
-	old_cred = override_creds(ctx->cred);
+	old_cred = override_creds_light(ctx->cred);
 	if (is_sync_kiocb(iocb)) {
 		rwf_t rwf = iocb_to_rw_flags(flags);
 
@@ -264,7 +264,7 @@ ssize_t backing_file_write_iter(struct file *file, struct iov_iter *iter,
 			backing_aio_cleanup(aio, ret);
 	}
 out:
-	revert_creds(old_cred);
+	revert_creds_light(old_cred);
 
 	return ret;
 }
@@ -281,9 +281,9 @@ ssize_t backing_file_splice_read(struct file *in, struct kiocb *iocb,
 	if (WARN_ON_ONCE(!(in->f_mode & FMODE_BACKING)))
 		return -EIO;
 
-	old_cred = override_creds(ctx->cred);
+	old_cred = override_creds_light(ctx->cred);
 	ret = vfs_splice_read(in, &iocb->ki_pos, pipe, len, flags);
-	revert_creds(old_cred);
+	revert_creds_light(old_cred);
 
 	if (ctx->accessed)
 		ctx->accessed(iocb->ki_filp);
@@ -310,11 +310,11 @@ ssize_t backing_file_splice_write(struct pipe_inode_info *pipe,
 	if (ret)
 		return ret;
 
-	old_cred = override_creds(ctx->cred);
+	old_cred = override_creds_light(ctx->cred);
 	file_start_write(out);
 	ret = out->f_op->splice_write(pipe, out, &iocb->ki_pos, len, flags);
 	file_end_write(out);
-	revert_creds(old_cred);
+	revert_creds_light(old_cred);
 
 	if (ctx->end_write)
 		ctx->end_write(iocb, ret);
@@ -337,9 +337,9 @@ int backing_file_mmap(struct file *file, struct vm_area_struct *vma,
 
 	vma_set_file(vma, file);
 
-	old_cred = override_creds(ctx->cred);
+	old_cred = override_creds_light(ctx->cred);
 	ret = call_mmap(vma->vm_file, vma);
-	revert_creds(old_cred);
+	revert_creds_light(old_cred);
 
 	if (ctx->accessed)
 		ctx->accessed(vma->vm_file);
-- 
2.47.0


