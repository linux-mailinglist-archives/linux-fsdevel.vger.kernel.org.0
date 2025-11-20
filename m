Return-Path: <linux-fsdevel+bounces-69314-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 86FF5C7688B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 23:35:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id CCC742DC0C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 22:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EC1035F8D0;
	Thu, 20 Nov 2025 22:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ruDcwX/F"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DDCA305065
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Nov 2025 22:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763678008; cv=none; b=tRAZfkK8StbwLRXd2kPHVGz/rZSLOUe/q+kwV49t3KMrW1aCzi1YIdymRMvsq80SEoDrNwvHNprMBl8scfgHhbyq8WwSiI3dmcZfiD5a28txf0R7U8FOEY2jgzQoe0QV3DnpztkXTw7WA1WgyRZB68NaYICwLqi/zmQ8cmLZ8sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763678008; c=relaxed/simple;
	bh=Ao+laqxSrd7XC1ToTZXYpg5FAqfHdhtoysofRNfjFLQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AOJbgk9ODB0trYuVi9SvlN57KwxcgRhIUQdLTVQwN+oBD+n/zlwcrAia5bnhYhNp2wkFRIurFAdUWva64cZbn9sePNFsVk+zNbtSC5QPSahHRCdHXdEJ/Gw/CiGTFEa02zgURMC8ztPWh4OcVklWo9GqDoTejbE7+wCP4sRUpag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ruDcwX/F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 742D2C4CEF1;
	Thu, 20 Nov 2025 22:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763678008;
	bh=Ao+laqxSrd7XC1ToTZXYpg5FAqfHdhtoysofRNfjFLQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ruDcwX/FmGPfsaviQWc6TKM2qCrwlxG2pJLc/AHRPk6H0AwBQbp/aQOxPMhytgeWn
	 /U7gXT4aBlHeLJG1hOWQNlvjCsnqFF/aOyZ+6hwn1UaABvGWzePnErsZqz9s5G251f
	 HpyKJ7lnfjiHHmuttF/t2c/Vgs23KjxJJLaZZw2yqw5G+AD9LMZlT4GZhDg/zJOlZc
	 Dyb9PMkvmQAD8evM0wQ2fIlshRnR/XJko3FZ/4KogQhG14IwIJcvXoLo4tAP6Tvwp9
	 ROkKc0ZLvmfh4LJtTxm8vMYcufEUxulrqOz6oQ0we0SFIcAhm+QsMKe9uNy3TpT2JQ
	 olS+72swZbxkg==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 20 Nov 2025 23:32:31 +0100
Subject: [PATCH RFC v2 34/48] papr-hvpipe: convert
 papr_hvpipe_dev_create_handle() to FD_PREPARE()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251120-work-fd-prepare-v2-34-fef6ebda05d3@kernel.org>
References: <20251120-work-fd-prepare-v2-0-fef6ebda05d3@kernel.org>
In-Reply-To: <20251120-work-fd-prepare-v2-0-fef6ebda05d3@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>, 
 Jeff Layton <jlayton@kernel.org>, Amir Goldstein <amir73il@gmail.com>, 
 Jens Axboe <axboe@kernel.dk>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2494; i=brauner@kernel.org;
 h=from:subject:message-id; bh=Ao+laqxSrd7XC1ToTZXYpg5FAqfHdhtoysofRNfjFLQ=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTKT3u3s0Vqv9qjS9EyQnZz6uQ8va/8u7x0kdJSzVvGp
 SpsGQYpHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABOxFGJkuLDXqD9xv+qS/YYi
 +4NWc7AI/77Bvul16LJ0q3M9s7+WcTMyPFhas0/mtiLvfQdlXtt9AT7sc/b9jLsT63kzZv1m2fW
 GPAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Fixes a UAF for src_info as well.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 arch/powerpc/platforms/pseries/papr-hvpipe.c | 58 +++++++++++-----------------
 1 file changed, 22 insertions(+), 36 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/papr-hvpipe.c b/arch/powerpc/platforms/pseries/papr-hvpipe.c
index 21a2f447c43f..84106bc75235 100644
--- a/arch/powerpc/platforms/pseries/papr-hvpipe.c
+++ b/arch/powerpc/platforms/pseries/papr-hvpipe.c
@@ -479,10 +479,8 @@ static const struct file_operations papr_hvpipe_handle_ops = {
 
 static int papr_hvpipe_dev_create_handle(u32 srcID)
 {
-	struct hvpipe_source_info *src_info;
-	struct file *file;
+	struct hvpipe_source_info *src_info __free(kfree) = NULL;
 	long err;
-	int fd;
 
 	spin_lock(&hvpipe_src_list_lock);
 	/*
@@ -506,43 +504,31 @@ static int papr_hvpipe_dev_create_handle(u32 srcID)
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
+				      (void *)src_info, O_RDWR)) {
+		if (fd_prepare_failed(fdf)) {
+			err = fd_prepare_error(fdf);
+			goto free_buf;
+		}
 
-	spin_lock(&hvpipe_src_list_lock);
-	/*
-	 * If two processes are executing ioctl() for the same
-	 * source ID concurrently, prevent the second process to
-	 * acquire FD.
-	 */
-	if (hvpipe_find_source(srcID)) {
+		retain_and_null_ptr(src_info);
+		spin_lock(&hvpipe_src_list_lock);
+		/*
+		 * If two processes are executing ioctl() for the same
+		 * source ID concurrently, prevent the second process to
+		 * acquire FD.
+		 */
+		if (hvpipe_find_source(srcID)) {
+			spin_unlock(&hvpipe_src_list_lock);
+			return -EALREADY;
+		}
+		list_add(&src_info->list, &hvpipe_src_list);
 		spin_unlock(&hvpipe_src_list_lock);
-		err = -EALREADY;
-		goto free_file;
-	}
-	list_add(&src_info->list, &hvpipe_src_list);
-	spin_unlock(&hvpipe_src_list_lock);
 
-	fd_install(fd, file);
-	return fd;
+		return fd_publish(fdf);
+	}
 
-free_file:
-	fput(file);
-free_fd:
-	put_unused_fd(fd);
-free_buf:
-	kfree(src_info);
 	return err;
 }
 

-- 
2.47.3


