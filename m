Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E12B85436F5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jun 2022 17:16:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243058AbiFHPPS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Jun 2022 11:15:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243737AbiFHPMW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Jun 2022 11:12:22 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0D12103888;
        Wed,  8 Jun 2022 08:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:To:From:Sender:
        Reply-To:Cc:Content-Type:Content-ID:Content-Description;
        bh=x7JOqfa2RI0AOqNl02SQf1wFVJ5Ok2YV4zXvh/LnRsU=; b=NvquLW9gwRTmhQyGqfAPWAzDSN
        4aTfkhphSIRmLdBhL7Ly2eznMvI5BlkmIvMfX0PAvbTrLMWaPaXQk77zIFeoTaMC2d6/fSgmBeGY5
        NBJsAVSelW5jk+jBVipAcF5jodxqxIdDEOT3vshgvQ9U606vkPaoZCuJ+J4YLRtkKLtyQd+y6D5Pw
        Dq1o2qdpFW1TJRWX/KWryCq2LbW8kO+Ln5kb8GeWSdYzdeoyJiNIPx6IPgeeevsJn+eXJMc0xPDrF
        nhnmtjbYfT/85dPWS/7Lnvv/QPpd1N9vKDRYsB3miIORTclPMJo1oH63rR4HwdtYFC2Ldp7DFxtFZ
        IEyN3EHA==;
Received: from [2001:4bb8:190:726c:66c4:f635:4b37:bdda] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nyxF4-00DtL1-No; Wed, 08 Jun 2022 15:05:07 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.com>,
        Dave Kleikamp <shaggy@kernel.org>, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        jfs-discussion@lists.sourceforge.net
Subject: [PATCH 4/5] fs: don't call ->writepage from __mpage_writepage
Date:   Wed,  8 Jun 2022 17:04:50 +0200
Message-Id: <20220608150451.1432388-5-hch@lst.de>
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

All callers of mpage_writepage use block_write_full_page as their
->writepage implementation, so hard code that.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/mpage.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/mpage.c b/fs/mpage.c
index 31a97a0acf5f5..a354ef2b4b4eb 100644
--- a/fs/mpage.c
+++ b/fs/mpage.c
@@ -624,7 +624,7 @@ static int __mpage_writepage(struct page *page, struct writeback_control *wbc,
 	/*
 	 * The caller has a ref on the inode, so *mapping is stable
 	 */
-	ret = mapping->a_ops->writepage(page, wbc);
+	ret = block_write_full_page(page, mpd->get_block, wbc);
 	mapping_set_error(mapping, ret);
 out:
 	mpd->bio = bio;
-- 
2.30.2

