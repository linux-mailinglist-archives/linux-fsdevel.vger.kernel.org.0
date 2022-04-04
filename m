Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 761BE4F0E43
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Apr 2022 06:47:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377188AbiDDEsT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Apr 2022 00:48:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346224AbiDDEsJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Apr 2022 00:48:09 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65ADE33885;
        Sun,  3 Apr 2022 21:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=3d6WnvoTZ+PsVqRzozji9/pP+F953nsqfC/6WxafsSE=; b=eMwL0HHrx1kwPC5Ct7a5jq0Grn
        ZaXalrm7Y0Ipk1Wek5GvL7AqbNlA7GoqWOf/KV11h80HIrXstgmX69vMm9xVk5uFQaj0twnisZFAa
        /baeA1irvRUMCRkV7YDUR/cUsv9uMpZvDC8vMGeRwdNdfj8BNBtxv3VcCWrzvgDrfYeNTZKnJdw7U
        fkhVKN9kvzAWw4V4EI2CObpNvS+nLDb41IHakS5Siqe440r34AVi86QnSEkiyCK+k64QZON7wWh3x
        bCmDxnFmo3DuGHUnGZM+g8IbW2jp2ircyYkziJyUEZu9pSLDaI6jmkE2vKGCAanU7U3pTbRDekQii
        ol5zi1iw==;
Received: from 089144211060.atnat0020.highway.a1.net ([89.144.211.60] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nbEbR-00D3lZ-V4; Mon, 04 Apr 2022 04:46:10 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>
Cc:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 12/12] btrfs: stop using the btrfs_bio saved iter in index_rbio_pages
Date:   Mon,  4 Apr 2022 06:45:28 +0200
Message-Id: <20220404044528.71167-13-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220404044528.71167-1-hch@lst.de>
References: <20220404044528.71167-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The bios added to ->bio_list are the original bios fed into
btrfs_map_bio, which are never advanced.  Just use the iter in the
bio itself.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/raid56.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index a0d65f4b2b258..0c96e91e9ee03 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -1155,9 +1155,6 @@ static void index_rbio_pages(struct btrfs_raid_bio *rbio)
 		stripe_offset = start - rbio->bioc->raid_map[0];
 		page_index = stripe_offset >> PAGE_SHIFT;
 
-		if (bio_flagged(bio, BIO_CLONED))
-			bio->bi_iter = btrfs_bio(bio)->iter;
-
 		bio_for_each_segment(bvec, bio, iter) {
 			rbio->bio_pages[page_index + i] = bvec.bv_page;
 			i++;
-- 
2.30.2

