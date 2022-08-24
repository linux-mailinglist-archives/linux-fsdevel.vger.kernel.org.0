Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84D4059F04B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Aug 2022 02:43:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232372AbiHXAnD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Aug 2022 20:43:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231516AbiHXAmy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Aug 2022 20:42:54 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57A5A861FB;
        Tue, 23 Aug 2022 17:42:53 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id io24so993013plb.1;
        Tue, 23 Aug 2022 17:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=uj5rrWVo2hhIgeuvVD0w6VogaYUvVvctXUbaYlCVCAo=;
        b=ojG9SQPgHrXaANCUaSiNdwQENvFe0haF1bqg2TNsX0PZ4L89+S9oEqG3x9mSHNOmCX
         fEkkxL5MmF2Z+NoSCrF7uNfE6LOSdRvjC+VTS7SYmQu5M4NnGKBD9B5TiVgrFjDzCruf
         ANQMTXrR9WRRE/NMOxIWTzrUPOQwD6wcQDRW7d/A3HQruAY8Q/LFHBCLjO+NulfdW0ej
         OG6BFSK5Hgghaq2RPMGKBYCZxcxHmlqEO0Kwmibm4qoLBH+INxAubDUtJqb670NJ+JN/
         WmfukncGRHe3XrC+vSmdtg51xSWy2Eoaktuu073lH25G+RTwB0r8uRdzZPr4xNjjFfn5
         aEjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=uj5rrWVo2hhIgeuvVD0w6VogaYUvVvctXUbaYlCVCAo=;
        b=3I1DUeXQc+AuvvsT2UdB1Q+k63u4/SGMDV5l04jAgzaUhiGMHpmtpdCXofPlsHJ7Ab
         J/pa3A2xZ/GHCPTvXbSsgxclQfSo5Gs00ubkKJJMZrzaQZ6eYT3cPFiZ6WmBvmFe0Y3e
         ReX5ZTLT7+egGfZOXXPlgmphFhM4GJ5J7ccz5lD6jVBP+dCJ1OcLySdSZQUtkSIHRR9t
         V/GUO2Irx+ht48B/16LWuo5UW1jqltyyeZJ0fH6NGZbcvLj4fLx9D4lAn+V4rT969sHB
         33sCxwurDcIvdnyFPKx0c7c9LEJ8rRjTtcEa0jI3sfffx2m7RHvl0sxadgYGxw5EviSN
         GslQ==
X-Gm-Message-State: ACgBeo20m0cXw7mBw99KhvNV075cEnLFWP67YUtT9YmXZ9ROAx9T/pUB
        ZZD0zz6ci4sGIl29aFE/pdVyUYQ8ypxB7Q4m
X-Google-Smtp-Source: AA6agR4QKpwL6R2zyk4XY3/XZMQUNveYTQy+QnagYV81kICTpxGmHkiP0SGAa0ajiEmDjO3dLDXJ2Q==
X-Received: by 2002:a17:902:7b87:b0:172:8ae9:2015 with SMTP id w7-20020a1709027b8700b001728ae92015mr26859761pll.112.1661301772273;
        Tue, 23 Aug 2022 17:42:52 -0700 (PDT)
Received: from vmfolio.. (c-73-189-111-8.hsd1.ca.comcast.net. [73.189.111.8])
        by smtp.googlemail.com with ESMTPSA id ij5-20020a170902ab4500b0016dd667d511sm11063319plb.252.2022.08.23.17.42.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 17:42:51 -0700 (PDT)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, linux-nilfs@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH v3 6/7] ramfs: Convert ramfs_nommu_get_unmapped_area() to use filemap_get_folios_contig()
Date:   Tue, 23 Aug 2022 17:40:22 -0700
Message-Id: <20220824004023.77310-7-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220824004023.77310-1-vishal.moola@gmail.com>
References: <20220824004023.77310-1-vishal.moola@gmail.com>
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
---
 fs/ramfs/file-nommu.c | 50 +++++++++++++++++++++++++------------------
 1 file changed, 29 insertions(+), 21 deletions(-)

diff --git a/fs/ramfs/file-nommu.c b/fs/ramfs/file-nommu.c
index ba3525ccc27e..cb240eac5036 100644
--- a/fs/ramfs/file-nommu.c
+++ b/fs/ramfs/file-nommu.c
@@ -203,9 +203,9 @@ static unsigned long ramfs_nommu_get_unmapped_area(struct file *file,
 					    unsigned long addr, unsigned long len,
 					    unsigned long pgoff, unsigned long flags)
 {
-	unsigned long maxpages, lpages, nr, loop, ret;
+	unsigned long maxpages, lpages, nr_folios, loop, ret, nr_pages, pfn;
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
+	nr_folios = filemap_get_folios_contig(inode->i_mapping, &pgoff,
+			ULONG_MAX, &fbatch);
+	if (!nr_folios) {
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
+	for (loop = 0; loop < nr_folios; loop++) {
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

