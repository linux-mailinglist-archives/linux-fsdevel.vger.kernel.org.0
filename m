Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 195B061511A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Nov 2022 18:54:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231202AbiKARyG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Nov 2022 13:54:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230314AbiKARx6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Nov 2022 13:53:58 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 819CA1C43D;
        Tue,  1 Nov 2022 10:53:57 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id io19so14255230plb.8;
        Tue, 01 Nov 2022 10:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sd/ZTZPQkq+Y0RGPTAhY/UhYvgYWKV9wt541wP0v/Zs=;
        b=SIGbKrtKugy7nOZmvoxKWK2XYfJQbfbGIzdFN5dvzfDZL8Ani8HTrXJSEa9F4u+AxM
         06FrOunrj2wfzy6hsmYucv8fjbuQhY+ivEWN9s4XkzSo8Fw/pOK90thaglhNy5U03shN
         RhCEpAoCI+YwQ1hxCfu+jwh01kpoiZ6GPZzP5WDlCJnzf7APFvrvSn8WpjglC+98MsYo
         MFE0Almyut+ZmS2LS3VcUnkb8E6ubc7zK3Mpz821N86Fy9YD8VL1yUm9anQfuvtvfkfP
         4JFoMdZGZUCWXoa6IdrHlkw3mQWpRk7i88a5kAJeDpVGx5OQcdSeBPqg0yCEaI1gjDOY
         N9+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sd/ZTZPQkq+Y0RGPTAhY/UhYvgYWKV9wt541wP0v/Zs=;
        b=ldV1Z7IMlu1mc/gqhTiRPpzbtGNXSQ/PJ9+XZg0JQpU3zW1CgJgd85hN3CoFi/O1hQ
         lXVs1AZp5JVrRba+DFvXRA3ReC4EjS0gouz+Y+6k+WqjtcSos7f7zINUDreoS8/A/Gtb
         zwvPEy9SF5PFPoD04xbEhHI05JIXWZt68yZYsNFjakmFbskz7y14WNyinMwcr6+nCLbz
         gZuOMvqS/9wVzMvND8oohIR8lkwMrkiZRtQrQCeOivJgRJFTlyYTPemWJzwL/rJrymBI
         +DkhhidGACSN9vHj3kLEwpRZvHukIDJLKBBeF79jE1GcbqBs5HeZ5ecuS2tN9qYcf9SY
         pecA==
X-Gm-Message-State: ACrzQf0HRqXXAI7e9wp3xmq7OqaUvAD3ZwT6XNaxSvAS9Fs2ETDw+wSX
        IQwXlsytWXOdQ0SP6a4kGSM=
X-Google-Smtp-Source: AMsMyM6JC1O/v8aLCpaRP/DQaK1pXWU0tYXi0PNefL+TH1DnYBlJkFbjclImohZF7Wr316yRxNvZDw==
X-Received: by 2002:a17:902:e352:b0:187:c4c:26ff with SMTP id p18-20020a170902e35200b001870c4c26ffmr17413372plc.162.1667325237185;
        Tue, 01 Nov 2022 10:53:57 -0700 (PDT)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:8002:1c20::8080])
        by smtp.googlemail.com with ESMTPSA id e26-20020a056a0000da00b0056b9124d441sm6797987pfj.218.2022.11.01.10.53.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 10:53:56 -0700 (PDT)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        akpm@linux-foundation.org, willy@infradead.org, miklos@szeredi.hu,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH 4/5] khugepage: Replace lru_cache_add() with folio_add_lru()
Date:   Tue,  1 Nov 2022 10:53:25 -0700
Message-Id: <20221101175326.13265-5-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221101175326.13265-1-vishal.moola@gmail.com>
References: <20221101175326.13265-1-vishal.moola@gmail.com>
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

Replaces some calls with their folio equivalents. This is in preparation
for the removal of lru_cache_add(). This replaces 3 calls to
compound_head() with 1.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 mm/khugepaged.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 4734315f7940..e432d5279043 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1970,6 +1970,7 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
 
 	if (result == SCAN_SUCCEED) {
 		struct page *page, *tmp;
+		struct folio *folio;
 
 		/*
 		 * Replacing old pages with new one has succeeded, now we
@@ -1997,11 +1998,13 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
 			index++;
 		}
 
-		SetPageUptodate(hpage);
-		page_ref_add(hpage, HPAGE_PMD_NR - 1);
+		folio = page_folio(hpage);
+		folio_mark_uptodate(folio);
+		folio_ref_add(folio, HPAGE_PMD_NR - 1);
+
 		if (is_shmem)
-			set_page_dirty(hpage);
-		lru_cache_add(hpage);
+			folio_mark_dirty(folio);
+		folio_add_lru(folio);
 
 		/*
 		 * Remove pte page tables, so we can re-fault the page as huge.
-- 
2.38.1

