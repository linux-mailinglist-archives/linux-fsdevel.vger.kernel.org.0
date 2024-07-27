Return-Path: <linux-fsdevel+bounces-24353-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F2F693DD4C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Jul 2024 06:52:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA8AB1F23F2D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Jul 2024 04:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0E9B14290;
	Sat, 27 Jul 2024 04:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A3JF6Sgf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B180F15C3
	for <linux-fsdevel@vger.kernel.org>; Sat, 27 Jul 2024 04:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722055945; cv=none; b=fQVIjXAeYJhStO7EdFDzd9hlWhwGwcbBBlHonLFI2hATJOndhsa4z3lrrl3ipvb9fCjENrLYdW6J1OGQCLQfcrLN9PkAq8Uh4x89y0oDx5EmnaYIopZmxtq3Q3J8ReXSIhra60DsmKurySlvpU+VGSo8mvCzJTJedb5w91NQ9r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722055945; c=relaxed/simple;
	bh=qMNOwDqEPPp+DgBQrDwQ0cNff5CQVtBnR1nVvvin7hU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=G5ZwAK+5hyoTS7mGXwV2fUhWF13rbZogDgdShOWEd0JRkcDWmAH2LcgtV0q9tRw3I4zy+K3jyaIHSf8CqsKA91UX3HY6A9lZ/CxfhDbq8tOjubm954vkqfo/bgQ8LUMRPddWxxcyXFArflHbaaSKdZvqUWhqQpQnH4LIrX/2hUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A3JF6Sgf; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5d5d4d07babso137454eaf.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 26 Jul 2024 21:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722055942; x=1722660742; darn=vger.kernel.org;
        h=content-transfer-encoding:commitdate:commit:authordate:author
         :mime-version:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=74pqFZ6GJTA74j5wcorWmd+opIrR6vm3cHYvIXlwIV8=;
        b=A3JF6SgfSBsYsArFamcVz6je82MNgn8JQA7dCdgBdvP7YC5mT70Dz5ZZS04XN86CMK
         DzgCjL8ax+exTsuRjdCqbuU80h5FVdRVAl2o7i6s6gBEIelo6zJ8lwtYWzBZjPA+vxkh
         azW6nTDGvpW1agKUDgO2ylVyzKmBY5+yFUILr5BbEiGL8IqKtctc43HvbqN9GlHQ9j7G
         LMC3sIuXvotpnrY2tljlMxNkZnowW9YapG7l3/1iv9EWjxhXDislGzm6LBhb5a66sI7d
         8mU5Dhi30UcRcgqi3NYiohI8Bi7LxobuQQQsMm5Fg+cPjSj+8cdgDFGfUc9Yc/vQPzSK
         /JTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722055942; x=1722660742;
        h=content-transfer-encoding:commitdate:commit:authordate:author
         :mime-version:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=74pqFZ6GJTA74j5wcorWmd+opIrR6vm3cHYvIXlwIV8=;
        b=XgATEJj5g8bFIYLw5fTXHfmlX+bKrun/uDFZFtDH3e4e2hIzj3bYJeASHPMl1nzsTF
         tJmiIvHlD3R6BysEtJifssL8oFVRAmWlkTxeVLdDn879SrF/NC15yJ8R116ZIo0EYJgY
         xaYl2diH0svP0HPWrSchh2eKiD9Zqwb5M4MkV9ERvychbPSnUytl9p26dX4+nVJgYT7N
         Tc6Qxt/n7e9+kR/S0IV9NJhg4KwZ2P13dNQplSm08U+FmhxLOldCJkC7iP/fpmxZovBV
         L0AegBW8Xr0RF22r2Dj6CuilJ+2z7GzqAdptbynhmNoY0ONOBD79BO4JjbU8cyo/u2E7
         7jaw==
X-Gm-Message-State: AOJu0YyIiQv0K2TXa/Tpt+UhIszpOXj9fuw5XNf3Oas50L9Kpsm90gZj
	Gq/PaoMVVyLglgF/a19Koc9XwxHMvVPJ1+Qfjc1uf8s2IC/GRu3zcS5MsbezRl0=
