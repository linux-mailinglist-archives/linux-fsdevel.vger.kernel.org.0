Return-Path: <linux-fsdevel+bounces-69557-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AFFDEC7E3FE
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Nov 2025 17:35:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1286B4E29F5
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Nov 2025 16:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2298D2D7DEE;
	Sun, 23 Nov 2025 16:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P/sjX8T/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810962D0C99
	for <linux-fsdevel@vger.kernel.org>; Sun, 23 Nov 2025 16:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763915691; cv=none; b=N/WTS5g+GTSZikE9inpZl/Amv+MetLepAJiyuEoqlZZiRpHXShRdPvklJbJGNzBbAee7xBQYlaZMTYZMFBwnFxglUGlI+de9KWR1kclG9oSH7/XBjainzeJg8J9htrD+awF94ABfxnRdjbd9hTB1kzz1MoPGOQ/Rg7toyIk1lwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763915691; c=relaxed/simple;
	bh=VhaXBaWOWFbXxcpUngeOOzv+4iyLBYFPYpPXKfB1Wz8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TX9smKtrXVxmtDM1JEtkBCQn1rRdcGgnTKet6kap4ilDQAs5OCp11ZxKhi6vYstrS6D3I+/sXHbhbXkWhPdyEqteSHEYNv58m6dO7zVe0CBeBz4dzvdAAW7UqH4TJlyD1Lzk8FKcQT2LrHSqhVgidENBMn4D2/FCMAbjkrvwJiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P/sjX8T/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57DD0C113D0;
	Sun, 23 Nov 2025 16:34:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763915691;
	bh=VhaXBaWOWFbXxcpUngeOOzv+4iyLBYFPYpPXKfB1Wz8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=P/sjX8T/wP6nPQOfjOt6Dzr7OMv+PAVFBzvFS7voWcC+iYGrbdvSTDEoSEqtzra4M
	 /bbkRmnGFJ1ivkO7ghXfWThAh8TV2+tz6CzYIawQ19XVNA16Gm9Iocz+BqhASQIDf/
	 2S1hI2h/KoSl0dUXViaQzuTba0dGJXQVz2fDadNUpSq/rFbd7yzmGhCvpwat8nRenJ
	 P6EpsRJLK20GqE2mUm0LQBtRNtpwfFw1ZskZzPEMfMEEzNfobKzGNiKf50ZgnALxr4
	 ElkPe5TwxIMCF/IYhl+vPH9NNptqlNOg/sInCGC0J1CrTlPBduwb0MGJap4d6lC4Rk
	 5JMMYUKjbONmg==
From: Christian Brauner <brauner@kernel.org>
Date: Sun, 23 Nov 2025 17:33:53 +0100
Subject: [PATCH v4 35/47] pseries: convert
 papr_platform_dump_create_handle() to FD_PREPARE()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251123-work-fd-prepare-v4-35-b6efa1706cfd@kernel.org>
References: <20251123-work-fd-prepare-v4-0-b6efa1706cfd@kernel.org>
In-Reply-To: <20251123-work-fd-prepare-v4-0-b6efa1706cfd@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, 
 Amir Goldstein <amir73il@gmail.com>, Jens Axboe <axboe@kernel.dk>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2002; i=brauner@kernel.org;
 h=from:subject:message-id; bh=VhaXBaWOWFbXxcpUngeOOzv+4iyLBYFPYpPXKfB1Wz8=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQqm0c1TH1gpfygelLk/l1yP+0bFTJfKB1cnu8UO/Ngw
 wzeHXI/O0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACYycykjw2yPuQpSE47derSg
 /u5fORuJU6p3jbwvt1tG6Z8qni+uKsHwz9CzuLHWaO/NVbydZse67hQLPvqrW+0S4pBmuUpOloO
 bHwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 .../powerpc/platforms/pseries/papr-platform-dump.c | 32 ++++++----------------
 1 file changed, 9 insertions(+), 23 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/papr-platform-dump.c b/arch/powerpc/platforms/pseries/papr-platform-dump.c
index f8d55eccdb6b..3f60e89be714 100644
--- a/arch/powerpc/platforms/pseries/papr-platform-dump.c
+++ b/arch/powerpc/platforms/pseries/papr-platform-dump.c
@@ -301,10 +301,8 @@ static const struct file_operations papr_platform_dump_handle_ops = {
  */
 static long papr_platform_dump_create_handle(u64 dump_tag)
 {
-	struct ibm_platform_dump_params *params;
+	struct ibm_platform_dump_params *params, *tmp;
 	u64 param_dump_tag;
-	struct file *file;
-	long err;
 	int fd;
 
 	/*
@@ -334,34 +332,22 @@ static long papr_platform_dump_create_handle(u64 dump_tag)
 	params->dump_tag_lo = (u32)(dump_tag & 0x00000000ffffffffULL);
 	params->status = RTAS_IBM_PLATFORM_DUMP_START;
 
-	fd = get_unused_fd_flags(O_RDONLY | O_CLOEXEC);
+	fd = FD_ADD(O_RDONLY | O_CLOEXEC,
+		    anon_inode_getfile_fmode("[papr-platform-dump]",
+					     &papr_platform_dump_handle_ops,
+					     (void *)params, O_RDONLY,
+					     FMODE_LSEEK | FMODE_PREAD));
 	if (fd < 0) {
-		err = fd;
-		goto free_area;
-	}
-
-	file = anon_inode_getfile_fmode("[papr-platform-dump]",
-				&papr_platform_dump_handle_ops,
-				(void *)params, O_RDONLY,
-				FMODE_LSEEK | FMODE_PREAD);
-	if (IS_ERR(file)) {
-		err = PTR_ERR(file);
-		goto put_fd;
+		rtas_work_area_free(params->work_area);
+		kfree(params);
+		return fd;
 	}
 
-	fd_install(fd, file);
-
 	list_add(&params->list, &platform_dump_list);
 
 	pr_info("%s (%d) initiated platform dump for dump tag %llu\n",
 		current->comm, current->pid, dump_tag);
 	return fd;
-put_fd:
-	put_unused_fd(fd);
-free_area:
-	rtas_work_area_free(params->work_area);
-	kfree(params);
-	return err;
 }
 
 /*

-- 
2.47.3


