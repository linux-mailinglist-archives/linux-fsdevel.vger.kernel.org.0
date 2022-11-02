Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE0626167FA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Nov 2022 17:14:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231867AbiKBQMr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Nov 2022 12:12:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231475AbiKBQLl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Nov 2022 12:11:41 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A27F2CC90;
        Wed,  2 Nov 2022 09:11:29 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id l22-20020a17090a3f1600b00212fbbcfb78so2539073pjc.3;
        Wed, 02 Nov 2022 09:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gop7swXAAJ8sgYyasjeCim+2hgvZWCX0xP2gQPQAoN4=;
        b=CYG7zu+QxCPI4y/4OmUZ6lM2JjETOTsDWuWnK+gbIF/bo8LwhHwDiP6kyfIdUbpyX8
         ab9PRWMdaUYGWhq7nY4kTV0jG0utHkrf1BbP7dErm+mKDb0+A4TEESQqpmkxzFQT+DtN
         JlhOn+4S24OwuKkrVD0sPxqkQVGmn/run6/9tIdNBUZ2ufh5mY9r9vOsWyRs6O01IxY5
         jAHXvzsRSva4MguNXkmSvlrLJxwuOGefxKTQZM10Odu+C4tDWapwK5UUuivkGmwCYD8n
         SKYn5/mySUl+qAWnJeuU5HhpDCL1/6/iG5Yn4Ie4dHT4sJqWWgvPDGxn9z17ZG2JtxX9
         QX+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gop7swXAAJ8sgYyasjeCim+2hgvZWCX0xP2gQPQAoN4=;
        b=HNXds3Bu2XdVyiX7CRWGfa8eaE0SP5lhh0ePBWslwTkKa65YbcxfdQhvtQKA1JQ1ps
         e/4bPZ11cAR5NTLBLeBIbTXzEgJ8x15nxVwT01bTjqYsEVptidS4in6gYoXRW0Ezf09h
         DJkCvPq8w9U4jejj2tmv9NM50NCsMOWFtC7OmIRjqIxVWPsVcPhmwbL9cKJBcwnS29rs
         B6NpjmF4ZDFwqm00+qLDQrU+SdIBHedqwamyUlnK7KTbeRCfHzdktdXFNrHzVp8g93+H
         PRsKMnfqm3HH6zKUks9Vs0otBJUqfgie2V+DhX+IgvxR6Jrm9CP72Q3gHCatsgIXhtbc
         dsbg==
X-Gm-Message-State: ACrzQf0UZocjr1k1Ji0fBayZx+0ryUzJsp4Ki077owTm6y6pGc6IxMU8
        /bj+1tp4F6Ug687GuB/nhhTDA5i4oPDfuw==
X-Google-Smtp-Source: AMsMyM6I1DPKwfoeXRZ0zpmiqcREQFJWEBekvCZledBpKCLwMg84o0uKiw8tB7975QpgvsZe2RH2ig==
X-Received: by 2002:a17:90a:b10b:b0:212:fbc3:e623 with SMTP id z11-20020a17090ab10b00b00212fbc3e623mr26873993pjq.5.1667405488224;
        Wed, 02 Nov 2022 09:11:28 -0700 (PDT)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:8002:1c20::8080])
        by smtp.googlemail.com with ESMTPSA id ms4-20020a17090b234400b00210c84b8ae5sm1632101pjb.35.2022.11.02.09.11.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 09:11:27 -0700 (PDT)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-cifs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-nilfs@vger.kernel.org, linux-mm@kvack.org,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH v4 14/23] f2fs: Convert f2fs_write_cache_pages() to use filemap_get_folios_tag()
Date:   Wed,  2 Nov 2022 09:10:22 -0700
Message-Id: <20221102161031.5820-15-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221102161031.5820-1-vishal.moola@gmail.com>
References: <20221102161031.5820-1-vishal.moola@gmail.com>
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
preparation for the removal of find_get_pages_range_tag(). This change
removes 7 calls to compound_head().

Also modified f2fs_all_cluster_page_ready to take in a folio_batch instead
of pagevec. This does NOT support large folios. The function currently
only utilizes folios of size 1 so this shouldn't cause any issues right
now.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 fs/f2fs/compress.c | 13 +++++----
 fs/f2fs/data.c     | 69 +++++++++++++++++++++++++---------------------
 fs/f2fs/f2fs.h     |  5 ++--
 3 files changed, 47 insertions(+), 40 deletions(-)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index d315c2de136f..7af6c923e0aa 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -842,10 +842,11 @@ bool f2fs_cluster_can_merge_page(struct compress_ctx *cc, pgoff_t index)
 	return is_page_in_cluster(cc, index);
 }
 
