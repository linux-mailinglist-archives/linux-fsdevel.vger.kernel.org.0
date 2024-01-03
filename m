Return-Path: <linux-fsdevel+bounces-7186-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3B5E822DA2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 13:56:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26F882834EF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 12:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A78B619BB1;
	Wed,  3 Jan 2024 12:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GdbpF7Mq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15AC5199D5;
	Wed,  3 Jan 2024 12:55:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FEA8C433C9;
	Wed,  3 Jan 2024 12:55:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704286538;
	bh=nuaXhZGdEQBqmp82NwU4XEExLM7A9/tXXoYdDuIdD3I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=GdbpF7MqcjlVDe5Xfgvlkb4GGX72GjhOgb7rZNinWk2dK0jXy7uKWEm1ap35vxTb4
	 QKIbwcmSAqhBSh1U8HvJf2PBAKhQkQfDC7gdT7tNzzpwAfSvrwVQ8WMlbeBQ85HF99
	 X2SbOjEerPHalsFjaHzQkNayVwbfD7at6Rpf7WEPaVkQWTe50kO4NtBdcNPi77pztp
	 opZDuNgkN2x0O3ttP32MUT3KBiYqVAM4pbJWQLA1xq8acFkbq1Ace4HJfoMSpVPeSu
	 pcpe4BRGMsE1viKDmRuqo1ASq+rGLzlppnROLW8gcCZ7kOPB44qO9JV1bCfG9iAYDj
	 mrnR/gGpFdEgQ==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 03 Jan 2024 13:55:03 +0100
Subject: [PATCH RFC 05/34] swap: port block device usage to file
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240103-vfs-bdev-file-v1-5-6c8ee55fb6ef@kernel.org>
References: <20240103-vfs-bdev-file-v1-0-6c8ee55fb6ef@kernel.org>
In-Reply-To: <20240103-vfs-bdev-file-v1-0-6c8ee55fb6ef@kernel.org>
To: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>, 
 Jens Axboe <axboe@kernel.dk>
Cc: "Darrick J. Wong" <djwong@kernel.org>, linux-fsdevel@vger.kernel.org, 
 linux-block@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.13-dev-4e032
X-Developer-Signature: v=1; a=openpgp-sha256; l=2583; i=brauner@kernel.org;
 h=from:subject:message-id; bh=nuaXhZGdEQBqmp82NwU4XEExLM7A9/tXXoYdDuIdD3I=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaROjbT+MVcvTdZY5vLR8g+xK33mM7x1M7t65enqdYFbJ
 wb+swm43VHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCR098YGVasFt5jdyXCdvLs
 ivMHWu/f+sunfjxU8vuNfSc4e5fPduZi+F/s47udZWl7oIzDztgft7b0s2zdWfLx2wOm5/IxxlG
 3HnEAAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 include/linux/swap.h |  2 +-
 mm/swapfile.c        | 22 +++++++++++-----------
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index f6dd6575b905..1c1114867637 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -298,7 +298,7 @@ struct swap_info_struct {
 	unsigned int __percpu *cluster_next_cpu; /*percpu index for next allocation */
 	struct percpu_cluster __percpu *percpu_cluster; /* per cpu's swap location */
 	struct rb_root swap_extent_root;/* root of the swap extent rbtree */
-	struct bdev_handle *bdev_handle;/* open handle of the bdev */
+	struct file *f_bdev;		/* open handle of the bdev */
 	struct block_device *bdev;	/* swap device or bdev of swap file */
 	struct file *swap_file;		/* seldom referenced */
 	unsigned int old_block_size;	/* seldom referenced */
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 4bc70f459164..3b2ac701815b 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -2530,10 +2530,10 @@ SYSCALL_DEFINE1(swapoff, const char __user *, specialfile)
 	exit_swap_address_space(p->type);
 
 	inode = mapping->host;
-	if (p->bdev_handle) {
+	if (p->f_bdev) {
 		set_blocksize(p->bdev, old_block_size);
-		bdev_release(p->bdev_handle);
-		p->bdev_handle = NULL;
+		fput(p->f_bdev);
+		p->f_bdev = NULL;
 	}
 
 	inode_lock(inode);
@@ -2763,14 +2763,14 @@ static int claim_swapfile(struct swap_info_struct *p, struct inode *inode)
 	int error;
 
 	if (S_ISBLK(inode->i_mode)) {
-		p->bdev_handle = bdev_open_by_dev(inode->i_rdev,
+		p->f_bdev = bdev_file_open_by_dev(inode->i_rdev,
 				BLK_OPEN_READ | BLK_OPEN_WRITE, p, NULL);
-		if (IS_ERR(p->bdev_handle)) {
-			error = PTR_ERR(p->bdev_handle);
-			p->bdev_handle = NULL;
+		if (IS_ERR(p->f_bdev)) {
+			error = PTR_ERR(p->f_bdev);
+			p->f_bdev = NULL;
 			return error;
 		}
-		p->bdev = p->bdev_handle->bdev;
+		p->bdev = F_BDEV(p->f_bdev);
 		p->old_block_size = block_size(p->bdev);
 		error = set_blocksize(p->bdev, PAGE_SIZE);
 		if (error < 0)
@@ -3206,10 +3206,10 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
 	p->percpu_cluster = NULL;
 	free_percpu(p->cluster_next_cpu);
 	p->cluster_next_cpu = NULL;
-	if (p->bdev_handle) {
+	if (p->f_bdev) {
 		set_blocksize(p->bdev, p->old_block_size);
-		bdev_release(p->bdev_handle);
-		p->bdev_handle = NULL;
+		fput(p->f_bdev);
+		p->f_bdev = NULL;
 	}
 	inode = NULL;
 	destroy_swap_extents(p);

-- 
2.42.0


