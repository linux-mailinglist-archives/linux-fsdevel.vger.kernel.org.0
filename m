Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BC6E751701
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jul 2023 05:55:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233764AbjGMDzf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Jul 2023 23:55:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233760AbjGMDz3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Jul 2023 23:55:29 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 873401BF2;
        Wed, 12 Jul 2023 20:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=dJKZzviGYlfiGYN+f/pIQkUos4W3rI9n2ymwoSwEN4E=; b=O8wuDQaNnlTjc1xtfxNp+u8rnS
        Ap0eYMhkM967U5HZdWTHyw9vqDYUSM1YXM6dXL7PDULiwGZyXgTNUuq20ah7k8RpTu2V3Y3Yb7KxP
        3BPPsSUZAoDFil2dDgaLEKI28kZU5lm6PL/C9fSTnIhsGuNvt9c+nsAR7LYUGmUOt0m1t8WnhXny6
        /gL8+3hrg3NbDijiSmztoUEzENKXaxhO/F/7M+zgh4i7e51x4V7G53dgRW7qsSF91Sj+4dGKCXiWZ
        MgypbL7Dz0Fgms3laHpwK4wCk13rQHseo/6VYw2dbuGNshjlyw1mDcH4iHHmyV40rt/bB8K5007ha
        AURiAvkw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qJnQA-00HMro-Mn; Thu, 13 Jul 2023 03:55:14 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        David Sterba <dsterba@suse.com>, linux-fsdevel@vger.kernel.org,
        Pankaj Raghav <p.raghav@samsung.com>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        ntfs3@lists.linux.dev, "Theodore Tso" <tytso@mit.edu>,
        Jan Kara <jack@suse.com>, linux-ext4@vger.kernel.org
Subject: [PATCH 6/7] jbd2: Use a folio in jbd2_journal_write_metadata_buffer()
Date:   Thu, 13 Jul 2023 04:55:11 +0100
Message-Id: <20230713035512.4139457-7-willy@infradead.org>
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

The primary goal here is removing the use of set_bh_page().
Take the opportunity to switch from kmap_atomic() to kmap_local().
This simplifies the function as the offset is already added to
the pointer.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/jbd2/journal.c | 35 ++++++++++++++++-------------------
 1 file changed, 16 insertions(+), 19 deletions(-)

diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index fbce16fedaa4..1b5a45ab62b0 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -341,7 +341,7 @@ int jbd2_journal_write_metadata_buffer(transaction_t *transaction,
 	int do_escape = 0;
 	char *mapped_data;
 	struct buffer_head *new_bh;
-	struct page *new_page;
+	struct folio *new_folio;
 	unsigned int new_offset;
 	struct buffer_head *bh_in = jh2bh(jh_in);
 	journal_t *journal = transaction->t_journal;
@@ -370,14 +370,14 @@ int jbd2_journal_write_metadata_buffer(transaction_t *transaction,
 	 */
 	if (jh_in->b_frozen_data) {
 		done_copy_out = 1;
-		new_page = virt_to_page(jh_in->b_frozen_data);
-		new_offset = offset_in_page(jh_in->b_frozen_data);
+		new_folio = virt_to_folio(jh_in->b_frozen_data);
+		new_offset = offset_in_folio(new_folio, jh_in->b_frozen_data);
 	} else {
-		new_page = jh2bh(jh_in)->b_page;
-		new_offset = offset_in_page(jh2bh(jh_in)->b_data);
+		new_folio = jh2bh(jh_in)->b_folio;
+		new_offset = offset_in_folio(new_folio, jh2bh(jh_in)->b_data);
 	}
 
-	mapped_data = kmap_atomic(new_page);
+	mapped_data = kmap_local_folio(new_folio, new_offset);
 	/*
 	 * Fire data frozen trigger if data already wasn't frozen.  Do this
 	 * before checking for escaping, as the trigger may modify the magic
@@ -385,18 +385,17 @@ int jbd2_journal_write_metadata_buffer(transaction_t *transaction,
 	 * data in the buffer.
 	 */
 	if (!done_copy_out)
-		jbd2_buffer_frozen_trigger(jh_in, mapped_data + new_offset,
+		jbd2_buffer_frozen_trigger(jh_in, mapped_data,
 					   jh_in->b_triggers);
 
 	/*
 	 * Check for escaping
 	 */
-	if (*((__be32 *)(mapped_data + new_offset)) ==
-				cpu_to_be32(JBD2_MAGIC_NUMBER)) {
+	if (*((__be32 *)mapped_data) == cpu_to_be32(JBD2_MAGIC_NUMBER)) {
 		need_copy_out = 1;
 		do_escape = 1;
 	}
-	kunmap_atomic(mapped_data);
+	kunmap_local(mapped_data);
 
 	/*
 	 * Do we need to do a data copy?
@@ -417,12 +416,10 @@ int jbd2_journal_write_metadata_buffer(transaction_t *transaction,
 		}
 
 		jh_in->b_frozen_data = tmp;
-		mapped_data = kmap_atomic(new_page);
-		memcpy(tmp, mapped_data + new_offset, bh_in->b_size);
-		kunmap_atomic(mapped_data);
+		memcpy_from_folio(tmp, new_folio, new_offset, bh_in->b_size);
 
-		new_page = virt_to_page(tmp);
-		new_offset = offset_in_page(tmp);
+		new_folio = virt_to_folio(tmp);
+		new_offset = offset_in_folio(new_folio, tmp);
 		done_copy_out = 1;
 
 		/*
@@ -438,12 +435,12 @@ int jbd2_journal_write_metadata_buffer(transaction_t *transaction,
 	 * copying, we can finally do so.
 	 */
 	if (do_escape) {
-		mapped_data = kmap_atomic(new_page);
-		*((unsigned int *)(mapped_data + new_offset)) = 0;
-		kunmap_atomic(mapped_data);
+		mapped_data = kmap_local_folio(new_folio, new_offset);
+		*((unsigned int *)mapped_data) = 0;
+		kunmap_local(mapped_data);
 	}
 
-	set_bh_page(new_bh, new_page, new_offset);
+	folio_set_bh(new_bh, new_folio, new_offset);
 	new_bh->b_size = bh_in->b_size;
 	new_bh->b_bdev = journal->j_dev;
 	new_bh->b_blocknr = blocknr;
-- 
2.39.2

