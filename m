Return-Path: <linux-fsdevel+bounces-58168-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D447CB2A621
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Aug 2025 15:41:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FCB81B671FE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Aug 2025 13:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C316F3375CC;
	Mon, 18 Aug 2025 13:29:16 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E8E71E48A;
	Mon, 18 Aug 2025 13:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755523756; cv=none; b=KB6H4O60GtjNUg69EDdapim4IZsB2QM3lgEn05iG59O6JlUKJN4efchPujdCS1SUWEOPcjBRNi6rpP3aQbrdTTxsWB7O/P9Px0wpdBMHiZmqNb/191Eu3QtpP6Q9w5R0Fy7RDIbelYFL4l9FTs9S+irGyIEdARwY2kIclxwnQC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755523756; c=relaxed/simple;
	bh=8yezdG3HhQfmXBMnQC0mZKqOGvI0D9TpPpmbAM1+vbg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=U29ETKQxxF4ItLpumi0iLQZL15gfqMjt55vhxiKrbtykO8MUc0T0PW0XcWQe1GaOwskfHqCpLCwMO9DzEXdawIznxwm3N2iqASG0yr4wSIAGSX8tQDewSycr7CXRDUmfiyZvw3BNqYOoE1EvDeSRXR1u/jGglZe/S3hN7Qr0zDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ustc.edu; spf=pass smtp.mailfrom=ustc.edu; arc=none smtp.client-ip=101.71.155.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ustc.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ustc.edu
Received: from localhost (unknown [14.22.11.164])
	by smtp.qiye.163.com (Hmail) with ESMTP id 1fc0c0b3a;
	Mon, 18 Aug 2025 21:29:06 +0800 (GMT+08:00)
From: Chunsheng Luo <luochunsheng@ustc.edu>
To: miklos@szeredi.hu
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chunsheng Luo <luochunsheng@ustc.edu>
Subject: [PATCH] fuse: clarify extending writes handling
Date: Mon, 18 Aug 2025 21:29:05 +0800
Message-ID: <20250818132905.323-1-luochunsheng@ustc.edu>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a98bd5e8c6103a2kunm989fadde37bf3a
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCGENDVh4fQk1JHkJLSUhMHVYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlKT1VJSVVKSlVKTU9ZV1kWGg8SFR0UWUFZS1VLVUtVS1kG

Only flush extending writes (up to LLONG_MAX) for files with upcoming
write operations, and Fix confusing 'end' parameter usage.

Signed-off-by: Chunsheng Luo <luochunsheng@ustc.edu>
---
 fs/fuse/file.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 95275a1e2f54..d2b8e3a7d4a4 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -2851,7 +2851,7 @@ fuse_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 
 static int fuse_writeback_range(struct inode *inode, loff_t start, loff_t end)
 {
-	int err = filemap_write_and_wait_range(inode->i_mapping, start, LLONG_MAX);
+	int err = filemap_write_and_wait_range(inode->i_mapping, start, end);
 
 	if (!err)
 		fuse_sync_writes(inode);
@@ -2894,9 +2894,8 @@ static long fuse_file_fallocate(struct file *file, int mode, loff_t offset,
 	}
 
 	if (mode & (FALLOC_FL_PUNCH_HOLE | FALLOC_FL_ZERO_RANGE)) {
-		loff_t endbyte = offset + length - 1;
-
-		err = fuse_writeback_range(inode, offset, endbyte);
+		/* flush extending writes for upcoming write operations */
+		err = fuse_writeback_range(inode, offset, LLONG_MAX);
 		if (err)
 			goto out;
 	}
@@ -3017,7 +3016,8 @@ static ssize_t __fuse_copy_file_range(struct file *file_in, loff_t pos_in,
 	 * To fix this a mapping->invalidate_lock could be used to prevent new
 	 * faults while the copy is ongoing.
 	 */
-	err = fuse_writeback_range(inode_out, pos_out, pos_out + len - 1);
+	/*  flush extending writes for upcoming write operations */
+	err = fuse_writeback_range(inode_out, pos_out, LLONG_MAX);
 	if (err)
 		goto out;
 
-- 
2.43.0


