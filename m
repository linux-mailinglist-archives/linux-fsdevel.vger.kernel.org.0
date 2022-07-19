Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E60D5791B3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Jul 2022 06:13:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236799AbiGSENi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Jul 2022 00:13:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234596AbiGSENd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Jul 2022 00:13:33 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A6AE3AB08;
        Mon, 18 Jul 2022 21:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=H/dq7a+nXxgT66Jn5P876CvJ4GwG7zUeZLf73UoNbbI=; b=Q2AyDGaQA2WDw75T207j9rtVE6
        e4jTmhUEChudtgdHjKiBMFj7MsmwNBKipAP+kjOA+Razm6Cipxm3gsE0txT3Md0ybIrD6Nv/Irpx/
        bKyrGbJheeQOpt6QTBa7zCYXhQasPbRQK7rHhiM+C46qWBPrl9iXfGS3sS7MixMLwMCd2ZSPqJXtS
        0ifddTM+9nTqn3e+KaiBEKRqKJgVJOT67OtkEU22urHipgWRJyHZ4oNSk/A8AvLa5Tevvr7bmD+H0
        1Xb1qhpT/nTNTwKeNJjWjo7V2FvZI6Zl2ygCYzXUEEA3DQx5h7krWs5ToDB3VQdK9kadG/nD8hbSJ
        RrfqC8DA==;
Received: from 089144198117.atnat0007.highway.a1.net ([89.144.198.117] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oDebq-004jTz-J7; Tue, 19 Jul 2022 04:13:23 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>
Cc:     Johannes Thumshirn <jth@kernel.org>, cluster-devel@redhat.com,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 3/4] zonefs: remove ->writepage
Date:   Tue, 19 Jul 2022 06:13:10 +0200
Message-Id: <20220719041311.709250-4-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220719041311.709250-1-hch@lst.de>
References: <20220719041311.709250-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

->writepage is only used for single page writeback from memory reclaim,
and not called at all for cgroup writeback.  Follow the lead of XFS
and remove ->writepage and rely entirely on ->writepages.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Acked-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---
 fs/zonefs/super.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
index 053299758deb9..062c3f1da0327 100644
--- a/fs/zonefs/super.c
+++ b/fs/zonefs/super.c
@@ -232,13 +232,6 @@ static const struct iomap_writeback_ops zonefs_writeback_ops = {
 	.map_blocks		= zonefs_write_map_blocks,
 };
 
-static int zonefs_writepage(struct page *page, struct writeback_control *wbc)
-{
-	struct iomap_writepage_ctx wpc = { };
-
-	return iomap_writepage(page, wbc, &wpc, &zonefs_writeback_ops);
-}
-
 static int zonefs_writepages(struct address_space *mapping,
 			     struct writeback_control *wbc)
 {
@@ -266,7 +259,6 @@ static int zonefs_swap_activate(struct swap_info_struct *sis,
 static const struct address_space_operations zonefs_file_aops = {
 	.read_folio		= zonefs_read_folio,
 	.readahead		= zonefs_readahead,
-	.writepage		= zonefs_writepage,
 	.writepages		= zonefs_writepages,
 	.dirty_folio		= filemap_dirty_folio,
 	.release_folio		= iomap_release_folio,
-- 
2.30.2

