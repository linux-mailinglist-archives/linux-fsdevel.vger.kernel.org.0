Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDA3E56D3A9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Jul 2022 06:15:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbiGKEPT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Jul 2022 00:15:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiGKEPR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Jul 2022 00:15:17 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7810D18B3A;
        Sun, 10 Jul 2022 21:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=+ahx8IwBj1lognBvyanyVPYvmkYJvj3o2T/XC6JDw+Y=; b=RkPmSbJOThdixWcmqh5WqcV+DM
        QZ937ZTJUiABfxThKQ5DgNZx047yLrbncE8Tj4ngUJHQnM3CSu/shmQrgCPy+7Hj5G5dBUuo2qRRW
        N8GMaaPnqecJZsF+zPBO4ETbzp8VcVwU0Pi+GT0VmD9UwCBVgfu4IYFEDgVyGSdvW1bC/apckAOnP
        NTBFEnwN29eBh1nKizbCqCx2+q9k/zKm/lKpf4QCLRPqXnG65gaJNoj5N2ZCx59h7NM2S/TET3aQ1
        SgkyVz61fGRuTPP6bwHx/Jfhf5BtpgoRH+oWjJNHFtpjLtteE215iohAjzGOTwTQ31D1li9N2bYtW
        8Wys0kFg==;
Received: from 089144197153.atnat0006.highway.a1.net ([89.144.197.153] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oAkpA-00Fpwn-1T; Mon, 11 Jul 2022 04:15:08 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>
Cc:     Johannes Thumshirn <jth@kernel.org>, cluster-devel@redhat.com,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 2/4] gfs2: remove ->writepage
Date:   Mon, 11 Jul 2022 06:14:57 +0200
Message-Id: <20220711041459.1062583-3-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220711041459.1062583-1-hch@lst.de>
References: <20220711041459.1062583-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

->writepage is only used for single page writeback from memory reclaim,
and not called at all for cgroup writeback.  Follow the lead of XFS
and remove ->writepage and rely entirely on ->writepages.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/gfs2/aops.c | 26 --------------------------
 1 file changed, 26 deletions(-)

diff --git a/fs/gfs2/aops.c b/fs/gfs2/aops.c
index 106e90a365838..0240a1a717f56 100644
--- a/fs/gfs2/aops.c
+++ b/fs/gfs2/aops.c
@@ -81,31 +81,6 @@ static int gfs2_get_block_noalloc(struct inode *inode, sector_t lblock,
 	return 0;
 }
 
-/**
- * gfs2_writepage - Write page for writeback mappings
- * @page: The page
- * @wbc: The writeback control
- */
-static int gfs2_writepage(struct page *page, struct writeback_control *wbc)
-{
-	struct inode *inode = page->mapping->host;
-	struct gfs2_inode *ip = GFS2_I(inode);
-	struct gfs2_sbd *sdp = GFS2_SB(inode);
-	struct iomap_writepage_ctx wpc = { };
-
-	if (gfs2_assert_withdraw(sdp, gfs2_glock_is_held_excl(ip->i_gl)))
-		goto out;
-	if (current->journal_info)
-		goto redirty;
-	return iomap_writepage(page, wbc, &wpc, &gfs2_writeback_ops);
-
-redirty:
-	redirty_page_for_writepage(wbc, page);
-out:
-	unlock_page(page);
-	return 0;
-}
-
 /**
  * gfs2_write_jdata_page - gfs2 jdata-specific version of block_write_full_page
  * @page: The page to write
@@ -765,7 +740,6 @@ bool gfs2_release_folio(struct folio *folio, gfp_t gfp_mask)
 }
 
 static const struct address_space_operations gfs2_aops = {
-	.writepage = gfs2_writepage,
 	.writepages = gfs2_writepages,
 	.read_folio = gfs2_read_folio,
 	.readahead = gfs2_readahead,
-- 
2.30.2

