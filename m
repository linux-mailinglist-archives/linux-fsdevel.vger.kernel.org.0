Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 188BB7120FF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 May 2023 09:33:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242416AbjEZHdo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 May 2023 03:33:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236891AbjEZHdn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 May 2023 03:33:43 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B8B8114;
        Fri, 26 May 2023 00:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=FJ06IRMbDJJrXOTKvODn3h7mdJ3kw+A63u/ZaBgMzfY=; b=TvnkXj/I5pCGoRzwSTLwGngHMk
        E/yOSJcwi8/rld1LFK0la1ONOTYE8kgf0sYeSy7EeAw2M9xM5dchixMhcAFI/dyqAGMeMxn0UGWi1
        Z/L2v0EUnETlmhx6yMZ2Pkv6KIyQ8DKIRJ9Z3+q5vWbT43/UJgv8w1w9fmLU9F4PjN8odpQtJNiIB
        V0/+D3Bej6fJHhwfmMBkg/16PEO3VhSIPA07vAmIXi2OuTn4BsoPVzH5VuDjE1wyPEPK76ic2KxwQ
        ifNUkHYRpWB9KO5IxFO4z82u0HHr7NQ518//dHvsxFWjq0yZXCx7CPAKr73uGMcywgLPIN9gHZEHu
        NBTI3fcw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q2RxB-001RdW-0P;
        Fri, 26 May 2023 07:33:37 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     axboe@kernel.dk, agk@redhat.com, snitzer@kernel.org,
        philipp.reisner@linbit.com, lars.ellenberg@linbit.com,
        christoph.boehmwalder@linbit.com, hch@infradead.org,
        djwong@kernel.org, minchan@kernel.org, senozhatsky@chromium.org
Cc:     patches@lists.linux.dev, linux-block@vger.kernel.org,
        linux-mm@kvack.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, dm-devel@redhat.com,
        drbd-dev@lists.linbit.com, linux-kernel@vger.kernel.org,
        willy@infradead.org, hare@suse.de, p.raghav@samsung.com,
        da.gomez@samsung.com, rohan.puri@samsung.com,
        rpuri.linux@gmail.com, kbusch@kernel.org, mcgrof@kernel.org
Subject: [PATCH v2 3/5] iomap: simplify iomap_init() with PAGE_SECTORS
Date:   Fri, 26 May 2023 00:33:34 -0700
Message-Id: <20230526073336.344543-4-mcgrof@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230526073336.344543-1-mcgrof@kernel.org>
References: <20230526073336.344543-1-mcgrof@kernel.org>
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

Replace common constants with generic versions. This produces no
functional changes.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 fs/iomap/buffered-io.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 915b448b8554..5641e696fb3f 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1831,7 +1831,7 @@ EXPORT_SYMBOL_GPL(iomap_writepages);
 
 static int __init iomap_init(void)
 {
-	return bioset_init(&iomap_ioend_bioset, 4 * (PAGE_SIZE / SECTOR_SIZE),
+	return bioset_init(&iomap_ioend_bioset, 4 * PAGE_SECTORS,
 			   offsetof(struct iomap_ioend, io_inline_bio),
 			   BIOSET_NEED_BVECS);
 }
-- 
2.39.2

