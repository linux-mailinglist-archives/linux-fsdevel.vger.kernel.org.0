Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C13B25ADAF2
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Sep 2022 23:46:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232223AbiIEVqH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Sep 2022 17:46:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbiIEVqF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Sep 2022 17:46:05 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3966C647D1;
        Mon,  5 Sep 2022 14:46:04 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id o4so9360365pjp.4;
        Mon, 05 Sep 2022 14:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=ffwlkhbya70pTRv/fpfe5oWt5Mb2pirf/lA8pBTQyDM=;
        b=lY1XwgXxMlS2BTmCTMapK/tq3+fDmhpyu3d2PUY0jjRfkG1Od68Y3dw4T35DDNTTx4
         TVIIKu5wWf41RwMlBzKNotkCUjuYfZCjf5RQyv2kDrplK6ruS+XUx/EZIVm1lxQQg8S5
         tPZ8qwPCWa83o1BqhjBaMQizXvLzcTddng+7Zq+MKjFkgDTd7JYWbSPgMtfAsmYnFz++
         meHOlymzsCRIzJ8Dn7bSpdjBCRZv57nSO0MTOZozNntPRdo2akNSnCNvTuzKnQ36FEcy
         2xajCYUQl5RFbve3ySfxmtNo4An2em5UOrFxPb0jgx/Vd+TMAcxML2L+Hp5XQxegjrAq
         nBqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=ffwlkhbya70pTRv/fpfe5oWt5Mb2pirf/lA8pBTQyDM=;
        b=y1XMHT5ykoiViBfjnG9DvbUeTJprjUWQmNCaitpMWnmdPzEgkXPXBG0Z4cS8z7F2d6
         dBCnHp2Dj7Cp+uBOGMeRd3SBxKnhi9HDEG8aOunU09VdZqayCHLEOjDxU7ssWSOWZAxs
         tegSvxgzwyHwuQHhALxDg/3BlFsF+7weZWMjT1qkxezQPI9chp7GF0IX+K3CqQnnyQNo
         jYSD8FN4xSpg2ckAjWLtO3nhxsEnrpscnPH6v1bt+IThMHPmu0SaUcFRhTSxmryNC9Kd
         ErhzllvQeC6b9yu8TldpDIeMWdt18PGOObP2Q0f329Z4a4MLn2DHG0pVKE9fyPpenhYr
         X5Rg==
X-Gm-Message-State: ACgBeo0irWdgPRNreG/F3DNYu3QAitLGfvw/OFpB7IUAPxUmdThwPj8t
        wDShe3lD9aAIHYEzLd9rrHU=
X-Google-Smtp-Source: AA6agR4MhvcgjsvSNve5IhswU6lghB0tnilpoqrbT4W/5EwR87thdNK4DMdRUqC7TTv0aAOry4XjQw==
X-Received: by 2002:a17:90b:388d:b0:1ff:f17b:244d with SMTP id mu13-20020a17090b388d00b001fff17b244dmr21609542pjb.231.1662414363674;
        Mon, 05 Sep 2022 14:46:03 -0700 (PDT)
Received: from vmfolio.. (c-73-189-111-8.hsd1.ca.comcast.net. [73.189.111.8])
        by smtp.googlemail.com with ESMTPSA id c11-20020a170903234b00b0016ed5266a5csm3906793plh.170.2022.09.05.14.46.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Sep 2022 14:46:03 -0700 (PDT)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        akpm@linux-foundation.org, willy@infradead.org,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH] filemap: Convert filemap_range_has_writeback() to use folios
Date:   Mon,  5 Sep 2022 14:45:57 -0700
Message-Id: <20220905214557.868606-1-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Removes 3 calls to compound_head().

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 mm/filemap.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 15800334147b..a4c71b90491c 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -632,22 +632,23 @@ bool filemap_range_has_writeback(struct address_space *mapping,
 {
 	XA_STATE(xas, &mapping->i_pages, start_byte >> PAGE_SHIFT);
 	pgoff_t max = end_byte >> PAGE_SHIFT;
-	struct page *page;
+	struct folio *folio;
 
 	if (end_byte < start_byte)
 		return false;
 
 	rcu_read_lock();
-	xas_for_each(&xas, page, max) {
-		if (xas_retry(&xas, page))
+	xas_for_each(&xas, folio, max) {
+		if (xas_retry(&xas, folio))
 			continue;
-		if (xa_is_value(page))
+		if (xa_is_value(folio))
 			continue;
-		if (PageDirty(page) || PageLocked(page) || PageWriteback(page))
+		if (folio_test_dirty(folio) || folio_test_locked(folio) ||
+				folio_test_writeback(folio))
 			break;
 	}
 	rcu_read_unlock();
-	return page != NULL;
+	return folio != NULL;
 }
 EXPORT_SYMBOL_GPL(filemap_range_has_writeback);
 
-- 
2.36.1

