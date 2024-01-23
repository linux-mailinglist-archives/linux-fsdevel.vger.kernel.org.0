Return-Path: <linux-fsdevel+bounces-8550-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAFFD838FEF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 14:30:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4C7D290109
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 13:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ACBB60276;
	Tue, 23 Jan 2024 13:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i/OoeQlw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A4460254;
	Tue, 23 Jan 2024 13:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706016431; cv=none; b=neorCjnmxwUfAG8QIPWLSyAmf7l3Lghf/lNT1Q4T/QnsML9YAPZKt1lebD+v95LwOHS5LTdtFisuRodMUOc0rGbEmhoz1/Rb8KUAKbeqpf+enU+QCw0gmuZmZxDfMQlDpWri4QuuOa+pPJILFerN4KbkCMPoggQkk/YyWavzwFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706016431; c=relaxed/simple;
	bh=NFbPYHPNmlG8/Z6xYpsACGNBIvY+R3g43A2DVsavXK4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GSAVV959oEZOvjikkJGxpWcbka+zVDIx9ocfuuob2K37GIxLuebL/UtrpqYVrDIXL6XWurC0zQwnBOz7vhiUCoh+3omTfRYFMPs1+9zSjIStUJ0M3vjbM7n7QKu6wZ0frnzH+8tXqPFfwPOTFYFxxE/lXr911cI6IzYtgRxKA4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i/OoeQlw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCDD0C4166A;
	Tue, 23 Jan 2024 13:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706016431;
	bh=NFbPYHPNmlG8/Z6xYpsACGNBIvY+R3g43A2DVsavXK4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=i/OoeQlw2jLPt3zPWarM4TucRgID7UK+SCIuaG3eSSdlFf00jh/XdwDE31MkmBwH7
	 JeZ4S7+0lEXQ2PynTEpc5uZabu0B4uS1igWNpoZ3P3Zzpw5GbEDB7LFbNDYYVkhNXq
	 ekfGf7sTXhSl2AYGI9TT/WVXRYTyKhv+nuc1Z8R9AACNhX2eSGqXDMtszRJ5+dSoUM
	 mieZSgAo1dSeANHRFzyixX3QRqU/lPXqTDk1zISTRazD5xi3hGGibJcDVv3KJq1HHJ
	 nWUzCpGTgqC/1UE2FMjikeL5W+ahF+l7JVBEac8EDd/jsFthACfTM1C+RGM5hGViCR
	 79PlibHHmmTxQ==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 23 Jan 2024 14:26:22 +0100
Subject: [PATCH v2 05/34] swap: port block device usage to file
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240123-vfs-bdev-file-v2-5-adbd023e19cc@kernel.org>
References: <20240123-vfs-bdev-file-v2-0-adbd023e19cc@kernel.org>
In-Reply-To: <20240123-vfs-bdev-file-v2-0-adbd023e19cc@kernel.org>
To: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>, 
 Jens Axboe <axboe@kernel.dk>
Cc: "Darrick J. Wong" <djwong@kernel.org>, linux-fsdevel@vger.kernel.org, 
 linux-block@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.13-dev-4e032
X-Developer-Signature: v=1; a=openpgp-sha256; l=2622; i=brauner@kernel.org;
 h=from:subject:message-id; bh=NFbPYHPNmlG8/Z6xYpsACGNBIvY+R3g43A2DVsavXK4=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSu3zcv+czNi33dMoUPO+f8rD54/WZitOxsv+AHPB5Pc
 h5/2JB7rKOUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BeAmMzL8T7f5UFgVfihnjqHB
 8ntxbUlf7JKCt2/cq7PncEX66nUrdjH8s0mrZeNNr3xdu+TlEZnpx1/+mvDnERO72foygyUcQqv
 PswMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 include/linux/swap.h |  2 +-
 mm/swapfile.c        | 22 +++++++++++-----------
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index 4db00ddad261..e5b82bc05e60 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -298,7 +298,7 @@ struct swap_info_struct {
 	unsigned int __percpu *cluster_next_cpu; /*percpu index for next allocation */
 	struct percpu_cluster __percpu *percpu_cluster; /* per cpu's swap location */
 	struct rb_root swap_extent_root;/* root of the swap extent rbtree */
-	struct bdev_handle *bdev_handle;/* open handle of the bdev */
+	struct file *bdev_file;		/* open handle of the bdev */
 	struct block_device *bdev;	/* swap device or bdev of swap file */
 	struct file *swap_file;		/* seldom referenced */
 	unsigned int old_block_size;	/* seldom referenced */
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 556ff7347d5f..73edd6fed6a2 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -2532,10 +2532,10 @@ SYSCALL_DEFINE1(swapoff, const char __user *, specialfile)
 	exit_swap_address_space(p->type);
 
 	inode = mapping->host;
-	if (p->bdev_handle) {
+	if (p->bdev_file) {
 		set_blocksize(p->bdev, old_block_size);
-		bdev_release(p->bdev_handle);
-		p->bdev_handle = NULL;
+		fput(p->bdev_file);
+		p->bdev_file = NULL;
 	}
 
 	inode_lock(inode);
@@ -2765,14 +2765,14 @@ static int claim_swapfile(struct swap_info_struct *p, struct inode *inode)
 	int error;
 
 	if (S_ISBLK(inode->i_mode)) {
-		p->bdev_handle = bdev_open_by_dev(inode->i_rdev,
+		p->bdev_file = bdev_file_open_by_dev(inode->i_rdev,
 				BLK_OPEN_READ | BLK_OPEN_WRITE, p, NULL);
-		if (IS_ERR(p->bdev_handle)) {
-			error = PTR_ERR(p->bdev_handle);
-			p->bdev_handle = NULL;
+		if (IS_ERR(p->bdev_file)) {
+			error = PTR_ERR(p->bdev_file);
+			p->bdev_file = NULL;
 			return error;
 		}
-		p->bdev = p->bdev_handle->bdev;
+		p->bdev = file_bdev(p->bdev_file);
 		p->old_block_size = block_size(p->bdev);
 		error = set_blocksize(p->bdev, PAGE_SIZE);
 		if (error < 0)
@@ -3208,10 +3208,10 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
 	p->percpu_cluster = NULL;
 	free_percpu(p->cluster_next_cpu);
 	p->cluster_next_cpu = NULL;
-	if (p->bdev_handle) {
+	if (p->bdev_file) {
 		set_blocksize(p->bdev, p->old_block_size);
-		bdev_release(p->bdev_handle);
-		p->bdev_handle = NULL;
+		fput(p->bdev_file);
+		p->bdev_file = NULL;
 	}
 	inode = NULL;
 	destroy_swap_extents(p);

-- 
2.43.0