-bool f2fs_all_cluster_page_ready(struct compress_ctx *cc, struct page **pages,
-				int index, int nr_pages, bool uptodate)
+bool f2fs_all_cluster_page_ready(struct compress_ctx *cc,
+				struct folio_batch *fbatch,
+				int index, int nr_folios, bool uptodate)
 {
-	unsigned long pgidx = pages[index]->index;
+	unsigned long pgidx = fbatch->folios[index]->index;
 	int i = uptodate ? 0 : 1;
 
 	/*
@@ -855,13 +856,13 @@ bool f2fs_all_cluster_page_ready(struct compress_ctx *cc, struct page **pages,
 	if (uptodate && (pgidx % cc->cluster_size))
 		return false;
 
-	if (nr_pages - index < cc->cluster_size)
+	if (nr_folios - index < cc->cluster_size)
 		return false;
 
 	for (; i < cc->cluster_size; i++) {
-		if (pages[index + i]->index != pgidx + i)
+		if (fbatch->folios[index + i]->index != pgidx + i)
 			return false;
-		if (uptodate && !PageUptodate(pages[index + i]))
+		if (uptodate && !folio_test_uptodate(fbatch->folios[index + i]))
 			return false;
 	}
 
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index a71e818cd67b..7511578b73c3 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2938,7 +2938,7 @@ static int f2fs_write_cache_pages(struct address_space *mapping,
 {
 	int ret = 0;
 	int done = 0, retry = 0;
-	struct page *pages[F2FS_ONSTACK_PAGES];
+	struct folio_batch fbatch;
 	struct f2fs_sb_info *sbi = F2FS_M_SB(mapping);
 	struct bio *bio = NULL;
 	sector_t last_block;
@@ -2959,7 +2959,7 @@ static int f2fs_write_cache_pages(struct address_space *mapping,
 		.private = NULL,
 	};
 #endif
-	int nr_pages;
+	int nr_folios;
 	pgoff_t index;
 	pgoff_t end;		/* Inclusive */
 	pgoff_t done_index;
@@ -2969,6 +2969,8 @@ static int f2fs_write_cache_pages(struct address_space *mapping,
 	int submitted = 0;
 	int i;
 
+	folio_batch_init(&fbatch);
+
 	if (get_dirty_pages(mapping->host) <=
 				SM_I(F2FS_M_SB(mapping))->min_hot_blocks)
 		set_inode_flag(mapping->host, FI_HOT_DATA);
@@ -2994,13 +2996,13 @@ static int f2fs_write_cache_pages(struct address_space *mapping,
 		tag_pages_for_writeback(mapping, index, end);
 	done_index = index;
 	while (!done && !retry && (index <= end)) {
-		nr_pages = find_get_pages_range_tag(mapping, &index, end,
-				tag, F2FS_ONSTACK_PAGES, pages);
-		if (nr_pages == 0)
+		nr_folios = filemap_get_folios_tag(mapping, &index, end,
+				tag, &fbatch);
+		if (nr_folios == 0)
 			break;
 
-		for (i = 0; i < nr_pages; i++) {
-			struct page *page = pages[i];
+		for (i = 0; i < nr_folios; i++) {
+			struct folio *folio = fbatch.folios[i];
 			bool need_readd;
 readd:
 			need_readd = false;
@@ -3017,7 +3019,7 @@ static int f2fs_write_cache_pages(struct address_space *mapping,
 				}
 
 				if (!f2fs_cluster_can_merge_page(&cc,
-								page->index)) {
+								folio->index)) {
 					ret = f2fs_write_multi_pages(&cc,
 						&submitted, wbc, io_type);
 					if (!ret)
@@ -3026,27 +3028,28 @@ static int f2fs_write_cache_pages(struct address_space *mapping,
 				}
 
 				if (unlikely(f2fs_cp_error(sbi)))
-					goto lock_page;
+					goto lock_folio;
 
 				if (!f2fs_cluster_is_empty(&cc))
-					goto lock_page;
+					goto lock_folio;
 
 				if (f2fs_all_cluster_page_ready(&cc,
-					pages, i, nr_pages, true))
-					goto lock_page;
+					&fbatch, i, nr_folios, true))
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
+						&fbatch, i, nr_folios,
+						false))) {
 					retry = 1;
 					break;
 				}
@@ -3059,46 +3062,47 @@ static int f2fs_write_cache_pages(struct address_space *mapping,
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
@@ -3122,7 +3126,8 @@ static int f2fs_write_cache_pages(struct address_space *mapping,
 					}
 					goto next;
 				}
-				done_index = page->index + 1;
+				done_index = folio->index +
+					folio_nr_pages(folio);
 				done = 1;
 				break;
 			}
@@ -3136,7 +3141,7 @@ static int f2fs_write_cache_pages(struct address_space *mapping,
 			if (need_readd)
 				goto readd;
 		}
-		release_pages(pages, nr_pages);
+		folio_batch_release(&fbatch);
 		cond_resched();
 	}
 #ifdef CONFIG_F2FS_FS_COMPRESSION
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index e6355a5683b7..d7bfb88fa341 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -4226,8 +4226,9 @@ void f2fs_end_read_compressed_page(struct page *page, bool failed,
 				block_t blkaddr, bool in_task);
 bool f2fs_cluster_is_empty(struct compress_ctx *cc);
 bool f2fs_cluster_can_merge_page(struct compress_ctx *cc, pgoff_t index);
-bool f2fs_all_cluster_page_ready(struct compress_ctx *cc, struct page **pages,
-				int index, int nr_pages, bool uptodate);
+bool f2fs_all_cluster_page_ready(struct compress_ctx *cc,
+		struct folio_batch *fbatch, int index, int nr_folios,
+		bool uptodate);
 bool f2fs_sanity_check_cluster(struct dnode_of_data *dn);
 void f2fs_compress_ctx_add_page(struct compress_ctx *cc, struct page *page);
 int f2fs_write_multi_pages(struct compress_ctx *cc,
-- 
2.38.1

