Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66CB5616781
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Nov 2022 17:11:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231466AbiKBQLk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Nov 2022 12:11:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231357AbiKBQLS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Nov 2022 12:11:18 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B059E2CCA8;
        Wed,  2 Nov 2022 09:11:16 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d10so16819592pfh.6;
        Wed, 02 Nov 2022 09:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CScuk7r85wyu6F501iefg0DKwl3fyaI1fu4SBsbfBNk=;
        b=G1xj7WAmIltNBsbLKuO9CkKEQ79pa0K47wkha3puJeaezV2/imAkDdcfm/KV23FIHU
         +KArDubzSRmx7FiH0l8qSZQuiZfGIGZFESde9F7GDr7BI0vnEKAz4OoG+/TLSnEP6lVV
         hEk3uS7L0RHCBIur0yh9N3EX0D7wiz8f/Tz1DOmo9UyRB6et4qwOzt9Nng+ZOsOpt5/H
         9uNCUJ20VcSVqHMicFHHEq7ELqXYQFE7Mrb+NRFmYH88zfkz/DMkzuyMw0IDbt4InR+d
         u77NqmroP0vZczS44dmUtLli+wdv7QD3/rglQpmtqCu4rEb336yGk934JQ6ASFGIEHNx
         5dKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CScuk7r85wyu6F501iefg0DKwl3fyaI1fu4SBsbfBNk=;
        b=rJJAI7mRb59zfjuTKxzctapCgjFwyOWjmC0VrNLX6wG0MKs6qvFXhCrUZd1bkl+1IW
         8S7cGAMvkb1KWaqR4qlL+sAoGvq8/RLiXFxzT0GhqeYQlMyCbpy0BiY3tZLAluoPuabP
         sYZGbjrcDQScpDeLt71xZ1/OtG3Z76f1q2UfRZgnHTNA9XQyhnRWBVoCJAIr9OlcDj6t
         FJid/vnbgGA7hKPyEGFzTRr1eK4SDiXVzNczmyEIfG4WPuKih5jZh4l/i076S4UK/uMR
         Wz7yVRmT6ZSB2mIaJzoXTD3wtktUyWhLN41RxEyTj3HiOzbe27xxHZ0sMZn10goUcbj2
         0q2Q==
X-Gm-Message-State: ACrzQf0jLvmIa2KdaqFN8rldY9HrvRNLCpMQ66iAIxbkxVPi8nS4L+Yx
        0zox3bECB3AclgbaDwdTanM6KB/22XRNPw==
X-Google-Smtp-Source: AMsMyM6GJxhB3WK1RR+mjEzfRIolTwRsa2T5GOunC8tyj4bGy4RuSHbsovs3MGUIO1XlX8Eq6nDAFQ==
X-Received: by 2002:a63:4753:0:b0:462:b3f0:a984 with SMTP id w19-20020a634753000000b00462b3f0a984mr21859153pgk.501.1667405476022;
        Wed, 02 Nov 2022 09:11:16 -0700 (PDT)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:8002:1c20::8080])
        by smtp.googlemail.com with ESMTPSA id ms4-20020a17090b234400b00210c84b8ae5sm1632101pjb.35.2022.11.02.09.11.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 09:11:15 -0700 (PDT)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-cifs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-nilfs@vger.kernel.org, linux-mm@kvack.org,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH v4 06/23] btrfs: Convert btree_write_cache_pages() to use filemap_get_folio_tag()
Date:   Wed,  2 Nov 2022 09:10:14 -0700
Message-Id: <20221102161031.5820-7-vishal.moola@gmail.com>
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

Converted function to use folios throughout. This is in preparation for
the removal of find_get_pages_range_tag().

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
Acked-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/extent_io.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 4dcf22e051ff..9ae75db4d55e 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2960,14 +2960,14 @@ int btree_write_cache_pages(struct address_space *mapping,
 	int ret = 0;
 	int done = 0;
 	int nr_to_write_done = 0;
-	struct pagevec pvec;
-	int nr_pages;
+	struct folio_batch fbatch;
+	unsigned int nr_folios;
 	pgoff_t index;
 	pgoff_t end;		/* Inclusive */
 	int scanned = 0;
 	xa_mark_t tag;
 
-	pagevec_init(&pvec);
+	folio_batch_init(&fbatch);
 	if (wbc->range_cyclic) {
 		index = mapping->writeback_index; /* Start from prev offset */
 		end = -1;
@@ -2990,14 +2990,15 @@ int btree_write_cache_pages(struct address_space *mapping,
 	if (wbc->sync_mode == WB_SYNC_ALL)
 		tag_pages_for_writeback(mapping, index, end);
 	while (!done && !nr_to_write_done && (index <= end) &&
-	       (nr_pages = pagevec_lookup_range_tag(&pvec, mapping, &index, end,
-			tag))) {
+	       (nr_folios = filemap_get_folios_tag(mapping, &index, end,
+					    tag, &fbatch))) {
 		unsigned i;
 
-		for (i = 0; i < nr_pages; i++) {
-			struct page *page = pvec.pages[i];
+		for (i = 0; i < nr_folios; i++) {
+			struct folio *folio = fbatch.folios[i];
 
-			ret = submit_eb_page(page, wbc, &epd, &eb_context);
+			ret = submit_eb_page(&folio->page, wbc, &epd,
+					&eb_context);
 			if (ret == 0)
 				continue;
 			if (ret < 0) {
@@ -3012,7 +3013,7 @@ int btree_write_cache_pages(struct address_space *mapping,
 			 */
 			nr_to_write_done = wbc->nr_to_write <= 0;
 		}
-		pagevec_release(&pvec);
+		folio_batch_release(&fbatch);
 		cond_resched();
 	}
 	if (!scanned && !done) {
-- 
2.38.1

