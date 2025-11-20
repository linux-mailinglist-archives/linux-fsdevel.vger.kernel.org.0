Return-Path: <linux-fsdevel+bounces-69316-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C238DC7688E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 23:36:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 27DD92F5C2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 22:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12D16368DFB;
	Thu, 20 Nov 2025 22:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dPeuOQ0w"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC88305065
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Nov 2025 22:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763678012; cv=none; b=jDYMQ92L1YVCScp4LWUCA6AYeDFLYDUG/uDmJ+Wmrwsov63z3FGm5eisT72Gz69JLeoayrV/oFk0LPVIXMLPfaFIMsEIb0Maht/1Q08QRZwjbiAGC/wXfxtDQTzs7DUbqCo142tmDMe2tLvLf9Nx7LLRHV+tEzGYc9tq5DigmD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763678012; c=relaxed/simple;
	bh=UPlzzkDwQDYJ07nePaAQGJhNmVKmyBwm5yic/Q508yc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VqM7pzsOILZSOYWKz1I896dUk/RY2vzziNMzslUQdcTIriA9b1esS5Uwp2Voa+B/E9Us3TZ8lVAXhTl+xGjPpgJxMMfTYaHyfAe1tAGcEe2dtVAs32E7eRnpuNdrKyyoaBThohhruXrKmzvncuNmibd+8lAKzYzylMJ9ClwwvPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dPeuOQ0w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3641C113D0;
	Thu, 20 Nov 2025 22:33:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763678012;
	bh=UPlzzkDwQDYJ07nePaAQGJhNmVKmyBwm5yic/Q508yc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=dPeuOQ0woCyWA8NocrgAkeMoRWwcgfPEf4k0G5wnscT4HLMZwiY0CuYJ5YQti5jtT
	 Bmye2+WoJXp+qd7TztCN2JwGT0GO3iVxed0BgoiTEiba8J5mxXttGMzYOeZXTiRcWM
	 10xAm2CgnXy1iCLwFmvWpF4bHuKEJCmz/nMncqzV+T4CRON8xoUTgtbgR5l1/DMRpl
	 A1dRQ3VW8UO132mhS7M3a3Vvc/MgSnKpSAWym2E7BMkKM1MoBuU4Y+Za98bcoxuslc
	 JpvG4479dZfzSmt2ICOupM1hA1DKnM4egVEDLdyDnvta+U/9LoWQP40kldGbCpEr56
	 nhaLnBFXBr4oQ==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 20 Nov 2025 23:32:33 +0100
Subject: [PATCH RFC v2 36/48] pseries: convert
 papr_platform_dump_create_handle() to FD_PREPARE()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251120-work-fd-prepare-v2-36-fef6ebda05d3@kernel.org>
References: <20251120-work-fd-prepare-v2-0-fef6ebda05d3@kernel.org>
In-Reply-To: <20251120-work-fd-prepare-v2-0-fef6ebda05d3@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>, 
 Jeff Layton <jlayton@kernel.org>, Amir Goldstein <amir73il@gmail.com>, 
 Jens Axboe <axboe@kernel.dk>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2325; i=brauner@kernel.org;
 h=from:subject:message-id; bh=UPlzzkDwQDYJ07nePaAQGJhNmVKmyBwm5yic/Q508yc=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTKT3unf28NX9uvIx+sbv58dSYktsbGexHzd5tXvgI6K
 Q7/uYQ4O0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACYSdJaRYeXmqdoWGm4qfg/b
 y/0v3f/EXGK3TzVvotRDyS3/k7czezEyPGvP+OvcePxZkOGE1ZIpbxcppebeqk3migtdvP7wuXs
 9bAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 .../powerpc/platforms/pseries/papr-platform-dump.c | 46 ++++++++--------------
 1 file changed, 16 insertions(+), 30 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/papr-platform-dump.c b/arch/powerpc/platforms/pseries/papr-platform-dump.c
index f8d55eccdb6b..c6020d7bdfa3 100644
--- a/arch/powerpc/platforms/pseries/papr-platform-dump.c
+++ b/arch/powerpc/platforms/pseries/papr-platform-dump.c
@@ -301,11 +301,8 @@ static const struct file_operations papr_platform_dump_handle_ops = {
  */
 static long papr_platform_dump_create_handle(u64 dump_tag)
 {
-	struct ibm_platform_dump_params *params;
+	struct ibm_platform_dump_params *params, *tmp;
 	u64 param_dump_tag;
-	struct file *file;
-	long err;
-	int fd;
 
 	/*
 	 * Return failure if the user space is already opened FD for
@@ -334,34 +331,23 @@ static long papr_platform_dump_create_handle(u64 dump_tag)
 	params->dump_tag_lo = (u32)(dump_tag & 0x00000000ffffffffULL);
 	params->status = RTAS_IBM_PLATFORM_DUMP_START;
 
-	fd = get_unused_fd_flags(O_RDONLY | O_CLOEXEC);
-	if (fd < 0) {
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
-	}
-
-	fd_install(fd, file);
+	FD_PREPARE(fdf, O_RDONLY | O_CLOEXEC,
+		   anon_inode_getfile_fmode("[papr-platform-dump]",
+					    &papr_platform_dump_handle_ops,
+					    (void *)params, O_RDONLY,
+					    FMODE_LSEEK | FMODE_PREAD)) {
+		if (fd_prepare_failed(fdf)) {
+			rtas_work_area_free(params->work_area);
+			kfree(params);
+			return fd_prepare_error(fdf);
+		}
 
-	list_add(&params->list, &platform_dump_list);
+		list_add(&params->list, &platform_dump_list);
 
-	pr_info("%s (%d) initiated platform dump for dump tag %llu\n",
-		current->comm, current->pid, dump_tag);
-	return fd;
-put_fd:
-	put_unused_fd(fd);
-free_area:
-	rtas_work_area_free(params->work_area);
-	kfree(params);
-	return err;
+		pr_info("%s (%d) initiated platform dump for dump tag %llu\n",
+			current->comm, current->pid, dump_tag);
+		return fd_publish(fdf);
+	}
 }
 
 /*

-- 
2.47.3


