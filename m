Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C1DC5AA248
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Sep 2022 00:10:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235072AbiIAWHS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Sep 2022 18:07:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234544AbiIAWGH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Sep 2022 18:06:07 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D940A00ED;
        Thu,  1 Sep 2022 15:03:29 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id jm11so47336plb.13;
        Thu, 01 Sep 2022 15:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=wOJt0d5525/vdydCfZOLqeQx20ust1GIMaCJJ+sLeoU=;
        b=diBwxyvKEf6JI6u957lZlRjBGUqMPUv/DOTu7USfBuUCPzlXtneLcNkT0wHfsvIjgR
         RtFF5KdI3PUaclSG4E8jhu3HF/vGooJNXm0wgBU68eptXErnpIrgJIK7grK3lg2BeI6L
         gnzmKoFOzWTOhjK7j7BejIXQ7JSWJrnbFx0Oc6zaDOnzxuaDir2i3tvuwfF1UzG2jYEP
         Cytu/wxg4A0FNem7xkUQzwOJicEG0m8Lou+wbr97B040g23ggq7N5kdhn0ywWQ13/Za/
         fq1WOxoWKPbol+s7gwJKowNnVI90ccXLoGBZIPqrz2b0PYJIIzBsCuxtrhYjXdSRoOEL
         ZZig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=wOJt0d5525/vdydCfZOLqeQx20ust1GIMaCJJ+sLeoU=;
        b=DsvqGBWVcpB2i1G+wkdNRpXbGJyHJpxygc9EXubPzZszN2SWt//9Vq4FhNXuVNZrLi
         z6pkVLI9v/Gxm262TMmQOdEMzEHUnYkgTBVcaGDss/UfnPxhZOzrR8OQ7ufTttJ1cUB9
         RiuAaovU/A0iUJyhALBynsx6uxo0CxsCH9OWDafTnyOlbAPQsImew41AK0OsSATpONx8
         xqXpnvANLt+nO89IqsBsxQR1Wt6dSI+cyyl3mIpf7+/57wefpTOgQO3MIJ2bculqdmEF
         3qPl35tw8JwPtnB37WMqBdwSmcnDnn4AWoULy5xDb/0IK/J8h5gwQohoOZ5aE+MGAbAF
         SIzw==
X-Gm-Message-State: ACgBeo1Mm+9UFWSE7VBFDhcsI5QNPGRVf7VgAXUQZhqdZUFEYfTqiFvK
        KhMMEvLHXbmwyTvQ+3m85Jl/K72VLRgxCw==
X-Google-Smtp-Source: AA6agR6RjeZe7Y8QnW0cYYPMobD16I7AFu/QpKwQwdSJSAXd1pKggv0iXArcdd34IaNHJIW6grL9/Q==
X-Received: by 2002:a17:902:ea02:b0:16f:11bf:f018 with SMTP id s2-20020a170902ea0200b0016f11bff018mr32101491plg.150.1662069784735;
        Thu, 01 Sep 2022 15:03:04 -0700 (PDT)
Received: from vmfolio.. (c-73-189-111-8.hsd1.ca.comcast.net. [73.189.111.8])
        by smtp.googlemail.com with ESMTPSA id fv4-20020a17090b0e8400b001fb350026f1sm128894pjb.4.2022.09.01.15.03.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 15:03:04 -0700 (PDT)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-cifs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-nilfs@vger.kernel.org, linux-mm@kvack.org,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH 21/23] nilfs2: Convert nilfs_copy_dirty_pages() to use filemap_get_folios_tag()
Date:   Thu,  1 Sep 2022 15:01:36 -0700
Message-Id: <20220901220138.182896-22-vishal.moola@gmail.com>
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

Convert function to use folios throughout. This is in preparation for
the removal of find_get_pages_range_tag().

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 fs/nilfs2/page.c | 39 ++++++++++++++++++++-------------------
 1 file changed, 20 insertions(+), 19 deletions(-)

diff --git a/fs/nilfs2/page.c b/fs/nilfs2/page.c
index 3267e96c256c..5c96084e829f 100644
--- a/fs/nilfs2/page.c
+++ b/fs/nilfs2/page.c
@@ -240,42 +240,43 @@ static void nilfs_copy_page(struct page *dst, struct page *src, int copy_dirty)
 int nilfs_copy_dirty_pages(struct address_space *dmap,
 			   struct address_space *smap)
 {
-	struct pagevec pvec;
+	struct folio_batch fbatch;
 	unsigned int i;
 	pgoff_t index = 0;
 	int err = 0;
 
-	pagevec_init(&pvec);
+	folio_batch_init(&fbatch);
 repeat:
-	if (!pagevec_lookup_tag(&pvec, smap, &index, PAGECACHE_TAG_DIRTY))
+	if (!filemap_get_folios_tag(smap, &index, (pgoff_t)-1,
+				PAGECACHE_TAG_DIRTY, &fbatch))
 		return 0;
 
-	for (i = 0; i < pagevec_count(&pvec); i++) {
-		struct page *page = pvec.pages[i], *dpage;
+	for (i = 0; i < folio_batch_count(&fbatch); i++) {
+		struct folio *folio = fbatch.folios[i], *dfolio;
 
-		lock_page(page);
-		if (unlikely(!PageDirty(page)))
-			NILFS_PAGE_BUG(page, "inconsistent dirty state");
+		folio_lock(folio);
+		if (unlikely(!folio_test_dirty(folio)))
+			NILFS_PAGE_BUG(&folio->page, "inconsistent dirty state");
 
-		dpage = grab_cache_page(dmap, page->index);
-		if (unlikely(!dpage)) {
+		dfolio = filemap_grab_folio(dmap, folio->index);
+		if (unlikely(!dfolio)) {
 			/* No empty page is added to the page cache */
 			err = -ENOMEM;
-			unlock_page(page);
+			folio_unlock(folio);
 			break;
 		}
-		if (unlikely(!page_has_buffers(page)))
-			NILFS_PAGE_BUG(page,
+		if (unlikely(!folio_buffers(folio)))
+			NILFS_PAGE_BUG(&folio->page,
 				       "found empty page in dat page cache");
 
-		nilfs_copy_page(dpage, page, 1);
-		__set_page_dirty_nobuffers(dpage);
+		nilfs_copy_page(&dfolio->page, &folio->page, 1);
+		filemap_dirty_folio(folio_mapping(dfolio), dfolio);
 
-		unlock_page(dpage);
-		put_page(dpage);
-		unlock_page(page);
+		folio_unlock(dfolio);
+		folio_put(dfolio);
+		folio_unlock(folio);
 	}
-	pagevec_release(&pvec);
+	folio_batch_release(&fbatch);
 	cond_resched();
 
 	if (likely(!err))
-- 
2.36.1

