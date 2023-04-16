Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93CF66E36EE
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Apr 2023 12:09:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229987AbjDPKJV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 16 Apr 2023 06:09:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229827AbjDPKJH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 16 Apr 2023 06:09:07 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A428E1;
        Sun, 16 Apr 2023 03:09:05 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-63b50a02bffso929710b3a.2;
        Sun, 16 Apr 2023 03:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681639744; x=1684231744;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cy+/pZaqvES6mObQuwzhCbnK8v685tx7A3EGdbbD7vE=;
        b=sFVOCZvgOoyY9NGPPtB0d+zQyuvyGVVB8xuvCqdMph1GwbNTgjBemAntLoEPebFRIm
         GPHjB5clBKS6OYqYxQAVpMLmO7elE10NZGRec6i0RlE4jufv4Kc0Y3pdFmsCn/ah85Li
         OIRT2wzCKnvvVN/Dczf4KICJHzpjaApOckevPaJzsa2paQCrFIZpc7MTiTgQpCOs+7L1
         RyI7aq9aQ7nB7LccavTQV08dpoc6QuOuOzoeHEXs1PEuwhh0DuHR1pFdPPw+gVDxiJIf
         uB18h3Be3uu+LfCyX5NHm72sKwRflbZJz7r2hXy+z1nGf1ULiYCgdTNphj2TedGec9L/
         u+7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681639744; x=1684231744;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cy+/pZaqvES6mObQuwzhCbnK8v685tx7A3EGdbbD7vE=;
        b=gafHpcr1NIdXRpaqYT4vWESJdrGA/T46BD2UXPVh7xV3R4edazaIVfWj6vLIBdceKy
         QGGoZbiO1oXrDL6Hj/Nk4QpYlHkIJFG7jZiKzpek9W6LosZl86h2mvfZqLb1i52XK/fX
         9rMfPuBDNeKpTNLpD6bXlfhLT/otwHAraj0ij7oKxAq7egbc1F7lGPTh1CQIC/Logwap
         TnS8L9QtnmWM7tHwYWzQlgaBiPsXU7Sv01ckW866NNukoPUEFmRXYVfdcuQlsgsPrZFW
         ZgoHdQW06AczvaGsQHPhTsc8kJgpiTDbocfUHeWmuGqT5KvfzMYCeoE5/wOV3CtWw0Zb
         r3ew==
X-Gm-Message-State: AAQBX9eX45H4XuhGwDBgNCe8xrIl52t/gCQ7Jm8O+A6vA1i2Jq03c5/P
        IVMte+71dih/DKvqDQNvaYPXELDxKr4=
X-Google-Smtp-Source: AKy350YPPRFuYdRRKfO/ois0GaE0E95dQk5+0qpmEwEF9DOxttlAH/mb8h3txeLe4nRmSlaRuW6+CQ==
X-Received: by 2002:a05:6a00:1306:b0:63b:435f:134a with SMTP id j6-20020a056a00130600b0063b435f134amr15120915pfu.28.1681639744695;
        Sun, 16 Apr 2023 03:09:04 -0700 (PDT)
Received: from rh-tp.. ([2406:7400:63:2dd2:1827:1d70:2273:8ee0])
        by smtp.gmail.com with ESMTPSA id h9-20020aa786c9000000b0063b733fdd33sm3096057pfo.89.2023.04.16.03.09.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Apr 2023 03:09:04 -0700 (PDT)
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Cc:     Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [PATCHv5 3/9] ext4: Use generic_buffer_fsync() implementation
Date:   Sun, 16 Apr 2023 15:38:38 +0530
Message-Id: <5dc8b7ad59fe836e72d5408261470f3b4caaebb2.1681639164.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1681639164.git.ritesh.list@gmail.com>
References: <cover.1681639164.git.ritesh.list@gmail.com>
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

