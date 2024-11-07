Return-Path: <linux-fsdevel+bounces-33854-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ABA19BFB0E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2024 01:58:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 925D2B22979
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2024 00:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D8F417543;
	Thu,  7 Nov 2024 00:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mgB3nxIv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D51F1DDA9;
	Thu,  7 Nov 2024 00:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730941066; cv=none; b=k19raEAz2nESOh3ojzFxhti6JaHaMckj+whD/4wON+oP/blF/YbCTkQF09NsGPfefqfxhOkUEynv4h6ti/LhAeO5iA6a5RhViO70o+YTFHBNXcGAPsfnF+ulHRuNQafaaa0TDcVYoafV96TVtYUgcb0pQMPiaEXEU62IeN6YZbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730941066; c=relaxed/simple;
	bh=Nv/kEc4CVTqwYdLKuLpdo5expB9qETdFqCz08KbSXzQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X0J3Nk0qepNdMYq8iYc3fcipBdhs7fWnwAb4nUUqakhRnlLvPY9/bZCuFlnKPUKOiRoDW7zSbnvvIRdCt6/GbUTQ7u7zp8aItw66210LauKh06KuHWWlRGd7OwRAaxSF3m0CmAQ77f9EzwNZH0NqRLAzASl3/v/3nPJHmrjOj7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mgB3nxIv; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730941065; x=1762477065;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Nv/kEc4CVTqwYdLKuLpdo5expB9qETdFqCz08KbSXzQ=;
  b=mgB3nxIvWJWRd1eZBEaQntHX8BFfu+jwuGoEV5tjIy2ljcREd8KDFxIG
   zbf0+WHlU7dO9EAEU8s0BxnDzZ/TffI5ljpR1RkZgVvAP6pl7bu0hD1Do
   TuXmeaFvf+XXEnN+587LvHrQaO2uYe+IIQOyxtdGNhGgDaoKdkUxjsvWy
   80XV+0OZTtJkLr/3kBtRHDCi61mVC4pgpGvb7eeX7hx3+WybNoZ1HlVh+
   BFX6Y7B8v6vVxbXzd5ynlGXfLKcKmyo++ruASWc+kLMjSHRwXeOUMxS0D
   gQ0/CbsGw7/8ioUQAvf29qD4NAiix/WQ5KUj7pmI4mzYmtCbcTTQYkatJ
   A==;
X-CSE-ConnectionGUID: WEDjjHoYT2ec6k3Fa6AvOg==
X-CSE-MsgGUID: yhjgoDMzSUui9/CvBbPjgw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="41320187"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="41320187"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2024 16:57:42 -0800
X-CSE-ConnectionGUID: JoIOGtVlQI+5hQCAKFKVNg==
X-CSE-MsgGUID: A+8Ikt7yR8OeZ4wxzda/RQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,264,1725346800"; 
   d="scan'208";a="85193431"
Received: from rfrazer-mobl3.amr.corp.intel.com (HELO vcostago-mobl3.lan) ([10.124.222.105])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2024 16:57:42 -0800
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
Subject: [PATCH v4 2/4] fs/backing-file: Convert to revert/override_creds_light()
Date: Wed,  6 Nov 2024 16:57:18 -0800
Message-ID: <20241107005720.901335-3-vinicius.gomes@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241107005720.901335-1-vinicius.gomes@intel.com>
References: <20241107005720.901335-1-vinicius.gomes@intel.com>
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


