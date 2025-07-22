Return-Path: <linux-fsdevel+bounces-55731-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D51CB0E431
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jul 2025 21:28:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C0BE581744
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jul 2025 19:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 368E5284B39;
	Tue, 22 Jul 2025 19:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="npnU8SqM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92569288D2;
	Tue, 22 Jul 2025 19:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753212487; cv=none; b=dhbVzjwHC4BE55XCZHTLIH4q5xrNzABh1UaaTCtiZgHsduBPu33RWEHkZD1aX4ySIb6jWKPAGjAde5ruSlChK/nZ5y2iToYxEFMUWkUvEGK3QpWfR3Rwh++XilZ1jeiMm2yzix9QJjeNE5Id8MVhR5nnora00oTHtMO2D3oghho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753212487; c=relaxed/simple;
	bh=LW0cXqqoGcre+e3okvGEVEOrfKunp9jDeP+S+Nok0pM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=boCbAzlHGmvUievk10jrL0VCsJvEQ9dyv5eKrKC3rFu7FpzAyQ1hhwp3EMxAMtCaoqQUvi0LDCjhKyJ7LlVZwx2DQPFt/BkjwOIuKYrJOT2iwnyZF4O1nFSCtLnqsTgqPPTkiAohNOfgZHz7NgbjJ2HlK6W+xff+HovF/6Lj4EA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=npnU8SqM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B589C4CEEB;
	Tue, 22 Jul 2025 19:28:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753212487;
	bh=LW0cXqqoGcre+e3okvGEVEOrfKunp9jDeP+S+Nok0pM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=npnU8SqMZg67WX9+ig+akKQg+U+BDwLk7PVnafyAy/UYxtBaV6ShglO2RGQ2UZ6SY
	 WNLpcUNt1UJoPavXS2g2wYYAet0oRkp2AeQa1+ISf5Toaa5VD+veSAg/e2byo6E7QO
	 RxMyU0mm7v+gB0743OzIS77L/C63zmRIlv/Tjoo9RXoheoiUKRgh4vIugjpRqe/uNk
	 NRMoKK/N9w71Rxn3Y9/+PRAQdGMAkF+Y9lpBKuTCkj+GPAdJiSsxzubDj6SvRZaZYk
	 ce3Do/iY9s3pF7iLzWECXmZE80YWFn7oPK56qu7I2NGSdzBbJwWbkWOBO5/4UI06+M
	 NvlF7yNwDg08w==
From: Christian Brauner <brauner@kernel.org>
To: Jeff Layton <jlayton@kernel.org>,
	Jan Kara <jack@suse.com>,
	Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>,
	Josef Bacik <josef@toxicpanda.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Eric Biggers <ebiggers@kernel.org>,
	"Theodore Y. Ts'o" <tytso@mit.edu>,
	linux-fsdevel@vger.kernel.org,
	linux-fscrypt@vger.kernel.org,
	fsverity@lists.linux.dev
Subject: [PATCH v3 05/13] f2fs: move fscrypt to filesystem inode
Date: Tue, 22 Jul 2025 21:27:23 +0200
Message-ID: <20250722-work-inode-fscrypt-v3-5-bdc1033420a0@kernel.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250722-work-inode-fscrypt-v3-0-bdc1033420a0@kernel.org>
References: <20250722-work-inode-fscrypt-v3-0-bdc1033420a0@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.15-dev-a9b2a
X-Developer-Signature: v=1; a=openpgp-sha256; l=1700; i=brauner@kernel.org; h=from:subject:message-id; bh=LW0cXqqoGcre+e3okvGEVEOrfKunp9jDeP+S+Nok0pM=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTUP5PlDL7remm7g/hmqTuZSdzejD53d/HNnJIY9Dbde BNLp25HRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwEQSHRgZTr6cPelUtVPs/fwJ 7etr3l7n6d4pGf6Bh1340DZhlv0LrjH8T8i6o3379ebSVaKH1v05OnuxzBreoKy8rWfua5ce8FC w5QAA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Move fscrypt data pointer into the filesystem's private inode and record
the offset from the embedded struct inode.

This will allow us to drop the fscrypt data pointer from struct inode
itself and move it into the filesystem's inode.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/f2fs/f2fs.h  | 3 +++
 fs/f2fs/super.c | 7 +++++++
 2 files changed, 10 insertions(+)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 9333a22b9a01..14e69c00e679 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -905,6 +905,9 @@ struct f2fs_inode_info {
 
 	unsigned int atomic_write_cnt;
 	loff_t original_i_size;		/* original i_size before atomic write */
+#ifdef CONFIG_FS_ENCRYPTION
+	struct fscrypt_inode_info *i_fscrypt_info; /* filesystem encryption info */
+#endif
 };
 
 static inline void get_read_extent_info(struct extent_info *ext,
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index bbf1dad6843f..969ba46990ea 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1453,6 +1453,9 @@ static struct inode *f2fs_alloc_inode(struct super_block *sb)
 
 	/* Will be used by directory only */
 	fi->i_dir_level = F2FS_SB(sb)->dir_level;
+#ifdef CONFIG_FS_ENCRYPTION
+	fi->i_fscrypt_info = NULL;
+#endif
 
 	return &fi->vfs_inode;
 }
@@ -3246,6 +3249,10 @@ void f2fs_quota_off_umount(struct super_block *sb)
 #endif
 
 static const struct super_operations f2fs_sops = {
+#ifdef CONFIG_FS_ENCRYPTION
+	.i_fscrypt	= offsetof(struct f2fs_inode_info, i_fscrypt_info) -
+			  offsetof(struct f2fs_inode_info, vfs_inode),
+#endif
 	.alloc_inode	= f2fs_alloc_inode,
 	.free_inode	= f2fs_free_inode,
 	.drop_inode	= f2fs_drop_inode,

-- 
2.47.2


