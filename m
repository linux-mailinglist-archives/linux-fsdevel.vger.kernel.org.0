Return-Path: <linux-fsdevel+bounces-28038-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 469E3966297
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2024 15:08:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 797671C23871
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2024 13:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35BD31B3B38;
	Fri, 30 Aug 2024 13:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TQbzrUyg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 998391AF4F9
	for <linux-fsdevel@vger.kernel.org>; Fri, 30 Aug 2024 13:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725023179; cv=none; b=S3BVXQwMXxMYyLkd8XDv5xKTyGuyQI0F8iYOSk1d+vl67UEcjl3oh67fr3PmGuKRmr2mIl7m4XktcgoZHsp9grj+LHFSyj6G2GhgLjnlZquz7VV0j7xyOmX3c8P+/y0dRye9WJ8WkYqAVfJSCLvU49knKKZWecHAfSb4PI8ALPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725023179; c=relaxed/simple;
	bh=7XWXiqTJI/Pb166wlRFa5S7205u4Kt0D94PluQkdy00=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YUcukxYdhrMOqiybo37U80o3gyLQob8ZpF2TZZlZCC9ockmvGi5IhfRr6+oiH7TDwTz6EE246pWcVwt9bxtRlCZsu4QpCCciYoTQFOC8uv5rLAWC9vBqlYlUwvJWpAxhMlU+Ci6JFgTEbJ7MMb6SttEmrQ9KRphcAg7Dpg+96aA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TQbzrUyg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72B12C4CEC9;
	Fri, 30 Aug 2024 13:06:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725023179;
	bh=7XWXiqTJI/Pb166wlRFa5S7205u4Kt0D94PluQkdy00=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=TQbzrUygvfJwyANPWQawPmIE/nPVYNZEP2oZzyt15Uuze1PWlVMT80oVq4hi+xChR
	 BheEgcxDVGFS7pt2BwnpQ/t6GhnAQo9zT78m4Uo8MRDe8GrLuES+Cc9ST7zSDf5hdv
	 k+A/qZR0SbIDFjHcXKkcB9f+Wkz+3G1srmm3nBGPwqtcI0e+kAEG6m6r5H9jxKyFI8
	 pHNcNfQuW1phh+MWc3c3sp2EwCdd5I8LYjh5pc2WcTt+zaISxFuKlKumRREp4cWMK8
	 pmwG/Aleb1E5BInYvN2SGdPiUe+YwA3wUB86h0ik12xf6UtHtAeN1Lr2xgPcX2I1TX
	 4exPsntr1Fuqw==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 30 Aug 2024 15:04:57 +0200
Subject: [PATCH RFC 16/20] ufs: store cookie in private data
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240830-vfs-file-f_version-v1-16-6d3e4816aa7b@kernel.org>
References: <20240830-vfs-file-f_version-v1-0-6d3e4816aa7b@kernel.org>
In-Reply-To: <20240830-vfs-file-f_version-v1-0-6d3e4816aa7b@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Jan Kara <jack@suse.com>, Al Viro <viro@zeniv.linux.org.uk>, 
 Jeff Layton <jlayton@kernel.org>, Josef Bacik <josef@toxicpanda.com>, 
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@infradead.org>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-37811
X-Developer-Signature: v=1; a=openpgp-sha256; l=2081; i=brauner@kernel.org;
 h=from:subject:message-id; bh=7XWXiqTJI/Pb166wlRFa5S7205u4Kt0D94PluQkdy00=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRdPDx3jZVu4GePr4VX5wtXPAxUlz0lJGwT5l145Fpbw
 A+nrVUvOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACZyg5eR4aGCSYLNruuLygO1
 ljP8ff0m+vwX5kdq7laZ5g62kr96VjH84VDZ4j/32QOTt3u/rXzZ/mu2jcjNf3Fr2ORab8/K4c+
 fyQkA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Store the cookie to detect concurrent seeks on directories in
file->private_data.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/ufs/dir.c | 28 +++++++++++++++++++++++++---
 1 file changed, 25 insertions(+), 3 deletions(-)

diff --git a/fs/ufs/dir.c b/fs/ufs/dir.c
index 61f25d3cf3f7..335f0ae529b4 100644
--- a/fs/ufs/dir.c
+++ b/fs/ufs/dir.c
@@ -435,7 +435,7 @@ ufs_readdir(struct file *file, struct dir_context *ctx)
 	unsigned long n = pos >> PAGE_SHIFT;
 	unsigned long npages = dir_pages(inode);
 	unsigned chunk_mask = ~(UFS_SB(sb)->s_uspi->s_dirblksize - 1);
-	bool need_revalidate = !inode_eq_iversion(inode, file->f_version);
+	bool need_revalidate = !inode_eq_iversion(inode, *(u64 *)file->private_data);
 	unsigned flags = UFS_SB(sb)->s_flags;
 
 	UFSD("BEGIN\n");
@@ -462,7 +462,7 @@ ufs_readdir(struct file *file, struct dir_context *ctx)
 				offset = ufs_validate_entry(sb, kaddr, offset, chunk_mask);
 				ctx->pos = (n<<PAGE_SHIFT) + offset;
 			}
-			file->f_version = inode_query_iversion(inode);
+			*(u64 *)file->private_data = inode_query_iversion(inode);
 			need_revalidate = false;
 		}
 		de = (struct ufs_dir_entry *)(kaddr+offset);
@@ -646,9 +646,31 @@ int ufs_empty_dir(struct inode * inode)
 	return 0;
 }
 
+static int ufs_dir_open(struct inode *inode, struct file *file)
+{
+	file->private_data = kzalloc(sizeof(u64), GFP_KERNEL);
+	if (!file->private_data)
+		return -ENOMEM;
+	return 0;
+}
+
+static int ufs_dir_release(struct inode *inode, struct file *file)
+{
+	kfree(file->private_data);
+	return 0;
+}
+
+static loff_t ufs_dir_llseek(struct file *file, loff_t offset, int whence)
+{
+	return generic_llseek_cookie(file, offset, whence,
+				     (u64 *)file->private_data);
+}
+
 const struct file_operations ufs_dir_operations = {
+	.open		= ufs_dir_open,
+	.release	= ufs_dir_release,
 	.read		= generic_read_dir,
 	.iterate_shared	= ufs_readdir,
 	.fsync		= generic_file_fsync,
-	.llseek		= generic_file_llseek,
+	.llseek		= ufs_dir_llseek,
 };

-- 
2.45.2


