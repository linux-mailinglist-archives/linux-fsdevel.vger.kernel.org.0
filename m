Return-Path: <linux-fsdevel+bounces-26649-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3374C95AA62
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 03:32:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B4791C21004
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 01:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D54D17E8E5;
	Thu, 22 Aug 2024 01:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iw/TxV9q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C52D713AA3E;
	Thu, 22 Aug 2024 01:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724289941; cv=none; b=oq4oishkEFJeOBNr3aquUn+j579H1PvTO+LPcaeMo7c5d8meal1f9hVojlkvhUhxFn/ME+gvxOJZ5SgKlAOiHJOUbAxwCjcH2mpWz7op1ApTCsgZ6bwZ/4sS9Jy2wclwEmdDGbRJbJmZuRZamR4x+JcIvrWRzxHaghJlwB+zGPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724289941; c=relaxed/simple;
	bh=7DveBzB7W1KL7ipOUxxizYtH0r2UaXXCB9/K9sjQz2k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CjjIDFvhF5EZKhRwt5roiho+Nm26NJh/IqtyXOtHXTyFwtIKTVQqWGeUURDczCNfgWIS9DL+jf4HjCRfW+m7poHhCoieGWAhozFMR50Cy6GGLs7eVmB8L/nDFbyvH1xKl5ISwfAZDx+1VSGu0fvyrfwYcrzjRKpVYu2FSA/0dkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iw/TxV9q; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724289940; x=1755825940;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7DveBzB7W1KL7ipOUxxizYtH0r2UaXXCB9/K9sjQz2k=;
  b=iw/TxV9qT1bBC1cPXC+Q3yU6abZQpl8AWGO3MEcPF+NsxQrc1KchQMQ2
   kjc0A6nd0FkBV1J6GeTBE8hrY/88xtqkFOISDpIgVPngiSzZ69Zi20SPC
   OkWDSY121o94kIRtxmkQCWt42jNT2Q/zsPsXy99imWaryb8q4OgnOg0wh
   Pjt9Jlx+AXotJfArtcXKtAMAzf9PsL6dfQ5wCaR7UhZCP1tb1ObvoMq6f
   4nsglRttnxf/vYxAu8xgvSAx/ZouE47Ufd33637LIuoMIP1ZTPJPC2lkN
   w4QW04f/JZ7mcZE5GW+m3xDapB6QebtEYc3ER9yWspIgsj7PIECBEp604
   Q==;
X-CSE-ConnectionGUID: JrQzlUkcTUW01Qp3QF+qWQ==
X-CSE-MsgGUID: 2axf8dTsSzKk+SB89YCWBA==
X-IronPort-AV: E=McAfee;i="6700,10204,11171"; a="25574760"
X-IronPort-AV: E=Sophos;i="6.10,165,1719903600"; 
   d="scan'208";a="25574760"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2024 18:25:33 -0700
X-CSE-ConnectionGUID: jsnb3tybQX2n/2LWanMgPQ==
X-CSE-MsgGUID: iY9/F+LHSbu4vM3g/4xQcQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,165,1719903600"; 
   d="scan'208";a="61811051"
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
Subject: [PATCH v2 10/16] overlayfs/file: Convert to cred_guard()
Date: Wed, 21 Aug 2024 18:25:17 -0700
Message-ID: <20240822012523.141846-11-vinicius.gomes@intel.com>
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
operations with cred_guard()/cred_scoped_guard().

Only ovl_copyfile() and ovl_fallocate() use cred_scoped_guard(),
because of 'goto', which can cause the cleanup flow to run on garbage
memory.

Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
---
 fs/overlayfs/file.c | 64 ++++++++++++++++++---------------------------
 1 file changed, 25 insertions(+), 39 deletions(-)

diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
index 5533fedcbc47..97aa657e6916 100644
--- a/fs/overlayfs/file.c
+++ b/fs/overlayfs/file.c
@@ -31,7 +31,6 @@ static struct file *ovl_open_realfile(const struct file *file,
 	struct inode *inode = file_inode(file);
 	struct mnt_idmap *real_idmap;
 	struct file *realfile;
-	const struct cred *old_cred;
 	int flags = file->f_flags | OVL_OPEN_FLAGS;
 	int acc_mode = ACC_MODE(flags);
 	int err;
@@ -39,7 +38,7 @@ static struct file *ovl_open_realfile(const struct file *file,
 	if (flags & O_APPEND)
 		acc_mode |= MAY_APPEND;
 
-	old_cred = ovl_override_creds_light(inode->i_sb);
+	cred_guard(ovl_creds(inode->i_sb));
 	real_idmap = mnt_idmap(realpath->mnt);
 	err = inode_permission(real_idmap, realinode, MAY_OPEN | acc_mode);
 	if (err) {
@@ -51,7 +50,6 @@ static struct file *ovl_open_realfile(const struct file *file,
 		realfile = backing_file_open(&file->f_path, flags, realpath,
 					     current_cred());
 	}
-	revert_creds_light(old_cred);
 
 	pr_debug("open(%p[%pD2/%c], 0%o) -> (%p, 0%o)\n",
 		 file, file, ovl_whatisit(inode, realinode), file->f_flags,
@@ -182,7 +180,6 @@ static loff_t ovl_llseek(struct file *file, loff_t offset, int whence)
 {
 	struct inode *inode = file_inode(file);
 	struct fd real;
-	const struct cred *old_cred;
 	loff_t ret;
 
 	/*
@@ -211,9 +208,8 @@ static loff_t ovl_llseek(struct file *file, loff_t offset, int whence)
 	ovl_inode_lock(inode);
 	real.file->f_pos = file->f_pos;
 
-	old_cred = ovl_override_creds_light(inode->i_sb);
+	cred_guard(ovl_creds(inode->i_sb));
 	ret = vfs_llseek(real.file, offset, whence);
-	revert_creds_light(old_cred);
 
 	file->f_pos = real.file->f_pos;
 	ovl_inode_unlock(inode);
@@ -385,7 +381,6 @@ static ssize_t ovl_splice_write(struct pipe_inode_info *pipe, struct file *out,
 static int ovl_fsync(struct file *file, loff_t start, loff_t end, int datasync)
 {
 	struct fd real;
-	const struct cred *old_cred;
 	int ret;
 
 	ret = ovl_sync_status(OVL_FS(file_inode(file)->i_sb));
@@ -398,9 +393,8 @@ static int ovl_fsync(struct file *file, loff_t start, loff_t end, int datasync)
 
 	/* Don't sync lower file for fear of receiving EROFS error */
 	if (file_inode(real.file) == ovl_inode_upper(file_inode(file))) {
-		old_cred = ovl_override_creds_light(file_inode(file)->i_sb);
+		cred_guard(ovl_creds(file_inode(file)->i_sb));
 		ret = vfs_fsync_range(real.file, start, end, datasync);
-		revert_creds_light(old_cred);
 	}
 
 	fdput(real);
@@ -424,7 +418,6 @@ static long ovl_fallocate(struct file *file, int mode, loff_t offset, loff_t len
 {
 	struct inode *inode = file_inode(file);
 	struct fd real;
-	const struct cred *old_cred;
 	int ret;
 
 	inode_lock(inode);
@@ -438,9 +431,8 @@ static long ovl_fallocate(struct file *file, int mode, loff_t offset, loff_t len
 	if (ret)
 		goto out_unlock;
 
-	old_cred = ovl_override_creds_light(file_inode(file)->i_sb);
-	ret = vfs_fallocate(real.file, mode, offset, len);
-	revert_creds_light(old_cred);
+	cred_scoped_guard(ovl_creds(file_inode(file)->i_sb))
+		ret = vfs_fallocate(real.file, mode, offset, len);
 
 	/* Update size */
 	ovl_file_modified(file);
@@ -456,16 +448,14 @@ static long ovl_fallocate(struct file *file, int mode, loff_t offset, loff_t len
 static int ovl_fadvise(struct file *file, loff_t offset, loff_t len, int advice)
 {
 	struct fd real;
-	const struct cred *old_cred;
 	int ret;
 
 	ret = ovl_real_fdget(file, &real);
 	if (ret)
 		return ret;
 
-	old_cred = ovl_override_creds_light(file_inode(file)->i_sb);
+	cred_guard(ovl_creds(file_inode(file)->i_sb));
 	ret = vfs_fadvise(real.file, offset, len, advice);
-	revert_creds_light(old_cred);
 
 	fdput(real);
 
@@ -484,7 +474,6 @@ static loff_t ovl_copyfile(struct file *file_in, loff_t pos_in,
 {
 	struct inode *inode_out = file_inode(file_out);
 	struct fd real_in, real_out;
-	const struct cred *old_cred;
 	loff_t ret;
 
 	inode_lock(inode_out);
@@ -506,26 +495,25 @@ static loff_t ovl_copyfile(struct file *file_in, loff_t pos_in,
 		goto out_unlock;
 	}
 
-	old_cred = ovl_override_creds_light(file_inode(file_out)->i_sb);
-	switch (op) {
-	case OVL_COPY:
-		ret = vfs_copy_file_range(real_in.file, pos_in,
-					  real_out.file, pos_out, len, flags);
-		break;
-
-	case OVL_CLONE:
-		ret = vfs_clone_file_range(real_in.file, pos_in,
-					   real_out.file, pos_out, len, flags);
-		break;
-
-	case OVL_DEDUPE:
-		ret = vfs_dedupe_file_range_one(real_in.file, pos_in,
-						real_out.file, pos_out, len,
-						flags);
-		break;
+	cred_scoped_guard(ovl_creds(file_inode(file_out)->i_sb)) {
+		switch (op) {
+		case OVL_COPY:
+			ret = vfs_copy_file_range(real_in.file, pos_in,
+						  real_out.file, pos_out, len, flags);
+			break;
+
+		case OVL_CLONE:
+			ret = vfs_clone_file_range(real_in.file, pos_in,
+						   real_out.file, pos_out, len, flags);
+			break;
+
+		case OVL_DEDUPE:
+			ret = vfs_dedupe_file_range_one(real_in.file, pos_in,
+							real_out.file, pos_out, len,
+							flags);
+			break;
+		}
 	}
-	revert_creds_light(old_cred);
-
 	/* Update size */
 	ovl_file_modified(file_out);
 
@@ -576,7 +564,6 @@ static loff_t ovl_remap_file_range(struct file *file_in, loff_t pos_in,
 static int ovl_flush(struct file *file, fl_owner_t id)
 {
 	struct fd real;
-	const struct cred *old_cred;
 	int err;
 
 	err = ovl_real_fdget(file, &real);
@@ -584,9 +571,8 @@ static int ovl_flush(struct file *file, fl_owner_t id)
 		return err;
 
 	if (real.file->f_op->flush) {
-		old_cred = ovl_override_creds_light(file_inode(file)->i_sb);
+		cred_guard(ovl_creds(file_inode(file)->i_sb));
 		err = real.file->f_op->flush(real.file, id);
-		revert_creds_light(old_cred);
 	}
 	fdput(real);
 
-- 
2.46.0


