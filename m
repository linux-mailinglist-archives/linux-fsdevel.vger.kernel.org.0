Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4F5B56D3A7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Jul 2022 06:15:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbiGKEPQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Jul 2022 00:15:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiGKEPO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Jul 2022 00:15:14 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C53317E1A;
        Sun, 10 Jul 2022 21:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=UpNRgrzdjhANfksOn4XBOf9M3wcJerHjfMYMEA5ytpg=; b=oSggFQvQiu2Q/Z4+RDMuKHoaq1
        NQSmsCJ4CDSVjb8qVFpmstPY3cliAV4YKv26+FTqAl725WUsiFW5OHJbZV5OCLsXOF0h/xicxpCJ6
        GP4BN75XbHX4eRnc9jTwHnL2MEHlMZsBjtU9IdS4QDzH4nw7d53DIpADrUKe+Tn1174dSv34nlzbC
        0tYZSuEkDzudQhHp611i2h6dZxPSi2wMFjrxbLFC8jORfL0RrbX58xFXHJJgb8sUcWj9+8DDkKxjA
        MM6zScWgrkBeb6ebKNwpsFlfQ4qp9SQnwavg2GzDKT9EYcNGsZ75XL3On/5Hgj8yEStz6qrQJ44aA
        t1uO9t5A==;
Received: from 089144197153.atnat0006.highway.a1.net ([89.144.197.153] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oAkp7-00FpwQ-9D; Mon, 11 Jul 2022 04:15:05 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>
Cc:     Johannes Thumshirn <jth@kernel.org>, cluster-devel@redhat.com,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 1/4] gfs2: stop using generic_writepages in gfs2_ail1_start_one
Date:   Mon, 11 Jul 2022 06:14:56 +0200
Message-Id: <20220711041459.1062583-2-hch@lst.de>
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

Use filemap_fdatawrite_wbc instead of generic_writepages in
gfs2_ail1_start_one so that the functin can also cope with address_space
operations that only implement ->writepages and to properly account
for cgroup writeback.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/gfs2/log.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/gfs2/log.c b/fs/gfs2/log.c
index f0ee3ff6f9a87..624dffc96136b 100644
--- a/fs/gfs2/log.c
+++ b/fs/gfs2/log.c
@@ -131,7 +131,7 @@ __acquires(&sdp->sd_ail_lock)
 		if (!mapping)
 			continue;
 		spin_unlock(&sdp->sd_ail_lock);
-		ret = generic_writepages(mapping, wbc);
+		ret = filemap_fdatawrite_wbc(mapping, wbc);
 		if (need_resched()) {
 			blk_finish_plug(plug);
 			cond_resched();
-- 
2.30.2

