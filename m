Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F05E8616802
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Nov 2022 17:14:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231627AbiKBQNY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Nov 2022 12:13:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231631AbiKBQMI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Nov 2022 12:12:08 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8808B2C674;
        Wed,  2 Nov 2022 09:11:40 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id b1-20020a17090a7ac100b00213fde52d49so2314784pjl.3;
        Wed, 02 Nov 2022 09:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T3e61Fb9Dqh0rLEzgpxaQ/B901JahzW9QwTImcYRDNk=;
        b=pqx1PJqOgEaKfUss0nxJak4n84vFKOvzq3ESyrjGFD8v8ROxU3CQGdvwQuKFd1I/w3
         dCJ41EX/Bok9xslgktz6xXZZB5vDFu5BXOoWGO34UzLTcVVzuhGdIGcQHvEi5gNg3GSQ
         gscxO1Gb4psr/vsFsU/1JpKGLnKfg3l6eDymWIA8qk7+XrNzqRLz/vgtPRF4DPnVnb4T
         PW63xls+m/+8H/fBE5siUOyqDVnX5GNrTviD0Y18uYcvd2toxW0MDmiLDFy+p7D7UQQ6
         IBU8URj3sypjIFT2nA8r21p6YwsgewrtbGGcm7sfWsWRu0sZsqZoVeMOaVhnUYxkI+jf
         hvVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T3e61Fb9Dqh0rLEzgpxaQ/B901JahzW9QwTImcYRDNk=;
        b=YmUupG7+40vpkFo5FeZHeZnyBRgb0unk3+IU0m9KM5NHl9y6ROwcmCSUppd0EEDalu
         +W1hmKxby4hrpumwcvQoj4kx0DRgVslNeMWmvCcdj4XK5pG46B4S1cje9EeGX6ewEG3N
         7XdL8KSM1lnk8K+ALUvlFDeBafim3mVmdtHwaIBINvPZ18QH/BEqnRUnj+ZUXigDzieG
         BvSbBGjp/4hrAQCfXRaybXRn2TNF9yyNaTx48fKnbnT4U/kC9HfRmer/4f885HkFaoyP
         fhcq1hUwxbE0I50ikAUP9eWVO66ERYjiFPdrn7xl/WvWeP4A/NwLGCY+C30nPnNy2vQx
         81wg==
X-Gm-Message-State: ACrzQf3k/7kEwfKo9QksgZqWKkqzuFEwwTo23NnDvK6HCfm99WDqtq8L
        /T0Vr61yF909TJX7prGCx/zsU4NRkbfStw==
X-Google-Smtp-Source: AMsMyM4+pj++Af4Edyb2QUG36sMaov5LKSRDOi2tknVjdB5MdIhE6lghLouhN9qeqBdhiOHeQb9nDw==
X-Received: by 2002:a17:90a:9a8f:b0:212:ea8d:dc34 with SMTP id e15-20020a17090a9a8f00b00212ea8ddc34mr45089840pjp.30.1667405500003;
        Wed, 02 Nov 2022 09:11:40 -0700 (PDT)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:8002:1c20::8080])
        by smtp.googlemail.com with ESMTPSA id ms4-20020a17090b234400b00210c84b8ae5sm1632101pjb.35.2022.11.02.09.11.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 09:11:39 -0700 (PDT)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-cifs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-nilfs@vger.kernel.org, linux-mm@kvack.org,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>
Subject: [PATCH v4 22/23] nilfs2: Convert nilfs_clear_dirty_pages() to use filemap_get_folios_tag()
Date:   Wed,  2 Nov 2022 09:10:30 -0700
Message-Id: <20221102161031.5820-23-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221102161031.5820-1-vishal.moola@gmail.com>
References: <20221102161031.5820-1-vishal.moola@gmail.com>
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
the removal of find_get_pages_range_tag(). This change removes 2 calls
to compound_head().

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
2.38.1

