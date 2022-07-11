Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA5C056D3AB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Jul 2022 06:15:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbiGKEPU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Jul 2022 00:15:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbiGKEPT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Jul 2022 00:15:19 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB63F18B3F;
        Sun, 10 Jul 2022 21:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=73WQtLAfublxnxlmb+ZkF+V6P0Xfh+eOQ9htm4JxrAc=; b=cQwfRLvK8KLMevw7oa8CBlZs/N
        nF4WHCExa93/t4A09tR6i7JU7ez49yjMLlm3AI5qyMOLvU+9dd9maeVyZqtMsIRjXPxYcVNi+rrUm
        Mtu5bS5TMZviK8kjNca4AH3Hi4f7Jsta30coKH2ncBgGPRnX1xqqhVRXvkcM0vzFsTypE8dEaSYem
        KSFedbiCq7tpHkaTcxxSmyBRyXk7WZoPG3l+EVXH487yrfqm3rmgDVeaEOs7K+9xbNoAP9TmQPHsf
        esUxA8OZsTcbNa4klMaIMnxJ3fXrbTNN0x6SxgxZunvAzQ1UbWu/U1urKPpsl92j2yQ0Ihp/BUazx
        38r6vUOg==;
Received: from 089144197153.atnat0006.highway.a1.net ([89.144.197.153] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oAkpC-00Fpwv-RI; Mon, 11 Jul 2022 04:15:11 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>
Cc:     Johannes Thumshirn <jth@kernel.org>, cluster-devel@redhat.com,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 3/4] zonefs: remove ->writepage
Date:   Mon, 11 Jul 2022 06:14:58 +0200
Message-Id: <20220711041459.1062583-4-hch@lst.de>
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

