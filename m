Return-Path: <linux-fsdevel+bounces-55737-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8746BB0E43C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jul 2025 21:28:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55492160856
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jul 2025 19:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2CAD283FE7;
	Tue, 22 Jul 2025 19:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BaC7uaHi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BAF027FB31;
	Tue, 22 Jul 2025 19:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753212506; cv=none; b=VpXjsoCZ+LOsoV8GuWDeYtMmW4bMAVyUuc9aEC4yhYI5R7KI8qR8C9g5jrpjDXi4X5T2sx1TRjJK/ZNGABvYgTTLOko1aaRj+t3ZAx7Yus83qwfrzrx5aSKMixuNTGO5gC9WA7jQZNNh3mj+qCcruGV2Sp2kgjcNRlyV8zl55a4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753212506; c=relaxed/simple;
	bh=aRKEDLMGsaZA4oqWLtFH+zBOvicPtLzCig3E3SFC20Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=maQMCukSP3cq4sMwCFLMFoImwTklndt3nn6spaFwkNjfBAwpEGVDMSCElKnhoDWig/+wHGhjNM8qhKY0lSoxNm9GJGgDe9Fyv/D+2eXHuJZB/Jc6yxJaGllNamjN7QdQUktl3Cx/XEv93+P486OgYj1VVVEVDLuQ0VnWoNjAGIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BaC7uaHi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10DBEC4CEEB;
	Tue, 22 Jul 2025 19:28:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753212505;
	bh=aRKEDLMGsaZA4oqWLtFH+zBOvicPtLzCig3E3SFC20Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BaC7uaHicZ2cH0EO9obIEhByuMjM2bw2VQQrlX41miMcT0Am9mjR96vMQ48dTPEZL
	 8geftMECznm+xzQRB2nCVHYSxHW0vlvPcBz06JlbEn8u1zTLO4Y5vOWza7lNFMOeU8
	 fFpa1gvaGa36lD4p35Hy1jvktJTtEwQLSRA4oBdB6j9rmqFLp9/YHL7PJj0wFgb+Ht
	 OQgvEgftOjaBo+P16ukCmARJ5lpvc37SnCRPYbhFhxuFgZWTc9afuswzDamuiiD8SL
	 9BQA3AclBCUWW674BJj8jXqYdU24gmmu9wyWjBKHcpbaAHaNjjo0Mu0Jas0/9ilT8y
	 tziR+LdLAwtXg==
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
Subject: [PATCH v3 11/13] ext4: move fsverity to filesystem inode
Date: Tue, 22 Jul 2025 21:27:29 +0200
Message-ID: <20250722-work-inode-fscrypt-v3-11-bdc1033420a0@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1659; i=brauner@kernel.org; h=from:subject:message-id; bh=aRKEDLMGsaZA4oqWLtFH+zBOvicPtLzCig3E3SFC20Y=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTUP5P7PsNQfvfi3wzeequvGzr6RXv/O9nRdni/++1my ZTq9N8LOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACYSdZnhf0CMue/EhfVRdftU n7p4ve6Mdf7+2I6Paf8c3VOPd13+VsLwP1bq1tKlEz/FiX9boP2Q55W8158dMtHbxJKX+P+cd+2 8Gx8A
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Move fsverity data pointer into the filesystem's private inode and
record the offset from the embedded struct inode.

This will allow us to drop the fsverity data pointer from struct inode
itself and move it into the filesystem's inode.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/ext4/ext4.h  | 4 ++++
 fs/ext4/super.c | 7 +++++++
 2 files changed, 11 insertions(+)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index f27d57aea316..4ae1a8aa8bac 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1201,6 +1201,10 @@ struct ext4_inode_info {
 #ifdef CONFIG_FS_ENCRYPTION
 	struct fscrypt_inode_info	*i_fscrypt_info;
 #endif
+
+#ifdef CONFIG_FS_VERITY
+	struct fsverity_info	*i_fsverity_info;
+#endif
 };
 
 /*
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 2a03835b67d5..37ef8fa4ebeb 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1414,6 +1414,9 @@ static struct inode *ext4_alloc_inode(struct super_block *sb)
 	spin_lock_init(&ei->i_fc_lock);
 #ifdef CONFIG_FS_ENCRYPTION
 	ei->i_fscrypt_info = NULL;
+#endif
+#ifdef CONFIG_FS_VERITY
+	ei->i_fsverity_info = NULL;
 #endif
 	return &ei->vfs_inode;
 }
@@ -1613,6 +1616,10 @@ static const struct super_operations ext4_sops = {
 #ifdef CONFIG_FS_ENCRYPTION
 	.i_fscrypt	= offsetof(struct ext4_inode_info, i_fscrypt_info) -
 			  offsetof(struct ext4_inode_info, vfs_inode),
+#endif
+#ifdef CONFIG_FS_VERITY
+	.i_fsverity	= offsetof(struct ext4_inode_info, i_fsverity_info) -
+			  offsetof(struct ext4_inode_info, vfs_inode),
 #endif
 	.alloc_inode	= ext4_alloc_inode,
 	.free_inode	= ext4_free_in_core_inode,

-- 
2.47.2


