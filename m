Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BBEB593B33
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Aug 2022 22:34:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243419AbiHOUNP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Aug 2022 16:13:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233632AbiHOUJc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Aug 2022 16:09:32 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CBA183F24;
        Mon, 15 Aug 2022 11:56:02 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id ha11so7689066pjb.2;
        Mon, 15 Aug 2022 11:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=+TETRuQREbWQMsK22eWvupq1sOQwbs1H5QXxZ2DEAgU=;
        b=f3E/ojiaz0NM63zgkJ6u7+tDQzLKIRRocWMkYaGqPGppzv5A2CRcZ4klgHcqLpTBNO
         UngXV4EWEHYrgvCn+TOgh3V4yIN6sgOaH9C/2fJz3k8+uUYVbNPlrkVIIFQfMIJMKIOg
         Zx+3dLSWUqr0a7/Y+/TzyPM78llRWrbfD1OHttkjC8QErSmtqZAWVFzrxI6dRuUcxfZ9
         McsQaV5CDmB3AXS4JCgfoDnPbukLWfrjty6MFRUZTI0z/GMVNZHiomZxIDdgiAh3o0lm
         dAaIbaqHz2liQhdZWWPXXok0hv8bdHGpgBBAGWHIz5lNBWv1Eioqe3n7Vu92977ImC7r
         0b5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=+TETRuQREbWQMsK22eWvupq1sOQwbs1H5QXxZ2DEAgU=;
        b=QRJgZuTVUBW13FCsTgkT7cPOvG9X9a6VU7PWideJaHlmy0/DMfzf+0XpdGCQP9Nctj
         ERFpqG5xfY3Bo/Y4Kpq3UrRjHx5wOxcK9DkxJ1FuXbUaJtHlwnOWyGwxpHGVdFdL0fxb
         oVdXxQICS4m9YSJfAoPgyymIR0/SbkBPp9hSPc2/WF5NY0qrFYnHB+Q/xUKaNzxTq5xj
         E2UX7uHNIffifgpNZJiz0TGSJNpWa5yUgdpktsLgde6iVQqju4d5xB1ymmWOGy+pHI0L
         isZuPwKJ33nlYgvbihxt48OF1czcSvb/+/XJ3RqV8Jmy6vwq1NFOPOi7hOcl0gbgGp8Q
         Fhaw==
X-Gm-Message-State: ACgBeo0HEzyAQWZyi6rqTcJnS/nIh/WaHT3Fs4A/MBSVNFgXItlHnp9n
        dC8DLmmDG0eXyJCdVAdaLTP+Kg9gtHwyiMCr
X-Google-Smtp-Source: AA6agR7CudSG0LqZx+wKC4C1PIGfjK9cuqlus0vYtBkYoxZbg+jdJMDMCTln1TB5lc5Wk4KfUxJMvQ==
X-Received: by 2002:a17:90a:317:b0:1f3:8ad:52aa with SMTP id 23-20020a17090a031700b001f308ad52aamr20072887pje.106.1660589761635;
        Mon, 15 Aug 2022 11:56:01 -0700 (PDT)
Received: from vmfolio.. (c-73-189-111-8.hsd1.ca.comcast.net. [73.189.111.8])
        by smtp.googlemail.com with ESMTPSA id x190-20020a6231c7000000b0052def2e20dasm6858174pfx.167.2022.08.15.11.56.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Aug 2022 11:56:01 -0700 (PDT)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, linux-nilfs@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH 4/7] btrfs: Convert process_page_range() to use filemap_get_folios_contig()
Date:   Mon, 15 Aug 2022 11:54:49 -0700
Message-Id: <20220815185452.37447-5-vishal.moola@gmail.com>
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
index 6fc2b77ae5c3..9a176af847d7 100644
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

