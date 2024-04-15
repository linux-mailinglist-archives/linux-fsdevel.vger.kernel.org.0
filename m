Return-Path: <linux-fsdevel+bounces-16948-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40DD88A5637
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Apr 2024 17:21:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0B7C282BB0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Apr 2024 15:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A960478C6D;
	Mon, 15 Apr 2024 15:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tnesVMj3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1714478685
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Apr 2024 15:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713194465; cv=none; b=i6PQs2/YEbgKMFpBtbNXA8PmPINl9eIK3/MM9/yHRB8XMwrbF0gh0hUaUYbwrMwEOmil5H/eEnFIfXA76pi1PiAaFdRoDL9VY2BL57rt057hj4hniBWEK867xX/ytEF6iBYX1G+ZIB2NnKAPblLPWUsFwXkxGgPBuHqKzk1tKas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713194465; c=relaxed/simple;
	bh=U591gILez3TCPIxsg2AZfCAyLmatKMd0D5f4AlEzUAo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MonnEIxex5cQkuxH7cuJ1ONh50mFOqD7Tsf9IXyNEl2iBu9JB82StZIUCeTAE0jIx6KNeacwbzx1d9mLcLrI2NfI3QKuLCFXRgPLKy8B26FKfcZM45Bs7w+/QzQQLCuVneEPGOV+CcUDh03wf1bhuGiAOWigMjGvzu6a/omY56E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tnesVMj3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0A8CC2BD10;
	Mon, 15 Apr 2024 15:21:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713194465;
	bh=U591gILez3TCPIxsg2AZfCAyLmatKMd0D5f4AlEzUAo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tnesVMj3h0+6+QlFogXGm3pQbaxsvGNT7TC89L75HvD36bYVy32OBCezVwERvPvcB
	 Jy0gPRKAL1KIOR6mzXeeIwdDnIWKogDWtramNz4DW3E7geV0nfaZT0YAe8t7NLNleb
	 ohb53LfsQ0qmRw7u8CdeOkkYZhZIaZtOu6zX59uVy/CmEI7QoqLHuegsSl0bxjELsN
	 yEAcBpkvD3O3KWDtc7GBGR1RqA4/BlJLx4PV9TKNDzP2xZWbDQncKOAUzUcWU4D+7K
	 w47zabvHdZbF42rD2M5ObdD4B/5h5evHJtH1XxcC8uGR1LppKu1Af3jTdBReQ46AXn
	 5owG47Foj/odA==
From: cel@kernel.org
To: Christian Brauner <brauner@kernel.org>
Cc: <linux-fsdevel@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v2 1/3] libfs: Fix simple_offset_rename_exchange()
Date: Mon, 15 Apr 2024 11:20:54 -0400
Message-ID: <20240415152057.4605-2-cel@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240415152057.4605-1-cel@kernel.org>
References: <20240415152057.4605-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

User space expects the replacement (old) directory entry to have
the same directory offset after the rename.

Suggested-by: Christian Brauner <brauner@kernel.org>
Fixes: a2e459555c5f ("shmem: stable directory offsets")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/libfs.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/fs/libfs.c b/fs/libfs.c
index 3a6f2cb364f8..ab61fae92cde 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -295,6 +295,18 @@ int simple_offset_add(struct offset_ctx *octx, struct dentry *dentry)
 	return 0;
 }
 
+static int simple_offset_replace(struct offset_ctx *octx, struct dentry *dentry,
+				 long offset)
+{
+	int ret;
+
+	ret = mtree_store(&octx->mt, offset, dentry, GFP_KERNEL);
+	if (ret)
+		return ret;
+	offset_set(dentry, offset);
+	return 0;
+}
+
 /**
  * simple_offset_remove - Remove an entry to a directory's offset map
  * @octx: directory offset ctx to be updated
@@ -352,6 +364,9 @@ int simple_offset_empty(struct dentry *dentry)
  * @new_dir: destination parent
  * @new_dentry: destination dentry
  *
+ * This API preserves the directory offset values. Caller provides
+ * appropriate serialization.
+ *
  * Returns zero on success. Otherwise a negative errno is returned and the
  * rename is rolled back.
  */
@@ -369,11 +384,11 @@ int simple_offset_rename_exchange(struct inode *old_dir,
 	simple_offset_remove(old_ctx, old_dentry);
 	simple_offset_remove(new_ctx, new_dentry);
 
-	ret = simple_offset_add(new_ctx, old_dentry);
+	ret = simple_offset_replace(new_ctx, old_dentry, new_index);
 	if (ret)
 		goto out_restore;
 
-	ret = simple_offset_add(old_ctx, new_dentry);
+	ret = simple_offset_replace(old_ctx, new_dentry, old_index);
 	if (ret) {
 		simple_offset_remove(new_ctx, old_dentry);
 		goto out_restore;
@@ -388,10 +403,8 @@ int simple_offset_rename_exchange(struct inode *old_dir,
 	return 0;
 
 out_restore:
-	offset_set(old_dentry, old_index);
-	mtree_store(&old_ctx->mt, old_index, old_dentry, GFP_KERNEL);
-	offset_set(new_dentry, new_index);
-	mtree_store(&new_ctx->mt, new_index, new_dentry, GFP_KERNEL);
+	(void)simple_offset_replace(old_ctx, old_dentry, old_index);
+	(void)simple_offset_replace(new_ctx, new_dentry, new_index);
 	return ret;
 }
 
-- 
2.44.0


