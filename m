Return-Path: <linux-fsdevel+bounces-5804-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 028A58108F7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 05:01:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 345421C20748
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 04:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABD12DDCB;
	Wed, 13 Dec 2023 04:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mtsw78xN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F03A4C8D4;
	Wed, 13 Dec 2023 04:01:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A0D1C433C9;
	Wed, 13 Dec 2023 04:01:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702440075;
	bh=/IgnbynuauVVnwnYuvTis66K2+UvLrV1IZcqqY1dQxo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Mtsw78xNFAYW72ZVSI58XmG3r3b7jzf5YBccAulp9/1BO7zRBF+wDqWlYrljaMm4k
	 +9/Vx7T1sw6/jBV6IO4Yha52vkFfiqnum5DEck4Ip6XZ9VSVH1PeChkoTOrTWNuszY
	 c1N8MVSA6ovIcnZMimKA5Kw55To5yhNMb79uFZKY8fg5hjndWVeVqmfW9hQxcY7xS6
	 5+OGVzgKJ3Y/tofA5oACmOTMCIwq0P6wpqYrMHO3JTqaGLbs50MhOKakxkbUvrYTPf
	 xDELOGTPUziyVV7E1kKLU0GuHB2LUKeXJ1Ptab8+IqkLO6TSYZX3avBSD7LXIRnRgW
	 OYnRi5KlA9t3A==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: linux-fscrypt@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	Josef Bacik <josef@toxicpanda.com>,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH 3/3] fs: move fscrypt keyring destruction to after ->put_super
Date: Tue, 12 Dec 2023 20:00:18 -0800
Message-ID: <20231213040018.73803-4-ebiggers@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231213040018.73803-1-ebiggers@kernel.org>
References: <20231213040018.73803-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Josef Bacik <josef@toxicpanda.com>

btrfs has a variety of asynchronous things we do with inodes that can
potentially last until ->put_super, when we shut everything down and
clean up all of our async work.  Due to this we need to move
fscrypt_destroy_keyring() to after ->put_super, otherwise we get
warnings about still having active references on the master key.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/super.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/super.c b/fs/super.c
index 076392396e724..faf7d248145d2 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -674,34 +674,34 @@ void generic_shutdown_super(struct super_block *sb)
 		/* Evict all inodes with zero refcount. */
 		evict_inodes(sb);
 
 		/*
 		 * Clean up and evict any inodes that still have references due
 		 * to fsnotify or the security policy.
 		 */
 		fsnotify_sb_delete(sb);
 		security_sb_delete(sb);
 
-		/*
-		 * Now that all potentially-encrypted inodes have been evicted,
-		 * the fscrypt keyring can be destroyed.
-		 */
-		fscrypt_destroy_keyring(sb);
-
 		if (sb->s_dio_done_wq) {
 			destroy_workqueue(sb->s_dio_done_wq);
 			sb->s_dio_done_wq = NULL;
 		}
 
 		if (sop->put_super)
 			sop->put_super(sb);
 
+		/*
+		 * Now that all potentially-encrypted inodes have been evicted,
+		 * the fscrypt keyring can be destroyed.
+		 */
+		fscrypt_destroy_keyring(sb);
+
 		if (CHECK_DATA_CORRUPTION(!list_empty(&sb->s_inodes),
 				"VFS: Busy inodes after unmount of %s (%s)",
 				sb->s_id, sb->s_type->name)) {
 			/*
 			 * Adding a proper bailout path here would be hard, but
 			 * we can at least make it more likely that a later
 			 * iput_final() or such crashes cleanly.
 			 */
 			struct inode *inode;
 
-- 
2.43.0


