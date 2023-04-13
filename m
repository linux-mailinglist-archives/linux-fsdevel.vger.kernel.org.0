Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F4B56E0917
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Apr 2023 10:41:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbjDMIl2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Apr 2023 04:41:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjDMIl0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Apr 2023 04:41:26 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E74286A8;
        Thu, 13 Apr 2023 01:41:25 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id la3so14112739plb.11;
        Thu, 13 Apr 2023 01:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681375284; x=1683967284;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R/tKSXJd14VMawLIxQYv8XyFgKpy9j//5eTEj3JDvMA=;
        b=YyIJ7Ton/QAEow2aJtckC1lIlyypXnanyOlCc1P3qTLQlwurZEdvoKEmUHu5ml/i5u
         xMQdRGObgFaLbWyIoD7UvvwluyKlFhrI2FNUQ98An30mQrYAfL+FYBbfOSQlLma/x2PB
         ZDdHfxDjZaUPHH/mjqC7dfrTk5r74ue3bTTdlKj60TJQ6uwGA4RiBgyPm8ZzTbZmezcO
         aCVUEPEZy8GOcYjW0rqshM6nrYZ/Pm2rKyst2tvM5tsoP0V7IkKiTxtljuFKIXYBA5vs
         k2No/2PotyUZsdMZyUNx8+ZXBkRjwqFu61s01qFLdaGig5aiTp1YpqquhhpkWj3ueI1v
         HTaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681375284; x=1683967284;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R/tKSXJd14VMawLIxQYv8XyFgKpy9j//5eTEj3JDvMA=;
        b=lIIoch3AkNaJ9VkwoJ/Sd91vqWOz4JFr8whoEiNu5eJnWHJXsdiW9UO4nHmJKoNDDy
         KpCE6lL8MSKYjr+L8TxBNarS+IQJPIOM7xv2Vew02cjtma/Ly6oYCr6ZGa40aPqRjTnI
         hGDheSNVF10hX0LcJM9aJZ8U3BA085pfG0GFDjwjCQXmEUlQIVA7AgimbrH0oROqAoV3
         WJsraoQpvZBYbRV4zVh/3QFIsuBqVr6vXNPq4X1ER93Tm8o8tXIBDfzt0vNw3T6i2GQ8
         pPfzvohMYcj56VMSoo2vbeK9Dm8j0BdIBiz2AB080v4xzDteGMBxc10pMMvp22PwrT5i
         w6Mw==
X-Gm-Message-State: AAQBX9cRNgCrMJs2gLh4X2cBP7N2qGHmfMSoixr8CJA+C4slHER5aBiK
        4cO5kd2+SIPumz9dufVZwNs1T0Elj9Q=
X-Google-Smtp-Source: AKy350ZQTECUP7uwFEK2/w30a6eRITyXMcTSsz/4BJ5NXDkwVQe1MIrU52ZfQVqzAljLH6D1v0y0OQ==
X-Received: by 2002:a05:6a20:89a8:b0:d3:72c6:b018 with SMTP id h40-20020a056a2089a800b000d372c6b018mr1161686pzg.39.1681375284573;
        Thu, 13 Apr 2023 01:41:24 -0700 (PDT)
Received: from rh-tp.. ([2406:7400:63:7035:9095:349e:5f0b:ded0])
        by smtp.gmail.com with ESMTPSA id g8-20020aa78188000000b0063b23c92d02sm817243pfi.212.2023.04.13.01.41.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Apr 2023 01:41:24 -0700 (PDT)
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Cc:     Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [RFCv3 03/10] ext4: Use __generic_file_fsync_nolock implementation
Date:   Thu, 13 Apr 2023 14:10:25 +0530
Message-Id: <334f21c733db6a9a872e91d81af18e9286a88781.1681365596.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1681365596.git.ritesh.list@gmail.com>
References: <cover.1681365596.git.ritesh.list@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

ext4 when got converted to iomap for dio, it copied __generic_file_fsync
implementation to avoid taking inode_lock in order to avoid any deadlock
(since iomap takes an inode_lock while calling generic_write_sync()).

The previous patch already added it's _nolock variant. Hence kill the
redundant code and use __generic_file_fsync_nolock() function instead.

Tested-by: Disha Goel <disgoel@linux.ibm.com>
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 fs/ext4/fsync.c | 31 +++++++++++++++----------------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/fs/ext4/fsync.c b/fs/ext4/fsync.c
index 027a7d7037a0..bf1d1b7f4ec7 100644
--- a/fs/ext4/fsync.c
+++ b/fs/ext4/fsync.c
@@ -78,21 +78,13 @@ static int ext4_sync_parent(struct inode *inode)
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
 
+	ret = __generic_file_fsync_nolock(file, start, end, datasync);
 	if (!ret)
 		ret = ext4_sync_parent(inode);
 	if (test_opt(inode->i_sb, BARRIER))
@@ -148,6 +140,14 @@ int ext4_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
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
@@ -166,13 +166,12 @@ int ext4_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
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

