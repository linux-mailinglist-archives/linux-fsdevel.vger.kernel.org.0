Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8634359F044
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Aug 2022 02:43:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232145AbiHXAnB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Aug 2022 20:43:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231535AbiHXAmy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Aug 2022 20:42:54 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEF5186078;
        Tue, 23 Aug 2022 17:42:50 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id c2so14298513plo.3;
        Tue, 23 Aug 2022 17:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=fsvLs3dxCPx9IBTgjKC5zI8Z7kYUASZBA4STFA8FapY=;
        b=kl5Ynp+b/qJi5XM2umHjmSQHEkTDDMvpacUO50PPBjgNqBHxyxqWoXIUMOfjvHAJG3
         oTGpKYfRiQ2GATQsJK0r9x42oinbboBr24fMIoK5LkiCM+8rQCJpZ15JcqKG+SzzWWdV
         /ChBcvv2dcdg92KmuvoNdeZZDzs+3KpmPPVT3ALy0+KQgopUCBZSq4NP89tr0HGtT/0V
         RP+TGfuY37/5Cg37DKL/cYxkJQRHYkhYRtyap5srPgo9RhQ9HCuU/cMf42hMXoTI+xfi
         de7hAL1mVJQ5y0T8dbCMF93yPMTrknbk2/3R/gCW32MNC4js0B9AaAgywAg9xISbM646
         tVJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=fsvLs3dxCPx9IBTgjKC5zI8Z7kYUASZBA4STFA8FapY=;
        b=bA0Ik7P0lpGj3j4xCwXPh0r2c4qXjLbtNSt8ZzMClZG9jkuCS6bvqdzivVhDT68brv
         bowvid55SgQrW6vRILITnX0uX9ST94zrgOJobR4aKi1Vo9p0SW/t+clez404wmobhybc
         eCh8JRnikYG3sE8CFiXBKnzfWBw7/7kH4ru880tFGrT7kg8MGzOGoZpJLkQoxRkD4vuC
         goa+KCv6mDlHwjVvJET86N273i6mcXLDhPvgd8wdUXZ2nyFfCGXycHsX/GgR4LvekA3P
         drQbd+BoT+wRnV5ECqh7m4eXOGy9EBafjk1qDoIJKCnPwS6KBs0GNCfqeuIACJcjXROy
         tIKA==
X-Gm-Message-State: ACgBeo0AJr6dyvNSc5G9l7cGeYtLBLIba69ErPDIVUoncWU0BsLyTFbz
        KvxSBaiyxRqHSsnLXNnAK3FIrMk2kUW/ZHhz
X-Google-Smtp-Source: AA6agR6J0l1eMiiv5vUNrdo/CN/+qTnn+dZoNKOj6OE1MQuDAUmCobIy9S2J7jrjIr9Qw3KkvqcoFw==
X-Received: by 2002:a17:90b:1d02:b0:1fb:77df:2c6 with SMTP id on2-20020a17090b1d0200b001fb77df02c6mr2391864pjb.102.1661301769897;
        Tue, 23 Aug 2022 17:42:49 -0700 (PDT)
Received: from vmfolio.. (c-73-189-111-8.hsd1.ca.comcast.net. [73.189.111.8])
        by smtp.googlemail.com with ESMTPSA id ij5-20020a170902ab4500b0016dd667d511sm11063319plb.252.2022.08.23.17.42.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 17:42:49 -0700 (PDT)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, linux-nilfs@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
        David Sterba <dsterb@suse.com>
Subject: [PATCH v3 4/7] btrfs: Convert process_page_range() to use filemap_get_folios_contig()
Date:   Tue, 23 Aug 2022 17:40:20 -0700
Message-Id: <20220824004023.77310-5-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220824004023.77310-1-vishal.moola@gmail.com>
References: <20220824004023.77310-1-vishal.moola@gmail.com>
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
the removal of find_get_pages_contig(). Now also supports large folios.

Since we may receive more than nr_pages pages, nr_pages may underflow.
Since nr_pages > 0 is equivalent to index <= end_index, we replaced it
with this check instead.

Also minor comment renaming for consistency in subpage.

Acked-by: David Sterba <dsterb@suse.com>
Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 fs/btrfs/subpage.c               |  2 +-
 fs/btrfs/tests/extent-io-tests.c | 32 +++++++++++++++++---------------
 2 files changed, 18 insertions(+), 16 deletions(-)

diff --git a/fs/btrfs/subpage.c b/fs/btrfs/subpage.c
index a105b291444f..6418c38c4b30 100644
--- a/fs/btrfs/subpage.c
+++ b/fs/btrfs/subpage.c
@@ -337,7 +337,7 @@ bool btrfs_subpage_end_and_test_writer(const struct btrfs_fs_info *fs_info,
  *
  * Even with 0 returned, the page still need extra check to make sure
  * it's really the correct page, as the caller is using
- * find_get_pages_contig(), which can race with page invalidating.
+ * filemap_get_folios_contig(), which can race with page invalidating.
  */
 int btrfs_page_start_writer_lock(const struct btrfs_fs_info *fs_info,
 		struct page *page, u64 start, u32 len)
diff --git a/fs/btrfs/tests/extent-io-tests.c b/fs/btrfs/tests/extent-io-tests.c
index a232b15b8021..26b0c99f54b8 100644
--- a/fs/btrfs/tests/extent-io-tests.c
+++ b/fs/btrfs/tests/extent-io-tests.c
@@ -4,6 +4,7 @@
  */
 
 #include <linux/pagemap.h>
+#include <linux/pagevec.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
 #include <linux/sizes.h>
@@ -20,39 +21,40 @@ static noinline int process_page_range(struct inode *inode, u64 start, u64 end,
 				       unsigned long flags)
 {
 	int ret;
-	struct page *pages[16];
+	struct folio_batch fbatch;
 	unsigned long index = start >> PAGE_SHIFT;
 	unsigned long end_index = end >> PAGE_SHIFT;
-	unsigned long nr_pages = end_index - index + 1;
 	int i;
 	int count = 0;
 	int loops = 0;
 
-	while (nr_pages > 0) {
-		ret = find_get_pages_contig(inode->i_mapping, index,
-				     min_t(unsigned long, nr_pages,
-				     ARRAY_SIZE(pages)), pages);
+	folio_batch_init(&fbatch);
+
+	while (index <= end_index) {
+		ret = filemap_get_folios_contig(inode->i_mapping, &index,
+				end_index, &fbatch);
 		for (i = 0; i < ret; i++) {
+			struct folio *folio = fbatch.folios[i];
+
 			if (flags & PROCESS_TEST_LOCKED &&
-			    !PageLocked(pages[i]))
+			    !folio_test_locked(folio))
 				count++;
-			if (flags & PROCESS_UNLOCK && PageLocked(pages[i]))
-				unlock_page(pages[i]);
-			put_page(pages[i]);
+			if (flags & PROCESS_UNLOCK && folio_test_locked(folio))
+				folio_unlock(folio);
 			if (flags & PROCESS_RELEASE)
-				put_page(pages[i]);
+				folio_put(folio);
 		}
-		nr_pages -= ret;
-		index += ret;
+		folio_batch_release(&fbatch);
 		cond_resched();
 		loops++;
 		if (loops > 100000) {
 			printk(KERN_ERR
-		"stuck in a loop, start %llu, end %llu, nr_pages %lu, ret %d\n",
-				start, end, nr_pages, ret);
+		"stuck in a loop, start %llu, end %llu, ret %d\n",
+				start, end, ret);
 			break;
 		}
 	}
+
 	return count;
 }
 
-- 
2.36.1

