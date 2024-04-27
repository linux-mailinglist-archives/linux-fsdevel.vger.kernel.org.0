Return-Path: <linux-fsdevel+bounces-17981-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 52B298B483C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Apr 2024 23:11:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8596CB21CBD
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Apr 2024 21:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B568145B37;
	Sat, 27 Apr 2024 21:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="nVWT2uoE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC483A8EF;
	Sat, 27 Apr 2024 21:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714252292; cv=none; b=frOhVcy6qbW973+NBWgmT7Ka6DGLnKncmxYbJLeb8mIcnMFX24rphkM9O+vVezUCUtYTlEdiojbw5ee9mY3M+FTyCgS6QzgJ5QVrIIRNECFuWMCqXi6ShwxCKG+Et35sqrJ2j2ejxZ/1oMO9N3+LQUpLnoyKD2GS86WTEMJNe1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714252292; c=relaxed/simple;
	bh=Dq5f+ejUETiFzRlLl7Y5xg/5QsFIWYNnilGxhCvIZK0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mIw46uT8WwPSZhoH+ptsIX7vcgdwwc3zly1AD0KpoC2ngF3uOF18FD0gU/KGZe2w+Acrw3rdLV+4t2BuGA9GG51nULZ7u/jZdaFRbOUAfcy+9o81W0V9hNAYe0gH8j+6iNiPerimOR1s2UjTRcV8rPU08dJ39zZheNWF0dGNa6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=nVWT2uoE; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=vtUeEAm40my/mX+7c/W6sObNsUyFrfkBXLiOVdV8j6c=; b=nVWT2uoExcrdvF43eehWNT4Dds
	//4aNiCI8Pa5L9TLDC+kVmTqqZ5j8JTSD07b78/XIqveealmG2PTwT3eNRLq7iB7Dex14fnJFKXSc
	FmPsZ18sKMoqZjEGUAyNKoTwDlaEV/4cIc58pV+rGwpvl3y4eLZZoruIMZAJHErm6bkLKAhhszlMh
	X3dgTy+BQlB6otIRhsXFt1RdTEOzRaVwkjr2pvgt9JtiQ6kvrRxPKNB7QrO8PXEhS2xPGHTRifZDt
	F6ZpBL+FJY5+f499oKaa4NkDLpblohAKJC+SnGn3cUxmLS9oklO4nFj+4tYDLH3MVkTABr2IB6+Zk
	W/GANHHw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1s0pKS-006H66-0m;
	Sat, 27 Apr 2024 21:11:28 +0000
Date: Sat, 27 Apr 2024 22:11:28 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>, linux-btrfs@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 4/7] swapon(2): open swap with O_EXCL
Message-ID: <20240427211128.GD1495312@ZenIV>
References: <20240427210920.GR2118490@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240427210920.GR2118490@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

... eliminating the need to reopen block devices so they could be
exclusively held.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 include/linux/swap.h |  1 -
 mm/swapfile.c        | 19 ++-----------------
 2 files changed, 2 insertions(+), 18 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index a5b640cca459..7e61a4aef2fc 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -298,7 +298,6 @@ struct swap_info_struct {
 	unsigned int __percpu *cluster_next_cpu; /*percpu index for next allocation */
 	struct percpu_cluster __percpu *percpu_cluster; /* per cpu's swap location */
 	struct rb_root swap_extent_root;/* root of the swap extent rbtree */
-	struct file *bdev_file;		/* open handle of the bdev */
 	struct block_device *bdev;	/* swap device or bdev of swap file */
 	struct file *swap_file;		/* seldom referenced */
 	struct completion comp;		/* seldom referenced */
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 304f74d039f3..71cb76a2d0ce 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -2550,10 +2550,6 @@ SYSCALL_DEFINE1(swapoff, const char __user *, specialfile)
 	exit_swap_address_space(p->type);
 
 	inode = mapping->host;
-	if (p->bdev_file) {
-		fput(p->bdev_file);
-		p->bdev_file = NULL;
-	}
 
 	inode_lock(inode);
 	inode->i_flags &= ~S_SWAPFILE;
@@ -2780,14 +2776,7 @@ static struct swap_info_struct *alloc_swap_info(void)
 static int claim_swapfile(struct swap_info_struct *p, struct inode *inode)
 {
 	if (S_ISBLK(inode->i_mode)) {
-		p->bdev_file = bdev_file_open_by_dev(inode->i_rdev,
-				BLK_OPEN_READ | BLK_OPEN_WRITE, p, NULL);
-		if (IS_ERR(p->bdev_file)) {
-			int error = PTR_ERR(p->bdev_file);
-			p->bdev_file = NULL;
-			return error;
-		}
-		p->bdev = file_bdev(p->bdev_file);
+		p->bdev = I_BDEV(inode);
 		/*
 		 * Zoned block devices contain zones that have a sequential
 		 * write only restriction.  Hence zoned block devices are not
@@ -3028,7 +3017,7 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
 		name = NULL;
 		goto bad_swap;
 	}
-	swap_file = file_open_name(name, O_RDWR|O_LARGEFILE, 0);
+	swap_file = file_open_name(name, O_RDWR|O_LARGEFILE|O_EXCL, 0);
 	if (IS_ERR(swap_file)) {
 		error = PTR_ERR(swap_file);
 		swap_file = NULL;
@@ -3225,10 +3214,6 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
 	p->percpu_cluster = NULL;
 	free_percpu(p->cluster_next_cpu);
 	p->cluster_next_cpu = NULL;
-	if (p->bdev_file) {
-		fput(p->bdev_file);
-		p->bdev_file = NULL;
-	}
 	inode = NULL;
 	destroy_swap_extents(p);
 	swap_cgroup_swapoff(p->type);
-- 
2.39.2


