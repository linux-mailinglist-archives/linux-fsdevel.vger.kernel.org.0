Return-Path: <linux-fsdevel+bounces-1088-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD0477D5472
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Oct 2023 16:54:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 199F41C20BFC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Oct 2023 14:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A52C2AB40;
	Tue, 24 Oct 2023 14:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kCuVcOd3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AFFD262BC
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Oct 2023 14:54:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 186DAC433C8;
	Tue, 24 Oct 2023 14:54:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698159247;
	bh=oK48GroZC22EkQ8fjvkqVknlzKfiRSSDVRh6FFQNUzY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=kCuVcOd3ak49VOGJC7CVah/QAbtx/qVPuWQEUiAyhuCkn6SFAtU5fzmumBd9L3XSa
	 ljmpCbyWPe3VJc+v411SJl/yyDfzZjwj7e77dgvehyI4guY+Ryfi5WL5LOIdTHthfm
	 1KP2v0eykWDBCITgiCHJCtdd2So/IitVG0671biyoKguu5pxCbf2UJ3ukpD+XpiR/f
	 mtcotp2DlQIv3CLi5UhJfVaZvyrgUz8lRlJEl9DO8ynigkz7Zkrx5W1wW88pvCbWZp
	 FrGhpJ83F5Fgti2Btnuelw7lXuFVMePZ8veV18cDrwYAYIsxU1oaMxZ4YKS7ASQwlQ
	 /nKlmjzK87osQ==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 24 Oct 2023 16:53:40 +0200
Subject: [PATCH RFC 2/6] xfs: simplify device handling
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231024-vfs-super-rework-v1-2-37a8aa697148@kernel.org>
References: <20231024-vfs-super-rework-v1-0-37a8aa697148@kernel.org>
In-Reply-To: <20231024-vfs-super-rework-v1-0-37a8aa697148@kernel.org>
To: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.13-dev-26615
X-Developer-Signature: v=1; a=openpgp-sha256; l=1805; i=brauner@kernel.org;
 h=from:subject:message-id; bh=oK48GroZC22EkQ8fjvkqVknlzKfiRSSDVRh6FFQNUzY=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSa3+oKPCxvs7lNSE0yjrmLmXnXGm+3KZs51NW1xRw+iUnN
 lvrdUcrCIMbFICumyOLQbhIut5ynYrNRpgbMHFYmkCEMXJwCMJEZ/YwMHXG5aUUq4dJGP5hN3l8viT
 6UuO2i2I1iexf1MPXH61RnMvzhXbT02BfejxOyjCZ4XtHbvPWWz6zNNTsrea/JnTyWzxzHAAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

We removed all codepaths where s_umount is taken beneath open_mutex and
bd_holder_lock so don't make things more complicated than they need to
be and hold s_umount over block device opening.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/xfs/xfs_super.c | 19 +++----------------
 1 file changed, 3 insertions(+), 16 deletions(-)

diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index f0ae07828153..84107d162e41 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -437,19 +437,13 @@ xfs_open_devices(
 	struct bdev_handle	*logdev_handle = NULL, *rtdev_handle = NULL;
 	int			error;
 
-	/*
-	 * blkdev_put() can't be called under s_umount, see the comment
-	 * in get_tree_bdev() for more details
-	 */
-	up_write(&sb->s_umount);
-
 	/*
 	 * Open real time and log devices - order is important.
 	 */
 	if (mp->m_logname) {
 		error = xfs_blkdev_get(mp, mp->m_logname, &logdev_handle);
 		if (error)
-			goto out_relock;
+			return error;
 	}
 
 	if (mp->m_rtname) {
@@ -492,10 +486,7 @@ xfs_open_devices(
 			bdev_release(logdev_handle);
 	}
 
-	error = 0;
-out_relock:
-	down_write(&sb->s_umount);
-	return error;
+	return 0;
 
  out_free_rtdev_targ:
 	if (mp->m_rtdev_targp)
@@ -508,7 +499,7 @@ xfs_open_devices(
  out_close_logdev:
 	if (logdev_handle)
 		bdev_release(logdev_handle);
-	goto out_relock;
+	return error;
 }
 
 /*
@@ -758,10 +749,6 @@ static void
 xfs_mount_free(
 	struct xfs_mount	*mp)
 {
-	/*
-	 * Free the buftargs here because blkdev_put needs to be called outside
-	 * of sb->s_umount, which is held around the call to ->put_super.
-	 */
 	if (mp->m_logdev_targp && mp->m_logdev_targp != mp->m_ddev_targp)
 		xfs_free_buftarg(mp->m_logdev_targp);
 	if (mp->m_rtdev_targp)

-- 
2.34.1


