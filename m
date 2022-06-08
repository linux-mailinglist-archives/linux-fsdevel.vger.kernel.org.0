Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69F735436DE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jun 2022 17:14:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243726AbiFHPOF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Jun 2022 11:14:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243736AbiFHPMW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Jun 2022 11:12:22 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35EA153C6D;
        Wed,  8 Jun 2022 08:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:To:From:Sender:
        Reply-To:Cc:Content-Type:Content-ID:Content-Description;
        bh=Zp2A2WsdHhKodTSMNz93mFV0bupP5ggkN3XKeFjb+k0=; b=M3VEhBOzxJlUiCP//pboxh+Xrb
        txStpypjpT6314mFPtaihGuyqKQOMKJ1V0ZzdQuEScNXtXZJDvYfa5u8Jdih0CWPuVaKRPqcqBtBd
        Yy6DIPGnttIBEYTUxelFkme+8q2P9aARzov2wtGuqohwb8+jmGEkpXos4IqKexzl1KdHp6omxtV+Z
        kJGMCGGwF8+IwSfNUAWMPgQXRO7U57IuE5ZxRzTaRywm+33PuknwtQjXr48/06zj8i1RtOWSKPESF
        7a3Rp5uR+3cndEP685MoUKLv2oXet+Bj9cpNWM3IDarrjGUqT+b6Al+nMxGn4u3bC3BvCfonmb/nr
        cBIIDgHQ==;
Received: from [2001:4bb8:190:726c:66c4:f635:4b37:bdda] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nyxF8-00DtMl-0X; Wed, 08 Jun 2022 15:05:10 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.com>,
        Dave Kleikamp <shaggy@kernel.org>, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        jfs-discussion@lists.sourceforge.net
Subject: [PATCH 5/5] fs: remove the NULL get_block case in mpage_writepages
Date:   Wed,  8 Jun 2022 17:04:51 +0200
Message-Id: <20220608150451.1432388-6-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220608150451.1432388-1-hch@lst.de>
References: <20220608150451.1432388-1-hch@lst.de>
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

