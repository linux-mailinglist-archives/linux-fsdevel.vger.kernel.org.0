Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0510A550FE6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jun 2022 07:59:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238407AbiFTF7d (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Jun 2022 01:59:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238399AbiFTF7c (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Jun 2022 01:59:32 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAAE8DF9B;
        Sun, 19 Jun 2022 22:59:31 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id p5so3477954pjt.2;
        Sun, 19 Jun 2022 22:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Dnr960qYxA6UYyUxCbuhVR96hMUWIp2ji8PopCctuLU=;
        b=Wl6kiBUznii/2rYkU/1Zxwa7/7osUmh8SDL6VDObtNhM55aEWaW4g/hYF1p4/IhzSo
         0YStTRq53FPmkiXsOUFWtEP/4IThAKEDlW1N/lv+3oa/wE8vZ5ej7hLMyki6c/+n2lXX
         TcvSnJPwJyuBVpgS7A8s7xWm5DK5SbRuB8s0Zi0o2gV+RQs6nPTWp5QRZmhDVamAGeG6
         ALRROg/GgDxY9xJ8rAPLtV6Z6I0/JOcRG/jGgG+yxshdFVS6gMKSrVSXMXfLOJrRylQr
         7c6uwVHA94yYVDLZ7rnWy4SwV2/GosGcNdYOb6txXnqfjKtW625F9aK9zvBKcDDxIs0A
         oenw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Dnr960qYxA6UYyUxCbuhVR96hMUWIp2ji8PopCctuLU=;
        b=LxamDfumLAmOUoCOJH3j8Hlpqc1hSqhpmE5Q5+Di5L9uRtg9g+9Rh145hfTSilaN20
         9/xz6nkVPDaZbp95e995FhPKZpUjJ3R4XjQhLXjMTaQXyg0+VmM49nTGdXPphaogZpek
         fOw7XD+/9eKb0foVV+b4rAsRwEfhxA4tGFKBj1/xm7uP9eh2wwH0eLNFcoQvq/CE90di
         VVWzn9ghvwrtcFom/jp+gHNdRsKwRE7jwYXI4tjj42W/i1VAVuo7jMmyAwds27E/+STF
         8x+I/NRKlGwwFGDWKAEugYKy+n4MEV41x53cVbHTsHkhVbrrbaaohnkuWsDRD27FnpOF
         Go7w==
X-Gm-Message-State: AJIora+bQk5qqA8NecJjpC/8xJ4wRztE4LDAFU3PDRa85szMRCW3gMIX
        eUlpsLCaxkcP54DFEeiF7N5CUnguLs4=
X-Google-Smtp-Source: AGRyM1uIVSlutSBbHKE2G7Q9EcbbSNaZn7Ddzo5S4iaDXG+kbfbw24ABlH+2pguuL3ZGIoY2VX4h6w==
X-Received: by 2002:a17:902:7686:b0:168:de55:8c45 with SMTP id m6-20020a170902768600b00168de558c45mr22155079pll.129.1655704770834;
        Sun, 19 Jun 2022 22:59:30 -0700 (PDT)
Received: from localhost ([2406:7400:63:5d34:e6c2:4c64:12ae:aa11])
        by smtp.gmail.com with ESMTPSA id g12-20020a62f94c000000b0050dc76281f8sm7968901pfm.210.2022.06.19.22.59.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jun 2022 22:59:29 -0700 (PDT)
From:   Ritesh Harjani <ritesh.list@gmail.com>
To:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     Jan Kara <jack@suse.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
        Ritesh Harjani <ritesh.list@gmail.com>
Subject: [RFC 1/3] jbd2: Drop useless return value of submit_bh
Date:   Mon, 20 Jun 2022 11:28:40 +0530
Message-Id: <57b9cb59e50dfdf68eef82ef38944fbceba4e585.1655703467.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1655703466.git.ritesh.list@gmail.com>
References: <cover.1655703466.git.ritesh.list@gmail.com>
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

