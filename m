Return-Path: <linux-fsdevel+bounces-57220-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1954B1F94F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Aug 2025 10:04:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7D6A3BEBAB
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Aug 2025 08:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31D98274B56;
	Sun, 10 Aug 2025 08:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sMaXqJKa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB4926E6FF;
	Sun, 10 Aug 2025 08:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754812813; cv=none; b=QS6RbrbzF59bZpJR00KrpcA7Ks6IsFGGYuUtRnucMPDDaHGb98piTdAatuz/KIpllCXnCgV2s65IWtXXzEsVExPKuvg4d+tIOZg5sHXFXNXEn9+FWOFslO0FVPriPjsqCHlaj1vdOMiYYPrH6DTiCn7Jry/lOsPmPoOcbUiLPT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754812813; c=relaxed/simple;
	bh=rH4xOjWHyO4rXuGnXUPR48o6Mlex3OOttISDvsv5E9s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bdWLoldjYHHI/mH8u6KJMh6qo5c05Gy2pSGfRSqYJuA0bEZDrxTA4yc0EiBwzvspnB329Epv80/nQeYRIa/i/prD+1BSiu1rnuo49xonHFZNVZpcvnrIxH2WMYX/1wDEtoMQDOhppESlgzJBnj41qe7sNonAlZMtvV9HsSWHCc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sMaXqJKa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 199D3C4CEEB;
	Sun, 10 Aug 2025 08:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754812813;
	bh=rH4xOjWHyO4rXuGnXUPR48o6Mlex3OOttISDvsv5E9s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sMaXqJKa2KxH6f4tMBBaWdPiIEWUPBUacPolQNKXvYj7y1z5EdTS9Ztn04re75Tzb
	 Von+ZDv71Est4yhSEseq9WQNpCJ5tYDDeTnayh3M7Ljc6Z5LkP+X1xTHvCmVmnK62o
	 3fFoQXIgkxTTpk30YcZ1TJeOyR6HE6cw0xQlu6QUNcpP4gKaVMPy6BWuJYymPZm+si
	 9rGzeRe7mySUbOWFc0+2EcQHLZTC4EgyqFre8OARwwRm7N8e3UuA4+gMwWTizV3tt5
	 i+cgenU4mq/isXW8C68emNfvbILzzQPczeVWKyKRxfEEbcTnIOkWQnm7zeTHl03ugW
	 6uTqLHCGI1q/g==
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
Subject: [PATCH v5 13/13] fsverity: check IS_VERITY() in fsverity_cleanup_inode()
Date: Sun, 10 Aug 2025 00:57:06 -0700
Message-ID: <20250810075706.172910-14-ebiggers@kernel.org>
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

Since getting the address of the fsverity_info has gotten a bit more
expensive, make fsverity_cleanup_inode() check for IS_VERITY() instead.
This avoids adding more overhead to non-verity files.

This assumes that verity info is never set when !IS_VERITY(), which is
currently true, but add a VFS_WARN_ON_ONCE() that asserts that.  (This
of course defeats the optimization, but only when CONFIG_VFS_DEBUG=y.)

Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---
 include/linux/fsverity.h | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/include/linux/fsverity.h b/include/linux/fsverity.h
index 844f7b8b56bbc..5bc7280425a71 100644
--- a/include/linux/fsverity.h
+++ b/include/linux/fsverity.h
@@ -188,12 +188,19 @@ void __fsverity_cleanup_inode(struct inode *inode);
  *
  * Filesystems must call this on inode eviction to free the inode's verity info.
  */
 static inline void fsverity_cleanup_inode(struct inode *inode)
 {
-	if (*fsverity_info_addr(inode))
+	/*
+	 * Only IS_VERITY() inodes can have verity info, so start by checking
+	 * for IS_VERITY() (which is faster than retrieving the pointer to the
+	 * verity info).  This minimizes overhead for non-verity inodes.
+	 */
+	if (IS_VERITY(inode))
 		__fsverity_cleanup_inode(inode);
+	else
+		VFS_WARN_ON_ONCE(*fsverity_info_addr(inode) != NULL);
 }
 
 /* read_metadata.c */
 
 int fsverity_ioctl_read_metadata(struct file *filp, const void __user *uarg);
-- 
2.50.1


