Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 982CB4E4377
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Mar 2022 16:57:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238816AbiCVP61 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Mar 2022 11:58:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238784AbiCVP6U (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Mar 2022 11:58:20 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FA8B6D87B;
        Tue, 22 Mar 2022 08:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=3d6WnvoTZ+PsVqRzozji9/pP+F953nsqfC/6WxafsSE=; b=KaSF1MmRb/OqhhwQULh48SqrnL
        lrivl6MLZaNBzu9Xg5IJq+1Pv4L2ozqCZuCt+QZLV8jtqKzhGOWRWMvwwFH62xL81M6sQ2YYB1ZUW
        G5wFDIUW9DWYpfF8mI+rlZ0tlp1k9KkjsSWfxrlc7RfSpQSiIuKutK3wdegWAiW5hu1KGXFs5OsdF
        rTUhG6XYnZmiYsqLSzLM3ra+lRfNqLrHI2zT9JIgncEn4Ig8PXmZIqDYlWiNS+/mSklso9lvLtlAn
        XkhKJHZcB42Itr+hjwVAwhGY7UFLvHHe1X1e/NKpcTrIvGe84x9QfQMVr/Ljg3N3IJgPEpRjFZ57+
        SbC1xTyg==;
Received: from [2001:4bb8:19a:b822:6444:5366:9486:4da] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nWgsM-00BamL-4e; Tue, 22 Mar 2022 15:56:50 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>
Cc:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 16/40] btrfs: stop using the btrfs_bio saved iter in index_rbio_pages
Date:   Tue, 22 Mar 2022 16:55:42 +0100
Message-Id: <20220322155606.1267165-17-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220322155606.1267165-1-hch@lst.de>
References: <20220322155606.1267165-1-hch@lst.de>
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

