Return-Path: <linux-fsdevel+bounces-66703-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 03E00C299AD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 03 Nov 2025 00:13:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D5DA64E6142
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 Nov 2025 23:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FD5C25783F;
	Sun,  2 Nov 2025 23:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K6WQD6kz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB4AB239E60;
	Sun,  2 Nov 2025 23:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762125186; cv=none; b=Jt+7z0e4PmZIAThABDTZ70oYzW8fioB05PKAcFA+EvoOJHOGcV3msFQYhbKSXmvUQ+ZMb0zabgGR2HxY96La6hRVQgwPytPXLAQb7qEELL2o6W0VBcelHLHtrwdtKL6kOj20WvZ/ELr5P3WQLilo2u3UMDdBiOf3KUDVr77DAF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762125186; c=relaxed/simple;
	bh=1ozcBCCfaQFjHpGUDMY7sc1UjIYzstsmIX1GAUFsUac=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Vejw9YytmH5Vpx9bvpLknGWxflNhvMbenATDXLhj4xb5INkc/4e7zmazM+XXi33WqyhKiwW6jWNcFr8TfZN719lVTWOHcgR5ks+br2LdrzQMqE0S6biTKLGAYsrJxTaVFoew13GeRg9dmwsuL8zld+OSxHNlaQaEsq8NPhn4na8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K6WQD6kz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4D24C4CEF7;
	Sun,  2 Nov 2025 23:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762125186;
	bh=1ozcBCCfaQFjHpGUDMY7sc1UjIYzstsmIX1GAUFsUac=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=K6WQD6kzirrVoE3fyt3uvzii9r/6pfwlglLZwoLk0ApZo1FBg83VOw1qTe+PfPGEN
	 9Hictdw3WbNzyVuw6WuHRJViRAEStdMDEYP3DYB+7Q9ZJZsPw60VElO7ME1pp3T4lt
	 oEIe3Bz4LJg9nCaa4jzOl1CbC3mtlPDfQ3DFXgxQqlNA1cWFz0pqKMr754MWdF3V/F
	 YWTwiBZOye1BmQTXlTMgRgNDeL9F+LS96hhhw4ohTGgUGS1NZfdy/YLWjE7RtE20th
	 tu/5XIuM8TpG1pcoIJPXh5KdEMGy3DXC2yBCxd4b2BLOAc6MlvjIYMxdndpycb8QCA
	 VQ+jeZzFkGSpA==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 03 Nov 2025 00:12:46 +0100
Subject: [PATCH 7/8] target: don't copy kernel creds
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251103-work-creds-init_cred-v1-7-cb3ec8711a6a@kernel.org>
References: <20251103-work-creds-init_cred-v1-0-cb3ec8711a6a@kernel.org>
In-Reply-To: <20251103-work-creds-init_cred-v1-0-cb3ec8711a6a@kernel.org>
To: Jens Axboe <axboe@kernel.dk>, 
 Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-96507
X-Developer-Signature: v=1; a=openpgp-sha256; l=1375; i=brauner@kernel.org;
 h=from:subject:message-id; bh=1ozcBCCfaQFjHpGUDMY7sc1UjIYzstsmIX1GAUFsUac=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSyPy1tNT4pMGnFb+MdbUavxfZvMp7a96ewtC/soFCC2
 svn3LfWdpSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzkxllGhgPrPx4udPf4msS1
 OCFu5eL//L2nX+wO3lm1vmxX6onLgpcZGbZeWpzleVzlhqNA0J+Q2es4HDcfTolcu5H3yLLQC8k
 M6kwA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Get rid of all the boilerplate and tightly scope when the task runs with
kernel creds.

Link: https://patch.msgid.link/20251031-work-creds-init_cred-v1-5-cbf0400d6e0e@kernel.org
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 drivers/target/target_core_configfs.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/target/target_core_configfs.c b/drivers/target/target_core_configfs.c
index b19acd662726..9e51c535ba8c 100644
--- a/drivers/target/target_core_configfs.c
+++ b/drivers/target/target_core_configfs.c
@@ -3670,8 +3670,6 @@ static int __init target_core_init_configfs(void)
 {
 	struct configfs_subsystem *subsys = &target_core_fabrics;
 	struct t10_alua_lu_gp *lu_gp;
-	struct cred *kern_cred;
-	const struct cred *old_cred;
 	int ret;
 
 	pr_debug("TARGET_CORE[0]: Loading Generic Kernel Storage"
@@ -3748,16 +3746,8 @@ static int __init target_core_init_configfs(void)
 	if (ret < 0)
 		goto out;
 
-	/* We use the kernel credentials to access the target directory */
-	kern_cred = prepare_kernel_cred(&init_task);
-	if (!kern_cred) {
-		ret = -ENOMEM;
-		goto out;
-	}
-	old_cred = override_creds(kern_cred);
-	target_init_dbroot();
-	revert_creds(old_cred);
-	put_cred(kern_cred);
+	scoped_with_kernel_creds()
+		target_init_dbroot();
 
 	return 0;
 

-- 
2.47.3


