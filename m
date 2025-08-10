Return-Path: <linux-fsdevel+bounces-57214-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 29958B1F929
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Aug 2025 10:01:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6199A1897799
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Aug 2025 08:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCF9425F798;
	Sun, 10 Aug 2025 08:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SLFlFAFY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F5FB256C84;
	Sun, 10 Aug 2025 08:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754812811; cv=none; b=EuMXowSXJv1PDrYHCj/ZOlFdDZITL2z6/iySlaoMRACE+O8bkClIKgHvMkL1la0fwCQvLBwnrlBldCwBBd7ljxbRB5LFeXGmaI3X8CYloEJvt/jdtmgBSX3nKQv43Tg2FqZrCJrFEsv89tZ2dYlKvOFy9QZVot8A8yZ5Fj+Helc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754812811; c=relaxed/simple;
	bh=hTLksDqAG7iJZbJnGqd8JyQQhFVP3K3qP+WNZUyThvI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tjJ3KdS9JJ875CTWwmZZMSNacjhaTVsFekyRizgedR9qhRSKloPns8D2AKj4Z9xuBHNKamET5GQKiDKR6Yc49MdQnCMSRlZjmF6Xc2rBIGNGImAITqKH79/W+2DgaIk7Uc+wBUxdOz30ORXBTfGVYIuj8n8A9HJjsc2uP1CQzB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SLFlFAFY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FAB9C4CEEB;
	Sun, 10 Aug 2025 08:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754812810;
	bh=hTLksDqAG7iJZbJnGqd8JyQQhFVP3K3qP+WNZUyThvI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SLFlFAFYjVyvx9ggNdb5bWTXUqjDAUbaAo7N9/6UnJmEJtn+vKgzQPSAsWKAsRRRL
	 So3V9vSSaOSZ6Ds6ARu8XEUs1FVfS4QUCRq4ZHQrfPc+rBVQhL3v9wIQaxwh3+aQXB
	 k2ubttllOoJvrh7zV/bz9kqO1TlYZEs1y0/O8Oyc1IkXRMPZ74rzJNYA4fyBXPEpMJ
	 /brqN4ToKmH+IcQQqnwa6y3VbfRNfVQosWIZdaAiMRv8+lLvNNZA8f1nmW1uL0/aTx
	 NURcg6NCqctDVHUqEvUCetLBqq3zGe3Ta/k9LE0yd/xaBpAv3jwBpD7nQrShG7pq1M
	 V6O2XmUIE9Lsg==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-fscrypt@vger.kernel.org,
	fsverity@lists.linux.dev
Cc: linux-fsdevel@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-mtd@lists.infradead.org,
	linux-btrfs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH v5 07/13] fs: remove inode::i_crypt_info
Date: Sun, 10 Aug 2025 00:57:00 -0700
Message-ID: <20250810075706.172910-8-ebiggers@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250810075706.172910-1-ebiggers@kernel.org>
References: <20250810075706.172910-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that all fscrypt-capable filesystems store the pointer to
fscrypt_inode_info in the filesystem-specific part of the inode
structure, inode::i_crypt_info is no longer needed.  Update
fscrypt_inode_info_addr() to no longer support the fallback to
inode::i_crypt_info.  Finally, remove inode::i_crypt_info itself along
with the now-unnecessary forward declaration of fscrypt_inode_info.

The end result of the migration to the filesystem-specific pointer is
memory savings on CONFIG_FS_ENCRYPTION=y kernels for all filesystems
that don't support fscrypt.  Specifically, their in-memory inodes are
now smaller by the size of a pointer: either 4 or 8 bytes.

Co-developed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---
 include/linux/fs.h      | 5 -----
 include/linux/fscrypt.h | 8 ++++++--
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index d7ab4f96d7051..1dafa18169be6 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -70,11 +70,10 @@ struct vfsmount;
 struct cred;
 struct swap_info_struct;
 struct seq_file;
 struct workqueue_struct;
 struct iov_iter;
-struct fscrypt_inode_info;
 struct fscrypt_operations;
 struct fsverity_info;
 struct fsverity_operations;
 struct fsnotify_mark_connector;
 struct fsnotify_sb_info;
@@ -778,14 +777,10 @@ struct inode {
 	__u32			i_fsnotify_mask; /* all events this inode cares about */
 	/* 32-bit hole reserved for expanding i_fsnotify_mask */
 	struct fsnotify_mark_connector __rcu	*i_fsnotify_marks;
 #endif
 
-#ifdef CONFIG_FS_ENCRYPTION
-	struct fscrypt_inode_info	*i_crypt_info;
-#endif
-
 #ifdef CONFIG_FS_VERITY
 	struct fsverity_info	*i_verity_info;
 #endif
 
 	void			*i_private; /* fs or device private pointer */
diff --git a/include/linux/fscrypt.h b/include/linux/fscrypt.h
index d7ff53accbfef..516aba5b858b5 100644
--- a/include/linux/fscrypt.h
+++ b/include/linux/fscrypt.h
@@ -199,15 +199,19 @@ struct fscrypt_operations {
 };
 
 int fscrypt_d_revalidate(struct inode *dir, const struct qstr *name,
 			 struct dentry *dentry, unsigned int flags);
 
+/*
+ * Returns the address of the fscrypt info pointer within the
+ * filesystem-specific part of the inode.  (To save memory on filesystems that
+ * don't support fscrypt, a field in 'struct inode' itself is no longer used.)
+ */
 static inline struct fscrypt_inode_info **
 fscrypt_inode_info_addr(const struct inode *inode)
 {
-	if (inode->i_sb->s_cop->inode_info_offs == 0)
-		return (struct fscrypt_inode_info **)&inode->i_crypt_info;
+	VFS_WARN_ON_ONCE(inode->i_sb->s_cop->inode_info_offs == 0);
 	return (void *)inode + inode->i_sb->s_cop->inode_info_offs;
 }
 
 /*
  * Load the inode's fscrypt info pointer, using a raw dereference.  Since this
-- 
2.50.1


