Return-Path: <linux-fsdevel+bounces-55805-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8159B0F08D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 12:58:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC13C3BF8B0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 10:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E87F028F935;
	Wed, 23 Jul 2025 10:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="efTob5KU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52CE128CF6D;
	Wed, 23 Jul 2025 10:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753268295; cv=none; b=SzxuswrGq7Q3MIFWslWBfKlvZ8rvccZvXEPcCHOCu7ZVI7yRR9wMwZ+82Kn0DNk9cDjhHLbQCD6cknNB3iYO+0sEdI+kZCiEVVj5RR247zEgz8D0r/9yTcnzK4U6/CFDSFuMyD8na4smEdU8tPewCU1JGV5RLHjjoJh6czrpUgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753268295; c=relaxed/simple;
	bh=iLq6PHTeFehVWrujKMoWKU++/D6uijzWL6Oxj45QdPM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KmSxxy+OUlFR2qcWkXeKpJBetBMwB+OSs6WKU6OK7hDYZWCAiFKn1xnFkDQsRSlj16LoeSO7MnugskmEs5H8ZIY4WtV++YaT8VJUM8Si8aeaDr34AXObkNWYR9yuH0FO3ZHJc3VitacYcBsX+FmAs+qjTZwTNDC8/IPUeA7H138=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=efTob5KU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EA57C4CEE7;
	Wed, 23 Jul 2025 10:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753268294;
	bh=iLq6PHTeFehVWrujKMoWKU++/D6uijzWL6Oxj45QdPM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=efTob5KUX6YfghEKOUdObFIp3nEa4faT1MdAuKqoZysw5KzXU5D1GfNdk3Zo2tT7G
	 os3vGhrs/j4+ae23KHQ9ocLJvLfNciHLGF3ARh+M9wFPWQrduzBiizVcHbnfV+vOTJ
	 Y6J78GtJ/gEoTNekxB7OQdfLEpTNh1cTkAnCIDBvVd/ep9HbyLc9mZVQD1UBH4q/1n
	 YVSHkQ1lN97gixy1Xu1OMHJ5hB2k8ljllhnOq8scsuG+5KQmfntGL/NjfwQB76ypU3
	 HGUNTk8flOzky8cD3uBa2kl00iQ2bysFy+p9+kn2jBbdmQtv0wKjyLVqwurD30+VQX
	 6Lq5uHryuH+bw==
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
Subject: [PATCH v4 04/15] ubifs: move fscrypt to filesystem inode
Date: Wed, 23 Jul 2025 12:57:42 +0200
Message-ID: <20250723-work-inode-fscrypt-v4-4-c8e11488a0e6@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1328; i=brauner@kernel.org; h=from:subject:message-id; bh=iLq6PHTeFehVWrujKMoWKU++/D6uijzWL6Oxj45QdPM=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQ0HNC89HnO+38HEl061qtyt8/pEy7/umQqb/jS+8LPW Ge/P+D8vqOUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAiqY0Mf7j0jjZ+mffK19T0 XHuKhsPyCVotJ3VtJ/wR51ttPnfiCnlGhluH/zoENrdZZa0/d/SLs8BdX7klnXcuSodM3+fJIL3 JgwEA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Move fscrypt data pointer into the filesystem's private inode and record
the offset from the embedded struct inode.

This will allow us to drop the fscrypt data pointer from struct inode
itself and move it into the filesystem's inode.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/ubifs/crypto.c | 4 ++++
 fs/ubifs/ubifs.h  | 3 +++
 2 files changed, 7 insertions(+)

diff --git a/fs/ubifs/crypto.c b/fs/ubifs/crypto.c
index 921f9033d0d2..9f34ed9d5356 100644
--- a/fs/ubifs/crypto.c
+++ b/fs/ubifs/crypto.c
@@ -88,6 +88,10 @@ int ubifs_decrypt(const struct inode *inode, struct ubifs_data_node *dn,
 }
 
 const struct fscrypt_operations ubifs_crypt_operations = {
+#ifdef CONFIG_FS_ENCRYPTION
+	.inode_info_offs	= offsetof(struct ubifs_inode, i_crypt_info) -
+				  offsetof(struct ubifs_inode, vfs_inode),
+#endif
 	.legacy_key_prefix	= "ubifs:",
 	.get_context		= ubifs_crypt_get_context,
 	.set_context		= ubifs_crypt_set_context,
diff --git a/fs/ubifs/ubifs.h b/fs/ubifs/ubifs.h
index 256dbaeeb0de..6c1baa11e073 100644
--- a/fs/ubifs/ubifs.h
+++ b/fs/ubifs/ubifs.h
@@ -416,6 +416,9 @@ struct ubifs_inode {
 	pgoff_t read_in_a_row;
 	int data_len;
 	void *data;
+#ifdef CONFIG_FS_ENCRYPTION
+	struct fscrypt_inode_info *i_crypt_info;
+#endif
 };
 
 /**

-- 
2.47.2


