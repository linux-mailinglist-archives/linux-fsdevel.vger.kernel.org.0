Return-Path: <linux-fsdevel+bounces-69555-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D8EE3C7E408
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Nov 2025 17:35:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BE47834A7FD
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Nov 2025 16:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DACD2D94B0;
	Sun, 23 Nov 2025 16:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RjZlHAng"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB62123184F
	for <linux-fsdevel@vger.kernel.org>; Sun, 23 Nov 2025 16:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763915686; cv=none; b=a3l+rSemhtRodmhaRXGYBMKQIq5dCJS8GikOItBPTMhE4cET2pExvoqY97HYzOlArt3jpfG4Cezgwu7kW/BOK9mXAE/i5V3gTjyMlsAse4M9A7eDuAciTixCtaRyk1YkDANDXs2zHM4q2pOwoIzeO0NVAIGXeZ30Z55erbylTBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763915686; c=relaxed/simple;
	bh=jgzns7ZKNmVz4RJ0N7tGQbxKC5rC3nj+jGV6Ns15GRc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=svfVAPodMUC55XoLCv5kCkoZuAQ6lAt1a14Ur6PCWjkYH3Ufulmc2Ciu+V1vAnbsrCrg6yE8T370q9qozRciRQt2z5Lips9DVa8cQSXTDykg0ewx4DJNucpbVvQJbEpPOxRE8vITYgwPqwxFSf1+th2cBcZXHQdRDkhjbka+Zjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RjZlHAng; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E663FC19421;
	Sun, 23 Nov 2025 16:34:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763915686;
	bh=jgzns7ZKNmVz4RJ0N7tGQbxKC5rC3nj+jGV6Ns15GRc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=RjZlHAngprE0SsZKBj9AZ3BRwKWPst1NE3Qz4BLiLI9HQHbocKSXYu5XMaSei7z3i
	 ccwhC8bmZOt/aRnBDutIkpIgcvNJm/h29lD65wYHcvMJtTIUGmr0XA+gFTiupj0B9k
	 KVBqDo4VP97SZPj4RlnN5mkRs1/zrImSyuSz+FCk+JzG/b50J7thLtJmLvqvOL3O0L
	 ke0jtU+qAlMUR355Jf6s2VsRTJrnzjHUfUebfEFLcCrT34sGfw5cAo8PzAHNVAQktc
	 TgS7kn7ui/jDPxkZkBfPLFZ5lF5u9CKTk0DNvtTM8I+LX4XnyK7PwYeS+vIqhJe/ni
	 7A4Yi/dGO1eQw==
From: Christian Brauner <brauner@kernel.org>
Date: Sun, 23 Nov 2025 17:33:51 +0100
Subject: [PATCH v4 33/47] papr-hvpipe: convert
 papr_hvpipe_dev_create_handle() to FD_PREPARE()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251123-work-fd-prepare-v4-33-b6efa1706cfd@kernel.org>
References: <20251123-work-fd-prepare-v4-0-b6efa1706cfd@kernel.org>
In-Reply-To: <20251123-work-fd-prepare-v4-0-b6efa1706cfd@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, 
 Amir Goldstein <amir73il@gmail.com>, Jens Axboe <axboe@kernel.dk>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2103; i=brauner@kernel.org;
 h=from:subject:message-id; bh=jgzns7ZKNmVz4RJ0N7tGQbxKC5rC3nj+jGV6Ns15GRc=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQqm0f5PdftvCt3dbKc4JQ2Dz3x7Zevi4dG3zsxo0eVW
 3Jy+5ffHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABM5HMPI8Hr28n/2K8/+TrNo
 2p7OvX89O0/zm1Chxr5Dn7NOHixhf8TI8Cn30u5//3Yo/XRuWcOaxy7yzTZAWt4vs/+LuN+b6vc
 qHAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Fixes a UAF for src_info as well.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 arch/powerpc/platforms/pseries/papr-hvpipe.c | 39 +++++++---------------------
 1 file changed, 9 insertions(+), 30 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/papr-hvpipe.c b/arch/powerpc/platforms/pseries/papr-hvpipe.c
index 21a2f447c43f..dd7b668799d9 100644
--- a/arch/powerpc/platforms/pseries/papr-hvpipe.c
+++ b/arch/powerpc/platforms/pseries/papr-hvpipe.c
@@ -479,10 +479,7 @@ static const struct file_operations papr_hvpipe_handle_ops = {
 
 static int papr_hvpipe_dev_create_handle(u32 srcID)
 {
-	struct hvpipe_source_info *src_info;
-	struct file *file;
-	long err;
-	int fd;
+	struct hvpipe_source_info *src_info __free(kfree) = NULL;
 
 	spin_lock(&hvpipe_src_list_lock);
 	/*
@@ -506,20 +503,13 @@ static int papr_hvpipe_dev_create_handle(u32 srcID)
 	src_info->tsk = current;
 	init_waitqueue_head(&src_info->recv_wqh);
 
-	fd = get_unused_fd_flags(O_RDONLY | O_CLOEXEC);
-	if (fd < 0) {
-		err = fd;
-		goto free_buf;
-	}
-
-	file = anon_inode_getfile("[papr-hvpipe]",
-			&papr_hvpipe_handle_ops, (void *)src_info,
-			O_RDWR);
-	if (IS_ERR(file)) {
-		err = PTR_ERR(file);
-		goto free_fd;
-	}
+	FD_PREPARE(fdf, O_RDONLY | O_CLOEXEC,
+		   anon_inode_getfile("[papr-hvpipe]", &papr_hvpipe_handle_ops,
+				      (void *)src_info, O_RDWR));
+	if (fdf.err)
+		return fdf.err;
 
+	retain_and_null_ptr(src_info);
 	spin_lock(&hvpipe_src_list_lock);
 	/*
 	 * If two processes are executing ioctl() for the same
@@ -528,22 +518,11 @@ static int papr_hvpipe_dev_create_handle(u32 srcID)
 	 */
 	if (hvpipe_find_source(srcID)) {
 		spin_unlock(&hvpipe_src_list_lock);
-		err = -EALREADY;
-		goto free_file;
+		return -EALREADY;
 	}
 	list_add(&src_info->list, &hvpipe_src_list);
 	spin_unlock(&hvpipe_src_list_lock);
-
-	fd_install(fd, file);
-	return fd;
-
-free_file:
-	fput(file);
-free_fd:
-	put_unused_fd(fd);
-free_buf:
-	kfree(src_info);
-	return err;
+	return fd_publish(fdf);
 }
 
 /*

-- 
2.47.3


