Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2346593B6E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Aug 2022 22:35:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242460AbiHOUNL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Aug 2022 16:13:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243202AbiHOUJe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Aug 2022 16:09:34 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB25883F2B;
        Mon, 15 Aug 2022 11:56:04 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id k14so7356280pfh.0;
        Mon, 15 Aug 2022 11:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=JxYlL9B7PcenLE4u6mpHNMIpwNwBfeAtvgsgZnBC2EQ=;
        b=Ia1O+/fmqiUDytIZqSmA1V3vSbkX1zepYr8UWJ1xOY+Au2TuQsU1CjaK+zT0PLsmd/
         E+O3yzfMaR5NdY5ImhVrdZFqgG8IY6GLyAkAuZAxXNJ7g1frwjv+xObysOMw9ZQj9N38
         V4kBxNRZzYBXVht6J1C8aUFPM4q7f2/Mr6FKOhM86huxwwIsCgF7Ec+Fkmx2Imxe112s
         8rZyF/n/+Pg4xSWae5jHMVbRnTduCkxC52xGgOOsHGt0tWEXwod/MCwauyzBrtSeu3v4
         sUXY2yNRl9HIjovNajfVtO2mLmyLZtZShw82f7ZwxsdOEL4uwXFqQMMX21AafPCChnds
         jq0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=JxYlL9B7PcenLE4u6mpHNMIpwNwBfeAtvgsgZnBC2EQ=;
        b=SMuoO6dZuxrtaxSGMmc4K5ydFPPtFQ3oro9UVvgmz/HBIPdlyZUn4WB6RfRitx04Gp
         4zKOHgUjxRLLhE4qtpd+5b1URua+XpvlUe6KH1tJ65BZm1q2SpeY42wimbCnojm+xrRM
         yU8zp0IvZ1Xh02IH1tOSmQEXGtY4diRzmKHGal9C16NlqZDkTdkvsqIKbRx8me6bFNQp
         PScsu9XKdtmiMt2f05VM/Jl4V212NjeoS9wdIchlo/qWy+uLfBqRldG9UhAmUeCh2rip
         SZxY9pi7o2GXAhwanbK6hqZ13Br8W3Ou7ExYJoJEoZeTwU/g8/QI67rnUfLcyBnMupo4
         G0BA==
X-Gm-Message-State: ACgBeo0rW5G75JlfL3sOS99CAEFaYDrqaQvQBQbumxdz0+vIzVeCZX0d
        tmY0yfkzWDlL/6EEUrMxfasrUhx8vtpwWb6L
X-Google-Smtp-Source: AA6agR4vgieevqYQjgOv8/gNfqzyTLP+yvvViGRQmf5ckGQ1mKZhtPq+2QJlr6dvquuI43mj/Y/Dug==
X-Received: by 2002:a63:d5:0:b0:41a:58f:929e with SMTP id 204-20020a6300d5000000b0041a058f929emr14627963pga.260.1660589764035;
        Mon, 15 Aug 2022 11:56:04 -0700 (PDT)
Received: from vmfolio.. (c-73-189-111-8.hsd1.ca.comcast.net. [73.189.111.8])
        by smtp.googlemail.com with ESMTPSA id x190-20020a6231c7000000b0052def2e20dasm6858174pfx.167.2022.08.15.11.56.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Aug 2022 11:56:03 -0700 (PDT)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, linux-nilfs@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH 6/7] ramfs: Convert ramfs_nommu_get_unmapped_area() to use filemap_get_folios_contig()
Date:   Mon, 15 Aug 2022 11:54:51 -0700
Message-Id: <20220815185452.37447-7-vishal.moola@gmail.com>
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

Converted to use folios throughout. This is in preparation for the
removal for find_get_pages_contig(). Now also supports large folios.

The initial version of this function set the page_address to be returned
after finishing all the checks. Since folio_batches have a maximum of 15
folios, the function had to be modified to support getting and checking up
to lpages, 15 pages at a time while still returning the initial page address.
Now the function sets ret as soon as the first batch arrives, and updates it
only if a check fails.

The physical adjacency check utilizes the page frame numbers. The page frame
number of each folio must be nr_pages away from the first folio.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 fs/ramfs/file-nommu.c | 50 +++++++++++++++++++++++++------------------
 1 file changed, 29 insertions(+), 21 deletions(-)

diff --git a/fs/ramfs/file-nommu.c b/fs/ramfs/file-nommu.c
index ba3525ccc27e..81817f301e17 100644
--- a/fs/ramfs/file-nommu.c
+++ b/fs/ramfs/file-nommu.c
@@ -203,9 +203,9 @@ static unsigned long ramfs_nommu_get_unmapped_area(struct file *file,
 					    unsigned long addr, unsigned long len,
 					    unsigned long pgoff, unsigned long flags)
 {
-	unsigned long maxpages, lpages, nr, loop, ret;
+	unsigned long maxpages, lpages, nr, loop, ret, nr_pages, pfn;
 	struct inode *inode = file_inode(file);
-	struct page **pages = NULL, **ptr, *page;
+	struct folio_batch fbatch;
 	loff_t isize;
 
 	/* the mapping mustn't extend beyond the EOF */
@@ -221,31 +221,39 @@ static unsigned long ramfs_nommu_get_unmapped_area(struct file *file,
 		goto out;
 
 	/* gang-find the pages */
-	pages = kcalloc(lpages, sizeof(struct page *), GFP_KERNEL);
-	if (!pages)
-		goto out_free;
-
-	nr = find_get_pages_contig(inode->i_mapping, pgoff, lpages, pages);
-	if (nr != lpages)
-		goto out_free_pages; /* leave if some pages were missing */
+	folio_batch_init(&fbatch);
+	nr_pages = 0;
+repeat:
+	nr = filemap_get_folios_contig(inode->i_mapping, &pgoff,
+			ULONG_MAX, &fbatch);
+	if (!nr) {
+		ret = -ENOSYS;
+		return ret;
+	}
 
+	if (ret == -ENOSYS) {
+		ret = (unsigned long) folio_address(fbatch.folios[0]);
+		pfn = folio_pfn(fbatch.folios[0]);
+	}
 	/* check the pages for physical adjacency */
-	ptr = pages;
-	page = *ptr++;
-	page++;
-	for (loop = lpages; loop > 1; loop--)
-		if (*ptr++ != page++)
-			goto out_free_pages;
+	for (loop = 0; loop < nr; loop++) {
+		if (pfn + nr_pages != folio_pfn(fbatch.folios[loop])) {
+			ret = -ENOSYS;
+			goto out_free; /* leave if not physical adjacent */
+		}
+		nr_pages += folio_nr_pages(fbatch.folios[loop]);
+		if (nr_pages >= lpages)
+			goto out_free; /* successfully found desired pages*/
+	}
 
+	if (nr_pages < lpages) {
+		folio_batch_release(&fbatch);
+		goto repeat; /* loop if pages are missing */
+	}
 	/* okay - all conditions fulfilled */
-	ret = (unsigned long) page_address(pages[0]);
 
-out_free_pages:
-	ptr = pages;
-	for (loop = nr; loop > 0; loop--)
-		put_page(*ptr++);
 out_free:
-	kfree(pages);
+	folio_batch_release(&fbatch);
 out:
 	return ret;
 }
-- 
2.36.1

