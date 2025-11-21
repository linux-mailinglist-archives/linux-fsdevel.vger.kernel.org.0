Return-Path: <linux-fsdevel+bounces-69433-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFB9BC7B2FB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 19:03:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE62F3A4308
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 18:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E732D353883;
	Fri, 21 Nov 2025 18:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gZ0YzTCQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51BD7350A27
	for <linux-fsdevel@vger.kernel.org>; Fri, 21 Nov 2025 18:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763748125; cv=none; b=hM/hWGC9GlhIoP+S31GbhIfTVzSqYjenUo2QFM+tWrCG/25ArsOI58naY5wgRlMOCRLBpsCOYlg58d6RJ/HXVyo6x3Gt52ulm/DnwqjTmnGdZDSXzt8jmz3rX+v4K34Mj/9b+qhsLwh/TqPH08tD3Pl9e0HQICTYRLzX5ushKjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763748125; c=relaxed/simple;
	bh=cyP3nsxHAVU8Or7P1tgy+gMgj5rRKDJ/3Mt/PWBXD2E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RxDSyXb6WGqQV03UeiGf8kI4TN1xvuPHr7d4I8Bf+p9fobE+FBbxzhrcRLoXyiCCsRFRQQvQczvFvyFUjULvRRUjOIBPJjj4FolTI2Kywe2BAXb0kb6PCp5RGASFSzHVe1PXw+yOAuqMnmf5cnldm/PSNqc1l9PMAAp77Qzy1+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gZ0YzTCQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98989C116D0;
	Fri, 21 Nov 2025 18:02:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763748125;
	bh=cyP3nsxHAVU8Or7P1tgy+gMgj5rRKDJ/3Mt/PWBXD2E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=gZ0YzTCQv+hccRFHRQqgrvvfgDFNDYG7jd1aiCzk9ayAwG2KwcQslf473/Ss3WOHO
	 i4YMQMSRQ9KN7ba+gut1LIfkOP1/vBw8sN7VuNPz32JtYWnUka7XiBf0xRgQD9vmBG
	 RYunWEMcIiK7X2DB6fcLdD74KzkaZ8BKOp0N21LK78+hVqntzhqob3gSdrFN808/2s
	 paJDI1G8boevqryzsnrBUMofSyJ5NFyUAmq2OEEZ50jCal0SYG0Bqd2DWrh+SkQHg3
	 SkNt4xVFRCEn2FuFR9GG5yjj85545+04tfjlQCUghqQQbb9zwfqn0QU4sS+nBD5y5S
	 NjuQTnTOD17Nw==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 21 Nov 2025 19:01:14 +0100
Subject: [PATCH RFC v3 35/47] pseries: convert
 papr_platform_dump_create_handle() to FD_PREPARE()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251121-work-fd-prepare-v3-35-2c6444d13e0e@kernel.org>
References: <20251121-work-fd-prepare-v3-0-2c6444d13e0e@kernel.org>
In-Reply-To: <20251121-work-fd-prepare-v3-0-2c6444d13e0e@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>, 
 Jeff Layton <jlayton@kernel.org>, Amir Goldstein <amir73il@gmail.com>, 
 Jens Axboe <axboe@kernel.dk>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2160; i=brauner@kernel.org;
 h=from:subject:message-id; bh=cyP3nsxHAVU8Or7P1tgy+gMgj5rRKDJ/3Mt/PWBXD2E=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQqrLgYvurmTteksp9LA6M92OYdPdR8rGyrIc/LLsYVs
 y4Iz/gq0lHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCR3eIM/xOjVc9s+fdWTMvz
 1qabqn73/t+Z4v+oLEL6xurqD01esmyMDBMajl8WfL3gxqakj5s/Zu1T//yQf5a57zKdkslyVcz
 WYfwA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 .../powerpc/platforms/pseries/papr-platform-dump.c | 39 ++++++++--------------
 1 file changed, 13 insertions(+), 26 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/papr-platform-dump.c b/arch/powerpc/platforms/pseries/papr-platform-dump.c
index f8d55eccdb6b..df9e837f2bd6 100644
--- a/arch/powerpc/platforms/pseries/papr-platform-dump.c
+++ b/arch/powerpc/platforms/pseries/papr-platform-dump.c
@@ -301,11 +301,9 @@ static const struct file_operations papr_platform_dump_handle_ops = {
  */
 static long papr_platform_dump_create_handle(u64 dump_tag)
 {
-	struct ibm_platform_dump_params *params;
+	struct ibm_platform_dump_params *params, *tmp;
 	u64 param_dump_tag;
-	struct file *file;
-	long err;
-	int fd;
+	int err;
 
 	/*
 	 * Return failure if the user space is already opened FD for
@@ -334,34 +332,23 @@ static long papr_platform_dump_create_handle(u64 dump_tag)
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
+	FD_PREPARE(fdf, O_RDONLY | O_CLOEXEC,
+		   anon_inode_getfile_fmode("[papr-platform-dump]",
+					    &papr_platform_dump_handle_ops,
+					    (void *)params, O_RDONLY,
+					    FMODE_LSEEK | FMODE_PREAD));
+	err = ACQUIRE_ERR(fd_prepare, &fdf);
+	if (err) {
+		rtas_work_area_free(params->work_area);
+		kfree(params);
+		return err
 	}
 
-	fd_install(fd, file);
-
 	list_add(&params->list, &platform_dump_list);
 
 	pr_info("%s (%d) initiated platform dump for dump tag %llu\n",
 		current->comm, current->pid, dump_tag);
-	return fd;
-put_fd:
-	put_unused_fd(fd);
-free_area:
-	rtas_work_area_free(params->work_area);
-	kfree(params);
-	return err;
+	return fd_publish(fdf);
 }
 
 /*

-- 
2.47.3


