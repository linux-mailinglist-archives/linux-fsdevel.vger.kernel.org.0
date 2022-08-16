Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51A635961A1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Aug 2022 19:55:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236775AbiHPRxv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Aug 2022 13:53:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236633AbiHPRxr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Aug 2022 13:53:47 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EFF67AC02;
        Tue, 16 Aug 2022 10:53:31 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id c2so1512052plo.3;
        Tue, 16 Aug 2022 10:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=zEWA5Mz5qgiKRAyUDs57laoSTQi4JTinbk89K1VeDTg=;
        b=Q0jTOXo0r8co2kNY7avhSUyp1min9bEFsIm1c2a5izPGeJQJyrPEAdD/n+GuHi8PWd
         WDStj6ozmxAN2tU8n0OKp1MPPxLW30a+rTvbx7Em+x0pgSFHhDJIWxTzr8OhJrSdE1iQ
         J/cZAICwfQm78pCbo4YRcdifiMgACJZJJeJfKQ90aQHcbOLTrcfKeLde4inZkvLukGdo
         fsrPaibUyeZTQcqDwhOMT3JDJ+Niv+a0cdWCMmdyIVFOUoqIraeDZhAU0Lz0n0wHdAni
         CbdZ22zpnt5sFgJAo2zIgwtwYFfiaDOqSKqpG+qLfvUloduCa5fc3Mk2m1FjVMPb80Bj
         gjBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=zEWA5Mz5qgiKRAyUDs57laoSTQi4JTinbk89K1VeDTg=;
        b=oAOk2T67KR5qlvccr7/wrxINLAP8h+lYK9tUi1J8BEYCapE9pgZeMqyYdlpbkVq/Qa
         rR8CXSUAdVuez0G1fwvGec/WbWMWk+4RxW9aaKmveGs0D2L7F3uSh0R0Httn3YEnsICr
         2eWG7MQvirnUcG0f+KMu7KyxR8YUTivO1Zydg1uk103HKigVd8RpJRzvpMI8nT/+oJaS
         Bywa4AbtW60CImUy48g/yvNuWbP8Q+bTDqDBixgelD5eXQKxLNqsO8dnXNYGkzXWBjeF
         W0h1jPI1qcMrDVn4tz9WSQAcS5MgmkgPzH6Gyv2UnjBST+z1lgPB7g/lPfHtpJQcCuZ9
         JJFg==
X-Gm-Message-State: ACgBeo0zHCvrycQdvrU9pVI2ViZezbXLjLjou+AmxAAqTe4T2lRdTl6I
        vAHEmCrMypRn3Ma03aFFrf8fVEOeJfvc25lN
X-Google-Smtp-Source: AA6agR61JnV3Crbh6hYVNBysj3mGvmoS9RGt6Gp3A5bI59WrLZeu7LtBj/cszoS3ATgEqLUhuvnKbQ==
X-Received: by 2002:a17:903:494:b0:172:9823:e355 with SMTP id jj20-20020a170903049400b001729823e355mr28574plb.75.1660672410347;
        Tue, 16 Aug 2022 10:53:30 -0700 (PDT)
Received: from vmfolio.. (c-73-189-111-8.hsd1.ca.comcast.net. [73.189.111.8])
        by smtp.googlemail.com with ESMTPSA id mi4-20020a17090b4b4400b001f52fa1704csm3379963pjb.3.2022.08.16.10.53.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 10:53:29 -0700 (PDT)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, linux-nilfs@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH v2 4/7] btrfs: Convert process_page_range() to use filemap_get_folios_contig()
Date:   Tue, 16 Aug 2022 10:52:43 -0700
Message-Id: <20220816175246.42401-5-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220816175246.42401-1-vishal.moola@gmail.com>
References: <20220816175246.42401-1-vishal.moola@gmail.com>
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

Converted function to use folios throughout. This is in preparation for
the removal of find_get_pages_contig(). Now also supports large folios.

Since we may receive more than nr_pages pages, nr_pages may underflow.
Since nr_pages > 0 is equivalent to index <= end_index, we replaced it
with this check instead.

Also minor comment renaming for consistency in subpage.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 fs/btrfs/subpage.c               |  2 +-
 fs/btrfs/tests/extent-io-tests.c | 31 ++++++++++++++++---------------
 2 files changed, 17 insertions(+), 16 deletions(-)

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
index a232b15b8021..530073868916 100644
--- a/fs/btrfs/tests/extent-io-tests.c
+++ b/fs/btrfs/tests/extent-io-tests.c
@@ -4,6 +4,7 @@
  */
 
 #include <linux/pagemap.h>
+#include <linux/pagevec.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
 #include <linux/sizes.h>
@@ -20,39 +21,39 @@ static noinline int process_page_range(struct inode *inode, u64 start, u64 end,
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

