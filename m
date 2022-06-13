Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62342547F1E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jun 2022 07:46:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235222AbiFMFiy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Jun 2022 01:38:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236746AbiFMFih (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Jun 2022 01:38:37 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5065C1263C;
        Sun, 12 Jun 2022 22:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=Zp2A2WsdHhKodTSMNz93mFV0bupP5ggkN3XKeFjb+k0=; b=TkFyl6H75fM8c9tKEtfeL1KjsG
        CaJ7Oa0Qby+KbEh93MbSGeNt6+Hb0Lsv4whlxvXNFQru8rZdWgVQPCWbmlNxFDK/doxGYWpgCjkIL
        FLoWBjKj8yg5+LWJwsn1xbEpvaKsIcE/n//P51Nh0sVCcD74niLAOC9BL7tfa+CpEE4KGhniOxYlu
        korHNvCyxqqp1We7PbToGW9NGxeC6/ymAX43zRsxTYdeEX4ESxpkpstlYzG5NSojl0Ndkcmjojn6h
        1yVZl0stpkYwXy3332y+rRPyZmpO8UQu0QDJCe7Ldx6GgbaIjPwdXs3UPLTipev2ydkLedaXeggZl
        ss3HGNUA==;
Received: from [2001:4bb8:180:36f6:f125:c38b:d3d6:ae6c] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o0cla-001V6O-Kt; Mon, 13 Jun 2022 05:37:35 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.com>,
        Dave Kleikamp <shaggy@kernel.org>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, jfs-discussion@lists.sourceforge.net,
        ntfs3@lists.linux.dev
Subject: [PATCH 6/6] fs: remove the NULL get_block case in mpage_writepages
Date:   Mon, 13 Jun 2022 07:37:15 +0200
Message-Id: <20220613053715.2394147-7-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220613053715.2394147-1-hch@lst.de>
References: <20220613053715.2394147-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

No one calls mpage_writepages with a NULL get_block paramter, so remove
support for that case.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/mpage.c | 22 ++++++----------------
 1 file changed, 6 insertions(+), 16 deletions(-)

diff --git a/fs/mpage.c b/fs/mpage.c
index a354ef2b4b4eb..e4cf881634a6a 100644
--- a/fs/mpage.c
+++ b/fs/mpage.c
@@ -636,8 +636,6 @@ static int __mpage_writepage(struct page *page, struct writeback_control *wbc,
  * @mapping: address space structure to write
  * @wbc: subtract the number of written pages from *@wbc->nr_to_write
  * @get_block: the filesystem's block mapper function.
- *             If this is NULL then use a_ops->writepage.  Otherwise, go
- *             direct-to-BIO.
  *
  * This is a library function, which implements the writepages()
  * address_space_operation.
@@ -654,24 +652,16 @@ int
 mpage_writepages(struct address_space *mapping,
 		struct writeback_control *wbc, get_block_t get_block)
 {
+	struct mpage_data mpd = {
+		.get_block	= get_block,
+	};
 	struct blk_plug plug;
 	int ret;
 
 	blk_start_plug(&plug);
-
-	if (!get_block)
-		ret = generic_writepages(mapping, wbc);
-	else {
-		struct mpage_data mpd = {
-			.bio = NULL,
-			.last_block_in_bio = 0,
-			.get_block = get_block,
-		};
-
-		ret = write_cache_pages(mapping, wbc, __mpage_writepage, &mpd);
-		if (mpd.bio)
-			mpage_bio_submit(mpd.bio);
-	}
+	ret = write_cache_pages(mapping, wbc, __mpage_writepage, &mpd);
+	if (mpd.bio)
+		mpage_bio_submit(mpd.bio);
 	blk_finish_plug(&plug);
 	return ret;
 }
-- 
2.30.2

