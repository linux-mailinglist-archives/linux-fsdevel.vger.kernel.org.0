Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20D0F3B74AE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Jun 2021 16:49:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234597AbhF2Ovk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Jun 2021 10:51:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234584AbhF2Ovj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Jun 2021 10:51:39 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9FCBC061760;
        Tue, 29 Jun 2021 07:49:11 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id h4so18712098pgp.5;
        Tue, 29 Jun 2021 07:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sgedI6+6qKlLTRATOo8xiBdzNyb6QgjMf9+CiWSlKJg=;
        b=MrFm2QVZyIhOXx5Nl3OtAQV0OVWh5YFA/aNRmurlT+tEMLsAdfPgmix1dFQO5gkVlj
         SAMovFD1tS0GuqGaKMElv5SQmcgSYdKY7ZcrANkl4e+4ceVNe2/NcIz5JZSUwsYxRaNZ
         jqOt3GPtOv0IGOgn5PQ+m5ipHQATdEFYwzgHBuJZ+yfMWIoV7QFPGFda2t8A8+dbJUCs
         5IdRgpo2W2/VMNoiv3QExRd31uwZ64hFKQTiNvlSATStFt8E/U/FqfT001RhGC3C9T5z
         3kqDB0MOoOieFkDiayEJZliKHp6LFBdFv5gyrQIix79FDL8MefMDcYhGMXgyBVyNeyXp
         KR9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sgedI6+6qKlLTRATOo8xiBdzNyb6QgjMf9+CiWSlKJg=;
        b=Ol2yeVG1zMRR1nO77FQgSdGk6YowkfzkqJzOui3L4n4LLuNzeW5jAr54yRu7waGdmT
         sM8e7Qjhaez46VlIlismlpxvJSwItX3fV7g0AP2/wTZTmkNxJklBjBxnIVQg+qGkRl7O
         6+4bBzPBOh2t8riISj0b4j/yjdZr1v3qBmQIcoO5MtwIIBlD67HJVVMyY5FFFg4vuLX7
         yPLs2cCgwKw7/dyImeNDNxu+QWgTngnsqhwF7QpDmCmlIZBeKNdK8+apqvs2BW6ILWdF
         7Qzd7MvqC5qTiNfXNL08Zi1WzTNe1cSdsvZk2FYAJfOXXwmBus0D7I7WZly0DAfYTp/V
         51Kg==
X-Gm-Message-State: AOAM531+K90YMSaQ6gwELCvqPGOzUwk4OgmHpFtwi5xmdNHSZohBas94
        4GPAK9hy6RHvPMq0KfpDd44=
X-Google-Smtp-Source: ABdhPJy6/Mf+TY9SUQHW36mJKwtu1pw9KHDcq/inYizQaE1PUDI16xDfzeYl9jbuRSqnKU00XaEzIQ==
X-Received: by 2002:a63:b54:: with SMTP id a20mr29013565pgl.407.1624978151551;
        Tue, 29 Jun 2021 07:49:11 -0700 (PDT)
Received: from localhost.localdomain ([118.200.190.93])
        by smtp.gmail.com with ESMTPSA id i2sm3417262pjj.25.2021.06.29.07.49.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jun 2021 07:49:11 -0700 (PDT)
From:   Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
To:     gustavoars@kernel.org, viro@zeniv.linux.org.uk
Cc:     Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org, gregkh@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        syzbot+b718ec84a87b7e73ade4@syzkaller.appspotmail.com
Subject: [PATCH 3/3] hfs: add lock nesting notation to hfs_find_init
Date:   Tue, 29 Jun 2021 22:48:03 +0800
Message-Id: <20210629144803.62541-4-desmondcheongzx@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210629144803.62541-1-desmondcheongzx@gmail.com>
References: <20210629144803.62541-1-desmondcheongzx@gmail.com>
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

