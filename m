Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 748D15AA224
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Sep 2022 00:10:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235126AbiIAWGU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Sep 2022 18:06:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234915AbiIAWE3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Sep 2022 18:04:29 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C60919CCDC;
        Thu,  1 Sep 2022 15:03:07 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id r69so351830pgr.2;
        Thu, 01 Sep 2022 15:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=cO8ljolH2h2y0oWNA4Z7VoneqopIkQJQEMsP9EWX9UE=;
        b=kKpyoHXEn14IP8WZWJwoknMWz/3cEOj2DtppI4cG+XUgdh8Tj1+NKWa1adqBtYfRyk
         VHPG5rdhWAQ4al3AZaUyV4gt0By/gJ2McMkw6RSp3WXMbGoQm4Z42P2OF7rEI5+v8UFy
         T83xOcnBL+8y53/G5LsCfiBNZVkJ59jiyGCBVGzvkjfyRBt3dlDX+e3T3Jb65ECCpxvk
         de50C1kCfFbev8CHBRr9SMR2MV04+yZrNWPkJ78ejHguj8T8ZvuRGaGrPi165Wp2Alcd
         WVUEC3AobWtJj3jqC/3Bd7A785/43KHGySAeLICCAztfaQ+xJ9RiweF5yex+rajvvdOC
         /ydw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=cO8ljolH2h2y0oWNA4Z7VoneqopIkQJQEMsP9EWX9UE=;
        b=oNuI8RdnjYz0XsJ/JM3WFfUfe3XnogfrQwrC7D+hxnovb6sFL37EiJ/Kbxdhzfpgt4
         1qNCxCB8HzytaX56S6B8HhjrFCqgodFxncqN5PxGlrAMFmdmrNAuJ7VBY4K3y68NFyCn
         Ednpx0A7zGMat1pUW3lJieXWwhHnPAD/SoXxhrWHJrNMUfhL9xdHL8lKqWWOKrLDryWD
         mFsu6beNAHbWgK0TojvIjyg9IhcQIH2GaqvKDaawx481VUsJFJYgitVe9UvvzqgUwkiD
         po9JylbtBpR6DGdDHwBRS2NHA/+ZI1pp87sLK8hJ+BBu1Ne/JRWZb92DTakvH4gnF77s
         TSbA==
X-Gm-Message-State: ACgBeo0T0xgOdzYquUjlsQhZowhpPxpi0iqrK/r7wBBC7bDDqD6gahs+
        0Qrwaq8yj/kyBy/3ELCNM6ORJBXcKuOvKw==
X-Google-Smtp-Source: AA6agR5hXhjZN5uBNUEvEE06143lBtKSeWoPuJQC/ApxWtxLERe0a7EzkbibHXQL+mnSnNH8xT9rzg==
X-Received: by 2002:a62:1c81:0:b0:52f:ccb5:9de1 with SMTP id c123-20020a621c81000000b0052fccb59de1mr33199922pfc.45.1662069776277;
        Thu, 01 Sep 2022 15:02:56 -0700 (PDT)
Received: from vmfolio.. (c-73-189-111-8.hsd1.ca.comcast.net. [73.189.111.8])
        by smtp.googlemail.com with ESMTPSA id fv4-20020a17090b0e8400b001fb350026f1sm128894pjb.4.2022.09.01.15.02.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 15:02:55 -0700 (PDT)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-cifs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-nilfs@vger.kernel.org, linux-mm@kvack.org,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH 15/23] f2fs: Convert last_fsync_dnode() to use filemap_get_folios_tag()
Date:   Thu,  1 Sep 2022 15:01:30 -0700
Message-Id: <20220901220138.182896-16-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220901220138.182896-1-vishal.moola@gmail.com>
References: <20220901220138.182896-1-vishal.moola@gmail.com>
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

Convert to use folios. This is in preparation for the removal of
find_get_pages_range_tag().

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 fs/f2fs/node.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index cf8665f04c0d..b993be76013e 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1513,23 +1513,24 @@ static void flush_inline_data(struct f2fs_sb_info *sbi, nid_t ino)
 static struct page *last_fsync_dnode(struct f2fs_sb_info *sbi, nid_t ino)
 {
 	pgoff_t index;
-	struct pagevec pvec;
+	struct folio_batch fbatch;
 	struct page *last_page = NULL;
-	int nr_pages;
+	int nr_folios;
 
-	pagevec_init(&pvec);
+	folio_batch_init(&fbatch);
 	index = 0;
 
-	while ((nr_pages = pagevec_lookup_tag(&pvec, NODE_MAPPING(sbi), &index,
-				PAGECACHE_TAG_DIRTY))) {
+	while ((nr_folios = filemap_get_folios_tag(NODE_MAPPING(sbi), &index,
+					(pgoff_t)-1, PAGECACHE_TAG_DIRTY,
+					&fbatch))) {
 		int i;
 
-		for (i = 0; i < nr_pages; i++) {
-			struct page *page = pvec.pages[i];
+		for (i = 0; i < nr_folios; i++) {
+			struct page *page = &fbatch.folios[i]->page;
 
 			if (unlikely(f2fs_cp_error(sbi))) {
 				f2fs_put_page(last_page, 0);
-				pagevec_release(&pvec);
+				folio_batch_release(&fbatch);
 				return ERR_PTR(-EIO);
 			}
 
@@ -1560,7 +1561,7 @@ static struct page *last_fsync_dnode(struct f2fs_sb_info *sbi, nid_t ino)
 			last_page = page;
 			unlock_page(page);
 		}
-		pagevec_release(&pvec);
+		folio_batch_release(&fbatch);
 		cond_resched();
 	}
 	return last_page;
-- 
2.36.1

