Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E749164A7FC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Dec 2022 20:16:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233064AbiLLTPf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Dec 2022 14:15:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232988AbiLLTPb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Dec 2022 14:15:31 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C434DEDC;
        Mon, 12 Dec 2022 11:15:29 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id 65so581934pfx.9;
        Mon, 12 Dec 2022 11:15:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xkM+afTsz5CqxyM8zs9D+iGsBZPiJzEAQMC/u5lyTL0=;
        b=nw6aRHz51wqaynmeH7AmMW3V+PrnQ7b13g7pdbT/3q/sYZ6zf4XwtfYCZ1rpiCiYqH
         pI4I/LqRIb5iTeb4DR9bwnqEWbh0bvxLhQnFn8DDCpiX7obMqaaacq4ZoujxXeeAtIpD
         iP7+Suj0lV5uFqedHjnmOEzupb/AZwifYl82gFtBMlsiuJNR2DjNQj/2WGXWaCy/Kups
         algKTyoa3OMcY7nFxh1KVtC2ohQx1eUS2udKylCSa7afpl0T2bCptskCXIT4SX0TNFr/
         w/+oa1x9pbOn//nzx0oIMuN1NiDR8cz9CT8LQu4zlDddjaJ0U19JkVnLzOrpPVnwvYqe
         zExQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xkM+afTsz5CqxyM8zs9D+iGsBZPiJzEAQMC/u5lyTL0=;
        b=4r6lNz464UAfkkZakqe8v6iTN6CKM9pQiM3k/+oPROnhVVgQYNTz8ZDGsU1BsgtZot
         NBRLAUiNGOyTXcLv04jsxUsVBtYbPwuFPi/g2CCQxyFDyMI0oAwr+oSBBoD3xUpqCA2h
         CMkWJj1ZykoioBKGNvsqlKa20AgiEAMLHGBCqk6+KS7nbGMubGr6Hr36vx4rLDf6YsDG
         CtLi37Go+xl5AEeoNcQCWRpZaogi5uKzFuI22vqElHiaDpRAaLIDGPAtb/razX7VhmRq
         NulDL3DZbxPmwrApftR9dfp4BquOsob4zjc3LGs+3eo7QwrrJR5f1p2q6CZFZ7pcYg3w
         1COw==
X-Gm-Message-State: ANoB5plEv238t9H4tHtjbokPI1pzXfLKyYK2rA4C3P3BbtayAEVia/GN
        nVFggK181EsIN9+4uq6p6HtgoiXefMM=
X-Google-Smtp-Source: AA0mqf6xHmaysAxy1tMtGrFaKJFTa1JaRWPfex9MBQgoDXluY4qrM4PveChIIQzp53ZYM19xWdXpBg==
X-Received: by 2002:a05:6a00:1c9c:b0:577:3126:704b with SMTP id y28-20020a056a001c9c00b005773126704bmr18893111pfw.17.1670872528763;
        Mon, 12 Dec 2022 11:15:28 -0800 (PST)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:8002:1c20::2c6b])
        by smtp.googlemail.com with ESMTPSA id u24-20020a62d458000000b00574345ee12csm6149470pfl.23.2022.12.12.11.15.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 11:15:28 -0800 (PST)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     chao@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-mm@kvack.org,
        fengnanchang@gmail.com, linux-fsdevel@vger.kernel.org,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [RFC PATCH] f2fs: Convert f2fs_write_cache_pages() to use filemap_get_folios_tag()
Date:   Mon, 12 Dec 2022 11:13:18 -0800
Message-Id: <20221212191317.9730-1-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <0a95ba7b-9335-ce03-0f47-5d9f4cce988f@kernel.org>
References: <0a95ba7b-9335-ce03-0f47-5d9f4cce988f@kernel.org>
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

Converted the function to use a folio_batch instead of pagevec. This is in
preparation for the removal of find_get_pages_range_tag().

Also modified f2fs_all_cluster_page_ready to take in a folio_batch instead
of pagevec. This does NOT support large folios. The function currently
only utilizes folios of size 1 so this shouldn't cause any issues right
now.

This version of the patch limits the number of pages fetched to
F2FS_ONSTACK_PAGES. If that ever happens, update the start index here
since filemap_get_folios_tag() updates the index to be after the last
found folio, not necessarily the last used page.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---

Let me know if you prefer this version and I'll include it in v5
of the patch series when I rebase it after the merge window.

