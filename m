Return-Path: <linux-fsdevel+bounces-18566-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9686F8BA5F6
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2024 06:17:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6752B2207B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2024 04:17:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BD622C190;
	Fri,  3 May 2024 04:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="hmCto5di"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7988714F62
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 May 2024 04:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714709864; cv=none; b=O/CWgpAcA4FNql1PE1ejaJDMbwBYrjKsOIclICuvJSozwylsFAQGi5TGt1eqtHZEYEBLTwQ4mgi3PmN6QAvIav8+dWARgKToq2gOXNvVok6SFDKBBgo4sz0nFc/A9GTekkfId3C9KxY/yDrjXphdVeVPyvBoNrat7uWmQZ8YwRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714709864; c=relaxed/simple;
	bh=nwdHSJ9iozj2tXtGX3zISOTD/CRAK2jBWcLjfLEAl/g=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RcV/+i0F5Ppsn2xBPHH8mmrrBNZXpxZFJ+SxA8U3NsiC1YsCEpERArf4VA7hMdECVfAeEObrrh3BJSxuHRX8wtxejDyZ11J3feN4m3AdFItW+RsdD0lsRmEZVLLqGBi2jZeEMC8AUBVJPxYHsqj9ocKy00HsPnFT3FpIc7uHBWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=hmCto5di; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description;
	bh=dhN/ef6KzTW6/TiSYN+7LCG+cbp0sa286GVMcEU5JNg=; b=hmCto5dilqsWlHlw7W3kVYvmvw
	RQ2ntpfQEAD6iso811RaBGAwyPB3hYJWu4eOzD03J7kH5jPtUwDDN05tSQRZ3uuKzlmYsmVVe69Ae
	jOiHC2+Xw66j1xoxSz1MyOY7clhwOFJn7ud7JyJhnC6grWQksRj/k01q6VdCult8S9HbGqGGzj9rh
	qLpkvA/D3O55foTGU+Nub0RBfQVAzzwzj2v9V80MOkAUSnuIIRPrbxsRrbqvIXiXcZ7p6TF1Ws4x8
	fe07KJT/a6R8Oi2X7xOjsX1QZbpk+tTuA8vrkjLJ0b7aY3iiiXCXBYz3NaH1DAx8sdVnoG8eML1TL
	lqXie9Gw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1s2kMe-00A5VJ-2l
	for linux-fsdevel@vger.kernel.org;
	Fri, 03 May 2024 04:17:41 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 4/9] swapon(2): open swap with O_EXCL
Date: Fri,  3 May 2024 05:17:35 +0100
Message-Id: <20240503041740.2404425-4-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240503041740.2404425-1-viro@zeniv.linux.org.uk>
References: <20240503031833.GU2118490@ZenIV>
 <20240503041740.2404425-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

... eliminating the need to reopen block devices so they could be
exclusively held.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Christian Brauner <brauner@kernel.org>
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
index 304f74d039f3..7bba0b0d4924 100644
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
+	swap_file = file_open_name(name, O_RDWR | O_LARGEFILE | O_EXCL, 0);
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


