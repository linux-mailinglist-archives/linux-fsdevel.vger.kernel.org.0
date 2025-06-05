Return-Path: <linux-fsdevel+bounces-50729-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46896ACEF8E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Jun 2025 14:51:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC1893AD1B0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Jun 2025 12:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 433A3221FC9;
	Thu,  5 Jun 2025 12:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FnYUvylk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52391E7C1B
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Jun 2025 12:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749127865; cv=none; b=QciwRQ8pt3w8vAO6QZNwg/DNTJG7JxTnbZWeibFhNScMPLNUSsXdCbxCVs7divQd2ej2jzrEgJqGrVGI79ZcRliaXxWnR2uw19/RcXl++zX2V0vz5xUJVbno8M/5zVcw0L8VXUJDpZ4K0vxgiJqTVpxEApWdI62FktbGrXao26k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749127865; c=relaxed/simple;
	bh=of71IB+Wwi3hGTs6kOqMuPv9bDnFUAlTKNVjWzaKvhk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ir+hFpFx/Wh4nOooXzsPZ9Zz/bZeD32qoK4TDrbczyzYDWwacOKGsvOiPTHA4AxSOCIjQoKGI0dQZJc2Z6ZAt4BosHei3HiZQyq/bQML6Nv1wYc/xSW0xKRA5AIq0NDbExQ/uGhRi9qb9qgpKZ1RodD9erqFDYnsZ85YSMMiti0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FnYUvylk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D92BFC4CEEE;
	Thu,  5 Jun 2025 12:51:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749127865;
	bh=of71IB+Wwi3hGTs6kOqMuPv9bDnFUAlTKNVjWzaKvhk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=FnYUvylkLSrDzDtyeRHUvko25erGnoiplDjfoxprT11/DTkLpj6Lu26bq7NoFWYSd
	 RwGU5C3ub85Ai0htHLL27e4YQp1OL3pdA7KhkAkP6/9cobQQQs6TIgzsNPPiZlyyj9
	 6xjVYn16+ukXYPYVkRcEN9u55tTlgksC4smeZg07FilSqYCBRVP8WTFYpI9jUNyAhu
	 L1zHVOfcuhMlSGaS8jTPxY/bmh9VQfCUKRaOLYSDUqQdNoTAO5T2MdoSwYeZnMsZVS
	 U+wTC3l5x/0FgTA+1wxXcPEMx/s/E5YA8dZwak0BnNJsFac0EnHHmK3y863BsMKv6u
	 iFsPo5UOIC4cA==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 05 Jun 2025 14:50:54 +0200
Subject: [PATCH 2/2] selftests/mount_setattr: adapt detached mount
 propagation test
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250605-work-mount-regression-v1-2-60c89f4f4cf5@kernel.org>
References: <20250605-work-mount-regression-v1-0-60c89f4f4cf5@kernel.org>
In-Reply-To: <20250605-work-mount-regression-v1-0-60c89f4f4cf5@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Miklos Szeredi <miklos@szeredi.hu>, Jan Kara <jack@suse.cz>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-6f78e
X-Developer-Signature: v=1; a=openpgp-sha256; l=1696; i=brauner@kernel.org;
 h=from:subject:message-id; bh=of71IB+Wwi3hGTs6kOqMuPv9bDnFUAlTKNVjWzaKvhk=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQ4Ttp8hkt84RTJmgeTZZMY72h67kz6uW1tY9h/jkTmp
 UK+XsW9HaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABOZ4snIsPzUnPBv+3/mslp3
 +oZsdlaUVg79N6/Cm9OSgcuS+1g5A8MfDnbx6N6e55NZP/turJ0wrX3FnHtpX8QffHzcH+4lman
 AAQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Make sure that detached trees don't receive mount propagation.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 .../selftests/mount_setattr/mount_setattr_test.c        | 17 +----------------
 1 file changed, 1 insertion(+), 16 deletions(-)

diff --git a/tools/testing/selftests/mount_setattr/mount_setattr_test.c b/tools/testing/selftests/mount_setattr/mount_setattr_test.c
index 8b378c91debf..b1e4618399be 100644
--- a/tools/testing/selftests/mount_setattr/mount_setattr_test.c
+++ b/tools/testing/selftests/mount_setattr/mount_setattr_test.c
@@ -2079,24 +2079,9 @@ TEST_F(mount_setattr, detached_tree_propagation)
 	 * means that the device information will be different for any
 	 * statx() that was taken from /mnt/A before the mount compared
 	 * to one after the mount.
-	 *
-	 * Since we already now that the device information between the
-	 * stx1 and stx2 samples are identical we also now that stx2 and
-	 * stx3 device information will necessarily differ.
 	 */
 	ASSERT_NE(stx1.stx_dev_minor, stx3.stx_dev_minor);
-
-	/*
-	 * If mount propagation worked correctly then the tmpfs mount
-	 * that was created after the mount namespace was unshared will
-	 * have propagated onto /mnt/A in the detached mount tree.
-	 *
-	 * Verify that the device information for stx3 and stx4 are
-	 * identical. It is already established that stx3 is different
-	 * from both stx1 and stx2 sampled before the tmpfs mount was
-	 * done so if stx3 and stx4 are identical the proof is done.
-	 */
-	ASSERT_EQ(stx3.stx_dev_minor, stx4.stx_dev_minor);
+	ASSERT_EQ(stx1.stx_dev_minor, stx4.stx_dev_minor);
 
 	EXPECT_EQ(close(fd_tree), 0);
 }

-- 
2.47.2


