Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0A01702AC6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 May 2023 12:41:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240603AbjEOKlO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 May 2023 06:41:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240556AbjEOKlE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 May 2023 06:41:04 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 738D51731;
        Mon, 15 May 2023 03:41:00 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-64a9335a8e7so19720453b3a.0;
        Mon, 15 May 2023 03:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684147259; x=1686739259;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lhHyuhMjD3iDjkhMsBeTFVgrKDu6FeVKj+zRjr50G2E=;
        b=bMaC4Pfl4Dotc82nwNUFMe6zsTxc2gX9wXKt+h9l6B8hQLNBLPSLU1W8U/z857ejkD
         k5MvMYGIrNXAKHjSzT+SjuzT0y06SOFpyewEqmoVdr3YzY0lEDiQF3gzAJaY6Z1zK5nP
         MboUHVymTr9qqNW70Y9yi0T1YVstLfNYKEDZfPYGGdj3P+28ug7ooDmudZim/W6vrEDV
         1ecvVP+uRYycwKIlPRAuqz5dcS0ugTbfGWPl48iky28dIA9X2OAeFTwZkVpWSLjUcK2v
         Iu/owJHUtv8mxllzBbWXkrOFN9a+wbvflKQB7udaZfVgBcTqck4YUdNPKlU7pCJ13G7s
         cxvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684147259; x=1686739259;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lhHyuhMjD3iDjkhMsBeTFVgrKDu6FeVKj+zRjr50G2E=;
        b=OSCqGVE6RuPqLFWAgf+d2ZDrAT8ZtUJ79nRQWyfMqSHMBSTm8g5JB1Hh8B1LQ9T0w9
         el1I/AkCvuEB6RafEWewygQcHK1ZqI0MNsUuF5q0kIENuGSGxyAJd1BU9wJpG+xo/FC3
         aaYIuucxEx0StENfM2EYjVSeUE9FtYYTNvdFv+bm4N42UPGz8/4WcoxWm7et8xi6/IQ9
         gPB+BaNP61+573uQEFB72MhOF1zM9u19aJmRMdYcwkEeBov1I1M2uRy/4X+RbCm5DuLR
         O+6naXHBDW9TzPq9fO/x9CTo/6+s/7Lzx5+ih0UTCJCahEeofuRn41Wd/uBTTjKxfjbO
         Ir5g==
X-Gm-Message-State: AC+VfDxhCveLjSWK4tYnVPur4TDvo3QPdduflfkQ+Vc6Fahejgbppkw9
        3NoJtQygYITMqQkKcuZMAvEt2iC485c=
X-Google-Smtp-Source: ACHHUZ6iBcB6MzZpCLbTdjfU+T3rKZsCPoR2B1cn2KCgl2jDhHC0oN7xsN7zeVwfJtedGJO+DHEf7w==
X-Received: by 2002:a05:6a00:198a:b0:643:5455:2577 with SMTP id d10-20020a056a00198a00b0064354552577mr35316026pfl.3.1684147259129;
        Mon, 15 May 2023 03:40:59 -0700 (PDT)
Received: from rh-tp.c4p-in.ibmmobiledemo.com ([129.41.58.18])
        by smtp.gmail.com with ESMTPSA id m14-20020aa7900e000000b006466d70a30esm11867078pfo.91.2023.05.15.03.40.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 03:40:58 -0700 (PDT)
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     linux-ext4@vger.kernel.org, Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [RFCv2 3/5] ext4: Change remaining tracepoints to use folio
Date:   Mon, 15 May 2023 16:10:42 +0530
Message-Id: <caba2b3c0147bed4ea7706767dc1d19cd0e29ab0.1684122756.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1684122756.git.ritesh.list@gmail.com>
References: <cover.1684122756.git.ritesh.list@gmail.com>
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

ext4_readpage() is converted to ext4_read_folio() hence change the
related tracepoint from trace_ext4_readpage(page) to
trace_ext4_read_folio(folio). Do the same for
trace_ext4_releasepage(page) to trace_ext4_release_folio(folio)

