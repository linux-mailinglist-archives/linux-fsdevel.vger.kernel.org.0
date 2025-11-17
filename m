Return-Path: <linux-fsdevel+bounces-68653-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D734BC633AF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 10:41:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 57EC8362FFA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 09:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 581F03271E2;
	Mon, 17 Nov 2025 09:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="glStNzvH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F54328B47;
	Mon, 17 Nov 2025 09:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763372043; cv=none; b=tQw4McXbFUe/0iP9SK9H68LuqdE90441SHN6xXrdQ3jU0BS1lGvIqyX5UXBE+eLWitBygBcV+wLW2oWiutFzuGiBh9nV+LOIik1XDuGK0fIHmOytR/p0kL8+2UhLUmTbV+U87fEVMYPAQlqJt96CcDwDZNfAHS0PPtp2+ob8RE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763372043; c=relaxed/simple;
	bh=NoVjUYZ1utZcTOi9AJM0qIsrY7IB57NX1QwQdKEtCe0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Z1FYhgzVPMNeisOy/Kj2/OhFooCBQl4A/6n9/pl/aVuRT+A21G/1KOg1baj8nbEQRoksApLJ8njuelC/i2GPJGVX29riJ1HBdQpfBix5sJLz6jY6rFkM2NNo2zAaQUE8yTrb8G7xlgs3Oj/dAzQoqSWdKlzEg2u8Q6ThdQgPnDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=glStNzvH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90A6CC4CEFB;
	Mon, 17 Nov 2025 09:34:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763372042;
	bh=NoVjUYZ1utZcTOi9AJM0qIsrY7IB57NX1QwQdKEtCe0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=glStNzvHbAT1rB8gwqIQrypm4Zrvpvig0YLeFrWyHS+VS5DYyZ7UUCq3xbTqdiBH0
	 reMT0wT1XBIkTy1ot1xRA3C1/SVSaWS58v5s7RH1Ad+XB3Abew0RL5l3MNuFvnXSRF
	 I6fcXLKcoL1xdxGPZqk8W2X4IeD4jUqM6KMKElJVQpjDLX+u4PNwMojzjMjpIkub9V
	 /EkIHQb25zZeFkCynqHxgIuGpvyUu/DapvQ/t8S///1FauOv06g4apVZjRXXUOH9s7
	 jvVIqmgrYg93lgC1l7nCO29B9ro74LOOEZbTKXQvZ73qtXQqZonNYPON5r193xbrt3
	 f7Hemc0wTGGqQ==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 17 Nov 2025 10:33:41 +0100
Subject: [PATCH v4 10/42] ovl: port ovl_fallocate() to cred guard
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251117-work-ovl-cred-guard-v4-10-b31603935724@kernel.org>
References: <20251117-work-ovl-cred-guard-v4-0-b31603935724@kernel.org>
In-Reply-To: <20251117-work-ovl-cred-guard-v4-0-b31603935724@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1013; i=brauner@kernel.org;
 h=from:subject:message-id; bh=NoVjUYZ1utZcTOi9AJM0qIsrY7IB57NX1QwQdKEtCe0=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRKvf76Vendg6Behl1Lz/PcT9ypuYBlf6H9GS0LB97TS
 icSGo9zdZSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEyETZCRod2AIXdN7IEKxltz
 5ko/Sc7i5hbp6T9UdsZ1Y+vndy6HFRgZ2hhD0+xy3K+XOsnqrLx4qyzgfq3PphXMPGd7p1itMN3
 DDQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Use the scoped ovl cred guard.

Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/overlayfs/file.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
index 6c5aa74f63ec..28263ad00dee 100644
--- a/fs/overlayfs/file.c
+++ b/fs/overlayfs/file.c
@@ -481,7 +481,6 @@ static long ovl_fallocate(struct file *file, int mode, loff_t offset, loff_t len
 {
 	struct inode *inode = file_inode(file);
 	struct file *realfile;
-	const struct cred *old_cred;
 	int ret;
 
 	inode_lock(inode);
@@ -496,9 +495,8 @@ static long ovl_fallocate(struct file *file, int mode, loff_t offset, loff_t len
 	if (IS_ERR(realfile))
 		goto out_unlock;
 
-	old_cred = ovl_override_creds(file_inode(file)->i_sb);
+	with_ovl_creds(inode->i_sb)
 		ret = vfs_fallocate(realfile, mode, offset, len);
-	ovl_revert_creds(old_cred);
 
 	/* Update size */
 	ovl_file_modified(file);

-- 
2.47.3


