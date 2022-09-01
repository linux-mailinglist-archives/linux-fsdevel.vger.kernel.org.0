Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F3FB5AA289
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Sep 2022 00:11:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235152AbiIAWGu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Sep 2022 18:06:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235039AbiIAWFl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Sep 2022 18:05:41 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B53F29F18E;
        Thu,  1 Sep 2022 15:03:19 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id y1so118856plb.2;
        Thu, 01 Sep 2022 15:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=STxbhiL9IoQUx8Fgwja3LTFavGfQLVFycqxgyDfQIlo=;
        b=mGc2AoTR/eShDxn1bEGmqvAylW19QjNRk+3TcxKgV4984n2y3D5OuujULmMIC93l/e
         994+ww4T76o6BwzB7Dyfg1FF5LjMDxODXBmaL6NBji3traBoNonz2I7oQAmlcfxNHVOA
         JLdLJqIa03W2Qrsk2PIvMnMysU/ngcbLVN/BRQBiNvcP54q0fdpfZuno15/BTBEyV9zg
         LqeO6y2P9pncUMeumeGyzoYeeCTEq6ojO8ZrLkKxcxzK4cx52ZP/vQb7lv19FhPcRb0w
         pXJidnaUHcjIUUhd88lBjjlm5xn6XbNJLDk41pSKS73ei7RFGp2h8pKrtvCI0OhjWSf8
         m3FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=STxbhiL9IoQUx8Fgwja3LTFavGfQLVFycqxgyDfQIlo=;
        b=pGteOc4eMx2C36gRBGx0owrQkOXDJCsrKz3F9XyoUsGAUfGyhGCF+NWs4mqkAD4x70
         pYcv1Ss6gBfzaIC7kELwpdbSNwy7i3Qh6NUzsSYw0ioconkQD+VslVsvGuqXaMX6uDM2
         YmBh11lJ5mKz+djDhsLKHjEIzEsphpgZmH59gVN2txs9PRZ2JVb1VyZFzyP7LiHhKQjt
         YKFt5o4u/jAIBL9nAPFWPI9AxQ+FoL1TWE3SFoWDWfE8fPFhST6MMNUEpfGea4Npeh6I
         idlZ0zVkWrbvj2aEIiJXYrgBUPKOqI4mB/Z6vGSQYLFI4tNwlNfg9rlUDUUdmJFxOG+T
         u5hw==
X-Gm-Message-State: ACgBeo0vuB++oQ8Zs9LeZhnje+ZN7RqGLVGFICg6wQuT49ynpZ7PG4bc
        /R6l4sSTeIUs4aE3DtkQo5gnm/CLisZ7Cw==
X-Google-Smtp-Source: AA6agR5hhXeukBftcpo4uj8qt2S1ZJNE07BNY5BMKr4j8Hs713UO7OgYoXkgvfwPLmscDaOkJk3Q/A==
X-Received: by 2002:a17:90b:212:b0:1fd:e61b:866a with SMTP id fy18-20020a17090b021200b001fde61b866amr1263582pjb.141.1662069780541;
        Thu, 01 Sep 2022 15:03:00 -0700 (PDT)
Received: from vmfolio.. (c-73-189-111-8.hsd1.ca.comcast.net. [73.189.111.8])
        by smtp.googlemail.com with ESMTPSA id fv4-20020a17090b0e8400b001fb350026f1sm128894pjb.4.2022.09.01.15.02.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 15:03:00 -0700 (PDT)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-cifs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-nilfs@vger.kernel.org, linux-mm@kvack.org,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH 18/23] nilfs2: Convert nilfs_lookup_dirty_data_buffers() to use filemap_get_folios_tag()
Date:   Thu,  1 Sep 2022 15:01:33 -0700
Message-Id: <20220901220138.182896-19-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220901220138.182896-1-vishal.moola@gmail.com>
References: <20220901220138.182896-1-vishal.moola@gmail.com>
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

Convert function to use folios throughout. This is in preparation for
the removal of find_get_pages_range_tag().

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 fs/nilfs2/segment.c | 29 ++++++++++++++++-------------
 1 file changed, 16 insertions(+), 13 deletions(-)

diff --git a/fs/nilfs2/segment.c b/fs/nilfs2/segment.c
index 0afe0832c754..e95c667bdc8f 100644
--- a/fs/nilfs2/segment.c
+++ b/fs/nilfs2/segment.c
@@ -680,7 +680,7 @@ static size_t nilfs_lookup_dirty_data_buffers(struct inode *inode,
 					      loff_t start, loff_t end)
 {
 	struct address_space *mapping = inode->i_mapping;
-	struct pagevec pvec;
+	struct folio_batch fbatch;
 	pgoff_t index = 0, last = ULONG_MAX;
 	size_t ndirties = 0;
 	int i;
@@ -694,23 +694,26 @@ static size_t nilfs_lookup_dirty_data_buffers(struct inode *inode,
 		index = start >> PAGE_SHIFT;
 		last = end >> PAGE_SHIFT;
 	}
-	pagevec_init(&pvec);
+	folio_batch_init(&fbatch);
  repeat:
 	if (unlikely(index > last) ||
-	    !pagevec_lookup_range_tag(&pvec, mapping, &index, last,
-				PAGECACHE_TAG_DIRTY))
+	      !filemap_get_folios_tag(mapping, &index, last,
+		      PAGECACHE_TAG_DIRTY, &fbatch))
 		return ndirties;
 
-	for (i = 0; i < pagevec_count(&pvec); i++) {
+	for (i = 0; i < folio_batch_count(&fbatch); i++) {
 		struct buffer_head *bh, *head;
-		struct page *page = pvec.pages[i];
+		struct folio *folio = fbatch.folios[i];
 
-		lock_page(page);
-		if (!page_has_buffers(page))
-			create_empty_buffers(page, i_blocksize(inode), 0);
-		unlock_page(page);
+		head = folio_buffers(folio);
+		folio_lock(folio);
+		if (!head) {
+			create_empty_buffers(&folio->page, i_blocksize(inode), 0);
+			head = folio_buffers(folio);
+		}
+		folio_unlock(folio);
 
-		bh = head = page_buffers(page);
+		bh = head;
 		do {
 			if (!buffer_dirty(bh) || buffer_async_write(bh))
 				continue;
@@ -718,13 +721,13 @@ static size_t nilfs_lookup_dirty_data_buffers(struct inode *inode,
 			list_add_tail(&bh->b_assoc_buffers, listp);
 			ndirties++;
 			if (unlikely(ndirties >= nlimit)) {
-				pagevec_release(&pvec);
+				folio_batch_release(&fbatch);
 				cond_resched();
 				return ndirties;
 			}
 		} while (bh = bh->b_this_page, bh != head);
 	}
-	pagevec_release(&pvec);
+	folio_batch_release(&fbatch);
 	cond_resched();
 	goto repeat;
 }
-- 
2.36.1

