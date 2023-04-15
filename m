Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77E426E2F85
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Apr 2023 09:45:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbjDOHo5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 15 Apr 2023 03:44:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbjDOHow (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 15 Apr 2023 03:44:52 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD3738A5E;
        Sat, 15 Apr 2023 00:44:47 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-51b514a8424so442013a12.1;
        Sat, 15 Apr 2023 00:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681544687; x=1684136687;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cy+/pZaqvES6mObQuwzhCbnK8v685tx7A3EGdbbD7vE=;
        b=HHDTBjl51tdnyl/bgJ4jslA6NFKk+j7wrfQh4wmRk61cWn/vb+JZKL4R0rJ4vpGe0d
         H+8KAWPfy6JNBfQqBpUO/hPR4Lmjr7+KCZkxzYOZ3MqzGAqP5KbPILBnxwOS1cNGFZV1
         hx1SvoQC/fnZbx/1s0l60DAsiEKocoYuZDTieFKOwjQOhukwLlOpIslFcbvrMbkbRV/f
         fQaVisaPQevsW0L7Bjczxe77D+ZZ3e9aL6fhmsr75ZxPfmZZ0qWyI/lOOikvSII0Nzng
         m4bDjnsKJUJ/vqLVgHDiCRk4bkGNqsyEDPGNZrnu+GmPD9wMVgyZsJ0vjfQJg4pYahwV
         5cuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681544687; x=1684136687;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cy+/pZaqvES6mObQuwzhCbnK8v685tx7A3EGdbbD7vE=;
        b=N8IshrsVt7pVw1AaNQaN1i/krm4i94VVQWv5DmW59WcOQS9yIILziinpYN1FLwe5Vn
         KWUrnKRFj5eP1Nb7no92hsmRQAfK35Zl7Vbw4YwBn55yFnjxQvZsNSuXcB9z7jwxU19L
         aRPwCdGohLEgJMTlrQ8eOaurdBDfiW945rXvd7jUl/bYjWjVtsl7s/A/JQZogbTWa0r6
         kfNl09Lit3Q3wDRAIYal+emAiJ6E7nzOvOsBqKZk5dpuzokAJSoFX0QeWDruqwEC8/3u
         C1i0JGZj7ySkrFOXwMfBG4EBhw2Gs58/wC9+xgkeOobft62QvBnUVtvC+toXa1ldOc6O
         QM6g==
X-Gm-Message-State: AAQBX9cy8jJxXaEgz5IN+f+r4n9n8VYeHARYXiUrbhXvr1kqM3MR+xJa
        jy4DCnF5b5T3QgCCM/YTumhGcnJwvj8=
X-Google-Smtp-Source: AKy350bkRSa5QvV4TPqBzo8ysEia+irgvscjVC6wFL+vx5+TcBFsGRWpHM5eTvuptGRUD9YsTtPyzA==
X-Received: by 2002:a05:6a00:22d4:b0:63b:7ab1:6c48 with SMTP id f20-20020a056a0022d400b0063b7ab16c48mr1967987pfj.6.1681544686893;
        Sat, 15 Apr 2023 00:44:46 -0700 (PDT)
Received: from rh-tp.. ([2406:7400:63:2dd2:1827:1d70:2273:8ee0])
        by smtp.gmail.com with ESMTPSA id e21-20020aa78255000000b0063b675f01a5sm2338789pfn.11.2023.04.15.00.44.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Apr 2023 00:44:46 -0700 (PDT)
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Cc:     Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [RFCv4 3/9] ext4: Use generic_buffer_fsync() implementation
Date:   Sat, 15 Apr 2023 13:14:24 +0530
Message-Id: <9622b68c186c364b54269ad67ff0efb72227a29e.1681544352.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1681544352.git.ritesh.list@gmail.com>
References: <cover.1681544352.git.ritesh.list@gmail.com>
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

The previous patch already added generic_buffer_fsync() which does not
take any inode_lock(). Hence kill the redundant code and use
generic_buffer_fsync() function instead.

Tested-by: Disha Goel <disgoel@linux.ibm.com>
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 fs/ext4/fsync.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/fs/ext4/fsync.c b/fs/ext4/fsync.c
index 027a7d7037a0..4f2af43f8b0f 100644
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
 
+	ret = generic_buffer_fsync(file, start, end, datasync);
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
@@ -166,13 +167,12 @@ int ext4_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
 	 *  (they were dirtied by commit).  But that's OK - the blocks are
 	 *  safe in-journal, which is all fsync() needs to ensure.
 	 */
-	if (!sbi->s_journal)
-		ret = ext4_fsync_nojournal(inode, datasync, &needs_barrier);
-	else if (ext4_should_journal_data(inode))
+	if (ext4_should_journal_data(inode))
 		ret = ext4_force_commit(inode->i_sb);
 	else
 		ret = ext4_fsync_journal(inode, datasync, &needs_barrier);
 
+issue_flush:
 	if (needs_barrier) {
 		err = blkdev_issue_flush(inode->i_sb->s_bdev);
 		if (!ret)
-- 
2.39.2

