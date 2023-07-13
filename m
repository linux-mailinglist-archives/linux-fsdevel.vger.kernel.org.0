Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 640357522EA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jul 2023 15:06:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235207AbjGMNGD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Jul 2023 09:06:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235177AbjGMNFd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Jul 2023 09:05:33 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7901F35B6;
        Thu, 13 Jul 2023 06:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=NR1Dsao3xHvpRuOa6WrdSfFOOH1XFxhO6DoGpCB/hxQ=; b=uw1V40UDPYkBQTmHG0WIrooo3q
        +OPM9EiFADzduSwVJMeTSCoZCDOmRvg+LMCiBBAkblgjdS/Q/MsMLVZ+CrLiAMwqb9hGO+HlR0ZjX
        6A1TR/w+pm87fX0fuZ9kXEu4AhJA+RwAWwqycWqOSYxkXz+GrSsdQhfIIYiR0Ymiv+4H7c7CjbCBq
        UysPU3ArFYUrk3wCJ5yHVtd1WJEFQ4HGObCF8YWcO+zY82NWQ+atx3xbnjc+H9Y0odS6oFih1kuzj
        pkSxfX4/kgxmlfv3+zsQporSbBiKpov9BiuDPL5S/JWcMm+nngeDZiYgNUhT6b8iD0pn+vIxvA/u6
        t4Bq2OJw==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qJvzp-003LQh-1s;
        Thu, 13 Jul 2023 13:04:37 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 1/9] btrfs: don't stop integrity writeback too early
Date:   Thu, 13 Jul 2023 15:04:23 +0200
Message-Id: <20230713130431.4798-2-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230713130431.4798-1-hch@lst.de>
References: <20230713130431.4798-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

extent_write_cache_pages stops writing pages as soon as nr_to_write hits
zero.  That is the right thing for opportunistic writeback, but incorrect
for data integrity writeback, which needs to ensure that no dirty pages
are left in the range.  Thus only stop the writeback for WB_SYNC_NONE
if nr_to_write hits 0.

This is a port of write_cache_pages changes in commit 05fe478dd04e
("mm: write_cache_pages integrity fix").

Note that I've only trigger the problem with other changes to the btrfs
writeback code, but this condition seems worthwhile fixing anyway.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/extent_io.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index f2b9c72ea0c104..cb8c5d06fe2304 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2098,7 +2098,8 @@ static int extent_write_cache_pages(struct address_space *mapping,
 			 * We have to make sure to honor the new nr_to_write
 			 * at any time
 			 */
-			nr_to_write_done = wbc->nr_to_write <= 0;
+			nr_to_write_done = wbc->sync_mode == WB_SYNC_NONE &&
+						wbc->nr_to_write <= 0;
 		}
 		folio_batch_release(&fbatch);
 		cond_resched();
-- 
2.39.2

