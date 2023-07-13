Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0C56751704
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jul 2023 05:55:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233768AbjGMDzh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Jul 2023 23:55:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232167AbjGMDzb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Jul 2023 23:55:31 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC7EF1FD7;
        Wed, 12 Jul 2023 20:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=elFZct2zLYsO/DhALW8T/PkTJ32hYfvGI0lmoYqZOm8=; b=fCiRDDQ0vsrg84r3mAsPC/UJja
        5X9ojaJStev+XTF+eZJYbr17rKhQEEX9Ks9wL4MCB6e7OI6ojgep5XBSuh/DBw8cfgfEvy2BmKc6u
        Li69Ba8gh1z058APNhZq5Aim+JeSvfn8oczbZ4uMvAO4v7izUuF/mdeN/YyX/c+/D3ShMIyWMhaHy
        t7H/nzZ29DsCV9n+Duqfz91bmWB+fVjVvJVRGMp+cqXowLegsfEb7Q9RgjYONN/HJhfmvQwB4DFzh
        AK67mENltmR7LSdQ2RuuBlSfxaQqWnviR/iXAJKzBqP6VDC98loO+gHarV82dAFbYyh5TW3hzlwdr
        Fwca4Cew==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qJnQA-00HMrq-Qg; Thu, 13 Jul 2023 03:55:14 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        David Sterba <dsterba@suse.com>, linux-fsdevel@vger.kernel.org,
        Pankaj Raghav <p.raghav@samsung.com>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        ntfs3@lists.linux.dev, "Theodore Tso" <tytso@mit.edu>,
        Jan Kara <jack@suse.com>, linux-ext4@vger.kernel.org
Subject: [PATCH 7/7] buffer: Remove set_bh_page()
Date:   Thu, 13 Jul 2023 04:55:12 +0100
Message-Id: <20230713035512.4139457-8-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230713035512.4139457-1-willy@infradead.org>
References: <20230713035512.4139457-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

With all users converted to folio_set_bh(), remove this function.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/buffer.c                 | 15 ---------------
 include/linux/buffer_head.h |  2 --
 2 files changed, 17 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index 587e4d4af9de..f0563ebae75f 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -1539,21 +1539,6 @@ void invalidate_bh_lrus_cpu(void)
 	bh_lru_unlock();
 }
 
-void set_bh_page(struct buffer_head *bh,
-		struct page *page, unsigned long offset)
-{
-	bh->b_page = page;
-	BUG_ON(offset >= PAGE_SIZE);
-	if (PageHighMem(page))
-		/*
-		 * This catches illegal uses and preserves the offset:
-		 */
-		bh->b_data = (char *)(0 + offset);
-	else
-		bh->b_data = page_address(page) + offset;
-}
-EXPORT_SYMBOL(set_bh_page);
-
 void folio_set_bh(struct buffer_head *bh, struct folio *folio,
 		  unsigned long offset)
 {
diff --git a/include/linux/buffer_head.h b/include/linux/buffer_head.h
index a7377877ff4e..06566aee94ca 100644
--- a/include/linux/buffer_head.h
+++ b/include/linux/buffer_head.h
@@ -194,8 +194,6 @@ void buffer_check_dirty_writeback(struct folio *folio,
 void mark_buffer_dirty(struct buffer_head *bh);
 void mark_buffer_write_io_error(struct buffer_head *bh);
 void touch_buffer(struct buffer_head *bh);
-void set_bh_page(struct buffer_head *bh,
-		struct page *page, unsigned long offset);
 void folio_set_bh(struct buffer_head *bh, struct folio *folio,
 		  unsigned long offset);
 bool try_to_free_buffers(struct folio *);
-- 
2.39.2

