Return-Path: <linux-fsdevel+bounces-74124-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B95D9D32A3D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 15:32:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8B81731499F7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 14:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9977339850;
	Fri, 16 Jan 2026 14:28:55 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A04631A555;
	Fri, 16 Jan 2026 14:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768573735; cv=none; b=FNo4Km9WHr270GWTdXxH8MaBOgxgRCDMbsY28cppl82HQlUDUwhX8bKatsv19PuZDoEvWeX53VqTtOKqBTgGY1Y6qH/jVJS894nHVIO/5pvFD04pK3pnswYbOImUO/MY3x+v8HxuH3fPtFs4CetdwxrO0VZX14pt/L5jlOVfJ24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768573735; c=relaxed/simple;
	bh=Wfd7T+XIhqQr3+OaZTeki3o+32YSR0shu5lVic1B5gs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WHZp0sii+KWHKbyKDfuabAzHkNx1KOm6DVZDahFt5dgD3/RpEURUD9KdbtWvDrD4H8URScdOMR9pFXIJNj2ArAtFQFU8QpYuYCiw7zdJ+bSAZucFqVNjKHd7aQcZFFeP+OenBKi5+pBJviTRHSxSE22MuqwPv94RTOyIjCrmAxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ustc.edu; spf=pass smtp.mailfrom=ustc.edu; arc=none smtp.client-ip=101.71.155.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ustc.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ustc.edu
Received: from localhost (unknown [14.22.11.163])
	by smtp.qiye.163.com (Hmail) with ESMTP id 30ef1dc9f;
	Fri, 16 Jan 2026 22:28:49 +0800 (GMT+08:00)
From: Chunsheng Luo <luochunsheng@ustc.edu>
To: miklos@szeredi.hu
Cc: amir73il@gmail.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chunsheng Luo <luochunsheng@ustc.edu>
Subject: [PATCH 2/2] fuse: Relax backing file validation to compare backing inodes
Date: Fri, 16 Jan 2026 22:28:45 +0800
Message-ID: <20260116142845.422-3-luochunsheng@ustc.edu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260116142845.422-1-luochunsheng@ustc.edu>
References: <20260116142845.422-1-luochunsheng@ustc.edu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9bc7357c5b03a2kunm62945613268fec
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaTU1IVh4eGkMYGUpNGEwdS1YeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlKT1VJSVVKSlVKTUhZV1kWGg8SFR0UWUFZS1VLVUtVS1kG

To simplify crash recovery and reduce performance impact, backing_ids
are not persisted across daemon restarts. However, when the daemon
restarts and another process open the same FUSE file and assigning it
the same backing file (with the same inode) will also cause the
fuse_inode_uncached_io_start() function to fail due to a mismatch in
the fb pointer.

So Relax the validation in fuse_inode_uncached_io_start() to compare
backing inodes instead of fuse_backing pointers.

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
2.43.0


