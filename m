Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B7123C8B3F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jul 2021 20:47:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240144AbhGNSue (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Jul 2021 14:50:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240130AbhGNSud (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Jul 2021 14:50:33 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8B0CC06175F
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Jul 2021 11:47:40 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id 23so2664391qke.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Jul 2021 11:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=4ITw8yYO9Mm2EpdRdd+ThoxB7QMMRcOH9aOSdlmSits=;
        b=0rpJPuMJ1jxhCoRWOAqTZd6zN/yZv7cGsws/5dyp0RPDk5yGbj3aBRIrSXG5WLEm6D
         AxDz3lCAE0gwoY2j8jeNE1ZTslQyXzhZeq4ftXR/so2xCGycfCU8TCs/rALNRCy0t68+
         4rGgxude/xhKypgjI6AKyq4JOrkW6Qf+pOaivIPu8dKAWPcAyF5zJPmwrztwNvkbriEV
         81IrJhs75XLjqXeEu6aR0tyL7022zW1xMPmIeGdyGQIVcz5uBOqIaPvr/+RhuKWFKJAl
         xY5gJvSUE4YkhnXXrSkpOHzKTucWnyA07TJ+iBTYvZANoaeVKLZe9d8v1bVkwcczpOPO
         p9JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4ITw8yYO9Mm2EpdRdd+ThoxB7QMMRcOH9aOSdlmSits=;
        b=DQ1FdAzBJyCp0nfuR/jFHFeRrIxDxd+tLBoOiL2bZCXhGWAaGcgTr7igN9Z/if/AeY
         NRZB7bj2O+K4X3r4fv7TiLLqxXjhT8rbrUXNW5mR0sVZEu+ylLGE0Zjpu7kAtrJ0fKGl
         euXVpILIhXwkW0XblUsmbw891I5zqpX8H6YnigAwiL1ssCgaXy6KxK/W8R20uMWKPBK6
         zlqgeLvP7TiyOzxuVqgbk4odM6chq/E+/VkzdE+YyxaY3SpQihy0lHekdoVF0W4TF3PT
         z/Qq2WU0il0E82xGq992UZpDzY6Q7M0Yk93lvTPX43UPpORsMRIInDhMYTomZKLDM6aq
         0MpA==
X-Gm-Message-State: AOAM532zz5XuaGI/52ASJuMRUVYlp18Zz1oherQ8YifY9RGeH/iW2xo5
        b+MGaow+pKMDOdndYJA5bC7hag==
X-Google-Smtp-Source: ABdhPJyHX8vfDY4LWszZXONESfbhQmTh2Tw5hDSZy+QhAXwh7eUT/aSKeHlokFDKQEnjjyU0cySG+A==
X-Received: by 2002:a37:a413:: with SMTP id n19mr7494248qke.462.1626288460075;
        Wed, 14 Jul 2021 11:47:40 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id bk40sm1312434qkb.3.2021.07.14.11.47.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 11:47:39 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 9/9] fs: kill sync_inode
Date:   Wed, 14 Jul 2021 14:47:25 -0400
Message-Id: <8c4c75ad09fb61114ee955829860ce8fd5e170ee.1626288241.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1626288241.git.josef@toxicpanda.com>
References: <cover.1626288241.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Now that all users of sync_inode() have been deleted, remove
sync_inode().

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/fs-writeback.c  | 19 +------------------
 include/linux/fs.h |  1 -
 2 files changed, 1 insertion(+), 19 deletions(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index e91980f49388..706dad22f735 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -2608,23 +2608,6 @@ int write_inode_now(struct inode *inode, int sync)
 }
 EXPORT_SYMBOL(write_inode_now);
 
-/**
- * sync_inode - write an inode and its pages to disk.
- * @inode: the inode to sync
- * @wbc: controls the writeback mode
- *
- * sync_inode() will write an inode and its pages to disk.  It will also
- * correctly update the inode on its superblock's dirty inode lists and will
- * update inode->i_state.
- *
- * The caller must have a ref on the inode.
- */
-int sync_inode(struct inode *inode, struct writeback_control *wbc)
-{
-	return writeback_single_inode(inode, wbc);
-}
-EXPORT_SYMBOL(sync_inode);
-
 /**
  * sync_inode_metadata - write an inode to disk
  * @inode: the inode to sync
@@ -2641,6 +2624,6 @@ int sync_inode_metadata(struct inode *inode, int wait)
 		.nr_to_write = 0, /* metadata-only */
 	};
 
-	return sync_inode(inode, &wbc);
+	return writeback_single_inode(inode, &wbc);
 }
 EXPORT_SYMBOL(sync_inode_metadata);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index aace07f88b73..7c33e5414747 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2458,7 +2458,6 @@ static inline void file_accessed(struct file *file)
 
 extern int file_modified(struct file *file);
 
-int sync_inode(struct inode *inode, struct writeback_control *wbc);
 int sync_inode_metadata(struct inode *inode, int wait);
 
 struct file_system_type {
-- 
2.26.3

