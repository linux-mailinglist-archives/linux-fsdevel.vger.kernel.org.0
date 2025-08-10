Return-Path: <linux-fsdevel+bounces-57213-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C228AB1F92E
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Aug 2025 10:02:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BA9E16D155
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Aug 2025 08:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D73A256C71;
	Sun, 10 Aug 2025 08:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o3Ppu9lC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 771AF248F5A;
	Sun, 10 Aug 2025 08:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754812810; cv=none; b=LneBvag1boojgblXpqpOL1JVNeUkibdMTvabWgxL9ElDXGlOVt7/ONnQ8E9umzEDxORaLuljD6JTXTxUOka741fbfUfpzcOgHvk48KUaO0PTsKq0nfEEdQ5mTincEyWku9Gzu57/sqB1v1Oro4f2XE6kZSnCWAPJkxJ7TUljuTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754812810; c=relaxed/simple;
	bh=bmB+BqOK47AQ74zOAlenVEXHIBC1qQuTYrDPLOSDJDw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P7lh+Yw57wHfhkjUPQI8Ze6AedlYXIL1E1xiGeeg55FxwUQxdO2WU1QcXZ6Ed5sU29l+UDxMOQrnMn0G8rgIS2f9CBDfRk4nAbDU5RdiCZ2o0mJ3/S1aTOnFiAnNnwwtn5C5wrCkAcQq7U8Y9x6dAxAxWMUSJogeshxB97mUm0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o3Ppu9lC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0353DC4CEFB;
	Sun, 10 Aug 2025 08:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754812810;
	bh=bmB+BqOK47AQ74zOAlenVEXHIBC1qQuTYrDPLOSDJDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=o3Ppu9lCK+UMIRCJ649FLlexF8zz+c5Fny3h+DogkpOBxxoTI+SD12otxBd4HJPGN
	 KrDlaO+YuVwOT5khIksO9p/0SHCSpmXkMAtaa9ZYhjNb+HopBdHl5Dgaq7wIamHvE4
	 Lx0RUvlNHg9683rs5qCfE6WCKJafDQIjyfimusDQPjsBQCFnURsh7M1PygjfbmsQsO
	 TcauGSZNJ/T+xRc3iJJaE+4/RX8mbkSg3olk0B9E8OMQ3IYEwZXXP7hfpdQCMrWXxi
	 v6M244Sk1mMSGGyYMPXvvqKBHDNMb/N2yOcxgbUKe/kBGuifA8XvEt1Ov4Sxny0gpD
	 tevQolZt9j7OA==
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
Subject: [PATCH v5 06/13] ceph: move crypt info pointer to fs-specific part of inode
Date: Sun, 10 Aug 2025 00:56:59 -0700
Message-ID: <20250810075706.172910-7-ebiggers@kernel.org>
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
the inode by adding the field ceph_inode_info::i_crypt_info and
configuring fscrypt_operations::inode_info_offs accordingly.

This is a prerequisite for a later commit that removes
inode::i_crypt_info, saving memory and improving cache efficiency with
filesystems that don't support fscrypt.

Co-developed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---
 fs/ceph/crypto.c | 2 ++
 fs/ceph/inode.c  | 1 +
 fs/ceph/super.h  | 1 +
 3 files changed, 4 insertions(+)

diff --git a/fs/ceph/crypto.c b/fs/ceph/crypto.c
index cab7226192073..7026e794813ca 100644
--- a/fs/ceph/crypto.c
+++ b/fs/ceph/crypto.c
@@ -131,10 +131,12 @@ static const union fscrypt_policy *ceph_get_dummy_policy(struct super_block *sb)
 {
 	return ceph_sb_to_fs_client(sb)->fsc_dummy_enc_policy.policy;
 }
 
 static struct fscrypt_operations ceph_fscrypt_ops = {
+	.inode_info_offs	= (int)offsetof(struct ceph_inode_info, i_crypt_info) -
+				  (int)offsetof(struct ceph_inode_info, netfs.inode),
 	.needs_bounce_pages	= 1,
 	.get_context		= ceph_crypt_get_context,
 	.set_context		= ceph_crypt_set_context,
 	.get_dummy_policy	= ceph_get_dummy_policy,
 	.empty_dir		= ceph_crypt_empty_dir,
diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index fc543075b827a..480cb3a1d639a 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -663,10 +663,11 @@ struct inode *ceph_alloc_inode(struct super_block *sb)
 
 	INIT_WORK(&ci->i_work, ceph_inode_work);
 	ci->i_work_mask = 0;
 	memset(&ci->i_btime, '\0', sizeof(ci->i_btime));
 #ifdef CONFIG_FS_ENCRYPTION
+	ci->i_crypt_info = NULL;
 	ci->fscrypt_auth = NULL;
 	ci->fscrypt_auth_len = 0;
 #endif
 	return &ci->netfs.inode;
 }
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index cf176aab0f823..25d8bacbcf440 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -461,10 +461,11 @@ struct ceph_inode_info {
 
 	struct work_struct i_work;
 	unsigned long  i_work_mask;
 
 #ifdef CONFIG_FS_ENCRYPTION
+	struct fscrypt_inode_info *i_crypt_info;
 	u32 fscrypt_auth_len;
 	u32 fscrypt_file_len;
 	u8 *fscrypt_auth;
 	u8 *fscrypt_file;
 #endif
-- 
2.50.1


