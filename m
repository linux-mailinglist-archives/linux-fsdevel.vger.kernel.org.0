Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A6395961A0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Aug 2022 19:55:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236817AbiHPRyE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Aug 2022 13:54:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236675AbiHPRxs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Aug 2022 13:53:48 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87C6B8050E;
        Tue, 16 Aug 2022 10:53:35 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id gp7so10370698pjb.4;
        Tue, 16 Aug 2022 10:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=JxYlL9B7PcenLE4u6mpHNMIpwNwBfeAtvgsgZnBC2EQ=;
        b=Nq+9QouXGb9OtKzDYs9F8DUKfb+2kMYjnY9YqSGh58CPfgXesRfH7AB/vwHuUCUeTZ
         tR5fd1Z2FcQIXpTnaS7MCNHzac6DLnCEZwhEMGe6RP3BtPbE1bgUNGTES/uo1EkkwKA4
         bBPp/B8YXeI20uy2wEPAWp1LrQxh8Pj1Wjzcw3yEXBHfZmbT9IimlafYhclU6FVRnA27
         SrfhSvtNeFiu2pcXT6TLj+fhB1ru65S1RG3ATIcgDiaboBDt96lWqU/L1zom/ilGXrHG
         BBVjwFombZRkSMnrrilxsNTVOFiXeVHFScQYjkPHdUmeuEUHxcBxW2aJm87IVi5lU+Cu
         fGFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=JxYlL9B7PcenLE4u6mpHNMIpwNwBfeAtvgsgZnBC2EQ=;
        b=GAEeBVhV90hifIAhY0WYPedBPLWM44IxWTeFGQVfcpNX2+DluODvXDxBhd5MvCqigY
         +xa7H11hLJphSI8mWV8liga6P2iH5VSvfwhXn41NN2O+aP3aAw9v38S7xHDV0bD3MQeX
         6dotycjQBHoPI4QSlU4uAf7x2MNP2ln0EqchqbDTp6ml7SW17WCeGEASZgXaEPd0dkTE
         TmxvAczUxiuCAmaLoG4PJuC9dkeR5hgKJuEMmwVj+kNyryo8+OJUc07HJ9gQyA3UCH9S
         417dwExWPti0nr4JcmdFqLQ6DnLigMYJG0z3jJiqOn1b31ppQ4Z/0zPDmVTqRvjAWSM6
         0H1w==
X-Gm-Message-State: ACgBeo3nKTLOw5rgJUnXD4NhNS+MVt7XYomaU3XfY2Y9bH3KxpCZBkEI
        daGXInoRyxOQc6bBR3y80lkhOYanWKarSrmq
X-Google-Smtp-Source: AA6agR7GQgPWWrx6Fw7vZ0I/Rl7XXKYgeoRPMw6xhsIRQQbrp+ICKcFNCw0+Sn81oTgAiJYNXMIVQA==
X-Received: by 2002:a17:902:904b:b0:170:a3e6:9d98 with SMTP id w11-20020a170902904b00b00170a3e69d98mr22779756plz.50.1660672414764;
        Tue, 16 Aug 2022 10:53:34 -0700 (PDT)
Received: from vmfolio.. (c-73-189-111-8.hsd1.ca.comcast.net. [73.189.111.8])
        by smtp.googlemail.com with ESMTPSA id mi4-20020a17090b4b4400b001f52fa1704csm3379963pjb.3.2022.08.16.10.53.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 10:53:33 -0700 (PDT)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, linux-nilfs@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH v2 6/7] ramfs: Convert ramfs_nommu_get_unmapped_area() to use filemap_get_folios_contig()
Date:   Tue, 16 Aug 2022 10:52:45 -0700
Message-Id: <20220816175246.42401-7-vishal.moola@gmail.com>
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

