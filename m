Return-Path: <linux-fsdevel+bounces-66873-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 61354C2EDFE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 04 Nov 2025 02:49:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D832B4E556A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Nov 2025 01:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E30352356C7;
	Tue,  4 Nov 2025 01:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gvernon.com header.i=@gvernon.com header.b="tfWPaZ3m"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6278E17A303
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Nov 2025 01:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762220955; cv=none; b=Vg8qUwQgu/T5cuXZsjRj3OmAVpY6feOfOAOVi0p9xLOkskTjB7X5JeZTVIXEgm2nLjZ6K3IdF+e+DSSIBsUcbqMrhmviVuyfpYMx5UfZ3xM2Gfv6S9cCQu6IhPtU2uhEderojXWrBntbIxrDqMc3noG0bofemHIXl908/KzxUtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762220955; c=relaxed/simple;
	bh=224JKoKN95C1VopyrFR3G27HuWsjdSSuSIq1K/VlYno=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bB14ZnC/Sl0IE0gk3QvTVReUIY5GE9WoM6m4kqxW8XBHdlO7bvBY2j9JhOpJx+UYvPclggT1lIIH2IL+3DuvzWlQ84SQ8bWT9QumBTDCXarNMSUuv60KkjIaGy++86BY0bqbrn9447iQjEXJl7S3SG+qPozzrnxvkWowSDVdkEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gvernon.com; spf=pass smtp.mailfrom=gvernon.com; dkim=pass (2048-bit key) header.d=gvernon.com header.i=@gvernon.com header.b=tfWPaZ3m; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gvernon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gvernon.com
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gvernon.com; s=key1;
	t=1762220951;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pnaYx7JNjwqOM882Qu2JmNY4fM9aj5y9EPMgwFvTdRs=;
	b=tfWPaZ3mHHIn2RkxErSIm3BAtlgGl+irRKqIRRW5Y4i5UNZPG25NL6muTs7NqOKBFf3iT3
	5o5p0XVPxADxPBLXJeJAU3YOjuYEftdpsKwmukQ44My/7xl2FuoNgwimKdU/rMu6ACdRg2
	g59j3pdpoparoenWaFLED7ACORLy50YN5Xj+816zWVcQElM3i+YV2stb6y4uoU+h2oyTvl
	41eBC4Y0EWSqUV5UMfazMR1d9Njf/H42RpXBgvkykrempZHy77UwanBRVUXnZErLqr675E
	+N8YrQdCl02sWk0KV4mgdlajJsoJzD8FJONDo/W1HXeRiMGEa27zX2pu1sLkvQ==
From: George Anthony Vernon <contact@gvernon.com>
To: slava@dubeyko.com,
	glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com,
	linux-fsdevel@vger.kernel.org,
	skhan@linuxfoundation.org
Cc: George Anthony Vernon <contact@gvernon.com>,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	penguin-kernel@i-love.sakura.ne.jp,
	syzbot+97e301b4b82ae803d21b@syzkaller.appspotmail.com
Subject: [PATCH v2 1/2] hfs: Validate CNIDs in hfs_read_inode
Date: Tue,  4 Nov 2025 01:47:36 +0000
Message-ID: <20251104014738.131872-3-contact@gvernon.com>
In-Reply-To: <d2b28f73-49c8-4e30-9913-01702da4dfe4@I-love.SAKURA.ne.jp>
References: <d2b28f73-49c8-4e30-9913-01702da4dfe4@I-love.SAKURA.ne.jp>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

hfs_read_inode previously did not validate CNIDs read from disk, thereby
allowing inodes to be constructed with disallowed CNIDs and placed on
the dirty list, eventually hitting a bug on writeback.

Validate reserved CNIDs according to Apple technical note TN1150.

This issue was discussed at length on LKML previously, the discussion
is linked below.

Syzbot tested this patch on mainline and the bug did not replicate.
This patch was regression tested by issuing various system calls on a
mounted HFS filesystem and validating that file creation, deletion,
reads and writes all work.

Link: https://lore.kernel.org/all/427fcb57-8424-4e52-9f21-7041b2c4ae5b@
I-love.SAKURA.ne.jp/T/
Reported-by: syzbot+97e301b4b82ae803d21b@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=97e301b4b82ae803d21b
Cc: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Tested-by: syzbot+97e301b4b82ae803d21b@syzkaller.appspotmail.com
Signed-off-by: George Anthony Vernon <contact@gvernon.com>
---
 fs/hfs/inode.c | 67 +++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 53 insertions(+), 14 deletions(-)

