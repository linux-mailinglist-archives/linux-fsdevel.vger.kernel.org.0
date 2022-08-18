Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A254597DD8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Aug 2022 07:08:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243118AbiHRFFL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Aug 2022 01:05:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242769AbiHRFFG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Aug 2022 01:05:06 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79D869F1B6;
        Wed, 17 Aug 2022 22:05:04 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id jm11so579839plb.13;
        Wed, 17 Aug 2022 22:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=CIXPojNt+yIDbPYg2qBN1uuNsthwKBFWVWuxVjGTqgo=;
        b=TRzMhtMr+7LC87xERlKGV5G6CxzQx5xbGT9HbWz+Gnh28ZyzkvcbsRPRjazJEIfiPk
         OchvFk0j2y8dQA88uW4rT4kDzx19T1pUsNZTk0MmswMmjf+7h4D+dWq1lTTjhjcPJ5wB
         nEzMroSn59Bcyv5lVTp17tbHffMFvptE4IG9vpy2Vc5NH43IpTuAGu8UoS4ZY5OOAs4C
         52QKxhNOeeYFJ+RfiJa44rn6QxL3GzYy7YfHwhkr/vobUhRYio1ywP8+xrhQ4H1WEIlo
         Z8Sv4XRhLzksyrD29r08JtoRZkrFEjnasi7Dp4jqFmClN8/q9FN6OfT0vEs35q+EyXVq
         Tb7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=CIXPojNt+yIDbPYg2qBN1uuNsthwKBFWVWuxVjGTqgo=;
        b=tbOF1zF/n/MrSHnrkGKyHdBvKPF1ki9O6k80cpqASgYqbiiB101RN7OX4U4kuOeq2w
         hu1xH0tjHCScL2QbVEBa7W3EHipaLJZNMesnDRFjq7mHiykuCN+qErp0d7fZMTm7M1bx
         yQ8KlW3c0fFsViNR2by4opeYxZoQnZqu9SWsT/fYNeBy1itld4WkBzN7Lat/WJ3sFxR6
         QAT1eVlCwJgf5k5bfnDc/ZMjPKkHm894gIvYaZkuYtqqRN7tIqKJPINTdVr+BMIJ0CZ1
         ZpEWaOtxBpNAuS4uUXT6uDINau4PwHn0D2obHr9mlMtpUKhrntJEJ9kYFt7ZZnSLaly/
         9oaQ==
X-Gm-Message-State: ACgBeo1chpgMQF16Zcmt+VbvOXmWIGy0avf+DEwZBHJNsVS0DfLetyIW
        m7sSLFtZFTBP+1Sf9zo2ts+wGk/5CNw=
X-Google-Smtp-Source: AA6agR6AL0hNqRWZBg/FFHYRTLG1VbwkZ8VSQJ/nomhHtQdOhWavTe/L/Dc9wFHjH4XDt5Vf6166vg==
X-Received: by 2002:a17:902:dac9:b0:172:af95:2db4 with SMTP id q9-20020a170902dac900b00172af952db4mr1414037plx.70.1660799103779;
        Wed, 17 Aug 2022 22:05:03 -0700 (PDT)
Received: from localhost ([2406:7400:63:e947:599c:6cd1:507f:801e])
        by smtp.gmail.com with ESMTPSA id j8-20020a170902da8800b0016edff78844sm330530plx.277.2022.08.17.22.05.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 22:05:03 -0700 (PDT)
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     Jan Kara <jack@suse.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>,
        linux-ntfs-dev@lists.sourceforge.net,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Jan Kara <jack@suse.cz>
Subject: [PATCHv3 1/4] jbd2: Drop useless return value of submit_bh
Date:   Thu, 18 Aug 2022 10:34:37 +0530
Message-Id: <e069c0539be0aec61abcdc6f6141982ec85d489d.1660788334.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1660788334.git.ritesh.list@gmail.com>
References: <cover.1660788334.git.ritesh.list@gmail.com>
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

submit_bh always returns 0. This patch cleans up 2 of it's caller
in jbd2 to drop submit_bh's useless return value.
Once all submit_bh callers are cleaned up, we can make it's return
type as void.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 fs/jbd2/commit.c  | 10 ++++------
 fs/jbd2/journal.c |  9 ++++-----
 2 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/fs/jbd2/commit.c b/fs/jbd2/commit.c
index b2b2bc9b88d9..6b51d2dc56e2 100644
--- a/fs/jbd2/commit.c
+++ b/fs/jbd2/commit.c
@@ -122,8 +122,8 @@ static int journal_submit_commit_record(journal_t *journal,
 {
 	struct commit_header *tmp;
 	struct buffer_head *bh;
-	int ret;
 	struct timespec64 now;
+	blk_opf_t write_flags = REQ_OP_WRITE | REQ_SYNC;
 
 	*cbh = NULL;
 
@@ -155,13 +155,11 @@ static int journal_submit_commit_record(journal_t *journal,
 
 	if (journal->j_flags & JBD2_BARRIER &&
 	    !jbd2_has_feature_async_commit(journal))
-		ret = submit_bh(REQ_OP_WRITE | REQ_SYNC | REQ_PREFLUSH |
-				REQ_FUA, bh);
-	else
-		ret = submit_bh(REQ_OP_WRITE | REQ_SYNC, bh);
+		write_flags |= REQ_PREFLUSH | REQ_FUA;
 
+	submit_bh(write_flags, bh);
 	*cbh = bh;
-	return ret;
+	return 0;
 }
 
 /*
diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index 6350d3857c89..f669ae1ff7a2 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -1606,7 +1606,7 @@ static int jbd2_write_superblock(journal_t *journal, blk_opf_t write_flags)
 {
 	struct buffer_head *bh = journal->j_sb_buffer;
 	journal_superblock_t *sb = journal->j_superblock;
-	int ret;
+	int ret = 0;
 
 	/* Buffer got discarded which means block device got invalidated */
 	if (!buffer_mapped(bh)) {
@@ -1636,7 +1636,7 @@ static int jbd2_write_superblock(journal_t *journal, blk_opf_t write_flags)
 		sb->s_checksum = jbd2_superblock_csum(journal, sb);
 	get_bh(bh);
 	bh->b_end_io = end_buffer_write_sync;
-	ret = submit_bh(REQ_OP_WRITE | write_flags, bh);
+	submit_bh(REQ_OP_WRITE | write_flags, bh);
 	wait_on_buffer(bh);
 	if (buffer_write_io_error(bh)) {
 		clear_buffer_write_io_error(bh);
@@ -1644,9 +1644,8 @@ static int jbd2_write_superblock(journal_t *journal, blk_opf_t write_flags)
 		ret = -EIO;
 	}
 	if (ret) {
-		printk(KERN_ERR "JBD2: Error %d detected when updating "
-		       "journal superblock for %s.\n", ret,
-		       journal->j_devname);
+		printk(KERN_ERR "JBD2: I/O error when updating journal superblock for %s.\n",
+				journal->j_devname);
 		if (!is_journal_aborted(journal))
 			jbd2_journal_abort(journal, ret);
 	}
-- 
2.35.3

