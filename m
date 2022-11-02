Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 543726167C0
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Nov 2022 17:14:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231500AbiKBQNJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Nov 2022 12:13:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231470AbiKBQLk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Nov 2022 12:11:40 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E8A12CDE0;
        Wed,  2 Nov 2022 09:11:26 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id h14so16689164pjv.4;
        Wed, 02 Nov 2022 09:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CuuU7Td+QUT919J1WnVrpHag/XTS8dO5J3B4LUD/nEI=;
        b=k4sYgtCTlKF9O5eHoAATqGO6DkAOPOB+/zWzhHb+mqOGd3qF7SgoAaKFi4lLVBsht/
         0a+GahnwrfYgcXzfcqjQMfMejC34Q/m1r6UggkT5/y5BwoQUSM/Inh109I0qpOE7qiZG
         VHSWVTYivN2nm8doYDi4kZvX7E+qWkNiB9Lrdy/A6STUjeM0jj3okY+N0rjKA3OWtndC
         3sSdr2MVpV/CijFouW4jnz6JBqF5pTNSy78wF6PfERj1jNxM0lNUypdxS+HdwVF2Q1pa
         vL090y+jlC31ftR9kmfoc3DT021w95uO172fFY0HeNWUC0D/N2SjsKb0ohMgGDNyRVN7
         /kgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CuuU7Td+QUT919J1WnVrpHag/XTS8dO5J3B4LUD/nEI=;
        b=xmRApXpDGjayygp1QTQkoVCW5Mirxxcsx1G4TBsjpOLa8Ti25mrtO8hFcL6GOzF9Ck
         Vik//oIKqqswe/LavxKoeakpCXejCJtsWxe2l1ZSqiqsfwDA4NTTBn8O7X8QdYfsAKee
         ALbOqQUiT4iacoqNqFHze68d5xaBTfqKsZZ8Kfr/RsYobCHMvvtli53X5Qjt3Te+tLxE
         TaPv3B3TUYmRXb12XlmUO8cLBitz3tk9ayX65UFeAc8sh0io4ZCG0TNlxhjMM/YkJpkP
         O37zk5H7FH2oNQ0sG6JLxMNgfHVJ3hidDWusdmVR6nRQP/KN8kl8zFAsrdtP+WpHNUUO
         J7BA==
X-Gm-Message-State: ACrzQf3OaAkKOZuRyuwZ2Gr7NUaQ00Ms4b66859ji+ilLETflqjvOOEm
        ratp7Q3fglj/Z5JbNER7moqt3Lq5JFW8fA==
X-Google-Smtp-Source: AMsMyM6I93ORgky9kjhOIjyftY7R2MXJmfWgHu6+CPmBQIrkt50BHJL8QLvp13RkJJ928M5oxPKLmA==
X-Received: by 2002:a17:902:aa02:b0:186:9395:4e82 with SMTP id be2-20020a170902aa0200b0018693954e82mr26138278plb.5.1667405485482;
        Wed, 02 Nov 2022 09:11:25 -0700 (PDT)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:8002:1c20::8080])
        by smtp.googlemail.com with ESMTPSA id ms4-20020a17090b234400b00210c84b8ae5sm1632101pjb.35.2022.11.02.09.11.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 09:11:25 -0700 (PDT)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-cifs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-nilfs@vger.kernel.org, linux-mm@kvack.org,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
        Chao Yu <chao@kernel.org>
Subject: [PATCH v4 12/23] f2fs: Convert f2fs_flush_inline_data() to use filemap_get_folios_tag()
Date:   Wed,  2 Nov 2022 09:10:20 -0700
Message-Id: <20221102161031.5820-13-vishal.moola@gmail.com>
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

Convert function to use a folio_batch instead of pagevec. This is in
preparation for the removal of find_get_pages_tag().

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
Acked-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/node.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index e8b72336c096..a2f477cc48c7 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1887,17 +1887,18 @@ static bool flush_dirty_inode(struct page *page)
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
@@ -1924,7 +1925,7 @@ void f2fs_flush_inline_data(struct f2fs_sb_info *sbi)
 			}
 			unlock_page(page);
 		}
-		pagevec_release(&pvec);
+		folio_batch_release(&fbatch);
 		cond_resched();
 	}
 }
-- 
2.38.1

