Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF58F5513AA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jun 2022 11:04:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240465AbiFTJE4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Jun 2022 05:04:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240453AbiFTJEy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Jun 2022 05:04:54 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99A58DF4;
        Mon, 20 Jun 2022 02:04:53 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id k7so9180134plg.7;
        Mon, 20 Jun 2022 02:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IGedjyJtOwhuKaMc6tFtvZiQjA/4iP2eLJyYJB25T2c=;
        b=f16Ctp/rQzwImm0eOheSgm0oPUuIymrb9sJiPlfBawLu91YcBShqXugdHCfmyMmASs
         33qMCqs8aolPdlmB01FMj8LSRw12sggBcX3OrOu8NwnxcCZO4WojEj2IvX9WwQmYk3JS
         F+Jmi0y/wDCCISvnOcvcrF2RtF6QOgl4yNM+WNTCgwehgb1EUv5t6euK3DSja+Xz+JTw
         xQgXtVk4bMiLs6dRhXCO6HFQ/iCN4cHBngF70NfRkWz4vED+ByAPD0GiALEu5XUbHSXp
         tAv126OvR64bzmXqiPL+JQU0uUZvJDzHQGhpkpds6o+TEBLa4GSzoLIIxnVNjLK/iYMN
         Mj8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IGedjyJtOwhuKaMc6tFtvZiQjA/4iP2eLJyYJB25T2c=;
        b=QPkUXyvSlGPAlNSNu5qVtzKMtjrXK5DwgHGhlU6mvUwa5WNFgUsNhgYjfD4mCqfV/V
         8sgYww6P+QYk29yJayCIo2VNEqYkH1Xic3ACI4ug3zA2L3bKWbWPFs5vSi9wu3toOEhv
         AeJ/qXSlR35ob9H9OUmNDAGyKjc3GnAPehGorVxp6W8aGVBmEjzzg6s2i1FHyumMmV96
         JFfjnHw0z4WkgGZSUZF3a1N1n0SrlW7NyUatYbwY5LruBcIlE2VFxYbu2QbXTcJC+z7p
         BuwgDUllZwzlP1N6xVVU93PePvZkHazbSdf+odauk38u1tH8+V/J3LWK8k/DwplG9QRt
         2m5Q==
X-Gm-Message-State: AJIora9Cux24RDCxr5neHkMXTek/7VBoLY8j6Zy3M+Pk3SVvRQb6qCtP
        B8Gntu7BMTJqPgXwLukVdfDXWO+V6PU=
X-Google-Smtp-Source: AGRyM1uJ05tB7F46GdOnpfPTix+8IlPfQMhu0Hw6oIcsFs+XaQtmsV6Drgm2z5mdzoIQ96Su3UCyhg==
X-Received: by 2002:a17:90b:1b10:b0:1e8:2966:3232 with SMTP id nu16-20020a17090b1b1000b001e829663232mr36765228pjb.103.1655715892967;
        Mon, 20 Jun 2022 02:04:52 -0700 (PDT)
Received: from localhost ([2406:7400:63:5d34:e6c2:4c64:12ae:aa11])
        by smtp.gmail.com with ESMTPSA id g23-20020a17090a579700b001eaec814132sm8770115pji.3.2022.06.20.02.04.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 02:04:52 -0700 (PDT)
From:   Ritesh Harjani <ritesh.list@gmail.com>
To:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     Jan Kara <jack@suse.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>,
        Ritesh Harjani <ritesh.list@gmail.com>
Subject: [PATCHv2 1/4] jbd2: Drop useless return value of submit_bh
Date:   Mon, 20 Jun 2022 14:34:34 +0530
Message-Id: <57b9cb59e50dfdf68eef82ef38944fbceba4e585.1655715329.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1655715329.git.ritesh.list@gmail.com>
References: <cover.1655715329.git.ritesh.list@gmail.com>
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
Signed-off-by: Ritesh Harjani <ritesh.list@gmail.com>
---
 fs/jbd2/commit.c  | 11 +++++------
 fs/jbd2/journal.c |  6 ++----
 2 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/fs/jbd2/commit.c b/fs/jbd2/commit.c
index eb315e81f1a6..688fd960d01f 100644
--- a/fs/jbd2/commit.c
+++ b/fs/jbd2/commit.c
@@ -122,8 +122,8 @@ static int journal_submit_commit_record(journal_t *journal,
 {
 	struct commit_header *tmp;
 	struct buffer_head *bh;
-	int ret;
 	struct timespec64 now;
+	int write_flags = REQ_SYNC;

 	*cbh = NULL;

@@ -155,13 +155,12 @@ static int journal_submit_commit_record(journal_t *journal,

 	if (journal->j_flags & JBD2_BARRIER &&
 	    !jbd2_has_feature_async_commit(journal))
-		ret = submit_bh(REQ_OP_WRITE,
-			REQ_SYNC | REQ_PREFLUSH | REQ_FUA, bh);
-	else
-		ret = submit_bh(REQ_OP_WRITE, REQ_SYNC, bh);
+		write_flags |= REQ_PREFLUSH | REQ_FUA;
+
+	submit_bh(REQ_OP_WRITE, write_flags, bh);

 	*cbh = bh;
-	return ret;
+	return 0;
 }

 /*
diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index c0cbeeaec2d1..81a282e676bc 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -1606,7 +1606,7 @@ static int jbd2_write_superblock(journal_t *journal, int write_flags)
 {
 	struct buffer_head *bh = journal->j_sb_buffer;
 	journal_superblock_t *sb = journal->j_superblock;
-	int ret;
+	int ret = 0;

 	/* Buffer got discarded which means block device got invalidated */
 	if (!buffer_mapped(bh)) {
@@ -1636,14 +1636,12 @@ static int jbd2_write_superblock(journal_t *journal, int write_flags)
 		sb->s_checksum = jbd2_superblock_csum(journal, sb);
 	get_bh(bh);
 	bh->b_end_io = end_buffer_write_sync;
-	ret = submit_bh(REQ_OP_WRITE, write_flags, bh);
+	submit_bh(REQ_OP_WRITE, write_flags, bh);
 	wait_on_buffer(bh);
 	if (buffer_write_io_error(bh)) {
 		clear_buffer_write_io_error(bh);
 		set_buffer_uptodate(bh);
 		ret = -EIO;
-	}
-	if (ret) {
 		printk(KERN_ERR "JBD2: Error %d detected when updating "
 		       "journal superblock for %s.\n", ret,
 		       journal->j_devname);
--
2.35.3

