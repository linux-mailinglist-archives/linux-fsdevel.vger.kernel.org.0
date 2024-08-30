Return-Path: <linux-fsdevel+bounces-28035-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AFEA966294
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2024 15:08:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DD301C24474
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2024 13:08:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B5461B3B13;
	Fri, 30 Aug 2024 13:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IwCFV0rZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB2C71AF4F9
	for <linux-fsdevel@vger.kernel.org>; Fri, 30 Aug 2024 13:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725023172; cv=none; b=fuu5uVXXpc0Cqyv4iGA9sjSaIrpdYGAEWtyuoqjZJNpOHYr5zk96JgVJib6EsIqETe4SKxqBqzPH38z5OCnbJLtmVWujHatyPMtcTXbSPimyhuuG3BbP8RsLSMgf0VzMTDbNM5tgiYXtK4DWdJ41ijsOnydor9eAF7L/ZwBxanw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725023172; c=relaxed/simple;
	bh=Xtr4hSA6zi572+OZOYqTqxLNXXtD13Ffk+HiNZKb6Bw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=b0IWF0vA6JprQuDiRRTEpLvHbqvvnHP8fwOZXQbOtFnv6mY+G8GN3C+7SuOB9bNRbO4U0grGEAIbOHDvUiPxo6iJf2rCNgp8dwphW2bGhX+xo9471Cem4pvrq4LmmQsn3yME98gn8RZ/FhxI0yqE6LX06jzwWfSWCfWnXDIkHG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IwCFV0rZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0368C4CEC2;
	Fri, 30 Aug 2024 13:06:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725023172;
	bh=Xtr4hSA6zi572+OZOYqTqxLNXXtD13Ffk+HiNZKb6Bw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=IwCFV0rZmR4yk9Ak2Ck80eQ3VWJFp7umwpsfHjlVM+lQEGWsYieAsEH+9MmmAseSK
	 uXU3/UvkR7gH3bPEsP5qSvbLuqwglF04LOOTk1vWfys77FORY3UW637Tim+PZkuGjy
	 AJE6NAXOFTxi1BUMaYQh88dpJL8L72DV196CVnHPE62KQUyD7uakMVehxzZOvu2cM6
	 /r6zBEFdiPPHQrpArTC5IVloCOQDy6icdppbKF6S9caNi01cD7BChs2A3yRz7bC73V
	 wFMXvyQhrev0hFwVibaWfWRDRaMyDKNnQ/QkGxGsbttYO2ioKgszkB8ISsjum2YAN4
	 yrR4Rth7s/eWw==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 30 Aug 2024 15:04:54 +0200
Subject: [PATCH RFC 13/20] ocfs2: store cookie in private data
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240830-vfs-file-f_version-v1-13-6d3e4816aa7b@kernel.org>
References: <20240830-vfs-file-f_version-v1-0-6d3e4816aa7b@kernel.org>
In-Reply-To: <20240830-vfs-file-f_version-v1-0-6d3e4816aa7b@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Jan Kara <jack@suse.com>, Al Viro <viro@zeniv.linux.org.uk>, 
 Jeff Layton <jlayton@kernel.org>, Josef Bacik <josef@toxicpanda.com>, 
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@infradead.org>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-37811
X-Developer-Signature: v=1; a=openpgp-sha256; l=2640; i=brauner@kernel.org;
 h=from:subject:message-id; bh=Xtr4hSA6zi572+OZOYqTqxLNXXtD13Ffk+HiNZKb6Bw=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRdPDyn4k9/5qtgs/Wf/jGdCF7JYL71vcSFa/Hfyx1vz
 +RLPeth3VHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRldcZGWbvv79K4+u1CUcX
 ciU2zXr27NGEC/H3FDwdxTRvyb9Krz/JyHBt1ty/QdPYl5ULr7TWqz6ynrXs4roMIabUp4subt+
 lvZYBAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Store the cookie to detect concurrent seeks on directories in
file->private_data.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/ocfs2/dir.c  |  3 ++-
 fs/ocfs2/file.c | 11 +++++++++--
 fs/ocfs2/file.h |  1 +
 3 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/fs/ocfs2/dir.c b/fs/ocfs2/dir.c
index f0beb173dbba..ccef3f42b333 100644
--- a/fs/ocfs2/dir.c
+++ b/fs/ocfs2/dir.c
@@ -1932,6 +1932,7 @@ int ocfs2_readdir(struct file *file, struct dir_context *ctx)
 {
 	int error = 0;
 	struct inode *inode = file_inode(file);
+	struct ocfs2_file_private *fp = file->private_data;
 	int lock_level = 0;
 
 	trace_ocfs2_readdir((unsigned long long)OCFS2_I(inode)->ip_blkno);
@@ -1952,7 +1953,7 @@ int ocfs2_readdir(struct file *file, struct dir_context *ctx)
 		goto bail_nolock;
 	}
 
-	error = ocfs2_dir_foreach_blk(inode, &file->f_version, ctx, false);
+	error = ocfs2_dir_foreach_blk(inode, &fp->cookie, ctx, false);
 
 	ocfs2_inode_unlock(inode, lock_level);
 	if (error)
diff --git a/fs/ocfs2/file.c b/fs/ocfs2/file.c
index ccc57038a977..115ab2172820 100644
--- a/fs/ocfs2/file.c
+++ b/fs/ocfs2/file.c
@@ -2750,6 +2750,13 @@ static loff_t ocfs2_remap_file_range(struct file *file_in, loff_t pos_in,
 	return remapped > 0 ? remapped : ret;
 }
 
+static loff_t ocfs2_dir_llseek(struct file *file, loff_t offset, int whence)
+{
+	struct ocfs2_file_private *fp = file->private_data;
+
+	return generic_llseek_cookie(file, offset, whence, &fp->cookie);
+}
+
 const struct inode_operations ocfs2_file_iops = {
 	.setattr	= ocfs2_setattr,
 	.getattr	= ocfs2_getattr,
@@ -2797,7 +2804,7 @@ const struct file_operations ocfs2_fops = {
 
 WRAP_DIR_ITER(ocfs2_readdir) // FIXME!
 const struct file_operations ocfs2_dops = {
-	.llseek		= generic_file_llseek,
+	.llseek		= ocfs2_dir_llseek,
 	.read		= generic_read_dir,
 	.iterate_shared	= shared_ocfs2_readdir,
 	.fsync		= ocfs2_sync_file,
@@ -2843,7 +2850,7 @@ const struct file_operations ocfs2_fops_no_plocks = {
 };
 
 const struct file_operations ocfs2_dops_no_plocks = {
-	.llseek		= generic_file_llseek,
+	.llseek		= ocfs2_dir_llseek,
 	.read		= generic_read_dir,
 	.iterate_shared	= shared_ocfs2_readdir,
 	.fsync		= ocfs2_sync_file,
diff --git a/fs/ocfs2/file.h b/fs/ocfs2/file.h
index 8e53e4ac1120..41e65e45a9f3 100644
--- a/fs/ocfs2/file.h
+++ b/fs/ocfs2/file.h
@@ -20,6 +20,7 @@ struct ocfs2_alloc_context;
 enum ocfs2_alloc_restarted;
 
 struct ocfs2_file_private {
+	u64			cookie;
 	struct file		*fp_file;
 	struct mutex		fp_mutex;
 	struct ocfs2_lock_res	fp_flock;

-- 
2.45.2


