Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FE515B60DE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Sep 2022 20:30:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230338AbiILS3R (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Sep 2022 14:29:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230493AbiILS2c (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Sep 2022 14:28:32 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B8791AF01;
        Mon, 12 Sep 2022 11:26:11 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d12so9376264plr.6;
        Mon, 12 Sep 2022 11:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=lkGrgC7rGv3gNtROZri1LZJW+W1eletv7YqP1zeCUhw=;
        b=fCy8TLtpc+2sHdfZpYJzZ3/33zUyiKgotMXve7zJnxVipv/nh1oXHb8bS2ysugI/9v
         DPPmXTfFd2REo9KrIQqrSQArNmn2PIXW2Xf5/1Ut4j4N93Wdp+lwmDib+aOUEWzjjW2z
         ZE7UUCvkcyVxvhRcudTBKvbY7PZCczmbSlXfRTufHjK1lQKZiPD4cVbUJ3kgQLIdrvTd
         DEsLz2Pp7SVPdQ+qvHM0m7ftgUr0guyVgV77dhlT4Kf3Rdhp8jR2Z6CWYrkquI7PqWFw
         z1Xy/MN+eXfTN+XVOyRTS9mw9r9QLcv9wmvp2cqbpHgbAYtX/bPNPHQhK3HBKbjjHYbK
         mZ4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=lkGrgC7rGv3gNtROZri1LZJW+W1eletv7YqP1zeCUhw=;
        b=bDk0euRFurrgogLmyvfiMiVJXJZMGPiV70fUXljn6o/6tFieCjph5fyFY46iGUrhr/
         V24uDwBSAbfGUII8y4RC0kEEwV/4A1fBlYsX10WO5LOpAHNlj9P6c+E9FsiZ3vKpqT0D
         +nYiRrhdQrzrUNV4tPn080DmzGLz2FQlbFzwebbMECU1dpfxlnfvXm4tNk/kW/C/I3V6
         6DsVva3O/3K7Y5+RJLeKtq2JjM9YdS+xTlbJcE6nt7f6qDZw2Vb8Rh2Gg54T7QcbKylZ
         iSnfOHpyb33QgikvOnrYm03IyRVSeqGmq2MHQvHT7LhjCtO8+mTUIjq5SAQPQMrGNvnG
         uC7A==
X-Gm-Message-State: ACgBeo0g0MzG5JLNUvjpdqpsis/Fd3o0gPdPWW92vlm2YQFKpnEVN+ZQ
        AVrGfI1quP0BIV0fGNmBmUPGNgFzJabOVA==
X-Google-Smtp-Source: AA6agR7ugObnvvF7oyQiEw4Z3c3fWFD4/N8jwEvlip2DlQU6J5KyEtNgXLRq2aVr22deGLsWpY1Yvg==
X-Received: by 2002:a17:90b:1d8c:b0:202:abf5:4b21 with SMTP id pf12-20020a17090b1d8c00b00202abf54b21mr13212396pjb.162.1663007158527;
        Mon, 12 Sep 2022 11:25:58 -0700 (PDT)
Received: from vmfolio.. (c-73-189-111-8.hsd1.ca.comcast.net. [73.189.111.8])
        by smtp.googlemail.com with ESMTPSA id x127-20020a626385000000b0053b2681b0e0sm5916894pfb.39.2022.09.12.11.25.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Sep 2022 11:25:58 -0700 (PDT)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-cifs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-nilfs@vger.kernel.org, linux-mm@kvack.org,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>
Subject: [PATCH v2 22/23] nilfs2: Convert nilfs_clear_dirty_pages() to use filemap_get_folios_tag()
Date:   Mon, 12 Sep 2022 11:22:23 -0700
Message-Id: <20220912182224.514561-23-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220912182224.514561-1-vishal.moola@gmail.com>
References: <20220912182224.514561-1-vishal.moola@gmail.com>
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

Convert function to use folios throughout. This is in preparation for
the removal of find_get_pages_range_tag().

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
Acked-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
---
 fs/nilfs2/page.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/fs/nilfs2/page.c b/fs/nilfs2/page.c
index 5c96084e829f..b66f4e988016 100644
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

