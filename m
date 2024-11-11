Return-Path: <linux-fsdevel+bounces-34171-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AD259C359E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 01:54:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 357CB1F22507
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 00:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0103CEAC6;
	Mon, 11 Nov 2024 00:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LntlDsRP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5868778C9C;
	Mon, 11 Nov 2024 00:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731286392; cv=none; b=aFm7d0M7Ofd7OCVeOPOCzvGoM+1k43BLsJRYBzeoSiUOVqYantvtI9FpPwL1CA2i7VpkrXFcgauXjUVkJiXLfJgvzh/TaUfg0gjqaXeoxFh0CewbtQOXcKa2ipGEZ8HmpxKGF1ADhiY4pM128E380T7SJgPRABXdMEgeB15RGs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731286392; c=relaxed/simple;
	bh=Vg2de2ueiLqplD9ZUkL2WjK6PFXZnIvvP0PrhnulG7U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rlBKJECy7NAcEkOq4xHAuUfFy2ln/8twBz1gMb9rOV37FLJP+3V8EQIJSLyu7x6jgQ4Fc4zM9Yau7FO5w7prwZDUHEqL4Q012YOSlGMg3ULgRzNYTtBW/b6+jpGYKasTFjgXDiSCXTdF0xx0We+KKq/44XEhRQR0kAnRVpuRHBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LntlDsRP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4692DC4CEDE;
	Mon, 11 Nov 2024 00:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731286392;
	bh=Vg2de2ueiLqplD9ZUkL2WjK6PFXZnIvvP0PrhnulG7U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LntlDsRPAJVpLflvo1J+MXbwR9kHtrH49Fl7QV0sUfTujzgZAVo2GYq05/qBcrED2
	 P5+FBtYtnXmvVoS67me6BmpKITcP96pPQOruzlaNuNYbgLNcdLbK8+uQoJk2yU52fe
	 3DPfqjPHYI5YACZNC9kwdfTOKkl50NK+YlzDP8pnBPZhCBFyXCgc92DjRrFVmAPVFl
	 P9D1yn//N2jB4mFzzusmaQPzfUhK6ZC0Uw8/KeJcqJd2o2bQ/ukM4eVg7Or+Ek0SLF
	 Ns9L2mmyGiq8vMHRYfUN8SiJfeLdspLvac8GWEATs2hz6s/fh3Jn/WBOYm5zRNJEGe
	 iLRbh88kvIh8Q==
From: cel@kernel.org
To: <stable@vger.kernel.org>
Cc: yukuai1@huaweicloud.com,
	harry.wentland@amd.com,
	sunpeng.li@amd.com,
	Rodrigo.Siqueira@amd.com,
	alexander.deucher@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	Liam.Howlett@oracle.com,
	akpm@linux-foundation.org,
	hughd@google.com,
	willy@infradead.org,
	gregkh@linuxfoundation.org,
	sashal@kernel.org,
	srinivasan.shanmugam@amd.com,
	chiahsuan.chung@amd.com,
	mingo@kernel.org,
	mgorman@techsingularity.net,
	yukuai3@huawei.com,
	chengming.zhou@linux.dev,
	zhangpeng.00@bytedance.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	<linux-kernel@vger.kernel.org>,
	linux-fsdevel@vger.kernel.org,
	maple-tree@lists.infradead.org,
	linux-mm@kvack.org,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [RFC PATCH 3/6 6.6] libfs: Fix simple_offset_rename_exchange()
Date: Sun, 10 Nov 2024 19:52:39 -0500
Message-ID: <20241111005242.34654-4-cel@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241111005242.34654-1-cel@kernel.org>
References: <20241111005242.34654-1-cel@kernel.org>
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
index 66b428f3fc41..9fec0113a83f 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -294,6 +294,18 @@ int simple_offset_add(struct offset_ctx *octx, struct dentry *dentry)
 	return 0;
 }
 
+static int simple_offset_replace(struct offset_ctx *octx, struct dentry *dentry,
+				 u32 offset)
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


