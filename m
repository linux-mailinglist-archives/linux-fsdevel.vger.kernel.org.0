Return-Path: <linux-fsdevel+bounces-16949-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29A688A5638
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Apr 2024 17:21:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B9BD1C226F8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Apr 2024 15:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23386768EE;
	Mon, 15 Apr 2024 15:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g7f39EsD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F1B60EF9
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Apr 2024 15:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713194470; cv=none; b=GGikmKrR+CZMcvRpYJBzHIXxAhi2m0dkPxanQu0NPEdAoJvyV4m2Zmedy+uVeEu1ijA8kHA+HRiMncK7J7IDEKp2tYMu2Z3o7w1AHtUVnqohSf2ugPXgw+AtH6k8OKHlNT0JpTQdRMBKj35y5Jfv6nLPn8Ag8DYdKsfK3f8zJgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713194470; c=relaxed/simple;
	bh=76XY9UufZaCaS5UZa2jy4I5k/dGrgf74e5xgmWqe09Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gQypHt81aidIezDPWG+fOkQdNf3P7Ef3qB+rhbXq/vdFHHxYPCXGWrHZjfn5qZ92EmpmBm0vtmPTz65BTuz+yFZ1/qeHxdOquCAJSJho+6dydjB5epqfskVUaUxlf60dc/2u3Tz17H1qCEPeSeYJwFQU0Ui+AkA3z0a4d33TMe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g7f39EsD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B65CBC113CC;
	Mon, 15 Apr 2024 15:21:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713194470;
	bh=76XY9UufZaCaS5UZa2jy4I5k/dGrgf74e5xgmWqe09Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g7f39EsDYmG8jqT2DOE0ZWpm+WoD+6bkAz26uqXwDou5CJmeApB7Me1ZDrM1S5jE7
	 /dvf/TVQTsdcxsUMdeGYyau3/J9Vc0EzGYAD81mpRkKggh5+7Qt0uRFNGWtoxHElu/
	 TB8JYkSo8WhuS3+daDrhkKTm+Ii3U2XsQc+ujTlKWj8frZdRzDwtsEtMP/uEt1reH3
	 Dj7IbyKA+VplXpeamkeZmC6F0HF+7p9rTyVivY5N5MdqIyZuxL+wk11Kk5buCK+BZJ
	 BeFIIvDNTjS+oV1GciHqXED9BqQSSsh0WIfGMaX9sH3i+Pt8o3fnRA6TdtIdQ0Veso
	 Yt8Dm44S8TDJg==
From: cel@kernel.org
To: Christian Brauner <brauner@kernel.org>
Cc: <linux-fsdevel@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v2 2/3] libfs: Add simple_offset_rename() API
Date: Mon, 15 Apr 2024 11:20:55 -0400
Message-ID: <20240415152057.4605-3-cel@kernel.org>
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

I'm about to fix a tmpfs rename bug that requires the use of
internal simple_offset helpers that are not available in mm/shmem.c

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/libfs.c         | 21 +++++++++++++++++++++
 include/linux/fs.h |  2 ++
 mm/shmem.c         |  3 +--
 3 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/fs/libfs.c b/fs/libfs.c
index ab61fae92cde..c392a6edd393 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -357,6 +357,27 @@ int simple_offset_empty(struct dentry *dentry)
 	return ret;
 }
 
+/**
+ * simple_offset_rename - handle directory offsets for rename
+ * @old_dir: parent directory of source entry
+ * @old_dentry: dentry of source entry
+ * @new_dir: parent_directory of destination entry
+ * @new_dentry: dentry of destination
+ *
+ * Caller provides appropriate serialization.
+ *
+ * Returns zero on success, a negative errno value on failure.
+ */
+int simple_offset_rename(struct inode *old_dir, struct dentry *old_dentry,
+			 struct inode *new_dir, struct dentry *new_dentry)
+{
+	struct offset_ctx *old_ctx = old_dir->i_op->get_offset_ctx(old_dir);
+	struct offset_ctx *new_ctx = new_dir->i_op->get_offset_ctx(new_dir);
+
+	simple_offset_remove(old_ctx, old_dentry);
+	return simple_offset_add(new_ctx, old_dentry);
+}
+
 /**
  * simple_offset_rename_exchange - exchange rename with directory offsets
  * @old_dir: parent of dentry being moved
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 8dfd53b52744..b09f14132110 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3340,6 +3340,8 @@ void simple_offset_init(struct offset_ctx *octx);
 int simple_offset_add(struct offset_ctx *octx, struct dentry *dentry);
 void simple_offset_remove(struct offset_ctx *octx, struct dentry *dentry);
 int simple_offset_empty(struct dentry *dentry);
+int simple_offset_rename(struct inode *old_dir, struct dentry *old_dentry,
+			 struct inode *new_dir, struct dentry *new_dentry);
 int simple_offset_rename_exchange(struct inode *old_dir,
 				  struct dentry *old_dentry,
 				  struct inode *new_dir,
diff --git a/mm/shmem.c b/mm/shmem.c
index 0aad0d9a621b..c0fb65223963 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -3473,8 +3473,7 @@ static int shmem_rename2(struct mnt_idmap *idmap,
 			return error;
 	}
 
-	simple_offset_remove(shmem_get_offset_ctx(old_dir), old_dentry);
-	error = simple_offset_add(shmem_get_offset_ctx(new_dir), old_dentry);
+	error = simple_offset_rename(old_dir, old_dentry, new_dir, new_dentry);
 	if (error)
 		return error;
 
-- 
2.44.0


