Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A41522590C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jul 2020 09:52:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728006AbgGTHwW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Jul 2020 03:52:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727951AbgGTHwV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Jul 2020 03:52:21 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94642C061794;
        Mon, 20 Jul 2020 00:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=+j5IsWDLKMxe2xsBmliuIyKvW71zFHxDs8w/dpzkLoA=; b=YMIjYvYxlX9QZcNO6KqQW1dhNf
        J+WCe3kNYALq/tyXvMtxhnNvLo11HJ0rvNd8qMenEqttHbXYq48Cq1062tWX/tm/nO0Gh/w0/gvsq
        qgDm5vxaCHJzQ3DVjM43Uu1fvbpJ/S7kl/ffc7MF+R8IZLFO4+2Hz1+LYWmKNgRYxfUyfnH/n7S30
        ENFDTVkcLsqZR8EyVoirLH8UpYTQ66LL6kAqiVT9nde3kkJWogGgSPg+pLbiUueXns72XIVkd8JQu
        sfYRJF6UwTPx+avFx1/ZBgf+/vckozGHVTxHE6vem5rwpVhvegVdfF1NZSiPg1RXFFvsSO7t1pFUr
        SW4NnsMg==;
Received: from [2001:4bb8:105:4a81:5185:88fc:94bb:f8bf] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jxQao-000439-0V; Mon, 20 Jul 2020 07:52:11 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Song Liu <song@kernel.org>, Hans de Goede <hdegoede@redhat.com>,
        Richard Weinberger <richard@nod.at>,
        linux-mtd@lists.infradead.org, dm-devel@redhat.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        drbd-dev@lists.linbit.com, linux-raid@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        cgroups@vger.kernel.org
Subject: [PATCH 11/14] mm: use SWP_SYNCHRONOUS_IO more intelligently
Date:   Mon, 20 Jul 2020 09:51:45 +0200
Message-Id: <20200720075148.172156-12-hch@lst.de>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200720075148.172156-1-hch@lst.de>
References: <20200720075148.172156-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

There is no point in trying to call bdev_read_page if SWP_SYNCHRONOUS_IO
is not set, as the device won't support it.  Also there is no point in
trying a bio submission if bdev_read_page failed.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 mm/page_io.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/mm/page_io.c b/mm/page_io.c
index ccda7679008851..63b44b8221af0f 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -403,8 +403,11 @@ int swap_readpage(struct page *page, bool synchronous)
 		goto out;
 	}
 
-	ret = bdev_read_page(sis->bdev, swap_page_sector(page), page);
-	if (!ret) {
+	if (sis->flags & SWP_SYNCHRONOUS_IO) {
+		ret = bdev_read_page(sis->bdev, swap_page_sector(page), page);
+		if (ret)
+			goto out;
+
 		if (trylock_page(page)) {
 			swap_slot_free_notify(page);
 			unlock_page(page);
-- 
2.27.0

