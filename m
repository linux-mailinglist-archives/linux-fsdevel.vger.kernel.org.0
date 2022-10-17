Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 030A3601A01
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Oct 2022 22:29:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230199AbiJQU2N (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Oct 2022 16:28:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230437AbiJQU1B (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Oct 2022 16:27:01 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60AD67DF57;
        Mon, 17 Oct 2022 13:25:48 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id b5so11458934pgb.6;
        Mon, 17 Oct 2022 13:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E33K4tt62trvRpPvq+30izBLUL0IuVPL5OXIZrHr8HE=;
        b=cl1Xi/1e0WoTPVgLswyDuFR7lxs/43LEKKD7Bo9Uw9kac9ra7cvb01UWyMEi5xxewT
         hyL1BtZ+mvM34/0A7+CMLc6hilzxun99rEMpx9xjsykG1vTPGkIhB0QBQ69a8Au+JrCf
         AfOyDw8pkWku9S+gAdDsIMskLeX96aYNe6IMl5AUvy5q7T1Ssku0uduQ+1wzM3YP9ppY
         7I0Y8VcM5OTQAhlJHbjcqxwUUfDUbj/f/tlW+sAL897w74AqpJQalJRfI1m2YFF1Lzb9
         r7eQ9gDkU5KFgK435GKStDS+BPmOYqtl3hyxC8hNrnbgmF0V6L78/uFd3xZV3vd3SDtq
         /rgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E33K4tt62trvRpPvq+30izBLUL0IuVPL5OXIZrHr8HE=;
        b=fGY2IbiQomX4TGiC40evXJNlzun53YMIyv8OJkdEF9igCez7MgvA3iBxqT/8r4hYxS
         egKWDUXVIyxpKAOm/qiPSOpfYYikK56dmWAOH3MXuQI/ZdVKU27dFLiuM1aO/qSn6Y/K
         k4c73wPxOutd3OcWiXviBTeRFqoWhWD2M8XghnsZaPEp6/pVsf/PuQftESFk8vvw/kcn
         kuMiOYdbP8+3pgg0RqElYvy3TxOsoTT2m8P8ZsmFErirIqB0wwVwevQ4xRmFKBNeTA6I
         ZrqMm9BHCEw8xWczjhOtYPIWVCVbOOvSSptf3Jk7ng5nl4XbU2qOVP85MfIYrs8NttwE
         j2eA==
X-Gm-Message-State: ACrzQf0QKaxsLeehCEADA30mS2DOhHdD8xCw9weW6EDIhyvJnsXrMQBr
        EEu3/LAqt7R3DDW6GaQHTTMCY9tllMC5jA==
X-Google-Smtp-Source: AMsMyM4kkO8T2vzywfYNW+3YWnKus1E6ExkXrh/gFAwlSfcvcWcDhTQV3uPrw41ayn+7UcqM6SSDWg==
X-Received: by 2002:a62:584:0:b0:55a:a7a5:b597 with SMTP id 126-20020a620584000000b0055aa7a5b597mr14379661pff.71.1666038314860;
        Mon, 17 Oct 2022 13:25:14 -0700 (PDT)
Received: from vmfolio.. (c-76-102-73-225.hsd1.ca.comcast.net. [76.102.73.225])
        by smtp.googlemail.com with ESMTPSA id pj12-20020a17090b4f4c00b00200b12f2bf5sm145037pjb.1.2022.10.17.13.25.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 13:25:14 -0700 (PDT)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-cifs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-nilfs@vger.kernel.org, linux-mm@kvack.org,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>
Subject: [PATCH v3 21/23] nilfs2: Convert nilfs_copy_dirty_pages() to use filemap_get_folios_tag()
Date:   Mon, 17 Oct 2022 13:24:49 -0700
Message-Id: <20221017202451.4951-22-vishal.moola@gmail.com>
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

Convert function to use folios throughout. This is in preparation for
the removal of find_get_pages_range_tag().

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
Acked-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
---
 fs/nilfs2/page.c | 39 ++++++++++++++++++++-------------------
 1 file changed, 20 insertions(+), 19 deletions(-)

diff --git a/fs/nilfs2/page.c b/fs/nilfs2/page.c
index 39b7eea2642a..d921542a9593 100644
--- a/fs/nilfs2/page.c
+++ b/fs/nilfs2/page.c
@@ -240,42 +240,43 @@ static void nilfs_copy_page(struct page *dst, struct page *src, int copy_dirty)
 int nilfs_copy_dirty_pages(struct address_space *dmap,
 			   struct address_space *smap)
 {
-	struct pagevec pvec;
+	struct folio_batch fbatch;
 	unsigned int i;
 	pgoff_t index = 0;
 	int err = 0;
 
-	pagevec_init(&pvec);
+	folio_batch_init(&fbatch);
 repeat:
-	if (!pagevec_lookup_tag(&pvec, smap, &index, PAGECACHE_TAG_DIRTY))
+	if (!filemap_get_folios_tag(smap, &index, (pgoff_t)-1,
+				PAGECACHE_TAG_DIRTY, &fbatch))
 		return 0;
 
-	for (i = 0; i < pagevec_count(&pvec); i++) {
-		struct page *page = pvec.pages[i], *dpage;
+	for (i = 0; i < folio_batch_count(&fbatch); i++) {
+		struct folio *folio = fbatch.folios[i], *dfolio;
 
-		lock_page(page);
-		if (unlikely(!PageDirty(page)))
-			NILFS_PAGE_BUG(page, "inconsistent dirty state");
+		folio_lock(folio);
+		if (unlikely(!folio_test_dirty(folio)))
+			NILFS_PAGE_BUG(&folio->page, "inconsistent dirty state");
 
-		dpage = grab_cache_page(dmap, page->index);
-		if (unlikely(!dpage)) {
+		dfolio = filemap_grab_folio(dmap, folio->index);
+		if (unlikely(!dfolio)) {
 			/* No empty page is added to the page cache */
 			err = -ENOMEM;
-			unlock_page(page);
+			folio_unlock(folio);
 			break;
 		}
-		if (unlikely(!page_has_buffers(page)))
-			NILFS_PAGE_BUG(page,
+		if (unlikely(!folio_buffers(folio)))
+			NILFS_PAGE_BUG(&folio->page,
 				       "found empty page in dat page cache");
 
-		nilfs_copy_page(dpage, page, 1);
-		__set_page_dirty_nobuffers(dpage);
+		nilfs_copy_page(&dfolio->page, &folio->page, 1);
+		filemap_dirty_folio(folio_mapping(dfolio), dfolio);
 
-		unlock_page(dpage);
-		put_page(dpage);
-		unlock_page(page);
+		folio_unlock(dfolio);
+		folio_put(dfolio);
+		folio_unlock(folio);
 	}
-	pagevec_release(&pvec);
+	folio_batch_release(&fbatch);
 	cond_resched();
 
 	if (likely(!err))
-- 
2.36.1

