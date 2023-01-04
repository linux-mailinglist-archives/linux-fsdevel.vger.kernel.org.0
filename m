Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDDF865DE6C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jan 2023 22:16:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233776AbjADVPi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Jan 2023 16:15:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240294AbjADVPD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Jan 2023 16:15:03 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EBBE1CFEA;
        Wed,  4 Jan 2023 13:15:02 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id n12so24639998pjp.1;
        Wed, 04 Jan 2023 13:15:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uFWiZotH2hHO/dqZz3ekRRXvMmeZ6crkehTB/0Ti1xA=;
        b=PJJR7HrEap3tSH1Krm3xKRqYuv2+ZnILQzCAZ4FvA6g7y0di41mF1AmB7b4LucnLPW
         9SnkknLaQi9JPN7HiqQursF5IJIh8x4Go7xxIzVvYbBtPjzAmZtsns33bPkPsrt+hy50
         mCiKeevBosZyzcK2IMA4wvhDdxllKMI0cCC9SxOGeZRrOeURvnO4TDKbleugnCd9p6Lb
         743pneGz2xpnNZHO7fCMj35WHO1f/RGQIweETnZKQ8XOTIemf3fMpTvzMTMPSOgKVRuz
         JEcncOEIDLTioi5zOdKBwUNvJ1hrNSt/h0sKN3+bcLYhECKpZRcloIieHM2fofEPAV8A
         w3mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uFWiZotH2hHO/dqZz3ekRRXvMmeZ6crkehTB/0Ti1xA=;
        b=TAhajz+KGR8Vgk8ahfWn8eJNQoYTfPFn18skZY4p/l4WdAjjap6Bp+BcHDQ2wOMK11
         nC1tB16o9klTdwzfj4ddfLoyUIrYyzIo/6Ve7rM7RErZC6hsu1cirl3xx2dtnucjAz+u
         VYygiok8Mx1hNhqAwZFusYvpnsjfuwlZfhG4EQ8kbVoGi8azRggMaE4NnKhPqyaQiiyh
         BB0wIjfocjXXX6vmosfvl24RnSvpcXhacgkij9xE/3uvjSErARH0a9aQSMvppGrYfchR
         mkLCiJQgUAFgz1n3WuO96c3oKsKipwuSNGdpqCiFgFt0ic7DbDy0DDIhud7q92twGhK+
         s7JQ==
X-Gm-Message-State: AFqh2kqHhd4bCTKY3l3r1J9qFThgEqGl3t9AMYTyfTjAYIxOS7BrVOHX
        psNhZ3T+zCcFnnfykoRuiw+/M+uOO/c0sw==
X-Google-Smtp-Source: AMrXdXs3J6LoGMu8noxjtrKyXAiquvbz4xl3hf/x2raO3jwqWxe++Tv6pvIGcV6rBxNIAYQX5K7/nQ==
X-Received: by 2002:a17:90b:4d8c:b0:21d:ef10:d6ca with SMTP id oj12-20020a17090b4d8c00b0021def10d6camr50592886pjb.45.1672866901534;
        Wed, 04 Jan 2023 13:15:01 -0800 (PST)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:8002:1c20::a55d])
        by smtp.googlemail.com with ESMTPSA id i8-20020a17090a138800b00226369149cesm6408pja.21.2023.01.04.13.14.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 13:15:01 -0800 (PST)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-cifs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-nilfs@vger.kernel.org, linux-mm@kvack.org,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
        Matthew Wilcow <willy@infradead.org>
Subject: [PATCH v5 04/23] page-writeback: Convert write_cache_pages() to use filemap_get_folios_tag()
Date:   Wed,  4 Jan 2023 13:14:29 -0800
Message-Id: <20230104211448.4804-5-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230104211448.4804-1-vishal.moola@gmail.com>
References: <20230104211448.4804-1-vishal.moola@gmail.com>
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
the removal of find_get_pages_range_tag(). This change removes 8 calls
to compound_head(), and the function now supports large folios.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
Reviewed-by: Matthew Wilcow (Oracle) <willy@infradead.org>
---
 mm/page-writeback.c | 44 +++++++++++++++++++++++---------------------
 1 file changed, 23 insertions(+), 21 deletions(-)

diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index ad608ef2a243..5d61fa9eecc0 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2398,15 +2398,15 @@ int write_cache_pages(struct address_space *mapping,
 	int ret = 0;
 	int done = 0;
 	int error;
-	struct pagevec pvec;
-	int nr_pages;
+	struct folio_batch fbatch;
+	int nr_folios;
 	pgoff_t index;
 	pgoff_t end;		/* Inclusive */
 	pgoff_t done_index;
 	int range_whole = 0;
 	xa_mark_t tag;
 
-	pagevec_init(&pvec);
+	folio_batch_init(&fbatch);
 	if (wbc->range_cyclic) {
 		index = mapping->writeback_index; /* prev offset */
 		end = -1;
@@ -2426,17 +2426,18 @@ int write_cache_pages(struct address_space *mapping,
 	while (!done && (index <= end)) {
 		int i;
 
-		nr_pages = pagevec_lookup_range_tag(&pvec, mapping, &index, end,
-				tag);
-		if (nr_pages == 0)
+		nr_folios = filemap_get_folios_tag(mapping, &index, end,
+				tag, &fbatch);
+
+		if (nr_folios == 0)
 			break;
 
-		for (i = 0; i < nr_pages; i++) {
-			struct page *page = pvec.pages[i];
+		for (i = 0; i < nr_folios; i++) {
+			struct folio *folio = fbatch.folios[i];
 
-			done_index = page->index;
+			done_index = folio->index;
 
-			lock_page(page);
+			folio_lock(folio);
 
 			/*
 			 * Page truncated or invalidated. We can freely skip it
@@ -2446,30 +2447,30 @@ int write_cache_pages(struct address_space *mapping,
 			 * even if there is now a new, dirty page at the same
 			 * pagecache address.
 			 */
-			if (unlikely(page->mapping != mapping)) {
+			if (unlikely(folio->mapping != mapping)) {
 continue_unlock:
-				unlock_page(page);
+				folio_unlock(folio);
 				continue;
 			}
 
-			if (!PageDirty(page)) {
+			if (!folio_test_dirty(folio)) {
 				/* someone wrote it for us */
 				goto continue_unlock;
 			}
 
-			if (PageWriteback(page)) {
+			if (folio_test_writeback(folio)) {
 				if (wbc->sync_mode != WB_SYNC_NONE)
-					wait_on_page_writeback(page);
+					folio_wait_writeback(folio);
 				else
 					goto continue_unlock;
 			}
 
-			BUG_ON(PageWriteback(page));
-			if (!clear_page_dirty_for_io(page))
+			BUG_ON(folio_test_writeback(folio));
+			if (!folio_clear_dirty_for_io(folio))
 				goto continue_unlock;
 
 			trace_wbc_writepage(wbc, inode_to_bdi(mapping->host));
-			error = (*writepage)(page, wbc, data);
+			error = writepage(&folio->page, wbc, data);
 			if (unlikely(error)) {
 				/*
 				 * Handle errors according to the type of
@@ -2484,11 +2485,12 @@ int write_cache_pages(struct address_space *mapping,
 				 * the first error.
 				 */
 				if (error == AOP_WRITEPAGE_ACTIVATE) {
-					unlock_page(page);
+					folio_unlock(folio);
 					error = 0;
 				} else if (wbc->sync_mode != WB_SYNC_ALL) {
 					ret = error;
-					done_index = page->index + 1;
+					done_index = folio->index +
+						folio_nr_pages(folio);
 					done = 1;
 					break;
 				}
@@ -2508,7 +2510,7 @@ int write_cache_pages(struct address_space *mapping,
 				break;
 			}
 		}
-		pagevec_release(&pvec);
+		folio_batch_release(&fbatch);
 		cond_resched();
 	}
 
-- 
2.38.1

