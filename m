Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67E8272141B
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Jun 2023 04:22:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbjFDCWq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 3 Jun 2023 22:22:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjFDCWq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 3 Jun 2023 22:22:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9EBEF2
        for <linux-fsdevel@vger.kernel.org>; Sat,  3 Jun 2023 19:22:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7D87D6101C
        for <linux-fsdevel@vger.kernel.org>; Sun,  4 Jun 2023 02:22:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD8D8C433A0;
        Sun,  4 Jun 2023 02:22:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685845363;
        bh=ZiSBZDkLcKmw75eFzau26ap+7KM3r4RIljqcwt+8ZvY=;
        h=From:To:Cc:Subject:Date:From;
        b=WRMY03XlxPjWUjdhXzJe2L6CZvyDwiObAFDahpwHj2lGjHxH3B8zijeRmfsm9niab
         xVgOIdzovx8paCIkpWKtdUHeC0m3tE0CJpzICgY12Ve5PIXWyxtmOX/82YBHlFbi8N
         zg79k5z8MV0y9kS+eQHFqbk67Dy+Wfoe2/3A9Rx+afjOqjn9OrqWquDIC0rPOx926x
         HL7n1Msa/HWhVkA8yA8gNeLI4CgNzxqINrFoC41/J2Yu3+2ngn/DOoXsTjQDaFgb/1
         om+p8eAh3rAlyH+mOp0971rqaJfOVa8vL25Dr8a4fFaveTNBk4FKIzRJiHzcaW4BkN
         bqBx8dJzkaBfA==
From:   Eric Biggers <ebiggers@kernel.org>
To:     fsverity@lists.linux.dev
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH] fsverity: don't use bio_first_page_all() in fsverity_verify_bio()
Date:   Sat,  3 Jun 2023 19:21:01 -0700
Message-ID: <20230604022101.48342-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

bio_first_page_all(bio)->mapping->host is not compatible with large
folios, since the first page of the bio is not necessarily the head page
of the folio, and therefore it might not have the mapping pointer set.

Therefore, move the dereference of ->mapping->host into
verify_data_blocks(), which works with a folio.

(Like the commit that this Fixes, this hasn't actually been tested with
large folios yet, since the filesystems that use fs/verity/ don't
support that yet.  But based on code review, I think this is needed.)

Fixes: 5d0f0e57ed90 ("fsverity: support verifying data from large folios")
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/verity/verify.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/verity/verify.c b/fs/verity/verify.c
index 702500ef1f348..0b54f94d763e6 100644
--- a/fs/verity/verify.c
+++ b/fs/verity/verify.c
@@ -256,9 +256,10 @@ verify_data_block(struct inode *inode, struct fsverity_info *vi,
 }
 
 static bool
-verify_data_blocks(struct inode *inode, struct folio *data_folio,
-		   size_t len, size_t offset, unsigned long max_ra_pages)
+verify_data_blocks(struct folio *data_folio, size_t len, size_t offset,
+		   unsigned long max_ra_pages)
 {
+	struct inode *inode = data_folio->mapping->host;
 	struct fsverity_info *vi = inode->i_verity_info;
 	const unsigned int block_size = vi->tree_params.block_size;
 	u64 pos = (u64)data_folio->index << PAGE_SHIFT;
@@ -298,7 +299,7 @@ verify_data_blocks(struct inode *inode, struct folio *data_folio,
  */
 bool fsverity_verify_blocks(struct folio *folio, size_t len, size_t offset)
 {
-	return verify_data_blocks(folio->mapping->host, folio, len, offset, 0);
+	return verify_data_blocks(folio, len, offset, 0);
 
 }
 EXPORT_SYMBOL_GPL(fsverity_verify_blocks);
@@ -320,7 +321,6 @@ EXPORT_SYMBOL_GPL(fsverity_verify_blocks);
  */
 void fsverity_verify_bio(struct bio *bio)
 {
-	struct inode *inode = bio_first_page_all(bio)->mapping->host;
 	struct folio_iter fi;
 	unsigned long max_ra_pages = 0;
 
@@ -338,7 +338,7 @@ void fsverity_verify_bio(struct bio *bio)
 	}
 
 	bio_for_each_folio_all(fi, bio) {
-		if (!verify_data_blocks(inode, fi.folio, fi.length, fi.offset,
+		if (!verify_data_blocks(fi.folio, fi.length, fi.offset,
 					max_ra_pages)) {
 			bio->bi_status = BLK_STS_IOERR;
 			break;

base-commit: c61c38330e582e664fdb97bcb9faf9fa0e4ee175
-- 
2.41.0

