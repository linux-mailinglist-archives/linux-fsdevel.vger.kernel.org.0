Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 387FA5791B0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Jul 2022 06:13:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236807AbiGSENb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Jul 2022 00:13:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236794AbiGSEN3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Jul 2022 00:13:29 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A35E43E764;
        Mon, 18 Jul 2022 21:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=pTqLT0oM/f1OG7Mculu+9k1UykQrvZTnDdQ2yOVLCdw=; b=L3sLySioEDd7yXl7pI7MayQUtS
        pzEVyZSkIicu44pZpCG7qC4x6ps3+s7pHGARwMO1lM45ZjV2x98nAcAWgvdXuehb2wbdrOTpgPAn6
        qMHIqB6KEiofTpI0L0ClWubeWTRp+D+AI+z/iSBtpielNwukc6KO2tfDXa7DKhDjN+c+RDVFtDnGU
        YaUd0kIb811heU/YIc8AOwLLEkJtxdG5qv+WYFsBMZ0MIN6Q2Q0FYc94rL8rdSJ54xe4D8YqMrEqR
        Q3c5W/w5eiNUs9+dRfhfO3SmgsoUp4+n+4A53CNiOPSoyIpk14h7j06r18ECgLmBmxsOuTwgMaEp+
        2qPLzqUg==;
Received: from 089144198117.atnat0007.highway.a1.net ([89.144.198.117] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oDebk-004jSZ-UL; Tue, 19 Jul 2022 04:13:17 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>
Cc:     Johannes Thumshirn <jth@kernel.org>, cluster-devel@redhat.com,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 1/4] gfs2: stop using generic_writepages in gfs2_ail1_start_one
Date:   Tue, 19 Jul 2022 06:13:08 +0200
Message-Id: <20220719041311.709250-2-hch@lst.de>
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

Use filemap_fdatawrite_wbc instead of generic_writepages in
gfs2_ail1_start_one so that the functin can also cope with address_space
operations that only implement ->writepages and to properly account
for cgroup writeback.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/log.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/gfs2/log.c b/fs/gfs2/log.c
index f0ee3ff6f9a87..a66e3b1f6d178 100644
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
@@ -222,8 +222,7 @@ void gfs2_ail1_flush(struct gfs2_sbd *sdp, struct writeback_control *wbc)
 	spin_unlock(&sdp->sd_ail_lock);
 	blk_finish_plug(&plug);
 	if (ret) {
-		gfs2_lm(sdp, "gfs2_ail1_start_one (generic_writepages) "
-			"returned: %d\n", ret);
+		gfs2_lm(sdp, "gfs2_ail1_start_one returned: %d\n", ret);
 		gfs2_withdraw(sdp);
 	}
 	trace_gfs2_ail_flush(sdp, wbc, 0);
-- 
2.30.2

