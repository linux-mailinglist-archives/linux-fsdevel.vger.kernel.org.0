Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5284A6DD186
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Apr 2023 07:22:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229987AbjDKFWZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Apr 2023 01:22:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbjDKFWU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Apr 2023 01:22:20 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94BDEE7C;
        Mon, 10 Apr 2023 22:22:19 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id 20so8590741plk.10;
        Mon, 10 Apr 2023 22:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681190539; x=1683782539;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lbvQRul9VyzVoBsE0fT4D8dcjtJNGy+0IdeJjunpvvs=;
        b=ZJZ6P11JNuLJzywC/vHvuTXtd4Aq32nDSc0wwKpVbZRwjOS+dBZuAdKiB+HxKeOZ2m
         L2YIFy8QnQTRLNDvcqzKNpAtsIgxMcoAs15mo7jlNWUAY2rpCJimoZ32BgALkehaYYEb
         LppjGt00SsnhAaX0MO9f+YAIEUax9gftUnPnJ2R5/OSi1HzY11Wlf4Rbw8EwncZi9ZT7
         xAHewv7uy9rKSpVH+aH/OPwqR4XnEOKqEWJXAXbNOIO+ec2jaeyhv+k5CtjgHEaHVPxj
         x1HrNeCk/rAw9N2BVBvebClvsp5gbMsFt/nzlqaNUFgbIPG537zpy4+atddyDHfadBjO
         JALg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681190539; x=1683782539;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lbvQRul9VyzVoBsE0fT4D8dcjtJNGy+0IdeJjunpvvs=;
        b=D0frfI2WZdz0Hsiw50O52/iIJ90KUT5ALsrbjtOh09ysdIf98p7nW2vi54aph36f7J
         j1L/QPUmSmAUlpKqqCVw7hVuGOFi5P+/JZNS7MKNlikdIOhxGwcrKCxTthk3k3lunStk
         9CEvwdcI9xJ2mXkpAgaeC5Oe9vievxI4INtnt1ctnLHfsmVyCjHF9DB9pF++omGbmwOz
         mzTY5wqPMJslfQGWpRR4WkH+eoIfP2vKxmbXkuN8jY1Kb31E0kmPcjgWkwaLS64f2OgM
         rEkFKf59lOXsbPN755tks7jePkHSOUSPhcILUirY84UEcLv2hqilqnkim9/5Nh3Lv7i0
         UM6g==
X-Gm-Message-State: AAQBX9exk+fyYVcLLOqHw25YBZOPG6Ky1anUknOiA/yGF8AfPc/UB6IY
        1z4EiHcayivmMkp+FE0Xl8YPpKHxq1c=
X-Google-Smtp-Source: AKy350a8aTIYaAlhQ3+fLLc5UAq+h8rXIoKFnNtQUAGes+1MJkabSiPtxHtaIPZBaz6vXJky8j55NQ==
X-Received: by 2002:a17:90b:4d87:b0:23a:ad68:25a7 with SMTP id oj7-20020a17090b4d8700b0023aad6825a7mr12962914pjb.2.1681190538736;
        Mon, 10 Apr 2023 22:22:18 -0700 (PDT)
Received: from rh-tp.ibmuc.com ([2406:7400:63:7035:9095:349e:5f0b:ded0])
        by smtp.gmail.com with ESMTPSA id v19-20020a17090abb9300b00246d7cd7327sm646154pjr.51.2023.04.10.22.22.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Apr 2023 22:22:18 -0700 (PDT)
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Cc:     Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [RFCv2 3/8] ext4: Use __generic_file_fsync_nolock implementation
Date:   Tue, 11 Apr 2023 10:51:51 +0530
Message-Id: <6a9963885f0872e0ab774283f3ba1b0061ad11ac.1681188927.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1681188927.git.ritesh.list@gmail.com>
References: <cover.1681188927.git.ritesh.list@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
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

