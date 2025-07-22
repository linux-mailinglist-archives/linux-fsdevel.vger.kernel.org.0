Return-Path: <linux-fsdevel+bounces-55738-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6EE8B0E43F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jul 2025 21:28:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34D40AA19FC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jul 2025 19:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA0E9285078;
	Tue, 22 Jul 2025 19:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CQvvJrFI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 257E0284678;
	Tue, 22 Jul 2025 19:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753212509; cv=none; b=L7hN0e9TiS+kPoXQXw8YEdDnm0m1v+PIaMAm6VhPd44Ax6JscX2a1i1l0R17DlAVhoR6zYihUc0XYAzqK0kW3J9aBo5uUlnPVm3FNVAcyBMuQJSN9yWjQILymjdsWcoCsxLjEVPwgtKmo/NcdybAvddydOFyBNkpFLFjEL3rvWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753212509; c=relaxed/simple;
	bh=GUkk7e5qyN845ZR1KhGK/kOJkGN4du8LauOUgQXX8Ns=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mlJ4vPUan2dui5L8CxM8IUejEkCdCPW6QbcTOVeHBNTw5n24emtBE0kD3zIeiFl1AisK+tSA28GoFpnfdLPBwBy9gTPu/VN1bP6gnTMYxt9djY1MZiMgC7SiXWihsPlvtx8k3Y+D/lyTeo00sVcn+O18gTyHS7Ccb1B/EaNszQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CQvvJrFI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 122BEC4CEF4;
	Tue, 22 Jul 2025 19:28:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753212508;
	bh=GUkk7e5qyN845ZR1KhGK/kOJkGN4du8LauOUgQXX8Ns=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CQvvJrFIG2DN5zDNrvypu2J+lCQvabbtV+j3bZpv5KL0IgEvdlLSvHAdvb1BDsdfS
	 QW547Slzkwdvowy91pOGNP5Hen4hLfnHOxhZSgU2pccpzuW6JgQpPWIVhjnLpD9sVL
	 8boqV7PgNpKyjnX3zI0+Xoxb1MKC3rJhacf/UmQ7rEE0afNTbUUJc4JWbhrNgJT0ao
	 hy4VKmNPrRCiyZnHzxO+TdZGJhpcqYXRySG1l0NdEjG7+76+cX8EDg0+4ZbZdl1r7u
	 babyg+vmwnAH8luH5MHNtdyZhHLiFallMKsQCVjXHbKzw6SE5AOKRDOnKA1Z9VEnrW
	 KH4Fx3SF2LTxg==
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
Subject: [PATCH v3 12/13] f2fs: move fsverity to filesystem inode
Date: Tue, 22 Jul 2025 21:27:30 +0200
Message-ID: <20250722-work-inode-fscrypt-v3-12-bdc1033420a0@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1707; i=brauner@kernel.org; h=from:subject:message-id; bh=GUkk7e5qyN845ZR1KhGK/kOJkGN4du8LauOUgQXX8Ns=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTUP5Pz2W/5P6GVe19ZusnzvSFpx+Qfz19snTk/yF/zS NuZ4GtSHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABOZw8Xwmz3of4tQX9er1Qb7 ypyzshb7ps2b4F+cOz13qmx5/IQtjowMJ+6dZkztM/18oyLaaYJq/6G/bzcuz7odn3nFaP7pn2J fGAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Move fsverity data pointer into the filesystem's private inode and
record the offset from the embedded struct inode.

This will allow us to drop the fsverity data pointer from struct inode
itself and move it into the filesystem's inode.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/f2fs/f2fs.h  | 3 +++
 fs/f2fs/super.c | 7 +++++++
 2 files changed, 10 insertions(+)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 14e69c00e679..dc43a957a693 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -908,6 +908,9 @@ struct f2fs_inode_info {
 #ifdef CONFIG_FS_ENCRYPTION
 	struct fscrypt_inode_info *i_fscrypt_info; /* filesystem encryption info */
 #endif
+#ifdef CONFIG_FS_VERITY
+	struct fsverity_info	*i_fsverity_info;
+#endif
 };
 
 static inline void get_read_extent_info(struct extent_info *ext,
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 969ba46990ea..75e7661be462 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1456,6 +1456,9 @@ static struct inode *f2fs_alloc_inode(struct super_block *sb)
 #ifdef CONFIG_FS_ENCRYPTION
 	fi->i_fscrypt_info = NULL;
 #endif
+#ifdef CONFIG_FS_VERITY
+	fi->i_fsverity_info = NULL;
+#endif
 
 	return &fi->vfs_inode;
 }
@@ -3252,6 +3255,10 @@ static const struct super_operations f2fs_sops = {
 #ifdef CONFIG_FS_ENCRYPTION
 	.i_fscrypt	= offsetof(struct f2fs_inode_info, i_fscrypt_info) -
 			  offsetof(struct f2fs_inode_info, vfs_inode),
+#endif
+#ifdef CONFIG_FS_VERITY
+	.i_fsverity	= offsetof(struct f2fs_inode_info, i_fsverity_info) -
+			  offsetof(struct f2fs_inode_info, vfs_inode),
 #endif
 	.alloc_inode	= f2fs_alloc_inode,
 	.free_inode	= f2fs_free_inode,

-- 
2.47.2