---
 fs/f2fs/data.c | 86 ++++++++++++++++++++++++++++++++++----------------
 1 file changed, 59 insertions(+), 27 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index a71e818cd67b..1703e353f0e0 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2939,6 +2939,7 @@ static int f2fs_write_cache_pages(struct address_space *mapping,
 	int ret = 0;
 	int done = 0, retry = 0;
 	struct page *pages[F2FS_ONSTACK_PAGES];
+	struct folio_batch fbatch;
 	struct f2fs_sb_info *sbi = F2FS_M_SB(mapping);
 	struct bio *bio = NULL;
 	sector_t last_block;
@@ -2959,6 +2960,7 @@ static int f2fs_write_cache_pages(struct address_space *mapping,
 		.private = NULL,
 	};
 #endif
+	int nr_folios, p, idx;
 	int nr_pages;
 	pgoff_t index;
 	pgoff_t end;		/* Inclusive */
@@ -2969,6 +2971,8 @@ static int f2fs_write_cache_pages(struct address_space *mapping,
 	int submitted = 0;
 	int i;
 
+	folio_batch_init(&fbatch);
+
 	if (get_dirty_pages(mapping->host) <=
 				SM_I(F2FS_M_SB(mapping))->min_hot_blocks)
 		set_inode_flag(mapping->host, FI_HOT_DATA);
@@ -2994,13 +2998,38 @@ static int f2fs_write_cache_pages(struct address_space *mapping,
 		tag_pages_for_writeback(mapping, index, end);
 	done_index = index;
 	while (!done && !retry && (index <= end)) {
-		nr_pages = find_get_pages_range_tag(mapping, &index, end,
-				tag, F2FS_ONSTACK_PAGES, pages);
-		if (nr_pages == 0)
+		nr_pages = 0;
+again:
+		nr_folios = filemap_get_folios_tag(mapping, &index, end,
+				tag, &fbatch);
+		if (nr_folios == 0) {
+			if (nr_pages)
+				goto write;
 			break;
+		}
 
+		for (i = 0; i < nr_folios; i++) {
+			struct folio* folio = fbatch.folios[i];
+
+			idx = 0;
+			p = folio_nr_pages(folio);
+add_more:
+			pages[nr_pages] = folio_page(folio,idx);
+			folio_ref_inc(folio);
+			if (++nr_pages == F2FS_ONSTACK_PAGES) {
+				index = folio->index + idx + 1;
+				folio_batch_release(&fbatch);
+				goto write;
+			}
+			if (++idx < p)
+				goto add_more;
+		}
+		folio_batch_release(&fbatch);
+		goto again;
+write:
 		for (i = 0; i < nr_pages; i++) {
 			struct page *page = pages[i];
+			struct folio *folio = page_folio(page);
 			bool need_readd;
 readd:
 			need_readd = false;
@@ -3017,7 +3046,7 @@ static int f2fs_write_cache_pages(struct address_space *mapping,
 				}
 
 				if (!f2fs_cluster_can_merge_page(&cc,
-								page->index)) {
+								folio->index)) {
 					ret = f2fs_write_multi_pages(&cc,
 						&submitted, wbc, io_type);
 					if (!ret)
@@ -3026,27 +3055,28 @@ static int f2fs_write_cache_pages(struct address_space *mapping,
 				}
 
 				if (unlikely(f2fs_cp_error(sbi)))
-					goto lock_page;
+					goto lock_folio;
 
 				if (!f2fs_cluster_is_empty(&cc))
-					goto lock_page;
+					goto lock_folio;
 
 				if (f2fs_all_cluster_page_ready(&cc,
 					pages, i, nr_pages, true))
-					goto lock_page;
+					goto lock_folio;
 
 				ret2 = f2fs_prepare_compress_overwrite(
 							inode, &pagep,
-							page->index, &fsdata);
+							folio->index, &fsdata);
 				if (ret2 < 0) {
 					ret = ret2;
 					done = 1;
 					break;
 				} else if (ret2 &&
 					(!f2fs_compress_write_end(inode,
-						fsdata, page->index, 1) ||
+						fsdata, folio->index, 1) ||
 					 !f2fs_all_cluster_page_ready(&cc,
-						pages, i, nr_pages, false))) {
+						pages, i, nr_pages,
+						false))) {
 					retry = 1;
 					break;
 				}
@@ -3059,46 +3089,47 @@ static int f2fs_write_cache_pages(struct address_space *mapping,
 				break;
 			}
 #ifdef CONFIG_F2FS_FS_COMPRESSION
-lock_page:
+lock_folio:
 #endif
-			done_index = page->index;
+			done_index = folio->index;
 retry_write:
-			lock_page(page);
+			folio_lock(folio);
 
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
-					f2fs_wait_on_page_writeback(page,
+					f2fs_wait_on_page_writeback(
+							&folio->page,
 							DATA, true, true);
 				else
 					goto continue_unlock;
 			}
 
-			if (!clear_page_dirty_for_io(page))
+			if (!folio_clear_dirty_for_io(folio))
 				goto continue_unlock;
 
 #ifdef CONFIG_F2FS_FS_COMPRESSION
 			if (f2fs_compressed_file(inode)) {
-				get_page(page);
-				f2fs_compress_ctx_add_page(&cc, page);
+				folio_get(folio);
+				f2fs_compress_ctx_add_page(&cc, &folio->page);
 				continue;
 			}
 #endif
-			ret = f2fs_write_single_data_page(page, &submitted,
-					&bio, &last_block, wbc, io_type,
-					0, true);
+			ret = f2fs_write_single_data_page(&folio->page,
+					&submitted, &bio, &last_block,
+					wbc, io_type, 0, true);
 			if (ret == AOP_WRITEPAGE_ACTIVATE)
-				unlock_page(page);
+				folio_unlock(folio);
 #ifdef CONFIG_F2FS_FS_COMPRESSION
 result:
 #endif
@@ -3122,7 +3153,8 @@ static int f2fs_write_cache_pages(struct address_space *mapping,
 					}
 					goto next;
 				}
-				done_index = page->index + 1;
+				done_index = folio->index +
+					folio_nr_pages(folio);
 				done = 1;
 				break;
 			}
@@ -3136,7 +3168,7 @@ static int f2fs_write_cache_pages(struct address_space *mapping,
 			if (need_readd)
 				goto readd;
 		}
-		release_pages(pages, nr_pages);
+		release_pages(pages,nr_pages);
 		cond_resched();
 	}
 #ifdef CONFIG_F2FS_FS_COMPRESSION
-- 
2.38.1

