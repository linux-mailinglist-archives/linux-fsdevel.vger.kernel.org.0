Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C88F4436209
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Oct 2021 14:45:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230407AbhJUMrR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Oct 2021 08:47:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230379AbhJUMrQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Oct 2021 08:47:16 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68FA3C06161C
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Oct 2021 05:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=acZg4wkuvbE9IZmYXfy6RNvUK0RdFUpI4ihnDw7DO/4=; b=23/nBcxqvr25HYTCsBEfXIijFk
        ELgOpFDemlWuE6yzeZPeI0cnUS3BlCWJ7gtrwjSBYNFmYaGpGrFHVfx8FMCx4FPSQIToNuyvdbWed
        o9ZDZhZeIIC6vkJqkQbYK55S5jFnixaZIV4qWd/2YKxKWiXtxH3agwhjPr0ksDmwd7RslsfNgE1sr
        KCBIsRHSv7ZyUmupZ1WGDM8aw1gn7tVAwaq6rPCOADkcaBVK40wCuRKELz+/Up/SRLMIRPoDAffjc
        /L+pCNsJ2JohFC1GSFMiQJhGDeTJw5Zjml93VDjKBFmW6BWCnDSUb6KmRWaUvzn6PzXolaDiYR/9d
        9wHc6NvA==;
Received: from [2001:4bb8:180:8777:dd70:8011:36d9:4c23] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mdXRI-007X0C-RZ; Thu, 21 Oct 2021 12:44:57 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>, Jan Kara <jack@suse.cz>,
        linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH 4/5] mm: don't automatically unregister bdis
Date:   Thu, 21 Oct 2021 14:44:40 +0200
Message-Id: <20211021124441.668816-5-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211021124441.668816-1-hch@lst.de>
References: <20211021124441.668816-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

All BDI users now unregister explicitly.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 mm/backing-dev.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/mm/backing-dev.c b/mm/backing-dev.c
index 8a46a0a4b72fa..768e9ae489f66 100644
--- a/mm/backing-dev.c
+++ b/mm/backing-dev.c
@@ -965,8 +965,7 @@ static void release_bdi(struct kref *ref)
 	struct backing_dev_info *bdi =
 			container_of(ref, struct backing_dev_info, refcnt);
 
-	if (test_bit(WB_registered, &bdi->wb.state))
-		bdi_unregister(bdi);
+	WARN_ON_ONCE(test_bit(WB_registered, &bdi->wb.state));
 	WARN_ON_ONCE(bdi->dev);
 	wb_exit(&bdi->wb);
 	kfree(bdi);
-- 
2.30.2

