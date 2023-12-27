Return-Path: <linux-fsdevel+bounces-6968-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A66E81F0D0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Dec 2023 18:17:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 153D8283623
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Dec 2023 17:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73D2F46B87;
	Wed, 27 Dec 2023 17:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="umWhZju6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBDF44654B;
	Wed, 27 Dec 2023 17:17:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1888C433C8;
	Wed, 27 Dec 2023 17:17:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703697445;
	bh=oMd6cyuWC44jmJeHw6DO++liI/GMxog3sPxf3VWV6yo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=umWhZju6J+3h2OeKVr6EpIyoI+lVYboEc5FBxoXG4nRMbDK2you3mgrHLbSLEGqEx
	 v5TJbAoOB5GsKdKsAs40VXE5LeOGcMqaY4qKOCUUQQXPYU53vBXrmAbHxJVCG0adZN
	 DL9T3H0YrsbhOTJlEH56Ew8WYkw2bRJ75TVcAE3g3Ljsl78Qw5Fw2cytlDEG8ycd/3
	 1TnhDrSuooc04NdQ1UDs3PcJplG97mdxu2/g13mI7dmJDf3wnUMK1ajm192QvtSYeb
	 LeQ2eCmipmcpzmW268aLMreocA1PWHKf2x0I8TvjMuEs9tL1jusH1flupng/oa8eer
	 nHSPVZLe7Y2Hg==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-fscrypt@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	Josef Bacik <josef@toxicpanda.com>,
	Christoph Hellwig <hch@lst.de>,
	Neal Gompa <neal@gompa.dev>
Subject: [PATCH v2 2/2] fs: move fscrypt keyring destruction to after ->put_super
Date: Wed, 27 Dec 2023 11:14:29 -0600
Message-ID: <20231227171429.9223-3-ebiggers@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231227171429.9223-1-ebiggers@kernel.org>
References: <20231227171429.9223-1-ebiggers@kernel.org>
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
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Neal Gompa <neal@gompa.dev>
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


