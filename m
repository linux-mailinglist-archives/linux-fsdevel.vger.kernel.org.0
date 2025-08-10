Return-Path: <linux-fsdevel+bounces-57219-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B136B1F94B
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Aug 2025 10:03:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 398AA3B4540
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Aug 2025 08:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEC6D27054B;
	Sun, 10 Aug 2025 08:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WrdsILbD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1491321C19D;
	Sun, 10 Aug 2025 08:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754812813; cv=none; b=HJKrT7xu2N68kWsz7pVfJBwZh/rZlKoDcx5O4nsayQbdvRKTlgsW4fbV9BxHZLhZRjbWRDHOU2G7/H8KmxDnUAiUJzC9FPayJ+wiGlCXYi5se7M0758/li4uPGKiMkDvXJpm0u7GAsVPV1ilrATwpetHZNtT9YAqTzujiwwAhz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754812813; c=relaxed/simple;
	bh=4ALZh1TX6fbceabPFA2hm4uM38KlRQdFwuBGPkO3fiQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rtHEqvI8QskgUGZK4NFGCGHwdtGwotwetb1Zzzd98lUteqGapCABAxRkGeBjUan30OXXetNq3B8KO74sT/ooSblUuTh6tSviOu7clBql34r7rP5ywVkmzC7B0UDsjhKrs/Dr9VVFiCo2eur3jDa5YiujJFLsFuFwXq6vHZfQZIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WrdsILbD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3EBCC113CF;
	Sun, 10 Aug 2025 08:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754812813;
	bh=4ALZh1TX6fbceabPFA2hm4uM38KlRQdFwuBGPkO3fiQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WrdsILbDUeHsSLCqkLIk932Dt2ft5mbjyrE14aQEF/nn2Pq8A94dxpPvu46Rx5hQe
	 8tzKe7dmDUzJgfofTapEb1rVqKkqr/QkF4KfBsSMYp4lMGHNXAf1D47sA4az5MAfEV
	 BCJ0OimXCSWvozt+8XYBZKApWRzQlt7Puqaz3lm06hfjSVR87qCb/HIam2C5DpXefv
	 +ByHz8g72FZi9U6OiqvWWhkIaIrGxCJnkGLcmtRdOrzozekuhoRfC663e53fBT3tvu
	 8J17CNaXveiknAWq1luhFlgs6mRJxXvOCcaccTW6LguZC6s8JAbk+v80HBcAGcCqea
	 YHJcypJNTou/A==
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
Subject: [PATCH v5 12/13] fs: remove inode::i_verity_info
Date: Sun, 10 Aug 2025 00:57:05 -0700
Message-ID: <20250810075706.172910-13-ebiggers@kernel.org>
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

Now that all fsverity-capable filesystems store the pointer to
fsverity_info in the filesystem-specific part of the inode structure,
inode::i_verity_info is no longer needed.  Update fsverity_info_addr()
to no longer support the fallback to inode::i_verity_info.  Finally,
remove inode::i_verity_info itself, and move the forward declaration of
struct fsverity_info from fs.h (which no longer needs it) to fsverity.h.

The end result of the migration to the filesystem-specific pointer is
memory savings on CONFIG_FS_VERITY=y kernels for all filesystems that
don't support fsverity.  Specifically, their in-memory inodes are now
smaller by the size of a pointer: either 4 or 8 bytes.

Co-developed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---
 include/linux/fs.h       |  5 -----
 include/linux/fsverity.h | 10 ++++++++--
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 1dafa18169be6..12ecc6b0e6f96 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -71,11 +71,10 @@ struct cred;
 struct swap_info_struct;
 struct seq_file;
 struct workqueue_struct;
 struct iov_iter;
 struct fscrypt_operations;
-struct fsverity_info;
 struct fsverity_operations;
 struct fsnotify_mark_connector;
 struct fsnotify_sb_info;
 struct fs_context;
 struct fs_parameter_spec;
@@ -777,14 +776,10 @@ struct inode {
 	__u32			i_fsnotify_mask; /* all events this inode cares about */
 	/* 32-bit hole reserved for expanding i_fsnotify_mask */
 	struct fsnotify_mark_connector __rcu	*i_fsnotify_marks;
 #endif
 
-#ifdef CONFIG_FS_VERITY
-	struct fsverity_info	*i_verity_info;
-#endif
-
 	void			*i_private; /* fs or device private pointer */
 } __randomize_layout;
 
 static inline void inode_set_cached_link(struct inode *inode, char *link, int linklen)
 {
diff --git a/include/linux/fsverity.h b/include/linux/fsverity.h
index e0f132cb78393..844f7b8b56bbc 100644
--- a/include/linux/fsverity.h
+++ b/include/linux/fsverity.h
@@ -24,10 +24,12 @@
 #define FS_VERITY_MAX_DIGEST_SIZE	SHA512_DIGEST_SIZE
 
 /* Arbitrary limit to bound the kmalloc() size.  Can be changed. */
 #define FS_VERITY_MAX_DESCRIPTOR_SIZE	16384
 
+struct fsverity_info;
+
 /* Verity operations for filesystems */
 struct fsverity_operations {
 	/**
 	 * The offset of the pointer to struct fsverity_info in the
 	 * filesystem-specific part of the inode, relative to the beginning of
@@ -128,15 +130,19 @@ struct fsverity_operations {
 				       u64 pos, unsigned int size);
 };
 
 #ifdef CONFIG_FS_VERITY
 
+/*
+ * Returns the address of the verity info pointer within the filesystem-specific
+ * part of the inode.  (To save memory on filesystems that don't support
+ * fsverity, a field in 'struct inode' itself is no longer used.)
+ */
 static inline struct fsverity_info **
 fsverity_info_addr(const struct inode *inode)
 {
-	if (inode->i_sb->s_vop->inode_info_offs == 0)
-		return (struct fsverity_info **)&inode->i_verity_info;
+	VFS_WARN_ON_ONCE(inode->i_sb->s_vop->inode_info_offs == 0);
 	return (void *)inode + inode->i_sb->s_vop->inode_info_offs;
 }
 
 static inline struct fsverity_info *fsverity_get_info(const struct inode *inode)
 {
-- 
2.50.1


