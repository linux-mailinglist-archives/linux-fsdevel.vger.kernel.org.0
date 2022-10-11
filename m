Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25C765FBD3C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Oct 2022 23:57:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbiJKV5S (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Oct 2022 17:57:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbiJKV5M (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Oct 2022 17:57:12 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BC0C5A168;
        Tue, 11 Oct 2022 14:57:12 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id x6so14471303pll.11;
        Tue, 11 Oct 2022 14:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yKhqZ9JRxfUHd7ueXHu2hnxQ9xN5WH2xdUaf7T3ps+Y=;
        b=dur9V8U6avr6eGkxSZVUrKpuSoFFEw3r5SOEyHC0jqIiLFPOMXjVnqgh7rsvGgMJG0
         6TfwFx3ajZ6v8lUQK/ljFO4/hzHBOlj0lEA8YLPsPLoLMsoHP29A/dC+cU2vEMpZZocn
         36P7QGWbcTaTFZKWn0aSnczlTD0TSNV8ZzkFmr4X43sv9QQyyDXmpPZ5EMtC9Qkwm0bJ
         6p5HMmqvoYWgDwaOwECANtWpHQh/a7lu3EwtFJamvh0YiuoQTzM3ebX9CCwtknosf6Hw
         nS5vPV+oe/1v7IJcBDTtMF4xkb9c6f78WXQ6ap4LAiIdoOPx68WG3gr853+NSp0KOpEu
         YlKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yKhqZ9JRxfUHd7ueXHu2hnxQ9xN5WH2xdUaf7T3ps+Y=;
        b=RXiDjGGA/L0dqCq5uV+fRMJH3W/s+9eJfm8MxocIoN0g2VPS9ThD8QmfpXaVDiHNsY
         cE//bGTdnZwaC15/OkpnvgJe46KoF9SegJJKUGEogqkfHlO4qWlznpsBmGef2JZHnuaX
         sUWjv9LY8h+WXQUljuddZDK9I989Ecp49t6pGpHr5IlfY6uvs1Hk0kHsBDfrIv3wCIxA
         8Gv3Xk/nzYS7iy6PVfDbD3E66dPJF9SNl1HiTpr+B/SwM/zxKTIcnMHUS7xRZHh2R1qW
         9LZScaRdMlKbe5NcFc+EvfGEn16ipoZ5+UKvl4MguhPdPSA2nGeNkY+dMllhth8S8ZKu
         3Dow==
X-Gm-Message-State: ACrzQf2Ub9Ja/erj070DlvJPQK5QECxIVoiRqLd354bq2eku0G1e0R/w
        2Ja/D9gJVbuMBa9aRIl7RSQ=
X-Google-Smtp-Source: AMsMyM5nSGmPeX92wxZjVokYJ/kQ1ovTA200qlKORsoRtP5J+yxFeMykTyyDynSg41ww8vRb7zIEkw==
X-Received: by 2002:a17:902:e9ca:b0:17f:93b5:5ec8 with SMTP id 10-20020a170902e9ca00b0017f93b55ec8mr26066551plk.59.1665525431654;
        Tue, 11 Oct 2022 14:57:11 -0700 (PDT)
Received: from vmfolio.. (c-76-102-73-225.hsd1.ca.comcast.net. [76.102.73.225])
        by smtp.googlemail.com with ESMTPSA id z17-20020a170903019100b0018123556931sm6580371plg.204.2022.10.11.14.57.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 14:57:11 -0700 (PDT)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     akpm@linux-foundation.org
Cc:     willy@infradead.org, hughd@google.com,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH 3/4] truncate: Remove indices argument from truncate_folio_batch_exceptionals()
Date:   Tue, 11 Oct 2022 14:56:33 -0700
Message-Id: <20221011215634.478330-4-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20221011215634.478330-1-vishal.moola@gmail.com>
References: <20221011215634.478330-1-vishal.moola@gmail.com>
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

The indices array is unnecessary. Folios keep track of their xarray indices
in the folio->index field which can simply be accessed as needed.

This change is in preparation for the removal of the indices arguments of
find_get_entries() and find_lock_entries().

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 mm/truncate.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/mm/truncate.c b/mm/truncate.c
index 846ddbdb27a4..4e63d885498a 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -58,7 +58,7 @@ static void clear_shadow_entry(struct address_space *mapping, pgoff_t index,
  * exceptional entries similar to what folio_batch_remove_exceptionals() does.
  */
 static void truncate_folio_batch_exceptionals(struct address_space *mapping,
-				struct folio_batch *fbatch, pgoff_t *indices)
+				struct folio_batch *fbatch)
 {
 	int i, j;
 	bool dax;
@@ -82,7 +82,6 @@ static void truncate_folio_batch_exceptionals(struct address_space *mapping,
 
 	for (i = j; i < folio_batch_count(fbatch); i++) {
 		struct folio *folio = fbatch->folios[i];
-		pgoff_t index = indices[i];
 
 		if (!xa_is_value(folio)) {
 			fbatch->folios[j++] = folio;
@@ -90,11 +89,11 @@ static void truncate_folio_batch_exceptionals(struct address_space *mapping,
 		}
 
 		if (unlikely(dax)) {
-			dax_delete_mapping_entry(mapping, index);
+			dax_delete_mapping_entry(mapping, folio->index);
 			continue;
 		}
 
-		__clear_shadow_entry(mapping, index, folio);
+		__clear_shadow_entry(mapping, folio->index, folio);
 	}
 
 	if (!dax) {
@@ -363,7 +362,7 @@ void truncate_inode_pages_range(struct address_space *mapping,
 	index = start;
 	while (index < end && find_lock_entries(mapping, &index, end - 1,
 			&fbatch, indices)) {
-		truncate_folio_batch_exceptionals(mapping, &fbatch, indices);
+		truncate_folio_batch_exceptionals(mapping, &fbatch);
 		for (i = 0; i < folio_batch_count(&fbatch); i++)
 			truncate_cleanup_folio(fbatch.folios[i]);
 		delete_from_page_cache_batch(mapping, &fbatch);
@@ -424,7 +423,7 @@ void truncate_inode_pages_range(struct address_space *mapping,
 			truncate_inode_folio(mapping, folio);
 			folio_unlock(folio);
 		}
-		truncate_folio_batch_exceptionals(mapping, &fbatch, indices);
+		truncate_folio_batch_exceptionals(mapping, &fbatch);
 		folio_batch_release(&fbatch);
 	}
 }
-- 
2.36.1

