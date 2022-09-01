Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55ECD5AA231
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Sep 2022 00:10:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234889AbiIAWEV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Sep 2022 18:04:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234695AbiIAWD2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Sep 2022 18:03:28 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADAF195E55;
        Thu,  1 Sep 2022 15:02:50 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id q3so257636pjg.3;
        Thu, 01 Sep 2022 15:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=6NcBwR4ABkPySjWunvka2slqDQWJiFAlVbuCNfsPT4M=;
        b=EMgPqv/dW9ejZPEHc8h0Is509X4km9zwyRiEeD2t+4Yx6XUuh0YXvkpHP71hc59gcH
         WHXYVRkSAnQTt2Q5KImgRXXH0n5e1nRRcwFpn1jn9Z0qBu3Za0+kSR5U3Y+oisvno0xB
         qHbF4h+rY+S22MLF5ap3CosoN1i6JX9EICc4nBvjMUeE9f6QqYdAhhzuln06qzJfz57w
         oLHRFjF+s5/WSklK4JMa6+VrW4gduwUK1e6UTZXB5QCl9rMvRAKM4RtoT15Wjcl4IJNW
         /hiN/u5HgTeRKgbPyvHTCdJvfSuKWwkMOiDMOAsJ6ZTq4D1ND7jjeTpG1Ks55/3UbdBy
         cXcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=6NcBwR4ABkPySjWunvka2slqDQWJiFAlVbuCNfsPT4M=;
        b=Wgk8ZIV6yIv7BZIHyqGsHTJs1vl15xrkBi0jbkvKlVwFzfNJamMirX78k9rXJx/p00
         7+ewusnYOxxMypBNhu9D1N1UMucYVAzuUZch9RND+/ibskgFhPXweniXinu3nwn5tyse
         95nIT5TObm2kkj8bJxpF11ag3MCaS2Y2VDvOfTcSAD9W3HJ/W13dXxaRws/Gwaw/0zYT
         wEABhLk3EmMzHFnZeQhUek/OccINTPJPPrtl0U5tZoGea5rm6/Glv/FrU6fokBHd5etC
         +Mq/lfkC+uj1ZhH5z4P71eKomOodYJ3nRY8S3jr8/il/UbqiYNzQi4xrRL8ggGch9b/d
         JdGg==
X-Gm-Message-State: ACgBeo26Gw/2rj9LefdzORGL9R9D8IXx9gBjGfXLkNb7Hyjxpt5VJS9A
        jBOU/DKptovVP7edAdcboJfyLpbI7C87Uw==
X-Google-Smtp-Source: AA6agR5snoq69yQww0YGWXPMUaiRC6H7FjKFO/+Gerw4iv9NQmzTMmyBjpDkB62vFRGsgB5JpchToQ==
X-Received: by 2002:a17:90a:55:b0:1f7:4513:8cac with SMTP id 21-20020a17090a005500b001f745138cacmr1263139pjb.93.1662069769102;
        Thu, 01 Sep 2022 15:02:49 -0700 (PDT)
Received: from vmfolio.. (c-73-189-111-8.hsd1.ca.comcast.net. [73.189.111.8])
        by smtp.googlemail.com with ESMTPSA id fv4-20020a17090b0e8400b001fb350026f1sm128894pjb.4.2022.09.01.15.02.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 15:02:48 -0700 (PDT)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-cifs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-nilfs@vger.kernel.org, linux-mm@kvack.org,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH 10/23] ext4: Convert mpage_prepare_extent_to_map() to use filemap_get_folios_tag()
Date:   Thu,  1 Sep 2022 15:01:25 -0700
Message-Id: <20220901220138.182896-11-vishal.moola@gmail.com>
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

