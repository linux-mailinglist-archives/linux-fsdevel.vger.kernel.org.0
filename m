Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B8D2229093
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jul 2020 08:27:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730061AbgGVG1D (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Jul 2020 02:27:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729742AbgGVG1B (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Jul 2020 02:27:01 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D883C061794;
        Tue, 21 Jul 2020 23:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=Jdh+Se3a2Jmdkbd57oVwwUzzlSWemowvtj1/EcjXiHo=; b=rjXQWvaS8qHBtniDPxFQ3W77Lf
        53UqC85nCDqwBMS670ZU8cqxhPbGs900+d1eIdmxbZ04GiYESYTfGlNCJgRQPBJuB86FTUwLpkHn3
        wPFSDOUzY5zhrDQMil0gRtDB48U4m1FpG+6tlFelSCd34zlztC8m/YowLfNo1I6/mXYie3MDWq7Wh
        QyvLFIXsIK4EB5pGBoHLx+hnJia9LMlhD6KbRcJ4zSik1o4g3eiVehQ9Bns6aNJzBx4RZvdKoLxB1
        JfOOksSykmuh1FyXqu4n88wDVc3dB5EDt/60gUX099FVBcr9ZkMC7D3y/p66Zj7Tco563xJ/Ht9As
        6JeW5qow==;
Received: from [2001:4bb8:18c:2acc:e75:d48f:65ef:e944] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jy8DM-0004rK-1P; Wed, 22 Jul 2020 06:26:52 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Song Liu <song@kernel.org>, Hans de Goede <hdegoede@redhat.com>,
        Richard Weinberger <richard@nod.at>,
        Minchan Kim <minchan@kernel.org>,
        linux-mtd@lists.infradead.org, dm-devel@redhat.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        drbd-dev@lists.linbit.com, linux-raid@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        cgroups@vger.kernel.org
Subject: [PATCH 11/14] mm: use SWP_SYNCHRONOUS_IO more intelligently
Date:   Wed, 22 Jul 2020 08:25:49 +0200
Message-Id: <20200722062552.212200-12-hch@lst.de>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200722062552.212200-1-hch@lst.de>
References: <20200722062552.212200-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

There is no point in trying to call bdev_read_page if SWP_SYNCHRONOUS_IO
is not set, as the device won't support it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 mm/page_io.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/mm/page_io.c b/mm/page_io.c
index ccda7679008851..442061348dfb26 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -403,15 +403,17 @@ int swap_readpage(struct page *page, bool synchronous)
 		goto out;
 	}
 
-	ret = bdev_read_page(sis->bdev, swap_page_sector(page), page);
-	if (!ret) {
-		if (trylock_page(page)) {
-			swap_slot_free_notify(page);
-			unlock_page(page);
-		}
+	if (sis->flags & SWP_SYNCHRONOUS_IO) {
+		ret = bdev_read_page(sis->bdev, swap_page_sector(page), page);
+		if (ret) {
+			if (trylock_page(page)) {
+				swap_slot_free_notify(page);
+				unlock_page(page);
+			}
 
-		count_vm_event(PSWPIN);
-		goto out;
+			count_vm_event(PSWPIN);
+			goto out;
+		}
 	}
 
 	ret = 0;
-- 
2.27.0

