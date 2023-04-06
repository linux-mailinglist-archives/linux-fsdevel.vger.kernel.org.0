Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7760E6D9371
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Apr 2023 12:00:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236825AbjDFJ7m (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Apr 2023 05:59:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236408AbjDFJ7V (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Apr 2023 05:59:21 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6743E9ED2;
        Thu,  6 Apr 2023 02:58:20 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id he13so2677852wmb.2;
        Thu, 06 Apr 2023 02:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680775098;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ex1nEQ6SQPtfsRcSCBNx1zccngQ8xlE989ZM/J7JAV8=;
        b=SUVvqtgw+8Reap0kc38YG9Xj5gMs5DnRXcEvzLPHcQqHVQRmFoTWex7gIqRil3Uvih
         0nI4iq2JUjU0wQwe2qYm+4YihTfeYQ8vxsopWEatlZtdYot1dABUFUVQ1zZ/nJgFchQc
         PpozKMvS+q1jwypkGMgeLXoNqGcWNRK2WkOGaqDx6ecWRktLYUzokS8eoxvNloUrYH96
         Wn90X9HG/08iZz4eideXBNLFAek4MNS/BIqR9bVU7nvMWn3Hv4R/KsAVBs5fNL2otgn6
         68z/pLK8GVKoBebayGixq3rtMrWDhaRZXdBpO2FMQECoruYlgo5jcTFkQrKL4hoPlMya
         5unA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680775098;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ex1nEQ6SQPtfsRcSCBNx1zccngQ8xlE989ZM/J7JAV8=;
        b=gP+NX+saola7LjDo+nXHwN0JfYshDP1kbY2+CPk1JzO5qidQajFsa7rTgH1vYLMOFY
         kXOos9FVojbzPdFm4uxGwLNueC7cBMQ0ygE0TA1Gnnke2NtA3QA4zNARpNI8i58rVGBC
         zAGdpUNXyVAOaMROz+Z3k1w7ex0rXUyF7IEDQCM1KriSNAdVDBtkkBHd2Z9BzN1lR49H
         xQudrwOkb0T5ESgYmnqsWvtxI17QWPpbz3KlGFMnkNIaxh8Y8rGUpkYRNZp8e6SflsQP
         jAk96RCegH+kgy3dx1urR0EH3RwtHb4YiA7KmDWhaFsFfwQEv7PgVl+Lfy3bTGR0NX/N
         ZxcA==
X-Gm-Message-State: AAQBX9ftjHLXiR1d2rVOIFigbF0+oFCKFwusumuKl+a6+Z3xwrCPwVxF
        paUcyBFAfBg8HmWL9ArVRWVjPfcwJZVZHA==
X-Google-Smtp-Source: AKy350Zux8V6KhIk5EJGtTxXKWqrSUKbPeyWhFoOBzbCBoAQYkRGI3z7v1OKijEF3TqVfycDvCCnBQ==
X-Received: by 2002:a7b:c85a:0:b0:3eb:3998:8c05 with SMTP id c26-20020a7bc85a000000b003eb39988c05mr4046048wml.6.1680775098452;
        Thu, 06 Apr 2023 02:58:18 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id i7-20020a05600c290700b003ee70225ed2sm1123446wmd.15.2023.04.06.02.58.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 02:58:18 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] mm: truncate: remove redundant initialization of new_order
Date:   Thu,  6 Apr 2023 10:58:17 +0100
Message-Id: <20230406095817.703426-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Variable new_order is being initialized with a value that is not read,
the variable is being re-assigned later. Remove the initialization.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 mm/truncate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/truncate.c b/mm/truncate.c
index 817efd5e94b4..d8dd7ee1654d 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -213,7 +213,7 @@ bool truncate_inode_partial_folio(struct folio *folio, loff_t start, loff_t end)
 {
 	loff_t pos = folio_pos(folio);
 	unsigned int offset, length, remaining;
-	unsigned int new_order = folio_order(folio);
+	unsigned int new_order;
 
 	if (pos < start)
 		offset = start - pos;
-- 
2.30.2

