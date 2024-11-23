Return-Path: <linux-fsdevel+bounces-35642-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3DE69D6A90
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Nov 2024 18:25:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9E6F281EE1
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Nov 2024 17:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EAE81428E0;
	Sat, 23 Nov 2024 17:25:05 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from air.basealt.ru (air.basealt.ru [193.43.8.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB898195;
	Sat, 23 Nov 2024 17:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.43.8.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732382704; cv=none; b=uWW3B18NFbC0i4zbsW0R93L9xR1QUNZCID/zwWV3TUdsoQ6C3rqHsspXOxltSJ3avu49ypa9PKrkh0cimvSXYLU4jKWI9Tul6yK/firIydCKukaoXqbvZZ++i0wK3hyXyfmJaM1QdECL1dg+DbvBNpVq0Nb/b16KteLQY/iyolA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732382704; c=relaxed/simple;
	bh=ge5FSu7/fAqLGmxFcR6uayT1c3YhSPc3WQsqzXSlKcc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Grhlbp1I4nB+6T+JqipT7wUAjBQGAw88QUw+v0XdtDafomAPadXYS5dbC+th8x50Bb8QqYL7ZR11QRg6YbHOu2wSryBbPXknAe0n+qCTTerAjQu8q539Ok4vSrLd24I3MhObT+koiKo/y2Qqpkbhv76BX0D/ro/vSHkhRx41tas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=193.43.8.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: from altlinux.ipa.basealt.ru (unknown [178.76.204.78])
	by air.basealt.ru (Postfix) with ESMTPSA id 9179223380;
	Sat, 23 Nov 2024 20:24:56 +0300 (MSK)
From: Vasiliy Kovalev <kovalev@altlinux.org>
To: "Tigran A . Aivazian" <aivazian.tigran@gmail.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	linux-fsdevel@vger.kernel.org,
	linux-unionfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: kovalev@altlinux.org
Subject: [PATCH] bfs: validate inode vtype and discard invalid entries
Date: Sat, 23 Nov 2024 20:24:53 +0300
Message-Id: <20241123172453.275255-1-kovalev@altlinux.org>
X-Mailer: git-send-email 2.33.8
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The inode's `i_mode` field previously included all 16 bits from the
BFS on-disk mode, which combines permission bits (0-11) with file type
bits (12-15).
However, this approach allowed invalid type bits to propagate, leading
to inodes with uninitialized or incorrect fields.

As Al Viro noted [1], file types are determined by bits 12-15, which
correspond to:
- `0x4000` for directories,
- `0x8000` for regular files,
- other values for different types like FIFOs or symlinks.

If the `i_vtype` field does not match a valid file type (e.g., `BFS_VDIR`
or `BFS_VREG`), it indicates corruption or an unsupported state in the
filesystem.

This patch restricts `i_mode` to the lower 12 bits and validates `i_vtype`:
- Directories and regular files are handled as expected.
- Inodes with invalid `i_vtype` values are discarded, and a warning is
logged for debugging.

[1] https://lore.kernel.org/linux-unionfs/20241123002157.GP3387508@ZenIV/

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: syzbot+a8c9d476508bd14a90e5@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=a8c9d476508bd14a90e5
Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
Cc: <stable@vger.kernel.org>
Signed-off-by: Vasiliy Kovalev <kovalev@altlinux.org>
---
 fs/bfs/inode.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/bfs/inode.c b/fs/bfs/inode.c
index db81570c96375..c02efc5724d26 100644
--- a/fs/bfs/inode.c
+++ b/fs/bfs/inode.c
@@ -60,7 +60,7 @@ struct inode *bfs_iget(struct super_block *sb, unsigned long ino)
 	off = (ino - BFS_ROOT_INO) % BFS_INODES_PER_BLOCK;
 	di = (struct bfs_inode *)bh->b_data + off;
 
-	inode->i_mode = 0x0000FFFF & le32_to_cpu(di->i_mode);
+	inode->i_mode = 0x00000FFF & le32_to_cpu(di->i_mode);
 	if (le32_to_cpu(di->i_vtype) == BFS_VDIR) {
 		inode->i_mode |= S_IFDIR;
 		inode->i_op = &bfs_dir_inops;
@@ -70,6 +70,11 @@ struct inode *bfs_iget(struct super_block *sb, unsigned long ino)
 		inode->i_op = &bfs_file_inops;
 		inode->i_fop = &bfs_file_operations;
 		inode->i_mapping->a_ops = &bfs_aops;
+	} else {
+		printf("Invalid vtype %u for inode %s:%08lx\n",
+			le32_to_cpu(di->i_vtype), inode->i_sb->s_id, ino);
+		brelse(bh);
+		goto error;
 	}
 
 	BFS_I(inode)->i_sblock =  le32_to_cpu(di->i_sblock);
-- 
2.33.8


