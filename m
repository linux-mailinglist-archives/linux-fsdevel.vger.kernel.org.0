Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 062FE601A29
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Oct 2022 22:29:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230460AbiJQU2S (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Oct 2022 16:28:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230416AbiJQU1B (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Oct 2022 16:27:01 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2B8F4F1A9;
        Mon, 17 Oct 2022 13:25:46 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 128so11470974pga.1;
        Mon, 17 Oct 2022 13:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YZ9m9PEte2VFIEg+ZjqrJWhRYr046qHZsEH0p4wP4bQ=;
        b=RbTnAa8OOU4bDfi05kBTS9XDQ6dgydoyGwgm2rAdlFuvDFKeJuTkR8cnp53eKSf2oP
         GzH8nisCG30X3jC1jl/LDcARm0rVApWqQVklxfmYAUvmTBu1AiZMoHb/94egUBPM1Hli
         zgZrL1ZfgTfDSY5qgxRLDSXd8k2yUZEjzXFgS8YFRuA/xZy1my2JfSRju33hwVEfedHe
         IsvYWmsBPX/KMv7/MjK+ai9AzBODwj7EhLvkMf7Mu/SBglvbuU403QvVjoZ1FQXLB8UZ
         +/dlwHXGwvn8fgYVCx9ihTT4XjorgHA56f2n+r/pzV+hOGYKhyzHOkTnNTVI8GPoU7jE
         aXaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YZ9m9PEte2VFIEg+ZjqrJWhRYr046qHZsEH0p4wP4bQ=;
        b=N5ZO0iRpowkIFCS3pBNMqprBGLzM4V7wBB+pGIQkfhudvUEJ4TWTCubNoi2H+bgJ9Q
         gC8S+Wi14GWb8QYIjswkGKZggA8osWlpwgob+fDxHwgK69iznRoiUtTOBj1b/5FurciH
         8C6IVEdLvitTv1eLVXdccwf+rX6MzD2C4mnsLEY0LQlDtGR+swp7obTl8NDHrxbh8EfF
         dBv44xJqUt5z+NVq1sTiwANjyDwnQaQAYh1j0POG0fNBTYhhtw1AnUyQS3etUB3TiKKP
         yyHcNXh/mFpRcamv1rsu8p+ztzher3ZIILQpyvUiiXMkROzYte18KYlfE7pLymNVwdlC
         3yHg==
X-Gm-Message-State: ACrzQf3GAAuAe03r5Bkd9446cEI+d0DqddIpKuDkn9H4K1QkEybJfa1g
        CeMaHXdn4D3Rj8CPZpndDxZW3WSO3SjnAw==
X-Google-Smtp-Source: AMsMyM6Vx91/oVV5ZLgvMLO5H6DzrZy3VN9LhaSzepKou3j9neRlbCeOsd5HcpLlGsmJ/qO//v5jWA==
X-Received: by 2002:a65:45c1:0:b0:461:5855:8d86 with SMTP id m1-20020a6545c1000000b0046158558d86mr11945929pgr.436.1666038311051;
        Mon, 17 Oct 2022 13:25:11 -0700 (PDT)
Received: from vmfolio.. (c-76-102-73-225.hsd1.ca.comcast.net. [76.102.73.225])
        by smtp.googlemail.com with ESMTPSA id pj12-20020a17090b4f4c00b00200b12f2bf5sm145037pjb.1.2022.10.17.13.25.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 13:25:10 -0700 (PDT)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-cifs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-nilfs@vger.kernel.org, linux-mm@kvack.org,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH v3 17/23] gfs2: Convert gfs2_write_cache_jdata() to use filemap_get_folios_tag()
Date:   Mon, 17 Oct 2022 13:24:45 -0700
Message-Id: <20221017202451.4951-18-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20221017202451.4951-1-vishal.moola@gmail.com>
References: <20221017202451.4951-1-vishal.moola@gmail.com>
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

Converted function to use folios throughout. This is in preparation for
the removal of find_get_pgaes_range_tag().

Also had to modify and rename gfs2_write_jdata_pagevec() to take in
and utilize folio_batch rather than pagevec and use folios rather
than pages. gfs2_write_jdata_batch() now supports large folios.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 fs/gfs2/aops.c | 64 +++++++++++++++++++++++++++-----------------------
 1 file changed, 35 insertions(+), 29 deletions(-)

diff --git a/fs/gfs2/aops.c b/fs/gfs2/aops.c
index 05bee80ac7de..8f87c2551a3d 100644
--- a/fs/gfs2/aops.c
+++ b/fs/gfs2/aops.c
@@ -195,67 +195,71 @@ static int gfs2_writepages(struct address_space *mapping,
 }
 
 /**
- * gfs2_write_jdata_pagevec - Write back a pagevec's worth of pages
+ * gfs2_write_jdata_batch - Write back a folio batch's worth of folios
  * @mapping: The mapping
  * @wbc: The writeback control
- * @pvec: The vector of pages
- * @nr_pages: The number of pages to write
+ * @fbatch: The batch of folios
  * @done_index: Page index
  *
  * Returns: non-zero if loop should terminate, zero otherwise
  */
 
-static int gfs2_write_jdata_pagevec(struct address_space *mapping,
+static int gfs2_write_jdata_batch(struct address_space *mapping,
 				    struct writeback_control *wbc,
-				    struct pagevec *pvec,
-				    int nr_pages,
+				    struct folio_batch *fbatch,
 				    pgoff_t *done_index)
 {
 	struct inode *inode = mapping->host;
 	struct gfs2_sbd *sdp = GFS2_SB(inode);
-	unsigned nrblocks = nr_pages * (PAGE_SIZE >> inode->i_blkbits);
+	unsigned nrblocks;
 	int i;
 	int ret;
+	int nr_pages = 0;
+	int nr_folios = folio_batch_count(fbatch);
+
+	for (i = 0; i < nr_folios; i++)
+		nr_pages += folio_nr_pages(fbatch->folios[i]);
+	nrblocks = nr_pages * (PAGE_SIZE >> inode->i_blkbits);
 
 	ret = gfs2_trans_begin(sdp, nrblocks, nrblocks);
 	if (ret < 0)
 		return ret;
 
-	for(i = 0; i < nr_pages; i++) {
-		struct page *page = pvec->pages[i];
+	for (i = 0; i < nr_folios; i++) {
+		struct folio *folio = fbatch->folios[i];
 
-		*done_index = page->index;
+		*done_index = folio->index;
 
-		lock_page(page);
+		folio_lock(folio);
 
-		if (unlikely(page->mapping != mapping)) {
+		if (unlikely(folio->mapping != mapping)) {
 continue_unlock:
-			unlock_page(page);
+			folio_unlock(folio);
 			continue;
 		}
 
-		if (!PageDirty(page)) {
+		if (!folio_test_dirty(folio)) {
 			/* someone wrote it for us */
 			goto continue_unlock;
 		}
 
-		if (PageWriteback(page)) {
+		if (folio_test_writeback(folio)) {
 			if (wbc->sync_mode != WB_SYNC_NONE)
-				wait_on_page_writeback(page);
+				folio_wait_writeback(folio);
 			else
 				goto continue_unlock;
 		}
 
-		BUG_ON(PageWriteback(page));
-		if (!clear_page_dirty_for_io(page))
+		BUG_ON(folio_test_writeback(folio));
+		if (!folio_clear_dirty_for_io(folio))
 			goto continue_unlock;
 
 		trace_wbc_writepage(wbc, inode_to_bdi(inode));
 
-		ret = __gfs2_jdata_writepage(page, wbc);
+		ret = __gfs2_jdata_writepage(&folio->page, wbc);
 		if (unlikely(ret)) {
 			if (ret == AOP_WRITEPAGE_ACTIVATE) {
-				unlock_page(page);
+				folio_unlock(folio);
 				ret = 0;
 			} else {
 
@@ -268,7 +272,8 @@ static int gfs2_write_jdata_pagevec(struct address_space *mapping,
 				 * not be suitable for data integrity
 				 * writeout).
 				 */
-				*done_index = page->index + 1;
+				*done_index = folio->index +
+					folio_nr_pages(folio);
 				ret = 1;
 				break;
 			}
@@ -305,8 +310,8 @@ static int gfs2_write_cache_jdata(struct address_space *mapping,
 {
 	int ret = 0;
 	int done = 0;
-	struct pagevec pvec;
-	int nr_pages;
+	struct folio_batch fbatch;
+	int nr_folios;
 	pgoff_t writeback_index;
 	pgoff_t index;
 	pgoff_t end;
@@ -315,7 +320,7 @@ static int gfs2_write_cache_jdata(struct address_space *mapping,
 	int range_whole = 0;
 	xa_mark_t tag;
 
-	pagevec_init(&pvec);
+	folio_batch_init(&fbatch);
 	if (wbc->range_cyclic) {
 		writeback_index = mapping->writeback_index; /* prev offset */
 		index = writeback_index;
@@ -341,17 +346,18 @@ static int gfs2_write_cache_jdata(struct address_space *mapping,
 		tag_pages_for_writeback(mapping, index, end);
 	done_index = index;
 	while (!done && (index <= end)) {
-		nr_pages = pagevec_lookup_range_tag(&pvec, mapping, &index, end,
-				tag);
-		if (nr_pages == 0)
+		nr_folios = filemap_get_folios_tag(mapping, &index, end,
+				tag, &fbatch);
+		if (nr_folios == 0)
 			break;
 
-		ret = gfs2_write_jdata_pagevec(mapping, wbc, &pvec, nr_pages, &done_index);
+		ret = gfs2_write_jdata_batch(mapping, wbc, &fbatch,
+				&done_index);
 		if (ret)
 			done = 1;
 		if (ret > 0)
 			ret = 0;
-		pagevec_release(&pvec);
+		folio_batch_release(&fbatch);
 		cond_resched();
 	}
 
-- 
2.36.1

