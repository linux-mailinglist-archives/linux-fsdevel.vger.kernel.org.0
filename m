Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8A0B5AA256
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Sep 2022 00:10:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235002AbiIAWE6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Sep 2022 18:04:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234643AbiIAWEG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Sep 2022 18:04:06 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 774FB97EE7;
        Thu,  1 Sep 2022 15:02:53 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id l5so246890pjy.5;
        Thu, 01 Sep 2022 15:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=VVDEDDCx2d1u9kTxOO3+HYn0Qu0jVDr1kjF69+koZKM=;
        b=b1/QSkbA0KE2xUlFrUXQEVG0tKpol73bVxgD0JU9l+NoBY6qShuSjNB+kmeBlOMRM5
         JTyIWvr9pHHuB5iH3YW16+gbFOwJPd0guEmk3lwDKP1rofaLlcFIYJW7KLMyPaqSsnUL
         3ANonRcxOaEgEr3fjaSMK6EhvpBNrqrC9y5jO3YalIG74gceZr+XlLuEMojU3DQOF2YT
         ZNnm8VG78RQtVu2G6CZxxzpbZ3oGLbUw/rcEMpsLZCHgtIqvQM56vT9Mo84bDHjBrKPR
         idwfoeW+VWrVke2zu158oVXXH2A5l7M+GBuTmwchmOVovptMyXXZZra4FRtAg/MbnMB0
         QMFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=VVDEDDCx2d1u9kTxOO3+HYn0Qu0jVDr1kjF69+koZKM=;
        b=DnPy02wDAb5/Md4QEYT13CDU6OMA0diYFyxo68sp2TjC+CY0wLjOKxvt5gS5/vgQpa
         N/XidK0X4idpqI+Gmjf0pM2O8jaXdhQquN0itp7Nri1NZbeSYwpXdRse8F4LVXE17nju
         pBdsj9DYwQC/4m2u6iCBH0Zy+7Ajt5I6oiV87UFm+afNjCCBNFpW6/1rISgKlgw3l1AU
         1jsVdDD0oCK8bljXa72pxoiQ42sK8dY4MXL8WtsJ814wkYppmXvamSZPYQs1aVhA4F/J
         NZ1gS9UDshb9FL8yIMl/v4EDJFjeZLuVNxv9j01veGH+xhyV7Z0WYVnsHqMBBtOzCXJA
         8Dbw==
X-Gm-Message-State: ACgBeo0otgFNe1+XWOmWvHy4So9sv27MEbAateSYxVnIwmi1udknqH/y
        6Ff9lP3GPDDE/iUvCtXkR55JYI5DcAqJOw==
X-Google-Smtp-Source: AA6agR66Ea/tFozfkhDfcVtnv3hw9p6c/dgn9A3H0n8S4fBp6aMTRwJJz8RoIdyCPNF25qzur+Vgow==
X-Received: by 2002:a17:90a:9309:b0:1fa:d28b:3751 with SMTP id p9-20020a17090a930900b001fad28b3751mr1262365pjo.189.1662069771948;
        Thu, 01 Sep 2022 15:02:51 -0700 (PDT)
Received: from vmfolio.. (c-73-189-111-8.hsd1.ca.comcast.net. [73.189.111.8])
        by smtp.googlemail.com with ESMTPSA id fv4-20020a17090b0e8400b001fb350026f1sm128894pjb.4.2022.09.01.15.02.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 15:02:51 -0700 (PDT)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-cifs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-nilfs@vger.kernel.org, linux-mm@kvack.org,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH 12/23] f2fs: Convert f2fs_flush_inline_data() to use filemap_get_folios_tag()
Date:   Thu,  1 Sep 2022 15:01:27 -0700
Message-Id: <20220901220138.182896-13-vishal.moola@gmail.com>
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

Convert function to use folios. This is in preparation for the removal
of find_get_pages_tag(). Does NOT support large folios.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 fs/f2fs/node.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index a3c5eedfcf64..c2b54c58392a 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1885,17 +1885,18 @@ static bool flush_dirty_inode(struct page *page)
 void f2fs_flush_inline_data(struct f2fs_sb_info *sbi)
 {
 	pgoff_t index = 0;
-	struct pagevec pvec;
-	int nr_pages;
+	struct folio_batch fbatch;
+	int nr_folios;
 
-	pagevec_init(&pvec);
+	folio_batch_init(&fbatch);
 
-	while ((nr_pages = pagevec_lookup_tag(&pvec,
-			NODE_MAPPING(sbi), &index, PAGECACHE_TAG_DIRTY))) {
+	while ((nr_folios = filemap_get_folios_tag(NODE_MAPPING(sbi), &index,
+					(pgoff_t)-1, PAGECACHE_TAG_DIRTY,
+					&fbatch))) {
 		int i;
 
-		for (i = 0; i < nr_pages; i++) {
-			struct page *page = pvec.pages[i];
+		for (i = 0; i < nr_folios; i++) {
+			struct page *page = &fbatch.folios[i]->page;
 
 			if (!IS_DNODE(page))
 				continue;
@@ -1922,7 +1923,7 @@ void f2fs_flush_inline_data(struct f2fs_sb_info *sbi)
 			}
 			unlock_page(page);
 		}
-		pagevec_release(&pvec);
+		folio_batch_release(&fbatch);
 		cond_resched();
 	}
 }
-- 
2.36.1

