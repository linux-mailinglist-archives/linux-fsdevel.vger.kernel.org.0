Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E0C359618F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Aug 2022 19:55:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236709AbiHPRxt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Aug 2022 13:53:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236463AbiHPRxh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Aug 2022 13:53:37 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A35CB65550;
        Tue, 16 Aug 2022 10:53:28 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id 130so9951367pfv.13;
        Tue, 16 Aug 2022 10:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=seovf7hiIocC7KrgUovFX1N/tGF31/3t5G8CMyD0zNk=;
        b=A0QG8rMJwgPAuWRxPlxnmh0emyQWQHjQkk9hr6ZxAF1b/UlBzE2vwG6yDS6Onat/T1
         nRdTln1m+yYp5YakV3snbMptSKhwuNZzSDdp+NESr/ni9xiSwgMDPWEEifb5m0ZosUSV
         9sHCH+S1LknyJ/6Tl+mQPkMXI351gqUZSkqiEPyrq0vLFwuzTIVb8cRw4rdotfCRibYp
         RnT8Uco4OInEnU/NOs8Bxepr+KJ5ngBTyRUVkb2BB3TNyBoiNHJ22I2XvB3SLeWnaXDA
         Tp3f6UUxkmtH/JSg8yZtpECHMchQJlJVuq9dRAuUXMqoOgIXk5bosl31og54wQVNkTFS
         l2UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=seovf7hiIocC7KrgUovFX1N/tGF31/3t5G8CMyD0zNk=;
        b=Rfkl9Ki5U8mynZuUswVJa+lVqioaHRyDmgzYDRhZxBT/HXMYro67kSEuTSPWL38nlP
         g2431vRBY7DeN4Qq8QmloLzMLUjYl2kFHvz8hGOXLUXggrTXwtDLOm4GvqA+QNHoHK2q
         eKt3+tOPqIJqydbFLC1egBgo50lZal8XF6QZY+oC4jCMq19/G3qNTXNv7/UEYpyYmTnH
         +pB7vCmwWRfF2h/4rJPgMn71S42ojW7DHPoI+3nt69Py+miq5T2yx8nxhORCNrVLcsyJ
         o5rG05GJw4e8lSCyotB6sIVg/HTTDM1NM5TamjxWpMSTiiwcb4uynS7hMthm4Er/bn5h
         qseQ==
X-Gm-Message-State: ACgBeo3enmWl+LQvpAcBvhSrXGofdAtSNOljAQBFtpoHLM3moBRwNSby
        n7jphcXnBKBcj+W54CLLhQ8zgCEuOAgSAW8o
X-Google-Smtp-Source: AA6agR5OMPr2DofSZD/3VZBz9h2pJym/U+Ew2vFlF94lnjZe3JsI+ZihdlS1+zjNBbNg0ylOVu34Fg==
X-Received: by 2002:a63:88c7:0:b0:429:a566:e534 with SMTP id l190-20020a6388c7000000b00429a566e534mr3304481pgd.517.1660672407707;
        Tue, 16 Aug 2022 10:53:27 -0700 (PDT)
Received: from vmfolio.. (c-73-189-111-8.hsd1.ca.comcast.net. [73.189.111.8])
        by smtp.googlemail.com with ESMTPSA id mi4-20020a17090b4b4400b001f52fa1704csm3379963pjb.3.2022.08.16.10.53.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 10:53:27 -0700 (PDT)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, linux-nilfs@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH v2 3/7] btrfs: Convert end_compressed_writeback() to use filemap_get_folios()
Date:   Tue, 16 Aug 2022 10:52:42 -0700
Message-Id: <20220816175246.42401-4-vishal.moola@gmail.com>
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

Also this function does not care about the pages being contiguous so we
can just use filemap_get_folios() to be more efficient.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 fs/btrfs/compression.c | 26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index f4564f32f6d9..3dcd5006cfb4 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -8,6 +8,7 @@
 #include <linux/file.h>
 #include <linux/fs.h>
 #include <linux/pagemap.h>
+#include <linux/pagevec.h>
 #include <linux/highmem.h>
 #include <linux/kthread.h>
 #include <linux/time.h>
@@ -339,8 +340,7 @@ static noinline void end_compressed_writeback(struct inode *inode,
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	unsigned long index = cb->start >> PAGE_SHIFT;
 	unsigned long end_index = (cb->start + cb->len - 1) >> PAGE_SHIFT;
-	struct page *pages[16];
-	unsigned long nr_pages = end_index - index + 1;
+	struct folio_batch fbatch;
 	const int errno = blk_status_to_errno(cb->status);
 	int i;
 	int ret;
@@ -348,24 +348,22 @@ static noinline void end_compressed_writeback(struct inode *inode,
 	if (errno)
 		mapping_set_error(inode->i_mapping, errno);
 
-	while (nr_pages > 0) {
-		ret = find_get_pages_contig(inode->i_mapping, index,
-				     min_t(unsigned long,
-				     nr_pages, ARRAY_SIZE(pages)), pages);
+	folio_batch_init(&fbatch);
+	while (index <= end_index) {
+		ret = filemap_get_folios(inode->i_mapping, &index, end_index,
+				&fbatch);
+
 		if (ret == 0) {
-			nr_pages -= 1;
-			index += 1;
-			continue;
+			return;
 		}
 		for (i = 0; i < ret; i++) {
+			struct folio *folio = fbatch.folios[i];
 			if (errno)
-				SetPageError(pages[i]);
-			btrfs_page_clamp_clear_writeback(fs_info, pages[i],
+				folio_set_error(folio);
+			btrfs_page_clamp_clear_writeback(fs_info, &folio->page,
 							 cb->start, cb->len);
-			put_page(pages[i]);
 		}
-		nr_pages -= ret;
-		index += ret;
+		folio_batch_release(&fbatch);
 	}
 	/* the inode may be gone now */
 }
-- 
2.36.1

