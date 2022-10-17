Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C63B6019F4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Oct 2022 22:29:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231572AbiJQU16 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Oct 2022 16:27:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230362AbiJQU1A (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Oct 2022 16:27:00 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E50037E83C;
        Mon, 17 Oct 2022 13:25:46 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id l1so11789228pld.13;
        Mon, 17 Oct 2022 13:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HDAaQjWw9mFQrxjxUUwcIUCSC2HAIvgNCPk+fwsNTgA=;
        b=KyZrIS2cRBI9Wi/s6j+k5Un+7xp/wwbjLfcNmkVss+gpEVM+6g9eB8E+kDr4ib/o9h
         aHZiqvGPcTO1RO0jkEq+CHtdYaQKQfVuoWerdbvVDifz5h14hCHY1ghQf1SL3/CEdh11
         opq+bBxZbhYQFO+7l9ipSWqSYpcVET1qxgS/dFbZ3YpA8WAY5aRBjLdlXQ+GF1IEYumz
         mhbeFFWVxeBoA+sLdrLdfFPXm81t+2pA2/aP8VFL3BoQvWah+LWY3LmumYhfXUeul7r/
         qn4+/zr/qr23Eqfc68ILRUEWUJNu0aVAW3XQ2taH9/TvZGJMRKjkxGOL4AtxxdlkSFnb
         Lm5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HDAaQjWw9mFQrxjxUUwcIUCSC2HAIvgNCPk+fwsNTgA=;
        b=S/vJbqpl9QLK4LMYeF9sWeATRLx81rz9Lh5ODLtS9V+vujCyAn+GX69M36ZYdJnTZP
         e9/Ldh8AD3U8nYJWMF5IcwR/z9v1F0R/qQJE+LyC/U+C/Rz6AezwfjH5+FL5fcZtipyB
         6SNgLflRpJFsDIyiZronayw13gu3TJF7xVnuGPt9Tiwr0K0oW7JFV6KuybZq4JrR/Vxa
         kwFZxcs0MoOCmxYHraPTFpoDShJEAKavlA+8n7O/yc3iVge0cVTFZk6xtDQmLShRzBB1
         M7v/RdxXFNgqOutWRDIW+XZU/o3PhiA6Vhu/abtkfljO3aRF4GqkRoz+WnEBugeUz9oA
         1Ucg==
X-Gm-Message-State: ACrzQf1R5BSwAVxipBa35F1r0p08afXtY9nkfR3L/3+U50OqwKLQ8gwg
        SmlsgUEsrHBPhJfwx8yibdmZ6niqfqlUVQ==
X-Google-Smtp-Source: AMsMyM5Oo/lMY32Rbjb2P42pIGit9i9BhaRia6oUIpcpnkGGb4iF3F4dLHfVbSpgqfYoEpbtvaO4MA==
X-Received: by 2002:a17:902:d714:b0:17f:5813:1df4 with SMTP id w20-20020a170902d71400b0017f58131df4mr14158278ply.148.1666038312014;
        Mon, 17 Oct 2022 13:25:12 -0700 (PDT)
Received: from vmfolio.. (c-76-102-73-225.hsd1.ca.comcast.net. [76.102.73.225])
        by smtp.googlemail.com with ESMTPSA id pj12-20020a17090b4f4c00b00200b12f2bf5sm145037pjb.1.2022.10.17.13.25.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 13:25:11 -0700 (PDT)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-cifs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-nilfs@vger.kernel.org, linux-mm@kvack.org,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>
Subject: [PATCH v3 18/23] nilfs2: Convert nilfs_lookup_dirty_data_buffers() to use filemap_get_folios_tag()
Date:   Mon, 17 Oct 2022 13:24:46 -0700
Message-Id: <20221017202451.4951-19-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20221017202451.4951-1-vishal.moola@gmail.com>
References: <20221017202451.4951-1-vishal.moola@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Convert function to use folios throughout. This is in preparation for
the removal of find_get_pages_range_tag().

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
Acked-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
---
 fs/nilfs2/segment.c | 29 ++++++++++++++++-------------
 1 file changed, 16 insertions(+), 13 deletions(-)

diff --git a/fs/nilfs2/segment.c b/fs/nilfs2/segment.c
index b4cebad21b48..2183e1698f8e 100644
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

