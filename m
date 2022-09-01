Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20B595AA27B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Sep 2022 00:11:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234979AbiIAWEz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Sep 2022 18:04:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234651AbiIAWEG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Sep 2022 18:04:06 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B9B582747;
        Thu,  1 Sep 2022 15:02:45 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 202so322988pgc.8;
        Thu, 01 Sep 2022 15:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=H1ZMVMBgfrZYGu2QZ+223evW3CSAsjQgLD9a3FFT7h8=;
        b=igWgWaj0aHyNZf5XNZM5uDc0n5BV1AEK0E8cDeZNmauvOVLadH3WVQNodqCzZr8D8R
         hzujhG+S4PCrAuPukcXuRC5mwOFIxxwc0GiMx0cdVcwx5Wb6+iBFORlAPVoNjlIQX23W
         bEswqyuy8EmNrId6zlGtKLGA8gtyv55Rw1AH2+FmpfoXovpJpdtYKd501mfmlL+x16b6
         RnroUj9UCaRa413Bl0N2xC2vydY5iSJtBjMDD5AAH5twN0K4mRxdAqlQAPIoPZ5lM8/Y
         gtqAG5Yqwp/Rp7ZQwJrAj53rl2ta1L0rfXCTZ6LkGMVa7YXGDBshaZeshZvIj3BPWRPL
         PsFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=H1ZMVMBgfrZYGu2QZ+223evW3CSAsjQgLD9a3FFT7h8=;
        b=wyvFBTx6nIijXCeUS6txDuwnS3FLfCwVX28HMnE2ewcpRqNXF3RGoxTcCSoMsgCLPJ
         1tfwmhNKRwZmSQB4BGbSdXn3OdIR9/EhCr/t/FxB+T4QzZ6q2os8FiPNxagecNC+6Bow
         xTCDQN0EIISsZJYF+7DrCgd0vliRECSevy07ApqeAqs9nlJmeg0Wj8d5OZqwrFBGg27u
         3aYllmXvMXUvH85Jt2F2TfS5AVPOiWGV+4LNKHgzngeFhLH9H34wsdNwYX/d6wVKDx4d
         rV4QXqHLYyc7Vk2CFeRIS1GmiH4MrpOe1/ehKtUjtQBVyLT/PnhgBaN77VYM85LEk7uG
         CnKg==
X-Gm-Message-State: ACgBeo0nIfvuOUFnWQMM1YQVCJ+ubENsJXlRi0d24gPtZ4+dhVYbTQwT
        13kx4kItMcWPCPR64vbzS+isoCotJ2IPHQ==
X-Google-Smtp-Source: AA6agR5L6zGCc4qqeGX4LmKGAR0dl5NNlHckFzIH8Y7h0BJOTByYfkAodyvTQyqMLGO5MJ0QXJsLYg==
X-Received: by 2002:a05:6a00:3406:b0:535:f76f:c971 with SMTP id cn6-20020a056a00340600b00535f76fc971mr33419595pfb.5.1662069764597;
        Thu, 01 Sep 2022 15:02:44 -0700 (PDT)
Received: from vmfolio.. (c-73-189-111-8.hsd1.ca.comcast.net. [73.189.111.8])
        by smtp.googlemail.com with ESMTPSA id fv4-20020a17090b0e8400b001fb350026f1sm128894pjb.4.2022.09.01.15.02.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 15:02:44 -0700 (PDT)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-cifs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-nilfs@vger.kernel.org, linux-mm@kvack.org,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH 07/23] btrfs: Convert extent_write_cache_pages() to use filemap_get_folios_tag()
Date:   Thu,  1 Sep 2022 15:01:22 -0700
Message-Id: <20220901220138.182896-8-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220901220138.182896-1-vishal.moola@gmail.com>
References: <20220901220138.182896-1-vishal.moola@gmail.com>
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

Converted function to use folios throughout. This is in preparation for
the removal of find_get_pages_range_tag(). Now also supports large
folios.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 fs/btrfs/extent_io.c | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index d1fa072bfdd0..80fe313f8461 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -4972,8 +4972,8 @@ static int extent_write_cache_pages(struct address_space *mapping,
 	int ret = 0;
 	int done = 0;
 	int nr_to_write_done = 0;
-	struct pagevec pvec;
-	int nr_pages;
+	struct folio_batch fbatch;
+	unsigned int nr_folios;
 	pgoff_t index;
 	pgoff_t end;		/* Inclusive */
 	pgoff_t done_index;
@@ -4993,7 +4993,7 @@ static int extent_write_cache_pages(struct address_space *mapping,
 	if (!igrab(inode))
 		return 0;
 
-	pagevec_init(&pvec);
+	folio_batch_init(&fbatch);
 	if (wbc->range_cyclic) {
 		index = mapping->writeback_index; /* Start from prev offset */
 		end = -1;
@@ -5031,14 +5031,14 @@ static int extent_write_cache_pages(struct address_space *mapping,
 		tag_pages_for_writeback(mapping, index, end);
 	done_index = index;
 	while (!done && !nr_to_write_done && (index <= end) &&
-			(nr_pages = pagevec_lookup_range_tag(&pvec, mapping,
-						&index, end, tag))) {
+			(nr_folios = filemap_get_folios_tag(mapping, &index,
+							end, tag, &fbatch))) {
 		unsigned i;
 
-		for (i = 0; i < nr_pages; i++) {
-			struct page *page = pvec.pages[i];
+		for (i = 0; i < nr_folios; i++) {
+			struct folio *folio = fbatch.folios[i];
 
-			done_index = page->index + 1;
+			done_index = folio->index + folio_nr_pages(folio);
 			/*
 			 * At this point we hold neither the i_pages lock nor
 			 * the page lock: the page may be truncated or
@@ -5046,29 +5046,29 @@ static int extent_write_cache_pages(struct address_space *mapping,
 			 * or even swizzled back from swapper_space to
 			 * tmpfs file mapping
 			 */
-			if (!trylock_page(page)) {
+			if (!folio_trylock(folio)) {
 				submit_write_bio(epd, 0);
-				lock_page(page);
+				folio_lock(folio);
 			}
 
-			if (unlikely(page->mapping != mapping)) {
-				unlock_page(page);
+			if (unlikely(folio->mapping != mapping)) {
+				folio_unlock(folio);
 				continue;
 			}
 
 			if (wbc->sync_mode != WB_SYNC_NONE) {
-				if (PageWriteback(page))
+				if (folio_test_writeback(folio))
 					submit_write_bio(epd, 0);
-				wait_on_page_writeback(page);
+				folio_wait_writeback(folio);
 			}
 
-			if (PageWriteback(page) ||
-			    !clear_page_dirty_for_io(page)) {
-				unlock_page(page);
+			if (folio_test_writeback(folio) ||
+			    !folio_clear_dirty_for_io(folio)) {
+				folio_unlock(folio);
 				continue;
 			}
 
-			ret = __extent_writepage(page, wbc, epd);
+			ret = __extent_writepage(&folio->page, wbc, epd);
 			if (ret < 0) {
 				done = 1;
 				break;
@@ -5081,7 +5081,7 @@ static int extent_write_cache_pages(struct address_space *mapping,
 			 */
 			nr_to_write_done = wbc->nr_to_write <= 0;
 		}
-		pagevec_release(&pvec);
+		folio_batch_release(&fbatch);
 		cond_resched();
 	}
 	if (!scanned && !done) {
-- 
2.36.1

