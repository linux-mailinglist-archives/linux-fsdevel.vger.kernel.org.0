Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C4565B60C1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Sep 2022 20:28:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230361AbiILS2o (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Sep 2022 14:28:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230221AbiILS1y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Sep 2022 14:27:54 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04B471A060;
        Mon, 12 Sep 2022 11:26:02 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id iw17so9422712plb.0;
        Mon, 12 Sep 2022 11:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=cO8ljolH2h2y0oWNA4Z7VoneqopIkQJQEMsP9EWX9UE=;
        b=NIg0pAYlAdDBbGDrxjomYDv80mhD4rG4slnGwjyjvuRzDAtDlmS4Gmg7tdlWc7e8do
         cgAHLwZIeIVAcV79nGjweh7uMALusKrXGqVmplYaBk0bWdwbyIopKrh+iEWfFSIilpNk
         z3YT92SaxzRwTmJNbyX6Xt5mjprGXtb+TsFXBq03Qr+7XwlTr+xiXhHXmcMiwCQCUR7C
         qqG75VplmUXuNQ4XXQR6jrK/n4YJ9YGeOs66l52pj4wjeExkbNP8DGjzL8bl5OJ38U5n
         Eo3ak8KaQKVhvelyH5oZZoriH+Gkfr9ljxLjDG6aoAZRb2H0n7U2YsjVruGe3DaNPvsh
         Tt5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=cO8ljolH2h2y0oWNA4Z7VoneqopIkQJQEMsP9EWX9UE=;
        b=yeEa7X4pNsY+JzFAWk+H1b7azHOIqTLLE6nYe14hGdysXV+nRnb4VslPRDJygMzG+I
         WvTKNKh3khuoNuDKwxEsHKururoh4ZiCeMnH18N6KwuI1OziXQICwNAKs//Ef7uWP2qM
         cpvgYd2zJfY19c+MJXltiuCZ1gu50vUgbHmtAB77fO1Q6Q0jIUPOCfjSq9MM0cTMefS3
         AhLgWmoLRnbyO2bvO3aWhZ2YjVBeu/Q+V2OYBzHfOY8Nh4DHkTzVQz4S7zWbU0bGVfO7
         v39ee7iZUDnnuKgu/iX2DNcgbKOL8ZfJbs0ZgvKnWkWHUT4mucZB2T5LcRSXswZw45kR
         cJ3g==
X-Gm-Message-State: ACgBeo01vpz1+sM5H10x9FQ7kIE9I3ExL2jZET8v6duWdrdChG0KR0op
        J9v9gbojbzD4wysg7EPnzAgqVfGEEBLp5A==
X-Google-Smtp-Source: AA6agR7Jqhi5sUHPJm5uyDhLBrAb4Z/1SypgFHlxXPSRgH2lkqeGp6P1DkFmieOK2bvhQMtnmicpkA==
X-Received: by 2002:a17:902:9f90:b0:178:1a1c:85d with SMTP id g16-20020a1709029f9000b001781a1c085dmr13250833plq.85.1663007146287;
        Mon, 12 Sep 2022 11:25:46 -0700 (PDT)
Received: from vmfolio.. (c-73-189-111-8.hsd1.ca.comcast.net. [73.189.111.8])
        by smtp.googlemail.com with ESMTPSA id x127-20020a626385000000b0053b2681b0e0sm5916894pfb.39.2022.09.12.11.25.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Sep 2022 11:25:45 -0700 (PDT)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-cifs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-nilfs@vger.kernel.org, linux-mm@kvack.org,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH v2 15/23] f2fs: Convert last_fsync_dnode() to use filemap_get_folios_tag()
Date:   Mon, 12 Sep 2022 11:22:16 -0700
Message-Id: <20220912182224.514561-16-vishal.moola@gmail.com>
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

