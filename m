Return-Path: <linux-fsdevel+bounces-55813-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DADE7B0F09D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 12:59:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E99DDAC0EEF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 10:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4B25254844;
	Wed, 23 Jul 2025 10:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DEZtTcFh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19E642BE047;
	Wed, 23 Jul 2025 10:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753268321; cv=none; b=X2sZN5b4vq5/gCO3CKQ3jFHpDo52ij4PgNNgOffX0FT2BvkLjxXlvxDYzQvP6byrn3pXB4OluDPoT8bzdxcDm6+JY2wDebbM5MrFjkcgcJK9EwWr+xUIWZYZlBQuo0gPWw8xhOKVV95WAQ4oaxw41RW0W+cK/L+I4p/jLhl/Y3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753268321; c=relaxed/simple;
	bh=9F3Pn/e8iPaJqguLpWthKVjvuUvjAlD0pqyxLDAW8QE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X6nZZ+w+tNVf98ENORS+MIx2m8K9OF2rkNz3az8Y03LyWnckPMMVOc2Up/9ShzeE0odzY3IBrrkT4C7JyDw7ZlvgvhxjI+8wiVmvsg2D3Em7Jqj8GZ3Z6pZ11LEPgwAm0P+DOlJsStQxrJKmLOR5/v8oWLe0HbbmDzf5WMXkbB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DEZtTcFh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5232C4CEF6;
	Wed, 23 Jul 2025 10:58:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753268320;
	bh=9F3Pn/e8iPaJqguLpWthKVjvuUvjAlD0pqyxLDAW8QE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DEZtTcFhztpXBUqd7FvU1V26EbIjKRhYWa/br08BGHO+sd/iEH77915rTE2Um3+2r
	 FA8u1fKprsfNGtfUNC9jWrziHmcnJDZ8UQbAuwqbYIJI8ustYZrb64ki6B1AROv0Kq
	 2WCaVwQ0RPGrg3EB0ujdzwv30Zg2eFeefo8tyihtpa/57vOjWbOHQXvrrRkJDnNV8G
	 uH/+z2dmyxeRKJFqH3jvg0iI46eWxgSaahhtAfRspb9+EzdmHeGwY45tI1IOKDUb7Y
	 iJbK78+LX9lZNh++T8h7d/xXLs4Sbic1Tfx0tPRZDj7gIUQXK5llHJdMAI+Ri67jPF
	 n0Uz5NfSXQhRw==
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
Subject: [PATCH v4 12/15] ext4: move fsverity to filesystem inode
Date: Wed, 23 Jul 2025 12:57:50 +0200
Message-ID: <20250723-work-inode-fscrypt-v4-12-c8e11488a0e6@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1826; i=brauner@kernel.org; h=from:subject:message-id; bh=9F3Pn/e8iPaJqguLpWthKVjvuUvjAlD0pqyxLDAW8QE=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQ0HNBOEZrtP/fe96bk2pjkpfpeFctmql6coNhmu3qTh sG/gw4/OkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACYi9onhf5KvoMqEgokrfP/y VEzg02xJ81idkjT376zT5RNm+3uvMGdkmLim/PvzVBbdkvnraqYcOnOlYq2H3LOwDR1fm2xz9pn 95AcA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Move fsverity data pointer into the filesystem's private inode and
record the offset from the embedded struct inode.

This will allow us to drop the fsverity data pointer from struct inode
itself and move it into the filesystem's inode.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/ext4/ext4.h   | 4 ++++
 fs/ext4/super.c  | 3 +++
 fs/ext4/verity.c | 4 ++++
 3 files changed, 11 insertions(+)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 75209a09b19f..d7befc610ca2 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1201,6 +1201,10 @@ struct ext4_inode_info {
 #ifdef CONFIG_FS_ENCRYPTION
 	struct fscrypt_inode_info *i_crypt_info;
 #endif
+
+#ifdef CONFIG_FS_VERITY
+	struct fsverity_info *i_verity_info;
+#endif
 };
 
 /*
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 47c450c68a3b..ff4070df5d77 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1414,6 +1414,9 @@ static struct inode *ext4_alloc_inode(struct super_block *sb)
 	spin_lock_init(&ei->i_fc_lock);
 #ifdef CONFIG_FS_ENCRYPTION
 	ei->i_crypt_info = NULL;
+#endif
+#ifdef CONFIG_FS_VERITY
+	ei->i_verity_info = NULL;
 #endif
 	return &ei->vfs_inode;
 }
diff --git a/fs/ext4/verity.c b/fs/ext4/verity.c
index d9203228ce97..70d9c6c73313 100644
--- a/fs/ext4/verity.c
+++ b/fs/ext4/verity.c
@@ -389,6 +389,10 @@ static int ext4_write_merkle_tree_block(struct inode *inode, const void *buf,
 }
 
 const struct fsverity_operations ext4_verityops = {
+#ifdef CONFIG_FS_VERITY
+	.inode_info_offs	= offsetof(struct ext4_inode_info, i_verity_info) -
+				  offsetof(struct ext4_inode_info, vfs_inode),
+#endif
 	.begin_enable_verity	= ext4_begin_enable_verity,
 	.end_enable_verity	= ext4_end_enable_verity,
 	.get_verity_descriptor	= ext4_get_verity_descriptor,

-- 
2.47.2


