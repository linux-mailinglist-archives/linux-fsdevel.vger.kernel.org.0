Return-Path: <linux-fsdevel+bounces-69317-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FF02C76879
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 23:35:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6DDA44E4AC1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 22:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 022B5368DFD;
	Thu, 20 Nov 2025 22:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mZHlMzk0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 626183624B3
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Nov 2025 22:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763678014; cv=none; b=YzKp7+YU5CkUJJl8xu4U1C+ndu+GPAz2OtsFAED5PtLuDNm8nEfAhF8VnDkXTMEgpYj+qI2Y2tgUI3ofoX/zjIHTNXrC8BDUAZyeAq6dwR4R3bloKpaDP4jVObvkivB5J/iI3iqAkMM+gxDxTD1AZ2TRAqmpPxOHGF7+UuNiwQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763678014; c=relaxed/simple;
	bh=YvgPDj4QC4nkhBZfKQYK2ty8K2sll633oUxAAEn60Gg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cBs9qV1AZ9arc2ZJhCu8gaie+z2FqYSdVb7u2/utK0vqPnecYDeUWhdDVxrTPS3UdZ+QnbMFSAr0FPZ6tQAHa70ZPEGzLC2xXTZpCYwuuK2HnwKkTPogR1hTHDWNFiFckkPb07iR/s4kVA7NF+jOV9N/FBqI8qsg9W4YOXc4YIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mZHlMzk0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A42B9C113D0;
	Thu, 20 Nov 2025 22:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763678014;
	bh=YvgPDj4QC4nkhBZfKQYK2ty8K2sll633oUxAAEn60Gg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=mZHlMzk0T788LnQFchQW5gxXcYCSlVTQXqo/G7bGUYv+g84jThw7alY9mIadUHH/w
	 2BccgAqAU/iVVtEQXtDZNt8x73HEaLZ2o/XqORtMrcyhF1m0lg7cMBGZI1w6uzzabh
	 v1hVppMab1PL7ztAmRLUZ5XgXOZazB8aHNBrMF8Ik2yZKAWHXZX1x24V3QKE0fMyke
	 pO0kA9jH8CKsyvXus4KRPc2cpxIVOflT8qO2Uj3l+1jkYJpRp6Jzgp+hV9H+41OTUe
	 vsDbBho++WWTqvwF5h7BuVHv/K++aS0KqlXlh2Tqe+6iijFjCnhKA0JSrHZbQP9l4s
	 S4qA1R+n0LeJw==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 20 Nov 2025 23:32:34 +0100
Subject: [PATCH RFC v2 37/48] pseries: port
 papr_rtas_setup_file_interface() to FD_PREPARE()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251120-work-fd-prepare-v2-37-fef6ebda05d3@kernel.org>
References: <20251120-work-fd-prepare-v2-0-fef6ebda05d3@kernel.org>
In-Reply-To: <20251120-work-fd-prepare-v2-0-fef6ebda05d3@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>, 
 Jeff Layton <jlayton@kernel.org>, Amir Goldstein <amir73il@gmail.com>, 
 Jens Axboe <axboe@kernel.dk>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1481; i=brauner@kernel.org;
 h=from:subject:message-id; bh=YvgPDj4QC4nkhBZfKQYK2ty8K2sll633oUxAAEn60Gg=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTKT3uX3fbe+pKR1PQZwksstuTKn35j7nqDq8n6M9+kN
 d/ufNx+vKOUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAiMh8Y/kfcq5LclvU5hp/3
 yu1d7sknLBKsziX43+x7vLjcIPj1y3MMf0XvPloVIeBz4b107iz2GdO1D0z5uTexo/99ppVTlMz
 dm1wA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 arch/powerpc/platforms/pseries/papr-rtas-common.c | 30 ++++++-----------------
 1 file changed, 8 insertions(+), 22 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/papr-rtas-common.c b/arch/powerpc/platforms/pseries/papr-rtas-common.c
index 33c606e3378a..8d697b9db4f5 100644
--- a/arch/powerpc/platforms/pseries/papr-rtas-common.c
+++ b/arch/powerpc/platforms/pseries/papr-rtas-common.c
@@ -205,35 +205,21 @@ long papr_rtas_setup_file_interface(struct papr_rtas_sequence *seq,
 				char *name)
 {
 	const struct papr_rtas_blob *blob;
-	struct file *file;
-	long ret;
-	int fd;
 
 	blob = papr_rtas_retrieve(seq);
 	if (IS_ERR(blob))
 		return PTR_ERR(blob);
 
-	fd = get_unused_fd_flags(O_RDONLY | O_CLOEXEC);
-	if (fd < 0) {
-		ret = fd;
-		goto free_blob;
-	}
+	FD_PREPARE(fdf, O_RDONLY | O_CLOEXEC,
+		   anon_inode_getfile_fmode(name, fops, (void *)blob,
+					    O_RDONLY, FMODE_LSEEK | FMODE_PREAD)) {
+		if (fd_prepare_failed(fdf)) {
+			papr_rtas_blob_free(blob);
+			return fd_prepare_error(fdf);
+		}
 
-	file = anon_inode_getfile_fmode(name, fops, (void *)blob,
-			O_RDONLY, FMODE_LSEEK | FMODE_PREAD);
-	if (IS_ERR(file)) {
-		ret = PTR_ERR(file);
-		goto put_fd;
+		return fd_publish(fdf);
 	}
-
-	fd_install(fd, file);
-	return fd;
-
-put_fd:
-	put_unused_fd(fd);
-free_blob:
-	papr_rtas_blob_free(blob);
-	return ret;
 }
 
 /*

-- 
2.47.3


