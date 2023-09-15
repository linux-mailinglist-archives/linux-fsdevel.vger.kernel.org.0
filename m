Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CCDA7A264B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Sep 2023 20:43:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236871AbjIOSmg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Sep 2023 14:42:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237022AbjIOSm1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Sep 2023 14:42:27 -0400
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99CB63A84;
        Fri, 15 Sep 2023 11:40:57 -0700 (PDT)
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4RnNJS3W0Xz9sbL;
        Fri, 15 Sep 2023 20:39:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
        s=MBO0001; t=1694803160;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SzrHPPmJTKjWfDrn3YXBgU9n1TNPo/kiGOZujmxfC3o=;
        b=zv1eBTD7DSyKB/ZHl4zr3fiwfusUpLKbzkWEafjVoKUx2xfMK7rklsQPPIp19HKeoo3l8c
        FWeg/koAWMOCS5X6e/FiZsa8S/OteBDH7E1VOVQjIAhxRZxG2855TiW8pZ388XhUkviYq2
        bUYv3/X5vM3Wi4vWfiFfR93e4/3fPoNylQkICflCDoirfo2ziNslgUpmYPd0h1VRhy/zgi
        U9QpS/GtWY71h/CXkrwsXNlNbS9TdIZ8rep7TVuhIWNrq3bhlA9o+chV8bjGafiMcWHOQs
        lIMWb0XukJXAYtVaua7Mngo8ueNlG8zrZT38tUYnIZNdtKRF4sPJFkbVEB/wNA==
From:   Pankaj Raghav <kernel@pankajraghav.com>
To:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     p.raghav@samsung.com, david@fromorbit.com, da.gomez@samsung.com,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        willy@infradead.org, djwong@kernel.org, linux-mm@kvack.org,
        chandan.babu@oracle.com, mcgrof@kernel.org, gost.dev@samsung.com
Subject: [RFC 10/23] filemap: align the index to mapping_min_order in filemap_get_pages()
Date:   Fri, 15 Sep 2023 20:38:35 +0200
Message-Id: <20230915183848.1018717-11-kernel@pankajraghav.com>
In-Reply-To: <20230915183848.1018717-1-kernel@pankajraghav.com>
References: <20230915183848.1018717-1-kernel@pankajraghav.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Luis Chamberlain <mcgrof@kernel.org>

Align the index to the mapping_min_order number of pages in
filemap_get_pages().

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
generic/451 triggers a crash in this path for bs = 16k.

 mm/filemap.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index e4d46f79e95d..8a4bbddcf575 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2558,14 +2558,17 @@ static int filemap_get_pages(struct kiocb *iocb, size_t count,
 {
 	struct file *filp = iocb->ki_filp;
 	struct address_space *mapping = filp->f_mapping;
+	unsigned int min_order = mapping_min_folio_order(mapping);
+	unsigned int nrpages = 1UL << min_order;
 	struct file_ra_state *ra = &filp->f_ra;
-	pgoff_t index = iocb->ki_pos >> PAGE_SHIFT;
+	pgoff_t index = round_down(iocb->ki_pos >> PAGE_SHIFT, nrpages);
 	pgoff_t last_index;
 	struct folio *folio;
 	int err = 0;
 
 	/* "last_index" is the index of the page beyond the end of the read */
 	last_index = DIV_ROUND_UP(iocb->ki_pos + count, PAGE_SIZE);
+	last_index = round_up(last_index, nrpages);
 retry:
 	if (fatal_signal_pending(current))
 		return -EINTR;
@@ -2581,8 +2584,7 @@ static int filemap_get_pages(struct kiocb *iocb, size_t count,
 	if (!folio_batch_count(fbatch)) {
 		if (iocb->ki_flags & (IOCB_NOWAIT | IOCB_WAITQ))
 			return -EAGAIN;
-		err = filemap_create_folio(filp, mapping,
-				iocb->ki_pos >> PAGE_SHIFT, fbatch);
+		err = filemap_create_folio(filp, mapping, index, fbatch);
 		if (err == AOP_TRUNCATED_PAGE)
 			goto retry;
 		return err;
-- 
2.40.1

