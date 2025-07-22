Return-Path: <linux-fsdevel+bounces-55730-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A5BBB0E42E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jul 2025 21:28:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86E8F3A9E13
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jul 2025 19:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DDA9284B4C;
	Tue, 22 Jul 2025 19:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qfBsV+SY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9749C2820B2;
	Tue, 22 Jul 2025 19:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753212484; cv=none; b=UmE5GsOyOs3t4DCMM6sJHuylNkpu7yxnIsksjOOQ85Ai9X4e8c7i6EIELOwkryl3O/CyLRgocQkeRTmwPVhXEywYeFEgY9J33hOyopIgDe1FxVkr5WDbu+ZPNyU8c3DF3pejmbNo6+kZX1goBeBdDDNhB9ys1KZUGtByC6g4KYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753212484; c=relaxed/simple;
	bh=ELBn8BFHCr5Y7oaI7HHKs2YtKU5E487BhFYoQYaZneU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uM7Bz0jRSaKj8n2nOr/gVvw7bA/Sadtzt535oJWKosupTlIpu4AGuNEAiboWuY8CsDgzFJjcF9wADYqCtMGUbyOgQkUO/4cQZWK5ZpDyW52uYHBXb7EbYFLncDwNWBvYUsitOyz5lbxdqh/5BU47L5s89gWRqCz4i3h7o7+dUdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qfBsV+SY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BCDAC4CEF4;
	Tue, 22 Jul 2025 19:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753212484;
	bh=ELBn8BFHCr5Y7oaI7HHKs2YtKU5E487BhFYoQYaZneU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qfBsV+SYTmALSFUfV0kx7ZmtmF6Br1rowsq5CgWL0PGpNOdqH+VglzPXuMjRY8M3I
	 Sy+hkeltVm4oM4aQdU+yzBLx0nRWIkIc6Dl14k7dZuO7ehMbZSVAZbi1Kp0AjPDAht
	 2F6zwu7HL+BYY/G5EA7nSdguB0XyrFTSf3+n8lciEcY7JWPDjsvkN3so/WbRogm9/j
	 vd0lEVIvHejehK5/SDCgwOEqiAxVrTtkdR6BRQUjS7qPxyT7bI4vAIyaDLViDz0zU7
	 4h+Yqok7dpkiran/e7vkiXz6+f35ahalxh0//Hfezj8d9sX7XD3G6l9FulTPxZXMzx
	 bK4wi1V69a4rw==
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
Subject: [PATCH v3 04/13] ubifs: move fscrypt to filesystem inode
Date: Tue, 22 Jul 2025 21:27:22 +0200
Message-ID: <20250722-work-inode-fscrypt-v3-4-bdc1033420a0@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1292; i=brauner@kernel.org; h=from:subject:message-id; bh=ELBn8BFHCr5Y7oaI7HHKs2YtKU5E487BhFYoQYaZneU=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTUP5NdFin6UOL50Z0/bionlHeyrxXZFJBzre7KlldP0 vlPzZp3r6OUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAi318y/C+dL7LuY7GU4a3v DtffPtvp8NkhLE7uv0nC/bTrhTeiOtwY/rs7fbVo8Evarqb+Jal9yhvLt4rnt+nkVvi8WhAWO2m 7IDsA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Move fscrypt data pointer into the filesystem's private inode and record
the offset from the embedded struct inode.

This will allow us to drop the fscrypt data pointer from struct inode
itself and move it into the filesystem's inode.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/ubifs/super.c | 4 ++++
 fs/ubifs/ubifs.h | 3 +++
 2 files changed, 7 insertions(+)

diff --git a/fs/ubifs/super.c b/fs/ubifs/super.c
index f3e3b2068608..5b484f054faf 100644
--- a/fs/ubifs/super.c
+++ b/fs/ubifs/super.c
@@ -2003,6 +2003,10 @@ static int ubifs_reconfigure(struct fs_context *fc)
 }
 
 const struct super_operations ubifs_super_operations = {
+#ifdef CONFIG_FS_ENCRYPTION
+	.i_fscrypt	= offsetof(struct ubifs_inode, i_fscrypt_info) -
+			  offsetof(struct ubifs_inode, vfs_inode),
+#endif
 	.alloc_inode   = ubifs_alloc_inode,
 	.free_inode    = ubifs_free_inode,
 	.put_super     = ubifs_put_super,
diff --git a/fs/ubifs/ubifs.h b/fs/ubifs/ubifs.h
index 256dbaeeb0de..0442782a54ab 100644
--- a/fs/ubifs/ubifs.h
+++ b/fs/ubifs/ubifs.h
@@ -416,6 +416,9 @@ struct ubifs_inode {
 	pgoff_t read_in_a_row;
 	int data_len;
 	void *data;
+#ifdef CONFIG_FS_ENCRYPTION
+	struct fscrypt_inode_info *i_fscrypt_info;
+#endif
 };
 
 /**

-- 
2.47.2


