Return-Path: <linux-fsdevel+bounces-28037-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F222966296
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2024 15:08:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 728EB1C23CD6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2024 13:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EB921B3B32;
	Fri, 30 Aug 2024 13:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mslo6IBu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 712D51AF4F9
	for <linux-fsdevel@vger.kernel.org>; Fri, 30 Aug 2024 13:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725023177; cv=none; b=fuDdksKaR/OiPA7XCMcM3hJ1nHHQCOWu0Z8LPxpthT5ML3kmTOHoY/Sv2nrqYXKwmLqTHN6zPJnEOR+PLK3mZd/kI2BLT36EgAdp4JPxS2jHelvB5/MSykqnnY4pnCBBWLocD+pn9bc3utd+HifCzwrW7oT4ftaPMZM6f6PICiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725023177; c=relaxed/simple;
	bh=KNRyxwtoBb565wjzV065TxRfaksQi1n5rMvPeXlpGmA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dOI+xQ3o+IDZEUz6lNCoHyF/my2lvSGOENn/VAihuz01opz6vkFtlEB3f1+N/uQyhYPw7KdIZu+tZNlc38JAplLY8u0ZpUg5tjb+jSHyVFbckriKJ0Hd6H+UJWZ+umER126crMzY2Ea/8Q6msTXiUNqe/lynZrQ1m8/Hf8nETbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mslo6IBu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35519C4CEC2;
	Fri, 30 Aug 2024 13:06:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725023177;
	bh=KNRyxwtoBb565wjzV065TxRfaksQi1n5rMvPeXlpGmA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Mslo6IBuqw1mzzifXJt2ZTUkWkC3MuX6GKPuDmj09JPMxtq0Nqaywx5lAq5LIRhk1
	 Wdyho34a2GwVraYbKulhMfLoW10iu/uGDpq/2ftExzl8z+rKyKwrDF0Nyk8vKIrMwM
	 tYokzTRK/s36HiwPH37ftA6fIyh3gvHYZ3wceMH8EU+8HOu7ZIjI9jB1t5alJs0KJw
	 3wHqY2o9eQrH8ogvhMnj7IOUxU0F5ZauOUdn5Y8vVR9fsJ5jZRGI5Vr70Ug6q215gI
	 rZvB1e4bRPiBjKjFgzNIuGMUmeea8t66Szb0fhaUPVpD2lF90+iZ0ZUI+8zb4a+TRZ
	 G2rHNMMi2p4Fg==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 30 Aug 2024 15:04:56 +0200
Subject: [PATCH RFC 15/20] udf: store cookie in private data
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240830-vfs-file-f_version-v1-15-6d3e4816aa7b@kernel.org>
References: <20240830-vfs-file-f_version-v1-0-6d3e4816aa7b@kernel.org>
In-Reply-To: <20240830-vfs-file-f_version-v1-0-6d3e4816aa7b@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Jan Kara <jack@suse.com>, Al Viro <viro@zeniv.linux.org.uk>, 
 Jeff Layton <jlayton@kernel.org>, Josef Bacik <josef@toxicpanda.com>, 
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@infradead.org>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-37811
X-Developer-Signature: v=1; a=openpgp-sha256; l=1884; i=brauner@kernel.org;
 h=from:subject:message-id; bh=KNRyxwtoBb565wjzV065TxRfaksQi1n5rMvPeXlpGmA=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRdPDx3xu3jnXp83OuFn7DmJh+wZYgI7/JleDnpioHHP
 LUmOTHOjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIms3svIcP78d76ksznX533v
 ndo2a9srzo+LngiyzNMymHPk6fdgBgFGhrU/nzLzxRWlpN+atVl1Sgv3P9ZLxXNL4g78Yp1yUEH
 Fmh8A
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Store the cookie to detect concurrent seeks on directories in
file->private_data.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/udf/dir.c | 28 +++++++++++++++++++++++++---
 1 file changed, 25 insertions(+), 3 deletions(-)

diff --git a/fs/udf/dir.c b/fs/udf/dir.c
index f94f45fe2c91..5023dfe191e8 100644
--- a/fs/udf/dir.c
+++ b/fs/udf/dir.c
@@ -60,7 +60,7 @@ static int udf_readdir(struct file *file, struct dir_context *ctx)
 	 * identifying beginning of dir entry (names are under user control),
 	 * we need to scan the directory from the beginning.
 	 */
-	if (!inode_eq_iversion(dir, file->f_version)) {
+	if (!inode_eq_iversion(dir, *(u64 *)file->private_data)) {
 		emit_pos = nf_pos;
 		nf_pos = 0;
 	} else {
@@ -122,15 +122,37 @@ static int udf_readdir(struct file *file, struct dir_context *ctx)
 	udf_fiiter_release(&iter);
 out:
 	if (pos_valid)
-		file->f_version = inode_query_iversion(dir);
+		*(u64 *)file->private_data = inode_query_iversion(dir);
 	kfree(fname);
 
 	return ret;
 }
 
+static int udf_dir_open(struct inode *inode, struct file *file)
+{
+	file->private_data = kzalloc(sizeof(u64), GFP_KERNEL);
+	if (!file->private_data)
+		return -ENOMEM;
+	return 0;
+}
+
+static int udf_dir_release(struct inode *inode, struct file *file)
+{
+	kfree(file->private_data);
+	return 0;
+}
+
+static loff_t udf_dir_llseek(struct file *file, loff_t offset, int whence)
+{
+	return generic_llseek_cookie(file, offset, whence,
+				     (u64 *)file->private_data);
+}
+
 /* readdir and lookup functions */
 const struct file_operations udf_dir_operations = {
-	.llseek			= generic_file_llseek,
+	.open			= udf_dir_open,
+	.release		= udf_dir_release,
+	.llseek			= udf_dir_llseek,
 	.read			= generic_read_dir,
 	.iterate_shared		= udf_readdir,
 	.unlocked_ioctl		= udf_ioctl,

-- 
2.45.2


