Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D43733B8C90
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Jul 2021 05:09:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238756AbhGADLk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Jun 2021 23:11:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238728AbhGADLj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Jun 2021 23:11:39 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35C4FC061756;
        Wed, 30 Jun 2021 20:09:10 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id a14so2635067pls.4;
        Wed, 30 Jun 2021 20:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=if2bnw03Mu18gRjTYl4E6k8rtPnZizNZqXxBx0h9PIw=;
        b=HOtemOj4Mf15W/3DOjhKWvrtyjA3aZ+zMbAY7cK0r0hLoltzyF9Bv+xPjfHtsqzUQ1
         N2gohog5NbYXL0yRwKbNd4akreHkQwzN49Q07N2zGoQY+M0qhL8LU1gw6u8AqGFQtjSM
         1EO0hGH4dmcwBrjz+zcHbI/lJUfi/FcdgODH41P8o1CLELgQP9cyqYAFx+/ESxO2P6hC
         S6vFNl2Nx6TLWF7+DvUSpEZW6d5w9g8iwKcBMhqmhGqk2AeXI1bd4s6/+N5AWz+2tTgj
         1+lyXiFnK1NIiB0uzUUXOIHhOkHwSG8RyEkVGGXUBGYDrgdvW4Ue7tfj/LsZihKhovle
         aVxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=if2bnw03Mu18gRjTYl4E6k8rtPnZizNZqXxBx0h9PIw=;
        b=JptCThR/vkA8fXLTS0kDk+O21OjLzWpadAsk0kFa02H0hQ2YiJN5BBwx69lCbpb1A8
         Tjv6dSDerQ9rT6lt+wGGkCo5u+a1XJ2EGt8lh9q/UtfUxFDcTRricrRlJfG7CBm/FGDH
         nCX9k+DSg1iLPUIcOGjUJK5NBYndy3xZJKJ4hwmsamtCZkY/feqN943aExk7mMVqxSOD
         M4FiveL19t01tF2dQshhxOSw/DrNa1QGR/j01+4SsITmCGVGhhRjxEuEKmCSEOrN23Uv
         lm9Vs4bJpztETdcaVobDZgxiYS6EoJ8yQixPnLGxnv267kFPaUQEE/TPw+49PdCqmi9I
         OffQ==
X-Gm-Message-State: AOAM530DyzaNrvLiYB4cx/rNWC5cGJ6EWHTMYYMiMoFAoyRHqeoBqNkF
        JAHLsplclTbW9C8CBFT5anM=
X-Google-Smtp-Source: ABdhPJxTByK+P+JhJSoMlHQ1WX8c2iVJgwDRLr2gdIKy8yj7rZGcShTonHm/9tHa2D6U6ZJKDQ4wcg==
X-Received: by 2002:a17:90a:f02:: with SMTP id 2mr4225720pjy.75.1625108949793;
        Wed, 30 Jun 2021 20:09:09 -0700 (PDT)
Received: from localhost.localdomain ([118.200.190.93])
        by smtp.gmail.com with ESMTPSA id g10sm4568568pjv.46.2021.06.30.20.09.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jun 2021 20:09:09 -0700 (PDT)
From:   Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
To:     gustavoars@kernel.org, viro@zeniv.linux.org.uk
Cc:     Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        slava@dubeyko.com, skhan@linuxfoundation.org,
        gregkh@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        syzbot+b718ec84a87b7e73ade4@syzkaller.appspotmail.com
Subject: [PATCH v2 3/3] hfs: add lock nesting notation to hfs_find_init
Date:   Thu,  1 Jul 2021 11:07:56 +0800
Message-Id: <20210701030756.58760-4-desmondcheongzx@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210701030756.58760-1-desmondcheongzx@gmail.com>
References: <20210701030756.58760-1-desmondcheongzx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Syzbot reports a possible recursive lock:
https://syzkaller.appspot.com/bug?id=f007ef1d7a31a469e3be7aeb0fde0769b18585db

This happens due to missing lock nesting information. From the logs,
we see that a call to hfs_fill_super is made to mount the hfs
filesystem. While searching for the root inode, the lock on the
catalog btree is grabbed. Then, when the parent of the root isn't
found, a call to __hfs_bnode_create is made to create the parent of
the root. This eventually leads to a call to hfs_ext_read_extent which
grabs a lock on the extents btree.

Since the order of locking is catalog btree -> extents btree, this
lock hierarchy does not lead to a deadlock.

To tell lockdep that this locking is safe, we add nesting notation to
distinguish between catalog btrees, extents btrees, and attributes
btrees (for HFS+). This has already been done in hfsplus.

Reported-and-tested-by: syzbot+b718ec84a87b7e73ade4@syzkaller.appspotmail.com
Signed-off-by: Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
Reviewed-by: Viacheslav Dubeyko <slava@dubeyko.com>
---
 fs/hfs/bfind.c | 14 +++++++++++++-
 fs/hfs/btree.h |  7 +++++++
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/fs/hfs/bfind.c b/fs/hfs/bfind.c
index 4af318fbda77..ef9498a6e88a 100644
--- a/fs/hfs/bfind.c
+++ b/fs/hfs/bfind.c
@@ -25,7 +25,19 @@ int hfs_find_init(struct hfs_btree *tree, struct hfs_find_data *fd)
 	fd->key = ptr + tree->max_key_len + 2;
 	hfs_dbg(BNODE_REFS, "find_init: %d (%p)\n",
 		tree->cnid, __builtin_return_address(0));
-	mutex_lock(&tree->tree_lock);
+	switch (tree->cnid) {
+	case HFS_CAT_CNID:
+		mutex_lock_nested(&tree->tree_lock, CATALOG_BTREE_MUTEX);
+		break;
+	case HFS_EXT_CNID:
+		mutex_lock_nested(&tree->tree_lock, EXTENTS_BTREE_MUTEX);
+		break;
+	case HFS_ATTR_CNID:
+		mutex_lock_nested(&tree->tree_lock, ATTR_BTREE_MUTEX);
+		break;
+	default:
+		return -EINVAL;
+	}
 	return 0;
 }
 
diff --git a/fs/hfs/btree.h b/fs/hfs/btree.h
index 4ba45caf5939..0e6baee93245 100644
--- a/fs/hfs/btree.h
+++ b/fs/hfs/btree.h
@@ -13,6 +13,13 @@ typedef int (*btree_keycmp)(const btree_key *, const btree_key *);
 
 #define NODE_HASH_SIZE  256
 
+/* B-tree mutex nested subclasses */
+enum hfs_btree_mutex_classes {
+	CATALOG_BTREE_MUTEX,
+	EXTENTS_BTREE_MUTEX,
+	ATTR_BTREE_MUTEX,
+};
+
 /* A HFS BTree held in memory */
 struct hfs_btree {
 	struct super_block *sb;
-- 
2.25.1

