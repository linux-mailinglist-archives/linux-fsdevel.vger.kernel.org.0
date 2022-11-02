Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5410761677B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Nov 2022 17:11:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231444AbiKBQLg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Nov 2022 12:11:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231272AbiKBQLN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Nov 2022 12:11:13 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68B042CC8A;
        Wed,  2 Nov 2022 09:11:12 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d10so16819373pfh.6;
        Wed, 02 Nov 2022 09:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D7ILOV7uCBW9G56cPuCyE+xwJ/LPVQUTk1i899caTl0=;
        b=WlFYPEeV3wf0VfK6pqbhv5Egc4h8KVjel140fCaMDBK3FcDDdSMrAwC2RRkCV1yrTw
         g5UfIoUTA56HrpjtwUHlbxxIl2+2XVj36Necvjw2qtsGVhSk3MpYNUz5lqUeXoe9rcG+
         rSIhTCQW2xVo9vVWdW8xlqvFvN174oq7e9hBFs8SL0eQTkE9h9BtGOiyq5hrX0X03ARZ
         +PjKQOimzK0w0ph8uxMDYryUYErs4i2YihTAv+8viAcID4R9rEgIXHWoL0tVB1NY/fCF
         Zz7LVoKY7ZVpgl83UNZSArBIZLGwCRqsreKwNZaIOWeZgiKqm4whhefGhGSMZzVBzGt+
         R1hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D7ILOV7uCBW9G56cPuCyE+xwJ/LPVQUTk1i899caTl0=;
        b=buqyy+g7jRAOyFTqOIq4ETWySYeXVTw427m23k0YK4iJoCE/pwR0/jUxv47NgncKoT
         1Lpme2krn43LJwMYTIzx5Z7xqUqY9zp4rCxPtJD263+q4aTMl/7fGRCPNKlPH/o8xEd6
         SKcbgnkXQQms55EYrbyvuHxxIWZv6WuDr4ilYeXQHeg71aMYCtYABF2YigLwCOMXutmZ
         GOon3qAMerfyqBE0k4Y+enNUTMAb7Mcr3wGjtDw2a0ub7rCTDCZETXG3Baie3vHKsEua
         H4Ui6KlZvjT5iQcK2t5yOBi6iODEh6SQ9nfv3LVuOtst4ojEs7Rn6gOpu6N9/if7DlSm
         /hiw==
X-Gm-Message-State: ACrzQf158A733GJDo3ojWlICd3DK5PHZ3dzRorGqjrTR/nhIivLCNEQN
        jTFtIHt6dpIZIcse9/BMUbs3e1bP8nmDfQ==
X-Google-Smtp-Source: AMsMyM5yBalx5fts0VaFDBkG5q5k8ESrx5LXqDS/i9qmdUWGQhi6efEZneqsEsoguUnslwFAGGHvTA==
X-Received: by 2002:a05:6a00:1a10:b0:56d:5266:56aa with SMTP id g16-20020a056a001a1000b0056d526656aamr19077451pfv.61.1667405471611;
        Wed, 02 Nov 2022 09:11:11 -0700 (PDT)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:8002:1c20::8080])
        by smtp.googlemail.com with ESMTPSA id ms4-20020a17090b234400b00210c84b8ae5sm1632101pjb.35.2022.11.02.09.11.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 09:11:11 -0700 (PDT)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-cifs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-nilfs@vger.kernel.org, linux-mm@kvack.org,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
        Matthew Wilcow <willy@infradead.org>
Subject: [PATCH v4 03/23] filemap: Convert __filemap_fdatawait_range() to use filemap_get_folios_tag()
Date:   Wed,  2 Nov 2022 09:10:11 -0700
Message-Id: <20221102161031.5820-4-vishal.moola@gmail.com>
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

Converted function to use folios. This is in preparation for the removal
of find_get_pages_range_tag(). This change removes 2 calls to
compound_head().

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
Reviewed-by: Matthew Wilcow (Oracle) <willy@infradead.org>
---
 mm/filemap.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 9be22672ce1a..cc4be51eae5b 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -503,28 +503,30 @@ static void __filemap_fdatawait_range(struct address_space *mapping,
 {
 	pgoff_t index = start_byte >> PAGE_SHIFT;
 	pgoff_t end = end_byte >> PAGE_SHIFT;
-	struct pagevec pvec;
-	int nr_pages;
+	struct folio_batch fbatch;
+	unsigned nr_folios;
 
 	if (end_byte < start_byte)
 		return;
 
-	pagevec_init(&pvec);
+	folio_batch_init(&fbatch);
+
 	while (index <= end) {
 		unsigned i;
 
-		nr_pages = pagevec_lookup_range_tag(&pvec, mapping, &index,
-				end, PAGECACHE_TAG_WRITEBACK);
-		if (!nr_pages)
+		nr_folios = filemap_get_folios_tag(mapping, &index, end,
+				PAGECACHE_TAG_WRITEBACK, &fbatch);
+
+		if (!nr_folios)
 			break;
 
-		for (i = 0; i < nr_pages; i++) {
-			struct page *page = pvec.pages[i];
+		for (i = 0; i < nr_folios; i++) {
+			struct folio *folio = fbatch.folios[i];
 
-			wait_on_page_writeback(page);
-			ClearPageError(page);
+			folio_wait_writeback(folio);
+			folio_clear_error(folio);
 		}
-		pagevec_release(&pvec);
+		folio_batch_release(&fbatch);
 		cond_resched();
 	}
 }
-- 
2.38.1

