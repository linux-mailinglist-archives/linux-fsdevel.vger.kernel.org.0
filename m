Return-Path: <linux-fsdevel+bounces-56841-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1DA0B1C70C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Aug 2025 15:53:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55EC1720BFD
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Aug 2025 13:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71A1D28C849;
	Wed,  6 Aug 2025 13:53:12 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDAE428C841;
	Wed,  6 Aug 2025 13:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754488392; cv=none; b=mbwIw8y1mZb2Sfyl2o0X4QXdNeUhQGmjxXwCuVGdk+E4e5B1wmhmydn4U9rMuRe3cb52PMWTqnj0m1l4sUDFAbNyMlkLKyjRKwWCvBs5b1RDL60ki426EQoxmozwgyWyRwVT9K8Ev4QdMYPbmxSCSm3JSKpo7+hgsU3oTpJHFKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754488392; c=relaxed/simple;
	bh=+bgbDLav3A9Ad0o0X3nROcfNM4Rpp4+hZKd1tJJ1Qtg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l9a/t9pgO4I2QtrTghor7UnA01aX0GG442xOOp4ddpTc7VeFQl68ashs1SpJXyU4645jydiOx14s/xWVGRagWFx+JgO0ODGoPxPiLQlg1nn4uV/Jk/NJii9yH/bfxvzIIcp8mWXV3yom/IMRea9GQVxlHYUlBr7oSksiTMkHfWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ustc.edu; spf=pass smtp.mailfrom=ustc.edu; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ustc.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ustc.edu
Received: from localhost (unknown [14.22.11.162])
	by smtp.qiye.163.com (Hmail) with ESMTP id 1e831fad3;
	Wed, 6 Aug 2025 21:52:56 +0800 (GMT+08:00)
From: Chunsheng Luo <luochunsheng@ustc.edu>
To: miklos@szeredi.hu
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chunsheng Luo <luochunsheng@ustc.edu>
Subject: [PATCH] fuse: Move same-superblock check to fuse_copy_file_range
Date: Wed,  6 Aug 2025 21:52:54 +0800
Message-ID: <20250806135254.352-1-luochunsheng@ustc.edu>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a987fa80ddd03a2kunm558ac8ac2f4495
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZTk8ZVklMT0oeQ0NKThkaTFYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlKT1VJSVVKSlVKTUlZV1kWGg8SFR0UWUFZT0tIVUpLSUJDQ0xVSktLVUtZBg
	++

The copy_file_range COPY_FILE_SPLICE capability allows filesystems to
handle cross-superblock copy. However, in the current fuse implementation,
__fuse_copy_file_range accesses src_file->private_data under the assumption
that it points to a fuse_file structure. When the source file belongs to a
non-FUSE filesystem, it will leads to kernel panics.

To resolve this, move the same-superblock check from __fuse_copy_file_range
to fuse_copy_file_range to ensure both files belong to the same fuse
superblock before accessing private_data.

Signed-off-by: Chunsheng Luo <luochunsheng@ustc.edu>
---
 fs/fuse/file.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 95275a1e2f54..a29f1b84f11b 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -2984,9 +2984,6 @@ static ssize_t __fuse_copy_file_range(struct file *file_in, loff_t pos_in,
 	if (fc->no_copy_file_range)
 		return -EOPNOTSUPP;
 
-	if (file_inode(file_in)->i_sb != file_inode(file_out)->i_sb)
-		return -EXDEV;
-
 	inode_lock(inode_in);
 	err = fuse_writeback_range(inode_in, pos_in, pos_in + len - 1);
 	inode_unlock(inode_in);
@@ -3066,9 +3063,12 @@ static ssize_t fuse_copy_file_range(struct file *src_file, loff_t src_off,
 {
 	ssize_t ret;
 
+	if (file_inode(src_file)->i_sb != file_inode(dst_file)->i_sb)
+		return splice_copy_file_range(src_file, src_off, dst_file,
+					     dst_off, len);
+
 	ret = __fuse_copy_file_range(src_file, src_off, dst_file, dst_off,
 				     len, flags);
-
 	if (ret == -EOPNOTSUPP || ret == -EXDEV)
 		ret = splice_copy_file_range(src_file, src_off, dst_file,
 					     dst_off, len);
-- 
2.43.0