As a minor bit of optimization to avoid an extra dereferencing,
since both of the above functions already were dereferencing
folio->mapping->host, hence change the tracepoint argument to take
(inode, folio).

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 fs/ext4/inode.c             |  7 ++++---
 include/trace/events/ext4.h | 26 +++++++++++++-------------
 2 files changed, 17 insertions(+), 16 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index b9fa7c30a9a5..43b54aac1c65 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3105,7 +3105,7 @@ static int ext4_read_folio(struct file *file, struct folio *folio)
 	int ret = -EAGAIN;
 	struct inode *inode = folio->mapping->host;
 
-	trace_ext4_readpage(&folio->page);
+	trace_ext4_read_folio(inode, folio);
 
 	if (ext4_has_inline_data(inode))
 		ret = ext4_readpage_inline(inode, folio);
@@ -3164,9 +3164,10 @@ static void ext4_journalled_invalidate_folio(struct folio *folio,
 
 static bool ext4_release_folio(struct folio *folio, gfp_t wait)
 {
-	journal_t *journal = EXT4_JOURNAL(folio->mapping->host);
+	struct inode *inode = folio->mapping->host;
+	journal_t *journal = EXT4_JOURNAL(inode);
 
-	trace_ext4_releasepage(&folio->page);
+	trace_ext4_release_folio(inode, folio);
 
 	/* Page has dirty journalled data -> cannot release */
 	if (folio_test_checked(folio))
diff --git a/include/trace/events/ext4.h b/include/trace/events/ext4.h
index ebccf6a6aa1b..54cd509ced0f 100644
--- a/include/trace/events/ext4.h
+++ b/include/trace/events/ext4.h
@@ -560,10 +560,10 @@ TRACE_EVENT(ext4_writepages_result,
 		  (unsigned long) __entry->writeback_index)
 );
 
-DECLARE_EVENT_CLASS(ext4__page_op,
-	TP_PROTO(struct page *page),
+DECLARE_EVENT_CLASS(ext4__folio_op,
+	TP_PROTO(struct inode *inode, struct folio *folio),
 
-	TP_ARGS(page),
+	TP_ARGS(inode, folio),
 
 	TP_STRUCT__entry(
 		__field(	dev_t,	dev			)
@@ -573,29 +573,29 @@ DECLARE_EVENT_CLASS(ext4__page_op,
 	),
 
 	TP_fast_assign(
-		__entry->dev	= page->mapping->host->i_sb->s_dev;
-		__entry->ino	= page->mapping->host->i_ino;
-		__entry->index	= page->index;
+		__entry->dev	= inode->i_sb->s_dev;
+		__entry->ino	= inode->i_ino;
+		__entry->index	= folio->index;
 	),
 
-	TP_printk("dev %d,%d ino %lu page_index %lu",
+	TP_printk("dev %d,%d ino %lu folio_index %lu",
 		  MAJOR(__entry->dev), MINOR(__entry->dev),
 		  (unsigned long) __entry->ino,
 		  (unsigned long) __entry->index)
 );
 
-DEFINE_EVENT(ext4__page_op, ext4_readpage,
+DEFINE_EVENT(ext4__folio_op, ext4_read_folio,
 
-	TP_PROTO(struct page *page),
+	TP_PROTO(struct inode *inode, struct folio *folio),
 
-	TP_ARGS(page)
+	TP_ARGS(inode, folio)
 );
 
-DEFINE_EVENT(ext4__page_op, ext4_releasepage,
+DEFINE_EVENT(ext4__folio_op, ext4_release_folio,
 
-	TP_PROTO(struct page *page),
+	TP_PROTO(struct inode *inode, struct folio *folio),
 
-	TP_ARGS(page)
+	TP_ARGS(inode, folio)
 );
 
 DECLARE_EVENT_CLASS(ext4_invalidate_folio_op,
-- 
2.40.1

