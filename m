Return-Path: <linux-fsdevel+bounces-40066-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E1E3A1BCC1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jan 2025 20:20:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8834D188FA82
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jan 2025 19:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DE14224B18;
	Fri, 24 Jan 2025 19:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bw2F45L6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D976B224B07;
	Fri, 24 Jan 2025 19:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737746395; cv=none; b=Kty8EPiyPmT3C7OuyMCIeV3WPLxZmuxaQeNqbn7rEcwds+uM+oaVdTdqZNwa92n9kj+ZFP7QQ0XVtXYPALYs/fowmLcFXXZMBG7I10N4LrFR/eWFU+Piibb9cfCMHlwfW/GBLuAo/FNtlT90SEPPUNSnrsVl3VSOTsNNSBATyDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737746395; c=relaxed/simple;
	bh=S3TpyVqlQ6GbQ6WEv5W4bM5DS5m/bnNZcBueUm6fZKc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mYklvEKYTucUXLaR2zdeyB/1c4SYQwmGJEydw+oJtb8nRERA2HP0wjOrem2B+N39fJhC5uiE4gDpD7WekaMZTm2tRarAZYzCLRxWUoH1ZfOTznxUgfUjExIR6EXSLjw3Z+FYtCuWcQQ0eVpPqGxlu5PXzDvfKs5QfftQPrX38XQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bw2F45L6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55E93C4CED2;
	Fri, 24 Jan 2025 19:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737746395;
	bh=S3TpyVqlQ6GbQ6WEv5W4bM5DS5m/bnNZcBueUm6fZKc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Bw2F45L6uyN95VvlhmGZ+g4u/m5LECYA5/LAsY1EmhxFlU2jq6MfD+cMGacR+Ld2v
	 p0aTtj40pSk6001/wmYSKhZDxqdzalUgg29lktQoX7WM/It7P5JeL0DDTbi2BgarK1
	 aqg3rsJYNXlDSgEfdlA9HPITqPGdQ7b6a5B9okkPLIl12h8XQFGY32nmKeBdFDlJR/
	 eeS/6GfYh+zNGGZkiMitIsaKbpA9TBHhGrY0MZt6ziQZlAFXK7Qx27N/G5+G3q8TDh
	 MFhqHTARUZwQCvDprCMXDiIXPzmJ/nbhOrwDP/bJk9U/7jIRCPya2sMAV9/1DS3yvb
	 HfkpCW6XtoGBg==
From: cel@kernel.org
To: Hugh Dickins <hughd@google.com>,
	Andrew Morten <akpm@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Cc: <linux-fsdevel@vger.kernel.org>,
	<stable@vger.kernel.org>,
	<linux-mm@kvack.org>,
	yukuai3@huawei.com,
	yangerkun@huawei.com,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [RFC PATCH v6.6 04/10] libfs: Fix simple_offset_rename_exchange()
Date: Fri, 24 Jan 2025 14:19:39 -0500
Message-ID: <20250124191946.22308-5-cel@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250124191946.22308-1-cel@kernel.org>
References: <20250124191946.22308-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

[ Upstream commit 23cdd0eed3f1fff3af323092b0b88945a7950d8e ]

User space expects the replacement (old) directory entry to have
the same directory offset after the rename.

Suggested-by: Christian Brauner <brauner@kernel.org>
Fixes: a2e459555c5f ("shmem: stable directory offsets")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Link: https://lore.kernel.org/r/20240415152057.4605-2-cel@kernel.org
Signed-off-by: Christian Brauner <brauner@kernel.org>
[ cel: adjusted to apply to origin/linux-6.6.y ]
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/libfs.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/fs/libfs.c b/fs/libfs.c
index d7b901cb9af4..2029cb6a0e15 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -294,6 +294,18 @@ int simple_offset_add(struct offset_ctx *octx, struct dentry *dentry)
 	return 0;
 }
 
+static int simple_offset_replace(struct offset_ctx *octx, struct dentry *dentry,
+				 long offset)
+{
+	void *ret;
+
+	ret = xa_store(&octx->xa, offset, dentry, GFP_KERNEL);
+	if (xa_is_err(ret))
+		return xa_err(ret);
+	offset_set(dentry, offset);
+	return 0;
+}
+
 /**
  * simple_offset_remove - Remove an entry to a directory's offset map
  * @octx: directory offset ctx to be updated
@@ -351,6 +363,9 @@ int simple_offset_empty(struct dentry *dentry)
  * @new_dir: destination parent
  * @new_dentry: destination dentry
  *
+ * This API preserves the directory offset values. Caller provides
+ * appropriate serialization.
+ *
  * Returns zero on success. Otherwise a negative errno is returned and the
  * rename is rolled back.
  */
@@ -368,11 +383,11 @@ int simple_offset_rename_exchange(struct inode *old_dir,
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
@@ -387,10 +402,8 @@ int simple_offset_rename_exchange(struct inode *old_dir,
 	return 0;
 
 out_restore:
-	offset_set(old_dentry, old_index);
-	xa_store(&old_ctx->xa, old_index, old_dentry, GFP_KERNEL);
-	offset_set(new_dentry, new_index);
-	xa_store(&new_ctx->xa, new_index, new_dentry, GFP_KERNEL);
+	(void)simple_offset_replace(old_ctx, old_dentry, old_index);
+	(void)simple_offset_replace(new_ctx, new_dentry, new_index);
 	return ret;
 }
 
-- 
2.47.0


