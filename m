Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A67D65DE9A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jan 2023 22:16:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240676AbjADVQL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Jan 2023 16:16:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240361AbjADVP3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Jan 2023 16:15:29 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98C891CFEA;
        Wed,  4 Jan 2023 13:15:28 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id o1-20020a17090a678100b00219cf69e5f0so40240503pjj.2;
        Wed, 04 Jan 2023 13:15:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T3e61Fb9Dqh0rLEzgpxaQ/B901JahzW9QwTImcYRDNk=;
        b=UBQCqBmywL4fUPJmhQf3YO25m2vTpABZ7JRHVBIp9YSGM9aBhK1+4doRUWlbWnsNJ9
         Ri79O/oHwGRqdLDoOxs8sNow2cNgbFMi6rZM99Z8qkiDtf5RaRCZ4Kiu+XAw3ND4YT+u
         uDMmwZa8+WDxJFatrXomU6Jxo2q5TCu5LR8/+XU4bnk9/TKJjWw5uFp/Zql3YXSztlcv
         tPDl0TN6IFTK0eTV0pDEOzPAZKdfzyEuk26yFkDyIUgZjfBa24lNPQ9yT8SpkbUHty0V
         Dwqcs2O9toxSYT9cJLwgyCSs/UOYEjGnysOmE6RW+/9UzSlDVIaa12qs1vX0TjSJY9qH
         c1xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T3e61Fb9Dqh0rLEzgpxaQ/B901JahzW9QwTImcYRDNk=;
        b=iLC4yDHnB5cFpGWGmrjvh//tl1YgK8bRGIyP9qmBL88Wbndu6X9bOfEVrlm/Kw0SIE
         92rxYJCOESEr7zbZ2GtJPSAX2UVkj8qW5o9czor4qav74bCriqN/lRck98ASpSjh5I6i
         6hhJgEyV8+PI8E3ot76p7c40Tk9smpaVCFPyq7v6NqM+dQfsPWJZWk0zt5rUdrA/iffG
         0y8sx6TPl/PKz/yE+vF+HvMFaiQNM4D5HCRWepL1yd6NmKBM+kE0cH7f7Nm3l6ykogAG
         YkGNuGNyVorFJtCQ1/2DeiQy91XP0RlaVzOKvbR/20tkKjKw/KGN+0E92cIMHWZnTWdZ
         L/dw==
X-Gm-Message-State: AFqh2koLtr1VM2oWZCJw8eOLwM51BWPsXPTZ4QSZggDrCVvlCEsNE57f
        1Qf0KG3z5e3bdLKGvhwH+nX+PeggDA8eRA==
X-Google-Smtp-Source: AMrXdXt6Y0kwAGb+h+EXze57cC4InRsKukIyGk3OA1Pq+5Y3FkKS+kdTcpuCqYx01FIOGAuf7ZNWuA==
X-Received: by 2002:a17:90b:92:b0:225:eda7:13e with SMTP id bb18-20020a17090b009200b00225eda7013emr35758753pjb.40.1672866927791;
        Wed, 04 Jan 2023 13:15:27 -0800 (PST)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:8002:1c20::a55d])
        by smtp.googlemail.com with ESMTPSA id i8-20020a17090a138800b00226369149cesm6408pja.21.2023.01.04.13.15.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 13:15:27 -0800 (PST)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-cifs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-nilfs@vger.kernel.org, linux-mm@kvack.org,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>
Subject: [PATCH v5 22/23] nilfs2: Convert nilfs_clear_dirty_pages() to use filemap_get_folios_tag()
Date:   Wed,  4 Jan 2023 13:14:47 -0800
Message-Id: <20230104211448.4804-23-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230104211448.4804-1-vishal.moola@gmail.com>
References: <20230104211448.4804-1-vishal.moola@gmail.com>
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

