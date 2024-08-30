Return-Path: <linux-fsdevel+bounces-28032-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3C91966290
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2024 15:07:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D51BA1C24212
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2024 13:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1EFB1B2EC2;
	Fri, 30 Aug 2024 13:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Todo69nV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E01D1B252D
	for <linux-fsdevel@vger.kernel.org>; Fri, 30 Aug 2024 13:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725023164; cv=none; b=vGV3djyKE5vlCO3SbPJ6Ov0sNu6CwEdFOQZhRhTyLGAX7QGTvgrD+4BihG8FmlWKe0tlbLdG1EMO8clMa/MSR5N3n+LOgE+9Jg3BNUZpplIBQr85YRtpcamjPYVJlYCrNLqIFHpnLO1XLRA0aaPNKm6pxrUXh+k3Ocp3AfMahMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725023164; c=relaxed/simple;
	bh=5TFStna3v+h2JmpsNdxCOVxrFroUUfHd5AjYd1lMZUM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qcGVPAdCnGfCNRFCLicElBQL/E9TlNAaZ9RQ5zLccSdYnrCtjlTuBa+81ilDUYL/y+x5asY7np474Kx5iJxs4WYviLOcPGf4LoDlD/hvlNS0BwtF6F6wH/7Mu4dUrDIV79NaKy+Ogzi1gzNf0bMXdDGvbaexxr7gTKAeY8PqmgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Todo69nV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5721FC4CEC9;
	Fri, 30 Aug 2024 13:06:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725023163;
	bh=5TFStna3v+h2JmpsNdxCOVxrFroUUfHd5AjYd1lMZUM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Todo69nV/8Fjxx78J79JW57tj3R84PGYCiLC7H4lOpogF/l6DCSSWRsIbAOp2F4US
	 CgErVN6dbcv7v4EAqskbtzgGdU2kVniX0xSk6ZjquEhxCaIeLRKcoz4HlZuhaBV1Cy
	 zBW6YuywNMIhnHhSUtC0p8RmREZrAywdFyv/VzEFW+J3nqz8fZFufsLKZV1Ds3TyGu
	 aWk8yU9XoSxTqjeU2YnHw4zdvFAshxtHQ1lgdiNeh2pG7r2olZTzkCinaEU7merIAC
	 3KMG9nW6Y+afZQv/9YJuBgjxTYgqxqJoU3g3aYISpW6Y74Th8tIYGwKs1yb2wOtxZC
	 LAP7I+8KpTWVA==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 30 Aug 2024 15:04:51 +0200
Subject: [PATCH RFC 10/20] ext2: store cookie in private data
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240830-vfs-file-f_version-v1-10-6d3e4816aa7b@kernel.org>
References: <20240830-vfs-file-f_version-v1-0-6d3e4816aa7b@kernel.org>
In-Reply-To: <20240830-vfs-file-f_version-v1-0-6d3e4816aa7b@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Jan Kara <jack@suse.com>, Al Viro <viro@zeniv.linux.org.uk>, 
 Jeff Layton <jlayton@kernel.org>, Josef Bacik <josef@toxicpanda.com>, 
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@infradead.org>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-37811
X-Developer-Signature: v=1; a=openpgp-sha256; l=2078; i=brauner@kernel.org;
 h=from:subject:message-id; bh=5TFStna3v+h2JmpsNdxCOVxrFroUUfHd5AjYd1lMZUM=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRdPDznQngH65+2xNndIvapZr7Bt5z/XM1f4pZ7YEOce
 8cbywnxHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABPR38Lwv3pLipw61529opzn
 HixjKtMPFE9ryTsydfVO/h3ProQtecLIcN13Sptk8bPc2POCTNwv312KUQx9OqPh/v/bitVSvV3
 1PAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Store the cookie to detect concurrent seeks on directories in
file->private_data.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/ext2/dir.c | 28 +++++++++++++++++++++++++---
 1 file changed, 25 insertions(+), 3 deletions(-)

diff --git a/fs/ext2/dir.c b/fs/ext2/dir.c
index 087457061c6e..6622c582f550 100644
--- a/fs/ext2/dir.c
+++ b/fs/ext2/dir.c
@@ -263,7 +263,7 @@ ext2_readdir(struct file *file, struct dir_context *ctx)
 	unsigned long n = pos >> PAGE_SHIFT;
 	unsigned long npages = dir_pages(inode);
 	unsigned chunk_mask = ~(ext2_chunk_size(inode)-1);
-	bool need_revalidate = !inode_eq_iversion(inode, file->f_version);
+	bool need_revalidate = !inode_eq_iversion(inode, *(u64 *)file->private_data);
 	bool has_filetype;
 
 	if (pos > inode->i_size - EXT2_DIR_REC_LEN(1))
@@ -290,7 +290,7 @@ ext2_readdir(struct file *file, struct dir_context *ctx)
 				offset = ext2_validate_entry(kaddr, offset, chunk_mask);
 				ctx->pos = (n<<PAGE_SHIFT) + offset;
 			}
-			file->f_version = inode_query_iversion(inode);
+			*(u64 *)file->private_data = inode_query_iversion(inode);
 			need_revalidate = false;
 		}
 		de = (ext2_dirent *)(kaddr+offset);
@@ -703,8 +703,30 @@ int ext2_empty_dir(struct inode *inode)
 	return 0;
 }
 
+static int ext2_dir_open(struct inode *inode, struct file *file)
+{
+	file->private_data = kzalloc(sizeof(u64), GFP_KERNEL);
+	if (!file->private_data)
+		return -ENOMEM;
+	return 0;
+}
+
+static int ext2_dir_release(struct inode *inode, struct file *file)
+{
+	kfree(file->private_data);
+	return 0;
+}
+
+static loff_t ext2_dir_llseek(struct file *file, loff_t offset, int whence)
+{
+	return generic_llseek_cookie(file, offset, whence,
+				     (u64 *)file->private_data);
+}
+
 const struct file_operations ext2_dir_operations = {
-	.llseek		= generic_file_llseek,
+	.open		= ext2_dir_open,
+	.release	= ext2_dir_release,
+	.llseek		= ext2_dir_llseek,
 	.read		= generic_read_dir,
 	.iterate_shared	= ext2_readdir,
 	.unlocked_ioctl = ext2_ioctl,

-- 
2.45.2


