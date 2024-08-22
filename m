Return-Path: <linux-fsdevel+bounces-26641-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9C0195AA4A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 03:30:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 398541C22CD0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 01:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A36023741;
	Thu, 22 Aug 2024 01:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HzOxQFO3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ABA411711;
	Thu, 22 Aug 2024 01:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724289936; cv=none; b=VJbjUlz4Ga4dIPnmx0/LMpbHLiI+E1IfK2aI9wzeSQoErbcet5FI0x9xp6qio3rbt6PHv39UsveKWIxErJpBirlSsn5jKnP94pFVHujsScJ4BpKtwd5KEFdUjWtPK6aWkajh7cZIZPrrg+Ajwg8ixzt8P7jUNYZ+HPzckDyAzzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724289936; c=relaxed/simple;
	bh=g3uaeVAsHyJeu5Tz3K7D6oV17IZ4IoQOeVs6zyE83IA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W79okamGV4uc33JVGnyjwMSKnlmx2XCT0JBDaIq4Q8ewHchWdFBNruaLy+4eEGoXsJqmYPNRyrYLMeYlSNvgOlmh+I/smGfwVCXN5qGCZ+E+4tA2YpIbO2sEU0Wcyhvn65Xau4CtXYJP6tBwIaSKtvB1QXsqsBy9ZfqrcJWaEl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HzOxQFO3; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724289935; x=1755825935;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=g3uaeVAsHyJeu5Tz3K7D6oV17IZ4IoQOeVs6zyE83IA=;
  b=HzOxQFO3E8Ng7EkRfZ/q6ajnJ8+H+QcJLfkh47MGnPcifMrI1xQQ9i+n
   /uUUtyJ2VAFwub8AXxTb1FUQ1z4PUrxxEvMtiFBCiOzKjPtKCKNgc6CuT
   hBohdXBX3KxBBMgbyvOy8euLS0DWbC14tAgmI2QwYoOwP1es2yx16/thp
   IfxSq1w7iPPH6QPBfoofM9cepKz8mdJWYF9hT0qGM+jQul/FVcer61M0v
   G0mymfUf3FjMvZsWKHrjMqbUD7OqDgoE/7Z83vSz/aRKedC26SsVnmx8J
   8KqpNpdifHrQq0VflbU+yRQKg8oaZhQtnRWe6LUo/Ro2f78Q4dsb0gs6P
   A==;
X-CSE-ConnectionGUID: NiCt7usnRjiHnPlmUSjM6A==
X-CSE-MsgGUID: cgrMSoouTriYYNCWnbhACg==
X-IronPort-AV: E=McAfee;i="6700,10204,11171"; a="25574725"
X-IronPort-AV: E=Sophos;i="6.10,165,1719903600"; 
   d="scan'208";a="25574725"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2024 18:25:32 -0700
X-CSE-ConnectionGUID: HWCknlldRFaxd9pasFUZVA==
X-CSE-MsgGUID: P0nBnFf+SB29clGzd6sB1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,165,1719903600"; 
   d="scan'208";a="61811021"
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
Subject: [PATCH v2 02/16] fs/backing-file: Convert to revert/override_creds_light()
Date: Wed, 21 Aug 2024 18:25:09 -0700
Message-ID: <20240822012523.141846-3-vinicius.gomes@intel.com>
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

As the credentials used by backing-file are long lived in relation to
the critical section (override_creds() -> revert_creds()) we can
replace them by their lighter alternatives.

Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
---
 fs/backing-file.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/fs/backing-file.c b/fs/backing-file.c
index afb557446c27..bc19e8e28e58 100644
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
 		ctx->accessed(ctx->user_file);
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
@@ -281,9 +281,9 @@ ssize_t backing_file_splice_read(struct file *in, loff_t *ppos,
 	if (WARN_ON_ONCE(!(in->f_mode & FMODE_BACKING)))
 		return -EIO;
 
-	old_cred = override_creds(ctx->cred);
+	old_cred = override_creds_light(ctx->cred);
 	ret = vfs_splice_read(in, ppos, pipe, len, flags);
-	revert_creds(old_cred);
+	revert_creds_light(old_cred);
 
 	if (ctx->accessed)
 		ctx->accessed(ctx->user_file);
@@ -307,11 +307,11 @@ ssize_t backing_file_splice_write(struct pipe_inode_info *pipe,
 	if (ret)
 		return ret;
 
-	old_cred = override_creds(ctx->cred);
+	old_cred = override_creds_light(ctx->cred);
 	file_start_write(out);
 	ret = iter_file_splice_write(pipe, out, ppos, len, flags);
 	file_end_write(out);
-	revert_creds(old_cred);
+	revert_creds_light(old_cred);
 
 	if (ctx->end_write)
 		ctx->end_write(ctx->user_file);
@@ -335,9 +335,9 @@ int backing_file_mmap(struct file *file, struct vm_area_struct *vma,
 
 	vma_set_file(vma, file);
 
-	old_cred = override_creds(ctx->cred);
+	old_cred = override_creds_light(ctx->cred);
 	ret = call_mmap(vma->vm_file, vma);
-	revert_creds(old_cred);
+	revert_creds_light(old_cred);
 
 	if (ctx->accessed)
 		ctx->accessed(ctx->user_file);
-- 
2.46.0


