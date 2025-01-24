Return-Path: <linux-fsdevel+bounces-40067-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EFCCA1BCC3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jan 2025 20:20:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFB6A3A3917
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jan 2025 19:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7119D2253E4;
	Fri, 24 Jan 2025 19:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cv+scLBr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE017224B1C;
	Fri, 24 Jan 2025 19:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737746396; cv=none; b=qNthHGdKi6BC13mC1kGAm17ESdjnFzgN+5gMz2f+vXsQ9f0cOggx9UrODED8QJ7Ursr/w1keqKln10628DCLkkigX559rv9daBVDzozhOfX7asaLBOQjSeuY8O86FmBZ6ARCQRwAbDg+WP6VnkP1NioWOmd6ChLDMwROUFrrgR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737746396; c=relaxed/simple;
	bh=zxSHvTXBTLPfQg38mkpreNxvil2Vzc9/HC9eEuTBUzs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=txk1st3Q4kEIa4xv3+EUCQvqtYe8huivdDn6y72Nno4dsQCoMFYlNkdizQZAUD+bFDFB8n5RsOsO0ECuZAyxOiwFeBpErTGCz/qSC9pVWYaqZfjwrbr9sHEZPGi5vscK9aIvPjg2dlvGsJNiCrSpSpFCPux8xzTGz0eatRte0u4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cv+scLBr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E72CC4CEE5;
	Fri, 24 Jan 2025 19:19:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737746396;
	bh=zxSHvTXBTLPfQg38mkpreNxvil2Vzc9/HC9eEuTBUzs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Cv+scLBrqN+k9/W+qvAwD8sQxTVRLnaM5jdmvabrIKB/9GAQAsSBHaUyeMBWok4SX
	 JcGAbXH636Br7W7QbTZB5O1npwacuax3JCvZ8HD3Vsh4diKEMf/zo0iJlzPaQ7oqh9
	 rqxvcBOrc9XobhsksfGqQcKnQ75rkDVAFFmIyOdRDHCoI89AUDP/rqWRBZOzm85UO3
	 hIHijzNeUhk8Aify8yQIke4Gix3/3m6hGBMUeWkWMPWFDnKen/vUt9M6xQxxyZcJv7
	 Bw1xfRP2jntdXYlZDRJz+8DZoUArKtMzWuXbnIGsDRfHnTu0+mKKj8meHKmCiqoKvk
	 kaFysGbrahW4w==
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
Subject: [RFC PATCH v6.6 05/10] libfs: Add simple_offset_rename() API
Date: Fri, 24 Jan 2025 14:19:40 -0500
Message-ID: <20250124191946.22308-6-cel@kernel.org>
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

[ Upstream commit 5a1a25be995e1014abd01600479915683e356f5c ]

I'm about to fix a tmpfs rename bug that requires the use of
internal simple_offset helpers that are not available in mm/shmem.c

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Link: https://lore.kernel.org/r/20240415152057.4605-3-cel@kernel.org
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/libfs.c         | 21 +++++++++++++++++++++
 include/linux/fs.h |  2 ++
 mm/shmem.c         |  3 +--
 3 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/fs/libfs.c b/fs/libfs.c
index 2029cb6a0e15..15d8c3300dae 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -356,6 +356,27 @@ int simple_offset_empty(struct dentry *dentry)
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
index 5104405ce3e6..e4d139fcaad0 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3198,6 +3198,8 @@ void simple_offset_init(struct offset_ctx *octx);
 int simple_offset_add(struct offset_ctx *octx, struct dentry *dentry);
 void simple_offset_remove(struct offset_ctx *octx, struct dentry *dentry);
 int simple_offset_empty(struct dentry *dentry);
+int simple_offset_rename(struct inode *old_dir, struct dentry *old_dentry,
+			 struct inode *new_dir, struct dentry *new_dentry);
 int simple_offset_rename_exchange(struct inode *old_dir,
 				  struct dentry *old_dentry,
 				  struct inode *new_dir,
diff --git a/mm/shmem.c b/mm/shmem.c
index aaf679976f3b..ab2b0e87b051 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -3434,8 +3434,7 @@ static int shmem_rename2(struct mnt_idmap *idmap,
 			return error;
 	}
 
-	simple_offset_remove(shmem_get_offset_ctx(old_dir), old_dentry);
-	error = simple_offset_add(shmem_get_offset_ctx(new_dir), old_dentry);
+	error = simple_offset_rename(old_dir, old_dentry, new_dir, new_dentry);
 	if (error)
 		return error;
 
-- 
2.47.0


