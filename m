Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A4C35B60D6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Sep 2022 20:30:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231262AbiILS3O (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Sep 2022 14:29:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230414AbiILS2S (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Sep 2022 14:28:18 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D8314505D;
        Mon, 12 Sep 2022 11:26:08 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id c198so9411335pfc.13;
        Mon, 12 Sep 2022 11:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=dVPmZmiNC1IS+YQLU6Y2NRJjfhjAkHbCXCFivKSKXpI=;
        b=oBC4zDF+WDmWgW6D6j4kBVoNttmlzw7SM2Dud9K5aTIdeGHp6wASaYdQxbVSVMg8yy
         1YLMgIW9WwwzQjDsnXwvkJcEoVrmIMjU4Oj1Gcrg49Y37eBvbDf/EC41Vj4/jMMb+7Ck
         FCgSenb4wxPcxoi+kVc413A4xthL7v8gDDW1BWNADPokKLTbv0CesCH7p5XEg8gDVRKk
         iNqUvQ+pbDF5tyVENwqTvEKGaaIFS9mWFC71GvQccH45wKLom6EQlIeUp/cnrRObUn1x
         PZzV5sEe9lO7DYLyaBFMFDqCajFMmNm4YjLGgrURc+6n/8mveQORYhKJQMSfY5QF3W9m
         HbnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=dVPmZmiNC1IS+YQLU6Y2NRJjfhjAkHbCXCFivKSKXpI=;
        b=s0zbtbUubihd6cN4HbZ/ZzXhp3UbtTyQNHCry07/36u4LmNqVIRZrslRVj7Asmzc5U
         DvtNmCJ+nhqSKrgkFrJ/o+iBP4bo4FzyATMnpYqO9Pi7sikz5ZkguXoHeGxp6Dq0txJU
         7EH1Sw5FLFN46z3c3COI1AHMJVATSChn3dJ7G78LyYtESsUeZvbzw5yCXzzO/C1nfU0L
         DxJ3+fthcVRU3EmQlje2JrF94kfPS1zfAZeE1yt7viKF46na67gvmohkOXxL46lUUSdC
         ha8AcqWreEC2RvvKaJZZ/YgKYTJajkY7REROG+XAXM/KVKadRhog1on8qTWjdgCzCPr0
         4HsQ==
X-Gm-Message-State: ACgBeo3alZnuN22eEQl7X9V/A6/T/PhTW2O0P5PX9svjyo/gpc406nB0
        UZcTM2BveOyLRejIflARNpywFa+xV0yq/g==
X-Google-Smtp-Source: AA6agR5Acqv7pt8aCugWQSlcu/2da/0WS5pUMnHLkzNbb0SnOalV4W4VSmf07FU6/EySzET52sgc5A==
X-Received: by 2002:a63:5a0b:0:b0:434:4748:4e7a with SMTP id o11-20020a635a0b000000b0043447484e7amr24353361pgb.561.1663007151035;
        Mon, 12 Sep 2022 11:25:51 -0700 (PDT)
Received: from vmfolio.. (c-73-189-111-8.hsd1.ca.comcast.net. [73.189.111.8])
        by smtp.googlemail.com with ESMTPSA id x127-20020a626385000000b0053b2681b0e0sm5916894pfb.39.2022.09.12.11.25.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Sep 2022 11:25:50 -0700 (PDT)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-cifs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-nilfs@vger.kernel.org, linux-mm@kvack.org,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH v2 18/23] nilfs2: Convert nilfs_lookup_dirty_data_buffers() to use filemap_get_folios_tag()
Date:   Mon, 12 Sep 2022 11:22:19 -0700
Message-Id: <20220912182224.514561-19-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220912182224.514561-1-vishal.moola@gmail.com>
References: <20220912182224.514561-1-vishal.moola@gmail.com>
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
index 0afe0832c754..c3f3484c4412 100644
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
+		folio_lock(folio);
+		head = folio_buffers(folio);
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

