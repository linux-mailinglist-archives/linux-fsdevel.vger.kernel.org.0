Return-Path: <linux-fsdevel+bounces-1030-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 850357D50F2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Oct 2023 15:06:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2544BB210E5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Oct 2023 13:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3187A2941E;
	Tue, 24 Oct 2023 13:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jIGoq9MI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D0142940B
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Oct 2023 13:06:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA854C433CC;
	Tue, 24 Oct 2023 13:06:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698152776;
	bh=TkCowelFDovyrB2g0BMhnKJEz3rlU5FTsJL2UGhCl5Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=jIGoq9MIC4leT2G63MnFVWZ9loVJbGqYMdnOoW5Uir54hV5cPug3/ys6Mrnlv5szV
	 T2Z/E6aLWIWot4/veBbiMVj6gOyg5oL9FUWdvCe/yYPk1QwVC6HK2EHJ/U7FvSFHE8
	 6Hn2pZN2xlvv0GeWcsE2AfvSv1wYAQEu+1GdF5zWvxT1hA7r+/MjGenrdP0QlUv/VT
	 kWUDLJQL1n/fuzR6lzVsBlh4jkXf5GqPWENhoWHQNuoguQqCbDpYK93GgBvlu6wYnO
	 RCSU+H73rRMX/hR9LVHEYBhul0uA1qJqUyWAOriwAzv7j9ztfCernw3mza0P4cB1VB
	 PWIa6tS6CHysg==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 24 Oct 2023 15:01:09 +0200
Subject: [PATCH v2 03/10] bdev: surface the error from sync_blockdev()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231024-vfs-super-freeze-v2-3-599c19f4faac@kernel.org>
References: <20231024-vfs-super-freeze-v2-0-599c19f4faac@kernel.org>
In-Reply-To: <20231024-vfs-super-freeze-v2-0-599c19f4faac@kernel.org>
To: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>, 
 "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=810; i=brauner@kernel.org;
 h=from:subject:message-id; bh=TkCowelFDovyrB2g0BMhnKJEz3rlU5FTsJL2UGhCl5Y=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSaH3TIeql4u0Klfkd4+ZrE6eazLTfclf6kp75zTijrT74S
 QZMTHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABNZcpbhf4atlnp2w4njAUGvdc3mvA
 s+p1I+IWntnRsPDToVMu7I9DP80/e7n7s/yrSaie1MiCjrxv8Os5pnqWjM2hsgXrM+/NMOHgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

When freeze_super() is called, sync_filesystem() will be called which
calls sync_blockdev() and already surfaces any errors. Do the same for
block devices that aren't owned by a superblock and also for filesystems
that don't call sync_blockdev() internally but implicitly rely on
bdev_freeze() to do it.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 block/bdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/bdev.c b/block/bdev.c
index d674ad381c52..a3e2af580a73 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -245,7 +245,7 @@ int bdev_freeze(struct block_device *bdev)
 	bdev->bd_fsfreeze_sb = sb;
 
 sync:
-	sync_blockdev(bdev);
+	error = sync_blockdev(bdev);
 done:
 	mutex_unlock(&bdev->bd_fsfreeze_mutex);
 	return error;

-- 
2.34.1