X-Google-Smtp-Source: AGHT+IEdVjPjAV6ZoMGnQBSHE1FnwwxNe1Iihz1TQMIToInKloGXWcVp+WDSIz/TTbJjEeE5np5vmQ==
X-Received: by 2002:a05:6871:b2c:b0:260:fd20:a885 with SMTP id 586e51a60fabf-267d4de4083mr2266034fac.27.1722055942462;
        Fri, 26 Jul 2024 21:52:22 -0700 (PDT)
Received: from BiscuitBobby.am.students.amrita.edu ([175.184.253.10])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7a9f9ec424csm3079710a12.59.2024.07.26.21.52.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 21:52:22 -0700 (PDT)
From: Siddharth Menon <simeddon@gmail.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel-mentees@lists.linuxfoundation.org,
	Siddharth Menon <simeddon@gmail.com>
Subject: hfsplus: Initialize directory subfolders in hfsplus_mknod
Date: Sat, 27 Jul 2024 10:21:29 +0530
Message-Id: <20240727045127.54746-1-simeddon@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Author:     Siddharth Menon <simeddon@gmail.com>
AuthorDate: Sat Jul 20 01:39:01 2024 +0530
Commit:     c20838f5588517990bbb54069e93aca19672fbe5
CommitDate: Sat Jul 27 10:14:28 2024 +0530
Content-Transfer-Encoding: 8bit

    hfsplus: Initialize directory subfolders in hfsplus_mknod
    
    Addresses uninitialized subfolders attribute being used in `hfsplus_subfolders_inc` and `hfsplus_subfolders_dec`.
    
    Fixes: https://syzkaller.appspot.com/bug?extid=fdedff847a0e5e84c39f
    Reported-by: syzbot+fdedff847a0e5e84c39f@syzkaller.appspotmail.com
    Closes: https://syzkaller.appspot.com/x/report.txt?x=16efda06680000

Signed-off-by: Siddharth Menon <simeddon@gmail.com>
---
 fs/hfsplus/btree.c | 1 +
 fs/hfsplus/dir.c   | 7 +++++--
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/hfsplus/btree.c b/fs/hfsplus/btree.c
index 9e1732a2b92a..13d2e90cb9b1 100644
--- a/fs/hfsplus/btree.c
+++ b/fs/hfsplus/btree.c
@@ -363,6 +363,7 @@ int hfs_bmap_reserve(struct hfs_btree *tree, int rsvd_nodes)
 				HFSPLUS_SB(tree->sb)->alloc_blksz_shift;
 		hip->fs_blocks =
 			hip->alloc_blocks << HFSPLUS_SB(tree->sb)->fs_shift;
+		hip->subfolders = 0;
 		inode_set_bytes(inode, inode->i_size);
 		count = inode->i_size >> tree->node_size_shift;
 		tree->free_nodes += count - tree->node_count;
diff --git a/fs/hfsplus/dir.c b/fs/hfsplus/dir.c
index f5c4b3e31a1c..a4eb287e3d4b 100644
--- a/fs/hfsplus/dir.c
+++ b/fs/hfsplus/dir.c
@@ -485,11 +485,14 @@ static int hfsplus_mknod(struct mnt_idmap *idmap, struct inode *dir,
 
 	mutex_lock(&sbi->vh_mutex);
 	inode = hfsplus_new_inode(dir->i_sb, dir, mode);
+	if (test_bit(HFSPLUS_SB_HFSX, &sbi->flags))
+		HFSPLUS_I(dir)->subfolders = 0;
+
 	if (!inode)
 		goto out;
 
-	if (S_ISBLK(mode) || S_ISCHR(mode) || S_ISFIFO(mode) || S_ISSOCK(mode))
-		init_special_inode(inode, mode, rdev);
+	if (S_ISBLK(mode) || S_ISCHR(mode) || S_ISFIFO(mode) || S_ISSOCK(mode)){
+		init_special_inode(inode, mode, rdev);}
 
 	res = hfsplus_create_cat(inode->i_ino, dir, &dentry->d_name, inode);
 	if (res)
-- 
2.39.2


