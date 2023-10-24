Return-Path: <linux-fsdevel+bounces-1087-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 293D67D5471
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Oct 2023 16:54:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D37F1281AF7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Oct 2023 14:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67CA830F8E;
	Tue, 24 Oct 2023 14:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lDiecNXE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F3530CFD
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Oct 2023 14:54:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ABB4C433C9;
	Tue, 24 Oct 2023 14:54:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698159245;
	bh=AQzwasHNWU2WpTY1u/tl3X4m5NS461Kg3OnivwaYl00=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=lDiecNXELGvare9RyqWhtE5sJ2qrD5uhnb/CKR+QUxDD0SohuDIUBSUVNjM9kDXkl
	 kg6dx4fSf2zeiFVbrZJ+Sbv2OL7Nh0NSmDyYSPcNV+F1F2wFrGZhSRq7XZ8UW9ZA3h
	 4btFbGOC2kY/SFL/euydTn6rrED/qUFrZcUKz4Vv9Q/6i0M5iZLIzvfnhKXHeoOB+p
	 GpbgKIxJNFNZsAcFT6rMZ1I1tmNZ1fcdMwKvqYtkyTpXL3Aox6UNApiaH5SvY3T9Qt
	 AvT2SlmQVm0qrJ0sQNG5RvYPHrf+wjXTl8m3SyTA9ZbMm9KwV0w1Y1ijds+n8OhHrH
	 /H/hxTNf0D7ZA==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 24 Oct 2023 16:53:39 +0200
Subject: [PATCH RFC 1/6] fs: simplify setup_bdev_super() calls
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231024-vfs-super-rework-v1-1-37a8aa697148@kernel.org>
References: <20231024-vfs-super-rework-v1-0-37a8aa697148@kernel.org>
In-Reply-To: <20231024-vfs-super-rework-v1-0-37a8aa697148@kernel.org>
To: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.13-dev-26615
X-Developer-Signature: v=1; a=openpgp-sha256; l=1496; i=brauner@kernel.org;
 h=from:subject:message-id; bh=AQzwasHNWU2WpTY1u/tl3X4m5NS461Kg3OnivwaYl00=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSa3+qafnBq+OGJP42ZlBQtmV/6rMldVp5zY+fdij9rvpSc
 8Dm0vKOUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAiUTsZ/pfe9Pmn/XqSm4DulIdbc2
 vrbNI+HD4bLNl4O/bLGf/ULU8ZGRbxMnbmTq2x2cK4UN7OfNKxnquWAlYiBicVH5nPPzSFjwcA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

There's no need to drop s_umount anymore now that we removed all sources
where s_umount is taken beneath open_mutex or bd_holder_lock.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/super.c | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/fs/super.c b/fs/super.c
index b26b302f870d..4edde92d5e8f 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -1613,15 +1613,7 @@ int get_tree_bdev(struct fs_context *fc,
 			return -EBUSY;
 		}
 	} else {
-		/*
-		 * We drop s_umount here because we need to open the bdev and
-		 * bdev->open_mutex ranks above s_umount (blkdev_put() ->
-		 * bdev_mark_dead()). It is safe because we have active sb
-		 * reference and SB_BORN is not set yet.
-		 */
-		super_unlock_excl(s);
 		error = setup_bdev_super(s, fc->sb_flags, fc);
-		__super_lock_excl(s);
 		if (!error)
 			error = fill_super(s, fc);
 		if (error) {
@@ -1665,15 +1657,7 @@ struct dentry *mount_bdev(struct file_system_type *fs_type,
 			return ERR_PTR(-EBUSY);
 		}
 	} else {
-		/*
-		 * We drop s_umount here because we need to open the bdev and
-		 * bdev->open_mutex ranks above s_umount (blkdev_put() ->
-		 * bdev_mark_dead()). It is safe because we have active sb
-		 * reference and SB_BORN is not set yet.
-		 */
-		super_unlock_excl(s);
 		error = setup_bdev_super(s, flags, NULL);
-		__super_lock_excl(s);
 		if (!error)
 			error = fill_super(s, data, flags & SB_SILENT ? 1 : 0);
 		if (error) {

-- 
2.34.1


