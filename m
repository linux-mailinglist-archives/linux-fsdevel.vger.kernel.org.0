Return-Path: <linux-fsdevel+bounces-28036-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 561DC966295
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2024 15:08:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 892BE1C23F83
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2024 13:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7120A1B3B26;
	Fri, 30 Aug 2024 13:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aPJJPHeq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D270E1AD5D8
	for <linux-fsdevel@vger.kernel.org>; Fri, 30 Aug 2024 13:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725023174; cv=none; b=hmeM/6gjRGK4GB/PELCcXWhzv+dOpV8QOXyVQmwIWmzoHM7MLh4ImEcXWj4oSXH7C09IFKa6F+rOPcQ1F9yihtQtc1v3ryz0SyjyGS7lrstbFIURlSzZ2V+NLAjMqvEkBDjCoSm5nesZjERfOsRXiS+5W/ooi9UEa0rHGlwlSwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725023174; c=relaxed/simple;
	bh=Ki7eZdDe+8S6Dp8c8eAe5SK+vFGc0TNMjq2+D+aXI/s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ehXTbie56AgcT1mpsyu4HIiwzAOJopsn5o0ScTPP7gfoA9OFfVz8DeBZJwoaLShTQQbR+oV1EjLiqs6hR96yDqRNBGt0wJpH4JQzfames0ZYK/sRkxAWrk+Ng3lzv/3Zijvv0WKTx0XVJ/O7Lvua0qSsC44Zqa+GgTSxRnZEECM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aPJJPHeq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7647C4CEC7;
	Fri, 30 Aug 2024 13:06:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725023174;
	bh=Ki7eZdDe+8S6Dp8c8eAe5SK+vFGc0TNMjq2+D+aXI/s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=aPJJPHeqOCkBhFxcy58uOqhhxEC6zkqeKMRdftifN+TitUICTHc7L2nkcEwAZe814
	 uHFdKOWbgqPIX9cRgSwZdjPVpMFbvgJ8LnTWIGAXmwAUKM0n53aXhEqduzlMC4VCuJ
	 Wi4fWKr3h55ZnQPCr0SxFAByMMgWG1VTCN012YigUicHq7N4Z4PduIKtUyZ8sBVLSv
	 XulCU4D8g07EQy/6szzy5lPCUxBVQauRqtrEx4KHwW2RcSQAB7qPjnx0A1wH+6pwm6
	 K2K4O1GOGlzsfzLvCa/kV2Doa//WAFbVadG9vgRuwsw49tOEaA9MLzajmzJBpYVH67
	 8SQtGdeKK9cGA==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 30 Aug 2024 15:04:55 +0200
Subject: [PATCH RFC 14/20] proc: store cookie in private data
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240830-vfs-file-f_version-v1-14-6d3e4816aa7b@kernel.org>
References: <20240830-vfs-file-f_version-v1-0-6d3e4816aa7b@kernel.org>
In-Reply-To: <20240830-vfs-file-f_version-v1-0-6d3e4816aa7b@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Jan Kara <jack@suse.com>, Al Viro <viro@zeniv.linux.org.uk>, 
 Jeff Layton <jlayton@kernel.org>, Josef Bacik <josef@toxicpanda.com>, 
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@infradead.org>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-37811
X-Developer-Signature: v=1; a=openpgp-sha256; l=2207; i=brauner@kernel.org;
 h=from:subject:message-id; bh=Ki7eZdDe+8S6Dp8c8eAe5SK+vFGc0TNMjq2+D+aXI/s=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRdPDz3n9KH9YvkD3LNWzX9fZzmS9m518Q9ljzdyryGK
 dplmfPdko5SFgYxLgZZMUUWh3aTcLnlPBWbjTI1YOawMoEMYeDiFICJRN1n+F+YMbdHl33zZOPj
 7TW2Gxq/8zu+E0o4N+1Grdy+Ou8nC7MYGeYIT7NbZK3rskxcdens+M7CN8e3L4nJftGbtefodM5
 n/lwA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Store the cookie to detect concurrent seeks on directories in
file->private_data.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/proc/base.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index 72a1acd03675..8a8aab6b9801 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -3870,12 +3870,12 @@ static int proc_task_readdir(struct file *file, struct dir_context *ctx)
 	if (!dir_emit_dots(file, ctx))
 		return 0;
 
-	/* f_version caches the tgid value that the last readdir call couldn't
-	 * return. lseek aka telldir automagically resets f_version to 0.
+	/* We cache the tgid value that the last readdir call couldn't
+	 * return and lseek resets it to 0.
 	 */
 	ns = proc_pid_ns(inode->i_sb);
-	tid = (int)file->f_version;
-	file->f_version = 0;
+	tid = (int)(intptr_t)file->private_data;
+	file->private_data = NULL;
 	for (task = first_tid(proc_pid(inode), tid, ctx->pos - 2, ns);
 	     task;
 	     task = next_tid(task), ctx->pos++) {
@@ -3890,7 +3890,7 @@ static int proc_task_readdir(struct file *file, struct dir_context *ctx)
 				proc_task_instantiate, task, NULL)) {
 			/* returning this tgid failed, save it as the first
 			 * pid for the next readir call */
-			file->f_version = (u64)tid;
+			file->private_data = (void *)(intptr_t)tid;
 			put_task_struct(task);
 			break;
 		}
@@ -3915,6 +3915,12 @@ static int proc_task_getattr(struct mnt_idmap *idmap,
 	return 0;
 }
 
+static loff_t proc_dir_llseek(struct file *file, loff_t offset, int whence)
+{
+	return generic_llseek_cookie(file, offset, whence,
+				     (u64 *)(uintptr_t)&file->private_data);
+}
+
 static const struct inode_operations proc_task_inode_operations = {
 	.lookup		= proc_task_lookup,
 	.getattr	= proc_task_getattr,
@@ -3925,7 +3931,7 @@ static const struct inode_operations proc_task_inode_operations = {
 static const struct file_operations proc_task_operations = {
 	.read		= generic_read_dir,
 	.iterate_shared	= proc_task_readdir,
-	.llseek		= generic_file_llseek,
+	.llseek		= proc_dir_llseek,
 };
 
 void __init set_proc_pid_nlink(void)

-- 
2.45.2