Converted the function to use folios throughout. This is in preparation
for the removal of find_get_pages_range_tag(). Now supports large
folios.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 fs/ext4/inode.c | 55 ++++++++++++++++++++++++-------------------------
 1 file changed, 27 insertions(+), 28 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 601214453c3a..fbd876e10a85 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -2565,8 +2565,8 @@ static int ext4_da_writepages_trans_blocks(struct inode *inode)
 static int mpage_prepare_extent_to_map(struct mpage_da_data *mpd)
 {
 	struct address_space *mapping = mpd->inode->i_mapping;
-	struct pagevec pvec;
-	unsigned int nr_pages;
+	struct folio_batch fbatch;
+	unsigned int nr_folios;
 	long left = mpd->wbc->nr_to_write;
 	pgoff_t index = mpd->first_page;
 	pgoff_t end = mpd->last_page;
@@ -2580,18 +2580,17 @@ static int mpage_prepare_extent_to_map(struct mpage_da_data *mpd)
 		tag = PAGECACHE_TAG_TOWRITE;
 	else
 		tag = PAGECACHE_TAG_DIRTY;
-
-	pagevec_init(&pvec);
+	folio_batch_init(&fbatch);
 	mpd->map.m_len = 0;
 	mpd->next_page = index;
 	while (index <= end) {
-		nr_pages = pagevec_lookup_range_tag(&pvec, mapping, &index, end,
-				tag);
-		if (nr_pages == 0)
+		nr_folios = filemap_get_folios_tag(mapping, &index, end,
+				tag, &fbatch);
+		if (nr_folios == 0)
 			break;
 
-		for (i = 0; i < nr_pages; i++) {
-			struct page *page = pvec.pages[i];
+		for (i = 0; i < nr_folios; i++) {
+			struct folio *folio = fbatch.folios[i];
 
 			/*
 			 * Accumulated enough dirty pages? This doesn't apply
@@ -2605,10 +2604,10 @@ static int mpage_prepare_extent_to_map(struct mpage_da_data *mpd)
 				goto out;
 
 			/* If we can't merge this page, we are done. */
-			if (mpd->map.m_len > 0 && mpd->next_page != page->index)
+			if (mpd->map.m_len > 0 && mpd->next_page != folio->index)
 				goto out;
 
-			lock_page(page);
+			folio_lock(folio);
 			/*
 			 * If the page is no longer dirty, or its mapping no
 			 * longer corresponds to inode we are writing (which
@@ -2616,16 +2615,16 @@ static int mpage_prepare_extent_to_map(struct mpage_da_data *mpd)
 			 * page is already under writeback and we are not doing
 			 * a data integrity writeback, skip the page
 			 */
-			if (!PageDirty(page) ||
-			    (PageWriteback(page) &&
+			if (!folio_test_dirty(folio) ||
+			    (folio_test_writeback(folio) &&
 			     (mpd->wbc->sync_mode == WB_SYNC_NONE)) ||
-			    unlikely(page->mapping != mapping)) {
-				unlock_page(page);
+			    unlikely(folio->mapping != mapping)) {
+				folio_unlock(folio);
 				continue;
 			}
 
-			wait_on_page_writeback(page);
-			BUG_ON(PageWriteback(page));
+			folio_wait_writeback(folio);
+			BUG_ON(folio_test_writeback(folio));
 
 			/*
 			 * Should never happen but for buggy code in
@@ -2636,33 +2635,33 @@ static int mpage_prepare_extent_to_map(struct mpage_da_data *mpd)
 			 *
 			 * [1] https://lore.kernel.org/linux-mm/20180103100430.GE4911@quack2.suse.cz
 			 */
-			if (!page_has_buffers(page)) {
-				ext4_warning_inode(mpd->inode, "page %lu does not have buffers attached", page->index);
-				ClearPageDirty(page);
-				unlock_page(page);
+			if (!folio_buffers(folio)) {
+				ext4_warning_inode(mpd->inode, "page %lu does not have buffers attached", folio->index);
+				folio_clear_dirty(folio);
+				folio_unlock(folio);
 				continue;
 			}
 
 			if (mpd->map.m_len == 0)
-				mpd->first_page = page->index;
-			mpd->next_page = page->index + 1;
+				mpd->first_page = folio->index;
+			mpd->next_page = folio->index + folio_nr_pages(folio);
 			/* Add all dirty buffers to mpd */
-			lblk = ((ext4_lblk_t)page->index) <<
+			lblk = ((ext4_lblk_t)folio->index) <<
 				(PAGE_SHIFT - blkbits);
-			head = page_buffers(page);
+			head = folio_buffers(folio);
 			err = mpage_process_page_bufs(mpd, head, head, lblk);
 			if (err <= 0)
 				goto out;
 			err = 0;
-			left--;
+			left -= folio_nr_pages(folio);
 		}
-		pagevec_release(&pvec);
+		folio_batch_release(&fbatch);
 		cond_resched();
 	}
 	mpd->scanned_until_end = 1;
 	return 0;
 out:
-	pagevec_release(&pvec);
+	folio_batch_release(&fbatch);
 	return err;
 }
 
-- 
2.36.1