diff --git a/fs/hfs/inode.c b/fs/hfs/inode.c
index 9cd449913dc8..bc346693941d 100644
--- a/fs/hfs/inode.c
+++ b/fs/hfs/inode.c
@@ -321,6 +321,38 @@ static int hfs_test_inode(struct inode *inode, void *data)
 	}
 }
 
+/*
+ * is_valid_cnid
+ *
+ * Validate the CNID of a catalog record
+ */
+static inline
+bool is_valid_cnid(u32 cnid, u8 type)
+{
+	if (likely(cnid >= HFS_FIRSTUSER_CNID))
+		return true;
+
+	switch (cnid) {
+	case HFS_ROOT_CNID:
+		return type == HFS_CDR_DIR;
+	case HFS_EXT_CNID:
+	case HFS_CAT_CNID:
+		return type == HFS_CDR_FIL;
+	case HFS_POR_CNID:
+		/* No valid record with this CNID */
+		break;
+	case HFS_BAD_CNID:
+	case HFS_EXCH_CNID:
+		/* Not implemented */
+		break;
+	default:
+		/* Invalid reserved CNID */
+		break;
+	}
+
+	return false;
+}
+
 /*
  * hfs_read_inode
  */
@@ -350,6 +382,8 @@ static int hfs_read_inode(struct inode *inode, void *data)
 	rec = idata->rec;
 	switch (rec->type) {
 	case HFS_CDR_FIL:
+		if (!is_valid_cnid(rec->file.FlNum, HFS_CDR_FIL))
+			goto make_bad_inode;
 		if (!HFS_IS_RSRC(inode)) {
 			hfs_inode_read_fork(inode, rec->file.ExtRec, rec->file.LgLen,
 					    rec->file.PyLen, be16_to_cpu(rec->file.ClpSize));
@@ -371,6 +405,8 @@ static int hfs_read_inode(struct inode *inode, void *data)
 		inode->i_mapping->a_ops = &hfs_aops;
 		break;
 	case HFS_CDR_DIR:
+		if (!is_valid_cnid(rec->dir.DirID, HFS_CDR_DIR))
+			goto make_bad_inode;
 		inode->i_ino = be32_to_cpu(rec->dir.DirID);
 		inode->i_size = be16_to_cpu(rec->dir.Val) + 2;
 		HFS_I(inode)->fs_blocks = 0;
@@ -380,8 +416,12 @@ static int hfs_read_inode(struct inode *inode, void *data)
 		inode->i_op = &hfs_dir_inode_operations;
 		inode->i_fop = &hfs_dir_operations;
 		break;
+	make_bad_inode:
+		pr_warn("rejected cnid %lu. Volume is probably corrupted, try performing fsck.\n", inode->i_ino);
+		fallthrough;
 	default:
 		make_bad_inode(inode);
+		break;
 	}
 	return 0;
 }
@@ -441,20 +481,19 @@ int hfs_write_inode(struct inode *inode, struct writeback_control *wbc)
 	if (res)
 		return res;
 
-	if (inode->i_ino < HFS_FIRSTUSER_CNID) {
-		switch (inode->i_ino) {
-		case HFS_ROOT_CNID:
-			break;
-		case HFS_EXT_CNID:
-			hfs_btree_write(HFS_SB(inode->i_sb)->ext_tree);
-			return 0;
-		case HFS_CAT_CNID:
-			hfs_btree_write(HFS_SB(inode->i_sb)->cat_tree);
-			return 0;
-		default:
-			BUG();
-			return -EIO;
-		}
+	if (!is_valid_cnid(inode->i_ino,
+			   S_ISDIR(inode->i_mode) ? HFS_CDR_DIR : HFS_CDR_FIL))
+		BUG();
+
+	switch (inode->i_ino) {
+	case HFS_EXT_CNID:
+		hfs_btree_write(HFS_SB(inode->i_sb)->ext_tree);
+		return 0;
+	case HFS_CAT_CNID:
+		hfs_btree_write(HFS_SB(inode->i_sb)->cat_tree);
+		return 0;
+	default:
+		break;
 	}
 
 	if (HFS_IS_RSRC(inode))
-- 
2.50.1


