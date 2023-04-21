Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD2B06EA77D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Apr 2023 11:47:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232118AbjDUJrb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Apr 2023 05:47:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232040AbjDUJrY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Apr 2023 05:47:24 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B5B5B76F;
        Fri, 21 Apr 2023 02:46:47 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-63b5465fb99so1817631b3a.1;
        Fri, 21 Apr 2023 02:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682070398; x=1684662398;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lBzbpAT6GWFJ1E3/348QGYQinhR9T2h2jmeonxN6r48=;
        b=c1UMZGuFljMyz1y7sLgBz/d+a4UgIEANJsKbvvKqMBQWr9o8nNf/NvVMhsxWvaSudm
         5lGftvcw46701xICjUTnnYCbZhIb4XnKqSTzGRGAo3McoDcOVvfbb/l1c96MM5IcLxaw
         oj985KaiIYFDk1ySojMHOOeyefu/VhcxI+LYwKCHhvm4l1Q2MuGZRskFY0xlOgFkemCD
         ZEb4EkhBZ8MtvzdWavSKimCoy96kgM6mFDFlb1BRGDYTpKNwr+24AJIlINgbJEeB5ad2
         4ZT/A7w0+sMPhUE/qUxVHqm+2DyhLEhkXPPcsF21Kb9102VO6EfXQoJVU9IFkySvm+qV
         U4ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682070398; x=1684662398;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lBzbpAT6GWFJ1E3/348QGYQinhR9T2h2jmeonxN6r48=;
        b=RRiJ/xlaFdiwCGYAC79kCmiZtZppbi3nx9hP7LRxXHV5cJFb2ZBawurTFUTyz9x5c5
         W/kHuni8bCHqLyllp81iepuaY7j3bhlnP/ciunfTwBmTGMi48gLDcz1ig3KdDzkb3KKd
         45mOHvLJAJafzZnbUVSaUYrW4n0Ui+vRVieN+A9k92kmVJbYGclma9E6g30JP/oYfxcB
         t/KroQ1zGHCNHLDYywpFZdcJrAQFKDtQ7a+V8ZYDa4iPEE+gUf7oJqabcBR8JWr8Jvv0
         gOU1nWW87Y8xhVv3Ti+MXJaKVkTWw5ZF/qnxgn5y5c8wG3Ltmx5tfLRmLjHwGq7xwjZJ
         Rakg==
X-Gm-Message-State: AAQBX9cDlcLvDwBvls9ZPrVOcFRI3SghORaILbEADSZZLwCxOGgvke2T
        s/5/Xj8NV2oof6WA+ark0P9g7KEftkc=
X-Google-Smtp-Source: AKy350Y/HjV/L3J1yn5zP6eEBwyhsyWV2XgEijGuFY9gEU7WxSb3fRSl/5zIBwg7a9Z1bjRxpK6C6Q==
X-Received: by 2002:a05:6a20:8f1b:b0:ef:e440:8aac with SMTP id b27-20020a056a208f1b00b000efe4408aacmr6397552pzk.39.1682070397719;
        Fri, 21 Apr 2023 02:46:37 -0700 (PDT)
Received: from rh-tp.. ([2406:7400:63:2dd2:8818:e6e1:3a73:368c])
        by smtp.gmail.com with ESMTPSA id w35-20020a631623000000b0051f15c575fesm2295376pgl.87.2023.04.21.02.46.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 02:46:37 -0700 (PDT)
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Cc:     Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [PATCHv6 3/9] ext4: Use generic_buffers_fsync_noflush() implementation
Date:   Fri, 21 Apr 2023 15:16:13 +0530
Message-Id: <b43d4bb4403061ed86510c9587673e30a461ba14.1682069716.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1682069716.git.ritesh.list@gmail.com>
References: <cover.1682069716.git.ritesh.list@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

ext4 when got converted to iomap for dio, it copied __generic_file_fsync
implementation to avoid taking inode_lock in order to avoid any deadlock
(since iomap takes an inode_lock while calling generic_write_sync()).

The previous patch already added generic_buffers_fsync*() which does not
take any inode_lock(). Hence kill the redundant code and use
generic_buffers_fsync_noflush() function instead.

Tested-by: Disha Goel <disgoel@linux.ibm.com>
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 fs/ext4/fsync.c | 33 ++++++++++++++++-----------------
 1 file changed, 16 insertions(+), 17 deletions(-)

diff --git a/fs/ext4/fsync.c b/fs/ext4/fsync.c
index f65fdb27ce14..9cd71d76622d 100644
--- a/fs/ext4/fsync.c
+++ b/fs/ext4/fsync.c
@@ -28,6 +28,7 @@
 #include <linux/sched.h>
 #include <linux/writeback.h>
 #include <linux/blkdev.h>
+#include <linux/buffer_head.h>
 
 #include "ext4.h"
 #include "ext4_jbd2.h"
@@ -78,21 +79,13 @@ static int ext4_sync_parent(struct inode *inode)
 	return ret;
 }
 
-static int ext4_fsync_nojournal(struct inode *inode, bool datasync,
-				bool *needs_barrier)
+static int ext4_fsync_nojournal(struct file *file, loff_t start, loff_t end,
+				int datasync, bool *needs_barrier)
 {
-	int ret, err;
-
-	ret = sync_mapping_buffers(inode->i_mapping);
-	if (!(inode->i_state & I_DIRTY_ALL))
-		return ret;
-	if (datasync && !(inode->i_state & I_DIRTY_DATASYNC))
-		return ret;
-
-	err = sync_inode_metadata(inode, 1);
-	if (!ret)
-		ret = err;
+	struct inode *inode = file->f_inode;
+	int ret;
 
+	ret = generic_buffers_fsync_noflush(file, start, end, datasync);
 	if (!ret)
 		ret = ext4_sync_parent(inode);
 	if (test_opt(inode->i_sb, BARRIER))
@@ -148,6 +141,14 @@ int ext4_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
 		goto out;
 	}
 
+	if (!sbi->s_journal) {
+		ret = ext4_fsync_nojournal(file, start, end, datasync,
+					   &needs_barrier);
+		if (needs_barrier)
+			goto issue_flush;
+		goto out;
+	}
+
 	ret = file_write_and_wait_range(file, start, end);
 	if (ret)
 		goto out;
@@ -157,11 +158,9 @@ int ext4_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
 	 *  Metadata is in the journal, we wait for proper transaction to
 	 *  commit here.
 	 */
-	if (!sbi->s_journal)
-		ret = ext4_fsync_nojournal(inode, datasync, &needs_barrier);
-	else
-		ret = ext4_fsync_journal(inode, datasync, &needs_barrier);
+	ret = ext4_fsync_journal(inode, datasync, &needs_barrier);
 
+issue_flush:
 	if (needs_barrier) {
 		err = blkdev_issue_flush(inode->i_sb->s_bdev);
 		if (!ret)
-- 
2.39.2

