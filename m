Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04777593BB8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Aug 2022 22:35:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239773AbiHOUNS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Aug 2022 16:13:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241783AbiHOUJP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Aug 2022 16:09:15 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56A97F2B;
        Mon, 15 Aug 2022 11:56:00 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d16so7097999pll.11;
        Mon, 15 Aug 2022 11:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=YNgoWYCY1lPrjzW0L6uvTUDhqO8Va4cbu+Lukza45Kk=;
        b=LLqk6nZx0CZaFFAKrYtayFNSQtFEufiNWAnBpPZzb6NuyTnfFHJ50yjihvOX09BnKM
         S47QhKHOD34cTFOPR6PhaMP7mmdaLrRYSmY3S08Yq78sPmyEiJxae5DQvOOdYruhjV2K
         VainybYqq60xbvb9Mjvhb2WTFrPUhyaHxn2OUAWwknzK883JGnUdbEkTFKzA/VFk6DlK
         U8j6FtQ9cjPFpqQ5YnVDfhVJc2COUwxSydLt+v/jUsytUL1hfqyDMVpnBKcHVytFmRqk
         lLrXpBUiei5hCA+Dw8+0AgZvhFxuDhaZTjwgI8a7Iu6XaMONbkJrwlTwh1AJurWNAhXM
         TeLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=YNgoWYCY1lPrjzW0L6uvTUDhqO8Va4cbu+Lukza45Kk=;
        b=p3N8ylRRo1xuQ7hq7lzpNtbdQImWvMlISs05rWYf80hU2G+ZLFk5HeHJa+KlMApiNs
         43xJnUXKajXYcSgOMnsTr7KKfDJZCCyIiGSul2ucbp9DMwyWyXQsmly4kUJkx/k42f+e
         fOe9EKUF1/xO6CJpK0Gr1vAek89gxjNtCugQfKhJ/j2YvR7vENnIygdIYLkFKPsaZi1k
         HaRZEKkmv3bEJALow5HyJt7nZIUe0j0dWvT7d6KQiOHunbj0RTjogAC5D94Jf963jcrr
         PrdZufeUwx55NyWJsEMlyK4WwTr9OdcqIEnFn2ilC2T441Wb1UWQgiyJE/X3z6d6C0JF
         AH/Q==
X-Gm-Message-State: ACgBeo2N0tdLLI6JI67uRsyBo5Wlf1Ra7r4AEdTxgc9qV5qa860J06rR
        7kRmw/fA0B6SHk1RGYkzTDhpLqBDHFgCq7nv
X-Google-Smtp-Source: AA6agR7Ao983jsJzFfh+XdeTEh3h2BJEmqP3wgZdEa6QB7GpFTZxxIDE7k3xHAwvuKwa7uOA/N5Omg==
X-Received: by 2002:a17:902:ef81:b0:16d:cd36:7955 with SMTP id iz1-20020a170902ef8100b0016dcd367955mr17848496plb.24.1660589759453;
        Mon, 15 Aug 2022 11:55:59 -0700 (PDT)
Received: from vmfolio.. (c-73-189-111-8.hsd1.ca.comcast.net. [73.189.111.8])
        by smtp.googlemail.com with ESMTPSA id x190-20020a6231c7000000b0052def2e20dasm6858174pfx.167.2022.08.15.11.55.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Aug 2022 11:55:59 -0700 (PDT)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, linux-nilfs@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH 2/7] btrfs: Convert __process_pages_contig() to use filemap_get_folios_contig()
Date:   Mon, 15 Aug 2022 11:54:47 -0700
Message-Id: <20220815185452.37447-3-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220815185452.37447-1-vishal.moola@gmail.com>
References: <20220815185452.37447-1-vishal.moola@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,SUSPICIOUS_RECIPS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Convert to use folios throughout. This is in preparation for the removal of
find_get_pages_contig(). Now also supports large folios.

Since we may receive more than nr_pages pages, nr_pages may underflow.
Since nr_pages > 0 is equivalent to index <= end_index, we replaced it
with this check instead.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 fs/btrfs/extent_io.c | 33 +++++++++++++++------------------
 1 file changed, 15 insertions(+), 18 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index bfae67c593c5..2c2f0e281014 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -1900,9 +1900,8 @@ static int __process_pages_contig(struct address_space *mapping,
 	pgoff_t start_index = start >> PAGE_SHIFT;
 	pgoff_t end_index = end >> PAGE_SHIFT;
 	pgoff_t index = start_index;
-	unsigned long nr_pages = end_index - start_index + 1;
 	unsigned long pages_processed = 0;
-	struct page *pages[16];
+	struct folio_batch fbatch;
 	int err = 0;
 	int i;
 
@@ -1911,16 +1910,17 @@ static int __process_pages_contig(struct address_space *mapping,
 		ASSERT(processed_end && *processed_end == start);
 	}
 
-	if ((page_ops & PAGE_SET_ERROR) && nr_pages > 0)
+	if ((page_ops & PAGE_SET_ERROR) && start_index <= end_index)
 		mapping_set_error(mapping, -EIO);
 
-	while (nr_pages > 0) {
-		int found_pages;
+	folio_batch_init(&fbatch);
+	while (index <= end_index) {
+		int found_folios;
+
+		found_folios = filemap_get_folios_contig(mapping, &index,
+				end_index, &fbatch);
 
-		found_pages = find_get_pages_contig(mapping, index,
-				     min_t(unsigned long,
-				     nr_pages, ARRAY_SIZE(pages)), pages);
-		if (found_pages == 0) {
+		if (found_folios == 0) {
 			/*
 			 * Only if we're going to lock these pages, we can find
 			 * nothing at @index.
@@ -1930,23 +1930,20 @@ static int __process_pages_contig(struct address_space *mapping,
 			goto out;
 		}
 
-		for (i = 0; i < found_pages; i++) {
+		for (i = 0; i < found_folios; i++) {
 			int process_ret;
-
+			struct folio *folio = fbatch.folios[i];
 			process_ret = process_one_page(fs_info, mapping,
-					pages[i], locked_page, page_ops,
+					&folio->page, locked_page, page_ops,
 					start, end);
 			if (process_ret < 0) {
-				for (; i < found_pages; i++)
-					put_page(pages[i]);
 				err = -EAGAIN;
+				folio_batch_release(&fbatch);
 				goto out;
 			}
-			put_page(pages[i]);
-			pages_processed++;
+			pages_processed += folio_nr_pages(folio);
 		}
-		nr_pages -= found_pages;
-		index += found_pages;
+		folio_batch_release(&fbatch);
 		cond_resched();
 	}
 out:
-- 
2.36.1

