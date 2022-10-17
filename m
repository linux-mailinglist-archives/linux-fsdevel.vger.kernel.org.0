Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 509F76019DF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Oct 2022 22:29:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231618AbiJQU2Q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Oct 2022 16:28:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231129AbiJQU1C (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Oct 2022 16:27:02 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E4DD7EFD2;
        Mon, 17 Oct 2022 13:25:53 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id n7so11840873plp.1;
        Mon, 17 Oct 2022 13:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vEJiD15A68fC6SKwYs5XNRqfHJAp+vmoTIHZ0Wq7X1E=;
        b=HuFrfcPO7PV53ayIMggGbnfzpHoeRQFhEFVQOHPc6PzciA7uBE16kgNsOTzTc1N9dJ
         2hSJwfj31GhqB57Dr9/JR3txjsKxYKd0DISzk5VV/d3E3Vvva9/OdBLRndwoGjHrDXuK
         3qY8DRPEAXcVMt/sdZ/bgfMCfvzda7cDqa8pI+Md0v4rCay9b1P1aDFJ+wuv/xkwhjDh
         0KtsJUtybAp1KLL3S4A3UmyZmXQ8CTdDX6Bkp+k+AXUIgWAtr3eIZaG4Vz97JDWv8G7t
         DfxB/Jkfg4jPAEaUIknmd3fhww6CnCHqRF/goZ5vhsIyCSXiY5Ug+9SlNiOQCIqmtJWg
         3FVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vEJiD15A68fC6SKwYs5XNRqfHJAp+vmoTIHZ0Wq7X1E=;
        b=mg32RvCntaS7btkW+bSysH7KeHRfc54xrMDT5gBOsEdMyJHGq53x5zZ0nsA++LNI0J
         wfo9pWpT8sjWFdXyQWorIfAIh77nmim4KDJQqJB3lywMfZbEBWDxwsgdcM5Ma5jPu1Cv
         P7c1cZtLtzhXH1YGYpAYN57A+PKi/Fu6npS4PoITuyKB24mEwyozYCWhGUx5az4NPPyY
         rr7jkqfTnVIQwfgn6ou/S2iX6hs28dcCMTOxfWO78WQe91CsjzgwrxdT0UOc82vfFDBS
         lLiBpwIpCzG1b0pdDn56D8m+fzw4njZsP/CDMShVtDQ6JHeP6NbV60Hu2EUw7/eCzmfK
         4BLg==
X-Gm-Message-State: ACrzQf22MdDwDc0EOOsINsSbL5koz6HpRHShv+O1GgNusZ3BCvaah3T9
        GQ1iDn4W8BDKzMDORhqQxVaF56mDUBz/sw==
X-Google-Smtp-Source: AMsMyM7NCPquviHbr1ViT+Zn2xCx1V3w/gqj9EI3FyaFAgvANG2ME7aA/s6o30lzSxwKI6TzBYUiPA==
X-Received: by 2002:a17:90a:e7d0:b0:20c:169f:7503 with SMTP id kb16-20020a17090ae7d000b0020c169f7503mr34763255pjb.175.1666038316564;
        Mon, 17 Oct 2022 13:25:16 -0700 (PDT)
Received: from vmfolio.. (c-76-102-73-225.hsd1.ca.comcast.net. [76.102.73.225])
        by smtp.googlemail.com with ESMTPSA id pj12-20020a17090b4f4c00b00200b12f2bf5sm145037pjb.1.2022.10.17.13.25.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 13:25:16 -0700 (PDT)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-cifs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-nilfs@vger.kernel.org, linux-mm@kvack.org,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>
Subject: [PATCH v3 22/23] nilfs2: Convert nilfs_clear_dirty_pages() to use filemap_get_folios_tag()
Date:   Mon, 17 Oct 2022 13:24:50 -0700
Message-Id: <20221017202451.4951-23-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20221017202451.4951-1-vishal.moola@gmail.com>
References: <20221017202451.4951-1-vishal.moola@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Convert function to use folios throughout. This is in preparation for
the removal of find_get_pages_range_tag().

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
Acked-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
---
 fs/nilfs2/page.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/fs/nilfs2/page.c b/fs/nilfs2/page.c
index d921542a9593..41ccd43cd979 100644
--- a/fs/nilfs2/page.c
+++ b/fs/nilfs2/page.c
@@ -358,22 +358,22 @@ void nilfs_copy_back_pages(struct address_space *dmap,
  */
 void nilfs_clear_dirty_pages(struct address_space *mapping, bool silent)
 {
-	struct pagevec pvec;
+	struct folio_batch fbatch;
 	unsigned int i;
 	pgoff_t index = 0;
 
-	pagevec_init(&pvec);
+	folio_batch_init(&fbatch);
 
-	while (pagevec_lookup_tag(&pvec, mapping, &index,
-					PAGECACHE_TAG_DIRTY)) {
-		for (i = 0; i < pagevec_count(&pvec); i++) {
-			struct page *page = pvec.pages[i];
+	while (filemap_get_folios_tag(mapping, &index, (pgoff_t)-1,
+				PAGECACHE_TAG_DIRTY, &fbatch)) {
+		for (i = 0; i < folio_batch_count(&fbatch); i++) {
+			struct folio *folio = fbatch.folios[i];
 
-			lock_page(page);
-			nilfs_clear_dirty_page(page, silent);
-			unlock_page(page);
+			folio_lock(folio);
+			nilfs_clear_dirty_page(&folio->page, silent);
+			folio_unlock(folio);
 		}
-		pagevec_release(&pvec);
+		folio_batch_release(&fbatch);
 		cond_resched();
 	}
 }
-- 
2.36.1

