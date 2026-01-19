Return-Path: <linux-fsdevel+bounces-74412-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4210CD3A1C5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 09:38:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B288230042B1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 08:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01DED340DB1;
	Mon, 19 Jan 2026 08:38:21 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC72341055;
	Mon, 19 Jan 2026 08:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768811898; cv=none; b=Bo/vB8mm374pL3Lp32xTpPGWszexSbwIBmEwanYgRe1djPXUzawtpJETypLHRUc6iXvlu43cA4YAxWFCkT7UoS0qs9cpdLbHTrR8Ctkyzc0xiqrKKOB7FTh5ty8OU2l31Yf6Ui4s33NRti/qyvOnDiXAUoscH/yiG5apGh3AjkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768811898; c=relaxed/simple;
	bh=OhcZcpA+M3aY0mPPxGknh+dqPpTGGDl2fTzwtyYD2KM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kS3W6mwpsSfP5X6u4LA2bUDTF2cMU1ifgSHsDnFORz/lonq7j/6s3cJjHQ4c3hjngGJ/JhkvvgQ2cOXqlJHhelJNR19TT3PmmdLUBEyIdXbF3S4uzpNY/J+sdR5jeN8EKhsUDVIh5GQxAINvfLS7km2Gh20YPnLuh947JQqelEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ustc.edu; spf=pass smtp.mailfrom=ustc.edu; arc=none smtp.client-ip=45.254.49.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ustc.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ustc.edu
Received: from localhost (unknown [14.116.239.35])
	by smtp.qiye.163.com (Hmail) with ESMTP id 3122c815c;
	Mon, 19 Jan 2026 16:38:08 +0800 (GMT+08:00)
From: Chunsheng Luo <luochunsheng@ustc.edu>
To: miklos@szeredi.hu
Cc: amir73il@gmail.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chunsheng Luo <luochunsheng@ustc.edu>
Subject: [PATCH v3 2/2] fuse: Relax backing file validation to compare backing inodes
Date: Mon, 19 Jan 2026 16:37:49 +0800
Message-ID: <20260119083750.2055-3-luochunsheng@ustc.edu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260119083750.2055-1-luochunsheng@ustc.edu>
References: <20260119083750.2055-1-luochunsheng@ustc.edu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9bd5677f5003a2kunm79ad2b16316272
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDQ0tJVkpOGE5OGRhKTExOQlYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlKT1VKSk1VSUhCVUhOWVdZFhoPEhUdFFlBWUtVS1VLVUtZBg++

To simplify crash recovery and reduce performance impact, backing_ids
are not persisted across daemon restarts. However, when the daemon
restarts and another process open the same FUSE file and assigning it
the same backing file (with the same inode) will also cause the
fuse_inode_uncached_io_start() function to fail due to a mismatch in
the fb pointer.

So Relax the validation in fuse_inode_uncached_io_start() to compare
backing inodes instead of fuse_backing pointers.

Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Chunsheng Luo <luochunsheng@ustc.edu>
---
 fs/fuse/iomode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/fuse/iomode.c b/fs/fuse/iomode.c
index 3728933188f3..ca7619958b0d 100644
--- a/fs/fuse/iomode.c
+++ b/fs/fuse/iomode.c
@@ -90,7 +90,7 @@ int fuse_inode_uncached_io_start(struct fuse_inode *fi, struct fuse_backing *fb)
 	spin_lock(&fi->lock);
 	/* deny conflicting backing files on same fuse inode */
 	oldfb = fuse_inode_backing(fi);
-	if (fb && oldfb && oldfb != fb) {
+	if (fb && oldfb && file_inode(oldfb->file) != file_inode(fb->file)) {
 		err = -EBUSY;
 		goto unlock;
 	}
-- 
2.41.0


