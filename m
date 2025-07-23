Return-Path: <linux-fsdevel+bounces-55814-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C5EB7B0F0A4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 13:00:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 360027B75DA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 10:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD0572D29C7;
	Wed, 23 Jul 2025 10:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A1pepAnp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43FBC28CF6D;
	Wed, 23 Jul 2025 10:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753268325; cv=none; b=N8VzXgUu5RxchGF0gsnMQ2Tzb/3/ibWtIwNolM+JENH0jcKJrC3DfnuUZp2vr+KLOXWfHBgnFKQElrwr0ztv2jIL8LwFPG8tKwSfeeXMcKJ717S7ZADIhnflpm4LNzRnI2+RQpLOe+HSTW5YBJRkbIV8rG7hJTQG8gcVUoCkEv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753268325; c=relaxed/simple;
	bh=G1Lh/1wG4ZP2loDw4ptaUeoMD5s7j2HHWmXRHFAYxPQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sKyJ5+guueEV2lxL0RjVck3N8b+3Ni9rpxxoVPz+R3JTSE4fVj0vTW/lnGm7iDR5tzaluq4m1VJ8Deppd/b0zX/RLpMsLpVbkUyamVjEfUOWzOYaigscxgSMUgdGTnVOa24Mps8/VZGQA4C99FOgnHAhQgE5SgIi5IaM7y1PlAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A1pepAnp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CE08C4CEF5;
	Wed, 23 Jul 2025 10:58:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753268323;
	bh=G1Lh/1wG4ZP2loDw4ptaUeoMD5s7j2HHWmXRHFAYxPQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=A1pepAnp5fk3/3bzHs3VP81t8Qz9ICFDqOYybI6qpOq3CkY73V/X7yy/+BCiqqIq9
	 suuoKGQHryRvSk3IRPScEZ4Brdptc6TwQFpB2pW2ai06bFkV9pSI0i5ZaQ0q6Gg8dM
	 QmcyfZiDKJhhdLhgR7vbApUKHXcaU5Y/5upo0MZ+HUJ2rdD/tZDX6w64mvCiG/Lz8W
	 TdhU+N/GKVwmDY63GGov6DiQnkbI1gCzvJROoNX331MXORRADq6QTQ2tFTOy/z/PWk
	 NKlVq9GTfPWGMG+bjoxWyBflsYYMs2BC0LvLooZj6mCSOpk84cdiXwPFuUXUnffSZE
	 H2NIP9vGYmfjQ==
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
Subject: [PATCH v4 13/15] f2fs: move fsverity to filesystem inode
Date: Wed, 23 Jul 2025 12:57:51 +0200
Message-ID: <20250723-work-inode-fscrypt-v4-13-c8e11488a0e6@kernel.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250723-work-inode-fscrypt-v4-0-c8e11488a0e6@kernel.org>
References: <20250723-work-inode-fscrypt-v4-0-c8e11488a0e6@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.15-dev-a9b2a
X-Developer-Signature: v=1; a=openpgp-sha256; l=1882; i=brauner@kernel.org; h=from:subject:message-id; bh=G1Lh/1wG4ZP2loDw4ptaUeoMD5s7j2HHWmXRHFAYxPQ=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQ0HND+qtRVvkI8Mz0o4/SVjfxxFccanxzW0lm1pn36B c2dcytcO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACbygJfhD7+QhO87U8cgkbcv 3oXPsZaLXPTjelTq/p0pEpJb88RUXjEyzOD+1afF01bTsTfeRbdzZxbPnqMlk4JdRRJEPBOP3ov jBQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Move fsverity data pointer into the filesystem's private inode and
record the offset from the embedded struct inode.

This will allow us to drop the fsverity data pointer from struct inode
itself and move it into the filesystem's inode.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/f2fs/f2fs.h   | 3 +++
 fs/f2fs/super.c  | 3 +++
 fs/f2fs/verity.c | 4 ++++
 3 files changed, 10 insertions(+)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 53cb6b6fc70b..f4d04f6fd680 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -908,6 +908,9 @@ struct f2fs_inode_info {
 #ifdef CONFIG_FS_ENCRYPTION
 	struct fscrypt_inode_info *i_crypt_info; /* filesystem encryption info */
 #endif
+#ifdef CONFIG_FS_VERITY
+	struct fsverity_info *i_verity_info;
+#endif
 };
 
 static inline void get_read_extent_info(struct extent_info *ext,
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index dab4078c2f6a..628469ee2b28 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1456,6 +1456,9 @@ static struct inode *f2fs_alloc_inode(struct super_block *sb)
 #ifdef CONFIG_FS_ENCRYPTION
 	fi->i_crypt_info = NULL;
 #endif
+#ifdef CONFIG_FS_VERITY
+	fi->i_verity_info = NULL;
+#endif
 
 	return &fi->vfs_inode;
 }
diff --git a/fs/f2fs/verity.c b/fs/f2fs/verity.c
index 2287f238ae09..1529fe072ff9 100644
--- a/fs/f2fs/verity.c
+++ b/fs/f2fs/verity.c
@@ -287,6 +287,10 @@ static int f2fs_write_merkle_tree_block(struct inode *inode, const void *buf,
 }
 
 const struct fsverity_operations f2fs_verityops = {
+#ifdef CONFIG_FS_VERITY
+	.inode_info_offs	= offsetof(struct f2fs_inode_info, i_verity_info) -
+				  offsetof(struct f2fs_inode_info, vfs_inode),
+#endif
 	.begin_enable_verity	= f2fs_begin_enable_verity,
 	.end_enable_verity	= f2fs_end_enable_verity,
 	.get_verity_descriptor	= f2fs_get_verity_descriptor,

-- 
2.47.2


