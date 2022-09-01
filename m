Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C4595AA21B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Sep 2022 00:10:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234586AbiIAWDI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Sep 2022 18:03:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234379AbiIAWCx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Sep 2022 18:02:53 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F2E27D1F4;
        Thu,  1 Sep 2022 15:02:44 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id u9-20020a17090a1f0900b001fde6477464so3726146pja.4;
        Thu, 01 Sep 2022 15:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=3W8eVECYUWOXPq8AmB0uwIDBTXoxHTg96669VXu7Qys=;
        b=T7nuCbAZMiTAbV5HIjQpWH+eZ9bQTc6PCgtrgl1hET8edirsolRjeqzxxDLlpylo6O
         o4mNGjl/sRdPAL9cyBLo7pPSX2/e8rdulZr4fxc4F/cQ5AhRiqY99FCf8SxmFrrEWzLG
         GwmBlyr64nECHNcSvLGGDgU9jwM9uICGm9ENuaBnbkPPhW9pSHYWvTqQUY01jHfEu8iA
         8qTU4vBK0tC6E/aFkaadbV0SSS1NROThuuOvdZR7ns9gnx2zbMOLC86SVrchIF9MO4NL
         JVoqN7FZ2hPAYogb7KAItYOxx1SfAaxkg+Ce70dXU0IvySIkg7JupZsJgatOwfXFf7eS
         c2hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=3W8eVECYUWOXPq8AmB0uwIDBTXoxHTg96669VXu7Qys=;
        b=vqkAwjamGD/uoNIP5iZ1F6FERjVG1yHXYEk2sE6gb891d0sVRSCuD7haW4kWdh5rx9
         Pdfehk7xlskhzrLg4aoyQyNGmoPdN+99OMTZw2n9S++iO6bCuTkyHkDk2BRw9aLdF4IA
         pwXovZMulEPeTbqamGJ92/fLLUWO7dzeTvU9YLONLeSoXHr+ro/1sCb3MQRM1Hih/i4L
         ffBPLFJS8YaS3sk/zX9GVZU71H3GHQ+8PzBimQ4uLFuxwgYxVjIKKost0tnj31Be3xjH
         XDRfjPRLYitrYx16axFz6qs3Au2j4e+zQ+NzffhFoeR0NIP1kFW/yNZU64Z8bsImweXh
         ujfw==
X-Gm-Message-State: ACgBeo21lwEDs80aoHQy+e+vPByAOU0lRRDCCWfsfRpFGDkaKUKEXvUP
        iNnCEv93G0bVYPVwLJ2FEs7oQIK1dGHdrg==
X-Google-Smtp-Source: AA6agR4+8BUAX2YkjXUvTou/rR9ObQ1uX2z42w4hYTYm88BqrnOHPc03kR7a6JZ8cWUAEetKKB6rvA==
X-Received: by 2002:a17:902:ecd2:b0:16e:d87f:d19e with SMTP id a18-20020a170902ecd200b0016ed87fd19emr32807669plh.75.1662069763246;
        Thu, 01 Sep 2022 15:02:43 -0700 (PDT)
Received: from vmfolio.. (c-73-189-111-8.hsd1.ca.comcast.net. [73.189.111.8])
        by smtp.googlemail.com with ESMTPSA id fv4-20020a17090b0e8400b001fb350026f1sm128894pjb.4.2022.09.01.15.02.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 15:02:42 -0700 (PDT)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-cifs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-nilfs@vger.kernel.org, linux-mm@kvack.org,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH 06/23] btrfs: Convert btree_write_cache_pages() to use filemap_get_folio_tag()
Date:   Thu,  1 Sep 2022 15:01:21 -0700
Message-Id: <20220901220138.182896-7-vishal.moola@gmail.com>
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

Converted function to use folios throughout. This is in preparation for
the removal of find_get_pages_range_tag().

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 fs/btrfs/extent_io.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index cf4f19e80e2f..d1fa072bfdd0 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -4844,14 +4844,14 @@ int btree_write_cache_pages(struct address_space *mapping,
 	int ret = 0;
 	int done = 0;
 	int nr_to_write_done = 0;
-	struct pagevec pvec;
-	int nr_pages;
+	struct folio_batch fbatch;
+	unsigned int nr_folios;
 	pgoff_t index;
 	pgoff_t end;		/* Inclusive */
 	int scanned = 0;
 	xa_mark_t tag;
 
-	pagevec_init(&pvec);
+	folio_batch_init(&fbatch);
 	if (wbc->range_cyclic) {
 		index = mapping->writeback_index; /* Start from prev offset */
 		end = -1;
@@ -4874,14 +4874,15 @@ int btree_write_cache_pages(struct address_space *mapping,
 	if (wbc->sync_mode == WB_SYNC_ALL)
 		tag_pages_for_writeback(mapping, index, end);
 	while (!done && !nr_to_write_done && (index <= end) &&
-	       (nr_pages = pagevec_lookup_range_tag(&pvec, mapping, &index, end,
-			tag))) {
+	       (nr_folios = filemap_get_folios_tag(mapping, &index, end,
+					    tag, &fbatch))) {
 		unsigned i;
 
-		for (i = 0; i < nr_pages; i++) {
-			struct page *page = pvec.pages[i];
+		for (i = 0; i < nr_folios; i++) {
+			struct folio *folio = fbatch.folios[i];
 
-			ret = submit_eb_page(page, wbc, &epd, &eb_context);
+			ret = submit_eb_page(&folio->page, wbc, &epd,
+					&eb_context);
 			if (ret == 0)
 				continue;
 			if (ret < 0) {
@@ -4896,7 +4897,7 @@ int btree_write_cache_pages(struct address_space *mapping,
 			 */
 			nr_to_write_done = wbc->nr_to_write <= 0;
 		}
-		pagevec_release(&pvec);
+		folio_batch_release(&fbatch);
 		cond_resched();
 	}
 	if (!scanned && !done) {
-- 
2.36.1

