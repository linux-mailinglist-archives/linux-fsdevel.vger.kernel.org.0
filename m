Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BB3F43620A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Oct 2021 14:45:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230502AbhJUMrS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Oct 2021 08:47:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230379AbhJUMrR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Oct 2021 08:47:17 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0618FC06161C
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Oct 2021 05:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=+8TMfo1y4J7RHdkJjy5rwVtPpxeRVjv8U26oS2pTWBA=; b=pNihMQiG5s/jsP//Uf7A2ys5xR
        nq9YKCa4rZDjhvyCMa/N4qA/vSu/ifCbunLQ/f9+0Fst1rYftsZuD9Xd9oidLgdf7blUHaO87FkIN
        /Zjzc7o5rgs8di3XaUU2suuTi9l1T8y1fZ05d2HCt8rfT/Dp5qbVHD1vZE2fkH9e/+z178+B5ggG0
        ajjj2d1YjVJAzPJm9I/YxzdmjABW+ojALElxav8a76A1v2S0ZndGoSLDo/+VEqE403uJUidjKmf7I
        a3OYiY4F3068CTYCR3RBbsFr7BLomhI6ujfQqIrp62lVjdvXh+NWj4tdZJC4JkfNXEFgIyDdbOBuT
        bsMWbwvg==;
Received: from [2001:4bb8:180:8777:dd70:8011:36d9:4c23] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mdXRD-007WyC-Ga; Thu, 21 Oct 2021 12:44:51 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>, Jan Kara <jack@suse.cz>,
        linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH 2/5] mtd: call bdi_unregister explicitly
Date:   Thu, 21 Oct 2021 14:44:38 +0200
Message-Id: <20211021124441.668816-3-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211021124441.668816-1-hch@lst.de>
References: <20211021124441.668816-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Call bdi_unregister explicitly instead of relying on the automatic
unregistration.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/mtd/mtdcore.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
index c8fd7f758938b..c904e23c82379 100644
--- a/drivers/mtd/mtdcore.c
+++ b/drivers/mtd/mtdcore.c
@@ -2409,6 +2409,7 @@ static void __exit cleanup_mtd(void)
 	if (proc_mtd)
 		remove_proc_entry("mtd", NULL);
 	class_unregister(&mtd_class);
+	bdi_unregister(mtd_bdi);
 	bdi_put(mtd_bdi);
 	idr_destroy(&mtd_idr);
 }
-- 
2.30.2

