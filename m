Return-Path: <linux-fsdevel+bounces-57212-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 955B7B1F92B
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Aug 2025 10:02:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33A991668F3
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Aug 2025 08:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB7C4253944;
	Sun, 10 Aug 2025 08:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IBNeIHJ2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EA2C247299;
	Sun, 10 Aug 2025 08:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754812810; cv=none; b=qSRfTaJiUITlTlp3/+JcvEOod/F9YUV/UDEO/Yq80iNAdcUFuRhYqoxlREWFaLIKFQTfyAg/4KlEqz1+sv8HilNCejzQiZ9Xwy8e9AYm4G9uuq7e8Sid+2rJHiu7vWRj4CkI6KZ7/D7v0/0pKwToaslOXEUFTAu+7y5GnxNE3NU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754812810; c=relaxed/simple;
	bh=Qm1plsgVlmTBCpbZLW/xcJNpj1w2kpvFy1WqJ9hSAZw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LApkqpBtaZJqM4UiZdO/1jQBKj2yOnonRpTMlcrWxizH3Ikfr6YNn4wTILWl4svPyNquDeFvBWvuwYHw80u0wttXeuxhe2pkuX8aFmPmp//V+SV/j3AU+YPjYazFqSSsxcNBhMesVuf3acY78oDThxbsbKcqJ5KUBPBRCMgXEHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IBNeIHJ2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D421C4CEEB;
	Sun, 10 Aug 2025 08:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754812809;
	bh=Qm1plsgVlmTBCpbZLW/xcJNpj1w2kpvFy1WqJ9hSAZw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IBNeIHJ2heVgM/csrEC21oBuVod6FeprqFqd1W+zzBuMWSAFjawLCDuBK4bneu7ou
	 0AlF0wyE4wt//266UDH7gUEIzRcrV+jXb8aeubS8u1tpfdXci4muagNyNZfgTKW7z6
	 jF+JQtHOfsQEB/S3jXe+F3X3rWlXyf4VbWi7aYpAxVSjgjSsDaWRFTSxEVW7ec7/Rc
	 kHShVks2Ht5rGE4vyY02UuKKgzsrXLCZoQMGvSwhz/kAeIpVrCuHfxcKEFzFAG1/fr
	 XCR8JpQGpS8e3uHh5SXlecIvhE6bSOWV5WiT27UJA8SYlbR+nXiMx3EeZEKqt1YvaB
	 x54EA9wnkMuUw==
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
Subject: [PATCH v5 05/13] ubifs: move crypt info pointer to fs-specific part of inode
Date: Sun, 10 Aug 2025 00:56:58 -0700
Message-ID: <20250810075706.172910-6-ebiggers@kernel.org>
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

Move the fscrypt_inode_info pointer into the filesystem-specific part of
the inode by adding the field ubifs_inode::i_crypt_info and configuring
fscrypt_operations::inode_info_offs accordingly.

This is a prerequisite for a later commit that removes
inode::i_crypt_info, saving memory and improving cache efficiency with
filesystems that don't support fscrypt.

Note that the initialization of ubifs_inode::i_crypt_info to NULL on
inode allocation is handled by the memset() in ubifs_alloc_inode().

Co-developed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---
 fs/ubifs/crypto.c | 2 ++
 fs/ubifs/ubifs.h  | 4 ++++
 2 files changed, 6 insertions(+)

diff --git a/fs/ubifs/crypto.c b/fs/ubifs/crypto.c
index fb5ac358077b1..0b14d004a095b 100644
--- a/fs/ubifs/crypto.c
+++ b/fs/ubifs/crypto.c
@@ -86,10 +86,12 @@ int ubifs_decrypt(const struct inode *inode, struct ubifs_data_node *dn,
 
 	return 0;
 }
 
 const struct fscrypt_operations ubifs_crypt_operations = {
+	.inode_info_offs	= (int)offsetof(struct ubifs_inode, i_crypt_info) -
+				  (int)offsetof(struct ubifs_inode, vfs_inode),
 	.legacy_key_prefix	= "ubifs:",
 	.get_context		= ubifs_crypt_get_context,
 	.set_context		= ubifs_crypt_set_context,
 	.empty_dir		= ubifs_crypt_empty_dir,
 };
diff --git a/fs/ubifs/ubifs.h b/fs/ubifs/ubifs.h
index 5db45c9e26ee0..49e50431741cd 100644
--- a/fs/ubifs/ubifs.h
+++ b/fs/ubifs/ubifs.h
@@ -363,10 +363,11 @@ struct ubifs_gced_idx_leb {
  * @compr_type: default compression type used for this inode
  * @last_page_read: page number of last page read (for bulk read)
  * @read_in_a_row: number of consecutive pages read in a row (for bulk read)
  * @data_len: length of the data attached to the inode
  * @data: inode's data
+ * @i_crypt_info: inode's fscrypt information
  *
  * @ui_mutex exists for two main reasons. At first it prevents inodes from
  * being written back while UBIFS changing them, being in the middle of an VFS
  * operation. This way UBIFS makes sure the inode fields are consistent. For
  * example, in 'ubifs_rename()' we change 4 inodes simultaneously, and
@@ -414,10 +415,13 @@ struct ubifs_inode {
 	int flags;
 	pgoff_t last_page_read;
 	pgoff_t read_in_a_row;
 	int data_len;
 	void *data;
+#ifdef CONFIG_FS_ENCRYPTION
+	struct fscrypt_inode_info *i_crypt_info;
+#endif
 };
 
 /**
  * struct ubifs_unclean_leb - records a LEB recovered under read-only mode.
  * @list: list
-- 
2.50.1


