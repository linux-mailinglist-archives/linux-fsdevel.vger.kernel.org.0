Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 319F77121A4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 May 2023 09:56:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242397AbjEZH4R (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 May 2023 03:56:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242602AbjEZH4K (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 May 2023 03:56:10 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 063D51A7;
        Fri, 26 May 2023 00:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=1AhvaQEykxRfZlsh2c4Dug9Lp7odXzIMf8TvoDKNOGw=; b=E15C01rvh8qJUhFpengqZNed+/
        epNw4ByYQ60Hpq6UA2LISl8vHwk8zLvgERrEfiFp3oNWfTARAPEe7kg6OrC9oLUNypcBwftohyOnf
        +kL6CMebLub5C8stfDZczdk0CnTJ2fgF/4xjbR58muAKAcLkhsx0UFbRGlIlzEGokmwyiQyPBh2wB
        bKTkZouYgrnXR+ek49+JL+J0BZFyfmAg080+gR8oRXI7sFUtk8hhGst/KBWs76xcaNZWzGmiur9Ci
        XJdyxvsilz8bhnSS0ZbAagO3yezv4DQzoPICC07AQImRF3Kid2X8VB9bGdRAtSfY4kFBchyEre3KY
        lgFf96ig==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q2SIk-001WZy-03;
        Fri, 26 May 2023 07:55:54 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     hughd@google.com, akpm@linux-foundation.org, willy@infradead.org,
        brauner@kernel.org, djwong@kernel.org
Cc:     p.raghav@samsung.com, da.gomez@samsung.com, rohan.puri@samsung.com,
        rpuri.linux@gmail.com, a.manzanares@samsung.com, dave@stgolabs.net,
        yosryahmed@google.com, keescook@chromium.org, hare@suse.de,
        kbusch@kernel.org, mcgrof@kernel.org, patches@lists.linux.dev,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [RFC v2 7/8] shmem: add high order page support
Date:   Fri, 26 May 2023 00:55:51 -0700
Message-Id: <20230526075552.363524-8-mcgrof@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230526075552.363524-1-mcgrof@kernel.org>
References: <20230526075552.363524-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

To support high order block sizes we want to support a high order
folios so to treat the larger block atomically. Add support for this
for tmpfs mounts.

Right now this produces no functional changes since we only allow one
single block size, matching the PAGE_SIZE and so the order is always 0.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 mm/shmem.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index d347a5ba49f1..080864949fe5 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1623,9 +1623,15 @@ static struct folio *shmem_alloc_folio(gfp_t gfp,
 {
 	struct vm_area_struct pvma;
 	struct folio *folio;
+	struct inode *inode = &info->vfs_inode;
+	struct super_block *i_sb = inode->i_sb;
+	int order = 0;
+
+	if (!(i_sb->s_flags & SB_KERNMOUNT))
+		order = i_sb->s_blocksize_bits - PAGE_SHIFT;
 
 	shmem_pseudo_vma_init(&pvma, info, index);
-	folio = vma_alloc_folio(gfp, 0, &pvma, 0, false);
+	folio = vma_alloc_folio(gfp, order, &pvma, 0, false);
 	shmem_pseudo_vma_destroy(&pvma);
 
 	return folio;
-- 
2.39.2

